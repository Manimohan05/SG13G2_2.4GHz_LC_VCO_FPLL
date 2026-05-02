v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
L 4 400 -120 640 -120 {}
P 4 5 400 -180 400 260 640 260 640 -180 400 -180 {}
T {Guard Rings} 460 -160 0 0 0.4 0.4 {}
N 180 200 180 240 {lab=GND}
N -80 0 -80 40 {lab=IN}
N -80 100 -80 140 {lab=#net1}
N -80 200 -80 240 {lab=GND}
N 180 0 180 70 {lab=OUT}
N -80 -0 20 -0 {lab=IN}
N 80 0 180 0 {lab=OUT}
N 180 -0 300 -0 {lab=OUT}
N -260 -0 -80 0 {lab=IN}
N 180 200 220 200 {lab=GND}
N 180 130 180 200 {lab=GND}
N 520 -60 520 -40 {lab=SUB!}
N 520 200 520 220 {lab=GND}
N 520 20 520 40 {lab=GND}
N 480 120 520 120 {lab=SUB!}
N 520 120 520 140 {lab=SUB!}
C {opin.sym} 300 0 0 0 {name=p4 lab=OUT}
C {gnd.sym} -80 240 0 0 {name=l4 lab=GND}
C {sg13g2_pr/cap_cmim.sym} 180 100 0 1 {name=C2
model=cap_cmim
w=18.63e-6
l=18.63e-6
m=4
spiceprefix=X}
C {sg13g2_pr/cap_cmim.sym} -80 170 0 0 {name=C1
model=cap_cmim
w=48.34e-6
l=48.34e-6
m=16
spiceprefix=X}
C {iopin.sym} 220 200 2 1 {name=p3 lab=GND}
C {ipin.sym} -260 0 0 0 {name=p1 lab=IN}
C {sg13g2_pr/rppd.sym} 50 0 1 1 {name=R2
w=2e-6
l=407.2e-6
model=rppd
body=SUB!
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/rppd.sym} -80 70 2 0 {name=R1
w=2e-6
l=407.2e-6
model=rppd
body=SUB!
spiceprefix=X
b=0
m=1
}
C {gnd.sym} 180 240 0 0 {name=l1 lab=GND}
C {gnd.sym} 520 40 0 0 {name=l3 lab=GND}
C {gnd.sym} 520 220 0 0 {name=l6 lab=GND}
C {lab_pin.sym} 520 -60 3 1 {name=p34 sig_type=std_logic lab=SUB!}
C {lab_pin.sym} 520 120 3 1 {name=p2 sig_type=std_logic lab=SUB!}
C {xschem/pdk_custom_SYM/ptap1_ring.sym} 520 -10 2 0 {name=R3
model=ptap1
spiceprefix=X
w=46.34e-6
l=32.18e-6
rw=0.3e-6
}
C {xschem/pdk_custom_SYM/ptap1_ring.sym} 520 170 2 1 {name=R4
model=ptap1
spiceprefix=X
w=46.34e-6
l=32.18e-6
rw=0.3e-6
}
C {iopin.sym} 480 120 2 0 {name=p5 lab=SUB!}
