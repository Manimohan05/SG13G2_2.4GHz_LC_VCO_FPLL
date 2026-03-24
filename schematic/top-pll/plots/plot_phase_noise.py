#!/usr/bin/env python3
"""
Phase Noise from PLL Transient Simulation
==========================================
Computes SSB phase noise L(f) [dBc/Hz] from v(clk_out) in pll_top.raw
using the period-jitter (zero-crossing) method.

Method
------
  1. Load v(clk_out) from the settled region using numpy memmap
     (memory-efficient: only extracts time + clk_out, ~160 MB)
  2. Find rising zero-crossings with sub-step linear interpolation
  3. Period deviation sequence δT_k = T_k − T̄
  4. Welch PSD S_δT(f) of δT_k sampled at the carrier rate f₀
  5. SSB phase noise:  L(f) = f₀⁴ · S_δT(f) / (2 · f²)

Usage
-----
  cd schematic/blocks/top-pll/simulations/
  python3 plot_phase_noise.py
  python3 plot_phase_noise.py /path/to/pll_top.raw
"""

import os, sys, struct
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
from scipy.signal import welch
import scienceplots                          # noqa: F401  (registers styles)

# ── Style (matches VCO tuning curve) ─────────────────────────────────────────
C_LINE  = "#C0143C"   # crimson  – phase noise curve
C_SPEC  = "#F5A623"   # amber    – spec markers

# ── Spec targets (from docs/Targets.md) ──────────────────────────────────────
SPECS = [
    (1e6,  -80, "−100 dBc/Hz @ 1 MHz"),
    (10e6, -135, "−135 dBc/Hz @ 10 MHz"),
]

# ── Settling threshold: skip the first 20 µs ─────────────────────────────────
T_SETTLE = 20e-6


# ---------------------------------------------------------------------------
# 1.  Raw file header parser
# ---------------------------------------------------------------------------

def parse_raw_header(filepath):
    meta, variables = {}, []
    with open(filepath, "rb") as f:
        while True:
            line = f.readline()
            if not line:
                break
            text = line.decode("ascii", errors="replace").strip()
            if text.startswith("No. Variables:"):
                meta["n_vars"]   = int(text.split(":", 1)[1])
            elif text.startswith("No. Points:"):
                meta["n_points"] = int(text.split(":", 1)[1])
            elif text.startswith("Variables:"):
                for _ in range(meta["n_vars"]):
                    vl = f.readline().decode("ascii", errors="replace").strip()
                    p  = vl.split()
                    variables.append({"index": int(p[0]), "name": p[1]})
            elif text.startswith("Binary:"):
                meta["data_offset"] = f.tell()
                break
    meta["variables"] = variables
    return meta


# ---------------------------------------------------------------------------
# 2.  Memory-efficient signal loader (memmap – only reads requested columns)
# ---------------------------------------------------------------------------

def load_two_signals(filepath, sig_name, downsample=1, t_start=None):
    """
    Load time and one signal from a binary ngspice raw file.
    Uses numpy memmap so only the two requested columns (time + signal)
    are pulled into RAM even though the file has 11 variables.

    Returns: t (s), v (V) arrays after downsampling and time slicing.
    """
    meta     = parse_raw_header(filepath)
    n_vars   = meta["n_vars"]
    n_points = meta["n_points"]
    offset   = meta["data_offset"]

    var_idx = next(
        (v["index"] for v in meta["variables"] if v["name"] == sig_name), None
    )
    if var_idx is None:
        raise ValueError(f"Signal '{sig_name}' not in raw file.")

    # Memory-map the binary section (read-only, no copy into RAM)
    mm = np.memmap(filepath, dtype=np.float64, mode="r",
                   offset=offset, shape=(n_points, n_vars))

    # Extract only the two needed columns → small in-memory arrays
    t = np.array(mm[:, 0])
    v = np.array(mm[:, var_idx])
    del mm                            # release the memory map

    # Time slice first (reduces further operations)
    if t_start is not None:
        idx = np.searchsorted(t, t_start)
        t, v = t[idx:], v[idx:]

    # Downsample
    if downsample > 1:
        t, v = t[::downsample], v[::downsample]

    return t, v


# ---------------------------------------------------------------------------
# 3.  Rising zero-crossing detector (sub-step interpolation)
# ---------------------------------------------------------------------------

