# 2.4 GHz LC-VCO PLL Benchmarks & Targets

This document outlines the performance targets and verification methodology for the 2.4 GHz LC-VCO PLL designed for Bluetooth and Wi-Fi applications.

## System Overview
* **Technology:** IHP PDK (Open-source flow via Xschem/Ngspice)
* **Target Applications:** Bluetooth (BT) and 2.4 GHz Wi-Fi
* **Reference Clock ($f_{ref}$):** 10 MHz
* **Feedback Divider ($N$):** 240
* **Center Frequency ($f_{out}$):** 2.4 GHz

---

## Target Specifications

| Parameter | Target Range (BT / Wi-Fi) | Conditions / Notes |
| :--- | :--- | :--- |
| **Center Frequency** | 2.4 GHz | ISM Band |
| **Tuning Range (TR)** | 2.1 GHz to 2.7 GHz | ~20-25% to cover PVT variations |
| **Phase Noise (1 MHz)** | < -115 dBc/Hz (BT) <br> < -120 dBc/Hz (Wi-Fi) | Measured at 1 MHz offset |
| **Phase Noise (10 MHz)** | < -135 dBc/Hz | Critical for Wi-Fi (OFDM) |
| **RMS Phase Jitter** | < 2 ps (BT) <br> < 1 ps (Wi-Fi) | Integrated from 10 kHz to 10 MHz |
| **Lock Time** | < 100 μs (Target: 40 μs) | Requires Loop BW $\approx$ 1 MHz |
| **Reference Spurs** | < -60 dBc | Measured at $f_{out} \pm 10$ MHz |
| **VCO Power Consumption**| 5 mW to 15 mW | VDD dependent |
| **Total PLL Power** | 15 mW to 30 mW | Includes VCO, CP, PFD, Divider |
| **Figure of Merit (FoM)**| < -180 dBc/Hz | Standard LC-VCO efficiency metric |

> **FoM Calculation:** > $$FoM = L(f_{offset}) - 20\log\left(\frac{f_0}{f_{offset}}\right) + 10\log\left(\frac{P_{DC}}{1\text{ mW}}\right)$$

---

## Verification & Simulation Checklist

### 1. Open-Loop VCO Characterization
- [ ] **DC/AC Sweep:** Plot Tuning Curve (Frequency vs. $V_{tune}$).
- [ ] **Gain Calculation:** Calculate $K_{vco}$ (MHz/V) across the tuning range.
- [ ] **Phase Noise:** Simulate/calculate steady-state phase noise at 1 MHz and 10 MHz offsets.
- [ ] **PVT Corners:** Verify Tuning Range covers 2.4 GHz - 2.4835 GHz across all corners (TT, FF, SS, Temp variations).

### 2. Phase-Frequency Detector (PFD) & Charge Pump (CP)
- [ ] **Transient Analysis:** Verify correct up/down pulse generation.
- [ ] **Dead Zone Check:** Sweep small phase differences to ensure the CP responds (no dead zone).
- [ ] **Current Matching:** Measure up/down current mismatch to predict reference spur performance.

### 3. Frequency Divider
- [ ] **Max Frequency Test:** Verify proper division (Divide-by-240) at inputs $> 2.7$ GHz.
- [ ] **Corner Simulation:** Ensure no missing edges under SS corner / low VDD.

### 4. Closed-Loop PLL Transient
- [ ] **Lock Time:** Simulate step response and measure time to settle within phase tolerance.
- [ ] **Control Voltage:** Plot $V_{tune}$ over time to check loop stability (damping factor).