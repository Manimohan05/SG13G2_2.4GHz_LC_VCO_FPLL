#!/usr/bin/env python3
"""
PLL Top-Level Simulation Visualiser
====================================
Reads ngspice binary .raw files and plots key PLL signals:
  - Control voltage (VCO tuning / lock indicator)
  - Reference clock (clk_in) vs Output clock (clk_out)
  - Phase-Frequency Detector outputs (UP / DN)
  - Delta-Sigma Modulator output
  - Bias voltages

Usage:
    python3 Visualiser.py                         # default: pll_top.raw
    python3 Visualiser.py --raw other_file.raw    # custom file
    python3 Visualiser.py --save                  # save PNGs instead of showing
    python3 Visualiser.py --start 5e-6 --stop 10e-6  # zoom into time window
"""

import argparse
import os
import struct
import sys

import numpy as np
import matplotlib
import matplotlib.pyplot as plt
from matplotlib.ticker import EngFormatter

# ---------------------------------------------------------------------------
# 1. Ngspice binary raw-file parser
# ---------------------------------------------------------------------------

def parse_raw_header(filepath):
    """Read the ASCII header of an ngspice .raw file and return metadata."""
    meta = {}
    variables = []
    with open(filepath, "rb") as f:
        while True:
            line = f.readline()
            if not line:
                raise ValueError("Unexpected end of file while reading header")
            text = line.decode("ascii", errors="replace").strip()

            if text.startswith("Title:"):
                meta["title"] = text.split(":", 1)[1].strip()
            elif text.startswith("Date:"):
                meta["date"] = text.split(":", 1)[1].strip()
            elif text.startswith("Plotname:"):
                meta["plotname"] = text.split(":", 1)[1].strip()
            elif text.startswith("Flags:"):
                meta["flags"] = text.split(":", 1)[1].strip()
            elif text.startswith("No. Variables:"):
                meta["n_vars"] = int(text.split(":", 1)[1].strip())
            elif text.startswith("No. Points:"):
                meta["n_points"] = int(text.split(":", 1)[1].strip())
            elif text.startswith("Variables:"):
                for _ in range(meta["n_vars"]):
                    vline = f.readline().decode("ascii", errors="replace").strip()
                    parts = vline.split()
                    variables.append({
                        "index": int(parts[0]),
                        "name": parts[1],
                        "type": parts[2],
                    })
            elif text.startswith("Binary:") or text.startswith("Values:"):
                meta["data_format"] = "binary" if "Binary" in text else "ascii"
                meta["data_offset"] = f.tell()
                break

    meta["variables"] = variables
    return meta


def load_raw(filepath, downsample=1):
    """
    Load an ngspice binary .raw file.

    Parameters
    ----------
    filepath : str
        Path to the .raw file.
    downsample : int
        Keep every Nth sample (1 = keep all). Useful for very large files.

    Returns
    -------
    signals : dict[str, np.ndarray]
        Mapping from signal name to its data array.
    meta : dict
        Header metadata.
    """
    meta = parse_raw_header(filepath)
    n_vars = meta["n_vars"]
    n_points = meta["n_points"]
    is_complex = "complex" in meta.get("flags", "").lower()
    values_per_var = 2 if is_complex else 1

    if meta["data_format"] != "binary":
        raise NotImplementedError("Only binary raw files are supported.")

    # Each data point: n_vars * values_per_var doubles (float64)
    record_size = n_vars * values_per_var * 8  # bytes

    print(f"Loading {filepath}")
    print(f"  {n_vars} variables, {n_points:,} points, "
          f"{'complex' if is_complex else 'real'} data")
    print(f"  Data size: {record_size * n_points / 1024**2:.1f} MB")

    with open(filepath, "rb") as f:
        f.seek(meta["data_offset"])
        raw_bytes = f.read(record_size * n_points)

    # Reshape into (n_points, n_vars * values_per_var)
    data = np.frombuffer(raw_bytes, dtype=np.float64).reshape(n_points, -1)

    if downsample > 1:
        data = data[::downsample]
        print(f"  Down-sampled to {data.shape[0]:,} points (1/{downsample})")

    signals = {}
    for var in meta["variables"]:
        col = var["index"] * values_per_var
        signals[var["name"]] = data[:, col]

    return signals, meta


# ---------------------------------------------------------------------------
# 2. Plotting helpers
# ---------------------------------------------------------------------------

