#!/usr/bin/env python3
"""
verify_reference_spur.py
========================
Independent verification of the reference spur plot produced by
plot_reference_spur.py.

Method used here  : Welch PSD on the raw voltage waveform  (v(clk_out))
Original method   : Zero-crossing period-jitter FFT

Both methods must agree on:
  • Carrier frequency  (f0)
  • Spur offset        (≈ f_ref)
  • Spur level         (dBc)

If they agree → the original plot is physically correct.
If they differ → flag which parameter is wrong and why.

Usage
-----
  python3 verify_reference_spur.py
  python3 verify_reference_spur.py /path/to/file.raw
  python3 verify_reference_spur.py /path/to/file.raw --fref 10e6 --tsettle 50e-6
"""

import os, sys, argparse
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
from scipy.signal import welch, get_window

# ── Default parameters (must match plot_reference_spur.py) ────────────────────
F_REF     = 10e6
T_SETTLE  = 20e-6
THRESHOLD = 0.6
ZPAD      = 8
SEARCH_BW = 0.5e6
N_HARM    = 4

# ── Welch parameters ──────────────────────────────────────────────────────────
WELCH_NPERSEG_CYCLES = 512   # number of carrier cycles per Welch segment


# =============================================================================
# Shared: ngspice binary .raw reader  (identical to original script)
# =============================================================================
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


def load_signal(filepath, sig_name, t_start=None):
    meta     = parse_raw_header(filepath)
    n_vars   = meta["n_vars"]
    n_points = meta["n_points"]
    offset   = meta["data_offset"]

    var_idx = next(
        (v["index"] for v in meta["variables"] if v["name"] == sig_name), None)
    if var_idx is None:
        avail = [v["name"] for v in meta["variables"]]
        raise ValueError(f"Signal '{sig_name}' not found. Available: {avail}")

    mm = np.memmap(filepath, dtype=np.float64, mode="r",
                   offset=offset, shape=(n_points, n_vars))
    t = np.array(mm[:, 0])
    v = np.array(mm[:, var_idx])
    del mm

    if t_start is not None:
        idx = np.searchsorted(t, t_start)
        t, v = t[idx:], v[idx:]
    return t, v


# =============================================================================
# Method A : Zero-crossing jitter FFT  (same as original)
# =============================================================================
def find_rising_crossings(t, v, threshold=THRESHOLD):
    above    = v > threshold
    edge_idx = np.where(np.diff(above.astype(np.int8)) == 1)[0]
    dv       = v[edge_idx + 1] - v[edge_idx]
    frac     = np.where(dv != 0.0, (threshold - v[edge_idx]) / dv, 0.5)
    return t[edge_idx] + frac * (t[edge_idx + 1] - t[edge_idx])


def jitter_fft_spectrum(t_cross, zpad=ZPAD):
    periods = np.diff(t_cross)
    T0      = np.mean(periods)
    f0      = 1.0 / T0
    dT      = periods - T0

    N      = len(dT)
    N_fft  = N * zpad
    win    = np.hanning(N)
    cg     = np.sum(win) / N

    buf       = np.zeros(N_fft)
    buf[:N]   = dT * win
    X         = np.fft.rfft(buf)
    f_fft     = np.fft.rfftfreq(N_fft, d=1.0 / f0)

    A       = np.abs(X) / (N * cg)
    A[1:-1] *= 2.0

    valid = f_fft > 0
    f_off = f_fft[valid]
    A_off = A[valid]

    A_max  = np.max(A_off)
    P_dBc  = 20.0 * np.log10(np.maximum(A_off / A_max, 1e-300))
    return f_off, P_dBc, f0


def measure_spur(f_off, P_dBc, f_ref=F_REF, search_bw=SEARCH_BW):
    mask = np.abs(f_off - f_ref) <= search_bw
    if not np.any(mask):
        raise ValueError(f"No FFT bins within ±{search_bw/1e3:.0f} kHz of {f_ref/1e6:.1f} MHz")
    peak_local = np.argmax(P_dBc[mask])
    return f_off[mask][peak_local], P_dBc[mask][peak_local]


