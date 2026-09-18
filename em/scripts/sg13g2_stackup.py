"""IHP SG13G2 back-end-of-line stackup.

Parsed from the PDK stackup XML (``em/stackup/sg13g2_stackup.xml``) so the EM
model and the foundry agree on layer heights, thicknesses and conductivities
rather than hard-coding numbers in the solver script.
"""
from __future__ import annotations

import os
import xml.etree.ElementTree as ET
from dataclasses import dataclass

__all__ = ["Layer", "Material", "Stackup", "load_stackup", "DEFAULT_XML"]

DEFAULT_XML = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                           "..", "stackup", "sg13g2_stackup.xml")


@dataclass
class Material:
    name: str
    kind: str
    epsilon: float
    loss_tangent: float
    conductivity: float


@dataclass
class Layer:
    name: str
    kind: str          # "conductor" or "via"
    zmin: float        # micrometres
    zmax: float
    material: str
    gds_layer: int

    @property
    def thickness(self):
        return self.zmax - self.zmin


@dataclass
class Stackup:
    materials: dict
    layers: dict
    substrate_offset: float = 283.75
    unit_um: float = 1.0

    def by_gds(self, num):
        for l in self.layers.values():
            if l.gds_layer == num:
                return l
        return None

    def material_of(self, layer):
        return self.materials[self.layers[layer].material]

    def conductivity(self, layer):
        return self.material_of(layer).conductivity

    def summary(self):
        rows = sorted(self.layers.values(), key=lambda l: -l.zmax)
        w = ["  {:<10} {:>4}  z = {:>9.4f} .. {:>9.4f} um  t = {:>7.4f}  sigma = {:.3g}".format(
            l.name, l.gds_layer, l.zmin, l.zmax, l.thickness,
            self.materials[l.material].conductivity) for l in rows]
        return "\n".join(w)


def load_stackup(path=None):
    path = os.path.abspath(path or DEFAULT_XML)
    root = ET.parse(path).getroot()

    mats = {}
    for m in root.iter("Material"):
        mats[m.get("Name")] = Material(
            m.get("Name"), m.get("Type", "").lower(),
            float(m.get("Permittivity", 1)),
            float(m.get("DielectricLossTangent", 0)),
            float(m.get("Conductivity", 0)))

    layers, offset = {}, 283.75
    for l in root.iter("Layer"):
        layers[l.get("Name")] = Layer(
            l.get("Name"), l.get("Type", "conductor"),
            float(l.get("Zmin")), float(l.get("Zmax")),
            l.get("Material"), int(l.get("Layer")))
    sub = root.find(".//Substrate")
    if sub is not None:
        offset = float(sub.get("Offset", offset))

    unit = 1.0
    el = root.find("ELayers")
    if el is not None and el.get("LengthUnit", "um") != "um":
        unit = 1e-3 if el.get("LengthUnit") == "mm" else 1.0
    return Stackup(mats, layers, offset, unit)


if __name__ == "__main__":
    st = load_stackup()
    print(f"materials: {len(st.materials)}   layers: {len(st.layers)}")
    print(st.summary())
