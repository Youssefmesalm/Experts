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
// includes
#include <Telegram.mqh>
#include <Arrays\ArrayObj.mqh>
#include  <YM\Execute\Execute.mqh>
#include  <YM\Position\Position.mqh>
// defination
#define  NL "\n"
#define ExpertName         "MultiStrategy Panel"
#define OBJPREFIX          "YM - "
//---
#define CLIENT_BG_WIDTH    1050
#define INDENT_TOP         15
//---
#define OPENPRICE          0
#define CLOSEPRICE         1
//---
#define OP_ALL            -1
//---
#define KEY_UP             38
#define KEY_DOWN           40

//--- enumeration
enum TRADE_TYPE
  {
   AUTO_TRADE = 0,
   SIGNALS_ONLY = 1,
  };
enum SL_TP
  {
   op1 = 0,
// in pips
   op2 = 1,
// SAR
   op3 = 2,
// Supertrend
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
//--- User inputs
input string Set= "                    < - - -  General  - - - >";
input ENUM_MODE SelectedMode = COMPACT; /*Dashboard (Size)*/
input string Prefix = ""; //Symbol Prefix
input string Suffix = ""; //Symbol Suffix
input string TradeSymbols = "AUDCHF;AUDJPY;AUDUSD;AUDCAD;CADJPY;CADCHF;CHFJPY;EURAUD;EURCAD;EURCHF;EURGBP;EURUSD;EURJPY;EURNZD;GBPAUD;GBPCAD;GBPCHF;GBPJPY;GBPUSD;GBPNZD;USDCHF;USDCAD;USDJPY;NZDCAD;NZDCHF;NZDJPY;NZDUSD;"; /*Symbol List (separated by " ; ")*/
input string set1 = "==================Trading Settings ================";
input TRADE_TYPE trade_type = AUTO_TRADE;
input TRADE_MODE TRADEMODE = SINGLE;
input TRADE_PAIR TRADE_ON = MULTIPLE_PAIRS;
input ORDERTYPE type = BOTH;
input SL_TP sltype = op1;
input TP_TYPE tpType = PIPS;
input double TAKEPROFIT = 100;
input double tp1 = 0;
input double RR1 =0;
input double tp2 = 0;
input double RR2 =0;
input double tp3 = 0;
input double RR3 =0;
input double tp4 = 0;
input double RR4 =0;
input double tp5 = 0;
input double RR5 =0;
input double STOPLOSS = 100;
input long magic_Number = 2020;
input string comment ="FM Stallions";
input string set2 = "=====================  RISK Management ===============";
input LOT_TYPE LotType = RISK;
input double Fixed_Lot = 0.1;
input double Risk = 2; // RIAK PRECENTAGE
input double lot_Per = 1; // LOT PER 1000
input string set3       ="======================Closing =====================";
input bool  closeWithPercentage    = true;
input double level_To_Close = 60; // Level to close
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




input string p00 = "<----------------->PRELIMINARIES<------------------->"; //******* PRELIMINARIES *******
input bool useAlerts = true; // Use popup Alerts
input bool useTel = false; // Use Telegram Alerts
input string InpChannelName = "fmfxstk"; // Telegram Channel ID
input string InpToken = "5111296664:AAEg7d8drUaTphBVRDYU7YWWtcVz6EIuvTU"; // Telegram Token
input string p14 = "<----------------->SAR<----------------->"; //******* SAR **************
input bool useSAR = true; // Use SAR
input ENUM_TIMEFRAMES sar_tf = PERIOD_CURRENT; // Timeframe
input double sar_step = 0.02; // Step
input double sar_max = 0.2; // Maximum

input string p01 = "<----------------->SINGLE MA<----------------->"; //******* SINGLE MA *********
input bool useSingleMA = true; // Use single MA
input ENUM_TIMEFRAMES MA1_tf = PERIOD_CURRENT; // Timeframe
input int MA1_per = 200; // Period
input ENUM_MA_METHOD MA1_method = MODE_SMA; // Method
input ENUM_APPLIED_PRICE MA1_price = PRICE_CLOSE; // Applied price

input string p02 = "<----------------->DOUBLE MA<----------------->"; //******** DOUBLE MA *********
input bool useDoubleMA = true; // Use double MA
input ENUM_TIMEFRAMES MA2_tf = PERIOD_CURRENT; // Fast MA Timeframe
input int MA2_per = 50; // Fast MA Period
input ENUM_MA_METHOD MA2_method = MODE_SMA; // Fast MA Method
input ENUM_APPLIED_PRICE MA2_price = PRICE_CLOSE; // Fast MA Applied price
input ENUM_TIMEFRAMES MA3_tf = PERIOD_CURRENT; // Slow MA Timeframe
input int MA3_per = 200; // Slow MA Period
input ENUM_MA_METHOD MA3_method = MODE_SMA; // Slow MA Method
input ENUM_APPLIED_PRICE MA3_price = PRICE_CLOSE; // Slow MA Applied price

input string p03 = "<----------------->SUPERTREND<----------------->"; //******** SUPERTREND ********
input bool useSuperTrend = true; // Use supertrend
input ENUM_TIMEFRAMES st_tf = PERIOD_CURRENT; // Timeframe
input int st_per = 10; // Period
input double st_mult = 4.5; // Multiplier

input string p04 = "<----------------->STO-RSI<----------------->"; //******** STO-RSI ********
input bool useStoRSI = true; // Use sto-rsi
input ENUM_TIMEFRAMES storsi_tf = PERIOD_CURRENT; // Timeframe
input int storsi1_per = 14; // RSI Period
input int storsi2_per = 20; // STO Period

input string p05 = "<-----------------> STOCHASTIC<-----------------> "; //******** STOCHASTIC ********
input bool useSto = true; // Use stochastic oscillator
input ENUM_TIMEFRAMES sto_tf = PERIOD_CURRENT; // Timeframe
input int sto_dper = 10; // STO D-Period
input int sto_kper = 3; // STO K-Period
input int sto_sper = 3; // STO Slow-Period

input string p06 = "<-----------------> MACD <----------------->"; //******** MACD ********
input bool useMacd = true; // Use MACD
input ENUM_TIMEFRAMES mac_tf = PERIOD_CURRENT; // Timeframe
input int mac_fper = 12; // Fast EMA
input int mac_sper = 26; // Slow EMA
input int mac_smper = 9; // SMA
input double macd_level = 50; // level

input string p07 = "<-----------------> ADX <----------------->"; //******** ADX ********
input bool useAdx = true; // Use ADX
input ENUM_TIMEFRAMES adx_tf = PERIOD_CURRENT; // Timeframe
input int adx_per = 14; // Period
input double adx_lev = 30; // Level

input string p08 = "<-----------------> ATR <----------------->"; //******** ATR ********
input bool useAtr = true; // Use ATR
input ENUM_TIMEFRAMES atr_tf = PERIOD_CURRENT; // Timeframe
input int atr_per = 14; // Period

input string p09 = "<-----------------> RSI <----------------->"; //******** RSI ********
input bool useRSI = true; // Use RSI
input ENUM_TIMEFRAMES rsi_tf = PERIOD_CURRENT; // Timeframe
input int rsi_per = 14; // Period
input double rsi_level = 50; // level

input string p10 = "<-----------------> BOLLINGER <----------------->"; //******** BOLLINGER BAND ********
input bool useBB = true; // Use Bollinger
input ENUM_TIMEFRAMES bb_tf = PERIOD_CURRENT; // Timeframe
input int BB_per = 28; // Period
input double BB_dev = 2; // Deviation

input string p11 = "<-----------------> BOLLINGER WIDTH <----------------->"; //******** BOLLINGER BAND WIDTH ********
input bool useBBw = true; // Use Bollinger width
input ENUM_TIMEFRAMES bbw_tf = PERIOD_CURRENT; // Timeframe
input int BBw_per = 20; // Period
input double BBw_dev = 2; // Deviation

input string p12 = "<-----------------> ICHIMOKU <----------------->"; //******** ICHIMOKU ********
input bool useIchi = true; // Use Ichimoku
input ENUM_TIMEFRAMES Ichi_tf = PERIOD_CURRENT; // Timeframe
input int tekan = 9; // Tekan
input int kijun = 26; // Kijun
input int senkou = 52; // Senkou-Span B

bool KeyboardTrading = true; /*Keyboard Trading*/
input string set4  = "==================================  Graphics =============================";
input color COLOR_BORDER = C'255, 151, 25'; /*Panel Border*/
input color COLOR_CBG_LIGHT = C'252, 252, 252'; /*Chart Background (Light)*/
input color COLOR_CBG_DARK = C'28, 27, 26'; /*Chart Background (Dark)*/
//--- Global variables
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


//variables
double Lot;

int s_ma_handle[], d_fma_handle[], d_sma_handle[], st_handle[], storsi_handle[], sto_handle[], mac_handle[], adx_handle[], atr_handle[], rsi_handle[], bb_handle[], bbw_handle[];
int Ichi_handle[], rsiDiv_handle[], sar_handle[];
datetime time0[];
int buyPartial[],sellPartial[];
string cc0 = "";
bool signal[];
CExecute * trades[];
CPosition * Positions[];
CPosition * SellPositions[];
CPosition * BuyPositions[];
CUtilities * tools[];
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

   if(useTel)
     {
      //--- set token
      bot.Token(InpToken);
      //--- check token
      getme_result = bot.GetMe();
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

//--- Check for Symbols (Analysis)
   for(int i = 0; i < ArraySize(Symbols); i++)
     {
      //---
      if(!SymbolFind(Prefix+Symbols[i]+Suffix, true))
         if(SymbolFind(Prefix+Symbols[i]+Suffix, false))
            SymbolSelect(Prefix+Symbols[i]+Suffix, true);
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
   ArrayResize(storsi_handle, ArraySize(aSymbols));
   ArrayResize(sto_handle, ArraySize(aSymbols));
   ArrayResize(mac_handle, ArraySize(aSymbols));
   ArrayResize(adx_handle, ArraySize(aSymbols));
   ArrayResize(atr_handle, ArraySize(aSymbols));
   ArrayResize(rsi_handle, ArraySize(aSymbols));
   ArrayResize(bb_handle, ArraySize(aSymbols));
   ArrayResize(bbw_handle, ArraySize(aSymbols));
   ArrayResize(Ichi_handle, ArraySize(aSymbols));
   ArrayResize(rsiDiv_handle, ArraySize(aSymbols));
   ArrayResize(time0, ArraySize(aSymbols));
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

//--- InitFullSymbs
   SetFull();

//--- Check for Currency Pairs
   for(int i = 0; i < ArraySize(UsedSymbols); i++)
     {
      //---
      if(!SymbolFind(Prefix+UsedSymbols[i]+Suffix, true))
        {
         //---
         if(LastReason == 0)
           {
            //---
            string message = "All 28 currency pairs are not available !\nPerhaps the Prefix and/or Suffix were not set correctly.";
            //---
            MessageBox(message, MB_CAPTION, MB_OK|MB_ICONERROR);
           }
         //---
         ObjectsDeleteAll(0, OBJPREFIX, -1, -1);
         break;
         return(INIT_FAILED);
        }
     }

   for(int i = 0; i < ArraySize(aSymbols); i++)
     {
      s_ma_handle[i] = iMA(Prefix+aSymbols[i]+Suffix, MA1_tf, MA1_per, 0, MA1_method, MA1_price);
      if(s_ma_handle[i] < 0)
        {
         Print("The iMA object is not created: Error", GetLastError());
         return(-1);
        }
      //---
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
      //---
      st_handle[i] = iCustom(Prefix+aSymbols[i]+Suffix, st_tf, "supertrend", st_per, st_mult, false);
      if(st_handle[i] < 0)
        {
         Print("The iCustom::Supertrend object is not created: Error", GetLastError());
         return(-1);
        }
      //---
      storsi_handle[i] = iRSI(Prefix+aSymbols[i]+Suffix, storsi_tf, int((storsi1_per+storsi2_per)/2), PRICE_CLOSE);
      if(storsi_handle[i] < 0)
        {
         Print("The iCustom::irsi object is not created: Error", GetLastError());
         return(-1);
        }
      //---
      sto_handle[i] = iStochastic(Prefix+aSymbols[i]+Suffix, sto_tf, sto_kper, sto_dper, sto_sper, MODE_SMA, STO_LOWHIGH);
      if(sto_handle[i] < 0)
        {
         Print("The iStochastic object is not created: Error", GetLastError());
         return(-1);
        }
      //---
      mac_handle[i] = iMACD(Prefix+aSymbols[i]+Suffix, mac_tf, mac_fper, mac_sper, mac_smper, PRICE_CLOSE);
      if(mac_handle[i] < 0)
        {
         Print("The iMACD object is not created: Error", GetLastError());
         return(-1);
        }
      //---
      adx_handle[i] = iADX(Prefix+aSymbols[i]+Suffix, adx_tf, adx_per);
      if(adx_handle[i] < 0)
        {
         Print("The iADX object is not created: Error", GetLastError());
         return(-1);
        }
      //---
      atr_handle[i] = iADX(Prefix+aSymbols[i]+Suffix, atr_tf, atr_per);
      if(atr_handle[i] < 0)
        {
         Print("The iATR object is not created: Error", GetLastError());
         return(-1);
        }
      //---
      rsi_handle[i] = iRSI(Prefix+aSymbols[i]+Suffix, rsi_tf, rsi_per, PRICE_CLOSE);
      if(rsi_handle[i] < 0)
        {
         Print("The iRSI object is not created: Error", GetLastError());
         return(-1);
        }
      //---
      bb_handle[i] = iBands(Prefix+aSymbols[i]+Suffix, bb_tf, BB_per, 0, BB_dev, PRICE_CLOSE);
      if(bb_handle[i] < 0)
        {
         Print("The iBands object is not created: Error", GetLastError());
         return(-1);
        }
      //---
      bbw_handle[i] = iCustom(Prefix+aSymbols[i]+Suffix, bbw_tf, "bbandwidth", BB_per, 0, BB_dev);
      if(bbw_handle[i] < 0)
        {
         Print("The Custom::iBands object is not created: Error", GetLastError());
         return(-1);
        }
      //---
      Ichi_handle[i] = iIchimoku(Prefix+aSymbols[i]+Suffix, Ichi_tf, tekan, kijun, senkou);
      if(Ichi_handle[i] < 0)
        {
         Print("The iIchimoku object is not created: Error", GetLastError());
         return(-1);
        }
      //---
      sar_handle[i] = iSAR(Prefix+aSymbols[i]+Suffix, sar_tf, sar_step, sar_max);
      if(sar_handle[i] < 0)
        {
         Print("The iSAR object is not created: Error", GetLastError());
         return(-1);
        }
      string sym = Prefix+aSymbols[i]+Suffix;
      trades[i] = new CExecute(sym, magic_Number);
      BuyPositions[i] = new CPosition(sym, magic_Number, GROUP_POSITIONS_BUYS);
      SellPositions[i] = new CPosition(sym, magic_Number, GROUP_POSITIONS_SELLS);
      Positions[i] = new CPosition(sym, magic_Number, GROUP_POSITIONS_ALL);
      tools[i] = new CUtilities(sym);
      sellPartial[i]=0;
      buyPartial[i]=0;
     }

//--- CheckData
   if(TerminalInfoInteger(TERMINAL_CONNECTED) && (LastReason == 0 || LastReason == REASON_PARAMETERS))
     {
      //---
      ResetLastError();
      //---
      for(int i = 0; i < ArraySize(UsedSymbols); i++)
        {
         //---
         double test = iHigh(Prefix+UsedSymbols[i]+Suffix, PERIOD_CURRENT, 0);
         //---
         if(test == 0)
           {
            //---
            for(int a = 0; a < 10; a++)
              {
               //---
               Comment("Loading Data...");
               Sleep(1);
               //---
               double _High = iHigh(Prefix+UsedSymbols[i]+Suffix, PERIOD_CURRENT, 0);
               double _Low = iLow(Prefix+UsedSymbols[i]+Suffix, PERIOD_CURRENT, 0);
               double _Close = iClose(Prefix+UsedSymbols[i]+Suffix, PERIOD_CURRENT, 0);
               //---
               double _Bid = SymbolInfoDouble(Prefix+UsedSymbols[i]+Suffix, SYMBOL_BID);
               double _Ask = SymbolInfoDouble(Prefix+UsedSymbols[i]+Suffix, SYMBOL_ASK);
               //---
               if(_High != 0 && _Low != 0 && _Close != 0 && _Bid != 0 && _Ask != 0)
                  break;
              }
           }
        }
      //---
      Comment("");
     }

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
//---

  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//----

   if(ArraySize(aSymbols) > ArraySize(UsedSymbols))
     {
      //---
      for(int i = 0; i < ArraySize(aSymbols); i++)
         SpeedOmeter(Prefix+aSymbols[i]+Suffix);
     }
   else
     {
      //---
      for(int i = 0; i < ArraySize(UsedSymbols); i++)
         SpeedOmeter(Prefix+UsedSymbols[i]+Suffix);
     }


//---
   if(ShowTradePanel)
     {
      //---
      ObjectsCreateAll();
      //---
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
   int fr_y2 = Dpi(100);
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
   int x = (Dpi(10));
   int y = (20);
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
   LabelCreate(0, OBJPREFIX+"1MA", 0, _x1+Dpi(100), _y1+Dpi(30), CORNER_LEFT_UPPER, "1 MA", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
   LabelCreate(0, OBJPREFIX+"2MA", 0, _x1+Dpi(150), _y1+Dpi(30), CORNER_LEFT_UPPER, "2 MA", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
   LabelCreate(0, OBJPREFIX+"sto-rsi", 0, _x1+Dpi(200), _y1+Dpi(30), CORNER_LEFT_UPPER, "STO-RSI", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
   LabelCreate(0, OBJPREFIX+"sto", 0, _x1+Dpi(300), _y1+Dpi(30), CORNER_LEFT_UPPER, "STO", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
   LabelCreate(0, OBJPREFIX+"macd", 0, _x1+Dpi(350), _y1+Dpi(30), CORNER_LEFT_UPPER, "MACD", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
   LabelCreate(0, OBJPREFIX+"adx", 0, _x1+Dpi(400), _y1+Dpi(30), CORNER_LEFT_UPPER, "ADX", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
   LabelCreate(0, OBJPREFIX+"atr", 0, _x1+Dpi(450), _y1+Dpi(30), CORNER_LEFT_UPPER, "ATR", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
   LabelCreate(0, OBJPREFIX+"rsi", 0, _x1+Dpi(500), _y1+Dpi(30), CORNER_LEFT_UPPER, "RSI", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
   LabelCreate(0, OBJPREFIX+"bb", 0, _x1+Dpi(550), _y1+Dpi(30), CORNER_LEFT_UPPER, "BB", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
   LabelCreate(0, OBJPREFIX+"ichi", 0, _x1+Dpi(600), _y1+Dpi(30), CORNER_LEFT_UPPER, "ICHI", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
   LabelCreate(0, OBJPREFIX+"str", 0, _x1+Dpi(650), _y1+Dpi(30), CORNER_LEFT_UPPER, "STR", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
   LabelCreate(0, OBJPREFIX+"sar", 0, _x1+Dpi(700), _y1+Dpi(30), CORNER_LEFT_UPPER, "SAR", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
   LabelCreate(0, OBJPREFIX+"avg", 0, _x1+Dpi(770), _y1+Dpi(30), CORNER_LEFT_UPPER, "AVG", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
   LabelCreate(0, OBJPREFIX+"trade-pair", 0, _x1+Dpi(820), _y1+Dpi(30), CORNER_LEFT_UPPER, "Tradable", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
   LabelCreate(0, OBJPREFIX+"sl", 0, _x1+Dpi(920), _y1+Dpi(30), CORNER_LEFT_UPPER, "SL", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");
   LabelCreate(0, OBJPREFIX+"tp", 0, _x1+Dpi(980), _y1+Dpi(30), CORNER_LEFT_UPPER, "TP", "Arial Black", 10, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, "\n");

//--- SymbolsGUI
   int fr_y = _y1+Dpi(60);

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
   color startcolor = FirstRun?clrNONE: COLOR_FONT;
   double countb = 0,
          counts = 0,
          countf = 0;

//---
   LabelCreate(0, OBJPREFIX+_Symb, 0, _x1+Dpi(10), Y, CORNER_LEFT_UPPER, StringSubstr(_Symb, StringLen(Prefix), 6)+":", sFontType, FONTSIZE, COLOR_FONT, 0, ANCHOR_LEFT, false, false, true, 0, _Symb);
//---
//--
   if(sig_SingleMA(i) == 1)
     {
      if(useSingleMA)
         countb++;
      ObjectDelete(0, OBJPREFIX+"1MA"+" - "+_Symb);
      LabelCreate(0, OBJPREFIX+"1MA"+" - "+_Symb, 0, _x1+Dpi(125), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

     }
   else
      if(sig_SingleMA(i) == -1)
        {
         if(useSingleMA)
            counts++;
         ObjectDelete(0, OBJPREFIX+"1MA"+" - "+_Symb);
         LabelCreate(0, OBJPREFIX+"1MA"+" - "+_Symb, 0, _x1+Dpi(125), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

        }
      else
        {
         if(useSingleMA)
            countf++;
         ObjectDelete(0, OBJPREFIX+"1MA"+" - "+_Symb);

         LabelCreate(0, OBJPREFIX+"1MA"+" - "+_Symb, 0, _x1+Dpi(125), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);

        }
//--
   if(sig_DoubleMA(i) == 1)
     {
      if(useDoubleMA)
         countb++;
      ObjectDelete(0, OBJPREFIX+"2MA"+" - "+_Symb);
      LabelCreate(0, OBJPREFIX+"2MA"+" - "+_Symb, 0, _x1+Dpi(175), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

     }
   else
      if(sig_DoubleMA(i) == -1)
        {
         if(useDoubleMA)
            counts++;
         ObjectDelete(0, OBJPREFIX+"2MA"+" - "+_Symb);
         LabelCreate(0, OBJPREFIX+"2MA"+" - "+_Symb, 0, _x1+Dpi(175), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

        }
      else
        {
         if(useDoubleMA)
            countf++;
         ObjectDelete(0, OBJPREFIX+"2MA"+" - "+_Symb);
         LabelCreate(0, OBJPREFIX+"2MA"+" - "+_Symb, 0, _x1+Dpi(175), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);

        }

//--
   if(sig_STORSI(i) == 1)
     {
      if(useStoRSI)
         countb++;
      LabelCreate(0, OBJPREFIX+"sto-rsi"+" - "+_Symb, 0, _x1+Dpi(240), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

     }
   else
      if(sig_STORSI(i) == -1)
        {
         if(useStoRSI)
            counts++;
         LabelCreate(0, OBJPREFIX+"sto-rsi"+" - "+_Symb, 0, _x1+Dpi(240), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

        }
      else
        {
         if(useStoRSI)
            countf++;
         LabelCreate(0, OBJPREFIX+"sto-rsi"+" - "+_Symb, 0, _x1+Dpi(240), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);

        }


//--
   if(sig_STO(i) == 1)
     {
      if(useSto)
         countb++;
      LabelCreate(0, OBJPREFIX+"sto"+" - "+_Symb, 0, _x1+Dpi(325), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

     }
   else
      if(sig_STO(i) == -1)
        {
         if(useSto)
            counts++;
         LabelCreate(0, OBJPREFIX+"sto"+" - "+_Symb, 0, _x1+Dpi(325), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

        }
      else
        {
         if(useSto)
            countf++;
         LabelCreate(0, OBJPREFIX+"sto"+" - "+_Symb, 0, _x1+Dpi(325), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);

        }


//--
   if(sig_MACD(i) == 1)
     {
      if(useMacd)
         countb++;
      LabelCreate(0, OBJPREFIX+"macd"+" - "+_Symb, 0, _x1+Dpi(375), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

     }
   else
      if(sig_MACD(i) == -1)
        {
         if(useMacd)
            counts++;
         LabelCreate(0, OBJPREFIX+"macd"+" - "+_Symb, 0, _x1+Dpi(375), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

        }
      else
        {
         if(useMacd)
            countf++;
         LabelCreate(0, OBJPREFIX+"macd"+" - "+_Symb, 0, _x1+Dpi(375), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);

        }

//--
   if(sig_ADX(i) == 1)
     {
      if(useAdx)
         countb++;
      LabelCreate(0, OBJPREFIX+"adx"+" - "+_Symb, 0, _x1+Dpi(425), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

     }
   else
      if(sig_ADX(i) == -1)
        {
         if(useAdx)
            counts++;
         LabelCreate(0, OBJPREFIX+"adx"+" - "+_Symb, 0, _x1+Dpi(425), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

        }
      else
        {
         if(useAdx)
            countf++;
         LabelCreate(0, OBJPREFIX+"adx"+" - "+_Symb, 0, _x1+Dpi(425), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);

        }

//--
   if(sig_ATR(i) == 1)
     {
      if(useAtr)
         countb++;
      LabelCreate(0, OBJPREFIX+"atr"+" - "+_Symb, 0, _x1+Dpi(475), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

     }
   else
      if(sig_ATR(i) == -1)
        {
         if(useAtr)
            counts++;
         LabelCreate(0, OBJPREFIX+"atr"+" - "+_Symb, 0, _x1+Dpi(475), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

        }
      else
        {
         if(useAtr)
            countf++;
         LabelCreate(0, OBJPREFIX+"atr"+" - "+_Symb, 0, _x1+Dpi(475), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);

        }

//--
   if(sig_RSI(i) == 1)
     {
      if(useRSI)
         countb++;
      LabelCreate(0, OBJPREFIX+"rsi"+" - "+_Symb, 0, _x1+Dpi(525), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Rsi Buy "+_Symb);

     }
   else
      if(sig_RSI(i) == -1)
        {
         if(useRSI)
            counts++;
         LabelCreate(0, OBJPREFIX+"rsi"+" - "+_Symb, 0, _x1+Dpi(525), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

        }
      else
        {
         if(useRSI)
            countf++;
         LabelCreate(0, OBJPREFIX+"rsi"+" - "+_Symb, 0, _x1+Dpi(525), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);

        }

//--
   if(sig_BB(i) == 1)
     {
      if(useBB)
         countb++;
      LabelCreate(0, OBJPREFIX+"bb"+" - "+_Symb, 0, _x1+Dpi(575), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

     }
   else
      if(sig_BB(i) == -1)
        {
         if(useBB)
            counts++;
         LabelCreate(0, OBJPREFIX+"bb"+" - "+_Symb, 0, _x1+Dpi(575), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

        }
      else
        {
         if(useBB)
            countf++;
         LabelCreate(0, OBJPREFIX+"bb"+" - "+_Symb, 0, _x1+Dpi(575), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);

        }
//--
   if(sig_BBw(i) == 1)
     {
      if(useBBw)
         countb++;

     }
   else
      if(sig_BBw(i) == -1)
        {
         if(useBBw)
            counts++;

        }
      else
        {
         if(useBBw)
            countf++;

        }

//--
   if(sig_ICHI(i) == 1)
     {
      if(useIchi)
         countb++;
      LabelCreate(0, OBJPREFIX+"ichi"+" - "+_Symb, 0, _x1+Dpi(625), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

     }
   else
      if(sig_ICHI(i) == -1)
        {
         if(useIchi)
            counts++;
         LabelCreate(0, OBJPREFIX+"ichi"+" - "+_Symb, 0, _x1+Dpi(625), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

        }
      else
        {
         if(useIchi)
            countf++;
         LabelCreate(0, OBJPREFIX+"ichi"+" - "+_Symb, 0, _x1+Dpi(625), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);

        }
//--
   if(sig_Supertrend(i) == 1)
     {
      if(useSuperTrend)
         countb++;
      LabelCreate(0, OBJPREFIX+"str"+" - "+_Symb, 0, _x1+Dpi(675), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

     }
   else
      if(sig_Supertrend(i) == -1)
        {
         if(useSuperTrend)
            counts++;
         LabelCreate(0, OBJPREFIX+"str"+" - "+_Symb, 0, _x1+Dpi(675), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

        }
      else
        {
         if(useSuperTrend)
            countf++;
         LabelCreate(0, OBJPREFIX+"str"+" - "+_Symb, 0, _x1+Dpi(675), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);
        }

//--
   if(sig_SAR(i) == 1)
     {
      if(useSAR)
         countb++;
      LabelCreate(0, OBJPREFIX+"sar"+" - "+_Symb, 0, _x1+Dpi(725), Y, CORNER_LEFT_UPPER, "5", "Webdings", 15, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, "Buy "+_Symb);

     }
   else
      if(sig_SAR(i) == -1)
        {
         if(useSAR)
            counts++;
         LabelCreate(0, OBJPREFIX+"sar"+" - "+_Symb, 0, _x1+Dpi(725), Y, CORNER_LEFT_UPPER, "6", "Webdings", 15, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "Sell "+_Symb);

        }
      else
        {
         if(useSAR)
            countf++;
         LabelCreate(0, OBJPREFIX+"sar"+" - "+_Symb, 0, _x1+Dpi(725), Y, CORNER_LEFT_UPPER, "4", "Webdings", 15, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "No Signal "+_Symb);
        }

   double perc_b = (countb/(countb+countf+counts))*100;
   double perc_s = (counts/(countb+countf+counts))*100;
//--
   if(perc_b > perc_s)
     {
      LabelCreate(0, OBJPREFIX+"avg"+" - "+_Symb, 0, _x1+Dpi(800), Y, CORNER_LEFT_UPPER, DoubleToString(perc_b, 2)+"%", sFontType, 9, clrLimeGreen, 0, ANCHOR_RIGHT, false, false, true, 0, _Symb+" avg : "+DoubleToString(perc_b, 2)+"%");

     }
   else
      if(perc_b < perc_s)
        {
         LabelCreate(0, OBJPREFIX+"avg"+" - "+_Symb, 0, _x1+Dpi(800), Y, CORNER_LEFT_UPPER, DoubleToString(perc_s, 2)+"%", sFontType, 9, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, _Symb+" avg : "+DoubleToString(perc_s, 2)+"%");
        }
      else
        {
         LabelCreate(0, OBJPREFIX+"avg"+" - "+_Symb, 0, _x1+Dpi(800), Y, CORNER_LEFT_UPPER, "______", sFontType, 9, clrYellow, 0, ANCHOR_RIGHT, false, false, true, 0, "\n");

        }
   bool buy = false;
   bool sell = false;
   bool close = false;
   if(perc_b == 100)
     {
      buy = true;
      ButtonCreate(0, OBJPREFIX+"trade"+" - "+_Symb, 0, _x1+Dpi(880), Y-Dpi(6), Dpi(77), Dpi(15), CORNER_LEFT_UPPER, _Symb, sFontType, 8, C'59, 41, 40', clrLimeGreen, C'144, 176, 239', false, false, false, true, 1, "Buy "+_Symb);

     }
   else
      if(perc_s == 100)
        {
         sell = true;
         ButtonCreate(0, OBJPREFIX+"trade"+" - "+_Symb, 0, _x1+Dpi(880), Y-Dpi(6), Dpi(77), Dpi(15), CORNER_LEFT_UPPER, _Symb, sFontType, 10, C'59, 41, 40', clrRed, C'239, 112, 112', false, false, false, true, 1, "Sell "+_Symb);
        }
      else
         if(perc_b > perc_s && perc_b < level_To_Close)
           {
            close = true;
            if(closeWithPercentage)
               Positions[i].GroupCloseAll(30);
            ObjectDelete(0, OBJPREFIX+"trade"+" - "+_Symb);

           }
         else
            if(perc_b < perc_s && perc_s < level_To_Close)
              {
               close = true;
               if(closeWithPercentage)
                  Positions[i].GroupCloseAll(30);
               ObjectDelete(0, OBJPREFIX+"trade"+" - "+_Symb);

              }
            else
              {
               ObjectDelete(0, OBJPREFIX+"trade"+" - "+_Symb);
              }
   CalcLot(i);

   if(buy)
     {
      double temp[],
             temp1[];
      ArraySetAsSeries(temp, true);
      if(CopyBuffer(sar_handle[i], 0, 0, 10, temp) <= 0)
         return;
      ArraySetAsSeries(temp1, true);
      if(CopyBuffer(st_handle[i], 2, 0, 10, temp1) <= 0)
         return;
      double sl = 0;
      if(sltype == 0)
         sl = tools[i].Ask()-STOPLOSS*tools[i].Pip();
      if(sltype == 1)
         sl = temp[0];
      if(sltype == 2)
         sl = temp1[0];
      double tp = tools[i].Bid()+TAKEPROFIT*tools[i].Pip();
      double slpip = tools[i].Bid()-sl;
      if(tpType == RISK_REWARD)
        {
         tp = tools[i].Bid()+TAKEPROFIT*slpip;
        }

      if(trade_type == AUTO_TRADE)
        {
         if((TRADE_ON == CURRENT_ONLY && _Symb == Symbol()) || (TRADE_ON == MULTIPLE_PAIRS))
           {
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
                        if(tp1 > 0)
                          {
                           if(tpType == RISK_REWARD)
                             {
                              tp = tools[i].Bid()+tp1*slpip;
                             }
                           trades[i].Position(TYPE_POSITION_BUY, Lot, sl, tp, SLTP_PRICE, 30, comment);
                          }
                        if(tp2 > 0)
                          {
                           if(tpType == RISK_REWARD)
                             {
                              tp = tools[i].Bid()+tp2*slpip;
                             }
                           trades[i].Position(TYPE_POSITION_BUY, Lot, sl, tp, SLTP_PRICE, 30, comment);
                          }
                        if(tp3 > 0)
                          {
                           if(tpType == RISK_REWARD)
                             {
                              tp = tools[i].Bid()+tp3*slpip;
                             }
                           trades[i].Position(TYPE_POSITION_BUY, Lot, sl, tp, SLTP_PRICE, 30, comment);
                          }
                        if(tp4 > 0)
                          {
                           if(tpType == RISK_REWARD)
                             {
                              tp = tools[i].Bid()+tp4*slpip;
                             }
                           trades[i].Position(TYPE_POSITION_BUY, Lot, sl, tp, SLTP_PRICE, 30, comment);
                          }
                        if(tp5 > 0)
                          {
                           if(tpType == RISK_REWARD)
                             {
                              tp = tools[i].Bid()+tp5*slpip;
                             }
                           trades[i].Position(TYPE_POSITION_BUY, Lot, sl, tp, SLTP_PRICE, 30, comment);
                          }

                       }
                 }
              }
           }
        }
      LabelCreate(0, OBJPREFIX+"sl"+" - "+_Symb, 0, _x1+Dpi(940), Y, CORNER_LEFT_UPPER, DoubleToString(sl, (int)SymbolInfoInteger(_Symb, SYMBOL_DIGITS)), sFontType, 9, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "\n");
      LabelCreate(0, OBJPREFIX+"tp"+" - "+_Symb, 0, _x1+Dpi(1000), Y, CORNER_LEFT_UPPER, DoubleToString(tp, (int)SymbolInfoInteger(_Symb, SYMBOL_DIGITS)), sFontType, 9, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "\n");

      signal[i] = true;
      cc0 = _Symb+" BUY SL "+DoubleToString(sl, (int)SymbolInfoInteger(_Symb, SYMBOL_DIGITS));
     }
   if(sell)
     {
      double temp[],
             temp1[];
      ArraySetAsSeries(temp, true);
      if(CopyBuffer(sar_handle[i], 0, 0, 10, temp) <= 0)
         return;
      ArraySetAsSeries(temp1, true);
      if(CopyBuffer(st_handle[i], 2, 0, 10, temp1) <= 0)
         return;
      double sl = 0;
      if(sltype == 0)
         sl = tools[i].Bid()+STOPLOSS*tools[i].Pip();
      if(sltype == 1)
         sl = temp[0];
      if(sltype == 2)
         sl = temp1[0];
      double tp = tools[i].Bid()-TAKEPROFIT*tools[i].Pip();
      double slpip = sl-tools[i].Bid();
      if(tpType == RISK_REWARD)
        {
         tp = tools[i].Bid()-TAKEPROFIT*slpip;
        }

      if(trade_type == AUTO_TRADE)
        {
         if((TRADE_ON == CURRENT_ONLY && _Symb == Symbol()) || (TRADE_ON == MULTIPLE_PAIRS))
           {
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
                        if(tp1 > 0)
                          {
                           if(tpType == RISK_REWARD)
                             {
                              tp = tools[i].Bid()-tp1*slpip;
                             }
                           trades[i].Position(TYPE_POSITION_SELL, Lot, sl, tp, SLTP_PRICE, 30, comment);
                          }
                        if(tp2 > 0)
                          {
                           if(tpType == RISK_REWARD)
                             {
                              tp = tools[i].Bid()-tp2*slpip;
                             }
                           trades[i].Position(TYPE_POSITION_SELL, Lot, sl, tp, SLTP_PRICE, 30, comment);
                          }
                        if(tp3 > 0)
                          {
                           if(tpType == RISK_REWARD)
                             {
                              tp = tools[i].Bid()-tp3*slpip;
                             }
                           trades[i].Position(TYPE_POSITION_SELL, Lot, sl, tp, SLTP_PRICE, 30, comment);
                          }
                        if(tp4 > 0)
                          {
                           if(tpType == RISK_REWARD)
                             {
                              tp = tools[i].Bid()-tp4*slpip;
                             }
                           trades[i].Position(TYPE_POSITION_SELL, Lot, sl, tp, SLTP_PRICE, 30, comment);
                          }
                        if(tp5 > 0)
                          {
                           if(tpType == RISK_REWARD)
                             {
                              tp = tools[i].Bid()-tp5*slpip;
                             }
                           trades[i].Position(TYPE_POSITION_SELL, Lot, sl, tp, SLTP_PRICE, 30, comment);
                          }

                       }
                 }
              }
           }
        }
      cc0 = _Symb+" SELL SL "+DoubleToString(sl, (int)SymbolInfoInteger(_Symb, SYMBOL_DIGITS));
      LabelCreate(0, OBJPREFIX+"sl"+" - "+_Symb, 0, _x1+Dpi(940), Y, CORNER_LEFT_UPPER, DoubleToString(sl, (int)SymbolInfoInteger(_Symb, SYMBOL_DIGITS)), sFontType, 9, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "\n");
      LabelCreate(0, OBJPREFIX+"tp"+" - "+_Symb, 0, _x1+Dpi(1000), Y, CORNER_LEFT_UPPER, DoubleToString(tp, (int)SymbolInfoInteger(_Symb, SYMBOL_DIGITS)), sFontType, 9, clrRed, 0, ANCHOR_RIGHT, false, false, true, 0, "\n");

      signal[i] = true;
     }
//---
   if(close)
     {
      cc0 = " Close "+_Symb;
      ObjectDelete(0, OBJPREFIX+"sl"+" - "+_Symb);
      signal[i] = false;
     }
//---
   if(useTel && cc0 != "" && time0[i] != iTime(_Symbol, PERIOD_CURRENT, 0))
     {
      time0[i] = iTime(_Symbol, PERIOD_CURRENT, 0);

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
         "www.YousufMesalm.com"
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
//| Symbols                                                          |
//+------------------------------------------------------------------+
string Symbols[] =
  {
//---
   "AUDCAD",
   "AUDCHF",
   "AUDJPY",
   "AUDNZD",
   "AUDUSD",
//---
   "CADCHF",
   "CADJPY",
   "CHFJPY",
//---
   "EURAUD",
   "EURCAD",
   "EURCHF",
   "EURGBP",
   "EURJPY",
   "EURNZD",
   "EURUSD",
//---
   "GBPAUD",
   "GBPCAD",
   "GBPCHF",
   "GBPNZD",
   "GBPUSD",
   "GBPJPY",
//---
   "NZDCHF",
   "NZDCAD",
   "NZDJPY",
   "NZDUSD",
//---
   "USDCAD",
   "USDCHF",
   "USDJPY"
  };
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| SetFull                                                          |
//+------------------------------------------------------------------+
void SetFull()
  {
//---
   ArrayResize(UsedSymbols, 28, 0);
//---
   UsedSymbols[0] = "AUDCAD";
   UsedSymbols[1] = "AUDCHF";
   UsedSymbols[2] = "AUDJPY";
   UsedSymbols[3] = "AUDNZD";
   UsedSymbols[4] = "AUDUSD";
//---
   UsedSymbols[5] = "CADCHF";
   UsedSymbols[6] = "CADJPY";
   UsedSymbols[7] = "CHFJPY";
//---
   UsedSymbols[8] = "EURAUD";
   UsedSymbols[9] = "EURCAD";
   UsedSymbols[10] = "EURCHF";
   UsedSymbols[11] = "EURGBP";
   UsedSymbols[12] = "EURJPY";
   UsedSymbols[13] = "EURNZD";
   UsedSymbols[14] = "EURUSD";
//---
   UsedSymbols[15] = "GBPAUD";
   UsedSymbols[16] = "GBPCAD";
   UsedSymbols[17] = "GBPCHF";
//---
   UsedSymbols[18] = "GBPNZD";
   UsedSymbols[19] = "GBPUSD";
   UsedSymbols[20] = "GBPJPY";
//---
   UsedSymbols[21] = "NZDCHF";
   UsedSymbols[22] = "NZDCAD";
   UsedSymbols[23] = "NZDJPY";
   UsedSymbols[24] = "NZDUSD";
//---
   UsedSymbols[25] = "USDCAD";
   UsedSymbols[26] = "USDCHF";
   UsedSymbols[27] = "USDJPY";
//---
  }
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
   if(temp1[0] >= rsi_level && temp1[0] > temp1[1] && temp1[1] > temp1[2] && temp1[2] > temp1[3])
      res = 1;
   if(temp1[0] <= rsi_level && temp1[0] < temp1[1] && temp1[1] < temp1[2] && temp1[2] < temp1[3])
      res = -1;
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
   if(temp1[0] > macd_level && temp1[0] > temp1[1] && temp1[1] > temp1[2] && temp1[2] > temp1[3])
      res = 1;
   if(temp1[0] < macd_level && temp1[0] < temp1[1] && temp1[1] < temp1[2] && temp1[2] < temp1[3])
      res = -1;
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
   if(temp1[0] > temp2[0] && temp3[0] >= adx_lev && temp3[0] > temp3[1] && temp3[1] > temp3[2] && temp3[2] > temp3[3])
      res = 1;
   if(temp1[0] < temp2[0] && temp3[0] >= adx_lev && temp3[0] > temp3[1] && temp3[1] > temp3[2] && temp3[2] > temp3[3])
      res = -1;
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
   if(temp1[0] > temp1[1] && temp1[1] > temp1[2] && temp1[2] > temp1[3] && sig_Supertrend(index) == 1)
      res = 1;
   if(temp1[0] > temp1[1] && temp1[1] > temp1[2] && temp1[2] > temp1[3] && sig_Supertrend(index) == -1)
      res = -1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_BB(int index)
  {
   int res = 0;
   double temp1[];
   ArraySetAsSeries(temp1, true);
   if(CopyBuffer(bb_handle[index], 0, 0, 10, temp1) <= 0)
      return res;
   if(temp1[0] < iClose(Prefix+aSymbols[index]+Suffix, bb_tf, 0) && temp1[0] > temp1[1] && temp1[1] > temp1[2] && temp1[2] > temp1[3])
      res = 1;
   if(temp1[0] > iClose(Prefix+aSymbols[index]+Suffix, bb_tf, 0) && temp1[0] < temp1[1] && temp1[1] < temp1[2] && temp1[2] < temp1[3])
      res = -1;
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

   if(iClose(Prefix+aSymbols[index]+Suffix, Ichi_tf, 0) > MathMax(temp1[0], temp2[0]))
      return 1;
   if(iClose(Prefix+aSymbols[index]+Suffix, Ichi_tf, 0) < MathMin(temp1[0], temp2[0]))
      return -1;

   return res;
  }


//+------------------------------------------------------------------+
void CalcLot(int i)
  {

   if(LotType == RISK)
     {
      double sl = STOPLOSS;

      Lot = tools[i].NormalizeVolume((AccountInfoDouble(ACCOUNT_EQUITY)*Risk/1000)/sl);
      if(Lot < SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN))
         Lot = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN);
      if(Lot > SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MAX))
         Lot = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MAX);
     }
   else
      if(LotType == LOT_PER)
        {
         Lot = (AccountInfoDouble(ACCOUNT_BALANCE)/1000)*lot_Per;
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
               buyPos[x].ClosePartial(vol*(close_Precentage1/100),30);
               b++;
              }
           }
         if(close_level2>0&&close_Precentage2>0&&b==2)
           {
            double tp1x=openPrice+((close_level2/100)*(tpDistance));
            double vol=buyPos[x].GetVolume();
            if(tool.Bid()>=tp1x)
              {
               buyPos[x].ClosePartial(vol*(close_Precentage2/100),30);
               b++;
              }
           }
         if(close_level3>0&&close_Precentage3>0&&b==3)
           {
            double tp1x=openPrice+((close_level3/100)*(tpDistance));
            double vol=buyPos[x].GetVolume();
            if(tool.Bid()>=tp1x)
              {
               buyPos[x].ClosePartial(vol*(close_Precentage3/100),30);
               b++;
              }
           }
         if(close_level4>0&&close_Precentage4>0&&b==4)
           {
            double tp1x=openPrice+((close_level4/100)*(tpDistance));
            double vol=buyPos[x].GetVolume();
            if(tool.Bid()>=tp1x)
              {
               buyPos[x].ClosePartial(vol*(close_Precentage4/100),30);
               b++;
              }
           }
         if(close_level5>0&&close_Precentage5>0&&b==5)
           {
            double tp1x=openPrice+((close_level5/100)*(tpDistance));
            double vol=buyPos[x].GetVolume();
            if(tool.Bid()>=tp1x)
              {
               buyPos[x].ClosePartial(vol*(close_Precentage5/100),30);
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
            double tp1x=openPrice+((close_level1/100)*(tpDistance));
            double vol=sellPos[x].GetVolume();
            if(tool.Bid()>=tp1x)
              {
               sellPos[x].ClosePartial(vol*(close_Precentage1/100),30);
               s++;
              }
           }
         if(close_level2>0&&close_Precentage2>0&&s==2)
           {
            double tp1x=openPrice+((close_level2/100)*(tpDistance));
            double vol=sellPos[x].GetVolume();
            if(tool.Bid()>=tp1x)
              {
               sellPos[x].ClosePartial(vol*(close_Precentage2/100),30);
               s++;
              }
           }
         if(close_level3>0&&close_Precentage3>0&&s==3)
           {
            double tp1x=openPrice+((close_level3/100)*(tpDistance));
            double vol=sellPos[x].GetVolume();
            if(tool.Bid()>=tp1x)
              {
               sellPos[x].ClosePartial(vol*(close_Precentage3/100),30);
               s++;
              }
           }
         if(close_level4>0&&close_Precentage4>0&&s==4)
           {
            double tp1x=openPrice+((close_level4/100)*(tpDistance));
            double vol=sellPos[x].GetVolume();
            if(tool.Bid()>=tp1x)
              {
               sellPos[x].ClosePartial(vol*(close_Precentage4/100),30);
               s++;
              }
           }
         if(close_level5>0&&close_Precentage5>0&&s==5)
           {
            double tp1x=openPrice+((close_level5/100)*(tpDistance));
            double vol=sellPos[x].GetVolume();
            if(tool.Bid()>=tp1x)
              {
               sellPos[x].ClosePartial(vol*(close_Precentage5/100),30);
               s++;
              }
           }

        }

     }
  }
//+------------------------------------------------------------------+
