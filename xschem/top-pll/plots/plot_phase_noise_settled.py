#!/usr/bin/env python3
"""
Phase Noise from PLL Transient Simulation  (Settled Window Edition)
====================================================================
Computes SSB phase noise L(f) [dBc/Hz] from v(clk_out) in the ngspice
raw file using the period-jitter (zero-crossing) method.

Only the settled window T_START–T_END is analysed.  Adjust the two
constants below to match your simulation's lock time.

Method
------
  1. Load v(clk_out) from the settled window [T_START, T_END]
  2. Find rising zero-crossings with sub-step linear interpolation
  3. Period deviation sequence  δT_k = T_k − T̄
  4. Welch PSD  S_δT(f)  of δT_k sampled at the carrier rate f₀
  5. SSB phase noise:  L(f) = f₀⁴ · S_δT(f) / (2 · f²)

Usage
-----
  python3 plot_phase_noise_settled.py
  python3 plot_phase_noise_settled.py /path/to/pll_top.raw
"""

import os, sys
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
from scipy.signal import welch
import scienceplots                          # noqa: F401  (registers styles)

# ── Style ─────────────────────────────────────────────────────────────────────
C_LINE = "#C0143C"   # crimson  – phase noise curve
C_SPEC = "#F5A623"   # amber    – spec markers

# ── Spec targets ──────────────────────────────────────────────────────────────
SPECS = [
    (1e6,  -100, "-100 dBc/Hz @ 1 MHz"),
    (10e6, -135, "-135 dBc/Hz @ 10 MHz"),
]

# ── Settled analysis window ───────────────────────────────────────────────────
T_START = 55e-6   # 55 µs  — start of settled region
T_END   = 75e-6   # 75 µs  — end of settled region


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

def load_two_signals(filepath, sig_name, downsample=1, t_start=None, t_end=None):
    """
    Load time + one signal from a binary ngspice raw file within [t_start, t_end].
    Uses numpy memmap — only the two needed columns are copied into RAM.

    Returns: t (s), v (V) arrays.
    """
    meta     = parse_raw_header(filepath)
    n_vars   = meta["n_vars"]
    n_points = meta["n_points"]
    offset   = meta["data_offset"]

    var_idx = next(
        (v["index"] for v in meta["variables"] if v["name"] == sig_name), None
    )
    if var_idx is None:
        raise ValueError(f"Signal '{sig_name}' not found in raw file.\n"
                         f"Available: {[v['name'] for v in meta['variables']]}")

    mm = np.memmap(filepath, dtype=np.float64, mode="r",
                   offset=offset, shape=(n_points, n_vars))

    t = np.array(mm[:, 0])
    v = np.array(mm[:, var_idx])
    del mm

    # Window in time
    if t_start is not None:
        i0 = np.searchsorted(t, t_start)
        t, v = t[i0:], v[i0:]
    if t_end is not None:
        i1 = np.searchsorted(t, t_end)
        t, v = t[:i1], v[:i1]

    if len(t) == 0:
        raise ValueError(
            f"No data in window [{t_start*1e6:.1f} µs, {t_end*1e6:.1f} µs]. "
            "Check T_START / T_END against your simulation stop time."
        )

    if downsample > 1:
        t, v = t[::downsample], v[::downsample]

    return t, v


# ---------------------------------------------------------------------------
# 3.  Rising zero-crossing detector (sub-step linear interpolation)
# ---------------------------------------------------------------------------

