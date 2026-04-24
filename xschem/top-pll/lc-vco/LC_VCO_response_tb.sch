v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 120 -1050 920 -650 {flags=graph
y1=0
y2=2.7e+09
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
sim_type=tran
color="4 7"
node="freq_vector
vctrl"
x2=1.59999e-07
hcursor2_y=2.5025565e+09
hcursor1_y=2.3542446e+09}
N 290 -320 290 -280 {lab=GND}
N 290 -460 290 -380 {lab=VCTRL}
N 850 -390 930 -390 {lab=OUTp}
N 850 -370 930 -370 {lab=OUTn}
N 570 -390 640 -390 {lab=VCTRL}
N 740 -290 740 -280 {lab=GND}
N 570 -370 640 -370 {lab=Ibias}
N 740 -480 740 -470 {lab=VDD}
N 230 -460 230 -380 {lab=VDD}
N 230 -320 230 -280 {lab=GND}
N 170 -400 170 -380 {lab=Ibias}
C {gnd.sym} 290 -280 0 0 {name=l2 lab=GND}
C {devices/vdd.sym} 290 -460 0 0 {name=l8 lab=VCTRL}
C {launcher.sym} 790 -630 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/tb_VCO.raw"
}
C {devices/code_shown.sym} 1030 -1200 0 0 {name=vco_tb_script
only_toplevel=false
value="
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
    * (alter @element[param] = value  is the correct ngspice syntax)
    alter @V2[dc] = $&v_c

    * Run 200 ns transient — ~480 cycles at 2.4 GHz, enough to settle from 0V
    * uic: each step starts fresh (no carry-over state from previous Vctrl)
    tran 10p 200n uic

    * Measure 20 full cycles starting from the 30th rising edge crossing of VDD/2
    * RISE=30 skips the startup transient; 50-30=20 cycles gives accurate average
    * Threshold = VDD/2 = 0.6 V   (was wrongly 0.9 V before)
    * Node     = v(OUTp)          (was wrongly v(vco_out) before)
    meas tran t_rise30 WHEN v(OUTp)=0.6 RISE=30
    meas tran t_rise50 WHEN v(OUTp)=0.6 RISE=50

    let freq = 20 / (t_rise50 - t_rise30)

    * Append  vctrl_V,freq_Hz  row to CSV
    echo $&v_c,$&freq >> vco_tuning.csv

    let v_c = v_c + v_step
end

* Save the raw file from the last transient (Vctrl = 1.2 V) for xschem viewer
write tb_VCO.raw v(OUTp) v(OUTn) v(vctrl)
echo --- Tuning sweep complete ---
echo CSV written to vco_tuning.csv
echo Run: python3 plot_vco_tuning.py
.endc
"}
C {vsource.sym} 290 -350 0 0 {name=V2 value=0.0 savecurrent=false}
C {devices/code_shown.sym} 100 -180 0 0 {name=MODEL1 only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
.lib cornerRES.lib res_typ
.lib $::SG13G2_MODELS/cornerCAP.lib cap_typ_stat
.include ./IHP_4nH_Inductor.spice
"}
C {/foss/designs/iic_osic_tools/frac-n-pll-vco-unic_cass/schematic/blocks/lc-vco/LC_VCO.sym} 740 -380 0 0 {name=x2}
C {gnd.sym} 740 -280 0 0 {name=l6 lab=GND}
C {lab_pin.sym} 570 -390 0 0 {name=p3 sig_type=std_logic lab=VCTRL}
C {lab_pin.sym} 570 -370 0 0 {name=p7 sig_type=std_logic lab=Ibias}
C {devices/vdd.sym} 740 -480 0 0 {name=l7 lab=VDD}
C {lab_pin.sym} 930 -390 0 1 {name=p1 sig_type=std_logic lab=OUTp}
C {lab_pin.sym} 930 -370 0 1 {name=p2 sig_type=std_logic lab=OUTn}
C {vsource.sym} 230 -350 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} 230 -280 0 0 {name=l1 lab=GND}
C {devices/vdd.sym} 230 -460 0 0 {name=l5 lab=VDD}
C {devices/isource.sym} 170 -430 0 0 {name=I0 value=50u}
C {devices/vdd.sym} 170 -460 0 0 {name=l12 lab=VDD}
C {devices/vdd.sym} 170 -380 2 0 {name=l3 lab=Ibias}
C {title.sym} 160 -40 0 0 {name=l4 author="Skill Surf"}
