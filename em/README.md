# Inductor EM flow — GDS to SPICE, open source

Takes the spiral inductor **layout** and produces the **SPICE model** the VCO
schematic instantiates, using only open-source tools. It replaces the Ansys HFSS
step that produced the taped-out model (now archived in
[`../archive/hfss/`](../archive/hfss/)).

```
gds/blocks/4nH_INDUCTOR.gds
        │  read + flatten polygons, map GDS layers to the SG13G2 stackup
        ▼
   OpenEMS FDTD  (0–12 GHz, graded mesh, real BEOL stack and substrate)
        │  raw 2-port S-parameters
        ▼
   two-step open-short de-embedding
        │
        ├──►  L_diff, Q_diff, peak Q, SRF   +  plot
        │
        ▼
   vector fit (shared poles)  ──►  .subckt 4nH_INDUCTOR 1 2
                                        │
                                        ▼
                    drop-in for spice/4nH_INDUCTOR.spice
```

The output has the **same subcircuit name and pin order** as the HFSS-exported
model, so it substitutes directly into the Xschem/ngspice testbenches with no
schematic change.

## Quick start

```bash
cd em
pip install -r requirements.txt

# what the EM model will contain — no solver needed
python scripts/run_pipeline.py --config config/inductor_4nH.yaml --stage geom

# full run (the `em` stage needs OpenEMS installed)
python scripts/run_pipeline.py --config config/inductor_4nH.yaml

# already have S-parameters from any solver? skip straight to the model
cp my_sim.s2p out/inductor.s2p
python scripts/run_pipeline.py --config config/inductor_4nH.yaml \
       --stage extract --stage fit --stage check
```

Results land in `out/` (git-ignored): `inductor.s2p`, `inductor_LQ.png`,
`summary.json` and the generated `.spice` model.

## Stages

| Stage | Does | Needs |
|---|---|---|
| `geom` | Flatten the GDS, map layers onto the stackup, report extents | numpy |
| `em` | Build and run the OpenEMS FDTD solve → raw Touchstone | **OpenEMS** |
| `deembed` | Two-step open-short de-embedding | numpy |
| `extract` | Differential L and Q, peak Q, SRF, plot | numpy, matplotlib |
| `fit` | Vector-fit S-parameters, write the `.subckt` | numpy |
| `check` | Solve the generated subcircuit, confirm it matches L and Q | numpy |

Only `em` needs the solver. Everything else runs anywhere numpy does, so a
Touchstone file from *any* field solver can be turned into a SPICE model.

## Verification

`scripts/validate.py` runs the whole back half against the archived HFSS results
— the reference this design actually taped out with:

```bash
python scripts/validate.py
```

```
[1] circuit solver vs HFSS reference CSV
    L = 4.0005 nH (ref 4.0004)   err 0.0047 %
    Q = 16.8054    (ref 16.8011)   err 0.0256 %
[2] vector fit: 32 poles, max |S| error over 0.1-12 GHz = 5.161e-03
[3] generated subckt (370 elements) -> em\out\4nH_INDUCTOR_refit.spice
    L = 4.0014 nH (ref 4.0004)   err 0.0266 %
    Q = 16.7675    (ref 16.8011)   err 0.1995 %
[4] 2.0-3.0 GHz band: max L err 0.030 %, max Q err 0.577 %
RESULT: PASS
```

Running the pipeline on the reference S-parameters reproduces every published
figure:

| Quantity | Pipeline | Paper |
|---|---|---|
| L<sub>diff</sub> @ 2.45 GHz | 4.0005 nH | 4.000 nH |
| Q<sub>diff</sub> @ 2.45 GHz | 16.805 | 16.80 |
| Peak Q<sub>diff</sub> | 18.915 at 3.85 GHz | ≈ 18.9 near 3.8 GHz |
| Self-resonant frequency | 9.95 GHz | ≈ 10 GHz |

## How the SPICE model works

S-parameters are fitted to a shared pole set,
`S(s) ≈ D + Σ R_k/(s − p_k)`, and realised as a scattering network:

- each port senses its incident wave, `u_i = V_i + Z0·I_i`, with an ammeter,
  a controlled source and a 1 Ω sense node;
- each pole becomes a first-order state node driven by `u_j` — real poles are a
  single RC, complex pairs a cross-coupled pair, matching the fit basis exactly
  so residues drop in as transconductances;
- the reflected wave `y_i = Σ_j S_ij·u_j` is accumulated on a 1 Ω node and
  applied through a series `Z0` resistor and a VCVS.

Only `R`, `C`, `V`, `E`, `G` and `F` elements are emitted, so it loads in
ngspice with no extra options.

`scripts/mna.py` is a small AC circuit solver used by `check` and `validate` to
confirm the generated netlist really does reproduce the target response —
without needing ngspice in the loop.

## Configuration

Everything lives in [`config/inductor_4nH.yaml`](config/inductor_4nH.yaml):
GDS path and layers, frequency sweep, mesh sizes, the dielectric stack, port
placement, de-embedding structures, fit settings and pass/fail tolerances.

Layer heights, thicknesses and conductivities come from
[`stackup/sg13g2_stackup.xml`](stackup/sg13g2_stackup.xml), the PDK stackup
definition, so the model and the foundry never disagree:

```bash
python scripts/sg13g2_stackup.py     # print the parsed stackup
```

| Layer | GDS | z range (µm) | Thickness | σ (S/m) |
|---|---|---|---|---|
| TopMetal2 | 134 | 11.2303 – 14.2303 | 3.00 | 3.03e7 |
| TopVia2 | 133 | 8.4303 – 11.2303 | 2.80 | 3.14e6 |
| TopMetal1 | 126 | 6.4303 – 8.4303 | 2.00 | 2.78e7 |

## De-embedding

The solver sees the feed lines and pads used to excite the structure; the device
does not have them. Generate `open` and `short` variants with identical feeds,
point the config at them, and the flow removes both shunt and series parasitics:

```
Y_dut = ( (Y_meas − Y_open)^-1 − (Y_short − Y_open)^-1 )^-1
```

Skipping this is the most common way to get a wrong on-chip inductor model — pad
capacitance alone moves the apparent SRF substantially.

## Notes and limits

- **The `em` stage has not been executed in this repository.** OpenEMS is not
  installed here, so the FDTD stage is written against the OpenEMS python API
  but unproven; everything downstream is validated against the HFSS reference.
  Treat the first solver run as bring-up: check mesh convergence and port
  placement before trusting the numbers.
- Port coordinates in the config are a starting point for the current layout.
  Check them against the terminal geometry after any layout change.
- Mesh refinement (`refined_cellsize_um`) dominates both runtime and accuracy.
  Conductor loss at 2.45 GHz sits in a thin skin at the trace edges; a coarse
  mesh smears it and reports an optimistically high Q.
- `scripts/gds_geometry.py` is a self-contained GDSII reader — no gdstk/gdspy
  dependency. It handles SREF/AREF, rotation, magnification and mirroring, and
  converts paths to polygons.