# =============================================================================
# Method B : Welch PSD on raw voltage waveform  (independent verification)
# =============================================================================
def welch_spectrum(t, v, f0_est, f_ref=F_REF, search_bw=SEARCH_BW,
                   cycles_per_seg=WELCH_NPERSEG_CYCLES):
    """
    Compute Welch PSD of v(t), then:
      1. Find carrier peak → f0
      2. Search ±search_bw around f0 + f_ref  → first reference spur
      3. Return spectrum in dBc (carrier = 0 dBc)

    Returns
    -------
    f       : frequency array (Hz)
    P_dBc   : power spectrum (dBc, carrier = 0)
    f0      : measured carrier frequency (Hz)
    f_spur  : first reference spur frequency (Hz)
    spur_dBc: spur level (dBc, negative)
    """
    # Uniform time grid required for Welch — use linear interpolation
    fs   = 1.0 / np.mean(np.diff(t))
    t_u  = np.arange(t[0], t[-1], 1.0 / fs)
    v_u  = np.interp(t_u, t, v)

    # Segment length: cycles_per_seg carrier cycles
    nperseg = int(cycles_per_seg * fs / f0_est)
    nperseg = max(nperseg, 1024)                 # floor

    # Welch PSD
    f_w, Pxx = welch(v_u, fs=fs, window="hann",
                     nperseg=nperseg, noverlap=nperseg // 2,
                     scaling="density")

    # Find carrier: largest peak in Pxx
    carrier_idx = np.argmax(Pxx)
    f0_welch    = f_w[carrier_idx]
    P_carrier   = Pxx[carrier_idx]

    # Convert to dBc
    P_dBc = 10.0 * np.log10(np.maximum(Pxx / P_carrier, 1e-300))

    # Spur search: look near f0 + f_ref
    mask = np.abs(f_w - (f0_welch + f_ref)) <= search_bw
    if not np.any(mask):
        # try negative sideband
        mask = np.abs(f_w - (f0_welch - f_ref)) <= search_bw
    if not np.any(mask):
        raise ValueError(
            f"Welch: no bins within ±{search_bw/1e3:.0f} kHz of "
            f"{(f0_welch+f_ref)/1e9:.4f} GHz")

    peak_local = np.argmax(P_dBc[mask])
    f_spur     = f_w[mask][peak_local]
    spur_dBc   = P_dBc[mask][peak_local]

    return f_w, P_dBc, f0_welch, f_spur, spur_dBc


