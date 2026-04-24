v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 860 -630 1660 -230 {flags=graph
y1=0
y2=2
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1e-12
x2=3e-08
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
f_div"
hilight_wave=-1
rawfile=$netlist_dir/tb_PHASE_FREQ_DET_PEX.raw
autoload=1}
B 2 860 -1030 1660 -630 {flags=graph
y1=0
y2=2
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1e-12
x2=3e-08
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color="9 10"
node="up
dn"
hilight_wave=-1
autoload=1
rawfile=$netlist_dir/tb_PHASE_FREQ_DET_PEX.raw}
B 2 60 -1030 860 -630 {flags=graph
y1=1.0920332
y2=1.2648332
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1e-12
x2=3e-08
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color=11
node=vdd
rawfile=$netlist_dir/tb_PHASE_FREQ_DET_PEX.raw
autoload=1}
P 4 1 1680 -490 {}
P 4 1 730 -460 {}
N 430 -360 480 -360 {lab=F_DIV}
N 430 -500 480 -500 {lab=F_REF}
N 730 -510 780 -510 {lab=UP}
N 670 -600 670 -570 {lab=VDD}
N 730 -350 800 -350 {lab=DN}
N 670 -290 670 -270 {lab=GND}
C {vsource.sym} 80 -400 0 0 {name=Vdd value='VDD' savecurrent=false}
C {lab_pin.sym} 80 -430 0 1 {name=p3 sig_type=std_logic lab=VDD}
C {gnd.sym} 80 -370 0 0 {name=l3 lab=GND}
C {vsource.sym} 160 -400 0 0 {name=Vfvco value="0 pulse(0 'VDD' 2n 1n 1n 5n 10n)" savecurrent=false}
C {lab_pin.sym} 160 -430 0 1 {name=p10 sig_type=std_logic lab=F_DIV}
C {gnd.sym} 160 -370 0 0 {name=l1 lab=GND}
C {vsource.sym} 160 -500 0 0 {name=Vfref value="0 pulse(0 'VDD' 0n 1n 1n 5n 10n)" savecurrent=false}
C {lab_pin.sym} 160 -530 0 1 {name=p11 sig_type=std_logic lab=F_REF}
C {gnd.sym} 160 -470 0 0 {name=l2 lab=GND}
C {lab_pin.sym} 670 -600 0 0 {name=p5 lab=VDD}
C {lab_pin.sym} 780 -510 0 1 {name=p6 lab=UP}
C {lab_pin.sym} 430 -500 0 0 {name=p7 lab=F_REF}
C {lab_pin.sym} 430 -360 0 0 {name=p12 lab=F_DIV}
C {lab_pin.sym} 790 -350 0 1 {name=p13 lab=DN}
C {lab_pin.sym} 670 -270 0 0 {name=p14 lab=GND}
C {simulator_commands_shown.sym} 1690 -980 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.include /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice
.global VDD GND

"
      }
C {launcher.sym} 390 -250 0 0 {name=h4
descr=SimulateNGSPICE
tclcommand="
# Setup the default simulation commands if not already set up
# for example by already launched simulations.
set_sim_defaults
puts $sim(spice,1,cmd) 

# Change the Xyce command. In the spice category there are currently
# 5 commands (0, 1, 2, 3, 4). Command 3 is the Xyce batch
# you can get the number by querying $sim(spice,n)
set sim(spice,1,cmd) \{ngspice  \\"$N\\" -a\}

# change the simulator to be used (Xyce)
set sim(spice,default) 0

# Create FET and BIP .save file
mkdir -p $netlist_dir
write_data [save_params] $netlist_dir/[file rootname [file tail [xschem get current_name]]].save

# run netlist and simulation
xschem netlist
simulate
"}
C {title.sym} 210 -150 0 0 {name=l4 author="Skill Surf"}
C {launcher.sym} 170 -250 0 0 {name=h1
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/tb_PHASE_FREQ_DET_PEX.raw tran"
}
C {simulator_commands_shown.sym} 1730 -750 0 0 {name=SimulatorNGSPICE
simulator=ngspice
only_toplevel=false 
value="
.param RAW_TEMP = agauss(40, 30, 1)
.param TEMPGAUSS = max(20, min(RAW_TEMP, 80))
.option temp = 'TEMPGAUSS'
.param VDDGAUSS = agauss(1.2, 0.05, 1)
.include /foss/designs/unicasss-tools/frac-n-pll-vco-unic_cass/pex/PHASE_FREQ_DET__PHASE_FREQ_DET/magic_RC/PHASE_FREQ_DET.pex.spice
.param VDD = 'VDDGAUSS'
* analysis

.tran 100p 30n uic

.control
let i = 0
dowhile i < 10
  reset
  run
  write tb_PHASE_FREQ_DET_PEX.raw
  set appendwrite
  reset
  let i = i + 1
end
quit
.endc
"}
C {xschem/phase-freq-detector/PHASE_FREQ_DET_PEX.sym} 600 -430 0 0 {name=x1}
