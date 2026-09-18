"""End-to-end self-check for the EM -> SPICE toolchain.

Runs the back half of the pipeline (S-parameters -> vector fit -> SPICE subckt
-> circuit solve -> L/Q) against the archived Ansys HFSS results, which are the
reference this design was actually taped out with.

Nothing here needs OpenEMS or ngspice, so it runs anywhere numpy does:

    python em/scripts/validate.py
"""
from __future__ import annotations

import os
import sys

import numpy as np

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from mna import parse_subckt, solve_z, z_to_s, s_to_z, diff_LQ      # noqa: E402
from spice_model import write_subckt                                 # noqa: E402
from vectorfit import eval_fit, vector_fit                           # noqa: E402

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
GOLD_SPICE = os.path.join(ROOT, "spice", "4nH_INDUCTOR.spice")
GOLD_CSV = os.path.join(ROOT, "archive", "hfss", "Results", "Final_Inductor",
                        "Final_inductor.csv")
OUT = os.path.join(ROOT, "em", "out")


def _ref_lq():
    d = np.genfromtxt(GOLD_CSV, delimiter=",", skip_header=1)
    d = d[~np.isnan(d[:, 1])]
    return d[:, 0] * 1e9, d[:, 2], d[:, 1]          # f, L(nH), Q


def main():
    ok = True
    os.makedirs(OUT, exist_ok=True)
    f, Lref, Qref = _ref_lq()
    i245 = int(np.argmin(abs(f - 2.45e9)))

    # -- stage 1: solve the reference model, confirm the solver -------------
    pins, els = parse_subckt(GOLD_SPICE)
    Zg = solve_z(pins, els, f)
    Lg, Qg = diff_LQ(Zg, f)
    e_l = abs(Lg[i245] * 1e9 - Lref[i245]) / Lref[i245] * 100
    e_q = abs(Qg[i245] - Qref[i245]) / Qref[i245] * 100
    print("[1] circuit solver vs HFSS reference CSV")
    print(f"    L = {Lg[i245]*1e9:.4f} nH (ref {Lref[i245]:.4f})   err {e_l:.4f} %")
    print(f"    Q = {Qg[i245]:.4f}    (ref {Qref[i245]:.4f})   err {e_q:.4f} %")
    ok &= e_l < 0.5 and e_q < 0.5

    # -- stage 2: fit its S-parameters -------------------------------------
    Sg = z_to_s(Zg)
    w = np.ones(len(f))
    w[(f >= 2.0e9) & (f <= 3.0e9)] = 5.0        # emphasise the design band
    poles, R, D = vector_fit(f, Sg, n_poles=32, n_iter=20, weight=w)
    Sfit = eval_fit(f, poles, R, D)
    inband = (f >= 0.1e9) & (f <= 12e9)
    err = np.max(np.abs(Sfit - Sg)[:, :, inband])
    print(f"[2] vector fit: {len(poles)} poles, "
          f"max |S| error over 0.1-12 GHz = {err:.3e}")
    ok &= err < 1e-2

    # -- stage 3: emit a subckt and solve it -------------------------------
    path = os.path.join(OUT, "4nH_INDUCTOR_refit.spice")
    write_subckt(path, "4nH_INDUCTOR", poles, R, D,
                 header="self-check: refit of the HFSS reference model")
    pins2, els2 = parse_subckt(path)
    Z2 = solve_z(pins2, els2, f)
    L2, Q2 = diff_LQ(Z2, f)
    e_l2 = abs(L2[i245] * 1e9 - Lref[i245]) / Lref[i245] * 100
    e_q2 = abs(Q2[i245] - Qref[i245]) / Qref[i245] * 100
    print(f"[3] generated subckt ({len(els2)} elements) -> {os.path.relpath(path, ROOT)}")
    print(f"    L = {L2[i245]*1e9:.4f} nH (ref {Lref[i245]:.4f})   err {e_l2:.4f} %")
    print(f"    Q = {Q2[i245]:.4f}    (ref {Qref[i245]:.4f})   err {e_q2:.4f} %")
    ok &= e_l2 < 0.5 and e_q2 < 2.0

    # -- stage 4: band-wide agreement --------------------------------------
    band = (f >= 2.0e9) & (f <= 3.0e9)
    dl = np.max(abs(L2[band] * 1e9 - Lref[band]) / Lref[band]) * 100
    dq = np.max(abs(Q2[band] - Qref[band]) / Qref[band]) * 100
    print(f"[4] 2.0-3.0 GHz band: max L err {dl:.3f} %, max Q err {dq:.3f} %")
    ok &= dl < 1.0 and dq < 3.0

    print("\nRESULT:", "PASS" if ok else "FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
