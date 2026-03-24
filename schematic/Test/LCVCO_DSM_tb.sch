v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 -90 -1440 710 -1040 {flags=graph
y1=-0.027
y2=1.3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-2e-08
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
sim_type=tran
color="12 4 7"
node="outp
vctrl
outd"
x2=3.8e-07
hcursor1_y=0.41963418
hcursor2_y=0.70549986}
B 2 710 -1230 1870 -1020 {flags=graph
y1=0
y2=3
ypos1=0
ypos2=3
divy=5
subdivy=1
unity=1
x1=0
x2=4e-07

subdivx=4
xlabmag=1.2
ylabmag=1.0

dataset=-1
unitx=1
logx=0
logy=0
digital=1
divx=4
legend=1
color="4 4 4 4 12 7 15"
node="sdata
sclk
en
rst
outd
outp
vctrl"}
B 2 710 -1450 1870 -1240 {flags=graph
y1=-0.03
y2=1.3
ypos1=0
ypos2=3
divy=5
subdivy=1
unity=1
x1=0
x2=4e-07

subdivx=4
xlabmag=1.2
ylabmag=1.0

dataset=-1
unitx=1
logx=0
logy=0
digital=0
divx=4
legend=0
color="8 20 10"
node="outd
outp
vctrl"
hilight_wave=0}
N 1310 -640 1330 -640 {lab=outd}
N 1000 -680 1060 -680 {lab=#net1}
N 1000 -660 1060 -660 {lab=#net2}
N 1000 -640 1060 -640 {lab=#net3}
N 1000 -620 1060 -620 {lab=#net4}
N 1000 -600 1060 -600 {lab=#net5}
N 1220 -640 1250 -640 {lab=#net6}
N 890 -660 940 -660 {lab=rst}
N 890 -640 940 -640 {lab=sclk}
N 890 -620 940 -620 {lab=sdata}
N 890 -600 940 -600 {lab=en}
N 730 -600 770 -600 {lab=en}
N 730 -620 770 -620 {lab=sdata}
N 730 -640 770 -640 {lab=sclk}
N 730 -660 770 -660 {lab=rst}
N 30 -600 30 -560 {lab=GND}
N -100 -740 -100 -660 {lab=VDD}
N -100 -600 -100 -560 {lab=GND}
N 30 -740 30 -660 {lab=VCTRL}
N -30 -600 -30 -580 {lab=Ibias}
N 530 -650 580 -650 {lab=OUTn}
N 280 -670 320 -670 {lab=VCTRL}
N 420 -570 420 -540 {lab=GND}
N 280 -650 320 -650 {lab=Ibias}
N 420 -770 420 -750 {lab=VDD}
N 650 -680 650 -670 {lab=OUTp}
N 610 -670 650 -670 {lab=OUTp}
N 650 -680 940 -680 {lab=OUTp}
N 650 -740 650 -680 {lab=OUTp}
C {launcher.sym} 810 -530 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/LCVCO_DSM.raw tran"
}
C {lab_pin.sym} 1330 -640 0 1 {name=p7 lab=outd}
C {lab_pin.sym} 890 -600 0 0 {name=p2 sig_type=std_logic lab=en}
C {lab_pin.sym} 890 -620 0 0 {name=p8 sig_type=std_logic lab=sdata}
C {lab_pin.sym} 890 -640 0 0 {name=p9 sig_type=std_logic lab=sclk}
C {lab_pin.sym} 890 -660 0 0 {name=p10 sig_type=std_logic lab=rst}
C {lab_pin.sym} 770 -600 0 1 {name=p11 sig_type=std_logic lab=en}
C {lab_pin.sym} 770 -620 0 1 {name=p12 sig_type=std_logic lab=sdata}
C {lab_pin.sym} 770 -640 0 1 {name=p14 sig_type=std_logic lab=sclk}
C {lab_pin.sym} 770 -660 0 1 {name=p15 sig_type=std_logic lab=rst}
C {noconn.sym} 730 -660 2 1 {name=l9}
C {noconn.sym} 730 -640 2 1 {name=l13}
C {noconn.sym} 730 -620 2 1 {name=l14}
C {noconn.sym} 730 -600 2 1 {name=l15}
C {simulator_commands.sym} 1420 -710 0 0 {name=SimulatorNGSPICE1
vhdl_ignore=1
spice_ignore="tcleval([regexp -nocase \{xyce\} $sim(spice,$sim(spice,default),name)])"
simulator=ngspice
only_toplevel=false 
value="
.include ./IHP_4nH_Inductor.spice
.param temp=27
.control
save V(VCTRL) V(OUTp) V(outd) V(sdata) V(sclk) V(en) V(rst) 
.options maxstep=50p reltol=1e-3 abstol=1e-6

*.ic v(OUTp)=0.6
tran 5p 400n
remzerovec

* Perform FFT on output
*fft v(OUTp)
*let vmag = db(mag(v(OUTp)))
*plot vmag xlabel 'Frequency (Hz)' xlimit 0 5G

* Save transient waveform to raw file
write LCVCO_DSM.raw

*quit 0
.endc


* to generate following file copy stimuli.test
* to the simulation directory and run simulation -> Utile Stimuli Editor (GUI), 
* and press 'Translate'
.include stimuli_test.cir
"}
C {vsource.sym} -100 -630 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} 30 -630 0 0 {name=V2 value="pulse(0.3 1.0 50n 100n 100n 200n)" savecurrent=false}
C {gnd.sym} -100 -560 0 0 {name=l1 lab=GND}
C {gnd.sym} 30 -560 0 0 {name=l2 lab=GND}
C {devices/vdd.sym} -100 -740 0 0 {name=l5 lab=VDD}
C {devices/vdd.sym} 30 -740 0 0 {name=l8 lab=VCTRL}
C {devices/isource.sym} -30 -630 0 0 {name=I0 value=50u}
C {devices/vdd.sym} -30 -660 0 0 {name=l12 lab=VDD}
C {devices/vdd.sym} -30 -580 2 0 {name=l3 lab=Ibias}
C {opin.sym} 580 -650 0 0 {name=p1 lab=OUTn
}
C {iopin.sym} 420 -770 3 0 {name=p4 lab=VDD
}
C {iopin.sym} 280 -670 2 0 {name=p6 lab=VCTRL
}
C {iopin.sym} 420 -540 1 0 {name=p3 lab=GND
}
C {iopin.sym} 280 -650 2 0 {name=p5 lab=Ibias
}
C {lab_pin.sym} 650 -740 0 1 {name=p23 lab=OUTp}
C {sg13g2_stdcells/sg13g2_inv_2.sym} 570 -670 0 0 {name=x5 VDD=VDD VSS=GND prefix=sg13g2_ }
C {simulator_commands_shown.sym} 870 -970 0 0 {
name=Libs_Ngspice1
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ_stat
.include /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice
.global VDD GND
"}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/lc-vco/LC_VCO.sym} 420 -660 0 0 {name=x4}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/dsm_and_freq_divider.sym} 1140 -640 0 0 {name=adut
dut=dut
d_cosim_model= d_cosim
model=./../dsm_and_freq_divider.so}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/adc_bridge1.sym} 970 -680 0 0 {name=A1
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=0.6
}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/adc_bridge1.sym} 970 -660 0 0 {name=A2
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=0.6
}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/adc_bridge1.sym} 970 -640 0 0 {name=A3
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=0.6
}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/adc_bridge1.sym} 970 -620 0 0 {name=A4
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=0.6
}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/adc_bridge1.sym} 970 -600 0 0 {name=A5
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=0.6
}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/dac_bridge1.sym} 1280 -640 0 0 {name=A6
dac=dac1
dac_bridge_model=dac_bridge
out_low=0
out_high=1.2
}
