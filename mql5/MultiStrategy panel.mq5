//+------------------------------------------------------------------+
//|                                          MultiStrategy panel.mq5 |
//|                                   Copyright 2022, Yousuf Mesalm. |
//|                           https://www.mql5.com/en/users/20163440 |
//+------------------------------------------------------------------+
#define Copyright          "Copyright 2022, Yousuf Mesalm."
#property copyright Copyright
#define Link               "https://www.mql5.com/en/users/20163440"
#property link Link
#define Version            "1.00"
#property version Version
#property strict
#property description "Note: All displayed values symbolized with a \"p\" as well as all input distances are in points.\n"
#property description "This software is Coded by YouSuf MeSalm"
#property description Link
//#property icon "logo.ico"
//---
#define INAME     "FFC"
#define TITLE     0
#define COUNTRY   1
#define DATE      2
#define TIME      3
#define IMPACT    4
#define FORECAST  5
#define PREVIOUS  6

// includes
#include <Telegram.mqh>
#include <Arrays\ArrayObj.mqh>
#include  <YM\Execute\Execute.mqh>
#include  <YM\Position\Position.mqh>
#include  <YM\HistoryPosition\HistoryPosition.mqh>

// defination
#define  NL "\n"
#define ExpertName         "MultiStrategy Panel"
#define OBJPREFIX          "YM - "
//---
int CLIENT_BG_WIDTH  =     150;
#define INDENT_TOP         15
//---
#define OPENPRICE          0
#define CLOSEPRICE         1
//---
#define OP_ALL            -1
//---
#define KEY_UP             38
#define KEY_DOWN           40

#define AUD_BUFFER_INDEX 0
#define CAD_BUFFER_INDEX 1
#define CHF_BUFFER_INDEX 2
#define EUR_BUFFER_INDEX 3
#define GBP_BUFFER_INDEX 4
#define JPY_BUFFER_INDEX 5
#define NZD_BUFFER_INDEX 6
#define USD_BUFFER_INDEX 7

#define CURRENCIES_COUNT 8

// Map symbols name to their indexes
string g_symbols[CURRENCIES_COUNT] = {"AUD", "CAD", "CHF", "EUR", "GBP", "JPY", "NZD", "USD"};

// CSM indicator handle
int g_handle = INVALID_HANDLE;
//--- enumeration
enum TRADE_TYPE
  {
   AUTO_TRADE = 0,
   SIGNALS_ONLY = 1,
  };
enum indi_type
  {
   Default,
   increase_Decrease,
  };
enum SL_TP
  {
   op1 = 0,// in pips
   op2 = 1,// SAR
   op3 = 2,// Supertrend
  };
enum TP_TYPE
  {
   RISK_REWARD,
   PIPS,
  };
enum ENUM_TF
  {
   DAILY/*Daily*/,
   WEEKLY/*Weekly*/,
   MONTHLY/*Monthly*/
  };
enum ENUM_MODE
  {
   FULL/*Full*/,
   COMPACT/*Compact*/,
   MINI/*Mini*/
  };
enum TRADE_MODE
  {
   SINGLE = 0,
//SIGNAL TRADE
   MULTIPLE = 1,
// MULTIPLE TRADE
  };
enum TRADE_PAIR
  {
   CURRENT_ONLY = 0,
   MULTIPLE_PAIRS = 1,
  };
enum CLOSE_CONDITIONS
  {
   SLTP = 0,
   AVG_PRECENTAGE = 1,
  };
enum ORDERTYPE
  {
   BUY_ONLY = 0,
   SELL_ONLY = 1,
   BOTH = 2,
  };
enum LOT_TYPE
  {
   FixedLot,
   LOT_PER,
   RISK,
  };
enum closetype
  {
   closeAll,
   closePartial,
   close
  };

enum DYS_WEEK
  {
   Sunday = 0,
   Monday = 1,
   Tuesday = 2,
   Wednesday,
   Thursday = 4,
   Friday = 5,
   Saturday =6,
  };
enum RISKOPTIONS
  {
   LOW,MID,HIGH,
  };
enum DD_Action
  {
   Stop_Trading,
   Close_Profit,
   Close_loss,
   ClosAll,
  };
enum close_Filtter
  {
   Indicators_only,
   CSM_only,
   Both
  };
//--- User inputs
input string Set0= "                    <===================== General ==========================>";
input string Prefix = ""; //Symbol Prefix
input string Suffix = ""; //Symbol Suffix
input string TradeSymbols = "AUDCHF;AUDJPY;AUDUSD;AUDCAD;CADJPY;CADCHF;CHFJPY;EURAUD;EURCAD;EURCHF;EURGBP;EURUSD;EURJPY;EURNZD;GBPAUD;GBPCAD;GBPCHF;GBPJPY;GBPUSD;GBPNZD;USDCHF;USDCAD;USDJPY;NZDCAD;NZDCHF;NZDJPY;NZDUSD;"; /*Symbol List (separated by " ; ")*/
input string set1 = "==================Trading Settings ================";
input TRADE_TYPE trade_type = SIGNALS_ONLY;
input TRADE_MODE TRADEMODE = SINGLE;
input TRADE_PAIR TRADE_ON = MULTIPLE_PAIRS;
input ORDERTYPE type = BOTH;
input bool Trade_Immediatly=true;
input ENUM_TIMEFRAMES TF_Interval=PERIOD_CURRENT;
input long magic_Number = 2020;
input string comment ="FM Stallions";
input string set11       = "===================== RISK FILTTERS OPTIONS===================";
input bool Monday_Filtter =false;
input RISKOPTIONS Monday_Risk = MID;
input bool last_week_month  =false;
input RISKOPTIONS last_week_month_risk =LOW;
input bool first_week_month = false;
input RISKOPTIONS first_week_month_risk =LOW;
input bool first_day_month =false;
input RISKOPTIONS first_day_month_risk = LOW;
input bool last_day_month =false;
input RISKOPTIONS last_day_month_risk = LOW;
input string set2 = "=====================  RISK Management ===============";
input LOT_TYPE LotType = RISK;
input SL_TP sltype = op1;
input TP_TYPE tpType = PIPS;
input double Fixed_Lot = 0.1;
input double lot_Per = 1; // LOT PER 1000
input double LowRisk =1;   // Low Risk
input double LowRiskTP =1;  //Tp for Low Risk
input double MidRisk =2; // Mid Risk
input double MidRiskTP = 2;  // Tp for Mid Risk
input double HighRisk = 3; //High Risk
input double HighRiskTP =3;  // Tp for High Risk
double TAKEPROFIT = 0;
input double tp2 = 0;
input double tp3 = 0;
input double tp4 = 0;
input double tp5 = 0;
input double STOPLOSS = 100;
input bool use_CMS_Filters=  true;  // Use CMS Filtering to open trade
input int num1=60;      // CMS open Num 1
input int num2=40;   // CMS open Num 2
input int Cnum1=50;      // CMS Close Num 1
input int Cnum2=50;   // CMS Close Num 2
input double avg_to_Trada=100; // Avg level to open trades
input indi_type CSMType    =Default;
input string set3       ="======================Closing =====================";
input bool  closeWithPercentage    = true; //close with avg
input close_Filtter CloseFilter= Both;
input double level_To_Close = 60; // avg to close
input bool closewithCSM       =false;
input double Max_Account_lost =50;
input string set4  ="======================Partial close Settings =============";
input bool  close_With_levels = true;
input double close_level1    = 20;
input double close_Precentage1=10;
input double close_level2    = 40;
input double close_Precentage2=10;
input double close_level3    = 50;
input double close_Precentage3=10;
input double close_level4    = 60;
input double close_Precentage4=10;
input double close_level5    = 80;
input double close_Precentage5=10;
input string set6  ="======================+Precentage trailinig =============";
input bool use_precentage_trailing=false;
input double SL1  =10;
input double profit_level1=30;
input double SL2 = 20;
input double profit_level2=50;
input double SL3 = 0;
input double profit_level3= 0;
input double SL4 = 0;
input double profit_level4 = 0;
input double SL5 = 0;
input double profit_level5 =0;
input string set7=      "=======================Filters=============================";
input bool Hedge           =true;
input bool Use_Max_Orders = false;    // Use Max Total Trades for All Symbols
input int Max_Orders = 20;    // Max Total Trades for All Symbols
input int Max_Orders_symbols=1; // Max total trades for each symbol
input bool Use_Max_Trade_daily     =false; //Use Max trades Daily for Each symbol
input int Max_Trade_daily     =10; // Max trades Daily for Each symbol
input bool Use_Max_Trade_weekly    =false; // Use Max trades Weekly for Each symbol
input int Max_Trade_weekly    =10; // Max trades Weekly for Each symbol
input bool Use_Max_negative_symbol_daily  =false;  //Use Max negative orders daily for each symbol
input bool Use_Max_negative_All_daily     =false;  //Use Max negative orders daily for All symbol
input bool Use_Max_negative_symbol_weekly =false;  //Use Max negative orders weekly for each symbol
input bool  Use_Max_negative_All_weekly    =false;  //Use Max negative orders weekly for All symbol

input bool Use_Max_positive_symbol_daily  =false;  //Use Max Positive orders daily for each symbol
input bool Use_Max_positive_All_daily     =false;  //Use Max Positive orders daily for All symbol
input bool Use_Max_positive_symbol_weekly =false;  //Use Max Positive orders weekly for each symbol
input bool  Use_Max_positive_All_weekly    =false;  //Use Max Positive orders weekly for All symbol

input int Max_negative_symbol_daily_low  =10;  //Max negative orders daily for each symbol (Low)
input int Max_negative_All_daily_low     =10;  //Max negative orders daily for All symbol (Low)
input int Max_negative_symbol_weekly_low =10;  //Max negative orders weekly for each symbol (Low)
input int Max_negative_All_weekly_low    =10;  //Max negative orders weekly for All symbol (Low)
input int Max_Positive_symbol_daily_low  =10;  //Max positive orders daily for each symbol (Low)
input int Max_Positive_All_daily_low     =10;  //Max positive orders daily for All symbol (Low)
input int Max_Positive_symbol_weekly_low  =10; //Max Positive orders weekly for each symbol (Low)
input int Max_Positive_All_weekly_low     =10; //Max Positive orders weekly for All symbol (Low)
input int Max_negative_symbol_daily_mid   =10;  //Max negative orders daily for each symbol (Mid)
input int Max_negative_All_daily_mid     =10;  //Max negative orders daily for All symbol (Mid)
input int Max_negative_symbol_weekly_mid =10;  //Max negative orders weekly for each symbol (Mid)
input int Max_negative_All_weekly_mid    =10;   //Max negative orders weekly for All symbol (Mid)
input int Max_Positive_symbol_daily_mid  =10;   //Max positive orders daily for each symbol (Mid)
input int Max_Positive_All_daily_mid     =10;   //Max positive orders daily for All symbol (Mid)
input int Max_Positive_symbol_weekly_mid  =10;  //Max positive orders weekly for each symbol (Mid)
input int Max_Positive_All_weekly_mid     =10;  //Max positive orders weekly for All symbol (Mid)
input int Max_negative_symbol_daily_high  =10;   //Max negative orders daily for each symbol (High)
input int Max_negative_All_daily_high     =10;   //Max negative orders daily for All symbol (High)
input int Max_negative_symbol_weekly_high =10;    //Max negative orders weekly for each symbol (High)
input int Max_negative_All_weekly_high    =10;     //Max negative orders weekly for each symbol (High)
input int Max_Positive_symbol_daily_high  =10;     //Max positive orders daily for each symbol (High)
input int Max_Positive_All_daily_high     =10;//Max positive orders daily for All symbol (High)
input int Max_Positive_symbol_weekly_high  =10;//Max positive orders weekly for each symbol (High)
input int Max_Positive_All_weekly_high     =10;//Max positive orders weekly for All symbol (Low)
input bool  Use_Max_Positive_trade_AUD     =false;  // Use Max Positive Trades For AUD daily
input int Max_Positive_trade_AUD     =10;  // Max Positive Trades For AUD daily
input bool  Use_Max_negative_trade_AUD     =false;  // Use Max Negative Trades For AUD daily
input int Max_Negative_trade_AUD     =10;  // Max Negative Trades For AUD daily
input bool  Use_Max_Positive_trade_EUR     =false;  // Use Max Positive Trades For EUR daily
input int Max_Positive_trade_EUR     =10;  // Max Positive Trades For EUR daily
input bool  Use_Max_Negative_trade_EUR     =false;  // Use Max Negative Trades For EUR daily
input int Max_Negative_trade_EUR     =10;  // Max Negative Trades For EUR daily
input bool  Use_Max_Positive_trade_USD     =false;  // Use Max Positive Trades For USD daily
input int Max_Positive_trade_USD     =10;  // Max Positive Trades For USD daily
input bool  Use_Max_Negative_trade_USD     =false;  // Use Max Negative Trades For USD daily
input int Max_Negative_trade_USD     =10;  // Max Negative Trades For USD daily
input bool  Use_Max_Positive_trade_GBP     =false;  // Use Max Positive Trades For GBP daily
input int Max_Positive_trade_GBP     =10;  // Max Positive Trades For GBP daily
input bool  Use_Max_Negative_trade_GBP     =false;  // Use Max Negative Trades For GBP daily
input int Max_Negative_trade_GBP     =10;  // Max Negative Trades For GBP daily
input bool  Use_Max_Positive_trade_JPY     =false;  // Use Max Positive Trades For JPY daily
input int Max_Positive_trade_JPY     =10;  // Max Positive Trades For JPY daily
input bool  Use_Max_Negative_trade_JPY     =false;  // Use Max Negative Trades For JPY daily
input int Max_Negative_trade_JPY     =10;  // Max Negative Trades For JPY daily
input bool  Use_Max_Positive_trade_CAD     =false;  // Use Max Positive Trades For CAD daily
input int Max_Positive_trade_CAD     =10;  // Max Positive Trades For CAD daily
input bool  Use_Max_Negative_trade_CAD     =false;  // Use Max Negative Trades For CAD daily
input int Max_Negative_trade_CAD     =10;  // Max Negative Trades For CAD daily
input bool  Use_Max_Positive_trade_NZD     =false;  // Use Max Positive Trades For NZD daily
input int Max_Positive_trade_NZD     =10;  // Max Positive Trades For NZD daily
input bool  Use_Max_Negative_trade_NZD     =false;  // Use Max Negative Trades For NZD daily
input int Max_Negative_trade_NZD     =10;  // Max Negative Trades For NZD daily
input bool  Use_Max_Positive_trade_CHF     =false;  // Use Max Positive Trades For CHF daily
input int Max_Positive_trade_CHF     =10;  // Max Positive Trades For CHF daily
input bool  Use_Max_Negative_trade_CHF     =false;  // Use Max Negative Trades For CHF daily
input int Max_Negative_trade_CHF     =10;  // Max Negative Trades For CHF daily
input bool  Use_weekly_Max_Positive_trade_AUD     =false;  // Use Max Positive Trades For AUD weekly
input int weekly_Max_Positive_trade_AUD     =10;  // Max Positive Trades For AUD weekly
input bool  Use_weekly_Max_Negative_trade_AUD     =false;  // Use Max Negative Trades For AUD weekly
input int weekly_Max_Negative_trade_AUD     =10;  // Max Negative Trades For EUR weekly
input bool  Use_weekly_Max_Positive_trade_EUR     =false;  // Use Max Positive Trades For EUR weekly
input int weekly_Max_Positive_trade_EUR     =10;  // Max Positive Trades For EUR weekly
input bool  Use_weekly_Max_Negative_trade_EUR     =false;  // Use Max Negative Trades For EUR weekly

input int weekly_Max_Negative_trade_EUR     =10;  // Max Negative Trades For EUR weekly
input bool  Use_weekly_Max_Positive_trade_USD     =false;  // Use Max Positive Trades For USD weekly
input int weekly_Max_Positive_trade_USD     =10;  // Max Positive Trades For USD weekly
input bool  Use_weekly_Max_Negative_trade_USD     =false;  // Use Max Negative Trades For USD weekly

input int weekly_Max_Negative_trade_USD     =10;  // Max Negative Trades For USD weekly
input bool  Use_weekly_Max_Positive_trade_GBP     =false;  // Use Max Positive Trades For GBP weekly
input int weekly_Max_Positive_trade_GBP     =10;  // Max Positive Trades For GBP weekly
input bool  Use_weekly_Max_Negative_trade_GBP     =false;  // Use Max Negative Trades For GBP weekly

input int weekly_Max_Negative_trade_GBP     =10;  // Max Negative Trades For GBP weekly
input bool  Use_weekly_Max_Positive_trade_JPY     =false;  // Use Max Positive Trades For JPY weekly
input int weekly_Max_Positive_trade_JPY     =10;  // Max Positive Trades For JPY weekly
input bool  Use_weekly_Max_Negative_trade_JPY     =false;  // Use Max Negative Trades For JPY weekly

input int weekly_Max_Negative_trade_JPY     =10;  // Max Negative Trades For JPY weekly
input bool  Use_weekly_Max_Positive_trade_CAD     =false;  // Use Max Positive Trades For CAD weekly
input int weekly_Max_Positive_trade_CAD     =10;  // Max Positive Trades For CAD weekly
input bool  Use_weekly_Max_Negative_trade_CAD     =false;  // Use Max Negative Trades For CAD weekly

input int weekly_Max_Negative_trade_CAD     =10;  // Max Negative Trades For CAD weekly
input bool  Use_weekly_Max_Positive_trade_NZD     =false;  // Use Max Positive Trades For NZD weekly
input int weekly_Max_Positive_trade_NZD     =10;  // Max Positive Trades For NZD weekly
input bool  Use_weekly_Max_Negative_trade_NZD     =false;  // Use Max Negative Trades For NZD weekly
input int weekly_Max_Negative_trade_NZD     =10;  // Max Negative Trades For NZD weekly
input bool  Use_weekly_Max_Positive_trade_CHF     =false;  // Use Max Positive Trades For CHF weekly
input int weekly_Max_Positive_trade_CHF     =10;  // Max Positive Trades For CHF weekly
input bool  Use_weekly_Max_Negative_trade_CHF     =false;  // Use Max Negative Trades For CHF weekly
input int weekly_Max_Negative_trade_CHF     =10;  // Max Negative Trades For CHF weekly
input double Max_DrawDown             =40;
input bool close_Drawdown             =true;  // Close All when reach Max DrawDown
input DD_Action DrawDown_Action      =ClosAll;
input bool close_All_prec_profit      =true; // Close All Positions when account profit reach xx%
input double prec_profit_close        =20;   // xx% profit to close all
input bool close_position_prec_profit =true; //Close one Position when its profit reach xx%
input double prec_close_position      =20;  // xx% profit to close position
input bool closeAll_DayEnd            =false; //close All Positions at the end of the day
input bool closeAll_WeekEnd           =false; //close All Positions at the end of the week
input bool closeAll_MonthEnd          =false;//close All Positions at the end of the Month
input bool daily_gain_limit          =false;
input double daily_gain_limit_prcentage_low=10;
input double daily_gain_limit_prcentage_mid=10;
input double daily_gain_limit_prcentage_high=10;
input bool weekly_gain_limit        =false;
input double weekly_gain_limit_prcentage_low=10;
input double weekly_gain_limit_prcentage_mid=10;
input double weekly_gain_limit_prcentage_high=10;
input bool monthly_gain_limit        =false;
input double monthly_gain_limit_prcentage_low=10;
input double monthly_gain_limit_prcentage_mid=10;
input double monthly_gain_limit_prcentage_high=10;
input bool daily_loss_limit          =false;
input double daily_loss_limit_prcentage_low=10;
input double daily_loss_limit_prcentage_mid=10;
input double daily_loss_limit_prcentage_high=10;
input bool weekly_loss_limit        =false;
input double weekly_loss_limit_prcentage_low=10;
input double weekly_loss_limit_prcentage_mid=10;
input double weekly_loss_limit_prcentage_high=10;
input bool monthly_loss_limit        =false;
input double monthly_loss_limit_prcentage_low=10;
input double monthly_loss_limit_prcentage_mid=10;
input double monthly_loss_limit_prcentage_high=10;
input string set71 = "======================== Closing with time =========================";
input bool CloseAllWitTime=false;
input DYS_WEEK DayToCloseAll=Friday;
input int HourToCloseAll= 22;
input int MinToCloseAll=0;
input bool PartialclosewithTime=false;
input DYS_WEEK DayToCloseAllParial=Friday;
input int HourToCloseAllPartial= 22;
input int MinToCloseAllPartial=0;
input double ParialClosePrecentage=20;
input bool CloseLossWithTime=false;
input DYS_WEEK DayToCloseLoss=Friday;
input int HourToCloseloss= 22;
input int MinToCloseLoss=0;
input bool CloseProfitWithTime=false;
input DYS_WEEK DayToCloseProfit=Friday;
input int HourToCloseProfit= 22;
input int MinToCloseProfit=0;


input string set8         = "======================CMS Indicator Settings ================";
input ENUM_TIMEFRAMES period = PERIOD_CURRENT;// Period for CMS
input int latency             = 0;// Latency (Refresh delay in seconds) 0 means every tick
input int  log_level          = 3; // Log level (Trace = 0, Info = 1, Warning = 2, Error = 3, Critical = 4)
input int  shift1              = 1;// Candles for calculation
input int  shift0             = 0;// Candles shift from the beginning
input bool use_MA             =false; // Use Moving Average smoothing
input int MA_P                =0;// Moving Average Period for smoothing
input int MA_M                =0;// Moving Average Method for smoothing (MODE_SMA = 0 (Simple averaging), MODE_EMA = 1 (Exponential averaging), MODE_SMMA = 2 (Smoothed averaging), MODE_LWMA = 3 (Linear-weighted averaging))
input bool Auto_Suffix        =true ; // Auto detect symbols suffix ("Use suffix" should be disabled)
input bool use_Suffix         =false; // Use suffix
input int Algo_Type           =0;// CSM algorithm type (RSI = 0, CCI = 1, RVI = 2, MFI = 3, Stochastic = 4, DeMarket = 5, Momentum = 6)
input string Algo_Params      ="";// CSM algorithm params (Empty string means default params)


input string Set9 = "===========================Indicators============================";
input bool useAlerts = true; // Use popup Alerts
input bool useTel = false; // Use Telegram Alerts
input string InpChannelName = "fmfxstk"; // Telegram Channel ID
input string InpToken = "5111296664:AAEg7d8drUaTphBVRDYU7YWWtcVz6EIuvTU"; // Telegram Token
input string p00 = "<----------------->SAR<----------------->"; //******* SAR **************
input bool useSAR = true; // Use SAR
input bool ShowSar = true;
input ENUM_TIMEFRAMES sar_tf = PERIOD_CURRENT; // Timeframe
input double sar_step = 0.02; // Step
input double sar_max = 0.2; // Maximum

input string p01 = "<----------------->SINGLE MA<----------------->"; //******* SINGLE MA *********
input bool useSingleMA = true; // Use single MA
input bool ShowSingleMA=true;
input ENUM_TIMEFRAMES MA1_tf = PERIOD_CURRENT; // Timeframe
input int MA1_per = 50; // Period
input ENUM_MA_METHOD MA1_method = MODE_SMA; // Method
input ENUM_APPLIED_PRICE MA1_price = PRICE_CLOSE; // Applied price

input string p02 = "<----------------->DOUBLE MA<----------------->"; //******** DOUBLE MA *********
input bool useDoubleMA = true; // Use double MA
input bool showDoubleMa=true;
input ENUM_TIMEFRAMES MA2_tf = PERIOD_CURRENT; // Fast MA Timeframe
input int MA2_per = 10; // Fast MA Period
input ENUM_MA_METHOD MA2_method = MODE_SMA; // Fast MA Method
input ENUM_APPLIED_PRICE MA2_price = PRICE_CLOSE; // Fast MA Applied price
input ENUM_TIMEFRAMES MA3_tf = PERIOD_CURRENT; // Slow MA Timeframe
input int MA3_per = 20; // Slow MA Period
input ENUM_MA_METHOD MA3_method = MODE_SMA; // Slow MA Method
input ENUM_APPLIED_PRICE MA3_price = PRICE_CLOSE; // Slow MA Applied price

input string p03 = "<----------------->SUPERTREND<----------------->"; //******** SUPERTREND ********
input bool useSuperTrend = true; // Use supertrend
input bool showSupertrend=true;
input ENUM_TIMEFRAMES st_tf = PERIOD_CURRENT; // Timeframe
input int st_per = 10; // Period
input double st_mult = 4.5; // Multiplier

input string p05 = "<-----------------> STOCHASTIC<-----------------> "; //******** STOCHASTIC ********
input bool useSto = true; // Use stochastic oscillator
input bool showSto =true;
input ENUM_TIMEFRAMES sto_tf = PERIOD_CURRENT; // Timeframe
input int sto_dper = 10; // STO D-Period
input int sto_kper = 3; // STO K-Period
input int sto_sper = 3; // STO Slow-Period

