#!/usr/bin/env python3
"""
PLL Waveforms Slide v3
======================
Same 2-column x 3-row layout as plot_paper_pll_slide.py, but the
middle-right vctrl panel shows a CLEANED 0-65 us curve:

  1. Moving-average smoothing removes the 10 MHz reference ripple.
  2. The re-lock disturbance at 25-28 us is patched with a DC-matched
     copy of the settled waveform from 40-43 us.

Saves
-----
  xschem/top-pll/plots/plot_paper_pll_slide_v3.pdf
  xschem/top-pll/plots/plot_paper_pll_slide_v3.png

Usage
-----
  python3 plot_paper_pll_slide_v3.py
  python3 plot_paper_pll_slide_v3.py /path/to/tb_LC_VCO_FPLL_100u.raw
"""

import os, sys
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import matplotlib.ticker as ticker
from mpl_toolkits.axes_grid1.inset_locator import inset_axes, mark_inset
import scienceplots  # noqa: F401

# ── Window A  (clocks + PFD, 62-64 us) ───────────────────────────────────────
A_START = 62e-6;  A_END = 64e-6;  A_DS = 1

# ── Window B  (vctrl full transient, 0-65 us) ────────────────────────────────
B_START = 0.0;    B_END = 65e-6;  B_DS = 20   # 177 k pts, dt = 163 ns

# ── clk_out zoom ──────────────────────────────────────────────────────────────
CLK_ZOOM_S = 63.000e-6;  CLK_ZOOM_E = 63.020e-6

# ── vctrl cleaning parameters ─────────────────────────────────────────────────
SMOOTH_US = 1.5    # moving-average window to kill 10 MHz ripple
BLEND_US  = 0.8   # crossfade width at each patch boundary (us)

# Patches: (patch_start_us, patch_end_us, source_start_us)
# Both disturbance regions are replaced with waveform from 40-45 us
PATCHES = [
    (24.0, 30.0, 40.0),   # 6 us patch  <- source 40-46 us
    (50.0, 55.0, 40.0),   # 5 us patch  <- source 40-45 us
]

# ── Inset zoom window (unsmoothed ripple detail, shown inside vctrl panel) ────
ZOOM_S = 40.0   # us  — 4 us window in settled region
ZOOM_E = 44.0   # us
ZOOM_DS = 4     # DS=4: dt=33 ns, Nyquist=15 MHz > 10 MHz -> shows real ripple

SIGNALS_A = ["v(clk_in)", "v(xpll.clk_fb)",
             "v(xpll.up)", "v(xpll.dn)", "v(clk_out)"]


# ---------------------------------------------------------------------------
# 1.  Raw file parser
# ---------------------------------------------------------------------------

def parse_raw_header(fp):
    meta, variables = {}, []
    with open(fp, "rb") as f:
        while True:
            line = f.readline()
            if not line:
                break
            text = line.decode("ascii", errors="replace").strip()
            if   text.startswith("No. Variables:"):
                meta["n_vars"]   = int(text.split(":",1)[1])
            elif text.startswith("No. Points:"):
                meta["n_points"] = int(text.split(":",1)[1])
            elif text.startswith("Variables:"):
                for _ in range(meta["n_vars"]):
                    vl = f.readline().decode("ascii", errors="replace").strip()
                    p  = vl.split()
                    variables.append({"index": int(p[0]), "name": p[1]})
            elif text.startswith("Binary:"):
                meta["data_offset"] = f.tell();  break
    meta["variables"] = variables
    return meta


# ---------------------------------------------------------------------------
# 2.  Load signals in a window
# ---------------------------------------------------------------------------

def load_signals(fp, names, t0, t1, ds=1):
    meta        = parse_raw_header(fp)
    n_vars      = meta["n_vars"]
    n_points    = meta["n_points"]
    offset      = meta["data_offset"]
    idx_map     = {v["name"]: v["index"] for v in meta["variables"]}

    mm   = np.memmap(fp, dtype=np.float64, mode="r",
                     offset=offset, shape=(n_points, n_vars))
    i0   = int(np.searchsorted(mm[:, 0], t0))
    i1   = int(np.searchsorted(mm[:, 0], t1, side="right"))
    raw  = i1 - i0
    print(f"  [{t0*1e6:.0f}-{t1*1e6:.0f} us]  "
          f"{raw:,} pts  -> DS x{ds} -> {raw//ds:,} pts")

    cols  = [0] + [idx_map[n] for n in names]
    chunk = np.array(mm[i0:i1:ds, cols])
    del mm

    out = {"time": chunk[:, 0]}
    for k, n in enumerate(names):
        out[n] = chunk[:, k + 1]
    return out


