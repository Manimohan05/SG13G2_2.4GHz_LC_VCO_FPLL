// sch_path: /foss/designs/frac-n-pll-vco-unic_cass/schematic/bgr/bandgap_reference_tb.sch
module bandgap_reference_tb
(
  output wire VBG,
  inout wire v+,
  inout wire v-,
  inout wire Vo1
);
wire vdd ;
wire net1 ;
wire net2 ;
wire net3 ;
wire net4 ;
wire GND ;

sg13_lv_nmos
#(
.l ( 1e-05 ) ,
.w ( 1.5e-07 ) ,
.ng ( 1 ) ,
.m ( 1 ) ,
.model ( sg13_lv_nmos ) ,
.spiceprefix ( X )
)
M8 ( 
 .D( GND ),
 .G( v- ),
 .S( net1 ),
 .B( GND )
);


sg13_lv_pmos
#(
.l ( 1e-06 ) ,
.w ( 1e-06 ) ,
.ng ( 1 ) ,
.m ( 1 ) ,
.model ( sg13_lv_pmos ) ,
.spiceprefix ( X )
)
M6 ( 
 .D( net1 ),
 .G( net1 ),
 .S( vdd ),
 .B( vdd )
);


sg13_lv_pmos
#(
.l ( 1e-06 ) ,
.w ( 1e-06 ) ,
.ng ( 1 ) ,
.m ( 1 ) ,
.model ( sg13_lv_pmos ) ,
.spiceprefix ( X )
)
M7 ( 
 .D( net2 ),
 .G( net1 ),
 .S( vdd ),
 .B( vdd )
);


sg13_lv_pmos
#(
.l ( 4e-06 ) ,
.w ( 2e-07 ) ,
.ng ( 1 ) ,
.m ( 1 ) ,
.model ( sg13_lv_pmos ) ,
.spiceprefix ( X )
)
M9 ( 
 .D( v- ),
 .G( net2 ),
 .S( vdd ),
 .B( vdd )
);


vsource
#(
.value ( "PULSE(0 ) ,
.savecurrent ( false )
)
V1 ( 
 .p( vdd ),
 .m( GND )
);


sg13_lv_nmos
#(
.l ( 5e-06 ) ,
.w ( 7.14e-06 ) ,
.ng ( 4 ) ,
.m ( 1 ) ,
.model ( sg13_lv_nmos ) ,
.spiceprefix ( X )
)
M1 ( 
 .D( GND ),
 .G( v+ ),
 .S( v- ),
 .B( GND )
);


sg13_lv_nmos
#(
.l ( 5e-06 ) ,
.w ( 2.1e-05 ) ,
.ng ( 8 ) ,
.m ( 1 ) ,
.model ( sg13_lv_nmos ) ,
.spiceprefix ( X )
)
M2 ( 
 .D( GND ),
 .G( net4 ),
 .S( net4 ),
 .B( GND )
);


sg13_lv_pmos
#(
.l ( 5e-06 ) ,
.w ( 1.5e-05 ) ,
.ng ( 8 ) ,
.m ( 1 ) ,
.model ( sg13_lv_pmos ) ,
.spiceprefix ( X )
)
M3 ( 
 .D( v- ),
 .G( Vo1 ),
 .S( vdd ),
 .B( vdd )
);


sg13_lv_pmos
#(
.l ( 5e-06 ) ,
.w ( 1.5e-05 ) ,
.ng ( 8 ) ,
.m ( 1 ) ,
.model ( sg13_lv_pmos ) ,
.spiceprefix ( X )
)
M4 ( 
 .D( v+ ),
 .G( Vo1 ),
 .S( vdd ),
 .B( vdd )
);


sg13_lv_pmos
#(
.l ( 5e-06 ) ,
.w ( 1.6e-05 ) ,
.ng ( 8 ) ,
.m ( 1 ) ,
.model ( sg13_lv_pmos ) ,
.spiceprefix ( X )
)
M5 ( 
 .D( VBG ),
 .G( Vo1 ),
 .S( vdd ),
 .B( vdd )
);


cap_cmim
#(
.model ( cap_cmim ) ,
.w ( 7.2965e-05 ) ,
.l ( 7.2965e-05 ) ,
.m ( 1 ) ,
.spiceprefix ( X )
)
C3 ( 
 .c0( VBG ),
 .c1( GND )
);


rppd
#(
.w ( 5e-07 ) ,
.l ( 0.000194345 ) ,
.model ( rppd ) ,
.spiceprefix ( X ) ,
.b ( 0 ) ,
.m ( 1 )
)
R3 ( 
 .P( v+ ),
 .M( net4 )
);


rppd
#(
.w ( 6e-07 ) ,
.l ( 0.000194345 ) ,
.model ( rppd ) ,
.spiceprefix ( X ) ,
.b ( 0 ) ,
.m ( 1 )
)
R1 ( 
 .P( v+ ),
 .M( GND )
);


rppd
#(
.w ( 5e-07 ) ,
.l ( 0.000192395 ) ,
.model ( rppd ) ,
.spiceprefix ( X ) ,
.b ( 0 ) ,
.m ( 1 )
)
R2 ( 
 .P( VBG ),
 .M( GND )
);


