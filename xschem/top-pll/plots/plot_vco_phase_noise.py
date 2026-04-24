#!/usr/bin/env python3
"""
VCO Phase Noise Plot
====================
Computes SSB phase noise L(f) [dBc/Hz] from the LC-VCO simulation.

Supports two raw file types automatically:
  FFT raw   (LC_VCO_fft.raw / LC_VCO_standalone_fft.raw)
            Variables: frequency, power_out_db, vout
            Method: direct FFT spectrum -> L(f) = P_dBc(f) - 10*log10(ENBW_blackman)

  Transient raw  (LC_VCO_tb.raw / LC_VCO_standalone_tran.raw)
            Variables: time, v(out) / v(outp)
            Method: zero-crossing period-jitter Welch PSD

Usage
-----
  python3 plot_vco_phase_noise.py
  python3 plot_vco_phase_noise.py /path/to/LC_VCO_fft.raw
  python3 plot_vco_phase_noise.py /path/to/LC_VCO_standalone_tran.raw
"""

import os, sys, argparse
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
from scipy.signal import welch

try:
    import scienceplots          # noqa: F401
    HAS_SCIENCE = True
except ImportError:
    HAS_SCIENCE = False

# ── Colours ───────────────────────────────────────────────────────────────────
C_LINE  = "#1A6FBF"
C_SPEC  = "#E87722"

# ── Default parameters ────────────────────────────────────────────────────────
T_SETTLE  = 100e-9
THRESHOLD = 0.6
N_SEGS    = 8

# Blackman window noise equivalent bandwidth factor
ENBW_BLACKMAN = 1.7269

# ── Spec targets ──────────────────────────────────────────────────────────────
SPECS = [
    (1e6,  -100, "-100 dBc/Hz @ 1 MHz"),
    (10e6, -120, "-120 dBc/Hz @ 10 MHz"),
]


# =============================================================================
# Raw file utilities
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


def list_signals(filepath):
    return [v["name"] for v in parse_raw_header(filepath)["variables"]]


def detect_file_type(filepath):
    """Return 'fft' if first variable is 'frequency', else 'transient'."""
    signals = list_signals(filepath)
    return "fft" if signals and signals[0] == "frequency" else "transient"


# =============================================================================
# FFT raw file loader  (complex binary: each variable = 2 doubles real+imag)
# =============================================================================
def load_fft_signals(filepath):
    """
    ngspice stores FFT/AC results as complex doubles.
    Each variable occupies 2 doubles (real, imag) per frequency point.
    Returns: freq (Hz), pdb (dB of voltage magnitude), vout_complex
    """
    meta     = parse_raw_header(filepath)
    n_vars   = meta["n_vars"]
    n_points = meta["n_points"]
    offset   = meta["data_offset"]
    names    = [v["name"] for v in meta["variables"]]

    # Read as complex layout: n_vars * 2 doubles per row
    mm = np.memmap(filepath, dtype=np.float64, mode="r",
                   offset=offset, shape=(n_points, n_vars * 2))

    freq = mm[:, 0].copy()   # frequency axis (real part, col 0)

    # Locate power_out_db and vout columns  (exact match to avoid
    # matching "max_power_out_db" when searching for "power_out_db")
    # Variable i occupies columns [i*2, i*2+1]
    pdb_col  = next((i for i, n in enumerate(names) if n == "power_out_db"), 2)
    vout_col = next((i for i, n in enumerate(names) if n == "vout"), n_vars - 1)

    pdb          = mm[:, pdb_col  * 2].copy()       # real part
    vout_complex = (mm[:, vout_col * 2].copy() +
                    1j * mm[:, vout_col * 2 + 1].copy())
    del mm

    return freq, pdb, vout_complex, names


