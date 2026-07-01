#!/usr/bin/env python3
"""
PLL Waveforms — Slide Figure  (2 columns × 3 rows)
===================================================
Left column  — PLL Inputs & PFD  [62–64 µs]:
  ① Reference Clock  (PFD in A)
  ② Feedback Clock   (PFD in B)
  ③ PFD UP

Right column  — PFD Output → VCO:
  ④ PFD DN                          [62–64 µs]
  ⑤ VCO Control Voltage transient   [0–65 µs]   ← full lock-in curve
  ⑥ Output Clock  (VCO, 2.4 GHz)   [20 ns zoom]

Saves
-----
  xschem/top-pll/plots/plot_paper_pll_slide.pdf
  xschem/top-pll/plots/plot_paper_pll_slide.png

Usage
-----
  python3 plot_paper_pll_slide.py
  python3 plot_paper_pll_slide.py /path/to/tb_LC_VCO_FPLL_100u.raw
"""

import os, sys
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import scienceplots  # noqa: F401

# ── Window A  (most signals) ──────────────────────────────────────────────────
A_START = 62e-6
A_END   = 64e-6
A_DS    = 1          # no downsample — only 245 k pts in 2 µs

# ── Window B  (vctrl full transient) ─────────────────────────────────────────
B_START = 0.0
B_END   = 65e-6
B_DS    = 60         # 7.96 M pts / 60 ≈ 133 k pts

# ── Zoom window  (clk_out) ────────────────────────────────────────────────────
CLK_ZOOM_START = 63.000e-6
CLK_ZOOM_END   = 63.020e-6   # 20 ns  →  ~48 cycles at 2.4 GHz

# ── Panel config
#   (raw_name, label, colour, row, col, window, x_unit)
#   window: 'A' = 62-64 µs  |  'B' = 0-65 µs  |  'Z' = clk zoom
# ─────────────────────────────────────────────────────────────────────────────
PANELS = [
    ("v(clk_in)",       "Reference Clock  (PFD in A)",        "#1D4ED8", 0, 0, "A"),
    ("v(xpll.clk_fb)",  "Feedback Clock   (PFD in B)",        "#B45309", 1, 0, "A"),
    ("v(xpll.up)",      "PFD  UP",                            "#15803D", 2, 0, "A"),
    ("v(xpll.dn)",      "PFD  DN",                            "#6D28D9", 0, 1, "A"),
    ("v(xpll.vctrl)",   "VCO Control Voltage  [0–65 µs]",     "#0E7490", 1, 1, "B"),
    ("v(clk_out)",      "Output Clock  (VCO, 2.4 GHz) — 20 ns zoom",
                                                               "#B91C1C", 2, 1, "Z"),
]

SIGNALS_A = ["v(clk_in)", "v(xpll.clk_fb)",
             "v(xpll.up)", "v(xpll.dn)", "v(clk_out)"]
SIGNALS_B = ["v(xpll.vctrl)"]


# ---------------------------------------------------------------------------
# 1.  Raw file parser
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
# 2.  Load a set of signals in a given time window
# ---------------------------------------------------------------------------

def load_signals(filepath, signal_names, t_start, t_end, downsample=1):
    meta        = parse_raw_header(filepath)
    n_vars      = meta["n_vars"]
    n_points    = meta["n_points"]
    offset      = meta["data_offset"]
    name_to_idx = {v["name"]: v["index"] for v in meta["variables"]}

    mm   = np.memmap(filepath, dtype=np.float64, mode="r",
                     offset=offset, shape=(n_points, n_vars))
    i0   = int(np.searchsorted(mm[:, 0], t_start))
    i1   = int(np.searchsorted(mm[:, 0], t_end, side="right"))
    print(f"  [{t_start*1e6:.0f}-{t_end*1e6:.0f} us]  "
          f"{i1-i0:,} raw pts  -> DS x{downsample} -> "
          f"{(i1-i0)//downsample:,} pts")

    cols  = [0] + [name_to_idx[n] for n in signal_names]
    chunk = np.array(mm[i0:i1:downsample, cols])
    del mm

    out = {"time": chunk[:, 0]}
    for k, name in enumerate(signal_names):
        out[name] = chunk[:, k + 1]
    return out


# ---------------------------------------------------------------------------
# 3.  Build the slide figure
# ---------------------------------------------------------------------------

