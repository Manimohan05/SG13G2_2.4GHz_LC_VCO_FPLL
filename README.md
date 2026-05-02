## A 2.4GHz Type-II ∆Σ Fractional-N Phase Locked Loop (PLL) with a Type IV Cross-Coupled Differential LC Voltage-Controlled Oscillator (VCO) for Wi-Fi/Bluetooth Applications - [Universalization of IC Design from CASS](https://github.com/unic-cass)

 *This design is currently under progress.

----------------------
<a name="toc"></a>
## Table of Contents

1. [Introduction](docs/intro.md)
    - [Project Overview](#overview)
    - [Project Specifications](#specs)
    - [Project Application](#application)
2. [Behavioral Model](model/model.md)
    - [Design Calculations](model/calculations/calc.md)
    - [Python Model](model/model.md)
3. [RF Simulation Workflow](openems/openems.md)
    - [OpenEMS Simulation workflow](openems/openems.md)
    - [Inductor Design Simulations](openems/ind_sims.md)
        - [IHP SG13G2 PDK](openems/SG13G2/ind_sg13g2.md)
        - [SKY130 PDK](openems/SKY130/ind_sky130.md)
    - [Inductor Layout](openems/layout/ind_lay.md)
4. [PLL IP Blocks](schematic/design.md)
    - [Phase-Frequency Detector (PFD)](schematic/blocks/phase-freq-detector/pfd.md)
    - [Charge Pump (CP)](schematic/blocks/charge-pump/cp.md)
    - [Loop Filter](schematic/blocks/loop-filter/lf.md)
    - [Bias Generator](schematic/blocks/bias-generator/bia.md)
    - [Bandgap Reference](schematic/blocks/bandgap-ref/bgr.md)
    - [LC Voltage-Controlled Oscillator (LC-VCO)](schematic/blocks/lc-vco/vco.md)
    - [Delta-Sigma Modulator (DSM)](schematic/blocks/dsm/dsm.md)
    - [Frequency Divider (FD)](schematic/blocks/freq_divider/fd.md)
    - [TOP: Phase-Locked Loop (PLL)](schematic/blocks/top-pll/pll.md)
5. [Integrated PLL Design and TestBench](simulation/full_pll_design.md)
    - [Output Waveform of the LC-VCO](simulation/full_pll_design.md)
    - [Operation of the Charge Pump](simulation/full_pll_design.md)
    - [Operation of the DSM and FD](simulation/full_pll_design.md)
    - [Integrated PLL Simulation for N = 240](simulation/full_pll_design.md)
6. [PLL Layout Design](layout/layout_design.md)
    - [Phase-Frequency Detector Layout](layout/layout_design.md)
    - [Charge Pump Layout](layout/layout_design.md)
    - [Loop Filter Layout](layout/layout_design.md)
    - [Bias Generator Layout](layout/layout_design.md)
    - [Band gap Reference Layout](layout/layout_design.md)
    - [LC-VCO Layout](layout/layout_design.md)
    - [Delta-Sigma Modulator (DSM)](layout/layout_design.md)
    - [Frequency Divider Layout](layout/layout_design.md)
    - [TOP: Integrated PLL Layout](layout/layout_design.md)
7. [Important Information for TTSKY25b](docs/layout_info.md)
8. [Physical Verification (DRC, LVS)](post-layout/pv.md)
9. [Parasitic Extractions (RC) with Kpex](post-layout/kpex.md)
10. [Post-layout Simulations after PEX](post-layout/pex.md)
    - [Integrated PLL Simulation for N = 240](post-layout/pex.md)   
11. [TinyTapeout SKY25b Submission](docs/ttsky25b_mpw.md)
12. [Testing Plan with AD3](test/plan.md)
13. [References](#ref)

### Team Members (Department of Electronic and Telecommunication Engineering, University of Moratuwa)

- Rajinthan	Rameshkumar.
- Anjana Viduranga.
- Shenal Ranasinghe.
- Sajitha Madugalle.
- Lohan Atapattu.
- Manimohan	Thiriloganathan.
- Hansa Marasinghe.
- Avishka Herath.
- Kithmin Wickremasinghe (MASc).
- Dr. Chamira Edussooriya (PhD).

<a name="overview"></a>
### Overview of the Project:

The PLL is a charge-pump (CP) based (Type-II) PLL which uses a standard fractional-N architecture, where an output frequency divider (FD) is used to set the frequency multiplication with respect to the reference clock input; a 10 MHz crystal oscillator. In order to make the frequency of the VCO output signal equivalent to the frequency of a PFD reference input, the frequency divider (FD) divides the frequency by a fractional value using the delta sigma modulation (DSM) technique. The output frequency `f_out` is `N * f_ref`, where `N` is the division ratio of `XDIV_OUT` and `f_ref` is the input clock frequency. Documentation for the PLL subcells is included below.

### Block Diagram of the Project:

<p align="center">
    <img src="./img/block.png" width = "800" height = "280"><br>
    <em>Figure 1: Block Diagram of the PLL Design</em>
</p>

<a name="specs"></a>
### Specifications of the Project:

| Category | Specification | Min | Typ | Max | Unit | Comments |
|----------|---------------|-----|-----|-----|------|----------|
| Top-level | Supply voltage (Design Input) | 1.7 | 1.8 | 1.9 | V | - |
| Top-level | Temperature (Design Input) | 20 | - | 50 | C | - |
| Top-level | Reference frequency (Design Input) | - | 10 | - | MHz | - |
| Top-level | Output center frequency range | 2.4 | 2.45 | 2.48 | GHz | - |
| Top-level | Output frequency range | 2.35 | - | 2.55 | GHz | - |
| Top-level | Expected PLL lock time | - | 25 | 40 | µs | - |
| Loop/Control | Loop bandwidth | 80 | 150 | 300 | kHz | - |
| Loop/Control | Phase margin | 50 | 55 | 60 | ° | - |
| Dividers/Buffers | MMD division range | 240 | 245 | 248 | - | - |
| Charge Pump | CP current range | 50 | 150 | 300 | µA | - |
| VCO | Oscillation frequency | 2.35 | 2.45 | 2.55 | GHz | - |
| VCO | Tuning range | 8 | 9 | 10 | % | - |
| VCO | K VCO sensitivity | 50| 80 | 150 | MHz/V | - |
| VCO | Phase noise (@100 kHz offset) | - | -85 | - | dBc/Hz | - |
| VCO | Phase noise (@1 MHz offset) | - | -100 | - | dBc/Hz | - |
| Robustness/PVT | Process corners covered | - | TT/FF/SS/FS/SF | - | - | - |
| Robustness/PVT | Monte Carlo yield on key specs | 99 | - | - | % | - |
| Power/Area | Total DC power consumption | - | 12 | 25 | mW | - |
| Power/Area | Power down current consumption | - | 0.5 | 5 | µA | - |
| Power/Area | Die area | - | 0.22 | 0.25 | mm² | 500 µm x 500 µm |

[Return to top](#toc)

<a name="application"></a>
### Application of the Project:

<a name="refs"></a>
### References:

The following open-source PLL designs were referred to during the development of this project:
- tt08-tiny-pll - [https://github.com/LegumeEmittingDiode/tt08-tiny-pll](https://github.com/LegumeEmittingDiode/tt08-tiny-pll)
- Razavi papers

[Return to top](#toc)