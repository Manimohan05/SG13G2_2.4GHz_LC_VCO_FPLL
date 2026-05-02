-- sch_path: /home/designer/shared/frac-n-pll-vco-unic_cass/xschem/lc-vco/LC_VCO_tb.sch
entity LC_VCO_tb is
port(
  OUT : out std_logic ;
  VCTRL :  in std_logic
);
end LC_VCO_tb ;

architecture arch_LC_VCO_tb of LC_VCO_tb is

component LC_VCO 
port (
  VDD : inout std_logic ;
  VCTRL : in std_logic ;
  GND : inout std_logic ;
  FOUT : out std_logic ;
  VBGR : in std_logic
);
end component ;


signal VDD : std_logic ;
signal net1 : std_logic ;
signal GND : std_logic ;
begin
V1 : vsource
generic map (
   value => PULSE(0 1.2 0 1u 0 1s 2s) ,
   savecurrent => false
)
port map (
   p => VDD ,
   m => GND
);

Vup : vsource
generic map (
   value => PULSE(0.4 0.8 1u 90n 1n 1s 2s) ,
   savecurrent => false
)
port map (
   p => VCTRL ,
   m => GND
);

V2 : vsource
generic map (
   value => 1.1 ,
   savecurrent => false
)
port map (
   p => VCTRL ,
   m => GND
);

Vdn : vsource
generic map (
   value => PULSE(0.5 0.0 10n 90n 1n 1s 2s) ,
   savecurrent => false
)
port map (
   p => VCTRL ,
   m => GND
);

x1 : LC_VCO
port map (
   VDD => VDD ,
   VCTRL => VCTRL ,
   GND => GND ,
   FOUT => OUT ,
   VBGR => net1
);

V3 : vsource
generic map (
   value => PULSE(0 1.2 0 1u 0 1s 2s) ,
   savecurrent => false
)
port map (
   p => net1 ,
   m => GND
);


.param temp = 27
.options method=gear rshunt=1.0e12

.control

* Save required signals
save v(VCTRL) v(OUT) v(x1.Vx) v(x1.OUTp) v(VBGR)

* Long transient simulation
tran 10p 2u

* Save raw waveform
write LC_VCO_standalone_tran.raw

* Plot transient waveform
let vout = v(OUT)
plot v(VCTRL) v(x1.Vx) v(OUT) v(x1.OUTp) v(VBGR)
plot v(VBGR)

* Plot steady-state waveform
plot v(VCTRL) v(x1.Vx) v(OUT) v(x1.OUTp) v(VBGR) xlimit 4000n 4005n

* FFT analysis
setplot tran1
linearize vout
set specwindow=blackman
fft vout

* Plot FFT spectrum
let power_out_db = db(vout)
plot power_out_db xlimit 2.34G 2.54G ylimit -200 0

* Find the maximum magnitude value between 2G and 3G
meas sp max_power_out_db max power_out_db FROM=2G TO=3G

* Save FFT spectrum as raw file
write LC_VCO_fft.raw

* Save FFT data
wrdata fft_output_standalone.txt frequency power_out_db

* Save waveform for external processing
wrdata vco_waveform_standalone.txt power_out_db

.endc


.param temp=27
.control
save all 
op
write LC_VCO_tb.raw
.endc


.include 4nH_INDUCTOR.spice


.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ

end arch_LC_VCO_tb ;


-- expanding   symbol:  /home/designer/shared/frac-n-pll-vco-unic_cass/xschem/lc-vco/LC_VCO.sym # of pins=5
-- sym_path: /home/designer/shared/frac-n-pll-vco-unic_cass/xschem/lc-vco/LC_VCO.sym
-- sch_path: /home/designer/shared/frac-n-pll-vco-unic_cass/xschem/lc-vco/LC_VCO.sch
entity LC_VCO is
port (
  VDD : inout std_logic ;
  VCTRL : in std_logic ;
  GND : inout std_logic ;
  FOUT : out std_logic ;
  VBGR : in std_logic
);
end LC_VCO ;

architecture arch_LC_VCO of LC_VCO is

component 4nH_INDUCTOR 
port (
  p1 : inout std_logic ;
  p2 : inout std_logic
);
end component ;


signal OUTn : std_logic ;
signal OUTp : std_logic ;
signal Vgs : std_logic ;
signal Vx : std_logic ;
signal net1 : std_logic ;
begin
M5 : sg13_lv_nmos
generic map (
   l => 1.0e-06 ,
   w => 0.000384 ,
   ng => 48 ,
   m => 1 ,
   model => sg13_lv_nmos ,
   spiceprefix => X
)
port map (
   D => Vx ,
   G => Vgs ,
   S => GND ,
   B => GND
);

