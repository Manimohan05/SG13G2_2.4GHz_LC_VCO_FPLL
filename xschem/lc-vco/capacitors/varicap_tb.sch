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
N -60 0 -40 0 {
lab=in}
N 90 0 160 0 {
lab=out}
N -450 0 -160 0 {
lab=in}
N 100 -140 140 -140 {lab=GND}
N 0 -140 40 -140 {lab=#net1}
N -0 -60 0 -30 {lab=#net1}
N 0 60 -0 90 {lab=GND}
N -0 150 0 170 {lab=#net1}
N -90 -60 -90 170 {lab=#net1}
N 0 -140 -0 -60 {lab=#net1}
N 0 60 50 60 {lab=GND}
N -0 30 0 60 {lab=GND}
N -60 120 -40 120 {lab=in}
N -60 0 -60 120 {lab=in}
N -160 0 -60 0 {
lab=in}
N -90 -60 -0 -60 {lab=#net1}
N -90 170 0 170 {lab=#net1}
N 40 120 90 120 {lab=out}
N 90 0 90 120 {lab=out}
N 40 0 90 0 {
lab=out}
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
C {devices/gnd.sym} 50 60 3 0 {name=l2 lab=GND}
C {devices/code_shown.sym} -450 240 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOShv.lib mos_tt
"}
C {code.sym} -420 -150 0 0 {name=NGSPICE only_toplevel=false 
value="
.control

* 1. Define sweep parameters
let v_start = 0
let v_stop = 1.2
let v_step = 0.1
let num_points = (v_stop - v_start + v_step) / v_step

let v_current = v_start

* 2. Create arrays for results
let C_var = vector(num_points)
let V_ctrl = vector(num_points)

let i = 0

* 3. Loop through tuning voltages
while v_current <= v_stop
    * Alter the DC voltage of the Vtune source
    alter Vtune dc = v_current
 
    * Run S-parameter analysis: Linear sweep, 1 point, 2.4 GHz
    sp lin 1 2.4G 2.4G
    
    * Calculate Capacitance
    let C = 1/(2*PI*frequency*imag(1/Y_2_1))
    
    * Store the values in the arrays
    let C_var[i] = real(C)
    let V_ctrl[i] = v_current
    
    * Increment loop variables
    let v_current = v_current + v_step
    let i = i + 1
end

let C_var_max = C_var[0]
let C_var_min = C_var[12]
let delta_C = (C_var_max - C_var_min) * 1e15
print delta_C

* 4. Plot the results
plot C_var vs V_ctrl xlabel 'Tuning Voltage (V)' ylabel 'Capacitance (F)' title 'Differential Capacitance vs. Tuning Voltage'

.endc
"}
C {sg13g2_pr/sg13_svaricap.sym} 0 0 0 0 {name=C1 
model=sg13_hv_svaricap 
w=9.74u 
l=0.8u 
Nx=7
spiceprefix=X
}
C {vsource.sym} 70 -140 3 0 {name=Vtune value="dc 0" savecurrent=false}
C {gnd.sym} 140 -140 3 0 {name=l1 lab=GND}
C {sg13g2_pr/sg13_svaricap.sym} 0 120 2 1 {name=C2 
model=sg13_hv_svaricap 
w=9.74u 
l=0.8u 
Nx=7
spiceprefix=X
}
