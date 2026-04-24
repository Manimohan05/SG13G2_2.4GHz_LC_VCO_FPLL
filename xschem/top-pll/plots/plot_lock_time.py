#!/usr/bin/env python3
"""
PLL Lock Time Measurement
=========================
Measures the PLL lock time from v(clk_in) and v(clk_out) in pll_sim.raw.

Method
------
  1. Load v(clk_in) and v(clk_out) from t=0 using memmap
  2. Find rising zero-crossings for both signals
  3. Compute instantaneous frequency of clk_out by sliding window:
       f_inst(t_k) = N_cycles / (t_{k+N} − t_k)   [Hz]
  4. Compute reference frequency f_ref from clk_in crossings (stable mean)
  5. Compute frequency error:
       err(t) = |f_inst(t) − f_target| / f_target × 1e6   [ppm]
     where f_target = f_ref × N_divider  (auto-detected from settled region)
  6. Lock time = first time err(t) enters and stays within ±LOCK_PPM_TOL

Two lock criteria are reported:
  • Frequency lock : f_out within ±LOCK_PPM_TOL ppm of f_target
  • Fine lock      : f_out within ±FINE_PPM_TOL ppm  (tighter, default ±10 ppm)

Plot
----
  Top panel    : instantaneous frequency of clk_out vs time  [GHz]
  Middle panel : frequency error vs time  [ppm], with tolerance bands
  Bottom panel : clk_in and clk_out waveforms (first 5 µs only, for clarity)
  Lock time is marked with a vertical dashed line on all panels.

Usage
-----
  python3 plot_lock_time.py
  python3 plot_lock_time.py /path/to/pll_sim.raw
  python3 plot_lock_time.py /path/to/pll_sim.raw --tol 100 --fine_tol 10
"""

import os, sys, argparse
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import scienceplots                          # noqa: F401

# ── Colours ──────────────────────────────────────────────────────────────────
C_OUT    = "#C0143C"   # crimson  – clk_out frequency / waveform
C_IN     = "#4A90D9"   # blue     – clk_in waveform
C_ERR    = "#7B68EE"   # purple   – frequency error
C_LOCK   = "#2CA02C"   # green    – lock time marker
C_BAND   = "#F5A623"   # amber    – tolerance band
C_FINE   = "#1DB954"   # bright green – fine lock band

# ── Defaults ─────────────────────────────────────────────────────────────────
LOCK_PPM_TOL  = 200    # coarse lock tolerance  (±200 ppm)
FINE_PPM_TOL  =  10    # fine   lock tolerance  (±10  ppm)
WIN_CYCLES    =  16    # cycles in sliding-window frequency estimator
LOCK_HOLD_NS  = 500    # must stay locked for this long to confirm (ns)


# ---------------------------------------------------------------------------
# 1.  Raw file header parser  (identical to other scripts)
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
# 2.  Load two signals from the raw file  (identical to other scripts)
# ---------------------------------------------------------------------------

def load_signal(filepath, sig_name, downsample=1, t_start=None, t_end=None):
    """Load one signal column from an ngspice binary raw file."""
    meta     = parse_raw_header(filepath)
    n_vars   = meta["n_vars"]
    n_points = meta["n_points"]
    offset   = meta["data_offset"]

    var_idx = next(
        (v["index"] for v in meta["variables"] if v["name"] == sig_name), None
    )
    if var_idx is None:
        avail = [v["name"] for v in meta["variables"]]
        raise ValueError(
            f"Signal '{sig_name}' not found.\nAvailable: {avail}"
        )

    mm = np.memmap(filepath, dtype=np.float64, mode="r",
                   offset=offset, shape=(n_points, n_vars))
    t = np.array(mm[:, 0])
    v = np.array(mm[:, var_idx])
    del mm

    if t_start is not None:
        i0 = np.searchsorted(t, t_start);  t, v = t[i0:], v[i0:]
    if t_end is not None:
        i1 = np.searchsorted(t, t_end);    t, v = t[:i1], v[:i1]
    if downsample > 1:
        t, v = t[::downsample], v[::downsample]
    return t, v


# ---------------------------------------------------------------------------
# 3.  Rising zero-crossing detector with sub-step interpolation
# ---------------------------------------------------------------------------

def rising_crossings(t, v, threshold=0.6):
    above    = v > threshold
    edge_idx = np.where(np.diff(above.astype(np.int8)) == 1)[0]
    t_cross  = np.empty(len(edge_idx))
    for i, k in enumerate(edge_idx):
        dv = v[k+1] - v[k]
        frac = (threshold - v[k]) / dv if dv != 0.0 else 0.5
        t_cross[i] = t[k] + frac * (t[k+1] - t[k])
    return t_cross


