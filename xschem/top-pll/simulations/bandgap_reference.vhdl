-- sch_path: /foss/designs/frac-n-pll-vco-unic_cass/schematic/bgr/bandgap_reference.sch
entity bandgap_reference is
port(
  VBG : out std_logic ;
  v+ : inout std_logic ;
  v- : inout std_logic ;
  Vo1 : inout std_logic
);
end bandgap_reference ;

architecture arch_bandgap_reference of bandgap_reference is

component two_stage_OTA 
port (
  vdd : inout std_logic ;
  iout : inout std_logic ;
  v+ : inout std_logic ;
  v- : inout std_logic ;
  vout : inout std_logic ;
  vss : inout std_logic
);
end component ;


signal vdd : std_logic ;
signal net1 : std_logic ;
signal net2 : std_logic ;
signal net3 : std_logic ;
signal net4 : std_logic ;
signal GND : std_logic ;
begin
M8 : sg13_lv_nmos
generic map (
   l => 1.0e-05 ,
   w => 1.5e-07 ,
   ng => 1 ,
   m => 1 ,
   model => sg13_lv_nmos ,
   spiceprefix => X
)
port map (
   D => GND ,
   G => v- ,
   S => net1 ,
   B => GND
);

M6 : sg13_lv_pmos
generic map (
   l => 1.0e-06 ,
   w => 1.0e-06 ,
   ng => 1 ,
   m => 1 ,
   model => sg13_lv_pmos ,
   spiceprefix => X
)
port map (
   D => net1 ,
   G => net1 ,
   S => vdd ,
   B => vdd
);

M7 : sg13_lv_pmos
generic map (
   l => 1.0e-06 ,
   w => 1.0e-06 ,
   ng => 1 ,
   m => 1 ,
   model => sg13_lv_pmos ,
   spiceprefix => X
)
port map (
   D => net2 ,
   G => net1 ,
   S => vdd ,
   B => vdd
);

M9 : sg13_lv_pmos
generic map (
   l => 4.0e-06 ,
   w => 2.0e-07 ,
   ng => 1 ,
   m => 1 ,
   model => sg13_lv_pmos ,
   spiceprefix => X
)
port map (
   D => v- ,
   G => net2 ,
   S => vdd ,
   B => vdd
);

V1 : vsource
generic map (
   value => PULSE(0 1.2 0 1 0 1 2) ,
   savecurrent => false
)
port map (
   p => vdd ,
   m => GND
);

M1 : sg13_lv_nmos
generic map (
   l => 5.0e-06 ,
   w => 7.14e-06 ,
   ng => 4 ,
   m => 1 ,
   model => sg13_lv_nmos ,
   spiceprefix => X
)
port map (
   D => GND ,
   G => v+ ,
   S => v- ,
   B => GND
);

M2 : sg13_lv_nmos
generic map (
   l => 5.0e-06 ,
   w => 2.1e-05 ,
   ng => 8 ,
   m => 1 ,
   model => sg13_lv_nmos ,
   spiceprefix => X
)
port map (
   D => GND ,
   G => net4 ,
   S => net4 ,
   B => GND
);

M3 : sg13_lv_pmos
generic map (
   l => 5.0e-06 ,
   w => 1.5e-05 ,
   ng => 8 ,
   m => 1 ,
   model => sg13_lv_pmos ,
   spiceprefix => X
)
port map (
   D => v- ,
   G => Vo1 ,
   S => vdd ,
   B => vdd
);

M4 : sg13_lv_pmos
generic map (
   l => 5.0e-06 ,
   w => 1.5e-05 ,
   ng => 8 ,
   m => 1 ,
   model => sg13_lv_pmos ,
   spiceprefix => X
)
port map (
   D => v+ ,
   G => Vo1 ,
   S => vdd ,
   B => vdd
);

M5 : sg13_lv_pmos
generic map (
   l => 5.0e-06 ,
   w => 1.6e-05 ,
   ng => 8 ,
   m => 1 ,
   model => sg13_lv_pmos ,
   spiceprefix => X
)
port map (
   D => VBG ,
   G => Vo1 ,
   S => vdd ,
   B => vdd
);

C3 : cap_cmim
generic map (
   model => cap_cmim ,
   w => 72.965E-6 ,
   l => 72.965E-6 ,
   m => 1 ,
   spiceprefix => X
)
port map (
   c0 => VBG ,
   c1 => GND
);

R3 : rppd
generic map (
   w => 0.5E-6 ,
   l => 194.345E-6 ,
   model => rppd ,
   spiceprefix => X ,
   b => 0 ,
   m => 1
)
port map (
   P => v+ ,
   M => net4
);

R1 : rppd
generic map (
   w => 0.6E-6 ,
   l => 194.345E-6 ,
   model => rppd ,
   spiceprefix => X ,
   b => 0 ,
   m => 1
)
port map (
   P => v+ ,
   M => GND
);

