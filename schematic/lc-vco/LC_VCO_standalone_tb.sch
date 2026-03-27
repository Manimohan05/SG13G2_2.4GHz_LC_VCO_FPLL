v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
L 4 -680 -340 -360 -340 {}
L 4 -360 -400 -360 -340 {}
L 4 470 360 680 360 {}
L 4 470 360 470 420 {}
L 4 -480 60 -260 60 {}
L 4 -480 0 -480 60 {}
L 4 -260 210 -50 210 {}
L 4 -50 150 -50 210 {}
L 4 470 210 680 210 {}
L 4 470 150 470 210 {}
P 4 5 -260 -400 680 -400 680 420 -260 420 -260 -400 {}
P 4 5 -260 0 -260 -400 -680 -400 -680 0 -260 0 {}
P 4 5 -680 0 -260 0 -260 420 -680 420 -680 0 {}
P 4 5 470 -220 470 150 680 150 680 -220 470 -220 {}
P 4 5 -50 -220 -50 150 -260 150 -260 -220 -50 -220 {}
T {S-Varicap Based Varactors} -660 -380 0 0 0.4 0.4 {}
T {Type-IV LC VCO} 490 380 0 0 0.4 0.4 {}
T {Bias Current Gen} -460 20 0 0 0.4 0.4 {}
T {Load Balancing} -240 170 0 0 0.4 0.4 {}
T {Output Buffer} 650 170 0 1 0.4 0.4 {}
N 360 -230 360 -190 {
lab=#net1}
N 100 -260 140 -260 {
lab=#net1}
N 290 -190 360 -190 {
lab=#net1}
N 60 -350 360 -350 {
lab=VDD}
N 60 -50 120 -50 {lab=#net2}
N 300 -50 360 -50 {lab=#net3}
N 60 -310 60 -290 {lab=VDD}
N 360 -310 360 -290 {lab=VDD}
N 360 -260 420 -260 {lab=VDD}
N 420 -310 420 -260 {lab=VDD}
N 0 -260 60 -260 {lab=VDD}
N 0 -310 0 -260 {lab=VDD}
N 0 -310 60 -310 {lab=VDD}
N 420 200 420 260 {lab=GND}
N 360 200 420 200 {lab=GND}
N 360 230 360 270 {
lab=#net4}
N 0 200 0 260 {lab=GND}
N 0 200 60 200 {lab=GND}
N 60 230 60 270 {
lab=#net4}
N 360 130 360 180 {
lab=OUTp}
N 60 130 60 180 {
lab=OUTn}
N 60 -350 60 -310 {lab=VDD}
N 360 -350 360 -310 {lab=VDD}
N 280 -260 320 -260 {
lab=#net5}
N 100 200 140 200 {
lab=OUTp}
N 280 200 320 200 {
lab=OUTn}
N 60 -190 130 -190 {
lab=#net5}
N 60 -230 60 -190 {
lab=#net5}
N 130 -190 280 -260 {lab=#net5}
N 140 -260 290 -190 {lab=#net1}
N 60 130 130 130 {
lab=OUTn}
N 290 130 360 130 {
lab=OUTp}
N 140 200 290 130 {lab=OUTp}
N 130 130 280 200 {lab=OUTn}
N 360 -310 420 -310 {lab=VDD}
N -380 350 -320 350 {lab=GND}
N -320 300 -320 350 {lab=GND}
N -380 300 -320 300 {lab=GND}
N -380 330 -380 350 {lab=GND}
N -800 -160 -800 -120 {lab=GND}
N 360 -50 360 -30 {lab=#net3}
N 360 -190 360 -140 {lab=#net1}
N 360 -30 360 0 {lab=#net3}
N 360 60 360 130 {lab=OUTp}
N 210 270 360 270 {
lab=#net4}
N -620 350 -560 350 {lab=GND}
N -620 300 -620 350 {lab=GND}
N -620 300 -560 300 {lab=GND}
N -560 330 -560 350 {lab=GND}
N -470 300 -420 300 {lab=Vgs}
N 60 -50 60 -30 {lab=#net2}
N 60 -190 60 -140 {lab=#net5}
N 60 60 60 130 {lab=OUTn}
N 60 -30 60 0 {lab=#net2}
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
N -470 -170 -470 -140 {lab=GND}
N -470 -170 -420 -170 {lab=GND}
N -470 -200 -470 -170 {lab=GND}
N -580 -110 -510 -110 {lab=OUTn}
N -580 -170 -580 -110 {lab=OUTn}
N -580 -230 -510 -230 {lab=OUTn}
N -430 -110 -360 -110 {lab=OUTp}
N -360 -170 -360 -110 {lab=OUTp}
N -430 -230 -360 -230 {lab=OUTp}
N -360 -170 -340 -170 {lab=OUTp}
N -360 -230 -360 -170 {lab=OUTp}
N -600 -170 -580 -170 {lab=OUTn}
N -580 -230 -580 -170 {lab=OUTn}
N -470 -290 -470 -260 {lab=VCTRL}
N 250 70 300 70 {lab=#net3}
N 120 70 160 70 {lab=#net2}
N 210 -60 210 -10 {lab=GND}
N 120 -90 180 -90 {lab=#net2}
N 120 -50 120 70 {lab=#net2}
N 300 -50 300 70 {lab=#net3}
N 240 -90 300 -90 {lab=#net3}
N 210 270 210 300 {lab=#net4}
N 60 270 210 270 {
lab=#net4}
N -470 -290 -410 -290 {lab=VCTRL}
N -470 -80 -470 -50 {lab=VCTRL}
N -470 -50 -410 -50 {lab=VCTRL}
N -380 350 -380 370 {lab=GND}
N -560 350 -560 370 {lab=GND}
N 210 360 210 390 {lab=Vx}
N 110 390 210 390 {lab=Vx}
N -470 230 -470 300 {lab=Vgs}
N -560 230 -560 270 {lab=Vgs}
N -560 110 -500 110 {lab=VDD}
N -500 110 -500 160 {lab=VDD}
N -560 160 -500 160 {lab=VDD}
N -560 110 -560 130 {lab=VDD}
N -560 90 -560 110 {lab=VDD}
N -790 260 -790 300 {lab=GND}
N -790 160 -790 200 {lab=VBGR}
N -520 300 -470 300 {lab=Vgs}
N -560 230 -470 230 {lab=Vgs}
N -560 190 -560 230 {lab=Vgs}
N -380 140 -380 270 {lab=Vx}
N -790 160 -600 160 {lab=VBGR}
N 570 -30 570 0 {lab=OUT}
N 570 -30 760 -30 {lab=OUT}
N 570 -60 570 -30 {lab=OUT}
N 500 30 530 30 {lab=#net3}
N 500 -90 530 -90 {lab=#net3}
N 570 80 570 100 {lab=GND}
N 570 -140 570 -120 {lab=VDD}
N 570 -90 630 -90 {lab=VDD}
N 630 -140 630 -90 {lab=VDD}
N 570 -140 630 -140 {lab=VDD}
N 570 -160 570 -140 {lab=VDD}
N 570 80 630 80 {lab=GND}
N 630 30 630 80 {lab=GND}
N 570 30 630 30 {lab=GND}
N 570 60 570 80 {lab=GND}
N 360 -30 500 -30 {lab=#net3}
N 500 -30 500 30 {lab=#net3}
N -150 -60 -150 0 {lab=#net6}
N -110 30 -80 30 {lab=#net2}
N -110 -90 -80 -90 {lab=#net2}
N -150 80 -150 100 {lab=GND}
N -150 -140 -150 -120 {lab=VDD}
N -210 -90 -150 -90 {lab=VDD}
N -210 -140 -210 -90 {lab=VDD}
N -210 -140 -150 -140 {lab=VDD}
N -150 -160 -150 -140 {lab=VDD}
N -210 80 -150 80 {lab=GND}
N -210 30 -210 80 {lab=GND}
N -210 30 -150 30 {lab=GND}
N -150 60 -150 80 {lab=GND}
N -80 -30 -80 30 {lab=#net2}
N -80 -30 60 -30 {lab=#net2}
N -80 -90 -80 -30 {lab=#net2}
N 500 -90 500 -30 {lab=#net3}
N 300 -90 300 -50 {lab=#net3}
N 360 -80 360 -50 {lab=#net3}
N 60 -80 60 -50 {lab=#net2}
N 120 -90 120 -50 {lab=#net2}
N -960 -270 -960 -240 {lab=VCTRL}
C {devices/vdd.sym} 210 -350 0 0 {name=l7 lab=VDD}
C {sg13g2_pr/sg13_lv_nmos.sym} -400 300 0 0 {name=M5
l=L_TL
w=W_5
ng=n_5
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 340 -260 0 0 {name=M4
l=L_CC
w=W_34
ng=n_34
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 80 -260 0 1 {name=M3
l=L_CC
w=W_34
ng=n_34
m=1
model=sg13_lv_pmos
spiceprefix=X}
C {sg13g2_pr/sg13_lv_nmos.sym} 340 200 0 0 {name=M2
l=L_CC
w=W_12
ng=n_12
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 80 200 0 1 {name=M1
l=L_CC
w=W_12
ng=n_12
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {gnd.sym} 0 260 0 0 {name=l1 lab=GND}
C {gnd.sym} 420 260 0 1 {name=l2 lab=GND}
C {gnd.sym} -380 370 0 0 {name=l3 lab=GND}
C {vsource.sym} -800 -190 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} -800 -120 0 0 {name=l4 lab=GND}
C {devices/vdd.sym} -800 -260 0 0 {name=l5 lab=VDD}
C {devices/code_shown.sym} -1100 400 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
"}
C {devices/launcher.sym} -1310 400 0 0 {name=h1
descr="OP annotate" 
tclcommand="xschem annotate_op"
}
C {ammeter.sym} 360 -110 0 0 {name=Vpmos_p savecurrent=true spice_ignore=0}
C {ammeter.sym} 360 30 0 0 {name=Vnmos_p savecurrent=true spice_ignore=0}
C {ammeter.sym} 210 330 0 0 {name=Vtail savecurrent=true spice_ignore=0}
C {lab_pin.sym} -380 140 1 0 {name=p2 sig_type=std_logic lab=Vx
}
C {devices/code_shown.sym} -1120 -50 0 0 {name=PARAMS only_toplevel=true 
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
C {sg13g2_pr/sg13_lv_nmos.sym} -540 300 0 1 {name=M6
l=L_TL
w=W_6
ng=n_6
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {gnd.sym} -560 370 0 1 {name=l8 lab=GND}
C {ammeter.sym} 60 -110 0 1 {name=Vpmos_n savecurrent=true spice_ignore=0}
C {ammeter.sym} 60 30 0 1 {name=Vnmos_n savecurrent=true spice_ignore=0}
C {lab_pin.sym} -470 230 2 0 {name=p1 sig_type=std_logic lab=Vgs
}
C {ihp_4nh_inductor.sym} 200 60 2 1 {name=x1
}
C {devices/code_shown.sym} -1380 -370 0 0 {name=INCLUDE only_toplevel=true
format="tcleval( @value )"
value="
.include ../ihp_4nh_inductor.spice
"}
C {simulator_commands.sym} -1340 220 0 0 {name=ANALYSIS only_toplevel=true 
value="
.param temp = 27
.options method=gear, rshunt=1.0e12

.control

* Save required signals
save v(OUTp) v(VCTRL) v(OUT) v(Vx)

* Long transient simulation
tran 10p 500n 100n

* Save raw waveform
write LC_VCO_standalone_tran.raw

* Plot transient waveform
let vout = v(OUT)
plot v(OUTp) v(VCTRL) v(Vx) v(OUT)

* Plot steady-state waveform
plot v(OUTp) v(VCTRL) v(Vx) v(OUT) xlimit 400n 405n

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

* Save FFT data
wrdata fft_output_standalone.txt frequency power_out_db

* Save waveform for external processing
wrdata vco_waveform_standalone.txt power_out_db

.endc
"
}
C {vsource.sym} -960 -190 0 1 {name=Vup value="PULSE(0.4 1.1 10n 90n 1n 1s 2s)" savecurrent=false
}
C {gnd.sym} -960 -120 0 0 {name=l6 lab=GND}
C {sg13g2_pr/cap_rfcmim.sym} 210 -90 3 0 {name=C1 
model=cap_rfcmim
lvs_model=rfcmim
w=21.77e-6
l=21.77e-6
wfeed=10.0e-6
spiceprefix=X
}
C {gnd.sym} 210 -10 0 0 {name=l11 lab=GND}
C {vsource.sym} -890 -190 0 0 {name=V2 value=1.1 savecurrent=false
spice_ignore=true}
C {vsource.sym} -1190 -190 0 1 {name=Vdn value="PULSE(0.5 0.0 10n 90n 1n 1s 2s)" savecurrent=false
spice_ignore=true}
C {sg13g2_pr/sg13_svaricap.sym} -470 -110 2 0 {name=C3 
model=sg13_hv_svaricap 
w=9.74u 
l=0.8u 
Nx=7
spiceprefix=X
}
C {sg13g2_pr/sg13_svaricap.sym} -470 -230 0 1 {name=C2 
model=sg13_hv_svaricap 
w=9.74u 
l=0.8u 
Nx=7
spiceprefix=X
}
C {lab_pin.sym} -410 -290 2 0 {name=p3 sig_type=std_logic lab=VCTRL
}
C {gnd.sym} -420 -170 3 0 {name=l10 lab=GND}
C {lab_pin.sym} -340 -170 2 0 {name=p6 sig_type=std_logic lab=OUTp
}
C {lab_pin.sym} -600 -170 2 1 {name=p7 sig_type=std_logic lab=OUTn
}
C {sg13g2_pr/annotate_fet_params.sym} 470 -380 0 0 {name=annot1 ref=M4}
C {sg13g2_pr/annotate_fet_params.sym} -150 260 0 0 {name=annot2 ref=M1}
C {lab_pin.sym} 110 390 2 1 {name=p10 sig_type=std_logic lab=Vx
}
C {lab_pin.sym} -410 -50 0 1 {name=p13 sig_type=std_logic lab=VCTRL
}
C {sg13g2_pr/sg13_lv_pmos.sym} -580 160 0 0 {name=M7
l=L_TL
w=W_7
ng=n_7
m=1
model=sg13_lv_pmos
spiceprefix=X}
C {devices/vdd.sym} -560 90 0 0 {name=l12 lab=VDD}
C {vsource.sym} -790 230 0 0 {name=VBGR value=0.6 savecurrent=false}
C {gnd.sym} -790 300 0 0 {name=l13 lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} 550 -90 0 0 {name=M8
l=0.13u
w=25.10u
ng=15
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 550 30 0 0 {name=M9
l=0.13u
w=1.64u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {gnd.sym} 570 100 0 0 {name=l14 lab=GND}
C {devices/vdd.sym} 570 -160 0 0 {name=l15 lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} -130 -90 0 1 {name=M10
l=0.13u
w=25.10u
ng=15
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -130 30 0 1 {name=M11
l=0.13u
w=1.64u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {gnd.sym} -150 100 0 1 {name=l16 lab=GND}
C {devices/vdd.sym} -150 -160 0 1 {name=l17 lab=VDD}
C {opin.sym} 760 -30 0 0 {name=p5 lab=OUT
}
C {simulator_commands.sym} -1340 0 0 0 {name=OP only_toplevel=true 
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
C {lab_pin.sym} 60 100 2 1 {name=p8 sig_type=std_logic lab=OUTn
}
C {lab_pin.sym} 360 100 2 0 {name=p9 sig_type=std_logic lab=OUTp
}
C {ipin.sym} -960 -270 1 0 {name=p11 lab=VCTRL}
C {ipin.sym} -790 160 1 0 {name=p4 lab=VBGR}
