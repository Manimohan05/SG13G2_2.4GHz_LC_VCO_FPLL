#!/usr/bin/env python3
"""
VCO Control Voltage Transient  0 to 65 us
==========================================
Plots v(xpll.vctrl) over the full 0–65 us range to show the PLL
lock-in transient, with a zoom inset of the settled region.

Saves
-----
  xschem/top-pll/plots/plot_vctrl_transient.pdf
  xschem/top-pll/plots/plot_vctrl_transient.png

Usage
-----
  python3 plot_vctrl_transient.py
  python3 plot_vctrl_transient.py /path/to/tb_LC_VCO_FPLL_100u.raw
"""

import os, sys
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
from mpl_toolkits.axes_grid1.inset_locator import inset_axes, mark_inset
import scienceplots  # noqa: F401

# ── Time window ───────────────────────────────────────────────────────────────
T_START    = 0.0
T_END      = 65e-6
DOWNSAMPLE = 60      # 7.96 M pts / 60 ≈ 133 k pts — smooth for a slow signal

# ── Zoom inset window (settled ripple) ───────────────────────────────────────
ZOOM_START = 60e-6
ZOOM_END   = 65e-6

# ── Colours ───────────────────────────────────────────────────────────────────
C_VCTRL  = "#0E7490"   # teal
C_SETTLE = "#15803D"   # green  – settled level line
C_LOCK   = "#B45309"   # amber  – lock-time marker
C_BAND   = "#D97706"   # amber fill for tolerance band
C_ZOOM   = "#6D28D9"   # violet – inset border


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
# 2.  Load one signal column in the time window
# ---------------------------------------------------------------------------

def load_signal(filepath, sig_name, t_start, t_end, downsample=1):
    meta     = parse_raw_header(filepath)
    n_vars   = meta["n_vars"]
    n_points = meta["n_points"]
    offset   = meta["data_offset"]

    name_to_idx = {v["name"]: v["index"] for v in meta["variables"]}
    if sig_name not in name_to_idx:
        raise ValueError(
            f"'{sig_name}' not found.\nAvailable: {list(name_to_idx.keys())}")
    col = name_to_idx[sig_name]

    fmb = os.path.getsize(filepath) / 1024**2
    print(f"  {fmb:.0f} MB  |  {n_points:,} pts  |  {n_vars} vars")

    mm  = np.memmap(filepath, dtype=np.float64, mode="r",
                    offset=offset, shape=(n_points, n_vars))
    i0  = int(np.searchsorted(mm[:, 0], t_start))
    i1  = int(np.searchsorted(mm[:, 0], t_end, side="right"))
    print(f"  [{t_start*1e6:.0f} us, {t_end*1e6:.0f} us] = {i1-i0:,} raw pts")

    chunk = np.array(mm[i0:i1:downsample, [0, col]])
    del mm
    print(f"  Downsample x{downsample} -> {chunk.shape[0]:,} pts")

    return chunk[:, 0], chunk[:, 1]   # time, voltage


# ---------------------------------------------------------------------------
# 3.  Estimate lock time  (when vctrl first stays within ±tol of settled mean)
# ---------------------------------------------------------------------------

def find_lock_time(t, v, tol_frac=0.01, hold_s=500e-9):
    """
    Returns the first time vctrl stays within ±tol_frac of the final
    settled mean continuously for at least hold_s.
    """
    settled_mean = np.median(v[int(len(v) * 0.85):])
    tol          = abs(settled_mean) * tol_frac
    in_band      = np.abs(v - settled_mean) <= tol

    hold_pts = max(1, int(hold_s / np.mean(np.diff(t[:1000]))))
    for i in range(len(t)):
        if not in_band[i]:
            continue
        j = i
        while j < len(t) and in_band[j]:
            j += 1
        if (t[min(j, len(t)-1)] - t[i]) >= hold_s:
            return t[i], settled_mean, tol
    return None, settled_mean, tol


# ---------------------------------------------------------------------------
# 4.  Plot
# ---------------------------------------------------------------------------

