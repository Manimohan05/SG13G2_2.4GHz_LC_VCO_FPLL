** sch_path: /foss/designs/frac-n-pll-vco-unic_cass/schematic/lc-vco/LC_VCO_response_tb.sch
**.subckt LC_VCO_response_tb
V2 VCTRL GND 0.0
V1 VDD GND 1.2
I0 VDD Ibias 50u
x1 VDD OUTp OUTn Ibias VCTRL GND LC_VCO

* Force ngspice to save top-level nodes (fixes "no such vector" error)
.save v(outp) v(outn) v(vctrl) v(vdd)

* Initial condition kick to guarantee oscillation startup
* OUTp starts HIGH, OUTn starts LOW — differential kick
.ic V(OUTp)=1.2 V(OUTn)=0.0

**** begin user architecture code
.control
* ============================================================
*  VCO Tuning Curve Sweep  (Vctrl = 0.0 V to 1.2 V, 0.1 V step)
*  Output:  vco_tuning.csv   <-- read by plot_vco_tuning.py
*           tb_VCO.raw       <-- last step waveform for xschem viewer
*  Plot:    python3 plot_vco_tuning.py
* ============================================================

* --- Sweep parameters ---
let v_start = 0.0
let v_stop  = 1.2
let v_step  = 0.1
let v_c     = v_start

* --- CSV header: vctrl_V,freq_Hz ---
echo vctrl_V,freq_Hz > vco_tuning.csv

while v_c <= (v_stop + v_step * 0.01)

    * Set VCTRL to the current sweep point
    alter @V2[dc] = $&v_c

    * Run 300 ns transient — longer window to ensure 50+ rising edges at all Vctrl
    * No 'uic' here: .ic handles initial conditions, DC OP is properly solved first
    tran 10p 300n

    * Measure 20 full cycles between the 30th and 50th rising edge crossings
    * Threshold = VDD/2 = 0.6 V
    * RISE=30 skips startup transient; 50-30=20 cycles gives accurate average period
    meas tran t_rise30 WHEN v(outp)=0.6 RISE=30
    meas tran t_rise50 WHEN v(outp)=0.6 RISE=50

    * Guard: only compute freq if both measurements succeeded
    if t_rise50 > t_rise30
        let freq = 20 / (t_rise50 - t_rise30)
        echo $&v_c,$&freq >> vco_tuning.csv
    else
        echo $&v_c,FAILED >> vco_tuning.csv
        echo WARNING: measurement failed at Vctrl = $&v_c V
    end

    let v_c = v_c + v_step

end

* Save raw waveform from the last transient (Vctrl = 1.2 V) for xschem viewer
write tb_VCO.raw v(outp) v(outn) v(vctrl)

echo --- Tuning sweep complete ---
echo CSV written to vco_tuning.csv
echo Run: python3 plot_vco_tuning.py

.endc

* ---- Process corners (deduplicated — each lib called only once) ----
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.include ./IHP_4nH_Inductor.spice

**** end user architecture code
**.ends

* expanding   symbol:  LC_VCO.sym # of pins=6
** sym_path: /foss/designs/frac-n-pll-vco-unic_cass/schematic/lc-vco/LC_VCO.sym
** sch_path: /foss/designs/frac-n-pll-vco-unic_cass/schematic/lc-vco/LC_VCO.sch
.subckt LC_VCO VDD OUTp OUTn Ibias VCTRL GND
*.opin OUTp
*.opin OUTn
*.iopin VCTRL
*.iopin Ibias
*.iopin GND
*.iopin VDD
XM6 net5 Vgs GND GND sg13_lv_nmos w=70.29u l=0.5u ng=20
XM4 net1 net4 VDD VDD sg13_lv_pmos w=34.52u l=0.13u ng=10
X5M3 net4 net1 VDD VDD sg13_lv_pmos w=34.52u l=0.13u ng=10
XM2 OUTp OUTn Vx GND sg13_lv_nmos w=25.11u l=0.13u ng=8
XM1 OUTn OUTp Vx GND sg13_lv_nmos w=25.11u l=0.13u ng=8
Vpmos_p net1 net3 0
.save i(vpmos_p)
Vnmos_p net3 OUTp 0
.save i(vnmos_p)
Vtail Vx net5 0
.save i(vtail)
XM5 Vgs Vgs GND GND sg13_lv_nmos w=17.95u l=0.5u ng=6
Vpmos_n net4 net2 0
.save i(vpmos_n)
Vnmos_n net2 OUTn 0
.save i(vnmos_n)
x1 net2 net3 ihp_4nh_inductor
XC1 net2 net3 GND cap_rfcmim w=22.15e-6 l=22.15e-6 wfeed=10.0e-6
XC3 OUTp VCTRL OUTn GND sg13_hv_svaricap w=9.74u l=0.8u Nx=7
XC2 OUTp VCTRL OUTn GND sg13_hv_svaricap w=9.74u l=0.8u Nx=7
Vbias Ibias Vgs 0
.save i(vbias)
.ends

.GLOBAL GND
.GLOBAL VCTRL
.GLOBAL VDD
.GLOBAL Ibias
.end
