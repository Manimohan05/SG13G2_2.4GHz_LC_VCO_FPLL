v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 610 -990 610 -930 {lab=VDD}
N 610 -870 610 -830 {lab=GND}
N 1200 -920 1250 -920 {lab=OUTn}
N 1090 -860 1090 -820 {lab=GND}
N 1090 -1030 1090 -1000 {lab=VDD}
N 880 -960 880 -950 {lab=#net1}
N 880 -950 980 -950 {lab=#net1}
N 880 -930 880 -920 {lab=CLK_IN}
N 880 -930 980 -930 {lab=CLK_IN}
N 880 -860 880 -830 {lab=GND}
N 940 -910 940 -890 {lab=#net2}
N 940 -910 980 -910 {lab=#net2}
N 1200 -940 1270 -940 {lab=CLK_OUT}
C {vsource.sym} 610 -900 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} 610 -830 0 0 {name=l1 lab=GND}
C {devices/vdd.sym} 610 -990 0 0 {name=l5 lab=VDD}
C {devices/isource.sym} 880 -990 0 0 {name=I0 value=50u}
C {devices/vdd.sym} 880 -1020 0 0 {name=l12 lab=VDD}
C {vsource.sym} 880 -890 0 1 {name=Vfref value="0 pulse(0 1.2 0n 0.1n 0.1n 5n 10n)" savecurrent=false}
C {lab_pin.sym} 880 -930 0 0 {name=p11 sig_type=std_logic lab=CLK_IN}
C {gnd.sym} 880 -830 0 0 {name=l10 lab=GND}
C {gnd.sym} 940 -830 0 0 {name=l11 lab=GND}
C {isource.sym} 940 -860 0 0 {name=I1 value=10m}
C {opin.sym} 1250 -920 0 0 {name=p24 lab=OUTn
}
C {gnd.sym} 1090 -820 0 0 {name=l7 lab=GND}
C {vdd.sym} 1090 -1030 0 0 {name=l3 lab=VDD}
C {opin.sym} 1270 -940 0 0 {name=p6 lab=CLK_OUT}
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
.include ./IHP_4nH_Inductor.spice

.control
save all
op
set filetype=ascii
write op_out.raw
print all > op_out.txt
.endc

* to generate following file copy stimuli.test
* to the simulation directory and run simulation -> Utile Stimuli Editor (GUI), 
* and press 'Translate'
.include stimuli_test.cir
"}
C {simulator_commands.sym} 1460 -970 0 0 {
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
C {LC_VCO_PLL.sym} 1100 -930 0 0 {name=x1}
