v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 250 -670 250 -640 {
lab=GND}
N 330 -740 390 -740 {lab=GND}
N 330 -720 360 -720 {lab=VDD}
N 390 -740 390 -710 {
lab=GND}
N 360 -720 360 -590 {lab=VDD}
N 20 -590 360 -590 {lab=VDD}
N -140 -800 -140 -720 {lab=VDD}
N -140 -800 250 -800 {lab=VDD}
N 250 -800 250 -790 {lab=VDD}
N 20 -790 250 -790 {lab=VDD}
N 20 -790 20 -590 {lab=VDD}
N -140 -660 -140 -630 {
lab=GND}
C {devices/code_shown.sym} -60 -555 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib $::SG13G2_MODELS/cornerCAP.lib cap_typ
.lib $::SG13G2_MODELS/cornerRES.lib res_typ
.lib cornerMOSlv.lib mos_tt
"}
C {vsource.sym} -140 -690 0 0 {name=V1 value="PULSE(0 1.2 0 1 0 1 2)" savecurrent=false}
C {lab_pin.sym} -140 -765 0 1 {name=p6 sig_type=std_logic lab=VDD}
C {gnd.sym} 250 -640 0 0 {name=l18 lab=GND}
C {Current_source.sym} 250 -730 0 0 {name=x1}
C {gnd.sym} 390 -710 0 0 {name=l1 lab=GND}
C {devices/code_shown.sym} 410 -783.828125 0 0 {name=bandgap only_toplevel=true value="
.control
save all
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

print I(Vmeas10) I(Vmeas11) I(Vmeas14) 

write bandgap_transient.raw
.endc
"
}
C {gnd.sym} -140 -630 0 0 {name=l2 lab=GND}
