"""GDS -> EM -> de-embed -> vector fit -> ngspice .subckt.

Stages (``--stage`` runs one, the default runs all that are possible):

  geom    read the GDS and report what the EM model will contain
  em      build and run the OpenEMS FDTD solve, write raw Touchstone
  deembed two-step open-short de-embedding
  extract differential L and Q, summary and plot
  fit     vector-fit the S-parameters and write the SPICE subcircuit
  check   solve the generated subcircuit and confirm it reproduces L and Q

``em`` needs OpenEMS installed. Every other stage needs only numpy, so a
Touchstone file from any solver can be dropped in and fitted.
"""
from __future__ import annotations

import argparse
import json
import os
import sys

import numpy as np

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import extract_lq as lq                                              # noqa: E402
from mna import diff_LQ as mna_LQ, parse_subckt, solve_z             # noqa: E402
from spice_model import write_subckt                                 # noqa: E402
from touchstone import read_touchstone, write_touchstone             # noqa: E402
from vectorfit import eval_fit, vector_fit                           # noqa: E402

STAGES = ["geom", "em", "deembed", "extract", "fit", "check"]


def load_cfg(path):
    with open(path) as fh:
        if path.endswith((".yaml", ".yml")):
            import yaml
            return yaml.safe_load(fh)
        return json.load(fh)


def _p(cfg, *parts):
    return os.path.normpath(os.path.join(cfg["_dir"], *parts))


def stage_geom(cfg):
    from build_openems import bounds_of, collect_layers
    g = cfg["geometry"]
    top, layers, st = collect_layers(_p(cfg, g["gds"]), g.get("topcell"),
                                     layer_names=g.get("layers"))
    print(f"top cell: {top}")
    for n, polys in layers.items():
        lay = st.layers[n]
        if polys:
            b = bounds_of(polys)
            print(f"  {n:<10} {len(polys):5d} polys  z {lay.zmin:8.4f}..{lay.zmax:8.4f}"
                  f"  extent {b[2]-b[0]:7.1f} x {b[3]-b[1]:7.1f} um")
        else:
            print(f"  {n:<10}     0 polys")


def stage_em(cfg):
    from build_openems import build
    out = _p(cfg, cfg["output"]["dir"])
    os.makedirs(out, exist_ok=True)
    g = dict(cfg["geometry"]); g["gds"] = _p(cfg, g["gds"])
    sub = dict(cfg, geometry=g)
    fdtd, csx, ports, top = build(sub)
    run = os.path.join(out, "openems")
    fdtd.Run(run, verbose=int(cfg["simulation"].get("verbose", 1)), cleanup=True)

    f = np.linspace(float(cfg["simulation"]["f_start"]),
                    float(cfg["simulation"]["f_stop"]),
                    int(cfg["simulation"].get("n_freq", 401)))
    for p in ports:
        p.CalcPort(run, f)
    n = len(ports)
    S = np.zeros((n, n, len(f)), complex)
    for i, pi in enumerate(ports):
        for j, pj in enumerate(ports):
            S[i, j] = (pi.uf_ref / pj.uf_inc) if i != j else (pi.uf_ref / pi.uf_inc)
    raw = os.path.join(out, cfg["output"].get("raw_s2p", "inductor_raw.s2p"))
    write_touchstone(raw, f, S, comments=[f"OpenEMS raw {top}"])
    print(f"wrote {raw}")


def stage_deembed(cfg):
    out = _p(cfg, cfg["output"]["dir"])
    raw = os.path.join(out, cfg["output"].get("raw_s2p", "inductor_raw.s2p"))
    f, S, z0, _ = read_touchstone(raw)
    dd = cfg.get("deembed", {})
    op, sh = dd.get("open_s2p"), dd.get("short_s2p")
    if op and sh:
        fo, So, _, _ = read_touchstone(_p(cfg, op))
        fs, Ss, _, _ = read_touchstone(_p(cfg, sh))
        S = lq.deembed_open_short(S, So, Ss, z0)
        print("applied two-step open-short de-embedding")
    elif op:
        fo, So, _, _ = read_touchstone(_p(cfg, op))
        S = lq.deembed_open(S, So, z0)
        print("applied open de-embedding only")
    else:
        print("no open/short structures configured - passing raw S through")
    dst = os.path.join(out, cfg["output"].get("deembedded_s2p", "inductor.s2p"))
    write_touchstone(dst, f, S, z0=z0, comments=["de-embedded"])
    print(f"wrote {dst}")


