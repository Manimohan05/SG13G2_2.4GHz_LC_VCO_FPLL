v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 900 -300 900 -270 {
lab=n}
N 640 -250 640 -220 {
lab=d}
N 520 -280 600 -280 {
lab=g}
N 520 -320 520 -280 {
lab=g}
N 520 -400 520 -380 {
lab=0}
N 520 -400 640 -400 {
lab=0}
N 640 -400 640 -310 {
lab=0}
N 640 -400 730 -400 {
lab=0}
N 730 -400 730 -380 {
lab=0}
N 730 -320 730 -280 {
lab=b}
N 640 -280 730 -280 {
lab=b}
N 730 -400 820 -400 {
lab=0}
N 820 -400 820 -380 {
lab=0}
N 820 -320 820 -220 {
lab=d}
N 640 -220 820 -220 {
lab=d}
N 820 -400 900 -400 {
lab=0}
N 900 -400 900 -360 {
lab=0}
C {devices/code_shown.sym} 0 -880 0 0 {name=COMMANDS1 only_toplevel=false
value="
.param wx=5u lx=0.13u
.op

.control
option numdgt = 3
set wr_singlescale
set wr_vecnames

compose l_vec  values 0.13u 0.14u 0.15u 0.16u 0.17u 0.18u 0.19u
+ 0.2u 0.3u 0.4u 0.5u 0.6u 0.7u 0.8u 0.9u 1u 2u 3u
compose vg_vec start= 0 stop=1.201  step=25m
compose vd_vec start= 0 stop=1.201  step=25m
compose vb_vec start= 0 stop=-0.4 step=-0.2

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
        wrdata techsweep_sg13_lv_pmos.txt all
        destroy all
        set appendwrite
        unset set wr_vecnames  
      end
    end 
  end
end
unset appendwrite

alterparam lx=0.13u
reset
op
show
write techsweep_sg13_lv_pmos.raw
.endc
"}
C {devices/title.sym} 160 -40 0 0 {name=l5 author="Boris Murmann"}
C {devices/ngspice_get_value.sym} 1000 -320 0 0 {name=r1 node=v(@n.xm1.nsg13_lv_pmos[vth])
descr="Vt="}
C {devices/launcher.sym} 930 -490 0 0 {name=h3
descr="save, netlist & simulate"
tclcommand="xschem save; xschem netlist; xschem simulate"}
C {devices/ngspice_get_value.sym} 1000 -280 0 0 {name=r2 node=@n.xm1.nsg13_lv_pmos[cgg]
descr="cgg="}
C {devices/ngspice_get_expr.sym} 1110 -240 0 0 {name=r4 
node="[format %.4g [expr [ngspice::get_node \{@n.xm1.nsg13_lv_pmos[gm]\}] / [ngspice::get_node \{@n.xm1.nsg13_lv_pmos[gds]\}]]]"
descr="gm/gds="}
C {devices/ngspice_get_value.sym} 1000 -240 0 0 {name=r3 node=@n.xm1.nsg13_lv_pmos[cjd]
descr="cjd="}
C {devices/ngspice_get_value.sym} 1000 -200 0 0 {name=r5 node=@n.xm1.nsg13_lv_pmos[cjs]
descr="cjs="}
C {devices/ngspice_get_expr.sym} 1110 -280 0 0 {name=r6 
node="[format %.4g [expr [ngspice::get_node \{@n.xm1.nsg13_lv_pmos[gm]\}] / [ngspice::get_node \{@n.xm1.nsg13_lv_pmos[cgg]\}] / 6.283]]"
descr="fT_intrinsic="}
C {devices/ngspice_get_expr.sym} 1110 -320 0 0 {name=r7 
node="[format %.4g [expr [ngspice::get_node \{@n.xm1.nsg13_lv_pmos[gm]\}] / [ngspice::get_node \{i(@n.xm1.nsg13_lv_pmos[ids])\}]]]"
descr="gm/ID="}
C {devices/code_shown.sym} 650 -880 0 0 {name=COMMANDS2 only_toplevel=false
value="
.save @n.xm1.nsg13_lv_pmos[cdd]
.save @n.xm1.nsg13_lv_pmos[cgb]
.save @n.xm1.nsg13_lv_pmos[cgd]
.save @n.xm1.nsg13_lv_pmos[cgdol]
.save @n.xm1.nsg13_lv_pmos[cgg]
.save @n.xm1.nsg13_lv_pmos[cgs]
.save @n.xm1.nsg13_lv_pmos[cgsol]
.save @n.xm1.nsg13_lv_pmos[cjd]
.save @n.xm1.nsg13_lv_pmos[cjs]
.save @n.xm1.nsg13_lv_pmos[css]
.save @n.xm1.nsg13_lv_pmos[gds]
.save @n.xm1.nsg13_lv_pmos[gm]
.save @n.xm1.nsg13_lv_pmos[gmb]
.save @n.xm1.nsg13_lv_pmos[ids]
.save @n.xm1.nsg13_lv_pmos[l]
.save @n.xm1.nsg13_lv_pmos[sfl]
.save @n.xm1.nsg13_lv_pmos[sid]
.save @n.xm1.nsg13_lv_pmos[vth]
.save @vb[dc]
.save @vd[dc]
.save @vg[dc]
.save g d b n
"}
C {devices/code_shown.sym} 500 -130 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib $::SG13G2_MODELS/cornerMOSlv.lib mos_tt"}
C {devices/ccvs.sym} 900 -330 0 0 {name=Hn vnam=vd value=1}
C {devices/lab_wire.sym} 900 -270 0 0 {name=p4 sig_type=std_logic lab=n}
C {devices/vsource.sym} 520 -350 0 0 {name=vg value="DC 0.6 AC 1" savecurrent=false}
C {devices/vsource.sym} 820 -350 0 0 {name=vd value=0.6 savecurrent=false}
C {devices/lab_wire.sym} 730 -280 0 0 {name=p2 sig_type=std_logic lab=b}
C {devices/lab_wire.sym} 730 -220 0 0 {name=p3 sig_type=std_logic lab=d}
C {devices/lab_wire.sym} 550 -280 0 0 {name=p1 sig_type=std_logic lab=g}
C {devices/vsource.sym} 730 -350 0 0 {name=vb value="0" savecurrent=false}
C {devices/lab_wire.sym} 550 -400 0 0 {name=p5 sig_type=std_logic lab=0}
C {sg13g2_pr/sg13_lv_pmos.sym} 620 -280 0 0 {name=M1
l=\{lx\}
w=\{wx\}
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {devices/launcher.sym} 930 -450 0 0 {name=h1
descr="load op & annotate" 
tclcommand="xschem raw_read $netlist_dir/techsweep_sg13_lv_pmos.raw; set show_hidden_texts 1; xschem annotate_op"}
