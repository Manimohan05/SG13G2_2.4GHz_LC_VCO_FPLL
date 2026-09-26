# UNIC-CASS 2025 — Final Chip (Team 1)

Top-level integration of the three Team 1 analog designs behind the UNIC-CASS pad ring.
It was produced in the Team 1 integration repository and is copied here unchanged.

| | |
|---|---|
| Integration repository | <https://github.com/manuel-monge/unic-cass-2025-analog-team1> (state after PR #10, 2026-09-25) |
| Top cell | `MPC0388` — `team1` + `sealring` + fill cells |
| Die | 2000 µm × 2000 µm |
| Technology | IHP SG13G2 |

## Contents

| File | Description |
|---|---|
| `MPC0388.gds.gz` | Final chip layout, gzip-compressed (64.8 MB uncompressed). Unpack with `gunzip -k MPC0388.gds.gz`. |
| `xschem/MPC0388.sch` | Chip-level schematic (identical to the integration repository's `top.sch`) |
| `xschem/team1.sch`, `team1.sym` | `team1` — the three designs and their routing |
| `xschem/user_project_wrapper_team1.sch`, `.sym` | Pad-ring wrapper with the pad-to-signal mapping |

The integration repository contains no simulation decks or netlists for the chip, so none are
included. The design is verified block by block in this repository; see the main
[README](../../README.md).

## Cell hierarchy

```
MPC0388                              2000 × 2000 µm
├── team1
│   ├── LC_VCO_FPLL                  this repository's PLL, rotated 90°, x 697–1363, y 754–1659 µm
│   ├── XPCAM   (TOP_XPCAM)          x 1435–1618, y 612–724 µm
│   ├── multiplier_top               x 448–622,  y 1107–1386 µm
│   ├── Connections                  routing between the pads and the three blocks
│   └── user_project_wrapper_team1   pad ring (analog, RF and digital-input pads, bond pads)
├── sealring
└── density fill cells               about 13.6 thousand instances (Act, GatP, Met1–Met5, TM1, TM2)
```

## Provenance of the integrated designs

Taken from the integration repository's README.

| Design | Top cell | Repository | Commit |
|---|---|---|---|
| PLL | `LC_VCO_FPLL` | <https://github.com/avishkaherath/LC_VCO_FPLL> | `bc5ef31` |
| XPCAM | `TOP_XPCAM` | <https://github.com/EstebanJGC/IHP__CMP9794> (branch `sept-update`) | `0c15edb` |
| Multiplier | `multiplier_top` | <https://github.com/LohanAtapattu/Unic_Cass_IHP> | `156b72a` |

## Verification status

As reported by the integration repository — DRC and LVS were **not** re-run for this copy.

| Step | Status |
|---|---|
| DRC of the three integrated top cells | clean |
| LVS of the three integrated top cells | clean |
| Chip-level DRC and LVS, before fill | clean |

## Comparison with this repository's PLL layout

The `LC_VCO_FPLL` cell inside `MPC0388` was compared layer by layer against
[`gds/LC_VCO_FPLL.gds`](../../gds/LC_VCO_FPLL.gds), by XOR of the flattened geometry on
all 71 layers. 69 layers are identical. The two that differ:

| Layer | Difference |
|---|---|
| 8/0 (Metal1) | 22.8 µm² of extra Metal1 in the chip copy |
| 189/0 | this repository's cell has a full-cell marker polygon (0.603 mm²) that the chip copy lacks |

## Screenshots

The layout screenshots in the main README were taken in KLayout 0.30.11 in editor mode with
the SG13G2 technology and layer properties from the PDK. The 2.5D views use the PDK's
`sg13g2_beol.lyd25` metal-stack script. The density fill cells (`*_FILL_CELL`) were removed from a temporary copy of
`MPC0388.gds` for rendering, so that the circuit is not hidden behind them; the delivered file
is unchanged. The pad-ring filler cells and the inductor fill are kept.