def find_rising_crossings(t, v, threshold=0.6):
    """Return interpolated times of rising edges through `threshold`."""
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

      δT_k  = T_k − T̄
      S_δT(f): Welch PSD of δT_k  [s²/Hz], sampled at f₀ = 1/T̄
      L(f)  = f₀⁴ · S_δT(f) / (2 · f²)

    Returns: f_offset (Hz), L_dBc (dBc/Hz), f0 (Hz)
    """
    periods = np.diff(t_cross)
    T0      = np.mean(periods)
    f0      = 1.0 / T0
    dT      = periods - T0

    nperseg = max(64, len(dT) // 8)
    f_psd, S_dT = welch(dT, fs=f0, nperseg=nperseg,
                        window="hann", scaling="density",
                        noverlap=nperseg // 2)

    valid  = f_psd > 0
    f_off  = f_psd[valid]
    S      = S_dT[valid]

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

        y_lo = min(np.percentile(L_dBc, 5) - 10, -160)
        y_hi = max(np.percentile(L_dBc, 95) + 15, -30)
        ax.set_ylim(y_lo, y_hi)
        ax.set_xlim(f_off.min(), f_off.max())

        ax.semilogx(f_off, L_dBc, color=C_LINE, linewidth=1.4, zorder=4)

        ax.set_xlabel("Frequency Offset (Hz)")
        ax.set_ylabel(r"$\mathcal{L}(f)$ (dBc/Hz)", color=C_LINE)
        ax.tick_params(axis="y", colors=C_LINE, which="both")
        ax.spines["left"].set_color(C_LINE)

        ax.xaxis.set_major_formatter(ticker.EngFormatter())
        ax.xaxis.set_major_locator(ticker.LogLocator(base=10, numticks=8))

        # Window annotation in top-left corner
        ax.text(0.03, 0.97,
                f"Window: {T_START*1e6:.0f}–{T_END*1e6:.0f} µs\n"
                f"$f_0$ = {f0/1e9:.4f} GHz",
                transform=ax.transAxes, ha="left", va="top",
                fontsize=5.5,
                bbox=dict(boxstyle="square,pad=0.2",
                          fc="white", ec="none", alpha=0.88))

        fig.tight_layout(pad=0.4)
        fmt = "pdf" if save_path.endswith(".pdf") else "png"
        fig.savefig(save_path, dpi=600, bbox_inches="tight", format=fmt)
        plt.close(fig)
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
            os.path.join(script_dir, "../../../simulations/tb_LC_VCO_FPLL_100u.raw"))

    if not os.path.isfile(raw_path):
        print(f"Error: '{raw_path}' not found.")
        sys.exit(1)

    print(f"Raw file : {raw_path}  ({os.path.getsize(raw_path)/1024**2:.1f} MB)")
    print(f"Window   : {T_START*1e6:.0f} µs – {T_END*1e6:.0f} µs  (downsample=4)")

    t, v = load_two_signals(raw_path, "v(clk_out)",
                            downsample=4, t_start=T_START, t_end=T_END)

    dt_mean = np.mean(np.diff(t))
    print(f"  {len(t):,} points  "
          f"dt≈{dt_mean*1e12:.0f} ps  "
          f"span={(t[-1]-t[0])*1e6:.2f} µs  "
          f"fs≈{1/dt_mean/1e9:.2f} GHz")

    print("  Detecting rising zero-crossings (threshold = 0.6 V) ...")
    t_cross = find_rising_crossings(t, v, threshold=0.6)
    print(f"  {len(t_cross):,} crossings found")

    if len(t_cross) < 256:
        print("Warning: fewer than 256 crossings — Welch estimate will be coarse.")
        print("  Consider widening the window or reducing the downsample factor.")
    if len(t_cross) < 16:
        print("Error: too few crossings to estimate phase noise.")
        sys.exit(1)

    print("  Computing phase noise via period-jitter Welch PSD ...")
    f_off, L_dBc, f0 = compute_phase_noise(t_cross)

    periods = np.diff(t_cross)
    f_inst  = 1.0 / periods
    f_std   = np.std(f_inst)

    print(f"\n  Carrier f0  : {f0/1e9:.6f} GHz")
    print(f"  Freq std dev: {f_std/1e6:.3f} MHz  ({f_std/f0*1e6:.1f} ppm)")
    print(f"  Freq range  : {f_inst.min()/1e9:.4f} – {f_inst.max()/1e9:.4f} GHz")
    print(f"  Offset range: {f_off.min()/1e3:.1f} kHz – {f_off.max()/1e6:.0f} MHz")

    for f_s, L_s, _ in SPECS:
        idx  = np.argmin(np.abs(f_off - f_s))
        flag = "PASS" if L_dBc[idx] <= L_s else "FAIL"
        print(f"  L({f_s/1e6:.0f} MHz) = {L_dBc[idx]:.1f} dBc/Hz  "
              f"(spec: {L_s} dBc/Hz)  [{flag}]")

    base = os.path.join(script_dir, "phase_noise_settled")
    plot_phase_noise(f_off, L_dBc, f0, f_std, base + ".pdf")
    plot_phase_noise(f_off, L_dBc, f0, f_std, base + ".png")


if __name__ == "__main__":
    main()
