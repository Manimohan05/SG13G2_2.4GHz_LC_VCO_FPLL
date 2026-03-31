v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -800 -160 -800 -120 {lab=GND}
N -960 -140 -960 -120 {lab=GND}
N -960 -240 -960 -220 {lab=VCTRL}
N -960 -240 -890 -240 {lab=VCTRL}
N -890 -240 -890 -220 {lab=VCTRL}
N -890 -160 -890 -140 {lab=GND}
N -960 -140 -890 -140 {lab=GND}
N -960 -160 -960 -140 {lab=GND}
N -800 -260 -800 -220 {lab=VDD}
N -1190 -240 -1190 -220 {lab=VCTRL}
N -1190 -240 -960 -240 {lab=VCTRL}
N -1190 -140 -960 -140 {lab=GND}
N -1190 -160 -1190 -140 {lab=GND}
N -580 -90 -580 -50 {lab=GND}
N -580 -190 -580 -150 {lab=VBGR}
N -960 -270 -960 -240 {lab=VCTRL}
N -260 -200 -180 -200 {lab=OUT}
N -540 -210 -470 -210 {lab=VCTRL}
N -370 -110 -370 -100 {lab=GND}
N -540 -190 -470 -190 {lab=VBGR}
N -370 -300 -370 -290 {lab=VDD}
N -580 -190 -540 -190 {lab=VBGR}
C {vsource.sym} -800 -190 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} -800 -120 0 0 {name=l4 lab=GND}
C {simulator_commands.sym} -1030 60 0 0 {name=ANALYSIS only_toplevel=true 
value="
.param temp = 27
.options method=gear, rshunt=1.0e12

.control

* Save required signals
save v(VCTRL) v(OUT) v(x1.Vx)

* Long transient simulation
tran 10p 5u 100n

* Save raw waveform
write LC_VCO_standalone_tran.raw

* Plot transient waveform
let vout = v(OUT)
plot v(VCTRL) v(x1.Vx) v(OUT)

* Plot steady-state waveform
plot v(VCTRL) v(x1.Vx) v(OUT) xlimit 400n 405n

* FFT analysis
setplot tran1
linearize vout
set specwindow=blackman
fft vout

* Plot FFT spectrum
let power_out_db = db(vout)
plot power_out_db xlimit 2.38G 2.58G ylimit -200 0

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
C {vsource.sym} -960 -190 0 1 {name=Vup value="PULSE(0.4 0.81 10n 90n 1n 1s 2s)" savecurrent=false
}
C {gnd.sym} -960 -120 0 0 {name=l6 lab=GND}
C {vsource.sym} -890 -190 0 0 {name=V2 value=1.1 savecurrent=false
spice_ignore=true}
C {vsource.sym} -1190 -190 0 1 {name=Vdn value="PULSE(0.5 0.0 10n 90n 1n 1s 2s)" savecurrent=false
spice_ignore=true}
C {vsource.sym} -580 -120 0 0 {name=VBGR value=0.6 savecurrent=false}
C {gnd.sym} -580 -50 0 0 {name=l13 lab=GND}
C {opin.sym} -180 -200 0 0 {name=p5 lab=OUT
}
C {simulator_commands.sym} -1170 60 0 0 {name=OP only_toplevel=true 
value="
.include LC_VCO_standalone_tb.save
.param temp=27
.control
save all 
op
write LC_VCO_standalone_tb.raw
.endc
"
}
C {ipin.sym} -960 -270 1 0 {name=p11 lab=VCTRL}
C {ipin.sym} -580 -190 1 0 {name=p4 lab=VBGR}
C {gnd.sym} -370 -100 0 0 {name=l1 lab=GND}
C {lab_pin.sym} -540 -210 1 0 {name=p3 sig_type=std_logic lab=VCTRL}
C {LC_VCO.sym} -370 -130 0 0 {name=x1}
C {vdd.sym} -370 -300 0 0 {name=l2 lab=VDD}
C {vdd.sym} -800 -260 0 0 {name=l3 lab=VDD}
C {simulator_commands.sym} -870 60 0 0 {name=PARAMS1 only_toplevel=true 
value="
.param L_CC=0.13u

  .param W_34=34.52u
  .param n_34=10

  .param W_12=25.11u
  .param n_12=8

.param L_TL=0.5u

  .param W_5=70.29u
  .param n_5=20

  .param W_6=17.95u
  .param n_6=6

  .param W_7=16.72u
  .param n_7=6
"}
C {simulator_commands.sym} -730 60 0 0 {name=INCLUDE only_toplevel=true
format="tcleval( @value )"
value="
.include ../ihp_4nh_inductor.spice
"}
C {simulator_commands.sym} -600 60 0 0 {name=MODEL only_toplevel=true
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
