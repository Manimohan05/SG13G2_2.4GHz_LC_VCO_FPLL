v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 890 -590 1690 -190 {flags=graph
y1=-23
y2=-15
ypos1=0
ypos2=2
divy=5
subdivy=8
unity=1
x1=-0.10850404
x2=10.891488
divx=5
subdivx=8
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=1
logy=1


color=4
node=onoise_spectrum}
T {tcleval(
sfl = [to_eng [xschem raw value \\@n.xm1.nsg13_lv_nmos\\\\[sfl\\\\]  0]]
sid = [to_eng [xschem raw value \\@n.xm1.nsg13_lv_nmos\\\\[sid\\\\]  0]]
gm = [to_eng [xschem raw value \\@n.xm1.nsg13_lv_nmos\\\\[gm\\\\]  0]]
ID = [to_eng [xschem raw value i(\\@n.xm1.nsg13_lv_nmos\\\\[ids\\\\])  0]]
gm/ID = [to_eng [xschem raw value \\@n.xm1.nsg13_lv_nmos\\\\[gm\\\\]  0]/[xschem raw value i(\\@n.xm1.nsg13_lv_nmos\\\\[ids\\\\])  0]]
gamma = [to_eng [expr [xschem raw value \\@n.xm1.nsg13_lv_nmos\\\\[sid\\\\]  0]/[xschem raw value \\@n.xm1.nsg13_lv_nmos\\\\[gm\\\\]  0]/4/1.38e-23/300 ]]
)} 540 -620 0 0 0.3 0.3 {floater=1}
N 530 -390 530 -370 {
lab=d}
N 410 -220 410 -190 {
lab=0}
N 720 -220 720 -190 {
lab=0}
N 630 -220 630 -190 {
lab=0}
N 530 -310 530 -190 {
lab=0}
N 630 -340 630 -280 {
lab=b}
N 410 -340 410 -280 {
lab=g}
N 410 -340 490 -340 {
lab=g}
N 530 -340 630 -340 {
lab=b}
N 530 -390 720 -390 {
lab=d}
N 720 -390 720 -280 {
lab=d}
N 800 -220 800 -190 {
lab=0}
N 800 -320 800 -280 {
lab=n}
N 720 -190 800 -190 {lab=0}
N 630 -190 720 -190 {lab=0}
N 530 -190 630 -190 {lab=0}
N 410 -190 530 -190 {lab=0}
C {devices/vsource.sym} 410 -250 0 0 {name=vg value="DC 0.6 AC 1" savecurrent=false}
C {devices/vsource.sym} 720 -250 0 0 {name=vd value=0.6 savecurrent=false}
C {devices/vsource.sym} 630 -250 0 1 {name=vb value=0 savecurrent=false}
C {devices/lab_wire.sym} 460 -340 0 0 {name=p1 sig_type=std_logic lab=g}
C {devices/lab_wire.sym} 630 -390 0 0 {name=p2 sig_type=std_logic lab=d}
C {devices/lab_wire.sym} 630 -340 0 0 {name=p3 sig_type=std_logic lab=b}
C {devices/code_shown.sym} 0 -690 0 0 {name=COMMANDS1 only_toplevel=false
value="
.param wx=5u lx=0.13u
.save all
.save @n.xm1.nsg13_lv_nmos[sfl]
.save @n.xm1.nsg13_lv_nmos[sid]
.save @n.xm1.nsg13_lv_nmos[gm]
.save @n.xm1.nsg13_lv_nmos[ids]

.control
set sqrnoise
noise v(n) vg dec 1 1 1e11 1
write noisetest_sg13_lv_nmos.raw noise1.all
setplot noise1
display
print onoise_n.xm1.nsg13_lv_nmos_flicker
print onoise_n.xm1.nsg13_lv_nmos_idid
print onoise_n.xm1.nsg13_lv_nmos_igig
op
print @n.xm1.nsg13_lv_nmos[sfl]
print @n.xm1.nsg13_lv_nmos[sid]
.endc
"}
C {devices/title.sym} 160 -40 0 0 {name=l5 author="Boris Murmann"}
C {devices/launcher.sym} 510 -720 0 0 {name=h3
descr="save, netlist & simulate"
tclcommand="xschem save; xschem netlist; xschem simulate"
value="
.param wx=5 lx=0.15 vbx=0
.save all
.save @m.xm1.msky130_fd_pr__nfet_01v8_lvt[gm]
.save @m.xm1.msky130_fd_pr__nfet_01v8_lvt[id]

.control
noise v(n) vg dec 10 1 1e11 1
dc vg 0.5 1 0.5
noise v(n) vg lin  1 1 1 1
echo $plots
*write noisetest_nfet_01v8_lvt.raw noise1.all
write noisetest_nfet_01v8_lvt.raw dc2.all noise1.all
wrdata noisetest_nfet_01v8_lvt.txt dc2.all noise1.all

setplot noise3
print onoise_spectrum
print onoise.m.xm1.msky130_fd_pr__nfet_01v8_lvt.1overf
print onoise.m.xm1.msky130_fd_pr__nfet_01v8_lvt.id
.endc
"}
C {devices/ccvs.sym} 800 -250 0 0 {name=Hn vnam=vd value=1}
C {devices/lab_wire.sym} 800 -320 0 0 {name=p4 sig_type=std_logic lab=n}
C {devices/launcher.sym} 510 -680 0 0 {name=h27
descr="load noise" 
tclcommand="
xschem raw_read $netlist_dir/[file tail [file rootname [xschem get current_name]]].raw noise; set show_hidden_texts 1 

"
}
C {devices/code_shown.sym} 50 -140 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib $::SG13G2_MODELS/cornerMOSlv.lib mos_tt"}
C {sg13g2_pr/sg13_lv_nmos.sym} 510 -340 2 1 {name=M1
l=\{lx\}
w=\{wx\}
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {devices/lab_wire.sym} 460 -190 0 0 {name=p5 sig_type=std_logic lab=0}
