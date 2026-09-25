v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {xschem/phase-freq-detector/PHASE_FREQ_DET.sym} 0 0 0 0 {name=x1}
N -150 -70 -120 -70 {}
C {lab_pin.sym} -150 -70 0 0 {name=p1
sig_type=std_logic
lab=CLK_IN}
N -150 70 -120 70 {}
C {lab_pin.sym} -150 70 0 0 {name=p2
sig_type=std_logic
lab=CLK_FB}
N 130 -80 160 -80 {}
C {lab_pin.sym} 160 -80 0 1 {name=p3
sig_type=std_logic
lab=UP}
N 130 80 160 80 {}
C {lab_pin.sym} 160 80 0 1 {name=p4
sig_type=std_logic
lab=DN}
N 70 -170 70 -140 {}
C {vdd.sym} 70 -170 0 0 {name=l5
lab=VDD}
N 70 140 70 170 {}
C {gnd.sym} 70 170 0 0 {name=l6
lab=GND}
C {xschem/charge-pump/CHARGE_PUMP.sym} 600 0 0 0 {name=x2}
N 490 -80 520 -80 {}
C {lab_pin.sym} 490 -80 0 0 {name=p7
sig_type=std_logic
lab=UP}
N 490 80 520 80 {}
C {lab_pin.sym} 490 80 0 0 {name=p8
sig_type=std_logic
lab=DN}
N 680 0 710 0 {}
C {lab_pin.sym} 710 0 0 1 {name=p9
sig_type=std_logic
lab=VCP}
N 600 -180 600 -150 {}
C {vdd.sym} 600 -180 0 0 {name=l10
lab=VDD}
N 640 -180 640 -150 {}
C {vdd.sym} 640 -180 0 0 {name=l11
lab=VBGR}
N 600 150 600 180 {}
C {gnd.sym} 600 180 0 0 {name=l12
lab=GND}
N 640 150 640 180 {}
C {gnd.sym} 640 180 0 0 {name=l13
lab=GND}
C {xschem/loop-filter/LOOP_FILTER.sym} 1000 0 0 0 {name=x3}
N 890 -30 920 -30 {}
C {lab_pin.sym} 890 -30 0 0 {name=p14
sig_type=std_logic
lab=VCP}
N 890 30 920 30 {}
C {lab_pin.sym} 890 30 0 0 {name=p15
sig_type=std_logic
lab=GND}
N 1080 0 1110 0 {}
C {lab_pin.sym} 1110 0 0 1 {name=p16
sig_type=std_logic
lab=VCTRL}
N 890 0 920 0 {}
C {lab_pin.sym} 890 0 0 0 {name=p17
sig_type=std_logic
lab=GND}
C {xschem/lc-vco/LC_VCO.sym} 1500 0 0 0 {name=x4}
N 1360 -30 1390 -30 {}
C {lab_pin.sym} 1360 -30 0 0 {name=p18
sig_type=std_logic
lab=VBGR}
N 1360 0 1390 0 {}
C {lab_pin.sym} 1360 0 0 0 {name=p19
sig_type=std_logic
lab=VCTRL}
N 1360 30 1390 30 {}
C {lab_pin.sym} 1360 30 0 0 {name=p20
sig_type=std_logic
lab=GND}
N 1610 -30 1640 -30 {}
C {lab_pin.sym} 1640 -30 0 1 {name=p21
sig_type=std_logic
lab=VDD}
N 1610 30 1640 30 {}
C {lab_pin.sym} 1640 30 0 1 {name=p22
sig_type=std_logic
lab=CLK_OUT}
N 1460 70 1460 100 {}
C {gnd.sym} 1460 100 0 0 {name=l23
lab=GND}
C {vsource.sym} 0 400 0 0 {name=V1
value=1.2
savecurrent=false}
N 0 340 0 370 {}
C {vdd.sym} 0 340 0 0 {name=l24
lab=VDD}
N 0 430 0 460 {}
C {gnd.sym} 0 460 0 0 {name=l25
lab=GND}
C {vsource.sym} 150 400 0 0 {name=VBGR
value=0.6
savecurrent=false}
N 150 340 150 370 {}
C {vdd.sym} 150 340 0 0 {name=l26
lab=VBGR}
N 150 430 150 460 {}
C {gnd.sym} 150 460 0 0 {name=l27
lab=GND}
C {vsource.sym} 300 400 0 0 {name=Vfref
value="0 pulse(0 1.2 0n 1n 1n 50n 100n)"
savecurrent=false}
N 300 340 300 370 {}
C {lab_pin.sym} 300 340 3 0 {name=p28
sig_type=std_logic
lab=CLK_IN}
N 300 430 300 460 {}
C {gnd.sym} 300 460 0 0 {name=l29
lab=GND}
C {opin.sym} 1900 30 0 0 {name=p30
lab=CLK_OUT}
N 1640 30 1900 30 {}
C {simulator_commands.sym} -100 600 0 0 {name=ANALYSIS only_toplevel=true
value="
*****************************************************
* Closed-loop PLL testbench (pre-layout)
* VBGR is an ideal source: the bandgap is a test block, not part of the tapeout.
*****************************************************
.option temp=27
.param VDD=1.2
.option rshunt=1.0e12
.include 4nH_INDUCTOR.spice
.include ../simulations/stimuli_test.cir

* Divider: compiled behavioural model of the DSM + N-divider (dsm_and_freq_divider.so),
* verified separately at transistor level (tb_DSM_N_FREQ_DIV, tb_DSM_N_FREQ_DIV_PEX).
adut [ dn1 dn2 dn3 dn4 dn5 ] [ dn6 ] null dut
.model dut d_cosim simulation=../simulations/dsm_and_freq_divider.so
A1 [ CLK_OUT ] [ dn1 ] adc1
A2 [ rst ] [ dn2 ] adc1
A3 [ sclk ] [ dn3 ] adc1
A4 [ sdata ] [ dn4 ] adc1
A5 [ en ] [ dn5 ] adc1
* ADC threshold: value used in the paper deck
.model adc1 adc_bridge in_low=0.76 in_high=0.76
A6 [ dn6 ] [ CLK_FB ] dac1
.model dac1 dac_bridge out_low=0 out_high=1.2
* gear method is stable for long oscillator runs
.options reltol=1e-3 abstol=1e-9 vntol=1e-6 method=gear
.control
  * save only the low-frequency loop signals plus the output clock
  save v(vctrl) v(up) v(dn) v(clk_fb) v(clk_out) v(clk_in) v(vcp) v1#branch
  tran 10p 100u
  meas tran idd avg i(V1) from=60u to=100u
  remzerovec
  write tb_LC_VCO_FPLL_100u.raw v(vctrl) v(up) v(dn) v(clk_fb) v(clk_out) v(clk_in) v(vcp)
.endc
"}
C {simulator_commands.sym} 500 600 0 0 {name=LIBS only_toplevel=true
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.include /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice
.global VDD GND
"}
