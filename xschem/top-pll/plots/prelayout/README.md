# Integrated PLL — pre-layout simulation (100 µs)

Full closed-loop transient of the schematic-level PLL (`LC_VCO_FPLL_tb.sch`). Every figure here is
made by the scripts in [`../`](../) from that run, as PNG and PDF, with the analysis windows moved
into the steady state.

| Setting | Value |
|---|---|
| Netlist | schematic, ideal wiring; ΔΣ divider is the behavioural model (`dsm_and_freq_divider.so`) |
| Supply / reference | V<sub>DD</sub> = 1.2 V, f<sub>REF</sub> = 10 MHz, average N = 244 → 2.44 GHz |
| Run | `tran 10p 100u`, `reltol=1e-3`, gear; one continuous run, no restart |
| Raw file | `simulations/tb_LC_VCO_FPLL_100u.raw` (1.6 GB, not committed) |

## Steady-state windows

The loop is disturbed for about 2 µs every 25.5 µs (255 reference cycles), starting at 25.6, 51.1 and
76.6 µs (cause below). The quiet windows are 30–50, 55–75 and 85–100 µs; V<sub>CTRL</sub> has the same
mean (0.7794–0.7795 V) and 25–27 mV peak-to-peak ripple in all three, with no drift. **All figures below
use 30–50 µs and 60–76 µs** — two windows of different length, both clear of a disturbance (60–80 µs is
not: it ends inside the one that starts at 76.6 µs).

## Results

| Quantity | Value | Window |
|---|---|---|
| Locked output frequency | 2.4400 GHz | 30–50 µs |
| V<sub>CTRL</sub>, steady state | 0.7794 V mean, about 25 mV peak-to-peak ripple (10 MHz) | 30–50 µs |
| V<sub>CTRL</sub>, acquisition | overshoot to 1.155 V at 1.5 µs | 0–8 µs |
| Frequency lock time | ±1000 ppm held for ≥ 1 µs from 7.6 µs; ±500 ppm from 8.5 µs | per reference period |
| Phase lock time | within ±500 ps of the final phase error from 7.4 µs, ±200 ps from 9.2 µs, ±100 ps from 11.0 µs | per reference period |
| Recurring disturbance | peak 2905 ppm, back within ±500 ppm after about 2 µs, phase error returns to the same value (no permanent cycle slip) | 25.6, 51.1, 76.6 µs |
| Supply current (V<sub>DD</sub> source) | 0.872 mA average | 60–100 µs |
| Phase noise @ 1 MHz, tones kept | −109.0 dBc/Hz (30–50 µs), −117.9 dBc/Hz (60–76 µs) | `plot_phase_noise.py` |
| Phase noise @ 10 MHz, tones kept | −98.6 dBc/Hz (30–50 µs), −99.3 dBc/Hz (60–76 µs); this is the 10 MHz tone, not the noise floor | same |
| Phase noise @ 1 MHz, tones removed | −109.0 dBc/Hz (30–50 µs), −117.9 dBc/Hz (60–76 µs) | `plot_phase_noise.py --remove-tones` |
| Phase noise @ 10 MHz, tones removed | −121.9 dBc/Hz (30–50 µs), −122.1 dBc/Hz (60–76 µs) | same |
| Phase noise, other estimator | −114.6 / −116.0 dBc/Hz at 1 MHz and −134.8 / −142.3 dBc/Hz at 10 MHz (same windows, phase Welch, `plot_pll_steady_state.py`); the value depends on the estimator and window by 5–9 dB | 30–50, 60–76 µs |
| Tone at 5 MHz (f<sub>REF</sub>/2) | −17.7 dBc phase sideband (0.26 rad peak), same in both windows | same |
| **Reference spur @ 10 MHz** | **−40.7 dBc** (30–50 µs), **−40.6 dBc** (60–76 µs) | `plot_reference_spur.py` (fixed, see below) |
| Sideband @ 15 MHz | −38.4 dBc | same |

## Reference-spur script bug (fixed)

`plot_reference_spur.py` and `verify_reference_spur.py`'s "Method A" both normalised their spectrum to
`A_max`, the **largest** bin in the offset spectrum, and called that bin "the carrier". For this PLL the
largest offset tone is the 5 MHz divider tone (−17.7 dBc), not the carrier, so every spur was reported
about 23 dB too high (a run before the fix read −17.05 dBc at 10 MHz here, against −40.2 dBc in the
paper and a direct edge-time measurement of −40.7 dBc). Both scripts now compute the output phase from
the edge times and reference it to a unity-amplitude carrier — the method already used and cross-checked
in `plot_pll_steady_state.py` — and both now agree with the paper: **−40.6 to −40.7 dBc**. Both scripts
also gained `--tend`, `--out-dir` and `--name` so a window and destination can be given on the command
line; `reference_spur_fixed_1`/`_2` and `spur_verification_fixed_1`/`_2` here are their output for the
two windows above, replacing the incorrect `reference_spur_SA` and `spur_verification` this run produced
before the fix (deleted).

