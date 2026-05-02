<Qucs Schematic 25.2.0>
<Properties>
  <View=-155,-259,1206,487,0.887399,0,0>
  <Grid=10,10,1>
  <DataSet=4_5_Prescaler.dat>
  <DataDisplay=4_5_Prescaler.dpl>
  <OpenDisplay=0>
  <Script=4_5_Prescaler.m>
  <RunScript=0>
  <showFrame=0>
  <FrameText0=Title>
  <FrameText1=Drawn By:>
  <FrameText2=Date:>
  <FrameText3=Revision:>
</Properties>
<Symbol>
</Symbol>
<Components>
  <Lib Y1 1 390 240 20 44 0 0 "Digital_XSPICE" 0 "d_D_FF" 0 "1e-10" 0 "1e-10" 0 "1e-10" 0 "0" 0 "1e-10" 0 "1e-10" 0>
  <Lib Y2 1 550 240 20 44 0 0 "Digital_XSPICE" 0 "d_D_FF" 0 "1e-10" 0 "1e-10" 0 "1e-10" 0 "0" 0 "1e-10" 0 "1e-10" 0>
  <Lib Y3 1 710 240 20 44 0 0 "Digital_XSPICE" 0 "d_D_FF" 0 "1e-10" 0 "1e-10" 0 "1e-10" 0 "0" 0 "1e-10" 0 "1e-10" 0>
  <Lib Y4 1 280 220 10 14 0 0 "Digital_XSPICE" 0 "d_AND2" 0 "1e-10" 0 "1e-10" 0 "0.5e-12" 0>
  <Lib Y5 1 190 230 10 14 0 0 "Digital_XSPICE" 0 "d_OR2" 0 "1e-10" 0 "1e-10" 0 "0.5e-12" 0>
  <Lib Y6 5 390 330 -35 -20 0 1 "Digital_AUX" 0 "Logic_zero" 0>
  <Lib Y7 5 550 330 -35 -20 0 1 "Digital_AUX" 0 "Logic_zero" 0>
  <Lib Y8 5 710 330 -35 -20 0 1 "Digital_AUX" 0 "Logic_zero" 0>
  <Lib Y9 5 390 150 35 -10 0 3 "Digital_AUX" 0 "Logic_zero" 0>
  <Lib Y10 5 550 150 35 -10 0 3 "Digital_AUX" 0 "Logic_zero" 0>
  <Lib Y11 5 710 150 35 -10 0 3 "Digital_AUX" 0 "Logic_zero" 0>
  <Lib XS1 5 250 380 -20 14 0 0 "Digital_AUX" 0 "ADC_bridge" 0 "0.5" 0 "0.5" 0 "1e-9" 0 "1e-9" 0>
  <Lib CLK1 1 100 380 14 25 0 0 "Digital_AUX" 0 "Clock" 0 "1K" 1 "1" 0 "0" 0 "0.1ns" 0 "0" 0>
  <GND * 1 100 420 0 0 0 0>
  <Lib XS2 5 880 220 -20 14 0 0 "Digital_AUX" 0 "DAC_bridge" 0 "0" 0 "1" 0 "0.5" 0 "1e-12" 0 "1e-9" 0 "1e-9" 0>
  <Lib MC 1 100 240 -10 -35 0 0 "Digital_AUX" 0 "Logic_zero" 0>
  <.TR TR1 1 840 290 0 56 0 0 "lin" 1 "0" 1 "7 ms" 1 "200" 0 "Trapezoidal" 0 "2" 0 "1 ns" 0 "1e-16" 0 "150" 0 "0.001" 0 "1 pA" 0 "1 uV" 0 "26.85" 0 "1e-3" 0 "1e-6" 0 "1" 0 "CroutLU" 0 "no" 0 "yes" 0 "0" 0>
</Components>
<Wires>
  <440 260 470 260 "" 0 0 0 "">
  <470 220 470 260 "" 0 0 0 "">
  <470 220 500 220 "" 0 0 0 "">
  <600 220 630 220 "" 0 0 0 "">
  <310 220 340 220 "" 0 0 0 "">
  <340 260 340 380 "" 0 0 0 "">
  <340 380 500 380 "" 0 0 0 "">
  <500 260 500 380 "" 0 0 0 "">
  <500 380 660 380 "" 0 0 0 "">
  <660 260 660 380 "" 0 0 0 "">
  <130 240 160 240 "" 0 0 0 "">
  <310 380 340 380 "" 0 0 0 "">
  <760 220 790 220 "" 0 0 0 "">
  <790 100 790 220 "" 0 0 0 "">
  <160 100 160 220 "" 0 0 0 "">
  <160 100 790 100 "" 0 0 0 "">
  <220 230 250 230 "" 0 0 0 "">
  <250 70 250 210 "" 0 0 0 "">
  <250 70 630 70 "" 0 0 0 "">
  <630 220 660 220 "" 0 0 0 "">
  <630 70 630 220 "" 0 0 0 "">
  <790 220 820 220 "" 0 0 0 "">
  <140 380 190 380 "in" 180 350 11 "">
  <940 220 940 220 "out" 970 190 0 "">
</Wires>
<Diagrams>
  <Rect 100 10 850 89 3 #c0c0c0 1 00 1 0 0.2 1 1 -0.1 0.5 1.1 1 -0.1 0.5 1.1 315 0 225 1 0 0 "" "" "">
	<"ngspice/tran.v(out)" #ff0000 0 3 0 0 0>
  </Rect>
  <Rect 100 -130 850 89 3 #c0c0c0 1 00 1 0 0.0005 0.01 1 -0.1 1 1.1 1 -1 2 1 315 0 225 1 0 0 "" "" "">
	<"ngspice/tran.v(in)" #0000ff 0 3 0 0 0>
  </Rect>
</Diagrams>
<Paintings>
</Paintings>