def plot_slide(data_a, data_b, save_base):
    # Time vectors
    t_a_us = data_a["time"] * 1e6
    t_a_ns = data_a["time"] * 1e9
    t_b_us = data_b["time"] * 1e6

    # x-limits for each window type
    xlim = {
        "A": (A_START * 1e6, A_END * 1e6),                          # µs
        "B": (B_START * 1e6, B_END * 1e6),                          # µs
        "Z": (CLK_ZOOM_START * 1e9, CLK_ZOOM_END * 1e9),            # ns
    }

    # vctrl settled level
    v_vctrl   = data_b["v(xpll.vctrl)"]
    v_settled = float(np.median(v_vctrl[int(len(v_vctrl) * 0.85):]))

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

        fig = plt.figure(figsize=(14.0, 7.5))
        gs  = fig.add_gridspec(
            3, 2,
            hspace=0.14, wspace=0.30,
            left=0.07, right=0.97,
            top=0.91,  bottom=0.09,
        )
        axs = [[fig.add_subplot(gs[r, c]) for c in range(2)]
               for r in range(3)]

        for raw_name, label, colour, row, col, win in PANELS:
            ax = axs[row][col]

            # ── Select data source & time axis ────────────────────────
            if win == "B":
                t_plot = t_b_us
                data   = data_b
                xl     = xlim["B"]
                xmajor = ticker.MultipleLocator(10)
                xminor = ticker.MultipleLocator(5)
                xlabel = "Time (µs)"
            elif win == "Z":
                t_plot = t_a_ns
                data   = data_a
                xl     = xlim["Z"]
                xmajor = ticker.MultipleLocator(5)
                xminor = ticker.MultipleLocator(1)
                xlabel = "Time (ns)"
            else:                          # "A"
                t_plot = t_a_us
                data   = data_a
                xl     = xlim["A"]
                xmajor = ticker.MultipleLocator(400)
                xminor = ticker.MultipleLocator(200)
                xlabel = "Time (µs)"

            # ── Mask to window ────────────────────────────────────────
            mask = (t_plot >= xl[0]) & (t_plot <= xl[1])
            tv   = t_plot[mask]
            yv   = data[raw_name][mask]

            # ── Line width ────────────────────────────────────────────
            lw = (1.0  if win == "Z"                              else
                  1.0  if raw_name == "v(xpll.vctrl)"            else
                  0.65 if "clk" in raw_name                       else
                  0.75 if raw_name in ("v(xpll.up)", "v(xpll.dn)") else
                  0.9)

            ax.plot(tv, yv, color=colour, linewidth=lw, zorder=4)

            # ── vctrl extras: settled line ────────────────────────────
            if raw_name == "v(xpll.vctrl)":
                ax.axhline(v_settled, color="#15803D", linewidth=0.9,
                           linestyle="--", alpha=0.85, zorder=3,
                           label=f"Settled  {v_settled:.4f} V")
                ax.legend(fontsize=8.5, loc="upper right",
                          framealpha=0.9, edgecolor="none")

            # ── Y-axis ────────────────────────────────────────────────
            ylo, yhi = float(yv.min()), float(yv.max())
            pad = max((yhi - ylo) * 0.15, 0.03)
            ax.set_ylim(ylo - pad, yhi + pad)

            if raw_name == "v(xpll.vctrl)":
                ax.yaxis.set_major_locator(
                    ticker.MaxNLocator(5, prune="both"))
                ax.yaxis.set_major_formatter(
                    ticker.FuncFormatter(lambda v, _: f"{v:.3f}"))
            else:
                ax.set_yticks([0.0, round((ylo + yhi) / 2, 1),
                               round(yhi, 1)])
                ax.yaxis.set_major_formatter(
                    ticker.FuncFormatter(lambda v, _: f"{v:.1f}"))

            ax.set_ylabel("V", fontsize=10, labelpad=2)

            # ── X-axis ────────────────────────────────────────────────
            ax.set_xlim(xl)
            ax.xaxis.set_major_locator(xmajor)
            ax.xaxis.set_minor_locator(xminor)
            if row == 2:
                ax.set_xlabel(xlabel, fontsize=11)
            else:
                plt.setp(ax.get_xticklabels(), visible=False)

            # ── Panel title ───────────────────────────────────────────
            ax.set_title(label, fontsize=11, color=colour,
                         fontweight="bold", loc="left", pad=4)

            # ── Zoom indicator on clk_in panel ────────────────────────
            if raw_name == "v(clk_in)":
                zs = CLK_ZOOM_START * 1e6
                ze = CLK_ZOOM_END   * 1e6
                ax.axvspan(zs, ze, color="#B91C1C", alpha=0.15, zorder=2)
                ax.text((zs + ze) / 2, yhi + pad * 0.3,
                        "zoom", fontsize=8, color="#B91C1C",
                        ha="center", va="bottom", fontweight="bold")

            # ── clk_out zoom panel background & label ─────────────────
            if win == "Z":
                ax.set_facecolor("#FFF5F5")
                ax.annotate(
                    "63.000 – 63.020 µs  (20 ns)",
                    xy=(0.02, 0.89), xycoords="axes fraction",
                    fontsize=8.5, color="#B91C1C",
                    bbox=dict(boxstyle="round,pad=0.2", fc="white",
                              ec="#B91C1C", alpha=0.9, lw=0.7),
                )

        # ── Column headers ────────────────────────────────────────────
        fig.text(0.25, 0.936, "PLL Inputs  &  PFD   [62–64 µs]",
                 ha="center", va="bottom", fontsize=12.5,
                 fontweight="bold", color="#374151")
        fig.text(0.73, 0.936, "PFD Output  →  VCO",
                 ha="center", va="bottom", fontsize=12.5,
                 fontweight="bold", color="#374151")

        # ── Overall title ─────────────────────────────────────────────
        fig.suptitle(
            "2.4 GHz Fractional-N PLL  —  Settled Waveforms  &  "
            "Control Voltage Transient     SG13G2 130 nm BiCMOS",
            fontsize=13.5, fontweight="bold", y=0.99,
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

    fmb = os.path.getsize(raw_path) / 1024**2
    print(f"Raw : {raw_path}  ({fmb:.0f} MB)\n")

    print("Loading window A  (62–64 µs, clocks + PFD) ...")
    data_a = load_signals(raw_path, SIGNALS_A, A_START, A_END, A_DS)

    print("Loading window B  (0–65 µs, vctrl transient) ...")
    data_b = load_signals(raw_path, SIGNALS_B, B_START, B_END, B_DS)

    save_base = os.path.join(script_dir, "plot_paper_pll_slide")
    print("\nRendering slide figure ...")
    plot_slide(data_a, data_b, save_base)
    print("Done.")


if __name__ == "__main__":
    main()