cap_cmim
#(
.model ( cap_cmim ) ,
.w ( 1.8195e-05 ) ,
.l ( 1.8195e-05 ) ,
.m ( 1 ) ,
.spiceprefix ( X )
)
C1 ( 
 .c0( net2 ),
 .c1( GND )
);


two_stage_OTA
x1 ( 
 .vdd( vdd ),
 .iout( net3 ),
 .v+( v+ ),
 .v-( v- ),
 .vout( Vo1 ),
 .vss( GND )
);


rppd
#(
.w ( 5e-07 ) ,
.l ( 1.5e-05 ) ,
.model ( rppd ) ,
.spiceprefix ( X ) ,
.b ( 0 ) ,
.m ( 1 )
)
R4 ( 
 .P( net3 ),
 .M( GND )
);


.lib $::SG13G2_MODELS/cornerCAP.lib cap_typ
.lib $::SG13G2_MODELS/cornerRES.lib res_typ
.lib cornerMOSlv.lib mos_tt


.control
save all
alter V1 dc 1.2

op
print I(Vmeas)

dc TEMP 100 -50 -5
print I(Vmeas)

write bgr_temp.raw
.endc

.control
save all
tran 1m 2

print I(Vmeas)

write bandgap_transient.raw
.endc

endmodule

// expanding   symbol:  two_stage_OTA.sym # of pins=6
// sym_path: /foss/designs/frac-n-pll-vco-unic_cass/schematic/current_source/two_stage_OTA.sym
// sch_path: /foss/designs/frac-n-pll-vco-unic_cass/schematic/current_source/two_stage_OTA.sch
module two_stage_OTA
(
  inout wire vdd,
  inout wire iout,
  inout wire v+,
  inout wire v-,
  inout wire vout,
  inout wire vss
);
wire net1 ;
wire net2 ;
wire net3 ;


sg13_lv_nmos
#(
.l ( 9.75e-06 ) ,
.w ( 7.2e-07 ) ,
.ng ( 1 ) ,
.m ( 1 ) ,
.model ( sg13_lv_nmos ) ,
.spiceprefix ( X )
)
M4 ( 
 .D( vss ),
 .G( net1 ),
 .S( net3 ),
 .B( vss )
);


sg13_lv_nmos
#(
.l ( 9.75e-06 ) ,
.w ( 7.2e-07 ) ,
.ng ( 1 ) ,
.m ( 1 ) ,
.model ( sg13_lv_nmos ) ,
.spiceprefix ( X )
)
M3 ( 
 .D( vss ),
 .G( net1 ),
 .S( net1 ),
 .B( vss )
);


sg13_lv_pmos
#(
.l ( 3.7e-06 ) ,
.w ( 3.64e-06 ) ,
.ng ( 1 ) ,
.m ( 2 ) ,
.model ( sg13_lv_pmos ) ,
.spiceprefix ( X )
)
M1 ( 
 .D( net1 ),
 .G( v- ),
 .S( net2 ),
 .B( vdd )
);


sg13_lv_pmos
#(
.l ( 3.7e-06 ) ,
.w ( 3.64e-06 ) ,
.ng ( 1 ) ,
.m ( 2 ) ,
.model ( sg13_lv_pmos ) ,
.spiceprefix ( X )
)
M2 ( 
 .D( net3 ),
 .G( v+ ),
 .S( net2 ),
 .B( vdd )
);


sg13_lv_pmos
#(
.l ( 1.95e-06 ) ,
.w ( 5.3e-06 ) ,
.ng ( 1 ) ,
.m ( 1 ) ,
.model ( sg13_lv_pmos ) ,
.spiceprefix ( X )
)
M5 ( 
 .D( net2 ),
 .G( iout ),
 .S( vdd ),
 .B( vdd )
);


sg13_lv_pmos
#(
.l ( 2.08e-06 ) ,
.w ( 7.5e-05 ) ,
.ng ( 8 ) ,
.m ( 1 ) ,
.model ( sg13_lv_pmos ) ,
.spiceprefix ( X )
)
M7 ( 
 .D( vout ),
 .G( iout ),
 .S( vdd ),
 .B( vdd )
);


sg13_lv_nmos
#(
.l ( 9.75e-06 ) ,
.w ( 2.88e-05 ) ,
.ng ( 4 ) ,
.m ( 1 ) ,
.model ( sg13_lv_nmos ) ,
.spiceprefix ( X )
)
M6 ( 
 .D( vss ),
 .G( net3 ),
 .S( vout ),
 .B( vss )
);


sg13_lv_pmos
#(
.l ( 2.08e-06 ) ,
.w ( 7.5e-05 ) ,
.ng ( 8 ) ,
.m ( 1 ) ,
.model ( sg13_lv_pmos ) ,
.spiceprefix ( X )
)
M9 ( 
 .D( iout ),
 .G( iout ),
 .S( vdd ),
 .B( vdd )
);


cap_cmim
#(
.model ( cap_cmim ) ,
.w ( 2.2295e-05 ) ,
.l ( 2.2295e-05 ) ,
.m ( 1 ) ,
.spiceprefix ( X )
)
C2 ( 
 .c0( net3 ),
 .c1( vout )
);

endmodule
