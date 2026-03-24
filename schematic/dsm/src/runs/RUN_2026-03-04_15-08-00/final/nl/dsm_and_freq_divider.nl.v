module dsm_and_freq_divider (en,
    freq_in,
    freq_out,
    rst,
    sclk,
    sdata);
 input en;
 input freq_in;
 output freq_out;
 input rst;
 input sclk;
 input sdata;

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

 sg13g2_decap_8 FILLER_0_0 ();
 sg13g2_decap_8 FILLER_0_106 ();
 sg13g2_decap_8 FILLER_0_113 ();
 sg13g2_decap_8 FILLER_0_120 ();
 sg13g2_decap_8 FILLER_0_127 ();
 sg13g2_decap_8 FILLER_0_134 ();
 sg13g2_decap_8 FILLER_0_14 ();
 sg13g2_decap_8 FILLER_0_141 ();
 sg13g2_decap_8 FILLER_0_148 ();
 sg13g2_decap_8 FILLER_0_155 ();
 sg13g2_decap_4 FILLER_0_162 ();
 sg13g2_fill_1 FILLER_0_166 ();
 sg13g2_decap_8 FILLER_0_21 ();
 sg13g2_decap_8 FILLER_0_28 ();
 sg13g2_decap_8 FILLER_0_35 ();
 sg13g2_decap_8 FILLER_0_42 ();
 sg13g2_decap_8 FILLER_0_49 ();
 sg13g2_decap_8 FILLER_0_56 ();
 sg13g2_decap_8 FILLER_0_63 ();
 sg13g2_decap_8 FILLER_0_7 ();
 sg13g2_decap_4 FILLER_0_70 ();
 sg13g2_fill_1 FILLER_0_74 ();
 sg13g2_decap_8 FILLER_0_78 ();
 sg13g2_decap_8 FILLER_0_85 ();
 sg13g2_decap_8 FILLER_0_92 ();
 sg13g2_decap_8 FILLER_0_99 ();
 sg13g2_decap_8 FILLER_10_0 ();
 sg13g2_decap_8 FILLER_10_102 ();
 sg13g2_decap_8 FILLER_10_109 ();
 sg13g2_decap_8 FILLER_10_116 ();
 sg13g2_decap_8 FILLER_10_123 ();
 sg13g2_decap_4 FILLER_10_134 ();
 sg13g2_fill_1 FILLER_10_138 ();
 sg13g2_decap_8 FILLER_10_14 ();
 sg13g2_decap_8 FILLER_10_147 ();
 sg13g2_decap_8 FILLER_10_154 ();
 sg13g2_decap_4 FILLER_10_161 ();
 sg13g2_fill_2 FILLER_10_165 ();
 sg13g2_decap_4 FILLER_10_21 ();
 sg13g2_fill_2 FILLER_10_25 ();
 sg13g2_decap_8 FILLER_10_52 ();
 sg13g2_decap_8 FILLER_10_59 ();
 sg13g2_decap_8 FILLER_10_66 ();
 sg13g2_decap_8 FILLER_10_7 ();
 sg13g2_decap_8 FILLER_10_81 ();
 sg13g2_decap_8 FILLER_10_88 ();
 sg13g2_decap_8 FILLER_10_95 ();
 sg13g2_decap_8 FILLER_11_102 ();
 sg13g2_decap_8 FILLER_11_109 ();
 sg13g2_decap_4 FILLER_11_116 ();
 sg13g2_fill_1 FILLER_11_120 ();
 sg13g2_fill_1 FILLER_11_166 ();
 sg13g2_decap_8 FILLER_11_19 ();
 sg13g2_decap_8 FILLER_11_26 ();
 sg13g2_decap_8 FILLER_11_33 ();
 sg13g2_decap_4 FILLER_11_4 ();
 sg13g2_decap_8 FILLER_11_40 ();
 sg13g2_decap_4 FILLER_11_47 ();
 sg13g2_fill_1 FILLER_11_51 ();
 sg13g2_decap_8 FILLER_11_60 ();
 sg13g2_decap_8 FILLER_11_67 ();
 sg13g2_decap_8 FILLER_11_74 ();
 sg13g2_fill_1 FILLER_11_8 ();
 sg13g2_decap_8 FILLER_11_81 ();
 sg13g2_decap_8 FILLER_11_88 ();
 sg13g2_decap_8 FILLER_11_95 ();
 sg13g2_decap_4 FILLER_12_0 ();
 sg13g2_fill_1 FILLER_12_107 ();
 sg13g2_fill_2 FILLER_12_165 ();
 sg13g2_fill_2 FILLER_12_35 ();
 sg13g2_fill_1 FILLER_12_4 ();
 sg13g2_decap_4 FILLER_12_49 ();
 sg13g2_fill_1 FILLER_12_53 ();
 sg13g2_decap_8 FILLER_12_63 ();
 sg13g2_decap_8 FILLER_12_70 ();
 sg13g2_decap_8 FILLER_13_104 ();
 sg13g2_decap_8 FILLER_13_111 ();
 sg13g2_decap_4 FILLER_13_118 ();
 sg13g2_fill_1 FILLER_13_136 ();
 sg13g2_decap_8 FILLER_13_142 ();
 sg13g2_decap_8 FILLER_13_149 ();
 sg13g2_decap_8 FILLER_13_156 ();
 sg13g2_decap_4 FILLER_13_163 ();
 sg13g2_fill_2 FILLER_13_34 ();
 sg13g2_fill_1 FILLER_13_36 ();
 sg13g2_decap_4 FILLER_13_45 ();
 sg13g2_decap_8 FILLER_13_62 ();
 sg13g2_decap_8 FILLER_13_69 ();
 sg13g2_decap_8 FILLER_13_76 ();
 sg13g2_decap_8 FILLER_13_83 ();
 sg13g2_decap_8 FILLER_13_90 ();
 sg13g2_decap_8 FILLER_13_97 ();
 sg13g2_decap_8 FILLER_14_0 ();
 sg13g2_decap_8 FILLER_14_107 ();
 sg13g2_decap_8 FILLER_14_114 ();
 sg13g2_fill_2 FILLER_14_121 ();
 sg13g2_decap_8 FILLER_14_127 ();
 sg13g2_decap_8 FILLER_14_134 ();
 sg13g2_decap_8 FILLER_14_141 ();
 sg13g2_decap_8 FILLER_14_148 ();
 sg13g2_decap_8 FILLER_14_155 ();
 sg13g2_decap_4 FILLER_14_162 ();
 sg13g2_fill_1 FILLER_14_166 ();
 sg13g2_fill_2 FILLER_14_47 ();
 sg13g2_fill_1 FILLER_14_49 ();
 sg13g2_decap_4 FILLER_14_54 ();
 sg13g2_fill_2 FILLER_14_58 ();
 sg13g2_decap_4 FILLER_14_65 ();
 sg13g2_fill_2 FILLER_14_7 ();
 sg13g2_decap_8 FILLER_15_0 ();
 sg13g2_decap_8 FILLER_15_104 ();
 sg13g2_decap_8 FILLER_15_111 ();
 sg13g2_decap_8 FILLER_15_118 ();
 sg13g2_decap_8 FILLER_15_125 ();
 sg13g2_decap_8 FILLER_15_132 ();
 sg13g2_decap_8 FILLER_15_139 ();
 sg13g2_decap_8 FILLER_15_14 ();
 sg13g2_decap_8 FILLER_15_146 ();
 sg13g2_decap_8 FILLER_15_153 ();
 sg13g2_decap_8 FILLER_15_160 ();
 sg13g2_decap_8 FILLER_15_21 ();
 sg13g2_decap_8 FILLER_15_28 ();
 sg13g2_decap_8 FILLER_15_35 ();
 sg13g2_decap_8 FILLER_15_42 ();
 sg13g2_decap_8 FILLER_15_49 ();
 sg13g2_decap_8 FILLER_15_56 ();
 sg13g2_fill_1 FILLER_15_63 ();
 sg13g2_decap_8 FILLER_15_69 ();
 sg13g2_decap_8 FILLER_15_7 ();
 sg13g2_decap_8 FILLER_15_76 ();
 sg13g2_decap_8 FILLER_15_83 ();
 sg13g2_decap_8 FILLER_15_90 ();
 sg13g2_decap_8 FILLER_15_97 ();
 sg13g2_decap_8 FILLER_16_0 ();
 sg13g2_decap_8 FILLER_16_106 ();
 sg13g2_decap_4 FILLER_16_113 ();
 sg13g2_fill_2 FILLER_16_117 ();
 sg13g2_decap_4 FILLER_16_127 ();
 sg13g2_decap_4 FILLER_16_161 ();
 sg13g2_fill_2 FILLER_16_165 ();
 sg13g2_decap_8 FILLER_16_19 ();
 sg13g2_decap_8 FILLER_16_26 ();
 sg13g2_decap_4 FILLER_16_33 ();
 sg13g2_fill_2 FILLER_16_37 ();
 sg13g2_fill_2 FILLER_16_7 ();
 sg13g2_decap_8 FILLER_16_71 ();
 sg13g2_decap_8 FILLER_16_78 ();
 sg13g2_decap_8 FILLER_16_85 ();
 sg13g2_decap_8 FILLER_16_92 ();
 sg13g2_decap_8 FILLER_16_99 ();
 sg13g2_decap_4 FILLER_17_0 ();
 sg13g2_fill_1 FILLER_17_104 ();
 sg13g2_decap_4 FILLER_17_108 ();
 sg13g2_fill_2 FILLER_17_112 ();
 sg13g2_fill_1 FILLER_17_117 ();
 sg13g2_decap_8 FILLER_17_151 ();
 sg13g2_decap_8 FILLER_17_158 ();
 sg13g2_fill_2 FILLER_17_165 ();
 sg13g2_fill_1 FILLER_17_39 ();
 sg13g2_decap_8 FILLER_17_45 ();
 sg13g2_decap_8 FILLER_17_52 ();
 sg13g2_decap_8 FILLER_17_94 ();
 sg13g2_fill_2 FILLER_18_101 ();
 sg13g2_decap_4 FILLER_18_130 ();
 sg13g2_fill_1 FILLER_18_134 ();
 sg13g2_decap_4 FILLER_18_162 ();
 sg13g2_fill_1 FILLER_18_166 ();
 sg13g2_decap_4 FILLER_18_50 ();
 sg13g2_fill_2 FILLER_18_54 ();
 sg13g2_fill_1 FILLER_18_64 ();
 sg13g2_decap_8 FILLER_19_116 ();
 sg13g2_decap_8 FILLER_19_123 ();
 sg13g2_decap_8 FILLER_19_130 ();
 sg13g2_decap_8 FILLER_19_137 ();
 sg13g2_decap_8 FILLER_19_144 ();
 sg13g2_decap_8 FILLER_19_151 ();
 sg13g2_decap_8 FILLER_19_158 ();
 sg13g2_fill_2 FILLER_19_165 ();
 sg13g2_decap_8 FILLER_19_19 ();
 sg13g2_decap_8 FILLER_19_26 ();
 sg13g2_decap_4 FILLER_19_4 ();
 sg13g2_decap_8 FILLER_19_41 ();
 sg13g2_decap_8 FILLER_19_48 ();
 sg13g2_decap_8 FILLER_19_55 ();
 sg13g2_decap_8 FILLER_19_62 ();
 sg13g2_decap_8 FILLER_19_69 ();
 sg13g2_decap_8 FILLER_19_76 ();
 sg13g2_fill_1 FILLER_19_8 ();
 sg13g2_fill_2 FILLER_19_83 ();
 sg13g2_decap_8 FILLER_1_0 ();
 sg13g2_fill_1 FILLER_1_11 ();
 sg13g2_decap_8 FILLER_1_111 ();
 sg13g2_decap_8 FILLER_1_118 ();
 sg13g2_decap_8 FILLER_1_125 ();
 sg13g2_decap_8 FILLER_1_132 ();
 sg13g2_decap_8 FILLER_1_139 ();
 sg13g2_decap_8 FILLER_1_146 ();
 sg13g2_decap_8 FILLER_1_153 ();
 sg13g2_decap_8 FILLER_1_160 ();
 sg13g2_decap_8 FILLER_1_39 ();
 sg13g2_decap_4 FILLER_1_46 ();
 sg13g2_decap_4 FILLER_1_66 ();
 sg13g2_decap_4 FILLER_1_7 ();
 sg13g2_fill_1 FILLER_1_74 ();
 sg13g2_decap_8 FILLER_1_87 ();
 sg13g2_decap_4 FILLER_1_94 ();
 sg13g2_decap_8 FILLER_20_0 ();
 sg13g2_decap_8 FILLER_20_104 ();
 sg13g2_decap_8 FILLER_20_111 ();
 sg13g2_decap_8 FILLER_20_118 ();
 sg13g2_decap_8 FILLER_20_125 ();
 sg13g2_decap_8 FILLER_20_132 ();
 sg13g2_decap_8 FILLER_20_139 ();
 sg13g2_decap_8 FILLER_20_14 ();
 sg13g2_decap_8 FILLER_20_146 ();
 sg13g2_decap_8 FILLER_20_153 ();
 sg13g2_decap_8 FILLER_20_160 ();
 sg13g2_decap_8 FILLER_20_21 ();
 sg13g2_decap_8 FILLER_20_28 ();
 sg13g2_decap_8 FILLER_20_35 ();
 sg13g2_decap_8 FILLER_20_42 ();
 sg13g2_decap_8 FILLER_20_49 ();
 sg13g2_decap_8 FILLER_20_56 ();
 sg13g2_decap_8 FILLER_20_63 ();
 sg13g2_decap_8 FILLER_20_7 ();
 sg13g2_decap_8 FILLER_20_70 ();
 sg13g2_decap_8 FILLER_20_77 ();
 sg13g2_decap_8 FILLER_20_84 ();
 sg13g2_fill_2 FILLER_20_91 ();
 sg13g2_decap_8 FILLER_20_97 ();
 sg13g2_fill_2 FILLER_2_0 ();
 sg13g2_fill_1 FILLER_2_114 ();
 sg13g2_fill_1 FILLER_2_127 ();
 sg13g2_decap_4 FILLER_2_136 ();
 sg13g2_fill_1 FILLER_2_140 ();
 sg13g2_decap_8 FILLER_2_144 ();
 sg13g2_decap_8 FILLER_2_151 ();
 sg13g2_decap_4 FILLER_2_158 ();
 sg13g2_fill_1 FILLER_2_162 ();
 sg13g2_fill_1 FILLER_2_2 ();
 sg13g2_fill_2 FILLER_2_46 ();
 sg13g2_fill_1 FILLER_2_48 ();
 sg13g2_decap_8 FILLER_3_0 ();
 sg13g2_decap_8 FILLER_3_107 ();
 sg13g2_fill_1 FILLER_3_114 ();
 sg13g2_fill_2 FILLER_3_120 ();
 sg13g2_fill_2 FILLER_3_165 ();
 sg13g2_decap_8 FILLER_3_46 ();
 sg13g2_decap_4 FILLER_3_53 ();
 sg13g2_fill_1 FILLER_3_57 ();
 sg13g2_decap_4 FILLER_3_63 ();
 sg13g2_fill_1 FILLER_3_67 ();
 sg13g2_fill_2 FILLER_3_7 ();
 sg13g2_decap_8 FILLER_3_84 ();
 sg13g2_decap_8 FILLER_3_91 ();
 sg13g2_fill_1 FILLER_3_98 ();
 sg13g2_decap_8 FILLER_4_0 ();
 sg13g2_decap_8 FILLER_4_100 ();
 sg13g2_decap_8 FILLER_4_107 ();
 sg13g2_decap_8 FILLER_4_114 ();
 sg13g2_fill_1 FILLER_4_121 ();
 sg13g2_decap_8 FILLER_4_127 ();
 sg13g2_decap_8 FILLER_4_134 ();
 sg13g2_decap_8 FILLER_4_141 ();
 sg13g2_decap_8 FILLER_4_148 ();
 sg13g2_decap_8 FILLER_4_155 ();
 sg13g2_decap_4 FILLER_4_162 ();
 sg13g2_fill_1 FILLER_4_166 ();
 sg13g2_decap_8 FILLER_4_23 ();
 sg13g2_decap_8 FILLER_4_30 ();
 sg13g2_decap_8 FILLER_4_37 ();
 sg13g2_decap_8 FILLER_4_44 ();
 sg13g2_decap_8 FILLER_4_51 ();
 sg13g2_decap_8 FILLER_4_58 ();
 sg13g2_decap_8 FILLER_4_65 ();
 sg13g2_fill_2 FILLER_4_7 ();
 sg13g2_decap_8 FILLER_4_72 ();
 sg13g2_decap_8 FILLER_4_79 ();
 sg13g2_decap_8 FILLER_4_86 ();
 sg13g2_fill_1 FILLER_4_9 ();
 sg13g2_decap_8 FILLER_4_93 ();
 sg13g2_decap_8 FILLER_5_0 ();
 sg13g2_decap_8 FILLER_5_102 ();
 sg13g2_decap_8 FILLER_5_109 ();
 sg13g2_fill_2 FILLER_5_116 ();
 sg13g2_fill_2 FILLER_5_122 ();
 sg13g2_decap_8 FILLER_5_129 ();
 sg13g2_decap_8 FILLER_5_136 ();
 sg13g2_decap_8 FILLER_5_14 ();
 sg13g2_decap_8 FILLER_5_143 ();
 sg13g2_decap_8 FILLER_5_150 ();
 sg13g2_decap_8 FILLER_5_157 ();
 sg13g2_fill_2 FILLER_5_164 ();
 sg13g2_fill_1 FILLER_5_166 ();
 sg13g2_decap_8 FILLER_5_21 ();
 sg13g2_decap_8 FILLER_5_53 ();
 sg13g2_decap_8 FILLER_5_60 ();
 sg13g2_decap_8 FILLER_5_67 ();
 sg13g2_decap_8 FILLER_5_7 ();
 sg13g2_decap_8 FILLER_5_74 ();
 sg13g2_decap_8 FILLER_5_81 ();
 sg13g2_decap_8 FILLER_5_88 ();
 sg13g2_decap_8 FILLER_5_95 ();
 sg13g2_decap_8 FILLER_6_106 ();
 sg13g2_fill_1 FILLER_6_113 ();
 sg13g2_decap_8 FILLER_6_138 ();
 sg13g2_decap_8 FILLER_6_145 ();
 sg13g2_fill_1 FILLER_6_152 ();
 sg13g2_decap_8 FILLER_6_157 ();
 sg13g2_fill_2 FILLER_6_164 ();
 sg13g2_fill_1 FILLER_6_166 ();
 sg13g2_decap_8 FILLER_6_19 ();
 sg13g2_decap_8 FILLER_6_26 ();
 sg13g2_decap_8 FILLER_6_33 ();
 sg13g2_decap_4 FILLER_6_4 ();
 sg13g2_decap_8 FILLER_6_40 ();
 sg13g2_decap_8 FILLER_6_47 ();
 sg13g2_decap_8 FILLER_6_54 ();
 sg13g2_decap_8 FILLER_6_61 ();
 sg13g2_fill_1 FILLER_6_68 ();
 sg13g2_decap_8 FILLER_6_77 ();
 sg13g2_fill_1 FILLER_6_8 ();
 sg13g2_fill_1 FILLER_6_84 ();
 sg13g2_decap_8 FILLER_6_89 ();
 sg13g2_fill_2 FILLER_6_96 ();
 sg13g2_decap_8 FILLER_7_0 ();
 sg13g2_fill_1 FILLER_7_100 ();
 sg13g2_fill_2 FILLER_7_116 ();
 sg13g2_fill_1 FILLER_7_118 ();
 sg13g2_fill_2 FILLER_7_123 ();
 sg13g2_fill_1 FILLER_7_125 ();
 sg13g2_decap_4 FILLER_7_131 ();
 sg13g2_fill_1 FILLER_7_135 ();
 sg13g2_fill_1 FILLER_7_166 ();
 sg13g2_decap_4 FILLER_7_37 ();
 sg13g2_decap_8 FILLER_7_45 ();
 sg13g2_fill_2 FILLER_7_52 ();
 sg13g2_decap_8 FILLER_7_80 ();
 sg13g2_decap_4 FILLER_7_87 ();
 sg13g2_fill_2 FILLER_7_91 ();
 sg13g2_decap_4 FILLER_7_96 ();
 sg13g2_decap_8 FILLER_8_0 ();
 sg13g2_decap_8 FILLER_8_116 ();
 sg13g2_decap_8 FILLER_8_123 ();
 sg13g2_decap_4 FILLER_8_130 ();
 sg13g2_fill_2 FILLER_8_134 ();
 sg13g2_fill_1 FILLER_8_166 ();
 sg13g2_fill_2 FILLER_8_37 ();
 sg13g2_fill_1 FILLER_8_39 ();
 sg13g2_fill_2 FILLER_8_48 ();
 sg13g2_fill_2 FILLER_8_64 ();
 sg13g2_fill_1 FILLER_8_66 ();
 sg13g2_decap_4 FILLER_8_72 ();
 sg13g2_decap_8 FILLER_9_0 ();
 sg13g2_decap_8 FILLER_9_100 ();
 sg13g2_decap_8 FILLER_9_107 ();
 sg13g2_decap_8 FILLER_9_114 ();
 sg13g2_decap_8 FILLER_9_121 ();
 sg13g2_decap_8 FILLER_9_128 ();
 sg13g2_decap_8 FILLER_9_135 ();
 sg13g2_decap_8 FILLER_9_145 ();
 sg13g2_decap_8 FILLER_9_152 ();
 sg13g2_decap_8 FILLER_9_159 ();
 sg13g2_fill_1 FILLER_9_166 ();
 sg13g2_decap_8 FILLER_9_19 ();
 sg13g2_decap_8 FILLER_9_26 ();
 sg13g2_decap_8 FILLER_9_33 ();
 sg13g2_decap_8 FILLER_9_40 ();
 sg13g2_decap_4 FILLER_9_47 ();
 sg13g2_fill_2 FILLER_9_67 ();
 sg13g2_fill_1 FILLER_9_69 ();
 sg13g2_fill_2 FILLER_9_7 ();
 sg13g2_decap_8 FILLER_9_79 ();
 sg13g2_decap_8 FILLER_9_86 ();
 sg13g2_decap_8 FILLER_9_93 ();
 sg13g2_mux2_1 _117_ (.A0(\data_word[8] ),
    .A1(\data_word[7] ),
    .S(net1),
    .X(_044_));
 sg13g2_mux2_1 _118_ (.A0(\data_word[7] ),
    .A1(\data_word[6] ),
    .S(net1),
    .X(_043_));
 sg13g2_mux2_1 _119_ (.A0(\data_word[6] ),
    .A1(\data_word[5] ),
    .S(net1),
    .X(_042_));
 sg13g2_mux2_1 _120_ (.A0(\data_word[5] ),
    .A1(\data_word[4] ),
    .S(net1),
    .X(_041_));
 sg13g2_mux2_1 _121_ (.A0(\data_word[4] ),
    .A1(\data_word[3] ),
    .S(net1),
    .X(_040_));
 sg13g2_mux2_1 _122_ (.A0(\data_word[3] ),
    .A1(\data_word[2] ),
    .S(net1),
    .X(_039_));
 sg13g2_mux2_1 _123_ (.A0(\data_word[2] ),
    .A1(\data_word[1] ),
    .S(net1),
    .X(_038_));
 sg13g2_mux2_1 _124_ (.A0(\data_word[1] ),
    .A1(\data_word[0] ),
    .S(net1),
    .X(_037_));
 sg13g2_mux2_1 _125_ (.A0(\data_word[0] ),
    .A1(net3),
    .S(net1),
    .X(_036_));
 sg13g2_a21oi_1 _126_ (.A1(\uut.d ),
    .A2(\uut.c ),
    .Y(\uut.mod7.jk1.d_in ),
    .B1(\uut.b ));
 sg13g2_nand2_1 _127_ (.Y(_113_),
    .A(\uut.d ),
    .B(\uut.c ));
 sg13g2_o21ai_1 _128_ (.B1(_113_),
    .Y(_114_),
    .A1(\uut.c ),
    .A2(\uut.b ));
 sg13g2_a21oi_1 _129_ (.A1(\uut.c ),
    .A2(\uut.b ),
    .Y(\uut.mod7.jk2.d_in ),
    .B1(_114_));
 sg13g2_a21oi_1 _130_ (.A1(\uut.c ),
    .A2(\uut.b ),
    .Y(_115_),
    .B1(\uut.d ));
 sg13g2_a21oi_1 _131_ (.A1(\uut.d ),
    .A2(\uut.c ),
    .Y(\uut.mod7.jk3.d_in ),
    .B1(_115_));
 sg13g2_nor2_1 _132_ (.A(\uut.d ),
    .B(\uut.c ),
    .Y(_116_));
 sg13g2_nor3_1 _133_ (.A(\uut.b ),
    .B(\uut.clk_jk ),
    .C(_116_),
    .Y(_045_));
 sg13g2_o21ai_1 _134_ (.B1(_045_),
    .Y(_046_),
    .A1(net6),
    .A2(_113_));
 sg13g2_and2_1 _135_ (.A(\uut.pre45.d3 ),
    .B(_046_),
    .X(\uut.pre45.d1 ));
 sg13g2_xor2_1 _136_ (.B(\u_dsm.integrator[0] ),
    .A(net5),
    .X(_047_));
 sg13g2_nand2b_1 _137_ (.Y(_048_),
    .B(\data_word[0] ),
    .A_N(_047_));
 sg13g2_nor2_1 _138_ (.A(net5),
    .B(\u_dsm.integrator[0] ),
    .Y(_049_));
 sg13g2_xor2_1 _139_ (.B(net5),
    .A(\data_word[1] ),
    .X(_050_));
 sg13g2_xnor2_1 _140_ (.Y(_051_),
    .A(\u_dsm.integrator[1] ),
    .B(_050_));
 sg13g2_xor2_1 _141_ (.B(_051_),
    .A(_049_),
    .X(_052_));
 sg13g2_xnor2_1 _142_ (.Y(_001_),
    .A(_048_),
    .B(_052_));
 sg13g2_inv_1 _143_ (.Y(_053_),
    .A(_048_));
 sg13g2_nor2_1 _144_ (.A(_049_),
    .B(_051_),
    .Y(_054_));
 sg13g2_a21o_2 _145_ (.A2(_052_),
    .A1(_053_),
    .B1(_054_),
    .X(_055_));
 sg13g2_and2_1 _146_ (.A(\data_word[1] ),
    .B(net5),
    .X(_056_));
 sg13g2_a21oi_1 _147_ (.A1(\u_dsm.integrator[1] ),
    .A2(_050_),
    .Y(_057_),
    .B1(_056_));
 sg13g2_xor2_1 _148_ (.B(net6),
    .A(\data_word[2] ),
    .X(_058_));
 sg13g2_xnor2_1 _149_ (.Y(_059_),
    .A(\u_dsm.integrator[2] ),
    .B(_058_));
 sg13g2_xor2_1 _150_ (.B(_059_),
    .A(_057_),
    .X(_060_));
 sg13g2_xor2_1 _151_ (.B(_060_),
    .A(_055_),
    .X(_002_));
 sg13g2_and2_1 _152_ (.A(\data_word[2] ),
    .B(net6),
    .X(_061_));
 sg13g2_a21oi_1 _153_ (.A1(\u_dsm.integrator[2] ),
    .A2(_058_),
    .Y(_062_),
    .B1(_061_));
 sg13g2_xor2_1 _154_ (.B(net5),
    .A(\data_word[3] ),
    .X(_063_));
 sg13g2_xnor2_1 _155_ (.Y(_064_),
    .A(\u_dsm.integrator[3] ),
    .B(_063_));
 sg13g2_xor2_1 _156_ (.B(_064_),
    .A(_062_),
    .X(_065_));
 sg13g2_nor2_1 _157_ (.A(_057_),
    .B(_059_),
    .Y(_066_));
 sg13g2_a21oi_1 _158_ (.A1(_055_),
    .A2(_060_),
    .Y(_067_),
    .B1(_066_));
 sg13g2_xnor2_1 _159_ (.Y(_003_),
    .A(_065_),
    .B(_067_));
 sg13g2_and2_1 _160_ (.A(_060_),
    .B(_065_),
    .X(_068_));
 sg13g2_nand2_1 _161_ (.Y(_069_),
    .A(_062_),
    .B(_064_));
 sg13g2_nor2_1 _162_ (.A(_062_),
    .B(_064_),
    .Y(_070_));
 sg13g2_a21o_2 _163_ (.A2(_069_),
    .A1(_066_),
    .B1(_070_),
    .X(_071_));
 sg13g2_a21oi_2 _164_ (.B1(_071_),
    .Y(_072_),
    .A2(_068_),
    .A1(_055_));
 sg13g2_nand2_1 _165_ (.Y(_073_),
    .A(\data_word[3] ),
    .B(net5));
 sg13g2_nand2_1 _166_ (.Y(_074_),
    .A(\u_dsm.integrator[3] ),
    .B(_063_));
 sg13g2_xor2_1 _167_ (.B(net5),
    .A(\data_word[4] ),
    .X(_075_));
 sg13g2_xnor2_1 _168_ (.Y(_076_),
    .A(\u_dsm.integrator[4] ),
    .B(_075_));
 sg13g2_a21oi_1 _169_ (.A1(_073_),
    .A2(_074_),
    .Y(_077_),
    .B1(_076_));
 sg13g2_nand3_1 _170_ (.B(_074_),
    .C(_076_),
    .A(_073_),
    .Y(_078_));
 sg13g2_nor2b_1 _171_ (.A(_077_),
    .B_N(_078_),
    .Y(_079_));
 sg13g2_xnor2_1 _172_ (.Y(_004_),
    .A(_072_),
    .B(_079_));
 sg13g2_nand2_1 _173_ (.Y(_080_),
    .A(\data_word[4] ),
    .B(net5));
 sg13g2_nand2_1 _174_ (.Y(_081_),
    .A(\u_dsm.integrator[4] ),
    .B(_075_));
 sg13g2_xor2_1 _175_ (.B(net6),
    .A(\data_word[5] ),
    .X(_082_));
 sg13g2_xnor2_1 _176_ (.Y(_083_),
    .A(\u_dsm.integrator[5] ),
    .B(_082_));
 sg13g2_and3_1 _177_ (.X(_084_),
    .A(_080_),
    .B(_081_),
    .C(_083_));
 sg13g2_a21oi_1 _178_ (.A1(_080_),
    .A2(_081_),
    .Y(_085_),
    .B1(_083_));
 sg13g2_nor2_1 _179_ (.A(_084_),
    .B(_085_),
    .Y(_086_));
 sg13g2_a21o_1 _180_ (.A2(_068_),
    .A1(_055_),
    .B1(_071_),
    .X(_087_));
 sg13g2_a21oi_1 _181_ (.A1(_087_),
    .A2(_079_),
    .Y(_088_),
    .B1(_077_));
 sg13g2_xnor2_1 _182_ (.Y(_005_),
    .A(_086_),
    .B(_088_));
 sg13g2_nand2_1 _183_ (.Y(_089_),
    .A(_079_),
    .B(_086_));
 sg13g2_nand3_1 _184_ (.B(_081_),
    .C(_083_),
    .A(_080_),
    .Y(_090_));
 sg13g2_a21oi_1 _185_ (.A1(_077_),
    .A2(_090_),
    .Y(_091_),
    .B1(_085_));
 sg13g2_o21ai_1 _186_ (.B1(_091_),
    .Y(_092_),
    .A1(_072_),
    .A2(_089_));
 sg13g2_nand2_1 _187_ (.Y(_093_),
    .A(\data_word[5] ),
    .B(net6));
 sg13g2_nand2_1 _188_ (.Y(_094_),
    .A(\u_dsm.integrator[5] ),
    .B(_082_));
 sg13g2_xor2_1 _189_ (.B(net6),
    .A(\data_word[6] ),
    .X(_095_));
 sg13g2_xnor2_1 _190_ (.Y(_096_),
    .A(\u_dsm.integrator[6] ),
    .B(_095_));
 sg13g2_a21oi_1 _191_ (.A1(_093_),
    .A2(_094_),
    .Y(_097_),
    .B1(_096_));
 sg13g2_nand3_1 _192_ (.B(_094_),
    .C(_096_),
    .A(_093_),
    .Y(_098_));
 sg13g2_nor2b_1 _193_ (.A(_097_),
    .B_N(_098_),
    .Y(_099_));
 sg13g2_xor2_1 _194_ (.B(_099_),
    .A(_092_),
    .X(_006_));
 sg13g2_nand2_1 _195_ (.Y(_100_),
    .A(\data_word[6] ),
    .B(net6));
 sg13g2_nand2_1 _196_ (.Y(_101_),
    .A(\u_dsm.integrator[6] ),
    .B(_095_));
 sg13g2_xnor2_1 _197_ (.Y(_102_),
    .A(\data_word[7] ),
    .B(\u_dsm.integrator[8] ));
 sg13g2_xnor2_1 _198_ (.Y(_103_),
    .A(\u_dsm.integrator[7] ),
    .B(_102_));
 sg13g2_a21oi_1 _199_ (.A1(_100_),
    .A2(_101_),
    .Y(_104_),
    .B1(_103_));
 sg13g2_nand3_1 _200_ (.B(_101_),
    .C(_103_),
    .A(_100_),
    .Y(_105_));
 sg13g2_nor2b_1 _201_ (.A(_104_),
    .B_N(_105_),
    .Y(_106_));
 sg13g2_a21oi_1 _202_ (.A1(_092_),
    .A2(_099_),
    .Y(_107_),
    .B1(_097_));
 sg13g2_xnor2_1 _203_ (.Y(_007_),
    .A(_106_),
    .B(_107_));
 sg13g2_and2_1 _204_ (.A(_099_),
    .B(_106_),
    .X(_108_));
 sg13g2_a221oi_1 _205_ (.B2(_092_),
    .C1(_104_),
    .B1(_108_),
    .A1(_097_),
    .Y(_109_),
    .A2(_105_));
 sg13g2_nor2b_1 _206_ (.A(\u_dsm.integrator[8] ),
    .B_N(\data_word[7] ),
    .Y(_110_));
 sg13g2_a21oi_1 _207_ (.A1(\u_dsm.integrator[7] ),
    .A2(_102_),
    .Y(_111_),
    .B1(_110_));
 sg13g2_xor2_1 _208_ (.B(_111_),
    .A(\data_word[8] ),
    .X(_112_));
 sg13g2_xnor2_1 _209_ (.Y(_008_),
    .A(_109_),
    .B(_112_));
 sg13g2_xnor2_1 _210_ (.Y(_000_),
    .A(\data_word[0] ),
    .B(_047_));
 sg13g2_inv_1 _211_ (.Y(\uut.pre45.d2 ),
    .A(\uut.pre45.ff1.q ));
 sg13g2_inv_1 _212_ (.Y(\uut.div4.dff2.d ),
    .A(\uut.div4.dff2.q ));
 sg13g2_inv_1 _213_ (.Y(\uut.out_stg.dff_out.d ),
    .A(net7));
 sg13g2_inv_1 _214_ (.Y(\uut.div4.dff1.d ),
    .A(\uut.div4.dff1.q ));
 sg13g2_inv_1 _215_ (.Y(_009_),
    .A(net8));
 sg13g2_inv_1 _216_ (.Y(_010_),
    .A(net8));
 sg13g2_inv_1 _217_ (.Y(_011_),
    .A(net8));
 sg13g2_inv_1 _218_ (.Y(_012_),
    .A(net8));
 sg13g2_inv_1 _219_ (.Y(_013_),
    .A(net8));
 sg13g2_inv_1 _220_ (.Y(_014_),
    .A(net8));
 sg13g2_inv_1 _221_ (.Y(_015_),
    .A(net8));
 sg13g2_inv_1 _222_ (.Y(_016_),
    .A(net9));
 sg13g2_inv_1 _223_ (.Y(_017_),
    .A(net9));
 sg13g2_inv_1 _224_ (.Y(_018_),
    .A(net8));
 sg13g2_inv_1 _225_ (.Y(_019_),
    .A(net11));
 sg13g2_inv_1 _226_ (.Y(_020_),
    .A(net11));
 sg13g2_inv_1 _227_ (.Y(_021_),
    .A(net11));
 sg13g2_inv_1 _228_ (.Y(_022_),
    .A(net11));
 sg13g2_inv_1 _229_ (.Y(_023_),
    .A(net10));
 sg13g2_inv_1 _230_ (.Y(_024_),
    .A(net10));
 sg13g2_inv_1 _231_ (.Y(_025_),
    .A(net9));
 sg13g2_inv_1 _232_ (.Y(_026_),
    .A(net9));
 sg13g2_inv_1 _233_ (.Y(_027_),
    .A(net11));
 sg13g2_inv_1 _234_ (.Y(_028_),
    .A(net10));
 sg13g2_inv_1 _235_ (.Y(_029_),
    .A(net10));
 sg13g2_inv_1 _236_ (.Y(_030_),
    .A(net10));
 sg13g2_inv_1 _237_ (.Y(_031_),
    .A(net10));
 sg13g2_inv_1 _238_ (.Y(_032_),
    .A(net11));
 sg13g2_inv_1 _239_ (.Y(_033_),
    .A(net11));
 sg13g2_inv_1 _240_ (.Y(_034_),
    .A(net10));
 sg13g2_inv_1 _241_ (.Y(_035_),
    .A(net10));
 sg13g2_dfrbpq_1 _242_ (.RESET_B(_009_),
    .D(_036_),
    .Q(\data_word[0] ),
    .CLK(clknet_1_0__leaf_sclk));
 sg13g2_dfrbpq_1 _243_ (.RESET_B(_010_),
    .D(_037_),
    .Q(\data_word[1] ),
    .CLK(clknet_1_0__leaf_sclk));
 sg13g2_dfrbpq_1 _244_ (.RESET_B(_011_),
    .D(_038_),
    .Q(\data_word[2] ),
    .CLK(clknet_1_0__leaf_sclk));
 sg13g2_dfrbpq_1 _245_ (.RESET_B(_012_),
    .D(_039_),
    .Q(\data_word[3] ),
    .CLK(clknet_1_0__leaf_sclk));
 sg13g2_dfrbpq_1 _246_ (.RESET_B(_013_),
    .D(_040_),
    .Q(\data_word[4] ),
    .CLK(clknet_1_0__leaf_sclk));
 sg13g2_dfrbpq_1 _247_ (.RESET_B(_014_),
    .D(_041_),
    .Q(\data_word[5] ),
    .CLK(clknet_1_1__leaf_sclk));
 sg13g2_dfrbpq_1 _248_ (.RESET_B(_015_),
    .D(_042_),
    .Q(\data_word[6] ),
    .CLK(clknet_1_1__leaf_sclk));
 sg13g2_dfrbpq_1 _249_ (.RESET_B(_016_),
    .D(_043_),
    .Q(\data_word[7] ),
    .CLK(clknet_1_1__leaf_sclk));
 sg13g2_dfrbpq_1 _250_ (.RESET_B(_017_),
    .D(_044_),
    .Q(\data_word[8] ),
    .CLK(clknet_1_1__leaf_sclk));
 sg13g2_dfrbpq_1 _251_ (.RESET_B(_018_),
    .D(_000_),
    .Q(\u_dsm.integrator[0] ),
    .CLK(net7));
 sg13g2_dfrbpq_1 _252_ (.RESET_B(_019_),
    .D(_001_),
    .Q(\u_dsm.integrator[1] ),
    .CLK(net7));
 sg13g2_dfrbpq_1 _253_ (.RESET_B(_020_),
    .D(_002_),
    .Q(\u_dsm.integrator[2] ),
    .CLK(net7));
 sg13g2_dfrbpq_1 _254_ (.RESET_B(_021_),
    .D(_003_),
    .Q(\u_dsm.integrator[3] ),
    .CLK(net7));
 sg13g2_dfrbpq_1 _255_ (.RESET_B(_022_),
    .D(_004_),
    .Q(\u_dsm.integrator[4] ),
    .CLK(net7));
 sg13g2_dfrbpq_1 _256_ (.RESET_B(_023_),
    .D(_005_),
    .Q(\u_dsm.integrator[5] ),
    .CLK(net7));
 sg13g2_dfrbpq_1 _257_ (.RESET_B(_024_),
    .D(_006_),
    .Q(\u_dsm.integrator[6] ),
    .CLK(net4));
 sg13g2_dfrbpq_1 _258_ (.RESET_B(_025_),
    .D(_007_),
    .Q(\u_dsm.integrator[7] ),
    .CLK(net4));
 sg13g2_dfrbpq_1 _259_ (.RESET_B(_026_),
    .D(_008_),
    .Q(\u_dsm.integrator[8] ),
    .CLK(net4));
 sg13g2_dfrbpq_1 _260_ (.RESET_B(_027_),
    .D(\uut.out_stg.dff_out.d ),
    .Q(net4),
    .CLK(\uut.d ));
 sg13g2_dfrbpq_1 _261_ (.RESET_B(_028_),
    .D(\uut.mod7.jk1.d_in ),
    .Q(\uut.b ),
    .CLK(\uut.clk_jk ));
 sg13g2_dfrbpq_1 _262_ (.RESET_B(_029_),
    .D(\uut.mod7.jk2.d_in ),
    .Q(\uut.c ),
    .CLK(\uut.clk_jk ));
 sg13g2_dfrbpq_1 _263_ (.RESET_B(_030_),
    .D(\uut.mod7.jk3.d_in ),
    .Q(\uut.d ),
    .CLK(\uut.clk_jk ));
 sg13g2_dfrbpq_1 _264_ (.RESET_B(_031_),
    .D(\uut.pre45.d1 ),
    .Q(\uut.pre45.ff1.q ),
    .CLK(\uut.div4.dff2.q ));
 sg13g2_dfrbpq_1 _265_ (.RESET_B(_032_),
    .D(\uut.pre45.d2 ),
    .Q(\uut.pre45.d3 ),
    .CLK(\uut.div4.dff2.q ));
 sg13g2_dfrbpq_1 _266_ (.RESET_B(_033_),
    .D(\uut.pre45.d3 ),
    .Q(\uut.clk_jk ),
    .CLK(\uut.div4.dff2.q ));
 sg13g2_dfrbpq_1 _267_ (.RESET_B(_034_),
    .D(\uut.div4.dff1.d ),
    .Q(\uut.div4.dff1.q ),
    .CLK(freq_in));
 sg13g2_dfrbpq_1 _268_ (.RESET_B(_035_),
    .D(\uut.div4.dff2.d ),
    .Q(\uut.div4.dff2.q ),
    .CLK(\uut.div4.dff1.q ));
 sg13g2_buf_16 clkbuf_0_sclk (.X(clknet_0_sclk),
    .A(sclk));
 sg13g2_buf_16 clkbuf_1_0__f_sclk (.X(clknet_1_0__leaf_sclk),
    .A(clknet_0_sclk));
 sg13g2_buf_16 clkbuf_1_1__f_sclk (.X(clknet_1_1__leaf_sclk),
    .A(clknet_0_sclk));
 sg13g2_inv_1 clkload0 (.A(clknet_1_1__leaf_sclk));
 sg13g2_buf_1 fanout10 (.A(net11),
    .X(net10));
 sg13g2_buf_1 fanout11 (.A(net2),
    .X(net11));
 sg13g2_buf_1 fanout5 (.A(net6),
    .X(net5));
 sg13g2_buf_1 fanout6 (.A(\u_dsm.integrator[8] ),
    .X(net6));
 sg13g2_buf_1 fanout7 (.A(net4),
    .X(net7));
 sg13g2_buf_1 fanout8 (.A(net2),
    .X(net8));
 sg13g2_buf_1 fanout9 (.A(net2),
    .X(net9));
 sg13g2_buf_1 input1 (.A(en),
    .X(net1));
 sg13g2_buf_1 input2 (.A(rst),
    .X(net2));
 sg13g2_buf_1 input3 (.A(sdata),
    .X(net3));
 sg13g2_buf_1 output4 (.A(net7),
    .X(freq_out));
endmodule