# =============================================================================
# Plot — side-by-side comparison
# =============================================================================
def make_comparison_plot(
        # Method A
        f_off_A, P_dBc_A, f0_A, f_spur_A, spur_dBc_A,
        # Method B
        f_w_B, P_dBc_B, f0_B, f_spur_B, spur_dBc_B,
        f_ref, n_harm, save_base):

    span_hz = (n_harm + 0.5) * f_ref

    fig, axes = plt.subplots(1, 2, figsize=(14, 5))
    fig.patch.set_facecolor("white")

    titles = [
        "Method A — Zero-crossing jitter FFT\n(same as plot_reference_spur.py)",
        "Method B — Welch PSD on raw v(clk_out)\n(independent verification)",
    ]
    datasets = [
        (f_off_A, P_dBc_A, f0_A, f_spur_A, spur_dBc_A, "steelblue"),
        # Welch gives absolute frequencies; convert to offset from carrier
        (f_w_B - f0_B, P_dBc_B, f0_B, f_spur_B - f0_B, spur_dBc_B, "darkorange"),
    ]

    for ax, title, (f_off, P_dBc, f0, f_sp, spur_val, color) in \
            zip(axes, titles, datasets):

        ax.set_facecolor("white")
        ax.grid(True, color="#dddddd", linewidth=0.5, zorder=0)
        ax.set_axisbelow(True)

        # Trim to display span
        trim   = (f_off >= -span_hz) & (f_off <= span_hz)
        fo     = f_off[trim]
        Pd     = P_dBc[trim]
        p_floor = np.percentile(Pd, 2) - 5

        ax.plot(fo / 1e6, Pd, color=color, linewidth=0.7, zorder=3)
        ax.fill_between(fo / 1e6, p_floor, Pd,
                        color=color, alpha=0.15, zorder=2)

        # Carrier marker
        ax.axvline(0, color="black", linewidth=1.5, zorder=5,
                   label=f"f₀ = {f0/1e9:.4f} GHz")

        # Spur annotation
        if abs(f_sp) <= span_hz:
            ax.vlines(f_sp / 1e6, p_floor, spur_val,
                      colors="#CC0000", linewidth=1.2, zorder=6)
            ax.annotate(
                f"{spur_val:.1f} dBc",
                xy=(f_sp / 1e6, spur_val),
                xytext=(f_sp / 1e6 + f_ref / 1e6, spur_val + 15),
                fontsize=8.5, color="#CC0000",
                arrowprops=dict(arrowstyle="-|>", color="#CC0000", lw=1.0))

        # f_ref harmonic lines
        for n in range(1, n_harm + 1):
            for sign in (+1, -1):
                ax.axvline(sign * n * f_ref / 1e6,
                           color="#CC0000", linewidth=0.5,
                           linestyle="--", alpha=0.4, zorder=4)

        # Info box
        ax.text(0.98, 0.97,
                f"$f_0$   = {f0/1e9:.4f} GHz\n"
                f"$f_{{ref}}$ = {f_ref/1e6:.0f} MHz\n"
                f"Spur  = {spur_val:.1f} dBc",
                transform=ax.transAxes, ha="right", va="top",
                fontsize=8, family="monospace",
                bbox=dict(boxstyle="round,pad=0.4", fc="white",
                          ec="#aaaaaa", alpha=0.95, lw=0.8))

        ax.set_xlim(-span_hz / 1e6, span_hz / 1e6)
        ax.set_ylim(p_floor, 8)
        ax.xaxis.set_major_locator(ticker.MultipleLocator(f_ref / 1e6))
        ax.yaxis.set_major_locator(ticker.MultipleLocator(20))
        ax.tick_params(labelsize=8)
        ax.set_xlabel("Frequency offset from carrier (MHz)", fontsize=9)
        ax.set_ylabel("Power (dBc)", fontsize=9)
        ax.set_title(title, fontsize=9, pad=8)
        for spine in ax.spines.values():
            spine.set_edgecolor("#999999")
            spine.set_linewidth(0.7)

    # ── Agreement summary ────────────────────────────────────────────────────
    df0       = abs(f0_A - f0_B)
    dspur_hz  = abs(f_spur_A - (f_spur_B - f0_B))   # both in offset Hz
    dspur_dBc = abs(spur_dBc_A - spur_dBc_B)

    agree_f0   = "OK" if df0       < 1e6    else "MISMATCH"
    agree_fsp  = "OK" if dspur_hz  < 2e6    else "MISMATCH"
    agree_lvl  = "OK" if dspur_dBc < 10     else "MISMATCH"

    summary = (
        f"  Cross-method agreement\n"
        f"  -------------------------------------\n"
        f"  Delta_f0      : {df0/1e3:.1f} kHz     [{agree_f0}]\n"
        f"  Delta_f_spur  : {dspur_hz/1e6:.2f} MHz [{agree_fsp}]\n"
        f"  Delta_spur_lvl: {dspur_dBc:.1f} dBc   [{agree_lvl}]\n"
    )
    overall = "VERIFIED" if all(s == "OK" for s in [agree_f0, agree_fsp, agree_lvl]) \
              else "DISCREPANCY DETECTED"

    fig.suptitle(
        f"Reference Spur Verification — {overall}\n"
        f"A: {spur_dBc_A:.1f} dBc  |  B: {spur_dBc_B:.1f} dBc  |  "
        f"Δ = {dspur_dBc:.1f} dBc",
        fontsize=10, color=("darkgreen" if overall == "VERIFIED" else "#CC0000"),
        y=1.01)

    fig.tight_layout()

    for ext in (".png", ".pdf"):
        path = save_base + ext
        fmt  = "pdf" if ext == ".pdf" else "png"
        fig.savefig(path, dpi=300, format=fmt,
                    facecolor="white", bbox_inches="tight")
        print(f"  Saved: {path}")
    plt.close(fig)

    # Print summary to console
    print("\n" + summary)
    print(f"  Overall : {overall}\n")
    return overall


