<Qucs Schematic 25.2.0>
<Properties>
  <View=-297,-123,480,303,1.55399,0,0>
  <Grid=10,10,1>
  <DataSet=4n_ind_spar.dat>
  <DataDisplay=4n_ind_spar.dpl>
  <OpenDisplay=0>
  <Script=custom_ind_spar.m>
  <RunScript=0>
  <showFrame=0>
  <FrameText0=Title>
  <FrameText1=Drawn By:>
  <FrameText2=Date:>
  <FrameText3=Revision:>
</Properties>
<Symbol>
  <.ID -30 -76 SUB>
  <Line -40 30 90 0 #000080 2 1>
  <Line 50 30 0 -50 #000080 2 1>
  <Line -40 -20 90 0 #000080 2 1>
  <Line -40 30 0 -50 #000080 2 1>
</Symbol>
<Components>
  <SPICE X1 1 0 -20 -26 -63 0 0 "C:/Users/acham/QucsWorkspace/IHP_4nH_Inductor.spice" 1 "_net1,_net2" 0 "yes" 0 "none" 0 "" 0>
  <GND * 1 0 50 0 0 0 0>
  <GND * 1 -140 120 0 0 0 0>
  <GND * 1 140 120 0 0 0 0>
  <Pac P1 1 -140 50 -93 -26 1 1 "1" 1 "50 Ohm" 1 "0 dBm" 0 "1 MHz" 0 "26.85" 0 "true" 0>
  <Pac P2 1 140 50 18 -26 0 1 "2" 1 "50 Ohm" 1 "0 dBm" 0 "1 MHz" 0 "26.85" 0 "true" 0>
  <Eqn Eqn1 1 -40 140 -28 18 0 0 "Z=stoz(S)" 1 "zdiff=Z[1,1] - Z[1,2] - Z[2,1] + Z[2,2]" 1 "L_diff=1e9 * imag(zdiff) / (2 * pi * frequency)" 1 "Q_diff=imag(zdiff) / real(zdiff)" 1 "yes" 0>
  <.SP SP1 1 310 50 0 56 0 0 "lin" 1 "100 MHz" 1 "15 GHz" 1 "500" 1 "no" 0 "1" 0 "2" 0 "no" 0 "no" 0>
</Components>
<Wires>
  <0 10 0 50 "" 0 0 0 "">
  <-140 -20 -30 -20 "" 0 0 0 "">
  <-140 80 -140 120 "" 0 0 0 "">
  <140 80 140 120 "" 0 0 0 "">
  <-140 -20 -140 20 "" 0 0 0 "">
  <30 -20 140 -20 "" 0 0 0 "">
  <140 -20 140 20 "" 0 0 0 "">
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
</Paintings>
