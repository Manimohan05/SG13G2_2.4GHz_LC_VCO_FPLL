v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1235.3515625 -974.21875 2035.3515625 -574.21875 {flags=graph
y1=-0.00019
y2=-7.9e-05
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1

x2=0.015
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=0
logy=0
x1=0
color=7
node=i(v1)
rawfile=$netlist_dir/tb_BGR_transient.raw
autoload=1}
B 2 1235.3515625 -574.21875 2035.3515625 -174.21875 {flags=graph
y1=-2.4e-13
y2=1.3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1

x2=0.015
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
x1=0
rawfile=$netlist_dir/tb_BGR_transient.raw
autoload=1
color="4 7"
node="vdd
vbgr"}
N 640 -730 640 -700 {
lab=GND}
N 880 -690 880 -660 {
lab=GND}
N 980 -760 1030 -760 {
lab=VBGR}
N 640 -870 640 -790 {lab=VDD}
N 640 -870 990 -870 {lab=VDD}
N 990 -870 990 -790 {lab=VDD}
N 980 -790 990 -790 {lab=VDD}
N 980 -730 990 -730 {lab=GND}
N 990 -730 990 -690 {lab=GND}
N 800 -690 990 -690 {lab=GND}
N 800 -760 800 -690 {lab=GND}
N 800 -760 820 -760 {lab=GND}
C {vsource.sym} 640 -760 0 0 {name=V1 value="PULSE(0 1.2 0 10m 0 1 2)" savecurrent=false}
C {gnd.sym} 640 -700 0 0 {name=l18 lab=GND}
C {gnd.sym} 880 -660 0 0 {name=l3 lab=GND}
C {opin.sym} 1030 -760 0 0 {name=p11 lab=VBGR}
C {launcher.sym} 921.40625 -553.28125 0 0 {name=h5
descr="load DC" 
tclcommand="xschem raw_read $netlist_dir/tb_BGR_temp.raw dc"
}
C {launcher.sym} 921.40625 -508.28125 0 0 {name=h1
descr="load Transient" 
tclcommand="xschem raw_read $netlist_dir/tb_BGR_transient.raw tran"
}
C {lab_pin.sym} 640 -850 0 0 {name=p1 sig_type=std_logic lab=VDD}
C {simulator_commands.sym} 560 -540 0 0 {name=bandgap1 only_toplevel=true value="
.option rshunt=1.0e12
.control
save all
save VDD
alter V1 dc 1.2

op
print I(Vmeas)

dc TEMP 100 -50 -5
print I(Vmeas)

write tb_BGR_temp.raw
.endc

.control
save all
tran 100u 15m

print I(Vmeas)

write tb_BGR_transient.raw
.endc
"
}
C {xschem/bgr/BANDGAP_REF.sym} 940 -760 0 1 {name=x1}
C {simulator_commands.sym} 730 -530 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
"}