def find_rising_crossings(t, v, threshold=0.6):
    """
    Return precise crossing times via linear interpolation.
    Only rising edges (v goes from below to above threshold).
    """
    above    = v > threshold
    edge_idx = np.where(np.diff(above.astype(np.int8)) == 1)[0]

    t_cross = np.empty(len(edge_idx))
    for i, k in enumerate(edge_idx):
        dv = v[k + 1] - v[k]
        frac = (threshold - v[k]) / dv if dv != 0.0 else 0.5
        t_cross[i] = t[k] + frac * (t[k + 1] - t[k])

    return t_cross


# ---------------------------------------------------------------------------
# 4.  Phase noise via Welch PSD of period jitter
# ---------------------------------------------------------------------------

def compute_phase_noise(t_cross):
    """
    Period jitter → SSB phase noise.

    Theory:
      δT_k  = T_k − T̄  (period deviation, sampled at f₀ = 1/T̄)
      S_δT(f): Welch PSD of δT_k in units s²/Hz
      L(f)  = f₀⁴ · S_δT(f) / (2 · f²)   [linear, dBc/Hz after log]

    Returns: f_offset (Hz), L_dBc (dBc/Hz), f0 (Hz carrier frequency)
    """
    periods = np.diff(t_cross)              # T_k (s per cycle)
    T0      = np.mean(periods)
    f0      = 1.0 / T0                      # carrier frequency (Hz)
    dT      = periods - T0                  # period deviation δT_k

    # Welch PSD: treat δT_k as a discrete-time sequence at sample rate f₀
    # Use 8 segments; more segments → smoother curve but coarser resolution
    nperseg = max(64, len(dT) // 8)
    f_psd, S_dT = welch(dT, fs=f0, nperseg=nperseg,
                        window="hann", scaling="density",
                        noverlap=nperseg // 2)

    # Drop DC bin
    valid  = f_psd > 0
    f_off  = f_psd[valid]
    S      = S_dT[valid]

    # SSB phase noise conversion
    L_lin  = f0 ** 4 * S / (2.0 * f_off ** 2)
    L_dBc  = 10.0 * np.log10(np.maximum(L_lin, 1e-300))

    return f_off, L_dBc, f0


# ---------------------------------------------------------------------------
# 5.  Plot
# ---------------------------------------------------------------------------

def plot_phase_noise(f_off, L_dBc, f0, f_std, save_path):
    with plt.style.context(["science", "no-latex"]):
        plt.rcParams.update({
            "figure.dpi": 300,
            "axes.grid":  True,
            "grid.alpha": 0.4,
        })

        fig, ax = plt.subplots(figsize=(3.5, 2.5))

        # ── y/x limits from actual data ────────────────────────────────────
        y_lo = min(np.percentile(L_dBc, 5) - 10, -160)
        y_hi = max(np.percentile(L_dBc, 95) + 15, -30)
        y_span = y_hi - y_lo
        ax.set_ylim(y_lo, y_hi)
        ax.set_xlim(f_off.min(), f_off.max())

        # ── Phase noise curve ──────────────────────────────────────────────
        ax.semilogx(f_off, L_dBc, color=C_LINE, linewidth=1.4, zorder=4)

        # ── Spec dashed lines + measured vs spec labels ────────────────────
        # for f_s, L_s, _ in SPECS:
        #     # measured L at this offset
        #     idx   = np.argmin(np.abs(f_off - f_s))
        #     L_meas = L_dBc[idx]

        #     ax.axhline(L_s,  color=C_SPEC, linewidth=0.8,
        #                linestyle="--", zorder=2, alpha=0.9)
        #     ax.axvline(f_s,  color=C_SPEC, linewidth=0.8,
        #                linestyle="--", zorder=2, alpha=0.9)

        #     # label: "meas / spec @ offset" — placed above spec line,
        #     # anchored left of right edge so it never leaves the axes
        #     f_label = f_s / 1e6
        #     unit    = "MHz" if f_label >= 1 else f"{f_s/1e3:.0f} kHz"
        #     if f_label >= 1:
        #         unit = f"{f_label:.0f} MHz"
        #     label = (f"{L_meas:.1f} / {L_s} dBc/Hz\n"
        #              f"@ {unit}")
        #     ax.text(f_off.max() * 0.85, L_s + y_span * 0.03,
        #             label, ha="right", va="bottom",
        #             fontsize=5.0, color=C_SPEC,
        #             bbox=dict(boxstyle="square,pad=0.15",
        #                       fc="white", ec="none", alpha=0.88))

        # ── Freq std dev annotation (top-left, clear of curve) ─────────────
        # ax.text(0.03, 0.97,
        #         f"$f_0$ = {f0/1e9:.4f} GHz\n"
        #         f"$\\sigma_f$ = {f_std/1e6:.2f} MHz",
        #         transform=ax.transAxes, ha="left", va="top",
        #         fontsize=5.5,
        #         bbox=dict(boxstyle="square,pad=0.2",
        #                   fc="white", ec="none", alpha=0.88))

        # ── Axis formatting ────────────────────────────────────────────────
        ax.set_xlabel("Frequency Offset (Hz)")
        ax.set_ylabel(r"$\mathcal{L}(f)$ (dBc/Hz)", color=C_LINE)
        ax.tick_params(axis="y", colors=C_LINE, which="both")
        ax.spines["left"].set_color(C_LINE)

        ax.xaxis.set_major_formatter(ticker.EngFormatter())
        ax.xaxis.set_major_locator(ticker.LogLocator(base=10, numticks=8))

        fig.tight_layout(pad=0.4)
        fig.savefig(save_path, dpi=600, bbox_inches="tight",
                    format="pdf" if save_path.endswith(".pdf") else "png")
        print(f"Saved: {save_path}")


# ---------------------------------------------------------------------------
# 6.  Main
# ---------------------------------------------------------------------------

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))

    if len(sys.argv) > 1:
        raw_path = os.path.abspath(sys.argv[1])
    else:
        raw_path = os.path.abspath(
            os.path.join(script_dir, "../simulations/pll_top.raw"))

    if not os.path.isfile(raw_path):
        print(f"Error: '{raw_path}' not found.")
        sys.exit(1)

    print(f"Raw file : {raw_path}  ({os.path.getsize(raw_path)/1024**2:.0f} MB)")
    print(f"Loading v(clk_out) (settled region t > {T_SETTLE*1e6:.0f} µs, "
          f"downsample=4) ...")

    t, v = load_two_signals(raw_path, "v(clk_out)",
                            downsample=4, t_start=T_SETTLE)

    dt_mean = np.mean(np.diff(t))
    print(f"  {len(t):,} points  "
          f"dt≈{dt_mean*1e12:.0f} ps  "
          f"span={(t[-1]-t[0])*1e6:.1f} µs  "
          f"fs≈{1/dt_mean/1e9:.2f} GHz")

    print("  Detecting rising zero-crossings (threshold = 0.6 V) ...")
    t_cross = find_rising_crossings(t, v, threshold=0.6)
    print(f"  {len(t_cross):,} crossings found")

    if len(t_cross) < 256:
        print("Error: too few crossings — verify the PLL has settled.")
        sys.exit(1)

    print("  Computing phase noise via period-jitter Welch PSD ...")
    f_off, L_dBc, f0 = compute_phase_noise(t_cross)

    # ── Frequency statistics from instantaneous period ────────────────────
    periods = np.diff(t_cross)
    f_inst  = 1.0 / periods
    f_std   = np.std(f_inst)
    f_min   = np.min(f_inst)
    f_max   = np.max(f_inst)

    print(f"\n  Carrier f0  : {f0/1e9:.6f} GHz")
    print(f"  Freq std dev: {f_std/1e6:.3f} MHz  ({f_std/f0*1e6:.1f} ppm)")
    print(f"  Freq range  : {f_min/1e9:.4f} – {f_max/1e9:.4f} GHz")
    print(f"  Offset range: {f_off.min()/1e3:.1f} kHz – {f_off.max()/1e6:.0f} MHz")
    for f_s, L_s, _ in SPECS:
        idx  = np.argmin(np.abs(f_off - f_s))
        flag = "✓" if L_dBc[idx] <= L_s else "✗"
        print(f"  L({f_s/1e6:.0f} MHz) = {L_dBc[idx]:.1f} dBc/Hz  "
              f"(spec: {L_s} dBc/Hz)  {flag}")

    base = os.path.join(script_dir, "phase_noise")
    plot_phase_noise(f_off, L_dBc, f0, f_std, base + ".pdf")
    plot_phase_noise(f_off, L_dBc, f0, f_std, base + ".png")


if __name__ == "__main__":
    main()