# =============================================================================
# Transient raw file loader
# =============================================================================
def load_transient_signal(filepath, sig_name, t_start=None):
    meta     = parse_raw_header(filepath)
    n_vars   = meta["n_vars"]
    n_points = meta["n_points"]
    offset   = meta["data_offset"]
    var_idx  = next(
        (v["index"] for v in meta["variables"] if v["name"] == sig_name), None)
    if var_idx is None:
        avail = [v["name"] for v in meta["variables"]]
        raise ValueError(f"'{sig_name}' not found. Available: {avail}")
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
# Method A: FFT raw -> phase noise
# =============================================================================
def fft_raw_to_phase_noise(freq, pdb, carrier_search=(2e9, 3e9)):
    """
    Convert FFT spectrum (power_out_db = 20*log10|V_fft|) to SSB phase noise.

    L(fm) [dBc/Hz] = pdb(f0+fm) - pdb(f0) - 10*log10(ENBW_blackman * df)

    Parameters
    ----------
    freq  : frequency array (Hz)
    pdb   : 20*log10(|V_fft|) array (dB)
    carrier_search : (f_lo, f_hi) Hz — window to search for carrier

    Returns
    -------
    f_off  : offset frequency from carrier (Hz), positive only
    L_dBc  : SSB phase noise (dBc/Hz)
    f0     : carrier frequency (Hz)
    pdb_f0 : carrier power (dB)
    """
    df = float(freq[1] - freq[0])
    enbw = ENBW_BLACKMAN * df   # noise equivalent bandwidth (Hz)

    # Find carrier in search window
    mask_carrier = (freq >= carrier_search[0]) & (freq <= carrier_search[1])
    if not np.any(mask_carrier):
        raise ValueError(f"No bins in carrier search range {carrier_search}")
    idx_f0_local = np.argmax(pdb[mask_carrier])
    idx_f0       = np.where(mask_carrier)[0][idx_f0_local]
    f0           = freq[idx_f0]
    pdb_f0       = pdb[idx_f0]

    # One-sided (positive offset) spectrum
    f_pos  = freq[idx_f0:]
    p_pos  = pdb[idx_f0:]
    f_off  = f_pos - f0

    # Exclude carrier bin (offset = 0) and DC
    valid  = f_off > 0
    f_off  = f_off[valid]
    p_off  = p_pos[valid]

    # L(f) [dBc/Hz]
    L_dBc = p_off - pdb_f0 - 10.0 * np.log10(max(enbw, 1.0))

    return f_off, L_dBc, f0, pdb_f0


# =============================================================================
# Method B: transient -> phase noise  (zero-crossing Welch PSD)
# =============================================================================
def find_rising_crossings(t, v, threshold=THRESHOLD):
    above    = v > threshold
    edge_idx = np.where(np.diff(above.astype(np.int8)) == 1)[0]
    dv       = v[edge_idx + 1] - v[edge_idx]
    frac     = np.where(dv != 0.0, (threshold - v[edge_idx]) / dv, 0.5)
    return t[edge_idx] + frac * (t[edge_idx + 1] - t[edge_idx])


