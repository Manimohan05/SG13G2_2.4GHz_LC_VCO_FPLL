* begin ansoft header
* node 1 Port1
* node 2 Port2
* 
* created by ElectronicsDesktop
* end ansoft header

.subckt Feb_01st_lfws 1 2 
rl1_2to1 2 3 143.53864963381
ls1_2to1 3 1 37.006630733346n
rs2_2to1 2 4 1.4704207271992
ls2_2to1 4 1 4.1691984192738n
rc1_1to0 1 5 1e-005
cs1_1to0 5 0 0.09579530317348p
rp_1to0 1 0 8990.9586905285
rc1_2to0 2 6 1e-005
cs1_2to0 6 0 0.090317930383159p
rp_2to0 2 0 9652.0127403247
.ends Feb_01st_lfws