def setup_style():
    """Configure matplotlib for clean engineering plots."""
    plt.rcParams.update({
        "figure.facecolor": "white",
        "axes.facecolor": "#fafafa",
        "axes.grid": True,
        "grid.alpha": 0.3,
        "axes.axisbelow": True,
        "font.size": 10,
        "axes.titlesize": 12,
        "axes.labelsize": 11,
        "figure.dpi": 120,
    })


def apply_time_axis(ax, xlabel=True):
    """Add engineering-formatted time axis."""
    fmt = EngFormatter(unit="s")
    ax.xaxis.set_major_formatter(fmt)
    if xlabel:
        ax.set_xlabel("Time")


def time_slice(signals, t_start=None, t_stop=None):
    """Return index mask for a time window."""
    t = signals["time"]
    mask = np.ones(len(t), dtype=bool)
    if t_start is not None:
        mask &= t >= t_start
    if t_stop is not None:
        mask &= t <= t_stop
    return mask


# ---------------------------------------------------------------------------
# 3. Individual plot routines
# ---------------------------------------------------------------------------

def plot_control_voltage(signals, mask, save_path=None):
    """Plot VCO control voltage — the primary PLL lock indicator."""
    fig, ax = plt.subplots(figsize=(12, 4))
    t = signals["time"][mask]
    vctrl = signals["v(x2.vctrl)"][mask]

    ax.plot(t, vctrl, linewidth=0.5, color="#1f77b4")
    ax.set_ylabel("Voltage (V)")
    ax.set_title("VCO Control Voltage — v(x2.vctrl)")
    apply_time_axis(ax)
    fig.tight_layout()
    if save_path:
        fig.savefig(os.path.join(save_path, "01_control_voltage.png"))
    return fig


def plot_clocks(signals, mask, save_path=None):
    """Plot reference and output clocks."""
    fig, axes = plt.subplots(2, 1, figsize=(12, 5), sharex=True)
    t = signals["time"][mask]

    axes[0].plot(t, signals["v(clk_in)"][mask], linewidth=0.4, color="#2ca02c")
    axes[0].set_ylabel("V")
    axes[0].set_title("Reference Clock — v(clk_in)")

    axes[1].plot(t, signals["v(clk_out)"][mask], linewidth=0.4, color="#d62728")
    axes[1].set_ylabel("V")
    axes[1].set_title("Output Clock — v(clk_out)")

    apply_time_axis(axes[1])
    apply_time_axis(axes[0], xlabel=False)
    fig.tight_layout()
    if save_path:
        fig.savefig(os.path.join(save_path, "02_clocks.png"))
    return fig


def plot_pfd_outputs(signals, mask, save_path=None):
    """Plot Phase-Frequency Detector UP and DN pulses."""
    fig, axes = plt.subplots(2, 1, figsize=(12, 5), sharex=True)
    t = signals["time"][mask]

    axes[0].plot(t, signals["v(x2.up)"][mask], linewidth=0.4, color="#9467bd")
    axes[0].set_ylabel("V")
    axes[0].set_title("PFD UP Pulse — v(x2.up)")

    axes[1].plot(t, signals["v(x2.dn)"][mask], linewidth=0.4, color="#e377c2")
    axes[1].set_ylabel("V")
    axes[1].set_title("PFD DN Pulse — v(x2.dn)")

    apply_time_axis(axes[1])
    apply_time_axis(axes[0], xlabel=False)
    fig.tight_layout()
    if save_path:
        fig.savefig(os.path.join(save_path, "03_pfd_outputs.png"))
    return fig


def plot_dsm_output(signals, mask, save_path=None):
    """Plot Delta-Sigma Modulator output."""
    fig, ax = plt.subplots(figsize=(12, 4))
    t = signals["time"][mask]

    ax.plot(t, signals["v(x2.dsm_out)"][mask], linewidth=0.4, color="#ff7f0e")
    ax.set_ylabel("Voltage (V)")
    ax.set_title("Delta-Sigma Modulator Output — v(x2.dsm_out)")
    apply_time_axis(ax)
    fig.tight_layout()
    if save_path:
        fig.savefig(os.path.join(save_path, "04_dsm_output.png"))
    return fig


