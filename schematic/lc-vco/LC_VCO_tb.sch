v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 210 -540 210 -460 {lab=VDD}
N 210 -400 210 -360 {lab=GND}
N 650 -450 730 -450 {lab=OUTp}
N 650 -430 730 -430 {lab=OUTn}
N 370 -450 440 -450 {lab=VCTRL}
N 540 -350 540 -340 {lab=GND}
N 120 -480 120 -460 {lab=Ibias}
N 370 -430 440 -430 {lab=Ibias}
N 540 -540 540 -530 {lab=VDD}
N 880 -180 880 -160 {lab=GND}
N 880 -280 880 -260 {lab=VCTRL}
N 880 -280 950 -280 {lab=VCTRL}
N 950 -280 950 -260 {lab=VCTRL}
N 950 -200 950 -180 {lab=GND}
N 880 -180 950 -180 {lab=GND}
N 880 -200 880 -180 {lab=GND}
N 880 -300 880 -280 {lab=VCTRL}
N 650 -280 650 -260 {lab=VCTRL}
N 650 -280 880 -280 {lab=VCTRL}
N 650 -180 880 -180 {lab=GND}
N 650 -200 650 -180 {lab=GND}
C {vsource.sym} 210 -430 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} 210 -360 0 0 {name=l1 lab=GND}
C {devices/vdd.sym} 210 -540 0 0 {name=l5 lab=VDD}
C {launcher.sym} 900 -470 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/LC_VCO_tb.raw"
}
C {devices/isource.sym} 120 -510 0 0 {name=I0 value=80u}
C {devices/vdd.sym} 120 -540 0 0 {name=l12 lab=VDD}
C {devices/vdd.sym} 120 -460 2 0 {name=l3 lab=Ibias}
C {/home/designer/shared/frac-n-pll-vco-smacd_2026/schematic/lc-vco/LC_VCO.sym} 540 -440 0 0 {name=x2}
C {gnd.sym} 540 -340 0 0 {name=l6 lab=GND}
C {lab_pin.sym} 370 -450 0 0 {name=p3 sig_type=std_logic lab=VCTRL}
C {lab_pin.sym} 370 -430 0 0 {name=p7 sig_type=std_logic lab=Ibias}
C {devices/vdd.sym} 540 -540 0 0 {name=l7 lab=VDD}
C {lab_pin.sym} 730 -450 0 1 {name=p1 sig_type=std_logic lab=OUTp}
C {lab_pin.sym} 730 -430 0 1 {name=p2 sig_type=std_logic lab=OUTn}
C {simulator_commands.sym} 140 -250 0 0 {name=NGSPICE only_toplevel=true 
value="
.include ../ihp_4nh_inductor.spice
.param temp = 27
.options method=gear, rshunt=1.0e12

.control

* Save required signals
save v(OUTp) v(VCTRL)

* Long transient simulation
tran 10p 10.1u 100n

* Save raw waveform
write LC_VCO_tb.raw

* Plot transient waveform
let vout = v(OUTp)
plot vout v(Vctrl)

* Plot steady-state waveform
plot vout xlimit 200n 205n

* FFT analysis
setplot tran1
linearize vout
set specwindow=blackman
fft vout

* Plot FFT spectrum
let vout_db = db(vout)
plot vout_db xlimit 2.30G 2.50G ylimit -160 0

* Find the maximum magnitude value between 2G and 3G
meas sp max_vout_db max vout_db FROM=2G TO=3G

* Save FFT data
wrdata fft_output.txt frequency vout_db

* Save waveform for external processing
wrdata vco_waveform.txt vout_db

.endc
"}
C {simulator_commands.sym} 300 -250 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
"}
C {devices/launcher.sym} 900 -410 0 0 {name=h1
descr="OP annotate" 
tclcommand="xschem annotate_op"
}
C {vsource.sym} 880 -230 0 1 {name=Vup value="PULSE(0.4 1.1 10n 90n 1n 1s 2s)" savecurrent=false
spice_ignore=true}
C {gnd.sym} 880 -160 0 0 {name=l4 lab=GND}
C {vsource.sym} 950 -230 0 0 {name=V3 value=1.1 savecurrent=false
spice_ignore=true}
C {vsource.sym} 650 -230 0 1 {name=Vdn value="PULSE(0.5 0.4 10n 1n 90n 1s 2s)" savecurrent=false
}
C {devices/vdd.sym} 880 -300 0 0 {name=l8 lab=VCTRL}
