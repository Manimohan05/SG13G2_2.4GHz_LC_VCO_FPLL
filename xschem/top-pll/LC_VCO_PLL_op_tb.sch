v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 1200 -930 1250 -930 {lab=OUT}
N 1090 -860 1090 -820 {lab=GND}
N 1090 -1030 1090 -1000 {lab=VDD}
N 880 -960 880 -950 {lab=VBGR}
N 880 -950 980 -950 {lab=VBGR}
N 880 -930 880 -920 {lab=CLK_IN}
N 880 -930 980 -930 {lab=CLK_IN}
N 880 -860 880 -830 {lab=GND}
N 940 -910 940 -890 {lab=#net1}
N 940 -910 980 -910 {lab=#net1}
N 670 -950 670 -850 {lab=VDD}
N 670 -790 670 -740 {lab=GND}
N 590 -780 590 -740 {lab=GND}
N 590 -940 590 -840 {lab=VBGR}
C {vsource.sym} 880 -890 0 1 {name=Vfref value="0 pulse(0 1.2 0n 0.1n 0.1n 5n 10n)" savecurrent=false}
C {lab_pin.sym} 880 -930 0 0 {name=p11 sig_type=std_logic lab=CLK_IN}
C {gnd.sym} 880 -830 0 0 {name=l10 lab=GND}
C {gnd.sym} 940 -830 0 0 {name=l11 lab=GND}
C {isource.sym} 940 -860 0 0 {name=I1 value=10m}
C {opin.sym} 1250 -930 0 0 {name=p24 lab=OUT
}
C {gnd.sym} 1090 -820 0 0 {name=l7 lab=GND}
C {vdd.sym} 1090 -1030 0 0 {name=l3 lab=VDD}
C {simulator_commands.sym} 1580 -970 0 0 {name=SimulatorNGSPICE
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
.include ../IHP_4nH_Inductor.spice

.control
save all
op
set filetype=ascii

* Print supply current
print i(V1)

* Print power (correct way)
let power = i(V1)*v(VDD)
print power

write op_out.raw
print all > op_out.txt
.endc

* to generate following file copy stimuli.test
* to the simulation directory and run simulation -> Utile Stimuli Editor (GUI), 
* and press 'Translate'
.include ../simulations/stimuli_test.cir
"}
C {top-pll/LC_VCO_FPLL.sym} 1080 -840 0 0 {name=x1}
C {vsource.sym} 670 -820 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} 670 -740 0 0 {name=l1 lab=GND}
C {vdd.sym} 670 -950 0 0 {name=l5 lab=VDD}
C {vsource.sym} 590 -810 0 0 {name=VBGR value=0.6 savecurrent=false}
C {gnd.sym} 590 -740 0 0 {name=l13 lab=GND}
C {vdd.sym} 590 -940 0 0 {name=l4 lab=VBGR}
C {vdd.sym} 880 -960 0 0 {name=l2 lab=VBGR}
C {simulator_commands.sym} 1420 -970 0 0 {
name=Libs_Ngspice1
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
*.include /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice
.include /opt/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice
.global VDD GND


.param CP_N_L = 1u
.param CP_N_W = 3u
.param CP_P_M = 1
.param CP_P_L = 1u
.param CP_P_W = 10u
.param CP_N_M = 1
"}