def transient_to_phase_noise(t_cross, n_segs=N_SEGS):
    periods = np.diff(t_cross)
    T0      = np.mean(periods)
    f0      = 1.0 / T0
    dT      = periods - T0
    nperseg = max(64, len(dT) // n_segs)
    f_psd, S_dT = welch(dT, fs=f0, nperseg=nperseg,
                        window="hann", scaling="density",
                        noverlap=nperseg // 2)
    valid  = f_psd > 0
    f_off  = f_psd[valid]
    L_dBc  = 10.0 * np.log10(
        np.maximum((f0 ** 4) * S_dT[valid] / (2.0 * f_off ** 2), 1e-300))
    return f_off, L_dBc, f0, periods


# =============================================================================
# Plot
# =============================================================================
def plot_vco_phase_noise(f_off, L_dBc, f0, vctrl_v, jitter_rms_ps,
                         n_cycles, method_label, save_path, specs=SPECS):
    style = ["science", "no-latex"] if HAS_SCIENCE else []
    with plt.style.context(style):
        plt.rcParams.update({"figure.dpi": 300, "axes.grid": True,
                             "grid.alpha": 0.35})
        fig, ax = plt.subplots(figsize=(6, 4))

        y_lo = min(np.percentile(L_dBc, 3) - 10, -180)
        y_hi = max(np.percentile(L_dBc, 97) + 20, -20)
        ax.set_ylim(y_lo, y_hi)
        ax.set_xlim(f_off.min(), f_off.max())

        ax.semilogx(f_off, L_dBc, color=C_LINE, linewidth=1.6, zorder=4,
                    label=f"VCO  $f_0$ = {f0/1e9:.4f} GHz")

        # Spec lines
        for f_s, L_s, _ in specs:
            if not (f_off.min() <= f_s <= f_off.max()):
                continue
            idx    = np.argmin(np.abs(f_off - f_s))
            L_meas = L_dBc[idx]
            passed = L_meas <= L_s
            ax.axvline(f_s, color=C_SPEC, linewidth=0.8,
                       linestyle="--", zorder=2, alpha=0.8)
            ax.axhline(L_s, color=C_SPEC, linewidth=0.8,
                       linestyle="--", zorder=2, alpha=0.8)
            ax.plot(f_s, L_meas, "o", color=C_LINE, markersize=5, zorder=6)
            ax.annotate(
                f"{L_meas:.1f} dBc/Hz\n(spec {L_s})  "
                + ("PASS" if passed else "FAIL"),
                xy=(f_s, L_meas),
                xytext=(f_s * 3, L_meas + (y_hi - y_lo) * 0.07),
                fontsize=7.5,
                color="darkgreen" if passed else "#CC0000",
                arrowprops=dict(arrowstyle="-|>", color=C_SPEC, lw=0.8))

        # Info box
        vctrl_str = f"{vctrl_v:.3f} V" if not np.isnan(vctrl_v) else "N/A"
        info = (
            f"$f_0$        = {f0/1e9:.4f} GHz\n"
            f"$V_{{CTRL}}$   = {vctrl_str}\n"
            f"Jitter RMS = {jitter_rms_ps:.2f} ps\n"
            f"Cycles     = {n_cycles:,}\n"
            f"Method     : {method_label}"
        )
        ax.text(0.97, 0.97, info, transform=ax.transAxes,
                ha="right", va="top", fontsize=7.5, family="monospace",
                bbox=dict(boxstyle="round,pad=0.4", fc="white",
                          ec="#aaaaaa", alpha=0.95, lw=0.8))

        ax.set_xlabel("Frequency Offset (Hz)", fontsize=10)
        ax.set_ylabel(r"$\mathcal{L}(f)$  (dBc/Hz)",
                      fontsize=10, color=C_LINE)
        ax.tick_params(axis="y", colors=C_LINE, which="both")
        ax.spines["left"].set_color(C_LINE)
        ax.xaxis.set_major_formatter(ticker.EngFormatter())
        ax.xaxis.set_major_locator(ticker.LogLocator(base=10, numticks=8))
        ax.legend(fontsize=8.5, loc="lower left", framealpha=0.9)
        vctrl_title = f"{vctrl_v:.2f} V" if not np.isnan(vctrl_v) else "N/A"
        ax.set_title(
            f"LC-VCO Phase Noise  |  $f_0$ = {f0/1e9:.4f} GHz"
            f"  |  $V_{{CTRL}}$ = {vctrl_title}",
            fontsize=10, pad=8)

        fig.tight_layout(pad=0.5)
        fmt = "pdf" if save_path.endswith(".pdf") else "png"
        fig.savefig(save_path, dpi=600, bbox_inches="tight", format=fmt)
        print(f"  Saved: {save_path}")
        plt.close(fig)


# =============================================================================
# Main
# =============================================================================
def main():
    parser = argparse.ArgumentParser(
        description="LC-VCO phase noise from ngspice .raw file (FFT or transient)")
    parser.add_argument("raw_file", nargs="?",
        help="Path to FFT or transient .raw file (auto-detected)")
    parser.add_argument("--threshold", type=float, default=THRESHOLD,
        help=f"Zero-crossing threshold V — transient only [default {THRESHOLD}]")
    parser.add_argument("--tsettle",   type=float, default=T_SETTLE,
        help=f"Skip settling time s — transient only [default {T_SETTLE:.0e}]")
    parser.add_argument("--nsegs",     type=int,   default=N_SEGS,
        help=f"Welch segments — transient only [default {N_SEGS}]")
    args = parser.parse_args()

    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Default path: prefer FFT raw, fall back to transient
    candidates = [
        "../simulations/LC_VCO_fft.raw",
        "../simulations/LC_VCO_standalone_fft.raw",
        "../simulations/LC_VCO_standalone_tran.raw",
        "../simulations/LC_VCO_tb.raw",
    ]
    raw_path = (os.path.abspath(args.raw_file) if args.raw_file else
                next((os.path.abspath(os.path.join(script_dir, c))
                      for c in candidates
                      if os.path.isfile(os.path.join(script_dir, c))),
                     os.path.abspath(os.path.join(script_dir, candidates[0]))))

    if not os.path.isfile(raw_path):
        print(f"Error: '{raw_path}' not found.")
        sys.exit(1)

    ftype = detect_file_type(raw_path)
    print(f"\nRaw file : {raw_path}  ({os.path.getsize(raw_path)/1024**2:.1f} MB)")
    print(f"Type     : {ftype.upper()} raw")
    print(f"Signals  : {list_signals(raw_path)}")

    # ── FFT path ─────────────────────────────────────────────────────────────
    if ftype == "fft":
        print("\nLoading FFT spectrum ...")
        freq, pdb, vout_c, names = load_fft_signals(raw_path)
        df = freq[1] - freq[0]
        print(f"  {len(freq):,} bins  |  df = {df/1e3:.1f} kHz"
              f"  |  span = {freq.max()/1e9:.1f} GHz")
        print(f"  pdb range: {pdb.min():.1f} to {pdb.max():.1f} dB")

        print("Computing phase noise from FFT spectrum ...")
        f_off, L_dBc, f0, pdb_f0 = fft_raw_to_phase_noise(freq, pdb)

        # Estimate jitter RMS from phase noise integral (rough)
        # sigma_phi = sqrt(2 * integral L(f) df)  [rad]
        # sigma_t   = sigma_phi / (2*pi*f0)        [s]
        L_lin   = 10.0 ** (L_dBc / 10.0)
        sigma_t = np.sqrt(2.0 * np.trapezoid(L_lin, f_off)) / (2.0 * np.pi * f0)
        jitter_rms_ps = sigma_t * 1e12
        n_cycles      = int(f0 / df)
        method_label  = "FFT spectrum"

        # Try to read VCTRL from companion transient file in the same directory
        sim_dir = os.path.dirname(raw_path)
        tran_candidates = [
            os.path.join(sim_dir, "LC_VCO_standalone_tran.raw"),
            os.path.join(sim_dir, "LC_VCO_tb.raw"),
            os.path.join(sim_dir, "tb_VCO.raw"),
        ]
        vctrl_v = None
        for tran_path in tran_candidates:
            if not os.path.isfile(tran_path):
                continue
            try:
                tran_sigs = list_signals(tran_path)
                if "v(vctrl)" in tran_sigs:
                    _, vc = load_transient_signal(
                        tran_path, "v(vctrl)", t_start=T_SETTLE)
                    vctrl_v = float(np.mean(vc))
                    print(f"  VCTRL    = {vctrl_v:.4f} V"
                          f"  (from {os.path.basename(tran_path)})")
                    break
            except Exception:
                continue
        if vctrl_v is None:
            vctrl_v = float("nan")
            print("  VCTRL    = N/A (no companion transient file found)")

        print(f"  Carrier f0   : {f0/1e9:.6f} GHz  ({pdb_f0:.2f} dB)")
        print(f"  Bin width df : {df/1e3:.2f} kHz")
        print(f"  ENBW         : {ENBW_BLACKMAN * df / 1e3:.2f} kHz (Blackman)")
        print(f"  Jitter RMS   : {jitter_rms_ps:.3f} ps (integrated estimate)")

    # ── Transient path ────────────────────────────────────────────────────────
    else:
        signals = list_signals(raw_path)
        candidates_sig = ["v(out)", "v(outp)", "v(outn)"]
        sig_name = next(
            (s for s in candidates_sig if s in signals),
            next((s for s in signals if s.startswith("v(") and "ctrl" not in s), signals[1]))
        print(f"\nUsing signal : {sig_name}")
        print(f"Loading (skip first {args.tsettle*1e9:.0f} ns) ...")
        t, v = load_transient_signal(raw_path, sig_name, t_start=args.tsettle)
        print(f"  {len(t):,} points  |  v range: {v.min():.3f}-{v.max():.3f} V")

        thr_ok = v.min() < args.threshold < v.max()
        if not thr_ok:
            print(f"  WARNING: threshold {args.threshold} V outside signal range!"
                  f"  Try --threshold {(v.min()+v.max())/2:.2f}")

        vctrl_v = 0.6
        try:
            _, vc = load_transient_signal(raw_path, "v(vctrl)", t_start=args.tsettle)
            vctrl_v = float(np.mean(vc))
        except ValueError:
            pass

        print("Detecting rising edges ...")
        t_cross = find_rising_crossings(t, v, threshold=args.threshold)
        print(f"  {len(t_cross):,} crossings found")
        if len(t_cross) < 64:
            print("ERROR: too few crossings.")
            sys.exit(1)

        print(f"Computing phase noise (Welch, {args.nsegs} segments) ...")
        f_off, L_dBc, f0, periods = transient_to_phase_noise(
            t_cross, n_segs=args.nsegs)
        jitter_rms_ps = np.std(periods) * 1e12
        n_cycles      = len(periods)
        method_label  = "Welch PSD (jitter)"

    # ── Console report ────────────────────────────────────────────────────────
    print(f"\n  Carrier f0     : {f0/1e9:.6f} GHz")
    print(f"  Offset range   : {f_off.min()/1e3:.1f} kHz - {f_off.max()/1e6:.1f} MHz")
    print()
    for f_s, L_s, _ in SPECS:
        if not (f_off.min() <= f_s <= f_off.max()):
            print(f"  L({f_s/1e6:.0f} MHz) : out of range — extend simulation")
            continue
        idx  = np.argmin(np.abs(f_off - f_s))
        flag = "PASS" if L_dBc[idx] <= L_s else "FAIL"
        print(f"  L({f_s/1e6:.0f} MHz) = {L_dBc[idx]:.1f} dBc/Hz"
              f"  (spec {L_s} dBc/Hz)  [{flag}]")

    # ── Save plots ────────────────────────────────────────────────────────────
    base = os.path.join(script_dir, "vco_phase_noise")
    print()
    for ext in (".png", ".pdf"):
        plot_vco_phase_noise(f_off, L_dBc, f0, vctrl_v, jitter_rms_ps,
                             n_cycles, method_label, base + ext)


if __name__ == "__main__":
    main()
