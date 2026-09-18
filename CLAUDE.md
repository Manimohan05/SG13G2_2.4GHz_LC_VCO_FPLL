# CLAUDE.md

Guidance for Claude Code (and other coding agents) working in this repository.

## What this is

A 2.4 GHz type-II ΔΣ fractional-N phase-locked loop with a cross-coupled differential
LC-VCO, implemented in the **IHP SG13G2 130 nm open-source BiCMOS PDK** using a fully
open-source EDA flow. Targeted at the UNIC-CASS 2026 mock tapeout.

The distinguishing feature is a **custom on-chip 4 nH spiral inductor**, characterised
with an electromagnetic solver rather than taken from the PDK — open PDKs ship no
inductor models, which is why other open-source PLLs use ring oscillators.

Published as: *"A 2.4 GHz LC-VCO Fractional-N Phase Locked Loop Open-Source Design in
130-nm BiCMOS"*, SMACD 2026.

## Repository layout

| Path | Contents | Hand-written? |
|---|---|---|
| `xschem/` | Schematics and symbols, grouped by block subfolder | **Yes** |
| `spice/` | Netlists exported from Xschem — the golden netlists LVS compares against | No, generated |
| `simulations/` | Xschem-exported testbench netlists and simulation decks | Mixed |
| `gds/` | Layouts — `LC_VCO_FPLL.gds` (top) and `blocks/` | **Yes** (KLayout) |
| `drc/`, `lvs/`, `pex/` | Archived verification runs, one directory per cell | No, tool output |
| `em/` | Open-source inductor EM flow: GDS → OpenEMS → SPICE model | **Yes** |
| `model/` | Analytical sizing notebooks, gm/ID lookup tables, Qucs-S models | **Yes** |
| `docs/` | Documentation and images | **Yes** |
| `archive/hfss/` | Archived Ansys HFSS inductor work (superseded by `em/`) | Reference only |
| `UNIC-CASS-2025/` | Mock-tapeout wrapper integration data | Vendored |
| `paper_submission/` | Manuscripts and figure sources | **Yes** |

### Block subfolders under `xschem/`

`lc-vco/`, `top-pll/`, `charge-pump/`, `loop-filter/`, `bgr/`,
`phase-freq-detector/`, `dsm/`, `freq_divider/`, `pdk_custom_SYM/`,
`sg13g2_stdcells/`

Cell names are upper snake case and identical across Xschem, SPICE and GDS:
`LC_VCO_FPLL`, `LC_VCO`, `PHASE_FREQ_DET`, `CHARGE_PUMP`, `LOOP_FILTER`,
`BANDGAP_REF`, `DSM_N_FREQ_DIV`, `PFD_CP_LF`, `4nH_INDUCTOR`.

## Environment

Everything runs inside the
[uniccass-icdesign-tools](https://github.com/unic-cass/uniccass-icdesign-tools)
container (Xschem, ngspice, KLayout, Magic, Yosys, LibreLane, the SG13G2 PDK).

```bash
export PDK_ROOT=/foss/pdks     # or /opt/pdks in newer container images
export PDK=ihp-sg13g2
```

Archived verification runs used **KLayout 0.30.11** (some older ones 0.30.5).

## Rules that matter

1. **Never hand-edit `spice/`.** It is Xschem output and the reference LVS compares
   layouts against. Change the schematic, re-netlist, commit the regenerated file.
2. **Launch Xschem from the repository root.** Schematics reference symbols by
   repo-relative paths (`xschem/lc-vco/LC_VCO.sym`). Starting elsewhere breaks them.
3. **One archived run per cell** in `drc/` and `lvs/`. Replacing a run means deleting
   the superseded directory in the same commit.
4. **Run simulation decks from the directory they live in** — they use relative
   `.include` paths.
5. **Layout changes need fresh DRC and LVS** archived in the same change.
6. Do not commit generated build output: LibreLane `runs/`, Verilator `obj_dir/`,
   `*.so`, `*.raw`, `*.vcd`, KLayout `backups/`.

## Upstream

Design files are periodically synced from
[avishkaherath/LC_VCO_FPLL](https://github.com/avishkaherath/LC_VCO_FPLL).

**That repo keeps all schematics in one flat `xschem/` folder; this repo uses block
subfolders.** When syncing, the symbol references inside the copied `.sch` files must be
remapped, and upstream sometimes contains hardcoded absolute paths
(`/home/designer/shared/...`). After any sync, verify every symbol reference resolves:

```bash
for f in $(git ls-files '*.sch'); do
  grep -oE '^C \{[^}]+\}' "$f" | sed 's/^C {//;s/}$//' \
    | grep -E '^(/|xschem/)' | while read -r p; do
        [ -f "$p" ] || echo "BROKEN $f -> $p"; done; done
```

## Verification status

DRC is clean on all cells. **`LC_VCO_FPLL` — the integrated top level — passes both DRC
and LVS**, which is the result that gates tapeout.

Two standalone blocks fail LVS on **pin naming only** — no device or net mismatches:

- `LOOP_FILTER` — `'VSS'` vs `'GND'`, plus an unlabelled substrate pin
- `LC_VCO` — five unlabelled top-level pins

These surfaced when newer runs enabled strict port checking; older runs set
`IGNORE_TOP_PORTS_MISMATCH=true` and passed. The stricter result is the honest one.
Fixing means adding pin labels to the block layouts, not relaxing the check.

Also open: reference spur ≈ −40.2 dBc against a −60 dBc target; charge-pump PEX is from
revision V1 while V2 ships; only the typical corner is archived.

## Common tasks

```bash
# simulate (from the deck's own directory)
cd simulations && ngspice -b LC_VCO_tb.spice

# physical verification
python $PDK_ROOT/$PDK/libs.tech/klayout/tech/drc/run_drc.py \
  --path=gds/LC_VCO_FPLL.gds --topcell=LC_VCO_FPLL --run_dir=drc/drc_run_LC_VCO_FPLL

# inductor EM flow — see em/README.md
cd em && python scripts/run_pipeline.py --config config/inductor_4nH.yaml
```

## Gotchas

- **Windows long paths.** Some archived paths approach the 260-character limit. Clone
  with `git clone -c core.longpaths=true ...` on Windows or checkout fails partway.
- **ngspice has no closed-loop PLL phase-noise analysis.** Phase noise here is derived by
  post-processing a long transient; take the spectrum from the *settled* portion only.
- **The inductor has two models on purpose**: `spice/4nH_INDUCTOR.spice` (full
  EM-extracted network, for simulation) and `spice/4nH_INDUCTOR_LVS.spice` (two-terminal
  black box, for LVS). Do not merge them.
- The README table of contents links to several documentation files that do not exist
  yet, and some paths reflect a planned layout rather than the current one.

## Conventions for changes

- Commit subjects: imperative, prefixed with the area — `vco: widen tail device`,
  `lvs: re-run PFD_CP_LF`, `em: add de-embedding step`.
- Keep large binary (GDS, lvsdb) changes in their own commits so diffs stay reviewable.
- State the KLayout and PDK versions when attaching verification evidence.
- **Do not add Claude/AI co-author trailers to commits in this repository.**
