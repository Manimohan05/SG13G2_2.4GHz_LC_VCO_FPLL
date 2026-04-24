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
B 2 20 -660 1180 -450 {flags=graph
y1=0
y2=3
ypos1=0
ypos2=3
divy=5
subdivy=1
unity=1
x1=0
x2=0.001

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
freq_in"
rawfile=$netlist_dir/test.raw
autoload=1}
N 650 -180 700 -180 {lab=rst}
N 1280 -160 1330 -160 {lab=sclk}
N 1280 -180 1330 -180 {lab=sdata}
N 1280 -200 1330 -200 {lab=en}
N 320 -200 320 -190 {lab=GND}
N 570 -100 610 -100 {lab=en}
N 570 -120 610 -120 {lab=sdata}
N 570 -140 610 -140 {lab=sclk}
N 570 -160 610 -160 {lab=rst}
N 320 -290 320 -260 {lab=freq_in}
N 650 -260 700 -260 {lab=freq_in}
N 1290 -260 1330 -260 {lab=freq_out}
N 1190 -260 1230 -260 {lab=#net1}
N 1190 -200 1220 -200 {lab=#net2}
N 1190 -180 1220 -180 {lab=#net3}
N 1190 -160 1220 -160 {lab=#net4}
N 760 -180 790 -180 {lab=#net5}
N 760 -260 790 -260 {lab=#net6}
N 250 -195 250 -155 {lab=GND}
N 250 -295 250 -255 {lab=VDD}
N 850 -355 850 -315 {lab=VDD}
N 850 -115 850 -75 {lab=GND}
C {simulator_commands.sym} 110 -290 0 0 {name=COMMANDS
verilog_ignore=1
vhdl_ignore=1
spice_ignore="tcleval([regexp -nocase \{xyce\} $sim(spice,$sim(spice,default),name)])"
simulator=ngspice
only_toplevel=false 
value="
* ngspice commands
.save v(dout) v(sdata) v(sclk) v(en) v(rst) v(dsm_clk) v(freq_in) v(freq_out)
.control  
  tran 0.5n 1m
  remzerovec
  write tb_DSM_N_FREQ_DIV.raw
.endc

* to generate following file copy stimuli.test
* to the simulation directory and run simulation -> Utile Stimuli Editor (GUI), 
* and press 'Translate'
.include stimuli_test.cir
"}
C {launcher.sym} 70 -420 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/tb_DSM_N_FREQ_DIV.raw tran"
}
C {vsource.sym} 320 -230 0 0 {name=V1 value="PULSE(0 1.8 0 10ns 10ns 50ns 100ns)" savecurrent=false}
C {gnd.sym} 320 -190 0 0 {name=l1 lab=GND}
C {lab_wire.sym} 320 -290 0 0 {name=p10 sig_type=std_logic lab=freq_in}
C {adc_bridge1.sym} 1250 -200 0 1 {name=A2
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=1.2
}
C {adc_bridge1.sym} 1250 -180 0 1 {name=A3
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=1.2
}
C {adc_bridge1.sym} 1250 -160 0 1 {name=A4
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=1.2
}
C {adc_bridge1.sym} 730 -180 0 0 {name=A5
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=1.2
}
C {adc_bridge1.sym} 730 -260 0 0 {name=A6
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=1.2
}
C {lab_pin.sym} 570 -100 0 0 {name=p6 sig_type=std_logic lab=en}
C {lab_pin.sym} 570 -120 0 0 {name=p7 sig_type=std_logic lab=sdata}
C {lab_pin.sym} 570 -140 0 0 {name=p8 sig_type=std_logic lab=sclk}
C {lab_pin.sym} 570 -160 0 0 {name=p9 sig_type=std_logic lab=rst}
C {noconn.sym} 610 -160 2 0 {name=l2}
C {noconn.sym} 610 -140 2 0 {name=l3}
C {noconn.sym} 610 -120 2 0 {name=l4}
C {noconn.sym} 610 -100 2 0 {name=l5}
C {lab_pin.sym} 1330 -200 0 1 {name=p1 sig_type=std_logic lab=en}
C {lab_pin.sym} 1330 -180 0 1 {name=p2 sig_type=std_logic lab=sdata}
C {lab_pin.sym} 1330 -160 0 1 {name=p3 sig_type=std_logic lab=sclk}
C {lab_pin.sym} 650 -180 0 0 {name=p4 sig_type=std_logic lab=rst}
C {lab_wire.sym} 1330 -260 0 1 {name=p13 sig_type=std_logic lab=freq_out}
C {dac_bridge1.sym} 1260 -260 0 0 {name=A10
dac=dac1
dac_bridge_model=dac_bridge
out_low=0
out_high=1.2
}
C {lab_wire.sym} 650 -260 0 0 {name=p5 sig_type=std_logic lab=freq_in}
C {xschem/dsm/xschem/DSM_N_FREQ_DIV.sym} 990 -220 0 1 {name=adut
dut=dut
d_cosim_model= d_cosim
model=./../dsm_and_freq_divider.so}
C {vsource.sym} 250 -225 0 0 {name=V2 value="PULSE(0 1.2 0 1u 0 1s 2s)" savecurrent=false}
C {gnd.sym} 250 -155 0 0 {name=l6 lab=GND}
C {vdd.sym} 250 -295 0 0 {name=l7 lab=VDD}
C {vdd.sym} 850 -355 0 0 {name=l8 lab=VDD}
C {gnd.sym} 850 -75 0 0 {name=l9 lab=GND}
