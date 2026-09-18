"""Dependency-free GDSII reader.

Only what the EM flow needs: flatten a cell hierarchy to polygons tagged with
(layer, datatype), honouring SREF/AREF placement, rotation, magnification and
x-reflection. Paths are converted to polygons using their width and end type.

gdstk/gdspy are excellent but drag in a build toolchain; the EM flow should
stay runnable with nothing but numpy.
"""
from __future__ import annotations

import struct
from dataclasses import dataclass, field

import numpy as np

__all__ = ["read_gds", "Cell", "Polygon"]

# record types we care about
_HEADER, _BGNLIB, _LIBNAME, _UNITS = 0x0002, 0x0102, 0x0206, 0x0305
_BGNSTR, _STRNAME, _ENDSTR = 0x0502, 0x0606, 0x0700
_BOUNDARY, _PATH, _SREF, _AREF, _ENDEL = 0x0800, 0x0900, 0x0A00, 0x0B00, 0x1100
_LAYER, _DATATYPE, _WIDTH, _XY = 0x0D02, 0x0E02, 0x0F03, 0x1003
_SNAME, _COLROW, _STRANS, _MAG, _ANGLE = 0x1206, 0x1302, 0x1A01, 0x1B05, 0x1C05
_PATHTYPE, _ENDLIB = 0x2102, 0x0400


def _real8(b):
    """GDSII 8-byte excess-64 float."""
    v = int.from_bytes(b, "big")
    sign = -1 if v >> 63 else 1
    exp = ((v >> 56) & 0x7F) - 64
    mant = v & 0x00FFFFFFFFFFFFFF
    return sign * mant * (16.0 ** exp) / (1 << 56)


@dataclass
class Polygon:
    layer: int
    datatype: int
    points: np.ndarray            # (n, 2) in micrometres


@dataclass
class Cell:
    name: str
    polygons: list = field(default_factory=list)
    refs: list = field(default_factory=list)    # (name, origin, angle, mag, mirror, cols, rows, sp)


def _records(fh):
    while True:
        head = fh.read(4)
        if len(head) < 4:
            return
        size, rtype = struct.unpack(">HH", head)
        data = fh.read(size - 4) if size > 4 else b""
        yield rtype, data


def _parse(path):
    cells, cur, el = {}, None, None
    unit_um = 1.0
    with open(path, "rb") as fh:
        for rtype, data in _records(fh):
            if rtype == _UNITS:
                # user-unit in metres -> micrometres per database unit
                unit_um = _real8(data[8:16]) * 1e6
            elif rtype == _BGNSTR:
                cur = None
            elif rtype == _STRNAME:
                name = data.rstrip(b"\x00").decode("ascii", "replace")
                cur = cells.setdefault(name, Cell(name))
            elif rtype in (_BOUNDARY, _PATH, _SREF, _AREF):
                el = {"kind": rtype, "layer": 0, "dtype": 0, "width": 0.0,
                      "pathtype": 0, "xy": None, "sname": None, "angle": 0.0,
                      "mag": 1.0, "mirror": False, "cols": 1, "rows": 1}
            elif el is not None and rtype == _LAYER:
                el["layer"] = struct.unpack(">h", data[:2])[0]
            elif el is not None and rtype == _DATATYPE:
                el["dtype"] = struct.unpack(">h", data[:2])[0]
            elif el is not None and rtype == _WIDTH:
                el["width"] = struct.unpack(">i", data[:4])[0]
            elif el is not None and rtype == _PATHTYPE:
                el["pathtype"] = struct.unpack(">h", data[:2])[0]
            elif el is not None and rtype == _XY:
                n = len(data) // 8
                xy = np.array(struct.unpack(f">{2*n}i", data), float).reshape(n, 2)
                el["xy"] = xy
            elif el is not None and rtype == _SNAME:
                el["sname"] = data.rstrip(b"\x00").decode("ascii", "replace")
            elif el is not None and rtype == _STRANS:
                el["mirror"] = bool(struct.unpack(">H", data[:2])[0] & 0x8000)
            elif el is not None and rtype == _MAG:
                el["mag"] = _real8(data[:8])
            elif el is not None and rtype == _ANGLE:
                el["angle"] = _real8(data[:8])
            elif el is not None and rtype == _COLROW:
                el["cols"], el["rows"] = struct.unpack(">hh", data[:4])
            elif rtype == _ENDEL and el is not None and cur is not None:
                _finish(cur, el, unit_um)
                el = None
    return cells, unit_um


