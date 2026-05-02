#!/usr/bin/env python3
"""
PLL Reference Spur — Spectrum Analyser Style Plot
==================================================
Matches the style of the reference image:
  • White background, black/coloured trace
  • Y-axis: Power (dBc), negative, 0 at top, noise floor at bottom
  • X-axis: absolute frequency (GHz), carrier centred, ±N×f_ref visible
  • Carrier = tallest peak (0 dBc reference), spurs are discrete peaks below
  • Red annotation arrows for spur level

Method: zero-crossing period-jitter FFT (correct domain for digital clocks)

Usage
-----
  python3 plot_reference_spur_SA.py /path/to/pll_top.raw
  python3 plot_reference_spur_SA.py /path/to/pll_top.raw --fref 10e6
  python3 plot_reference_spur_SA.py /path/to/pll_top.raw --zpad 16 --threshold 0.9
"""

import os, sys, argparse
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
from matplotlib.collections import LineCollection

# ── Parameters ────────────────────────────────────────────────────────────────
F_REF     = 10e6    # reference frequency (Hz)
T_SETTLE  = 20e-6   # skip first N seconds (PLL settling)
THRESHOLD = 0.6     # zero-crossing threshold (V); use ~half of VDD
ZPAD      = 8       # zero-padding factor (more → finer bins)
SEARCH_BW = 0.5e6   # ±Hz window to search for spur peak
N_HARM    = 4       # number of f_ref harmonics to show each side of carrier


# ---------------------------------------------------------------------------
# 1. ngspice binary .raw header parser
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
# 2. Memory-mapped signal loader
# ---------------------------------------------------------------------------
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


# ---------------------------------------------------------------------------
# 3. Rising zero-crossing detector — vectorised
# ---------------------------------------------------------------------------
def find_rising_crossings(t, v, threshold=THRESHOLD):
    above    = v > threshold
    edge_idx = np.where(np.diff(above.astype(np.int8)) == 1)[0]
    dv       = v[edge_idx + 1] - v[edge_idx]
    frac     = np.where(dv != 0.0, (threshold - v[edge_idx]) / dv, 0.5)
    return t[edge_idx] + frac * (t[edge_idx + 1] - t[edge_idx])


# ---------------------------------------------------------------------------
# 4. Period-jitter FFT → single-sided amplitude spectrum A(f) [seconds]
# ---------------------------------------------------------------------------
def compute_jitter_spectrum(t_cross, zpad=ZPAD):
    """
    Returns
    -------
    f_off : offset frequency array (Hz), positive, DC excluded
    A     : jitter amplitude (s, peak, single-sided, window-corrected)
    f0    : carrier frequency (Hz)
    N     : number of jitter periods
    """
    periods  = np.diff(t_cross)
    T0       = np.mean(periods)
    f0       = 1.0 / T0
    dT       = periods - T0          # δTₖ = Tₖ − T̄  → zero-mean, no DC

    N        = len(dT)
    N_fft    = N * zpad
    win      = np.hanning(N)
    cg       = np.sum(win) / N       # coherent gain ≈ 0.5

    buf      = np.zeros(N_fft)
    buf[:N]  = dT * win
    X        = np.fft.rfft(buf)
    f_fft    = np.fft.rfftfreq(N_fft, d=1.0 / f0)

    A        = np.abs(X) / (N * cg)
    A[1:-1] *= 2.0                   # single-sided: ×2 except DC & Nyquist

    valid = f_fft > 0
    return f_fft[valid], A[valid], f0, N


