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
N 700 -510 720 -510 {lab=DN}
N 550 -600 550 -590 {lab=VDD}
N 950 -610 950 -600 {lab=VDD}
N 860 -510 880 -510 {lab=Ibias}
N 550 -470 550 -460 {lab=GND}
N 950 -480 950 -470 {lab=GND}
N 1380 -320 1730 -320 {lab=CLK_OUT}
N 1380 -300 1550 -300 {lab=rst}
N 1380 -280 1550 -280 {lab=sclk}
N 1380 -260 1550 -260 {lab=sdata}
N 1380 -240 1550 -240 {lab=en}
N 460 -540 520 -540 {lab=CLK_IN}
N 700 -550 720 -550 {lab=UP}
N 1050 -540 1070 -540 {lab=VCTRL}
N 860 -550 880 -550 {lab=UP}
N 860 -530 880 -530 {lab=DN}
N 460 -520 520 -520 {lab=DSM_OUT}
N 460 -280 1220 -280 {lab=DSM_OUT}
N 1550 -520 1600 -520 {lab=OUTn}
N 1440 -630 1440 -620 {lab=VDD}
N 1320 -540 1340 -540 {lab=VCTRL}
N 1440 -440 1440 -430 {lab=GND}
N 1730 -540 1800 -540 {lab=CLK_OUT}
N 1320 -520 1340 -520 {lab=IbiasVCO}
N 1730 -540 1730 -320 {lab=CLK_OUT}
N 1660 -540 1730 -540 {lab=CLK_OUT}
N 1550 -540 1580 -540 {lab=#net1}
C {lab_pin.sym} 720 -550 0 1 {name=p16 lab=UP}
C {lab_pin.sym} 460 -520 0 0 {name=p18 sig_type=std_logic lab=DSM_OUT}
C {lab_pin.sym} 720 -510 0 1 {name=p19 lab=DN}
C {lab_pin.sym} 1070 -540 0 1 {name=p10 lab=VCTRL}
C {vdd.sym} 550 -600 0 0 {name=l6 lab=VDD}
C {vdd.sym} 950 -610 0 0 {name=l2 lab=VDD}
C {lab_pin.sym} 1550 -240 0 1 {name=p2 sig_type=std_logic lab=en}
C {lab_pin.sym} 1550 -260 0 1 {name=p3 sig_type=std_logic lab=sdata}
C {lab_pin.sym} 1550 -280 0 1 {name=p4 sig_type=std_logic lab=sclk}
C {lab_pin.sym} 1550 -300 0 1 {name=p5 sig_type=std_logic lab=rst}
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
C {lab_pin.sym} 860 -510 0 0 {name=p20 lab=Ibias}
C {lab_pin.sym} 860 -550 0 0 {name=p21 lab=UP}
C {lab_pin.sym} 860 -530 0 0 {name=p22 lab=DN}
C {opin.sym} 200 -210 0 0 {name=p24 lab=OUTn
}
C {opin.sym} 200 -240 0 0 {name=p6 lab=CLK_OUT}
C {ipin.sym} 90 -420 0 0 {name=p8 lab=sdata}
C {ipin.sym} 90 -390 0 0 {name=p9 lab=en}
C {ipin.sym} 90 -360 0 0 {name=p14 lab=sclk}
C {ipin.sym} 90 -330 0 0 {name=p15 lab=rst}
C {sg13g2_stdcells/sg13g2_inv_2.sym} 1620 -540 0 0 {name=x5 VDD=VDD VSS=GND prefix=sg13g2_ }
C {vdd.sym} 1440 -630 0 0 {name=l4 lab=VDD}
C {lab_pin.sym} 1320 -520 0 0 {name=p12 lab=IbiasVCO}
C {lab_pin.sym} 1320 -540 0 0 {name=p23 lab=VCTRL}
C {gnd.sym} 1440 -430 0 0 {name=l7 lab=GND}
C {lab_pin.sym} 1800 -540 0 1 {name=p13 sig_type=std_logic lab=CLK_OUT}
C {lab_pin.sym} 1600 -520 0 1 {name=p25 lab=OUTn}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/charge-pump/CP.sym} 950 -540 0 0 {name=x1}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/lc-vco/LC_VCO.sym} 1440 -530 0 0 {name=x2}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/phase-freq-detector/PFD.sym} 550 -530 0 0 {name=x3}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/dsm/xschem/dsm_and_freq_divider.sym} 1300 -280 0 1 {name=adut
dut=dut
d_cosim_model= d_cosim
model=./../dsm_and_freq_divider.so}