def _finish(cell, el, u):
    k = el["kind"]
    if k == _BOUNDARY and el["xy"] is not None:
        cell.polygons.append(Polygon(el["layer"], el["dtype"], el["xy"] * u))
    elif k == _PATH and el["xy"] is not None:
        w = el["width"] * u
        if w > 0:
            for poly in _path_to_polys(el["xy"] * u, w, el["pathtype"]):
                cell.polygons.append(Polygon(el["layer"], el["dtype"], poly))
    elif k == _SREF and el["xy"] is not None:
        cell.refs.append((el["sname"], el["xy"][0] * u, el["angle"],
                          el["mag"], el["mirror"], 1, 1, None))
    elif k == _AREF and el["xy"] is not None:
        p = el["xy"] * u
        cell.refs.append((el["sname"], p[0], el["angle"], el["mag"], el["mirror"],
                          el["cols"], el["rows"], (p[1], p[2])))


def _path_to_polys(pts, width, pathtype):
    """Rectangle per segment plus a square at each joint - adequate for
    Manhattan/45-degree RF metal, and mesh-friendly."""
    out, h = [], width / 2.0
    for a, b in zip(pts[:-1], pts[1:]):
        d = b - a
        n = np.hypot(*d)
        if n == 0:
            continue
        d = d / n
        if pathtype in (1, 2):                       # round / square extension
            a = a - d * h
            b = b + d * h
        p = np.array([-d[1], d[0]]) * h
        out.append(np.array([a + p, b + p, b - p, a - p]))
    for q in pts[1:-1]:
        out.append(np.array([q + [-h, -h], q + [h, -h], q + [h, h], q + [-h, h]]))
    return out


def _xf(pts, origin, angle, mag, mirror):
    p = np.asarray(pts, float) * mag
    if mirror:
        p = p * [1.0, -1.0]
    if angle:
        t = np.deg2rad(angle)
        c, s = np.cos(t), np.sin(t)
        p = p @ np.array([[c, s], [-s, c]])
    return p + origin


def read_gds(path, topcell=None, layers=None, max_depth=24):
    """Flatten `topcell` (or the sole root cell) to a list of Polygon."""
    cells, _ = _parse(path)
    if not cells:
        raise ValueError(f"no structures in {path}")
    if topcell is None:
        referenced = {r[0] for c in cells.values() for r in c.refs}
        # $$$CONTEXT_INFO$$$ is KLayout bookkeeping, never a real top cell
        roots = [n for n in cells
                 if n not in referenced and not n.startswith("$$$")]
        if len(roots) != 1:
            raise ValueError(f"specify topcell; candidates: {sorted(roots) or sorted(cells)}")
        topcell = roots[0]

    want = None if layers is None else {int(l) for l in layers}
    out = []

    def walk(name, origin, angle, mag, mirror, depth):
        if depth > max_depth or name not in cells:
            return
        c = cells[name]
        for poly in c.polygons:
            if want is None or poly.layer in want:
                out.append(Polygon(poly.layer, poly.datatype,
                                   _xf(poly.points, origin, angle, mag, mirror)))
        for (sn, org, ang, m, mir, cols, rows, sp) in c.refs:
            base = _xf(org, origin, angle, mag, mirror)
            if cols > 1 or rows > 1:
                cv = (sp[0] - org) / max(cols, 1)
                rv = (sp[1] - org) / max(rows, 1)
                for i in range(cols):
                    for j in range(rows):
                        off = _xf(org + cv * i + rv * j, origin, angle, mag, mirror)
                        walk(sn, off, angle + ang, mag * m, mirror ^ mir, depth + 1)
            else:
                walk(sn, base, angle + ang, mag * m, mirror ^ mir, depth + 1)

    walk(topcell, np.zeros(2), 0.0, 1.0, False, 0)
    return topcell, out


def bounds(polys):
    if not polys:
        return None
    a = np.vstack([p.points for p in polys])
    return a[:, 0].min(), a[:, 1].min(), a[:, 0].max(), a[:, 1].max()
