#!/usr/bin/env python3
"""
VCO Tuning Curve — Publication Figure
=======================================
Dual-axis plot:  Frequency (left, crimson)  +  Kvco gain (right, orange)
with Bluetooth ISM band shaded on frequency axis and Vctrl range marked.
Rendered with SciencePlots for IEEE-quality output.

Usage
-----
  python3 plot_vco_paper.py                  # reads ../simulations/vco_tuning.csv
  python3 plot_vco_paper.py vco_tuning.csv   # explicit path
"""

import os, sys
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import scienceplots                          # noqa: F401  (registers styles)

# ── colours ──────────────────────────────────────────────────────────────────
C_FREQ  = "#C0143C"   # crimson  – frequency curve + left axis
C_KVCO  = "#F5A623"   # amber    – Kvco curve + right axis
C_BT    = "#2563EB"   # blue     – Bluetooth band

# ── Bluetooth ISM band (2.400 – 2.4835 GHz) ──────────────────────────────────
BT_LO, BT_HI = 2.400, 2.4835     # GHz


# ---------------------------------------------------------------------------
# 1.  Load CSV  (comma- or space-delimited, auto-detected)
# ---------------------------------------------------------------------------
def load_csv(filepath):
    with open(filepath) as f:
        header = f.readline()
    delim = "," if "," in header else None
    data  = np.genfromtxt(filepath, delimiter=delim, skip_header=1)
    if data.ndim == 1:
        data = data[np.newaxis, :]
    vctrl, freq = data[:, 0], data[:, 1]
    mask = np.isfinite(freq) & (freq > 1e8)
    return vctrl[mask], freq[mask]


# ---------------------------------------------------------------------------
# 2.  Plot
# ---------------------------------------------------------------------------
def plot_paper(vctrl, freq_hz, save_path):
    freq_ghz  = freq_hz / 1e9
    kvco_mhzv = np.abs(np.gradient(freq_hz / 1e6, vctrl))   # MHz/V

    # ── Interpolate Vctrl for Bluetooth band edges ────────────────────────
    vctrl_bt_lo = float(np.interp(BT_LO, freq_ghz, vctrl))
    vctrl_bt_hi = float(np.interp(BT_HI, freq_ghz, vctrl))
    if vctrl_bt_lo > vctrl_bt_hi:
        vctrl_bt_lo, vctrl_bt_hi = vctrl_bt_hi, vctrl_bt_lo

    # ── SciencePlots style ────────────────────────────────────────────────
    with plt.style.context(["science", "no-latex"]):

        # override a few params to keep coloured dual axes readable
        plt.rcParams.update({
            "figure.dpi":        300,
            "axes.grid":         True,
            "grid.alpha":        0.4,
        })

        fig, ax_f = plt.subplots(figsize=(3.5, 2.5))
        ax_k = ax_f.twinx()

        # ── axis limits ────────────────────────────────────────────────────
        f_pad = (freq_ghz.max() - freq_ghz.min()) * 0.08
        y_lo  = freq_ghz.min() - f_pad
        y_hi  = freq_ghz.max() + f_pad
        ax_f.set_xlim(vctrl.min(), vctrl.max())
        ax_f.set_ylim(y_lo, y_hi)

        k_pad = kvco_mhzv.max() * 0.12
        ax_k.set_ylim(0, kvco_mhzv.max() + k_pad)

        # ── Bluetooth horizontal frequency band ────────────────────────────
        ax_f.axhspan(BT_LO, BT_HI, color=C_BT, alpha=0.10, zorder=0)
        ax_f.axhline(BT_LO, color=C_BT, linewidth=0.7,
                     linestyle=(0, (4, 3)), zorder=1, alpha=0.8)
        ax_f.axhline(BT_HI, color=C_BT, linewidth=0.7,
                     linestyle=(0, (4, 3)), zorder=1, alpha=0.8)

        # ── Bluetooth Vctrl range: vertical markers ────────────────────────
        ax_f.axvspan(vctrl_bt_lo, vctrl_bt_hi,
                     color=C_BT, alpha=0.07, zorder=2)
        ax_f.axvline(vctrl_bt_lo, color=C_BT, linewidth=0.9,
                     linestyle="--", zorder=3, alpha=0.85)
        ax_f.axvline(vctrl_bt_hi, color=C_BT, linewidth=0.9,
                     linestyle="--", zorder=3, alpha=0.85)

        # ── Kvco curve (right axis, dashed amber) ──────────────────────────
        ax_k.plot(vctrl, kvco_mhzv, color=C_KVCO, linewidth=1.4,
                  linestyle="--", zorder=3)

        # ── frequency curve (left axis, solid crimson) ─────────────────────
        ax_f.plot(vctrl, freq_ghz, color=C_FREQ, linewidth=1.6,
                  linestyle="-", zorder=4)

        # ── ticks ──────────────────────────────────────────────────────────
        ax_f.xaxis.set_major_locator(ticker.MultipleLocator(0.2))
        ax_f.xaxis.set_minor_locator(ticker.MultipleLocator(0.1))
        ax_f.yaxis.set_major_locator(ticker.MultipleLocator(0.2))
        ax_f.yaxis.set_major_formatter(ticker.FormatStrFormatter("%.2f"))

        ax_k.yaxis.set_major_locator(
            ticker.MaxNLocator(nbins=5, steps=[1, 2, 5, 10]))
        ax_k.yaxis.set_major_formatter(ticker.FormatStrFormatter("%g"))

        # ── axis labels ────────────────────────────────────────────────────
        ax_f.set_xlabel(r"Control Voltage $V_\mathrm{ctrl}$ (V)")
        ax_f.set_ylabel(r"Frequency $f_\mathrm{osc}$ (GHz)", color=C_FREQ)
        ax_k.set_ylabel(r"$K_\mathrm{VCO}$ (MHz/V)",         color=C_KVCO)

        # ── tick / spine colours ───────────────────────────────────────────
        ax_f.tick_params(axis="y", colors=C_FREQ, which="both")
        ax_f.spines["left"].set_color(C_FREQ)
        ax_k.tick_params(axis="y", colors=C_KVCO, which="both")
        ax_k.spines["right"].set_color(C_KVCO)

        ax_k.grid(False)

        fig.tight_layout(pad=0.4)
        fig.savefig(save_path, dpi=600, bbox_inches="tight",
                    format="pdf" if save_path.endswith(".pdf") else "png")
        print(f"Saved: {save_path}")


# ---------------------------------------------------------------------------
# 3.  Main
# ---------------------------------------------------------------------------
def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))

    if len(sys.argv) > 1:
        csv_path = sys.argv[1]
    else:
        csv_path = os.path.join(script_dir, "..", "simulations", "vco_tuning.csv")

    if not os.path.isfile(csv_path):
        print(f"Error: '{csv_path}' not found.")
        sys.exit(1)

    vctrl, freq_hz = load_csv(csv_path)
    plot_paper(vctrl, freq_hz, os.path.join(script_dir, "plot_vco.pdf"))
    plot_paper(vctrl, freq_hz, os.path.join(script_dir, "plot_vco.png"))


if __name__ == "__main__":
    main()
