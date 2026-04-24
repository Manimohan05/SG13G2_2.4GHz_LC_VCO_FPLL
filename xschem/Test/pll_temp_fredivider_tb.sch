v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 800 -1200 1600 -800 {flags=graph
y1=-0.19685718
y2=1.4135428
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.3444715e-07
x2=2.6663273e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
hilight_wave=-1
color="7 4"
node="f_vco
f_div"}
B 2 1600 -800 2400 -400 {flags=graph
y1=-0.056
y2=1.3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.3444715e-07
x2=2.6663273e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color="11 7"
node="Ref;f_ref 0.03 +
f_div"
hilight_wave=1}
B 2 0 -1200 800 -800 {flags=graph
y1=-212.99966
y2=30.440979
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-5.845727e-08
x2=-1.0958429e-08
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
sim_type=sp
color="5 4"
node="Out;outp db20()
F_DIV;f_div db20()"
hilight_wave=-1}
B 2 1600 -1200 2400 -800 {flags=graph
y1=0.00046
y2=1.2
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.3444715e-07
x2=2.6663273e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color="9 6 12"
node="UP;VDD up -
dn
CTRL"
hilight_wave=-1
}
P 4 1 2310 -1050 {}
P 4 1 690 -600 {}
N 230 -300 230 -270 {lab=VDD}
N 230 -210 230 -170 {lab=GND}
N 170 -210 170 -190 {lab=IbiasVCO}
N 1090 -570 1140 -570 {lab=OUTn}
N 850 -570 880 -570 {lab=IbiasVCO}
N 980 -680 980 -670 {lab=VDD}
N 290 -600 310 -600 {lab=UP}
N 290 -560 310 -560 {lab=DN}
N 140 -650 140 -640 {lab=VDD}
N 570 -660 570 -650 {lab=VDD}
N 140 -520 140 -510 {lab=GND}
N 570 -530 570 -520 {lab=GND}
N 980 -490 980 -480 {lab=GND}
N 1290 -590 1320 -590 {lab=F_VCO}
N 770 -370 840 -370 {lab=F_VCO}
N 530 -370 590 -370 {lab=F_DIV}
N 100 -570 110 -570 {lab=F_DIV}
N 290 -210 290 -170 {lab=GND}
N 290 -330 290 -270 {lab=F_REF}
N 100 -590 110 -590 {lab=F_REF}
N 170 -300 170 -270 {lab=VDD}
N 670 -590 690 -590 {lab=CTRL}
N 850 -590 880 -590 {lab=CTRL}
N 490 -560 500 -560 {lab=IbiasCP}
N 110 -290 110 -270 {lab=IbiasCP}
N 110 -210 110 -170 {lab=GND}
N 480 -600 500 -600 {lab=UP}
N 480 -580 500 -580 {lab=DN}
N 1090 -590 1210 -590 {lab=#net1}
C {vsource.sym} 230 -240 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} 230 -170 0 0 {name=l1 lab=GND}
C {devices/vdd.sym} 230 -300 0 0 {name=l5 lab=VDD}
C {devices/isource.sym} 170 -240 0 0 {name=I0 value=50u}
C {vsource.sym} 290 -240 0 0 {name=Vfref value="0 pulse(0 1.2 0n 0.1n 0.1n 5n 10n)" savecurrent=false}
C {lab_pin.sym} 290 -330 0 1 {name=p11 sig_type=std_logic lab=F_REF}
C {gnd.sym} 290 -170 0 0 {name=l10 lab=GND}
C {launcher.sym} 1150 -420 0 0 {name=h1
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/tb_pll_freq_div.raw tran
"
}
C {launcher.sym} 1150 -380 0 0 {name=h4
descr=SimulateNGSPICE
tclcommand="
xschem netlist; 
xschem simulate; 
xschem raw_read $netlist_dir/tb_COMB.raw tran; 
xschem redraw
"}
C {lab_pin.sym} 490 -560 0 0 {name=p12 sig_type=std_logic lab=IbiasCP}
C {gnd.sym} 110 -170 0 0 {name=l11 lab=GND}
C {isource.sym} 110 -240 0 0 {name=I1 value=10m}
C {lab_pin.sym} 110 -290 1 0 {name=p13 sig_type=std_logic lab=IbiasCP}
C {lab_pin.sym} 310 -600 0 1 {name=p16 lab=UP}
C {lab_pin.sym} 310 -560 0 1 {name=p19 lab=DN}
C {lab_pin.sym} 1320 -590 0 1 {name=p23 lab=F_VCO}
C {lab_pin.sym} 530 -370 0 0 {name=p29 lab=F_DIV}
C {sg13g2_stdcells/sg13g2_inv_2.sym} 1250 -590 0 0 {name=x5 VDD=VDD VSS=GND prefix=sg13g2_ }
C {lab_pin.sym} 690 -590 0 1 {name=p10 lab=CTRL}
C {vdd.sym} 140 -650 0 0 {name=l6 lab=VDD}
C {vdd.sym} 570 -660 0 0 {name=l2 lab=VDD}
C {vdd.sym} 980 -680 0 0 {name=l4 lab=VDD}
C {lab_pin.sym} 170 -190 1 1 {name=p1 sig_type=std_logic lab=IbiasVCO
}
C {gnd.sym} 140 -510 0 0 {name=l3 lab=GND}
C {gnd.sym} 570 -520 0 0 {name=l7 lab=GND}
C {gnd.sym} 980 -480 0 0 {name=l8 lab=GND}
C {simulator_commands.sym} 1060 -280 0 0 {
name=Libs_Ngspice1
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ_stat
.include /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice
.global VDD GND


.param CP_N_L = 0.5u
.param CP_N_W = 10u
.param CP_P_M = 1
.param CP_P_L = 0.5u
.param CP_P_W = 30u
.param CP_N_M = 1
.param C_CP = 400p
"}
C {simulator_commands.sym} 1180 -280 0 0 {name=SimulatorNGSPICE
simulator=ngspice
only_toplevel=false 
value="
.model freq_div freq_div
.include ./IHP_4nH_Inductor.spice
.option temp = 27
.param VDD = 1.2
.ic v(OUTp)=0.6

.control
.options maxstep=100P reltol=1e-3 abstol=1e-6
pre_osdi ./freq_div.osdi
save v(CTRL) v(OUTp) v(F_REF) v(F_DIV) v(VDD) v(UP) v(DN) v(F_VCO) 

tran 50p 500n uic
write tb_pll_freq_div.raw
*quit 0
.endc
"}
C {title.sym} 160 -30 0 0 {name=l9 author="Skill Surf"}
C {lab_pin.sym} 100 -590 0 0 {name=p2 sig_type=std_logic lab=F_REF}
C {lab_pin.sym} 100 -570 0 0 {name=p3 lab=F_DIV}
C {lab_pin.sym} 840 -370 0 1 {name=p4 lab=F_VCO}
C {devices/vdd.sym} 170 -300 0 0 {name=l13 lab=VDD}
C {lab_pin.sym} 850 -570 2 1 {name=p5 sig_type=std_logic lab=IbiasVCO
}
C {lab_pin.sym} 850 -590 0 0 {name=p6 lab=CTRL}
C {lab_pin.sym} 480 -600 0 0 {name=p7 lab=UP}
C {lab_pin.sym} 480 -580 0 0 {name=p8 lab=DN}
C {lab_pin.sym} 1140 -570 0 1 {name=p9 lab=OUTn}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/charge-pump/CP.sym} 570 -590 0 0 {name=x2}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/phase-freq-detector/PFD.sym} 140 -580 0 0 {name=x3}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/lc-vco/LC_VCO.sym} 980 -580 0 0 {name=x4}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/Test/FD/Freq_Div_std.sym} 690 -370 0 1 {name=x7}
