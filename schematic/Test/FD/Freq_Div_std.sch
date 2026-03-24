v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N 610 -230 620 -230 {lab=#net1}
N 620 -230 620 -160 {lab=#net1}
N 360 -160 620 -160 {lab=#net1}
N 360 -230 360 -160 {lab=#net1}
N 360 -230 430 -230 {lab=#net1}
N 910 -230 920 -230 {lab=#net2}
N 920 -230 920 -160 {lab=#net2}
N 660 -160 920 -160 {lab=#net2}
N 660 -230 660 -160 {lab=#net2}
N 660 -230 730 -230 {lab=#net2}
N 610 -250 730 -250 {lab=#net3}
N 910 -250 1000 -250 {lab=#net4}
N 1180 -230 1190 -230 {lab=#net5}
N 1190 -230 1190 -160 {lab=#net5}
N 930 -160 1190 -160 {lab=#net5}
N 930 -230 930 -160 {lab=#net5}
N 930 -230 1000 -230 {lab=#net5}
N 1180 -250 1270 -250 {lab=#net6}
N 1450 -230 1460 -230 {lab=#net7}
N 1460 -230 1460 -160 {lab=#net7}
N 1200 -160 1460 -160 {lab=#net7}
N 1200 -230 1200 -160 {lab=#net7}
N 1200 -230 1270 -230 {lab=#net7}
N 1450 -250 1540 -250 {lab=#net8}
C {sg13g2_stdcells/sg13g2_dfrbp_1.sym} 520 -230 0 0 {name=x6 VDD=VDD VSS=GND prefix=sg13g2_ }
C {lab_pin.sym} 430 -250 0 0 {name=p29 lab=F_IN}
C {sg13g2_stdcells/sg13g2_dfrbp_2.sym} 820 -230 0 0 {name=x5 VDD=VDD VSS=GND prefix=sg13g2_ }
C {lab_pin.sym} 430 -210 0 0 {name=p30 lab=VDD}
C {lab_pin.sym} 730 -210 0 0 {name=p31 lab=VDD}
C {sg13g2_stdcells/sg13g2_dfrbp_2.sym} 1090 -230 0 0 {name=x7 VDD=VDD VSS=GND prefix=sg13g2_ }
C {lab_pin.sym} 1000 -210 0 0 {name=p32 lab=VDD}
C {sg13g2_stdcells/sg13g2_dfrbp_2.sym} 1360 -230 0 0 {name=x8 VDD=VDD VSS=GND prefix=sg13g2_ }
C {lab_pin.sym} 1270 -210 0 0 {name=p33 lab=VDD}
C {opin.sym} 180 -210 0 0 {name=p4 lab=F_OUT}
C {ipin.sym} 120 -210 0 0 {name=p1 lab=F_IN}
C {title.sym} 160 -30 0 0 {name=l1 author="Rajinthan R"}
C {lab_pin.sym} 1540 -250 0 1 {name=p2 lab=F_OUT}