def extract_instantaneous_frequency(time, voltage, threshold=None):
    """
    Compute instantaneous frequency from rising-edge zero crossings.

    Parameters
    ----------
    time : np.ndarray
        Time vector.
    voltage : np.ndarray
        Voltage waveform (clock signal).
    threshold : float or None
        Crossing level.  If None, uses the midpoint between min and max.

    Returns
    -------
    t_freq : np.ndarray
        Time at the midpoint of each period.
    freq : np.ndarray
        Instantaneous frequency (Hz) for each period.
    """
    if threshold is None:
        threshold = (np.min(voltage) + np.max(voltage)) / 2.0

    # Detect rising-edge crossings: signal goes from below to above threshold
    above = voltage > threshold
    crossings = np.where(np.diff(above.astype(int)) == 1)[0]

    if len(crossings) < 2:
        return np.array([]), np.array([])

    # Linear interpolation for precise crossing times
    t_cross = np.empty(len(crossings))
    for i, idx in enumerate(crossings):
        v0, v1 = voltage[idx], voltage[idx + 1]
        t0, t1 = time[idx], time[idx + 1]
        # fraction of the interval where the crossing occurs
        frac = (threshold - v0) / (v1 - v0) if v1 != v0 else 0.5
        t_cross[i] = t0 + frac * (t1 - t0)

    # Period = difference between consecutive crossing times
    periods = np.diff(t_cross)
    freq = 1.0 / periods

    # Place each frequency measurement at the midpoint of its period
    t_freq = (t_cross[:-1] + t_cross[1:]) / 2.0

    return t_freq, freq


def plot_vco_frequency(signals, mask, save_path=None):
    """Plot instantaneous VCO output frequency vs time."""
    t = signals["time"][mask]
    v_clk = signals["v(clk_out)"][mask]

    print("  Computing VCO output frequency from rising-edge crossings ...")
    t_freq, freq = extract_instantaneous_frequency(t, v_clk)

    if len(freq) == 0:
        print("  WARNING: No clock edges detected — skipping frequency plot.")
        return None

    freq_ghz = freq / 1e9

    fig, ax = plt.subplots(figsize=(12, 5))
    ax.plot(t_freq, freq_ghz, linewidth=0.5, color="#d62728", alpha=0.8)
    ax.set_ylabel("Frequency (GHz)")
    ax.set_title("VCO Output Frequency — v(clk_out)")
    apply_time_axis(ax)

    # Annotate steady-state statistics (last 20% of data)
    n = len(freq)
    tail = freq[int(0.8 * n):]
    if len(tail) > 1:
        f_mean = np.mean(tail)
        f_std = np.std(tail)
        ax.axhline(f_mean / 1e9, color="gray", ls="--", lw=0.8, alpha=0.6)
        stats_text = (f"Steady-state (last 20%):\n"
                      f"  Mean = {f_mean/1e9:.4f} GHz\n"
                      f"  Std  = {f_std/1e6:.2f} MHz")
        ax.text(0.02, 0.95, stats_text, transform=ax.transAxes,
                fontsize=9, verticalalignment="top",
                bbox=dict(boxstyle="round,pad=0.4", fc="white", alpha=0.85))
        print(f"  Steady-state freq: {f_mean/1e9:.4f} GHz  "
              f"(std = {f_std/1e6:.2f} MHz)")

    fig.tight_layout()
    if save_path:
        fig.savefig(os.path.join(save_path, "06_vco_frequency.png"))
    return fig


def plot_bias_voltages(signals, mask, save_path=None):
    """Plot bias voltages."""
    fig, ax = plt.subplots(figsize=(12, 4))
    t = signals["time"][mask]

    ax.plot(t, signals["v(vbias1)"][mask], linewidth=0.5, label="vbias1")
    ax.plot(t, signals["v(vbias2)"][mask], linewidth=0.5, label="vbias2")
    ax.set_ylabel("Voltage (V)")
    ax.set_title("Bias Voltages")
    ax.legend(loc="best")
    apply_time_axis(ax)
    fig.tight_layout()
    if save_path:
        fig.savefig(os.path.join(save_path, "05_bias_voltages.png"))
    return fig