# ---------------------------------------------------------------------------
# 5. Convert jitter amplitude → dBc power spectrum (correct, negative values)
# ---------------------------------------------------------------------------
def jitter_to_dBc(A, f0):
    """
    φ(f) = 2π·f₀·A(f)   [radians, peak phase deviation]

    Carrier reference = 0 dBc  (i.e., the carrier bin is normalised to 0).
    All other bins are below → negative dBc values.

    Power at each bin relative to carrier:
        P(f) [dBc] = 20·log10( φ(f) / φ_max )
                   = 20·log10( A(f) / A_max )   (f₀ cancels)

    So we simply normalise by the peak amplitude → carrier = 0 dBc,
    everything else is negative. This matches spectrum analyser convention.
    """
    A_max  = np.max(A)                                   # carrier bin
    ratio  = np.maximum(A / A_max, 1e-300)
    return 20.0 * np.log10(ratio)                        # dBc, carrier=0, rest<0


# ---------------------------------------------------------------------------
# 6. Measure spur level in dBc (peak search near f_ref)
# ---------------------------------------------------------------------------
def measure_spur(f_off, P_dBc, f_ref=F_REF, search_bw=SEARCH_BW):
    """
    Find the peak bin within ±search_bw of f_ref.
    Returns spur frequency (Hz) and spur level (dBc, negative).
    """
    mask = np.abs(f_off - f_ref) <= search_bw
    if not np.any(mask):
        raise ValueError(
            f"No FFT bins within ±{search_bw/1e3:.0f} kHz of "
            f"{f_ref/1e6:.1f} MHz. Increase --zpad or simulation time.")

    peak_local = np.argmax(P_dBc[mask])
    f_spur     = f_off[mask][peak_local]
    spur_dBc   = P_dBc[mask][peak_local]    # negative ✓

    return f_spur, spur_dBc


