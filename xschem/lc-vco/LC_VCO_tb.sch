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
N -1190 -240 -1190 -220 {lab=VCTRL}
N -1190 -240 -960 -240 {lab=VCTRL}
N -1190 -140 -960 -140 {lab=GND}
N -1190 -160 -1190 -140 {lab=GND}
N -960 -270 -960 -240 {lab=VCTRL}
N -160 -280 -160 -260 {lab=VDD}
N -160 -200 -140 -200 {lab=FOUT}
N -390 -230 -370 -230 {lab=VCTRL}
N -620 -260 -620 -250 {lab=VBGR}
N -620 -260 -370 -260 {lab=VBGR}
N -620 -195 -620 -155 {lab=GND}
N -400 -200 -370 -200 {lab=GND}
N -400 -200 -400 -140 {lab=GND}
N -800 -190 -800 -140 {lab=VDD}
C {gnd.sym} -800 -45 0 0 {name=l4 lab=GND}
C {simulator_commands.sym} -1030 60 0 0 {name=ANALYSIS only_toplevel=true 
value="
.param temp = 27
.options method=gear rshunt=1.0e12

.control

* Save required signals
save v(VCTRL) v(FOUT) v(x1.Vx) v(x1.OUTp)

* Long transient simulation
tran 10p 500n 100n

* Save raw waveform
write tb_LC_VCO_tran.raw

* Plot transient waveform
let vout = v(FOUT)
plot v(VCTRL) v(x1.Vx) v(FOUT) v(x1.OUTp)

* Plot steady-state waveform
plot v(VCTRL) v(x1.Vx) v(FOUT) v(x1.OUTp) xlimit 400n 405n

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
C {gnd.sym} -960 -120 0 0 {name=l6 lab=GND}
C {vsource.sym} -890 -190 0 0 {name=V2 value=1.1 savecurrent=false
spice_ignore=true}
C {vsource.sym} -1190 -190 0 1 {name=Vdn value="PULSE(0.5 0.0 10n 90n 1n 1s 2s)" savecurrent=false
spice_ignore=true}
C {opin.sym} -140 -200 0 0 {name=p5 lab=FOUT
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
C {gnd.sym} -400 -140 0 0 {name=l1 lab=GND}
C {lab_pin.sym} -390 -230 2 1 {name=p3 sig_type=std_logic lab=VCTRL}
C {vdd.sym} -160 -280 0 0 {name=l2 lab=VDD}
C {vdd.sym} -800 -185 0 0 {name=l3 lab=VDD}
C {simulator_commands.sym} -740 60 0 0 {name=INCLUDE only_toplevel=true
format="tcleval( @value )"
value="
.include 4nH_INDUCTOR.spice
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
C {gnd.sym} -620 -155 0 0 {name=l5 lab=GND}
C {vsource.sym} -620 -220 0 0 {name=VBGR value=0.6 savecurrent=false}
C {xschem/lc-vco/LC_VCO.sym} -260 -230 0 0 {name=x1}
C {lab_pin.sym} -490 -260 2 1 {name=p1 sig_type=std_logic lab=VBGR}
C {vsource.sym} -800 -110 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -960 -190 0 1 {name=Vup value="PULSE(0.4 0.8 10n 90n 1n 1s 2s)" savecurrent=false
}
