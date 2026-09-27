#!/usr/bin/env python3
"""
Steady-state phase noise and reference-spur read-out of the closed-loop PLL transient.

The delta-sigma divider alternates between two ratios every other reference period, which puts
deterministic tones at multiples of f_REF/2 (5, 10, 15 ... MHz) on the output phase. This script
  1. takes the rising-edge times of v(clk_out) inside a quiet steady-state window (no acquisition,
     no disturbance of the modulator sequence),
  2. converts them to output phase and estimates L(f) with Welch's method,
  3. removes the tones at multiples of f_REF/2 from L(f) (linear interpolation in dB across each tone)
     and reads L(1 MHz) and L(10 MHz) from the tone-free curve,
  4. measures the size of each tone as a phase sideband in dBc, coherently, in a single DFT bin.

Usage
  python3 plot_pll_steady_state.py /path/to/tb_LC_VCO_FPLL_100u.raw [out_dir]

Outputs pll_steady_state_pn_spur.png / .pdf. The single-curve figure in the phase_noise.png style comes from
plot_phase_noise.py --remove-tones. Windows: see WINDOWS (the second one ends after the disturbance at 76.6 us starts; both should be free of the
25.5 us modulator disturbance).
"""
import os
import re
import sys

import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from scipy.signal import welch

F_REF = 10e6
WINDOWS = ((30e-6, 50e-6), (60e-6, 76e-6))     # steady-state windows [s]; the disturbance at 76.6 us must stay outside
COLORS = ("#C0143C", "#1F5FA8")
SEG = 5e-6                                     # Welch segment length [s]
TONE_HALF_WIDTH = 0.6e6                        # half width removed around each tone [Hz]
N_TONES = 40                                   # tones at k * f_REF/2, k = 1..N_TONES
THRESHOLD = 0.6                                # clk_out crossing level [V]


def read_columns(path, names):
    """Return the requested columns of an ngspice binary raw file (real data)."""
    with open(path, "rb") as fh:
        header = b""
        while True:
            line = fh.readline()
            header += line
            if line.startswith(b"Binary:"):
                break
        offset = fh.tell()
    text = header.decode()
    nv = int(re.search(r"No. Variables:\s*(\d+)", text).group(1))
    npts = int(re.search(r"No. Points:\s*(\d+)", text).group(1))
    body = text.split("\nVariables:")[1].split("Binary:")[0].strip().splitlines()
    var = [ln.split()[1].lower() for ln in body]
    mm = np.memmap(path, dtype="<f8", mode="r", offset=offset, shape=(npts, nv))
    return [np.array(mm[:, var.index(n)]) for n in names]


def rising_edges(t, v, level):
    i = np.where((v[:-1] < level) & (v[1:] >= level))[0]
    return t[i] + (level - v[i]) * (t[i + 1] - t[i]) / (v[i + 1] - v[i])


def phase_series(edges, t0, t1):
    """Output phase [rad] at every rising edge inside [t0, t1], one sample per output cycle."""
    e = edges[(edges >= t0) & (edges < t1)]
    k = np.arange(len(e))
    f0 = (len(e) - 1) / (e[-1] - e[0])
    dev = e - (e[0] + k / f0)
    dev -= np.polyval(np.polyfit(k, dev, 1), k)          # remove the frequency offset
    return 2 * np.pi * f0 * dev, f0


def remove_tones(f, l_db):
    """Replace L(f) around every tone by a straight line in dB between the two edges of the notch."""
    out = l_db.copy()
    for m in range(1, N_TONES + 1):
        ft = m * F_REF / 2
        inside = np.abs(f - ft) < TONE_HALF_WIDTH
        if not inside.any():
            continue
        lo = np.where(f <= ft - TONE_HALF_WIDTH)[0]
        hi = np.where(f >= ft + TONE_HALF_WIDTH)[0]
        if len(lo) and len(hi):
            out[inside] = np.interp(f[inside], [f[lo[-1]], f[hi[0]]], [out[lo[-1]], out[hi[0]]])
    return out


