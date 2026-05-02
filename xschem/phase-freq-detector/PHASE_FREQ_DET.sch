v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -100 90 -80 90 {lab=nRST}
N -100 -0 -100 90 {lab=nRST}
N -100 -90 -80 -90 {lab=nRST}
N -100 -0 20 0 {lab=nRST}
N -100 -90 -100 -0 {lab=nRST}
N 180 20 180 130 {lab=DN}
N 100 130 180 130 {lab=DN}
N 100 -110 140 -110 {lab=UP}
N 180 130 220 130 {lab=DN}
N 100 -130 210 -130 {lab=#net1}
N 210 -130 210 -20 {lab=#net1}
N -120 -110 -80 -110 {lab=VDD}
N -120 110 -80 110 {lab=VDD}
N -180 -130 -80 -130 {lab=FREF}
N -180 130 -80 130 {lab=FDIV}
N 100 110 140 110 {lab=#net2}
N -140 -40 -140 -20 {lab=VDD}
N -180 -20 -140 -20 {lab=VDD}
N -140 20 -140 40 {lab=GND}
N -180 20 -140 20 {lab=GND}
N 140 20 180 20 {lab=DN}
N 140 -20 210 -20 {lab=#net1}
C {opin.sym} 140 -110 0 0 {name=p4 lab=UP}
C {ipin.sym} -180 -130 2 1 {name=p12 lab=FREF}
C {iopin.sym} -180 -20 0 1 {name=p1 lab=VDD}
C {iopin.sym} -180 20 0 1 {name=p5 lab=GND}
C {opin.sym} 220 130 0 0 {name=p7 lab=DN}
C {ipin.sym} -180 130 0 0 {name=p20 lab=FDIV}
C {sg13g2_stdcells/sg13g2_dfrbp_2.sym} 10 -110 0 0 {name=x1 VDD=VDD VSS=GND prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_dfrbp_2.sym} 10 110 2 1 {name=x2 VDD=VDD VSS=GND prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_nand2_2.sym} 80 0 0 1 {name=x3 VDD=VDD VSS=GND prefix=sg13g2_ }
C {vdd.sym} -120 -110 3 0 {name=l12 lab=VDD}
C {vdd.sym} -120 110 3 0 {name=l1 lab=VDD}
C {noconn.sym} 140 110 2 0 {name=l2}
C {vdd.sym} -140 -40 0 1 {name=l4 lab=VDD}
C {gnd.sym} -140 40 0 1 {name=l14 lab=GND}
C {lab_pin.sym} -40 0 1 0 {name=p16 sig_type=std_logic lab=nRST}
