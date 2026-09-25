v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {xschem/phase-freq-detector/PHASE_FREQ_DET_PEX.sym} 0 0 0 0 {name=x1}
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
C {xschem/charge-pump/CHARGE_PUMP_PEX.sym} 600 0 0 0 {name=x2}
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
C {xschem/loop-filter/LOOP_FILTER_PEX.sym} 1000 0 0 0 {name=x3}
N 890 -30 920 -30 {}
C {lab_pin.sym} 890 -30 0 0 {name=p13
sig_type=std_logic
lab=VCP}
N 890 30 920 30 {}
C {lab_pin.sym} 890 30 0 0 {name=p14
sig_type=std_logic
lab=GND}
N 1080 0 1110 0 {}
C {lab_pin.sym} 1110 0 0 1 {name=p15
sig_type=std_logic
lab=VCTRL}
C {xschem/lc-vco/LC_VCO_NOIND.sym} 1500 0 0 0 {name=x4}
N 1360 0 1390 0 {}
C {lab_pin.sym} 1360 0 0 0 {name=p16
sig_type=std_logic
lab=VCTRL}
N 1360 -30 1390 -30 {}
C {lab_pin.sym} 1360 -30 0 0 {name=p17
sig_type=std_logic
lab=VBGR}
N 1360 30 1390 30 {}
C {lab_pin.sym} 1360 30 0 0 {name=p18
sig_type=std_logic
lab=GND}
N 1610 -30 1640 -30 {}
C {lab_pin.sym} 1640 -30 0 1 {name=p19
sig_type=std_logic
lab=VDD}
N 1610 30 1640 30 {}
C {lab_pin.sym} 1640 30 0 1 {name=p20
sig_type=std_logic
lab=CLK_OUT}
N 1500 70 1500 100 {}
C {lab_pin.sym} 1500 100 1 0 {name=p21
sig_type=std_logic
lab=OUTp}
N 1540 70 1540 100 {}
C {lab_pin.sym} 1540 100 1 0 {name=p22
sig_type=std_logic
lab=OUTn}
C {xschem/lc-vco/4nH_INDUCTOR.sym} 1750 -200 0 0 {name=xind}
N 1680 -210 1710 -210 {}
C {lab_pin.sym} 1680 -210 0 0 {name=p23
sig_type=std_logic
lab=OUTn}
N 1800 -210 1830 -210 {}
C {lab_pin.sym} 1830 -210 0 1 {name=p24
sig_type=std_logic
lab=OUTp}
C {vsource.sym} 0 400 0 0 {name=V1
value=1.2
savecurrent=false}
N 0 340 0 370 {}
C {vdd.sym} 0 340 0 0 {name=l25
lab=VDD}
N 0 430 0 460 {}
C {gnd.sym} 0 460 0 0 {name=l26
lab=GND}
C {vsource.sym} 150 400 0 0 {name=VBGR
value=0.6
savecurrent=false}
N 150 340 150 370 {}
C {vdd.sym} 150 340 0 0 {name=l27
lab=VBGR}
N 150 430 150 460 {}
C {gnd.sym} 150 460 0 0 {name=l28
lab=GND}
C {vsource.sym} 300 400 0 0 {name=Vfref
value="0 pulse(0 1.2 0n 1n 1n 50n 100n)"
savecurrent=false}
N 300 340 300 370 {}
C {lab_pin.sym} 300 340 3 0 {name=p29
sig_type=std_logic
lab=CLK_IN}
N 300 430 300 460 {}
C {gnd.sym} 300 460 0 0 {name=l30
lab=GND}
C {opin.sym} 1900 30 0 0 {name=p31
lab=CLK_OUT}
N 1640 20 1900 20 {}
C {simulator_commands.sym} -100 600 0 0 {name=ANALYSIS only_toplevel=true
value="
*****************************************************
* Closed-loop PLL testbench (post-layout, extracted blocks)
* VBGR is an ideal source: the bandgap is a test block, not part of the tapeout.
*****************************************************
.option temp=27
.param VDD=1.2
.option rshunt=1.0e12
.include 4nH_INDUCTOR.spice
.include ../simulations/stimuli_test.cir
* start-up kick: a noise-free run can stay at the unstable equilibrium at low VCTRL
.ic v(OUTp)=0.4
* extracted (Magic RC) netlists of the blocks; the inductor is the EM model above
.include ../pex/PHASE_FREQ_DET__PHASE_FREQ_DET/magic_RC/PHASE_FREQ_DET.pex.spice
.include ../pex/CHARGE_PUMP_V2__CHARGE_PUMP/magic_RC/CHARGE_PUMP.pex.spice
.include ../pex/LOOP_FILTER__LOOP_FILTER/magic_RC/LOOP_FILTER.pex.spice
.include ../pex/LC_VCO_NOIND__LC_VCO_NOIND/magic_RC/LC_VCO_NOIND.pex_sim.spice
* Divider: compiled behavioural model of the DSM + N-divider (dsm_and_freq_divider.so),
* verified separately at transistor level (tb_DSM_N_FREQ_DIV, tb_DSM_N_FREQ_DIV_PEX).
adut [ dn1 dn2 dn3 dn4 dn5 ] [ dn6 ] null dut
.model dut d_cosim simulation=../simulations/dsm_and_freq_divider.so
A1 [ CLK_OUT ] [ dn1 ] adc1
A2 [ rst ] [ dn2 ] adc1
A3 [ sclk ] [ dn3 ] adc1
A4 [ sdata ] [ dn4 ] adc1
A5 [ en ] [ dn5 ] adc1
* ADC threshold: 0.6 V = mid-swing of the extracted VCO output (measured -0.03 V to 1.22 V)
.model adc1 adc_bridge in_low=0.6 in_high=0.6
A6 [ dn6 ] [ CLK_FB ] dac1
.model dac1 dac_bridge out_low=0 out_high=1.2
* gear method is stable for long oscillator runs
.options reltol=1e-3 abstol=1e-9 vntol=1e-6 method=gear
.control
  * save only the low-frequency loop signals plus the output clock
  save v(vctrl) v(up) v(dn) v(clk_fb) v(clk_out) v(clk_in) v(vcp) v1#branch
  tran 10p 40u
  meas tran idd avg i(V1) from=20u to=40u
  remzerovec
  write tb_LC_VCO_FPLL_PEX_40u.raw v(vctrl) v(up) v(dn) v(clk_fb) v(clk_out) v(clk_in) v(vcp)
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
