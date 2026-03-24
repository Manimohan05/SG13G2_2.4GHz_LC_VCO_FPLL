v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N 2020 530 2020 570 {
lab=#net1}
N 2310 530 2310 570 {
lab=#net1}
N 2020 430 2020 440 {
lab=OUTn}
N 2020 440 2020 480 {
lab=OUTn}
N 1990 500 2020 500 {
lab=GND}
N 2310 500 2340 500 {
lab=GND}
N 2170 570 2310 570 {
lab=#net1}
N 2060 500 2100 500 {
lab=OUTp}
N 2100 500 2230 440 {
lab=OUTp}
N 2230 440 2310 440 {
lab=OUTp}
N 2230 500 2270 500 {
lab=OUTn}
N 2080 440 2230 500 {
lab=OUTn}
N 2020 440 2080 440 {
lab=OUTn}
N 2310 440 2310 480 {
lab=OUTp}
N 1680 460 1710 460 {
lab=OUTn}
N 1680 580 1680 790 {
lab=VCTRL}
N 1970 670 2130 670 {
lab=Ibias}
N 1900 640 1970 640 {
lab=Ibias}
N 1970 640 1970 670 {
lab=Ibias}
N 2170 670 2170 710 {
lab=GND}
N 1900 670 1900 710 {
lab=GND}
N 2170 570 2170 640 {
lab=#net1}
N 1650 460 1650 540 {
lab=OUTn}
N 1710 460 1710 540 {
lab=OUTn}
N 1680 530 1680 540 {
lab=VDD}
N 1680 430 1680 460 {
lab=OUTn}
N 2310 430 2310 440 {
lab=OUTp}
N 1940 670 1970 670 {
lab=Ibias}
N 2020 570 2170 570 {
lab=#net1}
N 1650 460 1680 460 {
lab=OUTn}
N 2630 460 2660 460 {
lab=OUTp}
N 2630 580 2630 790 {
lab=VCTRL}
N 2600 460 2600 540 {
lab=OUTp}
N 2630 530 2630 540 {
lab=VDD}
N 2630 430 2630 460 {
lab=OUTp}
N 2600 460 2630 460 {
lab=OUTp}
N 1900 580 1900 640 {lab=Ibias}
N 1900 710 2170 710 {lab=GND}
N 1680 790 2630 790 {lab=VCTRL}
N 2020 70 2020 110 {
lab=OUTn}
N 2310 70 2310 110 {
lab=OUTp}
N 2060 40 2100 40 {
lab=OUTp}
N 2100 40 2240 110 {
lab=OUTp}
N 2240 110 2310 110 {
lab=OUTp}
N 2230 40 2270 40 {
lab=OUTn}
N 2080 110 2230 40 {
lab=OUTn}
N 2020 110 2080 110 {
lab=OUTn}
N 2020 0 2020 10 {
lab=VDD}
N 2020 -10 2310 -10 {
lab=VDD}
N 2310 0 2310 10 {
lab=VDD}
N 2310 40 2320 40 {
lab=VDD}
N 2320 0 2320 40 {
lab=VDD}
N 2310 0 2320 0 {
lab=VDD}
N 2010 40 2020 40 {
lab=VDD}
N 2010 0 2010 40 {
lab=VDD}
N 2010 0 2020 0 {
lab=VDD}
N 2310 -10 2310 0 {
lab=VDD}
N 2020 -10 2020 0 {
lab=VDD}
N 1680 430 2020 430 {
lab=OUTn}
N 2310 430 2630 430 {
lab=OUTp}
N 2660 460 2660 540 {lab=OUTp}
N 2310 260 2310 430 {
lab=OUTp}
N 2020 260 2020 430 {
lab=OUTn}
N 2190 360 2270 360 {
lab=OUTp}
N 2270 260 2310 260 {lab=OUTp}
N 2060 260 2110 260 {lab=OUTn}
N 2270 260 2270 360 {lab=OUTp}
N 2270 160 2270 260 {lab=OUTp}
N 2190 160 2270 160 {
lab=OUTp}
N 2060 160 2130 160 {lab=OUTn}
N 2060 160 2060 260 {lab=OUTn}
N 2020 260 2060 260 {lab=OUTn}
N 2060 260 2060 360 {lab=OUTn}
N 2060 360 2130 360 {lab=OUTn}
N 2200 260 2270 260 {lab=OUTp}
N 2310 110 2310 260 {
lab=OUTp}
N 2020 110 2020 260 {
lab=OUTn}
C {iopin.sym} 1550 -10 2 0 {name=p4 lab=VDD
}
C {devices/lab_pin.sym} 1990 500 0 0 {name=l4 sig_type=std_logic lab=GND}
C {devices/lab_pin.sym} 2340 500 0 1 {name=l6 sig_type=std_logic lab=GND}
C {devices/vdd.sym} 1680 530 0 0 {name=l17 lab=VDD}
C {devices/vdd.sym} 2630 530 0 0 {name=l21 lab=VDD}
C {opin.sym} 2310 370 0 0 {name=p11 lab=OUTp
}
C {opin.sym} 2020 370 2 0 {name=p12 lab=OUTn


}
C {iopin.sym} 2030 710 1 0 {name=p13 lab=GND
}
C {iopin.sym} 1680 790 2 0 {name=p14 lab=VCTRL
}
C {iopin.sym} 1900 580 3 0 {name=p15 lab=Ibias
}
C {devices/vdd.sym} 2170 -10 0 0 {name=l7 lab=VDD}
C {sg13g2_pr/sg13_lv_nmos.sym} 2150 670 0 0 {name=M6
l=0.15u
w=1u
ng=1
m=60
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1920 670 0 1 {name=M5
l=0.15u
w=1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 2290 40 0 0 {name=M4
l=0.5u
w=8.5u
ng=1
m=13
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 2040 40 0 1 {name=M3
l=0.5u
w=8.5u
ng=1
m=13
model=sg13_lv_pmos
spiceprefix=X5}
C {sg13g2_pr/sg13_lv_nmos.sym} 2290 500 0 0 {name=M2
l=0.5u
w=2u
ng=1
m=12
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 2040 500 0 1 {name=M1
l=0.5u
w=2u
ng=1
m=12
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/cap_cmim.sym} 2160 160 1 0 {name=C3
model=cap_cmim
w=4.26e-6
l=4.26e-6
m=12
spiceprefix=X}
C {sg13g2_pr/sg13_lv_pmos.sym} 2630 560 3 0 {name=Mv2
l=4u
w=4u
ng=1
m=22
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1680 560 3 0 {name=Mv1
l=4u
w=4u
ng=1
m=22
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/rhigh.sym} 2160 360 1 0 {name=R1
w=1e-6
l=0.79e-6
model=rhigh
body=sub!
spiceprefix=X
b=0
m=1}
C {ihp_4nh_inductor.sym} 2150 270 0 0 {name=x1}
