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
N 440 120 440 140 {lab=VSS}
N 440 60 480 60 {lab=VSS}
N 0 170 0 200 {lab=VSS}
N -220 140 -220 170 {lab=VSS}
N -0 -170 0 -150 {lab=VDD}
N -220 -170 -220 -140 {lab=VDD}
N 400 -200 480 -200 {lab=VBGR}
N 640 160 640 180 {lab=VDD}
N 700 240 740 240 {lab=CLK_OUT}
N 740 60 740 240 {lab=CLK_OUT}
N 700 60 740 60 {lab=CLK_OUT}
N 640 390 640 410 {lab=VSS}
N 740 -40 740 0 {lab=VDD}
N 700 0 740 0 {lab=VDD}
N -450 240 300 240 {lab=CLK_FB}
N -450 70 -450 240 {lab=CLK_FB}
N -450 70 -410 70 {lab=CLK_FB}
N -450 -70 -410 -70 {lab=CLK_IN}
N 740 60 780 60 {lab=CLK_OUT}
N 260 300 300 300 {lab=EN}
N 260 320 300 320 {lab=SDATA}
N 260 340 300 340 {lab=SCLK}
N 700 320 740 320 {lab=RST}
N 740 0 780 0 {lab=VDD}
N 160 140 200 140 {lab=VSS}
N 160 60 160 140 {lab=VSS}
N 440 -250 440 -230 {lab=VDD}
N 400 -200 400 0 {lab=VBGR}
N 160 30 200 30 {lab=VSS}
N 160 30 160 60 {lab=VSS}
N 0 170 40 170 {lab=VSS}
N -0 150 0 170 {lab=VSS}
N 40 150 40 170 {lab=VSS}
N 660 -200 660 -110 {lab=VSS}
N 640 -200 660 -200 {lab=VSS}
N 440 -110 440 -80 {lab=VSS}
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
N 440 -110 660 -110 {lab=VSS}
N 440 -170 440 -110 {lab=VSS}
N 440 -170 480 -170 {lab=VSS}
N 440 -230 480 -230 {lab=VDD}
N -490 70 -450 70 {lab=CLK_FB}
N 400 0 480 0 {lab=VBGR}
N 440 60 440 120 {lab=VSS}
N 0 300 0 320 {lab=VDD}
N 0 380 0 400 {lab=#net1}
C {xschem/phase-freq-detector/PHASE_FREQ_DET_PEX.sym} -290 0 0 0 {name=x1}
C {xschem/charge-pump/CHARGE_PUMP_PEX.sym} 0 0 0 0 {name=x2}
C {xschem/loop-filter/LOOP_FILTER_PEX.sym} 280 30 0 0 {name=x3}
C {lab_pin.sym} -120 -110 3 1 {name=p8 sig_type=std_logic lab=UP}
C {lab_pin.sym} -120 110 3 0 {name=p7 sig_type=std_logic lab=DN}
C {lab_pin.sym} 120 -30 3 1 {name=p6 sig_type=std_logic lab=VCP}
C {gnd.sym} 160 170 0 0 {name=l4 lab=VSS}
C {lab_pin.sym} 400 60 1 1 {name=p4 lab=VCTRL}
C {xschem/lc-vco/LC_VCO_NOIND.sym} 590 30 0 0 {name=x4}
C {gnd.sym} 440 140 0 0 {name=l1 lab=VSS}
C {gnd.sym} 0 200 0 0 {name=l2 lab=VSS}
C {gnd.sym} -220 170 0 0 {name=l3 lab=VSS}
C {xschem/dsm/xschem/DSM_N_FREQ_DIV_PEX.sym} 500 280 0 0 {name=x5}
C {vdd.sym} 0 -170 0 0 {name=l5 lab=VDD}
C {vdd.sym} -220 -170 0 0 {name=l6 lab=VDD}
C {vdd.sym} 640 160 0 0 {name=l7 lab=VDD}
C {gnd.sym} 640 410 0 0 {name=l8 lab=VSS}
C {vdd.sym} 740 -40 0 0 {name=l9 lab=VDD}
C {ipin.sym} -450 -70 2 1 {name=p1 lab=CLK_IN}
C {opin.sym} 780 60 2 1 {name=p2 lab=CLK_OUT}
C {ipin.sym} 260 300 2 1 {name=p3 lab=EN}
C {ipin.sym} 260 320 2 1 {name=p5 lab=SDATA}
C {ipin.sym} 260 340 2 1 {name=p9 lab=SCLK}
C {ipin.sym} 740 320 2 0 {name=p10 lab=RST}
C {lab_pin.sym} 160 -230 1 0 {name=p11 lab=VBGR}
C {iopin.sym} 780 0 2 1 {name=p12 lab=VDD}
C {iopin.sym} 200 140 2 1 {name=p13 lab=VSS}
C {lab_pin.sym} -490 70 0 0 {name=p14 lab=CLK_FB}
C {xschem/bgr/BANDGAP_REF_PEX.sym} 520 -200 0 0 {name=x6}
C {vdd.sym} 440 -250 0 0 {name=l10 lab=VDD}
C {gnd.sym} 440 -80 0 0 {name=l11 lab=VSS}
N 590 100 590 130 {lab=OUTp}
N 630 100 630 130 {lab=OUTn}
C {lab_pin.sym} 590 130 1 0 {name=p20 sig_type=std_logic lab=OUTp}
C {lab_pin.sym} 630 130 1 0 {name=p21 sig_type=std_logic lab=OUTn}
N 830 110 860 110 {lab=OUTp}
N 950 110 980 110 {lab=OUTn}
C {lab_pin.sym} 830 110 0 0 {name=p22 sig_type=std_logic lab=OUTp}
C {lab_pin.sym} 980 110 0 1 {name=p23 sig_type=std_logic lab=OUTn}
C {xschem/lc-vco/4nH_INDUCTOR.sym} 900 120 0 0 {name=xind}
C {sg13g2_pr/cap_cmim.sym} 0 350 0 0 {name=C1
model=cap_cmim
 w=20.0e-6
 l=20.0e-6
 m=40
  mm_ok=1
 spiceprefix=X}
C {vdd.sym} 0 300 0 0 {name=l12 lab=VDD}
C {gnd.sym} 0 400 0 0 {name=l13 lab=VSS}
