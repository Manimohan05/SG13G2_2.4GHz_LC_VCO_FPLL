v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -120 -80 -80 -80 {lab=UP}
N -120 80 -80 80 {lab=DN}
N 120 -0 200 0 {lab=VCP}
N 160 140 160 170 {lab=VSS}
N 160 60 200 60 {lab=VSS}
N 400 30 480 30 {lab=VCTRL}
N 440 60 440 100 {lab=VSS}
N 440 60 480 60 {lab=VSS}
N 0 170 0 200 {lab=VSS}
N -220 140 -220 170 {lab=VSS}
N -0 -170 0 -150 {lab=VDD}
N -220 -170 -220 -140 {lab=VDD}
N 540 160 540 180 {lab=VDD}
N 600 240 640 240 {lab=#net1}
N 730 60 730 240 {lab=CLK_OUT}
N 690 60 730 60 {lab=CLK_OUT}
N 540 390 540 410 {lab=VSS}
N 730 -40 730 0 {lab=VDD}
N 690 0 730 0 {lab=VDD}
N -450 70 -450 240 {lab=CLK_FB}
N -450 70 -410 70 {lab=CLK_FB}
N -450 -70 -410 -70 {lab=CLK_IN}
N 730 60 770 60 {lab=CLK_OUT}
N 70 300 110 300 {lab=EN}
N 70 320 110 320 {lab=SDATA}
N 70 340 110 340 {lab=SCLK}
N 600 320 640 320 {lab=#net2}
N 730 0 770 0 {lab=VDD}
N 160 140 200 140 {lab=VSS}
N 160 60 160 140 {lab=VSS}
N 400 -200 400 0 {lab=VBGR}
N 160 30 200 30 {lab=VSS}
N 160 30 160 60 {lab=VSS}
N 0 170 40 170 {lab=VSS}
N -0 150 0 170 {lab=VSS}
N 40 150 40 170 {lab=VSS}
N 40 -200 40 -150 {lab=VBGR}
N -120 -110 -120 -80 {lab=UP}
N -160 -80 -120 -80 {lab=UP}
N -120 80 -120 110 {lab=DN}
N -160 80 -120 80 {lab=DN}
N 120 -30 120 -0 {lab=VCP}
N 80 0 120 -0 {lab=VCP}
N 160 -230 160 -200 {lab=VBGR}
N 40 -200 160 -200 {lab=VBGR}
N 400 30 400 60 {lab=VCTRL}
N 360 30 400 30 {lab=VCTRL}
N 160 -200 400 -200 {lab=VBGR}
N -490 70 -450 70 {lab=CLK_FB}
N 400 0 480 0 {lab=VBGR}
N 400 -200 440 -200 {lab=VBGR}
N 700 320 730 320 {lab=RST}
N 700 240 730 240 {lab=CLK_OUT}
N 170 340 200 340 {lab=#net3}
N 170 320 200 320 {lab=#net4}
N 170 300 200 300 {lab=#net5}
N 60 240 100 240 {lab=CLK_FB}
N 160 240 200 240 {lab=#net6}
N -450 240 60 240 {lab=CLK_FB}
C {PHASE_FREQ_DET.sym} -290 0 0 0 {name=x1}
C {CHARGE_PUMP.sym} 0 0 0 0 {name=x2}
C {lab_pin.sym} -120 -110 3 1 {name=p8 sig_type=std_logic lab=UP}
C {lab_pin.sym} -120 110 3 0 {name=p7 sig_type=std_logic lab=DN}
C {lab_pin.sym} 120 -30 3 1 {name=p6 sig_type=std_logic lab=VCP}
C {gnd.sym} 160 170 0 0 {name=l4 lab=VSS}
C {lab_pin.sym} 400 60 1 1 {name=p4 lab=VCTRL}
C {gnd.sym} 440 100 0 0 {name=l1 lab=VSS}
C {gnd.sym} 0 200 0 0 {name=l2 lab=VSS}
C {gnd.sym} -220 170 0 0 {name=l3 lab=VSS}
C {vdd.sym} 0 -170 0 0 {name=l5 lab=VDD}
C {vdd.sym} -220 -170 0 0 {name=l6 lab=VDD}
C {vdd.sym} 540 160 0 0 {name=l7 lab=VDD}
C {gnd.sym} 540 410 0 0 {name=l8 lab=VSS}
C {vdd.sym} 730 -40 0 0 {name=l9 lab=VDD}
C {ipin.sym} -450 -70 2 1 {name=p1 lab=CLK_IN}
C {opin.sym} 770 60 2 1 {name=p2 lab=CLK_OUT}
C {ipin.sym} 70 300 2 1 {name=p3 lab=EN}
C {ipin.sym} 70 320 2 1 {name=p5 lab=SDATA}
C {ipin.sym} 70 340 2 1 {name=p9 lab=SCLK}
C {ipin.sym} 730 320 2 0 {name=p10 lab=RST}
C {lab_pin.sym} 160 -230 1 0 {name=p11 lab=VBGR}
C {iopin.sym} 770 0 2 1 {name=p12 lab=VDD}
C {iopin.sym} 200 140 2 1 {name=p13 lab=VSS}
C {lab_pin.sym} -490 70 0 0 {name=p14 lab=CLK_FB}
C {xschem/loop-filter/LOOP_FILTER.sym} 280 30 0 0 {name=x3}
C {xschem/lc-vco/LC_VCO.sym} 590 30 0 0 {name=x4}
C {xschem/dsm/xschem/DSM_N_FREQ_DIV.sym} 400 280 0 0 {name=adut
dut=dut
d_cosim_model= d_cosim
model=../simulations/dsm_and_freq_divider.so}
C {iopin.sym} 440 -200 2 1 {name=p15 lab=VBGR}
C {adc_bridge1.sym} 670 240 0 1 {name=A1
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.76
in_high=0.76
}
C {adc_bridge1.sym} 670 320 0 1 {name=A2
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.76
in_high=0.76
}
C {adc_bridge1.sym} 140 340 0 0 {name=A3
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.76
in_high=0.76
}
C {adc_bridge1.sym} 140 320 0 0 {name=A4
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.76
in_high=0.76
}
C {adc_bridge1.sym} 140 300 0 0 {name=A5
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.76
in_high=0.76
}
C {dac_bridge1.sym} 130 240 0 1 {name=A6
dac=dac1
dac_bridge_model=dac_bridge
out_low=0
out_high=1.2
}
