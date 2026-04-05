v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 40 -960 260 -960 {}
L 4 40 -1020 40 -960 {}
P 4 5 -160 -1020 260 -1020 260 -600 -160 -600 -160 -1020 {}
T {Bias Current Gen} 60 -1000 0 0 0.4 0.4 {}
N -180 -730 -180 -690 {lab=GND}
N -180 -860 -180 -790 {lab=VBGR}
N 160 -670 220 -670 {lab=GND}
N 220 -720 220 -670 {lab=GND}
N 160 -720 220 -720 {lab=GND}
N 160 -690 160 -670 {lab=GND}
N -80 -670 -20 -670 {lab=GND}
N -80 -720 -80 -670 {lab=GND}
N -80 -720 -20 -720 {lab=GND}
N -20 -690 -20 -670 {lab=GND}
N 70 -720 120 -720 {lab=Vgs}
N 160 -670 160 -650 {lab=GND}
N -20 -670 -20 -650 {lab=GND}
N 70 -790 70 -720 {lab=Vgs}
N -20 -790 -20 -750 {lab=Vgs}
N -20 -910 40 -910 {lab=VDD}
N 40 -910 40 -860 {lab=VDD}
N -20 -860 40 -860 {lab=VDD}
N -20 -910 -20 -890 {lab=VDD}
N -20 -930 -20 -910 {lab=VDD}
N 20 -720 70 -720 {lab=Vgs}
N -20 -790 70 -790 {lab=Vgs}
N -20 -830 -20 -790 {lab=Vgs}
N -180 -860 -60 -860 {lab=VBGR}
N 160 -820 160 -750 {lab=#net1}
N 680 -750 680 -710 {lab=GND}
N 680 -850 680 -810 {lab=VDD}
C {lab_pin.sym} -180 -860 1 0 {name=p4 sig_type=std_logic lab=VBGR
}
C {vsource.sym} -180 -760 0 0 {name=VBGR1 value=0.6 savecurrent=false}
C {gnd.sym} -180 -690 0 0 {name=l4 lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} 140 -720 0 0 {name=M5
l=1u
w=384u
ng=48
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {gnd.sym} 160 -650 0 0 {name=l3 lab=GND}
C {lab_pin.sym} 160 -880 1 0 {name=p2 sig_type=std_logic lab=ibias
}
C {sg13g2_pr/sg13_lv_nmos.sym} 0 -720 0 1 {name=M6
l=1u
w=64u
ng=8
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {gnd.sym} -20 -650 0 1 {name=l8 lab=GND}
C {lab_pin.sym} 70 -790 2 0 {name=p1 sig_type=std_logic lab=Vgs
}
C {sg13g2_pr/sg13_lv_pmos.sym} -40 -860 0 0 {name=M7
l=1u
w=38u
ng=5
m=1
model=sg13_lv_pmos
spiceprefix=X}
C {vdd.sym} -20 -920 0 0 {name=l6 lab=VDD}
C {ammeter.sym} 160 -850 0 0 {name=Vtail savecurrent=true spice_ignore=0}
C {simulator_commands.sym} 290 -850 0 0 {name=ANALYSIS only_toplevel=true 
value="

.param temp = 27
.options method=gear rshunt=1e12

.control

* Run operating point analysis
op

* Print current through ibias (Vtail source)
print i(Vtail)
tran 1n 1u
plot i(Vtail)

.endc
"
}
C {simulator_commands.sym} 440 -850 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
"}
C {vsource.sym} 680 -780 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} 680 -710 0 0 {name=l13 lab=GND}
C {vdd.sym} 680 -845 0 0 {name=l1 lab=VDD}
