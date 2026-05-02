v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 800 -590 1600 -190 {flags=graph
y1=-0.097333465
y2=1.4626665
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1e-12
x2=1e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color="7 8"
node="f_ref
f_vco
"
hilight_wave=-1}
B 2 800 -990 1600 -590 {flags=graph
y1=-0.36399457
y2=1.7493495
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1e-12
x2=1e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color="9 10 12"
node="up
dn
CTRL"
hilight_wave=-1
hcursor1_y=0.20114425}
B 2 0 -990 800 -590 {flags=graph
y1=1.0055219
y2=1.2348454
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1e-12
x2=1e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color=11
node="vdd
"}
P 4 1 1550 -600 {}
P 4 1 630 -240 {}
C {vsource.sym} 80 -390 0 0 {name=Vdd value='VDD' savecurrent=false}
C {lab_pin.sym} 80 -420 0 1 {name=p3 sig_type=std_logic lab=VDD}
C {gnd.sym} 80 -360 0 0 {name=l3 lab=GND}
C {vsource.sym} 160 -390 0 0 {name=Vfvco value="0 pulse(0 'VDD' 6n 1n 1n 5n 10n)" savecurrent=false}
C {lab_pin.sym} 160 -420 0 1 {name=p10 sig_type=std_logic lab=F_VCO}
C {gnd.sym} 160 -360 0 0 {name=l1 lab=GND}
C {vsource.sym} 160 -490 0 0 {name=Vfref value="0 pulse(0 'VDD' 0n 1n 1n 5n 10n)" savecurrent=false}
C {lab_pin.sym} 160 -520 0 1 {name=p11 sig_type=std_logic lab=F_REF}
C {gnd.sym} 160 -460 0 0 {name=l2 lab=GND}
C {lab_pin.sym} 510 -280 0 0 {name=p5 lab=VDD}
C {lab_pin.sym} 610 -220 0 1 {name=p6 lab=CTRL}
C {lab_pin.sym} 510 -160 0 0 {name=p14 lab=GND}
C {launcher.sym} 600 -560 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/PFD_CP_tb.raw tran
"
}
C {launcher.sym} 600 -520 0 0 {name=h4
descr=SimulateNGSPICE
tclcommand="
xschem netlist; 
xschem simulate; 
xschem raw_read $netlist_dir/tb_CP.raw tran; 
xschem redraw
"}
C {lab_pin.sym} 80 -520 0 1 {name=p1 sig_type=std_logic lab=Ibias}
C {gnd.sym} 80 -460 0 0 {name=l5 lab=GND}
C {isource.sym} 80 -490 0 0 {name=I0 value=1u}
C {lab_pin.sym} 440 -190 0 0 {name=p2 sig_type=std_logic lab=Ibias}
C {lab_pin.sym} 170 -280 0 0 {name=p4 lab=VDD}
C {lab_pin.sym} 320 -240 0 1 {name=p8 lab=UP}
C {lab_pin.sym} 140 -230 0 0 {name=p9 lab=F_REF}
C {lab_pin.sym} 140 -210 0 0 {name=p13 lab=F_VCO}
C {lab_pin.sym} 320 -200 0 1 {name=p15 lab=DN}
C {lab_pin.sym} 170 -160 0 0 {name=p16 lab=GND}
C {lab_pin.sym} 440 -230 0 0 {name=p17 lab=UP}
C {lab_pin.sym} 440 -210 0 0 {name=p7 lab=DN}
C {simulator_commands.sym} 530 -440 0 0 {name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.include /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice
.global VDD GND


.param CP_N_L = 2u
.param CP_N_W = 3u
.param CP_P_M = 1
.param CP_P_L = 2u
.param CP_P_W = 10u
.param CP_N_M = 1
.param C_CP = 10p
"}
C {simulator_commands.sym} 660 -440 0 0 {name=Simulator
simulator=ngspice
only_toplevel=false 
value="
.param RAW_TEMP = agauss(40, 30, 1)
.param TEMPGAUSS = max(20, min(RAW_TEMP, 80))
.option temp = 'TEMPGAUSS'
.param VDDGAUSS = agauss(1.2, 0.05, 1)
.include ../simulations/PFD_std.pex.spice
.include ../simulations/CP_lvs.pex.spice
.param VDD = 'VDDGAUSS'
* analysis

.control
save all
*op
remzerovec
write tb_CP.raw
*set appendwrite
let i = 0
dowhile i < 1

  
  tran 100p 1u uic
  write PFD_CP_tb.raw
  let i = i + 1
end
quit 0
.endc
"}
C {devices/code_shown.sym} 800 -150 0 0 {name=MODEL1 only_toplevel=true
format="tcleval( @value )"
value="
.lib $::SG13G2_MODELS/cornerCAP.lib cap_typ
"}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/phase-freq-detector/PFD.sym} 170 -220 0 0 {name=x1}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/charge-pump/CP.sym} 510 -220 0 0 {name=x2}
