"""Small-signal MNA solver for the linear subset used by EM-extracted models.

Supports R, C, L, independent V sources (used as 0 V ammeters), VCVS (E),
VCCS (G) and CCCS (F).

Its purpose is to let the toolchain *verify* a generated .subckt reproduces the
target S-parameters without invoking ngspice, so `make check` is fast and has no
simulator dependency.
"""
from __future__ import annotations

import numpy as np

__all__ = ["parse_subckt", "solve_z", "z_to_s", "s_to_z", "diff_LQ"]


def parse_subckt(path, name=None):
    """Return (pins, elements) for a .subckt in `path`.

    `name` selects a specific subcircuit; the first one is used when omitted.
    """
    els, pins, inside = [], [], name is None
    for raw in open(path):
        line = raw.split("*")[0].strip() if raw.lstrip().startswith("*") else raw.strip()
        if not line or line.startswith("*"):
            continue
        low = line.lower()
        if low.startswith(".subckt"):
            tok = line.split()
            if name is None or tok[1] == name:
                pins, inside = tok[2:], True
            continue
        if low.startswith(".ends"):
            if inside:
                break
            continue
        if inside and not line.startswith("."):
            els.append(line.split())
    if not pins:
        raise ValueError(f"no .subckt {name or ''} found in {path}")
    return pins, els


def _num(tok):
    """SPICE number with optional engineering suffix."""
    suf = {"t": 1e12, "g": 1e9, "meg": 1e6, "k": 1e3, "m": 1e-3,
           "u": 1e-6, "n": 1e-9, "p": 1e-12, "f": 1e-15}
    t = tok.lower()
    try:
        return float(t)
    except ValueError:
        pass
    for s in ("meg", "t", "g", "k", "m", "u", "n", "p", "f"):
        if t.endswith(s):
            try:
                return float(t[: -len(s)]) * suf[s]
            except ValueError:
                break
    raise ValueError(f"cannot parse number {tok!r}")


def solve_z(pins, els, freqs):
    """Z-parameters (nport, nport, nfreq) seen from `pins`."""
    nodes: dict[str, int] = {}

    def nid(n):
        return -1 if n == "0" else nodes.setdefault(n, len(nodes))

    for p in pins:
        nid(p)

    vsrc, evs, stamps = [], [], []
    for t in els:
        k = t[0][0].upper()
        if k in "RCL":
            stamps.append((k, nid(t[1]), nid(t[2]), _num(t[3])))
        elif k == "V":
            vsrc.append((t[0].upper(), nid(t[1]), nid(t[2])))
        elif k == "E":                       # E n+ n- nc+ nc- gain
            evs.append((t[0].upper(), nid(t[1]), nid(t[2]),
                        nid(t[3]), nid(t[4]), _num(t[5])))
        elif k == "G":                       # G n+ n- nc+ nc- gain
            stamps.append(("G", nid(t[1]), nid(t[2]), nid(t[3]), nid(t[4]), _num(t[5])))
        elif k == "F":                       # F n+ n- Vname gain
            stamps.append(("F", nid(t[1]), nid(t[2]), t[3].upper(), _num(t[4])))
        else:
            raise ValueError(f"unsupported element {t[0]!r}")

    nn = len(nodes)
    aux = [v[0] for v in vsrc] + [e[0] for e in evs]
    amap = {n: nn + i for i, n in enumerate(aux)}
    dim = nn + len(aux)
    npn = len(pins)
    Z = np.zeros((npn, npn, len(freqs)), complex)

    def add(Y, r, c, v):
        if r >= 0 and c >= 0:
            Y[r, c] += v

    for fi, f in enumerate(freqs):
        s = 2j * np.pi * f
        Y = np.zeros((dim, dim), complex)
        for st in stamps:
            if st[0] in "RCL":
                k, a, b, v = st
                y = 1.0 / v if k == "R" else (s * v if k == "C" else 1.0 / (s * v))
                add(Y, a, a, y); add(Y, b, b, y); add(Y, a, b, -y); add(Y, b, a, -y)
            elif st[0] == "G":
                _, p, m, cp, cm, g = st
                add(Y, p, cp, g); add(Y, p, cm, -g)
                add(Y, m, cp, -g); add(Y, m, cm, g)
            else:                                     # F
                _, p, m, vn, g = st
                j = amap[vn]
                add(Y, p, j, g); add(Y, m, j, -g)
        for name, a, b in vsrc:
            j = amap[name]
            add(Y, a, j, 1.0); add(Y, b, j, -1.0)
            add(Y, j, a, 1.0); add(Y, j, b, -1.0)
        for name, a, b, cp, cm, g in evs:
            j = amap[name]
            add(Y, a, j, 1.0); add(Y, b, j, -1.0)
            add(Y, j, a, 1.0); add(Y, j, b, -1.0)
            add(Y, j, cp, -g); add(Y, j, cm, g)

        lu = np.linalg.inv(Y)
        for k in range(npn):
            rhs = np.zeros(dim, complex)
            rhs[nid(pins[k])] = 1.0                   # inject 1 A into pin k
            x = lu @ rhs
            for r in range(npn):
                Z[r, k, fi] = x[nid(pins[r])]
    return Z


def z_to_s(Z, Z0=50.0):
    n = Z.shape[0]
    I = np.eye(n)
    S = np.empty_like(Z)
    for fi in range(Z.shape[2]):
        z = Z[:, :, fi] / Z0
        S[:, :, fi] = (z - I) @ np.linalg.inv(z + I)
    return S


def s_to_z(S, Z0=50.0):
    n = S.shape[0]
    I = np.eye(n)
    Z = np.empty_like(S)
    for fi in range(S.shape[2]):
        s = S[:, :, fi]
        Z[:, :, fi] = Z0 * (I + s) @ np.linalg.inv(I - s)
    return Z


def diff_LQ(Z, freqs):
    """Differential inductance [H] and quality factor from 2-port Z."""
    zd = Z[0, 0] - Z[0, 1] - Z[1, 0] + Z[1, 1]
    return zd.imag / (2 * np.pi * np.asarray(freqs)), zd.imag / zd.real