def _load_S(cfg):
    out = _p(cfg, cfg["output"]["dir"])
    for key, default in (("deembedded_s2p", "inductor.s2p"),
                         ("raw_s2p", "inductor_raw.s2p")):
        p = os.path.join(out, cfg["output"].get(key, default))
        if os.path.exists(p):
            return read_touchstone(p)
    src = cfg.get("input_s2p")
    if src:
        return read_touchstone(_p(cfg, src))
    raise SystemExit("no S-parameter file; run the em stage or set input_s2p")


def stage_extract(cfg):
    f, S, z0, _ = _load_S(cfg)
    L, Q = lq.diff_LQ(S, f, z0)
    f0 = float(cfg.get("target", {}).get("f0", 2.45e9))
    s = lq.summarise(f, L, Q, f0)
    print(f"  L_diff({s['f0']/1e9:.3f} GHz) = {s['L_f0']*1e9:.4f} nH")
    print(f"  Q_diff({s['f0']/1e9:.3f} GHz) = {s['Q_f0']:.3f}")
    print(f"  peak Q = {s['Q_peak']:.3f} at {s['f_Q_peak']/1e9:.3f} GHz")
    srf = "n/a (above sweep)" if s["SRF"] is None else f"{s['SRF']/1e9:.3f} GHz"
    print(f"  SRF    = {srf}")
    out = _p(cfg, cfg["output"]["dir"])
    os.makedirs(out, exist_ok=True)
    png = os.path.join(out, "inductor_LQ.png")
    lq.plot(f, L, Q, png, cfg.get("name", "Spiral inductor"), f0)
    with open(os.path.join(out, "summary.json"), "w") as fh:
        json.dump(s, fh, indent=2)
    print(f"  wrote {png}")


def stage_fit(cfg):
    f, S, z0, _ = _load_S(cfg)
    fit = cfg.get("fit", {})
    w = np.ones(len(f))
    band = fit.get("emphasis_band")
    if band:
        m = (f >= float(band[0])) & (f <= float(band[1]))
        w[m] = float(fit.get("emphasis_weight", 5.0))
    poles, R, D = vector_fit(f, S, n_poles=int(fit.get("n_poles", 32)),
                             n_iter=int(fit.get("n_iter", 20)), weight=w)
    err = np.max(np.abs(eval_fit(f, poles, R, D) - S))
    print(f"  {len(poles)} poles, max |S| fit error = {err:.3e}")
    out = _p(cfg, cfg["output"]["dir"])
    os.makedirs(out, exist_ok=True)
    dst = os.path.join(out, cfg["output"].get("spice", "inductor.spice"))
    write_subckt(dst, cfg.get("subckt", "INDUCTOR"), poles, R, D, z0,
                 header=f"source: {cfg.get('name', '')}\nfit error {err:.3e}")
    print(f"  wrote {dst}")


def stage_check(cfg):
    f, S, z0, _ = _load_S(cfg)
    out = _p(cfg, cfg["output"]["dir"])
    dst = os.path.join(out, cfg["output"].get("spice", "inductor.spice"))
    Lr, Qr = lq.diff_LQ(S, f, z0)
    pins, els = parse_subckt(dst)
    L, Q = mna_LQ(solve_z(pins, els, f), f)
    f0 = float(cfg.get("target", {}).get("f0", 2.45e9))
    i = int(np.argmin(abs(f - f0)))
    el = abs(L[i] - Lr[i]) / abs(Lr[i]) * 100
    eq = abs(Q[i] - Qr[i]) / abs(Qr[i]) * 100
    print(f"  model  L = {L[i]*1e9:.4f} nH  Q = {Q[i]:.3f}")
    print(f"  target L = {Lr[i]*1e9:.4f} nH  Q = {Qr[i]:.3f}")
    print(f"  error  L = {el:.3f} %   Q = {eq:.3f} %")
    tol = cfg.get("tolerance", {})
    ok = el <= float(tol.get("L_percent", 1.0)) and eq <= float(tol.get("Q_percent", 3.0))
    print("  RESULT:", "PASS" if ok else "FAIL")
    return 0 if ok else 1


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--config", required=True)
    ap.add_argument("--stage", choices=STAGES, action="append",
                    help="run only this stage (repeatable)")
    a = ap.parse_args()

    cfg = load_cfg(a.config)
    cfg["_dir"] = os.path.dirname(os.path.abspath(a.config))
    stages = a.stage or ["geom", "deembed", "extract", "fit", "check"]
    rc = 0
    for s in stages:
        print(f"\n== {s} ==")
        rc = globals()[f"stage_{s}"](cfg) or 0
        if rc:
            break
    return rc


if __name__ == "__main__":
    raise SystemExit(main())
