v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1870 -1110 2670 -710 {flags=graph
y2=1.3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.5e-6
x2=3e-06
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
hilight_wave=0
y1=00
color="7 12"
node="clk_out
dsm_out"}
B 2 270 -1510 1070 -1110 {flags=graph
y1=0
y2=1.3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.5e-6
x2=2.8e-06
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=-1
autoload=0
sim_type=tran
color=12
node=clk_in}
B 2 1070 -1510 1870 -1110 {flags=graph
y1=-0.025
y2=1.2
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2e-13
x2=5e-06
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color=4
node=vctrl}
B 2 1870 -1510 2670 -1110 {flags=graph
y1=-0.016
y2=1.3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.5e-6
x2=3.5e-06
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=-1
hcursor1_y=0.68567067
hcursor2_y=0.47137288
color="4 7"
node="dn
up"}
B 2 710 -400 1870 -190 {flags=graph
y1=0
y2=3
ypos1=0
ypos2=3
divy=5
subdivy=1
unity=1
x1=2e-13
x2=5e-06

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
color="7 12 8 6 11 10"
node="rst
sclk
sdata
en
clk_out
dsm_out"}
B 2 1870 -720 2670 -320 {flags=graph
y2=1.3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.5e-6
x2=3e-06
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
hilight_wave=0
y1=0
color="12 7"
node="clk_in
dsm_out"}
P 4 1 2810 -1370 {}
P 4 1 1090 -980 {}
N 540 -610 540 -550 {lab=VDD}
N 540 -490 540 -450 {lab=GND}
N 1160 -900 1240 -900 {lab=IbiasVCO}
N 1490 -950 1540 -950 {lab=OUTn}
N 1240 -950 1280 -950 {lab=IbiasVCO}
N 1380 -1070 1380 -1050 {lab=VDD}
N 820 -980 900 -980 {lab=UP}
N 810 -940 820 -940 {lab=DN}
N 820 -960 820 -940 {lab=DN}
N 820 -960 900 -960 {lab=DN}
N 1170 -970 1280 -970 {lab=VCTRL}
N 1170 -1010 1170 -970 {lab=VCTRL}
N 1070 -970 1170 -970 {lab=VCTRL}
N 820 -1030 820 -980 {lab=UP}
N 780 -980 820 -980 {lab=UP}
N 810 -940 810 -880 {lab=DN}
N 780 -940 810 -940 {lab=DN}
N 630 -1070 630 -1020 {lab=VDD}
N 970 -1070 970 -1030 {lab=VDD}
N 460 -970 600 -970 {lab=CLK_IN}
N 880 -940 880 -880 {lab=Ibias}
N 880 -940 900 -940 {lab=Ibias}
N 1240 -950 1240 -900 {lab=IbiasVCO}
N 630 -900 630 -860 {lab=GND}
N 970 -910 970 -870 {lab=GND}
N 1380 -870 1380 -820 {lab=GND}
N 1570 -970 1620 -970 {lab=CLK_OUT}
N 560 -950 560 -710 {lab=DSM_OUT}
N 560 -950 600 -950 {lab=DSM_OUT}
N 460 -740 460 -700 {lab=GND}
N 460 -970 460 -800 {lab=CLK_IN}
N 560 -710 1070 -710 {lab=DSM_OUT}
N 1440 -750 1620 -750 {lab=CLK_OUT}
N 1620 -970 1620 -750 {lab=CLK_OUT}
N 1440 -730 1490 -730 {lab=rst}
N 1440 -710 1490 -710 {lab=sclk}
N 1440 -690 1490 -690 {lab=sdata}
N 1440 -670 1490 -670 {lab=en}
N 1610 -670 1650 -670 {lab=en}
N 1610 -690 1650 -690 {lab=sdata}
N 1610 -710 1650 -710 {lab=sclk}
N 1610 -730 1650 -730 {lab=rst}
N 1320 -750 1380 -750 {lab=#net1}
N 1320 -730 1380 -730 {lab=#net2}
N 1320 -710 1380 -710 {lab=#net3}
N 1320 -690 1380 -690 {lab=#net4}
N 1320 -670 1380 -670 {lab=#net5}
N 1130 -710 1160 -710 {lab=#net6}
N 1620 -970 1660 -970 {lab=CLK_OUT}
C {vsource.sym} 540 -520 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} 540 -450 0 0 {name=l1 lab=GND}
C {devices/vdd.sym} 540 -610 0 0 {name=l5 lab=VDD}
C {devices/isource.sym} 1130 -900 3 0 {name=I0 value=50u}
C {devices/vdd.sym} 1100 -900 3 0 {name=l12 lab=VDD}
C {vsource.sym} 460 -770 0 1 {name=Vfref value="0 pulse(0 1.2 0n 0.1n 0.1n 5n 10n)" savecurrent=false}
C {lab_pin.sym} 460 -960 0 1 {name=p11 sig_type=std_logic lab=CLK_IN}
C {gnd.sym} 460 -700 0 0 {name=l10 lab=GND}
C {launcher.sym} 1270 -510 0 0 {name=h1
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/pll_dsm_div.raw tran
"
}
C {launcher.sym} 1270 -470 0 0 {name=h4
descr=SimulateNGSPICE
tclcommand="
xschem netlist; 
xschem simulate; 
xschem raw_read $netlist_dir/tb_COMB.raw tran; 
xschem redraw
"}
C {lab_pin.sym} 880 -880 0 1 {name=p12 sig_type=std_logic lab=Ibias}
C {gnd.sym} 880 -820 0 0 {name=l11 lab=GND}
C {isource.sym} 880 -850 0 0 {name=I1 value=10m}
C {lab_pin.sym} 880 -920 0 0 {name=p13 sig_type=std_logic lab=Ibias}
C {lab_pin.sym} 820 -1030 0 1 {name=p16 lab=UP}
C {lab_pin.sym} 560 -890 0 0 {name=p18 lab=DSM_OUT}
C {lab_pin.sym} 810 -880 0 1 {name=p19 lab=DN}
C {opin.sym} 1540 -950 0 0 {name=p24 lab=OUTn
}
C {sg13g2_stdcells/sg13g2_inv_2.sym} 1530 -970 0 0 {name=x5 VDD=VDD VSS=GND prefix=sg13g2_ }
C {lab_pin.sym} 1170 -1010 0 1 {name=p10 lab=VCTRL}
C {vdd.sym} 630 -1070 0 0 {name=l6 lab=VDD}
C {vdd.sym} 970 -1070 0 0 {name=l2 lab=VDD}
C {vdd.sym} 1380 -1070 0 0 {name=l4 lab=VDD}
C {lab_pin.sym} 1240 -930 0 0 {name=p1 sig_type=std_logic lab=IbiasVCO
}
C {gnd.sym} 630 -860 0 0 {name=l3 lab=GND}
C {gnd.sym} 970 -870 0 0 {name=l7 lab=GND}
C {gnd.sym} 1380 -820 0 0 {name=l8 lab=GND}
C {lab_pin.sym} 1490 -670 0 1 {name=p2 sig_type=std_logic lab=en}
C {lab_pin.sym} 1490 -690 0 1 {name=p3 sig_type=std_logic lab=sdata}
C {lab_pin.sym} 1490 -710 0 1 {name=p4 sig_type=std_logic lab=sclk}
C {lab_pin.sym} 1490 -730 0 1 {name=p5 sig_type=std_logic lab=rst}
C {lab_pin.sym} 1610 -670 0 0 {name=p8 sig_type=std_logic lab=en}
C {lab_pin.sym} 1610 -690 0 0 {name=p9 sig_type=std_logic lab=sdata}
C {lab_pin.sym} 1610 -710 0 0 {name=p14 sig_type=std_logic lab=sclk}
C {lab_pin.sym} 1610 -730 0 0 {name=p15 sig_type=std_logic lab=rst}
C {noconn.sym} 1650 -730 2 0 {name=l9}
C {noconn.sym} 1650 -710 2 0 {name=l13}
C {noconn.sym} 1650 -690 2 0 {name=l14}
C {noconn.sym} 1650 -670 2 0 {name=l15}
C {simulator_commands.sym} 1010 -520 0 0 {name=SimulatorNGSPICE
vhdl_ignore=1
spice_ignore="tcleval([regexp -nocase \{xyce\} $sim(spice,$sim(spice,default),name)])"
simulator=ngspice
only_toplevel=false 
value="
*****************************************************
* PLL + DSM Frequency Divider Testbench
*****************************************************

.option temp = 27
.param VDD = 1.2

* ==============================
* Include Models
* ==============================

* Inductor / analog models
.include ./IHP_4nH_Inductor.spice

.control
  save v(sdata) v(sclk) v(rst) v(en) v(UP) v(DN) v(VCTRL) v(CLK_IN) v(DSM_OUT) v(CLK_OUT) 
  * Simulation accuracy options
  .options maxstep=10p reltol=1e-4 abstol=1e-9

 * Run long enough for PLL lock
  tran 20p 5u uic
  remzerovec
  write pll_dsm_div.raw
.endc
* to generate following file copy stimuli.test
* to the simulation directory and run simulation -> Utile Stimuli Editor (GUI), 
* and press 'Translate'
.include stimuli_test.cir
"}
C {simulator_commands.sym} 810 -520 0 0 {
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


.param CP_N_L = 0.5u
.param CP_N_W = 10u
.param CP_P_M = 1
.param CP_P_L = 0.5u
.param CP_P_W = 30u
.param CP_N_M = 1
.param C_CP = 400p
"}
C {opin.sym} 1660 -970 0 0 {name=p6 lab=CLK_OUT
}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/charge-pump/CP.sym} 970 -970 0 0 {name=x4}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/phase-freq-detector/PFD.sym} 630 -960 0 0 {name=x6}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/dsm_and_freq_divider.sym} 1240 -710 0 1 {name=adut
dut=dut
d_cosim_model= d_cosim
model=./../dsm_and_freq_divider.so}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/adc_bridge1.sym} 1410 -750 0 1 {name=A1
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=0.6
}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/adc_bridge1.sym} 1410 -730 0 1 {name=A2
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=0.6
}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/adc_bridge1.sym} 1410 -710 0 1 {name=A3
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=0.6
}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/adc_bridge1.sym} 1410 -690 0 1 {name=A4
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=0.6
}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/adc_bridge1.sym} 1410 -670 0 1 {name=A5
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=0.6
}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/dac_bridge1.sym} 1100 -710 0 1 {name=A6
dac=dac1
dac_bridge_model=dac_bridge
out_low=0
out_high=1.2
}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/lc-vco/LC_VCO.sym} 1380 -960 0 0 {name=x1}
