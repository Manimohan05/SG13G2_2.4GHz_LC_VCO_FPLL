v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 -724.6484375 -64.21875 75.3515625 335.78125 {flags=graph
y1=0
y2=1.2
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1

x2=2
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
x1=0
autoload=1
rawfile=$netlist_dir/LC_VCO_fft.raw}
N -870 -160 -870 -120 {lab=GND}
N -1030 -140 -1030 -120 {lab=GND}
N -1030 -240 -1030 -220 {lab=VCTRL}
N -1030 -240 -960 -240 {lab=VCTRL}
N -960 -240 -960 -220 {lab=VCTRL}
N -960 -160 -960 -140 {lab=GND}
N -1030 -140 -960 -140 {lab=GND}
N -1030 -160 -1030 -140 {lab=GND}
N -870 -260 -870 -220 {lab=VDD}
N -1260 -240 -1260 -220 {lab=VCTRL}
N -1260 -240 -1030 -240 {lab=VCTRL}
N -1260 -140 -1030 -140 {lab=GND}
N -1260 -160 -1260 -140 {lab=GND}
N -1030 -270 -1030 -240 {lab=VCTRL}
N -260 -200 -180 -200 {lab=OUT}
N -540 -210 -470 -210 {lab=VCTRL}
N -370 -110 -370 -100 {lab=GND}
N -540 -190 -470 -190 {lab=VBGR}
N -370 -300 -370 -290 {lab=VDD}
N -560 -190 -540 -190 {lab=VBGR}
C {gnd.sym} -870 -120 0 0 {name=l4 lab=GND}
C {simulator_commands.sym} -1120 -30 0 0 {name=ANALYSIS only_toplevel=true 
value="
.param temp = 27
.options method=gear, rshunt=1.0e12

.control

* Save required signals
save v(VCTRL) v(OUT) v(x1.Vx) v(vbgr)

* Long transient simulation
tran 10p 1.5 100n

* Save raw waveform
write LC_VCO_tran.raw

* Plot transient waveform
let vout = v(OUT)
plot v(VCTRL) v(x1.Vx) v(OUT)
plot v(VBGR)
* Plot steady-state waveform
plot v(VCTRL) v(x1.Vx) v(OUT) xlimit 1 1100m

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
C {vsource.sym} -1030 -190 0 1 {name=Vup value="PULSE(0.4 0.81 10n 90n 1n 1s 2s)" savecurrent=false
}
C {gnd.sym} -1030 -120 0 0 {name=l6 lab=GND}
C {vsource.sym} -960 -190 0 0 {name=V2 value=1.1 savecurrent=false
spice_ignore=true}
C {vsource.sym} -1260 -190 0 1 {name=Vdn value="PULSE(0.5 0.0 10n 90n 1n 1s 2s)" savecurrent=false
spice_ignore=true}
C {opin.sym} -180 -200 0 0 {name=p5 lab=OUT
}
C {simulator_commands.sym} -1260 -30 0 0 {name=OP only_toplevel=true 
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
C {ipin.sym} -1030 -270 1 0 {name=p11 lab=VCTRL}
C {gnd.sym} -370 -100 0 0 {name=l1 lab=GND}
C {lab_pin.sym} -540 -210 1 0 {name=p3 sig_type=std_logic lab=VCTRL}
C {LC_VCO.sym} -370 -130 0 0 {name=x1}
C {vdd.sym} -370 -300 0 0 {name=l2 lab=VDD}
C {vdd.sym} -870 -260 0 0 {name=l3 lab=VDD}
C {simulator_commands.sym} -960 -30 0 0 {name=PARAMS1 only_toplevel=true 
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
C {simulator_commands.sym} -1260 150 0 0 {name=INCLUDE only_toplevel=true
format="tcleval( @value )"
value="
.include ../ihp_4nh_inductor.spice
"}
C {simulator_commands.sym} -1130 150 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
"}
C {launcher.sym} -890 150 0 0 {name=h1
descr="OP annotate" 
tclcommand="xschem annotate_op"
}
C {schematic/bgr/bgr.sym} -670 -190 0 0 {name=x2}
C {vdd.sym} -670 -260 0 0 {name=l5 lab=VDD}
C {gnd.sym} -670 -120 0 0 {name=l7 lab=GND}
C {launcher.sym} -898.59375 241.71875 0 0 {name=h3
descr="load Transient" 
tclcommand="xschem raw_read $netlist_dir/LC_VCO_tran.raw tran"
}
C {lab_pin.sym} -520 -190 3 0 {name=p1 sig_type=std_logic lab=VBGR}
C {vsource.sym} -870 -190 0 0 {name=V1 value="PULSE(0 1.2 0 1 0 1 2)" savecurrent=false}
