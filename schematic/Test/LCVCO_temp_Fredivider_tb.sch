v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 -190 -1290 610 -890 {flags=graph
y1=-0.029
y2=1.3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
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
color="5 4 12"
node="Outp
outd
Vctrl"
x2=4e-08
hcursor1_y=0.41963418
hcursor2_y=0.70549986}
B 2 640 -1290 1440 -890 {flags=graph
y1=0
y2=0.01
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
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
color=21
node=freq_vector
x2=4e-08
hcursor1_y=2.2597346e+09
hcursor2_y=2.5045169e+09}
N 500 -670 550 -670 {lab=OUTn}
N 250 -690 290 -690 {lab=VCTRL}
N 390 -590 390 -560 {lab=GND}
N 250 -670 290 -670 {lab=Ibias}
N 390 -790 390 -770 {lab=VDD}
N 850 -690 870 -690 {lab=OUTd}
N 620 -760 620 -690 {lab=OUTp}
N 620 -690 670 -690 {lab=OUTp}
N 580 -690 620 -690 {lab=OUTp}
N -30 -690 -30 -650 {lab=GND}
N -160 -830 -160 -750 {lab=VDD}
N -160 -690 -160 -650 {lab=GND}
N -30 -830 -30 -750 {lab=VCTRL}
N -90 -690 -90 -670 {lab=Ibias}
C {launcher.sym} 740 -540 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/LCVCO_freqdiv.raw tran"
}
C {opin.sym} 550 -670 0 0 {name=p1 lab=OUTn
}
C {iopin.sym} 390 -790 3 0 {name=p4 lab=VDD
}
C {iopin.sym} 250 -690 2 0 {name=p6 lab=VCTRL
}
C {iopin.sym} 390 -560 1 0 {name=p3 lab=GND
}
C {iopin.sym} 250 -670 2 0 {name=p5 lab=Ibias
}
C {lab_pin.sym} 620 -760 0 1 {name=p23 lab=OUTp}
C {lab_pin.sym} 870 -690 0 1 {name=p7 lab=OUTd}
C {sg13g2_stdcells/sg13g2_inv_2.sym} 540 -690 0 0 {name=x5 VDD=VDD VSS=GND prefix=sg13g2_ }
C {simulator_commands.sym} 1050 -600 0 0 {name=NGSPICE2 only_toplevel=true 
value="
.model freq_div freq_div
.include ./IHP_4nH_Inductor.spice
.param temp=27
.control
pre_osdi ./freq_div.osdi
save all
*.ic v(OUTp)=0.6

tran 1p 40n UIC

linearize v(OUTp) v(Vctrl) v(outd)

    let n_pts = length(time)
    let freq_vector = unitvec(n_pts) * 0
    
    * Advanced script to calculate instantaneous frequency
    let i = 1
    let last_cross = 0
    while i < length(time)
        if (v(OUTp)[i] >= 0.6) & (v(OUTp)[i-1] < 0.6)
            let current_cross = time[i]
            let period = current_cross - last_cross
            let inst_freq = 1 / period
            let freq_vector[i] = inst_freq
            let last_cross = current_cross
        else
            let freq_vector[i] = freq_vector[i-1]
        end
        let i = i + 1
    end

* Save transient waveform to raw file
write LCVCO_freqdiv.raw

*quit 0
.endc
"}
C {vsource.sym} -160 -720 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -30 -720 0 0 {name=V2 value="pulse(0.3 1.0 50n 100n 100n 200n)" savecurrent=false}
C {gnd.sym} -160 -650 0 0 {name=l1 lab=GND}
C {gnd.sym} -30 -650 0 0 {name=l2 lab=GND}
C {devices/vdd.sym} -160 -830 0 0 {name=l5 lab=VDD}
C {devices/vdd.sym} -30 -830 0 0 {name=l8 lab=VCTRL}
C {devices/isource.sym} -90 -720 0 0 {name=I0 value=50u}
C {devices/vdd.sym} -90 -750 0 0 {name=l12 lab=VDD}
C {devices/vdd.sym} -90 -670 2 0 {name=l3 lab=Ibias}
C {simulator_commands_shown.sym} 960 -840 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ_stat
.include /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice
.global VDD GND

"
      }
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/lc-vco/LC_VCO.sym} 390 -680 0 0 {name=x4}
C {/foss/designs/frac-n-pll-vco-unic_cass/schematic/Test/FD/Freq_Div_std.sym} 770 -690 0 1 {name=x7}
