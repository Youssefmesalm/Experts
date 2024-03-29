//+------------------------------------------------------------------+
//|                                                   BOTT_NEW_1.mq4 |
//+------------------------------------------------------------------+
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                          boturbotrader@gmail.com |
//+------------------------------------------------------------------+ ستاپ های جدید توسط بن تیلور
#property description " http://www.youtube.com/c/boturbotrader"
#property description " "
#property description " boturbotrader@gmail.com"
#property description " "
#property description " © 2021 BOTT"
#property strict
#define ARROW_UP   233
#define ARROW_DOWN 234
//--
int flag_reversal_Eng_up = 0, flag_reversal_Eng_down = 0;
int flag_reversal_MS_up  = 0, flag_reversal_ES_down  = 0;
int flag_reversal_MDS_up = 0, flag_reversal_EDS_down = 0;
int flag_reversal_PL_up  = 0, flag_reversal_DC_down  = 0;
bool btn_status = true;
input color InpLineColor_up = clrGreen;
input color InpLineColor_down = clrRed;
datetime Time_Analyse_0_up  = 0;
datetime Time_Analyse_0_down  = 0;
int Find_Analys_0 = -1;
bool false_PoE  = true;
bool false_PoE_3sarbaz_3kalagh  = true;
bool false_DPoE = true;
bool false_DPoE_3sarbaz_3kalagh = true;
input bool shoW_line_highest_lowest  = true;

//+------------------------------------------------------------------+  3WS/3BC
string IIIIIIIIIIIIIIIIII_WS_3BC_IIIIIIIIIIIIIIIIII ;
bool _3WS_3BC = false; // 3WS/3BC
bool Small_to_Big = true; // Small to big
//+------------------------------------------------------------------+  3WSP_3BCP
string IIIIIIIIIIIIIIIIII_3WSP_3BCP_IIIIIIIIIIIIIIIIII ;
bool _3WSP_ = false; // 3WSP/3BCP
//+------------------------------------------------------------------+  DC_PL
string IIIIIIIIIIIIIIIIII_DC_PL_IIIIIIIIIIIIIIIIII ;
bool Dark_Cloud_Piercing_DC_PL = false; // Dark Cloud/Piercing Line (DC/PL)
bool DC_PL_outside_2_Dev       = false; // Outside 2 Dev
bool DC_PL_2_EMA_breakout      = false; // 2 EMA Breakout
bool DC_PL_close_at_key_level  = false; // Close at key level
bool DC_PL_Body_to_Wick        = false; // Body to wick ratio
int  DC_PL_body_size_percent   = 50;    // Body Size %
//+------------------------------------------------------------------+  PoE
string IIIIIIIIIIIIIIIIII_PoE_IIIIIIIIIIIIIIIIII ;
bool PoE = false;
//+------------------------------------------------------------------+  DPoE
string IIIIIIIIIIIIIIIIII_DPoE_IIIIIIIIIIIIIIIIII ;
bool DPoE = false;
//+------------------------------------------------------------------+  EDS_MDS
string IIIIIIIIIIIIIIIIII_EDS_MDS_IIIIIIIIIIIIIIIIII;
bool   EDS_MDS = false; // EDS/MDS
bool   _outside_2_Dev_EDS_MDS   = true;
bool   _3rd_Huge_candle_EDS_MDS = true;
double _middle_candle_size_EDS_MDS = 5;
bool   _Body_to_Wick_EDS_MDS = true;
double _3rd_Huge_candle_size_EDS_MDS = 3;
bool   _3rd_to_Middle_candle_raio_EDS_MDS = true;
bool   _3rd_Tiny_candle_EDS_MDS = true;
double _3rd_Tiny_candle_size_EDS_MDS = 3;
bool   _3rd_candle_body_breakout_EDS_MDS = true;
bool   _3rd_candle_wick_breakout_EDS_MDS = true;
bool   _2_EMA_breakout_EDS_MDS = true;
bool   _close_at_key_level_EDS_MDS = true;
double _3rd_to_Middle_candle_size_EDS_MDS = 5;
int    _body_size_percent_EDS_MDS = 50;
//+------------------------------------------------------------------+  ES_MS
string IIIIIIIIIIIIIIIIII_ES_MS_IIIIIIIIIIIIIIIIII ;
bool   ES_MS = false; // ES/MS
double ES_MS_middle_candle_size_ES_MS = 8; // 2nd to 1st candle smallness ratio
bool   ES_MS_outside_2_Dev_ES_MS   = false;
bool   ES_MS_3rd_Huge_candle_ES_MS = true; //  How huge 3rd to 1st candle
double ES_MS_3rd_Huge_candle_size_ES_MS = 8;  // 3rd to 1st candle bigness ratio
bool   ES_MS_3rd_Tiny_candle_ES_MS = true; // How small 3rd to 1st candle size
double ES_MS_3rd_Tiny_candle_size_ES_MS = 8; // 3rd to 1st candle smallness ratio
bool   ES_MS_3rd_candle_body_breakout_ES_MS = false;
bool   ES_MS_3rd_candle_wick_breakout_ES_MS = false;
bool   ES_MS_2_EMA_breakout_ES_MS     = false;
bool   ES_MS_close_at_key_level_ES_MS = false;
bool  ES_MS_3rd_to_Middle_candle_raio_ES_MS = true; //
double ES_MS_3rd_to_Middle_candle_size_ES_MS = 8;
bool   ES_MS_Body_to_Wick_ES_MS = false; // 3rd candle body to wick ratio
int    ES_MS_body_size_percent_ES_MS = 50; // 3rd candle body to wick ratio in %
//+------------------------------------------------------------------+  EMS_50  //MS50/ES50
string IIIIIIIIIIIIIIIIII_EMS_50_IIIIIIIIIIIIIIIIII;
bool   ES_50_MS_50 = false; // MS50/ES50
int    EMs_at_50_middle_candle_size_EMS_50 = 3; // 2nd to 1st candle smallness ratio
//+------------------------------------------------------------------+  EMS_EES (EMS_Equal)
string IIIIIIIIIIIIIIIIII_EMS_Equal_IIIIIIIIIIIIIIIIII ;
bool EMS_Equal = false; // EMS/EES
int Equal_middle_candle_size_EMS_Equal = 3;// 2nd to 1st candle smallness ratio

//+------------------------------------------------------------------+  Eng
string IIIIIIIIIIIIIIIIII_Eng_IIIIIIIIIIIIIIIIII;
bool Eng = false; // Eng
bool Eng_engulfing_candle_ratio = true; // Engulfing candle ratio
int  Eng_Max_engulfing_percent = 50; // Max Eng %
int  Eng_Min_engulfing_percent = 20; // Min Eng %
bool Eng_outside_2_Dev = false;
bool Eng_2_EMA_breakout = false;
bool Eng_close_at_key_level = false;
bool Eng_Shaven_head = false;
bool Eng_Body_breakout = false;
bool Eng_Body_to_Wick = false;
int  Eng_body_size_percent = 50; //
//+------------------------------------------------------------------+  EXP
string IIIIIIIIIIIIIIIIII_EXP_IIIIIIIIIIIIIIIIII;
bool EXP = false;
bool Band_1_EXP = false;
bool Band_2_EXP = false;
bool FB_EXP = false;
//+------------------------------------------------------------------+  EXRC
string IIIIIIIIIIIIIIIIII_EXRC_IIIIIIIIIIIIIIIIII;
bool EXRC = false;
bool Band_1_EXRC = true;
bool Band_2_EXRC = true;
bool mosave_bodan_high_low_2_candle_EXRC = true;
bool Band_1_5_for_candel_1_EXRC = true;
//input bool Band_2_for_candel_1_EXRC   = true;
//+------------------------------------------------------------------+  NRS
string IIIIIIIIIIIIIIIIII_NRS_IIIIIIIIIIIIIIIIII;
bool NRS = false;
bool NRS_Constriction_NRS     = false;
bool NRS_on_2_dev_NRS         = false;
bool sayeh_Candle_1_NRS       = false;
int  multi_ply_NRS = 3 ;
bool Close_balay_pain_ema200_Fake_NRS = false;
bool Huge_Candle_NRS                  = false;
bool badane_candle_1_25_percent_NRS    = true; // body breakout
//+------------------------------------------------------------------+  FNRS
string IIIIIIIIIIIIIIIIII_FNRS_IIIIIIIIIIIIIIIIII ;
bool No_rejection_setup_FNRS = false; // FNRS
bool FNRS_Constriction = false;
bool Huge_Candle_FNRS = true; // 2nd to 3rd candle bigness
int  multi_ply_FNRS = 2 ;   // 2nd to 3rd candle bigness ratio
bool badane_candle_1_25_darsad_FNRS = true;
bool sayeh_Candle_1_FNRS = false;
bool nesbat_sayh_candel_1_be_badaneh_khodash_FNRS = false;
bool Close_balay_pain_ema200_FNRS = false;
bool size_candele_1_nesbat_be_candel_2_FNRS = false;
int  size_candle_2_FNRS = 4 ;
bool badaneh_candele_1_nesbat_be_sayehha_2_3_FNRS = false;
//+------------------------------------------------------------------+ NRSP
string IIIIIIIIIIIIIIIIII_NRSP_IIIIIIIIIIIIIIIIII ;
bool NRSP = false;
//+------------------------------------------------------------------+  SS9
string IIIIIIIIIIIIIIIIII_SS9_IIIIIIIIIIIIIIIIII ;
input bool SnR = true; // SS9
input bool Show_arrow_SnR = true; // Show the root candle
int  min_distance_snr = 4 ; // Min distance from the root Candle
int  max_distance_snr = 20 ; // Max distance from the root Candle
double High_2 = 0;
double Close_2_buy = 0, Open_2_buy = 0;
double Low_2 = 0;
double Close_2_sell = 0, Open_2_sell = 0;
int    segnal_buy  = 0 ;
int    segnal_sell = 0 ;
int    pattern_signal_sell = 0, pattern_signal_buy = 0;
datetime pastTime_sell, pastTime_buy;
datetime time_candel_1_buy, time_candel_1_sell,
         time_candel_2_sell, time_candel_2_buy ;
//+------------------------------------------------------------------+  FB
string IIIIIIIIIIIIIIIIII_FB_IIIIIIIIIIIIIIIIII ;
bool FB = false;
bool Band_1_FB = true;
bool Band_2_FB = true;
bool AFTER_REVERSAL = true;  // After Reversal
bool Analyse_reversal = true; // Reversal Analysis
bool Show_arrow_reversal = true; // Show Reversal patterns

bool Show_Analyse_reversal_0  = true;
//+------------------------------------------------------------------+  EXC
input bool EXC = true; //EXC
//+------------------------------------------------------------------+  EXR
input bool EXR = true; //EXR
//+------------------------------------------------------------------+  shoting_s_1
input bool shoting_s_1 = true; //SST 1
//+------------------------------------------------------------------+  shoting_s_2
input bool shoting_s_2 = true; //SST 2
//+------------------------------------------------------------------+  shoting_s_3
input bool shoting_s_3 = true; //SST 3
//+------------------------------------------------------------------+  shoting_s_4
input bool shoting_s_4 = true; //SST 4
//-------------------------------------------------------------------+  marubozu
input bool marubozu = true; //MA
//-------------------------------------------------------------------+  dragonfly
input bool dragonfly = true; //DF/GS
//-------------------------------------------------------------------+  gravestone
bool gravestone = false; // GS
//-------------------------------------------------------------------+  gap
input bool gap = true; // GU GD
//-------------------------------------------------------------------+  inverted_hammer
input bool inverted_hammer = true; //IHA
//-------------------------------------------------------------------+  EES_1
input bool EES_1 = true; // EES
//-------------------------------------------------------------------+  EMS_1
input bool EMS_1 = true; //EMS
//-------------------------------------------------------------------+  NRS_1
input bool NRS_1 = true; //NRS
//-------------------------------------------------------------------+  MS50_1
input bool MS50_1 = true; // MS50
//-------------------------------------------------------------------+  ES50_1
input bool ES50_1 = true; // ES50
//-------------------------------------------------------------------+  Hanging Man
input bool Hanging_man = true; // HM
//-------------------------------------------------------------------+  Harami
input bool Harami = true; // HAR
//-------------------------------------------------------------------+  HHLL
input bool HHLL = true; // HH LL
//-------------------------------------------------------------------+  ENG_1
input bool eng_1 = true; // ENG 1
//-------------------------------------------------------------------+  ENG_2
input bool eng_2 = true; // ENG 2
//-------------------------------------------------------------------+  ENG_3
input bool eng_3 = true; // ENG 3
//-------------------------------------------------------------------+  ENG_4
input bool eng_4 = true; // ENG 4
//-------------------------------------------------------------------+  ENG_5
input bool eng_5 = true; // ENG 5
//-------------------------------------------------------------------+  ENG_6
input bool eng_6 = true; // ENG 6
//-------------------------------------------------------------------+  ENG_7
input bool eng_7 = true; // ENG 7
//-------------------------------------------------------------------+  DC_1
input bool dc_1 = true; // DC 1
//-------------------------------------------------------------------+  DC_2
input bool dc_2 = true; // DC 2
//-------------------------------------------------------------------+  huge_candle_1
input bool huge_candle_1 = true; // HC 1
//-------------------------------------------------------------------+  huge_candle_2
input bool huge_candle_2 = true; // HC 2
//-------------------------------------------------------------------+  huge_candle_3
input bool huge_candle_3 = true; // HC 3
//-------------------------------------------------------------------+  ms_buy_1_es_1
input bool ms_buy_1_es_1 = true; // MS ES 1
//-------------------------------------------------------------------+  ms_buy_1_es_2
input bool ms_buy_1_es_2 = true; // MS ES 2
//-------------------------------------------------------------------+  tws_put_1_tbc
input bool tws_put_1_tbc = true;  // TWS TBC 1
//-------------------------------------------------------------------+  tws_put_2_tbc
input bool tws_put_2_tbc = true;  // TWS TBC 2
//-------------------------------------------------------------------+  tws_put_3_tbc
input bool tws_put_3_tbc = true;  // TWS TBC 3
//-------------------------------------------------------------------+  tws_put_4_tbc
input bool tws_put_4_tbc = true;  // TWS TBC 4
//-------------------------------------------------------------------+  Hammer
input bool Hammer = true; // HA
input int shift_candel = 3;
//-------------------------------------------------------------------+  G_Hammer
input bool G_Hammer = true; // HA
//-------------------------------------------------------------------+  twzb_call_1_twzt_put
input bool twzb_call_1_twzt_put = true;  // TWZB TWZT
//-------------------------------------------------------------------+  call_reversal_put_reversal
input bool call_reversal_put_reversal = true; // RC RS
//-------------------------------------------------------------------+  minor_put_minor_call
input bool minor_put_minor_call = true; // MIU MID
//-------------------------------------------------------------------+  poe_1
input bool poe_1 = true; // POE 1
//-------------------------------------------------------------------+  poe_2
input bool poe_2 = true; // POE 2






string   arrow_name_up, arrow_name_down;
datetime time_up, time_down;
double   price_up, price_down;
//-------------------------------------------------------------------+ 3WS
string   arrow_name_up_3WS, arrow_name_down_3WS;
datetime time_up_3WS, time_down_3WS ;
double   price_up_3WS, price_down_3WS ;
//-------------------------------------------------------------------+ 3BC
string   arrow_name_up_3BC, arrow_name_down_3BC;
datetime time_up_3BC, time_down_3BC ;
double   price_up_3BC, price_down_3BC ;
//-------------------------------------------------------------------+ 3BCP
string   arrow_name_up_3BCP, arrow_name_down_3BCP;
datetime time_up_3BCP, time_down_3BCP ;
double   price_up_3BCP, price_down_3BCP ;
//-------------------------------------------------------------------+ 3WSP
string   arrow_name_up_3WSP, arrow_name_down_3WSP;
datetime time_up_3WSP, time_down_3WSP ;
double   price_up_3WSP, price_down_3WSP ;
//-------------------------------------------------------------------+ PL 0
string   arrow_name_up_PL, arrow_name_down_PL;
datetime time_up_PL, time_down_PL ;
double   price_up_PL, price_down_PL ;
//-------------------------------------------------------------------+ DC 0
string   arrow_name_up_DC, arrow_name_down_DC;
datetime time_up_DC, time_down_DC ;
double   price_up_DC, price_down_DC ;
//-------------------------------------------------------------------+ PL 1
string   arrow_name_up_PL_1, arrow_name_down_PL_1;
datetime time_up_PL_1, time_down_PL_1 ;
double   price_up_PL_1, price_down_PL_1 ;
//-------------------------------------------------------------------+ DC 1
string   arrow_name_up_DC_1, arrow_name_down_DC_1;
datetime time_up_DC_1, time_down_DC_1 ;
double   price_up_DC_1, price_down_DC_1 ;
//-------------------------------------------------------------------+ PoE 0
string   arrow_name_up_PoE, arrow_name_down_PoE;
datetime time_up_PoE, time_down_PoE ;
double   price_up_PoE, price_down_PoE ;
//-------------------------------------------------------------------+ PoE 1
string   arrow_name_up_PoE_1, arrow_name_down_PoE_1;
datetime time_up_PoE_1, time_down_PoE_1 ;
double   price_up_PoE_1, price_down_PoE_1 ;
//-------------------------------------------------------------------+ PoE 2
string   arrow_name_up_PoE_2, arrow_name_down_PoE_2;
datetime time_up_PoE_2, time_down_PoE_2 ;
double   price_up_PoE_2, price_down_PoE_2 ;
//-------------------------------------------------------------------+ PoE 3
string   arrow_name_up_PoE_3, arrow_name_down_PoE_3;
datetime time_up_PoE_3, time_down_PoE_3 ;
double   price_up_PoE_3, price_down_PoE_3 ;
//-------------------------------------------------------------------+ PoE 4
string   arrow_name_up_PoE_4, arrow_name_down_PoE_4;
datetime time_up_PoE_4, time_down_PoE_4 ;
double   price_up_PoE_4, price_down_PoE_4 ;
//-------------------------------------------------------------------+ PoE 5
string   arrow_name_up_PoE_5, arrow_name_down_PoE_5;
datetime time_up_PoE_5, time_down_PoE_5 ;
double   price_up_PoE_5, price_down_PoE_5 ;
//-------------------------------------------------------------------+ PoE 6
string   arrow_name_up_PoE_6, arrow_name_down_PoE_6;
datetime time_up_PoE_6, time_down_PoE_6 ;
double   price_up_PoE_6, price_down_PoE_6 ;
//-------------------------------------------------------------------+ PoE 7
string   arrow_name_up_PoE_7, arrow_name_down_PoE_7;
datetime time_up_PoE_7, time_down_PoE_7 ;
double   price_up_PoE_7, price_down_PoE_7 ;
//-------------------------------------------------------------------+ PoE 8
string   arrow_name_up_PoE_8, arrow_name_down_PoE_8;
datetime time_up_PoE_8, time_down_PoE_8 ;
double   price_up_PoE_8, price_down_PoE_8 ;
//-------------------------------------------------------------------+ PoE 9
string   arrow_name_up_PoE_9, arrow_name_down_PoE_9;
datetime time_up_PoE_9, time_down_PoE_9 ;
double   price_up_PoE_9, price_down_PoE_9 ;
//-------------------------------------------------------------------+ PoE 10
string   arrow_name_up_PoE_10, arrow_name_down_PoE_10;
datetime time_up_PoE_10, time_down_PoE_10 ;
double   price_up_PoE_10, price_down_PoE_10 ;
//-------------------------------------------------------------------+ PoE 11
string   arrow_name_up_PoE_11, arrow_name_down_PoE_11;
datetime time_up_PoE_11, time_down_PoE_11 ;
double   price_up_PoE_11, price_down_PoE_11 ;
//-------------------------------------------------------------------+ DPoE 0
string   arrow_name_up_DPoE, arrow_name_down_DPoE;
datetime time_up_DPoE, time_down_DPoE ;
double   price_up_DPoE, price_down_DPoE ;
//-------------------------------------------------------------------+ DPoE 1
string   arrow_name_up_DPoE_1, arrow_name_down_DPoE_1;
datetime time_up_DPoE_1, time_down_DPoE_1 ;
double   price_up_DPoE_1, price_down_DPoE_1 ;
//-------------------------------------------------------------------+ DPoE 2
string   arrow_name_up_DPoE_2, arrow_name_down_DPoE_2;
datetime time_up_DPoE_2, time_down_DPoE_2 ;
double   price_up_DPoE_2, price_down_DPoE_2 ;
//-------------------------------------------------------------------+ DPoE 3
string   arrow_name_up_DPoE_3, arrow_name_down_DPoE_3;
datetime time_up_DPoE_3, time_down_DPoE_3 ;
double   price_up_DPoE_3, price_down_DPoE_3 ;
//-------------------------------------------------------------------+ DPoE 4
string   arrow_name_up_DPoE_4, arrow_name_down_DPoE_4;
datetime time_up_DPoE_4, time_down_DPoE_4 ;
double   price_up_DPoE_4, price_down_DPoE_4 ;
//-------------------------------------------------------------------+ DPoE 5
string   arrow_name_up_DPoE_5, arrow_name_down_DPoE_5;
datetime time_up_DPoE_5, time_down_DPoE_5 ;
double   price_up_DPoE_5, price_down_DPoE_5 ;
//-------------------------------------------------------------------+ MDS
string   arrow_name_up_MDS, arrow_name_down_MDS;
datetime time_up_MDS, time_down_MDS ;
double   price_up_MDS, price_down_MDS ;
//-------------------------------------------------------------------+ EDS
string   arrow_name_up_EDS, arrow_name_down_EDS;
datetime time_up_EDS, time_down_EDS ;
double   price_up_EDS, price_down_EDS ;
//-------------------------------------------------------------------+ MS 0
string   arrow_name_up_MS, arrow_name_down_MS;
datetime time_up_MS, time_down_MS ;
double   price_up_MS, price_down_MS ;
//-------------------------------------------------------------------+ MS 0
string   arrow_name_up_ES, arrow_name_down_ES;
datetime time_up_ES, time_down_ES ;
double   price_up_ES, price_down_ES ;
//-------------------------------------------------------------------+ MS 1
string   arrow_name_up_MS_1, arrow_name_down_MS_1;
datetime time_up_MS_1, time_down_MS_1 ;
double   price_up_MS_1, price_down_MS_1 ;
//-------------------------------------------------------------------+ ES 1
string   arrow_name_up_ES_1, arrow_name_down_ES_1;
datetime time_up_ES_1, time_down_ES_1 ;
double   price_up_ES_1, price_down_ES_1 ;
//-------------------------------------------------------------------+ MS50 0
string   arrow_name_up_MS50, arrow_name_down_MS50;
datetime time_up_MS50, time_down_MS50 ;
double   price_up_MS50, price_down_MS50 ;
//-------------------------------------------------------------------+ ES50 0
string   arrow_name_up_ES50, arrow_name_down_ES50;
datetime time_up_ES50, time_down_ES50 ;
double   price_up_ES50, price_down_ES50 ;
//-------------------------------------------------------------------+ EMS_Equal 0
string   arrow_name_up_EMS_Equal, arrow_name_down_EMS_Equal;
datetime time_up_EMS_Equal, time_down_EMS_Equal ;
double   price_up_EMS_Equal, price_down_EMS_Equal ;
//-------------------------------------------------------------------+ EES_Equal 0
string   arrow_name_up_EES_Equal, arrow_name_down_EES_Equal;
datetime time_up_EES_Equal, time_down_EES_Equal ;
double   price_up_EES_Equal, price_down_EES_Equal ;
//-------------------------------------------------------------------+ EMS_Equal 1
string   arrow_name_up_EMS_Equal_1, arrow_name_down_EMS_Equal_1;
datetime time_up_EMS_Equal_1, time_down_EMS_Equal_1 ;
double   price_up_EMS_Equal_1, price_down_EMS_Equal_1 ;
//-------------------------------------------------------------------+ EESqual 1
string   arrow_name_up_EES_Equal_1, arrow_name_down_EES_Equal_1;
datetime time_up_EES_Equal_1, time_down_EES_Equal_1 ;
double   price_up_EES_Equal_1, price_down_EES_Equal_1 ;
//-------------------------------------------------------------------+ Eng 0
string   arrow_name_up_Eng, arrow_name_down_Eng;
datetime time_up_Eng, time_down_Eng ;
double   price_up_Eng, price_down_Eng ;
//-------------------------------------------------------------------+ Eng 1
string   arrow_name_up_Eng_1, arrow_name_down_Eng_1;
datetime time_up_Eng_1, time_down_Eng_1 ;
double   price_up_Eng_1, price_down_Eng_1 ;
//-------------------------------------------------------------------+ EXC 1
string   arrow_name_up_EXC, arrow_name_down_EXC;
datetime time_up_EXC, time_down_EXC ;
double   price_up_EXC, price_down_EXC ;
//-------------------------------------------------------------------+ EXP 0
string   arrow_name_up_EXP, arrow_name_down_EXP;
datetime time_up_EXP, time_down_EXP ;
double   price_up_EXP, price_down_EXP ;
//-------------------------------------------------------------------+ EXR 0
string   arrow_name_up_EXR, arrow_name_down_EXR;
datetime time_up_EXR, time_down_EXR ;
double   price_up_EXR, price_down_EXR ;
//-------------------------------------------------------------------+ EXRC 0
string   arrow_name_up_EXRC, arrow_name_down_EXRC;
datetime time_up_EXRC, time_down_EXRC ;
double   price_up_EXRC, price_down_EXRC ;
//-------------------------------------------------------------------+ NRS 0
string   arrow_name_up_NRS, arrow_name_down_NRS;
datetime time_up_NRS, time_down_NRS;
double   price_up_NRS, price_down_NRS;
//-------------------------------------------------------------------+ FNRS 0
string   arrow_name_up_FNRS, arrow_name_down_FNRS;
datetime time_up_FNRS, time_down_FNRS;
double   price_up_FNRS, price_down_FNRS;
//-------------------------------------------------------------------+ NRSP 0
string   arrow_name_up_NRSP, arrow_name_down_NRSP;
datetime time_up_NRSP, time_down_NRSP;
double   price_up_NRSP, price_down_NRSP;
//-------------------------------------------------------------------+ SnR 0
string   arrow_name_up_SnR, arrow_name_down_SnR;
datetime time_up_SnR, time_down_SnR ;
double   price_up_SnR, price_down_SnR ;
//-------------------------------------------------------------------+ SnR 0
string   arrow_name_up_buy_SnR, arrow_name_down_sell_SnR;
datetime time_up_buy_SnR, time_down_sell_SnR;
double   price_up_buy_SnR, price_down_sell_SnR;
//-------------------------------------------------------------------+ _Analyse
/*string   arrow_name_up_buy__Analyse, arrow_name_down_sell__Analyse;
datetime time_up_buy__Analyse, time_down_sell__Analyse;
double   price_up_buy__Analyse, price_down_sell__Analyse;*/
//-------------------------------------------------------------------+ FB 0
string   arrow_name_up_FB, arrow_name_down_FB;
datetime time_up_FB, time_down_FB ;
double   price_up_FB, price_down_FB ;
//-------------------------------------------------------------------+ shoting_s_1
string   arrow_name_up_shoting_s_1, arrow_name_down_shoting_s_1;
datetime time_up_shoting_s_1, time_down_shoting_s_1 ;
double   price_up_shoting_s_1, price_down_shoting_s_1 ;
//-------------------------------------------------------------------+ shoting_s_2
string   arrow_name_up_shoting_s_2, arrow_name_down_shoting_s_2;
datetime time_up_shoting_s_2, time_down_shoting_s_2 ;
double   price_up_shoting_s_2, price_down_shoting_s_2 ;
//-------------------------------------------------------------------+ shoting_s_3
string   arrow_name_up_shoting_s_3, arrow_name_down_shoting_s_3;
datetime time_up_shoting_s_3, time_down_shoting_s_3 ;
double   price_up_shoting_s_3, price_down_shoting_s_3 ;
//-------------------------------------------------------------------+ shoting_s_4
string   arrow_name_up_shoting_s_4, arrow_name_down_shoting_s_4;
datetime time_up_shoting_s_4, time_down_shoting_s_4 ;
double   price_up_shoting_s_4, price_down_shoting_s_4 ;

//-------------------------------------------------------------------+ marubozu
string   arrow_name_up_marubozu, arrow_name_down_marubozu;
datetime time_up_marubozu, time_down_marubozu ;
double   price_up_marubozu, price_down_marubozu ;
//-------------------------------------------------------------------+ dragonfly
string   arrow_name_up_dragonfly, arrow_name_down_dragonfly;
datetime time_up_dragonfly, time_down_dragonfly ;
double   price_up_dragonfly, price_down_dragonfly ;
//-------------------------------------------------------------------+ gap
string   arrow_name_up_gap, arrow_name_down_gap;
datetime time_up_gap, time_down_gap ;
double   price_up_gap, price_down_gap ;
//-------------------------------------------------------------------+ gravestone
string   arrow_name_up_gravestone, arrow_name_down_gravestone;
datetime time_up_gravestone, time_down_gravestone ;
double   price_up_gravestone, price_down_gravestone ;
//-------------------------------------------------------------------+ inverted_hammer
string   arrow_name_up_inverted_hammer, arrow_name_down_inverted_hammer;
datetime time_up_inverted_hammer, time_down_inverted_hammer ;
double   price_up_inverted_hammer, price_down_inverted_hammer ;
//-------------------------------------------------------------------+ EES_1
string   arrow_name_up_EES_1, arrow_name_down_EES_1;
datetime time_up_EES_1, time_down_EES_1 ;
double   price_up_EES_1, price_down_EES_1 ;
//-------------------------------------------------------------------+ EMS_1
string   arrow_name_up_EMS_1, arrow_name_down_EMS_1;
datetime time_up_EMS_1, time_down_EMS_1 ;
double   price_up_EMS_1, price_down_EMS_1 ;
//-------------------------------------------------------------------+ NRS_1
string   arrow_name_up_NRS_1, arrow_name_down_NRS_1;
datetime time_up_NRS_1, time_down_NRS_1 ;
double   price_up_NRS_1, price_down_NRS_1 ;
//-------------------------------------------------------------------+ MS50_1
string   arrow_name_up_MS50_1, arrow_name_down_MS50_1;
datetime time_up_MS50_1, time_down_MS50_1 ;
double   price_up_MS50_1, price_down_MS50_1 ;
//-------------------------------------------------------------------+ ES50 1
string   arrow_name_up_ES50_1, arrow_name_down_ES50_1;
datetime time_up_ES50_1, time_down_ES50_1 ;
double   price_up_ES50_1, price_down_ES50_1 ;
//-------------------------------------------------------------------+ Hanging_man
string   arrow_name_up_Hanging_man, arrow_name_down_Hanging_man;
datetime time_up_Hanging_man, time_down_Hanging_man ;
double   price_up_Hanging_man, price_down_Hanging_man ;
//-------------------------------------------------------------------+ Harami
string   arrow_name_up_Harami, arrow_name_down_Harami;
datetime time_up_Harami, time_down_Harami ;
double   price_up_Harami, price_down_Harami ;
//-------------------------------------------------------------------+ HHLL
string   arrow_name_up_HHLL, arrow_name_down_HHLL;
datetime time_up_HHLL, time_down_HHLL ;
double   price_up_HHLL, price_down_HHLL ;
//-------------------------------------------------------------------+ eng_1
string   arrow_name_up_eng_1, arrow_name_down_eng_1;
datetime time_up_eng_1, time_down_eng_1 ;
double   price_up_eng_1, price_down_eng_1 ;
//-------------------------------------------------------------------+ eng_2
string   arrow_name_up_eng_2, arrow_name_down_eng_2;
datetime time_up_eng_2, time_down_eng_2 ;
double   price_up_eng_2, price_down_eng_2 ;
//-------------------------------------------------------------------+ eng_3
string   arrow_name_up_eng_3, arrow_name_down_eng_3;
datetime time_up_eng_3, time_down_eng_3 ;
double   price_up_eng_3, price_down_eng_3 ;
//-------------------------------------------------------------------+ eng_4
string   arrow_name_up_eng_4, arrow_name_down_eng_4;
datetime time_up_eng_4, time_down_eng_4 ;
double   price_up_eng_4, price_down_eng_4 ;
//-------------------------------------------------------------------+ eng_5
string   arrow_name_up_eng_5, arrow_name_down_eng_5;
datetime time_up_eng_5, time_down_eng_5 ;
double   price_up_eng_5, price_down_eng_5 ;
//-------------------------------------------------------------------+ eng_6
string   arrow_name_up_eng_6, arrow_name_down_eng_6;
datetime time_up_eng_6, time_down_eng_6 ;
double   price_up_eng_6, price_down_eng_6 ;
//-------------------------------------------------------------------+ eng_7
string   arrow_name_up_eng_7, arrow_name_down_eng_7;
datetime time_up_eng_7, time_down_eng_7 ;
double   price_up_eng_7, price_down_eng_7 ;
//-------------------------------------------------------------------+ dc_1
string   arrow_name_up_dc_1, arrow_name_down_dc_1;
datetime time_up_dc_1, time_down_dc_1 ;
double   price_up_dc_1, price_down_dc_1 ;
//-------------------------------------------------------------------+ dc_2
string   arrow_name_up_dc_2, arrow_name_down_dc_2;
datetime time_up_dc_2, time_down_dc_2 ;
double   price_up_dc_2, price_down_dc_2 ;
//-------------------------------------------------------------------+ huge_candle_1
string   arrow_name_up_huge_candle_1, arrow_name_down_huge_candle_1;
datetime time_up_huge_candle_1, time_down_huge_candle_1 ;
double   price_up_huge_candle_1, price_down_huge_candle_1 ;
//-------------------------------------------------------------------+ huge_candle_2
string   arrow_name_up_huge_candle_2, arrow_name_down_huge_candle_2;
datetime time_up_huge_candle_2, time_down_huge_candle_2 ;
double   price_up_huge_candle_2, price_down_huge_candle_2 ;
//-------------------------------------------------------------------+ huge_candle_3
string   arrow_name_up_huge_candle_3, arrow_name_down_huge_candle_3;
datetime time_up_huge_candle_3, time_down_huge_candle_3 ;
double   price_up_huge_candle_3, price_down_huge_candle_3 ;
//-------------------------------------------------------------------+ ms_buy_1_es_1
string   arrow_name_up_ms_buy_1_es_1, arrow_name_down_ms_buy_1_es_1;
datetime time_up_ms_buy_1_es_1, time_down_ms_buy_1_es_1 ;
double   price_up_ms_buy_1_es_1, price_down_ms_buy_1_es_1 ;
//-------------------------------------------------------------------+ ms_buy_1_es_2
string   arrow_name_up_ms_buy_1_es_2, arrow_name_down_ms_buy_1_es_2;
datetime time_up_ms_buy_1_es_2, time_down_ms_buy_1_es_2 ;
double   price_up_ms_buy_1_es_2, price_down_ms_buy_1_es_2 ;
//-------------------------------------------------------------------+ tws_put_1_tbc
string   arrow_name_up_tws_put_1_tbc, arrow_name_down_tws_put_1_tbc;
datetime time_up_tws_put_1_tbc, time_down_tws_put_1_tbc ;
double   price_up_tws_put_1_tbc, price_down_tws_put_1_tbc ;
//-------------------------------------------------------------------+ tws_put_2_tbc
string   arrow_name_up_tws_put_2_tbc, arrow_name_down_tws_put_2_tbc;
datetime time_up_tws_put_2_tbc, time_down_tws_put_2_tbc ;
double   price_up_tws_put_2_tbc, price_down_tws_put_2_tbc ;
//-------------------------------------------------------------------+ tws_put_3_tbc
string   arrow_name_up_tws_put_3_tbc, arrow_name_down_tws_put_3_tbc;
datetime time_up_tws_put_3_tbc, time_down_tws_put_3_tbc ;
double   price_up_tws_put_3_tbc, price_down_tws_put_3_tbc ;
//-------------------------------------------------------------------+ tws_put_4_tbc
string   arrow_name_up_tws_put_4_tbc, arrow_name_down_tws_put_4_tbc;
datetime time_up_tws_put_4_tbc, time_down_tws_put_4_tbc ;
double   price_up_tws_put_4_tbc, price_down_tws_put_4_tbc ;
//-------------------------------------------------------------------+ Hammer
string   arrow_name_up_Hammer, arrow_name_down_Hammer;
datetime time_up_Hammer, time_down_Hammer ;
double   price_up_Hammer, price_down_Hammer ;
//-------------------------------------------------------------------+ twzb_call_1_twzt_put
string   arrow_name_up_twzb_call_1_twzt_put, arrow_name_down_twzb_call_1_twzt_put;
datetime time_up_twzb_call_1_twzt_put, time_down_twzb_call_1_twzt_put ;
double   price_up_twzb_call_1_twzt_put, price_down_twzb_call_1_twzt_put ;
//-------------------------------------------------------------------+ call_reversal_put_reversal
string   arrow_name_up_call_reversal_put_reversal, arrow_name_down_call_reversal_put_reversal;
datetime time_up_call_reversal_put_reversal, time_down_call_reversal_put_reversal ;
double   price_up_call_reversal_put_reversal, price_down_call_reversal_put_reversal ;
//-------------------------------------------------------------------+ minor_put_minor_call
string   arrow_name_up_minor_put_minor_call, arrow_name_down_minor_put_minor_call;
datetime time_up_minor_put_minor_call, time_down_minor_put_minor_call ;
double   price_up_minor_put_minor_call, price_down_minor_put_minor_call ;
//-------------------------------------------------------------------+
//-------------------------------------------------------------------+ poe_1
string   arrow_name_up_poe_1, arrow_name_down_poe_1;
datetime time_up_poe_1, time_down_poe_1 ;
double   price_up_poe_1, price_down_poe_1 ;
//-------------------------------------------------------------------+
//-------------------------------------------------------------------+ poe_2
string   arrow_name_up_poe_2, arrow_name_down_poe_2;
datetime time_up_poe_2, time_down_poe_2 ;
double   price_up_poe_2, price_down_poe_2 ;
//-------------------------------------------------------------------+
//+------------------------------------------------------------------+
struct Respons
  {
   int               res;
   string            status;
   string            msg;
   string            token;
   int               expire_day;
  };

#import "licence.ex4"
string GetToken(int value1, string value2, string value3);
Respons Request(int value1, string value2, string value3);
#import
string base_url     = "https://bott-indicator.com/";   // ip server
bool   isLicence    = false;
string validate     = "DG64Dgfd2GHE3sdfgW";
bool   isFirst      = true;
string bott = "\\Libraries\\BOTT Price Action Indicator Logo.bmp";
extern string active = "----- Activation -----";
input string  Serial = "000000000000000000000000000000000";
int day   = 21;
int month = 3;
int year  = 2021;
bool Enable_EA = true;
//+------------------------------------------------------------------+
//int  User_ID   = 346621 ;
int Start_Time = 1;
int End_Time = 23;
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
int MaxLevel = 1; // Maximum Martingle Levels (Max is 5)
int Expire = 1; // Time Order Candle
bool consecutive_Loss = false;
int  consecutiveLoss = 4;
bool consecutive_Win = false;
int  consecutiveWin = 4;
int  Percentage = 10;
int  countZeroBalance = 0;
//input double Size = 2;
int InitialBalance = 100;
int BaseBalance = InitialBalance;
//+------------------------------------------------------------------+
int  period;
datetime PreviousBarTime1;
double Bands_up_1_7_1, Bands_up_1_7_2, Bands_up_1_7_3, Bands_down_1_7_1, Bands_down_1_7_2, Bands_down_1_7_3,
       Bands_up_1_8_1, Bands_up_1_8_2, Bands_up_1_8_3, Bands_down_1_8_1, Bands_down_1_8_2, Bands_down_1_8_3,
       Bands_up_2_3_1, Bands_up_2_3_2, Bands_up_2_3_3, Bands_down_2_3_1, Bands_down_2_3_2, Bands_down_2_3_3;

double Bands_up_1_1 = 0, Bands_up_1_2, Bands_up_1_3, Bands_down_1_1 = 0, Bands_down_1_2 = 0, Bands_down_1_3 = 0, Bands_up_1_4 = 0, Bands_down_1_4 = 0;  // 1
double Bands_MODE_MAIN_1 = 0, Bands_MODE_MAIN_2 = 0, Bands_MODE_MAIN_3 = 0;
double Bands_up_2_1 = 0, Bands_up_2_2 = 0, Bands_up_2_3 = 0, Bands_up_2_4 = 0, Bands_down_2_1 = 0, Bands_down_2_2 = 0, Bands_down_2_3 = 0, Bands_down_2_4 = 0; // 2
double Bands_up_1_5_1 = 0, Bands_up_1_5_2 = 0, Bands_up_1_5_3 = 0, Bands_down_1_5_1 = 0, Bands_down_1_5_2 = 0, Bands_down_1_5_3 = 0, Bands_up_1_5_4 = 0, Bands_down_1_5_4 = 0;    // 1.5
double myMA_6_1 = 0, myMA_6_2 = 0, myMA_6_3 = 0, myMA_6_4 = 0, myMA_6_5 = 0, myMA_6_6 = 0, myMA_8_1 = 0;
double myMA_20 = 0, myMA_20_1 = 0, myMA_20_2 = 0, myMA_20_3 = 0, myMA_20_4 = 0, myMA_20_5 = 0, myMA_20_10 = 0;
double myMA_50 = 0, myMA_50_1 = 0, myMA_50_2 = 0, myMA_50_3 = 0;
double myMA_100 = 0, myMA_100_1 = 0, myMA_100_2 = 0, myMA_100_3 = 0;
double myMA_200 = 0, myMA_200_1 = 0, myMA_200_2 = 0, myMA_200_3 = 0;
string g1, g2, g3, g4, g5, g6, g7, g50, g51, g100, g101, g103, g104, g106, g109, g200, g300, gConcept_name_distance_20, g500, g501, g502, g503, g504, g505,
       g506, g600, g601, g602, g603, g604, g605, g606, g700;
//--------
string Moving_Parameters_20 = "Moving_20";
int                Ma_Period  = 20;
int                Ma_Shift   = 0;
ENUM_MA_METHOD     Ma_Method  = MODE_EMA;
ENUM_APPLIED_PRICE Ma_Price   = PRICE_CLOSE;
//---
string Moving_Parameters_50 = "Moving_50";
int                Ma_Period2  = 50;
int                Ma_Shift2   = 0;
ENUM_MA_METHOD     Ma_Method2  = MODE_EMA;
ENUM_APPLIED_PRICE Ma_Price2   = PRICE_CLOSE;
//---
string Moving_Parameters_100 = "Moving_100";
int                Ma_Period3  = 100;
int                Ma_Shift3   = 0;
ENUM_MA_METHOD     Ma_Method3  = MODE_EMA;
ENUM_APPLIED_PRICE Ma_Price3   = PRICE_CLOSE;
//---
string Moving_Parameters_200 = "Moving_200";
int                Ma_Period4  = 200;
int                Ma_Shift4   = 0;
ENUM_MA_METHOD     Ma_Method4  = MODE_EMA;
ENUM_APPLIED_PRICE Ma_Price4   = PRICE_CLOSE;
//---
string Bands_Parameters        = "Bands";
int                Period_     = 20;
int                Shift       = 0;
double             Deviation_2 = 2;
double             Deviation_1_5 = 1.5;
double             Deviation_1_7 = 1.7;
double             Deviation_1_8 = 1.8;
double             Deviation_2_3 = 2.3;

string Bands_Parameters_2      = "Bands";
int                Period_2    = 20;
int                Shift_2     = 0;
double             Deviation_1 = 1;     // 1
bool Comment_winRate = false;
//---------------------------
int countSignalCandle_Buy = 0;
int countSignal_Buy = 0;
int countSignalCandle_Sell = 0;
int countSignal_Sell = 0;
int Cont_all_candles = 0;
//---
int countLoss_buy = 0;
int countWin_buy = 0;
int countLoss_sell = 0;
int countWin_sell = 0;
int countSell = 0;
int countBuy = 0;
int levels_sell[6] = {0, 0, 0, 0, 0, 0}, levels_buy[6] = {0, 0, 0, 0, 0, 0};
int levels_loss_buy[6] = {0, 0, 0, 0, 0, 0}, levels_win_buy[6] = {0, 0, 0, 0, 0, 0};
int levels_loss_sell[6] = {0, 0, 0, 0, 0, 0}, levels_win_sell[6] = {0, 0, 0, 0, 0, 0};
int countLoss = 0;
int countAllLoss = 0;
int countWin = 0;
int countAllWin = 0;
double signal_price_buy, signal_price_sell;
datetime signalTime_buy = 0;
datetime signalTime_sell = 0;
int countBack_buy = 0;
int countBack_sell = 0;
int Accountnumber;
double point;
int Cont_can;
int error;
input string Alert  = " Alert Setting "; //Alert
input bool   Show_arrow  = true; // Show arrow
input int    Arrow_size  = 1 ; // Arrow Size
input color  Color_Arrow_UP   = clrSpringGreen;// Arrow color up
input color  Color_Arrow_Down = clrRed;         // Arrow color down
bool         Alertwait    = false; // Get ready alert
bool         Message_Alert = true; // message alert
input bool   Push_notification  = true; // Push notification
input bool   Mail_alert   = true; // Mail alert
input bool   Sound_alert  = true; // Sound alert
input string Sound_file_name = "news.wav"; // Sound file name
input int    Concept_name_distance = 5; // Concept name distance
input int    Concept_name_distance_2 = 5; // Concept name distance

input int    Arrow_distance = 3; // Arrow distance
bool         enable_text = true; // Enable Text
input int    Text_size = 11; // Concept name size
input color  Text_color = clrAqua;     // Concept name color
//---
input color Text_ColorBuy  = clrBlue; // Buy signal name display
input color Text_ColorSell = clrIndianRed; // Sell signal name display
input int TextSize = 15; // Signal name display size
input int x = 50; // Horizontal position
input int y = 50; // Vertical position
input bool GetLine   = true;
input color Text_Colorwait = clrMediumSlateBlue; // Pre-signal name display
input int x_wait = 4;  // Horizontal Position
input int y_wait = 60; // Vertical Position
input int TextSize_wait = 12; // Signal name display size
datetime time_wait_buy ;
datetime time_wait_sell ;

input bool TakePicture =  false ; /* set true to TakePicture */
input int  _width      = 600;//2560;// set to match your screen resolution numbers
input int  _height     = 400;//1600;// set to match your screen resolution numbers
color Analys_Color_Green  = clrLime;
color Analys_Color_Red    = clrRed;
color Analys_Color_Yellow = clrYellow;
color Analys_Color_DarkGray  = clrDarkGray ;

input int   TextSize_Analys = 14;           // Dashboard parameters text size
input color clr_bacgrond_Analys = clrBlack; // Dashboard background color
color clr_cadr_Analys     = clrAqua;  // clr cadr Analys
int   Analys_EMA = 0;
input int iFrom  = 5 ; // No. of past candles for 20 EMA steepness
int iTo    = 1 ;
bool Degrees_Trendline = false;
int makan_x = 6;
int makan_y = 125;
int y_Degrees = 1, x_Degrees = 10;
color clr_RectLabel = clrBlack;
//---
bool show_hide_btn_status = false;
input bool show_hide_btn = true;
color  Color_Line_Snr   = clrBlue;// Color Line Snr
bool runInBacktest = true;            // <<<<<<<<<<<<<<<  // نکته ی مهم وقتی میخواهید این کد را به کار بر دهید حتما این گزینه باید فالس باشد
double max_body = 0, min_body = 9999999999;
int flag_c = 0;
//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   if(show_hide_btn)
     {
      ObjectCreate(0, "show-hide", OBJ_BUTTON, 0, 0, 0);
      ObjectSetInteger(0, "show-hide", OBJPROP_CORNER, CORNER_RIGHT_LOWER);
      ObjectSetInteger(0, "show-hide", OBJPROP_XDISTANCE, 50);
      ObjectSetInteger(0, "show-hide", OBJPROP_YDISTANCE, 30);
      ObjectSetInteger(0, "show-hide", OBJPROP_BGCOLOR, clrRed);
      ObjectSetInteger(0, "show-hide", OBJPROP_COLOR, clrBlack);
      ObjectSetInteger(0, "show-hide", OBJPROP_FONTSIZE, 10);
      ObjectSetString(0, "show-hide", OBJPROP_TEXT, "Panel");
      RectLabelCreate(0, "RectLabel", 0, 50, 145, 200, 162, clr_RectLabel, 2, CORNER_RIGHT_UPPER);
     }
   else
     {
      show_hide_btn_status = false;
      ObjectDelete("EMA_obj");
      ObjectDelete("DEV_obj");
      ObjectDelete("myMA_Analys");
      ObjectDelete("BB-obj");
      ObjectDelete("Reversal-obj");
      ObjectDelete("C-obj2");
      ObjectDelete("C-obj");
      ObjectDelete("P-obj");
      ObjectDelete("Alert_Degrees");
      ObjectDelete("show-hide");
      ObjectDelete("RectLabel");
     }
   if(runInBacktest == true)
     {
      isLicence = true;
      isFirst = false;
      if(Digits == 3 || Digits == 5)
         point = 10 * Point;
      else
         point = Point;
      IndicatorDigits(6);
      ObjectCreate(0, "bitmap alpha", OBJ_BITMAP_LABEL, 0, 0, 0);
      ObjectSetString(0, "bitmap alpha", OBJPROP_BMPFILE, bott);
      ObjectSetInteger(0, "bitmap alpha", OBJPROP_YDISTANCE, 17);
      ObjectSetInteger(0, "bitmap alpha", OBJPROP_XDISTANCE, 5);
      ObjectSetInteger(0, "bitmap alpha", OBJPROP_CORNER, CORNER_LEFT_UPPER);
      ///////////////
      //--- indicator buffers mapping
      /* ObjectCreate("show-hide", OBJ_LABEL, 0, 0, 0);
         ObjectSet("show-hide", OBJPROP_CORNER, 1);
         ObjectSet("show-hide", OBJPROP_XDISTANCE, 10);
         ObjectSet("show-hide", OBJPROP_YDISTANCE, 30);
         ObjectSetText("show-hide", CharToStr(110), 25, "Wingdings", clrGreen);*/
      //---
      ////////////
      return(INIT_SUCCEEDED);
     }
   else
     {
      if(isFirst)
        {
         Print("[INFO] isFirst 270 is true.");
         if(CheckLicence())
           {
            //--- Wrtie your code here.
            Print("[INFO] CheckLicence 274 is true.");
            ResetLastError();
            EventSetTimer(60 * 60 * 24);
            error = GetLastError();
            Print("[ERROR] EventSetTimer 278 error code = ", error);
            isLicence = true;
            isFirst = false;
            if(Digits == 3 || Digits == 5)
               point = 10 * Point;
            else
               point = Point;
            IndicatorDigits(6);
            ObjectCreate(0, "bitmap alpha", OBJ_BITMAP_LABEL, 0, 0, 0);
            ObjectSetString(0, "bitmap alpha", OBJPROP_BMPFILE, bott);
            ObjectSetInteger(0, "bitmap alpha", OBJPROP_YDISTANCE, 17);
            ObjectSetInteger(0, "bitmap alpha", OBJPROP_XDISTANCE, 5);
            ObjectSetInteger(0, "bitmap alpha", OBJPROP_CORNER, CORNER_LEFT_UPPER);
            ///////////////
            //--- indicator buffers mapping
            /*ObjectCreate("show-hide", OBJ_LABEL, 0, 0, 0);
              ObjectSet("show-hide", OBJPROP_CORNER, 1);
              ObjectSet("show-hide", OBJPROP_XDISTANCE, 10);
              ObjectSet("show-hide", OBJPROP_YDISTANCE, 30);
              ObjectSetText("show-hide", CharToStr(110), 25, "Wingdings", clrGreen);*/
            //---
            ////////////
            return(INIT_SUCCEEDED);
           }
         else
           {
            Print("[INFO] CheckLicence 295 is false.");
            ExpertRemove();
            return(INIT_FAILED);
           }
        }
      else
        {
         Print("[INFO] isFirst 302 is false.");
         ResetLastError();
         EventSetTimer(60 * 60 * 24);
         error = GetLastError();
         Print("[ERROR] EventSetTimer 306 error code = ", error);
         //--- Wrtie your code here.
         if(Digits == 3 || Digits == 5)
            point = 10 * Point;
         else
            point = Point;
         IndicatorDigits(6);
         ObjectCreate(0, "bitmap alpha", OBJ_BITMAP_LABEL, 0, 0, 0);
         ObjectSetString(0, "bitmap alpha", OBJPROP_BMPFILE, bott);
         ObjectSetInteger(0, "bitmap alpha", OBJPROP_YDISTANCE, 17);
         ObjectSetInteger(0, "bitmap alpha", OBJPROP_XDISTANCE, 5);
         ObjectSetInteger(0, "bitmap alpha", OBJPROP_CORNER, CORNER_LEFT_UPPER);
         ///////////////
         //--- indicator buffers mapping
         /*ObjectCreate("show-hide", OBJ_LABEL, 0, 0, 0);
           ObjectSet("show-hide", OBJPROP_CORNER, 1);
           ObjectSet("show-hide", OBJPROP_XDISTANCE, 10);
           ObjectSet("show-hide", OBJPROP_YDISTANCE, 30);
           ObjectSetText("show-hide", CharToStr(110), 25, "Wingdings", clrGreen);*/
         //---
         ////////////
         return(INIT_SUCCEEDED);
        }
     }
   return(INIT_FAILED);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   EventKillTimer();
   ObjectDelete("EMA_obj");
   ObjectDelete("DEV_obj");
   ObjectDelete("myMA_Analys");
   ObjectDelete("BB-obj");
   ObjectDelete("Reversal-obj");
   ObjectDelete("C-obj2");
   ObjectDelete("C-obj");
   ObjectDelete("P-obj");
   ObjectDelete("Alert_Degrees");
   ObjectDelete("show-hide");
   ObjectDelete("RectLabel");
//ObjectsDeleteAll();
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
void OnTick()
  {
// Comment("(Close[2] - Open[2]) / 2)   ==",((Close[2] - Open[2]) / 2), " ((Close[2] - Open[2]) / 2) + Open[2] ) ===" , (((Close[2] - Open[2]) / 2) + Open[2] ));
// if(btn_status == false)
//TrendLine("Zig_Line", last_low_time_2, last_low_price_2, last_high_time_2, last_high_price_2, -1, InpLineStyle);
//   Alert_Analys_type("Reversal-obj", "ES", Analys_Color_Red, TextSize_Analys,277, 17);
// else
//TrendLine("Zig_Line", last_low_time_2, last_low_price_2, last_high_time_2, last_high_price_2, InpLineColor_down, InpLineStyle);
// Alert_Analys_type("Reversal-obj", "ES", Analys_Color_Red, TextSize_Analys, 277, 17 );
// Alert_Analys_type("Reversal-obj", "ES", Analys_Color_Red, TextSize_Analys, makan_y + 1Concept_name_distance_2, makan_x );
//PlotLine("_lev "+bar4+"_"+Complect+"_"+i,vel4,bar4,bar3,1,angle_dn*i, flag);
// Arrow_Degrees("Degrees", clrBlue,161,y_Degrees,x_Degrees);
//-------------------------------------------------------------------+
//-------------------------------------------------------------------+
   if(IsVisualMode())
      CheckResetButton();
   if(SnR  == true)
     {
      if(Time[0] != pastTime_sell)
        {
         if(Close[1] < Open[1] && Close[2] < Open[2] && Close[3] > Open[3] && Open[2] - Close[2] < Open[1] - Close[1]  && Open[2] - Close[2] < Close[3] - Open[3]
            && Close[2] > Bands_up_1_2 && Close[2] < Bands_up_2_2
           )
           {
            time_candel_1_sell = Time[1];
            time_candel_2_sell = Time[2];
            Open_2_sell = Open[2];
            pattern_signal_sell = 1;
            Low_2 = Low[2];
            Close_2_sell = Close[2];
            pastTime_sell = Time[0];
            if(Show_arrow_SnR == true)
              {
               Arrow_Create_sell(arrow_name_down_sell_SnR,  Time[2], High[2], clrBlue, ARROW_DOWN, ANCHOR_BOTTOM);
              }
           }
        }
      int shift_sell = iBarShift(Symbol(), PERIOD_CURRENT, time_candel_1_sell);
      if(pattern_signal_sell == 1 && (Close[1] > Close_2_sell))
        {
         segnal_sell = 0;
         pattern_signal_sell = 0;
         Low_2 = 0;
         Close_2_sell = 0;
        }
      //---
      if(pattern_signal_sell == 1 && Close[0] >= Low_2)
        {
         Alert_wait_type(" SS9 ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
         time_wait_sell = Time[0];
         // GetLine_Buy();
        }
      if(time_wait_sell == Time[1])
        {
         ObjectDelete("wait_signal");
         // GetLine_Sell();
        }
      //----
      if(pattern_signal_sell == 1 && (Close[1] == Low_2 || Close[1] == Close_2_sell || Close[1] > Close_2_sell) && Time[1] > time_candel_1_sell
         && shift_sell >= min_distance_snr && shift_sell <= max_distance_snr)
        {
         segnal_sell = 1;
         pattern_signal_sell = 0;
         Low_2 = 0;
         Close_2_sell = 0;
         time_candel_1_sell = 0;
         TrendLine("SNR_sell", time_candel_2_sell, Close[1], Time[0], Close[1], Color_Line_Snr, STYLE_SOLID, TRUE);
        }
      //---------------
      if(Time[0] != pastTime_buy)
        {
         if(Close[1] > Open[1] && Close[2] > Open[2] && Close[3] < Open[3] && Close[2] - Open[2] < Close[1] - Open[1] && Close[2] - Open[2] < Open[3] - Close[3]
            && Close[2] < Bands_down_1_2 && Close[2] > Bands_down_2_2
           )
           {
            time_candel_1_buy = Time[1];
            time_candel_2_buy = Time[2];
            pattern_signal_buy = 1;
            High_2 = High[2];
            Close_2_buy = Close[2];
            Open_2_buy = Open[2];
            pastTime_buy = Time[0];
            if(Show_arrow_SnR == true)  ///
              {
               Arrow_Create_buy(arrow_name_up_buy_SnR,  Time[2], Low[2], clrBlue, ARROW_UP, ANCHOR_TOP);
              }
           }
        }
      int shift_buy = iBarShift(Symbol(), PERIOD_CURRENT, time_candel_1_buy);
      if(pattern_signal_buy == 1 && Close[1] < Close_2_buy)
        {
         segnal_buy = 0;
         pattern_signal_buy = 0;
         High_2 = 0;
         Close_2_buy = 0;
        }
      //---
      if(pattern_signal_buy == 1 && Close[0] <= High_2)
        {
         Alert_wait_type(" SS9 ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
         time_wait_buy = Time[0];
         // GetLine_Buy();
        }
      if(time_wait_buy == Time[1])
        {
         ObjectDelete("wait_signal");
         // GetLine_Sell();
        }
      //----
      if(pattern_signal_buy == 1 && (Close[1] == High_2 || Close[1] == Close_2_buy || Close[1] < Close_2_buy) && Time[1] > time_candel_1_buy
         && shift_buy >= min_distance_snr && shift_buy <= max_distance_snr)
        {
         segnal_buy = 1;
         pattern_signal_buy = 0;
         High_2 = 0;
         Close_2_buy = 0;
         time_candel_1_buy = 0 ;
         TrendLine("SNR_buy", time_candel_2_buy,  Close[1], Time[0],  Close[1], Color_Line_Snr, STYLE_SOLID, TRUE);
        }
     }
//+------------------------------------------------------------------+
   arrow_name_up = "ARROW_UP" + TimeToString(Time[0]);
   time_up       = Time[0];
   price_up      = Low[0] - Arrow_distance * 1 * Point;
   Arrow_Move(arrow_name_up, time_up, price_up);
//--
   arrow_name_down = "ARROW_DOWN" + TimeToString(Time[0]);
   time_down       = Time[0];
   price_down      = High[0] + Arrow_distance * 1 * Point;
   Arrow_Move(arrow_name_down, time_down, price_down);
//+------------------------------------------------------------------+
   arrow_name_up_3WS = "ARROW_UP_3WS" + TimeToString(Time[0]);
   time_up_3WS       = Time[0];
   price_up_3WS      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   _3WS_Move(arrow_name_up_3WS, time_up_3WS, price_up_3WS);
//
   arrow_name_down_3WS = "ARROW_DOWN_3WS" + TimeToString(Time[0]);
   time_down_3WS       = Time[0];
   price_down_3WS      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   _3WS_Move(arrow_name_down_3WS, time_down_3WS, price_down_3WS);
//+------------------------------------------------------------------+
   arrow_name_up_3BC = "ARROW_UP_3BC" + TimeToString(Time[0]);
   time_up_3BC       = Time[0];
   price_up_3BC      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   _3BC_Move(arrow_name_up_3BC, time_up_3BC, price_up_3BC);
//
   arrow_name_down_3BC = "ARROW_DOWN_3BC" + TimeToString(Time[0]);
   time_down_3BC       = Time[0];
   price_down_3BC      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   _3BC_Move(arrow_name_down_3BC, time_down_3BC, price_down_3BC);
//+------------------------------------------------------------------+
   arrow_name_up_3WSP = "ARROW_UP_3WSP" + TimeToString(Time[0]);
   time_up_3WSP       = Time[0];
   price_up_3WSP      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   _3WSP_Move(arrow_name_up_3WSP, time_up_3WSP, price_up_3WSP);
//
   arrow_name_down_3WSP = "ARROW_DOWN_3WSP" + TimeToString(Time[0]);
   time_down_3WSP       = Time[0];
   price_down_3WSP      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   _3WSP_Move(arrow_name_down_3WSP, time_down_3WSP, price_down_3WSP);
//+------------------------------------------------------------------+
   arrow_name_up_3BCP = "ARROW_UP_3BCP" + TimeToString(Time[0]);
   time_up_3BCP       = Time[0];
   price_up_3BCP      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   _3BCP_Move(arrow_name_up_3BCP, time_up_3BCP, price_up_3BCP);
//
   arrow_name_down_3BCP = "ARROW_DOWN_3BCP" + TimeToString(Time[0]);
   time_down_3BCP       = Time[0];
   price_down_3BCP      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   _3BCP_Move(arrow_name_down_3BCP, time_down_3BCP, price_down_3BCP);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_PL = "ARROW_UP_PL" + TimeToString(Time[0]);
   time_up_PL       = Time[0];
   price_up_PL      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   PL_Move(arrow_name_up_PL, time_up_PL, price_up_PL);
//
   arrow_name_down_PL = "ARROW_DOWN_PL" + TimeToString(Time[0]);
   time_down_PL       = Time[0];
   price_down_PL      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   PL_Move(arrow_name_down_PL, time_down_PL, price_down_PL);
//+------------------------------------------------------------------+
   arrow_name_up_DC = "ARROW_UP_DC" + TimeToString(Time[0]);
   time_up_DC       = Time[0];
   price_up_DC      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   DC_Move(arrow_name_up_DC, time_up_DC, price_up_DC);
//
   arrow_name_down_DC = "ARROW_DOWN_DC" + TimeToString(Time[0]);
   time_down_DC       = Time[0];
   price_down_DC      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   DC_Move(arrow_name_down_DC, time_down_DC, price_down_DC);
//+------------------------------------------------------------------+
   arrow_name_up_PL_1 = "ARROW_UP_PL_1" + TimeToString(Time[0]);
   time_up_PL_1       = Time[0];
   price_up_PL_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   PL_1_Move(arrow_name_up_PL_1, time_up_PL_1, price_up_PL_1);
//
   arrow_name_down_PL_1 = "ARROW_DOWN_PL_1" + TimeToString(Time[0]);
   time_down_PL_1       = Time[0];
   price_down_PL_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   PL_1_Move(arrow_name_down_PL_1, time_down_PL_1, price_down_PL_1);
//+------------------------------------------------------------------+
   arrow_name_up_DC_1 = "ARROW_UP_DC_1" + TimeToString(Time[0]);
   time_up_DC_1       = Time[0];
   price_up_DC_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   DC_1_Move(arrow_name_up_DC_1, time_up_DC_1, price_up_DC_1);
//
   arrow_name_down_DC_1 = "ARROW_DOWN_DC_1" + TimeToString(Time[0]);
   time_down_DC_1       = Time[0];
   price_down_DC_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   DC_1_Move(arrow_name_down_DC_1, time_down_DC_1, price_down_DC_1);
//+------------------------------------------------------------------+
   arrow_name_up_PoE = "ARROW_UP_PoE 0" + TimeToString(Time[0]);
   time_up_PoE       = Time[0];
   price_up_PoE      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   PoE_Move(arrow_name_up_PoE, time_up_PoE, price_up_PoE);
//
   arrow_name_down_PoE = "ARROW_DOWN_PoE 0" + TimeToString(Time[0]);
   time_down_PoE       = Time[0];
   price_down_PoE      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   PoE_Move(arrow_name_down_PoE, time_down_PoE, price_down_PoE);
//+------------------------------------------------------------------+
   arrow_name_up_PoE_1 = "ARROW_UP_PoE 1" + TimeToString(Time[0]);
   time_up_PoE_1       = Time[0];
   price_up_PoE_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   PoE_Move_1(arrow_name_up_PoE_1, time_up_PoE_1, price_up_PoE_1);
//
   arrow_name_down_PoE_1 = "ARROW_DOWN_PoE 1" + TimeToString(Time[0]);
   time_down_PoE_1       = Time[0];
   price_down_PoE_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   PoE_Move_1(arrow_name_down_PoE_1, time_down_PoE_1, price_down_PoE_1);
//+------------------------------------------------------------------+
   arrow_name_up_PoE_2 = "ARROW_UP_PoE 2" + TimeToString(Time[0]);
   time_up_PoE_2       = Time[0];
   price_up_PoE_2      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   PoE_Move_2(arrow_name_up_PoE_2, time_up_PoE_2, price_up_PoE_2);
//
   arrow_name_down_PoE_2 = "ARROW_DOWN_PoE 2" + TimeToString(Time[0]);
   time_down_PoE_2       = Time[0];
   price_down_PoE_2      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   PoE_Move_2(arrow_name_down_PoE_2, time_down_PoE_2, price_down_PoE_2);
//+------------------------------------------------------------------+
   arrow_name_up_PoE_3 = "ARROW_UP_PoE 3" + TimeToString(Time[0]);
   time_up_PoE_3       = Time[0];
   price_up_PoE_3      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   PoE_Move_3(arrow_name_up_PoE_3, time_up_PoE_3, price_up_PoE_3);
//
   arrow_name_down_PoE_3 = "ARROW_DOWN_PoE 3" + TimeToString(Time[0]);
   time_down_PoE_3       = Time[0];
   price_down_PoE_3      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   PoE_Move_3(arrow_name_down_PoE_3, time_down_PoE_3, price_down_PoE_3);
//+------------------------------------------------------------------+
   arrow_name_up_PoE_4 = "ARROW_UP_PoE 4" + TimeToString(Time[0]);
   time_up_PoE_4       = Time[0];
   price_up_PoE_4      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   PoE_Move_4(arrow_name_up_PoE_4, time_up_PoE_4, price_up_PoE_4);
//
   arrow_name_down_PoE_4 = "ARROW_DOWN_PoE 4" + TimeToString(Time[0]);
   time_down_PoE_4       = Time[0];
   price_down_PoE_4      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   PoE_Move_4(arrow_name_down_PoE_4, time_down_PoE_4, price_down_PoE_4);
//+------------------------------------------------------------------+
   arrow_name_up_PoE_5 = "ARROW_UP_PoE 5" + TimeToString(Time[0]);
   time_up_PoE_5       = Time[0];
   price_up_PoE_5      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   arrow_name_down_PoE_5 = "ARROW_DOWN_PoE 5" + TimeToString(Time[0]);
   time_down_PoE_5       = Time[0];
   price_down_PoE_5      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   PoE_Move_5(arrow_name_up_PoE_5, time_up_PoE_5, price_up_PoE_5);
   PoE_Move_5(arrow_name_down_PoE_5, time_down_PoE_5, price_down_PoE_5);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_PoE_6 = "ARROW_UP_PoE 6" + TimeToString(Time[0]);
   time_up_PoE_6       = Time[0];
   price_up_PoE_6      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   arrow_name_down_PoE_6 = "ARROW_DOWN_PoE 6" + TimeToString(Time[0]);
   time_down_PoE_6       = Time[0];
   price_down_PoE_6      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   PoE_Move_6(arrow_name_up_PoE_6, time_up_PoE_6, price_up_PoE_6);
   PoE_Move_6(arrow_name_down_PoE_6, time_down_PoE_6, price_down_PoE_6);
//+------------------------------------------------------------------+
   arrow_name_up_PoE_7 = "ARROW_UP_PoE 7" + TimeToString(Time[0]);
   time_up_PoE_7       = Time[0];
   price_up_PoE_7      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   arrow_name_down_PoE_7 = "ARROW_DOWN_PoE 7" + TimeToString(Time[0]);
   time_down_PoE_7       = Time[0];
   price_down_PoE_7      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   PoE_Move_7(arrow_name_up_PoE_7, time_up_PoE_7, price_up_PoE_7);
   PoE_Move_7(arrow_name_down_PoE_7, time_down_PoE_7, price_down_PoE_7);
//+------------------------------------------------------------------+
   arrow_name_up_PoE_8 = "ARROW_UP_PoE 8" + TimeToString(Time[0]);
   time_up_PoE_8       = Time[0];
   price_up_PoE_8      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   arrow_name_down_PoE_8 = "ARROW_DOWN_PoE 8" + TimeToString(Time[0]);
   time_down_PoE_8       = Time[0];
   price_down_PoE_8      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   PoE_Move_8(arrow_name_up_PoE_8, time_up_PoE_8, price_up_PoE_8);
   PoE_Move_8(arrow_name_down_PoE_8, time_down_PoE_8, price_down_PoE_8);
//+------------------------------------------------------------------+
   arrow_name_up_PoE_9 = "ARROW_UP_PoE 9" + TimeToString(Time[0]);
   time_up_PoE_9       = Time[0];
   price_up_PoE_9      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   arrow_name_down_PoE_9 = "ARROW_DOWN_PoE 9" + TimeToString(Time[0]);
   time_down_PoE_9       = Time[0];
   price_down_PoE_9      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   PoE_Move_9(arrow_name_up_PoE_9, time_up_PoE_9, price_up_PoE_9);
   PoE_Move_9(arrow_name_down_PoE_9, time_down_PoE_9, price_down_PoE_9);
//+------------------------------------------------------------------+
   arrow_name_up_PoE_10 = "ARROW_UP_PoE 10" + TimeToString(Time[0]);
   time_up_PoE_10       = Time[0];
   price_up_PoE_10      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   arrow_name_down_PoE_10 = "ARROW_DOWN_PoE 10" + TimeToString(Time[0]);
   time_down_PoE_10       = Time[0];
   price_down_PoE_10      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   PoE_Move_10(arrow_name_up_PoE_10, time_up_PoE_10, price_up_PoE_10);
   PoE_Move_10(arrow_name_down_PoE_10, time_down_PoE_10, price_down_PoE_10);
//+------------------------------------------------------------------+
   arrow_name_up_PoE_11 = "ARROW_UP_PoE 11" + TimeToString(Time[0]);
   time_up_PoE_11       = Time[0];
   price_up_PoE_11      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   arrow_name_down_PoE_11 = "ARROW_DOWN_PoE 11" + TimeToString(Time[0]);
   time_down_PoE_11       = Time[0];
   price_down_PoE_11      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   PoE_Move_11(arrow_name_up_PoE_11, time_up_PoE_11, price_up_PoE_11);
   PoE_Move_11(arrow_name_down_PoE_11, time_down_PoE_11, price_down_PoE_11);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_DPoE = "ARROW_UP_DPoE 0" + TimeToString(Time[0]);
   time_up_DPoE       = Time[0];
   price_up_DPoE      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   DPoE_Move(arrow_name_up_DPoE, time_up_DPoE, price_up_DPoE);
//
   arrow_name_down_DPoE = "ARROW_DOWN_DPoE 0" + TimeToString(Time[0]);
   time_down_DPoE       = Time[0];
   price_down_DPoE      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   DPoE_Move(arrow_name_down_DPoE, time_down_DPoE, price_down_DPoE);
//+------------------------------------------------------------------+
   arrow_name_up_DPoE_1 = "ARROW_UP_DPoE 1" + TimeToString(Time[0]);
   time_up_DPoE_1       = Time[0];
   price_up_DPoE_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   DPoE_Move_1(arrow_name_up_DPoE_1, time_up_DPoE_1, price_up_DPoE_1);
//
   arrow_name_down_DPoE_1 = "ARROW_DOWN_DPoE 1" + TimeToString(Time[0]);
   time_down_DPoE_1       = Time[0];
   price_down_DPoE_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   DPoE_Move_1(arrow_name_down_DPoE_1, time_down_DPoE_1, price_down_DPoE_1);
//+------------------------------------------------------------------+
   arrow_name_up_DPoE_2 = "ARROW_UP_DPoE 2" + TimeToString(Time[0]);
   time_up_DPoE_2       = Time[0];
   price_up_DPoE_2      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   DPoE_Move_2(arrow_name_up_DPoE_2, time_up_DPoE_2, price_up_DPoE_2);
//
   arrow_name_down_DPoE_2 = "ARROW_DOWN_DPoE 2" + TimeToString(Time[0]);
   time_down_DPoE_2       = Time[0];
   price_down_DPoE_2      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   DPoE_Move_2(arrow_name_down_DPoE_2, time_down_DPoE_2, price_down_DPoE_2);
//+------------------------------------------------------------------+
   arrow_name_up_DPoE_3 = "ARROW_UP_DPoE 3" + TimeToString(Time[0]);
   time_up_DPoE_3       = Time[0];
   price_up_DPoE_3      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   DPoE_Move_3(arrow_name_up_DPoE_3, time_up_DPoE_3, price_up_DPoE_3);
//
   arrow_name_down_DPoE_3 = "ARROW_DOWN_DPoE 3" + TimeToString(Time[0]);
   time_down_DPoE_3       = Time[0];
   price_down_DPoE_3      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   DPoE_Move_3(arrow_name_down_DPoE_3, time_down_DPoE_3, price_down_DPoE_3);
//+------------------------------------------------------------------+
   arrow_name_up_DPoE_4 = "ARROW_UP_DPoE 4" + TimeToString(Time[0]);
   time_up_DPoE_4       = Time[0];
   price_up_DPoE_4      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   DPoE_Move_4(arrow_name_up_DPoE_4, time_up_DPoE_4, price_up_DPoE_4);
//
   arrow_name_down_DPoE_4 = "ARROW_DOWN_DPoE 4" + TimeToString(Time[0]);
   time_down_DPoE_4       = Time[0];
   price_down_DPoE_4      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   DPoE_Move_4(arrow_name_down_DPoE_4, time_down_DPoE_4, price_down_DPoE_4);
//+------------------------------------------------------------------+
   arrow_name_up_DPoE_5 = "ARROW_UP_DPoE 5" + TimeToString(Time[0]);
   time_up_DPoE_5       = Time[0];
   price_up_DPoE_5      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   DPoE_Move_5(arrow_name_up_DPoE_5, time_up_DPoE_5, price_up_DPoE_5);
//
   arrow_name_down_DPoE_5 = "ARROW_DOWN_DPoE 5" + TimeToString(Time[0]);
   time_down_DPoE_5       = Time[0];
   price_down_DPoE_5      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   DPoE_Move_5(arrow_name_down_DPoE_5, time_down_DPoE_5, price_down_DPoE_5);
//+------------------------------------------------------------------+
   arrow_name_up_MDS = "ARROW_UP_MDS" + TimeToString(Time[0]);
   time_up_MDS       = Time[0];
   price_up_MDS      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   MDS_Move(arrow_name_up_MDS, time_up_MDS, price_up_MDS);
//
   arrow_name_down_MDS = "ARROW_DOWN_MDS" + TimeToString(Time[0]);
   time_down_MDS       = Time[0];
   price_down_MDS      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   MDS_Move(arrow_name_down_MDS, time_down_MDS, price_down_MDS);
//+------------------------------------------------------------------+
   arrow_name_up_EDS = "ARROW_UP_EDS" + TimeToString(Time[0]);
   time_up_EDS       = Time[0];
   price_up_EDS      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   EDS_Move(arrow_name_up_EDS, time_up_EDS, price_up_EDS);
//
   arrow_name_down_EDS = "ARROW_DOWN_EDS" + TimeToString(Time[0]);
   time_down_EDS       = Time[0];
   price_down_EDS      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   EDS_Move(arrow_name_down_EDS, time_down_EDS, price_down_EDS);
//+------------------------------------------------------------------+
   arrow_name_up_MS = "ARROW_UP MS" + TimeToString(Time[0]);
   time_up_MS       = Time[0];
   price_up_MS      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   MS_Move(arrow_name_up_MS, time_up_MS, price_up_MS);
//
   arrow_name_down_MS = "ARROW_DOWN MS" + TimeToString(Time[0]);
   time_down_MS       = Time[0];
   price_down_MS      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   MS_Move(arrow_name_down_MS, time_down_MS, price_down_MS);
//+------------------------------------------------------------------+
   arrow_name_up_ES = "ARROW_UP ES" + TimeToString(Time[0]);
   time_up_ES       = Time[0];
   price_up_ES      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   ES_Move(arrow_name_up_ES, time_up_ES, price_up_ES);
//
   arrow_name_down_ES = "ARROW_DOWN ES" + TimeToString(Time[0]);
   time_down_ES       = Time[0];
   price_down_ES      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   ES_Move(arrow_name_down_ES, time_down_ES, price_down_ES);
//+------------------------------------------------------------------+
   arrow_name_up_MS_1 = "ARROW_UP MS_1" + TimeToString(Time[0]);
   time_up_MS_1       = Time[0];
   price_up_MS_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   MS_1_Move(arrow_name_up_MS_1, time_up_MS_1, price_up_MS_1);
//
   arrow_name_down_MS_1 = "ARROW_DOWN MS_1" + TimeToString(Time[0]);
   time_down_MS_1       = Time[0];
   price_down_MS_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   MS_1_Move(arrow_name_down_MS_1, time_down_MS_1, price_down_MS_1);
//+------------------------------------------------------------------+
   arrow_name_up_ES_1 = "ARROW_UP ES_1" + TimeToString(Time[0]);
   time_up_ES_1       = Time[0];
   price_up_ES_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   ES_1_Move(arrow_name_up_ES_1, time_up_ES_1, price_up_ES_1);
//
   arrow_name_down_ES_1 = "ARROW_DOWN ES_1" + TimeToString(Time[0]);
   time_down_ES_1       = Time[0];
   price_down_ES_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   ES_1_Move(arrow_name_down_ES_1, time_down_ES_1, price_down_ES_1);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_MS50 = "ARROW_UP MS50" + TimeToString(Time[0]);
   time_up_MS50       = Time[0];
   price_up_MS50      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   MS50_Move(arrow_name_up_MS50, time_up_MS50, price_up_MS50);
//
   arrow_name_down_MS50 = "ARROW_DOWN MS50" + TimeToString(Time[0]);
   time_down_MS50       = Time[0];
   price_down_MS50      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   MS50_Move(arrow_name_down_MS50, time_down_MS50, price_down_MS50);
//+------------------------------------------------------------------+
   arrow_name_up_ES50 = "ARROW_UP ES50" + TimeToString(Time[0]);
   time_up_ES50       = Time[0];
   price_up_ES50      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   ES50_Move(arrow_name_up_ES50, time_up_ES50, price_up_ES50);
//
   arrow_name_down_ES50 = "ARROW_DOWN ES50" + TimeToString(Time[0]);
   time_down_ES50       = Time[0];
   price_down_ES50      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   ES50_Move(arrow_name_down_ES50, time_down_ES50, price_down_ES50);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_EES_Equal = "ARROW_UP EES_Equal" + TimeToString(Time[0]);
   time_up_EES_Equal       = Time[0];
   price_up_EES_Equal      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   EES_Equal_Move(arrow_name_up_EES_Equal, time_up_EES_Equal, price_up_EES_Equal);
//
   arrow_name_down_EES_Equal = "ARROW_DOWN EES_Equal" + TimeToString(Time[0]);
   time_down_EES_Equal       = Time[0];
   price_down_EES_Equal      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   EES_Equal_Move(arrow_name_down_EES_Equal, time_down_EES_Equal, price_down_EES_Equal);
//+------------------------------------------------------------------+
   arrow_name_up_EMS_Equal = "ARROW_UP EMS_Equal" + TimeToString(Time[0]);
   time_up_EMS_Equal       = Time[0];
   price_up_EMS_Equal      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   EMS_Equal_Move(arrow_name_up_EMS_Equal, time_up_EMS_Equal, price_up_EMS_Equal);
//
   arrow_name_down_EMS_Equal = "ARROW_DOWN EMS_Equal" + TimeToString(Time[0]);
   time_down_EMS_Equal       = Time[0];
   price_down_EMS_Equal      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   EMS_Equal_Move(arrow_name_down_EMS_Equal, time_down_EMS_Equal, price_down_EMS_Equal);
//+------------------------------------------------------------------+
   arrow_name_up_EES_Equal_1 = "ARROW_UP EES_Equal_1" + TimeToString(Time[0]);
   time_up_EES_Equal_1       = Time[0];
   price_up_EES_Equal_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   EES_Equal_1_Move(arrow_name_up_EES_Equal_1, time_up_EES_Equal_1, price_up_EES_Equal_1);
//
   arrow_name_down_EES_Equal_1 = "ARROW_DOWN EES_Equal_1" + TimeToString(Time[0]);
   time_down_EES_Equal_1       = Time[0];
   price_down_EES_Equal_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   EES_Equal_1_Move(arrow_name_down_EES_Equal_1, time_down_EES_Equal_1, price_down_EES_Equal_1);
//+------------------------------------------------------------------+
   arrow_name_up_EMS_Equal_1 = "ARROW_UP EMS_Equal_1" + TimeToString(Time[0]);
   time_up_EMS_Equal_1       = Time[0];
   price_up_EMS_Equal_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   EMS_Equal_1_Move(arrow_name_up_EMS_Equal_1, time_up_EMS_Equal_1, price_up_EMS_Equal_1);
//
   arrow_name_down_EMS_Equal_1 = "ARROW_DOWN EMS_Equal_1" + TimeToString(Time[0]);
   time_down_EMS_Equal_1       = Time[0];
   price_down_EMS_Equal_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   EMS_Equal_1_Move(arrow_name_down_EMS_Equal_1, time_down_EMS_Equal_1, price_down_EMS_Equal_1);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_Eng = "ARROW_UP_Eng" + TimeToString(Time[0]);
   time_up_Eng       = Time[0];
   price_up_Eng      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   Eng_Move(arrow_name_up_Eng, time_up_Eng, price_up_Eng);
//
   arrow_name_down_Eng = "ARROW_DOWN_Eng" + TimeToString(Time[0]);
   time_down_Eng       = Time[0];
   price_down_Eng      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   Eng_Move(arrow_name_down_Eng, time_down_Eng, price_down_Eng);
//+------------------------------------------------------------------+
   arrow_name_up_Eng_1 = "ARROW_UP_Eng2" + TimeToString(Time[0]);
   time_up_Eng_1       = Time[0];
   price_up_Eng_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   Eng_Move_1(arrow_name_up_Eng_1, time_up_Eng_1, price_up_Eng_1);
//
   arrow_name_down_Eng_1 = "ARROW_DOWN_Eng2" + TimeToString(Time[0]);
   time_down_Eng_1       = Time[0];
   price_down_Eng_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   Eng_Move_1(arrow_name_down_Eng_1, time_down_Eng_1, price_down_Eng_1);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_EXC = "ARROW_UP_EXC" + TimeToString(Time[0]);
   time_up_EXC       = Time[0];
   price_up_EXC      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   EXC_Move(arrow_name_up_EXC, time_up_EXC, price_up_EXC);
//
   arrow_name_down_EXC = "ARROW_DOWN_EXC" + TimeToString(Time[0]);
   time_down_EXC       = Time[0];
   price_down_EXC      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_EXP = "ARROW_UP_EXP" + TimeToString(Time[0]);
   time_up_EXP       = Time[0];
   price_up_EXP      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   EXP_Move(arrow_name_up_EXP, time_up_EXP, price_up_EXP);
//
   arrow_name_down_EXP = "ARROW_DOWN_EXP" + TimeToString(Time[0]);
   time_down_EXP       = Time[0];
   price_down_EXP      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   EXP_Move(arrow_name_down_EXP, time_down_EXP, price_down_EXP);
//+------------------------------------------------------------------+
   arrow_name_up_EXR = "ARROW_UP_EXR" + TimeToString(Time[0]);
   time_up_EXR       = Time[0];
   price_up_EXR      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   EXR_Move(arrow_name_up_EXR, time_up_EXR, price_up_EXR);
//
   arrow_name_down_EXR = "ARROW_DOWN_EXR" + TimeToString(Time[0]);
   time_down_EXR       = Time[0];
   price_down_EXR      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   EXR_Move(arrow_name_down_EXR, time_down_EXR, price_down_EXR);
//+------------------------------------------------------------------+
   arrow_name_up_EXRC = "ARROW_UP_EXRC" + TimeToString(Time[0]);
   time_up_EXRC       = Time[0];
   price_up_EXRC      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   EXRC_Move(arrow_name_up_EXRC, time_up_EXRC, price_up_EXRC);
//   arrow_name_down_EXRC = "ARROW_DOWN_EXRC" + TimeToString(Time[0]);
   time_down_EXRC       = Time[0];
   price_down_EXRC      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   EXRC_Move(arrow_name_down_EXRC, time_down_EXRC, price_down_EXRC);
//+------------------------------------------------------------------+
   arrow_name_up_NRS = "ARROW_UP_NRS" + TimeToString(Time[0]);
   time_up_NRS       = Time[0];
   price_up_NRS      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   NRS_Move(arrow_name_up_NRS, time_up_NRS, price_up_NRS);
//
   arrow_name_down_NRS = "ARROW_DOWN_NRS" + TimeToString(Time[0]);
   time_down_NRS       = Time[0];
   price_down_NRS      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   NRS_Move(arrow_name_down_NRS, time_down_NRS, price_down_NRS);
//+------------------------------------------------------------------+
   arrow_name_up_FNRS = "ARROW_UP_FNRS" + TimeToString(Time[0]);
   time_up_FNRS       = Time[0];
   price_up_FNRS      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   FNRS_Move(arrow_name_up_FNRS, time_up_FNRS, price_up_FNRS);
//
   arrow_name_down_FNRS = "ARROW_DOWN_FNRS" + TimeToString(Time[0]);
   time_down_FNRS       = Time[0];
   price_down_FNRS      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   FNRS_Move(arrow_name_down_FNRS, time_down_FNRS, price_down_FNRS);
//+------------------------------------------------------------------+
   arrow_name_up_NRSP = "ARROW_UP_FNRS" + TimeToString(Time[0]);
   time_up_NRSP       = Time[0];
   price_up_NRSP      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   arrow_name_down_NRSP = "ARROW_DOWN_FNRS" + TimeToString(Time[0]);
   time_down_NRSP       = Time[0];
   price_down_NRSP      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   NRSP_Move(arrow_name_up_NRSP, time_up_NRSP, price_up_NRSP);
   NRSP_Move(arrow_name_down_NRSP, time_down_NRSP, price_down_NRSP);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_SnR = "ARROW_up_SnR" + TimeToString(Time[0]);
   time_up_SnR       = Time[0];
   price_up_SnR      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   Arrow_Move_buy_SnR(arrow_name_up_SnR, time_up_SnR, price_up_SnR);
//
   arrow_name_down_SnR = "ARROW_down_SnR" + TimeToString(Time[0]);
   time_down_SnR       = Time[0];
   price_down_SnR      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   Arrow_Move_sell_SnR(arrow_name_down_SnR, time_down_SnR, price_down_SnR);
//+------------------------------------------------------------------+
   arrow_name_up_buy_SnR = "ARROW_UP_buy_SnR" + TimeToString(Time[0]);
   time_up_buy_SnR       = Time[2];
   price_up_buy_SnR      = Low[2] - Arrow_distance * 1 * Point;
   Arrow_Move_buy_SnR(arrow_name_up_buy_SnR, time_up_buy_SnR, price_up_buy_SnR);
//
   arrow_name_down_sell_SnR = "ARROW_DOWN_sell_SnR" + TimeToString(Time[0]);
   time_down_sell_SnR       = Time[2];
   price_down_sell_SnR      = High[2] + Arrow_distance * 1 * Point;
   Arrow_Move_sell_SnR(arrow_name_down_sell_SnR, time_down_sell_SnR, price_down_sell_SnR);
//+------------------------------------------------------------------+
   arrow_name_up_FB = "ARROW_UP_FB" + TimeToString(Time[0]);
   time_up_FB       = Time[0];
   price_up_FB      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   FB_Move(arrow_name_up_FB, time_up_FB, price_up_FB);
//
   arrow_name_down_FB = "ARROW_DOWN_FB" + TimeToString(Time[0]);
   time_down_FB       = Time[0];
   price_down_FB      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   FB_Move(arrow_name_down_FB, time_down_FB, price_down_FB);
//+------------------------------------------------------------------+
   arrow_name_up_shoting_s_1 = "ARROW_UP_shoting_s_1" + TimeToString(Time[0]);
   time_up_shoting_s_1       = Time[0];
   price_up_shoting_s_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   shoting_s_1_Move(arrow_name_up_shoting_s_1, time_up_shoting_s_1, price_up_shoting_s_1);
//
   arrow_name_down_shoting_s_1 = "ARROW_DOWN_shoting_s_1" + TimeToString(Time[0]);
   time_down_shoting_s_1       = Time[0];
   price_down_shoting_s_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   shoting_s_1_Move(arrow_name_down_shoting_s_1, time_down_shoting_s_1, price_down_shoting_s_1);
//+------------------------------------------------------------------+
   arrow_name_up_shoting_s_2 = "ARROW_UP_shoting_s_2" + TimeToString(Time[0]);
   time_up_shoting_s_2       = Time[0];
   price_up_shoting_s_2      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   shoting_s_2_Move(arrow_name_up_shoting_s_2, time_up_shoting_s_2, price_up_shoting_s_2);
//
   arrow_name_down_shoting_s_2 = "ARROW_DOWN_shoting_s_2" + TimeToString(Time[0]);
   time_down_shoting_s_2       = Time[0];
   price_down_shoting_s_2      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   shoting_s_2_Move(arrow_name_down_shoting_s_2, time_down_shoting_s_2, price_down_shoting_s_2);
//+------------------------------------------------------------------+
   arrow_name_up_shoting_s_3 = "ARROW_UP_shoting_s_3" + TimeToString(Time[0]);
   time_up_shoting_s_3       = Time[0];
   price_up_shoting_s_3      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   shoting_s_3_Move(arrow_name_up_shoting_s_3, time_up_shoting_s_3, price_up_shoting_s_3);
//
   arrow_name_down_shoting_s_3 = "ARROW_DOWN_shoting_s_3" + TimeToString(Time[0]);
   time_down_shoting_s_3       = Time[0];
   price_down_shoting_s_3      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   shoting_s_3_Move(arrow_name_down_shoting_s_3, time_down_shoting_s_3, price_down_shoting_s_3);
//+------------------------------------------------------------------+
   arrow_name_down_shoting_s_4 = "ARROW_DOWN_shoting_s_4" + TimeToString(Time[0]);
   time_down_shoting_s_4       = Time[0];
   price_down_shoting_s_4      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   shoting_s_4_Move(arrow_name_down_shoting_s_4, time_down_shoting_s_4, price_down_shoting_s_4);
//+------------------------------------------------------------------+
   arrow_name_up_marubozu = "ARROW_UP_marubozu" + TimeToString(Time[0]);
   time_up_marubozu       = Time[0];
   price_up_marubozu      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   marubozu_Move(arrow_name_up_marubozu, time_up_marubozu, price_up_marubozu);
//
   arrow_name_down_marubozu = "ARROW_DOWN_marubozu" + TimeToString(Time[0]);
   time_down_marubozu       = Time[0];
   price_down_marubozu      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   marubozu_Move(arrow_name_down_marubozu, time_down_marubozu, price_down_marubozu);
//+------------------------------------------------------------------+
   arrow_name_up_dragonfly = "ARROW_UP_dragonfly" + TimeToString(Time[0]);
   time_up_dragonfly       = Time[0];
   price_up_dragonfly      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   dragonfly_Move(arrow_name_up_dragonfly, time_up_dragonfly, price_up_dragonfly);
//
   arrow_name_down_dragonfly = "ARROW_DOWN_dragonfly" + TimeToString(Time[0]);
   time_down_dragonfly       = Time[0];
   price_down_dragonfly      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   dragonfly_Move(arrow_name_down_dragonfly, time_down_dragonfly, price_down_dragonfly);
//+------------------------------------------------------------------+
   arrow_name_up_gap = "ARROW_UP_gap" + TimeToString(Time[0]);
   time_up_gap       = Time[0];
   price_up_gap      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   gap_Move(arrow_name_up_gap, time_up_gap, price_up_gap);
//
   arrow_name_down_gap = "ARROW_DOWN_gap" + TimeToString(Time[0]);
   time_down_gap       = Time[0];
   price_down_gap      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   gap_Move(arrow_name_down_gap, time_down_gap, price_down_gap);
//+------------------------------------------------------------------+
   arrow_name_up_gravestone = "ARROW_UP_gravestone" + TimeToString(Time[0]);
   time_up_gravestone       = Time[0];
   price_up_gravestone      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   gravestone_Move(arrow_name_up_gravestone, time_up_gravestone, price_up_gravestone);
//
   arrow_name_down_gravestone = "ARROW_DOWN_gravestone" + TimeToString(Time[0]);
   time_down_gravestone       = Time[0];
   price_down_gravestone      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   gravestone_Move(arrow_name_down_gravestone, time_down_gravestone, price_down_gravestone);
//+------------------------------------------------------------------+
   arrow_name_up_inverted_hammer = "ARROW_UP_inverted_hammer" + TimeToString(Time[0]);
   time_up_inverted_hammer       = Time[0];
   price_up_inverted_hammer      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   inverted_hammer_Move(arrow_name_up_inverted_hammer, time_up_inverted_hammer, price_up_inverted_hammer);
//
   arrow_name_down_inverted_hammer = "ARROW_DOWN_inverted_hammer" + TimeToString(Time[0]);
   time_down_inverted_hammer       = Time[0];
   price_down_inverted_hammer      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   inverted_hammer_Move(arrow_name_down_inverted_hammer, time_down_inverted_hammer, price_down_inverted_hammer);
//+------------------------------------------------------------------+
   arrow_name_up_EES_1 = "ARROW_UP_EES_1" + TimeToString(Time[0]);
   time_up_EES_1       = Time[0];
   price_up_EES_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   EES_1_Move(arrow_name_up_EES_1, time_up_EES_1, price_up_EES_1);
//
   arrow_name_down_EES_1 = "ARROW_DOWN_EES_1" + TimeToString(Time[0]);
   time_down_EES_1       = Time[0];
   price_down_EES_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   EES_1_Move(arrow_name_down_EES_1, time_down_EES_1, price_down_EES_1);
//+------------------------------------------------------------------+
   arrow_name_up_EMS_1 = "ARROW_UP_EMS_1" + TimeToString(Time[0]);
   time_up_EMS_1       = Time[0];
   price_up_EMS_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   EMS_1_Move(arrow_name_up_EMS_1, time_up_EMS_1, price_up_EMS_1);
//
   arrow_name_down_EMS_1 = "ARROW_DOWN_EMS_1" + TimeToString(Time[0]);
   time_down_EMS_1       = Time[0];
   price_down_EMS_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   EMS_1_Move(arrow_name_down_EMS_1, time_down_EMS_1, price_down_EMS_1);
//+------------------------------------------------------------------+
   arrow_name_up_NRS_1 = "ARROW_UP_NRS_1" + TimeToString(Time[0]);
   time_up_NRS_1       = Time[0];
   price_up_NRS_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   NRS_1_Move(arrow_name_up_NRS_1, time_up_NRS_1, price_up_NRS_1);
//
   arrow_name_down_NRS_1 = "ARROW_DOWN_NRS_1" + TimeToString(Time[0]);
   time_down_NRS_1       = Time[0];
   price_down_NRS_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   NRS_1_Move(arrow_name_down_NRS_1, time_down_NRS_1, price_down_NRS_1);
//+------------------------------------------------------------------+
   arrow_name_up_MS50_1 = "ARROW_UP_MS50_1" + TimeToString(Time[0]);
   time_up_MS50_1       = Time[0];
   price_up_MS50_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   MS50_1_Move(arrow_name_up_MS50_1, time_up_MS50_1, price_up_MS50_1);
//
   arrow_name_down_MS50_1 = "ARROW_DOWN_MS50_1" + TimeToString(Time[0]);
   time_down_MS50_1       = Time[0];
   price_down_MS50_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   MS50_1_Move(arrow_name_down_MS50_1, time_down_MS50_1, price_down_MS50_1);
//+------------------------------------------------------------------+
   arrow_name_up_ES50_1 = "ARROW_UP ES50_1" + TimeToString(Time[0]);
   time_up_ES50_1       = Time[0];
   price_up_ES50_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   ES50_1_Move(arrow_name_up_ES50_1, time_up_ES50_1, price_up_ES50_1);
//
   arrow_name_down_ES50_1 = "ARROW_DOWN ES50_1" + TimeToString(Time[0]);
   time_down_ES50_1       = Time[0];
   price_down_ES50_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   ES50_1_Move(arrow_name_down_ES50_1, time_down_ES50_1, price_down_ES50_1);
//+------------------------------------------------------------------+
   arrow_name_up_Hanging_man = "ARROW_UP Hanging_man" + TimeToString(Time[0]);
   time_up_Hanging_man       = Time[0];
   price_up_Hanging_man      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   Hanging_man_Move(arrow_name_up_Hanging_man, time_up_Hanging_man, price_up_Hanging_man);
//
   arrow_name_down_Hanging_man = "ARROW_DOWN Hanging_man" + TimeToString(Time[0]);
   time_down_Hanging_man       = Time[0];
   price_down_Hanging_man      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   Hanging_man_Move(arrow_name_down_Hanging_man, time_down_Hanging_man, price_down_Hanging_man);
//+------------------------------------------------------------------+
   arrow_name_up_Harami = "ARROW_UP Harami" + TimeToString(Time[0]);
   time_up_Harami       = Time[0];
   price_up_Harami      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   Harami_Move(arrow_name_up_Harami, time_up_Harami, price_up_Harami);
//
   arrow_name_down_Harami = "ARROW_DOWN Harami" + TimeToString(Time[0]);
   time_down_Harami       = Time[0];
   price_down_Harami      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   Harami_Move(arrow_name_down_Harami, time_down_Harami, price_down_Harami);
//+------------------------------------------------------------------+
   arrow_name_up_HHLL = "ARROW_UP HHLL" + TimeToString(Time[0]);
   time_up_HHLL       = Time[0];
   price_up_HHLL      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   HHLL_Move(arrow_name_up_HHLL, time_up_HHLL, price_up_HHLL);
//
   arrow_name_down_HHLL = "ARROW_DOWN HHLL" + TimeToString(Time[0]);
   time_down_HHLL       = Time[0];
   price_down_HHLL      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   HHLL_Move(arrow_name_down_HHLL, time_down_HHLL, price_down_HHLL);
//+------------------------------------------------------------------+
   arrow_name_up_eng_1 = "ARROW_UP eng_1" + TimeToString(Time[0]);
   time_up_eng_1       = Time[0];
   price_up_eng_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   eng_1_Move(arrow_name_up_eng_1, time_up_eng_1, price_up_eng_1);
//
   arrow_name_down_eng_1 = "ARROW_DOWN eng_1" + TimeToString(Time[0]);
   time_down_eng_1       = Time[0];
   price_down_eng_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   eng_1_Move(arrow_name_down_eng_1, time_down_eng_1, price_down_eng_1);
//+------------------------------------------------------------------+
   arrow_name_up_eng_2 = "ARROW_UP eng_2" + TimeToString(Time[0]);
   time_up_eng_2       = Time[0];
   price_up_eng_2      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   eng_2_Move(arrow_name_up_eng_2, time_up_eng_2, price_up_eng_2);
//
   arrow_name_down_eng_2 = "ARROW_DOWN eng_2" + TimeToString(Time[0]);
   time_down_eng_2       = Time[0];
   price_down_eng_2      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   eng_2_Move(arrow_name_down_eng_2, time_down_eng_2, price_down_eng_2);
//+------------------------------------------------------------------+
   arrow_name_up_eng_3 = "ARROW_UP eng_3" + TimeToString(Time[0]);
   time_up_eng_3       = Time[0];
   price_up_eng_3      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   eng_3_Move(arrow_name_up_eng_3, time_up_eng_3, price_up_eng_3);
//
   arrow_name_down_eng_3 = "ARROW_DOWN eng_3" + TimeToString(Time[0]);
   time_down_eng_3       = Time[0];
   price_down_eng_3      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   eng_3_Move(arrow_name_down_eng_3, time_down_eng_3, price_down_eng_3);
//+------------------------------------------------------------------+
   arrow_name_up_eng_4 = "ARROW_UP eng_4" + TimeToString(Time[0]);
   time_up_eng_4       = Time[0];
   price_up_eng_4      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   eng_4_Move(arrow_name_up_eng_4, time_up_eng_4, price_up_eng_4);
//
   arrow_name_down_eng_4 = "ARROW_DOWN eng_4" + TimeToString(Time[0]);
   time_down_eng_4       = Time[0];
   price_down_eng_4      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   eng_4_Move(arrow_name_down_eng_4, time_down_eng_4, price_down_eng_4);
//+------------------------------------------------------------------+
   arrow_name_up_eng_5 = "ARROW_UP eng_5" + TimeToString(Time[0]);
   time_up_eng_5       = Time[0];
   price_up_eng_5      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   eng_5_Move(arrow_name_up_eng_5, time_up_eng_5, price_up_eng_5);
//
   arrow_name_down_eng_5 = "ARROW_DOWN eng_5" + TimeToString(Time[0]);
   time_down_eng_5       = Time[0];
   price_down_eng_5      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   eng_5_Move(arrow_name_down_eng_5, time_down_eng_5, price_down_eng_5);
//+------------------------------------------------------------------+
   arrow_name_up_eng_6 = "ARROW_UP eng_6" + TimeToString(Time[0]);
   time_up_eng_6       = Time[0];
   price_up_eng_6      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   eng_6_Move(arrow_name_up_eng_6, time_up_eng_6, price_up_eng_6);
//
   arrow_name_down_eng_6 = "ARROW_DOWN eng_6" + TimeToString(Time[0]);
   time_down_eng_6       = Time[0];
   price_down_eng_6      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   eng_6_Move(arrow_name_down_eng_6, time_down_eng_6, price_down_eng_6);
//+------------------------------------------------------------------+
   arrow_name_up_dc_1 = "ARROW_UP dc_1" + TimeToString(Time[0]);
   time_up_dc_1       = Time[0];
   price_up_dc_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   dc_1_Move(arrow_name_up_dc_1, time_up_dc_1, price_up_dc_1);
//
   arrow_name_down_dc_1 = "ARROW_DOWN dc_1" + TimeToString(Time[0]);
   time_down_dc_1       = Time[0];
   price_down_dc_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   dc_1_Move(arrow_name_down_dc_1, time_down_dc_1, price_down_dc_1);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_dc_2 = "ARROW_UP dc_2" + TimeToString(Time[0]);
   time_up_dc_2       = Time[0];
   price_up_dc_2      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   dc_2_Move(arrow_name_up_dc_2, time_up_dc_2, price_up_dc_2);
//
   arrow_name_down_dc_2 = "ARROW_DOWN dc_2" + TimeToString(Time[0]);
   time_down_dc_2       = Time[0];
   price_down_dc_2      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   dc_2_Move(arrow_name_down_dc_2, time_down_dc_2, price_down_dc_2);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_huge_candle_1 = "ARROW_UP huge_candle_1" + TimeToString(Time[0]);
   time_up_huge_candle_1       = Time[0];
   price_up_huge_candle_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   huge_candle_1_Move(arrow_name_up_huge_candle_1, time_up_huge_candle_1, price_up_huge_candle_1);
//
   arrow_name_down_huge_candle_1 = "ARROW_DOWN huge_candle_1" + TimeToString(Time[0]);
   time_down_huge_candle_1       = Time[0];
   price_down_huge_candle_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   huge_candle_1_Move(arrow_name_down_huge_candle_1, time_down_huge_candle_1, price_down_huge_candle_1);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_huge_candle_2 = "ARROW_UP huge_candle_2" + TimeToString(Time[0]);
   time_up_huge_candle_2       = Time[0];
   price_up_huge_candle_2      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   huge_candle_2_Move(arrow_name_up_huge_candle_2, time_up_huge_candle_2, price_up_huge_candle_2);
//
   arrow_name_down_huge_candle_2 = "ARROW_DOWN huge_candle_2" + TimeToString(Time[0]);
   time_down_huge_candle_2       = Time[0];
   price_down_huge_candle_2      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   huge_candle_2_Move(arrow_name_down_huge_candle_2, time_down_huge_candle_2, price_down_huge_candle_2);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_huge_candle_3 = "ARROW_UP huge_candle_3" + TimeToString(Time[0]);
   time_up_huge_candle_3       = Time[0];
   price_up_huge_candle_3      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   huge_candle_3_Move(arrow_name_up_huge_candle_3, time_up_huge_candle_3, price_up_huge_candle_3);
//
   arrow_name_down_huge_candle_3 = "ARROW_DOWN huge_candle_3" + TimeToString(Time[0]);
   time_down_huge_candle_3       = Time[0];
   price_down_huge_candle_3      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   huge_candle_3_Move(arrow_name_down_huge_candle_3, time_down_huge_candle_3, price_down_huge_candle_3);
//+------------------------------------------------------------------+
   arrow_name_up_ms_buy_1_es_1 = "ARROW_UP ms_buy_1_es_1" + TimeToString(Time[0]);
   time_up_ms_buy_1_es_1       = Time[0];
   price_up_ms_buy_1_es_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   ms_buy_1_es_1_Move(arrow_name_up_ms_buy_1_es_1, time_up_ms_buy_1_es_1, price_up_ms_buy_1_es_1);
//
   arrow_name_down_ms_buy_1_es_1 = "ARROW_DOWN ms_buy_1_es_1" + TimeToString(Time[0]);
   time_down_ms_buy_1_es_1       = Time[0];
   price_down_ms_buy_1_es_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   ms_buy_1_es_1_Move(arrow_name_down_ms_buy_1_es_1, time_down_ms_buy_1_es_1, price_down_ms_buy_1_es_1);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_ms_buy_1_es_2 = "ARROW_UP ms_buy_1_es_2" + TimeToString(Time[0]);
   time_up_ms_buy_1_es_2       = Time[0];
   price_up_ms_buy_1_es_2      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   ms_buy_1_es_2_Move(arrow_name_up_ms_buy_1_es_2, time_up_ms_buy_1_es_2, price_up_ms_buy_1_es_2);
//
   arrow_name_down_ms_buy_1_es_2 = "ARROW_DOWN ms_buy_1_es_2" + TimeToString(Time[0]);
   time_down_ms_buy_1_es_2       = Time[0];
   price_down_ms_buy_1_es_2      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   ms_buy_1_es_2_Move(arrow_name_down_ms_buy_1_es_2, time_down_ms_buy_1_es_2, price_down_ms_buy_1_es_2);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_tws_put_1_tbc = "ARROW_UP tws_put_1_tbc" + TimeToString(Time[0]);
   time_up_tws_put_1_tbc       = Time[0];
   price_up_tws_put_1_tbc      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   tws_put_1_tbc_Move(arrow_name_up_tws_put_1_tbc, time_up_tws_put_1_tbc, price_up_tws_put_1_tbc);
//
   arrow_name_down_tws_put_1_tbc = "ARROW_DOWN tws_put_1_tbc" + TimeToString(Time[0]);
   time_down_tws_put_1_tbc       = Time[0];
   price_down_tws_put_1_tbc      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   tws_put_1_tbc_Move(arrow_name_down_tws_put_1_tbc, time_down_tws_put_1_tbc, price_down_tws_put_1_tbc);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_tws_put_2_tbc = "ARROW_UP tws_put_2_tbc" + TimeToString(Time[0]);
   time_up_tws_put_2_tbc       = Time[0];
   price_up_tws_put_2_tbc      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   tws_put_2_tbc_Move(arrow_name_up_tws_put_2_tbc, time_up_tws_put_2_tbc, price_up_tws_put_2_tbc);
//
   arrow_name_down_tws_put_2_tbc = "ARROW_DOWN tws_put_2_tbc" + TimeToString(Time[0]);
   time_down_tws_put_2_tbc       = Time[0];
   price_down_tws_put_2_tbc      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   tws_put_2_tbc_Move(arrow_name_down_tws_put_2_tbc, time_down_tws_put_2_tbc, price_down_tws_put_2_tbc);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_tws_put_3_tbc = "ARROW_UP tws_put_3_tbc" + TimeToString(Time[0]);
   time_up_tws_put_3_tbc       = Time[0];
   price_up_tws_put_3_tbc      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   tws_put_3_tbc_Move(arrow_name_up_tws_put_3_tbc, time_up_tws_put_3_tbc, price_up_tws_put_3_tbc);
//
   arrow_name_down_tws_put_3_tbc = "ARROW_DOWN tws_put_3_tbc" + TimeToString(Time[0]);
   time_down_tws_put_3_tbc       = Time[0];
   price_down_tws_put_3_tbc      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   tws_put_3_tbc_Move(arrow_name_down_tws_put_3_tbc, time_down_tws_put_3_tbc, price_down_tws_put_3_tbc);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_tws_put_4_tbc = "ARROW_UP tws_put_4_tbc" + TimeToString(Time[0]);
   time_up_tws_put_4_tbc       = Time[0];
   price_up_tws_put_4_tbc      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   tws_put_4_tbc_Move(arrow_name_up_tws_put_4_tbc, time_up_tws_put_4_tbc, price_up_tws_put_4_tbc);
//
   arrow_name_down_tws_put_4_tbc = "ARROW_DOWN tws_put_4_tbc" + TimeToString(Time[0]);
   time_down_tws_put_4_tbc       = Time[0];
   price_down_tws_put_4_tbc      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   tws_put_4_tbc_Move(arrow_name_down_tws_put_4_tbc, time_down_tws_put_4_tbc, price_down_tws_put_4_tbc);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_Hammer = "ARROW_UP Hammer" + TimeToString(Time[0]);
   time_up_Hammer       = Time[0];
   price_up_Hammer      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   Hammer_Move(arrow_name_up_Hammer, time_up_Hammer, price_up_Hammer);
//
   arrow_name_down_Hammer = "ARROW_DOWN Hammer" + TimeToString(Time[0]);
   time_down_Hammer       = Time[0];
   price_down_Hammer      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   Hammer_Move(arrow_name_down_Hammer, time_down_Hammer, price_down_Hammer);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_twzb_call_1_twzt_put = "ARROW_UP twzb_call_1_twzt_put" + TimeToString(Time[0]);
   time_up_twzb_call_1_twzt_put       = Time[0];
   price_up_twzb_call_1_twzt_put      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   twzb_call_1_twzt_put_Move(arrow_name_up_twzb_call_1_twzt_put, time_up_twzb_call_1_twzt_put, price_up_twzb_call_1_twzt_put);
//
   arrow_name_down_twzb_call_1_twzt_put = "ARROW_DOWN twzb_call_1_twzt_put" + TimeToString(Time[0]);
   time_down_twzb_call_1_twzt_put       = Time[0];
   price_down_twzb_call_1_twzt_put      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   twzb_call_1_twzt_put_Move(arrow_name_down_twzb_call_1_twzt_put, time_down_twzb_call_1_twzt_put, price_down_twzb_call_1_twzt_put);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_call_reversal_put_reversal = "ARROW_UP call_reversal_put_reversal" + TimeToString(Time[0]);
   time_up_call_reversal_put_reversal       = Time[0];
   price_up_call_reversal_put_reversal      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   call_reversal_put_reversal_Move(arrow_name_up_call_reversal_put_reversal, time_up_call_reversal_put_reversal, price_up_call_reversal_put_reversal);
//
   arrow_name_down_call_reversal_put_reversal = "ARROW_DOWN call_reversal_put_reversal" + TimeToString(Time[0]);
   time_down_call_reversal_put_reversal       = Time[0];
   price_down_call_reversal_put_reversal      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   call_reversal_put_reversal_Move(arrow_name_down_call_reversal_put_reversal, time_down_call_reversal_put_reversal, price_down_call_reversal_put_reversal);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_minor_put_minor_call = "ARROW_UP minor_put_minor_call" + TimeToString(Time[0]);
   time_up_minor_put_minor_call       = Time[0];
   price_up_minor_put_minor_call      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   minor_put_minor_call_Move(arrow_name_up_minor_put_minor_call, time_up_minor_put_minor_call, price_up_minor_put_minor_call);
//
   arrow_name_down_minor_put_minor_call = "ARROW_DOWN minor_put_minor_call" + TimeToString(Time[0]);
   time_down_minor_put_minor_call       = Time[0];
   price_down_minor_put_minor_call      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   minor_put_minor_call_Move(arrow_name_down_minor_put_minor_call, time_down_minor_put_minor_call, price_down_minor_put_minor_call);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_poe_1 = "ARROW_UP poe_1" + TimeToString(Time[0]);
   time_up_poe_1       = Time[0];
   price_up_poe_1      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   poe_1_Move(arrow_name_up_poe_1, time_up_poe_1, price_up_poe_1);
//
   arrow_name_down_poe_1 = "ARROW_DOWN poe_1" + TimeToString(Time[0]);
   time_down_poe_1       = Time[0];
   price_down_poe_1      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   poe_1_Move(arrow_name_down_poe_1, time_down_poe_1, price_down_poe_1);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   arrow_name_up_poe_2 = "ARROW_UP poe_2" + TimeToString(Time[0]);
   time_up_poe_2       = Time[0];
   price_up_poe_2      = Low[0] - (Concept_name_distance - 1) * 2 * Point;
   poe_2_Move(arrow_name_up_poe_2, time_up_poe_2, price_up_poe_2);
//
   arrow_name_down_poe_2 = "ARROW_DOWN poe_2" + TimeToString(Time[0]);
   time_down_poe_2       = Time[0];
   price_down_poe_2      = High[0] + (Concept_name_distance + Concept_name_distance_2) * 1 * 1 * Point;
   poe_2_Move(arrow_name_down_poe_2, time_down_poe_2, price_down_poe_2);
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
   if(isLicence)
     {
      //-------------------------------+
      ObjectDelete("test_12");
      ObjectDelete("test_13");
      ObjectDelete("test_14");
      ObjectDelete("test_15");
      ObjectDelete("test_16");
      ObjectDelete("test_17");
      ObjectDelete("test_18");
      ObjectDelete("test_19");
      ObjectDelete("test_20");
      //------------------------------------------------+
      myMA_20_1  = iMA(Symbol(), 0, Ma_Period, Ma_Shift, Ma_Method, Ma_Price, 1);
      myMA_20_2  = iMA(Symbol(), 0, Ma_Period, Ma_Shift, Ma_Method, Ma_Price, 2);
      myMA_20_3  = iMA(Symbol(), 0, Ma_Period, Ma_Shift, Ma_Method, Ma_Price, 3);
      myMA_20_5  = iMA(Symbol(), 0, Ma_Period, Ma_Shift, Ma_Method, Ma_Price, 5);
      myMA_20_10 = iMA(Symbol(), 0, Ma_Period, Ma_Shift, Ma_Method, Ma_Price, 10);
      myMA_50_1  = iMA(Symbol(), 0, Ma_Period2, Ma_Shift2, Ma_Method2, Ma_Price2, 1);
      myMA_50_2  = iMA(Symbol(), 0, Ma_Period2, Ma_Shift2, Ma_Method2, Ma_Price2, 2);
      myMA_50_3  = iMA(Symbol(), 0, Ma_Period2, Ma_Shift2, Ma_Method2, Ma_Price2, 3);
      myMA_100_1 = iMA(Symbol(), 0, Ma_Period3, Ma_Shift3, Ma_Method3, Ma_Price3, 1);
      myMA_100_2 = iMA(Symbol(), 0, Ma_Period3, Ma_Shift3, Ma_Method3, Ma_Price3, 2);
      myMA_100_3 = iMA(Symbol(), 0, Ma_Period3, Ma_Shift3, Ma_Method3, Ma_Price3, 3);
      myMA_200_1 = iMA(Symbol(), 0, Ma_Period4, Ma_Shift4, Ma_Method4, Ma_Price4, 1);
      myMA_200_2 = iMA(Symbol(), 0, Ma_Period4, Ma_Shift4, Ma_Method4, Ma_Price4, 2);
      myMA_200_3 = iMA(Symbol(), 0, Ma_Period4, Ma_Shift4, Ma_Method4, Ma_Price4, 3);
      //------------------------------------------------+
      Bands_MODE_MAIN_1 = iBands(NULL, 0, Period_, Deviation_2, Shift, PRICE_CLOSE, MODE_MAIN, 1); // 2
      Bands_MODE_MAIN_2 = iBands(NULL, 0, Period_, Deviation_2, Shift, PRICE_CLOSE, MODE_MAIN, 2);
      Bands_MODE_MAIN_3 = iBands(NULL, 0, Period_, Deviation_2, Shift, PRICE_CLOSE, MODE_MAIN, 3);
      ///////
      Bands_up_1_1   = iBands(NULL, 0, Period_2, Deviation_1, Shift_2, PRICE_CLOSE, MODE_LOW, 1); // 1
      Bands_up_1_2   = iBands(NULL, 0, Period_2, Deviation_1, Shift_2, PRICE_CLOSE, MODE_LOW, 2);
      Bands_up_1_3   = iBands(NULL, 0, Period_2, Deviation_1, Shift_2, PRICE_CLOSE, MODE_LOW, 3);
      Bands_up_1_4   =  iBands(NULL, 0, Period_2, Deviation_1, Shift_2, PRICE_CLOSE, MODE_LOW, 4);
      //-
      Bands_down_1_1 = iBands(NULL, 0, Period_2, Deviation_1, Shift, PRICE_CLOSE, MODE_HIGH, 1); // 1
      Bands_down_1_2 = iBands(NULL, 0, Period_2, Deviation_1, Shift, PRICE_CLOSE, MODE_HIGH, 2);
      Bands_down_1_3 = iBands(NULL, 0, Period_2, Deviation_1, Shift, PRICE_CLOSE, MODE_HIGH, 3);
      Bands_down_1_4 = iBands(NULL, 0, Period_2, Deviation_1, Shift, PRICE_CLOSE, MODE_HIGH, 4);
      //---
      //---
      Bands_up_1_5_1  = iBands(NULL, 0, Period_2, Deviation_1_5, Shift_2, PRICE_CLOSE, MODE_LOW, 1); // 1.5
      Bands_up_1_5_2  = iBands(NULL, 0, Period_2, Deviation_1_5, Shift_2, PRICE_CLOSE, MODE_LOW, 2);
      Bands_up_1_5_3  = iBands(NULL, 0, Period_2, Deviation_1_5, Shift_2, PRICE_CLOSE, MODE_LOW, 3);
      Bands_up_1_5_4  = iBands(NULL, 0, Period_2, Deviation_1_5, Shift_2, PRICE_CLOSE, MODE_LOW, 4);
      //---
      Bands_down_1_5_1 = iBands(NULL, 0, Period_2, Deviation_1_5, Shift, PRICE_CLOSE, MODE_HIGH, 1);  // 1.5
      Bands_down_1_5_2 = iBands(NULL, 0, Period_2, Deviation_1_5, Shift, PRICE_CLOSE, MODE_HIGH, 2);
      Bands_down_1_5_3 = iBands(NULL, 0, Period_2, Deviation_1_5, Shift, PRICE_CLOSE, MODE_HIGH, 3);
      Bands_down_1_5_4 = iBands(NULL, 0, Period_2, Deviation_1_5, Shift, PRICE_CLOSE, MODE_HIGH, 4);
      //---
      //---
      Bands_up_1_7_1   = iBands(NULL, 0, Period_2, Deviation_1_7, Shift_2, PRICE_CLOSE, MODE_LOW, 1); // 1.7
      Bands_up_1_7_2   = iBands(NULL, 0, Period_2, Deviation_1_7, Shift_2, PRICE_CLOSE, MODE_LOW, 2);
      Bands_up_1_7_3   = iBands(NULL, 0, Period_2, Deviation_1_7, Shift_2, PRICE_CLOSE, MODE_LOW, 3);
      //---
      Bands_down_1_7_1 = iBands(NULL, 0, Period_2, Deviation_1_7, Shift_2, PRICE_CLOSE, MODE_HIGH, 1); // 1.7
      Bands_down_1_7_2 = iBands(NULL, 0, Period_2, Deviation_1_7, Shift_2, PRICE_CLOSE, MODE_HIGH, 2);
      Bands_down_1_7_3 = iBands(NULL, 0, Period_2, Deviation_1_7, Shift_2, PRICE_CLOSE, MODE_HIGH, 3);
      //---
      //---
      Bands_up_1_8_1   = iBands(NULL, 0, Period_2, Deviation_1_8, Shift_2, PRICE_CLOSE, MODE_LOW, 1); // 1.8
      Bands_up_1_8_2   = iBands(NULL, 0, Period_2, Deviation_1_8, Shift_2, PRICE_CLOSE, MODE_LOW, 2);
      Bands_up_1_8_3   = iBands(NULL, 0, Period_2, Deviation_1_8, Shift_2, PRICE_CLOSE, MODE_LOW, 3);
      //---
      Bands_down_1_8_1 = iBands(NULL, 0, Period_2, Deviation_1_8, Shift_2, PRICE_CLOSE, MODE_HIGH, 1); // 1.8
      Bands_down_1_8_2 = iBands(NULL, 0, Period_2, Deviation_1_8, Shift_2, PRICE_CLOSE, MODE_HIGH, 2);
      Bands_down_1_8_3 = iBands(NULL, 0, Period_2, Deviation_1_8, Shift_2, PRICE_CLOSE, MODE_HIGH, 3);
      //---
      //---
      Bands_up_2_1   = iBands(NULL, 0, Period_2, Deviation_2, Shift, PRICE_CLOSE, MODE_LOW, 1); // 2
      Bands_up_2_2   = iBands(NULL, 0, Period_2, Deviation_2, Shift, PRICE_CLOSE, MODE_LOW, 2);
      Bands_up_2_3   = iBands(NULL, 0, Period_2, Deviation_2, Shift, PRICE_CLOSE, MODE_LOW, 3);
      Bands_up_2_4   = iBands(NULL, 0, Period_2, Deviation_2, Shift, PRICE_CLOSE, MODE_LOW, 4);
      //---
      Bands_down_2_1 = iBands(NULL, 0, Period_2, Deviation_2, Shift, PRICE_CLOSE, MODE_HIGH, 1); // 2
      Bands_down_2_2 = iBands(NULL, 0, Period_2, Deviation_2, Shift, PRICE_CLOSE, MODE_HIGH, 2);
      Bands_down_2_3 = iBands(NULL, 0, Period_2, Deviation_2, Shift, PRICE_CLOSE, MODE_HIGH, 3);
      Bands_down_2_4 = iBands(NULL, 0, Period_2, Deviation_2, Shift, PRICE_CLOSE, MODE_HIGH, 4);
      //---
      Bands_up_2_3_1   = iBands(NULL, 0, Period_2, Deviation_2_3, Shift_2, PRICE_CLOSE, MODE_LOW, 1); // 2.3
      Bands_up_2_3_2   = iBands(NULL, 0, Period_2, Deviation_2_3, Shift_2, PRICE_CLOSE, MODE_LOW, 2);
      Bands_up_2_3_3   = iBands(NULL, 0, Period_2, Deviation_2_3, Shift_2, PRICE_CLOSE, MODE_LOW, 3);
      //---
      Bands_down_2_3_1 = iBands(NULL, 0, Period_2, Deviation_2_3, Shift_2, PRICE_CLOSE, MODE_HIGH, 1); // 2.3
      Bands_down_2_3_2 = iBands(NULL, 0, Period_2, Deviation_2_3, Shift_2, PRICE_CLOSE, MODE_HIGH, 2);
      Bands_down_2_3_3 = iBands(NULL, 0, Period_2, Deviation_2_3, Shift_2, PRICE_CLOSE, MODE_HIGH, 3);
      //---
      //---
      g1  = DoubleToStr(myMA_6_1, _Digits);
      myMA_6_1 = StringToDouble(g1);
      g2  = DoubleToStr(myMA_6_2, _Digits);
      myMA_6_2 = StringToDouble(g2);
      g3  = DoubleToStr(myMA_6_3, _Digits);
      myMA_6_3 = StringToDouble(g3);
      g4  = DoubleToStr(myMA_6_4, _Digits);
      myMA_6_4 = StringToDouble(g4);
      g5  = DoubleToStr(myMA_6_5, _Digits);
      myMA_6_5 = StringToDouble(g5);
      g6  = DoubleToStr(myMA_6_6, _Digits);
      myMA_6_6 = StringToDouble(g6);
      //---
      g50  = DoubleToStr(myMA_8_1, _Digits);
      myMA_8_1 = StringToDouble(g50);
      //---
      g100  = DoubleToStr(myMA_20_1, _Digits);
      myMA_20_1  = StringToDouble(g100);
      g101  = DoubleToStr(myMA_20_2, _Digits);
      myMA_20_2 = StringToDouble(g101);
      g103  = DoubleToStr(myMA_20_4, _Digits);
      myMA_20_4  = StringToDouble(g103);
      g104  = DoubleToStr(myMA_20_5, _Digits);
      myMA_20_5  = StringToDouble(g104);
      g109  = DoubleToStr(myMA_20_10, _Digits);
      myMA_20_10  = StringToDouble(g109);
      //---
      g200  = DoubleToStr(myMA_50_1, _Digits);
      myMA_50_1  = StringToDouble(g200);
      //---
      g300  = DoubleToStr(myMA_100_1, _Digits);
      myMA_100_1 = StringToDouble(g300);
      //---
      gConcept_name_distance_20  = DoubleToStr(myMA_200_1, _Digits);
      myMA_200_1 = StringToDouble(gConcept_name_distance_20);
      //---
      g500  = DoubleToStr(Bands_MODE_MAIN_1, _Digits);
      Bands_MODE_MAIN_1 = StringToDouble(g500);
      g501  = DoubleToStr(Bands_up_1_1, _Digits);
      Bands_up_1_1 = StringToDouble(g501);
      g502  = DoubleToStr(Bands_up_1_2, _Digits);
      Bands_up_1_2 = StringToDouble(g502);
      g503  = DoubleToStr(Bands_up_1_3, _Digits);
      Bands_up_1_3 = StringToDouble(g503);
      g504  = DoubleToStr(Bands_down_1_1, _Digits);
      Bands_down_1_1 = StringToDouble(g504);
      //---
      g601  = DoubleToStr(Bands_up_2_1, _Digits);
      Bands_up_2_1 = StringToDouble(g601);
      g602  = DoubleToStr(Bands_up_2_2, _Digits);
      Bands_up_2_2 = StringToDouble(g602);
      g603  = DoubleToStr(Bands_up_2_3, _Digits);
      Bands_up_2_3 = StringToDouble(g603);
      g604  = DoubleToStr(Bands_down_2_1, _Digits);
      Bands_down_2_1 = StringToDouble(g604);
      g605  = DoubleToStr(Bands_down_2_2, _Digits);
      Bands_down_2_2 = StringToDouble(g605);
      g606  = DoubleToStr(Bands_down_2_3, _Digits);
      Bands_down_2_3 = StringToDouble(g606);
      Cont_can++;
      //------------------------------------------------+
      if(myMA_20_1 > myMA_50_1 && myMA_50_1 > myMA_100_1 && myMA_100_1 > myMA_200_1)
        {
         Alert_Analys_type("EMA_obj", "EMA", Analys_Color_Green, TextSize_Analys, makan_y + 20, makan_x); // EMA سبز
         Analys_EMA = 1;
        }
      else
         if(myMA_20_1 < myMA_50_1 && myMA_50_1 < myMA_100_1 && myMA_100_1 < myMA_200_1)
           {
            Alert_Analys_type("EMA_obj", "EMA", Analys_Color_Red, TextSize_Analys,  makan_y + 20, makan_x);  //EMA قرمز
            Analys_EMA = 2;
           }
         else
           {
            Alert_Analys_type("EMA_obj", "EMA", Analys_Color_Yellow, TextSize_Analys,  makan_y + 20, makan_x); // EMA زرد
            Analys_EMA = 3;
           }
      //------------------------------------
      if(Close[1] > Bands_up_1_1 && Close[1] < Bands_up_2_1)
        {
         Alert_Analys_type("DEV_obj", "D1", Analys_Color_Green, TextSize_Analys, 163, makan_x + 18); // DEVسبز
        }
      else
         if(Close[1]  < Bands_down_1_1 && Close[1] > Bands_up_2_1)
           {
            Alert_Analys_type("DEV_obj", "D1", Analys_Color_Red, TextSize_Analys,  163, makan_x + 18);  //DEV قرمز
           }
         else
            if(Close[1]  > Bands_down_1_1 && Close[1]  < Bands_up_1_1)
              {
               Alert_Analys_type("DEV_obj", "D", Analys_Color_Yellow, TextSize_Analys,  163, makan_x + 27); //DEV زرد
              }
      //--
      if(Close[1] > Bands_up_2_1)
        {
         Alert_Analys_type("DEV_obj", "D2", Analys_Color_Green, TextSize_Analys,  163, makan_x + 17);   // DEVسبز
        }
      else
         if(Close[1]  < Bands_down_2_1)
           {
            Alert_Analys_type("DEV_obj", "D2", Analys_Color_Red, TextSize_Analys,  163, makan_x + 17);    //DEV قرمز
           }
      /*  else    if(Close[1]  > Bands_down_1_1 && Close[1]  < Bands_up_1_1 )
           {
              Alert_Analys_type("DEV_obj", "D", Analys_Color_Yellow, TextSize_Analys, 1, 1250);            //DEV زرد
           }*/
      //---------------------------------------
      double a = MathAbs(myMA_20_1 - Close[1]);
      double b = MathAbs(myMA_50_1 - Close[1]);
      double c = MathAbs(myMA_100_1 - Close[1]);
      double d = MathAbs(myMA_200_1 - Close[1]);
      //Print(a,b,c,d );
      if(a < b && a < c && a < d)
        {
         Alert_Analys_type("myMA_Analys", "20", Analys_Color_Green, TextSize_Analys, makan_y + 55, 27);
        }
      if(b < a && b < c && b < d)
        {
         Alert_Analys_type("myMA_Analys", "50", Analys_Color_Green, TextSize_Analys, makan_y + 55, 27);
        }
      if(c < a && c < b && c < d)
        {
         Alert_Analys_type("myMA_Analys", "100", Analys_Color_Green, TextSize_Analys, makan_y + 55, 20);
        }
      if(d < a && d < b && d < c)
        {
         Alert_Analys_type("myMA_Analys", "200", Analys_Color_Green, TextSize_Analys, makan_y + 55, 20);
        }
      //------------------------------------
      //----------------------------------
      /* if(Close[1] > Bands_MODE_MAIN_1 && Close[2] > Bands_MODE_MAIN_2 && Close[3] > Bands_MODE_MAIN_3 && Bands_MODE_MAIN_1 > Bands_MODE_MAIN_2 && Bands_MODE_MAIN_2 > Bands_MODE_MAIN_3)
          // اگر کلوز کندلهای یک و دو و سه بالای باند میانه بودند و باند یک از دو بالاتر و باند دو از سه بالاتر بوروند صعودی هستد
          {
             Alert_Analys_type("BB-obj", "BB", Analys_Color_Green, TextSize_Analys,  makan_y+ 20, makan_x * 18);          //BB سبز
          }
       else if(Close[1] < Bands_MODE_MAIN_1 && Close[2] < Bands_MODE_MAIN_2 && Close[3] < Bands_MODE_MAIN_3 && Bands_MODE_MAIN_1 < Bands_MODE_MAIN_2 && Bands_MODE_MAIN_2 < Bands_MODE_MAIN_3)
          // اگر کلوز کندلهای یک و دو و سه پایین تر از باند میانه بود و باند یک از دو پایین تر و باند دو از سه پایین تر بود روند نزولی هست
          {
             Alert_Analys_type("BB-obj", "BB", Analys_Color_Red, TextSize_Analys,  makan_y+ 20, makan_x * 18); // BB سبز میتوانیم رنگ را قرمز هم نشان دهیم
          }
       else
          {
             Alert_Analys_type("BB-obj", "BB", Analys_Color_Yellow, TextSize_Analys,  makan_y+ 20, makan_x * 18);  // BB زرد
          }*/
      //------------------------------------------------+ کد درجه موینگ 20
      //---
      double maF = iMA(NULL, PERIOD_CURRENT, Ma_Period, 0, MODE_EMA, PRICE_CLOSE, iFrom);
      double maT = iMA(NULL, PERIOD_CURRENT, Ma_Period, 0, MODE_EMA, PRICE_CLOSE, iTo);
      if(Degrees_Trendline == true)
        {
         ObjectDelete("ClassicTrendline");
         uint i = 10;
         ObjectCreate("ClassicTrendline", OBJ_TREND, 0, Time[10], maF, Time[0], maT);
         ObjectSetInteger(0, "ClassicTrendline", OBJPROP_RAY, false);
         ObjectSetInteger(0, "ClassicTrendline", OBJPROP_WIDTH, 1);
         ObjectSetInteger(0, "ClassicTrendline", OBJPROP_COLOR, clrBlue);
        }
      int x2, y2, x1, y1;
      ChartTimePriceToXY(0, 0, Time[10], maF, x2, y2);
      ChartTimePriceToXY(0, 0, Time[0], maT, x1, y1);
      double base   = x1 - x2;
      double height = y1 - y2;
      double degrees = MathArctan(height / base) * (360 / (2 * M_PI));
      int Degrees = MathMod((360 - degrees), 360) ;
      if(Degrees > 0 && Degrees < 100)
        {
         Degrees = Degrees;
         Alert_Analys_type("BB-obj", IntegerToString(Degrees), Analys_Color_Green, TextSize_Analys, 206, 25);
         if(Degrees >= 0 && Degrees  <= 9)
           {
            Alert_Degrees("°", Analys_Color_Green, 13, 202, 12);
           }
         else
            if(Degrees > 9)
               Alert_Degrees("°", Analys_Color_Green, 13, 202, 12);
        }
      else
         if(Degrees > 100)
           {
            Degrees = Degrees - 360 ;
            Alert_Analys_type("BB-obj", IntegerToString(Degrees), Analys_Color_Red, TextSize_Analys, 206, 25);
            if(Degrees >= -9 && Degrees  <= -1)
              {
               Alert_Degrees("°", Analys_Color_Red, 13, 202, 12);
              }
            else
               if(Degrees < -9)
                  Alert_Degrees("°", Analys_Color_Red, 13, 202, 12);
           }
      //------------------------------------------------+
      //------------------------------------------------+
      /* if(((myMA_20_1 > myMA_50_1 && myMA_50_1 > myMA_100_1 && myMA_100_1 > myMA_200_1) || (myMA_50_1 < myMA_100_1 && myMA_100_1 < myMA_200_1 &&  Degrees > 30)))
          {
             // Alert_Analys_type("EMA_obj", "EMA", Analys_Color_Green, TextSize_Analys, makan_y + 20,makan_x);// EMA سبز
             Analys_EMA = 1;
          }
       else if(((myMA_20_1 < myMA_50_1 && myMA_50_1 < myMA_100_1 && myMA_100_1 < myMA_200_1) || (myMA_50_1 > myMA_100_1 && myMA_100_1 > myMA_200_1 &&  Degrees < -30)))
          {
             // Alert_Analys_type("EMA_obj", "EMA", Analys_Color_Red, TextSize_Analys,  makan_y+ 20, makan_x);   //EMA قرمز
             Analys_EMA = 2;
          }
       else
          {
             // Alert_Analys_type("EMA_obj", "EMA", Analys_Color_Yellow, TextSize_Analys,  makan_y+ 20, makan_x);// EMA زرد
             Analys_EMA = 3;
          }*/
      //------------------------------
      //---- امتیاز های صعودی
      int score_up  = 0;
      if(Close[1] > Open[1]) // اگر کندل صعودی بود
         score_up ++;
      if(Close[1] > Open[1] && Close[1] - Open[1] > 1 * Point) // اگر کندل صعودی بود و بدنه بیشتر از یک پوینت بود
         score_up ++;
      if(Close[1] > Open[1] && Open[1] - Low[1] > Close[1] - Open[1])// اگر کندل صعودی بود و سایه ی پایینی بیشتر از بدنه بود
         score_up ++;
      if(Close[1] < Open[1] && Close[1] - Low[1] > Open[1] - Close[1]) // اگر کندل نزولی بود و سایه ی پایینی بیشتر از بدنه بود
         score_up ++;
      //
      if(Close[1] > Open[1] && High[1] - Close[1] < Open[1] - Low[1]) // اگر کندل صعودی بود و سایه پایینی بزرگتر از سایه بالایی بود
         score_up ++;
      if(Close[1] < Open[1] && Close[1] - Low[1] > High[1] - Open[1])  // اگر کندل نزولی بود و سایه ی پایینی بیشتر از سایه ی بالایی بود
         score_up ++;
      //---
      //--- امتیاز های نزولی
      int score_down = 0;
      if(Close[1] < Open[1]) // اگر کندل نزولی بود
         score_down ++;
      if(Close[1] < Open[1] && Open[1] - Close[1] >  1 * Point)    // اگر کندل نزولی بود و بدن هی کندل بیشتر از یک پوینت بود
         score_down ++;
      if(Close[1] > Open[1] && High[1] - Close[1] > Close[1] - Open[1]) // اگر کندل صعودی بود و سایه ی بالایی بیشتر از بدنه بود
         score_down ++;
      if(Close[1] < Open[1] && High[1] - Open[1] > Open[1] - Close[1])   // اگر کندل نزولی بود و سایه ی بالایی بیشتر از بدنه بود
         score_down ++;
      //
      if(Close[1] > Open[1] && High[1] - Close[1] > Open[1] - Low[1]) // اگر کندل صعودی بود و سایه ی بالایی بیشتر از سایه ی پایینی بود
         score_down ++;
      if(Close[1] < Open[1] && High[1] - Open[1] > Close[1] - Low[1])  // اگر کندل نزولی بود و سایه ی بالایی بیشتر از بدنه بود
         score_down ++;
      //
      if(score_up > score_down)
        {
         Alert_Analys_type("P-obj", "P", Analys_Color_Green, TextSize_Analys,  226, 32);  // p سبز
        }
      else
         if(score_up < score_down)
           {
            Alert_Analys_type("P-obj", "P", Analys_Color_Red, TextSize_Analys,  226, 32);     // p قرمز
           }
         else
           {
            Alert_Analys_type("P-obj", "P", Analys_Color_Yellow, TextSize_Analys, 226, 32);   // p زرد
           }
      //------------------------------------------------+
      int score_up_1  = 0;
      double size_bode_up_1 = 0, size_bode_up_2 = 0, size_bode_up_3 = 0, size_bode_up_4 = 0, size_bode_up_5 = 0;
      double All_size_bode_up = 0;
      if(Close[1] > Open[1])
         score_up_1 ++ ;
      if(Close[2] > Open[2])
         score_up_1 ++ ;
      if(Close[3] > Open[3])
         score_up_1 ++ ;
      if(Close[4] > Open[4])
         score_up_1 ++ ;
      if(Close[5] > Open[5])
         score_up_1 ++ ;
      //
      if(Close[1] > Open[1])
         size_bode_up_1 = Close[1] - Open[1] ;
      if(Close[2] > Open[2])
         size_bode_up_2 = Close[2] - Open[2] ;
      if(Close[3] > Open[3])
         size_bode_up_3 = Close[3] - Open[3] ;
      if(Close[4] > Open[4])
         size_bode_up_4 = Close[4] - Open[4] ;
      if(Close[5] > Open[5])
         size_bode_up_5 = Close[5] - Open[5] ;
      //
      All_size_bode_up = size_bode_up_1 + size_bode_up_2 + size_bode_up_3 + size_bode_up_4 + size_bode_up_5 ;
      //---
      int score_down_1 = 0;
      double size_bode_down_1 = 0, size_bode_down_2 = 0, size_bode_down_3 = 0, size_bode_down_4 = 0, size_bode_down_5 = 0;
      double All_size_bode_down = 0;
      if(Close[1] < Open[1])
         score_down_1 ++ ;
      if(Close[2] < Open[2])
         score_down_1 ++ ;
      if(Close[3] < Open[3])
         score_down_1 ++ ;
      if(Close[4] < Open[4])
         score_down_1 ++ ;
      if(Close[5] < Open[5])
         score_down_1 ++ ;
      //
      if(Close[1] < Open[1])
         size_bode_down_1 = Open[1] - Close[1] ;
      if(Close[2] < Open[2])
         size_bode_down_2 = Open[2] - Close[2] ;
      if(Close[3] < Open[3])
         size_bode_down_3 = Open[3] - Close[3] ;
      if(Close[4] < Open[4])
         size_bode_down_4 = Open[4] - Close[4] ;
      if(Close[5] < Open[5])
         size_bode_down_5 = Open[5] - Close[5] ;
      //
      All_size_bode_down = size_bode_down_1 + size_bode_down_2 + size_bode_down_3 + size_bode_down_4 + size_bode_down_5 ;
      //--
      if(All_size_bode_up > All_size_bode_down || score_up_1 > score_down_1)
        {
         Alert_Analys_type("C-obj", "C" + IntegerToString(score_up_1), Analys_Color_Green, TextSize_Analys, 246, 22);   //سبز
        }
      //
      else
         if(All_size_bode_up < All_size_bode_down || score_up_1 < score_down_1)
           {
            Alert_Analys_type("C-obj", "C" + IntegerToString(score_down_1), Analys_Color_Red, TextSize_Analys,  246, 22);  //قرمز
           }
         else
            Alert_Analys_type("C-obj", "C", Analys_Color_Yellow, TextSize_Analys, 246, 22);                   // زرد
      //------------------------------------------------+
      if(flag_c == 0)
        {
         max_body = 0;
         min_body = 999999;
         for(int i = 2; i <= 4; i++)
           {
            if(MathMax(Open[i], Close[i]) > max_body)
              {
               max_body = MathMax(Open[i], Close[i]);
              }
            if(MathMin(Open[i], Close[i]) < min_body)
              {
               min_body = MathMin(Open[i], Close[i]);
              }
           }
         flag_c = 1;
        }
      if(MathMax(Open[1], Close[1]) <= max_body && MathMin(Open[1], Close[1]) >= min_body)
        {
         Alert_Analys_type("C-obj2", "C", Analys_Color_DarkGray, TextSize_Analys, 282, 33); // خاکستری
        }
      if(Close[1] > max_body)
        {
         flag_c = 0;
         Alert_Analys_type("C-obj2", "NC", Analys_Color_Green, TextSize_Analys, 282, 19); //سبز
        }
      if(Close[1] < min_body)
        {
         flag_c = 0;
         Alert_Analys_type("C-obj2", "NC", Analys_Color_Red, TextSize_Analys, 282, 19);  //قرمز*/
        }
      /*
         if(Close[1] < High[iHighest(NULL, 0, MODE_HIGH, 4, 2)] &&  Close[1] > Low[iLowest(NULL, 0, MODE_LOW, 4, 2)])
            {
               Alert_Analys_type("C-obj2", "C", Analys_Color_DarkGray, TextSize_Analys, 282, 33); // خاکستری
            }
         else if(Close[1] > High[iHighest(NULL, 0, MODE_HIGH, 4, 2)])
            {
               Alert_Analys_type("C-obj2", "NC", Analys_Color_Green, TextSize_Analys, 282, 19); //سبز
            }
         else if(Close[1] < Low[iLowest(NULL, 0, MODE_LOW, 4, 2)])
            Alert_Analys_type("C-obj2", "NC", Analys_Color_Red, TextSize_Analys, 282, 19);  //قرمز*/
      //------------------------------------------------+
      Accountnumber = AccountNumber();
      //------------------------------------------------+
      if(Enable_EA == false)
        {
         return ;
        }
      if(Bars < 300)
         return ;
      //------------------------------------------------+
      if(Period() == 1)
         period = 1 ;
      if(Period() == 5)
         period = 5 ;
      if(Period() == 15)
         period = 15;
      if(Period() == 30)
         period = 30;
      if(Period() == 60)
         period = 60;
      if(Period() == 240)
         period = 240;
      if(Period() == 1440)
         period = 1440;
      if(Period() == 10080)
         period = 10080;
      if(Period() == 43200)
         period = 43200;
      //+---------------------------BUY---------------------------------+
      if(countSignalCandle_Buy == 0)
        {
         if(countSignal_Sell == 0)
           {
            Check_Analyse() ;
            Check_Analyse_0();
            if(
               // Check_Buy_Signal_3WS() ||    // 3WS   BUY
               //  Check_Buy_Signal_3WSP() ||   // 3WSP  BUY
               // Check_Buy_Signal_PL() ||     // PL    BUY
               // Check_Buy_Signal_PL_1() ||   // PL 1  BUY
               // Check_Buy_Signal_PoE_1() ||  // POE 1 BUY
               //  Check_Buy_Signal_PoE_2() ||  // POE 0 BUY
               // Check_buy_Signal_PoE_3() ||  // POE 3 BUY
               //  Check_Buy_Signal_PoE_4() ||  // POE 4 BUY
               // Check_Buy_Signal_PoE_5() ||  // POE 5 BUY
               // Check_Buy_Signal_PoE_6() ||  // POE 6 BUY
               // Check_Buy_Signal_PoE_7() ||  // POE 7 BUY
               // Check_Buy_Signal_PoE_8() ||  // POE 8 BUY
               // Check_Buy_Signal_PoE_9() ||  // POE 9 BUY
               // Check_Buy_Signal_PoE_10() || // POE 10 BUY
               // Check_Buy_Signal_PoE_11()// || // POE 11 BUY
               // Check_Buy_Signal_MDS() ||    // MDS   BUY
               // Check_Buy_Signal_MS() ||     // MS    BUY
               // Check_Buy_Signal_MS_1() ||   // MS 1  BUY
               // Check_Buy_Signal_ES50()// ||   // ES50  BUY
               // Check_Buy_Signal_MS50_1() || // MS50 1 BUY
               // Check_Buy_Signal_EES_Equal()  || //  EES   BUY
               // Check_Buy_Signal_EMS_Equal_1()//|| //  EMS 1 BUY
               // Check_Buy_Signal_Eng() ||    // Eng   BUY
               // Check_Buy_Signal_Eng_1()||   // Eng 1 BUY
               Check_Buy_Signal_EXC() ||    // EXC   BUY
               // Check_Buy_Signal_EXP() ||    // EXP   BUY
               Check_Buy_Signal_EXR() ||    // EXR   BUY
               // Check_Buy_Signal_EXRC()||    // EXRC  BUY
               // Check_Buy_Signal_NRS() ||    // NRS   BUY
               // Check_Buy_Signal_FNRS()||    // FNRS  BUY
               // Check_Buy_Signal_NRSP()||    // NRSP  BUY
               Check_Buy_Signal_SnR() ||    // SS9   BUY
               // Check_Buy_Signal_FB()        // FB    BUY
               Check_Buy_Signal_shoting_s_1() ||
               Check_Buy_Signal_shoting_s_2() ||
               Check_Buy_Signal_shoting_s_3() ||
               Check_Buy_Signal_marubozu() ||
               Check_Buy_Signal_dragonfly() ||
               Check_Buy_Signal_gap() ||
               //  Check_Buy_Signal_gravestone() ||
               Check_Buy_Signal_inverted_hammer() ||
               Check_Buy_Signal_EES_1() ||
               Check_Buy_Signal_EMS_1() ||
               Check_Buy_Signal_NRS_1() ||
               Check_Buy_Signal_MS50_1() ||
               Check_Buy_Signal_ES50_1() ||
               // Check_Buy_Signal_Hanging_man() ||
               Check_Buy_Signal_Harami() ||
               Check_Buy_Signal_HHLL() ||
               Check_Buy_Signal_eng_1() ||
               Check_Buy_Signal_eng_2() ||
               Check_Buy_Signal_eng_3() ||
               Check_Buy_Signal_eng_4() ||
               Check_Buy_Signal_eng_5() ||
               Check_Buy_Signal_eng_6() ||
               Check_Buy_Signal_eng_7() ||
               Check_Buy_Signal_dc_1() ||
               Check_Buy_Signal_dc_2() ||
               Check_Buy_Signal_huge_candle_1() ||
               Check_Buy_Signal_huge_candle_2() ||
               Check_Buy_Signal_huge_candle_3() ||
               Check_Buy_Signal_ms_buy_1_es_1() ||
               Check_Buy_Signal_ms_buy_1_es_2() ||
               Check_Buy_Signal_tws_put_1_tbc() ||
               Check_Buy_Signal_tws_put_2_tbc() ||
               Check_Buy_Signal_tws_put_3_tbc() ||
               Check_Buy_Signal_tws_put_4_tbc() ||
               Check_Buy_Signal_Hammer() ||
               Check_Buy_Signal_G_Hammer_call() ||
               Check_Buy_Signal_twzb_call_1_twzt_put() ||
               Check_Buy_Signal_call_reversal_put_reversal() ||
               Check_Buy_Signal_minor_put_minor_call() ||
               Check_Buy_Signal_poe_1() ||
               Check_Buy_Signal_poe_2()
            )
              {
               countSignal_Buy++;
               countSignalCandle_Buy++;
              }
           }
        }
      else
        {
         if(Volume[0] > 1)
            return;
         countSignalCandle_Buy++;
        }
      if(countSignalCandle_Buy == Expire + 1 && countSignal_Sell == 0)
        {
         ObjectDelete("signal_type_obj");
         ObjectDelete("test_9");
         countSignal_Buy = 0;
         countSignalCandle_Buy = 0;
        }
      //+---------------------------SELL--------------------------------+
      if(countSignalCandle_Sell == 0)
        {
         if(countSignal_Buy == 0)
           {
            Check_Analyse() ;
            Check_Analyse_0();
            if(
               // Check_Sell_Signal_3BC() ||   // 3BC    sell
               // Check_Sell_Signal_3BCP() ||  // 3BCP   sell
               // Check_Sell_Signal_DC() ||    // DC     sell
               // Check_Sell_Signal_DC_1() ||  // DC 1   sell
               // Check_Sell_Signal_PoE_1() || // POE 1  sell
               // Check_Sell_Signal_PoE_2() || // POE 0  sell
               // Check_sell_Signal_PoE_3()||  // POE 3  sell
               // Check_Sell_Signal_PoE_4() || // POE 4  sell
               // Check_sell_Signal_PoE_5() || // POE 5  sell
               // Check_sell_Signal_PoE_6() || // POE 6  sell
               // Check_sell_Signal_PoE_7() || // POE 7  sell
               // Check_sell_Signal_PoE_8() || // POE 8  sell
               // Check_sell_Signal_PoE_9() || // POE 9  sell
               // Check_sell_Signal_PoE_10() ||// POE 10  sell
               // Check_sell_Signal_PoE_11()// ||// POE 11  sell
               // Check_Sell_Signal_EDS() ||   // EDS    sell
               // Check_Sell_Signal_ES()||     // ES     sell
               // Check_Sell_Signal_ES_1() ||  // ES 1   sell
               // Check_Sell_Signal_MS50()// ||  // MS50   sell
               // Check_Sell_Signal_ES50_1()|| // ES50 1 sell
               // Check_Sell_Signal_EMS_Equal() || // EMS   sell
               // Check_Sell_Signal_EES_Equal_1() // ||// EES 1 sell
               // Check_Sell_Signal_Eng() ||   // Eng   Sell
               // Check_Sell_Signal_Eng_1() || // Eng 1 Sell
               Check_Sell_Signal_EXC() ||   // EXC   Sell
               // Check_Sell_Signal_EXP() ||   // EXP   Sell
               Check_Sell_Signal_EXR() ||   // EXR   Sell
               // Check_Sell_Signal_EXRC() ||  // EXRC  Sell
               // Check_Sell_Signal_NRS() ||   // NRS   Sell
               // Check_Sell_Signal_FNRS() ||  // FNRS  Sell
               // Check_Sell_Signal_NRSP()||   // NRSP  sell
               Check_Sell_Signal_SnR() ||   // SS9   sell
               // Check_Sell_Signal_FB()       // FB    sell
               Check_Sell_Signal_shoting_s_1() ||
               Check_Sell_Signal_shoting_s_2() ||
               Check_Sell_Signal_shoting_s_3() ||
               Check_Sell_Signal_shoting_s_4() ||
               Check_Sell_Signal_marubozu() ||
               Check_Sell_Signal_dragonfly() ||
               Check_Sell_Signal_gap() ||
               // Check_Sell_Signal_gravestone() ||
               Check_Sell_Signal_inverted_hammer() ||
               Check_Sell_Signal_EES_1() ||
               Check_Sell_Signal_EMS_1() ||
               Check_Sell_Signal_NRS_1() ||
               Check_Sell_Signal_MS50_1() ||
               Check_Sell_Signal_ES50_1() ||
               Check_Sell_Signal_Hanging_man() ||
               Check_Sell_Signal_Harami() ||
               Check_Sell_Signal_HHLL() ||
               Check_Sell_Signal_eng_1() ||
               Check_Sell_Signal_eng_2() ||
               Check_Sell_Signal_eng_3() ||
               Check_Sell_Signal_eng_4() ||
               Check_Sell_Signal_eng_5() ||
               Check_Sell_Signal_eng_6() ||
               Check_Sell_Signal_eng_7() ||
               Check_Sell_Signal_dc_1() ||
               Check_Sell_Signal_dc_2() ||
               Check_Sell_Signal_huge_candle_1() ||
               Check_Sell_Signal_huge_candle_2() ||
               Check_Sell_Signal_huge_candle_3() ||
               Check_Sell_Signal_ms_buy_1_es_1() ||
               Check_Sell_Signal_ms_buy_1_es_2() ||
               Check_Sell_Signal_tws_put_1_tbc() ||
               Check_Sell_Signal_tws_put_2_tbc() ||
               Check_Sell_Signal_tws_put_3_tbc() ||
               Check_Sell_Signal_tws_put_4_tbc() ||
               Check_Sell_Signal_twzb_call_1_twzt_put() ||
               Check_Sell_Signal_call_reversal_put_reversal() ||
               Check_Sell_Signal_minor_put_minor_call() ||
               Check_Sell_Signal_poe_1() ||
               Check_Sell_Signal_poe_2()
            )
              {
               countSignal_Sell++;
               countSignalCandle_Sell++;
              }
           }
        }
      else
        {
         if(Volume[0] > 1)
            return;
         countSignalCandle_Sell++;
        }
      if(countSignalCandle_Sell == Expire + 1 && countSignal_Buy == 0)
        {
         ObjectDelete("signal_type_obj");
         ObjectDelete("test_11");
         countSignal_Sell = 0;
         countSignalCandle_Sell = 0;
        }
     }
   else
     {
      Print("isLicense is false.");
     }
//---
   for(int j = 0; j <= ObjectsTotal(); j++)
     {
      if(StringFind(ObjectName(j), "SNR_buy") != -1 || StringFind(ObjectName(j), "SNR_sell") != -1)
        {
         double object_price = ObjectGetValueByShift(ObjectName(j), 0);
         if(object_price <= MathMax(High[1], High[1]) && object_price >= MathMin(Low[1], Low[1]))
           {
            ObjectSet(ObjectName(j), OBJPROP_TIME2, Time[1]);
            ObjectSet(ObjectName(j), OBJPROP_RAY, false);
           }
        }
     }
   /* if(Find_Analys_MS_up  == 1 && Find_Analys_ES_down  == 1) Find_Analys_MS_up  = 0;
    if(Find_Analys_Eng_up == 1 && Find_Analys_Eng_down == 1) Find_Analys_Eng_up = 0;
    if(Find_Analys_PL_up  == 1 && Find_Analys_DC_down  == 1) Find_Analys_PL_up  = 0;
    //---
    if(Find_Analys_ES_down  == 1 && Find_Analys_MS_up  == 1) Find_Analys_ES_down  = 0;
    if(Find_Analys_Eng_down == 1 && Find_Analys_Eng_up == 1) Find_Analys_Eng_down = 0;
    if(Find_Analys_DC_down  == 1 && Find_Analys_PL_up  == 1) Find_Analys_DC_down  = 0;*/
//---------------------
//---
   if(Volume[0] > 1)
      return;
   double highest_1 = 0, highest_2 = 0;
   double lowest_1 = 99999999, lowest_2 = 999999999;
   datetime highest_t_1, highest_t_2;
   datetime lowest_t_1, lowest_t_2;
   for(int i = 1 ; i <= 4; i++)
     {
      if(High[i] > highest_1)
        {
         highest_2 = highest_1;
         highest_t_2 = highest_t_1;
         highest_1 = High[i];
         highest_t_1 = Time[i];
        }
      if(High[i] < highest_1 && High[i] > highest_2)
        {
         highest_2 = High[i];
         highest_t_2 = Time[i];
        }
      if(Low[i] < lowest_1)
        {
         lowest_2 = lowest_1;
         lowest_t_2 = lowest_t_1;
         lowest_1 = Low[i];
         lowest_t_1 = Time[i];
        }
      if(Low[i] > lowest_1 && Low[i] < lowest_2)
        {
         lowest_2 = Low[i];
         lowest_t_2 = Time[i];
        }
     }
   if(shoW_line_highest_lowest)
     {
      Trend_Line("highest_1", highest_t_1, highest_1, highest_t_1 + PeriodSeconds(), highest_1, clrGreen, true);
      Trend_Line("highest_2", highest_t_2, highest_2, highest_t_2 + PeriodSeconds(), highest_2, clrGreen, true);
      Trend_Line("lowest_1", lowest_t_1, lowest_1, lowest_t_1 + PeriodSeconds(), lowest_1, clrRed, true);
      Trend_Line("lowest_2", lowest_t_2, lowest_2, lowest_t_2 + PeriodSeconds(), lowest_2, clrRed, true);
     }
   return;
  }
//+------------------------------------------------------------------+  Check_Signal
bool Check_Analyse_0()
  {
   if(Show_Analyse_reversal_0 == true)
     {
      //+------------------------------------------------------------------+ _MS_up
      if(((Open[4] > Close[4] && Open[3] > Close[3] && Open[2] < Close[2] && ((Open[3] - Close[3]) <= ((Open[4] - Close[4]) / ES_MS_middle_candle_size_ES_MS)) && Close[2] != Open[4]
           && (Close[2] < Open[4] || Close[2] > High[4]) && Close[2] > High[3] && Close[1] > Open[1])
          ||
          (Open[4] > Close[4] && Open[3] == Close[3] && Open[2] < Close[2] && ((Open[3] - Close[3]) <= ((Open[4] - Close[4]) / ES_MS_middle_candle_size_ES_MS)) && Close[2] != Open[4]
           && (Close[2] < Open[4] || Close[2] > High[4]) && Close[2] > High[3] && Close[1] > Open[1])
          ||
          (Open[4] > Close[4] && Open[3] < Close[3] && Open[2] < Close[2] && ((Close[3] - Open[3]) <= ((Open[4] - Close[4]) / ES_MS_middle_candle_size_ES_MS)) && Close[2] != Open[4]
           && (Close[2] < Open[4] || Close[2] > High[4]) && Close[2] > High[3] && Close[1] > Open[1])
         )
         &&
         ((Low[4] < Bands_down_1_4 && Close[2] > Bands_down_1_2) || (Low[4] < Bands_down_2_4 && Close[2] > Bands_down_2_2)
          || (Low[3] < Bands_down_1_3 && Close [2] > Bands_down_1_2) || (Low[3] < Bands_down_2_3 && Close [2] > Bands_down_2_2)))
        {
         if(Show_arrow_reversal == true)
           {
            // Arrow_Create_reversal("_MS_up" + TimeToString(Time[0]),  Time[1], Low[1], clrGold, ARROW_UP, ANCHOR_TOP);
            Arrow_CreateAnalyse_0_up("MS_up_" + TimeToString(TimeCurrent()), Time[2], Low[2], LimeGreen, ARROW_DOWN, ANCHOR_TOP);
           }
         Alert_Analys_type("Reversal-obj", "MS", Analys_Color_Green, TextSize_Analys,  262, 17);
         // Time_Analyse_0_up = Time[1];
         Find_Analys_0 = 0;
        }
      //+------------------------------------------------------------------+_Eng_up
      if(Open[3] > Close[3] && Open[2] < Close[2] && Open[2] <= Close[3] && Open[3] - Close[3] < Close[2] - Open[2] && Close[2] > Open[3]  && Close[1] > Open[1]
         && ((Low [3] < Bands_down_1_3 && Close [2] > Bands_down_1_2) || (Low [3] < Bands_down_2_3 && Close [2] > Bands_down_2_2)))
        {
         if(Show_arrow_reversal == true)
           {
            //  Arrow_Create_reversal("_Eng_up" + TimeToString(Time[0]),  Time[1], Low[1], clrGold, ARROW_UP, ANCHOR_TOP);
            Arrow_CreateAnalyse_0_up("_Eng_up" + TimeToString(TimeCurrent()), Time[2], Low[2], LimeGreen, ARROW_DOWN, ANCHOR_TOP);
           }
         Alert_Analys_type("Reversal-obj", "Eng", Analys_Color_Green, TextSize_Analys, 262, 17);
         // Time_Analyse_0_up =  Time[1];
         Find_Analys_0 = 0;
        }
      //+------------------------------------------------------------------+_PL_up
      if(Open[3] > Close[3] && Open[2] < Close[2] && Open[2] <= Close[3] && Close[2] >= ((((Open[3] - Close[3]) * 55) / 100) + Close[3]) &&
         (Close[2] <= (((Open[3] - Close[3]) * 90) / 100 + Close[3])) &&   Close[1] > Open[1] &&
         ((Low [3] < Bands_down_1_3 && Close [2] > Bands_down_1_2) || (Low [3] < Bands_down_2_3 && Close [2] > Bands_down_2_2)))
        {
         if(Show_arrow_reversal == true)
           {
            // Arrow_Create_reversal("_PL_up" + TimeToString(Time[0]),  Time[1], Low[1], clrGold, ARROW_UP, ANCHOR_TOP);
            Arrow_CreateAnalyse_0_up("_PL_up" + TimeToString(TimeCurrent()), Time[2], Low[2], LimeGreen, ARROW_DOWN, ANCHOR_TOP);
           }
         Alert_Analys_type("Reversal-obj", "PL", Analys_Color_Green, TextSize_Analys,  262, 20);
         // Time_Analyse_0_up = Time[1];
         //
         Find_Analys_0 = 0;
        }
      //---
      //--
      //+------------------------------------------------------------------+ES_down
      if(((Open[4] <  Close[4] && Open[3] > Close[3] && Open[2] > Close[2] && (Open[3] - Close[3] <= ((Close[4] - Open[4]) / ES_MS_middle_candle_size_ES_MS)) && Close[2] != Open[4]
           && (Close[2] > Open[4] || Close[2] < Low[4]) && Close[2] < Low[3]  && Close[1] < Open[1])
          ||
          (Open[4] <  Close[4] && Open[3] == Close[3] && Open[2] > Close[2] && (Open[3] - Close[3] <= ((Close[4] - Open[4]) / ES_MS_middle_candle_size_ES_MS)) && Close[2] != Open[4]
           && (Close[2] > Open[4] || Close[2] < Low[4]) && Close[2] < Low[3]  && Close[1] < Open[1])
          ||
          (Open[4] <  Close[4] && Open[3] < Close[3] && Open[2] > Close[2] && (Close[3] - Open[3] <= ((Close[4] - Open[4]) / ES_MS_middle_candle_size_ES_MS)) && Close[2] != Open[4]
           && (Close[2] > Open[4] || Close[2] < Low[4]) && Close[2] < Low[3]  && Close[1] < Open[1])
         )
         &&
         (((High [4] > Bands_up_1_4 && Close [2] < Bands_up_1_2) || (High [4] > Bands_up_2_4 && Close [2] < Bands_up_2_2))
          || ((High [3] > Bands_up_1_3 && Close [2] < Bands_up_1_2) || (High [3] > Bands_up_2_3 && Close [2] < Bands_up_2_2))))
        {
         if(Show_arrow_reversal == true)
           {
            //  Arrow_Create_reversal("ES_down" + TimeToString(Time[0]),  Time[1], High[1], clrGold, ARROW_UP, ANCHOR_BOTTOM);
            Arrow_CreateAnalyse_0_down("ES_down" + TimeToString(TimeCurrent()), Time[2], High[2], clrRed, ARROW_DOWN, ANCHOR_BOTTOM);
           }
         Alert_Analys_type("Reversal-obj", "ES", Analys_Color_Red, TextSize_Analys, 262, 23);
         Time_Analyse_0_down = Time[1];
         Find_Analys_0 = 1;
        }
      //+------------------------------------------------------------------+Eng_down_
      if(Open[3] < Close[3] && Open[2] >  Close[2] && Open[2] >= Close[3] && Close[3] - Open[3] < Open[2] - Close[2] && Close[2] < Open[3]  && Close[1] < Open[1] &&
         ((High [3] > Bands_up_1_3 && Close [2] < Bands_up_1_2) || (High [3] > Bands_up_2_3 && Close [2] < Bands_up_2_2)))
        {
         if(Show_arrow_reversal == true)
           {
            //  Arrow_Create_reversal("Eng_down_" + TimeToString(Time[0]),  Time[1], High[1], clrGold, ARROW_UP, ANCHOR_BOTTOM);
            Arrow_CreateAnalyse_0_down("Eng_down_" + TimeToString(TimeCurrent()), Time[2], High[2], clrRed, ARROW_DOWN, ANCHOR_BOTTOM);
           }
         Alert_Analys_type("Reversal-obj", "Eng", Analys_Color_Green, TextSize_Analys, 262, 17);
         // Time_Analyse_0_down = Time[1];
         Find_Analys_0 = 1;
        }
      //+------------------------------------------------------------------+DC_down_
      if(Open[3] < Close[3] && Open[2] >  Close[2] && Open[2] >= Close[3] && Close[2] <= (((Close[3] - Open[3]) * 45) / 100 + Open[3]) &&
         (Close[2] >= (((Close[3] - Open[3]) * 10) / 100 + Open[3]))  && Close[1] < Open[1] &&
         ((High [3] > Bands_up_1_3 && Close [2] < Bands_up_1_2) || (High [3] > Bands_up_2_3 && Close [2] < Bands_up_2_2)))
        {
         if(Show_arrow_reversal == true)
           {
            //Arrow_Create_reversal("DC_down_" + TimeToString(Time[0]),  Time[1], High[1], clrGold, ARROW_UP, ANCHOR_BOTTOM);
            Arrow_CreateAnalyse_0_down("DC_down_" + TimeToString(TimeCurrent()), Time[2], High[2], clrRed, ARROW_DOWN, ANCHOR_BOTTOM);
           }
         Alert_Analys_type("Reversal-obj", "DC", Analys_Color_Red, TextSize_Analys,  262, 17);
         //Time_Analyse_0_down = Time[1];
         Find_Analys_0 = 1;
        }
     }
   return true;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+  Check_Signal
bool Check_Analyse()
  {
   if(Analyse_reversal == true)
     {
      //+------------------------------------------------------------------+ _MS_up
      if(((Open[3] > Close[3] && Open[2] > Close[2] && Open[1] < Close[1] && ((Open[2] - Close[2]) <= ((Open[3] - Close[3]) / ES_MS_middle_candle_size_ES_MS)) && Close[1] != Open[3]
           && (Close[1] < Open[3] || Close[1] > High[3]))
          ||
          (Open[3] > Close[3] && Open[2] == Close[2] && Open[1] < Close[1] && ((Open[2] - Close[2]) <= ((Open[3] - Close[3]) / ES_MS_middle_candle_size_ES_MS)) && Close[1] != Open[3]
           && (Close[1] < Open[3] || Close[1] > High[3]))
          ||
          (Open[3] > Close[3] && Open[2] < Close[2] && Open[1] < Close[1] && ((Close[2] - Open[2]) <= ((Open[3] - Close[3]) / ES_MS_middle_candle_size_ES_MS)) && Close[1] != Open[3]
           && (Close[1] < Open[3] || Close[1] > High[3]))
         )
         &&
         ((Low[3] < Bands_down_2_3 && Close[1] > Bands_down_2_1) || (Low[2] < Bands_down_2_2 && Close [1] > Bands_down_2_1)))
        {
         if(Show_arrow_reversal == true)
           {
            // Arrow_Create_reversal("_MS_up" + TimeToString(Time[0]),  Time[1], Low[1], clrGreen, ARROW_UP, ANCHOR_TOP);
           }
         //Alert_Analys_type("Reversal-obj", "MS", Analys_Color_Green, TextSize_Analys,  262, 17);
         //Find_Analys_MS_up = 1;
        }
      //+------------------------------------------------------------------+_Eng_up
      if(Open[2] > Close[2] && Open[1] < Close[1] && Open[1] <= Close[2] && Open[2] - Close[2] < Close[1] - Open[1] && Close[1] > Open[2] &&
         Low [2] < Bands_down_2_2 && Close [1] > Bands_down_2_1)
        {
         if(Show_arrow_reversal == true)
           {
            // Arrow_Create_reversal("_Eng_up" + TimeToString(Time[0]),  Time[1], Low[1], clrGreen, ARROW_UP, ANCHOR_TOP);
           }
         // Alert_Analys_type("Reversal-obj", "Eng", Analys_Color_Green, TextSize_Analys, 262, 17);
         // Find_Analys_Eng_up = 1;
        }
      //+------------------------------------------------------------------+_PL_up
      if(Open[2] < Close[2] && Open[1] >  Close[1] && Open[1] >= Close[2] && Close[1] <= (((Close[2] - Open[2]) * 45) / 100 + Open[2]) &&
         (Close[1] >= (((Close[2] - Open[2]) * 10) / 100 + Open[2])) &&
         Low [2] < Bands_down_2_2 && Close [1] > Bands_down_2_1)
        {
         if(Show_arrow_reversal == true)
           {
            // Arrow_Create_reversal("_PL_up" + TimeToString(Time[0]),  Time[1], Low[1], clrGreen, ARROW_UP, ANCHOR_TOP);
           }
         // Alert_Analys_type("Reversal-obj", "PL", Analys_Color_Green, TextSize_Analys,  262, 20);
         // Find_Analys_PL_up = 1;
        }
      //---
      //--
      //+------------------------------------------------------------------+ES_down
      if(((Open[3] <  Close[3] && Open[2] > Close[2] && Open[1] > Close[1] && (Open[2] - Close[2] <= ((Close[3] - Open[3]) / ES_MS_middle_candle_size_ES_MS)) && Close[1] != Open[3]
           && (Close[1] > Open[3] || Close[1] < Low[3]))
          ||
          (Open[3] <  Close[3] && Open[2] == Close[2] && Open[1] > Close[1] && (Open[2] - Close[2] <= ((Close[3] - Open[3]) / ES_MS_middle_candle_size_ES_MS)) && Close[1] != Open[3]
           && (Close[1] > Open[3] || Close[1] < Low[3]))
          ||
          (Open[3] <  Close[3] && Open[2] < Close[2] && Open[1] > Close[1] && (Close[2] - Open[2] <= ((Close[3] - Open[3]) / ES_MS_middle_candle_size_ES_MS)) && Close[1] != Open[3]
           && (Close[1] > Open[3] || Close[1] < Low[3]))
         )
         &&
         ((High [3] > Bands_up_2_3 && Close [1] < Bands_up_2_1) || (High [2] > Bands_up_2_2 && Close [1] < Bands_up_2_1)))
        {
         if(Show_arrow_reversal == true)
           {
            //  Arrow_Create_reversal("ES_down" + TimeToString(Time[0]),  Time[1], High[1], clrGreen, ARROW_UP, ANCHOR_BOTTOM);
           }
         // Alert_Analys_type("Reversal-obj", "ES", Analys_Color_Red, TextSize_Analys, 262, 23);
         //Find_Analys_ES_down = 1;
        }
      //+------------------------------------------------------------------+Eng_down_
      if(Open[2] < Close[2] && Open[1] >  Close[1] && Open[1] >= Close[2] && Close[2] - Open[2] < Open[1] - Close[1] && Close[1] < Open[2] &&
         High [2] > Bands_up_2_2 && Close [1] < Bands_up_2_1)
        {
         if(Show_arrow_reversal == true)
           {
            // Arrow_Create_reversal("Eng_down_" + TimeToString(Time[0]),  Time[1], High[1], clrGreen, ARROW_UP, ANCHOR_BOTTOM);
           }
         // Alert_Analys_type("Reversal-obj", "Eng", Analys_Color_Green, TextSize_Analys, 262, 17);
         // Find_Analys_Eng_down = 1;
        }
      //+------------------------------------------------------------------+DC_down_
      if(Open[2] > Close[2] && Open[1] < Close[1] && Open[1] <= Close[2] && Close[1] >= ((((Open[2] - Close[2]) * 55) / 100) + Close[2]) &&
         (Close[1] <= (((Open[2] - Close[2]) * 90) / 100 + Close[2])) &&
         High [2] > Bands_up_2_2 && Close [1] < Bands_up_2_1)
        {
         if(Show_arrow_reversal == true)
           {
            // Arrow_Create_reversal("DC_down_" + TimeToString(Time[0]),  Time[1], High[1], clrGreen, ARROW_UP, ANCHOR_BOTTOM);
           }
         //Alert_Analys_type("Reversal-obj", "DC", Analys_Color_Red, TextSize_Analys,  262, 17 );
         // Find_Analys_DC_down = 1;
        }
     }
   return true;
  }
//+------------------------------------------------------------------+_3WS_3BC
//+------------------------------------------------------------------+
bool Check_Buy_Signal_3WS() // 3WS BUY
  {
   int r;
   if(_3WS_3BC == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Small_to_Big == true)
     {
      if(Close[4] - Open[4] < Close[3] - Open[3] && Close[3] - Open[3] < Close[2] - Open[2])
        {
         r = 1;
        }
      else
         return false;
     }
//---
   if(Open[1] > Close[1] && Open[2] < Close[2] && Open[3] < Close[3] && Open[4] < Close[4]
      && Open[1] - Close[1] < (Close[2] - Open[2]) / 2
      && Close[3] - Open[3] < Close[2] - Open[2]
      && Open[1] == Close[2]
//&& Close[2] - Open[2] < (Close[3] - Open[3] + Close[4] - Open[4])
      && (Close[3] - Open[3]) * 2 > Close[2] - Open[2] //&& (Close[4] - Open[4]) * 2 > Close[3] - Open[3]
//&& Close[2] > Bands_up_2_2
//&& Close[1] < Bands_up_2_1
// && Close[1] > Bands_up_1_1
      && ((Analys_EMA == 1  && Close[1] > Bands_up_1_1)  || (Analys_EMA == 3 && (Close[1] < Bands_down_1_1 || Close[1] < Bands_down_2_1)))
     )
     {
      if(enable_text == true)
        {
         _3WS_b(arrow_name_up_3WS, time_up_3WS, price_up_3WS);
        }
      Send_Buy_Order("3WS");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_3BC()  // 3BC SELL
  {
   int r;
   if(_3WS_3BC == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Small_to_Big == true)
     {
      if(Open[4] - Close[4] < Open[3] - Close[3] && Open[3] - Close[3] < Open[2] - Close[2])
        {
         r = 1;
        }
      else
         return false;
     }
//---
   if(Open[1] < Close[1] && Open[2] > Close[2] && Open[3] > Close[3] && Open[4] > Close[4]
      && Close[1] - Open[1] < (Open[2] - Close[2]) / 2
      && Open[3] - Close[3] < Open[2] - Close[2]
      && Close[2] == Open[1]
//&& Open[2] - Close[2] < (Open[3] - Close[3] + Open[4] - Close[4])
      && (Open[3] - Close[3]) * 2 >  Open[2] - Close[2] //&&  (Open[4] - Close[4]) * 2  >  Open[3] - Close[3]
//&& Close[2] < Bands_down_2_2
// && Close[1] > Bands_down_2_1
// && Close[1] < Bands_down_1_1
      && ((Analys_EMA == 2  && Close[1] < Bands_down_1_1) || (Analys_EMA == 3  && (Close[1] > Bands_up_1_1 || Close[1] > Bands_up_2_1)))
     )
     {
      if(enable_text == true)
        {
         _3BC_s(arrow_name_down_3BC, time_down_3BC, price_down_3BC);
        }
      Send_Sell_Order("3BC");
      signal_price_sell = Bid;
      signalTime_sell =  Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+3WSP 3BCP
//+------------------------------------------------------------------+
bool Check_Buy_Signal_3WSP()  // 3WSP BUY
  {
   int r;
   if(_3WSP_ == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Close[1] < Open[1] && Close[2] > Open[2] && Close[3] > Open[3]  && Close[4] > Open[4]
      && Close[2] - Open[2] > Close[3] - Open[3] &&  Close[2] - Open[2] > Close[4] - Open[4]
      && (Close[0] == High[3] ||  Close[0] == Close[3] || Close[0] == High[4] ||  Close[0] == Close[4])
      && Close[2] - ((Close[2] - Open[2]) / 4) > High[3]
      && Close[2] > High[3] && Close[3] >= High[4]
     )
     {
      Alert_wait_type(" 3WSP ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
      time_wait_buy = Time[0];
      // GetLine_Buy();
     }
   if(time_wait_buy == Time[1])
     {
      ObjectDelete("wait_signal");
      // GetLine_Sell();
     }
//----
//---
   if(Close[1] < Open[1] && Close[2] > Open[2] && Close[3] > Open[3]  && Close[4] > Open[4]
      && Close[2] - Open[2] > Close[3] - Open[3] &&  Close[2] - Open[2] > Close[4] - Open[4]
      && (Close[1] == High[3] ||  Close[1] == Close[3] || Close[1] == High[4] ||  Close[1] == Close[4])
      && Close[2] - ((Close[2] - Open[2]) / 4) > High[3]
      && Close[2] > High[3] && Close[3] >= High[4] &&
      ((Analys_EMA == 1  && Close[1] > Bands_up_1_1) ||
       (Analys_EMA == 3 && (Close[1] < Bands_down_1_1 || Close[1] < Bands_down_2_1)))
     )
     {
      if(enable_text == true)
        {
         _3WSP_b(arrow_name_up_3WSP, time_up_3WSP, price_up_3WSP);
        }
      Send_Buy_Order("3WSP");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_3BCP()  // 3BCP SELL
  {
   int r;
   if(_3WSP_ == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Close[1] > Open[1] && Close[2] < Open[2] && Close[3] < Open[3]  && Close[4] < Open[4]
      && Open[2] - Close[2] >  Open[3] - Close[3] && Open[2] - Close[2] >  Open[4] - Close[4]
      && (Close[0] == Low[3] ||  Close[0] == Close[3] || Close[0] == Low[4] ||  Close[0] == Close[4])
      && ((Open[2] - Close[2]) / 4) + Close[2] < Low[3]
      && Close[2] < Low[3] && Close[3] <= Low[4])
     {
      Alert_wait_type(" 3WSP ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
      time_wait_sell = Time[0];
      //GetLine_Buy();
     }
   if(time_wait_sell == Time[1])
     {
      ObjectDelete("wait_signal");
      // GetLine_Sell();
     }
//----
//---
   if(Close[1] > Open[1] && Close[2] < Open[2] && Close[3] < Open[3]  && Close[4] < Open[4]
      && Open[2] - Close[2] >  Open[3] - Close[3] && Open[2] - Close[2] >  Open[4] - Close[4]
      && (Close[1] == Low[3] ||  Close[1] == Close[3] || Close[1] == Low[4] ||  Close[1] == Close[4])
      && ((Open[2] - Close[2]) / 4) + Close[2] < Low[3]
      && Close[2] < Low[3] && Close[3] <= Low[4] &&
      ((Analys_EMA == 2 && Close[1] < Bands_down_1_1) ||
       (Analys_EMA == 3 && (Close[1] > Bands_up_1_1 || Close[1] > Bands_up_2_1)))
     )
     {
      if(enable_text == true)
        {
         _3BCP_s(arrow_name_down_3BCP, time_down_3BCP, price_down_3BCP);
        }
      Send_Sell_Order("3BCP");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ DC_PL
bool Check_Buy_Signal_PL()  // PL BUY
  {
   int r;
   if(Dark_Cloud_Piercing_DC_PL == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(DC_PL_outside_2_Dev == true)
     {
      if(Open[3] > Bands_down_2_3 && Close[3] < Bands_down_2_3 && Close[2] > Bands_down_2_2)
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(DC_PL_Body_to_Wick == true)
     {
      if((High[2] - Close[2]) < (((Close[2] - Open[2])*DC_PL_body_size_percent) / 100))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(DC_PL_2_EMA_breakout == true)
     {
      if(
         (myMA_20_2 > Open[2] && myMA_20_2  < Close[2] && myMA_50_2  > Open[2] && myMA_50_2 < Close[2])  ||
         (myMA_20_2  > Open[2] && myMA_20_2  < Close[2] && myMA_100_2 > Open[2] && myMA_100_2 < Close[2]) ||
         (myMA_20_2  > Open[2] && myMA_20_2  < Close[2] && myMA_200_2 > Open[2] && myMA_200_2 < Close[2]) ||
         (myMA_50_2  > Open[2] && myMA_50_2  < Close[2] && myMA_100_2 > Open[2] && myMA_100_2 < Close[2]) ||
         (myMA_50_2  > Open[2] && myMA_50_2  < Close[2] && myMA_200_2 > Open[2] && myMA_200_2 < Close[2]) ||
         (myMA_100_2 > Open[2] && myMA_100_2 < Close[2] && myMA_200_2 > Open[2] && myMA_200_2 < Close[2]) ||
         (myMA_20_2  < Open[3] && myMA_20_2  > Close[3] && myMA_50_2  < Open[3] && myMA_50_2  > Close[3]) ||
         (myMA_20_2  < Open[3] && myMA_20_2  > Close[3] && myMA_100_2 < Open[3] && myMA_100_2 > Close[3]) ||
         (myMA_20_2  < Open[3] && myMA_20_2  > Close[3] && myMA_200_2 < Open[3] && myMA_200_2 > Close[3]) ||
         (myMA_50_2  < Open[3] && myMA_50_2  > Close[3] && myMA_100_2 < Open[3] && myMA_100_2 > Close[3]) ||
         (myMA_50_2  < Open[3] && myMA_50_2  > Close[3] && myMA_200_2 < Open[3] && myMA_200_2 > Close[3]) ||
         (myMA_100_2 < Open[3] && myMA_100_2 > Close[3] && myMA_200_2 < Open[3] && myMA_200_2 > Close[3]))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(DC_PL_close_at_key_level == true)
     {
      if(
         (Close[2] == myMA_20_2)  ||
         (Close[2] == myMA_50_2)  ||
         (Close[2] == myMA_100_2) ||
         (Close[2] == myMA_200_2) ||
         (Close[2] == Bands_MODE_MAIN_2) ||
         (Close[2] == Bands_down_1_2) ||
         (Close[2] == Bands_up_1_2)  ||
         (Close[2] == Bands_down_2_2) ||
         (Close[2] == Bands_up_2_2))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(Open[3] > Close[3] && Open[2] < Close[2] && Open[2] <= Close[3] && Close[2] >= ((((Open[3] - Close[3]) * 55) / 100) + Close[3]) &&
      Close[2] <= (((Open[3] - Close[3]) * 90) / 100 + Close[3]) &&
      Open[1] > Close[1]
      && ///
      (Close[1] == Open[2] || Close[1]  == Low[2] || (Close[1] >= ((Open[3] - Close[3]) / 2) + Close[3] && Low[1] <= ((Open[3] - Close[3]) / 2) + Close[3]) ||
       Close[1] ==  Bands_up_1_1   ||
       Close[1] ==  Bands_down_1_1 ||
       Close[1] ==  Bands_up_1_5_1 ||
       Close[1] ==  Bands_down_1_5_1 ||
       Close[1] ==  Bands_up_2_1 ||
       Close[1] ==  Bands_down_2_1 ||
       Close[1] ==  myMA_20_1 ||
       Close[1] ==  myMA_50_1 ||
       Close[1] ==  myMA_100_1 ||
       Close[1] ==  myMA_200_1 ||
       Close[1] == Bands_MODE_MAIN_1)
      && //ریتریسمنت
      ((Analys_EMA == 3 && ((Open[2] < Bands_down_2_2 &&  Close[2] > Bands_down_2_2) || (Open[2] < Bands_down_1_2 && Close[2] > Bands_down_1_2))) ||
       (Analys_EMA == 1 && Open[2] < Bands_up_1_2 &&  Close[2] > Bands_up_1_2) ||
       (Analys_EMA == 2 && Open[2] < Bands_down_1_2 &&  Close[2] > Bands_down_1_2 &&  Close[2] < High[iHighest(NULL, 0, MODE_HIGH, 6, 2)] &&  Close[2] > Low[iLowest(NULL, 0, MODE_LOW, 6, 2)]))
     )
     {
      // Up();
      if(enable_text == true)
        {
         PL_b(arrow_name_up_PL, time_up_PL, price_up_PL);
        }
      Send_Buy_Order("PL");
      // Alert_Analys_type("Reversal-obj", "PL", Analys_Color_Green, TextSize_Analys,  262, 20);
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_DC()  // DC SELL
  {
   int r;
   if(Dark_Cloud_Piercing_DC_PL == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(DC_PL_outside_2_Dev == true)
     {
      if(Open[3] < Bands_up_2_3 && Close[3] > Bands_up_2_3 && Close[2] < Bands_up_2_2)
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(DC_PL_Body_to_Wick == true)
     {
      if((Close[2] - Low[2]) < (((Open[2] - Close[2])*DC_PL_body_size_percent) / 100))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(DC_PL_2_EMA_breakout == true)
     {
      if(
         (myMA_20_2  < Open[2] && myMA_20_2  > Close[2] && myMA_50_2  < Open[2] && myMA_50_2  > Close[2]) ||
         (myMA_20_2  < Open[2] && myMA_20_2  > Close[2] && myMA_100_2 < Open[2] && myMA_100_2 > Close[2]) ||
         (myMA_20_2  < Open[2] && myMA_20_2  > Close[2] && myMA_200_2 < Open[2] && myMA_200_2 > Close[2]) ||
         (myMA_50_2  < Open[2] && myMA_50_2  > Close[2] && myMA_100_2 < Open[2] && myMA_100_2 > Close[2]) ||
         (myMA_50_2  < Open[2] && myMA_50_2  > Close[2] && myMA_200_2 < Open[2] && myMA_200_2 > Close[2]) ||
         (myMA_100_2 < Open[2] && myMA_100_2 > Close[2] && myMA_200_2 < Open[2] && myMA_200_2 > Close[2]) ||
         (myMA_20_2  > Open[3] && myMA_20_2  < Close[3] && myMA_50_2  > Open[3] && myMA_50_2  < Close[3]) ||
         (myMA_20_2  > Open[3] && myMA_20_2  < Close[3] && myMA_100_2 > Open[3] && myMA_100_2 < Close[3]) ||
         (myMA_20_2  > Open[3] && myMA_20_2  < Close[3] && myMA_200_2 > Open[3] && myMA_200_2 < Close[3]) ||
         (myMA_50_2  > Open[3] && myMA_50_2  < Close[3] && myMA_100_2 > Open[3] && myMA_100_2 < Close[3]) ||
         (myMA_50_2  > Open[3] && myMA_50_2  < Close[3] && myMA_200_2 > Open[3] && myMA_200_2 < Close[3]) ||
         (myMA_100_2 > Open[3] && myMA_100_2 < Close[3] && myMA_200_2 > Open[3] && myMA_200_2 < Close[3]))
         return false;
     }
//------------------------------------------------+
   if(DC_PL_close_at_key_level == true)
     {
      if(
         (Close[2] == myMA_20_2)  ||
         (Close[2] == myMA_50_2)  ||
         (Close[2] == myMA_100_2) ||
         (Close[2] == myMA_200_2) ||
         (Close[2] == Bands_MODE_MAIN_2) ||
         (Close[2] == Bands_down_1_2) ||
         (Close[2] == Bands_up_1_2)  ||
         (Close[2] == Bands_down_2_2) ||
         (Close[2] == Bands_up_2_2))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(Open[3] < Close[3] && Open[2] >  Close[2] && Open[2] >= Close[3] && Close[2] <= (((Close[3] - Open[3]) * 45) / 100 + Open[3]) &&
      (Close[2] >= (((Close[3] - Open[3]) * 10) / 100 + Open[3])) &&
      Open[1] < Close[1]
      &&   ////
      (Close[1] == Open[2] || Close[1]  == High[2] || (Close[1] <= ((Close[3] - Open[3]) / 2) + Open[3] && High[1] >= ((Close[3] - Open[3]) / 2) + Open[3]) ||
       Close[1] ==  Bands_up_1_1   ||
       Close[1] ==  Bands_down_1_1 ||
       Close[1] ==  Bands_up_1_5_1 ||
       Close[1] ==  Bands_down_1_5_1 ||
       Close[1] ==  Bands_up_2_1 ||
       Close[1] ==  Bands_down_2_1 ||
       Close[1] ==  myMA_20_1 ||
       Close[1] ==  myMA_50_1 ||
       Close[1] ==  myMA_100_1 ||
       Close[1] ==  myMA_200_1 ||
       Close[1] == Bands_MODE_MAIN_1)
      && //ریتریسمنت
      ((Analys_EMA  == 3 && ((Open[2] > Bands_up_2_2 &&  Close[2] < Bands_up_2_2) || (Open[2] > Bands_up_1_2 &&  Close[2] < Bands_up_1_2)))  ||
       (Analys_EMA  == 2 && Open[2] > Bands_down_1_2 &&  Close[1] < Bands_down_1_2) ||
       (Analys_EMA == 1 && Open[2] > Bands_up_1_2 && Close[2] < Bands_up_1_2 &&  Close[2] < High[iHighest(NULL, 0, MODE_HIGH, 6, 2)] &&  Close[2] > Low[iLowest(NULL, 0, MODE_LOW, 6, 2)]))
     )
     {
      // Don();
      if(enable_text == true)
        {
         DC_s(arrow_name_down_DC, time_down_DC, price_down_DC);
        }
      Send_Sell_Order("DC");
      // Alert_Analys_type("Reversal-obj","DC", Analys_Color_Red, TextSize_Analys,   makan_y, makan_x * 20);
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ DC_PL
bool Check_Buy_Signal_PL_1()  // PL 1 BUY
  {
   int r;
   if(Dark_Cloud_Piercing_DC_PL == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(DC_PL_outside_2_Dev == true)
     {
      if(Open[2] > Bands_down_2_2 && Close[2] < Bands_down_2_2 && Close[1] > Bands_down_2_1)
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(DC_PL_Body_to_Wick == true)
     {
      if((High[1] - Close[1]) < (((Close[1] - Open[1])*DC_PL_body_size_percent) / 100))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(DC_PL_2_EMA_breakout == true)
     {
      if(
         (myMA_20_1 > Open[1] && myMA_20_1  < Close[1] && myMA_50_1  > Open[1] && myMA_50_1 < Close[1])  ||
         (myMA_20_1  > Open[1] && myMA_20_1  < Close[1] && myMA_100_1 > Open[1] && myMA_100_1 < Close[1]) ||
         (myMA_20_1  > Open[1] && myMA_20_1  < Close[1] && myMA_200_1 > Open[1] && myMA_200_1 < Close[1]) ||
         (myMA_50_1  > Open[1] && myMA_50_1  < Close[1] && myMA_100_1 > Open[1] && myMA_100_1 < Close[1]) ||
         (myMA_50_1  > Open[1] && myMA_50_1  < Close[1] && myMA_200_1 > Open[1] && myMA_200_1 < Close[1]) ||
         (myMA_100_1 > Open[1] && myMA_100_1 < Close[1] && myMA_200_1 > Open[1] && myMA_200_1 < Close[1]) ||
         (myMA_20_1  < Open[2] && myMA_20_1  > Close[2] && myMA_50_1  < Open[2] && myMA_50_1  > Close[2]) ||
         (myMA_20_1  < Open[2] && myMA_20_1  > Close[2] && myMA_100_1 < Open[2] && myMA_100_1 > Close[2]) ||
         (myMA_20_1  < Open[2] && myMA_20_1  > Close[2] && myMA_200_1 < Open[2] && myMA_200_1 > Close[2]) ||
         (myMA_50_1  < Open[2] && myMA_50_1  > Close[2] && myMA_100_1 < Open[2] && myMA_100_1 > Close[2]) ||
         (myMA_50_1  < Open[2] && myMA_50_1  > Close[2] && myMA_200_1 < Open[2] && myMA_200_1 > Close[2]) ||
         (myMA_100_1 < Open[2] && myMA_100_1 > Close[2] && myMA_200_1 < Open[2] && myMA_200_1 > Close[2]))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(DC_PL_close_at_key_level == true)
     {
      if(
         (Close[1] == myMA_20_1)  ||
         (Close[1] == myMA_50_1)  ||
         (Close[1] == myMA_100_1) ||
         (Close[1] == myMA_200_1) ||
         (Close[1] == Bands_MODE_MAIN_1) ||
         (Close[1] == Bands_down_1_1) ||
         (Close[1] == Bands_up_1_1)  ||
         (Close[1] == Bands_down_2_1) ||
         (Close[1] == Bands_up_2_1))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(Open[2] > Close[2] && Open[1] < Close[1] && Open[1] <= Close[2] && Close[1] >= ((((Open[2] - Close[2]) * 55) / 100) + Close[2]) &&
      Close[1] <= (((Open[2] - Close[2]) * 90) / 100 + Close[2]) &&
      ((Open[2] > myMA_20_2 && Close[2] < myMA_20_2 && Open[1] < myMA_20_1  && Close[1] > myMA_20_1) ||
       (Open[2] > myMA_50_2 && Close[2] < myMA_50_2 && Open[1] < myMA_50_1  && Close[1] > myMA_50_1) ||
       (Open[2] > myMA_100_2 && Close[2] < myMA_100_2 && Open[1] < myMA_100_1  && Close[1] > myMA_100_1) ||
       (Open[2] > myMA_200_2 && Close[2] < myMA_200_2 && Open[1] < myMA_200_1  && Close[1] > myMA_200_1) ||
       (Open[2] > Bands_up_1_2 && Close[2] < Bands_up_1_2 && Open[1] < Bands_up_1_1  && Close[1] > Bands_up_1_1) ||
       (Open[2] > Bands_down_1_2 && Close[2] < Bands_down_1_2 && Open[1] < Bands_down_1_1  && Close[1] > Bands_down_1_1) ||
       (Open[2] > Bands_up_2_2 && Close[2] < Bands_up_2_2 && Open[1] < Bands_up_2_1  && Close[1] > Bands_up_2_1) ||
       (Open[2] > Bands_down_2_2 && Close[2] < Bands_down_2_2 && Open[1] < Bands_down_2_1  && Close[1] > Bands_down_2_1) ||
       (Open[2] > Bands_MODE_MAIN_2 && Close[2] < Bands_MODE_MAIN_2 && Open[1] < Bands_MODE_MAIN_1  && Close[1] > Bands_MODE_MAIN_1))
      &&  Analys_EMA == 1)
     {
      // // Up();
      if(enable_text == true)
        {
         PL_b_1(arrow_name_up_PL_1, time_up_PL_1, price_up_PL_1);
        }
      Send_Buy_Order("PL");
      //Alert_Analys_type("Reversal-obj", "PL", Analys_Color_Green, TextSize_Analys,  makan_y, makan_x * 20);
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_DC_1()  // DC 1 SELL
  {
   int r;
   if(Dark_Cloud_Piercing_DC_PL == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(DC_PL_outside_2_Dev == true)
     {
      if(Open[2] < Bands_up_2_2 && Close[2] > Bands_up_2_2 && Close[1] < Bands_up_2_1)
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(DC_PL_Body_to_Wick == true)
     {
      if((Close[1] - Low[1]) < (((Open[1] - Close[1])*DC_PL_body_size_percent) / 100))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(DC_PL_2_EMA_breakout == true)
     {
      if(
         (myMA_20_1  < Open[1] && myMA_20_1  > Close[1] && myMA_50_1  < Open[1] && myMA_50_1  > Close[1]) ||
         (myMA_20_1  < Open[1] && myMA_20_1  > Close[1] && myMA_100_1 < Open[1] && myMA_100_1 > Close[1]) ||
         (myMA_20_1  < Open[1] && myMA_20_1  > Close[1] && myMA_200_1 < Open[1] && myMA_200_1 > Close[1]) ||
         (myMA_50_1  < Open[1] && myMA_50_1  > Close[1] && myMA_100_1 < Open[1] && myMA_100_1 > Close[1]) ||
         (myMA_50_1  < Open[1] && myMA_50_1  > Close[1] && myMA_200_1 < Open[1] && myMA_200_1 > Close[1]) ||
         (myMA_100_1 < Open[1] && myMA_100_1 > Close[1] && myMA_200_1 < Open[1] && myMA_200_1 > Close[1]) ||
         (myMA_20_1  > Open[2] && myMA_20_1  < Close[2] && myMA_50_1  > Open[2] && myMA_50_1  < Close[2]) ||
         (myMA_20_1  > Open[2] && myMA_20_1  < Close[2] && myMA_100_1 > Open[2] && myMA_100_1 < Close[2]) ||
         (myMA_20_1  > Open[2] && myMA_20_1  < Close[2] && myMA_200_1 > Open[2] && myMA_200_1 < Close[2]) ||
         (myMA_50_1  > Open[2] && myMA_50_1  < Close[2] && myMA_100_1 > Open[2] && myMA_100_1 < Close[2]) ||
         (myMA_50_1  > Open[2] && myMA_50_1  < Close[2] && myMA_200_1 > Open[2] && myMA_200_1 < Close[2]) ||
         (myMA_100_1 > Open[2] && myMA_100_1 < Close[2] && myMA_200_1 > Open[2] && myMA_200_1 < Close[2]))
         return false;
     }
//------------------------------------------------+
   if(DC_PL_close_at_key_level == true)
     {
      if(
         (Close[1] == myMA_20_1)  ||
         (Close[1] == myMA_50_1)  ||
         (Close[1] == myMA_100_1) ||
         (Close[1] == myMA_200_1) ||
         (Close[1] == Bands_MODE_MAIN_1) ||
         (Close[1] == Bands_down_1_1) ||
         (Close[1] == Bands_up_1_1)  ||
         (Close[1] == Bands_down_2_1) ||
         (Close[1] == Bands_up_2_1))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(Open[2] < Close[2] && Open[1] >  Close[1] && Open[1] >= Close[2] && Close[1] <= (((Close[2] - Open[2]) * 45) / 100 + Open[2]) &&
      (Close[1] >= (((Close[2] - Open[2]) * 10) / 100 + Open[2])) &&
      ((Open[2] < myMA_20_2 && Close[2] > myMA_20_2 && Open[1] > myMA_20_1  && Close[1] < myMA_20_1) ||
       (Open[2] < myMA_50_2 && Close[2] > myMA_50_2 && Open[1] > myMA_50_1  && Close[1] < myMA_50_1) ||
       (Open[2] < myMA_100_2 && Close[2] > myMA_100_2 && Open[1] > myMA_100_1  && Close[1] < myMA_100_1) ||
       (Open[2] < myMA_200_2 && Close[2] > myMA_200_2 && Open[1] > myMA_200_1  && Close[1] < myMA_200_1) ||
       (Open[2] < Bands_up_1_2 && Close[2] > Bands_up_1_2 && Open[1] > Bands_up_1_1  && Close[1] < Bands_up_1_1) ||
       (Open[2] < Bands_down_1_2 && Close[2] > Bands_down_1_2 && Open[1] > Bands_down_1_1  && Close[1] < Bands_down_1_1) ||
       (Open[2] < Bands_up_2_2 && Close[2] > Bands_up_2_2 && Open[1] > Bands_up_2_1  && Close[1] < Bands_up_2_1) ||
       (Open[2] < Bands_down_2_2 && Close[2] > Bands_down_2_2 && Open[1] > Bands_down_2_1  && Close[1] < Bands_down_2_1) ||
       (Open[2] < Bands_MODE_MAIN_2 && Close[2] > Bands_MODE_MAIN_2 && Open[1] > Bands_MODE_MAIN_1  && Close[1] < Bands_MODE_MAIN_1))
      &&  Analys_EMA == 2)
     {
      // Don();
      if(enable_text == true)
        {
         DC_s_1(arrow_name_down_DC_1, time_down_DC_1, price_down_DC_1);
        }
      Send_Sell_Order("DC");
      //Alert_Analys_type("Reversal-obj", "DC", Analys_Color_Red, TextSize_Analys,  makan_y, makan_x * 20);
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ PoE BUY
bool Check_Buy_Signal_PoE_1()  // POE 1 BUY
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(Open[1] > Close[1] && Open[0] > Close[0] && Close[0] == Low[1] && Open[0] - Close[0] <= Open[1] - Close[1]
          && Close[0] != Close[1] && Open[0] == Close[1])
       {
          Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
          time_wait_buy = Time[0]; //GetLine_Buy();
       }
    if(time_wait_buy == Time[1])
       {
          ObjectDelete("wait_signal"); // GetLine_Sell();
       }*/
//---
//---
   if(int(MathAbs(Open[2] - Close[2]) / Point) > 1 && Open[2] > Close[2] && Open[1] > Close[1] &&  Close[1] == Low[2] && Open[1] - Close[1] <= Open[2] - Close[2] &&   ///////  1
      Close[1] != Close[2] && Open[1] == Close[2] && Analys_EMA == 2  && Close[1] < Bands_down_1_1)
     {
      int index_max_inc_candle = -1;
      double value_max_inc_candle = -1;
      for(int i = 3; i <= 5; i++)
        {
         if(Close[i] > Open[i])
           {
            if(Close[i] - Open[i] > value_max_inc_candle)
              {
               value_max_inc_candle = Close[i] - Open[i];
               index_max_inc_candle = i;
              }
           }
        }
      int bigger_counter = 0;
      for(int i = 2; i <= 5; i++)
        {
         if(i == index_max_inc_candle)
            continue;
         if(value_max_inc_candle >= MathAbs(Open[i] - Close[i]))
            bigger_counter++;
        }
      if(bigger_counter >= 2)
        {
         //
         double bands_2_max_candle_down = iBands(NULL, 0, Period_2, Deviation_2, Shift_2, PRICE_CLOSE, MODE_HIGH, index_max_inc_candle);
         if(Open[index_max_inc_candle] < bands_2_max_candle_down && Close[index_max_inc_candle] > bands_2_max_candle_down)
           {
            if(enable_text == true)
              {
               PoE_b_1(arrow_name_up_PoE_1, time_up_PoE_1, price_up_PoE_1);
              }
            Send_Buy_Order("PoE ");
            signal_price_buy = Bid;
            signalTime_buy = Time[0];
            return true;
           }
        }
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+PoE SELL
bool Check_Sell_Signal_PoE_1() // POE 1 SELL
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(Open[1] < Close[1] && Open[0] < Close[0] && Close[0] == High[1] && Close[0] - Open[0] <= Close[1] - Open[1]
          && Close[0] != Close[1] && Open[0] == Close[1])
       {
          Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
          time_wait_sell = Time[0];         // GetLine_Buy();
       }
    if(time_wait_sell == Time[1])
       {
          ObjectDelete("wait_signal");         // GetLine_Sell();
       }*/
//---
   if(int(MathAbs(Close[2] - Open[2]) / Point) > 1   && Open[2] < Close[2] && Open[1] < Close[1] && Close[1] == High[2] && Close[1] - Open[1] <= Close[2] - Open[2] &&
      Close[1] != Close[2] && Open[1] == Close[2] && Analys_EMA == 1  && Close[1] > Bands_up_1_1)
     {
      int index_max_dec_candle = -1;
      double value_max_dec_candle = -1;
      for(int i = 3; i <= 5; i++)
        {
         if(Close[i] < Open[i])
           {
            if(Open[i] - Close[i] > value_max_dec_candle)
              {
               value_max_dec_candle = Open[i] - Close[i];
               index_max_dec_candle = i;
              }
           }
        }
      int bigger_counter = 0;
      for(int i = 2; i <= 5; i++)
        {
         if(i == index_max_dec_candle)
            continue;
         if(value_max_dec_candle >= MathAbs(Open[i] - Close[i]))
            bigger_counter++;
        }
      if(bigger_counter >= 2)
        {
         double bands_2_max_candle_up = iBands(NULL, 0, Period_2, Deviation_2, Shift_2, PRICE_CLOSE, MODE_LOW, index_max_dec_candle);
         if(Open[index_max_dec_candle] > bands_2_max_candle_up && Close[index_max_dec_candle] < bands_2_max_candle_up)
           {
            if(enable_text == true)
              {
               PoE_s_1(arrow_name_down_PoE_1, time_down_PoE_1, price_down_PoE_1);
              }
            Send_Sell_Order("PoE");
            signal_price_sell = Bid;
            signalTime_sell = Time[0];
            return true;
           }
        }
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ PoE BUY
bool Check_Buy_Signal_PoE_2() //  POE 2 BUY
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(Open[1] > Close[1] && Open[0] > Close[0] && Close[0] == Low[1] && Open[0] - Close[0] <= Open[1] - Close[1]
          && Close[0] != Close[1] && Open[0] == Close[1])
       {
          Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
          time_wait_buy = Time[0]; //GetLine_Buy();
       }
    if(time_wait_buy == Time[1])
       {
          ObjectDelete("wait_signal");  // GetLine_Sell();
       }*/
//---
   /*if(false_PoE_3sarbaz_3kalagh == true )
      {
         if((Open[2] > Close[2] && Open[1] > Close[1] &&  Close[1] == Low[2] && Open[1] - Close[1] <= Open[2] - Close[2] &&
               Close[1] != Close[2] && Open[1] == Close[2] && Open[3] > Close[3] && Open[3] - Close[3] > Open[2] - Close[2])     //POE سه سرباز سه کلاغ
               ||
               (Open[2] < Close[2] && Open[1] < Close[1] && Close[1] == High[2] && Close[1] - Open[1] <= Close[2] - Open[2] &&
                Close[1] != Close[2] && Open[1] == Close[2] && Open[3] < Close[3] && Close[3] - Open[3] > Close[2] - Open[2]))
            return false;
      }
   else
      r = 1;*/
//---
   /* if(false_PoE == true)   // false_PoE
       {
          if(int(MathAbs(Close[2] - Open[2]) / Point) > 1   && Open[2] > Close[2] && Open[1] > Close[1] &&  Close[1] == Low[2] && Open[1] - Close[1] <= Open[2] - Close[2] &&
                Close[1] != Close[2] && Open[1] == Close[2] &&
                Open[3] > Close[3] && Open[4] < Close[4] && Close[1] < Bands_MODE_MAIN_1 && Close[1] > Bands_up_1_1 &&
                Analys_EMA == 1)
             return false;
       }
    else
       r = 1;*/
//---
   if(int(MathAbs(Close[2] - Open[2]) / Point) > 1   && Open[2] > Close[2] && Open[1] > Close[1] && Close[1] == Low[2] && Open[1] - Close[1] <= Open[2] - Close[2] &&
      Close[1] != Close[2] && Open[1] == Close[2]
      &&
      Analys_EMA == 2  && Close[1] < Bands_down_1_1 &&
      Open[3] > Close[3] && Open[3] - Close[3] > Open[2] - Close[2])   /////////// 2
     {
      if(enable_text == true)
        {
         PoE_b_2(arrow_name_up_PoE_2, time_up_PoE_2, price_up_PoE_2);
        }
      Send_Buy_Order("PoE");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+PoE SELL
bool Check_Sell_Signal_PoE_2()  // POE 2 SELL
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
//---
   /* if(Open[1] < Close[1] && Open[0] < Close[0] && Close[0] == High[1] && Close[0] - Open[0] <= Close[1] - Open[1]
          && Close[0] != Close[1] && Open[0] == Close[1])
       {
          Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
          time_wait_sell = Time[0];  // GetLine_Buy();
       }
    if(time_wait_sell == Time[1])
       {
          ObjectDelete("wait_signal"); // GetLine_Sell();
       }*/
//---
   /* if(false_PoE == true)   // false_PoE
       {
          if(int(MathAbs(Close[2] - Open[2]) / Point) > 1   && Open[2] < Close[2] && Open[1] < Close[1] && Close[1] == High[2] && Close[1] - Open[1] <= Close[2] - Open[2] &&
                Close[1] != Close[2] && Open[1] == Close[2] &&
                Open[3] < Close[3] && Open[4] > Close[4] && Close[1] < Bands_MODE_MAIN_1 && Close[1] < Bands_down_1_1 &&
                Analys_EMA == 2)
             return false;
       }
    else
       r = 1;*/
//---
   if(int(MathAbs(Close[2] - Open[2]) / Point) > 1   && Open[2] < Close[2] && Open[1] < Close[1] && Close[1] == High[2] && Close[1] - Open[1] <= Close[2] - Open[2] &&
      Close[1] != Close[2] && Open[1] == Close[2]
      &&
      Analys_EMA == 1  && Close[1] > Bands_up_1_1 &&
      Open[3] < Close[3] && Close[3] - Open[3] > Close[2] - Open[2])
     {
      if(enable_text == true)
        {
         PoE_s_2(arrow_name_down_PoE_2, time_down_PoE_2, price_down_PoE_2);
        }
      Send_Sell_Order("PoE");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ PoE BUY makose  //shart sell >>>>>  signal buy
bool Check_buy_Signal_PoE_3()  // POE 3 BUY
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(Open[1] < Close[1] && Open[0] < Close[0] && Close[0] == High[1] && Close[0] - Open[0] <= Close[1] - Open[1]
          && Close[0] != Close[1] && Open[0] == Close[1])
       {
          Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
          time_wait_sell = Time[0]; // GetLine_Buy();
       }
    if(time_wait_sell == Time[1])
       {
          ObjectDelete("wait_signal");  // GetLine_Sell();
       }*/
// فیلتر اگر سه کندل از سمت راست به ترتیب برگتر شد سیگنال نده
// یا فیک برک اوت کندل بزرگ روی باند 2 پایینی باشه
//---
   if(false_PoE == true)   // false_PoE
     {
      if((High[1] == Close[1] && Low[1] != Open[1] && Open[1] - Low[1] >= (Close[1] - Open[1]) * 1.5) || //f 6
         (Open[1] - Close[1]  < Open[2] - Close[2] && Open[2] - Close[2]  < Open[3] - Close[3]) ||  // 3 سرباز
         (Open[2] - Close[2] > Open[3] - Close[3] &&  Open[2] - Close[2] > Open[4] - Close[4] &&  Open[2] - Close[2] > Open[5] - Close[5] && Open[2] - Close[2] > Open[6] - Close[6]) || // f7
         (int(MathAbs(Close[1] - Open[1]) / Point) <= 1 && Close[1] > Bands_up_1_5_1) ||  // f9
         (int(MathAbs(Close[1] - Open[1]) / Point) == 1 && int(MathAbs(Close[1] - Open[1]) / Point) == 2))  //f 10
         return false;
     }
   else
      r = 1;
//---
   if(((int(MathAbs(Close[2] - Open[2]) / Point) > 1   && Open[2] > Close[2] && Open[1] > Close[1] &&  Close[1] == Low[2] && Open[1] - Close[1] <= Open[2] - Close[2] &&
        Close[1] != Close[2] && Open[1] == Close[2])
       ||
       (int(MathAbs(Close[2] - Open[2]) / Point) > 1   && Open[2] < Close[2] && Open[1] < Close[1] && Close[1] == High[2] && Close[1] - Open[1] <= Close[2] - Open[2] &&
        Close[1] != Close[2] && Open[1] == Close[2]))
      &&
      Analys_EMA == 1  && Close[1] > Bands_up_1_1)
     {
      if(enable_text == true) //         && Close[1] > Bands_up_1_1 && Analys_EMA == 1)
        {
         PoE_b_3(arrow_name_up_PoE_3, time_up_PoE_3, price_up_PoE_3);   //// 3
        }
      Send_Buy_Order("PoE ");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+_PoE SELL  makose  //shatr buy >>> signal sell
bool Check_sell_Signal_PoE_3() // POE 3 SELL
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(Open[1] > Close[1] && Open[0] > Close[0] && Close[0] == Low[1] && Open[0] - Close[0] <= Open[1] - Close[1]
          && Close[0] != Close[1] && Open[0] == Close[1])
       {
          Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
          time_wait_buy = Time[0];         //GetLine_Buy();
       }
    if(time_wait_buy == Time[1])
       {
          ObjectDelete("wait_signal");         // GetLine_Sell();
       }*/
// فیلتر اگر سه کندل از سمت راست به ترتیب برگتر شد سیگنال نده
// یا فیک برک اوت کندل بزرگ روی باند 2 پایینی باشه
//---
   if(false_PoE == true)   // false_PoE
     {
      if((Low[1] == Close[1] && High[1] != Open[1] && High[1] - Open[1] >= (Open[1] - Close[1]) * 1.5) || //f6
         (Close[1] - Open[1]  < Close[2] - Open[2] && Close[2] - Open[2]  < Close[3] - Open[3]) ||  // 3 سرباز
         (Close[2] - Open[2] > Close[3] - Open[3] &&  Close[2] - Open[2] > Close[4] - Open[4] &&  Close[2] - Open[2] > Close[5] - Open[5] && Close[2] - Open[2] > Close[6] - Open[6]) ||// f 7
         (int(MathAbs(Close[1] - Open[1]) / Point) <= 1 &&  Close[1] < Bands_down_1_5_1) || // f9
         (int(MathAbs(Close[1] - Open[1]) / Point) == 1 && int(MathAbs(Close[1] - Open[1]) / Point) == 2))  // f 10
         return false;
     }
   else
      r = 1;
//---
//----
   if(((int(MathAbs(Close[2] - Open[2]) / Point) > 1   && Open[2] < Close[2] && Open[1] < Close[1] && Close[1] == High[2] && Close[1] - Open[1] <= Close[2] - Open[2] &&
        Close[1] != Close[2] && Open[1] == Close[2])
       ||
       (int(MathAbs(Close[2] - Open[2]) / Point) > 1   && Open[2] > Close[2] && Open[1] > Close[1] &&  Close[1] == Low[2] && Open[1] - Close[1] <= Open[2] - Close[2] &&
        Close[1] != Close[2] && Open[1] == Close[2]))
      &&
      Analys_EMA == 2  && Close[1] < Bands_down_1_1)
     {
      if(enable_text == true)
        {
         PoE_s_3(arrow_name_down_PoE_3, time_down_PoE_3, price_down_PoE_3); //// 3
        }
      Send_Sell_Order("PoE 3");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ PoE BUY
bool Check_Buy_Signal_PoE_4()  // POE 4 BUY
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(int(MathAbs(Close[2] - Open[2]) / Point) > 1 && Open[2] < Close[2] && Open[1] < Close[1] && Close[1] == High[2] && Close[1] - Open[1] <= Close[2] - Open[2] &&
      Close[1] != Close[2] && Open[1] == Close[2] &&
      ((Open[3] > Close[3] && Open[4] < Close[4]) || (Open[3] < Close[3] && Open[4] < Close[4]) || (Open[3] > Close[3] && Open[4] > Close[4])) && Close[1] > Bands_MODE_MAIN_1 && Close[1]  < Bands_up_1_1 &&
      Analys_EMA == 1)
     {
      if(enable_text == true)
        {
         PoE_b_4(arrow_name_up_PoE_4, time_up_PoE_4, price_up_PoE_4);  ////4
        }
      Send_Buy_Order("PoE ");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ PoE BUY
bool Check_Sell_Signal_PoE_4()  // POE 4 SELL
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(int(MathAbs(Close[2] - Open[2]) / Point) > 1  && Open[2] > Close[2] && Open[1] > Close[1] &&  Close[1] == Low[2] && Open[1] - Close[1] <= Open[2] - Close[2] &&
      Close[1] != Close[2] && Open[1] == Close[2] &&
      ((Open[3] < Close[3] && Open[4] > Close[4]) || (Open[3] > Close[3] && Open[4] > Close[4]) || (Open[3] < Close[3] && Open[4] < Close[4])) && Close[1] < Bands_MODE_MAIN_1 && Close[1]  > Bands_down_1_1 &&
      Analys_EMA == 2
     )
     {
      if(enable_text == true)
        {
         PoE_s_4(arrow_name_down_PoE_4, time_down_PoE_4, price_down_PoE_4);   ////4
        }
      Send_Sell_Order("PoE ");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+_PoE BUY Ba olgoye reversal قبل از پی او ای یک الگوی ریورسال اتفاق بیفتد
//+------------------------------------------------------------------+
bool Check_Buy_Signal_PoE_5()  // POE 5 BUY
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(Open[1] < Close[1] && Open[0] < Close[0] && Close[0] == High[1] && Close[0] - Open[0] <= Close[1] - Open[1]
          && Close[0] != Close[1] && Open[0] == Close[1])
       {
          Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
          time_wait_sell = Time[0];// GetLine_Buy();
       }
    if(time_wait_sell == Time[1])
       {
          ObjectDelete("wait_signal"); // GetLine_Sell();
       }*/
//---
   if(AFTER_REVERSAL == true)  //  AFTER REVERSAL
     {
      if(Find_Analys_0 == 0)
        {
         r = 1;
        }
      else
         return false;
     }
   if(false_PoE == true)   // false_PoE
     {
      if((Open[3] < Close[3] && Open[4] > Close[4] && Close[3] - Open[3] > Close[2] - Open[2]) // f8
         ||
         (High[1] >= Bands_up_2_1 &&  Close[1] < Bands_up_2_1))  // 11
         return false;
     }
   else
      r = 1;
//---
   if(((int(MathAbs(Close[2] - Open[2]) / Point) > 1  && Open[2] < Close[2] && Open[1] < Close[1] && Close[1] == High[2] && Close[1] - Open[1] <= Close[2] - Open[2] &&
        Close[1] != Close[2] && Open[1] == Close[2])
       ||
       (int(MathAbs(Close[2] - Open[2]) / Point) > 1   && Open[2] > Close[2] && Open[1] > Close[1] && Close[1] == Low[2] && Open[1] - Close[1] <= Open[2] - Close[2] &&
        Close[1] != Close[2] && Open[1] == Close[2]))
      &&
      Analys_EMA == 3)
     {
      if(enable_text == true)
        {
         PoE_b_5(arrow_name_up_PoE_5, time_up_PoE_5, price_up_PoE_5);  ///5
        }
      Send_Buy_Order("PoE ");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+PoE SELL Ba olgoye reversal قبل از پی او ای یک الگوی ریورسال اتفاق بیفتد
bool Check_sell_Signal_PoE_5()  // POE 5 SELL
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /*  if(Open[1] > Close[1] && Open[0] > Close[0] && Close[0] == Low[1] && Open[0] - Close[0] <= Open[1] - Close[1]
           && Close[0] != Close[1] && Open[0] == Close[1])
        {
           Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
           time_wait_buy = Time[0];//GetLine_Buy();
        }
     if(time_wait_buy == Time[1])
        {
           ObjectDelete("wait_signal");   // GetLine_Sell();
        }*/
//----
   if(AFTER_REVERSAL == true)    // AFTER REVERSAL
     {
      if(Find_Analys_0 == 1)
        {
         r = 1;
        }
      else
         return false;
     }
//---
   if(false_PoE == true)   // false_PoE
     {
      if((Open[3] > Close[3] && Open[4] < Close[4] && Open[3] - Close[3] > Open[2] - Close[2]) ||   // f8
         (Low[1] <= Bands_down_2_1 && Close[1] > Bands_down_2_1))   // 11
         return false;
     }
   else
      r = 1;
//---
//---
   if(((int(MathAbs(Close[2] - Open[2]) / Point) > 1 && Open[2] > Close[2] && Open[1] > Close[1] && Close[1] == Low[2] && Open[1] - Close[1] <= Open[2] - Close[2] &&
        Close[1] != Close[2] && Open[1] == Close[2])
       ||
       (int(MathAbs(Close[2] - Open[2]) / Point) > 1 && Open[2] < Close[2] && Open[1] < Close[1] && Close[1] == High[2] && Close[1] - Open[1] <= Close[2] - Open[2] &&
        Close[1] != Close[2] && Open[1] == Close[2]))
      &&
      Analys_EMA == 3)
     {
      if(enable_text == true)
        {
         PoE_s_5(arrow_name_down_PoE_5, time_down_PoE_5, price_down_PoE_5); /// 5
        }
      Send_Sell_Order("PoE ");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ PoE BUY
bool Check_Buy_Signal_PoE_6()  // POE 6 BUY
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(int(MathAbs(Close[2] - Open[2]) / Point) > 1 &&
      int(MathAbs(Close[1] - Open[1]) / Point) <= 1 &&
      Open[2] > Close[2] && Open[1] > Close[1] &&  Close[1] == Low[2] && Open[1] - Close[1] <= Open[2] - Close[2] &&
      Close[1] != Close[2] && Open[1] == Close[2] &&
      Open[3] > Close[3] && Open[4] > Close[4] && Open[5] > Close[5] &&
      Low[1] == Close[1] && High[1] != Open[1] && High[1] - Open[1] >= (Open[1] - Close[1]) * 1.5 && Close[1] < Bands_down_1_1 && Analys_EMA == 2)
     {
      if(enable_text == true) //
        {
         PoE_b_6(arrow_name_up_PoE_6, time_up_PoE_6, price_up_PoE_6);
        }
      Send_Buy_Order("PoE ");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+PoE SELL
bool Check_sell_Signal_PoE_6() // POE 6 SELL
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(Open[1] < Close[1] && Open[0] < Close[0] && Close[0] == High[1] && Close[0] - Open[0] <= Close[1] - Open[1]
          && Close[0] != Close[1] && Open[0] == Close[1])
       {
          Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
          time_wait_sell = Time[0];         // GetLine_Buy();
       }
    if(time_wait_sell == Time[1])
       {
          ObjectDelete("wait_signal");         // GetLine_Sell();
       }*/
//---
//---
   if(int(MathAbs(Close[2] - Open[2]) / Point) > 1 &&
      int(MathAbs(Close[1] - Open[1]) / Point) <= 1 &&
      Open[2] < Close[2] && Open[1] < Close[1] && Close[1] == High[2] && Close[1] - Open[1] <= Close[2] - Open[2] &&
      Close[1] != Close[2] && Open[1] == Close[2] &&
      Open[3] < Close[3] && Open[4] < Close[4] && Open[5] < Close[5] && Open[6] < Close[6] &&
      High[1] == Close[1] && Low[1] != Open[1] && Open[1] - Low[1] >= (Close[1] - Open[1]) * 1.5 && Close[1] > Bands_up_1_1 && Analys_EMA == 1)
     {
      if(enable_text == true) // Analys_EMA == 1  && Close[1] > Bands_up_1_1)
        {
         PoE_s_6(arrow_name_down_PoE_6, time_down_PoE_6, price_down_PoE_6);
        }
      Send_Sell_Order("PoE");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   return false;
  }


//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ PoE BUY
bool Check_Buy_Signal_PoE_7()  // POE 7 BUY
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(false_PoE == true)   // false_PoE
       {
          if( Low[1] == Close[1] && High[1] != Open[1] && High[1] - Open[1] >= (Open[1] - Close[1]) * 1.5 )
             return false;
       }
    else
       r = 1;*/
//---
//---
   if(int(MathAbs(Close[1] - Open[1]) / Point) <= 1 && Open[2] > Close[2] && Open[1] > Close[1] &&  Close[1] == Low[2] && Open[1] - Close[1] <= Open[2] - Close[2] &&   ///////  1
      Close[1] != Close[2] && Open[1] == Close[2] &&
      Open[3] > Close[3] && Open[4] > Close[4] && Open[5] > Close[5] && Open[6] > Close[6] &&
      Close[1] < Bands_down_1_7_1 && Close[1] > Bands_down_2_3_1 &&
      Close[2] < Bands_down_1_7_2 && Close[2] > Bands_down_2_3_2 &&
      Open[2] - Close[2] > Open[3] - Close[3] &&  Open[2] - Close[2] > Open[4] - Close[4] &&  Open[2] - Close[2] > Open[5] - Close[5] && Open[2] - Close[2] > Open[6] - Close[6]
     )
     {
      if(enable_text == true)
        {
         PoE_b_7(arrow_name_up_PoE_7, time_up_PoE_7, price_up_PoE_7);
        }
      Send_Buy_Order("PoE ");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+PoE SELL
bool Check_sell_Signal_PoE_7() // POE 7 SELL
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(Open[1] < Close[1] && Open[0] < Close[0] && Close[0] == High[1] && Close[0] - Open[0] <= Close[1] - Open[1]
          && Close[0] != Close[1] && Open[0] == Close[1])
       {
          Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
          time_wait_sell = Time[0];         // GetLine_Buy();
       }
    if(time_wait_sell == Time[1])
       {
          ObjectDelete("wait_signal");         // GetLine_Sell();
       }*/
//---
   /* if(false_PoE == true)   // false_PoE
       {
          if(High[1] == Close[1] && Low[1] != Open[1] && Open[1] - Low[1] >= (Close[1] - Open[1]) * 1.5)
             return false;
       }
    else
       r = 1;*/
//---
   if(int(MathAbs(Close[1] - Open[1]) / Point) <= 1 && Open[2] < Close[2] && Open[1] < Close[1] && Close[1] == High[2] && Close[1] - Open[1] <= Close[2] - Open[2] &&
      Close[1] != Close[2] && Open[1] == Close[2] &&
      Open[3] < Close[3] && Open[4] < Close[4] && Open[5] < Close[5] && Open[6] < Close[6] &&
      Close[1] > Bands_up_1_7_1 && Close[1] < Bands_up_2_3_1 &&
      Close[2] > Bands_up_1_7_2 && Close[2] < Bands_up_2_3_2 &&
      Close[2] - Open[2] > Close[3] - Open[3] &&  Close[2] - Open[2] > Close[4] - Open[4] &&  Close[2] - Open[2] > Close[5] - Open[5] && Close[2] - Open[2] > Close[6] - Open[6])
     {
      if(enable_text == true)
        {
         PoE_s_7(arrow_name_down_PoE_7, time_down_PoE_7, price_down_PoE_7);
        }
      Send_Sell_Order("PoE");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ PoE BUY
bool Check_Buy_Signal_PoE_8()  // POE 8 BUY
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(int(MathAbs(Close[2] - Open[2]) / Point) > 1 &&
      int(MathAbs(Close[1] - Open[1]) / Point) <= 1  &&
      Open[2] > Close[2] && Open[1] > Close[1] &&  Close[1] == Low[2] && Open[1] - Close[1] <= Open[2] - Close[2] &&   ///////  1
      Close[1] != Close[2] && Open[1] == Close[2] &&
      Analys_EMA == 3 && Open[3] > Close[3] && Open[4] < Close[4] && Open[3] - Close[3] > Open[2] - Close[2])
     {
      if(enable_text == true)
        {
         PoE_b_8(arrow_name_up_PoE_8, time_up_PoE_8, price_up_PoE_8);
        }
      Send_Buy_Order("PoE ");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+PoE SELL
bool Check_sell_Signal_PoE_8() // POE 8 SELL
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(Open[1] < Close[1] && Open[0] < Close[0] && Close[0] == High[1] && Close[0] - Open[0] <= Close[1] - Open[1]
          && Close[0] != Close[1] && Open[0] == Close[1])
       {
          Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
          time_wait_sell = Time[0];         // GetLine_Buy();
       }
    if(time_wait_sell == Time[1])
       {
          ObjectDelete("wait_signal");         // GetLine_Sell();
       }*/
//---
   if(int(MathAbs(Close[2] - Open[2]) / Point) > 1 &&
      int(MathAbs(Close[1] - Open[1]) / Point) <= 1  &&
      Open[2] < Close[2] && Open[1] < Close[1] && Close[1] == High[2] && Close[1] - Open[1] <= Close[2] - Open[2] &&
      Close[1] != Close[2] && Open[1] == Close[2]
      && Analys_EMA == 3 && Open[3] < Close[3] && Open[4] > Close[4] && Close[3] - Open[3] > Close[2] - Open[2])
     {
      if(enable_text == true)
        {
         PoE_s_8(arrow_name_down_PoE_8, time_down_PoE_8, price_down_PoE_8);
        }
      Send_Sell_Order("PoE");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+ PoE BUY
bool Check_Buy_Signal_PoE_9()  // POE 9 BUY
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(int(MathAbs(Close[2] - Open[2]) / Point) > 1 &&
      int(MathAbs(Close[1] - Open[1]) / Point) <= 1 &&
      Open[2] > Close[2] && Open[1] > Close[1] &&  Close[1] == Low[2] && Open[1] - Close[1] <= Open[2] - Close[2] &&   ///////  1
      Close[1] != Close[2] && Open[1] == Close[2] &&
      Analys_EMA == 1  &&
      Close[1] < Bands_down_1_5_1)
     {
      if(enable_text == true)
        {
         PoE_b_9(arrow_name_up_PoE_9, time_up_PoE_9, price_up_PoE_9);
        }
      Send_Buy_Order("PoE ");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+PoE SELL
bool Check_sell_Signal_PoE_9() // POE 9 SELL
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(Open[1] < Close[1] && Open[0] < Close[0] && Close[0] == High[1] && Close[0] - Open[0] <= Close[1] - Open[1]
          && Close[0] != Close[1] && Open[0] == Close[1])
       {
          Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
          time_wait_sell = Time[0];         // GetLine_Buy();
       }
    if(time_wait_sell == Time[1])
       {
          ObjectDelete("wait_signal");         // GetLine_Sell();
       }*/
//---
   if(int(MathAbs(Close[2] - Open[2]) / Point) > 1 &&
      int(MathAbs(Close[1] - Open[1]) / Point) <= 1  &&
      Open[2] < Close[2] && Open[1] < Close[1] && Close[1] == High[2] && Close[1] - Open[1] <= Close[2] - Open[2] &&
      Close[1] != Close[2] && Open[1] == Close[2] &&
      Analys_EMA == 1  &&
      Close[1] > Bands_up_1_5_1)
     {
      if(enable_text == true)
        {
         PoE_s_9(arrow_name_down_PoE_9, time_down_PoE_9, price_down_PoE_9);
        }
      Send_Sell_Order("PoE");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+ PoE BUY
bool Check_Buy_Signal_PoE_10()  // POE 10 BUY
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(false_PoE == true)   // false_PoE
       {
          if( Low[1] == Close[1] && High[1] != Open[1] && High[1] - Open[1] >= (Open[1] - Close[1]) * 1.5 )
             return false;
       }
    else
       r = 1;*/
//---
//---
   if(int(MathAbs(Close[2] - Open[2]) / Point) == 2   &&
      int(MathAbs(Close[1] - Open[1]) / Point) == 1  &&
      Open[2] > Close[2] && Open[1] > Close[1] &&  Close[1] == Low[2] && Open[1] - Close[1] <= Open[2] - Close[2] &&   ///////  1
      Close[1] != Close[2] && Open[1] == Close[2] &&
      Analys_EMA == 2  &&
      Close[1] < Bands_down_1_1 /*&& Close[2] < Bands_down_1_2 && Open[3] > Close[3]&& Open[4] > Close[4] && Open[5] > Close[5]*/)
     {
      if(enable_text == true)
        {
         PoE_b_10(arrow_name_up_PoE_10, time_up_PoE_10, price_up_PoE_10);
        }
      Send_Buy_Order("PoE ");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+PoE SELL
bool Check_sell_Signal_PoE_10() // POE 10 SELL
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(Open[1] < Close[1] && Open[0] < Close[0] && Close[0] == High[1] && Close[0] - Open[0] <= Close[1] - Open[1]
          && Close[0] != Close[1] && Open[0] == Close[1])
       {
          Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
          time_wait_sell = Time[0];         // GetLine_Buy();
       }
    if(time_wait_sell == Time[1])
       {
          ObjectDelete("wait_signal");         // GetLine_Sell();
       }*/
//---
   /* if(false_PoE == true)   // false_PoE
       {
          if(High[1] == Close[1] && Low[1] != Open[1] && Open[1] - Low[1] >= (Close[1] - Open[1]) * 1.5)
             return false;
       }
    else
       r = 1;*/
//---
//---
   if(int(MathAbs(Open[2] - Close[2]) / Point) == 2   &&
      int(MathAbs(Close[1] - Open[1]) / Point) == 1  &&
      Open[2] < Close[2] && Open[1] < Close[1] && Close[1] == High[2] && Close[1] - Open[1] <= Close[2] - Open[2] &&
      Close[1] != Close[2] && Open[1] == Close[2] &&
      Analys_EMA == 1  &&
      Close[1] > Bands_up_1_1 /*&& Close[2] > Bands_up_1_2 && Open[3] < Close[3]&& Open[4] < Close[4] && Open[5] < Close[5]*/)
     {
      if(enable_text == true)
        {
         PoE_s_10(arrow_name_down_PoE_10, time_down_PoE_10, price_down_PoE_10);
        }
      Send_Sell_Order("PoE");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ PoE BUY
bool Check_Buy_Signal_PoE_11()  // POE 11 BUY
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(int(MathAbs(Close[2] - Open[2]) / Point) > 1   &&
      Open[2] > Close[2] && Open[1] > Close[1] &&  Close[1] == Low[2] && Open[1] - Close[1] <= Open[2] - Close[2] &&   ///////  1
      Close[1] != Close[2] && Open[1] == Close[2] &&
// High[1] == Open[1] &&
      Analys_EMA == 3  &&
      Low[1] <= Bands_down_2_1 &&  Close[1] > Bands_down_2_1)
     {
      if(enable_text == true)
        {
         PoE_b_11(arrow_name_up_PoE_11, time_up_PoE_11, price_up_PoE_11);
        }
      Send_Buy_Order("PoE ");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+PoE SELL
bool Check_sell_Signal_PoE_11() // POE 11 SELL
  {
   int r;
   if(PoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(Open[1] < Close[1] && Open[0] < Close[0] && Close[0] == High[1] && Close[0] - Open[0] <= Close[1] - Open[1]
          && Close[0] != Close[1] && Open[0] == Close[1])
       {
          Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
          time_wait_sell = Time[0];         // GetLine_Buy();
       }
    if(time_wait_sell == Time[1])
       {
          ObjectDelete("wait_signal");         // GetLine_Sell();
       }*/
//---
   if(int(MathAbs(Close[2] - Open[2]) / Point) > 1 &&
      Open[2] < Close[2] && Open[1] < Close[1] && Close[1] == High[2] && Close[1] - Open[1] <= Close[2] - Open[2] &&
      Close[1] != Close[2] && Open[1] == Close[2] &&
// Low[1] == Open[1] &&
      Analys_EMA == 3 &&
      High[1] >= Bands_up_2_1 &&  Close[1] < Bands_up_2_1)
     {
      if(enable_text == true)
        {
         PoE_s_11(arrow_name_down_PoE_11, time_down_PoE_11, price_down_PoE_11);
        }
      Send_Sell_Order("PoE");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ DPoE
//+------------------------------------------------------------------+ DPoE BUY  ok
bool Check_Buy_Signal_DPoE()
  {
   int r;
   if(DPoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /*  if(Open[1] > Close[1] && Open[0] > Close[0] && Close[0] == Low[1] && Open[0] - Close[0] <= Open[1] - Close[1]
           && Close[0] != Close[1] && Open[0] == Close[1])
        {
           Alert_wait_type(" DPoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
           time_wait_buy = Time[0];           //GetLine_Buy();
        }
     if(time_wait_buy == Time[1])
        {
           ObjectDelete("wait_signal"); // GetLine_Sell();
        }*/
//---
//---
   /* if(false_DPoE_3sarbaz_3kalagh == true )
       {
          if(((Close[1] == Open[1]  || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Open[2] > Close[2] && Open[3] > Close[3]    //DPOE سه سرباز سه کلاغ
                && Close[2] == Low[2]  && Close[3] != Low[3]
                && Close[2] == Low[3]
                && Low[1] >= Low[3]
                && Open[2] <= Close[3] && Open[4] > Close[4] && Open[4] > Close[4] > Open[3] > Close[3] )
                ||
                ((Close[1] == Open[1] || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Open[2] < Close[2] && Open[3] < Close[3]  //DPOE سه سرباز سه کلاغ
                 && Close[2] != High[2]  && Close[3] != High[3]
                 && Close[2] == High[3]
                 && High[1] <= High[3]
                 && Open[2] >= Close[3] && Open[4] < Close[4] && Close[4] > Open[4] > Close[3] > Open[3] ))
             return false;
       }
    else
       r = 1;*/
//----
   if(false_DPoE == true)  // false_DPoE
     {
      if((Close[1] == Open[1]  || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Open[2] > Close[2] && Open[3] > Close[3]      //DPOE
         && Close[2] == Low[2]  && Close[3] != Low[3]
         && Close[2] == Low[3]
         && Low[1] >= Low[3]
         && Open[2] <= Close[3] &&
         Open[4] > Close[4] && Open[5] < Close[5] &&  Close[1] < Bands_MODE_MAIN_1 && Close[1] > Bands_down_1_1 &&
         Analys_EMA == 1)
         return false;
     }
   else
      r = 1;
//----
   if(((Close[1] == Open[1]  || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Open[2] > Close[2] && Open[3] > Close[3]      //DPOE
       && Close[2] == Low[2]  && Close[3] != Low[3]
       && Close[2] == Low[3]
       && Low[1] >= Low[3]
       && Open[2] <= Close[3] &&
       ((Analys_EMA == 1  && Close[2] > Bands_up_1_2) ||     // buy
        (Analys_EMA == 1  && Close[2] > Bands_MODE_MAIN_2 && MathAbs(Close[4] - Open[4]) < MathAbs(Close[3] - Open[3]))))
      ||
//---
      ((Close[1] == Open[1]  || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Open[2] > Close[2] && Open[3] > Close[3]   //DPOE
       && Close[2] == Low[2]  && Close[3] != Low[3]
       && Close[2] == Low[3]
       && Low[1] >= Low[3]
       && Open[2] <= Close[3]
       &&
       Analys_EMA == 2  && Close[2] < Bands_down_1_2 &&  Open[4] > Close[4] && Open[4] - Close[4] > Open[3] - Close[3]))
     {
      if(enable_text == true)
        {
         DPoE_b(arrow_name_up_DPoE, time_up_DPoE, price_up_DPoE);
        }
      Send_Buy_Order("DPoE");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ DPoE BUY
bool Check_Buy_Signal_DPoE_1()
  {
   int r;
   if(DPoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /*  if(Open[1] > Close[1] && Open[0] > Close[0] && Close[0] == Low[1] && Open[0] - Close[0] <= Open[1] - Close[1]
           && Close[0] != Close[1] && Open[0] == Close[1])
        {
           Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
           time_wait_buy = Time[0]; //GetLine_Buy();
        }
     if(time_wait_buy == Time[1])
        {
           ObjectDelete("wait_signal");// GetLine_Sell();
        }*/
//---
   if((Close[1] == Open[1]  || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Open[2] > Close[2] && Open[3] > Close[3]      //DPOE
      && Close[2] == Low[2]  && Close[3] != Low[3]
      && Close[2] == Low[3]
      && Low[1] >= Low[3]
      && Open[2] <= Close[3] && Analys_EMA == 2  && Close[2] < Bands_down_1_2)
     {
      int index_max_inc_candle = -1;
      double value_max_inc_candle = -1;
      for(int i = 4; i <= 6; i++)
        {
         if(Close[i] > Open[i])
           {
            if(Close[i] - Open[i] > value_max_inc_candle)
              {
               value_max_inc_candle = Close[i] - Open[i];
               index_max_inc_candle = i;
              }
           }
        }
      int bigger_counter = 0;
      for(int i = 3; i <= 6; i++)
        {
         if(i == index_max_inc_candle)
            continue;
         if(value_max_inc_candle >= MathAbs(Open[i] - Close[i]))
            bigger_counter++;
        }
      if(bigger_counter >= 2)
        {
         double bands_2_max_candle = iBands(NULL, 0, Period_2, Deviation_2, Shift_2, PRICE_CLOSE, MODE_HIGH, index_max_inc_candle);
         if(Open[index_max_inc_candle] < bands_2_max_candle && Close[index_max_inc_candle] > bands_2_max_candle)
           {
            if(enable_text == true)
              {
               DPoE_b_1(arrow_name_up_DPoE_1, time_up_DPoE_1, price_up_DPoE_1);
              }
            Send_Buy_Order("DPoE ");
            signal_price_buy = Bid;
            signalTime_buy = Time[0];
            return true;
           }
        }
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ DPoE BUY  OK T
bool Check_Buy_Signal_DPoE_2()
  {
   int r;
   if(DPoE == true)
     {
      r = 1;
     }
   else
      return false;
//----
   if((Close[1] == Open[1] || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Close[2] > Open[2] && Close[3] > Open[3]
      && Close[2] != High[2]  && Close[3] != High[3]
      && Close[2] == High[3]
      && High[1] <= High[3]
      && Open[2] >= Close[3] &&
      ((Open[4] > Close[4] && Open[5] < Close[5]) || (Open[4] < Close[4] && Open[5] < Close[5])) && Close[3] > Bands_MODE_MAIN_3 && MathMax(Open[2], Close[2]) < Bands_up_1_2 &&
      MathMax(Open[3], Close[3]) < Bands_up_1_3 &&
      Analys_EMA == 1)
     {
      if(enable_text == true)
        {
         DPoE_b_2(arrow_name_up_DPoE_2, time_up_DPoE_2, price_up_DPoE_2);
        }
      Send_Buy_Order("DPoE ");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ DPoE BUY makose  //shart sell >>>>>  signal buy   ok
bool Check_buy_Signal_DPoE_3()
  {
   int r;
   if(DPoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(Open[1] < Close[1] && Open[0] < Close[0] && Close[0] == High[1] && Close[0] - Open[0] <= Close[1] - Open[1]
          && Close[0] != Close[1] && Open[0] == Close[1])
       {
          Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
          time_wait_sell = Time[0];          // GetLine_Buy();
       }
    if(time_wait_sell == Time[1])
       {
          ObjectDelete("wait_signal");          // GetLine_Sell();
       }*/
//----
   if(false_DPoE == true)  // false_DPoE
     {
      if((Close[1] == Open[1]  || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Open[2] > Close[2] && Open[3] > Close[3]      //DPOE
         && Close[2] == Low[2]  && Close[3] != Low[3]
         && Close[2] == Low[3]
         && Low[1] >= Low[3]
         && Open[2] <= Close[3] &&
         Open[4] > Close[4] && Open[5] < Close[5] && Close[1] < Bands_MODE_MAIN_1 && Close[1] > Bands_down_1_1 &&
         Analys_EMA == 1)
         return false;
     }
   else
      r = 1;
//---
   if((Close[1] == Open[1]  || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Open[2] > Close[2] && Open[3] > Close[3]      //DPOE
      && Close[2] == Low[2]  && Close[3] != Low[3]
      && Close[2] == Low[3]
      && Low[1] >= Low[3]
      && Open[2] <= Close[3]
      &&
      ((Analys_EMA == 1  && Close[2] > Bands_up_1_2) ||       // buy
       (Analys_EMA == 1  && Close[2] > Bands_MODE_MAIN_2 && MathAbs(Open[4] - Close[4]) < MathAbs(Open[3] - Close[3]))))    //buy
     {
      if(enable_text == true)
        {
         DPoE_b_3(arrow_name_up_DPoE_3, time_up_DPoE_3, price_up_DPoE_3);
        }
      Send_Buy_Order("DPoE ");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+_DPoE BUY Ba olgoye reversal قبل از پی او ای یک الگوی ریورسال اتفاق بیفتد  OK
//+------------------------------------------------------------------+
bool Check_Buy_Signal_DPoE_5()
  {
   int r;
   if(DPoE == true)
     {
      r = 1;
     }
   else
      return false;
   /* if(Open[1] < Close[1] && Open[0] < Close[0] && Close[0] == High[1] && Close[0] - Open[0] <= Close[1] - Open[1]
          && Close[0] != Close[1] && Open[0] == Close[1])
       {
          Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
          time_wait_sell = Time[0];   // GetLine_Buy();
       }
    if(time_wait_sell == Time[1])
       {
          ObjectDelete("wait_signal"); // GetLine_Sell();
       }*/
//----
   if(AFTER_REVERSAL == true)
     {
      if(Find_Analys_0 == 0)
        {
         r = 1;
        }
      else
         return false;
     }
//----
   if((((Close[1] == Open[1]  || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Open[2] > Close[2] && Open[3] > Close[3]      //DPOE
        && Close[2] == Low[2]  && Close[3] != Low[3]
        && Close[2] == Low[3]
        && Low[1] >= Low[3]
        && Open[2] <= Close[3])
       ||
       ((Close[1] == Open[1] || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Close[2] > Open[2] && Close[3] > Open[3]
        && Close[2] != High[2]  && Close[3] != High[3]
        && Close[2] == High[3]
        && High[1] <= High[3]
        && Open[2] >= Close[3]))
      &&
      Analys_EMA == 3)
     {
      if(enable_text == true)
        {
         DPoE_b_5(arrow_name_up_DPoE_5, time_up_DPoE_5, price_up_DPoE_5); /// 5
        }
      Send_Buy_Order("DPoE ");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+_DPoE SELL  makose  //shatr buy >>> signal sell  ok
bool Check_sell_Signal_DPoE_3()
  {
   int r;
   if(DPoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /*  if(Open[1] > Close[1] && Open[0] > Close[0] && Close[0] == Low[1] && Open[0] - Close[0] <= Open[1] - Close[1]
           && Close[0] != Close[1] && Open[0] == Close[1])
        {
           Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
           time_wait_buy = Time[0];           //GetLine_Buy();
        }
     if(time_wait_buy == Time[1])
        {
           ObjectDelete("wait_signal");// GetLine_Sell();
        }*/
//---
   if(false_DPoE == true)  // false_DPoE
     {
      if((Close[1] == Open[1] || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Open[2] < Close[2] && Open[3] < Close[3]
         && Close[2] != High[2]  && Close[3] != High[3]
         && Close[2] == High[3]
         && High[1] <= High[3]
         && Open[2] >= Close[3] &&
         Open[4] < Close[4] && Open[5] > Close[5] && Close[1] > Bands_MODE_MAIN_1 && Close[1] < Bands_up_1_1 &&
         Analys_EMA == 2)
         return false;
     }
   else
      r = 1;
//---
//---
   if((Close[1] == Open[1]  || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Open[2] > Close[2] && Open[3] > Close[3]      //DPOE
      && Close[2] == Low[2]  && Close[3] != Low[3]
      && Close[2] == Low[3]
      && Low[1] >= Low[3]
      && Open[2] <= Close[3] &&
      ((Analys_EMA == 2  && Close[2] < Bands_down_1_2) ||    //sell
       (Analys_EMA == 2  && Close[2] < Bands_MODE_MAIN_2 && MathAbs(Close[4] - Open[4]) < MathAbs(Close[3] - Open[3]))))   //sell
     {
      if(enable_text == true)
        {
         DPoE_s_3(arrow_name_down_DPoE_3, time_down_DPoE_3, price_down_DPoE_3);
        }
      Send_Sell_Order("DPoE ");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ DPoE BUY OK T
bool Check_Sell_Signal_DPoE_2()
  {
   int r;
   if(DPoE == true)
     {
      r = 1;
     }
   else
      return false;
//----
   if((Close[1] == Open[1]  || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Open[2] > Close[2] && Open[3] > Close[3]      //DPOE
      && Close[2] == Low[2]  && Close[3] != Low[3]
      && Close[2] == Low[3]
      && Low[1] >= Low[3]
      && Open[2] <= Close[3] &&
      ((Open[4] < Close[4] && Open[5] > Close[5]) || (Open[4] > Close[4] && Open[5] > Close[5])) && Close[3] < Bands_MODE_MAIN_3 && MathMin(Open[2], Close[2]) > Bands_down_1_2 &&
      MathMin(Open[3], Close[3]) > Bands_down_2_3 &&
      Analys_EMA == 2)
     {
      if(enable_text == true)
        {
         DPoE_s_2(arrow_name_down_DPoE_2, time_down_DPoE_2, price_down_DPoE_2);
        }
      Send_Sell_Order("DPoE ");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+DPoE SELL Ba olgoye reversal قبل از پی او ای یک الگوی ریورسال اتفاق بیفتد  OK
bool Check_Sell_Signal_DPoE_5()
  {
   int r;
   if(DPoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(Open[1] > Close[1] && Open[0] > Close[0] && Close[0] == Low[1] && Open[0] - Close[0] <= Open[1] - Close[1]
          && Close[0] != Close[1] && Open[0] == Close[1])
       {
          Alert_wait_type(" DPoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
          time_wait_buy = Time[0]; //GetLine_Buy();
       }
    if(time_wait_buy == Time[1])
       {
          ObjectDelete("wait_signal"); // GetLine_Sell();
       }*/
//----
   if(AFTER_REVERSAL == true)
     {
      if(Find_Analys_0 == 1)
        {
         r = 1;
        }
      else
         return false;
     }
//----
   if((((Close[1] == Open[1]  || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Open[2] > Close[2] && Open[3] > Close[3]      //DPOE
        && Close[2] == Low[2]  && Close[3] != Low[3]
        && Close[2] == Low[3]
        && Low[1] >= Low[3]
        && Open[2] <= Close[3])
       ||
       ((Close[1] == Open[1] || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) &&  Open[2] < Close[2] && Open[3] < Close[3]
        && Close[2] != High[2]  && Close[3] != High[3]
        && Close[2] == High[3]
        && High[1] <= High[3]
        && Open[2] >= Close[3]))
      &&
      Analys_EMA == 3)
     {
      if(enable_text == true)
        {
         DPoE_s_5(arrow_name_down_DPoE_5, time_down_DPoE_5, price_down_DPoE_5); ///5
        }
      Send_Sell_Order("DPoE ");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+DPoE SELL    ok
bool Check_Sell_Signal_DPoE()
  {
   int r;
   if(DPoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /*  if(Open[1] < Close[1] && Open[0] < Close[0] && Close[0] == High[1] && Close[0] - Open[0] <= Close[1] - Open[1]
           && Close[0] != Close[1] && Open[0] == Close[1])
        {
           Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
           time_wait_sell = Time[0]; // GetLine_Buy();
        }
     if(time_wait_sell == Time[1])
        {
           ObjectDelete("wait_signal");  // GetLine_Sell();
        }*/
//---
   if(false_DPoE == true) // false_DPoE
     {
      if((Close[1] == Open[1] || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) &&  Open[2] < Close[2] && Open[3] < Close[3]
         && Close[2] != High[2]  && Close[3] != High[3]
         && Close[2] == High[3]
         && High[1] <= High[3]
         && Open[2] >= Close[3] &&
         Open[4] < Close[4] && Open[5] > Close[5] && Close[1] > Bands_MODE_MAIN_1 && Close[1] < Bands_up_1_1 &&
         Analys_EMA == 2)
         return false;
     }
   else
      r = 1;
//---
   if((((Close[1] == Open[1] || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Close[2] > Open[2] && Close[3] > Open[3]
        && Close[2] != High[2]  && Close[3] != High[3]
        && Close[2] == High[3]
        && High[1] <= High[3]
        && Open[2] >= Close[3])
       &&
       ((Analys_EMA == 2  && Close[2] < Bands_down_1_2) ||    //sell
        (Analys_EMA == 2  && Close[2] < Bands_MODE_MAIN_2  && MathAbs(Open[4] - Close[4]) < MathAbs(Open[3] - Close[3]))))  //sell
      ||
      (((Close[1] == Open[1] || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Close[2] > Open[2] && Close[3] > Open[3]
        && Close[2] != High[2]  && Close[3] != High[3]
        && Close[2] == High[3]
        && High[1] <= High[3]
        && Open[2] >= Close[3])
       &&
       Analys_EMA == 1  && Close[2] > Bands_up_1_2 && Open[4] < Close[4] && Close[4] - Open[4] > Close[3] - Open[3]))
     {
      if(enable_text == true)
        {
         DPoE_s(arrow_name_down_DPoE, time_down_DPoE, price_down_DPoE);
        }
      Send_Sell_Order("DPoE");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+DPoE SELL
bool Check_Sell_Signal_DPoE_1()
  {
   int r;
   if(DPoE == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /*  if(Open[1] < Close[1] && Open[0] < Close[0] && Close[0] == High[1] && Close[0] - Open[0] <= Close[1] - Open[1]
           && Close[0] != Close[1] && Open[0] == Close[1])
        {
           Alert_wait_type(" PoE ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
           time_wait_sell = Time[0];// GetLine_Buy();
        }
     if(time_wait_sell == Time[1])
        {
           ObjectDelete("wait_signal"); // GetLine_Sell();
        }*/
//----
   if((Close[1] == Open[1]  || (MathMax(Close[1], Open[1]) - MathMin(Close[1], Open[1]) <= 1 * Point)) && Open[2] > Close[2] && Open[3] > Close[3]      //DPOE
      && Close[2] == Low[2]  && Close[3] != Low[3]
      && Close[2] == Low[3]
      && Low[1] >= Low[3]
      && Open[2] <= Close[3])
     {
      int index_max_dec_candle = -1;
      double value_max_dec_candle = -1;
      for(int i = 4; i <= 6; i++)
        {
         if(Close[i] < Open[i])
           {
            if(Open[i] - Close[i] > value_max_dec_candle)
              {
               value_max_dec_candle = Open[i] - Close[i];
               index_max_dec_candle = i;
              }
           }
        }
      int bigger_counter = 0;
      for(int i = 3; i <= 6; i++)
        {
         if(i == index_max_dec_candle)
            continue;
         if(value_max_dec_candle >= MathAbs(Open[i] - Close[i]))
            bigger_counter++;
        }
      if(bigger_counter >= 2)
        {
         //
         double bands_2_max_candle = iBands(NULL, 0, Period_2, Deviation_2, Shift_2, PRICE_CLOSE, MODE_LOW, index_max_dec_candle);
         if(Open[index_max_dec_candle] > bands_2_max_candle && Close[index_max_dec_candle] < bands_2_max_candle)
           {
            if(enable_text == true)
              {
               DPoE_s_1(arrow_name_down_DPoE_1, time_down_DPoE_1, price_down_DPoE_1);
              }
            Send_Sell_Order("DPoE");
            signal_price_sell = Bid;
            signalTime_sell = Time[0];
            return true;
           }
        }
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+_EDS_MDS
//+------------------------------------------------------------------+
bool Check_Buy_Signal_MDS()  // MDS BUY
  {
   int r;
   if(EDS_MDS == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(_outside_2_Dev_EDS_MDS == true)
     {
      if(Open[3] > Bands_down_2_3 && Close[3] < Bands_down_2_3 && Close[1] > Bands_down_2_1)
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(_Body_to_Wick_EDS_MDS == true)
     {
      if(High[1] - Close[1] < (((Close[1] - Open[1])*_body_size_percent_EDS_MDS) / 100))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(_3rd_Huge_candle_size_EDS_MDS == true)
     {
      if(Close[1] - Open[1] <= ((Open[3] - Close[3])*_3rd_Huge_candle_size_EDS_MDS))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(_3rd_Tiny_candle_EDS_MDS == true)
     {
      if(Close[1] - Open[1]  >= ((Open[3] -  Close[3]) / _3rd_Tiny_candle_size_EDS_MDS))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(_3rd_candle_body_breakout_EDS_MDS == true)
     {
      if(Close[1] > High[2] &&  Close[1] - (Close[1] - Open[1]) / 2 > High[2] && Close[1] != (Open[3] - Close[3]) + Close[3])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(_2_EMA_breakout_EDS_MDS == true)
     {
      if(
         (myMA_20_1  > Open[1] && myMA_20_1  < Close[1] && myMA_50_1  > Open[1] && myMA_50_1  < Close[1]) ||
         (myMA_20_1  > Open[1] && myMA_20_1  < Close[1] && myMA_100_1 > Open[1] && myMA_100_1 < Close[1]) ||
         (myMA_20_1  > Open[1] && myMA_20_1  < Close[1] && myMA_200_1 > Open[1] && myMA_200_1 < Close[1]) ||
         (myMA_50_1  > Open[1] && myMA_50_1  < Close[1] && myMA_100_1 > Open[1] && myMA_100_1 < Close[1]) ||
         (myMA_50_1  > Open[1] && myMA_50_1  < Close[1] && myMA_200_1 > Open[1] && myMA_200_1 < Close[1]) ||
         (myMA_100_1 > Open[1] && myMA_100_1 < Close[1] && myMA_200_1 > Open[1] && myMA_200_1 < Close[1]) ||
         (myMA_20_1  < Open[3] && myMA_20_1  > Close[3] && myMA_50_1  < Open[3] && myMA_50_1  > Close[3]) ||
         (myMA_20_1  < Open[3] && myMA_20_1  > Close[3] && myMA_100_1 < Open[3] && myMA_100_1 > Close[3]) ||
         (myMA_20_1  < Open[3] && myMA_20_1  > Close[3] && myMA_200_1 < Open[3] && myMA_200_1 > Close[3]) ||
         (myMA_50_1  < Open[3] && myMA_50_1  > Close[3] && myMA_100_1 < Open[3] && myMA_100_1 > Close[3]) ||
         (myMA_50_1  < Open[3] && myMA_50_1  > Close[3] && myMA_200_1 < Open[3] && myMA_200_1 > Close[3]) ||
         (myMA_100_1 < Open[3] && myMA_100_1 > Close[3] && myMA_200_1 < Open[3] && myMA_200_1 > Close[3]))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(_close_at_key_level_EDS_MDS == true)
     {
      if(
         (Close[1] == myMA_20_1)  ||
         (Close[1] == myMA_50_1)  ||
         (Close[1] == myMA_100_1) ||
         (Close[1] == myMA_200_1) ||
         (Close[1] == Bands_MODE_MAIN_1) ||
         (Close[1] == Bands_down_1_1) ||
         (Close[1] == Bands_up_1_1)  ||
         (Close[1] == Bands_down_2_1) ||
         (Close[1] == Bands_up_2_1))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(Open[3] > Close[3] && Open[2] == Close[2] && Open[1] < Close[1] && Close[1] != High[1] && Close[1] != Open[3]   && Close[1] != Open[3]
      && ((Close[1] < Open[3]) || Close[1] > High[3]))
     {
      // // Up();
      if(enable_text == true)
        {
         MDS_b(arrow_name_up_MDS, time_up_EDS, price_up_MDS);
        }
      Send_Buy_Order("MDS");
      // Alert_Analys_type("Reversal-obj", "MDS", Analys_Color_Green, TextSize_Analys,262, 17 );
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_EDS()  // EDS SELL
  {
   int r;
   if(EDS_MDS == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(_outside_2_Dev_EDS_MDS == true)
     {
      if(Open[3] < Bands_up_2_3 && Close[3] > Bands_up_2_3 && Close[1] < Bands_up_2_1)
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(_Body_to_Wick_EDS_MDS == true)
     {
      if(Close[1] - Low[1] < (((Open[1] - Close[1])*_body_size_percent_EDS_MDS) / 100))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(_3rd_Huge_candle_EDS_MDS == true)
     {
      if(Open[1] - Close[1] <= ((Close[3] - Open[3])*_3rd_Huge_candle_size_EDS_MDS))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(_3rd_Tiny_candle_EDS_MDS == true)
     {
      if((Open[1] - Close[1])  > ((Close[3] -  Open[3]) / _3rd_Tiny_candle_size_EDS_MDS))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(_3rd_candle_body_breakout_EDS_MDS == true)
     {
      if(Close[1] < Low[2] && ((Open[1] - Close[1]) / 2) + Close[1] < Low[2])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(_close_at_key_level_EDS_MDS == true)
     {
      if(
         (Close[1] == myMA_20_1)  ||
         (Close[1] == myMA_50_1)  ||
         (Close[1] == myMA_100_1) ||
         (Close[1] == myMA_200_1) ||
         (Close[1] == Bands_MODE_MAIN_1) ||
         (Close[1] == Bands_down_1_1) ||
         (Close[1] == Bands_up_1_1)  ||
         (Close[1] == Bands_down_2_1) ||
         (Close[1] == Bands_up_2_1))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(_2_EMA_breakout_EDS_MDS == true)
     {
      if(
         (myMA_20_1  < Open[1] && myMA_20_1  > Close[1] && myMA_50_1  < Open[1] && myMA_50_1  > Close[1]) ||
         (myMA_20_1  < Open[1] && myMA_20_1  > Close[1] && myMA_100_1 < Open[1] && myMA_100_1 > Close[1]) ||
         (myMA_20_1  < Open[1] && myMA_20_1  > Close[1] && myMA_200_1 < Open[1] && myMA_200_1 > Close[1]) ||
         (myMA_50_1  < Open[1] && myMA_50_1  > Close[1] && myMA_100_1 < Open[1] && myMA_100_1 > Close[1]) ||
         (myMA_50_1  < Open[1] && myMA_50_1  > Close[1] && myMA_200_1 < Open[1] && myMA_200_1 > Close[1]) ||
         (myMA_100_1 < Open[1] && myMA_100_1 > Close[1] && myMA_200_1 < Open[1] && myMA_200_1 > Close[1]) ||
         (myMA_20_1  > Open[3] && myMA_20_1  < Close[3] && myMA_50_1  > Open[3] && myMA_50_1  < Close[3]) ||
         (myMA_20_1  > Open[3] && myMA_20_1  < Close[3] && myMA_100_1 > Open[3] && myMA_100_1 < Close[3]) ||
         (myMA_20_1  > Open[3] && myMA_20_1  < Close[3] && myMA_200_1 > Open[3] && myMA_200_1 < Close[3]) ||
         (myMA_50_1  > Open[3] && myMA_50_1  < Close[3] && myMA_100_1 > Open[3] && myMA_100_1 < Close[3]) ||
         (myMA_50_1  > Open[3] && myMA_50_1  < Close[3] && myMA_200_1 > Open[3] && myMA_200_1 < Close[3]) ||
         (myMA_100_1 > Open[3] && myMA_100_1 < Close[3] && myMA_200_1 > Open[3] && myMA_200_1 < Close[3]))
         return false;
     }
//------------------------------------------------+
   if(Open[3] <  Close[3] && Open[2] == Close[2] && Open[1] > Close[1]
      && Close[1] != Low[1] && Close[1] != Open[3] &&  Close[1] != (Close[3] - Open[3]) + Close[3] && Close[1] != Open[3]
      && ((Close[1] > Open[3]) || Close[1] < Low[3]))
     {
      // Don();
      if(enable_text == true)
        {
         EDS_s(arrow_name_down_EDS, time_down_EDS, price_down_EDS);
        }
      Send_Sell_Order("EDS");
      // Alert_Analys_type("Reversal-obj", "EDS", Analys_Color_Red, TextSize_Analys,  262, 17);
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+_ES_MS 0
//+------------------------------------------------------------------+
bool Check_Buy_Signal_MS()  // MS BUY
  {
   int r;
   if(ES_MS == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(ES_MS_outside_2_Dev_ES_MS == true)
     {
      if(Open[4] > Bands_down_2_4 && Close[4] < Bands_down_2_4 && Close[2] > Bands_down_2_2)
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_Body_to_Wick_ES_MS == true)
     {
      if(High[2] - Close[2] < (((Close[2] - Open[2])*ES_MS_body_size_percent_ES_MS) / 100))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_Huge_candle_ES_MS == true)
     {
      if(Close[2] - Open[2] <= ((Open[4] - Close[4])*ES_MS_3rd_Huge_candle_size_ES_MS))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_to_Middle_candle_raio_ES_MS == true)
     {
      if((((Open[3] > Close[3] || Open[3] == Close[3]) && Close[2] - Open[2] >= ((Open[3] - Close[3])*ES_MS_3rd_to_Middle_candle_size_ES_MS)) ||
          ((Open[3] < Close[3] || Open[3] == Close[3]) && Close[2] - Open[2] >= ((Close[3] - Open[3])*ES_MS_3rd_to_Middle_candle_size_ES_MS))))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_Tiny_candle_ES_MS == true)
     {
      if(Close[2] - Open[2]  >= ((Open[4] -  Close[4]) / ES_MS_3rd_Tiny_candle_size_ES_MS))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_candle_body_breakout_ES_MS == true)
     {
      if(Close[2] > High[3])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_candle_wick_breakout_ES_MS == true)
     {
      if(High[2] > High[3])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_2_EMA_breakout_ES_MS == true)
     {
      if(
         (myMA_20_2  > Open[2] && myMA_20_2  < Close[2] && myMA_50_2  > Open[2] && myMA_50_2  < Close[2]) ||
         (myMA_20_2  > Open[2] && myMA_20_2  < Close[2] && myMA_100_2 > Open[2] && myMA_100_2 < Close[2]) ||
         (myMA_20_2  > Open[2] && myMA_20_2  < Close[2] && myMA_200_2 > Open[2] && myMA_200_2 < Close[2]) ||
         (myMA_50_2  > Open[2] && myMA_50_2  < Close[2] && myMA_100_2 > Open[2] && myMA_100_2 < Close[2]) ||
         (myMA_50_2  > Open[2] && myMA_50_2  < Close[2] && myMA_200_2 > Open[2] && myMA_200_2 < Close[2]) ||
         (myMA_100_2 > Open[2] && myMA_100_2 < Close[2] && myMA_200_2 > Open[2] && myMA_200_2 < Close[2]) ||
         (myMA_20_2  < Open[4] && myMA_20_2  > Close[4] && myMA_50_2  < Open[4] && myMA_50_2  > Close[4]) ||
         (myMA_20_2  < Open[4] && myMA_20_2  > Close[4] && myMA_100_2 < Open[4] && myMA_100_2 > Close[4]) ||
         (myMA_20_2  < Open[4] && myMA_20_2  > Close[4] && myMA_200_2 < Open[4] && myMA_200_2 > Close[4]) ||
         (myMA_50_2  < Open[4] && myMA_50_2  > Close[4] && myMA_100_2 < Open[4] && myMA_100_2 > Close[4]) ||
         (myMA_50_2  < Open[4] && myMA_50_2  > Close[4] && myMA_200_2 < Open[4] && myMA_200_2 > Close[4]) ||
         (myMA_100_2 < Open[4] && myMA_100_2 > Close[4] && myMA_200_2 < Open[4] && myMA_200_2 > Close[4]))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(ES_MS_close_at_key_level_ES_MS == true)
     {
      if(
         (Close[2] == myMA_20_2)  ||
         (Close[2] == myMA_50_2)  ||
         (Close[2] == myMA_100_2) ||
         (Close[2] == myMA_200_2) ||
         (Close[2] == Bands_MODE_MAIN_1) ||
         (Close[2] == Bands_down_1_2) ||
         (Close[2] == Bands_up_1_2)  ||
         (Close[2] == Bands_down_2_2) ||
         (Close[2] == Bands_up_2_2))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(((Open[4] > Close[4] && Open[3] > Close[3] && Open[2] < Close[2] && Close[1] < Open[1] &&
        ((Open[3] - Close[3]) <= ((Open[4] - Close[4]) / ES_MS_middle_candle_size_ES_MS)) && Close[2] != Open[4] && (Close[2] < Open[4] || Close[2] > High[4]))
       ||
       (Open[4] > Close[4] && Open[3] == Close[3] && Open[2] < Close[2] && Close[1] < Open[1] && Close[2] != Open[4] && (Close[2] < Open[4] || Close[2] > High[4]))
       ||
       (Open[4] > Close[4] && Open[3] < Close[3] && Open[2] < Close[2] && Close[1] < Open[1] &&
        ((Close[3] - Open[3]) <= ((Open[4] - Close[4]) / ES_MS_middle_candle_size_ES_MS)) && Close[2] != Open[4] && (Close[2] < Open[4] || Close[2] > High[4])))
      &&
      ((Analys_EMA == 2 && Open[2] < Bands_down_1_2 && Close[2] > Bands_down_1_2)
       ||
       (Analys_EMA == 1 && ((Open[2] < Bands_up_1_2 &&  Close[2] > Bands_up_1_2) || (Open[2] < Bands_up_2_2 &&  Close[1] > Bands_up_2_2)))
       ||
       (Analys_EMA == 3  && Close[2] < Bands_up_1_2 && Close[2] > Bands_down_1_2))
      &&
      ((Close[1] == High[3] || Close[1] == Close[3] ||
        Close[1] ==  Bands_up_1_1   ||
        Close[1] ==  Bands_down_1_1 ||
        Close[1] ==  Bands_up_1_5_1 ||
        Close[1] ==  Bands_down_1_5_1 ||
        Close[1] ==  Bands_up_2_1 ||
        Close[1] ==  Bands_down_2_1 ||
        Close[1] ==  myMA_20_1 ||
        Close[1] ==  myMA_50_1 ||
        Close[1] ==  myMA_100_1 ||
        Close[1] ==  myMA_200_1 ||
        Close[1] == Bands_MODE_MAIN_1)) &&
      Close[1] >= Open[2])   //ریتریسمنت
     {
      // Up();
      if(enable_text == true)
        {
         MS_b(arrow_name_up_MS, time_up_MS, price_up_MS);
        }
      Send_Buy_Order("MS");
      //Alert_Analys_type("Reversal-obj", "MS", Analys_Color_Green, TextSize_Analys,  262, 17);
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_ES()  // ES SELL
  {
   int r;
   if(ES_MS == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(ES_MS_outside_2_Dev_ES_MS == true)
     {
      if(Open[4] < Bands_up_2_4 && Close[4] > Bands_up_2_4 && Close[2] < Bands_up_2_2)
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_Body_to_Wick_ES_MS == true)
     {
      if(Close[2] - Low[2] < (((Open[2] - Close[2])*ES_MS_body_size_percent_ES_MS) / 100))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_Huge_candle_ES_MS == true)
     {
      if(Open[2] - Close[2] <= ((Close[4] - Open[4])*ES_MS_3rd_Huge_candle_size_ES_MS))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_to_Middle_candle_raio_ES_MS == true)
     {
      if(((Open[3] > Close[3] || Open[3] == Close[3]) && Open[2] - Close[2] >= ((Open[3] - Close[3])*ES_MS_3rd_to_Middle_candle_size_ES_MS)) ||
         ((Open[3] < Close[3] || Open[3] == Close[3]) && Open[2] - Close[2] >= ((Close[3] - Open[3])*ES_MS_3rd_to_Middle_candle_size_ES_MS)))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_Tiny_candle_ES_MS == true)
     {
      if((Open[2] - Close[2])  > ((Close[4] -  Open[4]) / ES_MS_3rd_Tiny_candle_size_ES_MS))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_candle_body_breakout_ES_MS == true)
     {
      if(Close[2] < Low[3])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_candle_wick_breakout_ES_MS == true)
     {
      if(Low[2] < Low[3])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_close_at_key_level_ES_MS == true)
     {
      if(
         (Close[2] == myMA_20_2)  ||
         (Close[2] == myMA_50_2)  ||
         (Close[2] == myMA_100_2) ||
         (Close[2] == myMA_200_2) ||
         (Close[2] == Bands_MODE_MAIN_2) ||
         (Close[2] == Bands_down_1_2) ||
         (Close[2] == Bands_up_1_2)  ||
         (Close[2] == Bands_down_2_2) ||
         (Close[2] == Bands_up_2_2))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(ES_MS_2_EMA_breakout_ES_MS == true)
     {
      if(
         (myMA_20_2  < Open[2] && myMA_20_2  > Close[2] && myMA_50_2  < Open[2] && myMA_50_2  > Close[2]) ||
         (myMA_20_2  < Open[2] && myMA_20_2  > Close[2] && myMA_100_2 < Open[2] && myMA_100_2 > Close[2]) ||
         (myMA_20_2  < Open[2] && myMA_20_2  > Close[2] && myMA_200_2 < Open[2] && myMA_200_2 > Close[2]) ||
         (myMA_50_2  < Open[2] && myMA_50_2  > Close[2] && myMA_100_2 < Open[2] && myMA_100_2 > Close[2]) ||
         (myMA_50_2  < Open[2] && myMA_50_2  > Close[2] && myMA_200_2 < Open[2] && myMA_200_2 > Close[2]) ||
         (myMA_100_2 < Open[2] && myMA_100_2 > Close[2] && myMA_200_2 < Open[2] && myMA_200_2 > Close[2]) ||
         (myMA_20_2  > Open[4] && myMA_20_2  < Close[4] && myMA_50_2  > Open[4] && myMA_50_2  < Close[4]) ||
         (myMA_20_2  > Open[4] && myMA_20_2  < Close[4] && myMA_100_2 > Open[4] && myMA_100_2 < Close[4]) ||
         (myMA_20_2  > Open[4] && myMA_20_2  < Close[4] && myMA_200_2 > Open[4] && myMA_200_2 < Close[4]) ||
         (myMA_50_2  > Open[4] && myMA_50_2  < Close[4] && myMA_100_2 > Open[4] && myMA_100_2 < Close[4]) ||
         (myMA_50_2  > Open[4] && myMA_50_2  < Close[4] && myMA_200_2 > Open[4] && myMA_200_2 < Close[4]) ||
         (myMA_100_2 > Open[4] && myMA_100_2 < Close[4] && myMA_200_2 > Open[4] && myMA_200_2 < Close[4]))
         return false;
     }
//------------------------------------------------+
   if(((Open[4] <  Close[4] && Open[3] > Close[3] && Open[2] > Close[2] &&  Close[1] > Open[1] &&
        (Open[3] - Close[3] <= ((Close[4] - Open[4]) / ES_MS_middle_candle_size_ES_MS)) && Close[2] != Open[4] && (Close[2] > Open[4] || Close[2] < Low[4]))
       ||
       (Open[4] <  Close[4] && Open[3] == Close[3] && Open[2] > Close[2] &&  Close[1] > Open[1] && Close[2] != Open[4] && (Close[2] > Open[4] || Close[2] < Low[4]))
       ||
       (Open[4] <  Close[4] && Open[3] < Close[3] && Open[2] > Close[2] && Close[1] > Open[1] &&
        (Close[3] - Open[3] <= ((Close[4] - Open[4]) / ES_MS_middle_candle_size_ES_MS)) && Close[2] != Open[4] && (Close[2] > Open[4] || Close[2] < Low[4])))
      &&
      ((Analys_EMA == 2 && Open[2] > Bands_down_1_2 && Close[2] < Bands_down_1_2)
       ||
       (Analys_EMA == 1 && ((Open[2] > Bands_down_1_2 &&  Close[2] < Bands_down_1_2) || (Open[2] > Bands_down_2_2 &&  Close[2] < Bands_down_2_2)))
       ||
       (Analys_EMA == 3  && Close[2] < Bands_up_1_2 && Close[2] > Bands_down_1_2))
      &&
      ((Close[1] == Low[3] || Close[1] == Close[3] ||
        Close[1] ==  Bands_up_1_1   ||
        Close[1] ==  Bands_down_1_1 ||
        Close[1] ==  Bands_up_1_5_1 ||
        Close[1] ==  Bands_down_1_5_1 ||
        Close[1] ==  Bands_up_2_1 ||
        Close[1] ==  Bands_down_2_1 ||
        Close[1] ==  myMA_20_1 ||
        Close[1] ==  myMA_50_1 ||
        Close[1] ==  myMA_100_1 ||
        Close[1] ==  myMA_200_1 ||
        Close[1] == Bands_MODE_MAIN_1)) &&
      Close[1] <= Open[2])   //ریتریسمنت
     {
      // Don();
      if(enable_text == true)
        {
         ES_s(arrow_name_down_ES, time_down_ES, price_down_ES);
        }
      Send_Sell_Order("ES");
      // Alert_Analys_type("Reversal-obj", "ES", Analys_Color_Red, TextSize_Analys,262, 17);
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+_ES_MS 1
//+------------------------------------------------------------------+
bool Check_Buy_Signal_MS_1()  // MS 1 BUY
  {
   int r;
   if(ES_MS == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(ES_MS_outside_2_Dev_ES_MS == true)
     {
      if(Open[3] > Bands_down_2_3 && Close[3] < Bands_down_2_3 && Close[1] > Bands_down_2_1)
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_Body_to_Wick_ES_MS == true)
     {
      if(High[1] - Close[1] < (((Close[1] - Open[1])*ES_MS_body_size_percent_ES_MS) / 100))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_Huge_candle_ES_MS == true)
     {
      if(Close[1] - Open[1] <= ((Open[3] - Close[3])*ES_MS_3rd_Huge_candle_size_ES_MS))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_to_Middle_candle_raio_ES_MS == true)
     {
      if(((((Open[2] > Close[2]) || (Open[2] == Close[2])) && ((Close[1] - Open[1]) >= ((Open[2] - Close[2])*ES_MS_3rd_to_Middle_candle_size_ES_MS))) ||
          (((Open[2] < Close[2]) || (Open[2] == Close[2])) && ((Close[1] - Open[1]) >= ((Close[2] - Open[2])*ES_MS_3rd_to_Middle_candle_size_ES_MS)))))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_Tiny_candle_ES_MS == true)
     {
      if(Close[1] - Open[1]  >= ((Open[3] -  Close[3]) / ES_MS_3rd_Tiny_candle_size_ES_MS))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_candle_body_breakout_ES_MS == true)
     {
      if(Close[1] > High[2])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_candle_wick_breakout_ES_MS == true)
     {
      if(High[1] > High[2])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_2_EMA_breakout_ES_MS == true)
     {
      if(
         (myMA_20_1  > Open[1] && myMA_20_1  < Close[1] && myMA_50_1  > Open[1] && myMA_50_1  < Close[1]) ||
         (myMA_20_1  > Open[1] && myMA_20_1  < Close[1] && myMA_100_1 > Open[1] && myMA_100_1 < Close[1]) ||
         (myMA_20_1  > Open[1] && myMA_20_1  < Close[1] && myMA_200_1 > Open[1] && myMA_200_1 < Close[1]) ||
         (myMA_50_1  > Open[1] && myMA_50_1  < Close[1] && myMA_100_1 > Open[1] && myMA_100_1 < Close[1]) ||
         (myMA_50_1  > Open[1] && myMA_50_1  < Close[1] && myMA_200_1 > Open[1] && myMA_200_1 < Close[1]) ||
         (myMA_100_1 > Open[1] && myMA_100_1 < Close[1] && myMA_200_1 > Open[1] && myMA_200_1 < Close[1]) ||
         (myMA_20_1  < Open[3] && myMA_20_1  > Close[3] && myMA_50_1  < Open[3] && myMA_50_1  > Close[3]) ||
         (myMA_20_1  < Open[3] && myMA_20_1  > Close[3] && myMA_100_1 < Open[3] && myMA_100_1 > Close[3]) ||
         (myMA_20_1  < Open[3] && myMA_20_1  > Close[3] && myMA_200_1 < Open[3] && myMA_200_1 > Close[3]) ||
         (myMA_50_1  < Open[3] && myMA_50_1  > Close[3] && myMA_100_1 < Open[3] && myMA_100_1 > Close[3]) ||
         (myMA_50_1  < Open[3] && myMA_50_1  > Close[3] && myMA_200_1 < Open[3] && myMA_200_1 > Close[3]) ||
         (myMA_100_1 < Open[3] && myMA_100_1 > Close[3] && myMA_200_1 < Open[3] && myMA_200_1 > Close[3]))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(ES_MS_close_at_key_level_ES_MS == true)
     {
      if(
         (Close[1] == myMA_20_1)  ||
         (Close[1] == myMA_50_1)  ||
         (Close[1] == myMA_100_1) ||
         (Close[1] == myMA_200_1) ||
         (Close[1] == Bands_MODE_MAIN_1) ||
         (Close[1] == Bands_down_1_1) ||
         (Close[1] == Bands_up_1_1)  ||
         (Close[1] == Bands_down_2_1) ||
         (Close[1] == Bands_up_2_1))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(((Open[3] > Close[3] && Open[2] > Close[2] && Open[1] < Close[1] && ((Open[2] - Close[2]) <= ((Open[3] - Close[3]) / ES_MS_middle_candle_size_ES_MS)) && Close[1] != Open[3] &&
        (Close[1] < Open[3] || Close[1] > High[3]))
       ||
       (Open[3] > Close[3] && Open[2] == Close[2] && Open[1] < Close[1] && Close[1] != Open[3] && (Close[1] < Open[3] || Close[1] > High[3]))
       ||
       (Open[3] > Close[3] && Open[2] < Close[2] && Open[1] < Close[1] && ((Close[2] - Open[2]) <= ((Open[3] - Close[3]) / ES_MS_middle_candle_size_ES_MS)) && Close[1] != Open[3] &&
        (Close[1] < Open[3] || Close[1] > High[3])))
      &&
      ((Open[3] > myMA_20_3 && Close[3] < myMA_20_3 && Open[1] < myMA_20_1  && Close[1] > myMA_20_1) ||
       (Open[3] > myMA_50_3 && Close[3] < myMA_50_3 && Open[1] < myMA_50_1  && Close[1] > myMA_50_1) ||
       (Open[3] > myMA_100_3 && Close[3] < myMA_100_3 && Open[1] < myMA_100_1  && Close[1] > myMA_100_1) ||
       (Open[3] > myMA_200_3 && Close[3] < myMA_200_3 && Open[1] < myMA_200_1  && Close[1] > myMA_200_1) ||
       (Open[3] > Bands_up_1_3 && Close[3] < Bands_up_1_3 && Open[1] < Bands_up_1_1  && Close[1] > Bands_up_1_1) ||
       (Open[3] > Bands_down_1_3 && Close[3] < Bands_down_1_3 && Open[1] < Bands_down_1_1  && Close[1] > Bands_down_1_1) ||
       (Open[3] > Bands_up_2_3 && Close[3] < Bands_up_2_3 && Open[1] < Bands_up_2_1  && Close[1] > Bands_up_2_1) ||
       (Open[3] > Bands_down_2_3 && Close[3] < Bands_down_2_3 && Open[1] < Bands_down_2_1  && Close[1] > Bands_down_2_1) ||
       (Open[3] > Bands_MODE_MAIN_3 && Close[3] < Bands_MODE_MAIN_3 && Open[1] < Bands_MODE_MAIN_1  && Close[1] > Bands_MODE_MAIN_1))
      &&  Analys_EMA == 1)
     {
      // // Up();
      if(enable_text == true)
        {
         MS_b_1(arrow_name_up_MS_1, time_up_MS_1, price_up_MS_1);
        }
      Send_Buy_Order("MS");
      // Alert_Analys_type("Reversal-obj", "MS", Analys_Color_Green, TextSize_Analys,  makan_y, makan_x * 20);
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+ES50 MS50
//+------------------------------------------------------------------+
bool Check_Buy_Signal_ES50()  // ES50 BUY
  {
   int r;
   if(ES_50_MS_50 == true)
     {
      r = 1;
     }
   else
      return false;
   if(((Open[2] < Close[2]  && Open[1] <  Close[1] && Open[0] > Close[0] && Close[1] - Open[1]  <= ((Close[2] - Open[2]) / EMs_at_50_middle_candle_size_EMS_50) && Close[0] < Open[1] && Close[0] == ((((Close[2] - Open[2]) * 50) / 100) + Open[2]) && Low[1] > Low[0]) ||
       (Open[2] < Close[2]  && Open[1] == Close[1] && Open[0] > Close[0] && Close[0] < Open[1] && Close[0] == ((((Close[2] - Open[2]) * 50) / 100) + Open[2]) && Low[1] > Low[0]) ||
       (Open[2]  < Close[2] && Open[1] >  Close[1] && Open[0] > Close[0] && Open[1]  - Close[1] <= ((Close[2] - Open[2]) / EMs_at_50_middle_candle_size_EMS_50) && Close[0] < Open[1] && Close[0] == ((((Close[2] - Open[2]) * 50) / 100) + Open[2]) && Low[1] >= Low[0])))
     {
      Alert_wait_type(" ES_50 ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
      time_wait_buy = Time[0];// GetLine_Buy();
     }
   if(time_wait_buy == Time[1])
     {
      ObjectDelete("wait_signal");
      //GetLine_Sell();
     }
//----//---
   if(((Open[3] < Close[3] && Open[2] < Close[2] && Open[1] > Close[1]/* && Close[2] - Open[2]  <= ((Close[3] - Open[3]) / EMs_at_50_middle_candle_size_EMS_50)*/ && Close[1] < Open[2] && Close[1] == ((((Close[3] - Open[3]) * 50) / 100) + Open[3]) && Low[2] > Low[1])
       ||
       (Open[3] < Close[3] && Open[2] == Close[2] && Open[1] > Close[1] && Close[1] < Open[2] && Close[1] == ((((Close[3] - Open[3]) * 50) / 100) + Open[3]) && Low[2] > Low[1])
       ||
       (Open[3] < Close[3] && Open[2] > Close[2] && Open[1] > Close[1]/* && Open[2]  - Close[2] <= ((Close[3] - Open[3]) / EMs_at_50_middle_candle_size_EMS_50)*/ && Close[1] < Open[2] && Close[1] == ((((Close[3] - Open[3]) * 50) / 100) + Open[3]) && Low[2] >= Low[1]))
      &&
      (
// (Analys_EMA == 1 && Close[1] > Bands_up_1_1) ||
// (Analys_EMA == 3 && Close[1] > Bands_up_1_1) ||
// (Analys_EMA == 3 && High[1]  > Bands_up_2_1 && Low[1] < Bands_up_2_1) ||
// (Analys_EMA == 2 && Close[1] > Bands_MODE_MAIN_1 && Close[1] - Low[1] > (Open[1] - Close[1]) /2) ||
// (Analys_EMA == 3 && Close[1] > Bands_up_1_1 && Open[1] > Bands_up_2_1 && Close[1] < Bands_up_2_1) ||
// (Analys_EMA == 3 && Close[1] > Bands_MODE_MAIN_1 && Close[1] < High[iHighest(NULL, 0, MODE_HIGH, 5, 1)] &&  Close[1] > Low[iLowest(NULL, 0, MODE_LOW, 5, 1)]) ||
//
//(Analys_EMA == 1 && Close[1] > Bands_up_1_1) // ||    /// کال 1 جدید es50 1  ok
// (Analys_EMA == 1 && Close[1] > Bands_up_1_1 && Close[1] != Low[1] && Close[1] - Low[1] > ((Open[1] - Close[1]) / 2))// ||   /// جدید کال 2  es50 2 ok
// (Analys_EMA == 3 && Close[1] < Bands_MODE_MAIN_1 && Close[1] ==  Bands_down_1_1)// ||  /// جدید کال 3 ES503 OK
         (Analys_EMA == 1 && Close[1] > Bands_up_1_1 && High[1] != Open[1] && High[1] > High[2] && High[2] != MathMax(Open[2], Close[2]) && High[1] - Open[1] > High[2] - MathMax(Open[2], Close[2])) //||    ///  کال 4 جدید
// (Analys_EMA == 1 && Close[1] == Bands_up_1_1)
      ))   /// کال 5 جدید
     {
      // // Up();
      if(enable_text == true)
        {
         ES50_b(arrow_name_up_ES50, time_up_ES50, price_up_ES50);
        }
      Send_Buy_Order("ES50");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }

//+------------------------------------------------------------------+
bool Check_Sell_Signal_MS50()  // MS50 sell
  {
   int r;
   if(ES_50_MS_50 == true)
     {
      r = 1;
     }
   else
      return false;
   if(((Open[2] > Close[2] && Open[1] >  Close[1] && Open[0] < Close[0] && Open[1]  - Close[1] <= ((Open[2] - Close[2]) / EMs_at_50_middle_candle_size_EMS_50) && Close[0] > Open[1] && Close[0] == ((((Open[2] - Close[2]) * 50) / 100) + Close[2])  && High[1] < High[0])
       ||
       (Open[2] > Close[2] && Open[1] == Close[1] && Open[0] < Close[0] && Close[0] > Open[1] && Close[0] == ((((Open[2] - Close[2]) * 50) / 100) + Close[2])  && High[1] < High[0])
       ||
       (Open[2] > Close[2] && Open[1] <  Close[1] && Open[0] < Close[0] && Close[1] - Open[1]  <= ((Open[2] - Close[2]) / EMs_at_50_middle_candle_size_EMS_50) && Close[0] > Open[1] && Close[0] == ((((Open[2] - Close[2]) * 50) / 100) + Close[2]) && High[1] < High[0])))
     {
      Alert_wait_type(" EMS_50 ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
      time_wait_sell = Time[0];  // GetLine_Buy();
     }
   if(time_wait_sell == Time[1])
     {
      ObjectDelete("wait_signal");
      // GetLine_Sell();
     }
//----
//---
   if(((Open[3] > Close[3] && Open[2] >  Close[2] && Open[1] < Close[1] /*&& Open[2] - Close[2] <= ((Open[3] - Close[3]) / EMs_at_50_middle_candle_size_EMS_50)*/ && Close[1] > Open[2] && Close[1] == ((((Open[3] - Close[3]) * 50) / 100) + Close[3])  && High[2] < High[1])
       ||
       (Open[3] > Close[3] && Open[2] == Close[2] && Open[1] < Close[1] && Close[1] > Open[2] && Close[1] == ((((Open[3] - Close[3]) * 50) / 100) + Close[3])  && High[2] < High[1])
       ||
       (Open[3] > Close[3] && Open[2] <  Close[2] && Open[1] < Close[1] /*&& Close[2] - Open[2] <= ((Open[3] - Close[3]) / EMs_at_50_middle_candle_size_EMS_50)*/ && Close[1] > Open[2] && Close[1] == ((((Open[3] - Close[3]) * 50) / 100) + Close[3]) && High[2] < High[1]))
      &&
      (
//(Analys_EMA == 2 && Close[1] < Bands_down_1_1) ||
////  (Analys_EMA == 3 && Close[1] < Bands_down_1_1) ||
// (Analys_EMA == 3 && Close[1] > Bands_up_2_1 && Open[1] < Bands_up_2_1) ||
// (Analys_EMA == 1 && Close[1] < Bands_MODE_MAIN_1 && High[1] - Close[1] > (Close[1] - Open[1]) /2) ||
// (Analys_EMA == 3 && Open[1]  < Bands_MODE_MAIN_1 && Close[1] > Bands_MODE_MAIN_1) ||
//(Analys_EMA == 3 && Close[1] < Bands_MODE_MAIN_1 &&  Close[1] < High[iHighest(NULL, 0, MODE_HIGH, 5, 1)] &&  Close[1] > Low[iLowest(NULL, 0, MODE_LOW, 5, 1)]) ||
//
// (Analys_EMA == 2 && Close[1] < Bands_down_1_1)// ||    /// کال 1 جدید  ms50 1 ok
//(Analys_EMA == 1 && Close[1] > Bands_up_1_1 && Close[1] != Low[1] && Close[1] - Low[1] > ((Open[1] - Close[1]) / 2)) //||   /// جدید کال 2
// (Analys_EMA == 3 && Close[1] != Low[1] && Close[1] - Low[1] > ((Open[1] - Close[1]) / 2) && Close[1] < Bands_MODE_MAIN_1 && Close[1] ==  Bands_down_1_1) ||  /// جدید کال 3
// (Analys_EMA == 1 && Close[1] > Bands_up_1_1 && High[1] != Open[1] && High[1] > High[2] && High[2] != MathMax(Open[2],Close[2]) && High[1] - Open[1] > High[2] - MathMax(Open[2],Close[2])) ||    ///  کال 4 جدید
// (Analys_EMA == 1 && Close[1] == Bands_up_1_1)
// ))  /// کال 5 جدید
// (Analys_EMA == 2 && Close[1] < Bands_down_1_1) //||    /// کال 1 جدید  ms50 1 ok
// (Analys_EMA == 2 && Close[1] < Bands_down_1_1 && Close[1] != High[1] && High[1] - Close[1] > ((Close[1] - Open[1]) / 2)) //||   /// جدید کال 2 ms50 2 ok
// (Analys_EMA == 3 && Close[1] > Bands_MODE_MAIN_1 && Close[1] ==  Bands_up_1_1)// ||  /// جدید کال 3 MS503 OK
         (Analys_EMA == 2 && Close[1] < Bands_down_1_1 && Low[1] != Open[1] && Low[1] < Low[2] && Low[2] != MathMin(Open[2], Close[2]) && Open[1] - Low[1] > MathMin(Open[2], Close[2]) - Low[2]) //||    ///  کال 4 جدید
// (Analys_EMA == 2 && Close[1] == Bands_down_1_1)
      ))  /// کال 5 جدید
     {
      // Don();
      if(enable_text == true)
        {
         MS50_s(arrow_name_down_MS50, time_down_MS50, price_down_MS50);
        }
      Send_Sell_Order("MS50");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }

//+------------------------------------------------------------------+EES EMS Equal
//+------------------------------------------------------------------+
bool Check_Buy_Signal_EES_Equal() // EES Buy
  {
   int r;
   if(EMS_Equal == true)
     {
      r = 1;
     }
   else
      return false;
   if(((Open[2] <  Close[2] && Open[1] > Close[1] && Open[0] > Close[0] && (Open[1] - Close[1] <= ((Close[2] - Open[2]) / Equal_middle_candle_size_EMS_Equal))  && (Close[0] == Open[2]) && Low[1] > Low[0] && Low[2] > Low[0]) ||
       (Open[2] <  Close[2] && Open[1] == Close[1] && Open[0] > Close[0] && (Close[0] == Open[2]) && Low[1] > Low[0] && Low[2] > Low[0]) ||
       (Open[2] <  Close[2] && Open[1] < Close[1] && Open[0] > Close[0] && (Close[1] - Open[1] <= ((Close[2] - Open[2]) / Equal_middle_candle_size_EMS_Equal))  && (Close[0] == Open[2]))) && Low[1] > Low[0] && Low[2] > Low[0])
     {
      Alert_wait_type(" EES ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
      time_wait_buy = Time[0];
      // GetLine_Buy();
     }
   if(time_wait_buy == Time[1])
     {
      ObjectDelete("wait_signal");
      // GetLine_Sell();
     }
//----//---
//---
   if(((Open[3] < Close[3] && Open[2] > Close[2] && Open[1] > Close[1] && (Open[2] - Close[2] <= ((Close[3] - Open[3]) / Equal_middle_candle_size_EMS_Equal)) && (Close[1] == Open[3]) && Low[2] > Low[1])
       ||
       (Open[3] < Close[3] && Open[2] == Close[2] && Open[1] > Close[1] && (Close[1] == Open[3]) && Low[2] > Low[1])
       ||
       (Open[3] < Close[3] && Open[2] < Close[2] && Open[1] > Close[1] && (Close[2] - Open[2] <= ((Close[3] - Open[3]) / Equal_middle_candle_size_EMS_Equal))  && (Close[1] == Open[3]) && Low[2] > Low[1])) &&
      (
         (Analys_EMA == 3 && Open[1]  > Bands_down_2_1 && Close[1] < Bands_down_2_1) ||
         (Analys_EMA == 2 && Close[1] > Bands_MODE_MAIN_1 && Close[1] - Low[1] > (Open[1] - Close[1] / 2)) ||
         (Analys_EMA == 3 && Open[1]  > Bands_MODE_MAIN_1 && Close[1] < Bands_MODE_MAIN_1) ||
         (Analys_EMA == 3 && Close[1] > Bands_MODE_MAIN_1 && Close[1] < High[iHighest(NULL, 0, MODE_HIGH, 5, 1)] && Close[1] > Low[iLowest(NULL, 0, MODE_LOW, 5, 1)]) ||
//
         (Analys_EMA == 1 && Close[1] > Bands_up_1_1) ||    /// کال 1 جدید
         (Analys_EMA == 1 && Close[1] > Bands_up_1_1 && Close[1] != Low[1] && Close[1] - Low[1] > ((Open[1] - Close[1]) / 2)) ||   /// جدید کال 2
         (Analys_EMA == 3 && Close[1] != Low[1] && Close[1] - Low[1] > ((Open[1] - Close[1]) / 2) && Close[1] < Bands_MODE_MAIN_1 && Close[1] ==  Bands_down_1_1) ||  /// جدید کال 3
         (Analys_EMA == 1 && Close[1] > Bands_up_1_1 && High[1] != Open[1] && High[1] > High[2] && High[2] != MathMax(Open[2], Close[2]) && High[1] - Open[1] > High[2] - MathMax(Open[2], Close[2])) ||  ///  کال 4 جدید
         (Analys_EMA == 1 && Close[1] == Bands_up_1_1)
      ))   /// کال 5 جدید
     {
      // Up();
      if(enable_text == true)
        {
         EES_Equal_b(arrow_name_up_EES_Equal, time_up_EES_Equal, price_up_EES_Equal);
        }
      Send_Buy_Order("EES");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+EMS_Equal
bool Check_Sell_Signal_EMS_Equal() // EMS Sell
  {
   int r;
   if(EMS_Equal == true)
     {
      r = 1;
     }
   else
      return false;
   if((Open[2] > Close[2] && Open[1] >  Close[1] && Open[0] < Close[0] && Open[1] - Close[1] <= ((Open[2] - Close[2]) / Equal_middle_candle_size_EMS_Equal) && Close[0] == Open[2] && High[1] < High[0]) ||
      (Open[2] > Close[2] && Open[1] == Close[1] && Open[0] < Close[0] && Close[0] == Open[2] && High[1] < High[0]) ||
      (Open[2] > Close[2] && Open[1] <  Close[1] && Open[0] < Close[0] && Close[1] - Open[1] <= ((Open[2] - Close[2]) / Equal_middle_candle_size_EMS_Equal) && Close[0] == Open[2] && High[1] < High[0]))
     {
      Alert_wait_type(" EMS ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
      time_wait_sell = Time[0]; // GetLine_Buy();
     }
   if(time_wait_sell == Time[1])
     {
      ObjectDelete("wait_signal");
      // GetLine_Sell();
     }
//----
//---
   if(((Open[3] > Close[3] && Open[2] > Close[2] && Open[1] < Close[1] && (Open[2] - Close[2] <= ((Open[3] - Close[3]) / Equal_middle_candle_size_EMS_Equal)) && Close[1] == Open[3] && High[2] < High[1])
       ||
       (Open[3] > Close[3] && Open[2] == Close[2] && Open[1] < Close[1] && Close[1] == Open[3] && High[2] < High[1])
       ||
       (Open[3] > Close[3] && Open[2] < Close[2] && Open[1] < Close[1] && Close[2] - Open[2] <= ((Open[3] - Close[3]) / Equal_middle_candle_size_EMS_Equal) && Close[1] == Open[3] && High[2] < High[1])) &&
      (
         (Analys_EMA == 2 && Close[1] < Bands_down_1_1) ||
         (Analys_EMA == 3 && Close[1] < Bands_down_1_1) ||
         (Analys_EMA == 3 && Close[1] > Bands_up_2_1 && Open[1] < Bands_up_2_1) ||
         (Analys_EMA == 1 && Close[1] < Bands_MODE_MAIN_1 && High[1] - Close[1] > (Close[1] - Open[1] / 2)) ||
         (Analys_EMA == 3 &&  Open[1] < Bands_MODE_MAIN_1 && Close[1] > Bands_MODE_MAIN_1) ||
         (Analys_EMA == 3 && Close[1] < Bands_MODE_MAIN_1 &&  Close[1] < High[iHighest(NULL, 0, MODE_HIGH, 5, 1)] &&  Close[1] > Low[iLowest(NULL, 0, MODE_LOW, 5, 1)]) ||
//
         (Analys_EMA == 2 && Close[1] < Bands_down_1_1) ||    /// کال 1 جدید
         (Analys_EMA == 2 && Close[1] < Bands_down_1_1 && Close[1] != High[1] && High[1] - Close[1] > ((Close[1] - Open[1]) / 2)) ||   /// جدید کال 2
         (Analys_EMA == 3 && Close[1] != High[1] &&  Close[1] != High[1] && High[1] - Close[1] > ((Close[1] - Open[1]) / 2) && Close[1] < Bands_MODE_MAIN_1 && Close[1] ==  Bands_down_1_1) ||  /// جدید کال 3
         (Analys_EMA == 2 && Close[1] < Bands_down_1_1 && Low[1] != Open[1] && Low[1] < Low[2] && Low[2] != MathMin(Open[2], Close[2]) && Open[1] - Low[1] > MathMin(Open[2], Close[2]) - Low[2]) ||  ///  کال 4 جدید
         (Analys_EMA == 2 && Close[1] == Bands_down_1_1)
      ))  /// کال 5 جدید
     {
      // Don();
      if(enable_text == true)
        {
         EMS_Equal_s(arrow_name_down_EMS_Equal, time_down_EMS_Equal, price_down_EMS_Equal);
        }
      Send_Sell_Order("EMS");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+ EMS_Equal_1
bool Check_Buy_Signal_EMS_Equal_1() // EMS 1 Buy
  {
   int r;
   if(EMS_Equal == true)
     {
      r = 1;
     }
   else
      return false;
   if((Open[2] > Close[2] && Open[1]  > Close[1] && Open[0] < Close[0] && Open[1] - Close[1] <= ((Open[2] - Close[2]) / Equal_middle_candle_size_EMS_Equal) && Close[0] == Open[2] && High[1] < High[0]) ||
      (Open[2] > Close[2] && Open[1] == Close[1] && Open[0] < Close[0] && Close[0] == Open[2] && High[1] < High[0]) ||
      (Open[2] > Close[2] && Open[1] <  Close[1] && Open[0] < Close[0] && Close[1] - Open[1] <= ((Open[2] - Close[2]) / Equal_middle_candle_size_EMS_Equal) && Close[0] == Open[2] && High[1] < High[0]))
     {
      Alert_wait_type(" EMS ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
      time_wait_sell = Time[0]; // GetLine_Buy();
     }
   if(time_wait_sell == Time[1])
     {
      ObjectDelete("wait_signal");
      // GetLine_Sell();
     }
//----
//---
   if(((Open[3] > Close[3] && Open[2] > Close[2] && Open[1] < Close[1] && Open[2] - Close[2] <= ((Open[3] - Close[3]) / Equal_middle_candle_size_EMS_Equal) &&
        Close[1] == Open[3] && High[2] < High[1])
       ||
       (Open[3] > Close[3] && Open[2] == Close[2] && Open[1] < Close[1] && Close[1] == Open[3] && High[2] < High[1])
       ||
       (Open[3] > Close[3] && Open[2] < Close[2] && Open[1] < Close[1] && Close[2] - Open[2] <= ((Open[3] - Close[3]) / Equal_middle_candle_size_EMS_Equal) &&
        Close[1] == Open[3] && High[2] < High[1])) &&
      (
         (Analys_EMA == 1 && Close[1] > Bands_up_1_1) ||
         (Analys_EMA == 3 && Close[1] > Bands_up_1_1) ||
         (Analys_EMA == 3 && Open[1] > Bands_down_2_1 && Close[1] < Bands_down_2_1) ||
         (Analys_EMA == 2 && Close[1] > Bands_MODE_MAIN_1 && Close[1] - Low[1] > (Open[1] - Close[1] / 2)) ||
         (Analys_EMA == 3 && Open[1] > Bands_MODE_MAIN_1 && Close[1] < Bands_MODE_MAIN_1) ||
         (Analys_EMA == 3 && Close[1] > Bands_MODE_MAIN_1 && Close[1] < High[iHighest(NULL, 0, MODE_HIGH, 5, 1)] && Close[1] > Low[iLowest(NULL, 0, MODE_LOW, 5, 1)]) ||
//
         (Analys_EMA == 1 && Close[1] > Bands_up_1_1 && Open[1] < Bands_up_1_1 && Close[1] > Bands_up_1_1 &&  Open[3] > Bands_up_1_3 && Close[3] < Bands_up_1_3) || /// پوت 1 جدید
         (Analys_EMA == 3 && (Low[1] <= Bands_down_2_1 || Low[2] <= Bands_down_2_2 || Low[3] <= Bands_down_2_3) && Close[1] > Bands_down_2_1 && Close[1] < Bands_down_1_1) || // پوت 2 جدید
         ((Analys_EMA == 2 || Analys_EMA == 3) && Find_Analys_0 == 0 &&  Open[1] < Bands_down_1_1 && Close[1] > Bands_down_1_1  &&  Open[3] > Bands_down_1_3 && Close[3] < Bands_down_1_3)))  // پوت 3 جدید
     {
      // UP();
      if(enable_text == true)
        {
         EMS_Equal_b_1(arrow_name_up_EMS_Equal_1, time_up_EMS_Equal_1, price_up_EMS_Equal_1);
        }
      Send_Buy_Order("EMS");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }

//+------------------------------------------------------------------+_EMS_Equal
bool Check_Sell_Signal_EES_Equal_1() // EES 1 Sell
  {
   int r;
   if(EMS_Equal == true)
     {
      r = 1;
     }
   else
      return false;
   if(((Open[2] <  Close[2] && Open[1] > Close[1] && Open[0] > Close[0] && (Open[1] - Close[1] <= ((Close[2] - Open[2]) / Equal_middle_candle_size_EMS_Equal))  && (Close[0] == Open[2]) && Low[1] > Low[0]) ||
       (Open[2] <  Close[2] && Open[1] == Close[1] && Open[0] > Close[0] && Close[0] == Open[2] && Low[1] > Low[0]) ||
       (Open[2] <  Close[2] && Open[1] < Close[1] && Open[0] > Close[0] && (Close[1] - Open[1] <= ((Close[2] - Open[2]) / Equal_middle_candle_size_EMS_Equal))  && (Close[0] == Open[2]))) && Low[1] > Low[0])
     {
      Alert_wait_type(" EES ", Text_ColorBuy, TextSize_wait, y_wait, x_wait);
      time_wait_buy = Time[0];// GetLine_Buy();
     }
   if(time_wait_buy == Time[1])
     {
      ObjectDelete("wait_signal");
      // GetLine_Sell();
     }
//----//---
//---
   if(((Open[3] <  Close[3] && Open[2] > Close[2] && Open[1] > Close[1] && (Open[2] - Close[2] <= ((Close[3] - Open[3]) / Equal_middle_candle_size_EMS_Equal)) && (Close[1] == Open[3]) && Low[2] > Low[1]) ||
       (Open[3] <  Close[3] && Open[2] == Close[2] && Open[1] > Close[1] && (Close[1] == Open[3]) && Low[2] > Low[1]) ||
       (Open[3] <  Close[3] && Open[2] < Close[2] && Open[1] > Close[1] && (Close[2] - Open[2] <= ((Close[3] - Open[3]) / Equal_middle_candle_size_EMS_Equal))  && (Close[1] == Open[3]) && Low[2] > Low[1])) &&
      (
         (Analys_EMA == 2 && Close[1] < Bands_down_1_1) ||
         (Analys_EMA == 3 && Close[1] < Bands_down_1_1) ||
         (Analys_EMA == 3 && Close[1] > Bands_up_2_1 && Open[1] < Bands_up_2_1) ||
         (Analys_EMA == 1 && Close[1] < Bands_down_2_1) || // ok
         (Analys_EMA == 3 && Open[1]  < Bands_MODE_MAIN_1 && Close[1] > Bands_MODE_MAIN_1) ||
         (Analys_EMA == 3 && Close[1] < Bands_MODE_MAIN_1 && Close[1] < High[iHighest(NULL, 0, MODE_HIGH, 5, 1)] &&  Close[1] > Low[iLowest(NULL, 0, MODE_LOW, 5, 1)]) ||
//
         (Analys_EMA == 2 && Close[1] < Bands_down_1_1 && Open[1] > Bands_down_1_1 && Close[1] < Bands_down_1_1 &&  Open[3] < Bands_down_1_3 && Close[3] > Bands_down_1_3) || /// پوت 1 جدید
         (Analys_EMA == 3 && (High[1] >= Bands_up_2_1 || High[2] >= Bands_up_2_2 || High[3] >= Bands_up_2_3) && Close[1] < Bands_up_2_1 && Close[1] > Bands_up_1_1) || // پوت 2 جدید
         ((Analys_EMA == 1 || Analys_EMA == 3) && Find_Analys_0 == 1 &&  Open[1] > Bands_up_1_1 && Close[1] < Bands_up_1_1  &&  Open[3] < Bands_up_1_3 && Close[3] > Bands_up_1_3)))  // پوت 3 جدید
     {
      if(enable_text == true)
        {
         EES_Equal_s_1(arrow_name_down_EES_Equal_1, time_down_EES_Equal_1, price_down_EES_Equal_1);
        }
      Send_Sell_Order("EES");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }




//+------------------------------------------------------------------+
bool Check_Sell_Signal_ES_1()  // ES 1 sell
  {
   int r;
   if(ES_MS == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(ES_MS_outside_2_Dev_ES_MS == true)
     {
      if(Open[3] < Bands_up_2_3 && Close[3] > Bands_up_2_3 && Close[1] < Bands_up_2_1)
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_Body_to_Wick_ES_MS == true)
     {
      if(Close[1] - Low[1] < (((Open[1] - Close[1])*ES_MS_body_size_percent_ES_MS) / 100))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_Huge_candle_ES_MS == true)
     {
      if(Open[1] - Close[1] <= ((Close[3] - Open[3])*ES_MS_3rd_Huge_candle_size_ES_MS))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_to_Middle_candle_raio_ES_MS == true)
     {
      if(((((Open[2] > Close[2]) || (Open[2] == Close[2])) && ((Open[1] - Close[1]) >= ((Open[2] - Close[2])*ES_MS_3rd_to_Middle_candle_size_ES_MS))) ||
          (((Open[2] < Close[2]) || (Open[2] == Close[2])) && ((Open[1] - Close[1]) >= ((Close[2] - Open[2])*ES_MS_3rd_to_Middle_candle_size_ES_MS)))))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_Tiny_candle_ES_MS == true)
     {
      if((Open[1] - Close[1])  > ((Close[3] -  Open[3]) / ES_MS_3rd_Tiny_candle_size_ES_MS))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_candle_body_breakout_ES_MS == true)
     {
      if(Close[1] < Low[2])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_3rd_candle_wick_breakout_ES_MS == true)
     {
      if(Low[1] < Low[2])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(ES_MS_close_at_key_level_ES_MS == true)
     {
      if(
         (Close[1] == myMA_20_1)  ||
         (Close[1] == myMA_50_1)  ||
         (Close[1] == myMA_100_1) ||
         (Close[1] == myMA_200_1) ||
         (Close[1] == Bands_MODE_MAIN_1) ||
         (Close[1] == Bands_down_1_1) ||
         (Close[1] == Bands_up_1_1)  ||
         (Close[1] == Bands_down_2_1) ||
         (Close[1] == Bands_up_2_1))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(ES_MS_2_EMA_breakout_ES_MS == true)
     {
      if(
         (myMA_20_1  < Open[1] && myMA_20_1  > Close[1] && myMA_50_1  < Open[1] && myMA_50_1  > Close[1]) ||
         (myMA_20_1  < Open[1] && myMA_20_1  > Close[1] && myMA_100_1 < Open[1] && myMA_100_1 > Close[1]) ||
         (myMA_20_1  < Open[1] && myMA_20_1  > Close[1] && myMA_200_1 < Open[1] && myMA_200_1 > Close[1]) ||
         (myMA_50_1  < Open[1] && myMA_50_1  > Close[1] && myMA_100_1 < Open[1] && myMA_100_1 > Close[1]) ||
         (myMA_50_1  < Open[1] && myMA_50_1  > Close[1] && myMA_200_1 < Open[1] && myMA_200_1 > Close[1]) ||
         (myMA_100_1 < Open[1] && myMA_100_1 > Close[1] && myMA_200_1 < Open[1] && myMA_200_1 > Close[1]) ||
         (myMA_20_1  > Open[3] && myMA_20_1  < Close[3] && myMA_50_1  > Open[3] && myMA_50_1  < Close[3]) ||
         (myMA_20_1  > Open[3] && myMA_20_1  < Close[3] && myMA_100_1 > Open[3] && myMA_100_1 < Close[3]) ||
         (myMA_20_1  > Open[3] && myMA_20_1  < Close[3] && myMA_200_1 > Open[3] && myMA_200_1 < Close[3]) ||
         (myMA_50_1  > Open[3] && myMA_50_1  < Close[3] && myMA_100_1 > Open[3] && myMA_100_1 < Close[3]) ||
         (myMA_50_1  > Open[3] && myMA_50_1  < Close[3] && myMA_200_1 > Open[3] && myMA_200_1 < Close[3]) ||
         (myMA_100_1 > Open[3] && myMA_100_1 < Close[3] && myMA_200_1 > Open[3] && myMA_200_1 < Close[3]))
         return false;
     }
//------------------------------------------------+
   if(((Open[3] <  Close[3] && Open[2] > Close[2] && Open[1] > Close[1] && (Open[2] - Close[2] <= ((Close[3] - Open[3]) / ES_MS_middle_candle_size_ES_MS)) && Close[1] != Open[3]
        && (Close[1] > Open[3] || Close[1] < Low[3]))
       ||
       (Open[3] <  Close[3] && Open[2] == Close[2] && Open[1] > Close[1] && Close[1] != Open[3]
        && (Close[1] > Open[3] || Close[1] < Low[3]))
       ||
       (Open[3] <  Close[3] && Open[2] < Close[2] && Open[1] > Close[1] && (Close[2] - Open[2] <= ((Close[3] - Open[3]) / ES_MS_middle_candle_size_ES_MS)) && Close[1] != Open[3]
        && (Close[1] > Open[3] || Close[1] < Low[3]))) &&
      ((Open[3] < myMA_20_3 && Close[3] > myMA_20_3 && Open[1] > myMA_20_1  && Close[1] < myMA_20_1) ||
       (Open[3] < myMA_50_3 && Close[3] > myMA_50_3 && Open[1] > myMA_50_1  && Close[1] < myMA_50_1) ||
       (Open[3] < myMA_100_3 && Close[3] > myMA_100_3 && Open[1] > myMA_100_1  && Close[1] < myMA_100_1) ||
       (Open[3] < myMA_200_3 && Close[3] > myMA_200_3 && Open[1] > myMA_200_1  && Close[1] < myMA_200_1) ||
       (Open[3] < Bands_up_1_3 && Close[3] > Bands_up_1_3 && Open[1] > Bands_up_1_1  && Close[1] < Bands_up_1_1) ||
       (Open[3] < Bands_down_1_3 && Close[3] > Bands_down_1_3 && Open[1] > Bands_down_1_1  && Close[1] < Bands_down_1_1) ||
       (Open[3] < Bands_up_2_3 && Close[3] > Bands_up_2_3 && Open[1] > Bands_up_2_1  && Close[1] < Bands_up_2_1) ||
       (Open[3] < Bands_down_2_3 && Close[3] > Bands_down_2_3 && Open[1] > Bands_down_2_1  && Close[1] < Bands_down_2_1) ||
       (Open[3] < Bands_MODE_MAIN_3 && Close[3] > Bands_MODE_MAIN_3 && Open[1] > Bands_MODE_MAIN_1  && Close[1] < Bands_MODE_MAIN_1))
      &&  Analys_EMA == 2)
     {
      // Don();
      if(enable_text == true)
        {
         ES_s_1(arrow_name_down_ES_1, time_down_ES_1, price_down_ES_1);
        }
      Send_Sell_Order("ES");
      // Alert_Analys_type("Reversal-obj", "ES", Analys_Color_Red, TextSize_Analys, makan_y, makan_x * 20);
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+_Eng
bool Check_Buy_Signal_Eng() // Eng Buy
  {
   int r;
   if(Eng == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Eng_engulfing_candle_ratio)
     {
      if(((Close[2]) <= ((((Open[3] - Close[3])*Eng_Max_engulfing_percent) / 100) + Open[3])) && (((Close[2]) >= ((((Open[3] - Close[3])*Eng_Min_engulfing_percent) / 100) + Open[2]))))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_Body_to_Wick == true)
     {
      if((High[2] - Close[2]) < (((Close[2] - Open[2])*Eng_body_size_percent) / 100))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_outside_2_Dev == true)
     {
      if(Open[3] > Bands_down_2_3 && Close[3] < Bands_down_2_3 && Close[2] > Bands_down_2_2)
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_Shaven_head == true)
     {
      if(Close[2] != High[2])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_Body_breakout == true)
     {
      if(Close[2] > High[3])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_2_EMA_breakout == true)
     {
      if(
         (myMA_20_2 > Open[2] && myMA_20_2  < Close[2] && myMA_50_2  > Open[2] && myMA_50_2 < Close[2])  ||
         (myMA_20_2  > Open[2] && myMA_20_2  < Close[2] && myMA_100_2 > Open[2] && myMA_100_2 < Close[2]) ||
         (myMA_20_2  > Open[2] && myMA_20_2  < Close[2] && myMA_200_2 > Open[2] && myMA_200_2 < Close[2]) ||
         (myMA_50_2  > Open[2] && myMA_50_2  < Close[2] && myMA_100_2 > Open[2] && myMA_100_2 < Close[2]) ||
         (myMA_50_2  > Open[2] && myMA_50_2  < Close[2] && myMA_200_2 > Open[2] && myMA_200_2 < Close[2]) ||
         (myMA_100_2 > Open[2] && myMA_100_2 < Close[2] && myMA_200_2 > Open[2] && myMA_200_2 < Close[2]) ||
         (myMA_20_2  < Open[3] && myMA_20_2  > Close[3] && myMA_50_2  < Open[3] && myMA_50_2  > Close[3]) ||
         (myMA_20_2  < Open[3] && myMA_20_2  > Close[3] && myMA_100_2 < Open[3] && myMA_100_2 > Close[3]) ||
         (myMA_20_2  < Open[3] && myMA_20_2  > Close[3] && myMA_200_2 < Open[3] && myMA_200_2 > Close[3]) ||
         (myMA_50_2  < Open[3] && myMA_50_2  > Close[3] && myMA_100_2 < Open[3] && myMA_100_2 > Close[3]) ||
         (myMA_50_2  < Open[3] && myMA_50_2  > Close[3] && myMA_200_2 < Open[3] && myMA_200_2 > Close[3]) ||
         (myMA_100_2 < Open[3] && myMA_100_2 > Close[3] && myMA_200_2 < Open[3] && myMA_200_2 > Close[3]))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(Eng_close_at_key_level == true)
     {
      if(
         (Close[2] == myMA_20_2)  ||
         (Close[2] == myMA_50_2)  ||
         (Close[2] == myMA_100_2) ||
         (Close[2] == myMA_200_2) ||
         (Close[2] == Bands_MODE_MAIN_2) ||
         (Close[2] == Bands_down_1_2) ||
         (Close[2] == Bands_up_1_2)  ||
         (Close[2] == Bands_down_2_2) ||
         (Close[2] == Bands_up_2_2))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(Open[3] > Close[3] && Open[2] < Close[2] && Open[2] <= Close[3] && Open[3] - Close[3] < Close[2] - Open[2] && Close[2] > Open[3] && Close[1] < Open[1]
      &&
      (Close[1] == Open[3] || Close[1] == High[3]) &&   // ریتریسمنت
      ((Analys_EMA == 3  && ((Open[2] < Bands_down_2_2 &&  Close[2] > Bands_down_2_2) || (Open[2] < Bands_down_1_2 && Close[2] > Bands_down_1_2))) ||
       (Analys_EMA == 1  && Open[2] < Bands_up_1_2 &&  Close[2] > Bands_up_1_2) ||
       (Analys_EMA == 2  && Open[2] < Bands_down_1_2 &&  Close[2] > Bands_down_1_2 &&  Close[2] < High[iHighest(NULL, 0, MODE_HIGH, 6, 2)] &&  Close[2] > Low[iLowest(NULL, 0, MODE_LOW, 6, 2)])))
     {
      // // Up();
      if(enable_text == true)
        {
         Eng_b(arrow_name_up_Eng, time_up_Eng, price_up_Eng);
        }
      Send_Buy_Order("Eng");
      //Alert_Analys_type("Reversal-obj", "Eng", Analys_Color_Green, TextSize_Analys, 262, 17);
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_Eng() // Eng Sell
  {
   int r;
   if(Eng == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Eng_engulfing_candle_ratio)
     {
      if((((Close[2]) <= ((Open[3]) - (((Close[3] - Open[3])*Eng_Min_engulfing_percent) / 100))) && ((Close[2]) >= ((Open[3]) - (((Close[3] - Open[3])*Eng_Max_engulfing_percent) / 100)))))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_Body_to_Wick == true)
     {
      if((Close[2] - Low[2]) < (((Open[2] - Close[2])*Eng_body_size_percent) / 100))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_outside_2_Dev == true)
     {
      if(Open[3] < Bands_up_2_3 && Close[3] > Bands_up_2_3 && Close[2] < Bands_up_2_2)
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_Shaven_head == true)
     {
      if(Close[2] != Low[1])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_Body_breakout == true)
     {
      if(Close[2] < Low[3])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_2_EMA_breakout == true)
     {
      if(
         (myMA_20_2  < Open[2] && myMA_20_2  > Close[2] && myMA_50_2  < Open[2] && myMA_50_2  > Close[2]) ||
         (myMA_20_2  < Open[2] && myMA_20_2  > Close[2] && myMA_100_2 < Open[2] && myMA_100_2 > Close[2]) ||
         (myMA_20_2  < Open[2] && myMA_20_2  > Close[2] && myMA_200_2 < Open[2] && myMA_200_2 > Close[2]) ||
         (myMA_50_2  < Open[2] && myMA_50_2  > Close[2] && myMA_100_2 < Open[2] && myMA_100_2 > Close[2]) ||
         (myMA_50_2  < Open[2] && myMA_50_2  > Close[2] && myMA_200_2 < Open[2] && myMA_200_2 > Close[2]) ||
         (myMA_100_2 < Open[2] && myMA_100_2 > Close[2] && myMA_200_2 < Open[2] && myMA_200_2 > Close[2]) ||
         (myMA_20_2  > Open[3] && myMA_20_2  < Close[3] && myMA_50_2  > Open[3] && myMA_50_2  < Close[3]) ||
         (myMA_20_2  > Open[3] && myMA_20_2  < Close[3] && myMA_100_2 > Open[3] && myMA_100_2 < Close[3]) ||
         (myMA_20_2  > Open[3] && myMA_20_2  < Close[3] && myMA_200_2 > Open[3] && myMA_200_2 < Close[3]) ||
         (myMA_50_2  > Open[3] && myMA_50_2  < Close[3] && myMA_100_2 > Open[3] && myMA_100_2 < Close[3]) ||
         (myMA_50_2  > Open[3] && myMA_50_2  < Close[3] && myMA_200_2 > Open[3] && myMA_200_2 < Close[3]) ||
         (myMA_100_2 > Open[3] && myMA_100_2 < Close[3] && myMA_200_2 > Open[3] && myMA_200_2 < Close[3]))
         return false;
     }
//------------------------------------------------+
   if(Eng_close_at_key_level == true)
     {
      if(
         (Close[2] == myMA_20_2)  ||
         (Close[2] == myMA_50_2)  ||
         (Close[2] == myMA_100_2) ||
         (Close[2] == myMA_200_2) ||
         (Close[2] == Bands_MODE_MAIN_2) ||
         (Close[2] == Bands_down_1_2) ||
         (Close[2] == Bands_up_1_2)  ||
         (Close[2] == Bands_down_2_2) ||
         (Close[2] == Bands_up_2_2))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(Open[3] < Close[3] && Open[2] >  Close[2] && Open[2] >= Close[3] && Close[3] - Open[3] < Open[2] - Close[2] && Close[2] < Open[3] && Close[1] > Open[1] &&
      (Close[1] == Open[3]  || Close[1] == Low[3]) &&   // ریتریسمنت
      ((Analys_EMA == 3  && ((Open[2] > Bands_up_2_2 &&  Close[2] < Bands_up_2_2)  || (Open[2] > Bands_up_1_2 && Close[2] < Bands_up_1_2))) ||
       (Analys_EMA == 2  && Open[2] > Bands_down_1_2 &&  Close[2] < Bands_down_1_2) ||
       (Analys_EMA == 1  && Open[2] > Bands_up_1_2 &&  Close[2] < Bands_up_1_2 &&  Close[2] < High[iHighest(NULL, 0, MODE_HIGH, 6, 2)] &&  Close[2] > Low[iLowest(NULL, 0, MODE_LOW, 6, 2)])))
     {
      // Don();
      if(enable_text == true)
        {
         Eng_s(arrow_name_down_Eng, time_down_Eng, price_down_Eng);
        }
      Send_Sell_Order("Eng");
      // Alert_Analys_type("Reversal-obj", "Eng", Analys_Color_Red, TextSize_Analys, 262, 17);
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+_Eng 1
bool Check_Buy_Signal_Eng_1() // Eng 1 Buy
  {
   int r;
   if(Eng == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Eng_engulfing_candle_ratio)
     {
      if(((Close[1]) <= ((((Open[2] - Close[2])*Eng_Max_engulfing_percent) / 100) + Open[2])) && (((Close[1]) >= ((((Open[2] - Close[2])*Eng_Min_engulfing_percent) / 100) + Open[2]))))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_Body_to_Wick == true)
     {
      if((High[1] - Close[1]) < (((Close[1] - Open[1])*Eng_body_size_percent) / 100))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_outside_2_Dev == true)
     {
      if(Open[2] > Bands_down_2_2 && Close[2] < Bands_down_2_2 && Close[1] > Bands_down_2_1)
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_Shaven_head == true)
     {
      if(Close[1] != High[1])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_Body_breakout == true)
     {
      if(Close[1] > High[2])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_2_EMA_breakout == true)
     {
      if(
         (myMA_20_1 > Open[1] && myMA_20_1  < Close[1] && myMA_50_1  > Open[1] && myMA_50_1 < Close[1])  ||
         (myMA_20_1  > Open[1] && myMA_20_1  < Close[1] && myMA_100_1 > Open[1] && myMA_100_1 < Close[1]) ||
         (myMA_20_1  > Open[1] && myMA_20_1  < Close[1] && myMA_200_1 > Open[1] && myMA_200_1 < Close[1]) ||
         (myMA_50_1  > Open[1] && myMA_50_1  < Close[1] && myMA_100_1 > Open[1] && myMA_100_1 < Close[1]) ||
         (myMA_50_1  > Open[1] && myMA_50_1  < Close[1] && myMA_200_1 > Open[1] && myMA_200_1 < Close[1]) ||
         (myMA_100_1 > Open[1] && myMA_100_1 < Close[1] && myMA_200_1 > Open[1] && myMA_200_1 < Close[1]) ||
         (myMA_20_1  < Open[2] && myMA_20_1  > Close[2] && myMA_50_1  < Open[2] && myMA_50_1  > Close[2]) ||
         (myMA_20_1  < Open[2] && myMA_20_1  > Close[2] && myMA_100_1 < Open[2] && myMA_100_1 > Close[2]) ||
         (myMA_20_1  < Open[2] && myMA_20_1  > Close[2] && myMA_200_1 < Open[2] && myMA_200_1 > Close[2]) ||
         (myMA_50_1  < Open[2] && myMA_50_1  > Close[2] && myMA_100_1 < Open[2] && myMA_100_1 > Close[2]) ||
         (myMA_50_1  < Open[2] && myMA_50_1  > Close[2] && myMA_200_1 < Open[2] && myMA_200_1 > Close[2]) ||
         (myMA_100_1 < Open[2] && myMA_100_1 > Close[2] && myMA_200_1 < Open[2] && myMA_200_1 > Close[2]))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(Eng_close_at_key_level == true)
     {
      if(
         (Close[1] == myMA_20_1)  ||
         (Close[1] == myMA_50_1)  ||
         (Close[1] == myMA_100_1) ||
         (Close[1] == myMA_200_1) ||
         (Close[1] == Bands_MODE_MAIN_1) ||
         (Close[1] == Bands_down_1_1) ||
         (Close[1] == Bands_up_1_1)  ||
         (Close[1] == Bands_down_2_1) ||
         (Close[1] == Bands_up_2_1))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(Open[2] > Close[2] && Open[1] < Close[1] && Open[1] <= Close[2] && Open[2] - Close[2] < Close[1] - Open[1] && Close[1] > Open[2] &&
      ((Open[2] > myMA_20_2 && Close[2] < myMA_20_2 && Open[1] < myMA_20_1  && Close[1] > myMA_20_1) ||
       (Open[2] > myMA_50_2 && Close[2] < myMA_50_2 && Open[1] < myMA_50_1  && Close[1] > myMA_50_1) ||
       (Open[2] > myMA_100_2 && Close[2] < myMA_100_2 && Open[1] < myMA_100_1  && Close[1] > myMA_100_1) ||
       (Open[2] > myMA_200_2 && Close[2] < myMA_200_2 && Open[1] < myMA_200_1  && Close[1] > myMA_200_1) ||
       (Open[2] > Bands_up_1_2 && Close[2] < Bands_up_1_2 && Open[1] < Bands_up_1_1  && Close[1] > Bands_up_1_1) ||
       (Open[2] > Bands_down_1_2 && Close[2] < Bands_down_1_2 && Open[1] < Bands_down_1_1  && Close[1] > Bands_down_1_1) ||
       (Open[2] > Bands_up_2_2 && Close[2] < Bands_up_2_2 && Open[1] < Bands_up_2_1  && Close[1] > Bands_up_2_1) ||
       (Open[2] > Bands_down_2_2 && Close[2] < Bands_down_2_2 && Open[1] < Bands_down_2_1  && Close[1] > Bands_down_2_1) ||
       (Open[2] > Bands_MODE_MAIN_2 && Close[2] < Bands_MODE_MAIN_2 && Open[1] < Bands_MODE_MAIN_1  && Close[1] > Bands_MODE_MAIN_1))
      &&  Analys_EMA == 1)
     {
      // // Up();
      if(enable_text == true)
        {
         Eng_b_1(arrow_name_up_Eng_1, time_up_Eng_1, price_up_Eng_1);
        }
      Send_Buy_Order("Eng");
      // Alert_Analys_type("Reversal-obj", "Eng", Analys_Color_Green, TextSize_Analys, makan_y, makan_x * 20);
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_Eng_1()  // Eng 1 Sell
  {
   int r;
   if(Eng == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Eng_engulfing_candle_ratio)
     {
      if((((Close[1]) <= ((Open[2]) - (((Close[2] - Open[2])*Eng_Min_engulfing_percent) / 100))) && ((Close[1]) >= ((Open[2]) - (((Close[2] - Open[2])*Eng_Max_engulfing_percent) / 100)))))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_Body_to_Wick == true)
     {
      if((Close[1] - Low[1]) < (((Open[1] - Close[1])*Eng_body_size_percent) / 100))
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_outside_2_Dev == true)
     {
      if(Open[2] < Bands_up_2_2 && Close[2] > Bands_up_2_2 && Close[1] < Bands_up_2_1)
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_Shaven_head == true)
     {
      if(Close[1] != Low[1])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_Body_breakout == true)
     {
      if(Close[1] < Low[2])
        {
         r = 1;
        }
      else
         return false;
     }
//------------------------------------------------+
   if(Eng_2_EMA_breakout == true)
     {
      if(
         (myMA_20_1  < Open[1] && myMA_20_1  > Close[1] && myMA_50_1  < Open[1] && myMA_50_1  > Close[1]) ||
         (myMA_20_1  < Open[1] && myMA_20_1  > Close[1] && myMA_100_1 < Open[1] && myMA_100_1 > Close[1]) ||
         (myMA_20_1  < Open[1] && myMA_20_1  > Close[1] && myMA_200_1 < Open[1] && myMA_200_1 > Close[1]) ||
         (myMA_50_1  < Open[1] && myMA_50_1  > Close[1] && myMA_100_1 < Open[1] && myMA_100_1 > Close[1]) ||
         (myMA_50_1  < Open[1] && myMA_50_1  > Close[1] && myMA_200_1 < Open[1] && myMA_200_1 > Close[1]) ||
         (myMA_100_1 < Open[1] && myMA_100_1 > Close[1] && myMA_200_1 < Open[1] && myMA_200_1 > Close[1]) ||
         (myMA_20_1  > Open[2] && myMA_20_1  < Close[2] && myMA_50_1  > Open[2] && myMA_50_1  < Close[2]) ||
         (myMA_20_1  > Open[2] && myMA_20_1  < Close[2] && myMA_100_1 > Open[2] && myMA_100_1 < Close[2]) ||
         (myMA_20_1  > Open[2] && myMA_20_1  < Close[2] && myMA_200_1 > Open[2] && myMA_200_1 < Close[2]) ||
         (myMA_50_1  > Open[2] && myMA_50_1  < Close[2] && myMA_100_1 > Open[2] && myMA_100_1 < Close[2]) ||
         (myMA_50_1  > Open[2] && myMA_50_1  < Close[2] && myMA_200_1 > Open[2] && myMA_200_1 < Close[2]) ||
         (myMA_100_1 > Open[2] && myMA_100_1 < Close[2] && myMA_200_1 > Open[2] && myMA_200_1 < Close[2]))
         return false;
     }
//------------------------------------------------+
   if(Eng_close_at_key_level == true)
     {
      if(
         (Close[1] == myMA_20_1)  ||
         (Close[1] == myMA_50_1)  ||
         (Close[1] == myMA_100_1) ||
         (Close[1] == myMA_200_1) ||
         (Close[1] == Bands_MODE_MAIN_1) ||
         (Close[1] == Bands_down_1_1) ||
         (Close[1] == Bands_up_1_1)  ||
         (Close[1] == Bands_down_2_1) ||
         (Close[1] == Bands_up_2_1))
        {
         return false;
        }
     }
//------------------------------------------------+
   if(Open[2] < Close[2] && Open[1] >  Close[1] && Open[1] >= Close[2] && Close[2] - Open[2] < Open[1] - Close[1] && Close[1] < Open[2] &&
      ((Open[2] < myMA_20_2 && Close[2] > myMA_20_2 && Open[1] > myMA_20_1  && Close[1] < myMA_20_1) ||
       (Open[2] < myMA_50_2 && Close[2] > myMA_50_2 && Open[1] > myMA_50_1  && Close[1] < myMA_50_1) ||
       (Open[2] < myMA_100_2 && Close[2] > myMA_100_2 && Open[1] > myMA_100_1  && Close[1] < myMA_100_1) ||
       (Open[2] < myMA_200_2 && Close[2] > myMA_200_2 && Open[1] > myMA_200_1  && Close[1] < myMA_200_1) ||
       (Open[2] < Bands_up_1_2 && Close[2] > Bands_up_1_2 && Open[1] > Bands_up_1_1  && Close[1] < Bands_up_1_1) ||
       (Open[2] < Bands_down_1_2 && Close[2] > Bands_down_1_2 && Open[1] > Bands_down_1_1  && Close[1] < Bands_down_1_1) ||
       (Open[2] < Bands_up_2_2 && Close[2] > Bands_up_2_2 && Open[1] > Bands_up_2_1  && Close[1] < Bands_up_2_1) ||
       (Open[2] < Bands_down_2_2 && Close[2] > Bands_down_2_2 && Open[1] > Bands_down_2_1  && Close[1] < Bands_down_2_1) ||
       (Open[2] < Bands_MODE_MAIN_2 && Close[2] > Bands_MODE_MAIN_2 && Open[1] > Bands_MODE_MAIN_1  && Close[1] < Bands_MODE_MAIN_1))
      &&  Analys_EMA == 2)
     {
      // Don();
      if(enable_text == true)
        {
         Eng_s_1(arrow_name_down_Eng_1, time_down_Eng_1, price_down_Eng_1);
        }
      Send_Sell_Order("Eng");
      //Alert_Analys_type("Reversal-obj", "Eng", Analys_Color_Red, TextSize_Analys, makan_y, makan_x * 20);;
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+_EXC
bool Check_Buy_Signal_EXC()  // EXC Buy
  {
   int r;
   if(EXC == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      MathAbs(Open[2] - Close[2]) < MathAbs(Open[1] - Close[1])
      &&  MathAbs(Open[4] - Close[4])  >   MathAbs(Open[3] - Close[3]) * 4
      && Close[1] > Open[1]
      && (Close[2] < Open[2] || Close[2] > Open[2])
      && Close[3] > Open[3]
      && Close[4] > Open[4]
      && High[1] > Bands_up_2_1
      && High[2] > Bands_up_2_2
      && High[3] > Bands_up_2_3
      && Close[1] > High[2] * -1.1
   )
     {
      // // Up();
      if(enable_text == true)
        {
         EXC_b(arrow_name_up_EXC, time_up_EXC, price_up_EXC);
        }
      Send_Buy_Order("EXC");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_EXC()  // EXC Sell
  {
   int r;
   if(EXC == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      MathAbs(Open[2] - Close[2]) < MathAbs(Open[1] - Close[1])
      &&  MathAbs(Open[4] - Close[4])  >   MathAbs(Open[3] - Close[3]) * 4
      && Close[1] < Open[1]
      && (Close[2] > Open[2] || Close[2] < Open[2])
      && Close[3] < Open[3]
      && Close[4] < Open[4]
      && Close[1] < Low[2] * 1.1
      && Low[1] < Bands_down_2_1
      && Low[2] < Bands_down_2_2
      && Low[3] < Bands_down_2_3
   )
     {
      // Don();
      if(enable_text == true)
        {
         EXC_s(arrow_name_down_EXC, time_down_EXC, price_down_EXC);
        }
      Send_Sell_Order("EXC");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+_EXP
bool Check_Buy_Signal_EXP()  // EXP BUY
  {
   int r;
   if(EXP == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Band_1_EXP == true)
     {
      if(Close[1] < Bands_down_1_1 && Close[2] > Bands_down_1_2 && Close[3] > Bands_up_1_3)
        {
         r = 1;
        }
      else
         return false;
     }
//----
   if(Band_2_EXP == true)
     {
      if(/* Close[1] < Bands_down_2_1 &&*/ Close[2] > Bands_down_2_2 && Close[3] > Bands_down_2_3)
        {
         r = 1;
        }
      else
         return false;
     }
//----
//    int m;
   if(Close[1] < Open[1] && Close[2] > Open[2] && Close[3] > Open[3]  && Close[4] > Open[4] &&
      Close[3] - Open[3] < Close[2] - Open[2] &&  Close[3] - Open[3] <  Close[4] - Open[4] && MathAbs(Open[1] - Close[1]) < MathAbs(Close[2] - Open[2]) / 2 &&
// && MathAbs(Open[5] - Close[5]) < Close[4] - Open[4] &&  Close[2] - Open[2] >  Close[4] - Open[4]
// && (Close[1] == High[3] ||  Close[1] == Close[3]  ||   Close[1] == High[4] ||  Close[1] == Close[4]  || Close[1] == (Close[2] - Open[2] / 2))
      High[1] < High[2] &&
      Low[1] != Close[1]
      &&
      Analys_EMA == 1 && Close[1] > Bands_up_1_5_1)
     {
      // // Up();
      if(enable_text == true)
        {
         EXP_b(arrow_name_up_EXP, time_up_EXP, price_up_EXP);
        }
      Send_Buy_Order("EXP");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+_EXP
bool Check_Sell_Signal_EXP()  // EXP Sell
  {
   int r;
   if(EXP == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Band_1_EXP == true)
     {
      if(Close[1] > Bands_up_1_1 && (Close[2] < Bands_up_1_2 || Close[3] < Bands_up_1_3))
        {
         r = 1;
        }
      else
         return false;
     }
//----
   if(Band_2_EXP == true)
     {
      if(/*Close[1] > Bands_up_2_1 &&*/ Close[2] < Bands_up_2_2 || Close[3] < Bands_up_2_3)
        {
         r = 1;
        }
      else
         return false;
     }
//----
//----
   if(Close[1] > Open[1] && Close[2] < Open[2] && Close[3] < Open[3]  && Close[4] < Open[4] &&
      Open[3] - Close[3] < Open[2] - Close[2] &&  Open[3] - Close[3] <  Open[4] - Close[4]  &&  MathAbs(Close[1] - Open[1]) < MathAbs(Open[2] - Close[2]) / 2 &&
//&& MathAbs(Open[5] - Close[5]) < Open[4] - Close[4] &&  Open[2] - Close[2] > Open[4] - Close[4]
// && (Close[1] == Low[3] ||  Close[1] == Close[3]  ||   Close[1] == Low[4] ||  Close[1] == Close[4]  || Close[1] == (Open[2] - Close[2] / 2))
      Low[1] > Low[2]
      && High[1] != Close[1]
      &&
      Analys_EMA == 2  && Close[1] < Bands_down_1_5_1)
     {
      // Don();
      if(enable_text == true)
        {
         EXP_s(arrow_name_down_EXP, time_down_EXP, price_down_EXP);
        }
      Send_Sell_Order("EXP");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+ EXR
//+------------------------------------------------------------------+
bool Check_Buy_Signal_EXR()  // EXR Buy
  {
   int r;
   if(EXR == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] < Open[1]
      && Close[2] < Open[2]
      && Close[3] < Open[3]
      && Open[2] - Close[2] >  Open[1] - Close[1]
      && Open[2] - Close[2] >  Open[3] - Close[3]
      && Open[1] - Close[1] <  Open[3] - Close[3]
      &&  MathAbs(Open[2] - Close[2])  >   MathAbs(Open[1] - Close[1]) * 4
      && Analys_EMA == 2
      && Close[1] != myMA_200_1 && Close[1] != myMA_100_1 && Close[1] != myMA_50_1
   )
     {
      // // Up();
      if(enable_text == true)
        {
         EXR_b(arrow_name_up_EXR, time_up_EXR, price_up_EXR);
        }
      Send_Buy_Order("EXR");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_EXR()   // EXR Sell
  {
   int r;
   if(EXR == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] > Open[1]
      && Close[2] > Open[2]
      && Close[3] > Open[3]
      && Open[2] - Close[2] <  Open[1] - Close[1]
      && Open[2] - Close[2] <  Open[3] - Close[3]
      && Open[1] - Close[1] >  Open[3] - Close[3]
      &&  MathAbs(Open[2] - Close[2])  <   MathAbs(Open[1] - Close[1]) * 4
      && Analys_EMA == 1
      && Close[1] != myMA_200_1 && Close[1] != myMA_100_1 && Close[1] != myMA_50_1
   )
     {
      // Don();
      if(enable_text == true)
        {
         EXR_s(arrow_name_down_EXR, time_down_EXR, price_down_EXR);
        }
      Send_Sell_Order("EXR");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+ EXRC
//+------------------------------------------------------------------+
bool Check_Buy_Signal_EXRC()  // EXRC Buy
  {
   int r;
   if(EXRC == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Band_1_EXRC == true)
     {
      //if(/* Close[1] < Bands_down_1_1 &&*/ Close[2] < Bands_down_1_2 && Close[3] < Bands_down_1_3)
      if(/* Close[1] < Bands_down_1_1 &&*/ Close[2] < Bands_down_1_5_2 /*&& Close[3] < Bands_up_1_3*/)
        {
         r = 1;
        }
      else
         return false;
     }
//----
   if(Band_2_EXRC == true)
     {
      //if(/* Close[1] < Bands_down_2_1 &&*/ Close[2] < Bands_down_2_2 && Close[3] < Bands_down_2_3)
      if(/* Close[1] < Bands_down_2_1 &&*/ Close[1] > Bands_down_1_1 /*&& Close[3] < Bands_down_2_3*/)
        {
         r = 1;
        }
      else
         return false;
     }
//----
   if(mosave_bodan_high_low_2_candle_EXRC == true)
     {
      if(Low[1] == Low[2])
        {
         r = 1;
        }
      else
         return false;
     }
//----
   if(Band_1_5_for_candel_1_EXRC == true)
     {
      if(Close[1] > Bands_down_1_5_1)
        {
         r = 1;
        }
      else
         return false;
     }
//----
   if(Close[1] > Open[1] && Close[2] < Open[2] && Close[3] < Open[3]  && Close[4] < Open[4]
      && Open[3] - Close[3] <  Open[2] - Close[2] &&  Open[3] - Close[3] <  Open[4] - Close[4]
      && ((Close[5] > Open[5] && Close[5] - Open[5] <  Open[4] - Close[4]) || (Open[5] > Close[5] && Open[5] - Close[5] <  Open[4] - Close[4]))
      && Open[2] - Close[2] >  Open[4] - Close[4]
      && (Close[1] == Low[3] ||  Close[1] == Close[3] || Close[1] == Low[4] || Close[1] == Close[4] || Close[1] == (Open[2] - Close[2] / 2))
      && Low[1] >= Low[2]
      && High[1] != Close[1] && High[1] - Close[1] < Close[1] - Open[1]
     )
     {
      if(enable_text == true)
        {
         EXRC_b(arrow_name_up_EXRC, time_up_EXRC, price_up_EXRC);
        }
      Send_Buy_Order("EXRC");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_EXRC() // EXRC Sell
  {
   int r;
   if(EXRC == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Band_1_EXRC == true)
     {
      // if(/* Close[1] > Bands_up_1_1 && */Close[2] > Bands_up_1_2 || Close[3] > Bands_up_1_3)
      if(/* Close[1] > Bands_up_1_1 && */Close[2] > Bands_up_1_5_2/* || Close[3] > Bands_up_1_3*/)
        {
         r = 1;
        }
      else
         return false;
     }
//----
   if(Band_2_EXRC == true)
     {
      // if(/*Close[1] > Bands_up_2_1 &&*/ Close[2] > Bands_up_2_2 || Close[3] > Bands_up_2_3)
      if(/*Close[1] > Bands_up_2_1 &&*/ Close[1] < Bands_up_1_1 /*|| Close[3] > Bands_up_2_3*/)
        {
         r = 1;
        }
      else
         return false;
     }
//----
   if(mosave_bodan_high_low_2_candle_EXRC == true)
     {
      if(High[1] == High[2])
        {
         r = 1;
        }
      else
         return false;
     }
//----
   if(Band_1_5_for_candel_1_EXRC == true)
     {
      if(Close[1] < Bands_up_1_5_1)
        {
         r = 1;
        }
      else
         return false;
     }
//----
   if(Close[1] < Open[1] && Close[2] > Open[2] && Close[3] > Open[3]  && Close[4] > Open[4]
      && Close[3] - Open[3] <  Close[2] - Open[2] &&  Close[3] - Open[3] <  Close[4] - Open[4]
      && ((Open[5] > Close[5] && Open[5] - Close[5] < Close[4] - Open[4]) || (Close[5] > Open[5] && Close[5] - Open[5] <  Close[4] - Open[4]))
      && Close[2] - Open[2] >  Close[4] - Open[4]
      && (Close[1] == High[3] ||  Close[1] == Close[3]  ||   Close[1] == High[4] ||  Close[1] == Close[4]  || Close[1] == (Close[2] - Open[2] / 2))
      && High[1] <= High[2]
      && Low[1] != Close[1] && Close[1] - Low[1] < Open[1] - Close[1]
     )
     {
      if(enable_text == true)
        {
         EXRC_s(arrow_name_down_EXRC, time_down_EXRC, price_down_EXRC);
        }
      Send_Sell_Order("EXRC");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }

//+------------------------------------------------------------------+ NRS
//+------------------------------------------------------------------+
bool Check_Buy_Signal_NRS()  // NRS Buy
  {
   int r;
   if(NRS == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Close[3] > Open[3]
      && Close[3] == Open[2]
      && Close[2] < Open[2]
      && Close[1] > Close[3] && Close[1] > Open[2]
      && Close[1] != High[1]
      && Close[1] > High[2]
      && Close[1] < Bands_up_1_1
      && Close[1] > Bands_down_1_1
      && ((Open[1] < myMA_20_1 && Close[1] > myMA_20_1)
          || (Open[1] < myMA_50_1 && Close[1] > myMA_50_1)
          || (Open[1] < myMA_100_1 && Close[1] > myMA_100_1)
          || (Open[1] < myMA_200_1 && Close[1] > myMA_200_1))
      &&  Analys_EMA == 2
     )
     {
      // // Up();
      if(enable_text == true)
        {
         NRS_b(arrow_name_up_NRS, time_up_NRS, price_up_NRS);
        }
      Send_Buy_Order("NRS");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_NRS()  // NRS Sell
  {
   int r;
   if(NRS == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[3] > Open[3]
      && Close[3] == Open[2]
      && Close[2] < Open[2]
      && Close[1] > Close[3] && Close[1] > Open[2]
      && Close[1] != High[1]
      && Close[1] > High[2]
      && Close[1] < Bands_up_1_1
      && Close[1] > Bands_down_1_1
      && ((Open[1] > myMA_20_1 && Close[1] < myMA_20_1)
          || (Open[1] > myMA_50_1 && Close[1] < myMA_50_1)
          || (Open[1] > myMA_100_1 && Close[1] < myMA_100_1)
          || (Open[1] > myMA_200_1 && Close[1] < myMA_200_1))
      && Analys_EMA == 1
   )
     {
      //Don();
      if(enable_text == true)
        {
         NRS_s(arrow_name_down_NRS, time_down_NRS, price_down_NRS);
        }
      Send_Sell_Order("NRS");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+ FNRS
//+------------------------------------------------------------------+
bool Check_Buy_Signal_FNRS()  // FNRS Buy
  {
   int r;
   if(No_rejection_setup_FNRS == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(FNRS_Constriction == true)
       {
          if(myMA_20_1 < myMA_20_10 && myMA_20_5 - myMA_20_1 >= myMA_20_10 - myMA_20_5)
             {
                r = 1;
             }
          else
             return false;
       }
    //---
    //---
    if(FNRS_on_2_dev == true)
       {
          if(((Close[3]) < (Bands_down_2_3)))
             {
                r = 1;
             }
          else
             return false;
       }
    if(Close_balay_pain_ema200_FNRS == true)
       {
          if(Open[1] > myMA_200_1 && Close[1] > myMA_200_1)
             {
                r = 1;
             }
          else
             return false;
       }*/
//---
//---
   if(size_candele_1_nesbat_be_candel_2_FNRS == true)
     {
      if(Open[1] - Close[1] > Close[2] - Open[2] * size_candle_2_FNRS) // اگر کندل یک دو برابر کندل دو بود بای کند
        {
         r = 1;
        }
      else
         return false;
     }
   if(badaneh_candele_1_nesbat_be_sayehha_2_3_FNRS == true)
     {
      // اگر بدنه ی کندل 1 را به چهار قسمت تقسیم کنیم و بدنه ی همین کندل نتواند به اندازه ی یک چارم خودش زیر سایه های کندلهای دو و سه قرار بگیرد بای کند
      if(Open[1] - Close[1] / 4 + Close[1] >  MathMin(Low[3],  Low[2]))
        {
         r = 1;
        }
      else
         return false;
     }
   if(nesbat_sayh_candel_1_be_badaneh_khodash_FNRS == true)
     {
      // اگر سایه ی کندل یک بیش از نصف بدنه خودش بود بای بزند
      if(Close[1] - Low[1] > ((Open[1] -  Close[1]) / multi_ply_FNRS))
        {
         r = 1;
        }
      else
         return false;
     }
//-------------------------------------
   if(badane_candle_1_25_darsad_FNRS == true)
     {
      if(Close[1]  + ((Open[1] - Close[1]) / 4)  > MathMin(Low[2], Low[3]))// بیش از یک چهارم کندل یک بالاتر از های کندلهای دو و سه باشد
        {
         r = 1;
        }
      else
         return false;
     }
//---
   if(Huge_Candle_FNRS == true)
     {
      if(Open[1] - Close[1] > (Close[2] - Open[2]) * multi_ply_FNRS) // کندل یک باید  بیش از دو برابر سایز کندل دو باشد
        {
         r = 1;
        }
      else
         return false;
     }
//---
   if(sayeh_Candle_1_FNRS == true)
     {
      if(Close[1] - Low[1]  > (Open[1] - Close[1]) / 1)  // اگر سایه کندل یک بزگتر از نیمی از بدنه ی خوش باشد سیگنال ندهد
        {
         r = 1;
        }
      else
         return false;
     }
//---
   if(Close[1] < Open[1] && Close[2] > Open[2] && Close[3] < Open[3] && Close[3] == Open[2] &&
      Open[1] <= Close[2] && Open[1] >= ((((Close[2] - Open[2]) * 50) / 100) + Open[2]) && Close[1] < Low[2]
// && (Open[1] - Close[1]) / 2  + Close[1] <=  Bands_down_1_1
      && ((Analys_EMA == 1 && Close[1] > Bands_up_1_1) || (Analys_EMA == 3  && (Close[1] < Bands_down_1_1 || Close[1] < Bands_down_2_1)))   ///
     )
     {
      // // Up();
      if(enable_text == true)
        {
         FNRS_b(arrow_name_up_FNRS, time_up_FNRS, price_up_FNRS);
        }
      Send_Buy_Order("FNRS");
      signal_price_buy = Bid;
      signalTime_buy = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+FNRS
bool Check_Sell_Signal_FNRS()  // FNRS Sell
  {
   int r;
   if(No_rejection_setup_FNRS == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(FNRS_Constriction == true)
       {
          if(myMA_20_1 > myMA_20_10 && myMA_20_1 - myMA_20_5 >= myMA_20_5 - myMA_20_10)
             {
                r = 1;
             }
          else
             return false;
       }
    //----
    if(FNRS_on_2_dev == true)
       {
          if(((Close[3]) > (Bands_up_2_3)))
             {
                r = 1;
             }
          else
             return false;
       }
    if(Close_balay_pain_ema200_FNRS == true)
       {
          if(Open[1] < myMA_200_1 && Close[1] < myMA_200_1 )
             {
                r = 1;
             }
          else
             return false;
       }*/
//---
   if(size_candele_1_nesbat_be_candel_2_FNRS == true)
     {
      if(Close[1] - Open[1] >= Open[2] - Close[2] * size_candle_2_FNRS) // اگر کندل یک دو برابر کندل دو بود سل بزند
        {
         r = 1;
        }
      else
         return false;
     }
   if(badaneh_candele_1_nesbat_be_sayehha_2_3_FNRS == true)
     {
      //  اگر بدنه ی کندل 1 را به چهار قسمت تقسیم کنیم و بدنه ی همین کندل نتواند به اندازه ی یک چارم خودش زیر سایه های کندلهای دو و سه قرار بگیرد سل کند
      if(Close[1] - Open[1] / 4 + Open[1] > MathMax(High[3],  High[2]))  //
        {
         r = 1;
        }
      else
         return false;
     }
//---
   if(nesbat_sayh_candel_1_be_badaneh_khodash_FNRS == true)
     {
      // اگر سایه ی کندل یک بیش از نصف بدنه خودش بود سل بزند
      if(High[1] - Close[1]  > ((Close[1] -  Open[1]) / multi_ply_FNRS))
        {
         r = 1;
        }
      else
         return false;
     }
//---------------------------------------------------------------------------------
   if(badane_candle_1_25_darsad_FNRS == true)
     {
      if(Close[1] - ((Close[1] - Open[1]) / 4) > MathMax(High[2], High[3]))// بیش از یک چهارم کندل یک بالاتر از های کندلهای دو و سه باشد
        {
         r = 1;
        }
      else
         return false;
     }
//---
   if(Huge_Candle_FNRS == true)
     {
      if(Close[1] - Open[1] > (Open[2] - Close[2]) * multi_ply_FNRS) // کندل یک باید  بیش از دو برابر سایز کندل دو باشد
        {
         r = 1;
        }
      else
         return false;
     }
//---
   if(sayeh_Candle_1_FNRS == true)
     {
      if(High[1] - Close[1] > (Close[1] - Open[1]) / 1) // اگر سایه کندل یک بزگتر از نیمی از بدنه ی خوش باشد سیگنال ندهد
        {
         r = 1;
        }
      else
         return false;
     }
//---
   if(Close[1] > Open[1] && Close[2] < Open[2] && Close[3] > Open[3] && Close[3] == Open[2] &&
      Open[1] >= Close[2] && (Open[1] < ((((Open[2] - Close[2]) * 50) / 100) + Close[2])) && Close[1] > High[2]
// && (Close[1] - Open[1]) / 2  + Open[1] >= Bands_up_1_1
      && ((Analys_EMA == 2  && Close[1] < Bands_down_1_1) || (Analys_EMA == 3  && (Close[1] > Bands_up_1_1 || Close[1] > Bands_up_2_1)))  ///
     )
     {
      //Don();
      if(enable_text == true)
        {
         FNRS_s(arrow_name_down_FNRS, time_down_FNRS, price_down_FNRS);
        }
      Send_Sell_Order("FNRS");
      signal_price_sell = Bid;
      signalTime_sell = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+NRSP
bool Check_Buy_Signal_NRSP()   //NRSP BUY
  {
   int r;
   if(NRSP == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Close[1] < Open[1] && Close[2] > Open[2] && Close[3] < Open[3] && Close[4] > Open[4]
// && Close[4] == Open[3]
      && Close[2] > MathMax(High[3], High[4])
      && (Close[1] == Open[3] || Close[1] == Close[4] ||  Close[1] == High[3] ||  Close[1] == High[4]) &&
      ((Analys_EMA == 3  && Close[1] > Bands_up_1_1) ||
       (Analys_EMA == 1  && Close[1] > Bands_up_1_1) ||
       (Analys_EMA == 2  && Close[1] > Bands_up_1_1))
     )
     {
      // // Up();
      if(enable_text == true)
        {
         NRSP_b(arrow_name_up_NRSP, time_up_NRSP, price_up_NRSP);
        }
      Send_Buy_Order("NRSP");
      signalTime_buy = Time[0];
      signal_price_buy = Bid;
      return true;
     }
   else
      return false;
  }
//----------------------------------------------------------------------NRSP
bool Check_Sell_Signal_NRSP() // NRSP SELL
  {
   int r;
   if(NRSP == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Close[1] > Open[1] && Close[2] < Open[2] && Close[3] > Open[3] && Close[4] < Open[4]
      && Close[4] == Open[3]
      && Close[2] < MathMin(Low[3], Low[4])
      && (Close[1] == Open[3] || Close[1] == Close[4] ||  Close[1] == Low[3] ||  Close[1] == Low[4]) &&
      ((Analys_EMA == 3 && Close[1] < Bands_down_1_1) ||
       (Analys_EMA == 2 && Close[1] < Bands_down_1_1) ||
       (Analys_EMA == 1 && Close[1] < Bands_down_1_1))
     )
     {
      //Don();
      if(enable_text == true)
        {
         NRSP_s(arrow_name_down_NRSP, time_down_NRSP, price_down_NRSP);
        }
      Send_Sell_Order("NRSP");
      signalTime_sell = Time[0];
      signal_price_sell = Bid;
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//+------------------------------------------------------------------+_SnR >>> SS9
//+------------------------------------------------------------------+
bool Check_Buy_Signal_SnR() // SS9 BUY
  {
   int r;
   if(SnR == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(segnal_buy == 1 && ((Analys_EMA == 3 && Close[1] > Bands_down_1_5_1) || (Analys_EMA == 1 && Close[1] > Bands_down_1_5_1)))
     {
      if(enable_text == true)
        {
         SnR_b(arrow_name_up_SnR, time_up_SnR, price_up_SnR);
        }
      Send_Buy_Order("SS9");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      segnal_buy = 0;
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_SnR() //SS9 SELL
  {
   int r;
   if(SnR == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(segnal_sell == 1 && ((Analys_EMA == 3  && Close[1] < Bands_up_1_5_1) || (Analys_EMA == 2 && Close[1] < Bands_up_1_5_1)))
     {
      if(enable_text == true)
        {
         SnR_s(arrow_name_down_SnR, time_down_SnR, price_down_SnR);
        }
      Send_Sell_Order("SS9");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      segnal_sell = 0;
      return true;
     }
   return false;
  }

//+------------------------------------------------------------------+_FB
bool Check_Buy_Signal_FB()  // FB BUY
  {
   int r;
   if(FB == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(/* Close[1] < Bands_down_1_1 &&*/ Close[2] < Bands_down_1_2 && Close[3] < Bands_up_1_3)
     {
      r = 1;
     }
   else
      return false;
//----
   if(((Close[1] > Open[1] && Close[2] < Open[2] && Close[3] < Open[3] && Close[3] != Low[3] && High[3] != Open[3] && Close[3] - Low[3] >= High[3] - Open[3] * 3)
       || (Close[1] > Open[1] && Close[2] < Open[2] && Close[3] > Open[3] && Close[3] != High[3] && Open[3] != Low[3] && Open[3] - Low[3] >= High[3] - Close[3] * 3)))
     {
      if(enable_text == true)
        {
         FB_b(arrow_name_up_FB, time_up_FB, price_up_FB);
        }
      Send_Buy_Order("FB");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_FB()  // FB SELL
  {
   int r;
   if(FB == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Band_1_FB == true)
     {
      if(/* Close[1] > Bands_up_1_1 && */Close[2] > Bands_up_1_2 || Close[3] > Bands_up_1_3)
        {
         r = 1;
        }
      else
         return false;
     }
//----
   if(Close[1] < Open[1] && Close[2] > Open[2] && (Close[3] > Open[3]  || Close[3] < Open[3])
     )
     {
      if(enable_text == true)
        {
         FB_s(arrow_name_down_FB, time_down_FB, price_down_FB);
        }
      Send_Sell_Order("FB");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }




//+------------------------------------------------------------------+_shoting_s_1
bool Check_Buy_Signal_shoting_s_1()  // shoting_s_1 BUY
  {
   int r;
   if(shoting_s_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      ((Open[1] < Close[1]) || (Open[1] > Close[1]))
      && Open[1] < Low[1] + ((High[1] - Low[1]) * 0.05)
      && (MathAbs(Close[1] - Open[1])) <= ((High[1] - Low[1]) * 0.6)
      && Open[2] <= Close[1]
      && Close[1] < Bands_MODE_MAIN_1
      && Open[2] < Close[2]
      && (High[1] > myMA_20_1 || High[1] > myMA_50_1)
   )
     {
      if(enable_text == true)
        {
         shoting_s_1_b(arrow_name_up_shoting_s_1, time_up_shoting_s_1, price_up_shoting_s_1);
        }
      Send_Buy_Order("SST_1");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_shoting_s_1()  // shoting_s_1 SELL
  {
   int r;
   if(shoting_s_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      ((Open[1] < Close[1]) || (Open[1] > Close[1]))
      && Open[1] < Low[1] + ((High[1] - Low[1]) * 0.05)
      && (MathAbs(Close[1] - Open[1])) <= ((High[1] - Low[1]) * 0.6)
      && Open[2] <= Close[1]
      && Open[2] > Close[2]
      && Low[1] > Bands_down_1_1
      && Analys_EMA == 2
      && (High[1] < myMA_20_1 || High[1] < myMA_50_1)
   )
     {
      if(enable_text == true)
        {
         shoting_s_1_s(arrow_name_down_shoting_s_1, time_down_shoting_s_1, price_down_shoting_s_1);
        }
      Send_Sell_Order("SST_1");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }


//+------------------------------------------------------------------+_shoting_s_2
bool Check_Buy_Signal_shoting_s_2()  // shoting_s_2 BUY
  {
   int r;
   if(shoting_s_2 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      ((Open[1] < Close[1]) || (Open[1] > Close[1]))
      && Open[1] < Low[1] + ((High[1] - Low[1]) * 0.05)
      && (MathAbs(Close[1] - Open[1])) <= ((High[1] - Low[1]) * 0.6)
      && Open[2] <= Close[1]
      && Close[1] < Bands_MODE_MAIN_1
      && Open[2] < Close[2]
      && (High[1] > myMA_50_1 || High[1] > myMA_100_1)
   )
     {
      if(enable_text == true)
        {
         shoting_s_2_b(arrow_name_up_shoting_s_2, time_up_shoting_s_2, price_up_shoting_s_2);
        }
      Send_Buy_Order("SST_2");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_shoting_s_2()  // shoting_s_2 SELL
  {
   int r;
   if(shoting_s_2 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      ((Open[1] < Close[1]) || (Open[1] > Close[1]))
      && Open[1] < Low[1] + ((High[1] - Low[1]) * 0.05)
      && (MathAbs(Close[1] - Open[1])) <= ((High[1] - Low[1]) * 0.6)
      && Open[2] <= Close[1]
      && Open[2] > Close[2]
      && Low[1] > Bands_down_1_1
      && Analys_EMA == 2
      && (High[1] < myMA_50_1 || High[1] < myMA_100_1)
   )
     {
      if(enable_text == true)
        {
         shoting_s_2_s(arrow_name_down_shoting_s_2, time_down_shoting_s_2, price_down_shoting_s_2);
        }
      Send_Sell_Order("SST_2");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+_shoting_s_3
bool Check_Buy_Signal_shoting_s_3()  // shoting_s_3 BUY
  {
   int r;
   if(shoting_s_3 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      ((Open[1] < Close[1]) || (Open[1] > Close[1]))
      && Open[1] < Low[1] + ((High[1] - Low[1]) * 0.05)
      && (MathAbs(Close[1] - Open[1])) <= ((High[1] - Low[1]) * 0.6)
      && Open[2] <= Close[1]
      && Close[1] < Bands_MODE_MAIN_1
      && Open[2] < Close[2]
      && (High[1] > myMA_100_1 || High[1] > myMA_200_1)
   )
     {
      if(enable_text == true)
        {
         shoting_s_3_b(arrow_name_up_shoting_s_3, time_up_shoting_s_3, price_up_shoting_s_3);
        }
      Send_Buy_Order("SST_3");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_shoting_s_3()  // shoting_s_3 SELL
  {
   int r;
   if(shoting_s_3 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      ((Open[1] < Close[1]) || (Open[1] > Close[1]))
      && Open[1] < Low[1] + ((High[1] - Low[1]) * 0.05)
      && (MathAbs(Close[1] - Open[1])) <= ((High[1] - Low[1]) * 0.6)
      && Open[2] <= Close[1]
      && Open[2] > Close[2]
      && Low[1] > Bands_down_1_1
      && Analys_EMA == 2
      && (High[1] < myMA_100_1 || High[1] < myMA_200_1)
   )
     {
      if(enable_text == true)
        {
         shoting_s_3_s(arrow_name_down_shoting_s_3, time_down_shoting_s_3, price_down_shoting_s_3);
        }
      Send_Sell_Order("SST_3");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_shoting_s_4()  // shoting_s_4 SELL
  {
   int r;
   if(shoting_s_4 == true)
     {
      r = 1;
     }
   else
      return false;
//---
//---
   if(Open[1] >  Close[1]  &&
      (High[1] - Open[1]) >= (Open[1] - Close[1]) * 2 &&
      (High[1] - Open[1]) > (Close[1] - Low[1]) * 2 &&
      High[1] >= High[iHighest(NULL, 0, MODE_HIGH, shift_candel, 1)]
      && Open[1] - Close[1] >= 2 * Point
      && Close[1] - Low[1] <= ((High[1] - Open[1]) / 10)
     )
     {
      if(enable_text == true)
        {
         shoting_s_4_s(arrow_name_down_shoting_s_4, time_down_shoting_s_4, price_down_shoting_s_4);
        }
      Send_Sell_Order("SST_4");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+_marubozu
bool Check_Buy_Signal_marubozu()  // marubozu BUY
  {
   int r;
   if(marubozu == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /*if(
      ((Open[1] < Close[1]) || (Open[1] > Close[1]))
      && Open[1] < Low[1] + ((High[1] - Low[1]) * 0.05)
      && (MathAbs(Close[1] - Open[1])) <= ((High[1] - Low[1]) * 0.6)
      && Open[2] <= Close[1]
      && Close[1] < Bands_MODE_MAIN_1
      && Open[2] < Close[2]
      && (High[1] > myMA_100_1 || High[1] > myMA_200_1)
   )*/
   if(
      ((Open[1] > Close[1])
       && (Close[1] < High[1] - ((High[1] - Low[1]) * 0.02))
       && (Open[1] < High[1] + ((High[1] - Low[1]) * 0.02))
       && (MathAbs(Close[1] - Open[1])) < ((High[1] - Low[1]) * 0.95))
      && Open[1] > Bands_MODE_MAIN_1
      && Close[1] < Bands_MODE_MAIN_1
// && real_ > 20
      && Analys_EMA == 1)
     {
      if(enable_text == true)
        {
         marubozu_b(arrow_name_up_marubozu, time_up_marubozu, price_up_marubozu);
        }
      Send_Buy_Order("MA");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_marubozu()  // marubozu SELL
  {
   int r;
   if(marubozu == true)
     {
      r = 1;
     }
   else
      return false;
//---
   /* if(
       ((Open[1] < Close[1]) || (Open[1] > Close[1]))
       && Open[1] < Low[1] + ((High[1] - Low[1]) * 0.05)
       && (MathAbs(Close[1] - Open[1])) <= ((High[1] - Low[1]) * 0.6)
       && Open[2] <= Close[1]
       && Open[2] > Close[2]
       && Low[1] > Bands_down_1_1
       && Analys_EMA == 2
       && (High[1] < myMA_100_1 || High[1] < myMA_200_1)
    )*/
   if(
      (Open[1] < Close[1]
       && (Close[1] < High[1] - ((High[1] - Low[1]) * 0.02))
       && (Open[1] < High[1] + ((High[1] - Low[1]) * 0.02))
       && (MathAbs(Close[1] - Open[1])) < ((High[1] - Low[1]) * 0.95))
      && Open[1] < Bands_MODE_MAIN_1
      && Close[1] > Bands_MODE_MAIN_1
      && High[1] < Bands_up_2_2
// && real_ > 20
      && Analys_EMA == 2
//&& ema_put
   )
     {
      if(enable_text == true)
        {
         marubozu_s(arrow_name_down_marubozu, time_down_marubozu, price_down_marubozu);
        }
      Send_Sell_Order("MA");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+_dragonfly
bool Check_Buy_Signal_dragonfly()  // dragonfly BUY
  {
   int r;
   if(dragonfly == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(dragonfly == true)
     {
      if(Close[1] - Open[1]  < Close[2] - Open[2] && Close[2] - Open[2]  < Close[3] - Open[3] && Close[4] < Open[4])  // 3 سرباز
         return false;
     }
   else
      r = 1;
//---
   if(((Open[1] < Close[1] || Open[1] == Close[1]) /*&&  Open[2] > Close[2] &&  Open[3] > Close[3]*/
       && High[1] == Close[1]  && Low[1] != Open[1]
       && Open[1] - Low[1] > (Close[1] - Open[1]) * 3
       && (Close[1] < Open[2] || Close[1] <= Close[2])
       && ((Close[1] - Open[1] < 2 * Point) || (Open[1] - Low[1] >= ((Close[1] - Open[1]) * 10) && Close[1] - Open[1] <= 2 * Point))
       && Low[1] <= Bands_down_2_1 &&  Open[1] >= Bands_down_2_1
//  && Analys_EMA == 1
      )
      ||
//---
      ((Open[1] < Close[1]  || Open[1] == Close[1]) &&  Open[2] > Close[2] &&  Open[3] > Close[3]
       && High[1] == Close[1] && Low[1] != Open[1]
       && Close[1] - Open[1] < 2 * Point
       && Open[1] - Low[1] > (Close[1] - Open[1]) * 2
       && Analys_EMA == 1))
     {
      if(enable_text == true)
        {
         dragonfly_b(arrow_name_up_dragonfly, time_up_dragonfly, price_up_dragonfly);
        }
      Send_Buy_Order("DF");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_dragonfly()  // dragonfly SELL
  {
   int r;
   if(dragonfly == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(dragonfly == true)
     {
      if(Open[1] - Close[1]  < Open[2] - Close[2] && Open[2] - Close[2]  < Open[3] - Close[3] && Open[4] < Close[4])  // 3 کلاغ
         return false;
     }
   else
      r = 1;
//---
   if(((Open[1] > Close[1]  || Open[1] == Close[1]) /*&&  Open[2] < Close[2] &&  Open[3] < Close[3]*/
       && Low[1] == Close[1]
       && High[1] != Open[1]
       && High[1] - Open[1] > (Open[1] - Close[1]) * 3
       && (Close[1] > Open[2] || Close[1] >= Close[2])
       &&  Open[1] - Close[1] < 2 * Point
       && High[1] >= Bands_up_2_1 &&  Open[1] <= Bands_up_2_1
//  && Analys_EMA == 2
      )
      ||
      ((Open[1] > Close[1] || Open[1] == Close[1]) &&  Open[2] < Close[2] &&  Open[3] < Close[3]
       && Low[1] == Close[1] && High[1] != Open[1]
       &&  Open[1] - Close[1] < 2 * Point
       && High[1] - Open[1] > (Open[1] - Close[1]) * 2
       && Analys_EMA == 2))
     {
      if(enable_text == true)
        {
         dragonfly_s(arrow_name_down_dragonfly, time_down_dragonfly, price_down_dragonfly);
        }
      Send_Sell_Order("GS");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }

//+------------------------------------------------------------------+_gravestone
bool Check_Buy_Signal_gravestone()  // gravestone BUY
  {
   int r;
   if(gravestone == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(gravestone == true)
     {
      if(Open[2] - Close[2]  < Open[3] - Close[3] && Open[3] - Close[3]  < Open[4] - Close[4] && Open[5] < Close[5])  // 3 کلاغ
         return false;
     }
   else
      r = 1;
//---
   if(Open[1] < Close[1] &&  Open[2] > Close[2] &&  Open[3] > Close[3]
      && High[1] == Close[1] && Low[1] != Open[1]
      && Close[1] - Open[1] < 2 * Point
      && Open[1] - Low[1] > (Close[1] - Open[1]) * 2
      && Analys_EMA == 1)
     {
      if(enable_text == true)
        {
         gravestone_b(arrow_name_up_gravestone, time_up_gravestone, price_up_gravestone);
        }
      Send_Buy_Order("GS_U");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_gravestone()  // gravestone SELL
  {
   int r;
   if(gravestone == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(gravestone == true)
     {
      if(Close[2] - Open[2]  < Close[3] - Open[3] && Close[3] - Open[3]  < Close[4] - Open[4] && Close[5] > Open[5])  // 3 سرباز
         return false;
     }
   else
      r = 1;
//---
//---
   /* if((  Open[1] > Close[1])
          && Open[1] > Low[1] + ((High[1] - Low[1]) * 0.05)
          && (MathAbs(Close[1]-Open[1])) <= ((High[1]-Low[1]) * 0.4)
          && Close[3]>Open[3]
          && Close[2]>Open[2]
          && MathAbs(Close[1] - Open[1]) / point < 5
          && ((Low[1] == Open[1]) || (Low[1] != MathMin(Open[1], Close[1]) && MathMin(Open[1], Close[1]) - Low[1] <= (MathAbs(Close[1] - Open[1]) / point) / 5 ))
          && High[1] - MathMax(Open[1], Close[1]) < ((MathMin(Open[1], Close[1]) - Low[1]) * 3)
          && Analys_EMA == 2
      )*/
   if(Open[1] > Close[1] &&  Open[2] < Close[2] &&  Open[3] < Close[3]
      && Low[1] == Close[1] && High[1] != Open[1]
      &&  Open[1] - Close[1] < 2 * Point
      && High[1] - Open[1] > (Open[1] - Close[1]) * 2
      && Analys_EMA == 2)
     {
      if(enable_text == true)
        {
         gravestone_s(arrow_name_down_gravestone, time_down_gravestone, price_down_gravestone);
        }
      Send_Sell_Order("GS_D");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+_gap
bool Check_Buy_Signal_gap()  // gap BUY
  {
   int r;
   if(gap == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Volume[0] > 1)
      return (false);
// if((Low[1]>High[2]  && Low[1]>Low[2] && High[1]>High[2] && Open[1]!=Close[1]
// && MathAbs(Open[1]-Close[2]) > MathAbs(Open[2]- Close[2]) ))
   if(Close[0] > High[1] && Open[1] != Close[1] &&
      MathAbs(Close[0]  - Close[1]) > MathAbs(Close[1] - Open[1]))
     {
      if(enable_text == true)
        {
         gap_b(arrow_name_up_gap, time_up_gap, price_up_gap);
        }
      Send_Buy_Order("GU");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_gap()  // gap SELL
  {
   int r;
   if(gap == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Volume[0] > 1)
      return (false);
//if((Low[1]<High[2]  && Low[1]<Low[2] && High[1]<High[2] && Open[1]!=Close[1]
//&& MathAbs(Open[1]-Close[2]) > MathAbs(Open[2]- Close[2]) )&& Analys_EMA == 1)
   if(Close[0] < Low[1] && Open[1] != Close[1] &&
      MathAbs(Close[1] - Close[0]) > MathAbs(Open[1] - Close[1]))
     {
      if(enable_text == true)
        {
         gap_s(arrow_name_down_gap, time_down_gap, price_down_gap);
        }
      Send_Sell_Order("GD");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+_inverted_hammer
bool Check_Buy_Signal_inverted_hammer()  // inverted_hammer BUY
  {
   int r;
   if(inverted_hammer == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      (Open[1] > Close[1])
      && Open[1] < High[1] + ((High[1] - Low[1]) * 0.05)
      && (MathAbs(Close[1] - Open[1])) <= ((High[1] - Low[1]) * 0.6)
      &&  Open[2] > Close[1]
      && Analys_EMA == 1
      && Close[1] < Bands_MODE_MAIN_1
      && Open[2] < Close[2]
      && Open[3] < Close[3]
      &&  MathAbs(Close[1] - Open[1]) / point > 3 &&  MathAbs(Close[1] - Open[1]) / point < 6
   )
     {
      if(enable_text == true)
        {
         inverted_hammer_b(arrow_name_up_inverted_hammer, time_up_inverted_hammer, price_up_inverted_hammer);
        }
      Send_Buy_Order("IHA");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_inverted_hammer()  // inverted_hammer SELL
  {
   int r;
   if(inverted_hammer == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      (Open[1] < Close[1])
      && Open[1] < Low[1] + ((High[1] - Low[1]) * 0.05)
      && (MathAbs(Close[1] - Open[1])) <= ((High[1] - Low[1]) * 0.6)
      &&  Open[2] < Close[1]
      && Close[1] < Bands_MODE_MAIN_1
      && Open[2] > Close[2]
      && Open[3] > Close[3]
      &&  MathAbs(Close[1] - Open[1]) / point > 3 &&  MathAbs(Close[1] - Open[1]) / point < 6
   )
     {
      if(enable_text == true)
        {
         inverted_hammer_s(arrow_name_down_inverted_hammer, time_down_inverted_hammer, price_down_inverted_hammer);
        }
      Send_Sell_Order("IHA");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+_EES_1
bool Check_Buy_Signal_EES_1()  // EES_1 BUY
  {
   int r;
   if(EES_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] == Open[3]
      && (MathAbs(Open[3] - Close[3]) > MathAbs(Open[2] - Close[2]) * 5)
      && (Open[2] <=  Close[2] || Open[2] >= Close[2])
      && Open[1] > Close[1]
      && Open[3] < Close[3]
      &&  High[1] - MathMax(Open[1], Close[1]) <  MathAbs(Close[1] - Open[1]) / point
      &&  Analys_EMA == 2
      && MathAbs(Close[2] + Open[2]) > (44 / 100 * MathAbs(Close[3] - Open[3]))
   )
     {
      if(enable_text == true)
        {
         EES_1_b(arrow_name_up_EES_1, time_up_EES_1, price_up_EES_1);
        }
      Send_Buy_Order("EES_1");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_EES_1()  // EES_1 SELL
  {
   int r;
   if(EES_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] == Open[3]
      && (MathAbs(Open[3] - Close[3]) > MathAbs(Open[2] - Close[2]) * 5)
      && (Open[2] <=  Close[2] || Open[2] >= Close[2])
      && Open[1] > Close[1]
      && Open[3] < Close[3]
      &&  High[1] - MathMax(Open[1], Close[1]) <  MathAbs(Close[1] - Open[1]) / point
      &&  Analys_EMA == 1
      && MathAbs(Close[2] + Open[2]) > (44 / 100 * MathAbs(Close[3] - Open[3]))
   )
     {
      if(enable_text == true)
        {
         EES_1_s(arrow_name_down_EES_1, time_down_EES_1, price_down_EES_1);
        }
      Send_Sell_Order("EES_1");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+_EMS_1
bool Check_Buy_Signal_EMS_1()  // EMS_1 BUY
  {
   int r;
   if(EMS_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] == Open[3]
      && (MathAbs(Open[3] - Close[3]) > MathAbs(Open[2] - Close[2]) * 5)
      && (Open[2] <=  Close[2] || Open[2] >= Close[2])
      && Open[1] < Close[1]
      && Open[3] > Close[3]
      && Close[1] > Bands_down_1_1
      &&  High[1] - MathMax(Open[1], Close[1]) <  MathAbs(Close[1] - Open[1]) / point
      &&  Analys_EMA == 2
      && Close[4] > Open[4] && Close[3] < Open[3]
      && Close[2] < Open[3] && Close[1] > Close[2]
      && MathAbs(Close[2] + Open[2]) > (44 / 100 * MathAbs(Close[3] - Open[3]))
   )
     {
      if(enable_text == true)
        {
         EMS_1_b(arrow_name_up_EMS_1, time_up_EMS_1, price_up_EMS_1);
        }
      Send_Buy_Order("EMS_1");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_EMS_1()  // EMS_1 SELL
  {
   int r;
   if(EMS_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] == Open[3]
      && (MathAbs(Open[3] - Close[3]) > MathAbs(Open[2] - Close[2]) * 5)
      && (Open[2] <=  Close[2] || Open[2] >= Close[2])
      && Open[1] < Close[1]
      && Open[3] > Close[3]
      && Close[1] < Bands_up_1_1
      && High[1] - MathMax(Open[1], Close[1]) <  MathAbs(Close[1] - Open[1]) / point
      &&  Analys_EMA == 1
      && Close[4] < Open[4] && Close[3] < Open[3]
      && Close[2] < Open[3] && Close[1] > Close[2]
      && MathAbs(Close[2] + Open[2]) > (44 / 100 * MathAbs(Close[3] - Open[3]))
   )
     {
      if(enable_text == true)
        {
         EMS_1_s(arrow_name_down_EMS_1, time_down_EMS_1, price_down_EMS_1);
        }
      Send_Sell_Order("EMS_1");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+_NRS_1
bool Check_Buy_Signal_NRS_1()  // NRS_1 BUY
  {
   int r;
   if(NRS_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[3] > Open[3]
      && Close[3] == Open[2]
      && Close[2] < Open[2]
      && (Close[1] > Close[3]) && (Close[1] > Open[2])
      && Close[1] != High[1]
      && Close[1] > High[2]
      && Close[1] < Bands_up_1_1
      && Close[1] > Bands_down_1_1
      && ((Open[1] < myMA_20_1 && Close[1] > myMA_20_1)
          || (Open[1] < myMA_50_1 && Close[1] > myMA_50_1)
          || (Open[1] < myMA_100_1 && Close[1] > myMA_100_1)
          || (Open[1] < myMA_200_1 && Close[1] > myMA_200_1))
      && Analys_EMA == 2
   )
     {
      if(enable_text == true)
        {
         NRS_1_b(arrow_name_up_NRS_1, time_up_NRS_1, price_up_NRS_1);
        }
      Send_Buy_Order("NRS_1");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_NRS_1()  // NRS_1 SELL
  {
   int r;
   if(NRS_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[3] > Open[3]
      && Close[3] == Open[2]
      && Close[2] < Open[2]
      && (Close[1] > Close[3]) && (Close[1] > Open[2])
      && Close[1] != High[1]
      && Close[1] > High[2]
      && Close[1] < Bands_up_1_1
      && Close[1] > Bands_down_1_1
      && ((Open[1] < myMA_20_1 && Close[1] > myMA_20_1)
          || (Open[1] < myMA_50_1 && Close[1] > myMA_50_1)
          || (Open[1] < myMA_100_1 && Close[1] > myMA_100_1)
          || (Open[1] < myMA_200_1 && Close[1] > myMA_200_1))
      && Analys_EMA == 1
   )
     {
      if(enable_text == true)
        {
         NRS_1_s(arrow_name_down_NRS_1, time_down_NRS_1, price_down_NRS_1);
        }
      Send_Sell_Order("NRS_1");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+_MS50_1
bool Check_Buy_Signal_MS50_1()  // MS50_1 BUY
  {
   int r;
   if(MS50_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] == ((((Close[3] - Open[3]) * 50) / 100) + Open[3])
      && (MathAbs(Open[3] - Close[3]) > MathAbs(Open[2] - Close[2]) * 5)
      && (Open[2] <=  Close[2] || Open[2] >= Close[2])
      && Open[1] < Close[1]
      && Open[3] > Close[3]
      && Close[1] < Bands_up_1_1
      && (High[1] - MathMax(Open[1], Close[1]) / point)  < (MathAbs(Close[1] - Open[1]) / point)
      && Analys_EMA == 1
      && Close[4] < Open[4] && Close[3] < Open[3]
      && Close[2] < Open[3] && Close[1] > Close[2]
      && MathAbs(Close[2] + Open[2]) > (44 / 100 * MathAbs(Close[3] - Open[3]))
   )
     {
      if(enable_text == true)
        {
         MS50_1_b(arrow_name_up_MS50_1, time_up_MS50_1, price_up_MS50_1);
        }
      Send_Buy_Order("MS50_1");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_MS50_1()  // MS50_1 SELL
  {
   int r;
   if(MS50_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] == ((((Close[3] - Open[3]) * 50) / 100) + Open[3])
      && (MathAbs(Open[3] - Close[3]) > MathAbs(Open[2] - Close[2]) * 5)
      && (Open[2] <=  Close[2] || Open[2] >= Close[2])
      && Open[1] < Close[1]
      && Open[3] > Close[3]
      && Close[1] > Bands_down_1_1
      && (MathMin(Open[1], Close[1]) - Low[1]  / point) < (MathAbs(Close[1] - Open[1]) / point)
      && Analys_EMA == 2
      && Close[4] > Open[4] && Close[3] < Open[3]
      && Close[2] < Open[3] && Close[1] > Close[2]
      && MathAbs(Close[2] + Open[2]) > (44 / 100 * MathAbs(Close[3] - Open[3]))
   )
     {
      if(enable_text == true)
        {
         MS50_1_s(arrow_name_down_MS50_1, time_down_MS50_1, price_down_MS50_1);
        }
      Send_Sell_Order("MS50_1");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+_ES50_1
bool Check_Buy_Signal_ES50_1()  // ES50_1 BUY
  {
   int r;
   if(ES50_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] == ((((Close[3] - Open[3]) * 50) / 100) + Open[3])
      && (MathAbs(Open[3] - Close[3]) > MathAbs(Open[2] - Close[2]) * 5)
      && (Open[2] <=  Close[2] || Open[2] >= Close[2])
      && Open[1] > Close[1]
      && Open[3] < Close[3]
      && (High[1] - MathMax(Open[1], Close[1]) / point) > (MathAbs(Close[1] - Open[1]) / point)
      && Analys_EMA == 2
      && MathAbs(Close[2] + Open[2]) > (44 / 100 * MathAbs(Close[3] - Open[3]))
   )
     {
      if(enable_text == true)
        {
         ES50_1_b(arrow_name_up_ES50_1, time_up_ES50_1, price_up_ES50_1);
        }
      Send_Buy_Order("ES50_2");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_ES50_1()  // ES50_1 SELL
  {
   int r;
   if(ES50_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] == ((((Close[3] - Open[3]) * 50) / 100) + Open[3])
      && (MathAbs(Open[3] - Close[3]) > MathAbs(Open[2] - Close[2]) * 5)
      && (Open[2] <=  Close[2] || Open[2] >= Close[2])
      && Open[1] > Close[1]
      && Open[3] < Close[3]
      && (High[1] - MathMax(Open[1], Close[1]) / point) < (MathAbs(Close[1] - Open[1]) / point)
      && Analys_EMA == 1
      && MathAbs(Close[2] + Open[2]) > (44 / 100 * MathAbs(Close[3] - Open[3]))
   )
     {
      if(enable_text == true)
        {
         ES50_1_s(arrow_name_down_ES50_1, time_down_ES50_1, price_down_ES50_1);
        }
      Send_Sell_Order("MS50_2");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+_Hanging_man
bool Check_Buy_Signal_Hanging_man()  // Hanging_man BUY
  {
   int r;
   if(Hanging_man == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] < Close[1]
      /*

       Close[1] == ((((Close[3] - Open[3]) * 50) / 100) + Open[3])
            && (MathAbs(Open[3] - Close[3]) > MathAbs(Open[2] - Close[2])*5 )
                  && (Open[2] <=  Close[2] || Open[2]>= Close[2])
                  && Open[1] <Close[1]
                  && Open[3] > Close[3]
                  && Close[1]<Bands_up_1_1
                 && upper_ < real_
                 &&  ema_call
                && Close[4]<Open[4] && Close[3]<Open[3]
               && Close[2]<Open[3] && Close[1]>Close[2]
                  && MathAbs(Close[2] + Open[2]) > (44/100 * MathAbs(Close[3] - Open[3]))
      */
   )
     {
      if(enable_text == true)
        {
         Hanging_man_b(arrow_name_up_Hanging_man, time_up_Hanging_man, price_up_Hanging_man);
        }
      Send_Buy_Order("HM");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_Hanging_man()  // Hanging_man SELL
  {
   int r;
   if(Hanging_man == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      (Open[1] >  Close[1]  && (Close[1] - Low[1]) >= (Open[1] - Close[1]) * 2
       && (Close[1] - Low[1]) > (High[1] - Open[1]) * 10 && Open[1] - Close[1] >= (High[1] - Low[1]) / 10
       && (Open [1] - Close [1]) * 4.5 > Close[1] - Low[1]
       && Open[1] - Close[1] >= 2 * Point
      )
   )
     {
      if(enable_text == true)
        {
         Hanging_man_s(arrow_name_down_Hanging_man, time_down_Hanging_man, price_down_Hanging_man);
        }
      Send_Sell_Order("HM");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+_Harami
bool Check_Buy_Signal_Harami()  // Harami BUY
  {
   int r;
   if(Harami == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[2] > Close[2]
      && (Close[1] > Open[1] || Close[1] < Open[1])
      && Close[3] < Open[3]
      && Close[4] < Open[4]
      && Close[5] < Open[5]
      && MathAbs(Close[1] - Open[1]) < MathAbs(Open[2] - Close[2])
      && Open[1] < Close[1]
      && (MathMin(Open[1], Close[1]) - Low[1]  / point) > (High[1] - MathMax(Open[1], Close[1]) / point)
      && (MathAbs(Close[1] - Open[1])) <= ((High[1] - Low[1]) * 0.3)
      && Analys_EMA == 2
   )
     {
      if(enable_text == true)
        {
         Harami_b(arrow_name_up_Harami, time_up_Harami, price_up_Harami);
        }
      Send_Buy_Order("HA");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_Harami()  // Harami SELL
  {
   int r;
   if(Harami == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[2] < Close[2]
      && (Close[1] > Open[1] || Close[1] < Open[1])
      && Close[3] > Open[3]
      && Close[4] > Open[4]
      && Close[5] > Open[5]
      && MathAbs(Close[1] - Open[1]) > MathAbs(Open[2] - Close[2])
      && Open[1] > Close[1]
      && (MathMin(Open[1], Close[1]) - Low[1]  / point) < (High[1] - MathMax(Open[1], Close[1]) / point)
      && (MathAbs(Close[1] - Open[1])) <= ((High[1] - Low[1]) * 0.3)
      && Analys_EMA == 1
   )
     {
      if(enable_text == true)
        {
         Harami_s(arrow_name_down_Harami, time_down_Harami, price_down_Harami);
        }
      Send_Sell_Order("HA");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+_HHLL
bool Check_Buy_Signal_HHLL()  // HHLL BUY
  {
   int r;
   if(HHLL == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      High[1] < Bands_up_1_7_1
      && Close[1] > Close[2]
      && Open[1] > Open[2]
      && Open[2] < Close[2]
      && Open[1] < Close[1]
      && Close[2] < Open[3]
      && Close[1] > High[2]
      && Close[1] != High[1]
      && Close[1] != High[2]
      && Close[1] != High[3]
      && Close[1] != High[4]
      && Analys_EMA == 1
      && (MathAbs(Open[2] - Close[2]) > MathAbs(Open[1] - Close[1]))
      && MathAbs(Close[2] - Open[2]) > (22 / 100 * MathAbs(Close[3] - Open[3]))
      && MathAbs(Close[1] - Open[1]) > (44 / 100 * MathAbs(Close[2] - Open[2]))
   )
     {
      if(enable_text == true)
        {
         HHLL_b(arrow_name_up_HHLL, time_up_HHLL, price_up_HHLL);
        }
      Send_Buy_Order("HH");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_HHLL()  // HHLL SELL
  {
   int r;
   if(HHLL == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Low[1] > Bands_up_1_7_1
      && Close[1] < Close[2]
      && Open[1] < Open[2]
      && Open[2] > Close[2]
      && Open[1] > Close[1]
      && Close[2] > Open[3]
      && (MathAbs(Open[2] + Close[2]) > MathAbs(Open[1] + Close[1]))
   )
     {
      if(enable_text == true)
        {
         HHLL_s(arrow_name_down_HHLL, time_down_HHLL, price_down_HHLL);
        }
      Send_Sell_Order("LL");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//+------------------------------------------------------------------+_eng_1
bool Check_Buy_Signal_eng_1()  // eng_1 BUY
  {
   int r;
   if(eng_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[2] > Open[2]
      && Open[1] > Close[1]
      && Open[1] >= Close[2]
      && Open[2] >= Close[1]
      && Open[1] - Close[1] > Close[2] - Open[2]
      && Analys_EMA == 1
      && Close[1] < Low[2]
      && Close[3] > Open[3]
      && Close[4] > Open[4]
      && Close[5] > Open[5]
   )
     {
      if(enable_text == true)
        {
         eng_1_b(arrow_name_up_eng_1, time_up_eng_1, price_up_eng_1);
        }
      Send_Buy_Order("ENG1");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_eng_1()  // eng_1 SELL
  {
   int r;
   if(eng_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[2] > Close[2]
      && Close[1] > Open[1]
      && Close[1] >= Open[2]
      && Close[2] >= Open[1]
      && Close[1] - Open[1] > Open[2] - Close[2]
      && Analys_EMA == 2
      && Close[1] > High[2]
      && Close[3] < Open[3]
      && Close[4] < Open[4]
   )
     {
      if(enable_text == true)
        {
         eng_1_s(arrow_name_down_eng_1, time_down_eng_1, price_down_eng_1);
        }
      Send_Sell_Order("ENG1");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+//+------------------------------------------------------------------+_eng_2
bool Check_Buy_Signal_eng_2()  // eng_2 BUY
  {
   int r;
   if(eng_2 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[2] < Close[2]
      &&  Close[2] > Bands_up_2_1
      && Open[1] > Bands_up_2_1
      && Close[1] < Bands_up_2_1
      && (Close[1] < Low[2] * 1.3)
      && (Close[1] < Low[3] * 1.3)
      && Analys_EMA == 2
   )
     {
      if(enable_text == true)
        {
         eng_2_b(arrow_name_up_eng_2, time_up_eng_2, price_up_eng_2);
        }
      Send_Buy_Order("ENG2");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_eng_2()  // eng_2 SELL
  {
   int r;
   if(eng_2 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[2] < Close[2]
      && Close[1] < Bands_down_1_1
      &&  Close[2] > Bands_up_1_1
      && Open[1] > Bands_up_1_1
      && Close[1] < Bands_up_1_1
      && (Close[1] < Low[2] * 1.3)
      && (Close[1] < Low[3] * 1.3)
      && Analys_EMA == 2
   )
     {
      if(enable_text == true)
        {
         eng_2_s(arrow_name_down_eng_2, time_down_eng_2, price_down_eng_2);
        }
      Send_Sell_Order("ENG2");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+//+------------------------------------------------------------------+_eng_3
bool Check_Buy_Signal_eng_3()  // eng_3 BUY
  {
   int r;
   if(eng_3 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[2] > Close[2]
      && Close[1] < Bands_down_1_1
      && Open[2] < Bands_down_1_1
      && (Analys_EMA == 2 || Analys_EMA == 3)
      && Close[1] > High[2]
      && Close[1] > High[3]
      && Close[3] < Open[3]
      && Close[4] < Open[4]
      && Close[5] < Open[5]
   )
     {
      if(enable_text == true)
        {
         eng_3_b(arrow_name_up_eng_3, time_up_eng_3, price_up_eng_3);
        }
      Send_Buy_Order("ENG3");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_eng_3()  // eng_3 SELL
  {
   int r;
   if(eng_3 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[2] < Close[2]
      &&  Close[1] > Bands_up_1_1
      && Open[2] > Bands_up_1_1
      && (Analys_EMA == 1 || Analys_EMA == 3)
      && Close[1] < Low[2]
      && Close[1] < Low[3]
      && Close[3] > Open[3]
      && Close[4] > Open[4]
      && Close[5] > Open[5]
   )
     {
      if(enable_text == true)
        {
         eng_3_s(arrow_name_down_eng_3, time_down_eng_3, price_down_eng_3);
        }
      Send_Sell_Order("ENG3");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//+------------------------------------------------------------------+_eng_4
bool Check_Buy_Signal_eng_4()  // eng_4 BUY
  {
   int r;
   if(eng_4 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      High[1] < Bands_up_2_1
      && Close[2] < Open[2]
      && Open[1] < Close[1]
      &&   Close[1] > Open[2]
      && Close[1] > High[3]
      && Close[1] > High[2]
      && Close[1] > myMA_20_1
      && Close[2] < myMA_20_1
      && Open[1] < myMA_20_1
      && myMA_200_1 < myMA_100_1
      && myMA_100_1 < myMA_50_1
      && myMA_50_1 < myMA_20_1
      && Close[1] > High[2]
      && Close[1] > High[3]
      && Close[3] < Open[3]
      && Close[4] < Open[4]
      && Close[5] > Open[5]
   )
     {
      if(enable_text == true)
        {
         eng_4_b(arrow_name_up_eng_4, time_up_eng_4, price_up_eng_4);
        }
      Send_Buy_Order("ENG4");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_eng_4()  // eng_4 SELL
  {
   int r;
   if(eng_4 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Low[1] > Bands_down_2_1
      && Close[2] > Open[2]
      && Open[1] > Close[1]
      &&   Close[1] < Open[2]
      && Close[1] < Low[3]
      && Close[1] < Low[2]
      && Close[1] < myMA_20_1
      && Close[2] > myMA_20_1
      && Open[1] > myMA_20_1
      && myMA_200_1 > myMA_100_1
      && myMA_100_1 > myMA_50_1
      && myMA_50_1 > myMA_20_1
      && Close[1] < Low[2]
      && Close[1] < Low[3]
      && Close[3] > Open[3]
      && Close[4] > Open[4]
      && Close[5] < Open[5]
   )
     {
      if(enable_text == true)
        {
         eng_4_s(arrow_name_down_eng_4, time_down_eng_4, price_down_eng_4);
        }
      Send_Sell_Order("ENG4");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//+------------------------------------------------------------------+_eng_5
bool Check_Buy_Signal_eng_5()  // eng_5 BUY
  {
   int r;
   if(eng_5 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] < Bands_up_2_1
      && Close[2] < Open[2]
      && Open[1] < Close[1]
      &&   Close[1] > Open[2]
      && Close[1] > High[3]
      && Close[1] > High[2]
      && Close[1] > myMA_50_1
      && Close[2] < myMA_50_1
      && Open[1] < myMA_50_1
      && myMA_200_1 < myMA_100_1
      && myMA_100_1 < myMA_50_1
      && Close[3] < Open[3]
      && Close[4] < Open[4]
      && MathAbs(Close[1] - Open[1]) / point < 30
      && Close[1] > High[2]
      && Close[1] > High[3]
      && Close[3] < Open[3]
      && Close[4] < Open[4]
   )
     {
      if(enable_text == true)
        {
         eng_5_b(arrow_name_up_eng_5, time_up_eng_5, price_up_eng_5);
        }
      Send_Buy_Order("ENG5");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_eng_5()  // eng_5 SELL
  {
   int r;
   if(eng_5 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] > Bands_down_2_1
      && Close[2] > Open[2]
      && Open[2] > Close[1]
      &&   Close[1] < Open[2]
      && Close[1] < Low[3]
      && Close[1] < Low[2]
      && Close[1] < myMA_50_1
      && Close[2] < myMA_50_1
      && Open[1] < myMA_50_1
      && myMA_200_1 > myMA_100_1
      && myMA_100_1 > myMA_50_1
      && Close[3] > Open[3]
      && Close[4] > Open[4]
      && MathAbs(Close[1] - Open[1]) / point < 30
      && Close[1] < Low[2]
      && Close[1] < Low[3]
      && Close[3] > Open[3]
      && Close[4] > Open[4]
   )
     {
      if(enable_text == true)
        {
         eng_5_s(arrow_name_down_eng_5, time_down_eng_5, price_down_eng_5);
        }
      Send_Sell_Order("ENG5");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//+------------------------------------------------------------------+_eng_6
bool Check_Buy_Signal_eng_6()  // eng_6 BUY
  {
   int r;
   if(eng_6 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] < Bands_down_1_1
      && Close[2] > Open[2]
      && Open[2] > Close[1]
      &&   Close[1] < Open[2]
      && Close[1] < myMA_100_1
      && Close[2] < myMA_100_1
      && Open[1] < myMA_100_1
      && myMA_200_1 > myMA_100_1
      && Close[3] > Open[3]
      && Close[4] > Open[4]
      && MathAbs(Close[1] - Open[1]) / point < 20
      && Close[1] < Low[2]
      && Close[1] < Low[3]
      && Close[3] > Open[3]
      && Close[4] > Open[4] &&
      Close[5] < Open[5]
   )
     {
      if(enable_text == true)
        {
         eng_6_b(arrow_name_up_eng_6, time_up_eng_6, price_up_eng_6);
        }
      Send_Buy_Order("ENG6");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_eng_6()  // eng_6 SELL
  {
   int r;
   if(eng_6 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] > Bands_up_1_1
      && Close[2] < Open[2]
      && Open[1] < Close[1]
      &&   Close[1] > Open[2]
      && Close[1] > High[3]
      && Close[1] > High[2]
      && Close[1] > myMA_100_1
      && Close[2] < myMA_100_1
      && Open[1] < myMA_100_1
      && myMA_200_1 < myMA_100_1
      && Close[3] < Open[3]
      && Close[4] < Open[4]
      && MathAbs(Close[1] - Open[1]) / point < 20
      && Close[1] > High[2]
      && Close[1] > High[3]
      && Close[3] < Open[3]
      && Close[4] < Open[4]
      && Close[5] > Open[5]
   )
     {
      if(enable_text == true)
        {
         eng_6_s(arrow_name_down_eng_6, time_down_eng_6, price_down_eng_6);
        }
      Send_Sell_Order("ENG6");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//+------------------------------------------------------------------+_eng_7
bool Check_Buy_Signal_eng_7()  // eng_7 BUY
  {
   int r;
   if(eng_7 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] < Bands_down_1_1
      && Low[1] > Bands_down_1_7_1
      && Close[2] > Open[2]
      && Open[2] > Close[1]
      && Close[1] < Open[2]
      && Close[1] < myMA_200_1
      && Close[2] < myMA_200_1
      && Open[1] < myMA_200_1
      && myMA_200_1 > myMA_100_1
      && Close[3] > Open[3]
      && Close[4] > Open[4]
      && MathAbs(Close[1] - Open[1]) / point < 30
      && Close[1] < Low[2]
      && Close[1] < Low[3]
      && Close[3] > Open[3]
      && Close[4] > Open[4]
      && Close[5] < Open[5]
   )
     {
      if(enable_text == true)
        {
         eng_7_b(arrow_name_up_eng_7, time_up_eng_7, price_up_eng_7);
        }
      Send_Buy_Order("ENG7");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_eng_7()  // eng_7 SELL
  {
   int r;
   if(eng_7 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close [1] > Bands_up_1_1
      && High[1] < Bands_up_1_7_1
      && Close[2] < Open[2]
      && Open[2] < Close[1]
      &&   Close[1] > Open[2]
      && Close[1] > High[3]
      && Close[1] > High[2]
      && Close[1] > myMA_200_1
      && Close[2] < myMA_200_1
      && Open[1] < myMA_200_1
      && myMA_200_1 < myMA_100_1
      && Close[3] < Open[3]
      && Close[4] < Open[4]
      && MathAbs(Close[1] - Open[1]) / point < 30
      && Close[1] > High[2]
      && Close[1] > High[3]
      && Close[3] < Open[3]
      && Close[4] < Open[4]
      && Close[5] > Open[5]
   )
     {
      if(enable_text == true)
        {
         eng_7_s(arrow_name_down_eng_7, time_down_eng_7, price_down_eng_7);
        }
      Send_Sell_Order("ENG7");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//+------------------------------------------------------------------+_dc_1
bool Check_Buy_Signal_dc_1()  // dc_1 BUY
  {
   int r;
   if(dc_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[1] < Close[2]
      && Close[1] > Close[2]
      && Close[1] < Open[2]
      && Close[2] < Open[2]
      && Close[3] < Open[3]
      && Close[4] < Open[4]
      && ((Open[2] + Close[2]) / 2) < Close[1]
      && Analys_EMA == 2
      && Close[1] < Bands_down_1_1
   )
     {
      if(enable_text == true)
        {
         dc_1_b(arrow_name_up_dc_1, time_up_dc_1, price_up_dc_1);
        }
      Send_Buy_Order("DC1");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_dc_1()  // dc_1 SELL
  {
   int r;
   if(dc_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[1] > Close[1]
      && Close[1] > Open[2]
      && Close[1] < Close[2]
      && Close[2] > Open[2]
      && Close[3] > Open[3]
      && Close[4] > Open[4]
      && ((Close[2] + Open[2]) / 2) > Close[1]
      && Analys_EMA == 1
      && Close[1] > Bands_up_1_1
   )
     {
      if(enable_text == true)
        {
         dc_1_s(arrow_name_down_dc_1, time_down_dc_1, price_down_dc_1);
        }
      Send_Sell_Order("PL1");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+//+------------------------------------------------------------------+_dc_2
bool Check_Buy_Signal_dc_2()  // dc_2 BUY
  {
   int r;
   if(dc_2 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[1] > Close[1]
      && Close[1] > Open[2]
      && Close[1] < Close[2]
      && Close[2] > Open[2]
      && Close[3] > Open[3]
      && Close[4] > Open[4]
      && ((Close[2] + Open[2]) / 2) > Close[1]
      && Analys_EMA == 2
      && Close[1] > Bands_up_1_1
   )
     {
      if(enable_text == true)
        {
         dc_2_b(arrow_name_up_dc_2, time_up_dc_2, price_up_dc_2);
        }
      Send_Buy_Order("DC2");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_dc_2()  // dc_2 SELL
  {
   int r;
   if(dc_2 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[1] < Close[2]
      && Close[1] > Close[2]
      && Close[1] < Open[2]
      && Close[2] < Open[2]
      && Close[3] < Open[3]
      && Close[4] < Open[4]
      && ((Open[2] + Close[2]) / 2) < Close[1]
      && Analys_EMA == 1
      && Close[1] > Bands_down_1_1
      && Close[1] < Bands_up_1_1
   )
     {
      if(enable_text == true)
        {
         dc_2_s(arrow_name_down_dc_2, time_down_dc_2, price_down_dc_2);
        }
      Send_Sell_Order("PL2");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//-------------------------------+//+------------------------------------------------------------------+_huge_candle_1
bool Check_Buy_Signal_huge_candle_1()  // huge_candle_1 BUY
  {
   int r;
   if(huge_candle_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] < Bands_down_2_1
      && Close[1] < Open[1]
      && Close[2] < Open[2]
      && MathAbs(Open[1] - Close[1]) > MathAbs(Open[2] - Close[2])
   )
     {
      if(enable_text == true)
        {
         huge_candle_1_b(arrow_name_up_huge_candle_1, time_up_huge_candle_1, price_up_huge_candle_1);
        }
      Send_Buy_Order("HC1");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_huge_candle_1()  // huge_candle_1 SELL
  {
   int r;
   if(huge_candle_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[1] > Bands_up_2_1
      && Close[1] > Open[1]
      &&  Close[2] > Open[2]
      && MathAbs(Open[1] - Close[1]) > MathAbs(Open[2] - Close[2])
   )
     {
      if(enable_text == true)
        {
         huge_candle_1_s(arrow_name_down_huge_candle_1, time_down_huge_candle_1, price_down_huge_candle_1);
        }
      Send_Sell_Order("HC1");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+//-------------------------------+//+------------------------------------------------------------------+_huge_candle_2
bool Check_Buy_Signal_huge_candle_2()  // huge_candle_2 BUY
  {
   int r;
   if(huge_candle_2 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[3] < Open[3]
      && (MathAbs(Close[2] - Open[2]) * 100000) < 3
      &&  Close[1] < myMA_20_1
      && Close[4] > Open[4]
      && MathAbs(Open[1] - Close[1]) > MathAbs(Open[2] - Close[2])
   )
     {
      if(enable_text == true)
        {
         huge_candle_2_b(arrow_name_up_huge_candle_2, time_up_huge_candle_2, price_up_huge_candle_2);
        }
      Send_Buy_Order("HC2");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_huge_candle_2()  // huge_candle_2 SELL
  {
   int r;
   if(huge_candle_2 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[3] > Open[3]
      && (MathAbs(Close[2] - Open[2]) * 100000) < 3
      && Close[1] > myMA_20_1
      && Close[4] < Open[4]
      && MathAbs(Open[1] - Close[1]) > MathAbs(Open[2] - Close[2])
   )
     {
      if(enable_text == true)
        {
         huge_candle_2_s(arrow_name_down_huge_candle_2, time_down_huge_candle_2, price_down_huge_candle_2);
        }
      Send_Sell_Order("HC2");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//-------------------------------+
bool Check_Buy_Signal_huge_candle_3()  // huge_candle_3 BUY
  {
   int r;
   if(huge_candle_3 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[3] < Open[3]
      && (MathAbs(Close[2] - Open[2]) * 100000) < 2
      && Close[4] > Open[4]
      && MathAbs(Open[1] - Close[1]) > MathAbs(Open[2] - Close[2])
      && Open[1] < Bands_down_1_1
      && Close[1] > Bands_down_1_1
      && Close[1] < myMA_20_1
   )
     {
      if(enable_text == true)
        {
         huge_candle_3_b(arrow_name_up_huge_candle_3, time_up_huge_candle_3, price_up_huge_candle_3);
        }
      Send_Buy_Order("HC3");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_huge_candle_3()  // huge_candle_3 SELL
  {
   int r;
   if(huge_candle_3 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Close[3] > Open[3]
      && (MathAbs(Close[2] - Open[2]) * 100000) < 2
      && Close[4] < Open[4]
      && MathAbs(Open[1] - Close[1]) > MathAbs(Open[2] - Close[2])
      && Open[1] > Bands_up_1_1
      && Close[1] < Bands_up_1_1
      && Close[1] > myMA_20_1
   )
     {
      if(enable_text == true)
        {
         huge_candle_3_s(arrow_name_down_huge_candle_3, time_down_huge_candle_3, price_down_huge_candle_3);
        }
      Send_Sell_Order("HC3");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//-------------------------------+
bool Check_Buy_Signal_ms_buy_1_es_1()  // ms_buy_1_es_1 BUY
  {
   int r;
   if(ms_buy_1_es_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[3] > Close[3]
      && Close[3] > Close[2]
      && Close[3] > Open[2]
      && Open[1] < Close[1]
      && Open[1] > Open[2]
      && MathAbs(Close[2] - Open[2])  < (33 / 100 * MathAbs(Close[3] - Open[3]))
   )
     {
      if(enable_text == true)
        {
         ms_buy_1_es_1_b(arrow_name_up_ms_buy_1_es_1, time_up_ms_buy_1_es_1, price_up_ms_buy_1_es_1);
        }
      Send_Buy_Order("ES1");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_ms_buy_1_es_1()  // ms_buy_1_es_1 SELL
  {
   int r;
   if(ms_buy_1_es_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[3] < Close[3]
      && Close[3] < Close[2]
      && Close[3] < Open[2]
      && Open[1] > Close[1]
      && Open[1] < Open[2]
      && MathAbs(Close[2] + Open[2]) > (33 / 100 * MathAbs(Close[3] - Open[3]))
      && Close[1] < Open[3]
      && Open[1] < myMA_20_1
      && Close[2] < myMA_20_1
      && Low[1] > Bands_down_1_7_1
   )
     {
      if(enable_text == true)
        {
         ms_buy_1_es_1_s(arrow_name_down_ms_buy_1_es_1, time_down_ms_buy_1_es_1, price_down_ms_buy_1_es_1);
        }
      Send_Sell_Order("MS1");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//-------------------------------+
bool Check_Buy_Signal_ms_buy_1_es_2()  // ms_buy_1_es_2 BUY
  {
   int r;
   if(ms_buy_1_es_2 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[3] < Close[3]
      && Close[3] < Close[2]
      && Close[3] < Open[2]
      && Open[1] > Close[1]
      && Open[1] < Open[2]
      &&  MathAbs(Close[2] + Open[2]) > (33 / 100 * MathAbs(Close[3] - Open[3]))
      && Open[1] < myMA_20_1
      && Close[2] < myMA_20_1
      && Low[1] > Bands_down_1_7_1
   )
     {
      if(enable_text == true)
        {
         ms_buy_1_es_2_b(arrow_name_up_ms_buy_1_es_2, time_up_ms_buy_1_es_2, price_up_ms_buy_1_es_2);
        }
      Send_Buy_Order("ES2");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_ms_buy_1_es_2()  // ms_buy_1_es_2 SELL
  {
   int r;
   if(ms_buy_1_es_2 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[3] > Close[3]
      && Close[3] > Close[2]
      && Close[3] > Open[2]
      && Open[1] < Close[1]
      && Open[1] > Open[2]
      && MathAbs(Close[2] - Open[2])  < (33 / 100 * MathAbs(Close[3] - Open[3]))
      && Open[1] > myMA_20_1
      && Close[2] > myMA_20_1
      && High[1] < Bands_up_1_7_1
   )
     {
      if(enable_text == true)
        {
         ms_buy_1_es_2_s(arrow_name_down_ms_buy_1_es_2, time_down_ms_buy_1_es_2, price_down_ms_buy_1_es_2);
        }
      Send_Sell_Order("MS2");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//-------------------------------+
bool Check_Buy_Signal_tws_put_1_tbc()  // tws_put_1_tbc BUY
  {
   int r;
   if(tws_put_1_tbc == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[4] > Close[4]
      &&  Open[3] < Close[3]
      && Open[2] < Close[2]
      && Open[1] < Close[1]
      && Close[3] < Close[2]
      && Close[2] < Close[1]
      && Close[2] - Open[2] > Close[3] - Open[3]
      && Analys_EMA == 2
   )
     {
      if(enable_text == true)
        {
         tws_put_1_tbc_b(arrow_name_up_tws_put_1_tbc, time_up_tws_put_1_tbc, price_up_tws_put_1_tbc);
        }
      Send_Buy_Order("TWS1");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_tws_put_1_tbc()  // tws_put_1_tbc SELL
  {
   int r;
   if(tws_put_1_tbc == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[3] > Close[3]
      && Close[3] > Close[2]
      && Close[3] > Open[2]
      && Open[1] < Close[1]
      && Open[1] > Open[2]
      && MathAbs(Close[2] - Open[2])  < (33 / 100 * MathAbs(Close[3] - Open[3]))
      && Open[1] > myMA_20_1
      && Close[2] > myMA_20_1
      && High[1] < Bands_up_1_7_1
   )
     {
      if(enable_text == true)
        {
         tws_put_1_tbc_s(arrow_name_down_tws_put_1_tbc, time_down_tws_put_1_tbc, price_down_tws_put_1_tbc);
        }
      Send_Sell_Order("TBC1");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+//-------------------------------+
bool Check_Buy_Signal_tws_put_2_tbc()  // tws_put_2_tbc BUY
  {
   int r;
   if(tws_put_2_tbc == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[4] < Close[4]
      &&  Open[3] > Close[3]
      && Open[2] > Close[2]
      && Open[1] > Close[1]
      && Close[3] > Close[2]
      && Close[2] > Close[1]
      && Close[2] - Open[2] > Close[3] - Open[3]
      && Analys_EMA == 2
      && Close[1] < Bands_down_1_7_1
   )
     {
      if(enable_text == true)
        {
         tws_put_2_tbc_b(arrow_name_up_tws_put_2_tbc, time_up_tws_put_2_tbc, price_up_tws_put_2_tbc);
        }
      Send_Buy_Order("TWS2");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_tws_put_2_tbc()  // tws_put_2_tbc SELL
  {
   int r;
   if(tws_put_2_tbc == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[4] > Close[4]
      &&  Open[3] < Close[3]
      && Open[2] < Close[2]
      && Open[1] < Close[1]
      && Close[3] < Close[2]
      && Close[2] < Close[1]
      && Close[2] - Open[2] > Close[3] - Open[3]
      && Analys_EMA == 1
      && Close[1] > Bands_up_1_7_1
   )
     {
      if(enable_text == true)
        {
         tws_put_2_tbc_s(arrow_name_down_tws_put_2_tbc, time_down_tws_put_2_tbc, price_down_tws_put_2_tbc);
        }
      Send_Sell_Order("TBC2");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+//-------------------------------+
bool Check_Buy_Signal_tws_put_3_tbc()  // tws_put_3_tbc BUY
  {
   int r;
   if(tws_put_3_tbc == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[4] < Close[4]
      &&  Open[3] > Close[3]
      && Open[2] > Close[2]
      && Open[1] > Close[1]
      && Close[3] > Close[2]
      && Close[2] > Close[1]
      && Close[2] - Open[2] > Close[3] - Open[3]
      && Analys_EMA == 3
      && Close[1] < Bands_down_2_1
   )
     {
      if(enable_text == true)
        {
         tws_put_3_tbc_b(arrow_name_up_tws_put_3_tbc, time_up_tws_put_3_tbc, price_up_tws_put_3_tbc);
        }
      Send_Buy_Order("TWS3");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_tws_put_3_tbc()  // tws_put_3_tbc SELL
  {
   int r;
   if(tws_put_3_tbc == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[4] > Close[4]
      &&  Open[3] < Close[3]
      && Open[2] < Close[2]
      && Open[1] < Close[1]
      && Close[3] < Close[2]
      && Close[2] < Close[1]
      && Close[2] - Open[2] > Close[3] - Open[3]
      && Analys_EMA == 3
      && Close[1] > Bands_up_2_1
   )
     {
      if(enable_text == true)
        {
         tws_put_3_tbc_s(arrow_name_down_tws_put_3_tbc, time_down_tws_put_3_tbc, price_down_tws_put_3_tbc);
        }
      Send_Sell_Order("TBC3");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+//-------------------------------+
bool Check_Buy_Signal_tws_put_4_tbc()  // tws_put_4_tbc BUY
  {
   int r;
   if(tws_put_4_tbc == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[4] < Close[4]
      &&  Open[3] > Close[3]
      && Open[2] > Close[2]
      && Open[1] > Close[1]
      && Close[3] > Close[2]
      && Close[2] > Close[1]
      && Close[2] - Open[2] > Close[3] - Open[3]
      && Analys_EMA == 3
      && Close[1] > Bands_down_1_1
      && MathAbs(Open[3] - Close[3]) > MathAbs(Open[2] - Close[2])
      &&  MathAbs(Open[2] - Close[2]) >   MathAbs(Open[1] - Close[1])
   )
     {
      if(enable_text == true)
        {
         tws_put_4_tbc_b(arrow_name_up_tws_put_4_tbc, time_up_tws_put_4_tbc, price_up_tws_put_4_tbc);
        }
      Send_Buy_Order("TWS4");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_tws_put_4_tbc()  // tws_put_4_tbc SELL
  {
   int r;
   if(tws_put_4_tbc == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[4] > Close[4]
      &&  Open[3] < Close[3]
      && Open[2] < Close[2]
      && Open[1] < Close[1]
      && Close[3] < Close[2]
      && Close[2] < Close[1]
      && Close[2] - Open[2] > Close[3] - Open[3]
      && Analys_EMA == 3
      && Close[1] < Bands_up_1_1
      && Close[1] > myMA_20_1
      && MathAbs(Open[3] - Close[3]) > MathAbs(Open[2] - Close[2])
      &&  MathAbs(Open[2] - Close[2]) >   MathAbs(Open[1] - Close[1])
   )
     {
      if(enable_text == true)
        {
         tws_put_4_tbc_s(arrow_name_down_tws_put_4_tbc, time_down_tws_put_4_tbc, price_down_tws_put_4_tbc);
        }
      Send_Sell_Order("TBC4");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//-------------------------------+//-------------------------------+
bool Check_Buy_Signal_Hammer()  // Hammer BUY
  {
   int r;
   if(Hammer == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(Open[1] <  Close[1]  && (Open[1] - Low[1]) >= (Close[1] - Open[1]) * 2
      && (Open[1] - Low[1]) > (High[1] - Close[1]) * 10 && Close[1] - Open[1] >= (High[1] - Low[1]) / 10
      && Low[1] <= (Low[iLowest(NULL, 0, MODE_LOW, shift_candel, 1)])
      && (Close [1] - Open [1]) * 4.5 > Open[1] - Low[1]
      && Close[1] - Open[1] >= 2 * Point
     )
      // if(Open[1] <  Close[1]  &&  Close[1] - Open[1] >= ((High[1] - Low[1]) * 3) / 10 &&  Close[1] - Open[1] <= ((High[1] - Low[1]) * 2) / 10
      // && High[1] - Close[1] <= ((High[1] - Low[1]) * 1) / 10
      //&& High[1] - Close[1] <= (Open[1] - Low[1]) / 20
      // && Open[1] - Low[1] >= (Close[1] - Open[1]) * 3
      // && Low[1] <= (Low[iLowest(NULL, 0, MODE_LOW, sheft_candel, 1)])
      //  )
     {
      if(enable_text == true)
        {
         Hammer_b(arrow_name_up_Hammer, time_up_Hammer, price_up_Hammer);
        }
      Send_Buy_Order("HA");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Buy_Signal_G_Hammer_call()  // G_Hammer BUY
  {
   int r;
   if(G_Hammer == true)
     {
      r = 1;
     }
   else
      return false;
//---
//if(Open[1] >  Close[1]  && (High[1] - Open[1]) >= (Open[1] - Close[1]) * 4
//&& (High[1] - Open[1]) > (Close[1] - Low[1]) * 10 &&  Open[1] -  Close[1] >= (High[1] - Low[1]) / 10
// && High[1] >= High[iHighest(NULL, 0, MODE_HIGH, sheft_candel, 1)])
   if(Open[1] <  Close[1]  && (Open[1] - Low[1]) >= (Close[1] - Open[1]) * 2
      && (Open[1] - Low[1]) > (High[1] - Close[1]) * 10 && Close[1] - Open[1] >= (High[1] - Low[1]) / 10
      && (Close [1] - Open [1]) * 4.5 > Open[1] - Low[1]
      && Close[1] - Open[1] >= 2 * Point
     )
     {
      if(enable_text == true)
        {
         G_Hammer_b(arrow_name_up_Hammer, time_up_Hammer, price_up_Hammer);
        }
      Send_Buy_Order("HAC");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//-------------------------------+//-------------------------------+
bool Check_Buy_Signal_twzb_call_1_twzt_put()  // twzb_call_1_twzt_put BUY
  {
   int r;
   if(twzb_call_1_twzt_put == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      High[3] > High[2]
      && Low[3] > Low[2]
      && Open[2] > Close[2]
      && Open[1] < Close[1]
      && Low[2] == Low[1]
      && Close[1] != Low[1]
      && (Close[2] < Open[2])
      && (Close[3] < Open[3])
      && Low[1] < Bands_down_2_1
   )
     {
      if(enable_text == true)
        {
         twzb_call_1_twzt_put_b(arrow_name_up_twzb_call_1_twzt_put, time_up_twzb_call_1_twzt_put, price_up_twzb_call_1_twzt_put);
        }
      Send_Buy_Order("TWZB");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_twzb_call_1_twzt_put()  // twzb_call_1_twzt_put SELL
  {
   int r;
   if(twzb_call_1_twzt_put == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Low[3] < Low[2]
      && High[3] < High[2]
      && Open[2] < Close[2]
      && Open[1] > Close[1]
      && High[2] == High[1]
      && Open[1] != High[1]
      && (Close[2] > Open[2])
      && (Close[3] > Open[3])
      && High[1] > Bands_up_2_1
   )
     {
      if(enable_text == true)
        {
         twzb_call_1_twzt_put_s(arrow_name_down_twzb_call_1_twzt_put, time_down_twzb_call_1_twzt_put, price_down_twzb_call_1_twzt_put);
        }
      Send_Sell_Order("TWZT");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//-------------------------------+//-------------------------------+
bool Check_Buy_Signal_call_reversal_put_reversal()  // call_reversal_put_reversal BUY
  {
   int r;
   if(call_reversal_put_reversal == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
//Close[1]<Close[1]
      Close[2] < Open[2]
      && Close[1] > Open[1]
      && Close[1] > Open[2]
      && (iLowest(NULL, 0, MODE_LOW, 3) < iLowest(NULL, 0, MODE_LOW, 50, 2) ||
          iLowest(NULL, 0, MODE_LOW, 3) < iLowest(NULL, 0, MODE_LOW, 50, 3) ||
          iLowest(NULL, 0, MODE_LOW, 3) < iLowest(NULL, 0, MODE_LOW, 50, 4))
      && Close[1] < Bands_down_1_1
   )
     {
      if(enable_text == true)
        {
         call_reversal_put_reversal_b(arrow_name_up_call_reversal_put_reversal, time_up_call_reversal_put_reversal, price_up_call_reversal_put_reversal);
        }
      Send_Buy_Order("RC");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_call_reversal_put_reversal()  // call_reversal_put_reversal SELL
  {
   int r;
   if(call_reversal_put_reversal == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
//Close[1]<Close[1]
      Close[2] > Open[2]
      && Close[1] < Open[1]
      && Close[1] < Open[2]
      && (iHighest(NULL, 0, MODE_HIGH, 3) < iHighest(NULL, 0, MODE_HIGH, 50, 2) ||
          iHighest(NULL, 0, MODE_HIGH, 3) < iHighest(NULL, 0, MODE_HIGH, 50, 3) ||
          iHighest(NULL, 0, MODE_HIGH, 3) < iHighest(NULL, 0, MODE_HIGH, 50, 4))
      && Close[1] > Bands_up_1_1
   )
     {
      if(enable_text == true)
        {
         call_reversal_put_reversal_s(arrow_name_down_call_reversal_put_reversal, time_down_call_reversal_put_reversal, price_down_call_reversal_put_reversal);
        }
      Send_Sell_Order("RS");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//-------------------------------+//-------------------------------+
bool Check_Buy_Signal_minor_put_minor_call()  // minor_put_minor_call BUY
  {
   int r;
   if(minor_put_minor_call == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      (Open[4] >= Close[4]
       && Open[3] >= Close[3]
       && Open[2] <= Close[2] &&  High[2] <= Close[2]
       && Open[1] <= Close[1]) &&  High[1] <= Close[1]
      && ((Close[3] < Bands_down_1_7_1)
          || (Close[2] < Bands_down_1_7_1)
          || (Low[2] < Bands_down_1_7_1)
          || (Low[3] < Bands_down_1_7_1))
   )
     {
      if(enable_text == true)
        {
         minor_put_minor_call_b(arrow_name_up_minor_put_minor_call, time_up_minor_put_minor_call, price_up_minor_put_minor_call);
        }
      Send_Buy_Order("MIU");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_minor_put_minor_call()  // minor_put_minor_call SELL
  {
   int r;
   if(minor_put_minor_call == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      (Open[4] <= Close[4]
       && Open[3] <= Close[3]
       && Open[2] >= Close[2] && Low[2] >= Close[2]
       && Open[1] >= Close[1]) && Low[1] >= Close[1]
      && ((Close[3] > Bands_up_1_7_1)
          || (Close[2] > Bands_up_1_7_1)
          || (High[2] > Bands_up_1_7_1)
          || (High[3] > Bands_up_1_7_1))
   )
     {
      if(enable_text == true)
        {
         minor_put_minor_call_s(arrow_name_down_minor_put_minor_call, time_down_minor_put_minor_call, price_down_minor_put_minor_call);
        }
      Send_Sell_Order("MID");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//-------------------------------+//-------------------------------+
bool Check_Buy_Signal_poe_1()  // poe_1 BUY
  {
   int r;
   if(poe_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
//Close[1]<Close[1]
      Low[2] == Close[1]
      && Open[1] > Close[1]
      && Analys_EMA == 1
      && Close[1] > Bands_up_1_1
      && MathAbs(Close[3] - Open[3]) > MathAbs(Close[2] - Open[2])
      && MathAbs(Close[2] - Open[2]) > MathAbs(Close[1] - Open[1])
// && Open[2] > Low[2] + ((Low[2]-High[2]) * 0.05)
      && (MathAbs(Close[2] - Open[2])) <= ((High[2] - Low[2]) * 0.4)
   )
     {
      if(enable_text == true)
        {
         poe_1_b(arrow_name_up_poe_1, time_up_poe_1, price_up_poe_1);
        }
      Send_Buy_Order("POE1");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_poe_1()  // poe_1 SELL
  {
   int r;
   if(poe_1 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      High[2] == Close[1]
      && Open[1] < Close[1]
      && Analys_EMA == 2
      && Close[1] < Bands_down_1_1
      && MathAbs(Close[3] - Open[3]) < MathAbs(Close[2] - Open[2])
      && MathAbs(Close[2] - Open[2]) > MathAbs(Close[1] - Open[1])
//&& Open[2] > Low[2] + ((Low[2]-High[2]) * 0.05)
      && (MathAbs(Close[2] - Open[2])) <= ((High[2] - Low[2]) * 0.8)
   )
     {
      if(enable_text == true)
        {
         poe_1_s(arrow_name_down_poe_1, time_down_poe_1, price_down_poe_1);
        }
      Send_Sell_Order("POE1");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//-------------------------------+
bool Check_Buy_Signal_poe_2()  // poe_2 BUY
  {
   int r;
   if(poe_2 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
//Close[1]<Close[1]
//Close[1]>Close[1]
// && real_>2
// && Close[1] > myMA_20_1
      Open[1] < Close[1]
//&&  doji == false
      && Analys_EMA == 2
      && High[2] == Close[1]
      && Close[1] > Bands_down_1_1
//&& upper_ < lower_
      && Close[1] != High[1]
      && Close[2] != High[2]
      && Open[2] < Close[2]
      && Open[3] < Close[3]
      && Open[4] > Close[4]
      && ((MathAbs(Close[3] - Open[3]) > MathAbs(Close[2] - Open[2])
           && MathAbs(Close[2] - Open[2]) > MathAbs(Close[1] - Open[1]))
          || MathAbs(Close[3] - Open[3]) * 5 > MathAbs(Close[2] - Open[2]))
   )
     {
      if(enable_text == true)
        {
         poe_2_b(arrow_name_up_poe_2, time_up_poe_2, price_up_poe_2);
        }
      Send_Buy_Order("POE2");
      signal_price_buy = Bid;
      signalTime_buy   = Time[0];
      return true;
     }
   else
      return false;
  }
//+------------------------------------------------------------------+
bool Check_Sell_Signal_poe_2()  // poe_2 SELL
  {
   int r;
   if(poe_2 == true)
     {
      r = 1;
     }
   else
      return false;
//---
   if(
      Open[1] > Close[1]
      && Analys_EMA == 1
      && Low[2] == Close[1]
      && Close[1] < Bands_up_1_1
      && Close[1] != Low[1]
      && Close[2] != Low[2]
      && Open[2] > Close[2]
      && Open[3] > Close[3]
      && Open[4] < Close[4]
      && ((MathAbs(Close[3] - Open[3]) > MathAbs(Close[2] - Open[2])
           && MathAbs(Close[2] - Open[2]) > MathAbs(Close[1] - Open[1]))
          || MathAbs(Close[3] - Open[3]) * 5 > MathAbs(Close[2] - Open[2]))
   )
     {
      if(enable_text == true)
        {
         poe_2_s(arrow_name_down_poe_2, time_down_poe_2, price_down_poe_2);
        }
      Send_Sell_Order("POE2");
      signal_price_sell = Bid;
      signalTime_sell   = Time[0];
      return true;
     }
   else
      return false;
  }
//-------------------------------+
//-------------------------------+
//-------------------------------+
void Send_Buy_Order(string typeSignal)
  {
   sendAlert(" BUY " + "__" + Symbol() + "_M_" + IntegerToString(period) + " " + typeSignal, " BUY " + "__" + Symbol() + "_M_" + IntegerToString(period) + " " + typeSignal);
   Alertsignal_type(typeSignal, Text_ColorBuy, TextSize, y, x);
   if(GetLine == true)
      GetLine_Buy();
   if(Show_arrow  == true)
      Arrow_Create(arrow_name_up, time_up, price_up, Color_Arrow_UP, ARROW_UP, ANCHOR_TOP);
   if(TakePicture   == true)
     {
      GetImage();
     }
  }
//-------------------------------+
void Send_Sell_Order(string typeSignal)
  {
   sendAlert(" SELL " + "__" + Symbol() + "_M_" + IntegerToString(period) + " " + typeSignal, " SELL " + "__" + Symbol() + "_M_" + IntegerToString(period) + " " + typeSignal);
   Alertsignal_type(typeSignal,  Text_ColorSell, TextSize, y, x);
   if(GetLine == true)
      GetLine_Sell();
   if(Show_arrow   == true)
      Arrow_Create(arrow_name_down, time_down, price_down, Color_Arrow_Down, ARROW_DOWN, ANCHOR_BOTTOM);
   if(TakePicture   == true)
     {
      GetImage();
     }
  }
//-------------------------------+
void buy()
  {
   string  objName = "test_8";
   if(ObjectFind(objName) == 0)
     {
      ObjectDelete(objName);
     }
   ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(objName, OBJPROP_YDISTANCE, 17);
   ObjectSet(objName, OBJPROP_XDISTANCE, 134);
   ObjectSet(objName, OBJPROP_CORNER, 0);
   ObjectSet(objName, OBJPROP_COLOR, Lime);
   ObjectSetText(objName, "BUY  ", 30, "All", Lime);
  }
//-------------------------------+
void Up()
  {
   string  objName = "test_9";
   if(ObjectFind(objName) == 0)
     {
      ObjectDelete(objName);
     }
   ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(objName, OBJPROP_YDISTANCE, 22);
   ObjectSet(objName, OBJPROP_XDISTANCE, 222);
   ObjectSet(objName, OBJPROP_CORNER, 0);
   ObjectSet(objName, OBJPROP_COLOR, Lime);
   ObjectSetText(objName, "Up  ", 25, "All", Lime);
  }
//-------------------------------+
void sell()
  {
   string  objName = "test_10";
   if(ObjectFind(objName) == 0)
     {
      ObjectDelete(objName);
     }
   ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(objName, OBJPROP_YDISTANCE, 17);
   ObjectSet(objName, OBJPROP_XDISTANCE, 134);
   ObjectSet(objName, OBJPROP_CORNER, 0);
   ObjectSet(objName, OBJPROP_COLOR, Lime);
   ObjectSetText(objName, "SELL  ", 30, "All", Red);
  }
//-------------------------------+
void Don()
  {
   string objName = "test_11";
   if(ObjectFind(objName) == 0)
     {
      ObjectDelete(objName);
     }
   ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(objName, OBJPROP_YDISTANCE, 22);
   ObjectSet(objName, OBJPROP_XDISTANCE, 222);
   ObjectSet(objName, OBJPROP_CORNER, 0);
   ObjectSet(objName, OBJPROP_COLOR, Lime);
   ObjectSetText(objName, "Down  ", 25, "All", Red);
  }
//+------------------------------------------------------+
//+------------------------------------------------------+
void GetLine_Buy()
  {
   string objName = "Line" + IntegerToString(GetMicrosecondCount()) + TimeToString(TimeCurrent());
   ObjectCreate(objName, OBJ_VLINE, 0, Time[0], 0, 0, 0, 0, 0);
   ObjectSet(objName, OBJPROP_COLOR, Color_Arrow_UP);
   ObjectSet(objName, OBJPROP_STYLE, STYLE_DOT);
   ObjectSet(objName, OBJPROP_WIDTH, 1);
  }
//-------------------------------+
void GetLine_Sell()
  {
   string objName3 = "Line13" + IntegerToString(GetMicrosecondCount()) + TimeToString(TimeCurrent());
   ObjectCreate(objName3, OBJ_VLINE, 0, Time[0], 0, 0, 0, 0, 0);
   ObjectSet(objName3, OBJPROP_COLOR, Color_Arrow_Down);
   ObjectSet(objName3, OBJPROP_STYLE, STYLE_DOT);
   ObjectSet(objName3, OBJPROP_WIDTH, 1);
  }
//+------------------------------------------------------------------+
//| Create Array  signal                                             |
//+------------------------------------------------------------------+
void Arrow_Create(const string name, datetime time, double price, const color clr, int ArrowCode, const ENUM_ARROW_ANCHOR anchor)
  {
   ObjectCreate(0,     name, OBJ_ARROW, 0, time, price);
   ObjectSetInteger(0, name, OBJPROP_ARROWCODE, ArrowCode);
   ObjectSetInteger(0, name, OBJPROP_ANCHOR, anchor);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
   ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSetInteger(0, name, OBJPROP_WIDTH, Arrow_size);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void Arrow_Create_buy(const string name, datetime time, double price, const color clr, int ArrowCode, const ENUM_ARROW_ANCHOR anchor)
  {
   ObjectCreate(0,     name, OBJ_ARROW, 0, time, price);
   ObjectSetInteger(0, name, OBJPROP_ARROWCODE, 108);
   ObjectSetInteger(0, name, OBJPROP_ANCHOR, anchor);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clrBlue);
   ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSetInteger(0, name, OBJPROP_WIDTH, 1);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void Arrow_Create_reversal(const string name, datetime time, double price, const color clr, int ArrowCode, const ENUM_ARROW_ANCHOR anchor)
  {
   ObjectCreate(0,     name, OBJ_ARROW, 0, time, price);
   ObjectSetInteger(0, name, OBJPROP_ARROWCODE, 158);
   ObjectSetInteger(0, name, OBJPROP_ANCHOR, anchor);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clrGreen);
   ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSetInteger(0, name, OBJPROP_WIDTH, 8);
  }
//+------------------------------------------------------------------+
void Arrow_Create_sell(const string name, datetime time, double price, const color clr, int ArrowCode, const ENUM_ARROW_ANCHOR anchor)
  {
   ObjectCreate(0,     name, OBJ_ARROW, 0, time, price);
   ObjectSetInteger(0, name, OBJPROP_ARROWCODE, 108);
   ObjectSetInteger(0, name, OBJPROP_ANCHOR, anchor);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clrBlue);
   ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSetInteger(0, name, OBJPROP_WIDTH, 1);
  }
//+------------------------------------------------------------------+
//|
//+------------------------------------------------------------------+
void _3WS_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "3WS", Text_size, "Tahoma", Text_color);
  }
//+---------+
void _3WS_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "3BC", Text_size, "Tahoma", Text_color);
  }

//+------------------------------------------------------------------+
void _3BC_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "3WS", Text_size, "Tahoma", Text_color);
  }
//+---------+
void _3BC_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "3BC", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void _3WSP_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "3WSP", Text_size, "Tahoma", Text_color);
  }
//+---------+
void _3WSP_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "3WSP", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void _3BCP_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "3BCP", Text_size, "Tahoma", Text_color);
  }
//+---------+
void _3BCP_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "3BCP", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void PL_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PL", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void PL_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PL", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void PL_b_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PL", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void PL_s_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PL", Text_size, "Tahoma", Text_color);
  }

//+---------+
void DC_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DC", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void DC_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DC", Text_size, "Tahoma", Text_color);
  }
//+---------+
void DC_b_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DC", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void DC_s_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DC", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void PoE_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE ", Text_size, "Tahoma", Text_color);
  }
//+---------+
void PoE_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE ", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void PoE_b_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 1", Text_size, "Tahoma", Text_color);
  }
//+---------+
void PoE_s_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void PoE_b_2(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 2", Text_size, "Tahoma", Text_color);
  }
//+---------+
void PoE_s_2(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 2", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void PoE_b_3(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 3", Text_size, "Tahoma", Text_color);
  }
//+---------+
void PoE_s_3(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 3", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void PoE_b_4(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 4", Text_size, "Tahoma", Text_color);
  }
//+---------+
void PoE_s_4(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 4", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void PoE_b_5(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 5", Text_size, "Tahoma", Text_color);
  }
//+---------+
void PoE_s_5(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 5", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void PoE_b_6(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 6", Text_size, "Tahoma", Text_color);
  }
//+---------+
void PoE_s_6(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 6", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void PoE_b_7(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 7", Text_size, "Tahoma", Text_color);
  }
//+---------+
void PoE_s_7(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 7", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void PoE_b_8(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 8", Text_size, "Tahoma", Text_color);
  }
//+---------+
void PoE_s_8(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 8", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void PoE_b_9(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 9", Text_size, "Tahoma", Text_color);
  }
//+---------+
void PoE_s_9(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 9", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void PoE_b_10(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 10", Text_size, "Tahoma", Text_color);
  }
//+---------+
void PoE_s_10(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 10", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void PoE_b_11(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 11", Text_size, "Tahoma", Text_color);
  }
//+---------+
void PoE_s_11(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PoE 11", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void DPoE_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DPoE ", Text_size, "Tahoma", Text_color);
  }
//+---------+
void DPoE_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DPoE ", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void DPoE_b_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DPoE 1", Text_size, "Tahoma", Text_color);
  }
//+---------+
void DPoE_s_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DPoE 1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void DPoE_b_2(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DPoE 1", Text_size, "Tahoma", Text_color);
  }
//+---------+
void DPoE_s_2(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DPoE 1", Text_size, "Tahoma", Text_color);
  }

//+------------------------------------------------------------------+
void DPoE_b_3(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DPoE 3", Text_size, "Tahoma", Text_color);
  }
//+---------+
void DPoE_s_3(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DPoE 3", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void DPoE_b_4(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DPoE 4", Text_size, "Tahoma", Text_color);
  }
//+---------+
void DPoE_s_4(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DPoE 4", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void DPoE_b_5(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DPoE 5", Text_size, "Tahoma", Text_color);
  }
//+---------+
void DPoE_s_5(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DPoE 5", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void MDS_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MDS", Text_size, "Tahoma", Text_color);
  }
//+---------+
void MDS_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MDS", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void EDS_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EDS", Text_size, "Tahoma", Text_color);
  }
//+---------+
void EDS_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EDS", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void MS_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MS", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void MS_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MS", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void MS_b_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MS 1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void MS_s_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MS 1", Text_size, "Tahoma", Text_color);
  }
//+---------+
void ES_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ES", Text_size, "Tahoma", Text_color);
  }
//+---------+
void ES_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ES", Text_size, "Tahoma", Text_color);
  }
//+---------+
void ES_b_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ES 1", Text_size, "Tahoma", Text_color);
  }
//+---------+
void ES_s_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ES 1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void MS50_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MS50", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void MS50_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MS50", Text_size, "Tahoma", Text_color);
  }

//+------------------------------------------------------------------+
void MS50_b_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MS50 1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void MS50_s_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MS50 1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void ES50_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ES50", Text_size, "Tahoma", Text_color);
  }
//+---------+
void ES50_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ES50", Text_size, "Tahoma", Text_color);
  }
//+---------+
void ES50_b_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ES50 1", Text_size, "Tahoma", Text_color);
  }
//+---------+
void ES50_s_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ES50 1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void EES_Equal_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EES_Equal", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void EES_Equal_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EES_Equal", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void EES_Equal_b_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EES_Equal 1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void EES_Equal_s_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EES_Equal 1", Text_size, "Tahoma", Text_color);
  }
//+---------+
void EMS_Equal_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EMS_Equal", Text_size, "Tahoma", Text_color);
  }
//+---------+
void EMS_Equal_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EMS_Equal", Text_size, "Tahoma", Text_color);
  }
//+---------+
void EMS_Equal_b_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EMS_Equal 1", Text_size, "Tahoma", Text_color);
  }
//+---------+
void EMS_Equal_s_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EMS_Equal 1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void Eng_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "Eng", Text_size, "Tahoma", Text_color);
  }
//+---------+
void Eng_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "Eng", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void Eng_b_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "Eng1", Text_size, "Tahoma", Text_color);
  }
//+---------+
void Eng_s_1(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "Eng1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void EXC_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EXC", Text_size, "Tahoma", Text_color);
  }
//+---------+
void EXC_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EXC", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void EXP_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EXP", Text_size, "Tahoma", Text_color);
  }
//+---------+
void EXP_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EXP", Text_size, "Tahoma", Text_color);
  }

//+------------------------------------------------------------------+
void EXR_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EXR", Text_size, "Tahoma", Text_color);
  }
//+---------+
void EXR_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EXR", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void EXRC_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EXRC", Text_size, "Tahoma", Text_color);
  }
//+---------+
void EXRC_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EXRC", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void NRS_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "NRS", Text_size, "Tahoma", Text_color);
  }
//+---------+
void NRS_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "NRS", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void FNRS_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "FNRS", Text_size, "Tahoma", Text_color);
  }
//+---------+
void FNRS_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "FNRS", Text_size, "Tahoma", Text_color);
  }
//+---------+
void NRSP_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "NRSP", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+---------+
void NRSP_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "NRSP", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void SnR_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "SS9", Text_size, "Tahoma", Text_color);
  }
//+---------+
void SnR_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "SS9", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void FB_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "FB", Text_size, "Tahoma", Text_color);
  }
//+---------+
void FB_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "FB", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void shoting_s_1_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "SST1", Text_size, "Tahoma", Text_color);
  }
//+---------+
void shoting_s_1_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "SST1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void shoting_s_2_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "SST2", Text_size, "Tahoma", Text_color);
  }
//+---------+
void shoting_s_2_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "SST2", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void shoting_s_3_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "SST3", Text_size, "Tahoma", Text_color);
  }
//+---------+
void shoting_s_3_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "SST3", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
void shoting_s_4_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "SST4", Text_size, "Tahoma", Text_color);
  }

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void marubozu_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MA", Text_size, "Tahoma", Text_color);
  }
//+---------+
void marubozu_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MA", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void dragonfly_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DF", Text_size, "Tahoma", Text_color);
  }
//+---------+
void dragonfly_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "GS", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void gap_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "GU", Text_size, "Tahoma", Text_color);
  }
//+---------+
void gap_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "GD", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void gravestone_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "GS", Text_size, "Tahoma", Text_color);
  }
//+---------+
void gravestone_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "GS", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void inverted_hammer_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "IHA", Text_size, "Tahoma", Text_color);
  }
//+---------+
void inverted_hammer_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "IHA", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void EES_1_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EES", Text_size, "Tahoma", Text_color);
  }
//+---------+
void EES_1_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EES", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void EMS_1_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EMS", Text_size, "Tahoma", Text_color);
  }
//+---------+
void EMS_1_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "EMS", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void NRS_1_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "NRS", Text_size, "Tahoma", Text_color);
  }
//+---------+
void NRS_1_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "NRS", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void MS50_1_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MS50", Text_size, "Tahoma", Text_color);
  }
//+---------+
void MS50_1_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MS50", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void ES50_1_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ES50", Text_size, "Tahoma", Text_color);
  }
//+---------+
void ES50_1_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ES50", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void Hanging_man_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "HM", Text_size, "Tahoma", Text_color);
  }
//+---------+
void Hanging_man_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "HM", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void Harami_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "HAR", Text_size, "Tahoma", Text_color);
  }
//+---------+
void Harami_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "HAR", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void HHLL_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "HH", Text_size, "Tahoma", Text_color);
  }
//+---------+
void HHLL_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "LL", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void eng_1_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ENG1", Text_size, "Tahoma", Text_color);
  }
//+---------+
void eng_1_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ENG1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void eng_2_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ENG2", Text_size, "Tahoma", Text_color);
  }
//+---------+
void eng_2_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ENG2", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void eng_3_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ENG3", Text_size, "Tahoma", Text_color);
  }
//+---------+
void eng_3_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ENG3", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void eng_4_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ENG4", Text_size, "Tahoma", Text_color);
  }
//+---------+
void eng_4_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ENG4", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void eng_5_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ENG5", Text_size, "Tahoma", Text_color);
  }
//+---------+
void eng_5_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ENG5", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void eng_6_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ENG6", Text_size, "Tahoma", Text_color);
  }
//+---------+
void eng_6_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ENG6", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void eng_7_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ENG7", Text_size, "Tahoma", Text_color);
  }
//+---------+
void eng_7_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ENG7", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void dc_1_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DC1", Text_size, "Tahoma", Text_color);
  }
//+---------+
void dc_1_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PL1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void dc_2_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "DC1", Text_size, "Tahoma", Text_color);
  }
//+---------+
void dc_2_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "PL1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void huge_candle_1_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "HC1", Text_size, "Tahoma", Text_color);
  }
//+---------+
void huge_candle_1_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "HC1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void huge_candle_2_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "HC2", Text_size, "Tahoma", Text_color);
  }
//+---------+
void huge_candle_2_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "HC2", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void huge_candle_3_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "HC3", Text_size, "Tahoma", Text_color);
  }
//+---------+
void huge_candle_3_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "HC3", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void ms_buy_1_es_1_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MS1", Text_size, "Tahoma", Text_color);
  }
//+---------+
void ms_buy_1_es_1_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ES1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void ms_buy_1_es_2_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MS2", Text_size, "Tahoma", Text_color);
  }
//+---------+
void ms_buy_1_es_2_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "ES2", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void tws_put_1_tbc_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "TWS1", Text_size, "Tahoma", Text_color);
  }
//+---------+
void tws_put_1_tbc_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "TBC1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void tws_put_2_tbc_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "TWS2", Text_size, "Tahoma", Text_color);
  }
//+---------+
void tws_put_2_tbc_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "TBC2", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void tws_put_3_tbc_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "TWS3", Text_size, "Tahoma", Text_color);
  }
//+---------+
void tws_put_3_tbc_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "TBC3", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void tws_put_4_tbc_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "TWS4", Text_size, "Tahoma", Text_color);
  }
//+---------+
void tws_put_4_tbc_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "TBC4", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void Hammer_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "HA", Text_size, "Tahoma", Text_color);
  }
//+---------+
void G_Hammer_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "HAC", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void twzb_call_1_twzt_put_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "TWZB", Text_size, "Tahoma", Text_color);
  }
//+---------+
void twzb_call_1_twzt_put_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "TWZT", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void call_reversal_put_reversal_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "RC", Text_size, "Tahoma", Text_color);
  }
//+---------+
void call_reversal_put_reversal_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "RS", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void minor_put_minor_call_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MIU", Text_size, "Tahoma", Text_color);
  }
//+---------+
void minor_put_minor_call_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "MID", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void poe_1_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "POE1", Text_size, "Tahoma", Text_color);
  }
//+---------+
void poe_1_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "POE1", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void poe_2_b(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "POE2", Text_size, "Tahoma", Text_color);
  }
//+---------+
void poe_2_s(const string name, datetime time, double price)
  {
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "POE2", Text_size, "Tahoma", Text_color);
  }
//+------------------------------------------------------------------+









//+------------------------------------------------------------------+
/*void Arrow_Move_buy__Analyse(const string name, datetime time, double price)
{
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "Analyse", Text_size, "Tahoma", Text_color);
}
//+---------+
void Arrow_Move_sell__Analyse(const string name, datetime time, double price)
{
   ObjectCreate(name, OBJ_TEXT, 0, time, price);
   ObjectSetText(name, "Analyse", Text_size, "Tahoma", Text_color);
}*/
//+------------------------------------------------------------------+
//| Move the anchor point                                            |
//+------------------------------------------------------------------+
void Arrow_Move(const string name, datetime time, double  price) //
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void _3WS_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void _3BC_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void _3WSP_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void _3BCP_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void PL_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void PL_1_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void DC_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void DC_1_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void PoE_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void PoE_Move_1(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void PoE_Move_2(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void PoE_Move_3(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void PoE_Move_4(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void PoE_Move_5(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void PoE_Move_6(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void PoE_Move_7(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void PoE_Move_8(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void PoE_Move_9(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void PoE_Move_10(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void PoE_Move_11(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }







//+------------------------------------------------------------------+
void DPoE_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void DPoE_Move_1(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void DPoE_Move_2(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void DPoE_Move_3(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void DPoE_Move_4(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void DPoE_Move_5(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void MDS_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void EDS_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void MS_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void MS_1_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void ES_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void ES_1_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void EMS50_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void ES50_1_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void MS50_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void ES50_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void ES50_Move_1(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void EES_Equal_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void EES_Equal_1_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void EMS_Equal_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void EMS_Equal_1_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void Eng_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void Eng_Move_1(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void EXC_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void EXP_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void EXR_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void EXRC_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void NRS_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void FNRS_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void NRSP_Move(const string name, datetime time, double  price) //
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void Arrow_Move_buy_SnR(const string name, datetime time, double  price) //
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void Arrow_Move_sell_SnR(const string name, datetime time, double  price) //
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void FB_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void shoting_s_1_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void shoting_s_2_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void shoting_s_3_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void shoting_s_4_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }

//+------------------------------------------------------------------+
void marubozu_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void dragonfly_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void gap_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void gravestone_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void inverted_hammer_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void EES_1_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void EMS_1_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void NRS_1_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void MS50_1_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void Hanging_man_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void Harami_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void HHLL_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void eng_1_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void eng_2_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void eng_3_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void eng_4_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void eng_5_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void eng_6_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void eng_7_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void dc_1_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }//+------------------------------------------------------------------+
void dc_2_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void huge_candle_1_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void huge_candle_2_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void huge_candle_3_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void ms_buy_1_es_1_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void ms_buy_1_es_2_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void tws_put_1_tbc_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void tws_put_2_tbc_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void tws_put_3_tbc_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void tws_put_4_tbc_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void Hammer_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
/*void Hammer_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }*/
//+------------------------------------------------------------------+
void twzb_call_1_twzt_put_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void call_reversal_put_reversal_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void minor_put_minor_call_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }
//+------------------------------------------------------------------+
void poe_1_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }


//+------------------------------------------------------------------+
void poe_2_Move(const string name, datetime time, double  price)
  {
   ObjectMove(0, name, 0, time, price);
   ChartRedraw();
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool NewBar()
  {
   if(PreviousBarTime1 < Time[0])
     {
      PreviousBarTime1 = Time[0];
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTimer()
  {
   Print("[INFO] OnTimer 2793");
   if(!CheckLicenceRepeat())
     {
      Comment("License check has failed");
      isLicence = false;
      while(MessageBox("License check has failed", NULL, MB_RETRYCANCEL) == IDRETRY)
        {
         if(!CheckLicenceRepeat())
           {
            Comment("License check has failed");
            isLicence = false;
           }
         else
           {
            Comment("");
            isLicence = true;
            break;
           }
        }
     }
   else
     {
      Comment("");
      isLicence = true;
     }
  }
//+------------------------------------------------------------------+
bool CheckLicence()
  {
   Respons respons;
   respons.res = -1;
   while(respons.res == -1)
     {
      respons = Request(AccountNumber(), Serial, base_url);
      Print("[INFO] CheckLicence 2826 respons.res = ", respons.res, "respons.status = ", respons.status, "respons.msg = ", respons.msg);
      if(respons.res == -1)
        {
         Alert("Check your internet connection. Please wait...");
        }
      Print(respons.res == 201, " ", respons.status == "201", " ", ValidateLicence(respons.token));
      if(respons.res == 201 && respons.status == "201" && ValidateLicence(respons.token))
        {
         MessageBox(respons.msg);
         if(respons.expire_day <= 3 && respons.expire_day != -1)
           {
            Alert(StringFormat("The license expires in %d days.", respons.expire_day));
           }
         return(true);
        }
      Sleep(5000);
     }
   MessageBox(respons.msg);
   return(false);
  }
//+------------------------------------------------------------------+
bool ValidateLicence(string responsToken)
  {
   string token = GetToken(AccountNumber(), Serial, validate);
   ushort u_sep;
   string result[];
   u_sep = StringGetCharacter("*", 0);
   int k = StringSplit(token, u_sep, result);
   if(responsToken == result[0] && k == 3 && result[1] == validate)
      return(true);
   return(false);
  }
//+------------------------------------------------------------------+
bool CheckLicenceRepeat()
  {
   Respons respons;
   respons.res = -1;
   while(respons.res == -1)
     {
      respons = Request(AccountNumber(), Serial, base_url);
      Print("[INFO] CheckLicenceRepeat 2865 respons.res = ", respons.res, "respons.status = ", respons.status, "respons.msg = ", respons.msg);
      if(respons.res == -1)
        {
         Alert("Check your internet connection. Please wait...");
        }
      Print(respons.res == 201, " ", respons.status == "201", " ", ValidateLicence(respons.token));
      if(respons.res == 201 && respons.status == "201" && ValidateLicence(respons.token))
        {
         if(respons.expire_day <= 3 && respons.expire_day != -1)
           {
            Alert(StringFormat("The license expires in %d days.", respons.expire_day));
           }
         return(true);
        }
      Sleep(5000);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void sendAlert(string AlertMsg, string AlertPushNotificationMsg)
  {
   if(Message_Alert)
      Alert(AlertMsg);
   if(Mail_alert)
      SendMail("Alert new signal", AlertPushNotificationMsg);
   if(Push_notification)
      SendNotification(AlertPushNotificationMsg);
   if(Sound_alert)
      PlaySound(Sound_file_name);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+                                                         |
//+------------------------------------------------------------------+
void TrendLine(string name, datetime time1, double price1, datetime time2, double price2, color col,  int line_style,  bool ray = false)
  {
   name = name + TimeToString(TimeCurrent()) + IntegerToString(GetMicrosecondCount());
   ObjectCreate(name, OBJ_TREND, 0,  time1, price1,  time2, price2);
   ObjectSet(name, OBJPROP_COLOR, col);
   ObjectSet(name, OBJPROP_STYLE, line_style);
   ObjectSet(name, OBJPROP_WIDTH, 1);
   ObjectSet(name, OBJPROP_RAY, ray);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void Alert_wait_type(string type, color col, int size, int yy, int xx)
  {
   string objName = "wait_signal";
   ObjectDelete(objName);
   ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(objName, OBJPROP_YDISTANCE, yy);
   ObjectSet(objName, OBJPROP_XDISTANCE, xx);
   ObjectSet(objName, OBJPROP_CORNER, CORNER_RIGHT_UPPER);
   ObjectSet(objName, OBJPROP_COLOR, col);
   ObjectSetInteger(0, objName, OBJPROP_SELECTABLE, true);
   ObjectSetInteger(0, objName, OBJPROP_SELECTED, false);
   ObjectSetText(objName, type, size, "FW_BOLD");
  }
//+------------------------------------------------------------------+
void Alert_Analys_type(string name, string type, color col, int size, int yy, int xx)
  {
   if(show_hide_btn_status)
     {
      string objNameAnalys = name;
      //ObjectDelete(objNameAnalys);
      ObjectCreate(objNameAnalys, OBJ_LABEL, 0, 0, 0);
      ObjectSet(objNameAnalys, OBJPROP_YDISTANCE, yy);
      ObjectSet(objNameAnalys, OBJPROP_XDISTANCE, xx);
      ObjectSet(objNameAnalys, OBJPROP_CORNER, CORNER_RIGHT_UPPER);
      ObjectSet(objNameAnalys, OBJPROP_COLOR, col);
      ObjectSet(objNameAnalys, OBJPROP_BGCOLOR, clr_bacgrond_Analys);
      ObjectSet(objNameAnalys, OBJPROP_BORDER_COLOR, clr_cadr_Analys);
      ObjectSetInteger(0, objNameAnalys, OBJPROP_SELECTABLE, true);
      ObjectSetInteger(0, objNameAnalys, OBJPROP_SELECTED, false);
      ObjectSetText(objNameAnalys, type, size, "Times New Roman");
     }
  }
//+------------------------------------------------------------------+
void Alertsignal_type(string type, color col, int size, int yy, int xx)
  {
   string objName = "signal_type_obj";
   ObjectDelete(objName);
   ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(objName, OBJPROP_YDISTANCE, yy);
   ObjectSet(objName, OBJPROP_XDISTANCE, xx);
   ObjectSet(objName, OBJPROP_CORNER, CORNER_RIGHT_UPPER);
   ObjectSet(objName, OBJPROP_COLOR, col);
   ObjectSetInteger(0, objName, OBJPROP_SELECTABLE, true);
   ObjectSetInteger(0, objName, OBJPROP_SELECTED, false);
   ObjectSetText(objName, type, size, "Times New Roman");
  }
//+------------------------------------------------------------------+
void Alert_Degrees(string type, color col, int size, int yy, int xx)
  {
   if(show_hide_btn_status)
     {
      string objName = "Alert_Degrees";
      ObjectDelete(objName);
      ObjectCreate(objName, OBJ_LABEL, 0, 0, 0);
      ObjectSet(objName, OBJPROP_YDISTANCE, yy);
      ObjectSet(objName, OBJPROP_XDISTANCE, xx);
      ObjectSet(objName, OBJPROP_CORNER, CORNER_RIGHT_UPPER);
      ObjectSet(objName, OBJPROP_COLOR, col);
      ObjectSetInteger(0, objName, OBJPROP_SELECTABLE, true);
      ObjectSetInteger(0, objName, OBJPROP_SELECTED, false);
      ObjectSetText(objName, type, size, "Times New Roman");
     }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
string GetDate2Name()
  {
   string Out;
   Out = IntegerToString(Year());
   if(Month() < 10)
      Out = Out + "0" + IntegerToString(Month());
   else
      Out = Out + IntegerToString(Month());
   if(Day() < 10)
      Out = Out + "0" + IntegerToString(Day());
   else
      Out = Out + IntegerToString(Day());
   Out = Out + "_";
   if(Hour() < 10)
      Out = Out + "0" + IntegerToString(Hour());
   else
      Out = Out + IntegerToString(Hour());
   if(Minute() < 10)
      Out = Out + "0" + IntegerToString(Minute());
   else
      Out = Out + IntegerToString(Minute());
   if(Period() == 1)
      Out = "\\M1\\__" + Out  ;
   if(Period() == 5)
      Out = "\\M5\\__" + Out ;
   if(Period() == 15)
      Out = "\\M15\\__" + Out;
   if(Period() == 30)
      Out = "\\M30\\__" + Out;
   if(Period() == 60)
      Out = "\\H1\\__" + Out;
   if(Period() == 240)
      Out = "\\H4\\__" + Out;
   if(Period() == 1440)
      Out = "\\D1\\__" + Out;
   if(Period() > 1440)
      Out = "\\W1\\__" + Out;
// Comment(" Out= " ,Out );
   return (Out);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void GetImage()
  {
   if(!WindowScreenShot(Symbol() + GetDate2Name() + ".png", _width, _height))
     {
      Print(GetLastError());
     }
   else
      Print(Symbol() + GetDate2Name() + ".png  --> Name Of File");
  }
//+------------------------------------------------------------------+
bool RectLabelCreate(const long             chart_ID = 0,             // chart's ID
                     const string           name = "RectLabel",       // label name
                     const int              sub_window = 0,           // subwindow index
                     const int              xx = 0,                    // X coordinate
                     const int              yy = 0,                    // Y coordinate
                     const int              width = 50,               // width
                     const int              height = 18,              // height
                     const color            back_clr = clrBlack, // background color
                     const ENUM_BORDER_TYPE border = BORDER_SUNKEN,   // border type
                     const ENUM_BASE_CORNER corner = CORNER_RIGHT_UPPER, // chart corner for anchoring
                     const color            clr = clrBlack,             // flat border color (Flat)
                     const ENUM_LINE_STYLE  style = STYLE_SOLID,      // flat border style
                     const int              line_width = 0,           // flat border width
                     const bool             back = false,             // in the background
                     const bool             selection = false,        // highlight to move
                     const bool             hidden = true,            // hidden in the object list
                     const long             z_order = 0)              // priority for mouse click
  {
//--- reset the error value
   ResetLastError();
//--- create a rectangle label
   if(!ObjectCreate(chart_ID, name, OBJ_RECTANGLE_LABEL, sub_window, 0, 0))
     {
      Print(__FUNCTION__,
            ": failed to create a rectangle label! Error code = ", GetLastError());
      return(false);
     }
//--- set label coordinates
   ObjectSetInteger(chart_ID, name, OBJPROP_XDISTANCE, xx);
   ObjectSetInteger(chart_ID, name, OBJPROP_YDISTANCE, yy);
//--- set label size
   ObjectSetInteger(chart_ID, name, OBJPROP_XSIZE, width);
   ObjectSetInteger(chart_ID, name, OBJPROP_YSIZE, height);
//--- set background color
   ObjectSetInteger(chart_ID, name, OBJPROP_BGCOLOR, back_clr);
//--- set border type
   ObjectSetInteger(chart_ID, name, OBJPROP_BORDER_TYPE, border);
//--- set the chart's corner, relative to which point coordinates are defined
   ObjectSetInteger(chart_ID, name, OBJPROP_CORNER, corner);
//--- set flat border color (in Flat mode)
   ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clr);
//--- set flat border line style
   ObjectSetInteger(chart_ID, name, OBJPROP_STYLE, style);
//--- set flat border width
   ObjectSetInteger(chart_ID, name, OBJPROP_WIDTH, line_width);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID, name, OBJPROP_BACK, back);
//--- enable (true) or disable (false) the mode of moving the label by mouse
   ObjectSetInteger(chart_ID, name, OBJPROP_SELECTABLE, selection);
   ObjectSetInteger(chart_ID, name, OBJPROP_SELECTED, selection);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID, name, OBJPROP_HIDDEN, hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID, name, OBJPROP_ZORDER, z_order);
//--- successful execution
   return(true);
  }
//+------------------------------------------------------------------+
//PlotLine("degre ",vel4,bar4,bar3,1,angle_dn*i, flag);
//+------------------------------------------------------------------+
void DrawDot(string name, datetime time, double price, color col)
  {
   string objName = name + TimeToString(TimeCurrent()) + IntegerToString(GetMicrosecondCount());
   ObjectCreate(objName, OBJ_TEXT, 0, time, price);
   ObjectSetText(objName, CharToStr(159), 14, "Wingdings", col);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
/*void GetArrow_loss()
{
   string name6 = "Arrow3" + GetMicrosecondCount() + TimeToString(TimeCurrent());
   ObjectCreate(0, name6, OBJ_ARROW, 0, 0, 0);
   ObjectSetInteger(0, name6, OBJPROP_TIME, Time[1]);
   ObjectSetDouble(0, name6, OBJPROP_PRICE, High[1] + 0.0002);
   ObjectSetInteger(0, name6, OBJPROP_ARROWCODE, 203);
   ObjectSetInteger(0, name6, OBJPROP_COLOR, clrDarkOrange);
   ObjectSetInteger(0, name6, OBJPROP_WIDTH, 1);
}*/
//-------------------------------+
//+-------
/* Alert_Analys_type("Reversal-obj", "PL", Analys_Color_Green, TextSize_Analys,  262, 20);
Alert_Analys_type("Reversal-obj", "DC", Analys_Color_Red, TextSize_Analys,  262, 17 );
Alert_Analys_type("Reversal-obj", "MDS", Analys_Color_Green, TextSize_Analys,262, 17 );
Alert_Analys_type("Reversal-obj", "EDS", Analys_Color_Red, TextSize_Analys,  262, 17);
Alert_Analys_type("Reversal-obj", "MS", Analys_Color_Green, TextSize_Analys,  262, 17);
Alert_Analys_type("Reversal-obj", "Eng", Analys_Color_Green, TextSize_Analys, 262, 17);
Alert_Analys_type("Reversal-obj", "ES", Analys_Color_Red, TextSize_Analys, 262, 17);*/
//-----------------------------------------------------------+
//+------------------------------------------------------------------+
/*  Eng_s_2(arrow_name_down_Eng_2, time_down_Eng_2, price_down_Eng_2);
Eng_b_2(arrow_name_up_Eng_2, time_up_Eng_2, price_up_Eng_2);
MS_b_2(arrow_name_up_MS_2, time_up_MS_2, price_up_MS_2);
ES_s_2(arrow_name_down_ES_2, time_down_ES_2, price_down_ES_2);
PL_b_2(arrow_name_up_PL_1, time_up_PL_1, price_up_PL_1);
DC_s_2(arrow_name_down_DC_2, time_down_DC_2, price_down_DC_2);*/
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void Arrow_CreateAnalyse_0_up(const string name, datetime time, double price, const color clr, int ArrowCode, const ENUM_ARROW_ANCHOR anchor)
  {
   ObjectCreate(0,     name, OBJ_ARROW, 0, time, price);
   ObjectSetInteger(0, name, OBJPROP_ARROWCODE, 200);
   ObjectSetInteger(0, name, OBJPROP_ANCHOR, anchor);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
   ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSetInteger(0, name, OBJPROP_WIDTH, 2);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void Arrow_CreateAnalyse_0_down(const string name, datetime time, double price, const color clr, int ArrowCode, const ENUM_ARROW_ANCHOR anchor)
  {
   ObjectCreate(0,     name, OBJ_ARROW, 0, time, price);
   ObjectSetInteger(0, name, OBJPROP_ARROWCODE, 202);
   ObjectSetInteger(0, name, OBJPROP_ANCHOR, anchor);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
   ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSetInteger(0, name, OBJPROP_WIDTH, 2);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long & lparam,
                  const double & dparam,
                  const string & sparam)
  {
   if(show_hide_btn == true)
     {
      if(id == CHARTEVENT_OBJECT_CLICK && sparam == "show-hide")
        {
         if(color(ObjectGetInteger(0, "show-hide", OBJPROP_BGCOLOR, 0)) == clrRed)
           {
            show_hide_btn_status = true;
            ObjectSetInteger(0, "show-hide", OBJPROP_BGCOLOR, clrLime);
            ObjectSetString(0, "show-hide", OBJPROP_TEXT, "Panel");
            RectLabelCreate(0, "RectLabel", 0, 50, 145, 200, 162, clr_RectLabel, 2, CORNER_RIGHT_UPPER);
           }
         else
           {
            ObjectSetInteger(0, "show-hide", OBJPROP_BGCOLOR, clrRed);
            ObjectSetString(0, "show-hide", OBJPROP_TEXT, "Panel");
            show_hide_btn_status = false;
            ObjectDelete("EMA_obj");
            ObjectDelete("DEV_obj");
            ObjectDelete("myMA_Analys");
            ObjectDelete("BB-obj");
            ObjectDelete("Reversal-obj");
            ObjectDelete("C-obj2");
            ObjectDelete("C-obj");
            ObjectDelete("P-obj");
            ObjectDelete("Alert_Degrees");
            ObjectDelete("RectLabel");
           }
        }
      ChartRedraw();
     }
  }
//+------------------------------------------------------------------+ EMA_obj DEV_obj myMA_Analys BB-obj Reversal-obj C-obj2 C-obj P-obj
//+------------------------------------------------------------------+
void CheckResetButton()
  {
   if(show_hide_btn == true)
     {
      if(bool(ObjectGetInteger(0, "show-hide", OBJPROP_STATE)))
        {
         show_hide_btn_status = true;
         ObjectSetInteger(0, "show-hide", OBJPROP_BGCOLOR, clrLime);
         ObjectSetString(0, "show-hide", OBJPROP_TEXT, "Panel");
        }
      else
        {
         ObjectSetInteger(0, "show-hide", OBJPROP_BGCOLOR, clrRed);
         ObjectSetString(0, "show-hide", OBJPROP_TEXT, "Panel");
         show_hide_btn_status = false;
         ObjectDelete("EMA_obj");
         ObjectDelete("DEV_obj");
         ObjectDelete("myMA_Analys");
         ObjectDelete("BB-obj");
         ObjectDelete("Reversal-obj");
         ObjectDelete("C-obj2");
         ObjectDelete("C-obj");
         ObjectDelete("P-obj");
         ObjectDelete("Alert_Degrees");
         ObjectDelete("RectLabel");
        }
     }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void Trend_Line(string name, datetime time1, double price1, datetime time2, double price2, color col, bool ray = false)
  {
   ObjectDelete(name);
   ObjectCreate(name, OBJ_TREND, 0,  time1, price1,  time2, price2);
   ObjectSet(name, OBJPROP_COLOR, col);
   ObjectSet(name, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSet(name, OBJPROP_WIDTH, 2);
   ObjectSet(name, OBJPROP_RAY, ray);
  }
//+------------------------------------------------------------------+
