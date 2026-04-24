v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -220 -120 -220 70 { lab=GND}
N -480 -10 -480 10 {lab=#net1}
N -480 -120 -480 -70 {lab=v1}
N -480 -120 -360 -120 {lab=v1}
N -270 -120 -220 -120 {lab=GND}
C {devices/vsource.sym} -480 40 0 0 {name=V1 value="sin(0 1.8 2.5G)"}
C {devices/gnd.sym} -480 70 0 0 {name=l1 lab=GND}
C {devices/gnd.sym} -220 70 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} -480 -110 1 0 {name=l3 sig_type=std_logic lab=v1}
C {devices/code_shown.sym} -190 -140 0 0 {name=Simulation only_toplevel=false value="
.include ./IHP_4nH_Inductor.spice
.tran 0.4p 400p
.control
destroy all
run
let i1 = -i(v2)
plot v1 i1

.endc"
}
C {devices/vsource.sym} -480 -40 0 0 {name=V2 value="0"}
C {ihp_4nh_inductor.sym} -320 -110 0 0 {name=x1}
