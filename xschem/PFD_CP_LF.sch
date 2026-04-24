v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -160 -80 -80 -80 {lab=UP}
N -160 80 -80 80 {lab=DN}
N 80 0 200 0 {lab=VCP}
N 160 130 160 160 {lab=VSS}
N 160 60 200 60 {lab=VSS}
N 360 30 400 30 {lab=VCTRL}
N 0 170 0 190 {lab=VSS}
N -220 140 -220 170 {lab=VSS}
N -0 -170 0 -150 {lab=VDD}
N -220 -170 -220 -140 {lab=VDD}
N 40 -170 40 -150 {lab=VBGR}
N -450 70 -410 70 {lab=CLK_FB}
N -450 -70 -410 -70 {lab=CLK_IN}
N -220 -170 -180 -170 {lab=VDD}
N 160 130 200 130 {lab=VSS}
N 160 60 160 130 {lab=VSS}
N 40 -170 120 -170 {lab=VBGR}
N -220 -200 -220 -170 {lab=VDD}
N 40 150 40 170 {lab=VSS}
N 0 170 40 170 {lab=VSS}
N -0 150 0 170 {lab=VSS}
N 160 30 200 30 {lab=VSS}
N 160 30 160 60 {lab=VSS}
C {xschem/PHASE_FREQ_DET.sym} -290 0 0 0 {name=x1}
C {xschem/CHARGE_PUMP.sym} 0 0 0 0 {name=x2}
C {xschem/LOOP_FILTER.sym} 280 30 0 0 {name=x3}
C {lab_pin.sym} -120 -80 3 1 {name=p8 sig_type=std_logic lab=UP}
C {lab_pin.sym} -120 80 3 0 {name=p7 sig_type=std_logic lab=DN}
C {lab_pin.sym} 120 0 1 1 {name=p6 sig_type=std_logic lab=VCP}
C {gnd.sym} 160 160 0 0 {name=l4 lab=VSS}
C {gnd.sym} 0 190 0 1 {name=l2 lab=VSS}
C {gnd.sym} -220 170 0 0 {name=l3 lab=VSS}
C {vdd.sym} 0 -170 0 0 {name=l5 lab=VDD}
C {vdd.sym} -220 -200 0 0 {name=l6 lab=VDD}
C {ipin.sym} -450 -70 2 1 {name=p1 lab=CLK_IN}
C {opin.sym} 400 30 2 1 {name=p2 lab=VCTRL}
C {iopin.sym} -180 -170 2 1 {name=p12 lab=VDD}
C {iopin.sym} 200 130 2 1 {name=p13 lab=VSS}
C {ipin.sym} -450 70 2 1 {name=p3 lab=CLK_FB}
C {iopin.sym} 120 -170 2 1 {name=p5 lab=VBGR}