input string p06 = "<-----------------> MACD <----------------->"; //******** MACD ********
input bool useMacd = true; // Use MACD
input bool showMacd  =true;
input indi_type MacdType=increase_Decrease;
input ENUM_TIMEFRAMES mac_tf = PERIOD_CURRENT; // Timeframe
input int mac_fper = 12; // Fast EMA
input int mac_sper = 26; // Slow EMA
input int mac_smper = 9; // SMA
input double macd_level = 0; // level

input string p07 = "<-----------------> ADX <----------------->"; //******** ADX ********
input bool useAdx = true; // Use ADX
input bool showAdx = true;
input indi_type AdxType=increase_Decrease;
input ENUM_TIMEFRAMES adx_tf = PERIOD_CURRENT; // Timeframe
input int adx_per = 14; // Period
input double adx_lev = 25; // Level

input string p08 = "<-----------------> ATR <----------------->"; //******** ATR ********
input bool useAtr = true; // Use ATR
input bool showAtr= true;
input indi_type AtrType=increase_Decrease;
input ENUM_TIMEFRAMES atr_tf = PERIOD_CURRENT; // Timeframe
input int atr_per = 14; // Period

input string p09 = "<-----------------> RSI <----------------->"; //******** RSI ********
input bool useRSI = true; // Use RSI
input bool showRsi = true;
input indi_type RsiType=Default;
input ENUM_TIMEFRAMES rsi_tf = PERIOD_CURRENT; // Timeframe
input int rsi_per = 14; // Period
input double rsi_level = 50; // level

input string p10 = "<-----------------> BOLLINGER <----------------->"; //******** BOLLINGER BAND ********
input bool useBB = true; // Use Bollinger
input bool ShowBB = true;
input indi_type BBType=Default;
input ENUM_TIMEFRAMES bb_tf = PERIOD_CURRENT; // Timeframe
input int BB_per = 28; // Period
input double BB_dev = 2; // Deviation

input string p12 = "<-----------------> ICHIMOKU <----------------->"; //******** ICHIMOKU ********
input bool useIchi = true; // Use Ichimoku
input bool showIchi = true;
input indi_type IchType=increase_Decrease;
input ENUM_TIMEFRAMES Ichi_tf = PERIOD_CURRENT; // Timeframe
input int tekan = 9; // Tekan
input int kijun = 26; // Kijun
input int senkou = 52; // Senkou-Span B

bool KeyboardTrading = true; /*Keyboard Trading*/
input string set10  = "==================================  Dashboard Settings  =============================";
input ENUM_MODE SelectedMode = COMPACT; /*Dashboard (Size)*/
input bool showAvg           =true;
input bool showBase          =true;
input bool showQuote         =true;
input bool showCSM           =true;//Show CSM Tradable
input bool ShowTradeable     =true;
input bool showClosable      =true;
input bool ShowSL            =true;
input bool ShowTp            =true;
input color COLOR_BORDER = C'255, 151, 25'; /*Panel Border*/
input color COLOR_CBG_LIGHT = C'252, 252, 252'; /*Chart Background (Light)*/
input color COLOR_CBG_DARK = C'28, 27, 26'; /*Chart Background (Dark)*/

string sTradeSymbols = TradeSymbols;
string sFontType = "";
//---
double RiskP = 0;
double RiskC = 0;
double RiskInpC = 0;
double RiskInpP = 0;
//---
int ResetAlertUp = 0;
int ResetAlertDwn = 0;
bool UserIsEditing = false;
bool UserWasNotified = false;
//---
double StopLossDist = 0;
double RiskInp = 0;
double RR = 0;
double _TP = 0;
//---
int SelectedTheme = 0;
int PriceRowLeft = 0;
int PriceRowRight = 0;
bool ShowTradePanel = true;
//---
int ErrorInterval = 300;
int LastReason = 0;
string ErrorSound = "error.wav";
bool SoundIsEnabled = false;
bool AlarmIsEnabled = false;
int ProfitMode = 0;
//---
bool AUDAlarm = true;
bool CADAlarm = true;
bool CHFAlarm = true;
bool EURAlarm = true;
bool GBPAlarm = true;
bool JPYAlarm = true;
bool NZDAlarm = true;
bool USDAlarm = true;
//---
bool AUDTrigger = false;
bool CADTrigger = false;
bool CHFTrigger = false;
bool EURTrigger = false;
bool GBPTrigger = false;
bool JPYTrigger = false;
bool NZDTrigger = false;
bool USDTrigger = false;
//----
string SuggestedPair = "";
int LastTimeFrame = 0;
int LastMode = -1;
//---
bool AutoSL = false;
bool AutoTP = false;
bool AutoLots = false;
bool ClearedTemplate = false;
bool FirstRun = true;
//---
color COLOR_BG = clrNONE;
color COLOR_FONT = clrNONE;
//---
color COLOR_GREEN = clrForestGreen;
color COLOR_RED = clrFireBrick;
color COLOR_SELL = C'225, 68, 29';
color COLOR_BUY = C'3, 95, 172';
color COLOR_CLOSE = clrNONE;
color COLOR_AUTO = clrDodgerBlue;
color COLOR_LOW = clrNONE;
color COLOR_MARKER = clrNONE;
int FONTSIZE = 9;
//---
int _x1 = 0;
int _y1 = 0;
int ChartX = 0;
int ChartY = 0;
int Chart_XSize = 0;
int Chart_YSize = 0;
int CalcTF = 0;
datetime drop_time = 0;
datetime stauts_time = 0;
//---
color COLOR_REGBG = C'27, 27, 27';
color COLOR_REGFONT = clrSilver;
//---
int Bck_Win_X = 255;
int Bck_Win_Y = 150;
//---
string aSymbols[];
string UsedSymbols[];
//---
string MB_CAPTION = ExpertName+" v"+Version+" | "+Copyright;
//---
string PriceRowLeftArr[] =
  {
   "Bid",
   "Low",
   "Open",
   "Pivot"
  };
string PriceRowRightArr[] =
  {
   "Ask",
   "High",
   "Open",
   "Pivot"
  };

double Daily_Balance,Weekly_Balance,Monthly_Balance;
/////////////
datetime lastweek=0;
datetime lastDay=0;
bool TradeAllow_Day[];
bool TradeAllow_Day_ALl=true;
bool TradeAllow_Week[];
bool TradeAllow_Week_ALl=true;
bool limit_gain=false;
bool daily_limit=false;
bool weekly_limit=false;
bool monthly_limit=false;
datetime daily_limit_date=0;
datetime weekly_limit_date=0;
datetime monthly_limit_date=0;
double daily_loss_limit_prcentage,daily_gain_limit_prcentage,
       weekly_gain_limit_prcentage,weekly_loss_limit_prcentage,
       monthly_loss_limit_prcentage,monthly_gain_limit_prcentage;
bool limit_loss=false;
bool daily_limit_loss=false;
bool weekly_limit_loss=false;
bool monthly_limit_loss=false;
datetime daily_limit_date_loss=0;
datetime weekly_limit_date_loss=0;
datetime monthly_limit_date_loss=0;
//variables
double Lot;
int Max_negative_symbol_daily  =0;
int Max_negative_All_daily     =0;
int Max_negative_symbol_weekly =0;
int Max_negative_All_weekly   =0;
int Max_Positive_symbol_daily=0;
int Max_Positive_All_daily    =0;
int Max_Positive_symbol_weekly=0;
int Max_Positive_All_weekly=0;
int tradableNum=0;
int ClosableNum=0;
RISKOPTIONS Risk=0;
datetime StartTime=0;
int s_ma_handle[], d_fma_handle[], d_sma_handle[], st_handle[], storsi_handle[], sto_handle[], mac_handle[], adx_handle[], atr_handle[], rsi_handle[], bb_handle[], bbw_handle[];
int Ichi_handle[], rsiDiv_handle[], sar_handle[];
datetime time0[],time1[];
int buyPartial[],sellPartial[];
double currenciesStrength[CURRENCIES_COUNT];
double currenciesStrength1[CURRENCIES_COUNT];
double currenciesStrength2[CURRENCIES_COUNT];
string cc0 = "";
bool signal[];
CExecute * trades[];
CPosition * Positions[];
CPosition * SellPositions[];
CPosition * BuyPositions[];
CUtilities * tools[];
CHistoryPosition * Hist[];

//telegram bot class
//+------------------------------------------------------------------+
//|   CMyBot                                                         |
//+------------------------------------------------------------------+
class CMyBot: public CCustomBot
  {
private:
   string            m_button[35];
public:
   //+------------------------------------------------------------------+
   void              CMyBot::CMyBot(void) {}

   //+------------------------------------------------------------------+
   void              ProcessMessages(string update)
     {
      if(cc0 != "")
        {
         int res = bot.SendMessage(InpChannelName, cc0, false, false);
         if(res != 0)
            Print("Error: ", GetErrorDescription(res));
         else
            cc0 = "";
        }
     }
  };
CMyBot bot;
int getme_result;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
//---- CreateTimer
   EventSetMillisecondTimer(100);
   StartTime=TimeCurrent();
   if(useTel)
     {
      //--- set token
      bot.Token(InpToken);
      //--- check token
      getme_result = bot.GetMe();
     }
   if(use_CMS_Filters)
     {
      // Initializing of CMS indicator
      g_handle = iCustom(
                    NULL,       // Symbol for CMS
                    period,  // Period for CMS
                    "Market\\Currency Strength Meter Pro for EA MT5",     // Indicator path
                    latency,          // Latency (Refresh delay in seconds) 0 means every tick
                    log_level,          // Log level (Trace = 0, Info = 1, Warning = 2, Error = 3, Critical = 4)
                    shift1,          // Candles for calculation
                    shift0,          // Candles shift from the beginning
                    use_MA,      // Use Moving Average smoothing
                    MA_P,          // Moving Average Period for smoothing
                    MA_M,          // Moving Average Method for smoothing (MODE_SMA = 0 (Simple averaging), MODE_EMA = 1 (Exponential averaging), MODE_SMMA = 2 (Smoothed averaging), MODE_LWMA = 3 (Linear-weighted averaging))
                    Auto_Suffix,       // Auto detect symbols suffix ("Use suffix" should be disabled)
                    use_Suffix,      // Use suffix
                    Suffix,         // Symbols Suffix
                    Algo_Type,          // CSM algorithm type (RSI = 0, CCI = 1, RVI = 2, MFI = 3, Stochastic = 4, DeMarket = 5, Momentum = 6)
                    Algo_Params          // CSM algorithm params (Empty string means default params)
                 );

      // Checking that CSM indicator was initialised
      if(g_handle == INVALID_HANDLE)
        {
         printf("Error creating CSM indicator");
        }
      CLIENT_BG_WIDTH+=200;

     }
//--- Disclaimer
   if(!GlobalVariableCheck(OBJPREFIX+"Disclaimer") || GlobalVariableGet(OBJPREFIX+"Disclaimer") != 1)
     {
      //---
      string message = "DISCLAIMER:\n\n Hello ";
      //---
      if(MessageBox(message, MB_CAPTION, MB_OKCANCEL|MB_ICONWARNING) == IDOK)
         GlobalVariableSet(OBJPREFIX+"Disclaimer", 1);

     }

//---
   if(!GlobalVariableCheck(OBJPREFIX+"Theme"))
      SelectedTheme = 1;
   else
      SelectedTheme = (int)GlobalVariableGet(OBJPREFIX+"Theme");

//---
   if(SelectedTheme == 0)
     {
      COLOR_BG = C'240,240,240';
      COLOR_FONT = C'40,41,59';
      COLOR_GREEN = clrForestGreen;
      COLOR_RED = clrIndianRed;
      COLOR_LOW = clrGoldenrod;
      COLOR_MARKER = clrDarkOrange;
     }
   else
     {
      COLOR_BG = C'28,28,28';
      COLOR_FONT = clrSilver;
      COLOR_GREEN = clrLimeGreen;
      COLOR_RED = clrRed;
      COLOR_LOW = clrYellow;
      COLOR_MARKER = clrGold;
     }

//---
   Daily_Balance = AccountInfoDouble(ACCOUNT_BALANCE);
   Weekly_Balance = AccountInfoDouble(ACCOUNT_BALANCE);
   Monthly_Balance = AccountInfoDouble(ACCOUNT_BALANCE);
   if(LastReason == 0)
     {

      //--- OfflineChart
      if(ChartGetInteger(0, CHART_IS_OFFLINE))
        {
         MessageBox("The currenct chart is offline, make sure to uncheck \"Offline chart\" under Properties(F8)->Common.",
                    MB_CAPTION, MB_OK|MB_ICONERROR);

        }

      //--- CheckConnection
      if(!TerminalInfoInteger(TERMINAL_CONNECTED))
         MessageBox("Warning: No Internet connection found!\nPlease check your network connection.",
                    MB_CAPTION+" | "+"#"+IntegerToString(123), MB_OK|MB_ICONWARNING);

      //--- CheckTradingIsAllowed
      if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))//Terminal
        {
         MessageBox("Warning: Check if automated trading is allowed in the terminal settings!",
                    MB_CAPTION+" | "+"#"+IntegerToString(123), MB_OK|MB_ICONWARNING);
        }
      else
        {
         if(!MQLInfoInteger(MQL_TRADE_ALLOWED))//CheckBox
           {
            MessageBox("Warning: Automated trading is forbidden in the program settings for "+__FILE__,
                       MB_CAPTION+" | "+"#"+IntegerToString(123), MB_OK|MB_ICONWARNING);
           }
        }

      //---
      if(!AccountInfoInteger(ACCOUNT_TRADE_EXPERT))//Server
         MessageBox("Warning: Automated trading is forbidden for the account "+IntegerToString(AccountInfoInteger(ACCOUNT_LOGIN))+" at the trade server side.",
                    MB_CAPTION+" | "+"#"+IntegerToString(123), MB_OK|MB_ICONWARNING);

      //---
      if(!AccountInfoInteger(ACCOUNT_TRADE_ALLOWED))//Investor
         MessageBox("Warning: Trading is forbidden for the account "+IntegerToString(AccountInfoInteger(ACCOUNT_LOGIN))+"."+
                    "\n\nPerhaps an investor password has been used to connect to the trading account."+
                    "\n\nCheck the terminal journal for the following entry:"+
                    "\n\'"+IntegerToString(AccountInfoInteger(ACCOUNT_LOGIN))+"\': trading has been disabled - investor mode.",
                    MB_CAPTION+" | "+"#"+IntegerToString(ERR_TRADE_DISABLED), MB_OK|MB_ICONWARNING);

      //---
      if(!SymbolInfoInteger(_Symbol, SYMBOL_TRADE_MODE))//Symbol
         MessageBox("Warning: Trading is disabled for the symbol "+_Symbol+" at the trade server side.",
                    MB_CAPTION+" | "+"#"+IntegerToString(ERR_TRADE_DISABLED), MB_OK|MB_ICONWARNING);

      //--- CheckDotsPerInch
      if(TerminalInfoInteger(TERMINAL_SCREEN_DPI) != 96)
        {
         Comment("Warning: 96 DPI highly recommended !");
         Sleep(3000);
         Comment("");
        }

     }


//--- Input Symbols Changed
   if(sTradeSymbols != TradeSymbols || LastReason == 0)
     {
      //---
      ArrayResize(aSymbols, 0, 0);
      ObjectsDeleteAll(0, OBJPREFIX, -1, -1);
      //--- Get Trade Symobols
      if(StringFind(TradeSymbols, ";", 0) == -1)
        {
         //---
         string message = "No separator found !\nMake sure to separate symbols with a semicolon \" ; \".";
         //---
         MessageBox(message, MB_CAPTION, MB_OK|MB_ICONERROR);
         Comment(message);
         //---
         ObjectsDeleteAll(0, OBJPREFIX, -1, -1);
        }
      string pairs = TradeSymbols;
      //--- Semicolon at the first place
      if(StringFind(pairs, ";", 0) == 0)
         pairs = StringSubstr(pairs, 1, StringLen(pairs));

      //---
      StringTrimRight(pairs);
      StringTrimLeft(pairs);

      //---

      //---
      int s = 0,
          k = StringFind(pairs, ";", s);
      string current;

      //---
      while(k > 0)
        {
         //---
         current = StringSubstr(pairs, s, k-s);
         //---
         if(SymbolFind(Prefix+current+Suffix, false))
           {
            ArrayResize(aSymbols, ArraySize(aSymbols)+1);
            aSymbols[ArraySize(aSymbols)-1] = current;
           }
         //---
         s = k+1;
         k = StringFind(pairs, ";", s);
        }

      //--- Check for Symbols (Trading)
      for(int i = 0; i < ArraySize(aSymbols); i++)
        {
         //---
         if(!SymbolFind(Prefix+aSymbols[i]+Suffix, true))
            if(SymbolFind(Prefix+aSymbols[i]+Suffix, false))
               SymbolSelect(Prefix+aSymbols[i]+Suffix, true);

        }
      //---
      sTradeSymbols = pairs;
     }
   ArrayResize(s_ma_handle, ArraySize(aSymbols));
   ArrayResize(d_fma_handle, ArraySize(aSymbols));
   ArrayResize(d_sma_handle, ArraySize(aSymbols));
   ArrayResize(st_handle, ArraySize(aSymbols));
   ArrayResize(sto_handle, ArraySize(aSymbols));
   ArrayResize(mac_handle, ArraySize(aSymbols));
   ArrayResize(adx_handle, ArraySize(aSymbols));
   ArrayResize(atr_handle, ArraySize(aSymbols));
   ArrayResize(rsi_handle, ArraySize(aSymbols));
   ArrayResize(bb_handle, ArraySize(aSymbols));
   ArrayResize(Ichi_handle, ArraySize(aSymbols));
   ArrayResize(rsiDiv_handle, ArraySize(aSymbols));
   ArrayResize(time0, ArraySize(aSymbols));
   ArrayResize(time1, ArraySize(aSymbols));
   ArrayResize(sar_handle, ArraySize(aSymbols));
   ArrayResize(signal, ArraySize(aSymbols));
   int size = ArraySize(aSymbols);
   ArrayResize(trades, size, size);
   ArrayResize(Positions, size, size);
   ArrayResize(SellPositions, size, size);
   ArrayResize(BuyPositions, size, size);
   ArrayResize(tools, size, size);
   ArrayResize(buyPartial,size,size);
   ArrayResize(sellPartial,size,size);
   ArrayResize(Hist,size,size);
   ArrayResize(TradeAllow_Day,size,size);
   ArrayResize(TradeAllow_Week,size,size);


//--- InitFullSymbs


   for(int i = 0; i < ArraySize(aSymbols); i++)
     {
      if(useSingleMA)
        {
         s_ma_handle[i] = iMA(Prefix+aSymbols[i]+Suffix, MA1_tf, MA1_per, 0, MA1_method, MA1_price);
         if(s_ma_handle[i] < 0)
           {
            Print("The iMA object is not created: Error", GetLastError());
            return(-1);
           }


        }
      //---
      if(useDoubleMA)
        {
         d_fma_handle[i] = iMA(Prefix+aSymbols[i]+Suffix, MA2_tf, MA2_per, 0, MA2_method, MA2_price);
         if(d_fma_handle[i] < 0)
           {
            Print("The iMA object is not created: Error", GetLastError());
            return(-1);
           }

         //---

         d_sma_handle[i] = iMA(Prefix+aSymbols[i]+Suffix, MA3_tf, MA3_per, 0, MA3_method, MA3_price);
         if(d_sma_handle[i] < 0)
           {
            Print("The iMA object is not created: Error", GetLastError());
            return(-1);
           }


        }
      //---
      if(useSuperTrend||sltype==2||useAtr)
        {
         st_handle[i] = iCustom(Prefix+aSymbols[i]+Suffix, st_tf, "supertrend", st_per, st_mult, false);
         if(st_handle[i] < 0)
           {
            Print("The iCustom::Supertrend object is not created: Error", GetLastError());
            return(-1);
           }

        }

      //---
      if(useSto)
        {
         sto_handle[i] = iStochastic(Prefix+aSymbols[i]+Suffix, sto_tf, sto_kper, sto_dper, sto_sper, MODE_SMA, STO_LOWHIGH);
         if(sto_handle[i] < 0)
           {
            Print("The iStochastic object is not created: Error", GetLastError());
            return(-1);
           }

        }
      //---
      if(useMacd)
        {
         mac_handle[i] = iMACD(Prefix+aSymbols[i]+Suffix, mac_tf, mac_fper, mac_sper, mac_smper, PRICE_CLOSE);
         if(mac_handle[i] < 0)
           {
            Print("The iMACD object is not created: Error", GetLastError());
            return(-1);
           }

        }
      //---
      if(useAdx)
        {
         adx_handle[i] = iADX(Prefix+aSymbols[i]+Suffix, adx_tf, adx_per);
         if(adx_handle[i] < 0)
           {
            Print("The iADX object is not created: Error", GetLastError());
            return(-1);
           }

        }
      //---
      if(useAtr)
        {
         atr_handle[i] = iADX(Prefix+aSymbols[i]+Suffix, atr_tf, atr_per);
         if(atr_handle[i] < 0)
           {
            Print("The iATR object is not created: Error", GetLastError());
            return(-1);
           }

        }
      //---
      if(useRSI)
        {
         rsi_handle[i] = iRSI(Prefix+aSymbols[i]+Suffix, rsi_tf, rsi_per, PRICE_CLOSE);
         if(rsi_handle[i] < 0)
           {
            Print("The iRSI object is not created: Error", GetLastError());
            return(-1);
           }

        }
      //---
      if(useBB)
        {
         bb_handle[i] = iBands(Prefix+aSymbols[i]+Suffix, bb_tf, BB_per, 0, BB_dev, PRICE_CLOSE);
         if(bb_handle[i] < 0)
           {
            Print("The iBands object is not created: Error", GetLastError());
            return(-1);
           }
        }

      //---
      if(useIchi)
        {
         Ichi_handle[i] = iIchimoku(Prefix+aSymbols[i]+Suffix, Ichi_tf, tekan, kijun, senkou);
         if(Ichi_handle[i] < 0)
           {
            Print("The iIchimoku object is not created: Error", GetLastError());
            return(-1);
           }
        }
      //---
      if(useSAR||sltype==1)
        {
         sar_handle[i] = iSAR(Prefix+aSymbols[i]+Suffix, sar_tf, sar_step, sar_max);
         if(sar_handle[i] < 0)
           {
            Print("The iSAR object is not created: Error", GetLastError());
            return(-1);
           }

        }
      string sym = Prefix+aSymbols[i]+Suffix;
      trades[i] = new CExecute(sym, magic_Number);
      BuyPositions[i] = new CPosition(sym, magic_Number, GROUP_POSITIONS_BUYS);
      SellPositions[i] = new CPosition(sym, magic_Number, GROUP_POSITIONS_SELLS);
      Positions[i] = new CPosition(sym, magic_Number, GROUP_POSITIONS_ALL);
      Hist[i]= new CHistoryPosition(sym,magic_Number,GROUP_HISTORY_POSITIONS_ALL);
      tools[i] = new CUtilities(sym);
      TradeAllow_Day[i]=true;
      TradeAllow_Week[i]=true;
      sellPartial[i]=0;
      buyPartial[i]=0;
     }

   if(useSingleMA&&ShowSingleMA)
     {

      CLIENT_BG_WIDTH+=50;
     }
//---
   if(useDoubleMA&&showDoubleMa)
     {

      CLIENT_BG_WIDTH+=50;

     }
//---
   if(useSuperTrend||sltype==2||useAtr)
     {

      if(useSuperTrend&&showSupertrend)
         CLIENT_BG_WIDTH+=50;
     }

//---
   if(useSto&&showSto)
     {

      CLIENT_BG_WIDTH+=50;
     }
//---
   if(useMacd&&showMacd)
     {

      CLIENT_BG_WIDTH+=50;
     }
//---
   if(useAdx&&showAdx)
     {

      CLIENT_BG_WIDTH+=50;
     }
//---
   if(useAtr&&showAtr)
     {

      CLIENT_BG_WIDTH+=50;
     }
//---
   if(useRSI&&showRsi)
     {

      CLIENT_BG_WIDTH+=50;
     }
//---
   if(useBB&&ShowBB)
     {

      CLIENT_BG_WIDTH+=50;
     }

//---
   if(useIchi&&showIchi)
      CLIENT_BG_WIDTH+=50;

   if(useSAR&&ShowSar)
      CLIENT_BG_WIDTH+=50;
   if(showAvg)
      CLIENT_BG_WIDTH+=50;
   if(ShowTradeable)
      CLIENT_BG_WIDTH+=100;
   if(showClosable)
      CLIENT_BG_WIDTH+=100;
   if(ShowSL)
      CLIENT_BG_WIDTH+=60;
   if(ShowTp)
      CLIENT_BG_WIDTH+=60;