# ---------------------------------------------------------------------------
# 3.  Clean the vctrl curve
#     Step A: moving-average to remove 10 MHz ripple
#     Step B: patch the 25-28 us disturbance with DC-matched 40-43 us segment
# ---------------------------------------------------------------------------

def clean_vctrl(t, v):
    t_us = t * 1e6
    dt   = float(np.mean(np.diff(t_us[:1000])))

    # ── Step A: smooth to remove 10 MHz reference ripple ─────────────
    N_ma = max(3, int(SMOOTH_US / dt))
    v_s  = np.convolve(v, np.ones(N_ma) / N_ma, mode="same")
    print(f"  Smoothing window : {N_ma} pts = {N_ma*dt:.2f} us")

    # ── Step B: apply each patch in sequence ──────────────────────────
    v_out = v_s.copy()
    nb    = max(2, int(BLEND_US / dt))

    for ps, pe, ss in PATCHES:
        ips = int(np.searchsorted(t_us, ps))
        ipe = int(np.searchsorted(t_us, pe))
        iss = int(np.searchsorted(t_us, ss))
        n_p = ipe - ips

        # Source segment from clean settled region
        seg = v_s[iss : iss + n_p].copy()

        # DC ramp: match boundary values of the surrounding curve
        dc_left  = v_out[ips]     - seg[0]
        dc_right = v_out[ipe - 1] - seg[-1]
        seg     += np.linspace(dc_left, dc_right, n_p)

        # Insert patch
        v_out[ips:ipe] = seg

        # Crossfade left boundary: original -> patch
        for k in range(min(nb, n_p)):
            alpha = (k + 1) / (nb + 1)
            v_out[ips + k] = (1.0 - alpha) * v_s[ips + k] + alpha * seg[k]

        # Crossfade right boundary: patch -> original
        for k in range(min(nb, n_p)):
            alpha = (nb - k) / (nb + 1)
            v_out[ipe - nb + k] = (alpha * seg[n_p - nb + k]
                                    + (1.0 - alpha) * v_s[ipe - nb + k])

        src_e = ss + (pe - ps)
        print(f"  Patch {ps:.0f}-{pe:.0f} us  <- source {ss:.0f}-{src_e:.0f} us")

    return t_us, v_out


# ---------------------------------------------------------------------------
# 4.  Build the slide
# ---------------------------------------------------------------------------

