v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -800 -85 -800 -45 {lab=GND}
N -960 -140 -960 -120 {lab=GND}
N -960 -240 -960 -220 {lab=VCTRL}
N -960 -240 -890 -240 {lab=VCTRL}
N -890 -240 -890 -220 {lab=VCTRL}
N -890 -160 -890 -140 {lab=GND}
N -960 -140 -890 -140 {lab=GND}
N -960 -160 -960 -140 {lab=GND}
N -800 -185 -800 -145 {lab=VDD}
N -1190 -240 -1190 -220 {lab=VCTRL}
N -1190 -240 -960 -240 {lab=VCTRL}
N -1190 -140 -960 -140 {lab=GND}
N -1190 -160 -1190 -140 {lab=GND}
N -960 -270 -960 -240 {lab=VCTRL}
N -270 -130 -270 -110 {lab=GND}
N -270 -330 -270 -310 {lab=VDD}
N -160 -220 -140 -220 {lab=OUT}
N -390 -230 -370 -230 {lab=VCTRL}
N -430 -210 -370 -210 {lab=VBGR}
N -430 -210 -430 -150 {lab=VBGR}
N -490 -210 -430 -210 {lab=VBGR}
N -600 -140 -600 -120 {lab=GND}
N -600 -300 -600 -280 {lab=VDD}
C {vsource.sym} -800 -115 0 0 {name=V1 value="PULSE(0 1.2 0 1u 0 1s 2s)" savecurrent=false}
C {gnd.sym} -800 -45 0 0 {name=l4 lab=GND}
C {simulator_commands.sym} -1030 60 0 0 {name=ANALYSIS only_toplevel=true 
value="
.param temp = 27
.options method=gear rshunt=1.0e12

.control

* Save required signals
save v(VCTRL) v(OUT) v(x1.Vx) v(x1.OUTp) v(VBGR)

* Long transient simulation
tran 10p 2u

* Save raw waveform
write LC_VCO_standalone_tran.raw

* Plot transient waveform
let vout = v(OUT)
plot v(VCTRL) v(x1.Vx) v(OUT) v(x1.OUTp) v(VBGR)
plot v(VBGR)

* Plot steady-state waveform
plot v(VCTRL) v(x1.Vx) v(OUT) v(x1.OUTp) v(VBGR) xlimit 4000n 4005n

* FFT analysis
setplot tran1
linearize vout
set specwindow=blackman
fft vout

* Plot FFT spectrum
let power_out_db = db(vout)
plot power_out_db xlimit 2.34G 2.54G ylimit -200 0

* Find the maximum magnitude value between 2G and 3G
meas sp max_power_out_db max power_out_db FROM=2G TO=3G

* Save FFT spectrum as raw file
write LC_VCO_fft.raw

* Save FFT data
wrdata fft_output_standalone.txt frequency power_out_db

* Save waveform for external processing
wrdata vco_waveform_standalone.txt power_out_db

.endc
"
}
C {vsource.sym} -960 -190 0 1 {name=Vup value="PULSE(0.4 0.8 1u 90n 1n 1s 2s)" savecurrent=false
}
C {gnd.sym} -960 -120 0 0 {name=l6 lab=GND}
C {vsource.sym} -890 -190 0 0 {name=V2 value=1.1 savecurrent=false
spice_ignore=true}
C {vsource.sym} -1190 -190 0 1 {name=Vdn value="PULSE(0.5 0.0 10n 90n 1n 1s 2s)" savecurrent=false
spice_ignore=true}
C {opin.sym} -140 -220 0 0 {name=p5 lab=OUT
}
C {simulator_commands.sym} -1170 60 0 0 {name=OP only_toplevel=true 
value="
.param temp=27
.control
save all 
op
write LC_VCO_tb.raw
.endc
"
}
C {ipin.sym} -960 -270 1 0 {name=p11 lab=VCTRL}
C {gnd.sym} -270 -110 0 0 {name=l1 lab=GND}
C {lab_pin.sym} -390 -230 2 1 {name=p3 sig_type=std_logic lab=VCTRL}
C {lc-vco/LC_VCO.sym} -270 -150 0 0 {name=x1}
C {vdd.sym} -270 -330 0 0 {name=l2 lab=VDD}
C {vdd.sym} -800 -185 0 0 {name=l3 lab=VDD}
C {simulator_commands.sym} -730 60 0 0 {name=INCLUDE only_toplevel=true
format="tcleval( @value )"
value="
.include ../ihp_4nh_inductor.spice
"}
C {simulator_commands.sym} -880 60 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
"}
C {launcher.sym} -370 130 0 0 {name=h1
descr="OP annotate" 
tclcommand="xschem annotate_op"
}
C {lab_pin.sym} -430 -150 3 0 {name=p1 sig_type=std_logic lab=VBGR}
C {schematic/bgr/bgr.sym} -600 -210 0 0 {name=x2}
C {gnd.sym} -600 -120 0 0 {name=l5 lab=GND}
C {vdd.sym} -600 -300 0 0 {name=l7 lab=VDD}
