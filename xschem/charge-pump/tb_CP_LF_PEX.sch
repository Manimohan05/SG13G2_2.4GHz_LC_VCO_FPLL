v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 1580 -760 1580 -740 {lab=VDD}
N 1580 -680 1580 -660 {lab=GND}
N 1060 -430 1060 -410 {lab=GND}
N 1320 -680 1320 -660 {lab=GND}
N 1180 -440 1180 -420 {lab=GND}
N 1180 -760 1180 -740 {lab=VDD}
N 1260 -590 1380 -590 {lab=VCP}
N 1320 -760 1320 -740 {lab=VBGR}
N 1220 -760 1320 -760 {lab=VBGR}
N 1220 -760 1220 -740 {lab=VBGR}
N 1060 -510 1060 -490 {lab=DN}
N 1060 -510 1100 -510 {lab=DN}
N 1060 -670 1060 -650 {lab=UP}
N 1060 -670 1100 -670 {lab=UP}
N 1060 -590 1060 -570 {lab=GND}
N 1340 -530 1340 -510 {lab=GND}
N 1340 -530 1380 -530 {lab=GND}
N 1530 -560 1570 -560 {lab=CTRL}
C {lab_pin.sym} 1570 -560 0 1 {name=p4 lab=CTRL}
C {lab_pin.sym} 1300 -590 1 1 {name=p6 sig_type=std_logic lab=VCP}
C {vsource.sym} 1580 -710 0 0 {name=V1 value=1.2 savecurrent=false}
C {vdd.sym} 1580 -760 0 0 {name=l1 lab=VDD}
C {gnd.sym} 1580 -660 0 0 {name=l8 lab=GND}
C {simulator_commands.sym} 1410 -440 0 0 {name=OP only_toplevel=true 
value="
.include tb_CP.save
.param temp=27
.option method=gear rshunt=1.0e12
.control
save all 
op
write tb_CP_LF.raw
.endc
"
}
C {launcher.sym} 1100 -340 0 0 {name=h1
descr="OP annotate" 
tclcommand="xschem annotate_op"
}
C {simulator_commands.sym} 1270 -440 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.include /foss/designs/unicasss-tools/frac-n-pll-vco-unic_cass/pex/CHARGE_PUMP_V1__CHARGE_PUMP/magic_RC/CHARGE_PUMP.pex.spice
.include /foss/designs/unicasss-tools/frac-n-pll-vco-unic_cass/pex/LOOP_FILTER__LOOP_FILTER/magic_RC/LOOP_FILTER.pex.spice
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
"}
C {vsource.sym} 1060 -460 0 1 {name=V2 value="PULSE(0 1.2 3.1u 1n 1n 49n 100n 29)" savecurrent=false}
C {gnd.sym} 1060 -410 0 0 {name=l16 lab=GND}
C {lab_pin.sym} 1060 -510 0 0 {name=p7 sig_type=std_logic lab=DN}
C {simulator_commands.sym} 1550 -440 0 0 {name=TRAN only_toplevel=true 
value="
.param temp = 27
.options method=gear rshunt=1.0e12

.control

* Save required signals
save v(UP) v(DN) v(VCP) v(CTRL)

* Long transient simulation
tran 1n 6u

* Plot transient waveform
plot v(UP) v(DN) v(VCP) v(CTRL)
plot v(CTRL)

.endc
"
}
C {vsource.sym} 1060 -620 0 1 {name=V3 value="PULSE(1.2 0 20n 1n 1n 49n 100n 29)" savecurrent=false}
C {lab_pin.sym} 1060 -670 2 1 {name=p8 sig_type=std_logic lab=UP}
C {vsource.sym} 1320 -710 0 1 {name=VBGR value=0.6 savecurrent=false}
C {gnd.sym} 1320 -660 0 0 {name=l20 lab=GND}
C {gnd.sym} 1180 -420 0 0 {name=l3 lab=GND}
C {vdd.sym} 1180 -760 0 0 {name=l5 lab=VDD}
C {gnd.sym} 1060 -570 0 0 {name=l6 lab=GND}
C {gnd.sym} 1340 -510 0 0 {name=l2 lab=GND}
C {xschem/charge-pump/CHARGE_PUMP_PEX.sym} 1180 -590 0 0 {name=x1}
C {xschem/loop-filter/LOOP_FILTER_PEX.sym} 1460 -560 0 0 {name=x2}
C {lab_pin.sym} 1270 -760 1 1 {name=p1 sig_type=std_logic lab=VBGR}
