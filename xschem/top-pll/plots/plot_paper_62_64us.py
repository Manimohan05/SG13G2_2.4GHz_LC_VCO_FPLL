#!/usr/bin/env python3
"""
PLL Key Signals  62 us to 64 us  — Presentation / Slide Figure
================================================================
Extracts 6 signals from tb_LC_VCO_FPLL_100u.raw.

Signal flow order (top -> bottom):
  ① v(clk_in)        Reference Clock      (PFD input A)
  ② v(xpll.clk_fb)   Feedback Clock       (PFD input B)
  ③ v(xpll.up)       PFD UP pulse
  ④ v(xpll.dn)       PFD DN pulse
  ⑤ v(xpll.vctrl)    VCO Control Voltage  (loop filter output)
  ⑥ v(clk_out)       Output Clock         (VCO output) — ZOOMED x-axis

Panels ①–⑤ share the 62–64 us (2000 ns) time axis.
Panel ⑥  uses a 20 ns zoom window to show individual 2.4 GHz cycles.
A shaded marker on panel ① shows where the zoom region sits.

Saves
-----
  xschem/top-pll/plots/plot_paper_62_64us.pdf
  xschem/top-pll/plots/plot_paper_62_64us.png

Usage
-----
  python3 plot_paper_62_64us.py
  python3 plot_paper_62_64us.py /path/to/tb_LC_VCO_FPLL_100u.raw
"""

import os, sys
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import matplotlib.patches as mpatches
import scienceplots  # noqa: F401

# ── Main time window ──────────────────────────────────────────────────────────
T_START = 62e-6
T_END   = 64e-6

# ── Zoom window for clk_out (show individual 2.4 GHz cycles) ─────────────────
CLK_ZOOM_START = 63.000e-6    # 20 ns window  →  ~48 cycles at 2.4 GHz
CLK_ZOOM_END   = 63.020e-6

# ── Signal fetch window: union of both windows ────────────────────────────────
FETCH_START = T_START
FETCH_END   = T_END

DOWNSAMPLE = 1    # no downsampling — only ~245 k pts in 2 us

# ── Signal flow order ─────────────────────────────────────────────────────────
SIGNALS = [
    "v(clk_in)",
    "v(xpll.clk_fb)",
    "v(xpll.up)",
    "v(xpll.dn)",
    "v(xpll.vctrl)",
    "v(clk_out)",
]

# ── 2-column × 3-row panel layout ────────────────────────────────────────────
#
#   Left column  (PLL inputs / PFD)   Right column  (PFD output / VCO)
#   ─────────────────────────────     ───────────────────────────────────
#   ① Reference Clock                ④ PFD DN
#   ② Feedback Clock                 ⑤ VCO Control Voltage
#   ③ PFD UP                         ⑥ Output Clock  (zoomed 20 ns)
#
# Each entry: (raw_name, short_label, colour, row, col)
PANELS = [
    ("v(clk_in)",       "Reference Clock  (PFD in A)",          "#1D4ED8", 0, 0),
    ("v(xpll.clk_fb)",  "Feedback Clock   (PFD in B)",          "#B45309", 1, 0),
    ("v(xpll.up)",      "PFD  UP",                              "#15803D", 2, 0),
    ("v(xpll.dn)",      "PFD  DN",                              "#6D28D9", 0, 1),
    ("v(xpll.vctrl)",   "VCO Control Voltage",                  "#0E7490", 1, 1),
    ("v(clk_out)",      "Output Clock  (VCO, 2.4 GHz) — 20 ns zoom",
                                                                 "#B91C1C", 2, 1),
]


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
# 2.  Load only the requested columns in the time window
# ---------------------------------------------------------------------------