//--- Init ChartSize
   Chart_XSize = (int)ChartGetInteger(0, CHART_WIDTH_IN_PIXELS);
   Chart_YSize = (int)ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS);
   ChartX = Chart_XSize;
   ChartY = Chart_YSize;

//--- CheckSoundIsEnabled
   if(!GlobalVariableCheck(OBJPREFIX+"Sound"))
      SoundIsEnabled = true;
   else
      SoundIsEnabled = GlobalVariableGet(OBJPREFIX+"Sound");

//--- Alert
   if(!GlobalVariableCheck(OBJPREFIX+"Alarm"))
      AlarmIsEnabled = true;
   else
      AlarmIsEnabled = GlobalVariableGet(OBJPREFIX+"Alarm");



//---
   if(!GlobalVariableCheck(OBJPREFIX+"Dashboard"))
      ShowTradePanel = true;
   else
      ShowTradePanel = GlobalVariableGet(OBJPREFIX+"Dashboard");


//---
   PriceRowLeft = (int)GlobalVariableGet(OBJPREFIX+"PRL");
   PriceRowRight = (int)GlobalVariableGet(OBJPREFIX+"PRR");

//---
   if(LastReason == 0)
      ChartGetColor();

//--- Hide OneClick Arrow
   ChartSetInteger(0, CHART_SHOW_ONE_CLICK, true);
   ChartSetInteger(0, CHART_SHOW_ONE_CLICK, false);

//--- ChartChanged
   if(LastReason == REASON_CHARTCHANGE)
      _PlaySound("switch.wav");

//---
   if(ShowTradePanel)
      ChartMouseScrollSet(false);
   else
      ChartMouseScrollSet(true);
//---
   if(SelectedMode != LastMode)
      ObjectsDeleteAll(0, OBJPREFIX, -1, -1);

//--- Init Speed Prices
   for(int i = ArraySize(aSymbols)-1; i >= 0; i--)
      GlobalVariableSet(OBJPREFIX+Prefix+aSymbols[i]+Suffix+" - Price", (SymbolInfoDouble(Prefix+aSymbols[i]+Suffix, SYMBOL_ASK)+SymbolInfoDouble(Prefix+aSymbols[i]+Suffix, SYMBOL_BID))/2);

//--- Animation
   if(LastReason == 0 && ShowTradePanel)
     {
      //---
      ObjectsCreateAll();
      ObjectSetInteger(0, OBJPREFIX+"PRICEROW_Lª", OBJPROP_COLOR, clrNONE);
      ObjectSetInteger(0, OBJPREFIX+"PRICEROW_Rª", OBJPROP_COLOR, clrNONE);
      //---
      SetStatus("6", "Please wait...");


      //---

      //---
      ResetStatus();
      //---
     }

//---
   FirstRun = false;

//--- Dropped Time
   drop_time = TimeLocal();

//--- Border Color
   if(ShowTradePanel)
     {
      //---
      if(ObjectFind(0, OBJPREFIX+"BORDER[]") == 0 || ObjectFind(0, OBJPREFIX+"BCKGRND[]") == 0)
        {
         //---
         if(ObjectGetInteger(0, OBJPREFIX+"BORDER[]", OBJPROP_COLOR) != COLOR_BORDER)
           {
            ObjectSetInteger(0, OBJPREFIX+"BORDER[]", OBJPROP_COLOR, COLOR_BORDER);
            ObjectSetInteger(0, OBJPREFIX+"BORDER[]", OBJPROP_BGCOLOR, COLOR_BORDER);
            ObjectSetInteger(0, OBJPREFIX+"BCKGRND[]", OBJPROP_COLOR, COLOR_BORDER);
           }
        }
     }
//---
   if(!ShowTradePanel)
     {
      //---
      if(ObjectFind(0, OBJPREFIX+"MIN"+"BCKGRND[]") == 0)
        {
         //---
         if(ObjectGetInteger(0, OBJPREFIX+"MIN"+"BCKGRND[]", OBJPROP_COLOR) != COLOR_BORDER)
           {
            ObjectSetInteger(0, OBJPREFIX+"MIN"+"BCKGRND[]", OBJPROP_COLOR, COLOR_BORDER);
            ObjectSetInteger(0, OBJPREFIX+"MIN"+"BCKGRND[]", OBJPROP_BGCOLOR, COLOR_BORDER);
           }
        }
     }

   cc0 = "Started Successfuly!";
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   for(int i=0; i<ArraySize(aSymbols); i++)
     {
      delete trades[i];
      delete Positions[i];
      delete Hist[i];
      delete tools[i];
      delete SellPositions[i];
      delete BuyPositions[i];
     }
//---- DestroyTimer
   EventKillTimer();

//--- Save global variables
   if(reason != REASON_INITFAILED && !MQLInfoInteger(MQL_TESTER))
     {

      //---
      GlobalVariableSet(OBJPREFIX+"Theme", SelectedTheme);
      //---
      GlobalVariableSet(OBJPREFIX+"Dashboard", ShowTradePanel);
      //---
      GlobalVariableSet(OBJPREFIX+"Sound", SoundIsEnabled);
      //---
      GlobalVariableSet(OBJPREFIX+"Alarm", AlarmIsEnabled);
      //---
      GlobalVariablesFlush();
     }
   ArrayInitialize(currenciesStrength, 0);
   ArrayInitialize(currenciesStrength1, 0);
   ArrayInitialize(currenciesStrength2, 0);
//--- DeleteObjects
   if(reason <= REASON_REMOVE || reason == REASON_CLOSE || reason == REASON_RECOMPILE || reason == REASON_INITFAILED || reason == REASON_ACCOUNT)
     {
      ObjectsDeleteAll(0, OBJPREFIX, -1, -1);
      DelteMinWindow();
     }

//---
   if(reason <= REASON_REMOVE || reason == REASON_CLOSE || reason == REASON_RECOMPILE)
     {
      //---
      if(ClearedTemplate)
         ChartSetColor(2);
     }

//--- UnblockScrolling
   ChartMouseScrollSet(true);

//--- UserIsRegistred
   if(!GlobalVariableCheck(OBJPREFIX+"Registred"))
      GlobalVariableSet(OBJPREFIX+"Registred", 1);

//---
   LastMode = SelectedMode;

//--- StoreDeinitReason
   LastReason = reason;
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   Risk=HighRisk;
   MqlDateTime current,tmrw;
   datetime currentDT=0;
   datetime tmrwDT=currentDT+24*60*60;
   currentDT=TimeCurrent();
   TimeToStruct(tmrwDT,tmrw);
   TimeToStruct(currentDT,current);
// RISK OPTIONS
   if(Monday_Filtter)
     {
      if(current.day_of_week==1)
        {
         Risk=Monday_Risk;
        }
     }

   if(last_week_month)
     {
      if(current.day>=21)
        {
         Risk=last_week_month_risk;
        }
     }

   if(first_week_month)
     {
      if(current.day<=7)
        {
         Risk=first_week_month_risk;
        }
     }

   if(first_day_month)
     {
      if(current.day==1)
        {
         Risk=first_day_month_risk;
        }
     }


   if(last_day_month)
     {
      if(tmrw.day==1)
        {
         Risk=last_day_month_risk;
        }
     }

   Max_negative_symbol_daily  =Risk==HighRisk?Max_negative_symbol_daily_high:Risk==MidRisk?Max_negative_symbol_daily_mid:Max_negative_symbol_daily_low;
   Max_negative_All_daily     =Risk==HighRisk?Max_negative_All_daily_high:Risk==MidRisk?Max_negative_All_daily_mid:Max_negative_All_daily_low;
   Max_negative_symbol_weekly =Risk==HighRisk?Max_negative_symbol_weekly_high:Risk==MidRisk?Max_negative_symbol_weekly_mid:Max_negative_symbol_weekly_low;
   Max_negative_All_weekly   =Risk==HighRisk?Max_negative_All_weekly_high:Risk==MidRisk?Max_negative_All_weekly_mid:Max_negative_All_weekly_low;
   Max_Positive_symbol_daily=Risk==HighRisk?Max_Positive_symbol_daily_high:Risk==MidRisk?Max_Positive_symbol_daily_mid:Max_Positive_symbol_daily_low;
   Max_Positive_All_daily    =Risk==HighRisk?Max_Positive_All_daily_high:Risk==MidRisk?Max_Positive_All_daily_mid:Max_Positive_All_daily_low;
   Max_Positive_symbol_weekly=Risk==HighRisk?Max_Positive_symbol_weekly_high:Risk==MidRisk?Max_Positive_symbol_weekly_mid:Max_Positive_symbol_weekly_low;
   Max_Positive_All_weekly=Risk==HighRisk?Max_Positive_All_weekly_high:Risk==MidRisk?Max_Positive_All_weekly_mid:Max_Positive_All_weekly_low;
   daily_gain_limit_prcentage=Risk==HighRisk?daily_gain_limit_prcentage_high:Risk==MidRisk?daily_gain_limit_prcentage_mid:daily_gain_limit_prcentage_low;
   daily_loss_limit_prcentage=Risk==HighRisk?daily_loss_limit_prcentage_high:Risk==MidRisk?daily_loss_limit_prcentage_mid:daily_loss_limit_prcentage_low;
   weekly_gain_limit_prcentage=Risk==HighRisk?weekly_gain_limit_prcentage_high:Risk==MidRisk?weekly_gain_limit_prcentage_mid:weekly_gain_limit_prcentage_low;
   weekly_loss_limit_prcentage=Risk==HighRisk?weekly_loss_limit_prcentage_high:Risk==MidRisk?weekly_loss_limit_prcentage_mid:weekly_loss_limit_prcentage_low;
   monthly_gain_limit_prcentage=Risk==HighRisk?monthly_gain_limit_prcentage_high:Risk==MidRisk?monthly_gain_limit_prcentage_mid:monthly_gain_limit_prcentage_low;
   monthly_loss_limit_prcentage=Risk==HighRisk?monthly_loss_limit_prcentage_high:Risk==MidRisk?monthly_loss_limit_prcentage_mid:monthly_loss_limit_prcentage_low;
//+------------------------------------------------------------------+
//|
//---
   Max_order_Day();
   Max_order_Weekly();


// Getting currencies strength for all 8 currencies to the currenciesStrength buffer
   if(use_CMS_Filters)
     {
      fetchCurrenciesStrength(currenciesStrength,currenciesStrength1,currenciesStrength2);

     }
   double Balance = AccountInfoDouble(ACCOUNT_BALANCE);
   double Profit= AccountInfoDouble(ACCOUNT_PROFIT);
   datetime d1=iTime(Symbol(),PERIOD_D1,0);
   datetime w1=iTime(Symbol(),PERIOD_W1,0);
   datetime m1 =iTime(Symbol(),PERIOD_M1,0);
   if(daily_gain_limit)
     {
      if(d1>daily_limit_date&&daily_limit)
        {
         daily_limit=false;
         Daily_Balance=AccountInfoDouble(ACCOUNT_BALANCE);
        }
      double Daily_profit=Balance-Daily_Balance+Profit;
      if(Daily_Balance*(daily_gain_limit_prcentage/100)<=Daily_profit)
        {
         Alert(" Daily gain limit reached");
         daily_limit=true;
         daily_limit_date=iTime(Symbol(),PERIOD_D1,0);
         for(int z=0; z<ArraySize(aSymbols); z++)
           {
            Positions[z].GroupCloseAll(30);
           }
        }
     }
   if(daily_loss_limit)
     {
      if(d1>daily_limit_date_loss)
        {
         daily_limit_loss=false;
         Daily_Balance=AccountInfoDouble(ACCOUNT_BALANCE);
        }
 double Daily_profit=Balance-Daily_Balance+Profit;
      if(Daily_Balance*(daily_loss_limit_prcentage/100)<=MathAbs(Daily_profit)&&Daily_profit<0)
        {
         Alert(" Daily loss limit reached");
         daily_limit_loss=true;
         daily_limit_date_loss=iTime(Symbol(),PERIOD_D1,0);
         for(int z=0; z<ArraySize(aSymbols); z++)
           {
            Positions[z].GroupCloseAll(30);
           }
        }
     }
 double Weekly_profit=Balance-Weekly_Balance+Profit;
   if(weekly_gain_limit)
     {
      if(w1>weekly_limit_date&&weekly_limit)
        {
         weekly_limit=false;
         Weekly_Balance=AccountInfoDouble(ACCOUNT_BALANCE);
        }
      if(Weekly_Balance*(weekly_gain_limit_prcentage/100)<=Weekly_profit)
        {
         Alert(" weekly gain limit reached");
         weekly_limit=true;
         weekly_limit_date=w1;
         for(int z=0; z<ArraySize(aSymbols); z++)
           {
            Positions[z].GroupCloseAll(30);
           }
        }
     }
   if(weekly_loss_limit)
     {
      if(w1>weekly_limit_date_loss&&weekly_limit_loss)
        {
         weekly_limit=false;
         Weekly_Balance=AccountInfoDouble(ACCOUNT_BALANCE);
        }
      if(Weekly_Balance*(weekly_loss_limit_prcentage/100)<=MathAbs(Weekly_profit)&&Weekly_profit<0)
        {
         Alert(" weekly loss limit reached");
         weekly_limit_loss=true;
         weekly_limit_date_loss=w1;
         for(int z=0; z<ArraySize(aSymbols); z++)
           {
            Positions[z].GroupCloseAll(30);
           }
        }
     }
 double Monthly_profit=Balance-Monthly_Balance+Profit;
   if(monthly_gain_limit)
     {
      if(m1>monthly_limit_date&&monthly_limit)
        {
         monthly_limit=false;
         Monthly_Balance=AccountInfoDouble(ACCOUNT_BALANCE);
        }
      if(Monthly_Balance*(monthly_gain_limit_prcentage/100)<=Monthly_profit)
        {
         Alert(" Monthly gain limit reached");
         monthly_limit=true;
         monthly_limit_date=m1;
         for(int z=0; z<ArraySize(aSymbols); z++)
           {
            Positions[z].GroupCloseAll(30);
           }
        }
     }
   if(monthly_loss_limit)
     {
      if(m1>monthly_limit_date_loss&&monthly_limit_loss)
        {
         monthly_limit_loss=false;
         Monthly_Balance=AccountInfoDouble(ACCOUNT_BALANCE);
        }
      if(Monthly_Balance*(monthly_loss_limit_prcentage/100)<=MathAbs(Monthly_profit)&&Monthly_profit<0)
        {
         Alert(" Monthly loss limit reached");
         monthly_limit_loss=true;
         monthly_limit_date_loss=m1;
         for(int z=0; z<ArraySize(aSymbols); z++)
           {
            Positions[z].GroupCloseAll(30);
           }
        }
     }
   MqlDateTime today;
   datetime todayDT=TimeCurrent();
   TimeToStruct(todayDT,today);
   if(CloseAllWitTime)
     {
      if(today.day_of_week==DayToCloseAll&&today.hour==HourToCloseAll&&today.min==MinToCloseAll)
        {
         for(int x=0; x<ArraySize(aSymbols); x++)
           {
            Positions[x].GroupCloseAll(30);
           }
        }
     }
   if(PartialclosewithTime)
     {
      if(today.day_of_week==DayToCloseAllParial&&today.hour==HourToCloseAllPartial&&today.min==MinToCloseAllPartial)
        {
         for(int x=0; x<ArraySize(aSymbols); x++)
           {
            for(int z=0; z<Positions[x].GroupTotal(); z++)
              {
               double ll=Positions[x][z].GetVolume();
               Positions[x][z].ClosePartial(ll*(ParialClosePrecentage/100),30);
              }
           }
        }
     }
   if(CloseLossWithTime)
     {
      if(today.day_of_week==DayToCloseLoss&&today.hour==HourToCloseloss&&today.min==MinToCloseLoss)
        {
         for(int x=0; x<ArraySize(aSymbols); x++)
           {
            for(int z=0; z<Positions[x].GroupTotal(); z++)
              {
               double pp= Positions[x][z].GetProfit();
               if(pp<0&&CloseLossWithTime)
                 {
                  Positions[x][z].Close(30);
                 }

              }
           }
        }
     }
   if(CloseProfitWithTime)
     {
      if(today.day_of_week==DayToCloseProfit&&today.hour==HourToCloseProfit&&today.min==MinToCloseProfit)
        {
         for(int x=0; x<ArraySize(aSymbols); x++)
           {
            for(int z=0; z<Positions[x].GroupTotal(); z++)
              {
               double pp= Positions[x][z].GetProfit();
               if(pp>0&&CloseProfitWithTime)
                 {
                  Positions[x][z].Close(30);
                 }

              }
           }
        }
     }
   limit_gain=!daily_limit&&!weekly_limit&&!monthly_limit;
   limit_loss=!daily_limit_loss&&!weekly_limit_loss&&!monthly_limit_loss;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//---
   if(ShowTradePanel)
     {
      //---
      ObjectsCreateAll();
      for(int i = 0; i < ArraySize(aSymbols); i++)
        {
         ObjectsUpdateAll(Prefix+aSymbols[i]+Suffix);
         GetSetInputs(Prefix+aSymbols[i]+Suffix);
        }
      //---
      GetSetInputsA();

      //--- MoveWindow
      if(LastReason == REASON_CHARTCHANGE)
        {
         Chart_XSize = (int)ChartGetInteger(0, CHART_WIDTH_IN_PIXELS);
         Chart_YSize = (int)ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS);
         //---
         ChartX = Chart_XSize;
         ChartY = Chart_YSize;
         //---
         LastReason = 0;
        }
      //---
      if(ChartX != Chart_XSize || ChartY != Chart_YSize)
        {
         ObjectsDeleteAll(0, OBJPREFIX, -1, -1);
         //---
         ObjectsCreateAll();
         //---
         ChartX = Chart_XSize;
         ChartY = Chart_YSize;
        }
      //---
      Chart_XSize = (int)ChartGetInteger(0, CHART_WIDTH_IN_PIXELS);
      Chart_YSize = (int)ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS);

      //--- Connected
      if(TerminalInfoInteger(TERMINAL_CONNECTED))
        {
         //---
         if(ObjectGetString(0, OBJPREFIX+"CONNECTION", OBJPROP_TEXT) != "ü")//GetObject
            ObjectSetString(0, OBJPREFIX+"CONNECTION", OBJPROP_TEXT, "ü"); //SetObject
         //---
         if(ObjectGetString(0, OBJPREFIX+"CONNECTION", OBJPROP_TOOLTIP) != "Connected")//GetObject
           {
            double Ping = TerminalInfoInteger(TERMINAL_PING_LAST); //SetPingToMs
            ObjectSetString(0, OBJPREFIX+"CONNECTION", OBJPROP_TOOLTIP, "Connected..."+"\nPing: "+DoubleToString(Ping/1000, 2)+" ms"); //SetObject
           }
        }
      //--- Disconnected
      else
        {
         //---
         if(ObjectGetString(0, OBJPREFIX+"CONNECTION", OBJPROP_TEXT) != "ñ")//GetObject
            ObjectSetString(0, OBJPREFIX+"CONNECTION", OBJPROP_TEXT, "ñ"); //SetObject
         //---
         if(ObjectGetString(0, OBJPREFIX+"CONNECTION", OBJPROP_TOOLTIP) != "No connection!")//GetObject
            ObjectSetString(0, OBJPREFIX+"CONNECTION", OBJPROP_TOOLTIP, "No connection!"); //SetObject
        }
      //--- ResetStatus
      if(stauts_time < TimeLocal()-1)
         ResetStatus();
      //---
      Comment("");
      ChartRedraw();
     }
   else
      CreateMinWindow();
//---
   Trailing_P();
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//----


//----
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//----
   if(id == CHARTEVENT_KEYDOWN)
     {

      //---
      if(KeyboardTrading)
        {


         //--- Switch Symbol (UP)
         if(lparam == KEY_UP)
           {
            //---
            int index = 0;
            //---
            for(int i = 0; i < ArraySize(aSymbols); i++)
              {
               if(_Symbol == Prefix+aSymbols[i]+Suffix)
                 {
                  //---
                  index = i-1;
                  //---
                  if(index < 0)
                     index = ArraySize(aSymbols)-1;
                  //---
                  if(SymbolFind(Prefix+aSymbols[index]+Suffix, false))
                    {
                     ChartSetSymbolPeriod(0, Prefix+aSymbols[index]+Suffix, PERIOD_CURRENT);
                     SetStatus("ÿ", "Switched to "+aSymbols[index]);
                     break;
                    }
                 }
              }
           }

         //--- Switch Symbol (DOWN)
         if(lparam == KEY_DOWN)
           {
            //---
            int index = 0;
            //---
            for(int i = 0; i < ArraySize(aSymbols); i++)
              {
               //---
               if(_Symbol == Prefix+aSymbols[i]+Suffix)
                 {
                  //---
                  index = i+1;
                  //---
                  if(index >= ArraySize(aSymbols))
                     index = 0;
                  //---
                  if(SymbolFind(Prefix+aSymbols[index]+Suffix, false))
                    {
                     ChartSetSymbolPeriod(0, Prefix+aSymbols[index]+Suffix, PERIOD_CURRENT);
                     SetStatus("ÿ", "Switched to "+aSymbols[index]);
                     break;
                    }
                 }
              }
           }
        }
     }

