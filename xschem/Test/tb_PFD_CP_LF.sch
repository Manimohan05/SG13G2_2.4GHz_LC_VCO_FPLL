v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -160 -80 -80 -80 {lab=UP}
N -160 80 -80 80 {lab=DN}
N 0 -170 0 -150 {lab=VDD}
N 0 150 0 170 {lab=GND}
N -220 140 -220 170 {lab=GND}
N -220 -170 -220 -140 {lab=VDD}
N 80 0 200 0 {lab=VCP}
N 160 20 160 40 {lab=GND}
N 160 20 200 20 {lab=GND}
N 140 -90 140 -70 {lab=GND}
N 140 -170 140 -150 {lab=#net1}
N 40 -170 140 -170 {lab=#net1}
N 40 -170 40 -150 {lab=#net1}
N 360 10 400 10 {lab=CTRL}
N 400 -170 400 -150 {lab=VDD}
N 400 -90 400 -70 {lab=GND}
N -450 150 -450 170 {lab=GND}
N -450 70 -450 90 {lab=FDIV}
N -450 70 -410 70 {lab=FDIV}
N -450 -70 -450 -50 {lab=FREF}
N -450 -70 -410 -70 {lab=FREF}
N -450 10 -450 30 {lab=GND}
C {/foss/designs/uniccass-icdesign-tools/shared_xserver/frac-n-pll-vco-smacd_2026/schematic/charge-pump/CHARGE_PUMP.sym} 0 0 0 0 {name=x1}
C {/foss/designs/uniccass-icdesign-tools/shared_xserver/frac-n-pll-vco-smacd_2026/schematic/loop-filter/LOOP_FILTER.sym} 280 10 0 0 {name=x2}
C {/foss/designs/uniccass-icdesign-tools/shared_xserver/frac-n-pll-vco-smacd_2026/schematic/phase-freq-detector/PHASE_FREQ_DET.sym} -290 0 0 0 {name=x3}
C {lab_pin.sym} -120 -80 3 1 {name=p8 sig_type=std_logic lab=UP}
C {lab_pin.sym} -120 80 3 0 {name=p7 sig_type=std_logic lab=DN}
C {vdd.sym} -220 -170 0 0 {name=l5 lab=VDD}
C {vdd.sym} 0 -170 0 0 {name=l1 lab=VDD}
C {gnd.sym} 0 170 0 0 {name=l3 lab=GND}
C {gnd.sym} -220 170 0 0 {name=l2 lab=GND}
C {lab_pin.sym} 120 0 1 1 {name=p6 sig_type=std_logic lab=VCP}
C {gnd.sym} 160 40 0 0 {name=l4 lab=GND}
C {vsource.sym} 140 -120 0 1 {name=VBGR value=0.6 savecurrent=false}
C {gnd.sym} 140 -70 0 0 {name=l20 lab=GND}
C {lab_pin.sym} 400 10 0 1 {name=p4 lab=CTRL}
C {vsource.sym} 400 -120 0 0 {name=V1 value=1.2 savecurrent=false}
C {vdd.sym} 400 -170 0 0 {name=l6 lab=VDD}
C {gnd.sym} 400 -70 0 0 {name=l8 lab=GND}
C {vsource.sym} -450 120 0 1 {name=V2 value="PULSE(0 1.2 0 1n 1n 50n 102n)" savecurrent=false}
C {gnd.sym} -450 170 0 0 {name=l16 lab=GND}
C {lab_pin.sym} -450 70 0 0 {name=p1 sig_type=std_logic lab=FDIV}
C {vsource.sym} -450 -20 0 1 {name=V3 value="PULSE(0 1.2 0 1n 1n 49n 100n)" savecurrent=false}
C {lab_pin.sym} -450 -70 2 1 {name=p2 sig_type=std_logic lab=FREF}
C {gnd.sym} -450 30 0 0 {name=l7 lab=GND}
C {simulator_commands.sym} 230 140 0 0 {name=OP only_toplevel=true 
value="
.param temp=27
.option method=gear rshunt=1.0e12
.control
save all 
op
write tb_PFD_CP_LF.raw
.endc
"
}
C {launcher.sym} -100 240 0 0 {name=h1
descr="OP annotate" 
tclcommand="xschem annotate_op"
}
C {simulator_commands.sym} 90 140 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.include /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice
"}
C {simulator_commands.sym} 370 140 0 0 {name=TRAN only_toplevel=true 
value="
.param temp = 27
.options method=gear rshunt=1.0e12
.global VDD GND

.control

* Save required signals
save v(FREF) v(FDIV) v(UP) v(DN) v(VCP) v(CTRL)

* Long transient simulation
tran 0.1n 3u

* Plot transient waveform
plot v(VCP) v(CTRL)
plot v(FREF) v(FDIV)+1.5 v(UP)+3 v(DN)+4.5

.endc
"
}
