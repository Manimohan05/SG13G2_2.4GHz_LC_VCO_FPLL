"""Build an OpenEMS/CSXCAD model of a spiral inductor from its GDS layout.

Reads the polygons of the metal and via layers, extrudes each into the z-range
the SG13G2 stackup gives it, adds the dielectric stack and substrate, meshes,
and attaches lumped ports.

Requires the openEMS python bindings (``openEMS``/``CSXCAD``); everything up to
the point where they are needed runs without them so the geometry can be
inspected on a machine that has no solver installed.
"""
from __future__ import annotations

import os
import sys

import numpy as np

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from gds_geometry import bounds, read_gds          # noqa: E402
from sg13g2_stackup import load_stackup            # noqa: E402

__all__ = ["collect_layers", "build", "PORT_LAYER"]

PORT_LAYER = "TopMetal2"


def collect_layers(gds, topcell=None, stackup=None, layer_names=None):
    """Return {layer_name: [polygon, ...]} for the layers the model needs."""
    st = stackup or load_stackup()
    names = layer_names or ["TopMetal2", "TopMetal1", "TopVia2"]
    wanted = {}
    for n in names:
        if n not in st.layers:
            raise KeyError(f"{n} not in stackup")
        wanted[st.layers[n].gds_layer] = n

    top, polys = read_gds(gds, topcell, layers=wanted.keys())
    out = {n: [] for n in names}
    for p in polys:
        out[wanted[p.layer]].append(p.points)
    return top, out, st


def _mesh_lines(lo, hi, coarse, refine_at=(), refine=0.5, pad=0.0):
    """Graded mesh: `coarse` everywhere, `refine` near the listed coordinates."""
    lines = list(np.arange(lo - pad, hi + pad + coarse, coarse))
    for x in refine_at:
        lines += list(np.arange(x - 3 * refine, x + 3 * refine + refine, refine))
    lines = np.unique(np.round(np.array(lines), 6))
    return lines[(lines >= lo - pad - 1e-9) & (lines <= hi + pad + 1e-9)]


def build(cfg):
    """Construct the FDTD model. Returns (FDTD, CSX, port_list)."""
    try:
        from CSXCAD import ContinuousStructure
        from openEMS import openEMS
    except ImportError as exc:                       # pragma: no cover
        raise SystemExit(
            "openEMS python bindings not found.\n"
            "Install openEMS with python bindings, or run the pipeline with\n"
            "--stage fit to use an existing Touchstone file instead."
        ) from exc

    g = cfg["geometry"]
    sim = cfg["simulation"]
    top, layers, st = collect_layers(g["gds"], g.get("topcell"),
                                     layer_names=g.get("layers"))

    fmax = float(sim["f_stop"])
    fdtd = openEMS(NrTS=int(sim.get("max_timesteps", 60000)),
                   EndCriteria=float(sim.get("end_criteria", 1e-5)))
    fdtd.SetGaussExcite((float(sim["f_start"]) + fmax) / 2.0,
                        (fmax - float(sim["f_start"])) / 2.0)
    fdtd.SetBoundaryCond(sim.get("boundary", ["MUR"] * 6))

    csx = ContinuousStructure()
    fdtd.SetCSX(csx)
    grid = csx.GetGrid()
    grid.SetDeltaUnit(1e-6)                          # model is in micrometres

    # --- conductors -----------------------------------------------------
    all_pts = [p for v in layers.values() for p in v]
    xmin, ymin, xmax, ymax = bounds_of(all_pts)
    for name, polys in layers.items():
        if not polys:
            continue
        lay = st.layers[name]
        sigma = st.materials[lay.material].conductivity
        mat = csx.AddMaterial(name, kappa=sigma)
        for pts in polys:
            mat.AddLinPoly(points=np.asarray(pts).T, norm_dir="z",
                           elevation=lay.zmin, length=lay.thickness, priority=10)

    # --- dielectric stack and substrate ---------------------------------
    pad = float(sim.get("air_padding_um", 200.0))
    zt = max(st.layers[n].zmax for n in layers)
    for d in cfg.get("dielectrics", []):
        m = csx.AddMaterial(d["name"], epsilon=d["epsilon"],
                            kappa=d.get("kappa", 0.0))
        m.AddBox([xmin - pad, ymin - pad, d["zmin"]],
                 [xmax + pad, ymax + pad, d["zmax"]], priority=1)

    # --- mesh ------------------------------------------------------------
    fine = float(sim.get("refined_cellsize_um", 0.5))
    coarse = float(sim.get("cellsize_um", 8.0))
    edges_x, edges_y = edge_coords(all_pts)
    grid.AddLine("x", _mesh_lines(xmin, xmax, coarse, edges_x, fine, pad))
    grid.AddLine("y", _mesh_lines(ymin, ymax, coarse, edges_y, fine, pad))
    zs = sorted({st.layers[n].zmin for n in layers} | {st.layers[n].zmax for n in layers})
    zlines = list(np.arange(-float(sim.get("substrate_um", 280.0)), zt + pad, coarse * 2))
    for z in zs:
        zlines += [z - fine, z, z + fine]
    grid.AddLine("z", np.unique(np.round(zlines, 6)))
    grid.SmoothMeshLines("all", coarse, 1.4)

    # --- ports ------------------------------------------------------------
    ports = []
    lay = st.layers[PORT_LAYER]
    for i, p in enumerate(cfg["ports"], start=1):
        start = [p["x0"], p["y0"], lay.zmin]
        stop = [p["x1"], p["y1"], lay.zmax]
        ports.append(fdtd.AddLumpedPort(i, float(p.get("z0", 50.0)), start, stop,
                                        p.get("direction", "y"),
                                        excite=1.0 if i == 1 else 0.0,
                                        priority=50))
    return fdtd, csx, ports, top


def bounds_of(polys):
    a = np.vstack([np.asarray(p) for p in polys])
    return a[:, 0].min(), a[:, 1].min(), a[:, 0].max(), a[:, 1].max()


def edge_coords(polys, tol=6):
    """Unique x and y coordinates of polygon vertices, for mesh refinement."""
    a = np.vstack([np.asarray(p) for p in polys])
    return np.unique(np.round(a[:, 0], tol)), np.unique(np.round(a[:, 1], tol))


if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser(description="inspect the GDS geometry an EM run would use")
    ap.add_argument("gds")
    ap.add_argument("--topcell")
    a = ap.parse_args()
    top, layers, st = collect_layers(a.gds, a.topcell)
    print(f"top cell: {top}")
    for n, p in layers.items():
        lay = st.layers[n]
        if p:
            b = bounds_of(p)
            print(f"  {n:<10} {len(p):5d} polys  z {lay.zmin:8.4f}..{lay.zmax:8.4f} um  "
                  f"extent {b[2]-b[0]:7.1f} x {b[3]-b[1]:7.1f} um  "
                  f"sigma {st.materials[lay.material].conductivity:.3g}")
        else:
            print(f"  {n:<10}     0 polys")
