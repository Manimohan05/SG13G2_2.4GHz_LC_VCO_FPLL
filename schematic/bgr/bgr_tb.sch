v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1125.3515625 -974.21875 1925.3515625 -574.21875 {flags=graph
y1=-0.00019
y2=0
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1

x2=2
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
node=i(v1)}
B 2 1125.3515625 -574.21875 1925.3515625 -174.21875 {flags=graph
y1=0
y2=1.2
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1

x2=2
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
x1=0
rawfile=$netlist_dir/bandgap_transient.raw
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
N 640 -870 880 -870 {lab=VDD}
N 880 -870 880 -830 {lab=VDD}
C {vsource.sym} 640 -760 0 0 {name=V1 value="PULSE(0 1.2 0 1 0 1 2)" savecurrent=false}
C {gnd.sym} 640 -700 0 0 {name=l18 lab=GND}
C {gnd.sym} 880 -660 0 0 {name=l3 lab=GND}
C {opin.sym} 1030 -760 0 0 {name=p11 lab=VBGR}
C {launcher.sym} 921.40625 -553.28125 0 0 {name=h5
descr="load DC" 
tclcommand="xschem raw_read $netlist_dir/bgr_temp.raw dc"
}
C {launcher.sym} 921.40625 -508.28125 0 0 {name=h1
descr="load Transient" 
tclcommand="xschem raw_read $netlist_dir/bandgap_transient.raw tran"
}
C {schematic/bgr/bgr.sym} 880 -760 0 0 {name=x1}
C {lab_pin.sym} 640 -850 0 0 {name=p1 sig_type=std_logic lab=VDD}
C {simulator_commands.sym} 700 -540 0 0 {name=MODEL1 only_toplevel=true
format="tcleval( @value )"
value="
.lib $::SG13G2_MODELS/cornerCAP.lib cap_typ
.lib $::SG13G2_MODELS/cornerRES.lib res_typ
.lib cornerMOSlv.lib mos_tt
.lib /foss/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerCAP.lib cap_typ
.lib /foss/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerRES.lib res_typ
.lib /foss/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerMOSlv.lib mos_tt"}
C {simulator_commands.sym} 560 -540 0 0 {name=bandgap1 only_toplevel=true value="
.control
save all
save VDD
alter V1 dc 1.2

op
print I(Vmeas)

dc TEMP 100 -50 -5
print I(Vmeas)

write bgr_temp.raw
.endc

.control
save all
tran 1m 2

print I(Vmeas)

write bandgap_transient.raw
.endc
"
}
C {launcher.sym} 951.40625 -423.28125 0 0 {name=h2
descr="load DC" 
tclcommand="xschem raw_read $netlist_dir/bgr_temp.raw dc"
}
C {launcher.sym} 951.40625 -378.28125 0 0 {name=h3
descr="load Transient" 
tclcommand="xschem raw_read $netlist_dir/bandgap_transient.raw tran"
}
