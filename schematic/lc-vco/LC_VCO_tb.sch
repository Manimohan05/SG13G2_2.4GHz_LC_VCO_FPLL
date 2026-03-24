v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N 240 -400 240 -360 {lab=GND}
N 180 -540 180 -460 {lab=VDD}
N 180 -400 180 -360 {lab=GND}
N 240 -540 240 -460 {lab=VCTRL}
N 650 -450 730 -450 {lab=OUTp}
N 650 -430 730 -430 {lab=OUTn}
N 370 -450 440 -450 {lab=VCTRL}
N 540 -350 540 -340 {lab=GND}
N 120 -480 120 -460 {lab=Ibias}
N 370 -430 440 -430 {lab=Ibias}
N 540 -540 540 -530 {lab=VDD}
C {vsource.sym} 180 -430 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} 240 -430 0 0 {name=V2 value=0.6 savecurrent=false}
C {gnd.sym} 180 -360 0 0 {name=l1 lab=GND}
C {gnd.sym} 240 -360 0 0 {name=l2 lab=GND}
C {devices/vdd.sym} 180 -540 0 0 {name=l5 lab=VDD}
C {devices/vdd.sym} 240 -540 0 0 {name=l8 lab=VCTRL}
C {launcher.sym} 650 -190 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/LC_VCO_tb.raw"
}
C {devices/isource.sym} 120 -510 0 0 {name=I0 value=50u}
C {devices/vdd.sym} 120 -540 0 0 {name=l12 lab=VDD}
C {devices/vdd.sym} 120 -460 2 0 {name=l3 lab=Ibias}
C {LC_VCO.sym} 540 -440 0 0 {name=x2}
C {gnd.sym} 540 -340 0 0 {name=l6 lab=GND}
C {lab_pin.sym} 370 -450 0 0 {name=p3 sig_type=std_logic lab=VCTRL}
C {lab_pin.sym} 370 -430 0 0 {name=p7 sig_type=std_logic lab=Ibias}
C {devices/vdd.sym} 540 -540 0 0 {name=l7 lab=VDD}
C {lab_pin.sym} 730 -450 0 1 {name=p1 sig_type=std_logic lab=OUTp}
C {lab_pin.sym} 730 -430 0 1 {name=p2 sig_type=std_logic lab=OUTn}
C {simulator_commands.sym} 220 -250 0 0 {name=NGSPICE1 only_toplevel=true 
value="
.include ./IHP_4nH_Inductor.spice
.param temp = 27

.control

* Initial condition
.ic v(OUTp)=0.6

* Simulation accuracy
.options reltol=1e-4 abstol=1e-9 maxstep=5p method=gear

* Save required signals
save time v(OUTp) v(CTRL)

* Long transient for ~10 kHz FFT resolution
tran 0.01n 0.5u UIC

* Save raw waveform
write LC_VCO_tb.raw

* Plot steady-state waveform
plot v(OUTp) xlimit 5n 60n

* FFT analysis
linearize v(OUTp)
fft v(OUTp)

let vmag = db(mag(v(OUTp)))

* Plot FFT spectrum
plot vmag vs frequency xlimit 0 5G

* Save FFT data
wrdata fft_output.txt frequency vmag

* Save waveform for external processing
wrdata vco_waveform.txt time v(OUTp)

.endc
"}
C {simulator_commands.sym} 360 -250 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
.lib cornerRES.lib res_typ
.lib $::SG13G2_MODELS/cornerCAP.lib cap_typ_stat
"}