# ---------------------------------------------------------------------------
# 7. Spectrum analyser style plot
# ---------------------------------------------------------------------------
def plot_SA(f_off, P_dBc, f0, f_spur, spur_dBc_val,
            save_path, f_ref=F_REF, n_harm=N_HARM):
    """
    Spectrum analyser style:
      • Y-axis  : Power (dBc), 0 at top, noise floor negative at bottom
      • X-axis  : Absolute frequency (GHz), carrier centred
      • Carrier : tallest spike at 0 dBc
      • Spurs   : discrete peaks at ±N×f_ref, labelled in dBc
      • Style   : white background, black trace, red annotations
    """
    # ── Build symmetric (double-sided) spectrum around carrier ────────────
    # f_off is positive-only (offset from carrier).
    # Mirror to show both sidebands, like a real SA display.
    span_hz  = (n_harm + 0.5) * f_ref

    # Trim to display span
    trim     = f_off <= span_hz
    fo       = f_off[trim]
    Pd       = P_dBc[trim]

    # Mirror: negative offsets (left sideband) + positive (right sideband)
    # Carrier bin (offset=0) is placed at the join; approximate by using
    # the minimum offset bin as the closest proxy for f0
    f_sym    = np.concatenate([-fo[::-1], fo])
    P_sym    = np.concatenate([ Pd[::-1],  Pd])

    # Absolute GHz for x-axis
    f_abs_GHz = (f0 + f_sym) / 1e9

    # Noise floor: 5th percentile — sets bottom of y-axis
    p_floor  = np.percentile(P_sym, 2) - 5   # a little below actual floor

    # ── Figure ────────────────────────────────────────────────────────────
    fig, ax = plt.subplots(figsize=(8, 4.5))
    fig.patch.set_facecolor("white")
    ax.set_facecolor("white")
    ax.grid(True, color="#cccccc", linewidth=0.5, linestyle="-", zorder=0)
    ax.set_axisbelow(True)

    # ── Coloured trace: blue (noise) → cyan → yellow → red (peaks) ────────
    cmap   = matplotlib.colormaps["jet"]
    P_norm = np.clip((P_sym - p_floor) / (0 - p_floor), 0, 1)

    points = np.array([f_abs_GHz, P_sym]).T.reshape(-1, 1, 2)
    segs   = np.concatenate([points[:-1], points[1:]], axis=1)
    cols   = cmap((P_norm[:-1] + P_norm[1:]) / 2)
    lc     = LineCollection(segs, colors=cols, linewidth=1.0, zorder=3)
    ax.add_collection(lc)

    # ── Shaded fill under spectrum (fast — no per-point vlines loop) ──────
    ax.fill_between(f_abs_GHz, p_floor, P_sym,
                    color="#4488cc", alpha=0.12, zorder=2)

    # ── Carrier marker at 0 dBc ───────────────────────────────────────────
    f0_GHz = f0 / 1e9
    ax.vlines(f0_GHz, p_floor, 0,
              colors="black", linewidth=1.8, zorder=6)
    ax.annotate(
        "Fundamental\nHarmonic",
        xy=(f0_GHz, 0),
        xytext=(f0_GHz + 1.2 * f_ref / 1e9, -12),
        fontsize=8, color="#222222",
        arrowprops=dict(arrowstyle="-|>", color="#444444",
                        lw=0.9, connectionstyle="arc3,rad=-0.25"))

    # ── Spur markers at ±N×f_ref ─────────────────────────────────────────
    # For n=1: use f_spur + spur_dBc_val from measure_spur() — one source
    # of truth so arrow label == info box value, always.
    # For n>1: nearest-bin lookup (informational only, no separate search).
    C_RED       = "#CC0000"
    spurs_found = []   # list of (offset_hz, level_dBc)

    for n in range(1, n_harm + 1):
        f_s_off = n * f_ref
        if f_s_off > span_hz:
            break

        if n == 1:
            # Exact measured value — same number shown in info box
            p_s = spur_dBc_val          # dBc, negative ✓
        else:
            # Nearest-bin lookup for higher harmonics
            idx_pos = np.argmin(np.abs(fo - f_s_off))
            p_s     = Pd[idx_pos]

        for sign in (+1, -1):
            f_s_GHz = (f0 + sign * f_s_off) / 1e9
            ax.vlines(f_s_GHz, p_floor, p_s,
                      colors=C_RED, linewidth=0.8,
                      linestyle="-", zorder=5, alpha=0.7)

        spurs_found.append((f_s_off, p_s))

    # ── "Reference Spurs" label with arrow ───────────────────────────────
    if len(spurs_found) >= 1:
        f_s1_GHz = f_spur / 1e9          # exact measured frequency
        ax.annotate(
            "Reference Spurs",
            xy=(f_s1_GHz, spur_dBc_val),
            xytext=(f0_GHz - 1.5 * f_ref / 1e9, spur_dBc_val + 18),
            fontsize=8.5, color=C_RED, ha="center",
            arrowprops=dict(arrowstyle="-|>", color=C_RED, lw=1.1,
                            connectionstyle="arc3,rad=0.3"))

    # ── dBc double-headed arrow on first positive spur ────────────────────
    # Uses f_spur (exact Hz from measure_spur) and spur_dBc_val (same search)
    # so the arrow label is guaranteed to match the info box.
    if spurs_found:
        f_s1_GHz = f_spur / 1e9              # exact measured frequency
        arr_x    = f_s1_GHz + 0.5 * f_ref / 1e9

        ax.annotate(
            "",
            xy=(arr_x, 0),                   # top  : 0 dBc (carrier)
            xytext=(arr_x, spur_dBc_val),    # bottom: measured spur level
            arrowprops=dict(
                arrowstyle="<->", color=C_RED,
                lw=1.5, shrinkA=2, shrinkB=2))

        # Label: same value as info box ✓
        ax.text(
            arr_x + 0.2 * f_ref / 1e9,
            spur_dBc_val / 2,
            f"{spur_dBc_val:.1f} dBc",
            va="center", ha="left",
            fontsize=9.5, color=C_RED, fontweight="bold",
            bbox=dict(boxstyle="round,pad=0.25",
                      fc="white", ec="none", alpha=0.9))

        # f_ref offset label below spur stem
        ax.text(
            f_s1_GHz, p_floor + 8,
            f"{f_ref/1e6:.0f} MHz",
            fontsize=8.5, color="#0055CC",
            fontweight="bold", ha="center")

    # ── Info box ─────────────────────────────────────────────────────────
    ax.text(
        0.985, 0.97,
        f"$F_0$      = {f0/1e9:.4f} GHz\n"
        f"$F_{{ref}}$  = {f_ref/1e6:.0f} MHz\n"
        f"Spur    = {spur_dBc_val:.1f} dBc",
        transform=ax.transAxes, ha="right", va="top",
        fontsize=8.5, family="monospace", color="#111111",
        bbox=dict(boxstyle="round,pad=0.4", fc="white",
                  ec="#aaaaaa", alpha=0.95, lw=0.8))

    # ── Axes ──────────────────────────────────────────────────────────────
    ax.set_xlim((f0 - span_hz) / 1e9, (f0 + span_hz) / 1e9)
    ax.set_ylim(p_floor, 8)      # 0 dBc at carrier, noise floor at bottom

    # X ticks every f_ref
    ax.xaxis.set_major_locator(
        ticker.MultipleLocator(2 * f_ref / 1e9))
    ax.xaxis.set_minor_locator(
        ticker.MultipleLocator(f_ref / 1e9))
    ax.xaxis.set_major_formatter(
        ticker.FuncFormatter(lambda x, _: f"{x:.3f}"))
    ax.tick_params(axis="x", labelrotation=0, labelsize=8, which="both",
                   colors="black")
    ax.tick_params(axis="x", which="minor", length=3)

    # Y ticks every 20 dBc
    ax.yaxis.set_major_locator(ticker.MultipleLocator(20))
    ax.yaxis.set_minor_locator(ticker.MultipleLocator(10))
    ax.tick_params(axis="y", labelsize=8, colors="black")

    for spine in ax.spines.values():
        spine.set_edgecolor("#888888")
        spine.set_linewidth(0.8)

    ax.set_xlabel("Frequency (GHz)", fontsize=10, color="black")
    ax.set_ylabel("Power (dBc)", fontsize=10, color="black")
    ax.set_title(
        f"PLL Output Spectrum — Reference Spur: {spur_dBc_val:.1f} dBc"
        f"  @  {f_ref/1e6:.0f} MHz offset  |  $f_0$ = {f0/1e9:.4f} GHz",
        fontsize=9.5, pad=10, color="black")

    fig.subplots_adjust(left=0.09, right=0.97, top=0.91, bottom=0.18)
    fmt = "pdf" if save_path.endswith(".pdf") else "png"
    fig.savefig(save_path, dpi=300,
                format=fmt, facecolor="white")
    print(f"  Saved: {save_path}")
    plt.close(fig)


