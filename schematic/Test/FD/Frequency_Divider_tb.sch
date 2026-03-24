v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1530 -1580 2330 -1180 {flags=graph
y1=-0.099462236
y2=1.4605378
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=6.0534353e-10
x2=2.0233659e-08
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
color="5 4"
node="F_OUT
F_REF"
hilight_wave=0}
B 2 1530 -1050 2330 -650 {flags=graph
y1=-152.9
y2=32.6
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-2.4792929e+08
x2=3.251731e+09
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
node="Out;F_OUT db20()
F_REF;F_REF db20()"
hilight_wave=-1}
P 4 1 2140 -1610 {}
N 250 -1090 250 -1060 {lab=VDD}
N 250 -1000 250 -960 {lab=GND}
N 580 -990 600 -990 {lab=F_OUT}
N 370 -990 400 -990 {lab=F_REF}
C {vsource.sym} 250 -1030 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} 250 -960 0 0 {name=l1 lab=GND}
C {devices/vdd.sym} 250 -1090 0 0 {name=l5 lab=VDD}
C {vsource.sym} 420 -1100 0 0 {name=Vfref value="0 pulse(0 1.2 0p 100p 100p 200p 400p)" savecurrent=false}
C {lab_pin.sym} 420 -1130 0 1 {name=p11 sig_type=std_logic lab=F_REF}
C {gnd.sym} 420 -1070 0 0 {name=l10 lab=GND}
C {launcher.sym} 1600 -1150 0 0 {name=h1
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/tb_Frequency_Divisder.raw tran
"
}
C {simulator_commands_shown.sym} 940 -1550 0 0 {name=SimulatorNGSPICE
simulator=ngspice
only_toplevel=false 
value="
.model freq_div freq_div
*.include tb_CP.save
.param RAW_TEMP = agauss(40, 30, 1)
.param TEMPGAUSS = max(20, min(RAW_TEMP, 80))
.option temp = 'TEMPGAUSS'
.param VDDGAUSS = agauss(1.2, 0.05, 1)

.param VDD = 'VDDGAUSS'
* analysis

.control
pre_osdi /foss/designs/PLL_IHP_PDK/src/freq_div.osdi
save all
write Frequency_divider_tb.raw
set appendwrite
let i = 0
dowhile i < 1

  
  tran 10p 200n uic
  write tb_Frequency_Divisder.raw
  linearize
  fft v(F_REF) v(F_OUT)
  write tb_Frequency_Divisder.raw
  let i = i + 1
end
*quit 0
.endc
"}
C {simulator_commands_shown.sym} 120 -1510 0 0 {
name=Libs_Ngspice1
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ_stat
.include /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice
.global VDD GND
"}
C {launcher.sym} 1600 -1110 0 0 {name=h4
descr=SimulateNGSPICE
tclcommand="
xschem netlist; 
xschem simulate; 
xschem raw_read $netlist_dir/tb_FreqDiv.raw tran; 
xschem redraw
"}
C {lab_pin.sym} 370 -990 0 0 {name=p1 sig_type=std_logic lab=F_REF}
C {lab_pin.sym} 600 -990 0 1 {name=p2 sig_type=std_logic lab=F_OUT}
C {Freq_Div_std.sym} 480 -990 0 0 {name=x1}
