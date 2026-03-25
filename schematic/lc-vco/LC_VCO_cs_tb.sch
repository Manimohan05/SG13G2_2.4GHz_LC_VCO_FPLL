v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -80 -360 -80 -320 {lab=GND}
N -140 -500 -140 -420 {lab=VDD}
N -140 -360 -140 -320 {lab=GND}
N -80 -500 -80 -420 {lab=VCTRL}
N 760 -450 840 -450 {lab=OUTp}
N 760 -430 840 -430 {lab=OUTn}
N 480 -450 550 -450 {lab=VCTRL}
N 650 -350 650 -340 {lab=GND}
N 320 -420 340 -420 {lab=IBIASVCO}
N 480 -430 550 -430 {lab=IBIASVCO}
N 650 -540 650 -530 {lab=VDD}
N 230 -350 230 -310 {lab=GND}
N 230 -550 230 -470 {lab=VDD}
N 320 -400 330 -400 {lab=IOUT}
C {vsource.sym} -80 -390 0 0 {name=V2 value=0.6 savecurrent=false}
C {gnd.sym} -140 -320 0 0 {name=l1 lab=GND}
C {gnd.sym} -80 -320 0 0 {name=l2 lab=GND}
C {devices/vdd.sym} -140 -500 0 0 {name=l5 lab=VDD}
C {devices/vdd.sym} -80 -500 0 0 {name=l8 lab=VCTRL}
C {launcher.sym} 760 -190 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/LC_VCO_tb.raw"
}
C {LC_VCO.sym} 650 -440 0 0 {name=x2}
C {gnd.sym} 650 -340 0 0 {name=l6 lab=GND}
C {lab_pin.sym} 480 -450 0 0 {name=p3 sig_type=std_logic lab=VCTRL}
C {lab_pin.sym} 480 -430 0 0 {name=p7 sig_type=std_logic lab=IBIASVCO}
C {devices/vdd.sym} 650 -540 0 0 {name=l7 lab=VDD}
C {simulator_commands.sym} 330 -250 0 0 {name=NGSPICE1 only_toplevel=true 
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
C {simulator_commands.sym} 470 -250 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
.lib cornerRES.lib res_typ
.lib $::SG13G2_MODELS/cornerCAP.lib cap_typ_stat
"}
C {gnd.sym} 230 -310 0 0 {name=l4 lab=GND}
C {devices/vdd.sym} 230 -550 0 0 {name=l9 lab=VDD}
C {iopin.sym} 840 -450 0 0 {name=p4 lab=OUTp}
C {iopin.sym} 840 -430 0 0 {name=p1 lab=OUTn}
C {lab_pin.sym} 340 -420 0 1 {name=p2 sig_type=std_logic lab=IBIASVCO}
C {iopin.sym} 330 -400 0 0 {name=p5 lab=IOUT}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/current_source/Current_source.sym} 230 -410 0 0 {name=x1}
C {vsource.sym} -140 -390 0 0 {name=V1 value="PULSE(0 1.2 0 1 0 1 2)" savecurrent=false}