def plot_vctrl(t, v, save_base):
    t_us = t * 1e6

    t_lock, v_settled, tol = find_lock_time(t, v)
    print(f"\n  Settled vctrl = {v_settled:.4f} V  (tol ±{tol*1e3:.2f} mV)")
    if t_lock is not None:
        print(f"  Lock time     = {t_lock*1e6:.2f} µs")

    with plt.style.context(["science", "no-latex"]):
        plt.rcParams.update({
            "figure.facecolor" : "white",
            "axes.facecolor"   : "white",
            "figure.dpi"       : 200,
            "axes.grid"        : True,
            "grid.alpha"       : 0.25,
            "grid.linestyle"   : "--",
            "grid.linewidth"   : 0.6,
            "axes.axisbelow"   : True,
            "font.size"        : 13,
            "axes.labelsize"   : 13,
            "axes.titlesize"   : 13,
            "xtick.labelsize"  : 11,
            "ytick.labelsize"  : 11,
            "axes.linewidth"   : 1.0,
            "xtick.major.width": 0.8,
            "ytick.major.width": 0.8,
            "xtick.major.size" : 4,
            "ytick.major.size" : 4,
        })

        fig, ax = plt.subplots(figsize=(13.0, 4.5))
        fig.subplots_adjust(left=0.08, right=0.97, top=0.87, bottom=0.15)

        # ── Main transient curve ──────────────────────────────────────
        ax.plot(t_us, v, color=C_VCTRL, linewidth=1.0, zorder=4,
                label="v(xpll.vctrl)")

        # ── Settled level dashed line ─────────────────────────────────
        ax.axhline(v_settled, color=C_SETTLE, linewidth=1.0,
                   linestyle="--", alpha=0.85, zorder=3,
                   label=f"Settled  {v_settled:.4f} V")

        # ── Tolerance band ────────────────────────────────────────────
        ax.axhspan(v_settled - tol, v_settled + tol,
                   color=C_BAND, alpha=0.12, zorder=2,
                   label=f"±{tol*1e3:.1f} mV band")

        # ── Lock-time vertical marker ─────────────────────────────────
        if t_lock is not None:
            tl_us = t_lock * 1e6
            ax.axvline(tl_us, color=C_LOCK, linewidth=1.2,
                       linestyle=":", zorder=5)
            ax.annotate(
                f"Lock  {tl_us:.1f} µs",
                xy=(tl_us, v_settled + tol * 2.5),
                fontsize=10, color=C_LOCK, fontweight="bold",
                ha="left",
                xytext=(tl_us + 1.5, v_settled + tol * 5),
                arrowprops=dict(arrowstyle="->", color=C_LOCK,
                                lw=0.8, connectionstyle="arc3,rad=0.2"),
            )

        # ── Axes labels & limits ──────────────────────────────────────
        ax.set_xlabel("Time (µs)", fontsize=13)
        ax.set_ylabel("Voltage (V)", fontsize=13)
        ax.set_xlim(T_START * 1e6, T_END * 1e6)

        ylo = v.min();  yhi = v.max()
        pad = (yhi - ylo) * 0.12
        ax.set_ylim(ylo - pad, yhi + pad)

        ax.xaxis.set_major_locator(ticker.MultipleLocator(10))
        ax.xaxis.set_minor_locator(ticker.MultipleLocator(5))
        ax.yaxis.set_major_formatter(
            ticker.FuncFormatter(lambda val, _: f"{val:.3f}"))

        ax.legend(fontsize=10, loc="upper right",
                  framealpha=0.9, edgecolor="none", ncol=3)

        # ── Title ─────────────────────────────────────────────────────
        ax.set_title(
            "VCO Control Voltage — Lock-In Transient   "
            "[0 µs – 65 µs]     SG13G2 130 nm BiCMOS  |  2.4 GHz FPLL",
            fontsize=13, fontweight="bold", pad=8,
        )

        # ── Zoom inset  (settled ripple) ──────────────────────────────
        axin = inset_axes(ax, width="30%", height="55%",
                          loc="center left",
                          bbox_to_anchor=(0.55, 0.08, 1, 1),
                          bbox_transform=ax.transAxes)

        zm = (t_us >= ZOOM_START * 1e6) & (t_us <= ZOOM_END * 1e6)
        axin.plot(t_us[zm], v[zm], color=C_VCTRL, linewidth=0.8)
        axin.axhline(v_settled, color=C_SETTLE, linewidth=0.8,
                     linestyle="--", alpha=0.8)
        axin.axhspan(v_settled - tol, v_settled + tol,
                     color=C_BAND, alpha=0.15)

        axin.set_xlim(ZOOM_START * 1e6, ZOOM_END * 1e6)
        v_zm  = v[zm]
        ypad  = max((v_zm.max() - v_zm.min()) * 0.2, tol * 2)
        axin.set_ylim(v_zm.min() - ypad, v_zm.max() + ypad)
        axin.xaxis.set_major_locator(ticker.MultipleLocator(2))
        axin.yaxis.set_major_formatter(
            ticker.FuncFormatter(lambda val, _: f"{val:.3f}"))
        axin.tick_params(labelsize=8)
        axin.set_title("Settled ripple (60–65 µs)",
                       fontsize=8.5, pad=3, color=C_ZOOM)
        for sp in axin.spines.values():
            sp.set_edgecolor(C_ZOOM)
            sp.set_linewidth(1.2)

        mark_inset(ax, axin, loc1=2, loc2=4,
                   fc="none", ec=C_ZOOM, lw=0.8, linestyle="--")

        # ── Save ──────────────────────────────────────────────────────
        for ext in (".pdf", ".png"):
            out = save_base + ext
            dpi = 300 if ext == ".png" else None
            fig.savefig(out, dpi=dpi, bbox_inches="tight",
                        format=ext.lstrip("."))
            print(f"  Saved : {out}")

        plt.close(fig)


# ---------------------------------------------------------------------------
# 5.  Main
# ---------------------------------------------------------------------------

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))

    raw_path = (
        os.path.abspath(sys.argv[1]) if len(sys.argv) > 1
        else os.path.abspath(
            os.path.join(script_dir,
                         "../../../simulations/tb_LC_VCO_FPLL_100u.raw"))
    )

    if not os.path.isfile(raw_path):
        print(f"Error: '{raw_path}' not found.")
        sys.exit(1)

    print(f"Raw    : {raw_path}")
    print(f"Window : {T_START*1e6:.0f} µs  ->  {T_END*1e6:.0f} µs\n")

    t, v = load_signal(raw_path, "v(xpll.vctrl)",
                       T_START, T_END, downsample=DOWNSAMPLE)

    save_base = os.path.join(script_dir, "plot_vctrl_transient")
    print("\nRendering figure ...")
    plot_vctrl(t, v, save_base)
    print("Done.")


if __name__ == "__main__":
    main()
