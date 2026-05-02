v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 880 -270 880 -240 {
lab=n}
N 620 -220 620 -190 {
lab=d}
N 500 -250 580 -250 {
lab=g}
N 500 -290 500 -250 {
lab=g}
N 500 -370 500 -350 {
lab=0}
N 500 -370 620 -370 {
lab=0}
N 620 -370 620 -280 {
lab=0}
N 620 -370 710 -370 {
lab=0}
N 710 -370 710 -350 {
lab=0}
N 710 -290 710 -250 {
lab=b}
N 620 -250 710 -250 {
lab=b}
N 710 -370 800 -370 {
lab=0}
N 800 -370 800 -350 {
lab=0}
N 800 -290 800 -190 {
lab=d}
N 620 -190 800 -190 {
lab=d}
N 800 -370 880 -370 {
lab=0}
N 880 -370 880 -330 {
lab=0}
C {devices/code_shown.sym} 0 -880 0 0 {name=COMMANDS1 only_toplevel=false
value="
.param wx=5u lx=0.45u
.op

.control
option numdgt = 3
set wr_singlescale
set wr_vecnames

compose l_vec  values 0.45u 0.5u 0.55u
+ 0.6u 0.7u 0.8u 0.9u 1u 2u 3u
compose vg_vec start= 0 stop=3.301  step=25m
compose vd_vec start= 0 stop=3.301  step=25m
compose vb_vec start= 0 stop=-0.6   step=-0.2

foreach var1 $&l_vec
  alterparam lx=$var1
  reset
  foreach var2 $&vg_vec
    alter vg $var2
    foreach var3 $&vd_vec
      alter vd $var3
      foreach var4 $&vb_vec
        alter vb $var4
        run
        wrdata techsweep_sg13_hv_pmos.txt all
        destroy all
        set appendwrite
        unset set wr_vecnames  
      end
    end 
  end
end
unset appendwrite

alterparam lx=0.45u
reset
op
show
write techsweep_sg13_hv_pmos.raw
.endc
"}
C {devices/title.sym} 160 -40 0 0 {name=l5 author="Boris Murmann"}
C {devices/ngspice_get_value.sym} 1000 -320 0 0 {name=r1 node=v(@n.xm1.nsg13_hv_pmos[vth])
descr="Vt="}
C {devices/launcher.sym} 1000 -440 0 0 {name=h1
descr="load op & annotate" 
tclcommand="xschem raw_read $netlist_dir/techsweep_sg13_lv_nmos.raw; set show_hidden_texts 1; xschem annotate_op"}
C {devices/launcher.sym} 1000 -480 0 0 {name=h3
descr="save, netlist & simulate"
tclcommand="xschem save; xschem netlist; xschem simulate"}
C {devices/ngspice_get_value.sym} 1000 -280 0 0 {name=r2 node=@n.xm1.nsg13_hv_pmos[cgg]
descr="cgg="}
C {devices/ngspice_get_expr.sym} 1110 -240 0 0 {name=r4 
node="[format %.4g [expr [ngspice::get_node \{@n.xm1.nsg13_hv_pmos[gm]\}] / [ngspice::get_node \{@n.xm1.nsg13_hv_pmos[gds]\}]]]"
descr="gm/gds="}
C {devices/ngspice_get_value.sym} 1000 -240 0 0 {name=r3 node=@n.xm1.nsg13_hv_pmos[cjd]
descr="cjd="}
C {devices/ngspice_get_value.sym} 1000 -200 0 0 {name=r5 node=@n.xm1.nsg13_hv_pmos[cjs]
descr="cjs="}
C {devices/ngspice_get_expr.sym} 1110 -280 0 0 {name=r6 
node="[format %.4g [expr [ngspice::get_node \{@n.xm1.nsg13_hv_pmos[gm]\}] / [ngspice::get_node \{@n.xm1.nsg13_hv_pmos[cgg]\}] / 6.283]]"
descr="fT_intrinsic="}
C {devices/ngspice_get_expr.sym} 1110 -320 0 0 {name=r7 
node="[format %.4g [expr [ngspice::get_node \{@n.xm1.nsg13_hv_pmos[gm]\}] / [ngspice::get_node \{i(@n.xm1.nsg13_hv_pmos[ids])\}]]]"
descr="gm/ID="}
C {devices/code_shown.sym} 640 -880 0 0 {name=COMMANDS2 only_toplevel=false
value="
.save @n.xm1.nsg13_hv_pmos[cdd]
.save @n.xm1.nsg13_hv_pmos[cgb]
.save @n.xm1.nsg13_hv_pmos[cgd]
.save @n.xm1.nsg13_hv_pmos[cgdol]
.save @n.xm1.nsg13_hv_pmos[cgg]
.save @n.xm1.nsg13_hv_pmos[cgs]
.save @n.xm1.nsg13_hv_pmos[cgsol]
.save @n.xm1.nsg13_hv_pmos[cjd]
.save @n.xm1.nsg13_hv_pmos[cjs]
.save @n.xm1.nsg13_hv_pmos[css]
.save @n.xm1.nsg13_hv_pmos[gds]
.save @n.xm1.nsg13_hv_pmos[gm]
.save @n.xm1.nsg13_hv_pmos[gmb]
.save @n.xm1.nsg13_hv_pmos[ids]
.save @n.xm1.nsg13_hv_pmos[l]
.save @n.xm1.nsg13_hv_pmos[sfl]
.save @n.xm1.nsg13_hv_pmos[sid]
.save @n.xm1.nsg13_hv_pmos[vth]
.save @vb[dc]
.save @vd[dc]
.save @vg[dc]
.save g d b n
"}
C {devices/code_shown.sym} 500 -130 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib $::SG13G2_MODELS/cornerMOShv.lib mos_tt"}
C {sg13g2_pr/sg13_hv_pmos.sym} 600 -250 0 0 {name=M1
l=\{lx\}
w=\{wx\}
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {devices/ccvs.sym} 880 -300 0 0 {name=Hn vnam=vd value=1}
C {devices/lab_wire.sym} 880 -240 0 0 {name=p4 sig_type=std_logic lab=n}
C {devices/vsource.sym} 500 -320 0 0 {name=vg value="DC 0.8 AC 1" savecurrent=false}
C {devices/vsource.sym} 800 -320 0 0 {name=vd value=1.65 savecurrent=false}
C {devices/lab_wire.sym} 710 -250 0 0 {name=p2 sig_type=std_logic lab=b}
C {devices/lab_wire.sym} 710 -190 0 0 {name=p3 sig_type=std_logic lab=d}
C {devices/lab_wire.sym} 530 -250 0 0 {name=p1 sig_type=std_logic lab=g}
C {devices/vsource.sym} 710 -320 0 0 {name=vb value="0" savecurrent=false}
C {devices/lab_wire.sym} 530 -370 0 0 {name=p5 sig_type=std_logic lab=0}