def load_signals(filepath, signal_names, t_start, t_end, downsample=1):
    meta     = parse_raw_header(filepath)
    n_vars   = meta["n_vars"]
    n_points = meta["n_points"]
    offset   = meta["data_offset"]

    name_to_idx = {v["name"]: v["index"] for v in meta["variables"]}
    for name in signal_names:
        if name not in name_to_idx:
            raise ValueError(
                f"Signal '{name}' not found.\n"
                f"Available: {list(name_to_idx.keys())}"
            )

    fmb = os.path.getsize(filepath) / 1024**2
    print(f"  {fmb:.0f} MB  |  {n_points:,} pts  |  {n_vars} vars")

    mm  = np.memmap(filepath, dtype=np.float64, mode="r",
                    offset=offset, shape=(n_points, n_vars))
    i0  = int(np.searchsorted(mm[:, 0], t_start))
    i1  = int(np.searchsorted(mm[:, 0], t_end, side="right"))
    print(f"  [{t_start*1e6:.3f} us, {t_end*1e6:.3f} us] = {i1-i0:,} raw pts")

    cols  = [0] + [name_to_idx[n] for n in signal_names]
    chunk = np.array(mm[i0:i1:downsample, cols])
    del mm

    out = {"time": chunk[:, 0]}
    for k, name in enumerate(signal_names):
        out[name] = chunk[:, k + 1]
    return out


# ---------------------------------------------------------------------------
# 3.  2-column × 3-row slide figure
# ---------------------------------------------------------------------------