# ---------------------------------------------------------------------------
# 4.  Instantaneous frequency via sliding window
#
#  For each crossing t_k, measure the time for WIN_CYCLES complete cycles:
#      f_inst(t_k) = WIN_CYCLES / (t_{k + WIN_CYCLES} − t_k)
#
#  This averages over WIN_CYCLES periods → much smoother than single-period
#  estimate, while still tracking the transient faithfully.
# ---------------------------------------------------------------------------

def inst_frequency(t_cross, win=WIN_CYCLES):
    """
    Returns
    -------
    t_f   : time stamp of each frequency estimate (midpoint of window)
    f_hz  : instantaneous frequency in Hz
    """
    n   = len(t_cross)
    idx = np.arange(n - win)
    dt  = t_cross[idx + win] - t_cross[idx]
    f   = win / dt
    t_f = (t_cross[idx] + t_cross[idx + win]) / 2.0   # midpoint timestamp
    return t_f, f


# ---------------------------------------------------------------------------
# 5.  Detect lock time
#
#  Lock is declared when the frequency error stays within ±tol_ppm
#  continuously for at least LOCK_HOLD_NS nanoseconds.
# ---------------------------------------------------------------------------

def find_lock_time(t_f, f_hz, f_target, tol_ppm, hold_s):
    """
    Parameters
    ----------
    t_f      : time axis of frequency estimates (s)
    f_hz     : instantaneous frequency (Hz)
    f_target : target locked frequency (Hz)
    tol_ppm  : lock tolerance in ppm
    hold_s   : minimum hold time (s) — must stay locked for this long

    Returns
    -------
    t_lock   : lock time in seconds, or None if never locked
    """
    err_ppm = np.abs(f_hz - f_target) / f_target * 1e6
    in_band = err_ppm <= tol_ppm

    # Sliding hold: find first index where in_band stays True for hold_s
    for i in range(len(t_f)):
        if not in_band[i]:
            continue
        # Check how long it stays in band from this point
        j = i
        while j < len(t_f) and in_band[j]:
            j += 1
        if (t_f[min(j, len(t_f)-1)] - t_f[i]) >= hold_s:
            return t_f[i]

    return None   # never locked within simulation time


# ---------------------------------------------------------------------------
# 6.  Plot
# ---------------------------------------------------------------------------

