* BEGIN ANSOFT HEADER
* node 1    Port1
* node 2    Port2
*  Project: Feb_01st
*   Format: HSPICE
*   Topckt: s2pfot2port_sp
*     Date: Tue Feb 10 02:16:49 2026
*    Notes: Frequency range: 1.5e+009 to 3.5e+009 Hz, 41 points
*         : Maximum number of poles: 10000
*         : S-Matrix fitting error tolerance: 0.005
*         : Causality check tolerance: auto
*         : Passivity enforcement: off
*         : Causality enforcement: off
*         : Fitting method: TWA
*         : Matrix fitting: By entire matrix
*         : Ensure Z-parameter accuracy: on
*         : Relative error control: off
*         : Common ground option: on
*         : Final fitting error: 0.000468468
*         : Final model order: 6
* END ANSOFT HEADER

.subckt s2pfot2port_sp 1 2
Vam1 1 n2 dc 0
Rport1 n2 0 50 noise=0
Vam2 2 n4 dc 0
Rport2 n4 0 50 noise=0

Fi1 0 ni1 Vam1 50
Gi1 0 ni1 1 0 1
Rt1 ni1 0 1 noise=0
Fi2 0 ni2 Vam2 50
Gi2 0 ni2 2 0 1
Rt2 ni2 0 1 noise=0

Ca1 ns1 0 1e-012
Ra1 ns1 0 362.701960104 noise=0
Ca2 ns2 0 1e-012
Ra2 ns2 0 29.5155442666 noise=0
Ca3 ns3 0 1e-012
Ra3 ns3 0 5.63954877535 noise=0
Ca4 ns4 0 1e-012
Ra4 ns4 0 362.701960104 noise=0
Ca5 ns5 0 1e-012
Ra5 ns5 0 29.5155442666 noise=0
Ca6 ns6 0 1e-012
Ra6 ns6 0 5.63954877535 noise=0

Gb1_1 ns1 0 ni1 0 0.00275708463145
Gb2_1 ns2 0 ni1 0 0.0338804526512
Gb3_1 ns3 0 ni1 0 0.177319150846
Gb4_2 ns4 0 ni2 0 0.00275708463145
Gb5_2 ns5 0 ni2 0 0.0338804526512
Gb6_2 ns6 0 ni2 0 0.177319150846

Gc1_1 0 n2 ns1 0 0.000172315852641
Gc1_2 0 n2 ns2 0 0.0323026683703
Gc1_3 0 n2 ns3 0 -0.0512954847424
Gc1_4 0 n2 ns4 0 -0.000828010157737
Gc1_5 0 n2 ns5 0 -0.0318186332309
Gc1_6 0 n2 ns6 0 0.0348303622513
Gd1_1 0 n2 ni1 0 -0.0186641975326
Gd1_2 0 n2 ni2 0 0.0221135452619
Gc2_1 0 n4 ns1 0 -0.000828010157737
Gc2_2 0 n4 ns2 0 -0.0318186332309
Gc2_3 0 n4 ns3 0 0.0348303622513
Gc2_4 0 n4 ns4 0 0.00015157199959
Gc2_5 0 n4 ns5 0 0.0322647638087
Gc2_6 0 n4 ns6 0 -0.0507007122742
Gd2_1 0 n4 ni1 0 0.0221135452619
Gd2_2 0 n4 ni2 0 -0.0181141855004
.ends s2pfot2port_sp
