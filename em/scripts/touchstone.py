"""Minimal Touchstone (.s1p/.s2p) reader and writer.

Kept dependency-free on purpose: the EM flow should run with nothing but numpy.
Supports MA / DB / RI formats and Hz..GHz frequency units, S/Y/Z parameters.
"""
from __future__ import annotations

import numpy as np

__all__ = ["read_touchstone", "write_touchstone"]

_MUL = {"hz": 1.0, "khz": 1e3, "mhz": 1e6, "ghz": 1e9}


def read_touchstone(path):
    """Return (freqs_Hz, data[nport,nport,nfreq] complex, z0, kind)."""
    unit, kind, fmt, z0 = 1e9, "s", "ma", 50.0
    rows = []
    first_len = None
    for raw in open(path):
        line = raw.split("!")[0].strip()
        if not line:
            continue
        if line.startswith("#"):
            tok = line[1:].lower().split()
            i = 0
            while i < len(tok):
                t = tok[i]
                if t in _MUL:
                    unit = _MUL[t]
                elif t in ("s", "y", "z", "h", "g"):
                    kind = t
                elif t in ("ma", "db", "ri"):
                    fmt = t
                elif t == "r":
                    z0 = float(tok[i + 1]); i += 1
                i += 1
            continue
        tok = line.split()
        if first_len is None:
            first_len = len(tok)
        rows.extend(tok)

    vals = np.array(rows, float)

    # 1- and 2-port files put one frequency per line, so the first data line
    # settles the port count unambiguously (3 tokens -> 1 port, 9 -> 2 ports).
    # Anything else is wrapped across lines, so fall back to a divisibility
    # scan, preferring the largest port count that fits.
    nport = None
    if first_len == 3:
        nport = 1
    elif first_len == 9:
        nport = 2
    else:
        for n in (8, 4, 3, 2, 1):
            if vals.size % (1 + 2 * n * n) == 0:
                nport = n
                break
    if nport is None:
        raise ValueError(f"cannot infer port count from {path}")
    rec = 1 + 2 * nport * nport
    if vals.size % rec:
        raise ValueError(f"{path}: {vals.size} values is not a multiple of {rec}")

    vals = vals.reshape(-1, rec)
    f = vals[:, 0] * unit
    body = vals[:, 1:].reshape(len(f), nport * nport, 2)
    if fmt == "ri":
        c = body[:, :, 0] + 1j * body[:, :, 1]
    elif fmt == "ma":
        c = body[:, :, 0] * np.exp(1j * np.deg2rad(body[:, :, 1]))
    else:                                        # db
        c = 10 ** (body[:, :, 0] / 20.0) * np.exp(1j * np.deg2rad(body[:, :, 1]))

    data = np.empty((nport, nport, len(f)), complex)
    for k in range(len(f)):
        m = c[k].reshape(nport, nport)
        # 2-port Touchstone is written S11 S21 S12 S22
        data[:, :, k] = m.T if nport == 2 else m
    return f, data, z0, kind


def write_touchstone(path, freqs, data, z0=50.0, kind="s", unit="ghz", fmt="ri",
                     comments=()):
    nport = data.shape[0]
    mul = _MUL[unit]
    with open(path, "w") as fh:
        for c in comments:
            fh.write(f"! {c}\n")
        fh.write(f"# {unit.upper()} {kind.upper()} {fmt.upper()} R {z0:g}\n")
        for k, f in enumerate(freqs):
            m = data[:, :, k]
            seq = (m.T if nport == 2 else m).reshape(-1)
            parts = [f"{f / mul:.9g}"]
            for v in seq:
                if fmt == "ri":
                    parts += [f"{v.real:.9g}", f"{v.imag:.9g}"]
                elif fmt == "ma":
                    parts += [f"{abs(v):.9g}", f"{np.rad2deg(np.angle(v)):.9g}"]
                else:
                    mag = 20 * np.log10(max(abs(v), 1e-300))
                    parts += [f"{mag:.9g}", f"{np.rad2deg(np.angle(v)):.9g}"]
            fh.write(" ".join(parts) + "\n")
    return path
