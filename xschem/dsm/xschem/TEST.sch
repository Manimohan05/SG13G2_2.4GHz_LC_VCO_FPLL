v {xschem version=3.4.8RC file_version=1.3
*
* This file is part of XSCHEM,
* a schematic capture and Spice/Vhdl/Verilog netlisting tool for circuit
* simulation.
* Copyright (C) 1998-2024 Stefan Frederik Schippers
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 20 -680 1180 -470 {flags=graph
y1=0
y2=3
ypos1=0
ypos2=3
divy=5
subdivy=1
unity=1
x1=0
x2=1.7037356e-06

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
color="4 4 4 4 4 4"
node="sdata
sclk
en
rst
freq_out
freq_in"}
N 1080 -260 1160 -260 {lab=rst}
N 600 -240 680 -240 {lab=sclk}
N 600 -260 680 -260 {lab=sdata}
N 600 -280 680 -280 {lab=en}
N 320 -180 320 -170 {lab=GND}
N 570 -100 610 -100 {lab=en}
N 570 -120 610 -120 {lab=sdata}
N 570 -140 610 -140 {lab=sclk}
N 570 -160 610 -160 {lab=rst}
N 320 -270 320 -240 {lab=freq_in}
N 1080 -340 1160 -340 {lab=freq_in}
N 610 -340 680 -340 {lab=freq_out}
N 1020 -190 1020 -170 {lab=GND}
N 1020 -420 1020 -400 {lab=VDD}
N 420 -300 420 -280 {lab=GND}
N 420 -380 420 -360 {lab=VDD}
C {simulator_commands.sym} 110 -290 0 0 {name=COMMANDS
verilog_ignore=1
vhdl_ignore=1
spice_ignore="tcleval([regexp -nocase \{xyce\} $sim(spice,$sim(spice,default),name)])"
simulator=ngspice
only_toplevel=false 
value="
.include ../DSM_N_FREQ_DIV.spice
* ngspice commands
.save v(dout) v(sdata) v(sclk) v(en) v(rst) v(dsm_clk) v(freq_in) v(freq_out)
.control  
  tran 0.5n 1m
  remzerovec
  write test.raw
.endc

* to generate following file copy stimuli.test
* to the simulation directory and run simulation -> Utile Stimuli Editor (GUI), 
* and press 'Translate'
.include stimuli_test.cir
"}
C {launcher.sym} 70 -420 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/test.raw tran"
}
C {vsource.sym} 320 -210 0 0 {name=V1 value="PULSE(0 1.2 0 10ns 10ns 50ns 100ns)" savecurrent=false}
C {gnd.sym} 320 -170 0 0 {name=l1 lab=GND}
C {lab_wire.sym} 320 -270 0 0 {name=p10 sig_type=std_logic lab=freq_in}
C {lab_pin.sym} 570 -100 0 0 {name=p6 sig_type=std_logic lab=en}
C {lab_pin.sym} 570 -120 0 0 {name=p7 sig_type=std_logic lab=sdata}
C {lab_pin.sym} 570 -140 0 0 {name=p8 sig_type=std_logic lab=sclk}
C {lab_pin.sym} 570 -160 0 0 {name=p9 sig_type=std_logic lab=rst}
C {noconn.sym} 610 -160 2 0 {name=l2}
C {noconn.sym} 610 -140 2 0 {name=l3}
C {noconn.sym} 610 -120 2 0 {name=l4}
C {noconn.sym} 610 -100 2 0 {name=l5}
C {lab_pin.sym} 600 -280 0 0 {name=p1 sig_type=std_logic lab=en}
C {lab_pin.sym} 600 -260 0 0 {name=p2 sig_type=std_logic lab=sdata}
C {lab_pin.sym} 600 -240 0 0 {name=p3 sig_type=std_logic lab=sclk}
C {lab_pin.sym} 1160 -260 0 1 {name=p4 sig_type=std_logic lab=rst}
C {lab_wire.sym} 610 -340 0 0 {name=p13 sig_type=std_logic lab=freq_out}
C {lab_wire.sym} 1160 -340 0 1 {name=p5 sig_type=std_logic lab=freq_in}
C {DSM_N_FREQ_DIV.sym} 880 -300 0 0 {name=x1}
C {gnd.sym} 1020 -170 0 0 {name=l6 lab=GND}
C {vdd.sym} 1020 -420 0 0 {name=l7 lab=VDD}
C {vsource.sym} 420 -330 0 0 {name=V2 value=1.2 savecurrent=false}
C {gnd.sym} 420 -280 0 0 {name=l8 lab=GND}
C {vdd.sym} 420 -380 0 0 {name=l9 lab=VDD}
C {simulator_commands.sym} -20 -290 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
"}
