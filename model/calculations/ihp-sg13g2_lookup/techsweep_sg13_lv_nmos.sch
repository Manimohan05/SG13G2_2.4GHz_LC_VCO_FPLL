v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 620 -390 620 -370 {
lab=d}
N 500 -220 500 -190 {
lab=0}
N 810 -220 810 -190 {
lab=0}
N 720 -220 720 -190 {
lab=0}
N 620 -310 620 -190 {
lab=0}
N 720 -340 720 -280 {
lab=b}
N 500 -340 500 -280 {
lab=g}
N 500 -340 580 -340 {
lab=g}
N 620 -340 720 -340 {
lab=b}
N 620 -390 810 -390 {
lab=d}
N 810 -390 810 -280 {
lab=d}
N 890 -220 890 -190 {
lab=0}
N 890 -320 890 -280 {
lab=n}
N 810 -190 890 -190 {lab=0}
N 720 -190 810 -190 {lab=0}
N 620 -190 720 -190 {lab=0}
N 500 -190 620 -190 {lab=0}
C {devices/vsource.sym} 500 -250 0 0 {name=vg value="DC 0.6 AC 1" savecurrent=false}
C {devices/vsource.sym} 810 -250 0 0 {name=vd value=0.6 savecurrent=false}
C {devices/vsource.sym} 720 -250 0 1 {name=vb value=0 savecurrent=false}
C {devices/lab_wire.sym} 550 -340 0 0 {name=p1 sig_type=std_logic lab=g}
C {devices/lab_wire.sym} 720 -390 0 0 {name=p2 sig_type=std_logic lab=d}
C {devices/lab_wire.sym} 720 -340 0 0 {name=p3 sig_type=std_logic lab=b}
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
        wrdata techsweep_sg13_lv_nmos.txt all
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
write techsweep_sg13_lv_nmos.raw
.endc
"}
C {devices/title.sym} 160 -40 0 0 {name=l5 author="Boris Murmann"}
C {devices/ngspice_get_value.sym} 1000 -320 0 0 {name=r1 node=v(@n.xm1.nsg13_lv_nmos[vth])
descr="Vt="}
C {devices/launcher.sym} 1000 -440 0 0 {name=h1
descr="load op & annotate" 
tclcommand="xschem raw_read $netlist_dir/techsweep_sg13_lv_nmos.raw; set show_hidden_texts 1; xschem annotate_op"}
C {devices/launcher.sym} 1000 -480 0 0 {name=h3
descr="save, netlist & simulate"
tclcommand="xschem save; xschem netlist; xschem simulate"}
C {devices/ngspice_get_value.sym} 1000 -280 0 0 {name=r2 node=@n.xm1.nsg13_lv_nmos[cgg]
descr="cgg="}
C {devices/ngspice_get_expr.sym} 1110 -240 0 0 {name=r4 
node="[format %.4g [expr [ngspice::get_node \{@n.xm1.nsg13_lv_nmos[gm]\}] / [ngspice::get_node \{@n.xm1.nsg13_lv_nmos[gds]\}]]]"
descr="gm/gds="}
C {devices/ngspice_get_value.sym} 1000 -240 0 0 {name=r3 node=@n.xm1.nsg13_lv_nmos[cjd]
descr="cjd="}
C {devices/ngspice_get_value.sym} 1000 -200 0 0 {name=r5 node=@n.xm1.nsg13_lv_nmos[cjs]
descr="cjs="}
C {devices/ngspice_get_expr.sym} 1110 -280 0 0 {name=r6 
node="[format %.4g [expr [ngspice::get_node \{@n.xm1.nsg13_lv_nmos[gm]\}] / [ngspice::get_node \{@n.xm1.nsg13_lv_nmos[cgg]\}] / 6.283]]"
descr="fT_intrinsic="}
C {devices/ngspice_get_expr.sym} 1110 -320 0 0 {name=r7 
node="[format %.4g [expr [ngspice::get_node \{@n.xm1.nsg13_lv_nmos[gm]\}] / [ngspice::get_node \{i(@n.xm1.nsg13_lv_nmos[ids])\}]]]"
descr="gm/ID="}
C {devices/code_shown.sym} 640 -880 0 0 {name=COMMANDS2 only_toplevel=false
value="
.save @n.xm1.nsg13_lv_nmos[cdd]
.save @n.xm1.nsg13_lv_nmos[cgb]
.save @n.xm1.nsg13_lv_nmos[cgd]
.save @n.xm1.nsg13_lv_nmos[cgdol]
.save @n.xm1.nsg13_lv_nmos[cgg]
.save @n.xm1.nsg13_lv_nmos[cgs]
.save @n.xm1.nsg13_lv_nmos[cgsol]
.save @n.xm1.nsg13_lv_nmos[cjd]
.save @n.xm1.nsg13_lv_nmos[cjs]
.save @n.xm1.nsg13_lv_nmos[css]
.save @n.xm1.nsg13_lv_nmos[gds]
.save @n.xm1.nsg13_lv_nmos[gm]
.save @n.xm1.nsg13_lv_nmos[gmb]
.save @n.xm1.nsg13_lv_nmos[ids]
.save @n.xm1.nsg13_lv_nmos[l]
.save @n.xm1.nsg13_lv_nmos[sfl]
.save @n.xm1.nsg13_lv_nmos[sid]
.save @n.xm1.nsg13_lv_nmos[vth]
.save @vb[dc]
.save @vd[dc]
.save @vg[dc]
.save g d b n
"}
C {devices/ccvs.sym} 890 -250 0 0 {name=Hn vnam=vd value=1}
C {devices/lab_wire.sym} 890 -320 0 0 {name=p4 sig_type=std_logic lab=n}
C {devices/lab_wire.sym} 550 -190 0 0 {name=p5 sig_type=std_logic lab=0}
C {devices/code_shown.sym} 500 -130 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib $::SG13G2_MODELS/cornerMOSlv.lib mos_tt"}
C {sg13g2_pr/sg13_lv_nmos.sym} 600 -340 2 1 {name=M1
l=\{lx\}
w=\{wx\}
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