def plot_lock_time(t_out, v_out, t_in, v_in,
                   t_f, f_hz, f_target, f_ref,
                   t_lock_coarse, t_lock_fine,
                   tol_ppm, fine_ppm,
                   save_path):

    err_ppm = (f_hz - f_target) / f_target * 1e6   # signed error

    with plt.style.context(["science", "no-latex"]):
        plt.rcParams.update({
            "figure.dpi" : 300,
            "axes.grid"  : True,
            "grid.alpha" : 0.3,
        })

        fig, axes = plt.subplots(3, 1, figsize=(5.5, 6.5),
                                 gridspec_kw={"height_ratios": [2, 2, 1]})
        ax_freq, ax_err, ax_wave = axes

        t_us   = t_f   * 1e6    # convert to µs for display
        t_end  = t_f[-1] * 1e6

        # ── Panel 1: Instantaneous frequency ──────────────────────────────
        ax_freq.plot(t_us, f_hz / 1e9,
                     color=C_OUT, linewidth=0.8, zorder=4, label="$f_{out}$")
        ax_freq.axhline(f_target / 1e9, color=C_LOCK,
                        linewidth=0.8, linestyle="--",
                        alpha=0.7, label=f"Target {f_target/1e9:.4f} GHz")

        # Tolerance band on frequency panel (in GHz)
        band_hz = f_target * tol_ppm / 1e6
        ax_freq.axhspan((f_target - band_hz) / 1e9,
                        (f_target + band_hz) / 1e9,
                        color=C_BAND, alpha=0.12, zorder=2)

        ax_freq.set_ylabel("$f_{out}$ (GHz)", color=C_OUT, fontsize=8)
        ax_freq.tick_params(axis="y", colors=C_OUT, labelsize=7)
        ax_freq.spines["left"].set_color(C_OUT)
        ax_freq.tick_params(axis="x", labelbottom=False)
        ax_freq.legend(fontsize=6, loc="upper right",
                       framealpha=0.85, edgecolor="none")

        # ── Panel 2: Frequency error (ppm) ────────────────────────────────
        ax_err.plot(t_us, err_ppm,
                    color=C_ERR, linewidth=0.8, zorder=4)
        ax_err.axhline(0, color="gray", linewidth=0.5, alpha=0.5)

        # Coarse tolerance band
        ax_err.axhspan(-tol_ppm, +tol_ppm,
                       color=C_BAND, alpha=0.15, zorder=2,
                       label=f"±{tol_ppm} ppm band")
        # Fine tolerance band
        ax_err.axhspan(-fine_ppm, +fine_ppm,
                       color=C_FINE, alpha=0.20, zorder=3,
                       label=f"±{fine_ppm} ppm band")

        ax_err.set_ylabel("Freq error (ppm)", color=C_ERR, fontsize=8)
        ax_err.tick_params(axis="y", colors=C_ERR, labelsize=7)
        ax_err.spines["left"].set_color(C_ERR)
        ax_err.tick_params(axis="x", labelbottom=False)
        ax_err.legend(fontsize=6, loc="upper right",
                      framealpha=0.85, edgecolor="none")

        # ── Lock time vertical markers (both panels) ───────────────────────
        for ax in [ax_freq, ax_err]:
            if t_lock_coarse is not None:
                ax.axvline(t_lock_coarse * 1e6, color=C_BAND,
                           linewidth=1.0, linestyle=":", zorder=5)
            if t_lock_fine is not None:
                ax.axvline(t_lock_fine * 1e6, color=C_FINE,
                           linewidth=1.0, linestyle=":", zorder=5)

        # Lock time text annotation on error panel
        y_top = ax_err.get_ylim()[1]
        if t_lock_coarse is not None:
            ax_err.text(t_lock_coarse * 1e6 + t_end * 0.01, y_top * 0.88,
                        f"Coarse lock\n{t_lock_coarse*1e6:.2f} µs",
                        color=C_BAND, fontsize=6, va="top")
        if t_lock_fine is not None:
            ax_err.text(t_lock_fine * 1e6 + t_end * 0.01, y_top * 0.65,
                        f"Fine lock\n{t_lock_fine*1e6:.2f} µs",
                        color=C_FINE, fontsize=6, va="top")

        # ── Panel 3: Waveform overlay (first 5 µs for clarity) ────────────
        t_wave_end = min(5e-6, t_out[-1])
        m_out = t_out <= t_wave_end
        m_in  = t_in  <= t_wave_end

        ax_wave.plot(t_out[m_out] * 1e6, v_out[m_out],
                     color=C_OUT, linewidth=0.7, label="clk_out")
        ax_wave.plot(t_in[m_in]  * 1e6, v_in[m_in],
                     color=C_IN,  linewidth=0.7, label="clk_in",
                     alpha=0.75)
        ax_wave.set_ylabel("Voltage (V)", fontsize=8)
        ax_wave.set_xlabel("Time (µs)", fontsize=8)
        ax_wave.tick_params(labelsize=7)
        ax_wave.legend(fontsize=6, loc="upper right",
                       framealpha=0.85, edgecolor="none")
        ax_wave.set_xlim(0, t_wave_end * 1e6)

        # ── Shared x-label for top two panels ─────────────────────────────
        ax_err.set_xlabel("Time (µs)", fontsize=8)

        # ── Overall title ──────────────────────────────────────────────────
        t_lk = t_lock_fine if t_lock_fine is not None else t_lock_coarse
        title = (f"PLL Lock Time  —  $f_{{ref}}$ = {f_ref/1e6:.1f} MHz  "
                 f"→  $f_{{out}}$ = {f_target/1e9:.4f} GHz")
        fig.suptitle(title, fontsize=8, y=1.01)

        fig.tight_layout(pad=0.5)
        fmt = "pdf" if save_path.endswith(".pdf") else "png"
        fig.savefig(save_path, dpi=600, bbox_inches="tight", format=fmt)
        print(f"  Saved: {save_path}")