//--- OBJ_CLICKS
   if(id == CHARTEVENT_OBJECT_CLICK)
     {


      //---
      for(int i = 0; i < ArraySize(aSymbols); i++)
        {

         //--- SymoblSwitcher
         if(sparam == OBJPREFIX+Prefix+aSymbols[i]+Suffix)
           {
            ChartSetSymbolPeriod(0, Prefix+aSymbols[i]+Suffix, PERIOD_CURRENT);
            SetStatus("ÿ", "Switched to "+aSymbols[i]);
            break;
           }
        }

      //--- RemoveExpert
      if(sparam == OBJPREFIX+"EXIT")
        {
         //---
         if(MessageBox("Are you sure you want to exit?", MB_CAPTION, MB_ICONQUESTION|MB_YESNO) == IDYES)
            ExpertRemove(); //Exit
        }

      //--- Minimize
      if(sparam == OBJPREFIX+"MINIMIZE")
        {
         ObjectsDeleteAll(0, OBJPREFIX, -1, -1);
         CreateMinWindow();
         ShowTradePanel = false;
         ChartMouseScrollSet(true);
         ChartSetColor(2);
         ClearedTemplate = false;
        }

      //--- Maximize
      if(sparam == OBJPREFIX+"MIN"+"MAXIMIZE")
        {
         DelteMinWindow();
         ObjectsCreateAll();
         ShowTradePanel = true;
         ChartMouseScrollSet(false);
        }

      //--- Ping
      if(sparam == OBJPREFIX+"CONNECTION")
        {
         //---
         double Ping = TerminalInfoInteger(TERMINAL_PING_LAST); //SetPingToMs
         //---
         if(TerminalInfoInteger(TERMINAL_CONNECTED))
            SetStatus("\n", "Ping: "+DoubleToString(Ping/1000, 2)+" ms");
         else
            SetStatus("ý", "No Internet connection...");
        }


      //--- SwitchTheme
      if(sparam == OBJPREFIX+"THEME")
        {
         //---
         if(SelectedTheme == 0)
           {
            ObjectsDeleteAll(0, OBJPREFIX, -1, -1);
            COLOR_BG = C'28,28,28';
            COLOR_FONT = clrSilver;
            COLOR_GREEN = clrLimeGreen;
            COLOR_RED = clrRed;
            COLOR_LOW = clrYellow;
            COLOR_MARKER = clrGold;
            ObjectsCreateAll();
            SelectedTheme = 1;
            //---
            SetStatus("ÿ", "Dark theme selected...");
            Sleep(250);
            ResetStatus();
           }
         else
           {
            ObjectsDeleteAll(0, OBJPREFIX, -1, -1);
            COLOR_BG = C'240,240,240';
            COLOR_FONT = C'40,41,59';
            COLOR_GREEN = clrForestGreen;
            COLOR_RED = clrIndianRed;
            COLOR_LOW = clrGoldenrod;
            COLOR_MARKER = clrDarkOrange;
            ObjectsCreateAll();
            SelectedTheme = 0;
            //---
            SetStatus("ÿ", "Light theme selected...");
            Sleep(250);
            ResetStatus();
           }
        }

      //--- SwitchTheme
      if(sparam == OBJPREFIX+"TEMPLATE")
        {
         //---
         if(!ClearedTemplate)
           {
            //---
            if(SelectedTheme == 0)
              {
               ChartSetColor(0);
               ClearedTemplate = true;
               SetStatus("ÿ", "Chart color cleared...");
              }
            else
              {
               ChartSetColor(1);
               ClearedTemplate = true;
               SetStatus("ÿ", "Chart color cleared...");
              }
           }
         else
           {
            ChartSetColor(2);
            ClearedTemplate = false;
            SetStatus("ÿ", "Original chart color applied...");
           }
        }

      //--- GetParameters
      GetParam(sparam);

      //--- SoundManagement
      if(sparam == OBJPREFIX+"SOUND" || sparam == OBJPREFIX+"SOUNDIO")
        {
         //--- EnableSound
         if(!SoundIsEnabled)
           {
            SoundIsEnabled = true;
            ObjectSetInteger(0, OBJPREFIX+"SOUNDIO", OBJPROP_COLOR, C'59, 41, 40'); //SetObject
            SetStatus("þ", "Sounds enabled...");
            PlaySound("sound.wav");
           }
         //--- DisableSound
         else
           {
            SoundIsEnabled = false;
            ObjectSetInteger(0, OBJPREFIX+"SOUNDIO", OBJPROP_COLOR, clrNONE); //SetObject
            SetStatus("ý", "Sounds disabled...");
           }
        }
      //--- AlarmManagement
      if(sparam == OBJPREFIX+"ALARM" || sparam == OBJPREFIX+"ALARMIO")
        {
         //--- EnableSound
         if(!AlarmIsEnabled)
           {
            //---
            AlarmIsEnabled = true;
            //---
            ObjectSetInteger(0, OBJPREFIX+"ALARMIO", OBJPROP_COLOR, clrNONE);
            //---
            string message = "\n";

            //---
            Alert("Alerts enabled "+message);
            SetStatus("þ", "Alerts enabled...");
           }
         //--- DisableSound
         else
           {
            //---
            AlarmIsEnabled = false;
            ObjectSetInteger(0, OBJPREFIX+"ALARMIO", OBJPROP_COLOR, C'59, 41, 40');
            //---
            SetStatus("ý", "Alerts disabled...");
           }
        }

      //--- Balance
      if(sparam == OBJPREFIX+"BALANCE«")
        {
         //---
         string text = "";
         //---
         if(_AccountCurrency() == "$" || _AccountCurrency() == "£")
            text = _AccountCurrency()+DoubleToString(AccountInfoDouble(ACCOUNT_EQUITY), 2);
         else
            text = DoubleToString(AccountInfoDouble(ACCOUNT_EQUITY), 2)+_AccountCurrency();
         //---
         SetStatus("", "Equity: "+text);
        }



      //--- Switch PriceRow Left
      if(sparam == OBJPREFIX+"PRICEROW_Lª")
        {
         //---
         PriceRowLeft++;
         //---
         if(PriceRowLeft >= ArraySize(PriceRowLeftArr))//Reset
            PriceRowLeft = 0;
         //---
         ObjectSetString(0, OBJPREFIX+"PRICEROW_Lª", OBJPROP_TEXT, 0, PriceRowLeftArr[PriceRowLeft]); /*SetObject*/
         //---
         SetStatus("É", "Switched to "+PriceRowLeftArr[PriceRowLeft]+" mode...");
         //---
         for(int i = 0; i < ArraySize(aSymbols); i++)
            ObjectSetString(0, OBJPREFIX+"PRICEROW_L"+" - "+aSymbols[i], OBJPROP_TOOLTIP, PriceRowLeftArr[PriceRowLeft]+" "+aSymbols[i]);
        }

      //--- Switch PriceRow Right
      if(sparam == OBJPREFIX+"PRICEROW_Rª")
        {
         //---
         PriceRowRight++;
         //---
         if(PriceRowRight >= ArraySize(PriceRowRightArr))//Reset
            PriceRowRight = 0;
         //---
         ObjectSetString(0, OBJPREFIX+"PRICEROW_Rª", OBJPROP_TEXT, 0, PriceRowRightArr[PriceRowRight]); /*SetObject*/
         //---
         SetStatus("Ê", "Switched to "+PriceRowRightArr[PriceRowRight]+" mode...");
         //---
         for(int i = 0; i < ArraySize(aSymbols); i++)
            ObjectSetString(0, OBJPREFIX+"PRICEROW_R"+" - "+aSymbols[i], OBJPROP_TOOLTIP, PriceRowRightArr[PriceRowRight]+" "+aSymbols[i]);
        }
      if(sparam == OBJPREFIX+"PRICEROW_Rª")
        {
         //---
         PriceRowRight++;
         //---
         if(PriceRowRight >= ArraySize(PriceRowRightArr))//Reset
            PriceRowRight = 0;
         //---
         ObjectSetString(0, OBJPREFIX+"PRICEROW_Rª", OBJPROP_TEXT, 0, PriceRowRightArr[PriceRowRight]); /*SetObject*/
         //---
         SetStatus("Ê", "Switched to "+PriceRowRightArr[PriceRowRight]+" mode...");
         //---
         for(int i = 0; i < ArraySize(aSymbols); i++)
            ObjectSetString(0, OBJPREFIX+"PRICEROW_R"+" - "+aSymbols[i], OBJPROP_TOOLTIP, PriceRowRightArr[PriceRowRight]+" "+aSymbols[i]);
        }


     }

//----
  }
//+------------------------------------------------------------------+
//| _OnTester                                                        |
//+------------------------------------------------------------------+
void _OnTester()
  {
//---

//---
  }
//+------------------------------------------------------------------+
//| Balance                                                          |
//+------------------------------------------------------------------+
string Balance()
  {
//---
   string text = "";
//---
   if(_AccountCurrency() == "$" || _AccountCurrency() == "£")
      text = _AccountCurrency()+DoubleToString(AccountInfoDouble(ACCOUNT_BALANCE), 2);
   else
      text = DoubleToString(AccountInfoDouble(ACCOUNT_BALANCE), 2)+_AccountCurrency();
//---
   string result = "Balance: "+text;
//---

//---
   return(result);
  }
