v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 -680 -340 -360 -340 {}
L 4 -360 -400 -360 -340 {}
L 4 470 360 680 360 {}
L 4 470 360 470 420 {}
L 4 -480 60 -260 60 {}
L 4 -480 0 -480 60 {}
L 4 -260 210 -50 210 {}
L 4 -50 150 -50 210 {}
L 4 470 210 680 210 {}
L 4 470 150 470 210 {}
L 4 830 -340 1370 -340 {}
L 4 830 -400 830 -110 {}
L 4 830 -110 830 60 {}
P 4 5 -260 -400 680 -400 680 420 -260 420 -260 -400 {}
P 4 5 -260 0 -260 -400 -680 -400 -680 0 -260 0 {}
P 4 5 -680 0 -260 0 -260 420 -680 420 -680 0 {}
P 4 5 470 -220 470 150 680 150 680 -220 470 -220 {}
P 4 5 -50 -220 -50 150 -260 150 -260 -220 -50 -220 {}
P 4 5 830 -400 1370 -400 1370 280 830 280 830 60 {}
T {S-Varicap Based Varactors} -660 -380 0 0 0.4 0.4 {}
T {Type-IV LC VCO} 490 380 0 0 0.4 0.4 {}
T {Bias Current Gen} -460 20 0 0 0.4 0.4 {}
T {Load Balancing} -240 170 0 0 0.4 0.4 {}
T {Output Buffer} 650 170 0 1 0.4 0.4 {}
T {Guard Rings} 1050 -380 0 0 0.4 0.4 {}
N 360 -230 360 -190 {
lab=OUTp}
N 100 -260 140 -260 {
lab=OUTp}
N 290 -190 360 -190 {
lab=OUTp}
N 60 -350 360 -350 {
lab=VDD}
N 60 -50 120 -50 {lab=OUTn}
N 300 -50 360 -50 {lab=OUTp}
N 360 -260 420 -260 {lab=NW}
N 420 -310 420 -260 {lab=NW}
N 0 -260 60 -260 {lab=NW}
N 0 -310 0 -260 {lab=NW}
N 420 200 420 260 {lab=SUB!}
N 360 200 420 200 {lab=SUB!}
N 360 230 360 270 {
lab=Vx}
N 0 200 0 260 {lab=SUB!}
N 0 200 60 200 {lab=SUB!}
N 60 230 60 270 {
lab=Vx}
N 360 130 360 180 {
lab=OUTp}
N 60 130 60 180 {
lab=OUTn}
N 60 -350 60 -290 {lab=VDD}
N 360 -350 360 -290 {lab=VDD}
N 280 -260 320 -260 {
lab=OUTn}
N 100 200 140 200 {
lab=OUTp}
N 280 200 320 200 {
lab=OUTn}
N 60 -190 130 -190 {
lab=OUTn}
N 60 -230 60 -190 {
lab=OUTn}
N 130 -190 280 -260 {lab=OUTn}
N 140 -260 290 -190 {lab=OUTp}
N 60 130 130 130 {
lab=OUTn}
N 290 130 360 130 {
lab=OUTp}
N 140 200 290 130 {lab=OUTp}
N 130 130 280 200 {lab=OUTn}
N -320 300 -320 350 {lab=SUB!}
N -380 300 -320 300 {lab=SUB!}
N -380 330 -380 370 {lab=GND}
N 360 -50 360 -30 {lab=OUTp}
N 360 -190 360 -50 {lab=OUTp}
N 360 -30 360 130 {lab=OUTp}
N 210 270 360 270 {
lab=Vx}
N -620 300 -620 350 {lab=SUB!}
N -620 300 -560 300 {lab=SUB!}
N -560 330 -560 370 {lab=GND}
N -470 300 -420 300 {lab=Vgs}
N 60 -50 60 -30 {lab=OUTn}
N 60 -190 60 -50 {lab=OUTn}
N 60 -30 60 130 {lab=OUTn}
N -580 -110 -510 -110 {lab=OUTn}
N -580 -170 -580 -110 {lab=OUTn}
N -580 -230 -510 -230 {lab=OUTn}
N -430 -110 -360 -110 {lab=OUTp}
N -360 -170 -360 -110 {lab=OUTp}
N -430 -230 -360 -230 {lab=OUTp}
N -360 -170 -340 -170 {lab=OUTp}
N -360 -230 -360 -170 {lab=OUTp}
N -600 -170 -580 -170 {lab=OUTn}
N -580 -230 -580 -170 {lab=OUTn}
N -470 -290 -470 -260 {lab=VCTRL}
N 210 -50 210 0 {lab=sub!}
N 120 -80 180 -80 {lab=OUTn}
N 120 -50 120 30 {lab=OUTn}
N 300 -50 300 30 {lab=OUTp}
N 240 -80 300 -80 {lab=OUTp}
N 210 270 210 390 {lab=Vx}
N 60 270 210 270 {
lab=Vx}
N -470 -80 -470 -50 {lab=VCTRL}
N -470 -50 -410 -50 {lab=VCTRL}
N 110 390 210 390 {lab=Vx}
N -470 230 -470 300 {lab=Vgs}
N -560 230 -560 270 {lab=Vgs}
N -500 110 -500 160 {lab=NWa}
N -560 160 -500 160 {lab=NWa}
N -560 90 -560 130 {lab=VDD}
N -520 300 -470 300 {lab=Vgs}
N -560 230 -470 230 {lab=Vgs}
N -560 190 -560 230 {lab=Vgs}
N -380 140 -380 270 {lab=Vx}
N -720 160 -600 160 {lab=VBGR}
N 570 -30 570 0 {lab=FOUT}
N 570 -60 570 -30 {lab=FOUT}
N 500 30 530 30 {lab=OUTp}
N 500 -90 530 -90 {lab=OUTp}
N 570 -90 630 -90 {lab=NW}
N 630 -140 630 -90 {lab=NW}
N 570 -160 570 -120 {lab=VDD}
N 630 30 630 80 {lab=SUB!}
N 570 30 630 30 {lab=SUB!}
N 570 60 570 100 {lab=GND}
N 360 -30 500 -30 {lab=OUTp}
N 500 -30 500 30 {lab=OUTp}
N -150 -60 -150 0 {lab=#net1}
N -110 30 -80 30 {lab=OUTn}
N -110 -90 -80 -90 {lab=OUTn}
N -210 -90 -150 -90 {lab=NW}
N -210 -140 -210 -90 {lab=NW}
N -150 -160 -150 -120 {lab=VDD}
N -210 30 -210 80 {lab=SUB!}
N -210 30 -150 30 {lab=SUB!}
N -150 60 -150 100 {lab=GND}
N -80 -30 -80 30 {lab=OUTn}
N -80 -30 60 -30 {lab=OUTn}
N -80 -90 -80 -30 {lab=OUTn}
N 500 -90 500 -30 {lab=OUTp}
N 300 -80 300 -50 {lab=OUTp}
N 120 -80 120 -50 {lab=OUTn}
N 520 -320 580 -320 {lab=VDD}
N 520 -340 520 -320 {lab=VDD}
N 520 -280 580 -280 {lab=GND}
N 520 -280 520 -260 {lab=GND}
N 570 -30 720 -30 {lab=FOUT}
N -720 -290 -470 -290 {lab=VCTRL}
N 1070 -270 1070 -260 {lab=VDD}
N 940 -270 940 -260 {lab=VDD}
N 1070 20 1070 30 {lab=GND}
N 1070 -50 1070 -40 {lab=sub!}
N 1070 210 1070 220 {lab=GND}
N 1070 140 1070 150 {lab=SUB!}
N 940 -200 940 -190 {lab=NW}
N 1070 -200 1070 -190 {lab=NW}
N 940 210 940 220 {lab=GND}
N 940 140 940 150 {lab=SUB!}
N 1330 -270 1330 -260 {lab=VDD}
N 1200 -270 1200 -260 {lab=VDD}
N 1200 -200 1200 -190 {lab=NW}
N 1330 -200 1330 -190 {lab=NW}
N 1330 210 1330 220 {lab=GND}
N 1330 140 1330 150 {lab=SUB!}
N 1200 210 1200 220 {lab=GND}
N 1200 140 1200 150 {lab=SUB!}
N 1330 20 1330 30 {lab=GND}
N 1330 -50 1330 -40 {lab=SUB!}
N 1200 20 1200 30 {lab=GND}
N 1200 -50 1200 -40 {lab=SUB!}
N 940 -60 940 -50 {lab=VDD}
N 940 10 940 20 {lab=NWa}
C {sg13g2_pr/sg13_lv_nmos.sym} -400 300 0 0 {name=M5
l=1u
w=384u
ng=48
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 340 -260 0 0 {name=M4
l=0.13u
w=36u
ng=5
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 80 -260 0 1 {name=M3
l=0.13u
w=36u
ng=5
m=1
model=sg13_lv_pmos
spiceprefix=X}
C {sg13g2_pr/sg13_lv_nmos.sym} 340 200 0 0 {name=M2
l=0.13u
w=21.99u
ng=3
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 80 200 0 1 {name=M1
l=0.13u
w=21.99u
ng=3
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {gnd.sym} -380 370 0 0 {name=l3 lab=GND}
C {lab_pin.sym} -380 140 1 0 {name=p2 sig_type=std_logic lab=Vx
}
C {sg13g2_pr/sg13_lv_nmos.sym} -540 300 0 1 {name=M6
l=1u
w=64u
ng=8
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {gnd.sym} -560 370 0 1 {name=l8 lab=GND}
C {lab_pin.sym} -470 230 2 0 {name=p1 sig_type=std_logic lab=Vgs
}
C {sg13g2_pr/cap_rfcmim.sym} 210 -80 3 0 {name=C1 
model=cap_rfcmim
lvs_model=rfcmim
w=21.9e-6
l=21.9e-6
wfeed=10.0e-6
spiceprefix=X
}
C {sg13g2_pr/sg13_svaricap.sym} -470 -110 2 0 {name=C3 
model=sg13_hv_svaricap 
w=9.74u 
l=0.8u 
Nx=7
spiceprefix=X
}
C {sg13g2_pr/sg13_svaricap.sym} -470 -230 0 1 {name=C2 
model=sg13_hv_svaricap 
w=9.74u 
l=0.8u 
Nx=7
spiceprefix=X
}
C {lab_pin.sym} -340 -170 2 0 {name=p6 sig_type=std_logic lab=OUTp
}
C {lab_pin.sym} -600 -170 2 1 {name=p7 sig_type=std_logic lab=OUTn
}
C {lab_pin.sym} 110 390 2 1 {name=p10 sig_type=std_logic lab=Vx
}
C {lab_pin.sym} -410 -50 0 1 {name=p13 sig_type=std_logic lab=VCTRL
}
C {sg13g2_pr/sg13_lv_pmos.sym} -580 160 0 0 {name=M7
l=1u
w=38u
ng=5
m=1
model=sg13_lv_pmos
spiceprefix=X}
C {sg13g2_pr/sg13_lv_pmos.sym} 550 -90 0 0 {name=M8
l=0.13u
w=15u
ng=10
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 550 30 0 0 {name=M9
l=0.13u
w=1.5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {gnd.sym} 570 100 0 0 {name=l14 lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} -130 -90 0 1 {name=M10
l=0.13u
w=15u
ng=10
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -130 30 0 1 {name=M11
l=0.13u
w=1.5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {gnd.sym} -150 100 0 1 {name=l16 lab=GND}
C {opin.sym} 720 -30 0 0 {name=p5 lab=FOUT
}
C {lab_pin.sym} 60 100 2 1 {name=p8 sig_type=std_logic lab=OUTn
}
C {lab_pin.sym} 360 100 2 0 {name=p9 sig_type=std_logic lab=OUTp
}
C {ipin.sym} -720 -290 0 0 {name=p11 lab=VCTRL}
C {ipin.sym} -720 160 0 0 {name=p4 lab=VBGR}
C {iopin.sym} 580 -320 0 0 {name=p14 lab=VDD}
C {iopin.sym} 580 -280 0 0 {name=p3 lab=GND}
C {gnd.sym} 520 -260 0 0 {name=l5 lab=GND}
C {vdd.sym} -560 100 0 0 {name=l6 lab=VDD}
C {vdd.sym} -150 -160 0 0 {name=l9 lab=VDD}
C {vdd.sym} 220 -350 0 0 {name=l7 lab=VDD}
C {vdd.sym} 520 -340 0 0 {name=l4 lab=VDD}
C {vdd.sym} 570 -160 0 0 {name=l12 lab=VDD}
C {iopin.sym} 120 30 1 0 {name=p12 lab=OUTn}
C {iopin.sym} 300 30 1 0 {name=p15 lab=OUTp}
C {xschem/pdk_custom_SYM/ntap1_ring.sym} 1070 -230 0 1 {name=R1
model=ntap1
spiceprefix=X
w=10.22e-6
l=5.87e-6
rw=0.3e-6
}
C {lab_pin.sym} 1070 -190 3 0 {name=p17 sig_type=std_logic lab=NW}
C {vdd.sym} 1070 -270 0 1 {name=l10 lab=VDD}
C {xschem/pdk_custom_SYM/ntap1_ring.sym} 940 -230 0 1 {name=R2
model=ntap1
spiceprefix=X
w=10.22e-6
l=5.87e-6
rw=0.3e-6
}
C {lab_pin.sym} 940 -190 3 0 {name=p18 sig_type=std_logic lab=NW}
C {vdd.sym} 940 -270 0 1 {name=l13 lab=VDD}
C {xschem/pdk_custom_SYM/ptap1_ring.sym} 1070 -10 2 0 {name=R3
model=ptap1
spiceprefix=X
w=33.9e-6
l=14.41e-6
rw=0.3e-6
}
C {gnd.sym} 1070 30 0 1 {name=l15 lab=GND}
C {xschem/pdk_custom_SYM/ptap1_ring.sym} 1070 180 2 0 {name=R4
model=ptap1
spiceprefix=X
w=10.09e-6
l=4.23e-6
rw=0.3e-6
}
C {lab_pin.sym} 1070 140 3 1 {name=p20 sig_type=std_logic lab=SUB!}
C {gnd.sym} 1070 220 0 1 {name=l17 lab=GND}
C {xschem/pdk_custom_SYM/ptap1_ring.sym} 940 180 2 0 {name=R5
model=ptap1
spiceprefix=X
w=10.09e-6
l=4.23e-6
rw=0.3e-6
}
C {lab_pin.sym} 940 140 3 1 {name=p21 sig_type=std_logic lab=SUB!}
C {gnd.sym} 940 220 0 1 {name=l18 lab=GND}
C {lab_pin.sym} 630 -140 1 0 {name=p16 sig_type=std_logic lab=NW}
C {lab_pin.sym} -210 -140 1 0 {name=p22 sig_type=std_logic lab=NW}
C {lab_pin.sym} 630 80 1 1 {name=p23 sig_type=std_logic lab=SUB!}
C {lab_pin.sym} -210 80 1 1 {name=p24 sig_type=std_logic lab=SUB!}
C {lab_pin.sym} 0 260 1 1 {name=p25 sig_type=std_logic lab=SUB!}
C {lab_pin.sym} 420 260 1 1 {name=p26 sig_type=std_logic lab=SUB!}
C {lab_pin.sym} 420 -310 1 0 {name=p27 sig_type=std_logic lab=NW}
C {lab_pin.sym} 0 -310 1 0 {name=p28 sig_type=std_logic lab=NW}
C {lab_pin.sym} -500 110 1 0 {name=p29 sig_type=std_logic lab=NWa}
C {lab_pin.sym} -320 350 1 1 {name=p30 sig_type=std_logic lab=SUB!}
C {lab_pin.sym} -620 350 1 1 {name=p31 sig_type=std_logic lab=SUB!}
C {xschem/pdk_custom_SYM/ntap1_ring.sym} 1330 -230 0 1 {name=R6
model=ntap1
spiceprefix=X
w=8.42e-6
l=4.52e-6
rw=0.3e-6
}
C {lab_pin.sym} 1330 -190 3 0 {name=p32 sig_type=std_logic lab=NW}
C {vdd.sym} 1330 -270 0 1 {name=l1 lab=VDD}
C {xschem/pdk_custom_SYM/ntap1_ring.sym} 1200 -230 0 1 {name=R7
model=ntap1
spiceprefix=X
w=8.42e-6
l=4.52e-6
rw=0.3e-6
}
C {lab_pin.sym} 1200 -190 3 0 {name=p33 sig_type=std_logic lab=NW}
C {vdd.sym} 1200 -270 0 1 {name=l2 lab=VDD}
C {xschem/pdk_custom_SYM/ptap1_ring.sym} 1330 180 2 0 {name=R8
model=ptap1
spiceprefix=X
w=3.21e-6
l=4.26e-6
rw=0.3e-6
}
C {lab_pin.sym} 1330 140 3 1 {name=p19 sig_type=std_logic lab=SUB!}
C {gnd.sym} 1330 220 0 1 {name=l20 lab=GND}
C {xschem/pdk_custom_SYM/ptap1_ring.sym} 1200 180 2 0 {name=R9
model=ptap1
spiceprefix=X
w=3.21e-6
l=4.26e-6
rw=0.3e-6
}
C {lab_pin.sym} 1200 140 3 1 {name=p34 sig_type=std_logic lab=SUB!}
C {gnd.sym} 1200 220 0 1 {name=l21 lab=GND}
C {xschem/pdk_custom_SYM/ptap1_ring.sym} 1330 -10 2 0 {name=R10
model=ptap1
spiceprefix=X
w=10.76e-6
l=13.74e-6
rw=0.3e-6
}
C {lab_pin.sym} 1330 -50 3 1 {name=p35 sig_type=std_logic lab=SUB!}
C {gnd.sym} 1330 30 0 1 {name=l22 lab=GND}
C {xschem/pdk_custom_SYM/ptap1_ring.sym} 1200 -10 2 0 {name=R11
model=ptap1
spiceprefix=X
w=12.36e-6
l=57.9e-6
rw=0.3e-6
}
C {lab_pin.sym} 1200 -50 3 1 {name=p36 sig_type=std_logic lab=SUB!}
C {gnd.sym} 1200 30 0 1 {name=l23 lab=GND}
C {xschem/pdk_custom_SYM/ntap1_ring.sym} 940 -20 0 1 {name=R12
model=ntap1
spiceprefix=X
w=10.62e-6
l=10.22e-6
rw=0.3e-6
}
C {lab_pin.sym} 940 20 3 0 {name=p37 sig_type=std_logic lab=NWa}
C {vdd.sym} 940 -60 0 1 {name=l24 lab=VDD}
C {lab_pin.sym} 1070 -50 3 1 {name=p38 sig_type=std_logic lab=sub!}
C {lab_pin.sym} 210 0 1 1 {name=p39 sig_type=std_logic lab=sub!}