def plot_slide(signals, save_base):
    t_s  = signals["time"]
    t_us = t_s * 1e6
    t_ns = t_s * 1e9

    main_xlim = (T_START * 1e6, T_END * 1e6)                          # µs
    zoom_xlim = (CLK_ZOOM_START * 1e9, CLK_ZOOM_END * 1e9)            # ns

    with plt.style.context(["science", "no-latex"]):
        plt.rcParams.update({
            "figure.facecolor" : "white",
            "axes.facecolor"   : "white",
            "figure.dpi"       : 200,
            "axes.grid"        : True,
            "grid.alpha"       : 0.22,
            "grid.linestyle"   : "--",
            "grid.linewidth"   : 0.6,
            "axes.axisbelow"   : True,
            "font.size"        : 12,
            "axes.labelsize"   : 12,
            "axes.titlesize"   : 12,
            "xtick.labelsize"  : 10,
            "ytick.labelsize"  : 10,
            "axes.linewidth"   : 1.0,
            "xtick.major.width": 0.8,
            "ytick.major.width": 0.8,
            "xtick.major.size" : 4,
            "ytick.major.size" : 4,
        })

        # ── 16:9 figure — fills one slide ─────────────────────────────
        fig = plt.figure(figsize=(14.0, 7.5))
        gs  = fig.add_gridspec(
            3, 2,
            hspace=0.12, wspace=0.32,
            left=0.07, right=0.97,
            top=0.91,  bottom=0.09,
        )
        # Build 3×2 axes grid
        axs = [[fig.add_subplot(gs[r, c]) for c in range(2)]
               for r in range(3)]

        for raw_name, label, colour, row, col in PANELS:
            ax      = axs[row][col]
            is_zoom = (raw_name == "v(clk_out)")

            # ── Time vector & x-limits ────────────────────────────────
            if is_zoom:
                t_plot = t_ns;  xlim = zoom_xlim
                xmajor = ticker.MultipleLocator(5)
                xminor = ticker.MultipleLocator(1)
                xlabel = "Time (ns)"
            else:
                t_plot = t_us;  xlim = main_xlim
                xmajor = ticker.MultipleLocator(400)   # every 0.4 µs
                xminor = ticker.MultipleLocator(200)
                xlabel = "Time (µs)"

            # ── Mask to window ────────────────────────────────────────
            mask = (t_plot >= xlim[0]) & (t_plot <= xlim[1])
            tv   = t_plot[mask]
            yv   = signals[raw_name][mask]

            # ── Line width ────────────────────────────────────────────
            lw = 1.0 if is_zoom else (
                 0.65 if "clk" in raw_name else (
                 0.75 if raw_name in ("v(xpll.up)", "v(xpll.dn)") else 1.1))

            ax.plot(tv, yv, color=colour, linewidth=lw, zorder=3)

            # ── Y-axis ────────────────────────────────────────────────
            ylo, yhi = float(yv.min()), float(yv.max())
            pad = max((yhi - ylo) * 0.15, 0.03)
            ax.set_ylim(ylo - pad, yhi + pad)

            if raw_name == "v(xpll.vctrl)":
                ax.yaxis.set_major_locator(
                    ticker.MaxNLocator(4, prune="both"))
                ax.yaxis.set_major_formatter(
                    ticker.FuncFormatter(lambda v, _: f"{v:.3f}"))
            else:
                ax.set_yticks([0.0, round((ylo + yhi) / 2, 1),
                               round(yhi, 1)])
                ax.yaxis.set_major_formatter(
                    ticker.FuncFormatter(lambda v, _: f"{v:.1f}"))

            ax.set_ylabel("V", fontsize=10, labelpad=2)

            # ── X-axis: only bottom row gets tick labels ──────────────
            ax.set_xlim(xlim)
            ax.xaxis.set_major_locator(xmajor)
            ax.xaxis.set_minor_locator(xminor)
            if row == 2:
                ax.set_xlabel(xlabel, fontsize=11)
            else:
                plt.setp(ax.get_xticklabels(), visible=False)

            # ── Panel title (top-left, colour-matched) ────────────────
            ax.set_title(label, fontsize=11.5, color=colour,
                         fontweight="bold", loc="left", pad=4)

            # ── Zoom indicator on Reference Clock panel ───────────────
            if raw_name == "v(clk_in)":
                zs = CLK_ZOOM_START * 1e6
                ze = CLK_ZOOM_END   * 1e6
                ax.axvspan(zs, ze, color="#B91C1C", alpha=0.15, zorder=2)
                ax.text((zs + ze) / 2, yhi + pad * 0.3,
                        "zoom", fontsize=8, color="#B91C1C",
                        ha="center", va="bottom", fontweight="bold")

            # ── Faint tint on clk_out zoom panel ─────────────────────
            if is_zoom:
                ax.set_facecolor("#FFF5F5")
                ax.annotate(
                    f"63.000 – 63.020 µs  (20 ns window)",
                    xy=(0.02, 0.90), xycoords="axes fraction",
                    fontsize=9, color="#B91C1C",
                    bbox=dict(boxstyle="round,pad=0.2", fc="white",
                              ec="#B91C1C", alpha=0.9, lw=0.7),
                )

        # ── Column headers ────────────────────────────────────────────
        fig.text(0.25, 0.935, "PLL Inputs  &  PFD",
                 ha="center", va="bottom", fontsize=13,
                 fontweight="bold", color="#374151")
        fig.text(0.73, 0.935, "PFD Output  →  VCO",
                 ha="center", va="bottom", fontsize=13,
                 fontweight="bold", color="#374151")

        # ── Overall title ─────────────────────────────────────────────
        fig.suptitle(
            "2.4 GHz Fractional-N PLL  —  Settled Waveforms  "
            "[62 µs – 64 µs]     SG13G2 130 nm BiCMOS",
            fontsize=14, fontweight="bold", y=0.99,
        )

        # ── Save ──────────────────────────────────────────────────────
        for ext in (".pdf", ".png"):
            out = save_base + ext
            dpi = 300 if ext == ".png" else None
            fig.savefig(out, dpi=dpi, bbox_inches="tight",
                        format=ext.lstrip("."))
            print(f"  Saved : {out}")

        plt.close(fig)


# ---------------------------------------------------------------------------
# 4.  Main
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

    print(f"Raw   : {raw_path}")
    print(f"Main  : {T_START*1e6:.0f} µs  ->  {T_END*1e6:.0f} µs")
    print(f"Zoom  : {CLK_ZOOM_START*1e9:.0f} ns  ->  {CLK_ZOOM_END*1e9:.0f} ns\n")

    signals = load_signals(raw_path, SIGNALS, FETCH_START, FETCH_END,
                           downsample=DOWNSAMPLE)

    save_base = os.path.join(script_dir, "plot_paper_62_64us")
    print("\nRendering slide figure ...")
    plot_slide(signals, save_base)
    print("Done.")


if __name__ == "__main__":
    main()