M4 : sg13_lv_pmos
generic map (
   l => 1.3e-07 ,
   w => 3.6e-05 ,
   ng => 5 ,
   m => 1 ,
   model => sg13_lv_pmos ,
   spiceprefix => X
)
port map (
   D => OUTp ,
   G => OUTn ,
   S => VDD ,
   B => VDD
);

M3 : sg13_lv_pmos
generic map (
   l => 1.3e-07 ,
   w => 3.6e-05 ,
   ng => 5 ,
   m => 1 ,
   model => sg13_lv_pmos ,
   spiceprefix => X
)
port map (
   D => OUTn ,
   G => OUTp ,
   S => VDD ,
   B => VDD
);

M2 : sg13_lv_nmos
generic map (
   l => 1.3e-07 ,
   w => 2.2e-05 ,
   ng => 3 ,
   m => 1 ,
   model => sg13_lv_nmos ,
   spiceprefix => X
)
port map (
   D => OUTp ,
   G => OUTn ,
   S => Vx ,
   B => GND
);

M1 : sg13_lv_nmos
generic map (
   l => 1.3e-07 ,
   w => 2.2e-05 ,
   ng => 3 ,
   m => 1 ,
   model => sg13_lv_nmos ,
   spiceprefix => X
)
port map (
   D => OUTn ,
   G => OUTp ,
   S => Vx ,
   B => GND
);

M6 : sg13_lv_nmos
generic map (
   l => 1.0e-06 ,
   w => 6.4e-05 ,
   ng => 8 ,
   m => 1 ,
   model => sg13_lv_nmos ,
   spiceprefix => X
)
port map (
   D => Vgs ,
   G => Vgs ,
   S => GND ,
   B => GND
);

C1 : cap_rfcmim
generic map (
   model => cap_rfcmim ,
   lvs_model => rfcmim ,
   w => 21.9E-6 ,
   l => 21.9E-6 ,
   wfeed => 10.0E-6 ,
   spiceprefix => X
)
port map (
   c0 => OUTn ,
   c1 => OUTp ,
   bn => GND
);

C3 : sg13_svaricap
generic map (
   model => sg13_hv_svaricap ,
   w => 9.74e-06 ,
   l => 8.0e-07 ,
   Nx => 7 ,
   spiceprefix => X
)
port map (
   G2 => OUTp ,
   bn => VCTRL ,
   G1 => OUTn ,
   NW => GND
);

C2 : sg13_svaricap
generic map (
   model => sg13_hv_svaricap ,
   w => 9.74e-06 ,
   l => 8.0e-07 ,
   Nx => 7 ,
   spiceprefix => X
)
port map (
   G2 => OUTp ,
   bn => VCTRL ,
   G1 => OUTn ,
   NW => GND
);

M7 : sg13_lv_pmos
generic map (
   l => 1.0e-06 ,
   w => 3.8e-05 ,
   ng => 5 ,
   m => 1 ,
   model => sg13_lv_pmos ,
   spiceprefix => X
)
port map (
   D => Vgs ,
   G => VBGR ,
   S => VDD ,
   B => VDD
);

M8 : sg13_lv_pmos
generic map (
   l => 1.3e-07 ,
   w => 1.5e-05 ,
   ng => 10 ,
   m => 1 ,
   model => sg13_lv_pmos ,
   spiceprefix => X
)
port map (
   D => FOUT ,
   G => OUTp ,
   S => VDD ,
   B => VDD
);

M9 : sg13_lv_nmos
generic map (
   l => 1.3e-07 ,
   w => 1.5e-06 ,
   ng => 1 ,
   m => 1 ,
   model => sg13_lv_nmos ,
   spiceprefix => X
)
port map (
   D => FOUT ,
   G => OUTp ,
   S => GND ,
   B => GND
);

M10 : sg13_lv_pmos
generic map (
   l => 1.3e-07 ,
   w => 1.5e-05 ,
   ng => 10 ,
   m => 1 ,
   model => sg13_lv_pmos ,
   spiceprefix => X
)
port map (
   D => net1 ,
   G => OUTn ,
   S => VDD ,
   B => VDD
);

M11 : sg13_lv_nmos
generic map (
   l => 1.3e-07 ,
   w => 1.5e-06 ,
   ng => 1 ,
   m => 1 ,
   model => sg13_lv_nmos ,
   spiceprefix => X
)
port map (
   D => net1 ,
   G => OUTn ,
   S => GND ,
   B => GND
);

x1 : 4nH_INDUCTOR
port map (
   p1 => OUTn ,
   p2 => OUTp
);


.subckt 4nH_INDUCTOR 1 2
* LVS black-box stub only
* Full model is available in 4nH_INDUCTOR.spice
.ends

end arch_LC_VCO ;