# ---------------------------------------------------------------------------
# 8. Main
# ---------------------------------------------------------------------------
def main():
    parser = argparse.ArgumentParser(
        description="PLL reference spur — SA style plot from ngspice .raw file")
    parser.add_argument("raw_file", nargs="?",
        help="Path to ngspice .raw transient file")
    parser.add_argument("--fref",      type=float, default=F_REF,
        help=f"Reference frequency Hz [default {F_REF:.0e}]")
    parser.add_argument("--zpad",      type=int,   default=ZPAD,
        help=f"Zero-padding factor [default {ZPAD}]")
    parser.add_argument("--threshold", type=float, default=THRESHOLD,
        help=f"Zero-crossing threshold V [default {THRESHOLD}]")
    parser.add_argument("--tsettle",   type=float, default=T_SETTLE,
        help=f"Skip settling time s [default {T_SETTLE:.1e}]")
    parser.add_argument("--search_bw", type=float, default=SEARCH_BW,
        help=f"Spur search half-BW Hz [default {SEARCH_BW:.0e}]")
    parser.add_argument("--nharm",     type=int,   default=N_HARM,
        help=f"Harmonics to show each side [default {N_HARM}]")
    args = parser.parse_args()

    script_dir = os.path.dirname(os.path.abspath(__file__))

    # ── Default path matches your project layout ──────────────────────────
    raw_path = (os.path.abspath(args.raw_file) if args.raw_file else
                os.path.abspath(os.path.join(
                    script_dir, "../simulations/pll_sim_100U.raw")))

    if not os.path.isfile(raw_path):
        print(f"Error: '{raw_path}' not found.")
        sys.exit(1)

    # ── Load ──────────────────────────────────────────────────────────────
    print(f"\nRaw file : {raw_path}  ({os.path.getsize(raw_path)/1024**2:.1f} MB)")
    print(f"Loading v(clk_out)  (skip first {args.tsettle*1e6:.0f} µs) ...")
    t, v = load_signal(raw_path, "v(clk_out)", t_start=args.tsettle)

    dt_mean = np.mean(np.diff(t))
    print(f"  {len(t):,} points  |  fs = {1/dt_mean/1e9:.3f} GHz  |  "
          f"span = {(t[-1]-t[0])*1e6:.1f} µs")
    print(f"  v(clk_out): {v.min():.3f} V … {v.max():.3f} V")
    thr_ok = v.min() < args.threshold < v.max()
    print(f"  Threshold : {args.threshold} V  "
          f"({'OK' if thr_ok else 'WARNING: outside signal range!'})")

    # ── Zero crossings ────────────────────────────────────────────────────
    print(f"Detecting rising edges (threshold = {args.threshold} V) ...")
    t_cross = find_rising_crossings(t, v, threshold=args.threshold)
    print(f"  {len(t_cross):,} crossings found")

    if len(t_cross) < 512:
        print("ERROR: <512 crossings — check threshold or extend simulation.")
        sys.exit(1)

    # ── Jitter spectrum ───────────────────────────────────────────────────
    print(f"Computing jitter FFT (zero-pad ×{args.zpad}) ...")
    f_off, A, f0, N = compute_jitter_spectrum(t_cross, zpad=args.zpad)

    df_pad = (f0 / N) / args.zpad
    print(f"  Carrier f₀    : {f0/1e9:.6f} GHz")
    print(f"  Jitter samples: {N:,}")
    print(f"  Bin width     : {df_pad:.1f} Hz (zero-padded)")

    # ── Convert to dBc (carrier = 0 dBc, all else negative) ──────────────
    P_dBc = jitter_to_dBc(A, f0)

    # ── Spur measurement ──────────────────────────────────────────────────
    print(f"Searching for spur near {args.fref/1e6:.1f} MHz ...")
    f_spur, spur_dBc = measure_spur(
        f_off, P_dBc, f_ref=args.fref, search_bw=args.search_bw)

    # ── Console report ────────────────────────────────────────────────────
    sep = "=" * 58
    print(f"\n{sep}")
    print("  PLL REFERENCE SPUR MEASUREMENT")
    print(sep)
    print(f"  Carrier       : {f0/1e9:.6f} GHz")
    print(f"  Spur offset   : {f_spur/1e6:.3f} MHz  (target {args.fref/1e6:.1f} MHz)")
    print(f"  Spur level    : {spur_dBc:.2f} dBc")
    print(f"  Sign check    : "
          + ("NEGATIVE — correct ✓" if spur_dBc < 0
             else "POSITIVE — check threshold / settling!"))
    print(sep + "\n")

    # ── Save plots ────────────────────────────────────────────────────────
    base = os.path.join(script_dir, "reference_spur_SA")
    for ext in (".png", ".pdf"):
        plot_SA(f_off, P_dBc, f0, f_spur, spur_dBc,
                base + ext, f_ref=args.fref, n_harm=args.nharm)


if __name__ == "__main__":
    main()