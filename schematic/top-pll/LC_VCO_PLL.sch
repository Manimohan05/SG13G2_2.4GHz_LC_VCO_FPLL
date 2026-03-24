v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 490 -470 490 -310 {}
L 4 470 -450 490 -470 {}
L 4 490 -470 510 -450 {}
P 4 1 1070 -550 {}
N 1550 -520 1600 -520 {lab=OUTn}
N 1440 -630 1440 -620 {lab=VDD}
N 1320 -540 1340 -540 {lab=VCTRL}
N 700 -510 720 -510 {lab=DN}
N 550 -600 550 -590 {lab=VDD}
N 950 -610 950 -600 {lab=VDD}
N 860 -510 880 -510 {lab=Ibias}
N 550 -470 550 -460 {lab=GND}
N 950 -480 950 -470 {lab=GND}
N 1440 -440 1440 -430 {lab=GND}
N 1380 -320 1440 -320 {lab=#net1}
N 1380 -300 1440 -300 {lab=#net2}
N 1380 -280 1440 -280 {lab=#net3}
N 1380 -260 1440 -260 {lab=#net4}
N 1380 -240 1440 -240 {lab=#net5}
N 1190 -280 1220 -280 {lab=#net6}
N 1500 -320 1730 -320 {lab=CLK_OUT}
N 1500 -300 1550 -300 {lab=rst}
N 1500 -280 1550 -280 {lab=sclk}
N 1500 -260 1550 -260 {lab=sdata}
N 1500 -240 1550 -240 {lab=en}
N 1670 -240 1710 -240 {lab=en}
N 1670 -260 1710 -260 {lab=sdata}
N 1670 -280 1710 -280 {lab=sclk}
N 1670 -300 1710 -300 {lab=rst}
N 1730 -540 1800 -540 {lab=CLK_OUT}
N 1320 -520 1340 -520 {lab=IbiasVCO}
N 460 -540 520 -540 {lab=CLK_IN}
N 1730 -540 1730 -320 {lab=CLK_OUT}
N 1660 -540 1730 -540 {lab=CLK_OUT}
N 700 -550 720 -550 {lab=UP}
N 1050 -540 1070 -540 {lab=VCTRL}
N 860 -550 880 -550 {lab=UP}
N 860 -530 880 -530 {lab=DN}
N 460 -520 520 -520 {lab=DSM_OUT}
N 460 -280 1130 -280 {lab=DSM_OUT}
N 1550 -540 1580 -540 {lab=#net7}
C {lab_pin.sym} 720 -550 0 1 {name=p16 lab=UP}
C {lab_pin.sym} 460 -520 0 0 {name=p18 sig_type=std_logic lab=DSM_OUT}
C {lab_pin.sym} 720 -510 0 1 {name=p19 lab=DN}
C {sg13g2_stdcells/sg13g2_inv_2.sym} 1620 -540 0 0 {name=x5 VDD=VDD VSS=GND prefix=sg13g2_ }
C {lab_pin.sym} 1070 -540 0 1 {name=p10 lab=VCTRL}
C {vdd.sym} 550 -600 0 0 {name=l6 lab=VDD}
C {vdd.sym} 950 -610 0 0 {name=l2 lab=VDD}
C {vdd.sym} 1440 -630 0 0 {name=l4 lab=VDD}
C {lab_pin.sym} 1550 -240 0 1 {name=p2 sig_type=std_logic lab=en}
C {lab_pin.sym} 1550 -260 0 1 {name=p3 sig_type=std_logic lab=sdata}
C {lab_pin.sym} 1550 -280 0 1 {name=p4 sig_type=std_logic lab=sclk}
C {lab_pin.sym} 1550 -300 0 1 {name=p5 sig_type=std_logic lab=rst}
C {lab_pin.sym} 1670 -240 0 0 {name=p8 sig_type=std_logic lab=en}
C {lab_pin.sym} 1670 -260 0 0 {name=p9 sig_type=std_logic lab=sdata}
C {lab_pin.sym} 1670 -280 0 0 {name=p14 sig_type=std_logic lab=sclk}
C {lab_pin.sym} 1670 -300 0 0 {name=p15 sig_type=std_logic lab=rst}
C {noconn.sym} 1710 -300 2 0 {name=l9}
C {noconn.sym} 1710 -280 2 0 {name=l13}
C {noconn.sym} 1710 -260 2 0 {name=l14}
C {noconn.sym} 1710 -240 2 0 {name=l15}
C {iopin.sym} 170 -180 1 0 {name=p62 lab=GND}
C {iopin.sym} 170 -290 3 0 {name=p66 lab=VDD
}
C {ipin.sym} 140 -260 0 0 {name=p29 lab=CLK_IN}
C {ipin.sym} 140 -230 0 0 {name=p7 lab=IbiasVCO}
C {ipin.sym} 140 -200 0 0 {name=p1 lab=Ibias}
C {lab_pin.sym} 460 -540 0 0 {name=p17 lab=CLK_IN}
C {gnd.sym} 550 -460 0 0 {name=l3 lab=GND}
C {gnd.sym} 950 -470 0 0 {name=l5 lab=GND}
C {lab_pin.sym} 460 -280 0 0 {name=p11 sig_type=std_logic lab=DSM_OUT}
C {lab_pin.sym} 1320 -520 0 0 {name=p12 lab=IbiasVCO}
C {lab_pin.sym} 860 -510 0 0 {name=p20 lab=Ibias}
C {lab_pin.sym} 860 -550 0 0 {name=p21 lab=UP}
C {lab_pin.sym} 860 -530 0 0 {name=p22 lab=DN}
C {lab_pin.sym} 1320 -540 0 0 {name=p23 lab=VCTRL}
C {gnd.sym} 1440 -430 0 0 {name=l7 lab=GND}
C {lab_pin.sym} 1800 -540 0 1 {name=p13 sig_type=std_logic lab=CLK_OUT}
C {lab_pin.sym} 1600 -520 0 1 {name=p25 lab=OUTn}
C {opin.sym} 200 -210 0 0 {name=p24 lab=OUTn
}
C {opin.sym} 200 -240 0 0 {name=p6 lab=CLK_OUT}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/charge-pump/CP.sym} 950 -540 0 0 {name=x4}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/phase-freq-detector/PFD.sym} 550 -530 0 0 {name=x6}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/lc-vco/LC_VCO.sym} 1440 -530 0 0 {name=x1}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/dsm_and_freq_divider.sym} 1300 -280 0 1 {name=adut
dut=dut
d_cosim_model= d_cosim
model=./../dsm_and_freq_divider.so}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/adc_bridge1.sym} 1470 -320 0 1 {name=A1
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=0.6
}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/adc_bridge1.sym} 1470 -300 0 1 {name=A2
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=0.6
}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/adc_bridge1.sym} 1470 -280 0 1 {name=A3
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=0.6
}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/adc_bridge1.sym} 1470 -260 0 1 {name=A4
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=0.6
}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/adc_bridge1.sym} 1470 -240 0 1 {name=A5
adc=adc1
adc_bridge_model=adc_bridge
in_low=0.4
in_high=0.6
}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/dac_bridge1.sym} 1160 -280 0 1 {name=A6
dac=dac1
dac_bridge_model=dac_bridge
out_low=0
out_high=1.2
}
