v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N 140 -720 140 -700 {lab=p1}
N 140 -720 250 -720 {lab=p1}
N 340 -720 400 -720 {lab=GND}
N 400 -720 400 -640 {lab=GND}
C {devices/vsource.sym} 140 -670 0 0 {name=V1 value="DC 0 AC 1"}
C {devices/gnd.sym} 140 -640 0 0 {name=l1 lab=GND}
C {devices/gnd.sym} 400 -640 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 140 -720 1 0 {name=l3 sig_type=std_logic lab=p1}
C {devices/code_shown.sym} 520 -750 0 0 {name=Simulation only_toplevel=false value="
.include ./IHP_4nH_Inductor.spice
.ac lin 100k 100Meg 15G
.control
destroy all
run
save all

* Complex impedance
let z_complex = -v(p1)/i(v1)

* Real and Imag parts
let r = real(z_complex)
let x = imag(z_complex)

* Inductance in nH
let L = 1e9 * x/(2*pi*frequency)

* Quality factor
let Q = x/r

write tb-ind.raw

* Plot both on same graph
plot L Q title "Inductance (nH) and Q vs Frequency"

.endc

"}
C {ihp_4nh_inductor.sym} 290 -710 0 0 {name=x1}
