v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 320 -960 1010 -960 {}
L 4 1010 -960 1010 -230 {}
L 4 320 -230 1010 -230 {}
L 4 320 -960 320 -230 {}
L 4 1130 -960 1130 -230 {}
L 4 1130 -230 1450 -230 {}
L 4 1450 -960 1450 -230 {}
L 4 1130 -960 1450 -960 {}
L 4 1470 -960 1470 -230 {}
L 4 1470 -230 2130 -230 {}
L 4 2130 -960 2130 -230 {}
L 4 1470 -960 2130 -960 {}
L 4 40 -960 260 -960 {}
L 4 40 -1020 40 -960 {}
P 4 5 -160 -1020 260 -1020 260 -600 -160 -600 -160 -1020 {}
T {Bias Generator} 340 -950 0 0 0.4 0.4 {}
T {Charge Pump} 1150 -950 0 0 0.4 0.4 {}
T {Loop Filter} 1490 -950 0 0 0.4 0.4 {}
T {Bias Current Gen} 60 -1000 0 0 0.4 0.4 {}
N 740 -330 740 -290 {lab=GND}
N 740 -470 740 -390 {lab=net2}
N 710 -360 740 -360 {lab=GND}
N 700 -500 740 -500 {lab=GND}
N 740 -560 740 -530 {lab=Vbn}
N 740 -740 740 -700 {lab=net1}
N 740 -860 740 -800 {lab=VDD}
N 790 -500 810 -500 {lab=Vbn}
N 790 -560 790 -500 {lab=Vbn}
N 780 -500 790 -500 {lab=Vbn}
N 740 -560 790 -560 {lab=Vbn}
N 430 -860 430 -800 {lab=VDD}
N 430 -610 430 -410 {lab=Ibias}
N 1080 -360 1240 -360 {lab=DN}
N 1280 -330 1280 -290 {lab=GND}
N 1280 -470 1280 -390 {lab=#net3}
N 1280 -360 1310 -360 {lab=GND}
N 1280 -500 1320 -500 {lab=GND}
N 1280 -740 1280 -700 {lab=#net4}
N 1280 -860 1280 -800 {lab=VDD}
N 1210 -500 1240 -500 {lab=Vbn}
N 1200 -670 1240 -670 {lab=Ibias}
N 1080 -770 1240 -770 {lab=UP}
N 1990 -590 2220 -590 {lab=CTRL}
N 1280 -590 1280 -530 {lab=CTRL1}
N 470 -770 510 -770 {lab=GND}
N 390 -770 430 -770 {lab=VDD}
N 390 -670 430 -670 {lab=VDD}
N 1280 -770 1320 -770 {lab=VDD}
N 1280 -670 1320 -670 {lab=VDD}
N 690 -770 740 -770 {lab=VDD}
N 690 -670 740 -670 {lab=VDD}
N 780 -770 820 -770 {lab=GND}
N 430 -740 430 -700 {lab=#net5}
N 490 -670 510 -670 {lab=Ibias}
N 1990 -390 1990 -290 {lab=GND}
N 1990 -590 1990 -450 {lab=CTRL}
N 780 -360 820 -360 {lab=VDD}
N 780 -670 820 -670 {lab=Ibias}
N 490 -670 490 -610 {lab=Ibias}
N 470 -670 490 -670 {lab=Ibias}
N 430 -610 490 -610 {lab=Ibias}
N 430 -640 430 -610 {lab=Ibias}
N 740 -640 740 -560 {lab=Vbn}
N 1880 -590 1990 -590 {lab=CTRL}
N 1760 -590 1820 -590 {lab=CTRL1}
N 1280 -640 1280 -590 {lab=CTRL1}
N 1280 -590 1550 -590 {lab=CTRL1}
N 1760 -590 1760 -560 {lab=CTRL1}
N 1550 -590 1760 -590 {lab=CTRL1}
N 1760 -500 1760 -450 {lab=CTRL2}
N 1760 -390 1760 -290 {lab=GND}
N 140 -670 200 -670 {lab=GND}
N 200 -720 200 -670 {lab=GND}
N 140 -720 200 -720 {lab=GND}
N 140 -690 140 -670 {lab=GND}
N -100 -670 -40 -670 {lab=GND}
N -100 -720 -100 -670 {lab=GND}
N -100 -720 -40 -720 {lab=GND}
N -40 -690 -40 -670 {lab=GND}
N 50 -720 100 -720 {lab=Vgs}
N 140 -670 140 -650 {lab=GND}
N -40 -670 -40 -650 {lab=GND}
N 50 -790 50 -720 {lab=Vgs}
N -40 -790 -40 -750 {lab=Vgs}
N -40 -910 20 -910 {lab=VDD}
N 20 -910 20 -860 {lab=VDD}
N -40 -860 20 -860 {lab=VDD}
N -40 -910 -40 -890 {lab=VDD}
N -40 -930 -40 -910 {lab=VDD}
N 0 -720 50 -720 {lab=Vgs}
N -40 -790 50 -790 {lab=Vgs}
N -40 -830 -40 -790 {lab=Vgs}
N 140 -880 140 -750 {lab=Vx}
N -200 -860 -80 -860 {lab=VBGR}
C {opin.sym} 180 -210 0 0 {name=p4 lab=CTRL}
C {ipin.sym} 110 -220 0 0 {name=p12 lab=UP}
C {ipin.sym} 110 -270 0 0 {name=p1 lab=VDD}
C {ipin.sym} 110 -160 0 0 {name=p5 lab=Ibias}
C {ipin.sym} 110 -190 0 0 {name=p20 lab=DN}
C {lab_pin.sym} 810 -500 0 1 {name=p14 sig_type=std_logic lab=Vbn}
C {lab_pin.sym} 710 -360 0 0 {name=p2 sig_type=std_logic lab=GND}
C {lab_pin.sym} 700 -500 0 0 {name=p8 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} 760 -500 0 1 {name=M2
l=2u
w=3u
ng=1
m=1
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 430 -410 0 1 {name=p18 sig_type=std_logic lab=Ibias}
C {sg13g2_pr/sg13_lv_pmos.sym} 450 -770 0 1 {name=M8
l=2u
w=10u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1210 -500 0 0 {name=p11 sig_type=std_logic lab=Vbn}
C {lab_pin.sym} 1310 -360 0 1 {name=p13 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1080 -360 0 0 {name=p17 sig_type=std_logic lab=DN}
C {lab_pin.sym} 1320 -500 0 1 {name=p21 sig_type=std_logic lab=GND}
C {lab_pin.sym} 2220 -590 0 1 {name=p25 sig_type=std_logic lab=CTRL}
C {lab_pin.sym} 510 -770 0 1 {name=p26 sig_type=std_logic lab=GND}
C {lab_pin.sym} 390 -770 0 0 {name=p27 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 390 -670 0 0 {name=p28 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 700 -770 0 0 {name=p29 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 700 -670 0 0 {name=p30 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1320 -770 0 1 {name=p31 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1320 -670 0 1 {name=p32 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 820 -770 0 1 {name=p33 sig_type=std_logic lab=GND}
C {ipin.sym} 110 -110 0 0 {name=p3 lab=GND}
C {lab_pin.sym} 820 -360 0 1 {name=p7 sig_type=std_logic lab=VDD}
C {lab_pin.sym} 1080 -770 0 0 {name=p24 sig_type=std_logic lab=UP}
C {lab_pin.sym} 740 -720 0 1 {name=p35 sig_type=std_logic lab=net1}
C {lab_pin.sym} 740 -440 0 1 {name=p36 sig_type=std_logic lab=net2}
C {sg13g2_pr/annotate_fet_params.sym} 890 -940 0 0 {name=annot1 ref=M3}
C {sg13g2_pr/annotate_fet_params.sym} 900 -380 0 0 {name=annot2 ref=M2}
C {sg13g2_pr/annotate_fet_params.sym} 1360 -942.105189945283 0 0 {name=annot3 ref=M9}
C {sg13g2_pr/annotate_fet_params.sym} 1372.208120310291 -302.105189945283 0 0 {name=annot4 ref=M6}
C {sg13g2_pr/rsil.sym} 1850 -590 1 0 {name=R2
w=0.5e-6
l=3848e-6
model=rsil
body=sub!
spiceprefix=X
b=0
m=1
}
C {gnd.sym} 1990 -290 0 0 {name=l2 lab=GND}
C {gnd.sym} 1280 -290 0 0 {name=l3 lab=GND}
C {gnd.sym} 740 -290 0 0 {name=l5 lab=GND}
C {vdd.sym} 430 -860 0 0 {name=l12 lab=VDD}
C {vdd.sym} 740 -860 0 0 {name=l6 lab=VDD}
C {vdd.sym} 1280 -860 0 0 {name=l7 lab=VDD}
C {sg13g2_pr/rsil.sym} 1760 -530 2 0 {name=R1
w=0.5e-6
l=3848e-6
model=rsil
body=sub!
spiceprefix=X
b=0
m=1
}
C {gnd.sym} 1760 -290 0 0 {name=l4 lab=GND}
C {lab_pin.sym} 1550 -590 3 1 {name=p6 sig_type=std_logic lab=CTRL1}
C {lab_pin.sym} 1760 -480 0 1 {name=p9 sig_type=std_logic lab=CTRL2}
C {sg13g2_pr/cap_cmim.sym} 1990 -420 0 0 {name=C3
model=cap_cmim
w=41.7e-6
l=41.7e-6
m=8
spiceprefix=X
ic=20}
C {sg13g2_pr/cap_cmim.sym} 1760 -420 0 0 {name=C2
model=cap_cmim
w=55.85e-6
l=55.85e-6
m=12
spiceprefix=X
ic=2}
C {lab_pin.sym} 510 -670 0 1 {name=p10 sig_type=std_logic lab=Ibias}
C {lab_pin.sym} 820 -670 0 1 {name=p15 sig_type=std_logic lab=Ibias}
C {lab_pin.sym} 1200 -670 0 0 {name=p16 sig_type=std_logic lab=Ibias}
C {sg13g2_pr/sg13_lv_pmos.sym} 450 -670 0 1 {name=M11
l=2u
w=10u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 760 -670 0 1 {name=M3
l=2u
w=10u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 760 -770 0 1 {name=M4
l=2u
w=10u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1260 -770 0 0 {name=M7
l=2u
w=10u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1260 -670 0 0 {name=M9
l=2u
w=10u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 760 -360 0 1 {name=M10
l=2u
w=3u
ng=1
m=1
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1260 -360 0 0 {name=M1
l=2u
w=3u
ng=1
m=1
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1260 -500 0 0 {name=M5
l=2u
w=3u
ng=1
m=1
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 120 -720 0 0 {name=M6
l=0.5u
w=70.29u
ng=20
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {gnd.sym} 140 -650 0 0 {name=l1 lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} -20 -720 0 1 {name=M12
l=0.5u
w=17.95u
ng=6
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {gnd.sym} -40 -650 0 1 {name=l8 lab=GND}
C {lab_pin.sym} 50 -790 2 0 {name=p22 sig_type=std_logic lab=Vgs
}
C {sg13g2_pr/sg13_lv_pmos.sym} -60 -860 0 0 {name=M13
l=0.5u
w=16.72u
ng=6
m=1
model=sg13_lv_pmos
spiceprefix=X}
C {ipin.sym} -200 -860 0 0 {name=p23 lab=VBGR}
C {vdd.sym} -40 -920 0 0 {name=l9 lab=VDD}
C {lab_pin.sym} 140 -880 0 1 {name=p34 sig_type=std_logic lab=Ibias}
