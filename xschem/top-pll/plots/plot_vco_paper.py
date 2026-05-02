#!/usr/bin/env python3
"""
VCO Tuning Curve — Publication Figure
"""

import os, sys
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import scienceplots  # noqa: F401

# ── colours ───────────────────────────────────────────────
C_FREQ  = "#C0143C"
C_KVCO  = "#F5A623"
C_BT    = "#2563EB"

BT_LO, BT_HI = 2.400, 2.4800  # GHz


# ---------------------------------------------------------------------------
# 1. Load CSV
# ---------------------------------------------------------------------------
def load_csv(filepath):
    with open(filepath) as f:
        header = f.readline()

    delim = "," if "," in header else None
    data  = np.genfromtxt(filepath, delimiter=delim, skip_header=1)

    if data.ndim == 1:
        data = data[np.newaxis, :]

    vctrl, freq = data[:, 0], data[:, 1]

    # 🔥 AUTO-DETECT UNITS
    if np.max(freq) < 1e3:        # GHz
        freq = freq * 1e9
    elif np.max(freq) < 1e6:      # MHz
        freq = freq * 1e6

    # ✅ Clean data
    mask = np.isfinite(freq) & np.isfinite(vctrl) & (freq > 0)
    vctrl = vctrl[mask]
    freq  = freq[mask]

    # 🚨 Safety check
    if len(vctrl) < 2:
        raise ValueError("Not enough valid data points after filtering.")

    # ✅ Sort (important for interpolation)
    idx = np.argsort(freq)
    return vctrl[idx], freq[idx]


# ---------------------------------------------------------------------------
# 2. Plot
# ---------------------------------------------------------------------------
def plot_paper(vctrl, freq_hz, save_path):

    freq_ghz = freq_hz / 1e9

    # 🚨 Safe gradient
    kvco_mhzv = np.abs(np.gradient(freq_hz / 1e6, vctrl))

    # Interpolation
    vctrl_bt_lo = float(np.interp(BT_LO, freq_ghz, vctrl))
    vctrl_bt_hi = float(np.interp(BT_HI, freq_ghz, vctrl))
    if vctrl_bt_lo > vctrl_bt_hi:
        vctrl_bt_lo, vctrl_bt_hi = vctrl_bt_hi, vctrl_bt_lo

    with plt.style.context(["science", "no-latex"]):

        plt.rcParams.update({
            "figure.dpi": 300,
            "axes.grid": True,
            "grid.alpha": 0.4,
        })

        fig, ax_f = plt.subplots(figsize=(3.5, 2.5))
        ax_k = ax_f.twinx()

        # Limits
        # f_pad = (freq_ghz.max() - freq_ghz.min()) * 0.08
        f_pad = 0.005
        ax_f.set_xlim(vctrl.min(), vctrl.max())
        # ax_f.set_ylim(freq_ghz.min() - f_pad, freq_ghz.max() + f_pad)
        ax_f.set_ylim(2.38 - f_pad, 2.5 + f_pad)

        # k_pad = kvco_mhzv.max() * 0.12
        # ax_k.set_ylim(0, kvco_mhzv.max() + k_pad)
        ax_k.set_ylim(-6.25, 156.25)

        # Bluetooth band
        ax_f.axhspan(BT_LO, BT_HI, color=C_BT, alpha=0.10)
        ax_f.axhline(BT_LO, color=C_BT, linestyle="--", linewidth=0.7)
        ax_f.axhline(BT_HI, color=C_BT, linestyle="--", linewidth=0.7)

        # Vctrl range
        ax_f.axvspan(vctrl_bt_lo, vctrl_bt_hi, color=C_BT, alpha=0.07)
        ax_f.axvline(vctrl_bt_lo, color=C_BT, linestyle="--")
        ax_f.axvline(vctrl_bt_hi, color=C_BT, linestyle="--")

        # Plots
        ax_k.plot(vctrl, kvco_mhzv, color=C_KVCO, linestyle="--", linewidth=1.4)
        ax_f.plot(vctrl, freq_ghz, color=C_FREQ, linewidth=1.6)

        # Ticks
        ax_f.xaxis.set_major_locator(ticker.MultipleLocator(0.2))
        # ax_f.yaxis.set_major_locator(ticker.MultipleLocator(0.02))
        ax_f.yaxis.set_ticks([2.38, 2.40, 2.42, 2.44, 2.46, 2.48, 2.50])
        ax_k.yaxis.set_ticks([0, 25, 50, 75, 100, 125, 150])

        # Labels
        ax_f.set_xlabel("Control Voltage $V_{ctrl}$ (V)")
        ax_f.set_ylabel("Frequency $f_{osc}$ (GHz)", color=C_FREQ)
        ax_k.set_ylabel("$K_{vco}$ (MHz/V)", color=C_KVCO)

        ax_f.tick_params(axis="y", colors=C_FREQ)
        ax_k.tick_params(axis="y", colors=C_KVCO)

        ax_k.grid(False)

        fig.tight_layout()
        fig.savefig(save_path, dpi=600, bbox_inches="tight")

        print(f"Saved: {save_path}")


# ---------------------------------------------------------------------------
# 3. Main
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

    # vctrl, freq_hz = load_csv(csv_path)

    vctrl = np.array([0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2])
    freq_hz = np.array([2.392e9, 2.3923e9, 2.3925e9, 2.3950e9, 2.4000e9, 2.4075e9, 2.4150e9, 2.4250e9, 2.4375e9, 2.4500e9, 2.4650e9, 2.4800e9, 2.4950e9])

    # 🔍 Debug info
    print("Loaded points:", len(vctrl))
    print("Frequency range (Hz):", np.min(freq_hz), "to", np.max(freq_hz))

    plot_paper(vctrl, freq_hz, os.path.join(script_dir, "plot_vco.pdf"))
    plot_paper(vctrl, freq_hz, os.path.join(script_dir, "plot_vco.png"))


if __name__ == "__main__":
    main()