//+------------------------------------------------------------------+
//| ObjectsCreateAll                                                 |
//+------------------------------------------------------------------+
void ObjectsCreateAll()
  {
//---
   int fr_y2 = Dpi(50);
//---
   for(int i = 0; i < ArraySize(aSymbols); i++)
     {
      //---
      if(SelectedMode == FULL)
         fr_y2 += Dpi(25);
      //---
      if(SelectedMode == COMPACT)
         fr_y2 += Dpi(21);
      //---
      if(SelectedMode == MINI)
         fr_y2 += Dpi(17);
     }
//---
   int x = Dpi(10);
   int y = Dpi(20);
//---
   int height = fr_y2+Dpi(3);
//---
   RectLabelCreate(0, OBJPREFIX+"BCKGRND[]", 0, x, y, Dpi(CLIENT_BG_WIDTH), height, COLOR_BG, BORDER_FLAT, CORNER_LEFT_UPPER, COLOR_BORDER, STYLE_SOLID, 1, false, false, true, 0, "\n");
//---
   _x1 = (int)ObjectGetInteger(0, OBJPREFIX+"BCKGRND[]", OBJPROP_XDISTANCE);
   _y1 = (int)ObjectGetInteger(0, OBJPREFIX+"BCKGRND[]", OBJPROP_YDISTANCE);
//---
   RectLabelCreate(0, OBJPREFIX+"BORDER[]", 0, x, y, Dpi(CLIENT_BG_WIDTH), Dpi(INDENT_TOP), COLOR_BORDER, BORDER_FLAT, CORNER_LEFT_UPPER, COLOR_BORDER, STYLE_SOLID, 1, false, false, true, 0, "\n");
//---
   LabelCreate(0, OBJPREFIX+"CAPTION", 0, _x1+(Dpi(CLIENT_BG_WIDTH)/2)-Dpi(16), _y1, CORNER_LEFT_UPPER, ExpertName, "Arial Black", 9, C'59, 41, 40', 0, ANCHOR_UPPER, false, false, true, 0, "\n");
//---
   LabelCreate(0, OBJPREFIX+"EXIT", 0, (_x1+Dpi(CLIENT_BG_WIDTH))-Dpi(10), _y1-Dpi(2), CORNER_LEFT_UPPER, "r", "Webdings", 10, C'59, 41, 40', 0, ANCHOR_UPPER, false, false, true, 1, "\n", false);
//---
   LabelCreate(0, OBJPREFIX+"MINIMIZE", 0, (_x1+Dpi(CLIENT_BG_WIDTH))-Dpi(30), _y1-Dpi(2), CORNER_LEFT_UPPER, "2", "Webdings", 10, C'59, 41, 40', 0, ANCHOR_UPPER, false, false, true, 1, "\n", false);
//---
   LabelCreate(0, OBJPREFIX+" ", 0, (_x1+Dpi(CLIENT_BG_WIDTH))-Dpi(50), _y1-Dpi(2), CORNER_LEFT_UPPER, "s", "Webdings", 10, C'59, 41, 40', 0, ANCHOR_UPPER, false, false, true, 1, "\n", false);
//---
   LabelCreate(0, OBJPREFIX+"TIME", 0, (_x1+Dpi(CLIENT_BG_WIDTH))-Dpi(85), _y1+Dpi(1), CORNER_LEFT_UPPER, TimeToString(TimeLocal(), TIME_SECONDS), "Tahoma", 8, C'59, 41, 40', 0, ANCHOR_UPPER, false, false, true, 1, "Local Time", false);
   LabelCreate(0, OBJPREFIX+"TIME§", 0, (_x1+Dpi(CLIENT_BG_WIDTH))-Dpi(120), _y1, CORNER_LEFT_UPPER, "Â", "Wingdings", 12, C'59, 41, 40', 0, ANCHOR_UPPER, false, false, true, 1, "Local Time", false);
//---
   LabelCreate(0, OBJPREFIX+"CONNECTION", 0, _x1+Dpi(15), _y1-Dpi(2), CORNER_LEFT_UPPER, "ü", "Webdings", 10, C'59, 41, 40', 0, ANCHOR_UPPER, false, false, true, 0, "Connection", false);
//---
   LabelCreate(0, OBJPREFIX+"THEME", 0, _x1+Dpi(40), _y1-Dpi(4), CORNER_LEFT_UPPER, "N", "Webdings", 15, C'59, 41, 40', 0, ANCHOR_UPPER, false, false, true, 1, "Theme", false);
//---
   LabelCreate(0, OBJPREFIX+"TEMPLATE", 0, _x1+Dpi(65), _y1-Dpi(2), CORNER_LEFT_UPPER, "+", "Webdings", 12, C'59, 41, 40', 0, ANCHOR_UPPER, false, false, true, 1, "Background", false);
//---
   int middle = Dpi(CLIENT_BG_WIDTH/2);
//---
   LabelCreate(0, OBJPREFIX+"STATUS", 0, _x1+middle+(middle/2), _y1+Dpi(8), CORNER_LEFT_UPPER, "\n", "Wingdings", 10, C'59, 41, 40', 0, ANCHOR_LEFT, false, false, true, 1, "\n", false);
//---
   LabelCreate(0, OBJPREFIX+"STATUS«", 0, _x1+middle+(middle/2)+Dpi(15), _y1+Dpi(8), CORNER_LEFT_UPPER, "\n", sFontType, 8, C'59, 41, 40', 0, ANCHOR_LEFT, false, false, true, 1, "\n", false);
//---
   LabelCreate(0, OBJPREFIX+"SOUND", 0, _x1+Dpi(90), _y1-Dpi(2), CORNER_LEFT_UPPER, "X", "Webdings", 12, C'59, 41, 40', 0, ANCHOR_UPPER, false, false, true, 1, "Sounds", false);
//---
   color soundclr = SoundIsEnabled?C'59,41,40': clrNONE;
//---
   LabelCreate(0, OBJPREFIX+"SOUNDIO", 0, _x1+Dpi(100), _y1-Dpi(1), CORNER_LEFT_UPPER, "ð", "Webdings", 10, soundclr, 0, ANCHOR_UPPER, false, false, true, 1, "Sounds", false);
//---
   LabelCreate(0, OBJPREFIX+"ALARM", 0, _x1+Dpi(115), _y1-Dpi(1), CORNER_LEFT_UPPER, "%", "Wingdings", 12, C'59, 41, 40', 0, ANCHOR_UPPER, false, false, true, 1, "Alerts", false);
//---
   color alarmclr = AlarmIsEnabled?clrNONE: C'59,41,40';
//---

//---
   LabelCreate(0, OBJPREFIX+"ALARMIO", 0, _x1+Dpi(115), _y1-Dpi(6), CORNER_LEFT_UPPER, "x", sFontType, 16, alarmclr, 0, ANCHOR_UPPER, false, false, true, 1, "Alerts", false);
//---
   int csm_fr_x1 = _x1+Dpi(50);
   int csm_fr_x2 = _x1+Dpi(95);
   int csm_fr_x3 = _x1+Dpi(137);
   int csm_dist_b = Dpi(150);
//---

   LabelCreate(0, OBJPREFIX+"BALANCE«", 0, _x1+Dpi(300), _y1+Dpi(8), CORNER_LEFT_UPPER, Balance(), sFontType, 8, C'59, 41, 40', 0, ANCHOR_CENTER, false, false, true, 0, "Balance is :"+Balance());
   LabelCreate(0, OBJPREFIX+"Pairs", 0, _x1+Dpi(10), _y1+Dpi(30), CORNER_LEFT_UPPER, "Pairs", "Arial Black", 12, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
   int xxx=100;
   if(useSingleMA&&ShowSingleMA)
     {
      LabelCreate(0, OBJPREFIX+"1MA", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "1 MA", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
      xxx+=50;
     }
   if(useDoubleMA&&showDoubleMa)
     {
      LabelCreate(0, OBJPREFIX+"2MA", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "2 MA", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
      xxx+=50;
     }
   if(useSto&&showSto)
     {
      LabelCreate(0, OBJPREFIX+"sto", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "STO", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
      xxx+=50;
     }
   if(useMacd&&showMacd)
     {
      LabelCreate(0, OBJPREFIX+"macd", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "MACD", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
      xxx+=50;
     }
   if(useAdx&&showAdx)
     {
      LabelCreate(0, OBJPREFIX+"adx", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "ADX", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
      xxx+=50;
     }
   if(useAtr&&showAtr)
     {
      LabelCreate(0, OBJPREFIX+"atr", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "ATR", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
      xxx+=50;
     }
   if(useRSI&&showRsi)
     {
      LabelCreate(0, OBJPREFIX+"rsi", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "RSI", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
      xxx+=50;
     }
   if(useBB&&ShowBB)
     {
      LabelCreate(0, OBJPREFIX+"bb", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "BB", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
      xxx+=50;
     }
   if(useIchi&&showIchi)
     {
      LabelCreate(0, OBJPREFIX+"ichi", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "ICHI", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
      xxx+=50;
     }
   if(useSuperTrend&&showSupertrend)
     {
      LabelCreate(0, OBJPREFIX+"str", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "STR", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
      xxx+=50;
     }
   if(useSAR&&ShowSar)
     {
      LabelCreate(0, OBJPREFIX+"sar", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "SAR", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
      xxx+=50;
     }

   if(use_CMS_Filters)
     {
      if(showBase)
        {
         LabelCreate(0, OBJPREFIX+"base", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "Base", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
         xxx+=50;
        }
      if(showQuote)
        {
         LabelCreate(0, OBJPREFIX+"quote", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "Quote", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
         xxx+=50;
        }
      if(showCSM)
        {
         LabelCreate(0, OBJPREFIX+"CMS-pair", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "CSM Pairs", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
         xxx+=100;
        }
     }
   if(showAvg)
     {
      LabelCreate(0, OBJPREFIX+"avg", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "AVG", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
      xxx+=50;
     }
   if(ShowTradeable)
     {
      LabelCreate(0, OBJPREFIX+"trade-pair", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "Tradable("+(string)tradableNum+")", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
      xxx+=100;
     }
   if(showClosable)
     {
      LabelCreate(0, OBJPREFIX+"close-pair", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "Closable("+(string)ClosableNum+")", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
      xxx+=100;
     }
   if(ShowSL)
     {
      LabelCreate(0, OBJPREFIX+"sl", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "SL", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
      xxx+=60;
     }

   if(ShowTp)
     {
      LabelCreate(0, OBJPREFIX+"tp", 0, _x1+Dpi(xxx), _y1+Dpi(30), CORNER_LEFT_UPPER, "TP", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
      xxx+=60;
     }
//--- SymbolsGUI
   int fr_y = _y1+Dpi(60);
   tradableNum=0;
   ClosableNum=0;
//---
   for(int i = 0; i < ArraySize(aSymbols); i++)
     {
      //---
      CreateSymbGUI(i, fr_y);
      //---
      if(SelectedMode == FULL)
         fr_y += Dpi(25);
      //---
      if(SelectedMode == COMPACT)
         fr_y += Dpi(21);
      //---
      if(SelectedMode == MINI)
         fr_y += Dpi(17);
     }

  }
//+------------------------------------------------------------------+
//| CreateSymbGUI                                                    |
//+------------------------------------------------------------------+
void CreateSymbGUI(int i, int Y)
  {
//---
   string _Symb = Prefix+aSymbols[i]+Suffix;
   string Base =StringSubstr(aSymbols[i],0,3);
   string Quote = StringSubstr(aSymbols[i],3,3);
   color startcolor = FirstRun?clrNONE: COLOR_FONT;
   double countb = 0,
          counts = 0,
          countf = 0;
   int xx=10;
//---
   LabelCreate(0, OBJPREFIX+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, StringSubstr(_Symb, StringLen(Prefix), 6)+":", sFontType, FONTSIZE, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, _Symb);
   xx+=115;
//---
//--
   if(useSingleMA)
     {
      if(sig_SingleMA(i) == 1)
        {
         if(useSingleMA)
            countb++;
         if(ShowSingleMA)
           {
            ObjectDelete(0, OBJPREFIX+"1MA"+" - "+_Symb);
            LabelCreate(0, OBJPREFIX+"1MA"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);
            xx+=50;
           }
        }
      else
         if(sig_SingleMA(i) == -1)
           {
            if(useSingleMA)
               counts++;
            if(ShowSingleMA)
              {
               ObjectDelete(0, OBJPREFIX+"1MA"+" - "+_Symb);
               LabelCreate(0, OBJPREFIX+"1MA"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);
               xx+=50;
              }
           }
         else
           {
            if(useSingleMA)
               countf++;
            if(ShowSingleMA)
              {
               ObjectDelete(0, OBJPREFIX+"1MA"+" - "+_Symb);

               LabelCreate(0, OBJPREFIX+"1MA"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);
               xx+=50;
              }
           }
     }
//--
   if(useDoubleMA)
     {
      if(sig_DoubleMA(i) == 1)
        {
         if(useDoubleMA)
            countb++;
         if(ShowSingleMA)
           {
            ObjectDelete(0, OBJPREFIX+"2MA"+" - "+_Symb);
            LabelCreate(0, OBJPREFIX+"2MA"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);
            xx+=50;
           }
        }
      else
         if(sig_DoubleMA(i) == -1)
           {
            if(useDoubleMA)
               counts++;
            if(showDoubleMa)
              {
               ObjectDelete(0, OBJPREFIX+"2MA"+" - "+_Symb);
               LabelCreate(0, OBJPREFIX+"2MA"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);
               xx+=50;
              }
           }
         else
           {
            if(useDoubleMA)
               countf++;
            if(showDoubleMa)
              {
               ObjectDelete(0, OBJPREFIX+"2MA"+" - "+_Symb);
               LabelCreate(0, OBJPREFIX+"2MA"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);
               xx+=50;
              }
           }
     }

//--
   if(useSto)
     {
      if(sig_STO(i) == 1)
        {
         if(useSto)
            countb++;
         if(showSto)
            LabelCreate(0, OBJPREFIX+"sto"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

        }
      else
         if(sig_STO(i) == -1)
           {
            if(useSto)
               counts++;
            if(showSto)
               LabelCreate(0, OBJPREFIX+"sto"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

           }
         else
           {
            if(useSto)
               countf++;
            if(showSto)
               LabelCreate(0, OBJPREFIX+"sto"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);

           }
      if(showSto)
         xx+=50;
     }

//--
   if(useMacd)
     {
      if(sig_MACD(i) == 1)
        {
         if(useMacd)
            countb++;
         if(showMacd)
            LabelCreate(0, OBJPREFIX+"macd"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

        }

      else
         if(sig_MACD(i) == -1)
           {
            if(useMacd)
               counts++;
            if(showMacd)
               LabelCreate(0, OBJPREFIX+"macd"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

           }
         else
           {
            if(useMacd)
               countf++;
            if(showMacd)
               LabelCreate(0, OBJPREFIX+"macd"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);

           }
      if(showMacd)
         xx+=50;
     }
//--
   if(useAdx)
     {
      if(sig_ADX(i) == 1)
        {
         if(useAdx)
            countb++;
         if(showAdx)
            LabelCreate(0, OBJPREFIX+"adx"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

        }
      else
         if(sig_ADX(i) == -1)
           {
            if(useAdx)
               counts++;
            if(showAdx)
               LabelCreate(0, OBJPREFIX+"adx"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

           }
         else
           {
            if(useAdx)
               countf++;
            if(showAdx)
               LabelCreate(0, OBJPREFIX+"adx"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);

           }
      if(showAdx)
         xx+=50;
     }

//--
   if(useAtr)
     {
      if(sig_ATR(i) == 1)
        {
         if(useAtr)
            countb++;
         if(showAtr)
            LabelCreate(0, OBJPREFIX+"atr"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

        }
      else
         if(sig_ATR(i) == -1)
           {
            if(useAtr)
               counts++;
            if(showAtr)
               LabelCreate(0, OBJPREFIX+"atr"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

           }
         else
           {
            if(useAtr)
               countf++;
            if(showAtr)
               LabelCreate(0, OBJPREFIX+"atr"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);

           }
      if(showAtr)
         xx+=50;
     }

//--
   if(useRSI)
     {
      if(sig_RSI(i) == 1)
        {
         if(useRSI)
            countb++;
         if(showRsi)
            LabelCreate(0, OBJPREFIX+"rsi"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Rsi Buy "+_Symb);

        }
      else
         if(sig_RSI(i) == -1)
           {
            if(useRSI)
               counts++;
            if(showRsi)
               LabelCreate(0, OBJPREFIX+"rsi"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

           }
         else
           {
            if(useRSI)
               countf++;
            if(showRsi)
               LabelCreate(0, OBJPREFIX+"rsi"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);
           }
      if(showRsi)
         xx+=50;
     }

//--
   if(useBB)
     {
      if(sig_BB(i) == 1)
        {
         if(useBB)
            countb++;
         if(ShowBB)
            LabelCreate(0, OBJPREFIX+"bb"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

        }
      else
         if(sig_BB(i) == -1)
           {
            if(useBB)
               counts++;
            if(ShowBB)
               LabelCreate(0, OBJPREFIX+"bb"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

           }
         else
           {
            if(useBB)
               countf++;
            if(ShowBB)
               LabelCreate(0, OBJPREFIX+"bb"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);

           }
      if(ShowBB)
         xx+=50;
     }
//--
   if(useIchi)
     {
      if(sig_ICHI(i) == 1)
        {
         if(useIchi)
            countb++;
         if(showIchi)
            LabelCreate(0, OBJPREFIX+"ichi"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

        }
      else
         if(sig_ICHI(i) == -1)
           {
            if(useIchi)
               counts++;
            if(showIchi)
               LabelCreate(0, OBJPREFIX+"ichi"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

           }
         else
           {
            if(useIchi)
               countf++;
            if(showIchi)
               LabelCreate(0, OBJPREFIX+"ichi"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);

           }
      if(showIchi)
         xx+=50;
     }
//--
   if(useSuperTrend)
     {
      if(sig_Supertrend(i) == 1)
        {
         if(useSuperTrend)
            countb++;
         if(showIchi)
            LabelCreate(0, OBJPREFIX+"str"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

        }
      else
         if(sig_Supertrend(i) == -1)
           {
            if(useSuperTrend)
               counts++;
            if(showIchi)
               LabelCreate(0, OBJPREFIX+"str"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

           }
         else
           {
            if(useSuperTrend)
               countf++;
            if(showIchi)
               LabelCreate(0, OBJPREFIX+"str"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);
           }
      if(showIchi)
         xx+=50;
     }
//--
   if(useSAR)
     {
      if(sig_SAR(i) == 1)
        {
         if(useSAR)
            countb++;
         if(ShowSar)
            LabelCreate(0, OBJPREFIX+"sar"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

        }
      else
         if(sig_SAR(i) == -1)
           {
            if(useSAR)
               counts++;
            if(ShowSar)
               LabelCreate(0, OBJPREFIX+"sar"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

           }
         else
           {
            if(useSAR)
               countf++;
            if(ShowSar)
               LabelCreate(0, OBJPREFIX+"sar"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);
           }
      if(ShowSar)
         xx+=50;

     }
   xx+=10;
   bool close = false;
   bool CSMBuy=false;
   bool CSMSell=false;
   bool nonFX=false;

   bool Aclose=false;
   bool  CcloseBuy=false;
   bool CcloseSell=false;
   if(use_CMS_Filters)
     {
      int siz=ArraySize(g_symbols);
      double b1=0,q1=0,b2=0,q2=0,b3=0,q3=0;
      bool b_found=false,q_found=false;
      for(int z=0; z<siz; z++)
        {
         color c=currenciesStrength[z]>=60?clrLimeGreen:currenciesStrength[z]<=40?clrRed:clrYellow;
         if(g_symbols[z]==Base)
           {
            if(showBase)
              {
               LabelCreate(0, OBJPREFIX+"base"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER,DoubleToString(currenciesStrength[z],2), sFontType, 9, c, 0, ANCHOR_RIGHT, false, false, true, 0, "\n");
              }
            b_found=true;
            b1=currenciesStrength[z];
            if(CSMType==increase_Decrease)
              {
               b2=currenciesStrength1[z];
               b3=currenciesStrength2[z];
              }
           }
        }
      for(int z=0; z<siz; z++)
        {
         color c=currenciesStrength[z]>=60?clrLimeGreen:currenciesStrength[z]<=40?clrRed:clrYellow;
         if(g_symbols[z]==Quote)
           {
            if(showQuote)
              {
               if(showBase)
                  xx+=50;
               LabelCreate(0, OBJPREFIX+"quote"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER,DoubleToString(currenciesStrength[z],2), sFontType, 9, c, 0, ANCHOR_RIGHT, false, false, true, 0, "\n");

              }
            q_found=true;
            q1=currenciesStrength[z];
            if(CSMType==increase_Decrease)
              {
               q2=currenciesStrength1[z];
               q3=currenciesStrength2[z];
              }
           }

        }
      if(showCSM)
         xx+=10;
      if(!b_found||!q_found)
        {
         nonFX=true;
         if(!b_found)
            xx+=50;
         if(!q_found)
            xx+=10;
         xx+=140;

        }
      else
         if((b1>=num1&&q1<=num2)||(CSMType==increase_Decrease&&((b1>=b2&&b2>=b3&&q1<=num2)||(q1<=q2&&q2<=q3&&b1>=num1))))
           {
            if(showCSM)
              {
               ButtonCreate(0, OBJPREFIX+"CMS"+" - "+_Symb, 0, _x1+Dpi(xx), Y-Dpi(6), Dpi(77), Dpi(15), CORNER_LEFT_UPPER, _Symb, sFontType, 8, C'59, 41, 40', clrLimeGreen, C'144, 176, 239', false, false, false, true, 1, "Buy "+_Symb);
               xx+=140;
              }
            CSMBuy=true;
           }
         else
            if((q1>=num1&&b1<=num2)||(CSMType==increase_Decrease&&((q1>=q2&&q2>=q3&&b1<=num2)||(b1<=b2&&b2<=b3&&q1>=num1))))
              {
               if(showCSM)
                 {
                  ButtonCreate(0, OBJPREFIX+"CMS"+" - "+_Symb, 0, _x1+Dpi(xx), Y-Dpi(6), Dpi(77), Dpi(15), CORNER_LEFT_UPPER, _Symb, sFontType, 8, C'59, 41, 40', clrRed, C'144, 176, 239', false, false, false, true, 1, "Buy "+_Symb);
                  xx+=140;
                 }
               CSMSell=true;
              }
            else
              {
               ObjectDelete(0,OBJPREFIX+"CMS"+" - "+_Symb);
               if(showCSM)
                  xx+=140;
               if(closewithCSM&&Positions[i].GroupTotal()>0)
                 {

                  if(b1<=Cnum1&&q1>=Cnum2)
                    {
                     if(CloseFilter==CSM_only)
                       {
                        BuyPositions[i].GroupCloseAll(30);
                        close=true;
                       }
                     if(CloseFilter==Both)
                       {
                        CcloseBuy=true;
                       }

                    }
                  if(q1<=Cnum1&&b1>=Cnum2)
                    {
                     if(CloseFilter==CSM_only)
                       {
                        SellPositions[i].GroupCloseAll(30);
                        close=true;
                       }
                     if(CloseFilter==Both)
                       {
                        CcloseSell=true;
                       }
                    }

                 }
              }

     }

   double perc_b = (countb/(countb+countf+counts))*100;
   double perc_s = (counts/(countb+countf+counts))*100;
//--
   if(showAvg)
     {
      if(perc_b > perc_s)
        {
         LabelCreate(0, OBJPREFIX+"avg"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, DoubleToString(perc_b, 2)+"%", sFontType, 9, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, _Symb+" avg : "+DoubleToString(perc_b, 2)+"%");
         xx+=10;
        }
      else
         if(perc_b < perc_s)
           {
            LabelCreate(0, OBJPREFIX+"avg"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, DoubleToString(perc_s, 2)+"%", sFontType, 9, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, _Symb+" avg : "+DoubleToString(perc_s, 2)+"%");
            xx+=10;
           }
         else
           {
            LabelCreate(0, OBJPREFIX+"avg"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, "______", sFontType, 9, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "\n");
            xx+=10;
           }
     }

   bool buy = false;
   bool sell = false;


   if(perc_b >= avg_to_Trada)
     {
      buy = true;
      if(ShowTradeable)
        {
         ButtonCreate(0, OBJPREFIX+"trade"+" - "+_Symb, 0, _x1+Dpi(xx), Y-Dpi(6), Dpi(77), Dpi(15), CORNER_LEFT_UPPER, _Symb, sFontType, 8, C'59, 41, 40', clrLimeGreen, C'144, 176, 239', false, false, false, true, 1, "Buy "+_Symb);
         xx+=100;
         tradableNum++;
        }
      if(showClosable)
        {
         xx+=130;
        }
      ObjectDelete(0, OBJPREFIX+"close"+" - "+_Symb);
     }
   else
      if(perc_s >= avg_to_Trada)
        {
         sell = true;
         if(ShowTradeable)
           {
            ButtonCreate(0, OBJPREFIX+"trade"+" - "+_Symb, 0, _x1+Dpi(xx), Y-Dpi(6), Dpi(77), Dpi(15), CORNER_LEFT_UPPER, _Symb, sFontType, 10, C'59, 41, 40', clrRed, C'239, 112, 112', false, false, false, true, 1, "Sell "+_Symb);
            xx+=100;
            tradableNum++;
           }
         if(showClosable)
           {
            xx+=130;
           }
         ObjectDelete(0, OBJPREFIX+"close"+" - "+_Symb);

        }
      else
         if(perc_b > perc_s && perc_b < level_To_Close)
           {
            if(closeWithPercentage)
              {
               if(CloseFilter==Indicators_only)
                 {
                  Positions[i].GroupCloseAll(30);
                  close = true;
                 }
               if(CloseFilter==Both)
                 {
                  Aclose=true;
                 }
              }
            ObjectDelete(0, OBJPREFIX+"trade"+" - "+_Symb);
            if(ShowTradeable)
               xx+=100;
            if(showClosable)
              {
               ButtonCreate(0, OBJPREFIX+"close"+" - "+_Symb, 0, _x1+Dpi(xx), Y-Dpi(6), Dpi(77), Dpi(15), CORNER_LEFT_UPPER, _Symb, sFontType, 8, C'59, 41, 40', clrRed, C'144, 176, 239', false, false, false, true, 1, "Buy "+_Symb);
               xx+=130;
               ClosableNum++;
              }
           }
         else
            if(perc_b < perc_s && perc_s < level_To_Close)
              {

               if(closeWithPercentage)
                 {
                  if(CloseFilter==Indicators_only)
                    {
                     Positions[i].GroupCloseAll(30);
                     close = true;
                    }
                  if(CloseFilter==Both)
                    {
                     Aclose=true;
                    }
                 }
               ObjectDelete(0, OBJPREFIX+"trade"+" - "+_Symb);
               if(ShowTradeable)
                  xx+=100;
               if(showClosable)
                 {
                  ButtonCreate(0, OBJPREFIX+"close"+" - "+_Symb, 0, _x1+Dpi(xx), Y-Dpi(6), Dpi(77), Dpi(15), CORNER_LEFT_UPPER, _Symb, sFontType, 8, C'59, 41, 40', clrRed, C'144, 176, 239', false, false, false, true, 1, "Buy "+_Symb);
                  xx+=130;
                  ClosableNum++;
                 }
              }
            else
              {
               ObjectDelete(0, OBJPREFIX+"trade"+" - "+_Symb);
               ObjectDelete(0, OBJPREFIX+"close"+" - "+_Symb);
               if(ShowTradeable)
                  xx+=100;
               if(showClosable)
                 {
                  xx+=130;
                 }
              }

   if(CloseFilter==Both)
     {
      if(CcloseBuy&&Aclose)
        {
         close=true;
         BuyPositions[i].GroupCloseAll(30);
        }
      if(CcloseSell&&Aclose)
        {
         close=true;
         SellPositions[i].GroupCloseAll(30);
        }
     }

   PartialClosing(BuyPositions[i],SellPositions[i],tools[i],buyPartial[i],sellPartial[i]);
   bool T_Allow=true;
   int siz=ArraySize(g_symbols);
   for(int ss=0; ss<siz; ss++)
     {
      if(g_symbols[ss]==Base||g_symbols[ss]==Quote)
        {

         if(g_symbols[ss]=="EUR")
           {
            if(D_Max_N[ss]>=Max_Negative_trade_EUR&&Use_Max_Negative_trade_EUR)
              {
               T_Allow=false;
               Comment("Max -ve Trades for EUR Reached for today");
              }
            if(D_Max_P[ss]>=Max_Positive_trade_EUR&&Use_Max_Positive_trade_EUR)
              {
               T_Allow=false;
               Comment("Max +ve Trades for EUR Reached for today");

              }
            if(W_Max_N[ss]>=weekly_Max_Negative_trade_EUR&&Use_weekly_Max_Negative_trade_EUR)
              {
               T_Allow=false;
               Comment("Max -ve Trades for EUR Reached for week");

              }
            if(W_Max_P[ss]>=weekly_Max_Positive_trade_EUR&&Use_weekly_Max_Positive_trade_EUR)
              {
               T_Allow=false;
               Comment("Max +ve Trades for EUR Reached for week");

              }

           }
         if(g_symbols[ss]=="USD")
           {
            if(D_Max_N[ss]>=Max_Negative_trade_USD&&Use_Max_Negative_trade_USD)
              {
               T_Allow=false;
               Comment("Max -ve Trades for USD Reached for today");

              }
            if(D_Max_P[ss]>=Max_Positive_trade_USD&&Use_Max_Positive_trade_USD)
              {
               T_Allow=false;
               Comment("Max +ve Trades for USD Reached for today");
              }
            if(W_Max_N[ss]>=weekly_Max_Negative_trade_USD&&Use_weekly_Max_Negative_trade_USD)
              {
               T_Allow=false;
               Comment("Max -ve Trades for USD Reached for week");
              }
            if(W_Max_P[ss]>=weekly_Max_Positive_trade_USD&&Use_weekly_Max_Positive_trade_USD)
              {
               T_Allow=false;
               Comment("Max +ve Trades for USD Reached for week");
              }
           }
         if(g_symbols[ss]=="AUD")
           {
            if(D_Max_N[ss]>=Max_Negative_trade_AUD&&Use_Max_negative_trade_AUD)
              {
               T_Allow=false;
               Comment("Max -ve Trades for AUD Reached for Today");
              }
            if(D_Max_P[ss]>=Max_Positive_trade_AUD&&Use_Max_Positive_trade_AUD)
              {
               T_Allow=false;
               Comment("Max +ve Trades for AUD Reached for Today");
              }
            if(W_Max_N[ss]>=weekly_Max_Negative_trade_AUD&&Use_weekly_Max_Negative_trade_AUD)
              {
               T_Allow=false;
               Comment("Max -ve Trades for AUD Reached for week");
              }
            if(W_Max_P[ss]>=weekly_Max_Positive_trade_AUD&&Use_weekly_Max_Positive_trade_AUD)
              {
               T_Allow=false;
               Comment("Max +ve Trades for AUD Reached for week");
              }
           }
         if(g_symbols[ss]=="CAD")
           {
            if(D_Max_N[ss]>=Max_Negative_trade_CAD&&Use_Max_Negative_trade_CAD)
              {
               T_Allow=false;
               Comment("Max Negative Trades for CAD Reached for today");
              }
            if(D_Max_P[ss]>=Max_Positive_trade_CAD&&Use_Max_Positive_trade_CAD)
              {
               T_Allow=false;
               Comment("Max Positive Trades for CAD Reached for today");
              }
            if(W_Max_N[ss]>=weekly_Max_Negative_trade_CAD&&Use_weekly_Max_Negative_trade_CAD)
              {
               T_Allow=false;
               Comment("Max Negative Trades for CAD Reached for week");
              }
            if(W_Max_P[ss]>=weekly_Max_Positive_trade_CAD&&Use_weekly_Max_Positive_trade_CAD)
              {
               T_Allow=false;
               Comment("Max Positive Trades for CAD Reached for week");
              }
           }
         if(g_symbols[ss]=="GBP")
           {
            if(D_Max_N[ss]>=Max_Negative_trade_GBP&&Use_Max_Negative_trade_GBP)
              {
               T_Allow=false;
               Comment("Max Negative Trades for GBP Reached for today");
              }
            if(D_Max_P[ss]>=Max_Positive_trade_GBP&&Use_Max_Positive_trade_GBP)
              {
               T_Allow=false;
               Comment("Max Positive Trades for GBP Reached for today");
              }
            if(W_Max_N[ss]>=weekly_Max_Negative_trade_GBP&&Use_weekly_Max_Negative_trade_GBP)
              {
               T_Allow=false;
               Comment("Max Negative Trades for GBP Reached for Week");
              }
            if(W_Max_P[ss]>=weekly_Max_Positive_trade_GBP&&Use_weekly_Max_Positive_trade_GBP)
              {
               T_Allow=false;
               Comment("Max Positive Trades for GBP Reached for Week");
              }
           }
         if(g_symbols[ss]=="JPY")
           {
            if(D_Max_N[ss]>=Max_Negative_trade_JPY&&Use_Max_Negative_trade_JPY)
              {
               T_Allow=false;
               Comment("Max negative Trades for JPY Reached for today");
              }
            if(D_Max_P[ss]>=Max_Positive_trade_JPY&&Use_Max_Positive_trade_JPY)
              {
               T_Allow=false;
               Comment("Max Positive Trades for JPY Reached for today");
              }
            if(W_Max_N[ss]>=weekly_Max_Negative_trade_JPY&&Use_weekly_Max_Negative_trade_JPY)
              {
               T_Allow=false;
               Comment("Max negative Trades for JPY Reached for week");
              }
            if(W_Max_P[ss]>=weekly_Max_Positive_trade_JPY&&Use_weekly_Max_Positive_trade_JPY)
              {
               T_Allow=false;
               Comment("Max Positive Trades for JPY Reached for week");
              }
           }
         if(g_symbols[ss]=="CHF")
           {
            if(D_Max_N[ss]>=Max_Negative_trade_CHF&&Use_Max_Negative_trade_CHF)
              {
               T_Allow=false;
               Comment("Max negative Trades for CHF Reached for today");
              }
            if(D_Max_P[ss]>=Max_Positive_trade_CHF&&Use_Max_Positive_trade_CHF)
              {
               T_Allow=false;
               Comment("Max Positive Trades for CHF Reached for today");
              }
            if(W_Max_N[ss]>=weekly_Max_Negative_trade_CHF&&Use_weekly_Max_Negative_trade_CHF)
              {
               T_Allow=false;
               Comment("Max negative Trades for CHF Reached for week");
              }
            if(W_Max_P[ss]>=weekly_Max_Positive_trade_CHF&&Use_weekly_Max_Positive_trade_CHF)
              {
               T_Allow=false;
               Comment("Max Positive Trades for CHF Reached for week");
              }
           }
         if(g_symbols[ss]=="NZD")
           {
            if(D_Max_N[ss]>=Max_Negative_trade_NZD&&Use_Max_Negative_trade_NZD)
              {
               T_Allow=false;
               Comment("Max negative Trades for NZD Reached for today");
              }
            if(D_Max_P[ss]>=Max_Positive_trade_NZD&&Use_Max_Positive_trade_NZD)
              {
               T_Allow=false;
               Comment("Max +ve Trades for NZD Reached for today");
              }
            if(W_Max_N[ss]>=weekly_Max_Negative_trade_NZD&&Use_weekly_Max_Negative_trade_NZD)
              {
               T_Allow=false;
               Comment("Max negative Trades for NZD Reached for week");
              }
            if(W_Max_P[ss]>=weekly_Max_Positive_trade_NZD&&Use_weekly_Max_Positive_trade_NZD)
              {
               T_Allow=false;
               Comment("Max +ve Trades for NZD Reached for week");
              }
           }
        }
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   bool trade_Allow=TradeAllow_Day[i]&&TradeAllow_Day_ALl&&TradeAllow_Week[i]&&TradeAllow_Week_ALl&&limit_gain&&limit_loss&&T_Allow;
   MqlDateTime current,tmrw;
   datetime currentDT=0;
   datetime tmrwDT=currentDT+24*60*60;
   currentDT=TimeCurrent();
   TimeToStruct(tmrwDT,tmrw);
   TimeToStruct(currentDT,current);
   double Balance=AccountInfoDouble(ACCOUNT_BALANCE);
   double profit= AccountInfoDouble(ACCOUNT_PROFIT);
   if(profit<0&&MathAbs(profit)>Balance*(Max_Account_lost/100))
     {
      Comment("Your Account losses reach the Maximum");
      trade_Allow=false;
     }

   if(profit<0&&MathAbs(profit)>Balance*(Max_DrawDown/100))
     {
      Comment("Your Account DrawDown reach the Maximum");
      if(DrawDown_Action==Stop_Trading)
         trade_Allow=false;
      if(close_Drawdown)
        {
         if(DrawDown_Action==ClosAll)
            for(int b=0; b<ArraySize(aSymbols); b++)
              {
               Positions[b].GroupCloseAll(30);
              }
         if(DrawDown_Action==Close_Profit)
            for(int b=0; b<ArraySize(aSymbols); b++)
              {
               if(Positions[b].GetProfit()>0)
                  Positions[b].Close(30);
              }
         if(DrawDown_Action==Close_loss)
            for(int b=0; b<ArraySize(aSymbols); b++)
              {
               if(Positions[b].GetProfit()<0)
                  Positions[b].Close(30);
              }
        }
     }
   if(close_All_prec_profit)
     {
      if(profit>Balance*(prec_profit_close/100))
        {
         for(int b=0; b<ArraySize(aSymbols); b++)
           {
            Positions[b].GroupCloseAll(30);
           }
        }
     }
   if(close_position_prec_profit)
     {
      for(int b=0; b<Positions[i].GroupTotal(); b++)
        {
         double pp=Positions[i][b].GetProfit();
         if(pp>Balance*(prec_close_position/100))
           {
            Positions[i][b].Close(30);
           }
        }
     }

   if(closeAll_DayEnd)
     {
      if(current.hour==23&&current.min>=50)
         Positions[i].GroupCloseAll();
     }
   if(closeAll_WeekEnd)

     {

      if(current.day_of_week==5&&current.hour==23)
         Positions[i].GroupCloseAll();
     }
   if(closeAll_MonthEnd)
     {
      if(current.day==1&&current.hour==0&&current.min<2)
        {
         Positions[i].GroupCloseAll();
        }
     }


//+------------------------------------------------------------------+
   if((((!use_CMS_Filters&&buy)||(use_CMS_Filters&&buy&&CSMBuy&&!nonFX)||(use_CMS_Filters&&buy&&nonFX))&&trade_Allow)&&(Trade_Immediatly||(!Trade_Immediatly&&time1[i]!=iTime(_Symb,TF_Interval,0))))
     {
      double temp[],
             temp1[];

      ArraySetAsSeries(temp, true);
      if(sltype == 1)
         if(CopyBuffer(sar_handle[i], 0, 0, 1, temp) <= 0)
            Alert("error in geting SAR indicato data for sl");
      ArraySetAsSeries(temp1, true);
      if(sltype == 2)
         if(CopyBuffer(st_handle[i], 2, 0, 1, temp1) <= 0)
            Alert("error in geting supertrend indicato data for sl");
      double sl = 0;
      if(sltype == 0)
         sl = tools[i].Ask()-STOPLOSS*tools[i].Pip();
      if(sltype == 1)
         sl = temp[0];
      if(sltype == 2)
         sl = temp1[0];
      TAKEPROFIT=Risk==HighRisk?HighRiskTP:Risk==MidRisk?MidRiskTP:LowRiskTP;
      double tp = tools[i].Bid()+TAKEPROFIT*tools[i].Pip();
      double slpip = tools[i].Bid()-sl;
      if(tpType == RISK_REWARD)
        {
         tp = tools[i].Bid()+TAKEPROFIT*slpip;
        }
      time1[i]=iTime(_Symb,TF_Interval,0);
      CalcLot(i,slpip/tools[i].Pip());
      if(trade_type == AUTO_TRADE&&((Use_Max_Orders&&OrdersTotal()<Max_Orders)||!Use_Max_Orders))
        {
         if((TRADE_ON == CURRENT_ONLY && _Symb == Symbol()) || (TRADE_ON == MULTIPLE_PAIRS))
           {
            if((Hedge&&BuyPositions[i].GroupTotal()<Max_Orders_symbols)||(!Hedge&&Positions[i].GroupTotal()<Max_Orders_symbols))
               if(type == BOTH || type == BUY_ONLY)
                 {
                  if(BuyPositions[i].GroupTotal() == 0)
                    {
                     if(TRADEMODE == SINGLE)
                       {
                        trades[i].Position(TYPE_POSITION_BUY, Lot, sl, tp, SLTP_PRICE, 30, comment);
                       }
                     else
                        if(TRADEMODE == MULTIPLE)
                          {
                           if(TAKEPROFIT > 0)
                             {
                              if(tpType == RISK_REWARD)
                                {
                                 tp = tools[i].Bid()+TAKEPROFIT*slpip;
                                }
                              if(tpType == PIPS)
                                {
                                 tp = tools[i].Bid()+TAKEPROFIT*tools[i].Pip();
                                }
                              trades[i].Position(TYPE_POSITION_BUY, Lot, sl, tp, SLTP_PRICE, 30, comment);
                             }
                           if(tp2 > 0)
                             {
                              if(tpType == RISK_REWARD)
                                {
                                 tp = tools[i].Bid()+tp2*slpip;
                                }
                              if(tpType == PIPS)
                                {
                                 tp = tools[i].Bid()+tp2*tools[i].Pip();
                                }
                              trades[i].Position(TYPE_POSITION_BUY, Lot, sl, tp, SLTP_PRICE, 30, comment);
                             }
                           if(tp3 > 0)
                             {
                              if(tpType == RISK_REWARD)
                                {
                                 tp = tools[i].Bid()+tp3*slpip;
                                }
                              if(tpType == PIPS)
                                {
                                 tp = tools[i].Bid()+tp3*tools[i].Pip();
                                }
                              trades[i].Position(TYPE_POSITION_BUY, Lot, sl, tp, SLTP_PRICE, 30, comment);
                             }
                           if(tp4 > 0)
                             {
                              if(tpType == RISK_REWARD)
                                {
                                 tp = tools[i].Bid()+tp4*slpip;
                                }
                              if(tpType == PIPS)
                                {
                                 tp = tools[i].Bid()+tp4*tools[i].Pip();
                                }
                              trades[i].Position(TYPE_POSITION_BUY, Lot, sl, tp, SLTP_PRICE, 30, comment);
                             }
                           if(tp5 > 0)
                             {
                              if(tpType == RISK_REWARD)
                                {
                                 tp = tools[i].Bid()+tp5*slpip;
                                }
                              if(tpType == PIPS)
                                {
                                 tp = tools[i].Bid()+tp5*tools[i].Pip();
                                }
                              trades[i].Position(TYPE_POSITION_BUY, Lot, sl, tp, SLTP_PRICE, 30, comment);
                             }

                          }
                    }
                 }
           }
        }
      if(ShowSL)
        {
         LabelCreate(0, OBJPREFIX+"sl"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, DoubleToString(sl, (int)SymbolInfoInteger(_Symb, SYMBOL_DIGITS)), sFontType, 9, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "\n");
         xx+=60;
        }
      if(ShowTp)
        {
         LabelCreate(0, OBJPREFIX+"tp"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, DoubleToString(tp, (int)SymbolInfoInteger(_Symb, SYMBOL_DIGITS)), sFontType, 9, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "\n");
         xx+=60;
        }
      signal[i] = true;
      cc0 = _Symb+" BUY SL "+DoubleToString(sl, (int)SymbolInfoInteger(_Symb, SYMBOL_DIGITS))+" TP " +DoubleToString(tp, (int)SymbolInfoInteger(_Symb, SYMBOL_DIGITS));
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if((((!use_CMS_Filters&&sell)||(use_CMS_Filters&&sell&&CSMSell&&!nonFX)||(use_CMS_Filters&&sell&&nonFX))&&trade_Allow)&&(Trade_Immediatly||(!Trade_Immediatly&&time1[i]!=iTime(_Symb,TF_Interval,0))))
     {
      double temp[],
             temp1[];
      ArraySetAsSeries(temp, true);
      if(sltype == 1)
         if(CopyBuffer(sar_handle[i], 0, 0, 1, temp) <= 0)
            MessageBox("error in geting SAR indicator data for sl");
      ArraySetAsSeries(temp1, true);
      if(sltype == 2)
         if(CopyBuffer(st_handle[i], 2, 0, 1, temp1) <= 0)
            MessageBox("error in geting supertrend indicator data for sl");
      double sl = 0;
      if(sltype == 0)
         sl = tools[i].Bid()+STOPLOSS*tools[i].Pip();
      if(sltype == 1)
         sl = temp[0];
      if(sltype == 2)
         sl = temp1[0];
      TAKEPROFIT=Risk==HighRisk?HighRiskTP:Risk==MidRisk?MidRiskTP:LowRiskTP;
      double tp = tools[i].Bid()-TAKEPROFIT*tools[i].Pip();
      double slpip = sl-tools[i].Bid();
      if(tpType == RISK_REWARD)
        {
         tp = tools[i].Bid()-TAKEPROFIT*slpip;
        }
      CalcLot(i,slpip/tools[i].Pip());
      time1[i]=iTime(_Symb,TF_Interval,0);
      if(trade_type == AUTO_TRADE&&((Use_Max_Orders&&OrdersTotal()<Max_Orders)||!Use_Max_Orders))
        {
         if((TRADE_ON == CURRENT_ONLY && _Symb == Symbol()) || (TRADE_ON == MULTIPLE_PAIRS))
           {
            if((Hedge&&SellPositions[i].GroupTotal()<Max_Orders_symbols)||(!Hedge&&Positions[i].GroupTotal()<Max_Orders_symbols))
               if(type == BOTH || type == SELL_ONLY)
                 {
                  if(SellPositions[i].GroupTotal() == 0)
                    {
                     if(TRADEMODE == SINGLE)
                       {
                        trades[i].Position(TYPE_POSITION_SELL, Lot, sl, tp, SLTP_PRICE, 30, comment);
                       }
                     else
                        if(TRADEMODE == MULTIPLE)
                          {
                           if(TAKEPROFIT > 0)
                             {
                              if(tpType == RISK_REWARD)
                                {
                                 tp = tools[i].Bid()-TAKEPROFIT*slpip;
                                }
                              if(tpType == PIPS)
                                {
                                 tp = tools[i].Bid()-TAKEPROFIT*tools[i].Pip();
                                }
                              trades[i].Position(TYPE_POSITION_SELL, Lot, sl, tp, SLTP_PRICE, 30, comment);
                             }
                           if(tp2 > 0)
                             {
                              if(tpType == RISK_REWARD)
                                {
                                 tp = tools[i].Bid()-tp2*slpip;
                                }
                              if(tpType == PIPS)
                                {
                                 tp = tools[i].Bid()-tp2*tools[i].Pip();
                                }
                              trades[i].Position(TYPE_POSITION_SELL, Lot, sl, tp, SLTP_PRICE, 30, comment);
                             }
                           if(tp3 > 0)
                             {
                              if(tpType == RISK_REWARD)
                                {
                                 tp = tools[i].Bid()-tp3*slpip;
                                }
                              if(tpType == PIPS)
                                {
                                 tp = tools[i].Bid()-tp3*tools[i].Pip();
                                }
                              trades[i].Position(TYPE_POSITION_SELL, Lot, sl, tp, SLTP_PRICE, 30, comment);
                             }
                           if(tp4 > 0)
                             {
                              if(tpType == RISK_REWARD)
                                {
                                 tp = tools[i].Bid()-tp4*slpip;
                                }
                              if(tpType == PIPS)
                                {
                                 tp = tools[i].Bid()-tp4*tools[i].Pip();
                                }
                              trades[i].Position(TYPE_POSITION_SELL, Lot, sl, tp, SLTP_PRICE, 30, comment);
                             }
                           if(tp5 > 0)
                             {
                              if(tpType == RISK_REWARD)
                                {
                                 tp = tools[i].Bid()-tp5*slpip;
                                }
                              if(tpType == PIPS)
                                {
                                 tp = tools[i].Bid()-tp5*tools[i].Pip();
                                }
                              trades[i].Position(TYPE_POSITION_SELL, Lot, sl, tp, SLTP_PRICE, 30, comment);
                             }

                          }
                    }
                 }
           }
        }
      cc0 = _Symb+" SELL SL "+DoubleToString(sl, (int)SymbolInfoInteger(_Symb, SYMBOL_DIGITS))+" TP " +DoubleToString(tp, (int)SymbolInfoInteger(_Symb, SYMBOL_DIGITS));
      if(ShowSL)
        {
         LabelCreate(0, OBJPREFIX+"sl"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, DoubleToString(sl, (int)SymbolInfoInteger(_Symb, SYMBOL_DIGITS)), sFontType, 9, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "\n");
         xx+=60;
        }
      if(ShowTp)
        {
         LabelCreate(0, OBJPREFIX+"tp"+" - "+_Symb, 0, _x1+Dpi(xx), Y, CORNER_LEFT_UPPER, DoubleToString(tp, (int)SymbolInfoInteger(_Symb, SYMBOL_DIGITS)), sFontType, 9, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "\n");
         xx+=60;
        }
      signal[i] = true;
     }
//---
   if(close)
     {
      cc0 = " Close "+_Symb;
      ObjectDelete(0, OBJPREFIX+"sl"+" - "+_Symb);
      ObjectDelete(0, OBJPREFIX+"tp"+" - "+_Symb);

      signal[i] = false;
     }
//---
   if(useTel && cc0 != "" && time0[i] != iTime(_Symbol, PERIOD_CURRENT, 0))
     {
      time0[i]
         = iTime(_Symbol, PERIOD_CURRENT, 0);

      if(getme_result != 0)
        {
         Print("Error : ", (getme_result));
        }
      //--- popup alerts
      if(useAlerts)
         Alert(cc0);
      //--- reading messages
      bot.GetUpdates();

      //--- processing messages
      bot.ProcessMessages(cc0);
     }
//---
  }
//+------------------------------------------------------------------+
//| CreateProBar                                                     |
//+------------------------------------------------------------------+
void CreateProBar(string _Symb, int x, int y)
  {
//---
   int fr_y_pb = y;
//---
   for(int i = 1; i < 11; i++)
     {
      LabelCreate(0, OBJPREFIX+"PB#"+IntegerToString(i)+" - "+_Symb, 0, x, fr_y_pb, CORNER_LEFT_UPPER, "0", "Webdings", 25, clrNONE, 0, ANCHOR_RIGHT, false, false, true, 0, "\n");
      fr_y_pb -= Dpi(5);
     }
//---
  }
//+------------------------------------------------------------------+
//| UpdateProBar                                                     |
//+------------------------------------------------------------------+
void UpdateProBar(string _Symb, double Percent)
  {
//---
   for(int i = 1; i < 11; i++)
      ObjectSetInteger(0, OBJPREFIX+"PB#"+IntegerToString(i)+" - "+_Symb, OBJPROP_COLOR, SelectedTheme == 0?clrGainsboro: C'80, 80, 80');
//---
   if(Percent >= 0)
      ObjectSetInteger(0, OBJPREFIX+"PB#"+"1"+" - "+_Symb, OBJPROP_COLOR, C'255, 0, 0');
//---
   if(Percent > 10)
      ObjectSetInteger(0, OBJPREFIX+"PB#"+"2"+" - "+_Symb, OBJPROP_COLOR, C'255, 69, 0');
//---
   if(Percent > 20)
      ObjectSetInteger(0, OBJPREFIX+"PB#"+"3"+" - "+_Symb, OBJPROP_COLOR, C'255, 150, 0');
//---
   if(Percent > 30)
      ObjectSetInteger(0, OBJPREFIX+"PB#"+"4"+" - "+_Symb, OBJPROP_COLOR, C'255, 165, 0');
//---
   if(Percent > 40)
      ObjectSetInteger(0, OBJPREFIX+"PB#"+"5"+" - "+_Symb, OBJPROP_COLOR, C'255, 215, 0');
//---
   if(Percent > 50)
      ObjectSetInteger(0, OBJPREFIX+"PB#"+"6"+" - "+_Symb, OBJPROP_COLOR, C'255, 255, 0');
//---
   if(Percent > 60)
      ObjectSetInteger(0, OBJPREFIX+"PB#"+"7"+" - "+_Symb, OBJPROP_COLOR, C'173, 255, 47');
//---
   if(Percent > 70)
      ObjectSetInteger(0, OBJPREFIX+"PB#"+"8"+" - "+_Symb, OBJPROP_COLOR, C'124, 252, 0');
//---
   if(Percent > 80)
      ObjectSetInteger(0, OBJPREFIX+"PB#"+"9"+" - "+_Symb, OBJPROP_COLOR, C'0, 255, 0');
//---
   if(Percent > 90)
      ObjectSetInteger(0, OBJPREFIX+"PB#"+"10"+" - "+_Symb, OBJPROP_COLOR, C'0, 255, 0');
//---
  }
//+------------------------------------------------------------------+
//| CreateMinWindow                                                  |
//+------------------------------------------------------------------+
void CreateMinWindow()
  {
//---
   RectLabelCreate(0, OBJPREFIX+"MIN"+"BCKGRND[]", 0, Dpi(1), Dpi(20), Dpi(163), Dpi(25), COLOR_BORDER, BORDER_FLAT, CORNER_LEFT_LOWER, COLOR_BORDER, STYLE_SOLID, 1, false, false, true, 0, "\n");
//---
   LabelCreate(0, OBJPREFIX+"MIN"+"CAPTION", 0, Dpi(140)-Dpi(64), Dpi(18), CORNER_LEFT_LOWER, "MultiTrader", "Arial Black", 8, C'59, 41, 40', 0, ANCHOR_UPPER, false, false, true, 0, "\n", false);
//---
   LabelCreate(0, OBJPREFIX+"MIN"+"MAXIMIZE", 0, Dpi(156), Dpi(23), CORNER_LEFT_LOWER, "1", "Webdings", 10, C'59, 41, 40', 0, ANCHOR_UPPER, false, false, true, 0, "\n", false);
//---
  }
//+------------------------------------------------------------------+
//| DelteMinWindow                                                   |
//+------------------------------------------------------------------+
void DelteMinWindow()
  {
//---
   ObjectDelete(0, OBJPREFIX+"MIN"+"BCKGRND[]");
   ObjectDelete(0, OBJPREFIX+"MIN"+"CAPTION");
   ObjectDelete(0, OBJPREFIX+"MIN"+"MAXIMIZE");
//---
  }

//+------------------------------------------------------------------+
//| UpdateSymbolGUI                                                  |
//+------------------------------------------------------------------+
void ObjectsUpdateAll(string _Symb)
  {
//--- Market info
   double bid = SymbolInfoDouble(_Symb, SYMBOL_BID),
          ask = SymbolInfoDouble(_Symb, SYMBOL_ASK),
          avg = (ask+bid)/2;
//---
   double TFHigh = iHigh(_Symb, PERIOD_CURRENT, 0),
          TFLow = iLow(_Symb, PERIOD_CURRENT, 0),
          TFOpen = iOpen(_Symb, PERIOD_CURRENT, 0);
//---
   double TFLastHigh = iHigh(_Symb, PERIOD_CURRENT, 1),
          TFLastLow = iLow(_Symb, PERIOD_CURRENT, 1),
          TFLastClose = iClose(_Symb, PERIOD_CURRENT, 1);
//---
   long Spread = SymbolInfoInteger(_Symb, SYMBOL_SPREAD);
   int digits = (int)SymbolInfoInteger(_Symb, SYMBOL_DIGITS);

//--- Range
   double pts = SymbolInfoDouble(_Symb, SYMBOL_POINT);

  }

//


//+------------------------------------------------------------------+
//| SpeedOmeter                                                      |
//+------------------------------------------------------------------+
void SpeedOmeter(string _Symb)
  {
//--- CalcSpeed
   double Pts = SymbolInfoDouble(_Symb, SYMBOL_POINT),
          LastPrice = 0,
          CurrentPrice = 0;

//---
   if(Pts != 0)
     {
      //---
      LastPrice = GlobalVariableGet(OBJPREFIX+_Symb+" - Price")/Pts;
      //---
      CurrentPrice = ((SymbolInfoDouble(_Symb, SYMBOL_ASK)+SymbolInfoDouble(_Symb, SYMBOL_BID))/2)/Pts;
     }

//---
   double Speed = NormalizeDouble((CurrentPrice-LastPrice), 0);

//---
   GlobalVariableSet(OBJPREFIX+_Symb+" - Price", (SymbolInfoDouble(_Symb, SYMBOL_ASK)+SymbolInfoDouble(_Symb, SYMBOL_BID))/2);

//--- SetMaxSpeed
   if(Speed > 99)
      Speed = 99;



//--- ResetColors
   if(ShowTradePanel)
     {
      //---
      for(int i = 0; i < (10); i++)
        {
         //--- SetObjects
         if(ObjectFind(0, OBJPREFIX+"SPEED#"+" - "+_Symb+IntegerToString(i, 0, 0)) == 0)
            ObjectSetInteger(0, OBJPREFIX+"SPEED#"+" - "+_Symb+IntegerToString(i, 0, 0), OBJPROP_COLOR, clrNONE);
         //---
         if(ObjectFind(0, OBJPREFIX+"SPEEDª"+" - "+_Symb) == 0)
            ObjectSetInteger(0, OBJPREFIX+"SPEEDª"+" - "+_Symb, OBJPROP_COLOR, clrNONE);
        }
      //--- SetColor&Text
      for(int i = 0; i < MathAbs(Speed); i++)
        {
         //--- PositiveValue
         if(Speed > 0)
           {
            //--- SetObjects
            if(ObjectFind(0, OBJPREFIX+"SPEED#"+" - "+_Symb+IntegerToString(i, 0, 0)) == 0)
               ObjectSetInteger(0, OBJPREFIX+"SPEED#"+" - "+_Symb+IntegerToString(i, 0, 0), OBJPROP_COLOR, COLOR_BUY);
            //---
            if(ObjectFind(0, OBJPREFIX+"SPEEDª"+" - "+_Symb) == 0)
               ObjectSetInteger(0, OBJPREFIX+"SPEEDª"+" - "+_Symb, OBJPROP_COLOR, COLOR_BUY);
           }
         //--- NegativeValue
         if(Speed < 0)
           {
            //--- SetObjects
            if(ObjectFind(0, OBJPREFIX+"SPEED#"+" - "+_Symb+IntegerToString(i, 0, 0)) == 0)
               ObjectSetInteger(0, OBJPREFIX+"SPEED#"+" - "+_Symb+IntegerToString(i, 0, 0), OBJPROP_COLOR, COLOR_SELL);
            //---
            if(ObjectFind(0, OBJPREFIX+"SPEEDª"+" - "+_Symb) == 0)
               ObjectSetInteger(0, OBJPREFIX+"SPEEDª"+" - "+_Symb, OBJPROP_COLOR, COLOR_SELL);
           }
         //---
         if(ObjectFind(0, OBJPREFIX+"SPEEDª"+" - "+_Symb) == 0)
            ObjectSetString(0, OBJPREFIX+"SPEEDª"+" - "+_Symb, OBJPROP_TEXT, 0, ±Str(Speed, 0)); //SetObject
        }
     }
//---
  }


//+------------------------------------------------------------------+
//| GetSetInputs                                                     |
//+------------------------------------------------------------------+
void GetSetInputs(const string _Symb)
  {

//---
  }
//+------------------------------------------------------------------+
//| GetParam                                                         |
//+------------------------------------------------------------------+
void GetParam(string p)
  {
//---
   if(p == OBJPREFIX+" ")
     {
      //---
      double pVal = TerminalInfoInteger(TERMINAL_PING_LAST);
      //---
      MessageBox
      (
         //---
         dString("99A6D43B833CB976021189ABAEEACF5D")+AccountInfoString(ACCOUNT_NAME)
         +"\n"+
         dString("47D4F60E4272BE70FB300EB05BD2AEC9")+IntegerToString(AccountInfoInteger(ACCOUNT_LOGIN))
         +"\n"+
         dString("83744D48C2D63F90DD2F812DBB5CFC0C")+IntegerToString(AccountInfoInteger(ACCOUNT_LEVERAGE))
         +"\n\n"+
         //---
         dString("B001C36F24DDD87AFB300EB05BD2AEC9")+AccountInfoString(ACCOUNT_COMPANY)
         +"\n"+
         dString("808FEF727352434E021189ABAEEACF5D")+AccountInfoString(ACCOUNT_SERVER)
         +"\n"+
         dString("70FA849373E41928")+DoubleToString(pVal/1000, 2)+dString("CDB9155CB6080FC4")
         +"\n\n"+
         //---
         dString("47EFF8FADDDA4F05FB300EB05BD2AEC9")+dString("97BA10D5D76C54AE")
         +"\n\n"+
         "Author: "+"Dr YouSuf MeSalm "
         +"\n\n"+
         "www.Yousuf-Mesalm.com"
         +"\n\n"+
         Link
         //---, MB_CAPTION, MB_ICONINFORMATION|MB_OK
      );
     }
//---
  }
//+------------------------------------------------------------------+
//| GetSetInputsA                                                    |
//+------------------------------------------------------------------+
void GetSetInputsA()
  {
//---
   double balance = AccountInfoDouble(ACCOUNT_BALANCE);

  }

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| SymbPerc                                                         |
//+------------------------------------------------------------------+
double SymbPerc(string _Symb)
  {
//---
   double percent = 0,
          range = iHigh(_Symb, PERIOD_CURRENT, 0)-iLow(_Symb, PERIOD_CURRENT, 0);
//---
   if(range != 0)
      percent = 100*((iClose(_Symb, PERIOD_CURRENT, 0)-iLow(_Symb, PERIOD_CURRENT, 0))/range);
//---
   return(percent);
  }
//+------------------------------------------------------------------+
//| ±Str                                                             |
//+------------------------------------------------------------------+
string ±Str(double Inp, int Precision)
  {
//--- PositiveValue
   if(Inp > 0)
      return("+"+DoubleToString(Inp, Precision));
//--- NegativeValue
   else
      return(DoubleToString(Inp, Precision));
//---
  }
//+------------------------------------------------------------------+
//| ±Clr                                                             |
//+------------------------------------------------------------------+
color ±Clr(double Inp)
  {
//---
   color clr = clrNONE;
//--- PositiveValue
   if(Inp > 0)
      clr = COLOR_GREEN;
//--- NegativeValue
   if(Inp < 0)
      clr = COLOR_RED;
//--- NeutralValue
   if(Inp == 0)
      clr = COLOR_FONT;
//---
   return(clr);
  }
//+------------------------------------------------------------------+
//| ±ClrBR                                                           |
//+------------------------------------------------------------------+
color ±ClrBR(double Inp)
  {
//---
   color clr = clrNONE;
//--- PositiveValue
   if(Inp > 0)
      clr = COLOR_BUY;
//--- NegativeValue
   if(Inp < 0)
      clr = COLOR_SELL;
//--- NeutralValue
   if(Inp == 0)
      clr = COLOR_FONT;
//---
   return(clr);
  }

//+------------------------------------------------------------------+
//| _AccountCurrency                                                 |
//+------------------------------------------------------------------+
string _AccountCurrency()
  {
//---
   string txt = "";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "AUD")
      txt = "$";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "BGN")
      txt = "B";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "CAD")
      txt = "$";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "CHF")
      txt = "F";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "COP")
      txt = "$";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "CRC")
      txt = "₡";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "CUP")
      txt = "₱";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "CZK")
      txt = "K";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "EUR")
      txt = "€";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "GBP")
      txt = "£";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "GHS")
      txt = "¢";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "HKD")
      txt = "$";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "JPY")
      txt = "¥";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "NGN")
      txt = "₦";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "NOK")
      txt = "k";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "NZD")
      txt = "$";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "USD")
      txt = "$";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "RUB")
      txt = "₽";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "SGD")
      txt = "$";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "ZAR")
      txt = "R";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "SEK")
      txt = "k";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY) == "VND")
      txt = "₫";
//---
   if(txt == "")
      txt = "$";
//---
   return(txt);
  }


//+------------------------------------------------------------------+
//| SymbolFind                                                       |
//+------------------------------------------------------------------+
bool SymbolFind(const string _Symb, int mode)
  {
//---
   bool result = false;
//---
   for(int i = 0; i < SymbolsTotal(mode); i++)
     {
      //---
      if(_Symb == SymbolName(i, mode))
        {
         result = true; //SymbolFound
         break;
        }
     }
//---
   return(result);
  }


//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| SetStatus                                                        |
//+------------------------------------------------------------------+
void SetStatus(string Char, string Text)
  {
//---
   Comment("");
//---
   stauts_time = TimeLocal();
//---
   ObjectSetString(0, OBJPREFIX+"STATUS", OBJPROP_TEXT, Char);
   ObjectSetString(0, OBJPREFIX+"STATUS«", OBJPROP_TEXT, Text);
//---
  }
//+------------------------------------------------------------------+
//| ResetStatus                                                      |
//+------------------------------------------------------------------+
void ResetStatus()
  {
//---
   if(ObjectGetString(0, OBJPREFIX+"STATUS", OBJPROP_TEXT) != "\n" || ObjectGetString(0, OBJPREFIX+"STATUS«", OBJPROP_TEXT) != "\n")
     {
      ObjectSetString(0, OBJPREFIX+"STATUS", OBJPROP_TEXT, "\n");
      ObjectSetString(0, OBJPREFIX+"STATUS«", OBJPROP_TEXT, "\n");
     }
//---
  }
//+------------------------------------------------------------------+
//| Dpi                                                              |
//+------------------------------------------------------------------+
int Dpi(int Size)
  {
//---
   int screen_dpi = TerminalInfoInteger(TERMINAL_SCREEN_DPI);
   int base_width = Size;
   int width = (base_width*screen_dpi)/96;
   int scale_factor = (TerminalInfoInteger(TERMINAL_SCREEN_DPI)*100)/96;
//---
   width = (base_width*scale_factor)/100;
//---
   return(width);
  }
//+------------------------------------------------------------------+
//| dString                                                          |
//+------------------------------------------------------------------+
string dString(string text)
  {
//---
   uchar in[],
         out[],
         key[];
//---
   StringToCharArray("H+#eF_He", key);
//---
   StringToCharArray(text, in, 0, StringLen(text));
//---
   HexToArray(text, in);
//---
   CryptDecode(CRYPT_DES, in, key, out);
//---
   string result = CharArrayToString(out);
//---
   return(result);
  }
//+------------------------------------------------------------------+
//| HexToArray                                                       |
//+------------------------------------------------------------------+
bool HexToArray(string str, uchar &arr[])
  {
//--- By Andrew Sumner & Alain Verleyen
//--- https://www.mql5.com/en/forum/157839/page3
#define HEXCHAR_TO_DECCHAR(h) (h<=57?(h-48):(h-55))
//---
   int strcount = StringLen(str);
   int arrcount = ArraySize(arr);
   if(arrcount < strcount / 2)
      return false;
//---
   uchar tc[];
   StringToCharArray(str, tc);
//---
   int i = 0,
       j = 0;
//---
   for(i = 0; i < strcount; i += 2)
     {
      //---
      uchar tmpchr = (HEXCHAR_TO_DECCHAR(tc[i])<<4)+HEXCHAR_TO_DECCHAR(tc[i+1]);
      //---
      arr[j] = tmpchr;
      j++;
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ArrayToHex                                                       |
//+------------------------------------------------------------------+
//--- By Andrew Sumner & Alain Verleyen
//--- https://www.mql5.com/en/forum/157839/page3
string ArrayToHex(uchar &arr[], int count = -1)
  {
   string res = "";
//---
   if(count < 0 || count > ArraySize(arr))
      count = ArraySize(arr);
//---
   for(int i = 0; i < count; i++)
      res += StringFormat("%.2X", arr[i]);
//---
   return(res);
  }
//+------------------------------------------------------------------+
//|  ChartSetColor                                                   |
//+------------------------------------------------------------------+
void ChartSetColor(const int Type)
  {
//--- Set Light
   if(Type == 0)
     {
      ChartSetInteger(0, CHART_COLOR_BACKGROUND, COLOR_CBG_LIGHT);
      ChartSetInteger(0, CHART_COLOR_FOREGROUND, COLOR_FONT);
      ChartSetInteger(0, CHART_COLOR_GRID, clrNONE);
      ChartSetInteger(0, CHART_COLOR_CHART_UP, COLOR_CBG_LIGHT);
      ChartSetInteger(0, CHART_COLOR_CHART_DOWN, COLOR_CBG_LIGHT);
      ChartSetInteger(0, CHART_COLOR_CANDLE_BULL, COLOR_CBG_LIGHT);
      ChartSetInteger(0, CHART_COLOR_CANDLE_BEAR, COLOR_CBG_LIGHT);
      ChartSetInteger(0, CHART_COLOR_CHART_LINE, COLOR_CBG_LIGHT);
      ChartSetInteger(0, CHART_COLOR_VOLUME, COLOR_CBG_LIGHT);
      ChartSetInteger(0, CHART_COLOR_ASK, clrNONE);
      ChartSetInteger(0, CHART_COLOR_STOP_LEVEL, COLOR_CBG_LIGHT);
      //---
      ChartSetInteger(0, CHART_SHOW_OHLC, false);
      ChartSetInteger(0, CHART_SHOW_ASK_LINE, false);
      ChartSetInteger(0, CHART_SHOW_PERIOD_SEP, false);
      ChartSetInteger(0, CHART_SHOW_GRID, false);
      ChartSetInteger(0, CHART_SHOW_VOLUMES, false);
      ChartSetInteger(0, CHART_SHOW_OBJECT_DESCR, false);
      ChartSetInteger(0, CHART_SHOW_TRADE_LEVELS, false);
     }

//--- Set Dark
   if(Type == 1)
     {
      ChartSetInteger(0, CHART_COLOR_BACKGROUND, COLOR_CBG_DARK);
      ChartSetInteger(0, CHART_COLOR_FOREGROUND, COLOR_FONT);
      ChartSetInteger(0, CHART_COLOR_GRID, clrNONE);
      ChartSetInteger(0, CHART_COLOR_CHART_UP, COLOR_CBG_DARK);
      ChartSetInteger(0, CHART_COLOR_CHART_DOWN, COLOR_CBG_DARK);
      ChartSetInteger(0, CHART_COLOR_CANDLE_BULL, COLOR_CBG_DARK);
      ChartSetInteger(0, CHART_COLOR_CANDLE_BEAR, COLOR_CBG_DARK);
      ChartSetInteger(0, CHART_COLOR_CHART_LINE, COLOR_CBG_DARK);
      ChartSetInteger(0, CHART_COLOR_VOLUME, COLOR_CBG_DARK);
      ChartSetInteger(0, CHART_COLOR_ASK, clrNONE);
      ChartSetInteger(0, CHART_COLOR_STOP_LEVEL, COLOR_CBG_DARK);
      //---
      ChartSetInteger(0, CHART_SHOW_OHLC, false);
      ChartSetInteger(0, CHART_SHOW_ASK_LINE, false);
      ChartSetInteger(0, CHART_SHOW_PERIOD_SEP, false);
      ChartSetInteger(0, CHART_SHOW_GRID, false);
      ChartSetInteger(0, CHART_SHOW_VOLUMES, false);
      ChartSetInteger(0, CHART_SHOW_OBJECT_DESCR, false);
      ChartSetInteger(0, CHART_SHOW_TRADE_LEVELS, false);
     }

//--- Set Original
   if(Type == 2)
     {
      ChartSetInteger(0, CHART_COLOR_BACKGROUND, ChartColor_BG);
      ChartSetInteger(0, CHART_COLOR_FOREGROUND, ChartColor_FG);
      ChartSetInteger(0, CHART_COLOR_GRID, ChartColor_GD);
      ChartSetInteger(0, CHART_COLOR_CHART_UP, ChartColor_UP);
      ChartSetInteger(0, CHART_COLOR_CHART_DOWN, ChartColor_DWN);
      ChartSetInteger(0, CHART_COLOR_CANDLE_BULL, ChartColor_BULL);
      ChartSetInteger(0, CHART_COLOR_CANDLE_BEAR, ChartColor_BEAR);
      ChartSetInteger(0, CHART_COLOR_CHART_LINE, ChartColor_LINE);
      ChartSetInteger(0, CHART_COLOR_VOLUME, ChartColor_VOL);
      ChartSetInteger(0, CHART_COLOR_ASK, ChartColor_ASK);
      ChartSetInteger(0, CHART_COLOR_STOP_LEVEL, ChartColor_LVL);
      //---
      ChartSetInteger(0, CHART_SHOW_OHLC, ChartColor_OHLC);
      ChartSetInteger(0, CHART_SHOW_ASK_LINE, ChartColor_ASKLINE);
      ChartSetInteger(0, CHART_SHOW_PERIOD_SEP, ChartColor_PERIODSEP);
      ChartSetInteger(0, CHART_SHOW_GRID, ChartColor_GRID);
      ChartSetInteger(0, CHART_SHOW_VOLUMES, ChartColor_SHOWVOL);
      ChartSetInteger(0, CHART_SHOW_OBJECT_DESCR, ChartColor_OBJDESCR);
      ChartSetInteger(0, CHART_SHOW_TRADE_LEVELS, ChartColor_TRADELVL);
     }

//---
   if(Type == 3)
     {
      ChartSetInteger(0, CHART_COLOR_BACKGROUND, clrWhite);
      ChartSetInteger(0, CHART_COLOR_FOREGROUND, clrBlack);
      ChartSetInteger(0, CHART_COLOR_GRID, clrSilver);
      ChartSetInteger(0, CHART_COLOR_CHART_UP, clrBlack);
      ChartSetInteger(0, CHART_COLOR_CHART_DOWN, clrBlack);
      ChartSetInteger(0, CHART_COLOR_CANDLE_BULL, clrWhite);
      ChartSetInteger(0, CHART_COLOR_CANDLE_BEAR, clrBlack);
      ChartSetInteger(0, CHART_COLOR_CHART_LINE, clrBlack);
      ChartSetInteger(0, CHART_COLOR_VOLUME, clrGreen);
      ChartSetInteger(0, CHART_COLOR_ASK, clrOrangeRed);
      ChartSetInteger(0, CHART_COLOR_STOP_LEVEL, clrOrangeRed);
      //---
      ChartSetInteger(0, CHART_SHOW_OHLC, false);
      ChartSetInteger(0, CHART_SHOW_ASK_LINE, false);
      ChartSetInteger(0, CHART_SHOW_PERIOD_SEP, false);
      ChartSetInteger(0, CHART_SHOW_GRID, false);
      ChartSetInteger(0, CHART_SHOW_VOLUMES, false);
      ChartSetInteger(0, CHART_SHOW_OBJECT_DESCR, false);
     }
//---
  }
//+------------------------------------------------------------------+
//| ChartGetColor                                                    |
//+------------------------------------------------------------------+
//---- Original Template
color ChartColor_BG = 0, ChartColor_FG = 0, ChartColor_GD = 0, ChartColor_UP = 0, ChartColor_DWN = 0, ChartColor_BULL = 0, ChartColor_BEAR = 0, ChartColor_LINE = 0, ChartColor_VOL = 0, ChartColor_ASK = 0, ChartColor_LVL = 0;
//---
bool ChartColor_OHLC = false, ChartColor_ASKLINE = false, ChartColor_PERIODSEP = false, ChartColor_GRID = false, ChartColor_SHOWVOL = false, ChartColor_OBJDESCR = false, ChartColor_TRADELVL = false;
//----
void ChartGetColor()
  {
   ChartColor_BG = (color)ChartGetInteger(0, CHART_COLOR_BACKGROUND, 0);
   ChartColor_FG = (color)ChartGetInteger(0, CHART_COLOR_FOREGROUND, 0);
   ChartColor_GD = (color)ChartGetInteger(0, CHART_COLOR_GRID, 0);
   ChartColor_UP = (color)ChartGetInteger(0, CHART_COLOR_CHART_UP, 0);
   ChartColor_DWN = (color)ChartGetInteger(0, CHART_COLOR_CHART_DOWN, 0);
   ChartColor_BULL = (color)ChartGetInteger(0, CHART_COLOR_CANDLE_BULL, 0);
   ChartColor_BEAR = (color)ChartGetInteger(0, CHART_COLOR_CANDLE_BEAR, 0);
   ChartColor_LINE = (color)ChartGetInteger(0, CHART_COLOR_CHART_LINE, 0);
   ChartColor_VOL = (color)ChartGetInteger(0, CHART_COLOR_VOLUME, 0);
   ChartColor_ASK = (color)ChartGetInteger(0, CHART_COLOR_ASK, 0);
   ChartColor_LVL = (color)ChartGetInteger(0, CHART_COLOR_STOP_LEVEL, 0);
//---
   ChartColor_OHLC = ChartGetInteger(0, CHART_SHOW_OHLC, 0);
   ChartColor_ASKLINE = ChartGetInteger(0, CHART_SHOW_ASK_LINE, 0);
   ChartColor_PERIODSEP = ChartGetInteger(0, CHART_SHOW_PERIOD_SEP, 0);
   ChartColor_GRID = ChartGetInteger(0, CHART_SHOW_GRID, 0);
   ChartColor_SHOWVOL = ChartGetInteger(0, CHART_SHOW_VOLUMES, 0);
   ChartColor_OBJDESCR = ChartGetInteger(0, CHART_SHOW_OBJECT_DESCR, 0);
   ChartColor_TRADELVL = ChartGetInteger(0, CHART_SHOW_TRADE_LEVELS, 0);
//---
  }
//+------------------------------------------------------------------+
//| ChartMiddleX                                                     |
//+------------------------------------------------------------------+
int ChartMiddleX()
  {
   return((int)ChartGetInteger(0, CHART_WIDTH_IN_PIXELS)/2);
  }
//+------------------------------------------------------------------+
//| ChartMiddleY                                                     |
//+------------------------------------------------------------------+
int ChartMiddleY()
  {
   return((int)ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS)/2);
  }
//+------------------------------------------------------------------+
//| Create rectangle label                                           |
//+------------------------------------------------------------------+
//https://docs.mql4.com/constants/objectconstants/enum_object/obj_rectangle_label
bool RectLabelCreate(const long chart_ID = 0, // chart's ID
                     const string name = "RectLabel", // label name
                     const int sub_window = 0, // subwindow index
                     const int x = 0, // X coordinate
                     const int y = 0, // Y coordinate
                     const int width = 50, // width
                     const int height = 18, // height
                     const color back_clr = C'236, 233, 216', // background color
                     const ENUM_BORDER_TYPE border = BORDER_SUNKEN, // border type
                     const ENUM_BASE_CORNER corner = CORNER_LEFT_UPPER, // chart corner for anchoring
                     const color clr = clrRed, // flat border color (Flat)
                     const ENUM_LINE_STYLE style = STYLE_SOLID, // flat border style
                     const int line_width = 1, // flat border width
                     const bool back = false, // in the background
                     const bool selection = false, // highlight to move
                     const bool hidden = true, // hidden in the object list
                     const long z_order = 0, // priority for mouse click
                     const string tooltip = "\n") // tooltip for mouse hover
  {
//---- reset the error value
   ResetLastError();
//---
   if(ObjectFind(chart_ID, name) != 0)
     {
      if(!ObjectCreate(chart_ID, name, OBJ_RECTANGLE_LABEL, sub_window, 0, 0))
        {
         Print(__FUNCTION__,
               ": failed to create a rectangle label! Error code = ", _LastError);
         return(false);
        }
      //--- SetObjects
      ObjectSetInteger(chart_ID, name, OBJPROP_XDISTANCE, x);
      ObjectSetInteger(chart_ID, name, OBJPROP_YDISTANCE, y);
      ObjectSetInteger(chart_ID, name, OBJPROP_XSIZE, width);
      ObjectSetInteger(chart_ID, name, OBJPROP_YSIZE, height);
      ObjectSetInteger(chart_ID, name, OBJPROP_BGCOLOR, back_clr);
      ObjectSetInteger(chart_ID, name, OBJPROP_BORDER_TYPE, border);
      ObjectSetInteger(chart_ID, name, OBJPROP_CORNER, corner);
      ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clr);
      ObjectSetInteger(chart_ID, name, OBJPROP_STYLE, style);
      ObjectSetInteger(chart_ID, name, OBJPROP_WIDTH, line_width);
      ObjectSetInteger(chart_ID, name, OBJPROP_BACK, back);
      ObjectSetInteger(chart_ID, name, OBJPROP_SELECTABLE, selection);
      ObjectSetInteger(chart_ID, name, OBJPROP_SELECTED, selection);
      ObjectSetInteger(chart_ID, name, OBJPROP_HIDDEN, hidden);
      ObjectSetInteger(chart_ID, name, OBJPROP_ZORDER, z_order);
      ObjectSetString(chart_ID, name, OBJPROP_TOOLTIP, tooltip);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Create a text label                                              |
//+------------------------------------------------------------------+
//https://docs.mql4.com/constants/objectconstants/enum_object/obj_label
bool LabelCreate(const long chart_ID = 0, // chart's ID
                 const string name = "Label", // label name
                 const int sub_window = 0, // subwindow index
                 const int x = 0, // X coordinate
                 const int y = 0, // Y coordinate
                 const ENUM_BASE_CORNER corner = CORNER_LEFT_UPPER, // chart corner for anchoring
                 const string text = "Label", // text
                 const string font = "Arial", // font
                 const int font_size = 10, // font size
                 const color clr = clrRed, // color
                 const double angle = 0.0, // text slope
                 const ENUM_ANCHOR_POINT anchor = ANCHOR_LEFT_UPPER, // anchor type
                 const bool back = false, // in the background
                 const bool selection = false, // highlight to move
                 const bool hidden = true, // hidden in the object list
                 const long z_order = 0, // priority for mouse click
                 const string tooltip = "\n", // tooltip for mouse hover
                 const bool tester = true) // create object in the strategy tester
  {
//--- reset the error value
   ResetLastError();
//--- CheckTester
   if(!tester && MQLInfoInteger(MQL_TESTER))
      return(false);
//---
   if(ObjectFind(chart_ID, name) < 0)
     {
      if(!ObjectCreate(chart_ID, name, OBJ_LABEL, sub_window, 0, 0))
        {
         Print(__FUNCTION__,
               ": failed to create text label! Error code = ", _LastError);
         return(false);
        }
      //--- SetObjects
      ObjectSetInteger(chart_ID, name, OBJPROP_XDISTANCE, x);
      ObjectSetInteger(chart_ID, name, OBJPROP_YDISTANCE, y);
      ObjectSetInteger(chart_ID, name, OBJPROP_CORNER, corner);
      ObjectSetString(chart_ID, name, OBJPROP_TEXT, text);
      ObjectSetString(chart_ID, name, OBJPROP_FONT, font);
      ObjectSetInteger(chart_ID, name, OBJPROP_FONTSIZE, font_size);
      ObjectSetDouble(chart_ID, name, OBJPROP_ANGLE, angle);
      ObjectSetInteger(chart_ID, name, OBJPROP_ANCHOR, anchor);
      ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clr);
      ObjectSetInteger(chart_ID, name, OBJPROP_BACK, back);
      ObjectSetInteger(chart_ID, name, OBJPROP_SELECTABLE, selection);
      ObjectSetInteger(chart_ID, name, OBJPROP_SELECTED, selection);
      ObjectSetInteger(chart_ID, name, OBJPROP_HIDDEN, hidden);
      ObjectSetInteger(chart_ID, name, OBJPROP_ZORDER, z_order);
      ObjectSetString(chart_ID, name, OBJPROP_TOOLTIP, tooltip);
     }
   else
     {
      ObjectSetString(chart_ID, name, OBJPROP_TEXT, text);
      ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clr);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Create Edit object                                               |
//+------------------------------------------------------------------+
//https://docs.mql4.com/constants/objectconstants/enum_object/obj_edit
bool EditCreate(const long chart_ID = 0, // chart's ID
                const string name = "Edit", // object name
                const int sub_window = 0, // subwindow index
                const int x = 0, // X coordinate
                const int y = 0, // Y coordinate
                const int width = 50, // width
                const int height = 18, // height
                const string text = "Text", // text
                const string font = "Arial", // font
                const int font_size = 10, // font size
                const ENUM_ALIGN_MODE align = ALIGN_CENTER, // alignment type
                const bool read_only = false, // ability to edit
                const ENUM_BASE_CORNER corner = CORNER_LEFT_UPPER, // chart corner for anchoring
                const color clr = clrBlack, // text color
                const color back_clr = clrWhite, // background color
                const color border_clr = clrNONE, // border color
                const bool back = false, // in the background
                const bool selection = false, // highlight to move
                const bool hidden = true, // hidden in the object list
                const long z_order = 0, // priority for mouse click
                const string tooltip = "\n") // tooltip for mouse hover
  {
//--- reset the error value
   ResetLastError();
//---
   if(ObjectFind(chart_ID, name) != 0)
     {
      if(!ObjectCreate(chart_ID, name, OBJ_EDIT, sub_window, 0, 0))
        {
         Print(__FUNCTION__,
               ": failed to create \"Edit\" object! Error code = ", _LastError);
         return(false);
        }
      //--- SetObjects
      ObjectSetInteger(chart_ID, name, OBJPROP_XDISTANCE, x);
      ObjectSetInteger(chart_ID, name, OBJPROP_YDISTANCE, y);
      ObjectSetInteger(chart_ID, name, OBJPROP_XSIZE, width);
      ObjectSetInteger(chart_ID, name, OBJPROP_YSIZE, height);
      ObjectSetString(chart_ID, name, OBJPROP_TEXT, text);
      ObjectSetString(chart_ID, name, OBJPROP_FONT, font);
      ObjectSetInteger(chart_ID, name, OBJPROP_FONTSIZE, font_size);
      ObjectSetInteger(chart_ID, name, OBJPROP_ALIGN, align);
      ObjectSetInteger(chart_ID, name, OBJPROP_READONLY, read_only);
      ObjectSetInteger(chart_ID, name, OBJPROP_CORNER, corner);
      ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clr);
      ObjectSetInteger(chart_ID, name, OBJPROP_BGCOLOR, back_clr);
      ObjectSetInteger(chart_ID, name, OBJPROP_BORDER_COLOR, border_clr);
      ObjectSetInteger(chart_ID, name, OBJPROP_BACK, back);
      ObjectSetInteger(chart_ID, name, OBJPROP_SELECTABLE, selection);
      ObjectSetInteger(chart_ID, name, OBJPROP_SELECTED, selection);
      ObjectSetInteger(chart_ID, name, OBJPROP_HIDDEN, hidden);
      ObjectSetInteger(chart_ID, name, OBJPROP_ZORDER, z_order);
      ObjectSetString(chart_ID, name, OBJPROP_TOOLTIP, tooltip);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the button                                                |
//+------------------------------------------------------------------+
//https://docs.mql4.com/constants/objectconstants/enum_object/obj_button
bool ButtonCreate(const long chart_ID = 0, // chart's ID
                  const string name = "Button", // button name
                  const int sub_window = 0, // subwindow index
                  const int x = 0, // X coordinate
                  const int y = 0, // Y coordinate
                  const int width = 50, // button width
                  const int height = 18, // button height
                  const ENUM_BASE_CORNER corner = CORNER_LEFT_UPPER, // chart corner for anchoring
                  const string text = "Button", // text
                  const string font = "Arial", // font
                  const int font_size = 10, // font size
                  const color clr = clrBlack, // text color
                  const color back_clr = C'236, 233, 216', // background color
                  const color border_clr = clrNONE, // border color
                  const bool state = false, // pressed/released
                  const bool back = false, // in the background
                  const bool selection = false, // highlight to move
                  const bool hidden = true, // hidden in the object list
                  const long z_order = 0, // priority for mouse click
                  const string tooltip = "\n") // tooltip for mouse hover
  {
//--- reset the error value
   ResetLastError();
//---
   if(ObjectFind(chart_ID, name) != 0)
     {
      if(!ObjectCreate(chart_ID, name, OBJ_BUTTON, sub_window, 0, 0))
        {
         Print(__FUNCTION__,
               ": failed to create the button! Error code = ", _LastError);
         return(false);
        }
      //--- SetObjects
      ObjectSetInteger(chart_ID, name, OBJPROP_XDISTANCE, x);
      ObjectSetInteger(chart_ID, name, OBJPROP_YDISTANCE, y);
      ObjectSetInteger(chart_ID, name, OBJPROP_XSIZE, width);
      ObjectSetInteger(chart_ID, name, OBJPROP_YSIZE, height);
      ObjectSetInteger(chart_ID, name, OBJPROP_CORNER, corner);
      ObjectSetString(chart_ID, name, OBJPROP_TEXT, text);
      ObjectSetString(chart_ID, name, OBJPROP_FONT, font);
      ObjectSetInteger(chart_ID, name, OBJPROP_FONTSIZE, font_size);
      ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clr);
      ObjectSetInteger(chart_ID, name, OBJPROP_BGCOLOR, back_clr);
      ObjectSetInteger(chart_ID, name, OBJPROP_BORDER_COLOR, border_clr);
      ObjectSetInteger(chart_ID, name, OBJPROP_BACK, back);
      ObjectSetInteger(chart_ID, name, OBJPROP_STATE, state);
      ObjectSetInteger(chart_ID, name, OBJPROP_SELECTABLE, selection);
      ObjectSetInteger(chart_ID, name, OBJPROP_SELECTED, selection);
      ObjectSetInteger(chart_ID, name, OBJPROP_HIDDEN, hidden);
      ObjectSetInteger(chart_ID, name, OBJPROP_ZORDER, z_order);
      ObjectSetString(chart_ID, name, OBJPROP_TOOLTIP, tooltip);
     }
   else
     {
      ObjectSetString(chart_ID, name, OBJPROP_TEXT, text);
      ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clr);
      ObjectSetInteger(chart_ID, name, OBJPROP_BGCOLOR, back_clr);
      ObjectSetInteger(chart_ID, name, OBJPROP_BORDER_COLOR, border_clr);
     }
//---
   return(true);
  }
//+--------------------------------------------------------------------+
//| ChartMouseScrollSet                                                |
//+--------------------------------------------------------------------+
//https://docs.mql4.com/constants/chartconstants/charts_samples
bool ChartMouseScrollSet(const bool value)
  {
//--- reset the error value
   ResetLastError();
//---
   if(!ChartSetInteger(0, CHART_MOUSE_SCROLL, 0, value))
     {
      Print(__FUNCTION__,
            ", Error Code = ", _LastError);
      return(false);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| PlaySound                                                        |
//+------------------------------------------------------------------+
void _PlaySound(const string FileName)
  {
//---
   if(SoundIsEnabled)
      PlaySound(FileName);
//---
  }
//+------------------------------------------------------------------+
//| End of the Code                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_SAR(int index)
  {
   int res = 0;
   double temp[];
   ArraySetAsSeries(temp, true);
   if(CopyBuffer(sar_handle[index], 0, 0, 10, temp) <= 0)
      return res;
   if(iClose(Prefix+aSymbols[index]+Suffix, PERIOD_CURRENT, 0) > temp[0])
      res = 1;
   if(iClose(Prefix+aSymbols[index]+Suffix, PERIOD_CURRENT, 0) < temp[0])
      res = -1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_SingleMA(int index)
  {
   int res = 0;
   double temp[];
   ArraySetAsSeries(temp, true);
   if(CopyBuffer(s_ma_handle[index], 0, 0, 10, temp) <= 0)
      return res;
   if(iClose(Prefix+aSymbols[index]+Suffix, PERIOD_CURRENT, 0) > temp[0])
      res = 1;
   if(iClose(Prefix+aSymbols[index]+Suffix, PERIOD_CURRENT, 0) < temp[0])
      res = -1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_DoubleMA(int index)
  {
   int res = 0;
   double temp1[],
          temp2[];
   ArraySetAsSeries(temp1, true);
   ArraySetAsSeries(temp2, true);
   if(CopyBuffer(d_fma_handle[index], 0, 0, 10, temp1) <= 0)
      return res;
   if(CopyBuffer(d_sma_handle[index], 0, 0, 10, temp2) <= 0)
      return res;
   if(temp1[0] > temp2[0])
      res = 1;
   if(temp1[0] < temp2[0])
      res = -1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_Supertrend(int index)
  {
   int res = 0;
   double temp1[];
   ArraySetAsSeries(temp1, true);
   if(CopyBuffer(st_handle[index], 2, 0, 10, temp1) <= 0)
      return res;
   if(temp1[0] <= iClose(Prefix+aSymbols[index]+Suffix, st_tf, 0))
      res = 1;
   if(temp1[0] >= iClose(Prefix+aSymbols[index]+Suffix, st_tf, 0))
      res = -1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_STORSI(int index)
  {
   int res = 0;
   double temp1[];
   ArraySetAsSeries(temp1, true);
   if(CopyBuffer(storsi_handle[index], 0, 0, 10, temp1) <= 0)
      return res;
   if(temp1[0] >= 50)
      res = 1;
   if(temp1[0] <= 50)
      res = -1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_RSI(int index)
  {
   int res = 0;
   double temp1[];
   ArraySetAsSeries(temp1, true);
   if(CopyBuffer(rsi_handle[index], 0, 0, 10, temp1) <= 0)
      return res;
   if(RsiType==increase_Decrease)
     {
      if(temp1[0] >= rsi_level && temp1[0] > temp1[1] && temp1[1] > temp1[2] && temp1[2] > temp1[3])
         res = 1;
      if(temp1[0] <= rsi_level && temp1[0] < temp1[1] && temp1[1] < temp1[2] && temp1[2] < temp1[3])
         res = -1;
     }
   else
     {
      if(temp1[0] >= rsi_level)
         res = 1;
      if(temp1[0] <= rsi_level)
         res = -1;
     }
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_STO(int index)
  {
   int res = 0;
   double temp1[];
   double temp2[];
   ArraySetAsSeries(temp1, true);
   ArraySetAsSeries(temp2, true);
   if(CopyBuffer(sto_handle[index], MAIN_LINE, 0, 10, temp1) <= 0)
      return res;
   if(CopyBuffer(sto_handle[index], SIGNAL_LINE, 0, 10, temp2) <= 0)
      return res;
   if(temp1[0] > temp2[0])
      res = 1;
   if(temp1[0] < temp2[0])
      res = -1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_MACD(int index)
  {
   int res = 0;
   double temp1[];
   ArraySetAsSeries(temp1, true);
   if(CopyBuffer(mac_handle[index], 0, 0, 10, temp1) <= 0)
      return res;
   if(MacdType==increase_Decrease)
     {
      if(temp1[0] > macd_level && temp1[0] > temp1[1] && temp1[1] > temp1[2] && temp1[2] > temp1[3])
         res = 1;
      if(temp1[0] < macd_level && temp1[0] < temp1[1] && temp1[1] < temp1[2] && temp1[2] < temp1[3])
         res = -1;
     }
   else
     {
      if(temp1[0] > macd_level)
         res = 1;
      if(temp1[0] < macd_level)
         res = -1;
     }
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_ADX(int index)
  {
   int res = 0;
   double temp1[];
   double temp2[];
   double temp3[];
   ArraySetAsSeries(temp1, true);
   ArraySetAsSeries(temp2, true);
   ArraySetAsSeries(temp3, true);
   if(CopyBuffer(adx_handle[index], PLUSDI_LINE, 0, 10, temp1) <= 0)
      return res;
   if(CopyBuffer(adx_handle[index], MINUSDI_LINE, 0, 10, temp2) <= 0)
      return res;
   if(CopyBuffer(adx_handle[index], MAIN_LINE, 0, 10, temp3) <= 0)
      return res;
   if(AdxType==increase_Decrease)
     {
      if(temp1[0] > temp2[0] && temp3[0] >= adx_lev && temp3[0] > temp3[1] && temp3[1] > temp3[2] && temp3[2] > temp3[3])
         res = 1;
      if(temp1[0] < temp2[0] && temp3[0] >= adx_lev && temp3[0] > temp3[1] && temp3[1] > temp3[2] && temp3[2] > temp3[3])
         res = -1;
     }
   else
     {
      if(temp1[0] > temp2[0] && temp3[0] >= adx_lev)
         res = 1;
      if(temp1[0] < temp2[0] && temp3[0] >= adx_lev)
         res = -1;
     }
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_ATR(int index)
  {
   int res = 0;
   double temp1[];
   ArraySetAsSeries(temp1, true);
   if(CopyBuffer(atr_handle[index], 0, 0, 10, temp1) <= 0)
      return res;
   if(AtrType==increase_Decrease)
     {
      if(temp1[0] > temp1[1] && temp1[1] > temp1[2] && temp1[2] > temp1[3] && sig_Supertrend(index) == 1)
         res = 1;
      if(temp1[0] > temp1[1] && temp1[1] > temp1[2] && temp1[2] > temp1[3] && sig_Supertrend(index) == -1)
         res = -1;
     }
   else
     {
      if(sig_Supertrend(index) == 1)
         res = 1;
      if(sig_Supertrend(index) == -1)
         res = -1;
     }
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_BB(int index)
  {
   int res = 0;
   double temp1[],temp2[],temp3[];
   ArraySetAsSeries(temp1, true);
   ArraySetAsSeries(temp2, true);
   ArraySetAsSeries(temp3, true);
   if(CopyBuffer(bb_handle[index], 0, 0, 10, temp1) <= 0)
      return res;
   if(CopyBuffer(bb_handle[index], 1, 0, 10, temp2) <= 0)
      return res;
   if(CopyBuffer(bb_handle[index], 2, 0, 10, temp3) <= 0)
      return res;
   if(BBType==increase_Decrease)
     {
      if(temp1[0] < iClose(Prefix+aSymbols[index]+Suffix, bb_tf, 0) && temp2[0] > temp2[1] && temp2[1] > temp2[2] && temp2[2] > temp2[3])
         res = 1;
      if(temp1[0] > iClose(Prefix+aSymbols[index]+Suffix, bb_tf, 0) && temp3[0] > temp3[1] && temp3[1] > temp3[2] && temp3[2] > temp3[3])
         res = -1;
     }
   else
     {

      if(temp1[0] < iClose(Prefix+aSymbols[index]+Suffix, bb_tf, 0))
         res = 1;
      if(temp1[0] > iClose(Prefix+aSymbols[index]+Suffix, bb_tf, 0))
         res = -1;
     }
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_BBw(int index)
  {
   int res = 0;
   double temp1[];
   ArraySetAsSeries(temp1, true);
   if(CopyBuffer(bbw_handle[index], 0, 0, 10, temp1) <= 0)
      return res;
   if(temp1[0] > temp1[1] && temp1[1] > temp1[2])
      res = 1;
   if(temp1[0] < temp1[1] && temp1[1] < temp1[2])
      res = -1;
   return res;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_ICHI(int index)
  {
   int res = 0;
   double temp1[];
   double temp2[];
   ArraySetAsSeries(temp1, true);
   ArraySetAsSeries(temp2, true);
   if(CopyBuffer(Ichi_handle[index], SENKOUSPANA_LINE, 0, 10, temp1) <= 0)
      return res;
   if(CopyBuffer(Ichi_handle[index], SENKOUSPANB_LINE, 0, 10, temp2) <= 0)
      return res;
   if(IchType==increase_Decrease)
     {
      if(iClose(Prefix+aSymbols[index]+Suffix, Ichi_tf, 0) > MathMax(temp1[0], temp2[0])&&temp1[0] > temp1[1] && temp1[1] > temp1[2] && temp1[2] > temp1[3])
         return 1;
      if(iClose(Prefix+aSymbols[index]+Suffix, Ichi_tf, 0) < MathMin(temp1[0], temp2[0])&&temp1[0] < temp1[1] && temp1[1] < temp1[2] && temp1[2] < temp1[3])
         return -1;
     }
   else
     {
      if(iClose(Prefix+aSymbols[index]+Suffix, Ichi_tf, 0) > MathMax(temp1[0], temp2[0]))
         return 1;
      if(iClose(Prefix+aSymbols[index]+Suffix, Ichi_tf, 0) < MathMin(temp1[0], temp2[0]))
         return -1;
     }
   return res;
  }


//+------------------------------------------------------------------+
void CalcLot(int i,double sls)
  {

   if(LotType == RISK)
     {
      double sl = sls;
      double R =Risk==LOW?LowRisk:Risk==MID?MidRisk:HighRisk;
      Lot = tools[i].NormalizeVolume((AccountInfoDouble(ACCOUNT_EQUITY)*R/1000)/sl);
      if(Lot < SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN))
         Lot = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN);
      if(Lot > SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MAX))
         Lot = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MAX);
     }
   else
      if(LotType == LOT_PER)
        {
         Lot = tools[i].NormalizeVolume((AccountInfoDouble(ACCOUNT_BALANCE)/1000)*lot_Per);
        }
      else
        {
         Lot = Fixed_Lot;
        }
  }
//+------------------------------------------------------------------+
void PartialClosing(CPosition & buyPos,CPosition & sellPos,CUtilities & tool,int & b,int & s)
  {

   if(close_With_levels)
     {
      int buys=buyPos.GroupTotal();
      if(buys==0)
        {
         b=0;
        }
      for(int x=0; x<buys; x++)
        {
         double tpx=buyPos[x].GetTakeProfit();
         double openPrice= buyPos[x].GetPriceOpen();
         double tpDistance=tpx-openPrice;
         if(close_level1>0&&close_Precentage1>0&&b==0)
           {
            double tp1x=openPrice+((close_level1/100)*(tpDistance));
            double vol=buyPos[x].GetVolume();
            if(tool.Bid()>=tp1x)
              {
               buyPos[x].ClosePartial(tool.NormalizeVolume(vol*(close_Precentage1/100)),30);
               b++;

              }
           }
         if(close_level2>0&&close_Precentage2>0&&b==1)
           {
            double tp1x=openPrice+((close_level2/100)*(tpDistance));
            double vol=buyPos[x].GetVolume();
            if(tool.Bid()>=tp1x)
              {
               buyPos[x].ClosePartial(tool.NormalizeVolume(vol*(close_Precentage2/100)),30);
               b++;
              }
           }
         if(close_level3>0&&close_Precentage3>0&&b==2)
           {
            double tp1x=openPrice+((close_level3/100)*(tpDistance));
            double vol=buyPos[x].GetVolume();
            if(tool.Bid()>=tp1x)
              {
               buyPos[x].ClosePartial(tool.NormalizeVolume(vol*(close_Precentage3/100)),30);
               b++;
              }
           }
         if(close_level4>0&&close_Precentage4>0&&b==3)
           {
            double tp1x=openPrice+((close_level4/100)*(tpDistance));
            double vol=buyPos[x].GetVolume();
            if(tool.Bid()>=tp1x)
              {
               buyPos[x].ClosePartial(tool.NormalizeVolume(vol*(close_Precentage4/100)),30);
               b++;
              }
           }
         if(close_level5>0&&close_Precentage5>0&&b==4)
           {
            double tp1x=openPrice+((close_level5/100)*(tpDistance));
            double vol=buyPos[x].GetVolume();
            if(tool.Bid()>=tp1x)
              {
               buyPos[x].ClosePartial(tool.NormalizeVolume(vol*(close_Precentage5/100)),30);
               b++;
              }
           }

        }
      int sells=sellPos.GroupTotal();
      if(sells==0)
        {
         s=0;
        }
      for(int x=0; x<sells; x++)
        {
         double tpx=sellPos[x].GetTakeProfit();
         double openPrice= sellPos[x].GetPriceOpen();
         double tpDistance=openPrice-tpx;
         if(close_level1>0&&close_Precentage1>0&&s==0)
           {
            double tp1x=openPrice-((close_level1/100)*(tpDistance));
            double vol=sellPos[x].GetVolume();
            if(tool.Bid()<=tp1x)
              {
               sellPos[x].ClosePartial(tool.NormalizeVolume(vol*(close_Precentage1/100)),30);
               s++;
              }
           }
         if(close_level2>0&&close_Precentage2>0&&s==1)
           {
            double tp1x=openPrice-((close_level2/100)*(tpDistance));
            double vol=sellPos[x].GetVolume();
            if(tool.Bid()<=tp1x)
              {
               sellPos[x].ClosePartial(tool.NormalizeVolume(vol*(close_Precentage2/100)),30);
               s++;
              }
           }
         if(close_level3>0&&close_Precentage3>0&&s==2)
           {
            double tp1x=openPrice-((close_level3/100)*(tpDistance));
            double vol=sellPos[x].GetVolume();
            if(tool.Bid()<=tp1x)
              {
               sellPos[x].ClosePartial(tool.NormalizeVolume(vol*(close_Precentage3/100)),30);
               s++;
              }
           }
         if(close_level4>0&&close_Precentage4>0&&s==3)
           {
            double tp1x=openPrice-((close_level4/100)*(tpDistance));
            double vol=sellPos[x].GetVolume();
            if(tool.Bid()<=tp1x)
              {
               sellPos[x].ClosePartial(tool.NormalizeVolume(vol*(close_Precentage4/100)),30);
               s++;
              }
           }
         if(close_level5>0&&close_Precentage5>0&&s==4)
           {
            double tp1x=openPrice-((close_level5/100)*(tpDistance));
            double vol=sellPos[x].GetVolume();
            if(tool.Bid()<=tp1x)
              {
               sellPos[x].ClosePartial(tool.NormalizeVolume(vol*(close_Precentage5/100)),30);
               s++;
              }
           }

        }

     }
  }
//+------------------------------------------------------------------+
void Trailing_P()
  {
   if(use_precentage_trailing)
     {
      int size = ArraySize(aSymbols);
      for(int i=0; i<size; i++)
        {
         int buys=BuyPositions[i].GroupTotal();

         int sells=SellPositions[i].GroupTotal();
         for(int x=0; x<buys; x++)
           {
            double tpx=BuyPositions[i][x].GetTakeProfit();
            double price=BuyPositions[i][x].GetPriceOpen();
            double sssl=SellPositions[i][x].GetStopLoss();

            double distance = tpx-price;
            double tp1x=0,tpx2=0,tpx3=0,tpx4=0,tpx5=0;
            if(SL1>0&&profit_level1>0)
              {
               double p=price+(distance*(profit_level1/100));
               double s=price+(distance*(SL1/100));
               if(tools[i].Bid()>=p&&tools[i].Bid()>s&&sssl<s)
                 {
                  BuyPositions[i][x].Modify(s,tpx,SLTP_PRICE);
                 }
              }
            if(SL2>0&&profit_level2>0)
              {
               double p=price+(distance*(profit_level2/100));
               double s=price+(distance*(SL2/100));
               if(tools[i].Bid()>=p&&tools[i].Bid()>s&&sssl<s)
                 {
                  BuyPositions[i][x].Modify(s,tpx,SLTP_PRICE);
                 }
              }
            if(SL3>0&&profit_level3>0)
              {
               double p=price+(distance*(profit_level3/100));
               double s=price+(distance*(SL3/100));
               if(tools[i].Bid()>=p&&tools[i].Bid()>s&&sssl<s)
                 {
                  BuyPositions[i][x].Modify(s,tpx,SLTP_PRICE);
                 }
              }
            if(SL4>0&&profit_level4>0)
              {
               double p=price+(distance*(profit_level4/100));
               double s=price+(distance*(SL4/100));
               if(tools[i].Bid()>=p&&tools[i].Bid()>s&&sssl<s)
                 {
                  BuyPositions[i][x].Modify(s,tpx,SLTP_PRICE);
                 }
              }
            if(SL5>0&&profit_level5>0)
              {
               double p=price+(distance*(profit_level5/100));
               double s=price+(distance*(SL5/100));
               if(tools[i].Bid()>=p&&tools[i].Bid()>s&&sssl>s)
                 {
                  BuyPositions[i][x].Modify(s,tpx,SLTP_PRICE);
                 }
              }
           }

         for(int x=0; x<sells; x++)
           {
            double tpx=SellPositions[i][x].GetTakeProfit();
            double price=SellPositions[i][x].GetPriceOpen();
            double sssl=SellPositions[i][x].GetStopLoss();
            double distance = price-tpx;
            if(SL1>0&&profit_level1>0)
              {
               double p=price-(distance*(profit_level1/100));
               double s=price-(distance*(SL1/100));
               if(tools[i].Bid()<=p&&tools[i].Bid()<s&&sssl>s)
                 {
                  SellPositions[i][x].Modify(s,tpx,SLTP_PRICE);
                 }
              }
            if(SL2>0&&profit_level2>0)
              {
               double p=price-(distance*(profit_level2/100));
               double s=price-(distance*(SL2/100));

               if(tools[i].Bid()<=p&&tools[i].Bid()<s&&sssl>s)
                 {
                  SellPositions[i][x].Modify(s,tpx,SLTP_PRICE);
                 }
              }
            if(SL3>0&&profit_level3>0)
              {
               double p=price-(distance*(profit_level3/100));
               double s=price-(distance*(SL3/100));
               if(tools[i].Bid()<=p&&tools[i].Bid()<s&&sssl>s)
                 {
                  SellPositions[i][x].Modify(s,tpx,SLTP_PRICE);
                 }
              }
            if(SL4>0&&profit_level4>0)
              {
               double p=price-(distance*(profit_level4/100));
               double s=price-(distance*(SL4/100));
               if(tools[i].Bid()<=p&&tools[i].Bid()<s&&sssl>s)
                 {
                  SellPositions[i][x].Modify(s,tpx,SLTP_PRICE);
                 }
              }
            if(SL5>0&&profit_level5>0)
              {
               double p=price-(distance*(profit_level5/100));
               double s=price-(distance*(SL5/100));
               if(tools[i].Bid()<=p&&tools[i].Bid()<s&&sssl>s)
                 {
                  SellPositions[i][x].Modify(s,tpx,SLTP_PRICE);
                 }
              }
           }

        }
     }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool fetchCurrenciesStrength(double& currencyStrength[],double& currencyStrength1[],double& currencyStrength2[])
  {

   for(int index = 0; index < CURRENCIES_COUNT; ++index)
     {
      double strength[1] = { EMPTY_VALUE };
      // Copying currency strength data from CMS indicator to strength buffer
      if(CopyBuffer(g_handle, index, 0, 1, strength) != 1)
        {
         //Print("CopyBuffer from CSM failed, no data");
         return false;
        }

      if(MathAbs(strength[0])== EMPTY_VALUE)
        {
         //Print("Currency strength is not ready yet (downloading historical data..)");
         return false;
        }
      currencyStrength2[index]=currencyStrength1[index];
      currencyStrength1[index]=currencyStrength[index];
      currencyStrength[index] = strength[0];
     }

   return true;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool buildSymbolName(string firstInstrumentName, string secondInstrumentName, string suffix, string& symbolName)
  {
   string outTmp;
   symbolName = firstInstrumentName + secondInstrumentName + suffix;
   if(!SymbolInfoString(symbolName, SYMBOL_CURRENCY_BASE, outTmp))
     {
      symbolName = secondInstrumentName + firstInstrumentName + suffix;
      if(!SymbolInfoString(symbolName, SYMBOL_CURRENCY_BASE, outTmp))
        {
         return false;
        }
     }

   return true;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int findFirstStrongCurrency(double& currencyStrength[])
  {
   for(int index = 0; index < ArraySize(currencyStrength); ++index)
     {
      if(currencyStrength[index] >= 60)
        {
         return index;
        }
     }

   return -1;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int findFirstWeakCurrency(double& currencyStrength[])
  {

   for(int index = 0; index < ArraySize(currencyStrength); ++index)
     {
      if(currencyStrength[index] <= 40)
        {
         return index;
        }
     }

   return -1;
  }

int D_Max_N[CURRENCIES_COUNT];
int D_Max_P[CURRENCIES_COUNT];
int W_Max_N[CURRENCIES_COUNT];
int W_Max_P[CURRENCIES_COUNT];

//+------------------------------------------------------------------+
void Max_order_Day()
  {
   int size=ArraySize(aSymbols);
   int Max_N_D=0;
   int Max_P_D=0;
   ArrayInitialize(D_Max_N,0);
   ArrayInitialize(D_Max_P,0);
   for(int z=0; z<size; z++)
     {
      datetime time=iTime(aSymbols[z],PERIOD_D1,0);
      string pair= aSymbols[z];
      string Base =StringSubstr(pair,0,3);
      string Quote = StringSubstr(pair,3,3);
      Hist[z].SetHistoryRange(time,TimeCurrent());
      int total=Hist[z].GroupTotal();
      int n=0;
      int x=0;
      int siz=ArraySize(g_symbols);

      for(int i= 0; i<total; i++)
        {
         if(Hist[z][i].GetProfit()<0)
           {
            n++;
            for(int s=0; s<siz; s++)
              {
               if(g_symbols[s]==Base||g_symbols[s]==Quote)
                  D_Max_N[s]++;
              }
           }
         if(Hist[z][i].GetProfit()>0)
           {
            x++;
            for(int s=0; s<siz; s++)
              {
               if(g_symbols[s]==Base||g_symbols[s]==Quote)
                  D_Max_P[s]++;
              }
           }
        }

      int tot=Positions[z].GroupTotal();
      int s=0;
      for(int i= 0; i<tot; i++)
        {
         if(Positions[z][i].GetTimeOpen()>=time)
           {
            s++;
           }
        }
      Max_N_D+=n;
      Max_P_D+=x;

      if(n>=Max_negative_symbol_daily&&Use_Max_negative_symbol_daily)
        {
         Comment("("+pair+") Your Negative Trades reach the Maximum for today ");
         TradeAllow_Day[z]=false;
        }
      else
         if(x>=Max_Positive_symbol_daily&&Use_Max_positive_symbol_daily)
           {
            Comment("("+pair+") Your Positive Trades reach the Maximum for today");
            TradeAllow_Day[z]=false;
           }
         else
            if(s>=Max_Trade_daily&&Use_Max_Trade_daily)
              {
               Comment("("+pair+")Your Trades reach the Maximum for this Day");
               TradeAllow_Day[z]=false;
              }
            else
              {
               TradeAllow_Day[z]=true;
              }
     }
   if(Max_N_D>=Max_negative_All_daily&&Use_Max_negative_All_daily)
     {
      Comment("Your Negative Trades for All Symbols reach the Maximum for today");
      TradeAllow_Day_ALl=false;
     }
   else
      if(Max_P_D>=Max_Positive_All_daily&&Use_Max_positive_All_daily)
        {
         Comment("Your Positive Trades for All Symbols reach the Maximum for today");
         TradeAllow_Day_ALl=false;
        }
      else
        {
         TradeAllow_Day_ALl=true;
        }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Max_order_Weekly()
  {
   int size=ArraySize(aSymbols);
   int Max_N_W=0;
   int Max_P_W=0;
   ArrayInitialize(W_Max_N,0);
   ArrayInitialize(W_Max_P,0);
   for(int z=0; z<size; z++)
     {
      datetime time=iTime(aSymbols[z],PERIOD_W1,0);
      string pair= aSymbols[z];
      string Base =StringSubstr(pair,0,3);
      string Quote = StringSubstr(pair,3,3);
      Hist[z].SetHistoryRange(time,TimeCurrent());
      int total=Hist[z].GroupTotal();
      int n=0;
      int x=0;
      int siz=ArraySize(g_symbols);
      for(int i= 0; i<total; i++)
        {
         if(Hist[z][i].GetProfit()<0)
           {
            n++;
            for(int s=0; s<siz; s++)
              {
               if(g_symbols[s]==Base||g_symbols[s]==Quote)
                  W_Max_N[s]++;
              }
           }
         if(Hist[z][i].GetProfit()>0)
           {
            x++;
            for(int s=0; s<siz; s++)
              {
               if(g_symbols[s]==Base||g_symbols[s]==Quote)
                  W_Max_P[s]++;
              }
           }
        }

      int tot=Positions[z].GroupTotal();
      int s=0;
      for(int i= 0; i<tot; i++)
        {
         if(Positions[z][i].GetTimeOpen()>=time)
           {
            s++;
           }
        }
      Max_P_W+=x;
      Max_N_W+=n;
      if(n>=Max_negative_symbol_weekly&&Use_Max_negative_symbol_weekly)
        {
         Comment("Your Negative Trades reach the Maximum for this week");
         TradeAllow_Week[z]=false;
        }
      else
         if(x>=Max_Positive_symbol_weekly&&Use_Max_positive_symbol_weekly)
           {
            Comment("Your Positive Trades reach the Maximum for this week");
            TradeAllow_Week[z]=false;
           }
         else
            if(s>=Max_Trade_weekly&&Use_Max_Trade_weekly)
              {
               Comment("Your Trades reach the Maximum for this week");
               TradeAllow_Week[z]=false;
              }
            else
              {
               TradeAllow_Week[z]=true;
              }
     }
   if(Max_N_W>=Max_negative_All_weekly&&Use_Max_negative_All_weekly)
     {
      Comment("Your Negative Trades for All Symbols reach the Maximum for this week");
      TradeAllow_Week_ALl=false;
     }
   else
      if(Max_P_W>=Max_Positive_All_weekly&&Use_Max_positive_All_weekly)
        {
         Comment("Your Positive Trades for All Symbols reach the Maximum for this Week");
         TradeAllow_Week_ALl=false;
        }
      else
        {
         TradeAllow_Week_ALl=true;
        }

  }

//+------------------------------------------------------------------+
bool ClosingTimeFilter(string ET)
  {

   datetime End   =StringToTime(TimeToString(TimeCurrent(),TIME_DATE)+" "+ET);

   if((iTime(Symbol(),PERIOD_CURRENT,0)<=End))
     {
      return(false);
     }
   return(true);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