def plot_overview(signals, mask, save_path=None):
    """
    Combined 5-panel overview of the PLL.
    """
    fig, axes = plt.subplots(5, 1, figsize=(14, 14), sharex=True)
    t = signals["time"][mask]

    # Panel 1: Control voltage
    axes[0].plot(t, signals["v(x2.vctrl)"][mask], lw=0.5, color="#1f77b4")
    axes[0].set_ylabel("V")
    axes[0].set_title("VCO Control Voltage — v(x2.vctrl)")

    # Panel 2: Clocks
    axes[1].plot(t, signals["v(clk_in)"][mask], lw=0.3, alpha=0.8, label="clk_in")
    axes[1].plot(t, signals["v(clk_out)"][mask], lw=0.3, alpha=0.8, label="clk_out")
    axes[1].set_ylabel("V")
    axes[1].set_title("Clocks")
    axes[1].legend(loc="upper right", fontsize=8)

    # Panel 3: PFD outputs
    axes[2].plot(t, signals["v(x2.up)"][mask], lw=0.3, alpha=0.8, label="UP")
    axes[2].plot(t, signals["v(x2.dn)"][mask], lw=0.3, alpha=0.8, label="DN")
    axes[2].set_ylabel("V")
    axes[2].set_title("PFD Outputs (UP / DN)")
    axes[2].legend(loc="upper right", fontsize=8)

    # Panel 4: DSM output
    axes[3].plot(t, signals["v(x2.dsm_out)"][mask], lw=0.4, color="#ff7f0e")
    axes[3].set_ylabel("V")
    axes[3].set_title("Delta-Sigma Modulator Output")

    # Panel 5: Bias voltages
    axes[4].plot(t, signals["v(vbias1)"][mask], lw=0.5, label="vbias1")
    axes[4].plot(t, signals["v(vbias2)"][mask], lw=0.5, label="vbias2")
    axes[4].set_ylabel("V")
    axes[4].set_title("Bias Voltages")
    axes[4].legend(loc="upper right", fontsize=8)

    apply_time_axis(axes[-1])
    for ax in axes[:-1]:
        apply_time_axis(ax, xlabel=False)

    fig.suptitle("Fractional-N PLL — Transient Simulation Overview",
                 fontsize=14, fontweight="bold", y=1.0)
    fig.tight_layout()
    if save_path:
        fig.savefig(os.path.join(save_path, "00_pll_overview.png"))
    return fig


# ---------------------------------------------------------------------------
# 4. Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description="Visualise ngspice PLL simulation results (.raw files)")
    parser.add_argument("--raw", default="../simulations/pll_top.raw",
                        help="Path to the ngspice .raw file (default: pll_top.raw)")
    parser.add_argument("--start", type=float, default=None,
                        help="Start time in seconds (e.g. 5e-6)")
    parser.add_argument("--stop", type=float, default=None,
                        help="Stop time in seconds (e.g. 10e-6)")
    parser.add_argument("--downsample", type=int, default=1,
                        help="Keep every Nth sample to reduce memory (default: 1)")
    parser.add_argument("--save", action="store_true",
                        help="Save plots as PNG files instead of displaying them")
    parser.add_argument("--outdir", default="plots",
                        help="Directory for saved plots (default: plots/)")
    args = parser.parse_args()

    # Resolve raw file path relative to script location
    script_dir = os.path.dirname(os.path.abspath(__file__))
    raw_path = args.raw if os.path.isabs(args.raw) else os.path.join(script_dir, args.raw)

    if not os.path.isfile(raw_path):
        print(f"Error: raw file not found: {raw_path}", file=sys.stderr)
        sys.exit(1)

    # Auto-downsample for very large files (> 100 MB)
    file_mb = os.path.getsize(raw_path) / 1024**2
    ds = args.downsample
    if ds == 1 and file_mb > 100:
        ds = max(1, int(file_mb / 100))
        print(f"  Auto-downsampling by {ds}x for {file_mb:.0f} MB file")

    signals, meta = load_raw(raw_path, downsample=ds)
    mask = time_slice(signals, args.start, args.stop)

    print(f"\nTime range: {signals['time'][mask][0]:.3e} – "
          f"{signals['time'][mask][-1]:.3e} s  "
          f"({np.sum(mask):,} points after slicing)")
    print(f"Signals: {', '.join(s for s in signals if s != 'time')}\n")

    setup_style()

    save_path = None
    if args.save:
        save_path = os.path.join(script_dir, args.outdir)
        os.makedirs(save_path, exist_ok=True)
        # Use non-interactive backend for saving
        matplotlib.use("Agg")
        print(f"Saving plots to {save_path}/")

    plot_overview(signals, mask, save_path)
    plot_control_voltage(signals, mask, save_path)
    plot_clocks(signals, mask, save_path)
    plot_pfd_outputs(signals, mask, save_path)
    plot_dsm_output(signals, mask, save_path)
    plot_bias_voltages(signals, mask, save_path)
    plot_vco_frequency(signals, mask, save_path)

    if args.save:
        print("All plots saved.")
    else:
        plt.show()


if __name__ == "__main__":
    main()