def tone_level(phase, fs, f_tone):
    """Peak phase [rad] of a tone near f_tone (Hann window, coherent gain corrected) and its dBc level."""
    w = np.hanning(len(phase))
    spec = np.abs(np.fft.rfft(phase * w)) * 2 / w.sum()
    fr = np.fft.rfftfreq(len(phase), 1 / fs)
    band = (fr > f_tone - 0.1e6) & (fr < f_tone + 0.1e6)
    theta = spec[band].max()
    return theta, 20 * np.log10(theta / 2)


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    raw = sys.argv[1]
    out_dir = sys.argv[2] if len(sys.argv) > 2 else os.path.dirname(os.path.abspath(__file__))
    t, v = read_columns(raw, ["time", "v(clk_out)"])
    edges = rising_edges(t, v, THRESHOLD)

    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 5.2), gridspec_kw={"width_ratios": [1.5, 1]})
    tones = [m * F_REF / 2 for m in range(1, 9)]
    print("window            f0 (GHz)   L(1 MHz)  L(10 MHz)  [dBc/Hz, tones removed]")
    for n_win, ((t0, t1), col) in enumerate(zip(WINDOWS, COLORS), start=1):
        phase, f0 = phase_series(edges, t0, t1)
        nper = int(SEG * f0)
        f, s = welch(phase, fs=f0, window="hann", nperseg=nper, noverlap=nper // 2, detrend="linear")
        keep = (f > 3e5) & (f < 3e8)
        f, l_db = f[keep], 10 * np.log10(s[keep] / 2)     # L(f) = S_phi / 2
        l_free = remove_tones(f, l_db)
        l1, l10 = (np.interp(x, f, l_free) for x in (1e6, 10e6))
        label = f"{t0*1e6:.0f}–{t1*1e6:.0f} µs"
        print(f"{label:16s}  {f0/1e9:.5f}   {l1:8.1f}  {l10:8.1f}")
        ax1.semilogx(f, l_db, color=col, lw=0.8, alpha=0.30)
        ax1.semilogx(f, l_free, color=col, lw=1.8, label=f"window {n_win}, tones removed")
        levels = [tone_level(phase, f0, ft) for ft in tones]
        for ft, (theta, dbc) in zip(tones, levels):
            print(f"    tone {ft/1e6:5.1f} MHz : {theta:.4f} rad  ->  {dbc:6.1f} dBc")
        ax2.stem([ft / 1e6 + (0.12 if col == COLORS[1] else -0.12) for ft in tones],
                 [d for _, d in levels], linefmt=col, markerfmt="o", basefmt=" ", bottom=-80,
                 label=f"window {n_win}")
        if t0 == WINDOWS[0][0]:
            ax1.plot([1e6, 10e6], [l1, l10], "k^", ms=6, zorder=5)
            ax1.annotate(f"{l1:.1f} dBc/Hz @ 1 MHz", (1e6, l1), textcoords="offset points", xytext=(12, 22), arrowprops={"arrowstyle": "->"})
            ax1.annotate(f"{l10:.1f} dBc/Hz @ 10 MHz\n(interpolated across the tone)", (10e6, l10), textcoords="offset points", xytext=(30, 42), arrowprops={"arrowstyle": "->"})
            d10 = levels[1][1]
            ax2.annotate(f"10 MHz reference spur\n{d10:.1f} dBc", (10, d10), textcoords="offset points",
                         xytext=(12, 8), fontsize=10, arrowprops={"arrowstyle": "->"})
    ax1.set_xlabel("Frequency offset (Hz)")
    ax1.set_ylabel("Phase noise L(f) (dBc/Hz)")
    ax1.set_title("Steady-state phase noise (thin: measured, bold: tones at k·5 MHz removed)")
    ax1.set_ylim(-160, -60)
    ax1.set_xlim(4e5, 2e8)
    ax1.grid(True, which="both", alpha=0.3)
    ax1.legend(loc="upper right")
    ax2.set_xlabel("Offset from the carrier (MHz)")
    ax2.set_ylabel("Phase sideband (dBc)")
    ax2.set_title("Tones at multiples of f_REF/2 (DSM divider pattern)")
    ax2.set_ylim(-80, 0)
    ax2.set_xticks([m * F_REF / 2e6 for m in range(1, 9)])
    ax2.grid(True, alpha=0.3)
    ax2.legend(loc="upper right")
    fig.tight_layout()
    for ext in ("png", "pdf"):
        fig.savefig(os.path.join(out_dir, f"pll_steady_state_pn_spur.{ext}"), dpi=200, bbox_inches="tight")
    print("saved", os.path.join(out_dir, "pll_steady_state_pn_spur.png"))


if __name__ == "__main__":
    main()
