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

 sg13g2_mux2_1 _117_ (.A0(\data_word[8] ),
    .A1(\data_word[7] ),
    .S(en),
    .X(_044_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_mux2_1 _118_ (.A0(\data_word[7] ),
    .A1(\data_word[6] ),
    .S(en),
    .X(_043_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_mux2_1 _119_ (.A0(\data_word[6] ),
    .A1(\data_word[5] ),
    .S(en),
    .X(_042_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_mux2_1 _120_ (.A0(\data_word[5] ),
    .A1(\data_word[4] ),
    .S(en),
    .X(_041_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_mux2_1 _121_ (.A0(\data_word[4] ),
    .A1(\data_word[3] ),
    .S(en),
    .X(_040_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_mux2_1 _122_ (.A0(\data_word[3] ),
    .A1(\data_word[2] ),
    .S(en),
    .X(_039_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_mux2_1 _123_ (.A0(\data_word[2] ),
    .A1(\data_word[1] ),
    .S(en),
    .X(_038_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_mux2_1 _124_ (.A0(\data_word[1] ),
    .A1(\data_word[0] ),
    .S(en),
    .X(_037_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_mux2_1 _125_ (.A0(\data_word[0] ),
    .A1(sdata),
    .S(en),
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
    .A1(\u_dsm.integrator[8] ),
    .A2(_113_));
 sg13g2_and2_1 _135_ (.A(\uut.pre45.d3 ),
    .B(_046_),
    .X(\uut.pre45.d1 ),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xor2_1 _136_ (.B(\u_dsm.integrator[0] ),
    .A(\u_dsm.integrator[8] ),
    .X(_047_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand2b_1 _137_ (.Y(_048_),
    .B(\data_word[0] ),
    .A_N(_047_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nor2_1 _138_ (.A(\u_dsm.integrator[8] ),
    .B(\u_dsm.integrator[0] ),
    .Y(_049_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xor2_1 _139_ (.B(\u_dsm.integrator[8] ),
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
    .B(\u_dsm.integrator[8] ),
    .X(_056_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21oi_1 _147_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(\u_dsm.integrator[1] ),
    .A2(_050_),
    .Y(_057_),
    .B1(_056_));
 sg13g2_xor2_1 _148_ (.B(\u_dsm.integrator[8] ),
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
    .B(\u_dsm.integrator[8] ),
    .X(_061_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21oi_1 _153_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(\u_dsm.integrator[2] ),
    .A2(_058_),
    .Y(_062_),
    .B1(_061_));
 sg13g2_xor2_1 _154_ (.B(\u_dsm.integrator[8] ),
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
    .B(\u_dsm.integrator[8] ),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand2_1 _166_ (.Y(_074_),
    .A(\u_dsm.integrator[3] ),
    .B(_063_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xor2_1 _167_ (.B(\u_dsm.integrator[8] ),
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
    .B(\u_dsm.integrator[8] ),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand2_1 _174_ (.Y(_081_),
    .A(\u_dsm.integrator[4] ),
    .B(_075_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xor2_1 _175_ (.B(\u_dsm.integrator[8] ),
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
    .B(\u_dsm.integrator[8] ),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand2_1 _188_ (.Y(_094_),
    .A(\u_dsm.integrator[5] ),
    .B(_082_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xor2_1 _189_ (.B(\u_dsm.integrator[8] ),
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
    .B(\u_dsm.integrator[8] ),
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
    .A(freq_out),
    .VSS(VGND));
 sg13g2_inv_1 _214_ (.VDD(VPWR),
    .Y(\uut.div4.dff1.d ),
    .A(\uut.div4.dff1.q ),
    .VSS(VGND));
 sg13g2_inv_1 _215_ (.VDD(VPWR),
    .Y(_009_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _216_ (.VDD(VPWR),
    .Y(_010_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _217_ (.VDD(VPWR),
    .Y(_011_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _218_ (.VDD(VPWR),
    .Y(_012_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _219_ (.VDD(VPWR),
    .Y(_013_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _220_ (.VDD(VPWR),
    .Y(_014_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _221_ (.VDD(VPWR),
    .Y(_015_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _222_ (.VDD(VPWR),
    .Y(_016_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _223_ (.VDD(VPWR),
    .Y(_017_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _224_ (.VDD(VPWR),
    .Y(_018_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _225_ (.VDD(VPWR),
    .Y(_019_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _226_ (.VDD(VPWR),
    .Y(_020_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _227_ (.VDD(VPWR),
    .Y(_021_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _228_ (.VDD(VPWR),
    .Y(_022_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _229_ (.VDD(VPWR),
    .Y(_023_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _230_ (.VDD(VPWR),
    .Y(_024_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _231_ (.VDD(VPWR),
    .Y(_025_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _232_ (.VDD(VPWR),
    .Y(_026_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _233_ (.VDD(VPWR),
    .Y(_027_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _234_ (.VDD(VPWR),
    .Y(_028_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _235_ (.VDD(VPWR),
    .Y(_029_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _236_ (.VDD(VPWR),
    .Y(_030_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _237_ (.VDD(VPWR),
    .Y(_031_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _238_ (.VDD(VPWR),
    .Y(_032_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _239_ (.VDD(VPWR),
    .Y(_033_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _240_ (.VDD(VPWR),
    .Y(_034_),
    .A(rst),
    .VSS(VGND));
 sg13g2_inv_1 _241_ (.VDD(VPWR),
    .Y(_035_),
    .A(rst),
    .VSS(VGND));
 sg13g2_dfrbpq_1 _242_ (.RESET_B(_009_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_036_),
    .Q(\data_word[0] ),
    .CLK(sclk));
 sg13g2_dfrbpq_1 _243_ (.RESET_B(_010_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_037_),
    .Q(\data_word[1] ),
    .CLK(sclk));
 sg13g2_dfrbpq_1 _244_ (.RESET_B(_011_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_038_),
    .Q(\data_word[2] ),
    .CLK(sclk));
 sg13g2_dfrbpq_1 _245_ (.RESET_B(_012_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_039_),
    .Q(\data_word[3] ),
    .CLK(sclk));
 sg13g2_dfrbpq_1 _246_ (.RESET_B(_013_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_040_),
    .Q(\data_word[4] ),
    .CLK(sclk));
 sg13g2_dfrbpq_1 _247_ (.RESET_B(_014_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_041_),
    .Q(\data_word[5] ),
    .CLK(sclk));
 sg13g2_dfrbpq_1 _248_ (.RESET_B(_015_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_042_),
    .Q(\data_word[6] ),
    .CLK(sclk));
 sg13g2_dfrbpq_1 _249_ (.RESET_B(_016_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_043_),
    .Q(\data_word[7] ),
    .CLK(sclk));
 sg13g2_dfrbpq_1 _250_ (.RESET_B(_017_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_044_),
    .Q(\data_word[8] ),
    .CLK(sclk));
 sg13g2_dfrbpq_1 _251_ (.RESET_B(_018_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_000_),
    .Q(\u_dsm.integrator[0] ),
    .CLK(freq_out));
 sg13g2_dfrbpq_1 _252_ (.RESET_B(_019_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_001_),
    .Q(\u_dsm.integrator[1] ),
    .CLK(freq_out));
 sg13g2_dfrbpq_1 _253_ (.RESET_B(_020_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_002_),
    .Q(\u_dsm.integrator[2] ),
    .CLK(freq_out));
 sg13g2_dfrbpq_1 _254_ (.RESET_B(_021_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_003_),
    .Q(\u_dsm.integrator[3] ),
    .CLK(freq_out));
 sg13g2_dfrbpq_1 _255_ (.RESET_B(_022_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_004_),
    .Q(\u_dsm.integrator[4] ),
    .CLK(freq_out));
 sg13g2_dfrbpq_1 _256_ (.RESET_B(_023_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_005_),
    .Q(\u_dsm.integrator[5] ),
    .CLK(freq_out));
 sg13g2_dfrbpq_1 _257_ (.RESET_B(_024_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_006_),
    .Q(\u_dsm.integrator[6] ),
    .CLK(freq_out));
 sg13g2_dfrbpq_1 _258_ (.RESET_B(_025_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_007_),
    .Q(\u_dsm.integrator[7] ),
    .CLK(freq_out));
 sg13g2_dfrbpq_1 _259_ (.RESET_B(_026_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_008_),
    .Q(\u_dsm.integrator[8] ),
    .CLK(freq_out));
 sg13g2_dfrbpq_1 _260_ (.RESET_B(_027_),
    .VSS(VGND),
    .VDD(VPWR),
    .D(\uut.out_stg.dff_out.d ),
    .Q(freq_out),
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
endmodule