R2 : rppd
generic map (
   w => 0.5E-6 ,
   l => 192.395E-6 ,
   model => rppd ,
   spiceprefix => X ,
   b => 0 ,
   m => 1
)
port map (
   P => VBG ,
   M => GND
);

C1 : cap_cmim
generic map (
   model => cap_cmim ,
   w => 18.195E-6 ,
   l => 18.195E-6 ,
   m => 1 ,
   spiceprefix => X
)
port map (
   c0 => net2 ,
   c1 => GND
);

x1 : two_stage_OTA
port map (
   vdd => vdd ,
   iout => net3 ,
   v+ => v+ ,
   v- => v- ,
   vout => Vo1 ,
   vss => GND
);

R4 : rppd
generic map (
   w => 0.5E-6 ,
   l => 15.0e-6 ,
   model => rppd ,
   spiceprefix => X ,
   b => 0 ,
   m => 1
)
port map (
   P => net3 ,
   M => GND
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

end arch_bandgap_reference ;


-- expanding   symbol:  two_stage_OTA.sym # of pins=6
-- sym_path: /foss/designs/frac-n-pll-vco-unic_cass/schematic/current_source/two_stage_OTA.sym
-- sch_path: /foss/designs/frac-n-pll-vco-unic_cass/schematic/current_source/two_stage_OTA.sch
entity two_stage_OTA is
port (
  vdd : inout std_logic ;
  iout : inout std_logic ;
  v+ : inout std_logic ;
  v- : inout std_logic ;
  vout : inout std_logic ;
  vss : inout std_logic
);
end two_stage_OTA ;

architecture arch_two_stage_OTA of two_stage_OTA is


signal net1 : std_logic ;
signal net2 : std_logic ;
signal net3 : std_logic ;
begin
M4 : sg13_lv_nmos
generic map (
   l => 9.75e-06 ,
   w => 7.2e-07 ,
   ng => 1 ,
   m => 1 ,
   model => sg13_lv_nmos ,
   spiceprefix => X
)
port map (
   D => vss ,
   G => net1 ,
   S => net3 ,
   B => vss
);

M3 : sg13_lv_nmos
generic map (
   l => 9.75e-06 ,
   w => 7.2e-07 ,
   ng => 1 ,
   m => 1 ,
   model => sg13_lv_nmos ,
   spiceprefix => X
)
port map (
   D => vss ,
   G => net1 ,
   S => net1 ,
   B => vss
);

M1 : sg13_lv_pmos
generic map (
   l => 3.7e-06 ,
   w => 3.64e-06 ,
   ng => 1 ,
   m => 2 ,
   model => sg13_lv_pmos ,
   spiceprefix => X
)
port map (
   D => net1 ,
   G => v- ,
   S => net2 ,
   B => vdd
);

M2 : sg13_lv_pmos
generic map (
   l => 3.7e-06 ,
   w => 3.64e-06 ,
   ng => 1 ,
   m => 2 ,
   model => sg13_lv_pmos ,
   spiceprefix => X
)
port map (
   D => net3 ,
   G => v+ ,
   S => net2 ,
   B => vdd
);

M5 : sg13_lv_pmos
generic map (
   l => 1.95e-06 ,
   w => 5.3e-06 ,
   ng => 1 ,
   m => 1 ,
   model => sg13_lv_pmos ,
   spiceprefix => X
)
port map (
   D => net2 ,
   G => iout ,
   S => vdd ,
   B => vdd
);

M7 : sg13_lv_pmos
generic map (
   l => 2.08e-06 ,
   w => 7.5e-05 ,
   ng => 8 ,
   m => 1 ,
   model => sg13_lv_pmos ,
   spiceprefix => X
)
port map (
   D => vout ,
   G => iout ,
   S => vdd ,
   B => vdd
);

M6 : sg13_lv_nmos
generic map (
   l => 9.75e-06 ,
   w => 2.88e-05 ,
   ng => 4 ,
   m => 1 ,
   model => sg13_lv_nmos ,
   spiceprefix => X
)
port map (
   D => vss ,
   G => net3 ,
   S => vout ,
   B => vss
);

M9 : sg13_lv_pmos
generic map (
   l => 2.08e-06 ,
   w => 7.5e-05 ,
   ng => 8 ,
   m => 1 ,
   model => sg13_lv_pmos ,
   spiceprefix => X
)
port map (
   D => iout ,
   G => iout ,
   S => vdd ,
   B => vdd
);

C2 : cap_cmim
generic map (
   model => cap_cmim ,
   w => 22.295E-6 ,
   l => 22.295E-6 ,
   m => 1 ,
   spiceprefix => X
)
port map (
   c0 => net3 ,
   c1 => vout
);

end arch_two_stage_OTA ;