`verify_reference_spur.py`'s "Method B" (Welch PSD of the raw voltage) still disagrees, reading about
−22 dBc at 9.53 MHz instead of 10.0 MHz in both windows — a resolution/leakage problem, most likely
leakage from the much larger 5 MHz tone through the window's sidelobes, given how close the two are. It
was not fixed; treat its output as unreliable for this PLL and rely on Method A.

### Cause of the disturbance every 255 cycles

`dsm_9bit.v` is a first-order modulator with feedback levels +127 and −128. The testbench loads the
code 0 (`sdata` is held at 0), so the fraction of ones is 128/255 and the average ratio is
240 + 8 × 128/255 = 244.016. That fraction has a denominator of 255, so the output repeats every 255
samples: it alternates 1, 0, 1, 0 and once per 255 samples two equal bits follow each other. Two 240s
in a row are a 100 ns frequency step of 3.3 %, which the loop answers with the 2 µs disturbance seen
at 25.6, 51.1 and 76.6 µs. A Python model of the RTL reproduces the period of 255. With symmetric
levels (+128 and −128) the same code gives an exact 1, 0, 1, 0 pattern with a period of 2 and no
disturbance. That is a change to the RTL, so it needs a new divider layout; it is not made here.

### The peak at 5 MHz

The peak between 1 MHz and 10 MHz in the phase-noise plot is a discrete tone at f<sub>REF</sub>/2 = 5 MHz,
not noise. In the steady state the divider alternates between 240 and 248 VCO cycles on every other
reference period (counted: 100 periods of each in every 200 periods), so the average ratio is 244 but the
instantaneous ratio toggles by ±4. That frequency modulation at 5 MHz shows up as the phase-noise peak,
as the ±5 MHz sidebands in the spur plot, and as the two alternating widths of the PFD pulses in
`plot_paper_pll_slide_v3`. In `phase_noise_steady_*` this tone and its harmonics are removed with the
`--remove-tones` option of `plot_phase_noise.py`; the plot format is unchanged.

## Figures

| Script | Output (PNG and PDF) |
|---|---|
| `plot_phase_noise.py --window 30 50` / `60 76` | `phase_noise_with_tone_1`, `phase_noise_with_tone_2` (tones kept) |
| `plot_phase_noise.py --window 30 50 --remove-tones` / `60 76 --remove-tones` | `phase_noise_steady_1`, `phase_noise_steady_2` (tones removed) |
| `plot_pll_steady_state.py` (both windows, phase noise and the size of each tone) | `pll_steady_state_pn_spur` |
| `plot_reference_spur.py --tsettle 30e-6 --tend 50e-6` / `60e-6 76e-6` | `reference_spur_fixed_1`, `reference_spur_fixed_2` |
| `verify_reference_spur.py` (same windows) | `spur_verification_fixed_1`, `spur_verification_fixed_2` |
| `plot_vctrl_transient.py` | `plot_vctrl_transient` |
| `plot_paper_62_64us.py`, `plot_paper_pll_slide.py`, `plot_paper_pll_slide_v3.py` | `plot_paper_62_64us`, `plot_paper_pll_slide`, `plot_paper_pll_slide_v3` |
| lock analysis (frequency and phase error per reference period) | `pll_lock_error` |

Not produced:
- `plot_lock_time.py` reported "not achieved" and its time axis does not match the V<sub>CTRL</sub>
  transient, so `pll_lock_error` replaces it.
- `Visualiser.py` needs signals the run did not save (`xpll.dsm_out`).
- The VCO-only scripts (`plot_vco_paper.py`, `plot_vco_phase_noise.py`) use the standalone VCO runs, not this one.

## Caveats

- **Paper comparison.** The paper's reference spur (−40.2 dBc) agrees with the −40.7 dBc measured here
  at 10 MHz; the paper does not mention the larger tone at 5 MHz (−17.7 dBc). The paper's phase noise
  (−100.8 dBc/Hz at 1 MHz) is 8 dB higher than the −109 dBc/Hz here, and I could not check how it was
  obtained. These are pre-layout values; the paper calls its results post-layout.
- **Supply current is not the total power.** The divider is a behavioural model that draws no
  current, and the bandgap reference is an ideal source (`VBGR`), so 0.872 mA × 1.2 V ≈ 1.05 mW
  covers the charge pump, VCO and phase detector only.
