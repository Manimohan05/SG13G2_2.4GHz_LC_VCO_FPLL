v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 -640 10 160 410 {flags=graph
y1=-0.2
y2=1.4
ypos1=-0.2
ypos2=1.4
divy=5
subdivy=1
unity=1
x1=1e-07
x2=5e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
color="7 12 21 11"
node="vctrl
outn
fout
outp"
hilight_wave=-1
rawfile=$netlist_dir/tb_LC_VCO_PEX_tran.raw}
B 2 160 10 960 410 {flags=graph
y1=-0.2
y2=1.4
ypos1=-0.2
ypos2=1.4
divy=5
subdivy=1
unity=1
x1=4e-07
x2=4.05e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
color="7 12 21 11"
node="vctrl
outn
fout
outp"
hilight_wave=-1
rawfile=$netlist_dir/tb_LC_VCO_PEX_tran.raw}
B 2 160 -390 960 10 {flags=graph
y1=-200
y2=0
ypos1=-200
ypos2=0
divy=5
subdivy=1
unity=1
x1=2340000000.0
x2=2540000000.0
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
color="7"
node="power_out_db"
hilight_wave=-1
rawfile=$netlist_dir/LC_VCO_PEX_fft.raw}
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
N -150 -280 -150 -260 {lab=VDD}
N -150 -200 -130 -200 {lab=FOUT}
N -390 -230 -370 -230 {lab=VCTRL}
N -620 -260 -620 -250 {lab=VBGR}
N -620 -260 -370 -260 {lab=VBGR}
N -620 -195 -620 -155 {lab=GND}
N -400 -200 -370 -200 {lab=GND}
N -400 -200 -400 -140 {lab=GND}
N -800 -190 -800 -140 {lab=VDD}
N -260 -160 -260 -130 {lab=OUTp}
N -220 -160 -220 -130 {lab=OUTn}
N -130 -100 -100 -100 {lab=OUTp}
N -10 -100 20 -100 {lab=OUTn}
C {gnd.sym} -800 -45 0 0 {name=l4 lab=GND}
C {simulator_commands.sym} -1080 210 0 0 {name=ANALYSIS only_toplevel=true 
value="
.param temp = 27
.options method=gear rshunt=1.0e12
* start-up kick: a noise-free run can stay at the unstable equilibrium
.ic v(OUTp)=0.4

.control

* Save required signals
save v(VCTRL) v(FOUT) v(OUTn) v(OUTp)

* Long transient simulation
tran 10p 500n 100n

* Save raw waveform
write tb_LC_VCO_PEX_tran.raw

* Plot transient waveform
let vout = v(FOUT)
plot v(VCTRL) v(OUTn) v(FOUT) v(OUTp)

* Plot steady-state waveform
plot v(VCTRL) v(OUTn) v(FOUT) v(OUTp) xlimit 400n 405n

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
write LC_VCO_PEX_fft.raw frequency power_out_db
shell python3 ../xschem/lc-vco/raw_spectrum_as_tran.py LC_VCO_PEX_fft.raw

* Save FFT data
wrdata fft_output_pex.txt frequency power_out_db

* Save waveform for external processing
wrdata vco_waveform_pex.txt power_out_db

.endc
"
}
C {gnd.sym} -960 -120 0 0 {name=l6 lab=GND}
C {vsource.sym} -890 -190 0 0 {name=V2 value=1.1 savecurrent=false
spice_ignore=true}
C {vsource.sym} -1190 -190 0 1 {name=Vdn value="PULSE(0.5 0.0 10n 90n 1n 1s 2s)" savecurrent=false
spice_ignore=true}
C {opin.sym} -130 -200 0 0 {name=p5 lab=FOUT
}
C {simulator_commands.sym} -1220 210 0 0 {name=OP only_toplevel=true 
value="
.param temp=27
.control
save all 
op
write LC_VCO_PEX_tb.raw
.endc
"
}
C {ipin.sym} -960 -270 1 0 {name=p11 lab=VCTRL}
C {gnd.sym} -400 -140 0 0 {name=l1 lab=GND}
C {lab_pin.sym} -390 -230 2 1 {name=p3 sig_type=std_logic lab=VCTRL}
C {vdd.sym} -150 -280 0 0 {name=l2 lab=VDD}
C {vdd.sym} -800 -185 0 0 {name=l3 lab=VDD}
C {simulator_commands.sym} -1090 30 0 0 {name=INCLUDE only_toplevel=true
format="tcleval( @value )"
value="
.include 4nH_INDUCTOR.spice
* Magic RC extraction of the VCO without its inductor (the inductor is the EM model above)
.include ../pex/LC_VCO_NOIND__LC_VCO_NOIND/magic_RC/LC_VCO_NOIND.pex_sim.spice
"}
C {simulator_commands.sym} -1230 30 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
"}
C {launcher.sym} -310 -60 0 0 {name=h1
descr="OP annotate" 
tclcommand="xschem annotate_op"
}
C {gnd.sym} -620 -155 0 0 {name=l5 lab=GND}
C {vsource.sym} -620 -220 0 0 {name=VBGR value=0.6 savecurrent=false}
C {xschem/lc-vco/LC_VCO_NOIND.sym} -260 -230 0 0 {name=x1}
C {lab_pin.sym} -490 -260 2 1 {name=p1 sig_type=std_logic lab=VBGR}
C {vsource.sym} -800 -110 0 0 {name=V1 value=1.2 savecurrent=false}
C {lab_pin.sym} -260 -130 1 0 {name=p20 sig_type=std_logic lab=OUTp}
C {lab_pin.sym} -220 -130 1 0 {name=p21 sig_type=std_logic lab=OUTn}
C {lab_pin.sym} -130 -100 0 0 {name=p22 sig_type=std_logic lab=OUTp}
C {lab_pin.sym} 20 -100 0 1 {name=p23 sig_type=std_logic lab=OUTn}
C {xschem/lc-vco/4nH_INDUCTOR.sym} -60 -90 0 0 {name=xind}
C {vsource.sym} -960 -190 0 1 {name=Vup value="PULSE(0.4 0.8 10n 90n 1n 1s 2s)" savecurrent=false
}
