v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 1320 -890 1520 -890 {}
L 4 760 -360 960 -360 {}
L 4 960 -360 960 -300 {}
L 4 1600 -890 1880 -890 {}
L 4 1600 -950 1600 -660 {}
L 4 1600 -660 1700 -660 {}
L 4 1700 -660 1700 -500 {}
L 4 1600 -500 1700 -500 {}
P 4 5 1320 -950 1520 -950 1520 -300 1320 -300 1320 -950 {}
P 4 5 760 -890 1240 -890 1240 -300 760 -300 760 -890 {}
P 4 5 1600 -950 1880 -950 1880 -300 1600 -300 1600 -500 {}
T {Bias Generator} 780 -340 0 0 0.4 0.4 {}
T {Charge Pump} 1350 -930 0 0 0.4 0.4 {}
T {Guard Rings} 1670 -930 0 0 0.4 0.4 {}
N 1100 -370 1100 -350 {lab=GND}
N 1100 -730 1100 -690 {lab=#net1}
N 1140 -520 1180 -520 {lab=Vbn}
N 1280 -420 1370 -420 {lab=DN}
N 1410 -520 1470 -520 {lab=SUB!}
N 1280 -760 1370 -760 {lab=UP}
N 1410 -660 1470 -660 {lab=NW}
N 880 -730 880 -690 {lab=#net2}
N 1140 -420 1180 -420 {lab=VDD}
N 1140 -660 1370 -660 {lab=Vbp}
N 920 -660 960 -660 {lab=Vbp}
N 1100 -590 1100 -550 {lab=Vbn}
N 1410 -760 1470 -760 {lab=NW}
N 1470 -810 1470 -760 {lab=NW}
N 1410 -830 1410 -790 {lab=VDD}
N 1410 -730 1410 -690 {lab=#net3}
N 1410 -590 1410 -550 {lab=VCP}
N 1410 -490 1410 -450 {lab=#net4}
N 1470 -760 1470 -660 {lab=NW}
N 1470 -420 1470 -370 {lab=SUB!}
N 1410 -420 1470 -420 {lab=SUB!}
N 1410 -390 1410 -350 {lab=GND}
N 1470 -520 1470 -420 {lab=SUB!}
N 1410 -590 1560 -590 {lab=VCP}
N 1410 -630 1410 -590 {lab=VCP}
N 1280 -420 1280 -360 {lab=DN}
N 1280 -820 1280 -760 {lab=UP}
N 1180 -450 1180 -420 {lab=VDD}
N 1040 -520 1100 -520 {lab=SUB!}
N 1040 -420 1040 -370 {lab=SUB!}
N 1040 -420 1100 -420 {lab=SUB!}
N 1100 -390 1100 -370 {lab=GND}
N 1180 -590 1180 -520 {lab=Vbn}
N 1100 -590 1180 -590 {lab=Vbn}
N 1140 -760 1180 -760 {lab=GND}
N 1180 -760 1180 -730 {lab=GND}
N 1040 -760 1100 -760 {lab=NW}
N 1040 -810 1040 -760 {lab=NW}
N 1100 -810 1160 -810 {lab=VDD}
N 1040 -760 1040 -660 {lab=NW}
N 1040 -660 1100 -660 {lab=NW}
N 1100 -810 1100 -790 {lab=VDD}
N 1100 -830 1100 -810 {lab=VDD}
N 1100 -630 1100 -590 {lab=Vbn}
N 1180 -520 1370 -520 {lab=Vbn}
N 960 -660 960 -590 {lab=Vbp}
N 880 -590 960 -590 {lab=Vbp}
N 880 -630 880 -590 {lab=Vbp}
N 1100 -490 1100 -450 {lab=#net5}
N 920 -760 960 -760 {lab=GND}
N 960 -760 960 -730 {lab=GND}
N 820 -760 880 -760 {lab=bulk1}
N 820 -810 820 -760 {lab=bulk1}
N 820 -760 820 -660 {lab=bulk1}
N 820 -660 880 -660 {lab=bulk1}
N 880 -830 880 -790 {lab=VDD}
N 880 -520 940 -520 {lab=SUB!}
N 880 -490 880 -450 {lab=GND}
N 880 -590 880 -550 {lab=Vbp}
N 720 -520 840 -520 {lab=VBGR}
N 1100 -370 1140 -370 {lab=GND}
N 1040 -450 1040 -420 {lab=SUB!}
N 1840 -830 1840 -820 {lab=VDD}
N 1710 -830 1710 -820 {lab=VDD}
N 1840 -540 1840 -530 {lab=GND}
N 1840 -610 1840 -600 {lab=SUB!}
N 1840 -350 1840 -340 {lab=GND}
N 1840 -420 1840 -410 {lab=SUB!}
N 1710 -760 1710 -750 {lab=NW}
N 1840 -760 1840 -750 {lab=NW}
N 1710 -350 1710 -340 {lab=GND}
N 1710 -420 1710 -410 {lab=SUB!}
N 1040 -520 1040 -450 {lab=SUB!}
N 990 -450 1040 -450 {lab=SUB!}
C {opin.sym} 1560 -590 0 0 {name=p4 lab=VCP}
C {ipin.sym} 1280 -820 1 0 {name=p12 lab=UP}
C {ipin.sym} 1280 -360 3 0 {name=p20 lab=DN}
C {sg13g2_pr/sg13_lv_nmos.sym} 1120 -520 0 1 {name=M2
l=2u
w=40.7u
ng=5
m=1
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 900 -760 0 1 {name=M8
l=2u
w=29.6u
ng=5
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1280 -520 3 0 {name=p11 sig_type=std_logic lab=Vbn}
C {iopin.sym} 1140 -370 0 0 {name=p3 lab=GND}
C {gnd.sym} 1410 -350 0 0 {name=l3 lab=GND}
C {gnd.sym} 1100 -350 0 0 {name=l5 lab=GND}
C {vdd.sym} 880 -830 0 0 {name=l12 lab=VDD}
C {vdd.sym} 1100 -830 0 0 {name=l6 lab=VDD}
C {vdd.sym} 1410 -830 0 0 {name=l7 lab=VDD}
C {lab_pin.sym} 1280 -660 1 0 {name=p16 sig_type=std_logic lab=Vbp}
C {sg13g2_pr/sg13_lv_pmos.sym} 900 -660 0 1 {name=M11
l=2u
w=163.6u
ng=20
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1120 -660 0 1 {name=M3
l=2u
w=163.6u
ng=20
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1120 -760 0 1 {name=M4
l=2u
w=29.6u
ng=5
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1390 -760 0 0 {name=M7
l=2u
w=29.6u
ng=5
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1390 -660 0 0 {name=M9
l=2u
w=163.6u
ng=20
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1120 -420 0 1 {name=M10
l=2u
w=6u
ng=1
m=1
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1390 -420 0 0 {name=M1
l=2u
w=6u
ng=1
m=1
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1390 -520 0 0 {name=M5
l=2u
w=40.7u
ng=5
m=1
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
model=sg13_lv_nmos
spiceprefix=X
}
C {vdd.sym} 1180 -450 0 0 {name=l10 lab=VDD}
C {gnd.sym} 1180 -730 0 0 {name=l11 lab=GND}
C {gnd.sym} 960 -730 0 0 {name=l15 lab=GND}
C {lab_pin.sym} 960 -590 0 1 {name=p2 sig_type=std_logic lab=Vbp}
C {iopin.sym} 720 -520 0 1 {name=p5 lab=VBGR}
C {gnd.sym} 880 -450 0 1 {name=l17 lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} 860 -520 0 0 {name=M6
l=2u
w=3.9u
ng=1
m=1
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
model=sg13_lv_nmos
spiceprefix=X
}
C {iopin.sym} 1160 -810 2 1 {name=p1 lab=VDD}
C {lab_pin.sym} 820 -810 1 0 {name=p6 sig_type=std_logic lab=NW}
C {lab_pin.sym} 1040 -810 1 0 {name=p7 sig_type=std_logic lab=NW}
C {lab_pin.sym} 1470 -810 1 0 {name=p8 sig_type=std_logic lab=NW}
C {xschem/pdk_custom_SYM/ntap1_ring.sym} 1840 -790 0 1 {name=R1
model=ntap1
spiceprefix=X
w=51e-6
l=36e-6
rw=0.3e-6
}
C {lab_pin.sym} 1840 -750 3 0 {name=p9 sig_type=std_logic lab=NW}
C {vdd.sym} 1840 -830 0 1 {name=l1 lab=VDD}
C {xschem/pdk_custom_SYM/ntap1_ring.sym} 1710 -790 0 1 {name=R2
model=ntap1
spiceprefix=X
w=30.5e-6
l=15.5e-6
rw=0.3e-6
}
C {lab_pin.sym} 1710 -750 3 0 {name=p10 sig_type=std_logic lab=NW}
C {vdd.sym} 1710 -830 0 1 {name=l2 lab=VDD}
C {lab_pin.sym} 940 -520 2 0 {name=p13 sig_type=std_logic lab=SUB!}
C {xschem/pdk_custom_SYM/ptap1_ring.sym} 1840 -570 2 0 {name=R3
model=ptap1
spiceprefix=X
w=5.68e-6
l=7.26e-6
rw=0.3e-6
}
C {lab_pin.sym} 1840 -610 3 1 {name=p14 sig_type=std_logic lab=SUB!}
C {gnd.sym} 1840 -530 0 1 {name=l4 lab=GND}
C {lab_pin.sym} 1040 -370 1 1 {name=p15 sig_type=std_logic lab=SUB!}
C {lab_pin.sym} 1470 -370 1 1 {name=p17 sig_type=std_logic lab=SUB!}
C {xschem/pdk_custom_SYM/ptap1_ring.sym} 1840 -380 2 0 {name=R4
model=ptap1
spiceprefix=X
w=30e-6
l=12.54e-6
rw=0.3e-6
}
C {lab_pin.sym} 1840 -420 3 1 {name=p18 sig_type=std_logic lab=SUB!}
C {gnd.sym} 1840 -340 0 1 {name=l8 lab=GND}
C {xschem/pdk_custom_SYM/ptap1_ring.sym} 1710 -380 2 0 {name=R5
model=ptap1
spiceprefix=X
w=20e-6
l=6e-6
rw=0.3e-6
}
C {lab_pin.sym} 1710 -420 3 1 {name=p19 sig_type=std_logic lab=SUB!}
C {gnd.sym} 1710 -340 0 1 {name=l9 lab=GND}
C {iopin.sym} 990 -450 0 1 {name=p21 lab=SUB!}
