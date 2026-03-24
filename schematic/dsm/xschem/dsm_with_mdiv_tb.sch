v {xschem version=3.4.8RC file_version=1.2
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
x2=0.000161702

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
N 400 -330 450 -330 {lab=rst}
N 400 -310 450 -310 {lab=sclk}
N 400 -290 450 -290 {lab=sdata}
N 400 -270 450 -270 {lab=en}
N 320 -200 320 -190 {lab=GND}
N 570 -100 610 -100 {lab=en}
N 570 -120 610 -120 {lab=sdata}
N 570 -140 610 -140 {lab=sclk}
N 570 -160 610 -160 {lab=rst}
N 320 -290 320 -260 {lab=freq_in}
N 400 -350 450 -350 {lab=freq_in}
N 800 -310 840 -310 {lab=freq_out}
N 700 -310 740 -310 {lab=#net1}
N 510 -270 540 -270 {lab=#net2}
N 510 -290 540 -290 {lab=#net3}
N 510 -310 540 -310 {lab=#net4}
N 510 -330 540 -330 {lab=#net5}
N 510 -350 540 -350 {lab=#net6}
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
C {vsource.sym} 320 -230 0 0 {name=V1 value="PULSE(0 1.8 0 10ns 10ns 50ns 100ns)" savecurrent=false}
C {gnd.sym} 320 -190 0 0 {name=l1 lab=GND}
C {lab_wire.sym} 320 -290 0 0 {name=p10 sig_type=std_logic lab=freq_in}
C {adc_bridge1.sym} 480 -270 0 0 {name=A2
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=1.2
}
C {adc_bridge1.sym} 480 -290 0 0 {name=A3
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=1.2
}
C {adc_bridge1.sym} 480 -310 0 0 {name=A4
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=1.2
}
C {adc_bridge1.sym} 480 -330 0 0 {name=A5
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=1.2
}
C {adc_bridge1.sym} 480 -350 0 0 {name=A6
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
C {lab_pin.sym} 400 -270 0 0 {name=p1 sig_type=std_logic lab=en}
C {lab_pin.sym} 400 -290 0 0 {name=p2 sig_type=std_logic lab=sdata}
C {lab_pin.sym} 400 -310 0 0 {name=p3 sig_type=std_logic lab=sclk}
C {lab_pin.sym} 400 -330 0 0 {name=p4 sig_type=std_logic lab=rst}
C {lab_wire.sym} 840 -310 0 1 {name=p13 sig_type=std_logic lab=freq_out}
C {dac_bridge1.sym} 770 -310 0 0 {name=A10
dac=dac1
dac_bridge_model=dac_bridge
out_low=0
out_high=1.2
}
C {dsm_and_freq_divider.sym} 620 -310 0 0 {name=adut
dut=dut
d_cosim_model= d_cosim
model=./../dsm_and_freq_divider.so}
C {lab_wire.sym} 400 -350 0 0 {name=p5 sig_type=std_logic lab=freq_in}