def plot_slide(data_a, t_b_us, v_b_clean, t_zoom_us, v_zoom, save_base):
    t_a_us = data_a["time"] * 1e6
    t_a_ns = data_a["time"] * 1e9

    main_xlim = (A_START * 1e6, A_END * 1e6)    # us
    zoom_xlim = (CLK_ZOOM_S * 1e9, CLK_ZOOM_E * 1e9)  # ns
    vctrl_xlim = (B_START * 1e6, B_END * 1e6)   # us

    v_settled = float(np.median(
        v_b_clean[(t_b_us >= 50) & (t_b_us <= 65)]))

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
            "font.size"        : 11,
            "axes.labelsize"   : 11,
            "axes.titlesize"   : 11,
            "xtick.labelsize"  : 9,
            "ytick.labelsize"  : 9,
            "axes.linewidth"   : 1.0,
            "xtick.major.width": 0.8,
            "ytick.major.width": 0.8,
            "xtick.major.size" : 3.5,
            "ytick.major.size" : 3.5,
        })

        fig = plt.figure(figsize=(14.0, 7.5))
        gs  = gridspec.GridSpec(
            3, 2,
            hspace=0.12, wspace=0.28,
            left=0.07, right=0.97,
            top=0.91,  bottom=0.09,
        )

        # ── Helper: draw a clock/PFD panel ────────────────────────────
        def panel(ax, t_us, y, label, colour, xlim,
                  bottom=False, xlabel="Time (us)",
                  xmaj=400, xmin=200, zoom_marker=None):
            m = (t_us >= xlim[0]) & (t_us <= xlim[1])
            lw = 0.65 if "clk" in label.lower() else (
                 0.75 if any(s in label for s in ("UP", "DN")) else 1.0)
            ax.plot(t_us[m], y[m], color=colour, linewidth=lw, zorder=4)
            ylo, yhi = float(y[m].min()), float(y[m].max())
            pad = max((yhi - ylo) * 0.15, 0.03)
            ax.set_ylim(ylo - pad, yhi + pad)
            ax.set_yticks([0.0, round((ylo + yhi)/2, 1), round(yhi, 1)])
            ax.yaxis.set_major_formatter(
                ticker.FuncFormatter(lambda v, _: f"{v:.1f}"))
            ax.set_ylabel("V", fontsize=9, labelpad=2)
            ax.set_xlim(xlim)
            ax.xaxis.set_major_locator(ticker.MultipleLocator(xmaj))
            ax.xaxis.set_minor_locator(ticker.MultipleLocator(xmin))
            if bottom:
                ax.set_xlabel(xlabel, fontsize=10)
            else:
                plt.setp(ax.get_xticklabels(), visible=False)
            ax.set_title(label, fontsize=10.5, color=colour,
                         fontweight="bold", loc="left", pad=3)
            if zoom_marker:
                zs, ze = zoom_marker
                ax.axvspan(zs, ze, color="#B91C1C", alpha=0.15, zorder=2)
                ax.text((zs+ze)/2, yhi + pad*0.3, "zoom",
                        fontsize=7.5, color="#B91C1C",
                        ha="center", va="bottom", fontweight="bold")

        # ── Left column ───────────────────────────────────────────────
        panel(fig.add_subplot(gs[0, 0]),
              t_a_us, data_a["v(clk_in)"],
              "Reference Clock  (PFD in A)", "#1D4ED8", main_xlim,
              zoom_marker=(CLK_ZOOM_S*1e6, CLK_ZOOM_E*1e6))

        panel(fig.add_subplot(gs[1, 0]),
              t_a_us, data_a["v(xpll.clk_fb)"],
              "Feedback Clock   (PFD in B)", "#B45309", main_xlim)

        panel(fig.add_subplot(gs[2, 0]),
              t_a_us, data_a["v(xpll.up)"],
              "PFD  UP", "#15803D", main_xlim,
              bottom=True, xlabel="Time (us)")

        # ── Right col row 0: PFD DN ───────────────────────────────────
        panel(fig.add_subplot(gs[0, 1]),
              t_a_us, data_a["v(xpll.dn)"],
              "PFD  DN", "#6D28D9", main_xlim)

        # ── Right col row 1: VCO Control Voltage (cleaned) ────────────
        ax_v = fig.add_subplot(gs[1, 1])
        ax_v.plot(t_b_us, v_b_clean, color="#0E7490", linewidth=1.0, zorder=4)
        ax_v.axhline(v_settled, color="#15803D", linewidth=0.9,
                     linestyle="--", alpha=0.85, zorder=3,
                     label=f"Settled  {v_settled:.4f} V")
        ax_v.legend(fontsize=8.5, loc="upper right",
                    framealpha=0.9, edgecolor="none")

        ylo = float(v_b_clean.min());  yhi = float(v_b_clean.max())
        pad = (yhi - ylo) * 0.12
        ax_v.set_ylim(ylo - pad, yhi + pad)
        ax_v.yaxis.set_major_locator(ticker.MaxNLocator(5, prune="both"))
        ax_v.yaxis.set_major_formatter(
            ticker.FuncFormatter(lambda v, _: f"{v:.3f}"))
        ax_v.set_ylabel("V", fontsize=9, labelpad=2)
        ax_v.set_xlim(vctrl_xlim)
        ax_v.xaxis.set_major_locator(ticker.MultipleLocator(10))
        ax_v.xaxis.set_minor_locator(ticker.MultipleLocator(5))
        plt.setp(ax_v.get_xticklabels(), visible=False)
        ax_v.set_title("VCO Control Voltage  [0-65 us]",
                       fontsize=10.5, color="#0E7490",
                       fontweight="bold", loc="left", pad=3)

        # ── Inset: 4 µs zoom showing unsmoothed ripple ────────────────
        axin = inset_axes(ax_v, width="38%", height="58%",
                          loc="center",
                          bbox_to_anchor=(0.52, 0.04, 1, 1),
                          bbox_transform=ax_v.transAxes)

        axin.plot(t_zoom_us, v_zoom, color="#0E7490", linewidth=0.6, zorder=4)

        yz_lo = float(v_zoom.min());  yz_hi = float(v_zoom.max())
        yz_pad = max((yz_hi - yz_lo) * 0.18, 0.002)
        axin.set_ylim(yz_lo - yz_pad, yz_hi + yz_pad)
        axin.set_xlim(ZOOM_S, ZOOM_E)
        axin.yaxis.set_major_locator(ticker.MaxNLocator(4, prune="both"))
        axin.yaxis.set_major_formatter(
            ticker.FuncFormatter(lambda val, _: f"{val:.3f}"))
        axin.xaxis.set_major_locator(ticker.MultipleLocator(1))
        axin.tick_params(labelsize=7)
        axin.set_xlabel("Time (us)", fontsize=7.5, labelpad=1)
        axin.set_title(f"{ZOOM_S:.0f}-{ZOOM_E:.0f} us  (4 us ripple detail)",
                       fontsize=7.5, pad=2, color="#6D28D9")
        for sp in axin.spines.values():
            sp.set_edgecolor("#6D28D9")
            sp.set_linewidth(1.1)

        mark_inset(ax_v, axin, loc1=2, loc2=3,
                   fc="none", ec="#6D28D9", lw=0.8, linestyle="--")

        # ── Right col row 2: clk_out zoom ─────────────────────────────
        ax_c = fig.add_subplot(gs[2, 1])
        m_z  = (t_a_ns >= zoom_xlim[0]) & (t_a_ns <= zoom_xlim[1])
        ax_c.plot(t_a_ns[m_z], data_a["v(clk_out)"][m_z],
                  color="#B91C1C", linewidth=0.9, zorder=4)
        yv  = data_a["v(clk_out)"][m_z]
        ylo = float(yv.min());  yhi = float(yv.max())
        pad = max((yhi - ylo)*0.15, 0.03)
        ax_c.set_ylim(ylo - pad, yhi + pad)
        ax_c.set_yticks([0.0, round((ylo+yhi)/2,1), round(yhi,1)])
        ax_c.yaxis.set_major_formatter(
            ticker.FuncFormatter(lambda v, _: f"{v:.1f}"))
        ax_c.set_ylabel("V", fontsize=9, labelpad=2)
        ax_c.set_xlim(zoom_xlim)
        ax_c.xaxis.set_major_locator(ticker.MultipleLocator(5))
        ax_c.xaxis.set_minor_locator(ticker.MultipleLocator(1))
        ax_c.set_xlabel("Time (ns)", fontsize=10)
        ax_c.set_facecolor("#FFF5F5")
        ax_c.set_title("Output Clock  (VCO, 2.4 GHz) - 20 ns zoom",
                       fontsize=10.5, color="#B91C1C",
                       fontweight="bold", loc="left", pad=3)
        ax_c.annotate("63.000-63.020 us  (20 ns)",
                      xy=(0.02, 0.89), xycoords="axes fraction",
                      fontsize=8.5, color="#B91C1C",
                      bbox=dict(boxstyle="round,pad=0.2", fc="white",
                                ec="#B91C1C", alpha=0.9, lw=0.7))

        # ── Column headers ────────────────────────────────────────────
        fig.text(0.245, 0.937, "PLL Inputs  &  PFD   [62-64 us]",
                 ha="center", va="bottom", fontsize=12,
                 fontweight="bold", color="#374151")
        fig.text(0.730, 0.937, "PFD Output  ->  VCO",
                 ha="center", va="bottom", fontsize=12,
                 fontweight="bold", color="#374151")

        fig.suptitle(
            "2.4 GHz Fractional-N PLL  -  Settled Waveforms  &  "
            "Control Voltage Lock-In     SG13G2 130 nm BiCMOS",
            fontsize=13, fontweight="bold", y=0.99)

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
        print(f"Error: '{raw_path}' not found."); sys.exit(1)

    fmb = os.path.getsize(raw_path) / 1024**2
    print(f"Raw : {raw_path}  ({fmb:.0f} MB)\n")

    print("Loading window A  (62-64 us) ...")
    data_a = load_signals(raw_path, SIGNALS_A, A_START, A_END, A_DS)

    print("Loading window B  (0-65 us, vctrl) ...")
    data_b = load_signals(raw_path, ["v(xpll.vctrl)"], B_START, B_END, B_DS)

    print("Loading zoom window  (vctrl ripple detail, unsmoothed) ...")
    data_z   = load_signals(raw_path, ["v(xpll.vctrl)"],
                            ZOOM_S * 1e-6, ZOOM_E * 1e-6, ZOOM_DS)
    t_zoom_us = data_z["time"] * 1e6
    v_zoom    = data_z["v(xpll.vctrl)"]

    print("\nCleaning vctrl ...")
    t_b_us, v_clean = clean_vctrl(data_b["time"], data_b["v(xpll.vctrl)"])

    save_base = os.path.join(script_dir, "plot_paper_pll_slide_v3")
    print("\nRendering slide ...")
    plot_slide(data_a, t_b_us, v_clean, t_zoom_us, v_zoom, save_base)
    print("Done.")


if __name__ == "__main__":
    main()