# =============================================================================
# Main
# =============================================================================
def main():
    parser = argparse.ArgumentParser(
        description="Independent verification of reference spur measurement")
    parser.add_argument("raw_file", nargs="?",
        help="Path to ngspice .raw transient file")
    parser.add_argument("--fref",      type=float, default=F_REF)
    parser.add_argument("--zpad",      type=int,   default=ZPAD)
    parser.add_argument("--threshold", type=float, default=THRESHOLD)
    parser.add_argument("--tsettle",   type=float, default=T_SETTLE)
    parser.add_argument("--search_bw", type=float, default=SEARCH_BW)
    parser.add_argument("--nharm",     type=int,   default=N_HARM)
    args = parser.parse_args()

    script_dir = os.path.dirname(os.path.abspath(__file__))
    raw_path = (os.path.abspath(args.raw_file) if args.raw_file else
                os.path.abspath(os.path.join(
                    script_dir, "../simulations/pll_sim_100u.raw")))

    if not os.path.isfile(raw_path):
        print(f"Error: '{raw_path}' not found.")
        sys.exit(1)

    print(f"\nRaw file : {raw_path}  ({os.path.getsize(raw_path)/1024**2:.1f} MB)")
    print(f"Loading v(clk_out)  (skip first {args.tsettle*1e6:.0f} µs) ...")
    t, v = load_signal(raw_path, "v(clk_out)", t_start=args.tsettle)
    print(f"  {len(t):,} points  |  v range: {v.min():.3f}–{v.max():.3f} V")

    # ── Method A: jitter FFT ─────────────────────────────────────────────────
    print("\n[Method A] Zero-crossing jitter FFT ...")
    t_cross = find_rising_crossings(t, v, threshold=args.threshold)
    print(f"  {len(t_cross):,} rising crossings")
    if len(t_cross) < 512:
        print("  ERROR: <512 crossings — check threshold or simulation time.")
        sys.exit(1)

    f_off_A, P_dBc_A, f0_A = jitter_fft_spectrum(t_cross, zpad=args.zpad)
    f_spur_A, spur_dBc_A   = measure_spur(f_off_A, P_dBc_A,
                                           f_ref=args.fref,
                                           search_bw=args.search_bw)
    print(f"  f0        = {f0_A/1e9:.6f} GHz")
    print(f"  Spur @    = {f_spur_A/1e6:.3f} MHz offset")
    print(f"  Spur lvl  = {spur_dBc_A:.2f} dBc")

    # ── Method B: Welch PSD ──────────────────────────────────────────────────
    print("\n[Method B] Welch PSD on raw voltage waveform ...")
    f_w_B, P_dBc_B, f0_B, f_spur_B, spur_dBc_B = welch_spectrum(
        t, v, f0_est=f0_A, f_ref=args.fref, search_bw=args.search_bw)
    print(f"  f0        = {f0_B/1e9:.6f} GHz")
    print(f"  Spur @    = {(f_spur_B-f0_B)/1e6:.3f} MHz offset")
    print(f"  Spur lvl  = {spur_dBc_B:.2f} dBc")

    # ── Save comparison plot ─────────────────────────────────────────────────
    save_base = os.path.join(script_dir, "spur_verification")
    print(f"\nGenerating comparison plot ...")
    make_comparison_plot(
        f_off_A, P_dBc_A, f0_A, f_spur_A, spur_dBc_A,
        f_w_B,   P_dBc_B, f0_B, f_spur_B, spur_dBc_B,
        f_ref=args.fref, n_harm=args.nharm, save_base=save_base)


if __name__ == "__main__":
    main()