# ---------------------------------------------------------------------------
# 7.  Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description="Measure PLL lock time from clk_in and clk_out."
    )
    parser.add_argument("raw_file",    nargs="?",
                        help="Path to .raw file")
    parser.add_argument("--tol",       type=float, default=LOCK_PPM_TOL,
                        help=f"Coarse lock tolerance in ppm (default: {LOCK_PPM_TOL})")
    parser.add_argument("--fine_tol",  type=float, default=FINE_PPM_TOL,
                        help=f"Fine lock tolerance in ppm (default: {FINE_PPM_TOL})")
    parser.add_argument("--hold",      type=float, default=LOCK_HOLD_NS,
                        help=f"Hold time to confirm lock in ns (default: {LOCK_HOLD_NS})")
    parser.add_argument("--win",       type=int,   default=WIN_CYCLES,
                        help=f"Sliding window cycles for freq estimate (default: {WIN_CYCLES})")
    parser.add_argument("--clk_out",   type=str,   default="v(clk_out)",
                        help="Signal name for output clock (default: v(clk_out))")
    parser.add_argument("--clk_in",    type=str,   default="v(clk_in)",
                        help="Signal name for input/reference clock (default: v(clk_in))")
    args = parser.parse_args()

    script_dir = os.path.dirname(os.path.abspath(__file__))
    raw_path   = (os.path.abspath(args.raw_file) if args.raw_file else
                  os.path.abspath(os.path.join(script_dir,
                                               "../simulations/pll_sim_100u.raw")))

    if not os.path.isfile(raw_path):
        print(f"Error: '{raw_path}' not found.");  sys.exit(1)

    print(f"Raw file : {raw_path}  ({os.path.getsize(raw_path)/1024**2:.0f} MB)")

    # ── Load both clocks from t=0 (no settling skip — we need the transient) ──
    print(f"Loading {args.clk_out} ...")
    t_out, v_out = load_signal(raw_path, args.clk_out, downsample=2)
    print(f"  {len(t_out):,} points  span={(t_out[-1])*1e6:.1f} µs")

    print(f"Loading {args.clk_in} ...")
    t_in, v_in = load_signal(raw_path, args.clk_in, downsample=2)
    print(f"  {len(t_in):,} points  span={(t_in[-1])*1e6:.1f} µs")

    # ── Zero-crossings ────────────────────────────────────────────────────────
    print("  Finding zero-crossings ...")
    xc_out = rising_crossings(t_out, v_out, threshold=0.6)
    xc_in  = rising_crossings(t_in,  v_in,  threshold=0.6)
    print(f"  clk_out: {len(xc_out):,} crossings")
    print(f"  clk_in : {len(xc_in):,}  crossings")

    if len(xc_out) < 64:
        print("Error: too few clk_out crossings.");  sys.exit(1)
    if len(xc_in)  < 4:
        print("Error: too few clk_in crossings — check signal name.");  sys.exit(1)

    # ── Reference frequency from clk_in (stable mean of all periods) ─────────
    f_ref = 1.0 / np.mean(np.diff(xc_in))
    print(f"\n  Reference clock  f_ref  = {f_ref/1e6:.4f} MHz")

    # ── Target output frequency: mean of SETTLED region (last 20%) ───────────
    settle_idx = int(len(xc_out) * 0.80)
    f_settled  = np.mean(WIN_CYCLES / np.diff(
        xc_out[settle_idx : settle_idx + WIN_CYCLES + 1]
    ))
    # Use a sliding-window average over the last 20% for robustness
    t_settled_cross = xc_out[settle_idx:]
    _, f_settled_arr = inst_frequency(t_settled_cross, win=min(WIN_CYCLES, len(t_settled_cross)//2))
    f_target = np.median(f_settled_arr)

    N_divider = round(f_target / f_ref)
    print(f"  Target output    f_out  = {f_target/1e9:.6f} GHz")
    print(f"  Division ratio   N      = {N_divider}  "
          f"(f_ref × {N_divider} = {f_ref*N_divider/1e9:.6f} GHz)")

    # ── Instantaneous frequency of clk_out (full transient) ──────────────────
    print(f"  Computing instantaneous frequency (window = {args.win} cycles) ...")
    t_f, f_hz = inst_frequency(xc_out, win=args.win)

    # ── Find lock times ───────────────────────────────────────────────────────
    hold_s = args.hold * 1e-9
    t_lock_coarse = find_lock_time(t_f, f_hz, f_target, args.tol,      hold_s)
    t_lock_fine   = find_lock_time(t_f, f_hz, f_target, args.fine_tol, hold_s)

    print(f"\n  ┌──────────────────────────────────────────────────────┐")
    print(f"  │  f_ref                : {f_ref/1e6:.4f} MHz                  │")
    print(f"  │  f_target (settled)   : {f_target/1e9:.6f} GHz            │")
    print(f"  │  Division ratio N     : {N_divider}                          │")
    if t_lock_coarse is not None:
        print(f"  │  Coarse lock (±{args.tol:.0f} ppm) : {t_lock_coarse*1e6:.3f} µs               │")
    else:
        print(f"  │  Coarse lock (±{args.tol:.0f} ppm) : NOT achieved in sim time    │")
    if t_lock_fine is not None:
        print(f"  │  Fine   lock (±{args.fine_tol:.0f} ppm)  : {t_lock_fine*1e6:.3f} µs               │")
    else:
        print(f"  │  Fine   lock (±{args.fine_tol:.0f} ppm)  : NOT achieved in sim time    │")
    print(f"  └──────────────────────────────────────────────────────┘")

    # ── Plot ──────────────────────────────────────────────────────────────────
    base = os.path.join(script_dir, "lock_time")
    print("\n  Plotting ...")
    plot_lock_time(
        t_out, v_out, t_in, v_in,
        t_f, f_hz, f_target, f_ref,
        t_lock_coarse, t_lock_fine,
        args.tol, args.fine_tol,
        base + ".pdf"
    )
    plot_lock_time(
        t_out, v_out, t_in, v_in,
        t_f, f_hz, f_target, f_ref,
        t_lock_coarse, t_lock_fine,
        args.tol, args.fine_tol,
        base + ".png"
    )


if __name__ == "__main__":
    main()