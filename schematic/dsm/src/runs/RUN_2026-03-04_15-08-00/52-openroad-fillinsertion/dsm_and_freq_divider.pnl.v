module dsm_and_freq_divider (en,
    freq_in,
    freq_out,
    rst,
    sclk,
    sdata,
    VPWR,
    VGND);
 input en;
 input freq_in;
 output freq_out;
 input rst;
 input sclk;
 input sdata;
 inout VPWR;
 inout VGND;

 wire _000_;
 wire _001_;
 wire _002_;
 wire _003_;
 wire _004_;
 wire _005_;
 wire _006_;
 wire _007_;
 wire _008_;
 wire _009_;
 wire _010_;
 wire _011_;
 wire _012_;
 wire _013_;
 wire _014_;
 wire _015_;
 wire _016_;
 wire _017_;
 wire _018_;
 wire _019_;
 wire _020_;
 wire _021_;
 wire _022_;
 wire _023_;
 wire _024_;
 wire _025_;
 wire _026_;
 wire _027_;
 wire _028_;
 wire _029_;
 wire _030_;
 wire _031_;
 wire _032_;
 wire _033_;
 wire _034_;
 wire _035_;
 wire _036_;
 wire _037_;
 wire _038_;
 wire _039_;
 wire _040_;
 wire _041_;
 wire _042_;
 wire _043_;
 wire _044_;
 wire _045_;
 wire _046_;
 wire _047_;
 wire _048_;
 wire _049_;
 wire _050_;
 wire _051_;
 wire _052_;
 wire _053_;
 wire _054_;
 wire _055_;
 wire _056_;
 wire _057_;
 wire _058_;
 wire _059_;
 wire _060_;
 wire _061_;
 wire _062_;
 wire _063_;
 wire _064_;
 wire _065_;
 wire _066_;
 wire _067_;
 wire _068_;
 wire _069_;
 wire _070_;
 wire _071_;
 wire _072_;
 wire _073_;
 wire _074_;
 wire _075_;
 wire _076_;
 wire _077_;
 wire _078_;
 wire _079_;
 wire _080_;
 wire _081_;
 wire _082_;
 wire _083_;
 wire _084_;
 wire _085_;
 wire _086_;
 wire _087_;
 wire _088_;
 wire _089_;
 wire _090_;
 wire _091_;
 wire _092_;
 wire _093_;
 wire _094_;
 wire _095_;
 wire _096_;
 wire _097_;
 wire _098_;
 wire _099_;
 wire _100_;
 wire _101_;
 wire _102_;
 wire _103_;
 wire _104_;
 wire _105_;
 wire _106_;
 wire _107_;
 wire _108_;
 wire _109_;
 wire _110_;
 wire _111_;
 wire _112_;
 wire _113_;
 wire _114_;
 wire _115_;
 wire _116_;
 wire \data_word[0] ;
 wire \data_word[1] ;
 wire \data_word[2] ;
 wire \data_word[3] ;
 wire \data_word[4] ;
 wire \data_word[5] ;
 wire \data_word[6] ;
 wire \data_word[7] ;
 wire \data_word[8] ;
 wire net1;
 wire net4;
 wire net2;
 wire net3;
 wire \u_dsm.integrator[0] ;
 wire \u_dsm.integrator[1] ;
 wire \u_dsm.integrator[2] ;
 wire \u_dsm.integrator[3] ;
 wire \u_dsm.integrator[4] ;
 wire \u_dsm.integrator[5] ;
 wire \u_dsm.integrator[6] ;
 wire \u_dsm.integrator[7] ;
 wire \u_dsm.integrator[8] ;
 wire \uut.b ;
 wire \uut.c ;
 wire \uut.clk_jk ;
 wire \uut.d ;
 wire \uut.div4.dff1.d ;
 wire \uut.div4.dff1.q ;
 wire \uut.div4.dff2.d ;
 wire \uut.div4.dff2.q ;
 wire \uut.mod7.jk1.d_in ;
 wire \uut.mod7.jk2.d_in ;
 wire \uut.mod7.jk3.d_in ;
 wire \uut.out_stg.dff_out.d ;
 wire \uut.pre45.d1 ;
 wire \uut.pre45.d2 ;
 wire \uut.pre45.d3 ;
 wire \uut.pre45.ff1.q ;
 wire net5;
 wire net6;
 wire net7;
 wire net8;
 wire net9;
 wire net10;
 wire net11;
 wire clknet_0_sclk;
 wire clknet_1_0__leaf_sclk;
 wire clknet_1_1__leaf_sclk;

 sg13g2_decap_8 FILLER_0_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_106 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_113 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_120 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_127 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_134 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_14 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_141 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_148 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_155 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_0_162 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_0_166 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_21 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_28 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_35 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_42 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_49 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_56 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_63 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_7 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_0_70 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_0_74 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_78 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_85 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_92 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_0_99 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_10_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_10_102 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_10_109 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_10_116 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_10_123 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_10_134 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_10_138 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_10_14 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_10_147 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_10_154 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_10_161 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_10_165 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_10_21 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_10_25 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_10_52 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_10_59 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_10_66 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_10_7 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_10_81 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_10_88 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_10_95 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_11_102 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_11_109 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_11_116 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_11_120 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_11_166 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_11_19 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_11_26 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_11_33 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_11_4 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_11_40 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_11_47 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_11_51 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_11_60 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_11_67 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_11_74 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_11_8 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_11_81 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_11_88 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_11_95 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_12_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_12_107 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_12_165 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_12_35 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_12_4 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_12_49 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_12_53 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_12_63 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_12_70 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_13_104 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_13_111 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_13_118 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_13_136 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_13_142 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_13_149 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_13_156 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_13_163 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_13_34 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_13_36 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_13_45 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_13_62 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_13_69 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_13_76 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_13_83 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_13_90 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_13_97 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_14_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_14_107 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_14_114 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_14_121 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_14_127 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_14_134 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_14_141 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_14_148 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_14_155 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_14_162 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_14_166 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_14_47 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_14_49 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_14_54 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_14_58 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_14_65 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_14_7 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_104 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_111 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_118 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_125 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_132 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_139 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_14 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_146 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_153 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_160 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_21 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_28 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_35 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_42 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_49 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_56 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_15_63 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_69 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_7 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_76 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_83 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_90 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_15_97 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_16_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_16_106 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_16_113 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_16_117 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_16_127 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_16_161 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_16_165 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_16_19 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_16_26 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_16_33 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_16_37 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_16_7 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_16_71 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_16_78 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_16_85 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_16_92 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_16_99 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_17_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_17_104 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_17_108 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_17_112 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_17_117 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_17_151 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_17_158 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_17_165 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_17_39 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_17_45 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_17_52 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_17_94 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_18_101 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_18_130 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_18_134 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_18_162 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_18_166 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_18_50 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_18_54 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_18_64 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_19_116 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_19_123 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_19_130 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_19_137 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_19_144 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_19_151 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_19_158 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_19_165 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_19_19 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_19_26 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_19_4 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_19_41 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_19_48 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_19_55 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_19_62 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_19_69 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_19_76 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_19_8 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_19_83 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_1_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_1_11 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_1_111 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_1_118 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_1_125 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_1_132 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_1_139 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_1_146 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_1_153 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_1_160 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_1_39 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_1_46 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_1_66 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_1_7 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_1_74 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_1_87 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_1_94 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_104 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_111 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_118 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_125 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_132 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_139 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_14 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_146 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_153 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_160 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_21 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_28 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_35 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_42 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_49 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_56 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_63 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_7 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_70 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_77 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_84 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_20_91 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_20_97 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_2_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_2_114 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_2_127 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_2_136 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_2_140 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_2_144 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_2_151 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_2_158 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_2_162 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_2_2 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_2_46 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_2_48 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_3_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_3_107 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_3_114 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_3_120 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_3_165 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_3_46 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_3_53 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_3_57 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_3_63 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_3_67 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_3_7 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_3_84 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_3_91 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_3_98 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_100 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_107 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_114 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_4_121 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_127 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_134 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_141 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_148 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_155 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_4_162 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_4_166 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_23 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_30 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_37 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_44 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_51 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_58 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_65 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_4_7 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_72 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_79 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_86 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_4_9 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_4_93 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_102 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_109 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_5_116 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_5_122 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_129 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_136 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_14 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_143 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_150 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_157 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_5_164 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_5_166 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_21 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_53 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_60 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_67 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_7 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_74 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_81 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_88 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_5_95 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_6_106 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_6_113 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_6_138 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_6_145 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_6_152 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_6_157 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_6_164 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_6_166 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_6_19 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_6_26 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_6_33 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_6_4 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_6_40 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_6_47 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_6_54 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_6_61 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_6_68 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_6_77 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_6_8 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_6_84 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_6_89 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_6_96 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_7_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_7_100 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_7_116 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_7_118 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_7_123 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_7_125 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_7_131 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_7_135 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_7_166 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_7_37 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_7_45 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_7_52 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_7_80 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_7_87 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_7_91 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_7_96 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_8_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_8_116 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_8_123 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_8_130 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_8_134 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_8_166 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_8_37 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_8_39 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_8_48 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_8_64 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_8_66 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_8_72 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_9_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_9_100 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_9_107 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_9_114 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_9_121 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_9_128 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_9_135 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_9_145 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_9_152 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_9_159 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_9_166 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_9_19 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_9_26 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_9_33 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_9_40 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_9_47 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_9_67 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_9_69 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_9_7 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_9_79 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_9_86 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_8 FILLER_9_93 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_mux2_1 _117_ (.A0(\data_word[8] ),
    .A1(\data_word[7] ),
    .S(net1),
    .X(_044_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_mux2_1 _118_ (.A0(\data_word[7] ),
    .A1(\data_word[6] ),
    .S(net1),
    .X(_043_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_mux2_1 _119_ (.A0(\data_word[6] ),
    .A1(\data_word[5] ),
    .S(net1),
    .X(_042_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_mux2_1 _120_ (.A0(\data_word[5] ),
    .A1(\data_word[4] ),
    .S(net1),
    .X(_041_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_mux2_1 _121_ (.A0(\data_word[4] ),
    .A1(\data_word[3] ),
    .S(net1),
    .X(_040_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_mux2_1 _122_ (.A0(\data_word[3] ),
    .A1(\data_word[2] ),
    .S(net1),
    .X(_039_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_mux2_1 _123_ (.A0(\data_word[2] ),
    .A1(\data_word[1] ),
    .S(net1),
    .X(_038_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_mux2_1 _124_ (.A0(\data_word[1] ),
    .A1(\data_word[0] ),
    .S(net1),
    .X(_037_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_mux2_1 _125_ (.A0(\data_word[0] ),
    .A1(net3),
    .S(net1),
    .X(_036_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21oi_1 _126_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(\uut.d ),
    .A2(\uut.c ),
    .Y(\uut.mod7.jk1.d_in ),
    .B1(\uut.b ));
 sg13g2_nand2_1 _127_ (.Y(_113_),
    .A(\uut.d ),
    .B(\uut.c ),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_o21ai_1 _128_ (.B1(_113_),
    .VDD(VPWR),
    .Y(_114_),
    .VSS(VGND),
    .A1(\uut.c ),
    .A2(\uut.b ));
 sg13g2_a21oi_1 _129_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(\uut.c ),
    .A2(\uut.b ),
    .Y(\uut.mod7.jk2.d_in ),
    .B1(_114_));
 sg13g2_a21oi_1 _130_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(\uut.c ),
    .A2(\uut.b ),
    .Y(_115_),
    .B1(\uut.d ));
 sg13g2_a21oi_1 _131_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(\uut.d ),
    .A2(\uut.c ),
    .Y(\uut.mod7.jk3.d_in ),
    .B1(_115_));
 sg13g2_nor2_1 _132_ (.A(\uut.d ),
    .B(\uut.c ),
    .Y(_116_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nor3_1 _133_ (.A(\uut.b ),
    .B(\uut.clk_jk ),
    .C(_116_),
    .Y(_045_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_o21ai_1 _134_ (.B1(_045_),
    .VDD(VPWR),
    .Y(_046_),
    .VSS(VGND),
    .A1(net6),
    .A2(_113_));
 sg13g2_and2_1 _135_ (.A(\uut.pre45.d3 ),
    .B(_046_),
    .X(\uut.pre45.d1 ),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xor2_1 _136_ (.B(\u_dsm.integrator[0] ),
    .A(net5),
    .X(_047_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand2b_1 _137_ (.Y(_048_),
    .B(\data_word[0] ),
    .A_N(_047_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nor2_1 _138_ (.A(net5),
    .B(\u_dsm.integrator[0] ),
    .Y(_049_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xor2_1 _139_ (.B(net5),
    .A(\data_word[1] ),
    .X(_050_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xnor2_1 _140_ (.Y(_051_),
    .A(\u_dsm.integrator[1] ),
    .B(_050_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xor2_1 _141_ (.B(_051_),
    .A(_049_),
    .X(_052_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xnor2_1 _142_ (.Y(_001_),
    .A(_048_),
    .B(_052_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_inv_1 _143_ (.VDD(VPWR),
    .Y(_053_),
    .A(_048_),
    .VSS(VGND));
 sg13g2_nor2_1 _144_ (.A(_049_),
    .B(_051_),
    .Y(_054_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21o_2 _145_ (.A2(_052_),
    .A1(_053_),
    .B1(_054_),
    .X(_055_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_and2_1 _146_ (.A(\data_word[1] ),
    .B(net5),
    .X(_056_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21oi_1 _147_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(\u_dsm.integrator[1] ),
    .A2(_050_),
    .Y(_057_),
    .B1(_056_));
 sg13g2_xor2_1 _148_ (.B(net6),
    .A(\data_word[2] ),
    .X(_058_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xnor2_1 _149_ (.Y(_059_),
    .A(\u_dsm.integrator[2] ),
    .B(_058_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xor2_1 _150_ (.B(_059_),
    .A(_057_),
    .X(_060_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xor2_1 _151_ (.B(_060_),
    .A(_055_),
    .X(_002_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_and2_1 _152_ (.A(\data_word[2] ),
    .B(net6),
    .X(_061_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21oi_1 _153_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(\u_dsm.integrator[2] ),
    .A2(_058_),
    .Y(_062_),
    .B1(_061_));
 sg13g2_xor2_1 _154_ (.B(net5),
    .A(\data_word[3] ),
    .X(_063_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xnor2_1 _155_ (.Y(_064_),
    .A(\u_dsm.integrator[3] ),
    .B(_063_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xor2_1 _156_ (.B(_064_),
    .A(_062_),
    .X(_065_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nor2_1 _157_ (.A(_057_),
    .B(_059_),
    .Y(_066_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21oi_1 _158_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(_055_),
    .A2(_060_),
    .Y(_067_),
    .B1(_066_));
 sg13g2_xnor2_1 _159_ (.Y(_003_),
    .A(_065_),
    .B(_067_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_and2_1 _160_ (.A(_060_),
    .B(_065_),
    .X(_068_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand2_1 _161_ (.Y(_069_),
    .A(_062_),
    .B(_064_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nor2_1 _162_ (.A(_062_),
    .B(_064_),
    .Y(_070_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21o_2 _163_ (.A2(_069_),
    .A1(_066_),
    .B1(_070_),
    .X(_071_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21oi_2 _164_ (.VSS(VGND),
    .VDD(VPWR),
    .B1(_071_),
    .Y(_072_),
    .A2(_068_),
    .A1(_055_));
 sg13g2_nand2_1 _165_ (.Y(_073_),
    .A(\data_word[3] ),
    .B(net5),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand2_1 _166_ (.Y(_074_),
    .A(\u_dsm.integrator[3] ),
    .B(_063_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xor2_1 _167_ (.B(net5),
    .A(\data_word[4] ),
    .X(_075_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xnor2_1 _168_ (.Y(_076_),
    .A(\u_dsm.integrator[4] ),
    .B(_075_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21oi_1 _169_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(_073_),
    .A2(_074_),
    .Y(_077_),
    .B1(_076_));
 sg13g2_nand3_1 _170_ (.B(_074_),
    .C(_076_),
    .A(_073_),
    .Y(_078_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nor2b_1 _171_ (.A(_077_),
    .B_N(_078_),
    .Y(_079_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xnor2_1 _172_ (.Y(_004_),
    .A(_072_),
    .B(_079_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand2_1 _173_ (.Y(_080_),
    .A(\data_word[4] ),
    .B(net5),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand2_1 _174_ (.Y(_081_),
    .A(\u_dsm.integrator[4] ),
    .B(_075_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xor2_1 _175_ (.B(net6),
    .A(\data_word[5] ),
    .X(_082_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xnor2_1 _176_ (.Y(_083_),
    .A(\u_dsm.integrator[5] ),
    .B(_082_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_and3_1 _177_ (.X(_084_),
    .A(_080_),
    .B(_081_),
    .C(_083_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21oi_1 _178_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(_080_),
    .A2(_081_),
    .Y(_085_),
    .B1(_083_));
 sg13g2_nor2_1 _179_ (.A(_084_),
    .B(_085_),
    .Y(_086_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21o_1 _180_ (.A2(_068_),
    .A1(_055_),
    .B1(_071_),
    .X(_087_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21oi_1 _181_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(_087_),
    .A2(_079_),
    .Y(_088_),
    .B1(_077_));
 sg13g2_xnor2_1 _182_ (.Y(_005_),
    .A(_086_),
    .B(_088_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand2_1 _183_ (.Y(_089_),
    .A(_079_),
    .B(_086_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand3_1 _184_ (.B(_081_),
    .C(_083_),
    .A(_080_),
    .Y(_090_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21oi_1 _185_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(_077_),
    .A2(_090_),
    .Y(_091_),
    .B1(_085_));
 sg13g2_o21ai_1 _186_ (.B1(_091_),
    .VDD(VPWR),
    .Y(_092_),
    .VSS(VGND),
    .A1(_072_),
    .A2(_089_));
 sg13g2_nand2_1 _187_ (.Y(_093_),
    .A(\data_word[5] ),
    .B(net6),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand2_1 _188_ (.Y(_094_),
    .A(\u_dsm.integrator[5] ),
    .B(_082_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xor2_1 _189_ (.B(net6),
    .A(\data_word[6] ),
    .X(_095_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xnor2_1 _190_ (.Y(_096_),
    .A(\u_dsm.integrator[6] ),
    .B(_095_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21oi_1 _191_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(_093_),
    .A2(_094_),
    .Y(_097_),
    .B1(_096_));
 sg13g2_nand3_1 _192_ (.B(_094_),
    .C(_096_),
    .A(_093_),
    .Y(_098_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nor2b_1 _193_ (.A(_097_),
    .B_N(_098_),
    .Y(_099_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xor2_1 _194_ (.B(_099_),
    .A(_092_),
    .X(_006_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand2_1 _195_ (.Y(_100_),
    .A(\data_word[6] ),
    .B(net6),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand2_1 _196_ (.Y(_101_),
    .A(\u_dsm.integrator[6] ),
    .B(_095_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xnor2_1 _197_ (.Y(_102_),
    .A(\data_word[7] ),
    .B(\u_dsm.integrator[8] ),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xnor2_1 _198_ (.Y(_103_),
    .A(\u_dsm.integrator[7] ),
    .B(_102_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21oi_1 _199_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(_100_),
    .A2(_101_),
    .Y(_104_),
    .B1(_103_));
 sg13g2_nand3_1 _200_ (.B(_101_),
    .C(_103_),
    .A(_100_),
    .Y(_105_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nor2b_1 _201_ (.A(_104_),
    .B_N(_105_),
    .Y(_106_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21oi_1 _202_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(_092_),
    .A2(_099_),
    .Y(_107_),
    .B1(_097_));
 sg13g2_xnor2_1 _203_ (.Y(_007_),
    .A(_106_),
    .B(_107_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_and2_1 _204_ (.A(_099_),
    .B(_106_),
    .X(_108_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a221oi_1 _205_ (.VDD(VPWR),
    .VSS(VGND),
    .B2(_092_),
    .C1(_104_),
    .B1(_108_),
    .A1(_097_),
    .Y(_109_),
    .A2(_105_));
 sg13g2_nor2b_1 _206_ (.A(\u_dsm.integrator[8] ),
    .B_N(\data_word[7] ),
    .Y(_110_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21oi_1 _207_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(\u_dsm.integrator[7] ),
    .A2(_102_),
    .Y(_111_),
    .B1(_110_));
 sg13g2_xor2_1 _208_ (.B(_111_),
    .A(\data_word[8] ),
    .X(_112_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xnor2_1 _209_ (.Y(_008_),
    .A(_109_),
    .B(_112_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xnor2_1 _210_ (.Y(_000_),
    .A(\data_word[0] ),
    .B(_047_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_inv_1 _211_ (.VDD(VPWR),
    .Y(\uut.pre45.d2 ),
    .A(\uut.pre45.ff1.q ),
    .VSS(VGND));
 sg13g2_inv_1 _212_ (.VDD(VPWR),
    .Y(\uut.div4.dff2.d ),
    .A(\uut.div4.dff2.q ),
    .VSS(VGND));
 sg13g2_inv_1 _213_ (.VDD(VPWR),
    .Y(\uut.out_stg.dff_out.d ),
    .A(net7),
    .VSS(VGND));
 sg13g2_inv_1 _214_ (.VDD(VPWR),
    .Y(\uut.div4.dff1.d ),
    .A(\uut.div4.dff1.q ),
    .VSS(VGND));
 sg13g2_inv_1 _215_ (.VDD(VPWR),
    .Y(_009_),
    .A(net8),
    .VSS(VGND));
 sg13g2_inv_1 _216_ (.VDD(VPWR),
    .Y(_010_),
    .A(net8),
    .VSS(VGND));
 sg13g2_inv_1 _217_ (.VDD(VPWR),
    .Y(_011_),
    .A(net8),
    .VSS(VGND));
 sg13g2_inv_1 _218_ (.VDD(VPWR),
    .Y(_012_),
    .A(net8),
    .VSS(VGND));
 sg13g2_inv_1 _219_ (.VDD(VPWR),
    .Y(_013_),
    .A(net8),
    .VSS(VGND));
 sg13g2_inv_1 _220_ (.VDD(VPWR),
    .Y(_014_),
    .A(net8),
    .VSS(VGND));
 sg13g2_inv_1 _221_ (.VDD(VPWR),
    .Y(_015_),
    .A(net8),
    .VSS(VGND));
 sg13g2_inv_1 _222_ (.VDD(VPWR),
    .Y(_016_),
    .A(net9),
    .VSS(VGND));
 sg13g2_inv_1 _223_ (.VDD(VPWR),
    .Y(_017_),
    .A(net9),
    .VSS(VGND));
 sg13g2_inv_1 _224_ (.VDD(VPWR),
    .Y(_018_),
    .A(net8),
    .VSS(VGND));
 sg13g2_inv_1 _225_ (.VDD(VPWR),
    .Y(_019_),
    .A(net11),
    .VSS(VGND));
 sg13g2_inv_1 _226_ (.VDD(VPWR),
    .Y(_020_),
    .A(net11),
    .VSS(VGND));
 sg13g2_inv_1 _227_ (.VDD(VPWR),
    .Y(_021_),
    .A(net11),
    .VSS(VGND));
 sg13g2_inv_1 _228_ (.VDD(VPWR),
    .Y(_022_),
    .A(net11),
    .VSS(VGND));
 sg13g2_inv_1 _229_ (.VDD(VPWR),
    .Y(_023_),
    .A(net10),
    .VSS(VGND));
 sg13g2_inv_1 _230_ (.VDD(VPWR),
    .Y(_024_),
    .A(net10),
    .VSS(VGND));
 sg13g2_inv_1 _231_ (.VDD(VPWR),
    .Y(_025_),
    .A(net9),
    .VSS(VGND));
 sg13g2_inv_1 _232_ (.VDD(VPWR),
    .Y(_026_),
    .A(net9),
    .VSS(VGND));
 sg13g2_inv_1 _233_ (.VDD(VPWR),
    .Y(_027_),
    .A(net11),
    .VSS(VGND));
 sg13g2_inv_1 _234_ (.VDD(VPWR),
    .Y(_028_),
    .A(net10),
    .VSS(VGND));
 sg13g2_inv_1 _235_ (.VDD(VPWR),
    .Y(_029_),
    .A(net10),
    .VSS(VGND));
 sg13g2_inv_1 _236_ (.VDD(VPWR),
    .Y(_030_),
    .A(net10),
    .VSS(VGND));
 sg13g2_inv_1 _237_ (.VDD(VPWR),
    .Y(_031_),
    .A(net10),
    .VSS(VGND));
 sg13g2_inv_1 _238_ (.VDD(VPWR),
    .Y(_032_),
    .A(net11),
    .VSS(VGND));
 sg13g2_inv_1 _239_ (.VDD(VPWR),
    .Y(_033_),
    .A(net11),
    .VSS(VGND));
 sg13g2_inv_1 _240_ (.VDD(VPWR),
    .Y(_034_),
    .A(net10),
    .VSS(VGND));
 sg13g2_inv_1 _241_ (.VDD(VPWR),
    .Y(_035_),
    .A(net10),
    .VSS(VGND));
 sg13g2_dfrbpq_1 _242_ (.RESET_B(_009_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_036_),
    .Q(\data_word[0] ),
    .CLK(clknet_1_0__leaf_sclk));
 sg13g2_dfrbpq_1 _243_ (.RESET_B(_010_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_037_),
    .Q(\data_word[1] ),
    .CLK(clknet_1_0__leaf_sclk));
 sg13g2_dfrbpq_1 _244_ (.RESET_B(_011_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_038_),
    .Q(\data_word[2] ),
    .CLK(clknet_1_0__leaf_sclk));
 sg13g2_dfrbpq_1 _245_ (.RESET_B(_012_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_039_),
    .Q(\data_word[3] ),
    .CLK(clknet_1_0__leaf_sclk));
 sg13g2_dfrbpq_1 _246_ (.RESET_B(_013_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_040_),
    .Q(\data_word[4] ),
    .CLK(clknet_1_0__leaf_sclk));
 sg13g2_dfrbpq_1 _247_ (.RESET_B(_014_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_041_),
    .Q(\data_word[5] ),
    .CLK(clknet_1_1__leaf_sclk));
 sg13g2_dfrbpq_1 _248_ (.RESET_B(_015_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_042_),
    .Q(\data_word[6] ),
    .CLK(clknet_1_1__leaf_sclk));
 sg13g2_dfrbpq_1 _249_ (.RESET_B(_016_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_043_),
    .Q(\data_word[7] ),
    .CLK(clknet_1_1__leaf_sclk));
 sg13g2_dfrbpq_1 _250_ (.RESET_B(_017_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_044_),
    .Q(\data_word[8] ),
    .CLK(clknet_1_1__leaf_sclk));
 sg13g2_dfrbpq_1 _251_ (.RESET_B(_018_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_000_),
    .Q(\u_dsm.integrator[0] ),
    .CLK(net7));
 sg13g2_dfrbpq_1 _252_ (.RESET_B(_019_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_001_),
    .Q(\u_dsm.integrator[1] ),
    .CLK(net7));
 sg13g2_dfrbpq_1 _253_ (.RESET_B(_020_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_002_),
    .Q(\u_dsm.integrator[2] ),
    .CLK(net7));
 sg13g2_dfrbpq_1 _254_ (.RESET_B(_021_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_003_),
    .Q(\u_dsm.integrator[3] ),
    .CLK(net7));
 sg13g2_dfrbpq_1 _255_ (.RESET_B(_022_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_004_),
    .Q(\u_dsm.integrator[4] ),
    .CLK(net7));
 sg13g2_dfrbpq_1 _256_ (.RESET_B(_023_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_005_),
    .Q(\u_dsm.integrator[5] ),
    .CLK(net7));
 sg13g2_dfrbpq_1 _257_ (.RESET_B(_024_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_006_),
    .Q(\u_dsm.integrator[6] ),
    .CLK(net4));
 sg13g2_dfrbpq_1 _258_ (.RESET_B(_025_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_007_),
    .Q(\u_dsm.integrator[7] ),
    .CLK(net4));
 sg13g2_dfrbpq_1 _259_ (.RESET_B(_026_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_008_),
    .Q(\u_dsm.integrator[8] ),
    .CLK(net4));
 sg13g2_dfrbpq_1 _260_ (.RESET_B(_027_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(\uut.out_stg.dff_out.d ),
    .Q(net4),
    .CLK(\uut.d ));
 sg13g2_dfrbpq_1 _261_ (.RESET_B(_028_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(\uut.mod7.jk1.d_in ),
    .Q(\uut.b ),
    .CLK(\uut.clk_jk ));
 sg13g2_dfrbpq_1 _262_ (.RESET_B(_029_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(\uut.mod7.jk2.d_in ),
    .Q(\uut.c ),
    .CLK(\uut.clk_jk ));
 sg13g2_dfrbpq_1 _263_ (.RESET_B(_030_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(\uut.mod7.jk3.d_in ),
    .Q(\uut.d ),
    .CLK(\uut.clk_jk ));
 sg13g2_dfrbpq_1 _264_ (.RESET_B(_031_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(\uut.pre45.d1 ),
    .Q(\uut.pre45.ff1.q ),
    .CLK(\uut.div4.dff2.q ));
 sg13g2_dfrbpq_1 _265_ (.RESET_B(_032_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(\uut.pre45.d2 ),
    .Q(\uut.pre45.d3 ),
    .CLK(\uut.div4.dff2.q ));
 sg13g2_dfrbpq_1 _266_ (.RESET_B(_033_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(\uut.pre45.d3 ),
    .Q(\uut.clk_jk ),
    .CLK(\uut.div4.dff2.q ));
 sg13g2_dfrbpq_1 _267_ (.RESET_B(_034_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(\uut.div4.dff1.d ),
    .Q(\uut.div4.dff1.q ),
    .CLK(freq_in));
 sg13g2_dfrbpq_1 _268_ (.RESET_B(_035_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(\uut.div4.dff2.d ),
    .Q(\uut.div4.dff2.q ),
    .CLK(\uut.div4.dff1.q ));
 sg13g2_buf_16 clkbuf_0_sclk (.X(clknet_0_sclk),
    .A(sclk),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_16 clkbuf_1_0__f_sclk (.X(clknet_1_0__leaf_sclk),
    .A(clknet_0_sclk),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_16 clkbuf_1_1__f_sclk (.X(clknet_1_1__leaf_sclk),
    .A(clknet_0_sclk),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_inv_1 clkload0 (.VDD(VPWR),
    .A(clknet_1_1__leaf_sclk),
    .VSS(VGND));
 sg13g2_buf_1 fanout10 (.A(net11),
    .X(net10),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 fanout11 (.A(net2),
    .X(net11),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 fanout5 (.A(net6),
    .X(net5),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 fanout6 (.A(\u_dsm.integrator[8] ),
    .X(net6),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 fanout7 (.A(net4),
    .X(net7),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 fanout8 (.A(net2),
    .X(net8),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 fanout9 (.A(net2),
    .X(net9),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 input1 (.A(en),
    .X(net1),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 input2 (.A(rst),
    .X(net2),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 input3 (.A(sdata),
    .X(net3),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 output4 (.A(net7),
    .X(freq_out),
    .VDD(VPWR),
    .VSS(VGND));
endmodule
