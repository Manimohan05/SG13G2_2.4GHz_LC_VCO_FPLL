v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
L 4 -260 60 -260 180 {}
L 4 -250 50 -230 60 {}
L 4 -250 70 -230 60 {}
L 4 -250 50 -250 70 {}
L 4 -260 60 -250 60 {}
L 4 240 60 240 180 {}
L 4 230 60 240 60 {}
L 4 230 50 230 70 {}
L 4 210 60 230 50 {}
L 4 210 60 230 70 {}
P 4 6 -230 60 -230 -90 210 -90 210 200 -230 200 -230 50 {}
N -450 120 -450 150 {
lab=GND}
N -450 0 -450 60 {
lab=in}
N 160 120 160 150 {
lab=GND}
N 160 0 160 60 {
lab=out}
N -160 120 -160 150 {
lab=GND}
N -160 0 -160 60 {
lab=in}
N 300 120 300 150 {
lab=GND}
N 300 0 300 60 {
lab=out}
N 160 -10 160 0 {
lab=out}
N -160 -20 -160 0 {
lab=in}
N 160 0 300 0 {
lab=out}
N -160 0 -30 0 {
lab=in}
N 30 0 160 0 {
lab=out}
N -450 0 -160 0 {
lab=in}
N 0 30 0 150 {
lab=GND}
C {devices/res.sym} -160 90 0 0 {name=R1
value=1Meg
footprint=1206
device=resistor
m=1}
C {devices/vsource.sym} -450 90 0 0 {name=V1 value="dc 0 ac 1 portnum 1 z0 50"}
C {devices/gnd.sym} -160 150 0 0 {name=l3 lab=GND}
C {devices/gnd.sym} -450 150 0 0 {name=l4 lab=GND}
C {devices/res.sym} 160 90 0 0 {name=R2
value=1Meg
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 160 150 0 0 {name=l5 lab=GND}
C {devices/vsource.sym} 300 90 0 0 {name=V2 value="dc 0 ac 0 portnum 2 z0 50"}
C {devices/gnd.sym} 300 150 0 0 {name=l6 lab=GND}
C {devices/lab_pin.sym} -160 -20 1 0 {name=p1 sig_type=std_logic lab=in}
C {devices/lab_pin.sym} 160 -10 1 0 {name=p2 sig_type=std_logic lab=out}
C {devices/gnd.sym} 0 150 0 0 {name=l2 lab=GND}
C {sg13g2_pr/cap_rfcmim.sym} 0 0 3 0 {name=C1 
model=cap_rfcmim
w=2.0e-6
l=2.0e-6
wfeed=5.0e-6
spiceprefix=X}
C {devices/code_shown.sym} -450 240 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerCAP.lib cap_typ
"}
C {code.sym} -420 -150 0 0 {name=NGSPICE only_toplevel=false 
value="
.control

* Run S-parameter analysis: Linear sweep, 1 point, 2.44 GHz
sp lin 1 2.44G 2.44G
    
* Calculate C_diff and Q_diff
let C = 1/(2*PI*frequency*imag(1/Y_2_1))
print real(C)

.endc
"}
