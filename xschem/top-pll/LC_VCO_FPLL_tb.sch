v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1600 -800 2400 -400 {flags=graph
y1=0
y2=1.3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x2=60.5e-06
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
node="clk_out
xpll.clk_fb"
x1=60e-06
rawfile=$netlist_dir/tb_LC_VCO_FPLL_100u.raw}
B 2 0 -1200 800 -800 {flags=graph
y1=0
y2=1.3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=60e-06
x2=60.5e-06
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=1
autoload=0
color="4 7"
node="clk_out
clk_in"
rawfile=$netlist_dir/tb_LC_VCO_FPLL_100u.raw}
B 2 800 -1200 1600 -800 {flags=graph
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x2=400e-06
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=-1
hcursor1_y=0.712
hcursor2_y=0.81
color=12
node=xpll.vctrl
autoload=1
rawfile=$netlist_dir/tb_LC_VCO_FPLL_100u.raw
x1=22e-06
vlegend=0
y2=1.
y1=0}
B 2 1600 -1200 2400 -800 {flags=graph
y1=-0.00011
y2=1.3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x2=65e-06
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=-1
hcursor1_y=0.3997472
hcursor2_y=0.82900464
color="4 7"
node="xpll.dn
xpll.up"
rawfile=$netlist_dir/tb_LC_VCO_FPLL_100u.raw
autoload=1
x1=60e-06}
B 2 440 -360 1600 -150 {flags=graph
y1=0
y2=3
ypos1=0.15
ypos2=3.15
divy=5
subdivy=1
unity=1
x1=60e-06

subdivx=4
xlabmag=1.2
ylabmag=1.0

dataset=-1
unitx=1
logx=0
logy=0
digital=1
divx=4
legend=1
color="7 9 11 8 10 12 15 17"
node="rst
en
sclk
sdata
xpll.clk_fb
xpll.x4.outp
clk_in
clk_out"
rawfile=$netlist_dir/tb_LC_VCO_FPLL_100u.raw
autoload=1
x2=80e-06}
B 2 1600 -400 2400 0 {flags=graph
y1=0
y2=1.3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x2=60.5e-06
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
color="12 7"
node="xpll.clk_fb
clk_in"
rawfile=$netlist_dir/tb_LC_VCO_FPLL_100u.raw
x1=60e-06}
P 4 1 2340 -1060 {}
N 140 -720 140 -620 {lab=VDD}
N 140 -560 140 -510 {lab=GND}
N 720 -500 720 -460 {lab=GND}
N 720 -730 720 -700 {lab=VDD}
N 390 -650 390 -640 {lab=CLK_IN}
N 390 -650 490 -650 {lab=CLK_IN}
N 390 -580 390 -540 {lab=GND}
N 60 -550 60 -510 {lab=GND}
N 490 -650 600 -650 {lab=CLK_IN}
N 840 -590 880 -590 {lab=CLK_OUT}
N 470 -550 510 -550 {lab=sclk}
N 470 -570 510 -570 {lab=sdata}
N 470 -590 510 -590 {lab=rst}
N 470 -610 510 -610 {lab=en}
N 510 -610 590 -610 {lab=en}
N 510 -590 590 -590 {lab=rst}
N 510 -570 590 -570 {lab=sdata}
N 510 -550 590 -550 {lab=sclk}
N 60 -720 60 -610 {lab=VBGR}
N 670 -730 670 -700 {lab=VBGR}
C {vsource.sym} 140 -590 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} 140 -510 0 0 {name=l1 lab=GND}
C {vdd.sym} 140 -720 0 0 {name=l5 lab=VDD}
C {vsource.sym} 390 -610 0 1 {name=Vfref value="0 pulse(0 1.2 0n 1n 1n 50n 100n)" savecurrent=false}
C {gnd.sym} 390 -540 0 0 {name=l10 lab=GND}
C {launcher.sym} 1360 -660 0 0 {name=h1
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/simulation/tb_LC_VCO_FPLL_40u.raw tran
"
}
C {launcher.sym} 1360 -620 0 0 {name=h4
descr=SimulateNGSPICE
tclcommand="
xschem netlist; 
xschem simulate; 
xschem raw_read $netlist_dir/pll_top.raw tran; 
xschem redraw
"}
C {gnd.sym} 720 -460 0 0 {name=l7 lab=GND}
C {vdd.sym} 720 -730 0 0 {name=l3 lab=VDD}
C {simulator_commands.sym} 1120 -660 0 0 {name=SimulatorNGSPICE
vhdl_ignore=1
spice_ignore="tcleval([regexp -nocase \{xyce\} $sim(spice,$sim(spice,default),name)])"
simulator=ngspice
only_toplevel=false 
value="
*****************************************************
* PLL + DSM Frequency Divider Testbench (Optimized)
*****************************************************

.option temp=27
.param VDD=1.2
.option rshunt = 1.0e12

* ==============================
* Include Models & Stimuli
* ==============================
.include 4nH_INDUCTOR.spice
.include ../simulations/stimuli_test.cir

* ==============================
* Simulation Options (Optimized for Speed & Stability)
* ==============================
* gear method improves stability for long oscillator runs
* reltol=1e-3 prevents the simulator from bogging down on microscopic errors
.options reltol=1e-3 abstol=1e-9 vntol=1e-6 method=gear

.control
  * CRITICAL: Save ONLY essential low-frequency signals. 
  save xpll.vctrl xpll.up xpll.dn xpll.clk_fb clk_out clk_in vbgr xpll.vcp xpll.x4.outp sdata sclk en rst


  * 20p defines the step to resolve the 2.4 GHz edges without forcing a maxstep.
  tran 10p 40u
  
  remzerovec
  write tb_LC_VCO_FPLL_40u.raw 
.endc
"}
C {simulator_commands.sym} 990 -660 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.include /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice
*.include /opt/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice
.global VDD GND

"}
C {title.sym} 570 -70 0 0 {name=l2 author="Skill Surf"}
C {lab_pin.sym} 390 -650 0 0 {name=p3 sig_type=std_logic lab=CLK_IN}
C {vsource.sym} 60 -580 0 0 {name=VBGR value=0.6 savecurrent=false}
C {gnd.sym} 60 -510 0 0 {name=l13 lab=GND}
C {vdd.sym} 60 -720 0 0 {name=l4 lab=VBGR}
C {vdd.sym} 670 -730 0 0 {name=l6 lab=VBGR}
C {xschem/top-pll/LC_VCO_FPLL.sym} 720 -470 0 0 {name=xpll}
C {opin.sym} 880 -590 2 1 {name=p2 lab=CLK_OUT}
C {lab_pin.sym} 510 -610 0 1 {name=p6 sig_type=std_logic lab=en}
C {lab_pin.sym} 500 -570 0 1 {name=p7 sig_type=std_logic lab=sdata}
C {lab_pin.sym} 510 -550 0 1 {name=p8 sig_type=std_logic lab=sclk}
C {lab_pin.sym} 510 -590 0 1 {name=p9 sig_type=std_logic lab=rst}
C {noconn.sym} 470 -610 2 1 {name=l8}
C {noconn.sym} 470 -590 2 1 {name=l9}
C {noconn.sym} 470 -570 2 1 {name=l11}
C {noconn.sym} 470 -550 2 1 {name=l12}
C {lab_pin.sym} 670 -720 0 0 {name=p1 sig_type=std_logic lab=VBGR}
