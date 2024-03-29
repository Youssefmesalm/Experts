//+------------------------------------------------------------------+
//|                                               Reversal Range.mq5 |
//+------------------------------------------------------------------+
#property copyright " Copyright 2020 Squeeze Bounce (R) by Funkie Ajayi"
#property link "www.squeezebounce.com/"
#property description "www.facebook.com/ebonyfunky"
#property description "www.squeezebounce.com/"
#property version   "1.00"


datetime expirytime = 0;//D'2022.01.30';
datetime starttime = 0;//D'2000.1.1';
int Demo_Account = 0;
int Real_Account = 0;

double Pivot;

#include<Trade\PositionInfo.mqh>
CPositionInfo  m_position;

#property indicator_chart_window
#property indicator_buffers 66+16
#property indicator_plots   63+5
//--- plot Semafor1Up
#property indicator_label1  "Semafor 1 Up"
#property indicator_type1   DRAW_ARROW
#property indicator_color1  clrLightGreen//clrChocolate
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- plot Semafor1Dn
#property indicator_label2  "Semafor 1 Dn"
#property indicator_type2   DRAW_ARROW
#property indicator_color2  clrLightGreen//clrChocolate
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1
//--- plot Semafor2Up
#property indicator_label3  "Semafor 2 Up"
#property indicator_type3   DRAW_ARROW
#property indicator_color3  clrPowderBlue//clrMediumVioletRed
#property indicator_style3  STYLE_SOLID
#property indicator_width3  2
//--- plot Semafor2Dn
#property indicator_label4  "Semafor 2 Dn"
#property indicator_type4   DRAW_ARROW
#property indicator_color4  clrPowderBlue//clrMediumVioletRed
#property indicator_style4  STYLE_SOLID
#property indicator_width4  2
//--- plot Semafor3Up
#property indicator_label5  "Semafor 3 Up"
#property indicator_type5   DRAW_ARROW
#property indicator_color5  clrYellow
#property indicator_style5  STYLE_SOLID
#property indicator_width5  3
//--- plot Semafor3Dn
#property indicator_label6  "Semafor 3 Dn"
#property indicator_type6   DRAW_ARROW
#property indicator_color6  clrYellow
#property indicator_style6  STYLE_SOLID
#property indicator_width6  3
//--- plot BandsCenter
#property indicator_label7  "Bands Center"
#property indicator_type7   DRAW_LINE
#property indicator_color7  clrIndigo
#property indicator_style7  STYLE_SOLID
#property indicator_width7  2
//--- plot BandsUpperLimit
#property indicator_label8  "Bands Upper Limit"
#property indicator_type8   DRAW_LINE
#property indicator_color8  clrIndigo
#property indicator_style8  STYLE_DOT
#property indicator_width8  1
//--- plot BandsLowerLimit
#property indicator_label9  "Bands Lower Limit"
#property indicator_type9   DRAW_LINE
#property indicator_color9  clrIndigo
#property indicator_style9  STYLE_DOT
#property indicator_width9  1
//--- plot BuyScalper2
#property indicator_label10  "BuyScalper2"
#property indicator_type10   DRAW_ARROW
#property indicator_color10  clrYellow
#property indicator_style10  STYLE_SOLID
#property indicator_width10  2
//--- plot SellScalper2
#property indicator_label11  "SellScalper2"
#property indicator_type11   DRAW_ARROW
#property indicator_color11  clrBlue
#property indicator_style11  STYLE_SOLID
#property indicator_width11  2
//--- plot BuyScalper1
#property indicator_label12  "BuyScalper1"
#property indicator_type12   DRAW_ARROW
#property indicator_color12  clrYellow
#property indicator_style12  STYLE_SOLID
#property indicator_width12  3
//--- plot SellScalper1
#property indicator_label13  "SellScalper1"
#property indicator_type13   DRAW_ARROW
#property indicator_color13  clrBlue
#property indicator_style13  STYLE_SOLID
#property indicator_width13  3

//--- plot MonthlyHigh
#property indicator_label14  "MonthlyHigh"
#property indicator_type14   DRAW_LINE
#property indicator_color14  clrDarkGreen
#property indicator_style14  STYLE_SOLID
#property indicator_width14  4
//--- plot MonthlyLow
#property indicator_label15  "MonthlyLow"
#property indicator_type15   DRAW_LINE
#property indicator_color15  C'255,94,122'
#property indicator_style15  STYLE_SOLID
#property indicator_width15  4
//--- plot WeeklyHigh
#property indicator_label16  "WeeklyHigh"
#property indicator_type16   DRAW_LINE
#property indicator_color16  clrLime
#property indicator_style16  STYLE_SOLID
#property indicator_width16  3
//--- plot WeeklyLow
#property indicator_label17  "WeeklyLow"
#property indicator_type17   DRAW_LINE
#property indicator_color17  clrPink
#property indicator_style17  STYLE_SOLID
#property indicator_width17  3
//--- plot DailyHigh
#property indicator_label18  "DailyHigh"
#property indicator_type18   DRAW_LINE
#property indicator_color18  clrPaleGreen
#property indicator_style18  STYLE_SOLID
#property indicator_width18  2
//--- plot DailyLow
#property indicator_label19  "DailyLow"
#property indicator_type19   DRAW_LINE
#property indicator_color19  clrLightPink
#property indicator_style19  STYLE_SOLID
#property indicator_width19  2

#property indicator_label20  "SuperTrend"
#property indicator_type20   DRAW_LINE
#property indicator_color20  clrSilver
#property indicator_style20  STYLE_DOT
#property indicator_width20  1

#property indicator_label21  "SuperTrend_Up"
#property indicator_type21   DRAW_LINE
#property indicator_color21  clrYellow
#property indicator_style21  STYLE_DOT
#property indicator_width21  4

#property indicator_label22  "SuperTrend_Down"
#property indicator_type22   DRAW_LINE
#property indicator_color22  clrRed
#property indicator_style22  STYLE_DOT
#property indicator_width22  4

#property indicator_label23  "BuyBlackDiamond"
#property indicator_type23   DRAW_ARROW
#property indicator_color23  clrYellow
#property indicator_style23  STYLE_SOLID
#property indicator_width23  4

#property indicator_label24  "SellBlackDiamond"
#property indicator_type24   DRAW_ARROW
#property indicator_color24  clrMidnightBlue
#property indicator_style24  STYLE_SOLID
#property indicator_width24  4

//--- plot MA1
#property indicator_label25  "MA1"
#property indicator_type25   DRAW_LINE
#property indicator_color25  clrAqua
#property indicator_style25  STYLE_SOLID
#property indicator_width25  2
//--- plot MA2
#property indicator_label26  "MA2"
#property indicator_type26   DRAW_NONE
#property indicator_color26  clrLime
#property indicator_style26  STYLE_SOLID
#property indicator_width26  2
//--- plot MA3
#property indicator_label27  "MA3"
#property indicator_type27   DRAW_LINE
#property indicator_color27  clrWhite
#property indicator_style27  STYLE_SOLID
#property indicator_width27  2
//--- plot DailyOpen
#property indicator_label28  "DailyOpen"
#property indicator_type28   DRAW_LINE
#property indicator_color28  clrBlack
#property indicator_style28  STYLE_SOLID
#property indicator_width28  4

#property indicator_label29  "BuyArlensDiamond"
#property indicator_type29   DRAW_ARROW
#property indicator_color29  clrYellow
#property indicator_style29  STYLE_SOLID
#property indicator_width29  3

#property indicator_label30  "SellArlensDiamond"
#property indicator_type30   DRAW_ARROW
#property indicator_color30  clrBlue
#property indicator_style30  STYLE_SOLID
#property indicator_width30  3

#property indicator_label31  "BuyGoldenCross"
#property indicator_type31   DRAW_ARROW
#property indicator_color31  clrYellow
#property indicator_style31  STYLE_SOLID
#property indicator_width31  4

#property indicator_label32  "SellGoldenCross"
#property indicator_type32   DRAW_ARROW
#property indicator_color32  clrBlue
#property indicator_style32  STYLE_SOLID
#property indicator_width32  4

//--- plot BuyScalper3
#property indicator_label33  "BuyScalper3"
#property indicator_type33   DRAW_ARROW
#property indicator_color33  clrYellow
#property indicator_style33  STYLE_SOLID
#property indicator_width33  2
//--- plot SellScalper3
#property indicator_label34  "SellScalper3"
#property indicator_type34   DRAW_ARROW
#property indicator_color34  clrBlue
#property indicator_style34  STYLE_SOLID
#property indicator_width34  2
//--- plot GoldenBuyDiamond
#property indicator_label35  "GoldenBuyDiamond"
#property indicator_type35   DRAW_ARROW
#property indicator_color35  clrYellow
#property indicator_style35  STYLE_SOLID
#property indicator_width35  2
//--- plot GoldenSellDiamond
#property indicator_label36  "GoldenSellDiamond"
#property indicator_type36   DRAW_ARROW
#property indicator_color36  clrBlue
#property indicator_style36  STYLE_SOLID
#property indicator_width36  2
//--- plot BuySAPE
#property indicator_label37  "BuySAPE"
#property indicator_type37   DRAW_ARROW
#property indicator_color37  clrYellow
#property indicator_style37  STYLE_SOLID
#property indicator_width37  2
//--- plot SellSAPE
#property indicator_label38  "SellSAPE"
#property indicator_type38   DRAW_ARROW
#property indicator_color38  clrBlue
#property indicator_style38  STYLE_SOLID
#property indicator_width38  2
//--- plot GoldenBuyTrend
#property indicator_label39  "GoldenBuyTrend"
#property indicator_type39   DRAW_ARROW
#property indicator_color39  clrYellow
#property indicator_style39  STYLE_SOLID
#property indicator_width39  2
//--- plot GoldenSellTrend
#property indicator_label40  "GoldenSellTrend"
#property indicator_type40   DRAW_ARROW
#property indicator_color40  clrBlue
#property indicator_style40  STYLE_SOLID
#property indicator_width40  2
//--- plot GoldenBuyArrow
#property indicator_label41  "GoldenBuyArrow"
#property indicator_type41   DRAW_ARROW
#property indicator_color41  clrYellow
#property indicator_style41  STYLE_SOLID
#property indicator_width41  2
//--- plot GoldenSellArrow
#property indicator_label42  "GoldenSellArrow"
#property indicator_type42   DRAW_ARROW
#property indicator_color42  clrBlue
#property indicator_style42  STYLE_SOLID
#property indicator_width42  2
//--- plot PremiumBuy
#property indicator_label43  "PremiumBuy"
#property indicator_type43   DRAW_ARROW
#property indicator_color43  clrYellow
#property indicator_style43  STYLE_SOLID
#property indicator_width43  2
//--- plot PremiumSell
#property indicator_label44  "PremiumSell"
#property indicator_type44   DRAW_ARROW
#property indicator_color44  clrBlue
#property indicator_style44  STYLE_SOLID
#property indicator_width44  2
//--- plot Semafor2Buy
#property indicator_label45  "Semafor2Buy"
#property indicator_type45   DRAW_ARROW
#property indicator_color45  clrYellow
#property indicator_style45  STYLE_SOLID
#property indicator_width45  2
//--- plot Semafor2Sell
#property indicator_label46  "Semafor2Sell"
#property indicator_type46   DRAW_ARROW
#property indicator_color46  clrBlue
#property indicator_style46  STYLE_SOLID
#property indicator_width46  2
//--- plot BuyReversal
#property indicator_label47  "BuyReversal"
#property indicator_type47   DRAW_ARROW
#property indicator_color47  clrYellow
#property indicator_style47  STYLE_SOLID
#property indicator_width47  2
//--- plot SellReversal

#property indicator_label48  "SellReversal"
#property indicator_type48   DRAW_ARROW
#property indicator_color48  clrBlue
#property indicator_style48  STYLE_SOLID
#property indicator_width48  2
//--- plot BuySemafor3Alert
#property indicator_label49  "BuySemafor3Alert"
#property indicator_type49   DRAW_ARROW
#property indicator_color49  clrYellow
#property indicator_style49  STYLE_SOLID
#property indicator_width49  2
//--- plot SellSemafor3Alert
#property indicator_label50  "SellSemafor3Alert"
#property indicator_type50   DRAW_ARROW
#property indicator_color50  clrBlue
#property indicator_style50  STYLE_SOLID
#property indicator_width50  2
//--- plot BuyTrend
#property indicator_label51  "BuyTrend"
#property indicator_type51   DRAW_ARROW
#property indicator_color51  clrYellow
#property indicator_style51  STYLE_SOLID
#property indicator_width51  1
//--- plot SellTrend
#property indicator_label52  "SellTrend"
#property indicator_type52   DRAW_ARROW
#property indicator_color52  clrBlue
#property indicator_style52  STYLE_SOLID
#property indicator_width52  1
//--- plot BuyTrend1
#property indicator_label53  "BuyTrend1"
#property indicator_type53   DRAW_ARROW
#property indicator_color53  clrYellow
#property indicator_style53  STYLE_SOLID
#property indicator_width53  2
//--- plot SellTrend1
#property indicator_label54  "SellTrend1"
#property indicator_type54   DRAW_ARROW
#property indicator_color54  clrBlue
#property indicator_style54  STYLE_SOLID
#property indicator_width54  2

//--- plot BuyHull
#property indicator_label55  "BuyHull"
#property indicator_type55   DRAW_ARROW
#property indicator_color55  clrYellow
#property indicator_style55  STYLE_SOLID
#property indicator_width55  2
//--- plot SellHull
#property indicator_label56  "SellHull"
#property indicator_type56   DRAW_ARROW
#property indicator_color56  clrBlue
#property indicator_style56  STYLE_SOLID
#property indicator_width56  2


//--- plot HA
#property indicator_label57  "DRAW_HA_CANDLES"
#property indicator_type57   DRAW_COLOR_CANDLES
#property indicator_color57 clrDarkGreen, clrRed
#property indicator_style57  STYLE_SOLID
#property indicator_width57  1

//-------------------- Hull trend indicator -----------

#property indicator_label58  "Hull trend bars"
#property indicator_type58   DRAW_NONE
#property indicator_color58  clrDarkGray,clrDeepSkyBlue,clrSandyBrown
#property indicator_label59  "Hull trend candles"
#property indicator_type59   DRAW_NONE
#property indicator_color59  clrDarkGray,clrDeepSkyBlue,clrSandyBrown
#property indicator_label60  "Hull trend line"
#property indicator_type60   DRAW_NONE
#property indicator_color60  clrDarkGray,clrDeepSkyBlue,clrSandyBrown
#property indicator_width60  2

#property indicator_label61  "BuyArrow"
#property indicator_type61   DRAW_NONE
#property indicator_color61  clrYellow
#property indicator_style61  STYLE_SOLID
#property indicator_width61  2
//--- plot SellArrow

//--- plot MACross
#property indicator_label62  "CrossUp"
#property indicator_type62   DRAW_ARROW
#property indicator_color62  clrGreen
#property indicator_style62  STYLE_SOLID
#property indicator_width62  2

#property indicator_label63  "CrossDown"
#property indicator_type63  DRAW_ARROW
#property indicator_color63  clrRed
#property indicator_style63  STYLE_SOLID
#property indicator_width63 2


//--- plot MACross
#property indicator_label64  "diamondUp"
#property indicator_type64 DRAW_ARROW
#property indicator_color64  clrGreen
#property indicator_style64  STYLE_SOLID
#property indicator_width64 2

#property indicator_label65  "diamondDown"
#property indicator_type65   DRAW_ARROW
#property indicator_color65  clrRed
#property indicator_style65  STYLE_SOLID
#property indicator_width65 2

//--- plot BuyArrow





//--- input parameters
input bool  Show_All_Bars = false;
input int   CalculatedBars = 5000;
/*input */string Semafor_Setting = "===============================";
input bool DisplaySemaforPeaks = true;
/*input */double Period1 = 5;
/*input */double Period2 = 13;
/*input */double Period3 = 34;
/*input */string   Dev_Step_1 = "1,3";
/*input */string   Dev_Step_2 = "8,5";
/*input */string   Dev_Step_3 = "13,8";
/*input */int Symbol_1_Kod = 140;
/*input */int Symbol_2_Kod = 141;
/*input */int Symbol_3_Kod = 142;
/*input */string Trend_MAs_Setting = "===============================";
/*input */int                  Fast_MA_Period = 50;
/*input */ENUM_MA_METHOD       Fast_MA_Mode = MODE_EMA;
/*input */ENUM_APPLIED_PRICE   Fast_MA_Price = PRICE_CLOSE;
/*input */int                  Fast_MA_Shift = 0;
/*input */int                  Slow_MA_Period = 100;
/*input */ENUM_MA_METHOD       Slow_MA_Mode = MODE_EMA;
/*input */ENUM_APPLIED_PRICE   Slow_MA_Price = PRICE_CLOSE;
/*input */int                  Slow_MA_Shift = 0;
/*input */string Bandss_Setting = "===============================";
/*input */int            MALength = 20;
/*input */double         BandWidth = 2.0;
/*input */int            ATRLength = 100;
/*input */string SupportAndResistance_Setting = "===============================";
input bool  Display_SupportAndResistance = true;
/*input */ int LB = 3;
/*input */ int maxBarsForPeriod = 1000;
/*input */ bool showM01 = false;
/*input */ bool showM05 = false;
/*input */ bool showM15 = false;
/*input */ bool showM30 = false;
/*input */ bool showH01 = true;
/*input */ bool showH04 = true;
/*input */ bool showD01 = true;
/*input */ bool showW01 = true;
/*input */ bool showMN1 = true;

/*input */string PairChangerList_Setting = "===============================";
//input bool  Display_PairChanger_List=false;
string  Symbols = "AUDUSD;EURUSD;GBPUSD;USDCAD;USDJPY;USDCHF;AUDCAD;AUDCHF;AUDJPY;AUDNZD;CADCHF;CADJPY;EURAUD;EURCAD;EURGBP;EURJPY;EURNZD;GBPAUD;GBPCADGBPJPY;GBPNZD;NZDCAD;NZDJPY;NZDUSD;XAUUSD"; // List of symbols (separated by ";")
/*input */ string  UniqueID = "Achooos Pair Changer";   // Indicator unique ID

/*input */ int     ButtonsInARow = 25;     // Buttons in a horizontal row
/*input */ int     Corner        = 2;      // Corner
/*input */ int     XShift        = 37;     // Horizontal shift
/*input */ int     YShift        = 20;     // Vertical shift
/*input */ int     XSize         = 40;     // Width of buttons
/*input */ int     YSize         = 14;     // Height of buttons
/*input */ int     FSize         = 6;      // Font size
/*input */ string  FontType = "Consolas"; // Font
/*input */ color   Bcolor = clrDarkGray;      // Button color
/*input */ color   Dcolor = clrBlack;      // Button border color
/*input */ color   Tncolor = clrBlue;     // Text color - normal
/*input */ color   Sncolor = clrRed;  // Text color - selected
/*input */ bool    Transparent = false;   // Transparent buttons?

/*input */string CurrencyStrength_Setting = "===============================";
//input bool Display_Currency_Strength=false;
/*input */bool CurrenciesWindowBelowTable = false;
/*input */bool ShowCurrencies = true;
/*input */bool ShowCurrenciesSorted = true;
/*input */bool ShowSymbolsSorted = true;
/*input */string SymbolPrefix = "";
/*input */string DontShowThisPairs = "";
/*input */color HandleBackGroundColor = LightSlateGray;
/*input */color DataTableBackGroundColor_1 = LightSteelBlue;
/*input */color DataTableBackGroundColor_2 = Lavender;
/*input */color CurrencysBackGroundColor = LightSlateGray;
/*input */color HandleTextColor = White;
/*input */color DataTableTextColor = Black;
/*input */color CurrencysTextColor = White;
/*input */color TrendUpArrowsColor = MediumBlue;
/*input */color TrendDownArrowsColor = Red;

bool  Display_ADR = false; // removed by MP
/*input */string Alert_Setting = "===============================";
enum Select {Yes = 1, No = -1};
input bool ShowBox = true;
input bool ShowMiddleBandCrossing = false;
input bool TrendBasedMiddleBandCrossing = false;
bool ShowArlensDiamonds = false;
enum Enum_DiamondsTimeframe
  {
   Diamonds_AllTimeframes, //All Timeframes
   Diamonds_M15andAbove //M15 and Above
  };
Enum_DiamondsTimeframe DiamondsTimeframe = Diamonds_AllTimeframes;
bool ShowDiamondAfterSemafor1 = true;
bool ShowDiamondAfterSemafor2 = true;

input bool ShowArrows = false;
input bool ShowGoldenCross = false;
input bool ShowScalper3 = false;
input bool TrendBasedScalper3 = false;
const bool ShowGoldenDiamond = false;
const bool ShowGoldenTrend = false;
const bool ShowGoldenArrow = false;
input bool ShowSAPE = true;
enum Enum_SAPE_Timeframe
  {
   SAPE_AllTimeframes, //All Timeframes
   SAPE_M5andAbove //M5 and Above
  };
input Enum_SAPE_Timeframe SAPE_Timeframe = SAPE_AllTimeframes;
input bool ShowSAPEAfterSemafor1 = false;
input bool ShowSAPEAfterSemafor2 = true;
bool ShowPremiumDiamond = false;
const bool ShowSemafor2Arrows = false;
bool ShowReversal = false;
bool TrendBased_Reversal = false;
enum Enum_Reversal_Timeframe
  {
   Reversal_AllTimeframes, //All Timeframes
   Reversal_M5andAbove //M5 and Above
  };
Enum_Reversal_Timeframe Reversal_Timeframe = Reversal_AllTimeframes;
bool ShowReversalAfterSemafor1 = false;
bool ShowReversalAfterSemafor2 = true;
input bool ShowSemafor3Alert = false;
input bool ShowBuySellTrend = false;
input bool ShowBuySellTrend1 = false;
input bool ShowTrend1AlertAfterSemafor1 = false;
input bool ShowTrend1AlertAfterSemafor2 = false;
input bool ShowBuySellHull = true;
input bool ShowHullAlertAfterSemafor2 = false;
input bool ShowHullAlertAfterSemafor3 = true;

//--- global variables
CCustomBot bot;
datetime time_signal = 0;
bool checked;


const string HullIndicatorName = "Hull trend";

enum enDisplayStyle
  {
   dis_automatic, // Automatic display style
   dis_line,      // Display line
   dis_bars,      // Display bars
   dis_candles    // Display candles
  };
int                inpPeriod       = 70;            // Hull period
ENUM_APPLIED_PRICE inpPrice        = PRICE_CLOSE;   // Price
enDisplayStyle     inpDisplayStyle = dis_automatic; // Display style
enum Enum_HullTimeframe
  {
   Hull_AllTimeframes, //All Timeframes
   Hull_M15andAbove //M15 and Above
  };
Enum_HullTimeframe HullTimeframe = Hull_AllTimeframes;

enum Enum_AlertType
  {
   AlertType_Both, //Both
   AlertType_Buy, //Buy
   AlertType_Sell //Sell
  };
input Enum_AlertType AlertType = AlertType_Both;
input bool                 Signal_Alert_Popup = false; //Signal Alert Popup Message
input bool                 Signal_Alert_Email = false; //Signal Alert to Email
input bool                 Signal_Alert_Push_Notification = true; //Signal Alert Push Notification
/*input */string HA_Setting = "===============================";
input bool  Display_HA = true;
//---
// ADR Inputs
int TimeZoneOfData = 0;
int TimeZoneOfSession = 0;
int Gi_84 = 0;
int Gi_88 = 24;
int G_timeframe_92 = PERIOD_D1;
int ATRPeriod = 14;
extern bool UseManualADR = false;
int ManualADRValuePips = 0;
int LineStyle = 2;
int LineThickness1 = 1;
color LineColor1 = Orange;
int LineThickness2 = 2;
color LineColor2 = Red;
bool Gi_128 = true;
int BarForLabels = -10;
bool DebugLogger = false;
datetime G_time_140 = 0;
int G_timeframe_144 = 0;
int Gi_148 = -1;
double Gd_152;
bool showtext = false;

//---
string sAlertMsg_Bounce;
int lastAlertBar_Bounce;
int crossed = -1;
bool diamond_buy = false;
bool diamond_sell = false;
string sAlertMsg_Squeeze;
int lastAlertBar_Squeeze;
double LastStopLoss;
double LastTakeProfit;
string LastSignalType;
double LastSignalEntry;
double LastSemaForHigh;
double LastSemaForLow;
//--- indicator buffers
double         Semafor1UpBuffer[];
double         Semafor1DnBuffer[];
double         Semafor2UpBuffer[];
double         Semafor2DnBuffer[];
double         Semafor3UpBuffer[];
double         Semafor3DnBuffer[];
double         BandsCenterBuffer[];
double         BandsUpperLimitBuffer[];
double         BandsLowerLimitBuffer[];
double         BuyScalper2Buffer[];
double         SellScalper2Buffer[];
double         BuyScalper1Buffer[];
double         SellScalper1Buffer[];
double         gadSignalLine[];
double         gadUpBuf[];
double         gadDnBuf[];

double         MonthlyHighBuffer[];
double         MonthlyLowBuffer[];
double         WeeklyHighBuffer[];
double         WeeklyLowBuffer[];
double         DailyHighBuffer[];
double         DailyLowBuffer[];

double         BuyBlackDiamond[];
double         SellBlackDiamond[];

double         MA1Buffer[];
double         MA2Buffer[];
double         MA3Buffer[];

double         DailyOpenBuffer[];
double BuyArlensDiamond[], SellArlensDiamond[];

double         BuyGoldenCross[];
double         SellGoldenCross[];

double         BuyScalper3Buffer[];
double         SellScalper3Buffer[];

double         GoldenBuyDiamond[];
double         GoldenSellDiamond[];

double         GoldenBuyTrend[];
double         GoldenSellTrend[];

double         GoldenBuyArrow[];
double         GoldenSellArrow[];

double         BuySAPE[];
double         SellSAPE[];

double         PremiumBuy[];
double         PremiumSell[];

double         Semafor2Buy[];
double         Semafor2Sell[];

double         BuyReversal[];
double         SellReversal[];

double         BuySemafor3Alert[];
double         SellSemafor3Alert[];

double         BuyTrend[];
double         SellTrend[];

double         BuyTrend1[];
double         SellTrend1[];

double         BuyHull[];
double         SellHull[];
double         CrossUp[];
double         CrossDown[];
double         diamondUp[];
double         diamondDown[];
double HALowHighBuffer[];
double HAHighLowBuffer[];
double HAOpenBuffer[];
double HACloseBuffer[];
double HAColorBuffer[];
//---
//Mo Glboal Variables start
string sym = Symbol();
int per = Period();
//Mo Glboal Variables end

//SemaFor Glboal Variables start
int F_Period;
int N_Period;
int H_Period;
int Dev1;
int Stp1;
int Dev2;
int Stp2;
int Dev3;
int Stp3;
//SemaFor Glboal Variables end
/* PairChanger List Global Variables */ string aSymbols[];

//Currency Strength Global Variables Start

int Gia_144[] = {255, 17919, 5275647, 65535, 3145645, 65280};
string Gs_148;
int Gia_156[10];
int Gia_unused_160[100];
string Gsa_unused_164[100];
int Gia_168[10];
int Gia_172[21] = {15, 23, 31, 35, 43, 47, 55, 67, 75, 83, 87, 91, 95, 99, 119, 123, 127, 143, 148, 156, 164};
int Gia_176[21] = {11, 17, 23, 26, 32, 35, 41, 50, 56, 62, 65, 68, 71, 74, 89, 92, 95, 107, 110, 116, 122};
int Gia_180[21] = {4, 5, 6, 7, 9, 10, 12, 15, 17, 19, 20, 21, 22, 23, 28, 29, 30, 34, 36, 38, 40};
int Gia_184[21] = {-3, -2, -1, -1, -2, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0};
string Gsa_188[8] = {"USD", "EUR", "GBP", "CHF", "JPY", "CAD", "AUD", "NZD"};
int Gia_192[8] = {9639167, 16711680, 16711680, 65535, 65535, 9639167, 16711680, 16711680};
string Gsa_196[28] =
  {
   "EURUSD", "GBPUSD", "AUDUSD", "USDJPY", "USDCHF", "USDCAD", "EURAUD", "EURCAD", "EURCHF", "EURGBP", "EURJPY", "GBPJPY", "GBPCHF", "NZDUSD", "AUDCAD", "AUDJPY", "CHFJPY",
   "AUDNZD", "NZDJPY", "NZDCAD", "NZDCHF", "GBPNZD", "EURNZD", "GBPCAD", "GBPAUD", "AUDCHF", "CADCHF", "CADJPY"
  };
string Gsa_unused_200[6][5];
string Gsa_204[28];
int Gia_208[6];
double Gda_212[28][3];
int G_color_216;
int G_color_220;
int G_color_224;
int G_color_228;
int G_color_232;
int G_color_236;
int G_color_240;
int G_color_244;
int G_color_248;
string Gs_252 = "";
bool Gi_260 = false;
int Gi_264;
int diamond_trend = 0;
//Currency Strength Global Variables End

#define OBJPROP_TIME1 300
#define OBJPROP_PRICE1 301
#define OBJPROP_TIME2 302
#define OBJPROP_PRICE2 303
#define OBJPROP_TIME3 304
#define OBJPROP_PRICE3 305
//---
#define OBJPROP_RAY 310
#define OBJPROP_FIBOLEVELS 200

#define OP_BUY 0           //Buy 
#define OP_SELL 1          //Sell 
#define OP_BUYLIMIT 2      //Pending order of BUY LIMIT type 
#define OP_SELLLIMIT 3     //Pending order of SELL LIMIT type 
#define OP_BUYSTOP 4       //Pending order of BUY STOP type 
#define OP_SELLSTOP 5      //Pending order of SELL STOP type 
//---
#define MODE_OPEN 0
#define MODE_CLOSE 3
#define MODE_VOLUME 4
#define MODE_REAL_VOLUME 5
#define MODE_TRADES 0
#define MODE_HISTORY 1
#define SELECT_BY_POS 0
#define SELECT_BY_TICKET 1
//---
#define DOUBLE_VALUE 0
#define FLOAT_VALUE 1
#define LONG_VALUE INT_VALUE
//---
#define CHART_BAR 0
#define CHART_CANDLE 1
//---
#define MODE_ASCEND 0
#define MODE_DESCEND 1
//---
#define MODE_LOW 1
#define MODE_HIGH 2
#define MODE_TIME 5
#define MODE_BID 9
#define MODE_ASK 10
#define MODE_POINT 11
#define MODE_DIGITS 12
#define MODE_SPREAD 13
#define MODE_STOPLEVEL 14
#define MODE_LOTSIZE 15
#define MODE_TICKVALUE 16
#define MODE_TICKSIZE 17
#define MODE_SWAPLONG 18
#define MODE_SWAPSHORT 19
#define MODE_STARTING 20
#define MODE_EXPIRATION 21
#define MODE_TRADEALLOWED 22
#define MODE_MINLOT 23
#define MODE_LOTSTEP 24
#define MODE_MAXLOT 25
#define MODE_SWAPTYPE 26
#define MODE_PROFITCALCMODE 27
#define MODE_MARGINCALCMODE 28
#define MODE_MARGININIT 29
#define MODE_MARGINMAINTENANCE 30
#define MODE_MARGINHEDGED 31
#define MODE_MARGINREQUIRED 32
#define MODE_FREEZELEVEL 33
//---
#define EMPTY -1


double Point = _Point;
int Bars = Bars(_Symbol, _Period);
int Digits = _Digits;
double Low[];
double High[];
double Close[];
double Open[];
datetime Time[];

int Filter, Entry, Semafor3 = 0, LastArrowBuffer = 0, Scalper3 = 0, Semafor12 = 0;
datetime Semafor3_Time = 0;
int    SignalLine_Period     = 10;  // SignalLine ATR Period
double SignalLine_Multiplier = 3.0; // SignalLine Multiplier
int Semafor3Appeared = 0, Semafor2Appeared = 0, Semafor3Appeared_SAPE = 0, Semafor3Appeared_Reversal = 0, GoldenDiamond_Trend = 0, GoldenArrow_Trend = 0, GoldenTrend_Trend = 0, PremiumDiamond_Trend = 0, lastAlertBar_Hull = 0;
datetime SAPE_SignalLineChangeTime = 0, SAPE_SemaforTime = 0;

int lastAlertBar_ArlensDiamond, lastAlertBar_Scalper1, lastAlertBar_Scalper2, lastAlertBar_BlackDiamond, lastAlertBar_GoldenCross, lastAlertBar_Scalper3, lastAlertBar_GoldenDiamond, lastAlertBar_GoldenTrend, lastAlertBar_GoldenArrow, lastAlertBar_SAPE, lastAlertBar_PremiumDiamond, lastAlertBar_Semafor2Arrow, lastAlertBar_Reversal, lastAlertBar_Semafor3Alert, lastAlertBar_Trend, lastAlertBar_Trend1;
string sAlertMsg;

//-------------------- Hull trend indicator -----------
double canh[], canl[], cano[], canc[], cancl[], baro[], barh[], barl[], barc[], barcl[], line[], linecl[], hull[], hullcl[];
datetime lastAlertTime;
double BuyArrow[], SellArrow[];

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
#define displayLine   0
#define displayBars   1
#define displayCandle 2
//-------------------- Hull trend indicator -----------

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
bool timer_initialised = false;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
   if((starttime > 0 && TimeCurrent() < starttime)
      || (expirytime > 0 && TimeCurrent() >= expirytime)
     )
     {
      Comment("Your copy for testing from " + TimeToString(starttime) + " to " +  TimeToString(expirytime) + " please contact support  ");
      Print("Your copy for testing from " + TimeToString(starttime) + " to " +  TimeToString(expirytime) + " please contact support   ");
      Alert("Your copy for testing from " + TimeToString(starttime) + " to " +  TimeToString(expirytime) + " please contact support");
      return(INIT_FAILED);
     }
   if((Demo_Account > 0 && AccountInfoInteger(ACCOUNT_LOGIN) != Demo_Account && AccountInfoInteger(ACCOUNT_TRADE_MODE) == ACCOUNT_TRADE_MODE_DEMO)
      || (Real_Account > 0 && AccountInfoInteger(ACCOUNT_LOGIN) != Real_Account && AccountInfoInteger(ACCOUNT_TRADE_MODE) != ACCOUNT_TRADE_MODE_DEMO)
     )
     {
      Comment("Invalid Account Number  please contact support  ");
      Print("Invalid Account Number  please contact support  ");
      Alert("Invalid Account Number  please contact support  ");
      return(INIT_FAILED);
     }
   timer_initialised = false;
//---
//Load bars
   if(!Display_HA)
     {
      //Chart Auto Layout
      ChartSetInteger(0, CHART_MODE, CHART_CANDLES);
      ChartSetInteger(0, CHART_COLOR_BACKGROUND, clrGray);
      ChartSetInteger(0, CHART_COLOR_FOREGROUND, clrBlack);
      ChartSetInteger(0, CHART_COLOR_GRID, clrYellow);
      ChartSetInteger(0, CHART_COLOR_CHART_UP, clrBlack);
      ChartSetInteger(0, CHART_COLOR_CHART_DOWN, clrBlack);
      ChartSetInteger(0, CHART_COLOR_CANDLE_BULL, clrDarkGreen);
      ChartSetInteger(0, CHART_COLOR_CANDLE_BEAR, clrRed);
      ChartSetInteger(0, CHART_COLOR_CHART_LINE, clrBlack);
      ChartSetInteger(0, CHART_COLOR_VOLUME, clrLimeGreen);
      ChartSetInteger(0, CHART_COLOR_ASK, clrYellow);
      ChartSetInteger(0, CHART_COLOR_STOP_LEVEL, clrRed);
      //---
      ChartSetInteger(0, CHART_FOREGROUND, false);
      ChartSetInteger(0, CHART_SHIFT, true);
      ChartSetInteger(0, CHART_SHOW_OBJECT_DESCR, true);
      //ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,true);
      ChartSetInteger(0, CHART_SHOW_GRID, false);
     }
   else
     {
      //Chart Auto Layout
      ChartSetInteger(0, CHART_MODE, CHART_CANDLES);
      ChartSetInteger(0, CHART_COLOR_BACKGROUND, clrGray);
      ChartSetInteger(0, CHART_COLOR_FOREGROUND, clrBlack);
      ChartSetInteger(0, CHART_COLOR_GRID, clrYellow);
      ChartSetInteger(0, CHART_COLOR_CHART_UP, clrBlack);
      ChartSetInteger(0, CHART_COLOR_CHART_DOWN, clrBlack);
      ChartSetInteger(0, CHART_COLOR_CANDLE_BULL, clrDarkGreen);
      ChartSetInteger(0, CHART_COLOR_CANDLE_BEAR, clrRed);
      ChartSetInteger(0, CHART_COLOR_CHART_LINE, clrBlack);
      ChartSetInteger(0, CHART_COLOR_VOLUME, clrLimeGreen);
      ChartSetInteger(0, CHART_COLOR_ASK, clrYellow);
      ChartSetInteger(0, CHART_COLOR_STOP_LEVEL, clrRed);
      //---
      ChartSetInteger(0, CHART_FOREGROUND, false);
      ChartSetInteger(0, CHART_SHIFT, true);
      ChartSetInteger(0, CHART_SHOW_OBJECT_DESCR, true);
      //ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,true);
      ChartSetInteger(0, CHART_SHOW_GRID, false);
      ChartSetInteger(0, CHART_MODE, CHART_LINE);
      ChartSetInteger(0, CHART_COLOR_CHART_LINE, clrNONE);
     }
//--- indicator buffers mapping
//Semafor OnInt Start
   if(Period1 > 0)
      F_Period = MathCeil(Period1 * Period());
   else
      F_Period = 0;
   if(Period2 > 0)
      N_Period = MathCeil(Period2 * Period());
   else
      N_Period = 0;
   if(Period3 > 0)
      H_Period = MathCeil(Period3 * Period());
   else
      H_Period = 0;
   SetIndexBuffer(0, Semafor1UpBuffer, INDICATOR_DATA);
   PlotIndexSetDouble(0, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(1, Semafor1DnBuffer, INDICATOR_DATA);
   PlotIndexSetDouble(1, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(2, Semafor2UpBuffer, INDICATOR_DATA);
   PlotIndexSetDouble(2, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(3, Semafor2DnBuffer, INDICATOR_DATA);
   PlotIndexSetDouble(3, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(4, Semafor3UpBuffer, INDICATOR_DATA);
   PlotIndexSetDouble(4, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(5, Semafor3DnBuffer, INDICATOR_DATA);
   PlotIndexSetDouble(5, PLOT_EMPTY_VALUE, 0);
   ArraySetAsSeries(Semafor1UpBuffer, true);
   ArraySetAsSeries(Semafor1DnBuffer, true);
   ArraySetAsSeries(Semafor2UpBuffer, true);
   ArraySetAsSeries(Semafor2DnBuffer, true);
   ArraySetAsSeries(Semafor3UpBuffer, true);
   ArraySetAsSeries(Semafor3DnBuffer, true);
   if(Period1 > 0)
     {
      //SetIndexArrow(0,Symbol_1_Kod);
      PlotIndexSetInteger(0, PLOT_ARROW, Symbol_1_Kod);
      //SetIndexArrow(1,Symbol_1_Kod);
      PlotIndexSetInteger(1, PLOT_ARROW, Symbol_1_Kod);
     }
   if(Period2 > 0)
     {
      //SetIndexArrow(2,Symbol_2_Kod);
      PlotIndexSetInteger(2, PLOT_ARROW, Symbol_2_Kod);
      //SetIndexArrow(3,Symbol_2_Kod);
      PlotIndexSetInteger(3, PLOT_ARROW, Symbol_2_Kod);
     }
   if(Period3 > 0)
     {
      //SetIndexArrow(4,Symbol_3_Kod);
      PlotIndexSetInteger(4, PLOT_ARROW, Symbol_3_Kod);
      //SetIndexArrow(5,Symbol_3_Kod);
      PlotIndexSetInteger(5, PLOT_ARROW, Symbol_3_Kod);
     }
   int CDev = 0;
   int CSt = 0;
   int Mass[];
   int C = 0;
   if(IntFromStr(Dev_Step_1, C, Mass) == 1)
     {
      Stp1 = Mass[1];
      Dev1 = Mass[0];
     }
   if(IntFromStr(Dev_Step_2, C, Mass) == 1)
     {
      Stp2 = Mass[1];
      Dev2 = Mass[0];
     }
   if(IntFromStr(Dev_Step_3, C, Mass) == 1)
     {
      Stp3 = Mass[1];
      Dev3 = Mass[0];
     }
   if(!DisplaySemaforPeaks)
     {
      SetIndexStyleMQL4(0, DRAW_NONE);
      SetIndexStyleMQL4(1, DRAW_NONE);
      SetIndexStyleMQL4(2, DRAW_NONE);
      SetIndexStyleMQL4(3, DRAW_NONE);
      SetIndexStyleMQL4(4, DRAW_NONE);
      SetIndexStyleMQL4(5, DRAW_NONE);
     }
//Semafor OnInt End
//---
   SetIndexBuffer(6, BandsCenterBuffer, INDICATOR_DATA);
   PlotIndexSetDouble(6, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(7, BandsUpperLimitBuffer, INDICATOR_DATA);
   PlotIndexSetDouble(7, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(8, BandsLowerLimitBuffer, INDICATOR_DATA);
   PlotIndexSetDouble(8, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(9, BuyScalper2Buffer, INDICATOR_DATA);
   PlotIndexSetDouble(9, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(10, SellScalper2Buffer, INDICATOR_DATA);
   PlotIndexSetDouble(10, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(11, BuyScalper1Buffer, INDICATOR_DATA);
   PlotIndexSetDouble(11, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(12, SellScalper1Buffer, INDICATOR_DATA);
   PlotIndexSetDouble(12, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(13, MonthlyHighBuffer, INDICATOR_DATA);
   PlotIndexSetDouble(13, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(14, MonthlyLowBuffer, INDICATOR_DATA);
   PlotIndexSetDouble(14, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(15, WeeklyHighBuffer, INDICATOR_DATA);
   PlotIndexSetDouble(15, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(16, WeeklyLowBuffer, INDICATOR_DATA);
   PlotIndexSetDouble(16, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(17, DailyHighBuffer, INDICATOR_DATA);
   PlotIndexSetDouble(17, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(18, DailyLowBuffer, INDICATOR_DATA);
   PlotIndexSetDouble(18, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(19, gadSignalLine, INDICATOR_DATA);
   PlotIndexSetDouble(19, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(20, gadUpBuf, INDICATOR_DATA);
   PlotIndexSetDouble(20, PLOT_EMPTY_VALUE, EMPTY_VALUE);
   SetIndexBuffer(21, gadDnBuf, INDICATOR_DATA);
   PlotIndexSetDouble(21, PLOT_EMPTY_VALUE, EMPTY_VALUE);
   SetIndexBuffer(22, BuyBlackDiamond, INDICATOR_DATA);
   PlotIndexSetDouble(22, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(23, SellBlackDiamond, INDICATOR_DATA);
   PlotIndexSetDouble(23, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(24, MA1Buffer);
   PlotIndexSetDouble(24, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(25, MA2Buffer);
   PlotIndexSetDouble(25, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(26, MA3Buffer);
   PlotIndexSetDouble(26, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(27, DailyOpenBuffer, INDICATOR_DATA);
   PlotIndexSetDouble(27, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(28, BuyArlensDiamond, INDICATOR_DATA);
   PlotIndexSetDouble(28, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(29, SellArlensDiamond, INDICATOR_DATA);
   PlotIndexSetDouble(29, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(30, BuyGoldenCross, INDICATOR_DATA);
   PlotIndexSetDouble(30, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(31, SellGoldenCross, INDICATOR_DATA);
   PlotIndexSetDouble(31, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(32, BuyScalper3Buffer, INDICATOR_DATA);
   PlotIndexSetDouble(32, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(33, SellScalper3Buffer, INDICATOR_DATA);
   PlotIndexSetDouble(33, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(34, GoldenBuyDiamond, INDICATOR_DATA);
   PlotIndexSetDouble(34, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(35, GoldenSellDiamond, INDICATOR_DATA);
   PlotIndexSetDouble(35, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(36, BuySAPE, INDICATOR_DATA);
   PlotIndexSetDouble(36, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(37, SellSAPE, INDICATOR_DATA);
   PlotIndexSetDouble(37, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(38, GoldenBuyTrend, INDICATOR_DATA);
   PlotIndexSetDouble(38, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(39, GoldenSellTrend, INDICATOR_DATA);
   PlotIndexSetDouble(39, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(40, GoldenBuyArrow, INDICATOR_DATA);
   PlotIndexSetDouble(40, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(41, GoldenSellArrow, INDICATOR_DATA);
   PlotIndexSetDouble(41, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(42, PremiumBuy, INDICATOR_DATA);
   PlotIndexSetDouble(42, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(43, PremiumSell, INDICATOR_DATA);
   PlotIndexSetDouble(43, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(44, Semafor2Buy, INDICATOR_DATA);
   PlotIndexSetDouble(44, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(45, Semafor2Sell, INDICATOR_DATA);
   PlotIndexSetDouble(45, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(46, BuyReversal, INDICATOR_DATA);
   PlotIndexSetDouble(46, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(47, SellReversal, INDICATOR_DATA);
   PlotIndexSetDouble(47, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(48, BuySemafor3Alert, INDICATOR_DATA);
   PlotIndexSetDouble(48, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(49, SellSemafor3Alert, INDICATOR_DATA);
   PlotIndexSetDouble(49, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(50, BuyTrend, INDICATOR_DATA);
   PlotIndexSetDouble(50, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(51, SellTrend, INDICATOR_DATA);
   PlotIndexSetDouble(51, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(52, BuyTrend1, INDICATOR_DATA);
   PlotIndexSetDouble(52, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(53, SellTrend1, INDICATOR_DATA);
   PlotIndexSetDouble(53, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(54, BuyHull, INDICATOR_DATA);
   PlotIndexSetDouble(54, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(55, SellHull, INDICATOR_DATA);
   PlotIndexSetDouble(55, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(56, HAOpenBuffer, INDICATOR_DATA);
   SetIndexBuffer(57, HAHighLowBuffer, INDICATOR_DATA);
   SetIndexBuffer(58, HALowHighBuffer, INDICATOR_DATA);
   SetIndexBuffer(59, HACloseBuffer, INDICATOR_DATA);
   SetIndexBuffer(60, HAColorBuffer, INDICATOR_DATA);
   SetIndexBuffer(61, CrossUp, INDICATOR_DATA);
   PlotIndexSetDouble(61, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(62, CrossDown, INDICATOR_DATA);
   PlotIndexSetDouble(62, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(63, diamondUp, INDICATOR_DATA);
   PlotIndexSetDouble(63, PLOT_EMPTY_VALUE, 0);
   SetIndexBuffer(64, diamondDown, INDICATOR_DATA);
   PlotIndexSetDouble(64, PLOT_EMPTY_VALUE, 0);
   if(!Display_HA)
     {
      PlotIndexSetInteger(56, PLOT_DRAW_TYPE, DRAW_NONE);
      PlotIndexSetInteger(57, PLOT_DRAW_TYPE, DRAW_NONE);
      PlotIndexSetInteger(58, PLOT_DRAW_TYPE, DRAW_NONE);
      PlotIndexSetInteger(59, PLOT_DRAW_TYPE, DRAW_NONE);
      PlotIndexSetInteger(60, PLOT_DRAW_TYPE, DRAW_NONE);
     }
   ArraySetAsSeries(BandsCenterBuffer, true);
   ArraySetAsSeries(BandsUpperLimitBuffer, true);
   ArraySetAsSeries(BandsLowerLimitBuffer, true);
   ArraySetAsSeries(BuyScalper2Buffer, true);
   ArraySetAsSeries(SellScalper2Buffer, true);
   ArraySetAsSeries(BuyScalper1Buffer, true);
   ArraySetAsSeries(SellScalper1Buffer, true);
   ArraySetAsSeries(MonthlyHighBuffer, true);
   ArraySetAsSeries(MonthlyLowBuffer, true);
   ArraySetAsSeries(WeeklyHighBuffer, true);
   ArraySetAsSeries(WeeklyLowBuffer, true);
   ArraySetAsSeries(DailyHighBuffer, true);
   ArraySetAsSeries(DailyLowBuffer, true);
   ArraySetAsSeries(gadSignalLine, true);
   ArraySetAsSeries(gadUpBuf, true);
   ArraySetAsSeries(gadDnBuf, true);
   ArraySetAsSeries(BuyBlackDiamond, true);
   ArraySetAsSeries(SellBlackDiamond, true);
   ArraySetAsSeries(MA1Buffer, true);
   ArraySetAsSeries(MA2Buffer, true);
   ArraySetAsSeries(MA3Buffer, true);
   ArraySetAsSeries(DailyOpenBuffer, true);
   ArraySetAsSeries(BuyArlensDiamond, true);
   ArraySetAsSeries(SellArlensDiamond, true);
   ArraySetAsSeries(BuyGoldenCross, true);
   ArraySetAsSeries(SellGoldenCross, true);
   ArraySetAsSeries(BuyScalper3Buffer, true);
   ArraySetAsSeries(SellScalper3Buffer, true);
   ArraySetAsSeries(GoldenBuyDiamond, true);
   ArraySetAsSeries(GoldenSellDiamond, true);
   ArraySetAsSeries(GoldenBuyTrend, true);
   ArraySetAsSeries(GoldenSellTrend, true);
   ArraySetAsSeries(GoldenBuyArrow, true);
   ArraySetAsSeries(GoldenSellArrow, true);
   ArraySetAsSeries(BuySAPE, true);
   ArraySetAsSeries(SellSAPE, true);
   ArraySetAsSeries(PremiumBuy, true);
   ArraySetAsSeries(PremiumSell, true);
   ArraySetAsSeries(Semafor2Buy, true);
   ArraySetAsSeries(Semafor2Sell, true);
   ArraySetAsSeries(BuyReversal, true);
   ArraySetAsSeries(SellReversal, true);
   ArraySetAsSeries(BuySemafor3Alert, true);
   ArraySetAsSeries(SellSemafor3Alert, true);
   ArraySetAsSeries(BuyTrend, true);
   ArraySetAsSeries(SellTrend, true);
   ArraySetAsSeries(BuyTrend1, true);
   ArraySetAsSeries(SellTrend1, true);
   ArraySetAsSeries(BuyHull, true);
   ArraySetAsSeries(SellHull, true);
   ArraySetAsSeries(HALowHighBuffer, true);
   ArraySetAsSeries(HAHighLowBuffer, true);
   ArraySetAsSeries(HAOpenBuffer, true);
   ArraySetAsSeries(HACloseBuffer, true);
   ArraySetAsSeries(HAColorBuffer, true);
   ArraySetAsSeries(CrossDown, true);
   ArraySetAsSeries(CrossUp, true);
   ArraySetAsSeries(diamondUp, true);
   ArraySetAsSeries(diamondDown, true);
//--- setting a code from the Wingdings charset as the property of PLOT_ARROW
//SetIndexArrow(11,174);
   PlotIndexSetInteger(9, PLOT_ARROW, 233);
//SetIndexArrow(12,174);
   PlotIndexSetInteger(10, PLOT_ARROW, 234);
//SetIndexArrow(13,164);
   PlotIndexSetInteger(11, PLOT_ARROW, 110);
//SetIndexArrow(14,164);
   PlotIndexSetInteger(12, PLOT_ARROW, 110);
   PlotIndexSetInteger(22, PLOT_ARROW, 116);
   PlotIndexSetInteger(23, PLOT_ARROW, 116);
   PlotIndexSetInteger(28, PLOT_ARROW, 116);
   PlotIndexSetInteger(29, PLOT_ARROW, 116);
   PlotIndexSetInteger(30, PLOT_ARROW, 233);
   PlotIndexSetInteger(31, PLOT_ARROW, 234);
   PlotIndexSetInteger(32, PLOT_ARROW, 233);
   PlotIndexSetInteger(33, PLOT_ARROW, 234);
   PlotIndexSetInteger(34, PLOT_ARROW, 116);
   PlotIndexSetInteger(35, PLOT_ARROW, 116);
   PlotIndexSetInteger(36, PLOT_ARROW, 116);
   PlotIndexSetInteger(37, PLOT_ARROW, 116);
   PlotIndexSetInteger(38, PLOT_ARROW, 116);
   PlotIndexSetInteger(39, PLOT_ARROW, 116);
   PlotIndexSetInteger(40, PLOT_ARROW, 116);
   PlotIndexSetInteger(41, PLOT_ARROW, 116);
   PlotIndexSetInteger(42, PLOT_ARROW, 116);
   PlotIndexSetInteger(43, PLOT_ARROW, 116);
   PlotIndexSetInteger(44, PLOT_ARROW, 116);
   PlotIndexSetInteger(45, PLOT_ARROW, 116);
   PlotIndexSetInteger(46, PLOT_ARROW, 116);
   PlotIndexSetInteger(47, PLOT_ARROW, 116);
   PlotIndexSetInteger(48, PLOT_ARROW, 116);
   PlotIndexSetInteger(49, PLOT_ARROW, 116);
   PlotIndexSetInteger(50, PLOT_ARROW, 233);
   PlotIndexSetInteger(51, PLOT_ARROW, 234);
   PlotIndexSetInteger(52, PLOT_ARROW, 116);
   PlotIndexSetInteger(53, PLOT_ARROW, 116);
   PlotIndexSetInteger(54, PLOT_ARROW, 233);
   PlotIndexSetInteger(55, PLOT_ARROW, 234);
   PlotIndexSetInteger(61, PLOT_ARROW, 233);
   PlotIndexSetInteger(62, PLOT_ARROW, 234);
   PlotIndexSetInteger(63, PLOT_ARROW, 116);
   PlotIndexSetInteger(64, PLOT_ARROW, 116);
   if(!(ShowBuySellHull && (HullTimeframe == Hull_AllTimeframes || _Period >= PERIOD_M15)))
     {
      PlotIndexSetInteger(54, PLOT_DRAW_TYPE, DRAW_NONE);
      PlotIndexSetInteger(55, PLOT_DRAW_TYPE, DRAW_NONE);
     }
//---
//Support & Resistance
   if(Display_SupportAndResistance)
      SupportAndResistanceOnInt();
// Pair List
// if(Display_PairChanger_List)PairChangerOnInt();
// if(Display_Currency_Strength)CurrencyStrengthOnint();
//---
//ADR Int
   Gd_152 = SetPoint();
   if(showtext)
     {
      Print("Period= ", Period());
      Print("Point= ", DoubleToString(Point, 5), " myPoint=", Gd_152);
     }
//---
//initialisation
   ArrayInitialize(Semafor1UpBuffer, 0);
   ArrayInitialize(Semafor1DnBuffer, 0);
   ArrayInitialize(Semafor2UpBuffer, 0);
   ArrayInitialize(Semafor2DnBuffer, 0);
   ArrayInitialize(Semafor3UpBuffer, 0);
   ArrayInitialize(Semafor3DnBuffer, 0);
   ArrayInitialize(BandsCenterBuffer, 0);
   ArrayInitialize(BandsUpperLimitBuffer, 0);
   ArrayInitialize(BandsLowerLimitBuffer, 0);
   ArrayInitialize(BuyScalper2Buffer, 0);
   ArrayInitialize(SellScalper2Buffer, 0);
   ArrayInitialize(BuyScalper1Buffer, 0);
   ArrayInitialize(SellScalper1Buffer, 0);
   ArrayInitialize(MonthlyHighBuffer, 0);
   ArrayInitialize(MonthlyLowBuffer, 0);
   ArrayInitialize(WeeklyHighBuffer, 0);
   ArrayInitialize(WeeklyLowBuffer, 0);
   ArrayInitialize(DailyHighBuffer, 0);
   ArrayInitialize(DailyLowBuffer, 0);
   ArrayInitialize(gadSignalLine, 0);
   ArrayInitialize(gadUpBuf, 0);
   ArrayInitialize(gadDnBuf, 0);
   ArrayInitialize(BuyBlackDiamond, 0);
   ArrayInitialize(SellBlackDiamond, 0);
   ArrayInitialize(MA1Buffer, 0);
   ArrayInitialize(MA2Buffer, 0);
   ArrayInitialize(MA3Buffer, 0);
   ArrayInitialize(DailyOpenBuffer, 0);
   ArrayInitialize(BuyArlensDiamond, 0);
   ArrayInitialize(SellArlensDiamond, 0);
   ArrayInitialize(BuyGoldenCross, 0);
   ArrayInitialize(SellGoldenCross, 0);
   ArrayInitialize(BuyScalper3Buffer, 0);
   ArrayInitialize(SellScalper3Buffer, 0);
   ArrayInitialize(GoldenBuyDiamond, 0);
   ArrayInitialize(GoldenSellDiamond, 0);
   ArrayInitialize(GoldenBuyArrow, 0);
   ArrayInitialize(GoldenSellArrow, 0);
   ArrayInitialize(GoldenBuyTrend, 0);
   ArrayInitialize(GoldenSellTrend, 0);
   ArrayInitialize(BuySAPE, 0);
   ArrayInitialize(SellSAPE, 0);
   ArrayInitialize(PremiumBuy, 0);
   ArrayInitialize(PremiumSell, 0);
   ArrayInitialize(Semafor2Buy, 0);
   ArrayInitialize(Semafor2Sell, 0);
   ArrayInitialize(BuyReversal, 0);
   ArrayInitialize(SellReversal, 0);
   ArrayInitialize(BuySemafor3Alert, 0);
   ArrayInitialize(SellSemafor3Alert, 0);
   ArrayInitialize(HALowHighBuffer, 0);
   ArrayInitialize(HAHighLowBuffer, 0);
   ArrayInitialize(HAOpenBuffer, 0);
   ArrayInitialize(HACloseBuffer, 0);
   ArrayInitialize(HAColorBuffer, 0);
   ArrayInitialize(CrossUp, 0);
   ArrayInitialize(CrossDown, 0);
   ArrayInitialize(diamondUp, 0);
   ArrayInitialize(diamondDown, 0);
   if(!CreateIndicatorsHandles())
      return(INIT_FAILED);
   int Ret;
   if((Ret = OnInit_HullTrend()) != INIT_SUCCEEDED)
      return(Ret);
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool timeron = true;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  OnDeinit(
   const int  reason         // deinitialization reason code
)
  {
   timeron = false;
   EventKillTimer();
   ObjectDelete(0, "Trading_Window_Background_1");
   ObjectsDeleteAllMQL4(0, OBJ_LABEL);
//Support & Resistance
   SupportResetanceDenit();
//PairChanger List
   ObjectsDeleteAllMQL4(0, OBJ_BUTTON);
//Currency Strngth
//CurrencyStrengthDeInt();
//Pivot
   ObjectDeleteMQL4("P line");
//----
//ADR Denit
   string name_0;
   int Li_8 = ObjectsTotalMQL4();
   for(int objs_total_12 = Li_8; objs_total_12 >= 0; objs_total_12--)
     {
      name_0 = ObjectNameMQL4(objs_total_12);
      if(StringFind(name_0, "[ADR]") >= 0)
         ObjectDeleteMQL4(name_0);
     }
   Comment("");
//---
//return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
   int val = OnCalculate_HullTrend(rates_total, prev_calculated, time, open, high, low, close, tick_volume, volume, spread);
   if(val != rates_total)
      return(val);
   ArrayInitialize(Semafor1UpBuffer, 0);
   ArrayInitialize(Semafor1DnBuffer, 0);
   ArrayInitialize(Semafor2UpBuffer, 0);
   ArrayInitialize(Semafor2DnBuffer, 0);
   ArrayInitialize(Semafor3UpBuffer, 0);
   ArrayInitialize(Semafor3DnBuffer, 0);
   ArrayInitialize(BandsCenterBuffer, 0);
   ArrayInitialize(BandsUpperLimitBuffer, 0);
   ArrayInitialize(BandsLowerLimitBuffer, 0);
   ArrayInitialize(BuyScalper2Buffer, 0);
   ArrayInitialize(SellScalper2Buffer, 0);
   ArrayInitialize(BuyScalper1Buffer, 0);
   ArrayInitialize(SellScalper1Buffer, 0);
   ArrayInitialize(MonthlyHighBuffer, 0);
   ArrayInitialize(MonthlyLowBuffer, 0);
   ArrayInitialize(WeeklyHighBuffer, 0);
   ArrayInitialize(WeeklyLowBuffer, 0);
   ArrayInitialize(DailyHighBuffer, 0);
   ArrayInitialize(DailyLowBuffer, 0);
   ArrayInitialize(gadSignalLine, 0);
   ArrayInitialize(gadUpBuf, 0);
   ArrayInitialize(gadDnBuf, 0);
   ArrayInitialize(BuyBlackDiamond, 0);
   ArrayInitialize(SellBlackDiamond, 0);
   ArrayInitialize(DailyOpenBuffer, 0);
   ArrayInitialize(BuyArlensDiamond, 0);
   ArrayInitialize(SellArlensDiamond, 0);
   ArrayInitialize(BuyGoldenCross, 0);
   ArrayInitialize(SellGoldenCross, 0);
   ArrayInitialize(BuyScalper3Buffer, 0);
   ArrayInitialize(SellScalper3Buffer, 0);
   ArrayInitialize(GoldenBuyDiamond, 0);
   ArrayInitialize(GoldenSellDiamond, 0);
   ArrayInitialize(GoldenBuyArrow, 0);
   ArrayInitialize(GoldenSellArrow, 0);
   ArrayInitialize(GoldenBuyTrend, 0);
   ArrayInitialize(GoldenSellTrend, 0);
   ArrayInitialize(BuySAPE, 0);
   ArrayInitialize(SellSAPE, 0);
   ArrayInitialize(PremiumBuy, 0);
   ArrayInitialize(PremiumSell, 0);
   ArrayInitialize(Semafor2Buy, 0);
   ArrayInitialize(Semafor2Sell, 0);
   ArrayInitialize(BuyReversal, 0);
   ArrayInitialize(SellReversal, 0);
   ArrayInitialize(BuySemafor3Alert, 0);
   ArrayInitialize(SellSemafor3Alert, 0);
   ArrayInitialize(BuyTrend, 0);
   ArrayInitialize(SellTrend, 0);
   ArrayInitialize(BuyTrend1, 0);
   ArrayInitialize(SellTrend1, 0);
   ArrayInitialize(BuyHull, 0);
   ArrayInitialize(SellHull, 0);
   ArrayInitialize(CrossUp, 0);
   ArrayInitialize(CrossDown, 0);
   ArrayInitialize(diamondUp, 0);
   ArrayInitialize(diamondDown, 0);
   if(stage == 1)
     {
      if(Period() != PERIOD_D1)
         ChartSetSymbolPeriod(0, _Symbol, PERIOD_D1);
      else
         ChartSetSymbolPeriod(0, _Symbol, PERIOD_H1);
      stage = 0;
      return 0;
     }
   ENUM_TIMEFRAMES p = GlobalVariableGet("squeeze_" + ChartID());
   if(p != 0)
     {
      GlobalVariableSet("squeeze_" + ChartID(), 0);
      ChartSetSymbolPeriod(0, _Symbol, p);
      return 0;
     }
   ArraySetAsSeries(High, true);
   CopyHigh(_Symbol, _Period, 0, BarLimit() + 1, High);
   ArraySetAsSeries(Low, true);
   CopyLow(_Symbol, _Period, 0, BarLimit() + 1, Low);
   ArraySetAsSeries(Close, true);
   CopyClose(_Symbol, _Period, 0, BarLimit() + 1, Close);
   ArraySetAsSeries(Open, true);
   CopyOpen(_Symbol, _Period, 0, BarLimit() + 1, Open);
   ArraySetAsSeries(Time, true);
   CopyTime(_Symbol, _Period, 0, Bars, Time);
   if(!timer_initialised)
     {
      EventSetTimer(1);
      timer_initialised = true;
     }
// Print("time size ",ArraySize(Time));
   if(ArraySize(Time) == 0)
      return prev_calculated;
   for(int i = BarLimit(); i >= 0; i--)
     {
      double haOpen = (HAOpenBuffer[i + 1] + HACloseBuffer[i + 1]) / 2;
      if(i == BarLimit())
        {
         haOpen = (Open[i] + High[i]) / 2;
        }
      double haClose = (Open[i] + High[i] + Low[i] + Close[i]) / 4;
      double haHigh = MathMax(High[i], MathMax(haOpen, haClose));
      double haLow = MathMin(Low[i], MathMin(haOpen, haClose));
      HAHighLowBuffer[i] = haHigh;
      HALowHighBuffer[i] = haLow;
      HAOpenBuffer[i] = haOpen;
      HACloseBuffer[i] = haClose;
      //--- set candle color
      if(haOpen < haClose)
         HAColorBuffer[i] = 0.0; // set color DodgerBlue
      else
         HAColorBuffer[i] = 1.0; // set color Red
     }
//---
//Semafor Highs & Lows
   if(Period1 > 0)
      CountZZ(Semafor1UpBuffer, Semafor1DnBuffer, Period1, Dev1, Stp1);
   if(Period2 > 0)
      CountZZ(Semafor2UpBuffer, Semafor2DnBuffer, Period2, Dev2, Stp2);
   if(Period3 > 0)
      CountZZ(Semafor3UpBuffer, Semafor3DnBuffer, Period3, Dev3, Stp3);
//---
//Support & Resistance
   if(Display_SupportAndResistance)
      SupportResetanceStart();
//Currency Strength
//  if(Display_Currency_Strength)CurrencyStrengthStart();
//Pivot
   PivotStart();
//int limit=Bars-Slow_MA_Period;
   int i = 0;
//Scan For LAst Semafor high or low
   for(int k = 0; k < BarLimit(); k++)
     {
      if(Semafor2UpBuffer[k] != 0 || Semafor3UpBuffer[k] != 0)
        {
         LastSemaForLow = L(k);
         break;
        }
     }
//---
   for(int x = 0; x < BarLimit(); x++)
     {
      if(Semafor2DnBuffer[x] != 0 || Semafor3DnBuffer[x] != 0)
        {
         LastSemaForHigh = H(x);
         break;
        }
     }
   for(i = BarLimit(); i >= 0; i--)
     {
      if
      (
         //Semafor1UpBuffer[i+1]!=0
         Semafor2UpBuffer[i + 1] != 0
         && Semafor3UpBuffer[i + 1] != 0
      )
        {
         Semafor1UpBuffer[i + 1] = 0; //mp
         Semafor2UpBuffer[i + 1] = 0; //mp
        }
      //---
      if
      (
         //Semafor1DnBuffer[i+1]!=0
         Semafor2DnBuffer[i + 1] != 0
         && Semafor3DnBuffer[i + 1] != 0
      )
        {
         Semafor1DnBuffer[i + 1] = 0; //mp
         Semafor2DnBuffer[i + 1] = 0; //mp
        }
      //---
      if
      (
         Semafor1UpBuffer[i + 1] != 0
         && Semafor2UpBuffer[i + 1] != 0
      )
        {
         Semafor1UpBuffer[i + 1] = 0; //mp
        }
      //---
      if
      (
         Semafor1DnBuffer[i + 1] != 0
         && Semafor2DnBuffer[i + 1] != 0
      )
        {
         Semafor1DnBuffer[i + 1] = 0; //mp
        }
     }
   gadDnBuf[0] = EMPTY_VALUE;
   gadUpBuf[0] = EMPTY_VALUE;
   MA1Buffer[0] = 0;
   MA2Buffer[0] = 0;
   MA3Buffer[0] = 0;
//--- Main Loop
   for(i = BarLimit() - 1; i >= 1; i--)
     {
      //For Start
      BandsCenterBuffer[i] = iMAMQL4(MALength, 0, MODE_LWMA, PRICE_CLOSE, i);
      BandsUpperLimitBuffer[i] = BandsCenterBuffer[i] + BandWidth * iATRMQL4(sym, per, ATRLength, i);
      BandsLowerLimitBuffer[i] = BandsCenterBuffer[i] - BandWidth * iATRMQL4(sym, per, ATRLength, i);
      BuyScalper1Buffer[i] = 0;
      SellScalper1Buffer[i] = 0;
      //---
      //+------------------------------------------------------------------+
      //+------------------------------------------------------------------+
      //Higher Time Frame Bounce & Squeeze
      int AutoTF;
      if(Period() == 1)
         AutoTF = 15;
      if(Period() == 5)
         AutoTF = 30;
      if(Period() == 15)
         AutoTF = 60;
      if(Period() == 30)
         AutoTF = 240;
      if(Period() == 60)
         AutoTF = 1440;
      if(Period() == 240)
         AutoTF = 10080;
      if(Period() == 1440)
         AutoTF = 43200;
      if(Period() == 10080)
         AutoTF = 43200;
      int count = i + 1; // number of elements to copy
      //---- Monthly/Weekly/Daily High/Low
        {
         MonthlyHighBuffer[i] = 0;
         MonthlyLowBuffer[i] = 0;
         if(_Period < PERIOD_MN1)
           {
            int shift = BarShift(_Symbol, PERIOD_MN1, Time[i]);
            if(shift >= 0)
              {
               MonthlyHighBuffer[i] = iHigh(_Symbol, PERIOD_MN1, 1 + shift);
               MonthlyLowBuffer[i] = iLow(_Symbol, PERIOD_MN1, 1 + shift);
              }
           }
         //---
         WeeklyHighBuffer[i] = 0;
         WeeklyLowBuffer[i] = 0;
         if(_Period < PERIOD_W1)
           {
            int shift = BarShift(_Symbol, PERIOD_W1, Time[i]);
            if(shift >= 0)
              {
               WeeklyHighBuffer[i] = iHigh(_Symbol, PERIOD_W1, 1 + shift);
               WeeklyLowBuffer[i] = iLow(_Symbol, PERIOD_W1, 1 + shift);
              }
           }
         //---
         DailyHighBuffer[i] = 0;
         DailyLowBuffer[i] = 0;
         DailyOpenBuffer[i] = 0;
         if(_Period < PERIOD_D1)
           {
            int shift = BarShift(_Symbol, PERIOD_D1, Time[i]);
            if(shift >= 0)
              {
               DailyHighBuffer[i] = iHigh(_Symbol, PERIOD_D1, 1 + shift);
               DailyLowBuffer[i] = iLow(_Symbol, PERIOD_D1, 1 + shift);
               DailyOpenBuffer[i] = iOpen(_Symbol, PERIOD_D1, shift);
              }
           }
        }
      if(Semafor3UpBuffer[i] != 0)
        {
         Semafor3 = 1;
         Semafor3_Time = Time[i];
        }
      //---
      if(Semafor3DnBuffer[i] != 0)
        {
         Semafor3 = -1;
         Semafor3_Time = Time[i];
        }
      // Calc SignalLine
      //+------------------------------------------------------------------+
      //+------------------------------------------------------------------+
      double dAtr, dUpperLevel, dLowerLevel;
      dAtr = iATRMQL4(_Symbol, _Period, SignalLine_Period, i);
      dUpperLevel = (High[i] + Low[i]) / 2 + SignalLine_Multiplier * dAtr;
      dLowerLevel = (High[i] + Low[i]) / 2 - SignalLine_Multiplier * dAtr;
      gadSignalLine[i] = 0;
      // Set SignalLine levels
      if(Close[i] > gadSignalLine[i + 1] && Close[i + 1] <= gadSignalLine[i + 1])
        {
         gadSignalLine[i] = dLowerLevel;
        }
      else
         if(Close[i] < gadSignalLine[i + 1] && Close[i + 1] >= gadSignalLine[i + 1])
           {
            gadSignalLine[i] = dUpperLevel;
           }
         else
            if(gadSignalLine[i + 1] < dLowerLevel)
               gadSignalLine[i] = dLowerLevel;
            else
               if(gadSignalLine[i + 1] > dUpperLevel)
                  gadSignalLine[i] = dUpperLevel;
               else
                  gadSignalLine[i] = gadSignalLine[i + 1];
      // Draw SignalLine lines
      gadUpBuf[i] = EMPTY_VALUE;
      gadDnBuf[i] = EMPTY_VALUE;
      if(Close[i] > gadSignalLine[i] || (Close[i] == gadSignalLine[i] && Close[i + 1] > gadSignalLine[i + 1]))
         gadUpBuf[i] = gadSignalLine[i];
      else
         if(Close[i] < gadSignalLine[i] || (Close[i] == gadSignalLine[i] && Close[i + 1] < gadSignalLine[i + 1]))
            gadDnBuf[i] = gadSignalLine[i];
      MA1Buffer[i] = 0;
      MA2Buffer[i] = 0;
      MA3Buffer[i] = 0;
        {
         MA1Buffer[i] = MA50_Buffer(i);
         MA2Buffer[i] = MA100_Buffer(i);
         MA3Buffer[i] = MA200_Buffer(i);
        }
      //+------------------------------------------------------------------+
      //+------------------------------------------------------------------+
      if(_Period >= PERIOD_M15)
        {
         if
         (
            Semafor3 == 1
            &&
            (
               (Close[i] > MonthlyLowBuffer[i] && Close[i + 1] <= MonthlyLowBuffer[i + 1]) // || (Low[i] > MonthlyLowBuffer[i] && Low[i+1] < MonthlyLowBuffer[i+1] )
               ||
               (Close[i] > WeeklyLowBuffer[i] && Close[i + 1] <= WeeklyLowBuffer[i + 1]) // || (Low[i] > WeeklyLowBuffer[i] && Low[i+1] < WeeklyLowBuffer[i+1] )
               ||
               (Close[i] > DailyLowBuffer[i] && Close[i + 1] <= DailyLowBuffer[i + 1]) // || (Low[i] > DailyLowBuffer[i] && Low[i+1] < DailyLowBuffer[i+1] )
               ||
               (Close[i] > MonthlyHighBuffer[i] && Close[i + 1] <= MonthlyHighBuffer[i + 1]) /// || (Low[i] > MonthlyHighBuffer[i] && Low[i+1] < MonthlyHighBuffer[i+1] )
               ||
               (Close[i] > WeeklyHighBuffer[i] && Close[i + 1] <= WeeklyHighBuffer[i + 1]) // || (Low[i] > WeeklyHighBuffer[i] && Low[i+1] < WeeklyHighBuffer[i+1] )
               ||
               (Close[i] > DailyHighBuffer[i] && Close[i + 1] <= DailyHighBuffer[i + 1]) // || (Low[i] > DailyHighBuffer[i] && Low[i+1] < DailyHighBuffer[i+1] )
               ||
               (Close[i] > DailyOpenBuffer[i] && Close[i + 1] <= DailyOpenBuffer[i + 1])
            )
            && Filter != 1
         )
           {
            Filter = 1;
            Entry = 1;
            if(ShowBox && AlertType != AlertType_Sell)
              {
               BuyScalper1Buffer[i] = (Display_HA ? MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) : Low[i]) - 0.5 * iATRMQL4(_Symbol, _Period, 3, i);
               if(i == 1 && lastAlertBar_Scalper1 != rates_total)
                 {
                  sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Buy Scalper1 " + Symbol() + " " + EnumToString(Period());
                  if(Signal_Alert_Popup)
                    {Alert(sAlertMsg);}
                  if(Signal_Alert_Email)
                    {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
                  if(Signal_Alert_Push_Notification)
                    {SendNotification(sAlertMsg);}
                  lastAlertBar_Scalper1 = rates_total;
                 }
              }
           }
         else
            BuyScalper1Buffer[i] = 0;
         //---
         if
         (
            Semafor3 == -1
            &&
            (
               (Close[i] < MonthlyHighBuffer[i] && Close[i + 1] >= MonthlyHighBuffer[i + 1]) // ||  (High[i] < MonthlyHighBuffer[i] && High[i+1] > MonthlyHighBuffer[i+1] )
               ||
               (Close[i] < WeeklyHighBuffer[i] && Close[i + 1] >= WeeklyHighBuffer[i + 1]) // ||  (High[i] < WeeklyHighBuffer[i] && High[i+1] > WeeklyHighBuffer[i+1] )
               ||
               (Close[i] < DailyHighBuffer[i] && Close[i + 1] >= DailyHighBuffer[i + 1]) // ||  (High[i] < DailyHighBuffer[i] && High[i+1] > DailyHighBuffer[i+1] )
               ||
               (Close[i] < MonthlyLowBuffer[i] && Close[i + 1] >= MonthlyLowBuffer[i + 1]) // ||  (High[i] < MonthlyLowBuffer[i] && High[i+1] > MonthlyLowBuffer[i+1] )
               ||
               (Close[i] < WeeklyLowBuffer[i] && Close[i + 1] >= WeeklyLowBuffer[i + 1]) // ||  (High[i] < WeeklyLowBuffer[i] && High[i+1] > WeeklyLowBuffer[i+1] )
               ||
               (Close[i] < DailyLowBuffer[i] && Close[i + 1] >= DailyLowBuffer[i + 1]) // ||  (High[i] < DailyLowBuffer[i] && High[i+1] > DailyLowBuffer[i+1] )
               ||
               (Close[i] < DailyOpenBuffer[i] && Close[i + 1] >= DailyOpenBuffer[i + 1])
            )
            && Filter != -1
         )
           {
            Filter = -1;
            Entry = -1;
            if(ShowBox && AlertType != AlertType_Buy)
              {
               SellScalper1Buffer[i] = (Display_HA ? MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) : High[i]) + 0.5 * iATRMQL4(_Symbol, _Period, 3, i);
               if(i == 1 && lastAlertBar_Scalper1 != rates_total)
                 {
                  sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Sell Scalper1 " + Symbol() + " " + EnumToString(Period());
                  if(Signal_Alert_Popup)
                    {Alert(sAlertMsg);}
                  if(Signal_Alert_Email)
                    {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
                  if(Signal_Alert_Push_Notification)
                    {SendNotification(sAlertMsg);}
                  lastAlertBar_Scalper1 = rates_total;
                 }
              }
           }
         else
            SellScalper1Buffer[i] = 0;
        }
      //+------------------------------------------------------------------+
      //+--------------- BuyScalper2Buffer/SellScalper2Buffer--------------+
      //+------------------------------------------------------------------+
      if
      (
         Close[i] > BandsCenterBuffer[i]
         && Close[i + 1] < BandsCenterBuffer[i + 1]
         && Entry == 1
      )
        {
         LastArrowBuffer = 1;
         Entry = 0;
         if(ShowArrows && AlertType != AlertType_Sell)
           {
            BuyScalper2Buffer[i] = (Display_HA ? MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) : Low[i]) - iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_Scalper2 != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Buy Scalper2 " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_Scalper2 = rates_total;
              }
           }
        }
      else
         BuyScalper2Buffer[i] = 0;
      //---
      if
      (
         Close[i] < BandsCenterBuffer[i]
         && Close[i + 1] > BandsCenterBuffer[i + 1]
         && Entry == -1
      )
        {
         LastArrowBuffer = -1;
         Entry = 0;
         if(ShowArrows && AlertType != AlertType_Buy)
           {
            SellScalper2Buffer[i] = (Display_HA ? MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) : High[i]) + iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_Scalper2 != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Sell Scalper2 " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_Scalper2 = rates_total;
              }
           }
        }
      else
         SellScalper2Buffer[i] = 0;
      //---
      if
      (
         MA1Buffer[i] < BandsCenterBuffer[i]
         && MA1Buffer[i + 1] >= BandsCenterBuffer[i + 1]
         && (!TrendBasedMiddleBandCrossing || MA3Buffer[i] < BandsCenterBuffer[i])
         &&
         (
            MA1Buffer[i] > MonthlyLowBuffer[i]
            ||
            MA1Buffer[i] > WeeklyLowBuffer[i]
            ||
            MA1Buffer[i] > DailyLowBuffer[i]
            ||
            MA1Buffer[i] > MonthlyHighBuffer[i]
            ||
            MA1Buffer[i] > WeeklyHighBuffer[i]
            ||
            MA1Buffer[i] > DailyHighBuffer[i]
            ||
            MA1Buffer[i] > DailyOpenBuffer[i]
         )
      )
        {
         if(ShowMiddleBandCrossing && AlertType != AlertType_Sell)
           {
            BuyBlackDiamond[i] = (Display_HA ? MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) : Low[i]) - iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_BlackDiamond != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Buy BlackDiamonds " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_BlackDiamond = rates_total;
              }
           }
        }
      else
         BuyBlackDiamond[i] = 0;
      if
      (
         MA1Buffer[i] > BandsCenterBuffer[i]
         && MA1Buffer[i + 1] <= BandsCenterBuffer[i + 1]
         && (!TrendBasedMiddleBandCrossing || MA3Buffer[i] > BandsCenterBuffer[i])
         &&
         (
            MA1Buffer[i] < MonthlyLowBuffer[i]
            ||
            MA1Buffer[i] < WeeklyLowBuffer[i]
            ||
            MA1Buffer[i] < DailyLowBuffer[i]
            ||
            MA1Buffer[i] < MonthlyHighBuffer[i]
            ||
            MA1Buffer[i] < WeeklyHighBuffer[i]
            ||
            MA1Buffer[i] < DailyHighBuffer[i]
            ||
            MA1Buffer[i] < DailyOpenBuffer[i]
         )
      )
        {
         if(ShowMiddleBandCrossing && AlertType != AlertType_Buy)
           {
            SellBlackDiamond[i] = (Display_HA ? MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) : High[i]) + iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_BlackDiamond != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Sell BlackDiamonds " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_BlackDiamond = rates_total;
              }
           }
        }
      else
         SellBlackDiamond[i] = 0;
      //--- Calc Diamonds
      //+------------------------------------------------------------------+
      if(ShowArlensDiamonds && (DiamondsTimeframe == Diamonds_AllTimeframes || _Period >= PERIOD_M15))
        {
         BuyArlensDiamond[i] = 0;
         SellArlensDiamond[i] = 0;
         if(Semafor1UpBuffer[i] != 0)
           {
            if(Semafor1UpBuffer[i] < BandsCenterBuffer[i])
               Semafor12 = 1;
            else
               Semafor12 = 0;
           }
         if(Semafor1DnBuffer[i] != 0)
           {
            if(Semafor1DnBuffer[i] > BandsCenterBuffer[i])
               Semafor12 = -1;
            else
               Semafor12 = 0;
           }
         if(Semafor2UpBuffer[i] != 0)
           {
            if(Semafor2UpBuffer[i] < BandsCenterBuffer[i])
               Semafor12 = 2;
            else
               Semafor12 = 0;
           }
         if(Semafor2DnBuffer[i] != 0)
           {
            if(Semafor2DnBuffer[i] > BandsCenterBuffer[i])
               Semafor12 = -2;
            else
               Semafor12 = 0;
           }
         if(Semafor3UpBuffer[i] != 0)
            Semafor12 = 0;
         if(Semafor3DnBuffer[i] != 0)
            Semafor12 = 0;
         if(Semafor3 > 0
            && Scalper3 > 0
            && ((ShowDiamondAfterSemafor1 && Semafor12 == 1) || (ShowDiamondAfterSemafor2 && Semafor12 == 2))
            && BandsCenterBuffer[i] > MA1Buffer[i]
            && (Display_HA ? HACloseBuffer[i] : Close[i]) > (Display_HA ? HAOpenBuffer[i] : Open[i])
            && (Display_HA ? HACloseBuffer[i] : Close[i]) > BandsCenterBuffer[i]
           )
           {
            Semafor12 = 0;
            if(ShowArlensDiamonds && AlertType != AlertType_Sell)
              {
               BuyArlensDiamond[i] = (Display_HA ? MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) : Low[i]) - 0.5 * iATRMQL4(_Symbol, _Period, 100, i);
               if(i == 1 && lastAlertBar_ArlensDiamond != rates_total)
                 {
                  sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Buy Arlen's Diamonds " + Symbol() + " " + EnumToString(Period());
                  if(Signal_Alert_Popup)
                    {Alert(sAlertMsg);}
                  if(Signal_Alert_Email)
                    {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
                  if(Signal_Alert_Push_Notification)
                    {SendNotification(sAlertMsg);}
                  lastAlertBar_ArlensDiamond = rates_total;
                 }
              }
           }
         if(Semafor3 < 0
            && Scalper3 < 0
            && ((ShowDiamondAfterSemafor1 && Semafor12 == -1) || (ShowDiamondAfterSemafor2 && Semafor12 == -2))
            && BandsCenterBuffer[i] < MA1Buffer[i]
            && (Display_HA ? HACloseBuffer[i] : Close[i]) < (Display_HA ? HAOpenBuffer[i] : Open[i])
            && (Display_HA ? HACloseBuffer[i] : Close[i]) < BandsCenterBuffer[i]
           )
           {
            Semafor12 = 0;
              {
               if(ShowArlensDiamonds && AlertType != AlertType_Buy)
                 {
                  SellArlensDiamond[i] = (Display_HA ? MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) : High[i]) + 0.5 * iATRMQL4(_Symbol, _Period, 100, i);
                  if(i == 1 && lastAlertBar_ArlensDiamond != rates_total)
                    {
                     sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Sell Arlen's Diamonds " + Symbol() + " " + EnumToString(Period());
                     if(Signal_Alert_Popup)
                       {Alert(sAlertMsg);}
                     if(Signal_Alert_Email)
                       {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
                     if(Signal_Alert_Push_Notification)
                       {SendNotification(sAlertMsg);}
                     lastAlertBar_ArlensDiamond = rates_total;
                    }
                 }
              }
           }
        }
      //---
      if(MA3Buffer[i] < MA1Buffer[i]
         && MA3Buffer[i + 1] >= MA1Buffer[i + 1]
         && gadUpBuf[i] != EMPTY_VALUE
        )
        {
         if(ShowGoldenCross && AlertType != AlertType_Sell)
           {
            BuyGoldenCross[i] = (Display_HA ? MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) : Low[i]) - 1.25 * iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_GoldenCross != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Buy Golden Cross " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_GoldenCross = rates_total;
              }
           }
        }
      else
         BuyGoldenCross[i] = 0;
      if(MA3Buffer[i] > MA1Buffer[i]
         && MA3Buffer[i + 1] <= MA1Buffer[i + 1]
         && gadDnBuf[i] != EMPTY_VALUE
        )
        {
         if(ShowGoldenCross && AlertType != AlertType_Buy)
           {
            SellGoldenCross[i] = (Display_HA ? MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) : High[i]) + 1.25 * iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_GoldenCross != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Sell Golden Cross " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_GoldenCross = rates_total;
              }
           }
        }
      else
         SellGoldenCross[i] = 0;
      //--- Calc ParabolicSAR
      //+------------------------------------------------------------------+
      double PSARBuffer = PSAR_Buffer(i);
      //+------------------------------------------------------------------+
      //+--------------- BuyScalper3Buffer/SellScalper3Buffer--------------+
      //+------------------------------------------------------------------+
      if(Semafor3UpBuffer[i] != 0)
        {
         Semafor3Appeared = 1;
        }
      //---
      if(Semafor3DnBuffer[i] != 0)
        {
         Semafor3Appeared = -1;
        }
      if
      (
         Semafor3Appeared == 1
         && PSARBuffer < Close[i]
         && HAOpenBuffer[i] < HACloseBuffer[i]
         && HACloseBuffer[i] > BandsCenterBuffer[i]
         && MathAbs(HAOpenBuffer[i] - MathMin(HALowHighBuffer[i], HAHighLowBuffer[i])) < _Point
      )
        {
         Semafor3Appeared = 0;
         if(!TrendBasedScalper3 || MA3Buffer[i] < BandsCenterBuffer[i])
           {
            if(ShowScalper3 && AlertType != AlertType_Sell)
              {
               BuyScalper3Buffer[i] = (Display_HA ? MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) : Low[i]) - iATRMQL4(_Symbol, _Period, 100, i);
               if(i == 1 && lastAlertBar_Scalper3 != rates_total)
                 {
                  sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Buy Scalper3 " + Symbol() + " " + EnumToString(Period());
                  if(Signal_Alert_Popup)
                    {Alert(sAlertMsg);}
                  if(Signal_Alert_Email)
                    {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
                  if(Signal_Alert_Push_Notification)
                    {SendNotification(sAlertMsg);}
                  lastAlertBar_Scalper3 = rates_total;
                 }
              }
           }
        }
      else
         BuyScalper3Buffer[i] = 0;
      if
      (
         Semafor3Appeared == -1
         && PSARBuffer > Close[i]
         && HAOpenBuffer[i] > HACloseBuffer[i]
         && HACloseBuffer[i] < BandsCenterBuffer[i]
         && MathAbs(HAOpenBuffer[i] - MathMax(HALowHighBuffer[i], HAHighLowBuffer[i])) < _Point
      )
        {
         Semafor3Appeared = 0;
         if(!TrendBasedScalper3 || MA3Buffer[i] > BandsCenterBuffer[i])
           {
            if(ShowScalper3 && AlertType != AlertType_Buy)
              {
               SellScalper3Buffer[i] = (Display_HA ? MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) : High[i]) + iATRMQL4(_Symbol, _Period, 100, i);
               if(i == 1 && lastAlertBar_Scalper3 != rates_total)
                 {
                  sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Sell Scalper3 " + Symbol() + " " + EnumToString(Period());
                  if(Signal_Alert_Popup)
                    {Alert(sAlertMsg);}
                  if(Signal_Alert_Email)
                    {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
                  if(Signal_Alert_Push_Notification)
                    {SendNotification(sAlertMsg);}
                  lastAlertBar_Scalper3 = rates_total;
                 }
              }
           }
        }
      else
         SellScalper3Buffer[i] = 0;
      if(BuyScalper3Buffer[i] != 0)
        {
         Scalper3 = 1;
        }
      //---
      if(SellScalper3Buffer[i] != 0)
        {
         Scalper3 = -1;
        }
      //+------------------------------------------------------------------+
      //+--------------- GoldenBuyDiamond/GoldenSellDiamond--------------+
      //+------------------------------------------------------------------+
      if(ShowGoldenDiamond)
        {
         if(BuyGoldenCross[i] != 0)
            GoldenDiamond_Trend = 1;
         if(SellGoldenCross[i] != 0)
            GoldenDiamond_Trend = -1;
         //if (GoldenDiamond_Trend > 0 && SellScalper3Buffer[i] != 0) GoldenDiamond_Trend = 0;
         //if (GoldenDiamond_Trend < 0 && BuyScalper3Buffer[i] != 0) GoldenDiamond_Trend = 0;
         if(GoldenDiamond_Trend == 1 && Semafor2UpBuffer[i] != 0)
            GoldenDiamond_Trend = 2;
         if(GoldenDiamond_Trend == -1 && Semafor2DnBuffer[i] != 0)
            GoldenDiamond_Trend = -2;
         GoldenBuyDiamond[i] = 0;
         if(AlertType != AlertType_Sell
            && GoldenDiamond_Trend == 2
            && (Display_HA ? HACloseBuffer[i] : Close[i]) > (Display_HA ? HAOpenBuffer[i] : Open[i])
            && (Display_HA ? HACloseBuffer[i] : Close[i]) > BandsCenterBuffer[i]
            //&& (Display_HA ? HAOpenBuffer[i] : Open[i]) <= BandsCenterBuffer[i]
           )
           {
            GoldenDiamond_Trend = 0;
            if(gadUpBuf[i] != EMPTY_VALUE
               && MA1Buffer[i] < BandsCenterBuffer[i]
              )
              {
               GoldenBuyDiamond[i] = (Display_HA ? MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) : Low[i]) - iATRMQL4(_Symbol, _Period, 100, i);
               if(i == 1 && lastAlertBar_GoldenDiamond != rates_total)
                 {
                  sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Buy GoldenDiamond " + Symbol() + " " + EnumToString(Period());
                  if(Signal_Alert_Popup)
                    {Alert(sAlertMsg);}
                  if(Signal_Alert_Email)
                    {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
                  if(Signal_Alert_Push_Notification)
                    {SendNotification(sAlertMsg);}
                  lastAlertBar_GoldenDiamond = rates_total;
                 }
              }
           }
         GoldenSellDiamond[i] = 0;
         if(AlertType != AlertType_Buy
            && GoldenDiamond_Trend == -2
            && (Display_HA ? HACloseBuffer[i] : Close[i]) < (Display_HA ? HAOpenBuffer[i] : Open[i])
            && (Display_HA ? HACloseBuffer[i] : Close[i]) < BandsCenterBuffer[i]
            //&& (Display_HA ? HAOpenBuffer[i] : Open[i]) >= BandsCenterBuffer[i]
           )
           {
            GoldenDiamond_Trend = 0;
            if(gadDnBuf[i] != EMPTY_VALUE
               && MA1Buffer[i] > BandsCenterBuffer[i]
              )
              {
               GoldenSellDiamond[i] = (Display_HA ? MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) : High[i]) + iATRMQL4(_Symbol, _Period, 100, i);
               if(i == 1 && lastAlertBar_GoldenDiamond != rates_total)
                 {
                  sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Sell GoldenDiamond " + Symbol() + " " + EnumToString(Period());
                  if(Signal_Alert_Popup)
                    {Alert(sAlertMsg);}
                  if(Signal_Alert_Email)
                    {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
                  if(Signal_Alert_Push_Notification)
                    {SendNotification(sAlertMsg);}
                  lastAlertBar_GoldenDiamond = rates_total;
                 }
              }
           }
        }
      //+------------------------------------------------------------------+
      //+--------------- GoldenBuyTrend/GoldenSellTrend--------------+
      //+------------------------------------------------------------------+
      if(ShowGoldenTrend)
        {
         if(BuyGoldenCross[i] != 0)
            GoldenTrend_Trend = 1;
         if(SellGoldenCross[i] != 0)
            GoldenTrend_Trend = -1;
         //if (GoldenTrend_Trend > 0 && SellScalper3Buffer[i] != 0) GoldenTrend_Trend = 0;
         //if (GoldenTrend_Trend < 0 && BuyScalper3Buffer[i] != 0) GoldenTrend_Trend = 0;
         if(GoldenTrend_Trend == 1 && Semafor3UpBuffer[i] != 0)
            GoldenTrend_Trend = 2;
         if(GoldenTrend_Trend == -1 && Semafor3DnBuffer[i] != 0)
            GoldenTrend_Trend = -2;
         GoldenBuyTrend[i] = 0;
         if(AlertType != AlertType_Sell
            && GoldenTrend_Trend == 2
            && (Display_HA ? HACloseBuffer[i] : Close[i]) > (Display_HA ? HAOpenBuffer[i] : Open[i])
            && (Display_HA ? HACloseBuffer[i] : Close[i]) > BandsCenterBuffer[i]
            //&& (Display_HA ? HAOpenBuffer[i] : Open[i]) <= BandsCenterBuffer[i]
           )
           {
            GoldenTrend_Trend = 0;
            if(MA3Buffer[i] < BandsCenterBuffer[i])
              {
               GoldenBuyTrend[i] = (Display_HA ? MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) : Low[i]) - iATRMQL4(_Symbol, _Period, 100, i);
               if(i == 1 && lastAlertBar_GoldenTrend != rates_total)
                 {
                  sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Buy GoldenTrend " + Symbol() + " " + EnumToString(Period());
                  if(Signal_Alert_Popup)
                    {Alert(sAlertMsg);}
                  if(Signal_Alert_Email)
                    {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
                  if(Signal_Alert_Push_Notification)
                    {SendNotification(sAlertMsg);}
                  lastAlertBar_GoldenTrend = rates_total;
                 }
              }
           }
         GoldenSellTrend[i] = 0;
         if(AlertType != AlertType_Buy
            && GoldenTrend_Trend == -2
            && (Display_HA ? HACloseBuffer[i] : Close[i]) < (Display_HA ? HAOpenBuffer[i] : Open[i])
            && (Display_HA ? HACloseBuffer[i] : Close[i]) < BandsCenterBuffer[i]
            //&& (Display_HA ? HAOpenBuffer[i] : Open[i]) >= BandsCenterBuffer[i]
           )
           {
            GoldenTrend_Trend = 0;
            if(MA3Buffer[i] > BandsCenterBuffer[i])
              {
               GoldenSellTrend[i] = (Display_HA ? MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) : High[i]) + iATRMQL4(_Symbol, _Period, 100, i);
               if(i == 1 && lastAlertBar_GoldenTrend != rates_total)
                 {
                  sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Sell GoldenTrend " + Symbol() + " " + EnumToString(Period());
                  if(Signal_Alert_Popup)
                    {Alert(sAlertMsg);}
                  if(Signal_Alert_Email)
                    {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
                  if(Signal_Alert_Push_Notification)
                    {SendNotification(sAlertMsg);}
                  lastAlertBar_GoldenTrend = rates_total;
                 }
              }
           }
        }
      //+------------------------------------------------------------------+
      //+--------------- GoldenBuyArrow/GoldenSellArrow--------------+
      //+------------------------------------------------------------------+
      if(ShowGoldenArrow)
        {
         if(BuyGoldenCross[i] != 0)
            GoldenArrow_Trend = 1;
         if(SellGoldenCross[i] != 0)
            GoldenArrow_Trend = -1;
         //if (GoldenArrow_Trend > 0 && SellScalper3Buffer[i] != 0) GoldenArrow_Trend = 0;
         //if (GoldenArrow_Trend < 0 && BuyScalper3Buffer[i] != 0) GoldenArrow_Trend = 0;
         if(GoldenArrow_Trend == 1 && BuyScalper3Buffer[i] != 0)
            GoldenArrow_Trend = 2;
         if(GoldenArrow_Trend == -1 && SellScalper3Buffer[i] != 0)
            GoldenArrow_Trend = -2;
         GoldenBuyArrow[i] = 0;
         if(AlertType != AlertType_Sell
            && GoldenArrow_Trend == 2
            && (Display_HA ? HACloseBuffer[i] : Close[i]) > (Display_HA ? HAOpenBuffer[i] : Open[i])
            && (Display_HA ? HACloseBuffer[i] : Close[i]) > BandsCenterBuffer[i]
            //&& (Display_HA ? HAOpenBuffer[i] : Open[i]) <= BandsCenterBuffer[i]
           )
           {
            GoldenArrow_Trend = 0;
            if(MA3Buffer[i] < BandsCenterBuffer[i])
              {
               GoldenBuyArrow[i] = (Display_HA ? MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) : Low[i]) - iATRMQL4(_Symbol, _Period, 100, i);
               if(i == 1 && lastAlertBar_GoldenArrow != rates_total)
                 {
                  sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Buy GoldenArrow " + Symbol() + " " + EnumToString(Period());
                  if(Signal_Alert_Popup)
                    {Alert(sAlertMsg);}
                  if(Signal_Alert_Email)
                    {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
                  if(Signal_Alert_Push_Notification)
                    {SendNotification(sAlertMsg);}
                  lastAlertBar_GoldenArrow = rates_total;
                 }
              }
           }
         GoldenSellArrow[i] = 0;
         if(AlertType != AlertType_Buy
            && GoldenArrow_Trend == -2
            && (Display_HA ? HACloseBuffer[i] : Close[i]) < (Display_HA ? HAOpenBuffer[i] : Open[i])
            && (Display_HA ? HACloseBuffer[i] : Close[i]) < BandsCenterBuffer[i]
            //&& (Display_HA ? HAOpenBuffer[i] : Open[i]) >= BandsCenterBuffer[i]
           )
           {
            GoldenArrow_Trend = 0;
            if(MA3Buffer[i] > BandsCenterBuffer[i])
              {
               GoldenSellArrow[i] = (Display_HA ? MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) : High[i]) + iATRMQL4(_Symbol, _Period, 100, i);
               if(i == 1 && lastAlertBar_GoldenArrow != rates_total)
                 {
                  sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Sell GoldenArrow " + Symbol() + " " + EnumToString(Period());
                  if(Signal_Alert_Popup)
                    {Alert(sAlertMsg);}
                  if(Signal_Alert_Email)
                    {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
                  if(Signal_Alert_Push_Notification)
                    {SendNotification(sAlertMsg);}
                  lastAlertBar_GoldenArrow = rates_total;
                 }
              }
           }
        }
      //+------------------------------------------------------------------+
      //+--------------- PremiumBuy/PremiumSell--------------+
      //+------------------------------------------------------------------+
      if(ShowPremiumDiamond)
        {
         if(BuyBlackDiamond[i] != 0)
            PremiumDiamond_Trend = 1;
         if(SellBlackDiamond[i] != 0)
            PremiumDiamond_Trend = -1;
         if(PremiumDiamond_Trend == 1 && Semafor2UpBuffer[i] != 0)
            PremiumDiamond_Trend = 2;
         if(PremiumDiamond_Trend == -1 && Semafor2DnBuffer[i] != 0)
            PremiumDiamond_Trend = -2;
         PremiumBuy[i] = 0;
         if(AlertType != AlertType_Sell
            && PremiumDiamond_Trend == 2
            && (Display_HA ? HACloseBuffer[i] : Close[i]) > (Display_HA ? HAOpenBuffer[i] : Open[i])
            && (Display_HA ? HACloseBuffer[i] : Close[i]) > BandsCenterBuffer[i]
            //&& (Display_HA ? HAOpenBuffer[i] : Open[i]) <= BandsCenterBuffer[i]
           )
           {
            PremiumDiamond_Trend = 0;
            //if (gadUpBuf[i]!=EMPTY_VALUE
            //  && MA1Buffer[i] < BandsCenterBuffer[i]
            //  )
              {
               PremiumBuy[i] = (Display_HA ? MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) : Low[i]) - iATRMQL4(_Symbol, _Period, 100, i);
               if(i == 1 && lastAlertBar_PremiumDiamond != rates_total)
                 {
                  sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Buy Premium Diamond " + Symbol() + " " + EnumToString(Period());
                  if(Signal_Alert_Popup)
                    {Alert(sAlertMsg);}
                  if(Signal_Alert_Email)
                    {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
                  if(Signal_Alert_Push_Notification)
                    {SendNotification(sAlertMsg);}
                  lastAlertBar_PremiumDiamond = rates_total;
                 }
              }
           }
         PremiumSell[i] = 0;
         if(AlertType != AlertType_Buy
            && PremiumDiamond_Trend == -2
            && (Display_HA ? HACloseBuffer[i] : Close[i]) < (Display_HA ? HAOpenBuffer[i] : Open[i])
            && (Display_HA ? HACloseBuffer[i] : Close[i]) < BandsCenterBuffer[i]
            //&& (Display_HA ? HAOpenBuffer[i] : Open[i]) >= BandsCenterBuffer[i]
           )
           {
            PremiumDiamond_Trend = 0;
            //if (gadDnBuf[i]!=EMPTY_VALUE
            //  && MA1Buffer[i] > BandsCenterBuffer[i]
            // )
              {
               PremiumSell[i] = (Display_HA ? MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) : High[i]) + iATRMQL4(_Symbol, _Period, 100, i);
               if(i == 1 && lastAlertBar_PremiumDiamond != rates_total)
                 {
                  sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Sell Premium Diamond " + Symbol() + " " + EnumToString(Period());
                  if(Signal_Alert_Popup)
                    {Alert(sAlertMsg);}
                  if(Signal_Alert_Email)
                    {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
                  if(Signal_Alert_Push_Notification)
                    {SendNotification(sAlertMsg);}
                  lastAlertBar_PremiumDiamond = rates_total;
                 }
              }
           }
        }
      //+------------------------------------------------------------------+
      //+--------------- Semafor2Buy/Semafor2Sell--------------+
      //+------------------------------------------------------------------+
      if(ShowSemafor2Arrows)
        {
         static int Semafor2_Trend = 0;
         if(Semafor2_Trend <= 0
            && Semafor2UpBuffer[i] != 0
            && gadUpBuf[i] != EMPTY_VALUE
            && MA1Buffer[i] < BandsCenterBuffer[i]
           )
            Semafor2_Trend = 1;
         if(Semafor2_Trend >= 0
            && Semafor2DnBuffer[i] != 0
            && gadDnBuf[i] != EMPTY_VALUE
            && MA1Buffer[i] > BandsCenterBuffer[i]
           )
            Semafor2_Trend = -1;
         if(Semafor2_Trend > 0
            && !(gadUpBuf[i] != EMPTY_VALUE
                 && MA1Buffer[i] < BandsCenterBuffer[i])
           )
            Semafor2_Trend = 0;
         if(Semafor2_Trend < 0
            && !(gadDnBuf[i] != EMPTY_VALUE
                 && MA1Buffer[i] > BandsCenterBuffer[i])
           )
            Semafor2_Trend = 0;
         if(Time[i] >= D'2021.8.18 21:00')
           {
            int a = 0;
           }
         if(Semafor2_Trend == 1
            && HACloseBuffer[i] > HAOpenBuffer[i]
            && MathAbs(MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) - HAOpenBuffer[i]) < _Point
           )
            Semafor2_Trend = 2;
         if(Semafor2_Trend == -1
            && HACloseBuffer[i] < HAOpenBuffer[i]
            && MathAbs(MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) - HAOpenBuffer[i]) < _Point
           )
            Semafor2_Trend = -2;
         Semafor2Buy[i] = 0;
         if(AlertType != AlertType_Sell
            && Semafor2_Trend == 2
            && HACloseBuffer[i] > HAOpenBuffer[i]
            && HACloseBuffer[i] > BandsCenterBuffer[i] && HAOpenBuffer[i] <= BandsCenterBuffer[i]
           )
           {
            Semafor2_Trend = 0;
            Semafor2Buy[i] = (Display_HA ? MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) : Low[i]) - iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_Semafor2Arrow != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Buy Semafor2 " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_Semafor2Arrow = rates_total;
              }
           }
         Semafor2Sell[i] = 0;
         if(AlertType != AlertType_Sell
            && Semafor2_Trend == -2
            && HACloseBuffer[i] < HAOpenBuffer[i]
            && HACloseBuffer[i] < BandsCenterBuffer[i] && HAOpenBuffer[i] >= BandsCenterBuffer[i]
           )
           {
            Semafor2_Trend = 0;
            Semafor2Sell[i] = (Display_HA ? MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) : High[i]) + iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_Semafor2Arrow != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Sell Semafor2 " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_Semafor2Arrow = rates_total;
              }
           }
        }
      //+------------------------------------------------------------------------------------------+
      //+--------------- BuyReversal/SellReversal--------------+
      //+------------------------------------------------------------------------------------------+
      if(ShowReversal && (Reversal_Timeframe == Reversal_AllTimeframes || _Period >= PERIOD_M5))
        {
         static int Reversal_Trend = 0;
         if(Semafor3UpBuffer[i] != 0)
            Semafor3Appeared_Reversal = 1;
         if(Semafor3DnBuffer[i] != 0)
            Semafor3Appeared_Reversal = -1;
         if(Reversal_Trend <= 0 && Semafor3Appeared_Reversal > 0 && BuyScalper3Buffer[i] != 0)
           {
            Reversal_Trend = 1;
           }
         if(Reversal_Trend >= 1 && SellScalper3Buffer[i] != 0)
            Reversal_Trend = 0;
         if(Reversal_Trend >= 0 && Semafor3Appeared_Reversal < 0 && SellScalper3Buffer[i] != 0)
           {
            Reversal_Trend = -1;
           }
         if(Reversal_Trend <= -1 && BuyScalper3Buffer[i] != 0)
            Reversal_Trend = 0;
         if(Reversal_Trend == 1
            &&
            ((ShowReversalAfterSemafor1 && Semafor1UpBuffer[i] != 0) // && Semafor1UpBuffer[i] < BandsCenterBuffer[i])
             || (ShowReversalAfterSemafor2 && Semafor2UpBuffer[i] != 0) // && Semafor2UpBuffer[i] < BandsCenterBuffer[i])
            )
           )
           {
            Reversal_Trend = 2;
           }
         if(Reversal_Trend == -1
            &&
            ((ShowReversalAfterSemafor1 && Semafor1DnBuffer[i] != 0) // && Semafor1DnBuffer[i] > BandsCenterBuffer[i])
             || (ShowReversalAfterSemafor2 && Semafor2DnBuffer[i] != 0) // && Semafor2DnBuffer[i] > BandsCenterBuffer[i])
            )
           )
           {
            Reversal_Trend = -2;
           }
         if(Time[i] == D'2021.7.15 8:00')
           {
            int a = 0;
           }
         if(Reversal_Trend == 2
            &&
            (
               // Engulf
               ((Display_HA ? HACloseBuffer[i] : Close[i]) > (Display_HA ? HAOpenBuffer[i] : Open[i])
                && (Display_HA ? HACloseBuffer[i + 1] : Close[i + 1]) < (Display_HA ? HAOpenBuffer[i + 1] : Open[i + 1])
                && MathAbs((Display_HA ? HACloseBuffer[i] : Close[i]) - (Display_HA ? HAOpenBuffer[i] : Open[i]))
                >= 0.8 * ((Display_HA ? MathMax(HALowHighBuffer[i + 1], HAHighLowBuffer[i + 1]) : High[i + 1]) - (Display_HA ? MathMin(HALowHighBuffer[i + 1], HAHighLowBuffer[i + 1]) : Low[i + 1]))
               )
               ||
               // Doji
               (MathAbs((Display_HA ? HACloseBuffer[i] : Close[i]) - (Display_HA ? HAOpenBuffer[i] : Open[i]))
                < 0.5 * ((Display_HA ? MathMin(HACloseBuffer[i + 1], HAOpenBuffer[i + 1]) : MathMin(Close[i + 1], Open[i + 1])) - (Display_HA ? MathMin(HALowHighBuffer[i + 1], HAHighLowBuffer[i + 1]) : Low[i + 1]))
               )
            )
            && (!TrendBased_Reversal || MA3Buffer[i] < BandsCenterBuffer[i])
            && AlertType != AlertType_Sell
           )
           {
            Reversal_Trend = 0;
            BuyReversal[i] = (Display_HA ? MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) : Low[i]) - iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_Reversal != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Arlens Buy SemaforeBreak " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_Reversal = rates_total;
              }
           }
         else
            BuyReversal[i] = 0;
         if(Reversal_Trend == -2
            &&
            (
               // Engulf
               ((Display_HA ? HACloseBuffer[i] : Close[i]) < (Display_HA ? HAOpenBuffer[i] : Open[i])
                && (Display_HA ? HACloseBuffer[i + 1] : Close[i + 1]) > (Display_HA ? HAOpenBuffer[i + 1] : Open[i + 1])
                && MathAbs((Display_HA ? HACloseBuffer[i] : Close[i]) - (Display_HA ? HAOpenBuffer[i] : Open[i]))
                >= 0.8 * ((Display_HA ? MathMax(HALowHighBuffer[i + 1], HAHighLowBuffer[i + 1]) : High[i + 1]) - (Display_HA ? MathMin(HALowHighBuffer[i + 1], HAHighLowBuffer[i + 1]) : Low[i + 1]))
               )
               ||
               // Doji
               (MathAbs((Display_HA ? HACloseBuffer[i] : Close[i]) - (Display_HA ? HAOpenBuffer[i] : Open[i]))
                < 0.5 * ((Display_HA ? -MathMax(HACloseBuffer[i + 1], HAOpenBuffer[i + 1]) : MathMax(Close[i + 1], Open[i + 1])) + (Display_HA ? MathMax(HALowHighBuffer[i + 1], HAHighLowBuffer[i + 1]) : High[i + 1]))
               )
            )
            && (!TrendBased_Reversal || MA3Buffer[i] > BandsCenterBuffer[i])
            && AlertType != AlertType_Buy
           )
           {
            Reversal_Trend = 0;
            SellReversal[i] = (Display_HA ? MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) : High[i]) + iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_Reversal != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Arlens Sell SemaforeBreak " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_Reversal = rates_total;
              }
           }
         else
            SellReversal[i] = 0;
        }
      //+------------------------------------------------------------------------------------------+
      //+--------------- BuySemafor3Alert/SellSemafor3Alert--------------+
      //+------------------------------------------------------------------------------------------+
      if(ShowSemafor3Alert)
        {
         static int LastGoldenCross = 0;
         if(BuyGoldenCross[i] != 0)
            LastGoldenCross = 1;
         if(SellGoldenCross[i] != 0)
            LastGoldenCross = -1;
         if(LastGoldenCross == 1
            && Semafor3UpBuffer[i] != 0
            && Semafor3UpBuffer[i] < BandsCenterBuffer[i]
           )
           {
            BuySemafor3Alert[i] = (Display_HA ? MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) : Low[i]) - iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_Semafor3Alert != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Buy Semafor3 Alert " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_Semafor3Alert = rates_total;
              }
           }
         else
            BuySemafor3Alert[i] = 0;
         if(LastGoldenCross == -1
            && Semafor3DnBuffer[i] != 0
            && Semafor3DnBuffer[i] > BandsCenterBuffer[i]
           )
           {
            SellSemafor3Alert[i] = (Display_HA ? MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) : High[i]) + iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_Semafor3Alert != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Sell Semafor3 Alert " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_Semafor3Alert = rates_total;
              }
           }
         else
            SellSemafor3Alert[i] = 0;
        }
      //+------------------------------------------------------------------------------------------+
      //+--------------- BuyTrend/SellTrend--------------+
      //+------------------------------------------------------------------------------------------+
      if(ShowBuySellTrend)
        {
         if(MA3Buffer[i] < BandsCenterBuffer[i]
            && MA3Buffer[i + 1] >= BandsCenterBuffer[i + 1]
           )
           {
            BuyTrend[i] = (Display_HA ? MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) : Low[i]) - iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_Trend != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Buy Trend " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_Trend = rates_total;
              }
           }
         else
            BuyTrend[i] = 0;
         if(MA3Buffer[i] > BandsCenterBuffer[i]
            && MA3Buffer[i + 1] <= BandsCenterBuffer[i + 1]
           )
           {
            SellTrend[i] = (Display_HA ? MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) : High[i]) + iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_Trend != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Sell Trend " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_Trend = rates_total;
              }
           }
         else
            SellTrend[i] = 0;
        }
      //+------------------------------------------------------------------+
      //+--------------- BuyTrend1/SellTrend1--------------+
      //+------------------------------------------------------------------+
      if(ShowBuySellTrend1)
        {
         static int Trend1_Trend = 0;
         if(BuyTrend[i] != 0)
            Trend1_Trend = 1;
         if(SellTrend[i] != 0)
            Trend1_Trend = -1;
         if((ShowTrend1AlertAfterSemafor1 && Semafor1UpBuffer[i] != 0) || (ShowTrend1AlertAfterSemafor2 && Semafor2UpBuffer[i] != 0))
           {
            if(Trend1_Trend <= -2)
               Trend1_Trend = -1;
            else
               if(Trend1_Trend == 1)
                  Trend1_Trend = 2;
           }
         if((ShowTrend1AlertAfterSemafor1 && Semafor1DnBuffer[i] != 0) || (ShowTrend1AlertAfterSemafor2 && Semafor2DnBuffer[i] != 0))
           {
            if(Trend1_Trend >= 2)
               Trend1_Trend = 1;
            else
               if(Trend1_Trend == -1)
                  Trend1_Trend = -2;
           }
         if(Trend1_Trend == 2 && MathAbs(MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) - HAOpenBuffer[i]) < _Point)
            Trend1_Trend = 3;
         if(Trend1_Trend == -2 && MathAbs(MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) - HAOpenBuffer[i]) < _Point)
            Trend1_Trend = -3;
         if(Trend1_Trend == 3 && (Display_HA ? HACloseBuffer[i] : Close[i]) > BandsCenterBuffer[i])
           {
            Trend1_Trend = 0;
            BuyTrend1[i] = (Display_HA ? MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) : Low[i]) - iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_Trend1 != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Buy Trend1 " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_Trend1 = rates_total;
              }
           }
         else
            BuyTrend1[i] = 0;
         if(Trend1_Trend == -3 && (Display_HA ? HACloseBuffer[i] : Close[i]) < BandsCenterBuffer[i])
           {
            Trend1_Trend = 0;
            SellTrend1[i] = (Display_HA ? MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) : High[i]) + iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_Trend1 != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Sell Trend1 " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_Trend1 = rates_total;
              }
           }
        }
      //+------------------------------------------------------------------+
      //+--------------- BuyHull/SellHull--------------+
      //+------------------------------------------------------------------+
      //if (ShowBuySellHull && (HullTimeframe == Hull_AllTimeframes || _Period >= PERIOD_M15))
        {
         static int Hull_Trend = 0;
         if(BuyHull[i] != 0)
            Hull_Trend = 1;
         if(SellHull[i] != 0)
            Hull_Trend = -1;
         if((ShowHullAlertAfterSemafor2 && Semafor2UpBuffer[i] != 0) || (ShowHullAlertAfterSemafor3 && Semafor3UpBuffer[i] != 0))
           {
            Hull_Trend = 1;
           }
         if((ShowHullAlertAfterSemafor2 && Semafor2DnBuffer[i] != 0) || (ShowHullAlertAfterSemafor3 && Semafor3DnBuffer[i] != 0))
           {
            Hull_Trend = -1;
           }
         double BuyArrow_ = HullIndicator_BufferValue(0, i);
         if(Hull_Trend == 1 && (BuyArrow_ = HullIndicator_BufferValue(0, i)) != EMPTY_VALUE && BuyArrow_ > 0)
           {
            Hull_Trend = 0;
            BuyHull[i] = (Display_HA ? MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) : Low[i]) - iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_Hull != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Buy Hull " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_Hull = rates_total;
              }
           }
         else
            BuyHull[i] = 0;
         double SellArrow_;
         if(Hull_Trend == -1 && (SellArrow_ = HullIndicator_BufferValue(1, i)) != EMPTY_VALUE && SellArrow_ > 0)
           {
            Hull_Trend = 0;
            SellHull[i] = (Display_HA ? MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) : High[i]) + iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_Hull != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Sell Hull " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_Hull = rates_total;
              }
           }
        }
      //+------------------------------------------------------------------------------------------+
      //+--------------- BuySAPE/SellSAPE--------------+
      //+------------------------------------------------------------------------------------------+
      if(ShowSAPE && (SAPE_Timeframe == SAPE_AllTimeframes || _Period >= PERIOD_M5))
        {
         static int SAPE_Trend = 0;
         if(Semafor3UpBuffer[i] != 0 && SAPE_Trend <= 0)
           {
            SAPE_Trend = 1;
           }
         else
            if(Semafor3DnBuffer[i] != 0 && SAPE_Trend >= 0)
              {
               SAPE_Trend = -1;
              }
         if(BuyHull[i] != 0)
           {
            if(SAPE_Trend == 1)
               SAPE_Trend = 2;
            else
               if(SAPE_Trend < 0)
                  SAPE_Trend = -1;
           }
         else
            if(SellHull[i] != 0)
              {
               if(SAPE_Trend == -1)
                  SAPE_Trend = -2;
               else
                  if(SAPE_Trend > 0)
                     SAPE_Trend = 1;
              }
         if(SAPE_Trend == 2 && ((ShowSAPEAfterSemafor1 && Semafor1UpBuffer[i] != 0) || (ShowSAPEAfterSemafor2 && Semafor2UpBuffer[i] != 0)))
           {
            SAPE_Trend = 3;
           }
         if(SAPE_Trend == -2 && ((ShowSAPEAfterSemafor1 && Semafor1DnBuffer[i] != 0) || (ShowSAPEAfterSemafor2 && Semafor2DnBuffer[i] != 0)))
           {
            SAPE_Trend = -3;
           }
         if(SAPE_Trend == 3
            && (Display_HA ? HACloseBuffer[i] : Close[i]) > (Display_HA ? HAOpenBuffer[i] : Open[i])
            && MathAbs((Display_HA ? HALowHighBuffer[i] : Low[i]) - (Display_HA ? HAOpenBuffer[i] : Open[i])) < _Point
           )
           {
            SAPE_Trend = 4;
           }
         if(SAPE_Trend == -3
            && (Display_HA ? HACloseBuffer[i] : Close[i]) < (Display_HA ? HAOpenBuffer[i] : Open[i])
            && MathAbs((Display_HA ? HAHighLowBuffer[i] : High[i]) - (Display_HA ? HAOpenBuffer[i] : Open[i])) < _Point
           )
           {
            SAPE_Trend = -4;
           }
         if(Time[i] == D'2021.11.1 11:0')
           {
            int a = 0;
           }
         if(SAPE_Trend == 4
            && (Display_HA ? HACloseBuffer[i] : Close[i]) > (Display_HA ? HAOpenBuffer[i] : Open[i])
            && (Display_HA ? HACloseBuffer[i] : Close[i]) > BandsCenterBuffer[i]
            && AlertType != AlertType_Sell
           )
           {
            SAPE_Trend = 2;
            BuySAPE[i] = (Display_HA ? MathMin(HALowHighBuffer[i], HAHighLowBuffer[i]) : Low[i]) - iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_SAPE != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Arlens Buy SAPE " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_SAPE = rates_total;
              }
           }
         else
            BuySAPE[i] = 0;
         if(SAPE_Trend == -4
            && (Display_HA ? HACloseBuffer[i] : Close[i]) < (Display_HA ? HAOpenBuffer[i] : Open[i])
            && (Display_HA ? HACloseBuffer[i] : Close[i]) < BandsCenterBuffer[i]
            && AlertType != AlertType_Sell
           )
           {
            SAPE_Trend = -2;
            SellSAPE[i] = (Display_HA ? MathMax(HALowHighBuffer[i], HAHighLowBuffer[i]) : High[i]) + iATRMQL4(_Symbol, _Period, 100, i);
            if(i == 1 && lastAlertBar_SAPE != rates_total)
              {
               sAlertMsg = MQLInfoString(MQL_PROGRAM_NAME) + ": Arlens Sell SAPE " + Symbol() + " " + EnumToString(Period());
               if(Signal_Alert_Popup)
                 {Alert(sAlertMsg);}
               if(Signal_Alert_Email)
                 {SendMail("MT5 Alert: " + " " + sAlertMsg, sAlertMsg);}
               if(Signal_Alert_Push_Notification)
                 {SendNotification(sAlertMsg);}
               lastAlertBar_SAPE = rates_total;
              }
           }
         else
            SellSAPE[i] = 0;
        }
      //-------------------------------------------------------------
      //++++++++++++++++ show arrow when Ma crossing+++++++++++++++++++
      //-------------------------------------------------------------
      if(MA1Buffer[i] >= MA3Buffer[i] && crossed != 1)
        {
         CrossUp[i] = MA3Buffer[i] - 30 * Point();
         crossed = 1;
        }
      if(MA1Buffer[i] <= MA3Buffer[i] && crossed != 0)
        {
         CrossDown[i] = MA3Buffer[i] + 30 * Point();
         crossed = 0;
        }
      if(Semafor1UpBuffer[i] != 0)
        {
         diamond_trend = 1;
        }
      if(Semafor1DnBuffer[i] != 0)
        {
         diamond_trend = -1;
        }
      if(Semafor2UpBuffer[i] != 0)
        {
         diamond_trend = 2;
         diamond_buy = true;
        }
      if(Semafor2DnBuffer[i] != 0)
        {
         diamond_trend = -2;
         diamond_sell = true;
        }
      if(Semafor3UpBuffer[i] != 0)
        {
         diamond_trend = 3;
        }
      if(Semafor3DnBuffer[i] != 0)
        {
         diamond_trend = -3;
        }
      if(diamond_trend == 2 && MA1Buffer[i] > MA3Buffer[i] &&gadSignalLine[i]<Close[i] &&crossed == 1 && diamond_buy == true)
        {
         if(Close[i] > DailyOpenBuffer[i])
           {
            diamondUp[i] = Low[i];
            diamond_buy = false;
           }
        }
      else
         if(diamond_trend == -2 && MA1Buffer[i] < MA3Buffer[i] && crossed == 0 &&gadSignalLine[i]>Close[i]&& diamond_sell == true)
           {
            if(Close[i] > DailyOpenBuffer[i])
              {
               diamondDown[i] = High[i];
               diamond_sell = false;
              }
           }
     }//For End
//---
//ADR Start
   double open_0;
   double open_8;
   double Ld_16;
   double Ld_24;
   double Ld_32;
   int Li_40;
   double Ld_44;
   int Li_128;
   int Li_52 = 0;
   int Li_56 = 0;
   int Li_60 = 0;
   if(Period() > PERIOD_D1)
      return (-1);
   if(DebugLogger)
     {
      //datetime Time3[];
      //int count=1;   // number of elements to copy
      //ArraySetAsSeries(Time3,true);
      //CopyTime(_Symbol,_Period,0,count,Time3);
      Print("Local time current bar:", TimeToString(Time[0]));
      Print("Dest  time current bar: ", TimeToString(Time[0] - 3600 * (TimeZoneOfData - TimeZoneOfSession)), ", tzdiff= ", TimeZoneOfData - TimeZoneOfSession);
     }
   ComputeDayIndices(TimeZoneOfData, TimeZoneOfSession, Li_52, Li_56, Li_60);
   if(Time[0] == G_time_140 && Period() == G_timeframe_144 && Gi_148 == Li_52)
     {
     }
   G_timeframe_144 = Period();
   G_time_140 = Time[0];
   Gi_148 = Li_52;
   int Li_64 = TimeZoneOfData + TimeZoneOfSession;
   int Li_68 = 3600 * Li_64;
   datetime time_72 = Time[Li_52];
   double Ld_76 = iATRMQL4(NULL, G_timeframe_92, ATRPeriod, 1);
   if(UseManualADR)
      Ld_76 = ManualADRValuePips * Gd_152;
   double Ld_84 = 0;
   double Ld_92 = 0;
   double Ld_100 = 0;
   double Ld_108 = 0;
   double Ld_116 = 0;
   bool Li_124 = false;
   for(int Li_132 = Li_52; Li_132 >= 0; Li_132--)
     {
      Li_40 = Time[Li_132] - Li_68;
      if(TimeHourMQL4(Li_40) >= Gi_84 && TimeHourMQL4(Li_40) < Gi_88)
        {
         if(Ld_84 == 0.0)
           {
            Ld_84 = open[Li_52];
            Ld_108 = Ld_84 + Ld_76;
            Ld_116 = Ld_84 - Ld_76;
            open_0 = Ld_84;
            open_8 = Ld_84;
           }
         for(int count_136 = 0; count_136 < 3; count_136++)
           {
            switch(count_136)
              {
               case 0:
                  Ld_44 = low[Li_132];
                  break;
               case 1:
                  Ld_44 = high[Li_132];
                  break;
               case 2:
                  Ld_44 = close[Li_132];
              }
            Ld_24 = open_0;
            Ld_32 = open_8;
            Li_128 = Li_124;
            open_0 = MathMax(open_0, Ld_44);
            open_8 = MathMin(open_8, Ld_44);
            Ld_16 = open_0 - open_8;
            Li_124 = Ld_16 >= Ld_76 - Gd_152 / 2.0;
            if((!Li_128) && (!Li_124))
               Ld_108 = open_8 + Ld_76;
            else
              {
               if((!Li_128) && Li_124 && Ld_44 >= Ld_24)
                  Ld_108 = open_8 + Ld_76;
               else
                 {
                  if((!Li_128) && Li_124 && Ld_44 < Ld_24)
                     Ld_108 = Ld_24;
                  else
                     Ld_108 = Ld_108;
                 }
              }
            if((!Li_128) && (!Li_124))
              {
               if(DebugLogger)
                  Print("#: ", Li_132, " ", "adr_low= today_high-adr ", open_0, "-", Ld_76, "= ", open_0 - Ld_76);
               Ld_116 = open_0 - Ld_76;
              }
            else
              {
               if((!Li_128) && Li_124 && Ld_44 >= Ld_32)
                 {
                  if(DebugLogger)
                     Print("#: ", Li_132, " ", "adr_low= today_low", open_8);
                  Ld_116 = open_8;
                 }
               else
                 {
                  if((!Li_128) && Li_124 && Ld_44 < Ld_32)
                    {
                     if(DebugLogger)
                        Print("#: ", Li_132, " ", "adr_low= lasthigh-adr ", Ld_24, "-", Ld_76, "= ", Ld_24 - Ld_76);
                     Ld_116 = Ld_24 - Ld_76;
                    }
                  else
                    {
                     if(DebugLogger)
                        Print("#: ", Li_132, " ", "adr_low= adr_low ", Ld_116);
                     Ld_116 = Ld_116;
                    }
                 }
              }
            Ld_92 = Ld_108 - close[Li_132];
            Ld_100 = close[Li_132] - Ld_116;
            if(DebugLogger)
              {
               Print("#:", Li_132, " ", TimeToString(Li_40, TIME_MINUTES), " high-low/adr-Reached ", open_0 - open_8, "/", Li_124);
               Print("#: ", Li_132, " ", " Price= ", Ld_44, " (k= ", count_136, " [0=low, 1=high, 2=close]])");
               Print("#: ", Li_132, " ", "ADR= ", Ld_76, ", O= ", open_0, ", P= ", open_8, ", Q= ", open_0 - open_8, ", R= ", Li_124, ", S= ", Ld_108, ", T= ", Ld_116, ", U= ",
                     Ld_92, ", V= ", Ld_100);
              }
           }
        }
     }
   if(DebugLogger)
      Print("Timezoned values: t-open= ", Ld_84, ", t-high =", open_0, ", t-low= ", open_8);
   SetTimeLine("today_start", "ADR Start", Li_52, CadetBlue, low[Li_52] - 10.0 * Gd_152);
   int color_144 = LineColor1;
   int Li_148 = LineThickness1;
   if(Li_124)
     {
      color_144 = LineColor2;
      Li_148 = LineThickness2;
     }
   SetLevel("ADR high", Ld_108, color_144, LineStyle, Li_148, time_72);
   SetLevel("ADR low", Ld_116, color_144, LineStyle, Li_148, time_72);
   string Ls_152 = "Yes";
   if(!Li_124)
      Ls_152 = "No";
   string Ls_160 = "ADR 1.00 20051027 01 Mod 01\n" + "ADR Value= " + DoubleToString(MathRound(Ld_76 / Gd_152), 0) + "   | Reached= " + Ls_152 + "   | Today\'s Range= " + DoubleToString(MathRound((open_0 - open_8) / Gd_152), 0) + "   | T\'s high= " + DoubleToString(open_0, Digits) + "   | T\'s low= " + DoubleToString(open_8, Digits)
                   + "\n"
                   + "Target high= " + DoubleToString(Ld_108, Digits) + "   | Target low= " + DoubleToString(Ld_116, Digits) + "   | To ADR high= " + DoubleToString(MathRound(Ld_92 / Gd_152), 0) + "   | To ADR low= " + DoubleToString(MathRound(Ld_100 / Gd_152), 0)
                   + "\n";
   if(showtext)
     {
      Comment(Ls_160);
     }
//---
   return(rates_total);
  }
//+------------------------------------------------------------------+
#define BullishColor clrYellow
#define BearishColor clrDodgerBlue
//$------------------------------------------------------------------$
//| Timer function                                                   |
//$------------------------------------------------------------------$
int stage = 0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTimer()
  {
   if(!timeron)
      return;
//---
   if(GlobalVariableGet("squeeze_" + ChartID()) != 0)
      return;
   if(ArraySize(Time) == 0)
     {
      //Print("Redraw");
      GlobalVariableSet("squeeze_" + ChartID(), Period());
      stage = 1;
      return;
     }
// Print("Timer");
   double Price1 = ObjectGetMQL4("[ADR] ADR high Line", OBJPROP_PRICE1);
//---
//start();
//TradeControlPanel(); DEL ALL
   MqlTick last_tick;
   SymbolInfoTick(_Symbol, last_tick);
   double Ask = last_tick.ask;
   double Bid = last_tick.bid;
   Draw_Label("Info",
              " Spread: " + DoubleToString(0.1 * MathAbs(Ask - Bid) / Point, 1)
              + " , " + " Pips: " + DoubleToString(OrdersPips(), 1)
              + " , " + " Candle Time: " + TimeRemaining(), 10, 0, clrMaroon);
//---
   Draw_Label("LocalTime", "Local Time: " + TimeToString(TimeLocal(), TIME_MINUTES), 10, 20, clrMaroon);
//---
  }
//$------------------------------------------------------------------$
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//Mo Codes Start
//double Stochastic(int i){return(iStochastic(Symbol(),Period(),120,1,20,MODE_SMMA,STO_CLOSECLOSE,MODE_MAIN,i));}
//double Stochastic(int i){return(iStochastic(Symbol(),Period(),Stochastic_D_Period,Stochastic_K_Period,Stochastic_Slowing,Stochastic_MA_Mode,Stochastic_Applied_Price,MODE_MAIN,i));}
double StochasticStrength(int i) {return(iStochasticMQL4(Symbol(), Period(), 14, 3, 3, MODE_SMA, STO_CLOSECLOSE, 0, i));}
//Dash board control
int         Font_Size = 8; //Font Size
color       Text_Color = clrWhite; //Text Color
int         First_Column = 15; //First Column X Shift
int         Second_Column = 80; //Second Column X Shift
int         Third_Column = 120; //Third Column X Shift
int         Y_Shift_Start = 250; //Y Shift Start
int         Y_InterSpace = 18; //Y Inner Lines Space
int         Text_Corner = 0; //Text Corner
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Draw_Mini_Label(string Content1, string Content2 = "", string Content3 = "", int Y_Raw_Index = 0, color TextColor = clrWhite)
  {
   int Y_Distance = Y_Shift_Start + Y_Raw_Index * Y_InterSpace;
   string Object_Name = Content1;
   int Corner = 0;
   ObjectDeleteMQL4(Object_Name + " 1");
   ObjectCreateMQL4(Object_Name + " 1", OBJ_LABEL, 0, 0, 0);
   ObjectSetMQL4(Object_Name + " 1", OBJPROP_CORNER, Corner);
   ObjectSetMQL4(Object_Name + " 1", OBJPROP_XDISTANCE, First_Column);
   ObjectSetMQL4(Object_Name + " 1", OBJPROP_YDISTANCE, Y_Distance);
   ObjectSetMQL4(Object_Name + " 1", OBJPROP_HIDDEN, true);
   ObjectSetMQL4(Object_Name + " 1", OBJPROP_BACK, false);
   ObjectSetMQL4(Object_Name + " 1", OBJPROP_SELECTABLE, false);
   ObjectSetTextMQL4(Object_Name + " 1", Content1, Font_Size, "Arial", clrWhite);
   ObjectDeleteMQL4(Object_Name + " 2");
   ObjectCreateMQL4(Object_Name + " 2", OBJ_LABEL, 0, 0, 0);
   ObjectSetMQL4(Object_Name + " 2", OBJPROP_CORNER, Corner);
   ObjectSetMQL4(Object_Name + " 2", OBJPROP_XDISTANCE, Second_Column);
   ObjectSetMQL4(Object_Name + " 2", OBJPROP_YDISTANCE, Y_Distance);
   ObjectSetMQL4(Object_Name + " 2", OBJPROP_HIDDEN, true);
   ObjectSetMQL4(Object_Name + " 2", OBJPROP_BACK, false);
   ObjectSetMQL4(Object_Name + " 2", OBJPROP_SELECTABLE, false);
   ObjectSetTextMQL4(Object_Name + " 2", Content2, Font_Size, "Arial", TextColor);
   ObjectDeleteMQL4(Object_Name + " 3");
   ObjectCreateMQL4(Object_Name + " 3", OBJ_LABEL, 0, 0, 0);
   ObjectSetMQL4(Object_Name + " 3", OBJPROP_CORNER, Corner);
   ObjectSetMQL4(Object_Name + " 3", OBJPROP_XDISTANCE, Third_Column);
   ObjectSetMQL4(Object_Name + " 3", OBJPROP_YDISTANCE, Y_Distance);
   ObjectSetMQL4(Object_Name + " 3", OBJPROP_HIDDEN, true);
   ObjectSetMQL4(Object_Name + " 3", OBJPROP_BACK, false);
   ObjectSetMQL4(Object_Name + " 3", OBJPROP_SELECTABLE, false);
   ObjectSetTextMQL4(Object_Name + " 3", Content3, Font_Size, "Arial", TextColor);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Timeframe_To_String_(int _period)
  {
   switch(_period)
     {
      case 0:
         return("Current");
      case 1:
         return("M1");
      case 5:
         return("M5");
      case 15:
         return("M15");
      case 30:
         return("M30");
      case 60:
         return("H1");
      case 240:
         return("H4");
      case 1440:
         return("Daily");
      case 10080:
         return("Weekly");
      case 43200:
         return("Monthly");
      default:
         return(DoubleToString(_period, 0));
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Draw_Label(string Object_Name, string Content, int X_Distance, int Y_Distance, color Color)
  {
   ObjectDelete(0, Object_Name);
   ObjectCreate(0, Object_Name, OBJ_LABEL, 0, 0, 0);
   ObjectSetInteger(0, Object_Name, OBJPROP_CORNER, CORNER_RIGHT_LOWER);
   ObjectSetInteger(0, Object_Name, OBJPROP_ANCHOR, ANCHOR_RIGHT_LOWER);
   ObjectSetInteger(0, Object_Name, OBJPROP_XDISTANCE, X_Distance);
   ObjectSetInteger(0, Object_Name, OBJPROP_YDISTANCE, Y_Distance);
   ObjectSetString(0, Object_Name, OBJPROP_TEXT, Content);
   ObjectSetInteger(0, Object_Name, OBJPROP_FONTSIZE, 10);
   ObjectSetInteger(0, Object_Name, OBJPROP_COLOR, Color);
   ObjectSetString(0, Object_Name, OBJPROP_FONT, "Arial");
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Draw_Label_(string Object_Name, string Content, int X_Distance, int Y_Distance, color Color)
  {
   ObjectDelete(0, Object_Name);
   ObjectCreate(0, Object_Name, OBJ_LABEL, 0, 0, 0);
   ObjectSetInteger(0, Object_Name, OBJPROP_CORNER, CORNER_RIGHT_UPPER);
   ObjectSetInteger(0, Object_Name, OBJPROP_ANCHOR, ANCHOR_RIGHT_UPPER);
   ObjectSetInteger(0, Object_Name, OBJPROP_XDISTANCE, X_Distance);
   ObjectSetInteger(0, Object_Name, OBJPROP_YDISTANCE, Y_Distance);
   ObjectSetString(0, Object_Name, OBJPROP_TEXT, Content);
   ObjectSetInteger(0, Object_Name, OBJPROP_FONTSIZE, 10);
   ObjectSetInteger(0, Object_Name, OBJPROP_COLOR, Color);
   ObjectSetString(0, Object_Name, OBJPROP_FONT, "Arial Black");
  }
datetime TerminatorTime;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string TimeRemaining()
  {
//RefreshRates();
   TerminatorTime = iTimeMQL4(Symbol(), Period(), 0) + 1 * Period() * 60;
   datetime TimeRemainingInSeconds = TerminatorTime - TimeCurrent();
   string TimeRemainDisplayed = "";
   if(TimeRemainingInSeconds <= 60)
      TimeRemainDisplayed = IntegerToString(TimeRemainingInSeconds) + " Sec";
   if(TimeRemainingInSeconds > 60  &&  TimeRemainingInSeconds <= 3600)
      TimeRemainDisplayed = IntegerToString(TimeRemainingInSeconds / 60) + " Min " + IntegerToString(TimeRemainingInSeconds % 60) + " Sec";
   if(TimeRemainingInSeconds > 3600 && TimeRemainingInSeconds <= 86400)
      TimeRemainDisplayed = IntegerToString(TimeRemainingInSeconds / 3600) + " Hr " + IntegerToString((TimeRemainingInSeconds % 3600) / 60) + " Min";
   if(TimeRemainingInSeconds > 86400)
      TimeRemainDisplayed = IntegerToString(TimeRemainingInSeconds / 86400) + " Day " + IntegerToString((TimeRemainingInSeconds % 86400) / 3600) + " Hr";
//if(TotalActiveOrders()==0+TotalPairPendingOrders())TimeRemainDisplayed="No Trades";
   return(TimeRemainDisplayed);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//double OrdersPips()
//  {
//   double Pips=0;
//int i;
//for(i=0; i<OrdersTotal(); i++)
//  {
//   if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
//      if(Symbol()==OrderSymbol())
//        {
//         if(OrderType()==ORDER_TYPE_BUY)
//           {
//            Pips+=((Bid-OrderOpenPrice())/(Point*10));
//           }
//         if(OrderType()==ORDER_TYPE_SELL)
//           {
//            Pips+=((OrderOpenPrice()-Ask)/(Point*10));
//           }
//        }
//  }
//   return(Pips);
//  }
double OrdersPips()
  {
   double Pips = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--) // returns the number of current positions
      if(m_position.SelectByIndex(i))
        {
         if(m_position.Symbol() == _Symbol && m_position.PositionType() == POSITION_TYPE_BUY)
           {
            Pips += (m_position.PriceCurrent() - m_position.PriceOpen()) / (_Point * 10);
           }
         if(m_position.Symbol() == _Symbol && m_position.PositionType() == POSITION_TYPE_SELL)
           {
            Pips += (m_position.PriceOpen() - m_position.PriceCurrent()) / (_Point * 10);
           }
        }
   return(Pips);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CreateButtonIcon
(
   string ButtonName, string ButtonText, color TextColor, color BackgroundButtonColor, color ButtonBorderColor
   , int xShift, int yShift, int xSize, int ySize, int FontSize, string FontType1 = "Arial"
)
  {
   ObjectCreate(0, ButtonName, OBJ_BUTTON, 0, 0, 0);
   ObjectSetInteger(0, ButtonName, OBJPROP_XDISTANCE, xShift);
   ObjectSetInteger(0, ButtonName, OBJPROP_YDISTANCE, yShift);
   ObjectSetInteger(0, ButtonName, OBJPROP_XSIZE, xSize);
   ObjectSetInteger(0, ButtonName, OBJPROP_YSIZE, ySize);
   ObjectSetString(0, ButtonName, OBJPROP_TEXT, ButtonText);
   ObjectSetString(0, ButtonName, OBJPROP_FONT, FontType1);
   ObjectSetInteger(0, ButtonName, OBJPROP_COLOR, TextColor);
   ObjectSetInteger(0, ButtonName, OBJPROP_BGCOLOR, BackgroundButtonColor);
   ObjectSetInteger(0, ButtonName, OBJPROP_BORDER_COLOR, ButtonBorderColor);
   ObjectSetInteger(0, ButtonName, OBJPROP_BORDER_TYPE, BORDER_FLAT);
   ObjectSetInteger(0, ButtonName, OBJPROP_BACK, false);
   ObjectSetInteger(0, ButtonName, OBJPROP_HIDDEN, true);
   ObjectSetInteger(0, ButtonName, OBJPROP_STATE, false);
   ObjectSetInteger(0, ButtonName, OBJPROP_FONTSIZE, FontSize);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Draw_HL(string Name, double Value, color Color, int width)
  {
//datetime Time[];
//int count=1;   // number of elements to copy
//ArraySetAsSeries(Time,true);
//CopyTime(_Symbol,_Period,0,count,Time);
   if(ObjectFindMQL4(Name) != 0)
     {
      ObjectCreateMQL4(Name, OBJ_HLINE, 0, 0, Value);
      ObjectSetMQL4(Name, OBJPROP_COLOR, Color);
      ObjectSetMQL4(Name, OBJPROP_WIDTH, width);
      ObjectSetMQL4(Name, OBJPROP_SELECTABLE, false);
      ObjectSetMQL4(Name, OBJPROP_HIDDEN, true);
      ObjectSetMQL4(Name, OBJPROP_BACK, true);
     }
   else
     {
      ObjectMoveMQL4(Name, 0, Time[0], Value);
     }
  }
//$------------------------------------------------------------------$
//OHLCV
double O(int I_Open) {return(iOpenMQL4(sym, per, I_Open));}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double H(int I_High) {return(iHighMQL4(sym, per, I_High));}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double L(int I_Low) {return(iLowMQL4(sym, per, I_Low));}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double C(int I_Close) {return(iCloseMQL4(sym, per, I_Close));}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double M(int I_Median) {return((H(I_Median) + L(I_Median)) / 2);}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double T(int I_Typical) {return((H(I_Typical) + L(I_Typical) + C(I_Typical)) / 3);}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
long   V(int I_Volume) {return(iVolumeMQL4(sym, per, I_Volume));}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double R(int I_ATR) {return(0.3 * iATRMQL4(sym, per, 100, I_ATR));}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double ND(double Value, int Precision) {return(NormalizeDouble(Value, Precision));}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string DTS(double Value, int Precision) {return(DoubleToString(Value, Precision));}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double iMAMQL4(int period, int shift, ENUM_MA_METHOD mode, ENUM_APPLIED_PRICE price, int index) {return(iMAMQL4(Symbol(), Period(), period, shift, mode, price, index));}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double EMA(int period_, int index) {return(iMAMQL4(Symbol(), Period(), period_, 0, MODE_EMA, PRICE_CLOSE, index));}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int BarLimit()
  {
//int Bars=Bars(_Symbol,_Period);
   int AllBars = 0;
   if(Show_All_Bars)
      AllBars = Bars - 100;
   if(!Show_All_Bars)
      AllBars = MathMin(CalculatedBars, Bars - 100);
   return(AllBars);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Timeframe_To_String(int _period)
  {
   switch(_period)
     {
      case 0:
         return("Current");
      case 1:
         return("1M");
      case 5:
         return("5M");
      case 15:
         return("15M");
      case 30:
         return("30M");
      case 60:
         return("1H");
      case 240:
         return("4H");
      case 1440:
         return("D");
      case 10080:
         return("W");
      case 43200:
         return("Mn");
      default:
         return(DoubleToString(_period, 0));
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Draw_Trading_Window_Background()
  {
   if(ObjectFind(0, "Trading_Window_Background_1") < 0)
     {
      ObjectDelete(0, "Trading_Window_Background_1");
      ObjectCreate(0, "Trading_Window_Background_1", OBJ_LABEL, 0, 0, 0);
      ObjectSetInteger(0, "Trading_Window_Background_1", OBJPROP_CORNER, CORNER_RIGHT_UPPER);
      ObjectSetInteger(0, "Trading_Window_Background_1", OBJPROP_ANCHOR, ANCHOR_RIGHT_UPPER);
      ObjectSetInteger(0, "Trading_Window_Background_1", OBJPROP_XDISTANCE, -70);
      ObjectSetInteger(0, "Trading_Window_Background_1", OBJPROP_YDISTANCE, 0);
      ObjectSetTextMQL4("Trading_Window_Background_1", "gg", 100, "Webdings", clrDarkSlateGray);
      ObjectSetMQL4("Trading_Window_Background_1", OBJPROP_SELECTABLE, true);
      ObjectSetMQL4("Trading_Window_Background_1", OBJPROP_HIDDEN, true);
      ObjectSetMQL4("Trading_Window_Background_1", OBJPROP_BACK, false);
      ObjectSetMQL4("Trading_Window_Background_1", OBJPROP_ANGLE, 0);
     }
  }
//$------------------------------------------------------------------$
//Mo Codes End
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//  if(Period1>0) CountZZ(Semafor1UpBuffer,Semafor1DnBuffer,Period1,Dev1,Stp1);
//  if(Period2>0) CountZZ(Semafor2UpBuffer,Semafor2DnBuffer,Period2,Dev2,Stp2);
//  if(Period3>0) CountZZ(Semafor3UpBuffer,Semafor3DnBuffer,Period3,Dev3,Stp3);
//Semafor inputal Functions Start
void CountZZ(double & ExtMapBuffer[], double & ExtMapBuffer2[], int ExtDepth, int ExtDeviation, int ExtBackstep)
  {
   int    shift, back, lasthighpos, lastlowpos;
   double val, res;
   double curlow, curhigh, lasthigh, lastlow;
   for(shift = BarLimit(); shift >= 0; shift--)
     {
      //if(shift+ExtDepth>=BarLimit()){
      //if(iLowest(NULL,0,MODE_LOW,BarLimit()-shift,shift)>BarLimit()){
      //Print("ilowest ",iLowest(NULL,0,MODE_LOW,ExtDepth,shift)," BarLimit() ",BarLimit()," ",ExtDepth," shift=",shift);
      //}
      //val=Low[iLowest(NULL,0,MODE_LOW,BarLimit()-shift,shift)];
      //}
      //else{
      //val=Low[iLowest(NULL,0,MODE_LOW,ExtDepth,shift)];
      //}
      //Print(shift," ",BarLimit()," ",ExtDepth," ",shift);
      //ExtMapBuffer[shift]=0;
      //ExtMapBuffer2[shift]=0;
      if(iLowest(NULL, 0, MODE_LOW, ExtDepth, shift) < 0)
         continue;
      if(iLowest(NULL, 0, MODE_LOW, ExtDepth, shift) <= BarLimit())
        {
         val = Low[iLowest(NULL, 0, MODE_LOW, ExtDepth, shift)]; /////OUT
        }
      else
        {
         // Print("ilowest ",iLowest(NULL,0,MODE_LOW,ExtDepth,shift)," BarLimit() ",BarLimit()," ",ExtDepth," shift=",shift);
         val = Low[BarLimit()];
        }
      if(val == lastlow)
         val = 0.0;
      else
        {
         lastlow = val;
         if((Low[shift] - val) > (ExtDeviation * Point))
            val = 0.0;
         else
           {
            for(back = 1; back <= ExtBackstep; back++)
              {
               res = ExtMapBuffer[shift + back];
               if((res != 0) && (res > val))
                  ExtMapBuffer[shift + back] = 0.0;
              }
           }
        }
      ExtMapBuffer[shift] = val;
      //--- high
      //  val=High[iHighestMQL4(NULL,0,MODE_HIGH,ExtDepth,shift)];
      if(iHighest(NULL, 0, MODE_HIGH, ExtDepth, shift) <= BarLimit())
        {
         val = High[iHighest(NULL, 0, MODE_HIGH, ExtDepth, shift)]; /////OUT
        }
      else
        {
         // Print("ilowest ",iLowest(NULL,0,MODE_LOW,ExtDepth,shift)," BarLimit() ",BarLimit()," ",ExtDepth," shift=",shift);
         val = High[BarLimit()];
        }
      if(val == lasthigh)
         val = 0.0;
      else
        {
         lasthigh = val;
         if((val - High[shift]) > (ExtDeviation * Point))
            val = 0.0;
         else
           {
            for(back = 1; back <= ExtBackstep; back++)
              {
               res = ExtMapBuffer2[shift + back];
               if((res != 0) && (res < val))
                  ExtMapBuffer2[shift + back] = 0.0;
              }
           }
        }
      ExtMapBuffer2[shift] = val;
     }
// final cutting
   lasthigh = -1;
   lasthighpos = -1;
   lastlow = -1;
   lastlowpos = -1;
   for(shift = BarLimit(); shift >= 0; shift--)
     {
      curlow = ExtMapBuffer[shift];
      curhigh = ExtMapBuffer2[shift];
      if((curlow == 0) && (curhigh == 0))
         continue;
      //---
      if(curhigh != 0)
        {
         if(lasthigh > 0)
           {
            if(lasthigh < curhigh)
               ExtMapBuffer2[lasthighpos] = 0;
            else
               ExtMapBuffer2[shift] = 0;
           }
         //---
         if(lasthigh < curhigh || lasthigh < 0)
           {
            lasthigh = curhigh;
            lasthighpos = shift;
           }
         lastlow = -1;
        }
      //----
      if(curlow != 0)
        {
         if(lastlow > 0)
           {
            if(lastlow > curlow)
               ExtMapBuffer[lastlowpos] = 0;
            else
               ExtMapBuffer[shift] = 0;
           }
         //---
         if((curlow < lastlow) || (lastlow < 0))
           {
            lastlow = curlow;
            lastlowpos = shift;
           }
         lasthigh = -1;
        }
     }
   for(shift = BarLimit(); shift >= 0; shift--)
     {
      if(shift >= BarLimit())
         ExtMapBuffer[shift] = 0.0;
      else
        {
         res = ExtMapBuffer2[shift];
         if(res != 0.0)
            ExtMapBuffer2[shift] = res;
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Str2Massive(string VStr, int &M_Count, int &VMass[])
  {
   int val = StringToInteger(VStr);
   if(val > 0)
     {
      M_Count++;
      int mc = ArrayResize(VMass, M_Count);
      if(mc == 0)
         return(-1);
      VMass[M_Count - 1] = val;
      return(1);
     }
   else
      return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int IntFromStr(string ValStr, int &M_Count, int &VMass[])
  {
   if(StringLen(ValStr) == 0)
      return(-1);
   string SS = ValStr;
   int NP = 0;
   string CS;
   M_Count = 0;
   ArrayResize(VMass, M_Count);
   while(StringLen(SS) > 0)
     {
      NP = StringFind(SS, ",");
      if(NP > 0)
        {
         CS = StringSubstr(SS, 0, NP);
         SS = StringSubstr(SS, NP + 1, StringLen(SS));
        }
      else
        {
         if(StringLen(SS) > 0)
           {
            CS = SS;
            SS = "";
           }
        }
      if(Str2Massive(CS, M_Count, VMass) == 0)
        {
         return(-2);
        }
     }
   return(1);
  }
//Semafor inputal Function End
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//Support & Resistance Levels External Start
void SupportResetanceStart()
  {
   if(Period() <= PERIOD_M1 && showM01)
      displayPeriod(PERIOD_M1);
   if(Period() <= PERIOD_M5 && showM05)
      displayPeriod(PERIOD_M5);
   if(Period() <= PERIOD_M15 && showM15)
      displayPeriod(PERIOD_M15);
   if(Period() <= PERIOD_M30 && showM30)
      displayPeriod(PERIOD_M30);
   if(Period() <= PERIOD_H1 && showH01)
      displayPeriod(PERIOD_H1);
   if(Period() <= PERIOD_H4 && showH04)
      displayPeriod(PERIOD_H4);
   if(Period() <= PERIOD_D1 && showD01)
      displayPeriod(PERIOD_D1);
   if(Period() <= PERIOD_W1 && showW01)
      displayPeriod(PERIOD_W1);
   if(Period() <= PERIOD_MN1 && showMN1)
      displayPeriod(PERIOD_MN1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SupportAndResistanceOnInt()
  {
   set_prevBarTime(PERIOD_M1, NULL);
   set_prevBarTime(PERIOD_M5, NULL);
   set_prevBarTime(PERIOD_M15, NULL);
   set_prevBarTime(PERIOD_M30, NULL);
   set_prevBarTime(PERIOD_H1, NULL);
   set_prevBarTime(PERIOD_H4, NULL);
   set_prevBarTime(PERIOD_D1, NULL);
   set_prevBarTime(PERIOD_W1, NULL);
   set_prevBarTime(PERIOD_MN1, NULL);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SupportResetanceDenit()
  {
   string buffer1 = "";
   StringConcatenate(buffer1, getPeriodAsString(PERIOD_M1), " Sup");
   DeleteHLineObject(buffer1);
   string buffer2 = "";
   StringConcatenate(buffer2, getPeriodAsString(PERIOD_M1), " Res");
   DeleteHLineObject(buffer2);
   string buffer3 = "";
   StringConcatenate(buffer3, getPeriodAsString(PERIOD_M1), " Sup C");
   DeleteHLineObject(buffer3);
   string buffer4 = "";
   StringConcatenate(buffer4, getPeriodAsString(PERIOD_M1), " Res C");
   DeleteHLineObject(buffer4);
   string buffer5 = "";
   StringConcatenate(buffer5, getPeriodAsString(PERIOD_M5), " Sup");
   DeleteHLineObject(buffer5);
   string buffer6 = "";
   StringConcatenate(buffer6, getPeriodAsString(PERIOD_M5), " Res");
   DeleteHLineObject(buffer6);
   string buffer7 = "";
   StringConcatenate(buffer7, getPeriodAsString(PERIOD_M5), " Sup C");
   DeleteHLineObject(buffer7);
   string buffer8 = "";
   StringConcatenate(buffer8, getPeriodAsString(PERIOD_M5), " Res C");
   DeleteHLineObject(buffer8);
   string buffer9 = "";
   StringConcatenate(buffer9, getPeriodAsString(PERIOD_M15), " Sup");
   DeleteHLineObject(buffer9);
   string buffer10 = "";
   StringConcatenate(buffer10, getPeriodAsString(PERIOD_M15), " Res");
   DeleteHLineObject(buffer10);
   string buffer11 = "";
   StringConcatenate(buffer11, getPeriodAsString(PERIOD_M15), " Sup C");
   DeleteHLineObject(buffer11);
   string buffer12 = "";
   StringConcatenate(buffer12, getPeriodAsString(PERIOD_M15), " Res C");
   DeleteHLineObject(buffer12);
   string buffer13 = "";
   StringConcatenate(buffer13, getPeriodAsString(PERIOD_M30), " Sup");
   DeleteHLineObject(buffer13);
   string buffer14 = "";
   StringConcatenate(buffer14, getPeriodAsString(PERIOD_M30), " Res");
   DeleteHLineObject(buffer14);
   string buffer15 = "";
   StringConcatenate(buffer15, getPeriodAsString(PERIOD_M30), " Sup C");
   DeleteHLineObject(buffer15);
   string buffer16 = "";
   StringConcatenate(buffer16, getPeriodAsString(PERIOD_M30), " Res C");
   DeleteHLineObject(buffer16);
   string buffer17 = "";
   StringConcatenate(buffer17, getPeriodAsString(PERIOD_H1), " Sup");
   DeleteHLineObject(buffer17);
   string buffer18 = "";
   StringConcatenate(buffer18, getPeriodAsString(PERIOD_H1), " Res");
   DeleteHLineObject(buffer18);
   string buffer19 = "";
   StringConcatenate(buffer19, getPeriodAsString(PERIOD_H1), " Sup C");
   DeleteHLineObject(buffer19);
   string buffer20 = "";
   StringConcatenate(buffer20, getPeriodAsString(PERIOD_H1), " Res C");
   DeleteHLineObject(buffer20);
   string buffer21 = "";
   StringConcatenate(buffer21, getPeriodAsString(PERIOD_H4), " Sup");
   DeleteHLineObject(buffer21);
   string buffer22 = "";
   StringConcatenate(buffer22, getPeriodAsString(PERIOD_H4), " Res");
   DeleteHLineObject(buffer22);
   string buffer23 = "";
   StringConcatenate(buffer23, getPeriodAsString(PERIOD_H4), " Sup C");
   DeleteHLineObject(buffer23);
   string buffer24 = "";
   StringConcatenate(buffer24, getPeriodAsString(PERIOD_H4), " Res C");
   DeleteHLineObject(buffer24);
   string buffer25 = "";
   StringConcatenate(buffer25, getPeriodAsString(PERIOD_D1), " Sup");
   DeleteHLineObject(buffer25);
   string buffer26 = "";
   StringConcatenate(buffer26, getPeriodAsString(PERIOD_D1), " Res");
   DeleteHLineObject(buffer26);
   string buffer27 = "";
   StringConcatenate(buffer27, getPeriodAsString(PERIOD_D1), " Sup C");
   DeleteHLineObject(buffer27);
   string buffer28 = "";
   StringConcatenate(buffer28, getPeriodAsString(PERIOD_D1), " Res C");
   DeleteHLineObject(buffer28);
   string buffer29 = "";
   StringConcatenate(buffer29, getPeriodAsString(PERIOD_W1), " Sup");
   DeleteHLineObject(buffer29);
   string buffer30 = "";
   StringConcatenate(buffer30, getPeriodAsString(PERIOD_W1), " Res");
   DeleteHLineObject(buffer30);
   string buffer31 = "";
   StringConcatenate(buffer31, getPeriodAsString(PERIOD_W1), " Sup C");
   DeleteHLineObject(buffer31);
   string buffer32 = "";
   StringConcatenate(buffer32, getPeriodAsString(PERIOD_W1), " Res C");
   DeleteHLineObject(buffer32);
   string buffer33 = "";
   StringConcatenate(buffer33, getPeriodAsString(PERIOD_MN1), " Sup");
   DeleteHLineObject(buffer33);
   string buffer34 = "";
   StringConcatenate(buffer34, getPeriodAsString(PERIOD_MN1), " Res");
   DeleteHLineObject(buffer34);
   string buffer35 = "";
   StringConcatenate(buffer35, getPeriodAsString(PERIOD_MN1), " Sup C");
   DeleteHLineObject(buffer35);
   string buffer36 = "";
   StringConcatenate(buffer36, getPeriodAsString(PERIOD_MN1), " Res C");
   DeleteHLineObject(buffer36);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Diap(int mt4Period, bool up, int C, int shift)
  {
   int i;
   double MM;
   if(up)
     {
      MM = get_max(mt4Period, shift);
      for(i = 1; i < C; i++)
         if(get_max(mt4Period, shift - i) > MM)
            MM = get_max(mt4Period, shift - i);
     }
   if(!up)
     {
      MM = get_min(mt4Period, shift);
      for(i = 1; i < C; i++)
         if(get_min(mt4Period, shift - i) < MM)
            MM = get_min(mt4Period, shift - i);
     }
   return(MM);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void EmulateDoubleBuffer(double & buffer[], int numBars)
  {
//---- INDICATOR BUFFERS EMULATION
   if(ArraySize(buffer) < numBars)
     {
      ArraySetAsSeries(buffer, false);
      //----
      ArrayResize(buffer, numBars);
      //----
      ArraySetAsSeries(buffer, true);
     }
  }
//+------------------------------------------------------------------+
//|  Custom indicator initialization function                        |
//+------------------------------------------------------------------+
void DeleteHLineObject(string name)
  {
   ObjectDeleteMQL4(name);
   ObjectDeleteMQL4(name + "_Label");
  }
//+------------------------------------------------------------------+
//|  Custom indicator initialization function                        |
//+------------------------------------------------------------------+
void ShowHLineObject(string name, color clr, int style, double dValue, int shift)
  {
   if(ObjectFindMQL4(name) != 0)
     {
      CreateHLineObject(name, clr, style, dValue, shift);
     }
//if(ShowLineLabels)
   if(ArraySize(Time) > 0)
     {
      //datetime Time[];
      //int count=10;   // number of elements to copy
      //ArraySetAsSeries(Time,true);
      //CopyTime(_Symbol,_Period,0,count,Time);
      ObjectSetMQL4(name + "_Label", OBJPROP_PRICE1, dValue);
      ObjectSetMQL4(name + "_Label", OBJPROP_TIME1, Time[0] + Period()*shift);
      ObjectSetMQL4(name + "_Label", OBJPROP_STYLE, style);
     }
   ObjectSetMQL4(name, OBJPROP_PRICE1, dValue);
  }
//+------------------------------------------------------------------+
//|  Custom indicator initialization function                        |
//+------------------------------------------------------------------+
void CreateHLineObject(string name, color clr, int style, double dValue, int shift)
  {
//datetime Time[];
//int count=10;   // number of elements to copy
//ArraySetAsSeries(Time,true);
//CopyTime(_Symbol,_Period,0,count,Time);
//if(ShowLineLabels)
     {
      ObjectCreateMQL4(name + "_Label", OBJ_TEXT, 0, Time[0] + Period()*shift, dValue);
      ObjectSetTextMQL4(name + "_Label", name, 7, "Verdana", clr);
     }
   ObjectCreateMQL4(name, OBJ_HLINE, 0, Time[0], dValue);
   ObjectSetMQL4(name, OBJPROP_STYLE, style);
   ObjectSetMQL4(name, OBJPROP_COLOR, clr);
   ObjectSetMQL4(name, OBJPROP_WIDTH, 1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string getPeriodAsString(int mt4Period)
  {
   string periodname = 0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   switch(mt4Period)
     {
      case PERIOD_M1:
        { periodname = "M1"; break; }
      case PERIOD_M5:
        { periodname = "M5"; break; }
      case PERIOD_M15:
        { periodname = "M15"; break; }
      case PERIOD_M30:
        { periodname = "M30"; break; }
      case PERIOD_H1:
        { periodname = "H1"; break; }
      case PERIOD_H4:
        { periodname = "H4"; break; }
      case PERIOD_D1:
        { periodname = "D1"; break; }
      case PERIOD_W1:
        { periodname = "W1"; break; }
      case PERIOD_MN1:
        { periodname = "MN1"; break; }
     }
   return (periodname);
  }
static datetime prevBarTime_M01 = NULL;
static datetime prevBarTime_M05 = NULL;
static datetime prevBarTime_M15 = NULL;
static datetime prevBarTime_M30 = NULL;
static datetime prevBarTime_H01 = NULL;
static datetime prevBarTime_H04 = NULL;
static datetime prevBarTime_D01 = NULL;
static datetime prevBarTime_W01 = NULL;
static datetime prevBarTime_MN1 = NULL;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void set_prevBarTime(int mt4Period, datetime value)
  {
   switch(mt4Period)
     {
      case PERIOD_M1:
        { prevBarTime_M01 = value; break; }
      case PERIOD_M5:
        { prevBarTime_M05 = value; break; }
      case PERIOD_M15:
        { prevBarTime_M15 = value; break; }
      case PERIOD_M30:
        { prevBarTime_M30 = value; break; }
      case PERIOD_H1:
        { prevBarTime_H01 = value; break; }
      case PERIOD_H4:
        { prevBarTime_H04 = value; break; }
      case PERIOD_D1:
        { prevBarTime_D01 = value; break; }
      case PERIOD_W1:
        { prevBarTime_W01 = value; break; }
      case PERIOD_MN1:
        { prevBarTime_MN1 = value; break; }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime get_prevBarTime(int mt4Period)
  {
   switch(mt4Period)
     {
      case PERIOD_M1:
        { return (prevBarTime_M01); break; }
      case PERIOD_M5:
        { return (prevBarTime_M05); break; }
      case PERIOD_M15:
        { return (prevBarTime_M15); break; }
      case PERIOD_M30:
        { return (prevBarTime_M30); break; }
      case PERIOD_H1:
        { return (prevBarTime_H01); break; }
      case PERIOD_H4:
        { return (prevBarTime_H04); break; }
      case PERIOD_D1:
        { return (prevBarTime_D01); break; }
      case PERIOD_W1:
        { return (prevBarTime_W01); break; }
      case PERIOD_MN1:
        { return (prevBarTime_MN1); break; }
      default:
         return("Unknown Timeframe");
     }
  }
static datetime prevBarCount_M01 = NULL;
static datetime prevBarCount_M05 = NULL;
static datetime prevBarCount_M15 = NULL;
static datetime prevBarCount_M30 = NULL;
static datetime prevBarCount_H01 = NULL;
static datetime prevBarCount_H04 = NULL;
static datetime prevBarCount_D01 = NULL;
static datetime prevBarCount_W01 = NULL;
static datetime prevBarCount_MN1 = NULL;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void set_prevBarCount(int mt4Period, int value)
  {
   switch(mt4Period)
     {
      case PERIOD_M1:
        { prevBarCount_M01 = value; break; }
      case PERIOD_M5:
        { prevBarCount_M05 = value; break; }
      case PERIOD_M15:
        { prevBarCount_M15 = value; break; }
      case PERIOD_M30:
        { prevBarCount_M30 = value; break; }
      case PERIOD_H1:
        { prevBarCount_H01 = value; break; }
      case PERIOD_H4:
        { prevBarCount_H04 = value; break; }
      case PERIOD_D1:
        { prevBarCount_D01 = value; break; }
      case PERIOD_W1:
        { prevBarCount_W01 = value; break; }
      case PERIOD_MN1:
        { prevBarCount_MN1 = value; break; }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int get_prevBarCount(int mt4Period)
  {
   switch(mt4Period)
     {
      case PERIOD_M1:
        { return (prevBarCount_M01); break; }
      case PERIOD_M5:
        { return (prevBarCount_M05); break; }
      case PERIOD_M15:
        { return (prevBarCount_M15); break; }
      case PERIOD_M30:
        { return (prevBarCount_M30); break; }
      case PERIOD_H1:
        { return (prevBarCount_H01); break; }
      case PERIOD_H4:
        { return (prevBarCount_H04); break; }
      case PERIOD_D1:
        { return (prevBarCount_D01); break; }
      case PERIOD_W1:
        { return (prevBarCount_W01); break; }
      case PERIOD_MN1:
        { return (prevBarCount_MN1); break; }
      default:
         return("Unknown Timeframe");
     }
  }
double TLBMax_M01[];
double TLBMax_M05[];
double TLBMax_M15[];
double TLBMax_M30[];
double TLBMax_H01[];
double TLBMax_H04[];
double TLBMax_D01[];
double TLBMax_W01[];
double TLBMax_MN1[];
double TLBMin_M01[];
double TLBMin_M05[];
double TLBMin_M15[];
double TLBMin_M30[];
double TLBMin_H01[];
double TLBMin_H04[];
double TLBMin_D01[];
double TLBMin_W01[];
double TLBMin_MN1[];
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void set_max(int mt4Period, int shift, double value)
  {
   switch(mt4Period)
     {
      case PERIOD_M1:
        { TLBMax_M01[ shift ] = value; break; }
      case PERIOD_M5:
        { TLBMax_M05[ shift ] = value; break; }
      case PERIOD_M15:
        { TLBMax_M15[ shift ] = value; break; }
      case PERIOD_M30:
        { TLBMax_M30[ shift ] = value; break; }
      case PERIOD_H1:
        { TLBMax_H01[ shift ] = value; break; }
      case PERIOD_H4:
        { TLBMax_H04[ shift ] = value; break; }
      case PERIOD_D1:
        { TLBMax_D01[ shift ] = value; break; }
      case PERIOD_W1:
        { TLBMax_W01[ shift ] = value; break; }
      case PERIOD_MN1:
        { TLBMax_MN1[ shift ] = value; break; }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double get_max(int mt4Period, int shift)
  {
   if(shift < 0)
     {
      shift = 0;
     }
   switch(mt4Period)
     {
      case PERIOD_M1:
        { return(TLBMax_M01[shift]); break; }
      //case PERIOD_M1:  {
      //if(shift>ArraySize(TLBMax_M01)){
      //Print("shift=",shift,"arr= ",ArraySize(TLBMax_M01));
      //return(TLBMax_M01[ ArraySize(TLBMax_M01)-1 ]);
      //break;
      //}else{
      // return(TLBMax_M01[ shift ]);
      //  break;
      //  }
      // }
      case PERIOD_M5:
        { return(TLBMax_M05[ shift ]); break; }
      case PERIOD_M15:
        { return(TLBMax_M15[ shift ]); break; }
      case PERIOD_M30:
        { return(TLBMax_M30[ shift ]); break; }
      case PERIOD_H1:
        { return(TLBMax_H01[ shift ]); break; }
      // case PERIOD_H1:  {
      //if(shift>ArraySize(TLBMax_H01)){
      //Print("shift=",shift,"arr= ",ArraySize(TLBMax_H01));
      //return(TLBMax_H01[ ArraySize(TLBMax_H01)-1 ]);
      //break;
      //}else{
      //Print("H1 ",ArraySize(TLBMax_H01)," ",shift);
      // return(TLBMax_H01[ shift ]);
      //  break;
      //  }
      // }
      case PERIOD_H4:
        { return(TLBMax_H04[ shift ]); break; }
      case PERIOD_D1:
        { return(TLBMax_D01[ shift ]); break; }
      case PERIOD_W1:
        { return(TLBMax_W01[ shift ]); break; }
      //case PERIOD_W1:  {
      //if(shift>ArraySize(TLBMax_W01)){
      //Print("shift=",shift,"arr= ",ArraySize(TLBMax_W01));
      //return(TLBMax_W01[ ArraySize(TLBMax_W01)-1 ]);
      //break;
      //}else{
      // return(TLBMax_W01[ shift ]);
      //  break;
      //  }
      // }
      case PERIOD_MN1:
        { return(TLBMax_MN1[shift]); break; }
      default:
         return("Unknown Timeframe");
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void set_min(int mt4Period, int shift, double value)
  {
   switch(mt4Period)
     {
      case PERIOD_M1:
        { TLBMin_M01[ shift ] = value; break; }
      case PERIOD_M5:
        { TLBMin_M05[ shift ] = value; break; }
      case PERIOD_M15:
        { TLBMin_M15[ shift ] = value; break; }
      case PERIOD_M30:
        { TLBMin_M30[ shift ] = value; break; }
      case PERIOD_H1:
        { TLBMin_H01[ shift ] = value; break; }
      case PERIOD_H4:
        { TLBMin_H04[ shift ] = value; break; }
      case PERIOD_D1:
        { TLBMin_D01[ shift ] = value; break; }
      case PERIOD_W1:
        { TLBMin_W01[ shift ] = value; break; }
      case PERIOD_MN1:
        { TLBMin_MN1[ shift ] = value; break; }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double get_min(int mt4Period, int shift)
  {
   if(shift < 0)
     {
      shift = 0;
     }
   switch(mt4Period)
     {
      case PERIOD_M1:
        { return(TLBMin_M01[ shift ]); break; }
      case PERIOD_M5:
        { return(TLBMin_M05[ shift ]); break; }
      case PERIOD_M15:
        { return(TLBMin_M15[ shift ]); break; }
      case PERIOD_M30:
        { return(TLBMin_M30[ shift ]); break; }
      case PERIOD_H1:
        { return(TLBMin_H01[ shift ]); break; }
      case PERIOD_H4:
        { return(TLBMin_H04[ shift ]); break; }
      case PERIOD_D1:
        { return(TLBMin_D01[ shift ]); break; }
      case PERIOD_W1:
        { return(TLBMin_W01[ shift ]); break; }
      case PERIOD_MN1:
        { return(TLBMin_MN1[ shift ]); break; }
      default:
         return("Unknown Timeframe");
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void emulate_tlbmaxmin(int mt4Period, int numBars)
  {
   switch(mt4Period)
     {
      case PERIOD_M1:
        { EmulateDoubleBuffer(TLBMax_M01, numBars); EmulateDoubleBuffer(TLBMin_M01, numBars); break; }
      case PERIOD_M5:
        { EmulateDoubleBuffer(TLBMax_M05, numBars); EmulateDoubleBuffer(TLBMin_M05, numBars); break; }
      case PERIOD_M15:
        { EmulateDoubleBuffer(TLBMax_M15, numBars); EmulateDoubleBuffer(TLBMin_M15, numBars); break; }
      case PERIOD_M30:
        { EmulateDoubleBuffer(TLBMax_M30, numBars); EmulateDoubleBuffer(TLBMin_M30, numBars); break; }
      case PERIOD_H1:
        { EmulateDoubleBuffer(TLBMax_H01, numBars); EmulateDoubleBuffer(TLBMin_H01, numBars); break; }
      case PERIOD_H4:
        { EmulateDoubleBuffer(TLBMax_H04, numBars); EmulateDoubleBuffer(TLBMin_H04, numBars); break; }
      case PERIOD_D1:
        { EmulateDoubleBuffer(TLBMax_D01, numBars); EmulateDoubleBuffer(TLBMin_D01, numBars); break; }
      case PERIOD_W1:
        { EmulateDoubleBuffer(TLBMax_W01, numBars); EmulateDoubleBuffer(TLBMin_W01, numBars); break; }
      case PERIOD_MN1:
        { EmulateDoubleBuffer(TLBMax_MN1, numBars); EmulateDoubleBuffer(TLBMin_MN1, numBars); break; }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void displayPeriod(int mt4Period)
  {
   if(get_prevBarTime(mt4Period) == NULL || get_prevBarTime(mt4Period) != iTimeMQL4(Symbol(), mt4Period, 0) ||
      get_prevBarCount(mt4Period) == NULL || get_prevBarCount(mt4Period) != iBarsMQL4(Symbol(), mt4Period))
     {
      set_prevBarTime(mt4Period, iTimeMQL4(Symbol(), mt4Period, 0));
      set_prevBarCount(mt4Period, iBarsMQL4(Symbol(), mt4Period));
     }
   else
      return;
   int numBars = iBarsMQL4(Symbol(), mt4Period);
   if(maxBarsForPeriod > 0 && numBars > maxBarsForPeriod)
      numBars = maxBarsForPeriod;
   if(numBars == 0)
      numBars = maxBarsForPeriod;
// numBars=maxBarsForPeriod;
   int TLBBuffShift = 0;
   int limit = numBars;
   emulate_tlbmaxmin(mt4Period, numBars);
   int i, j;
   j = 1;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   while(iCloseMQL4(Symbol(), mt4Period, limit - 1) == iCloseMQL4(Symbol(), mt4Period, limit - 1 - j))
     {
      j++;
      if(j > limit - 1)
         break;
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(iCloseMQL4(Symbol(), mt4Period, limit - 1) > iCloseMQL4(Symbol(), mt4Period, limit - 1 - j))
     {
      set_max(mt4Period, 0, iCloseMQL4(Symbol(), mt4Period, limit - 1));
      set_min(mt4Period, 0, iCloseMQL4(Symbol(), mt4Period, limit - 1 - j));
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(iCloseMQL4(Symbol(), mt4Period, limit - 1) < iCloseMQL4(Symbol(), mt4Period, limit - 1 - j))
     {
      set_max(mt4Period, 0, iCloseMQL4(Symbol(), mt4Period, limit - 1 - j));
      set_min(mt4Period, 0, iCloseMQL4(Symbol(), mt4Period, limit - 1));
     }
   for(i = 1; i < LB; i++)
      //+------------------------------------------------------------------+
      //|                                                                  |
      //+------------------------------------------------------------------+
     {
      while(iCloseMQL4(Symbol(), mt4Period, limit - j) <= Diap(mt4Period, true, i, TLBBuffShift) && iCloseMQL4(Symbol(), mt4Period, limit - j) >= Diap(mt4Period, false, i, TLBBuffShift))
        {
         j++;
         if(j > limit - 1)
            break;
        }
      if(j > limit - 1)
         break;
      if(iCloseMQL4(Symbol(), mt4Period, limit - j) > get_max(mt4Period, i - 1))
        {
         set_max(mt4Period, i, iCloseMQL4(Symbol(), mt4Period, limit - j));
         set_min(mt4Period, i, get_max(mt4Period, i - 1));
         TLBBuffShift++;
        }
      if(iCloseMQL4(Symbol(), mt4Period, limit - j) < get_min(mt4Period, i - 1))
        {
         set_min(mt4Period, i, iCloseMQL4(Symbol(), mt4Period, limit - j));
         set_max(mt4Period, i, get_min(mt4Period, i - 1));
         TLBBuffShift++;
        }
     }
   for(i = LB; i < limit; i++)
      //+------------------------------------------------------------------+
      //|                                                                  |
      //+------------------------------------------------------------------+
     {
      while(iCloseMQL4(Symbol(), mt4Period, limit - j) <= Diap(mt4Period, true, LB, TLBBuffShift) && iCloseMQL4(Symbol(), mt4Period, limit - j) >= Diap(mt4Period, false, LB, TLBBuffShift))
        {
         j++;
         if(j > limit - 1)
            break;
        }
      if(j > limit - 1)
         break;
      if(iCloseMQL4(Symbol(), mt4Period, limit - j) > get_max(mt4Period, i - 1))
        {
         set_max(mt4Period, i, iCloseMQL4(Symbol(), mt4Period, limit - j));
         set_min(mt4Period, i, get_max(mt4Period, i - 1));
         TLBBuffShift++;
        }
      if(iCloseMQL4(Symbol(), mt4Period, limit - j) < get_min(mt4Period, i - 1))
        {
         set_min(mt4Period, i, iCloseMQL4(Symbol(), mt4Period, limit - j));
         set_max(mt4Period, i, get_min(mt4Period, i - 1));
         TLBBuffShift++;
        }
     }
   double sup = 0, res = 0, supc = 0, resc = 0;
   int redCnt = 0, blueCnt = 0;
   int numObj = 0;
   for(i = 1; i <= TLBBuffShift; i++)
      //+------------------------------------------------------------------+
      //|                                                                  |
      //+------------------------------------------------------------------+
     {
      if(get_max(mt4Period, i) > get_max(mt4Period, i - 1))
        {
         if(blueCnt >= LB)
            sup = get_max(mt4Period, i - LB);
         else
            sup = get_min(mt4Period, i - blueCnt - 1);
         resc = get_max(mt4Period, i);
         supc = 0;
         res = 0;
         blueCnt++;
         redCnt = 0;
        }
      if(get_max(mt4Period, i) < get_max(mt4Period, i - 1))
        {
         if(redCnt >= LB)
            res = get_min(mt4Period, i - LB);
         else
            res = get_max(mt4Period, i - redCnt - 1);
         supc = get_min(mt4Period, i);
         sup = 0;
         resc = 0;
         blueCnt = 0;
         redCnt++;
        }
     }
   if(sup > 0.0)
     {
      string buffer;
      StringConcatenate(buffer, getPeriodAsString(mt4Period), " Sup");
      ShowHLineObject(buffer, Blue, STYLE_SOLID, sup, 500);
     }
   else
     {
      string buffer01;
      StringConcatenate(buffer01, getPeriodAsString(mt4Period), " Sup");
      DeleteHLineObject(buffer01);
     }
   if(res > 0.0)
     {
      string buffer;
      StringConcatenate(buffer, getPeriodAsString(mt4Period), " Res");
      ShowHLineObject(buffer, Red, STYLE_SOLID, res, 500);
     }
   else
     {
      string buffer;
      StringConcatenate(buffer, getPeriodAsString(mt4Period), " Res");
      DeleteHLineObject(buffer);
     }
   if(supc > 0.0)
     {
      string buffer;
      StringConcatenate(buffer, getPeriodAsString(mt4Period), " Sup C");
      ShowHLineObject(buffer, Blue, STYLE_DASHDOTDOT, supc, 1200);
     }
   else
     {
      string buffer;
      StringConcatenate(buffer, getPeriodAsString(mt4Period), " Sup C");
      DeleteHLineObject(buffer);
     }
   if(resc > 0.0)
     {
      string buffer;
      StringConcatenate(buffer, getPeriodAsString(mt4Period), " Res C");
      ShowHLineObject(buffer, Red, STYLE_DASHDOTDOT, resc, 1200);
     }
   else
     {
      string buffer;
      StringConcatenate(buffer, getPeriodAsString(mt4Period), " Res C");
      DeleteHLineObject(buffer);
     }
  }
//Support & Resistance Levels External End
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//Pair Changer External Start
void createButton(string name, string caption, int xpos, int ypos)
  {
   if(ObjectFindMQL4(name) != 0)
      ObjectCreateMQL4(name, OBJ_BUTTON, 0, 0, 0);
   ObjectSetMQL4(name, OBJPROP_CORNER, 0);
   ObjectSetMQL4(name, OBJPROP_XDISTANCE, xpos);
   ObjectSetMQL4(name, OBJPROP_YDISTANCE, ypos);
   ObjectSetMQL4(name, OBJPROP_XSIZE, XSize);
   ObjectSetMQL4(name, OBJPROP_YSIZE, YSize);
   ObjectSetTextMQL4(name, caption, FSize, FontType, Tncolor);
   ObjectSetMQL4(name, OBJPROP_FONTSIZE, FSize);
   ObjectSetMQL4(name, OBJPROP_BORDER_TYPE, BORDER_FLAT);
   ObjectSetMQL4(name, OBJPROP_COLOR, Tncolor);
   ObjectSetMQL4(name, OBJPROP_BGCOLOR, Bcolor);
   ObjectSetMQL4(name, OBJPROP_BACK, Transparent);
   ObjectSetMQL4(name, OBJPROP_BORDER_COLOR, Dcolor);
   ObjectSetMQL4(name, OBJPROP_STATE, false);
   ObjectSetMQL4(name, OBJPROP_HIDDEN, true);
   ObjectSetMQL4(name, OBJPROP_CORNER, Corner);
  }
//+------------------------------------------------------------------+
void setSymbolButtonColor()
  {
   string lookFor       = UniqueID + ":symbol:";
   int    lookForLength = StringLen(lookFor);
   for(int i = ObjectsTotalMQL4() - 1; i >= 0; i--)
      //+------------------------------------------------------------------+
      //|                                                                  |
      //+------------------------------------------------------------------+
     {
      string ObjectNameMQL4 = ObjectNameMQL4(i);
      if(StringSubstr(ObjectNameMQL4, 0, lookForLength) == lookFor)
        {
         string symbol = ObjectGetString(0, ObjectNameMQL4, OBJPROP_TEXT);
         if(symbol != _Symbol)
            ObjectSetMQL4(ObjectNameMQL4, OBJPROP_COLOR, Tncolor);
         else
            ObjectSetMQL4(ObjectNameMQL4, OBJPROP_COLOR, Sncolor);
        }
     }
  }
//+------------------------------------------------------------------+
void setTimeFrameButtonColor()
  {
   string lookFor       = UniqueID + ":time:";
   int    lookForLength = StringLen(lookFor);
   for(int i = ObjectsTotalMQL4() - 1; i >= 0; i--)
      //+------------------------------------------------------------------+
      //|                                                                  |
      //+------------------------------------------------------------------+
     {
      string ObjectName = ObjectNameMQL4(i);
      if(StringSubstr(ObjectName, 0, lookForLength) == lookFor)
        {
         int time = stringToTimeFrame(ObjectGetString(0, ObjectName, OBJPROP_TEXT));
         if(time != _Period)
            ObjectSetMQL4(ObjectName, OBJPROP_COLOR, Tncolor);
         else
            ObjectSetMQL4(ObjectName, OBJPROP_COLOR, Sncolor);
        }
     }
  }
//+------------------------------------------------------------------+
string sTfTable[] = {};
int    iTfTable[] = {1, 5, 15, 30, 60, 240, 1440, 10080, 43200};
//+------------------------------------------------------------------+
string timeFrameToString(int tf)
  {
   for(int i = ArraySize(iTfTable) - 1; i >= 0; i--)
      if(tf == iTfTable[i])
         return(sTfTable[i]);
   return("");
  }
//+------------------------------------------------------------------+
int stringToTimeFrame(string tf)
  {
   for(int i = ArraySize(sTfTable) - 1; i >= 0; i--)
      if(tf == sTfTable[i])
         return(iTfTable[i]);
   return(0);
  }
//+------------------------------------------------------------------+
void OnChartEvent(const int id, const long & lparam, const double & dparam, const string & sparam)
  {
   if(id == CHARTEVENT_OBJECT_CLICK && ObjectGetMQL4(sparam, OBJPROP_TYPE) == OBJ_BUTTON)
     {
      if(StringFind(sparam, UniqueID + ":symbol:", 0) == 0)
         ChartSetSymbolPeriod(0, ObjectGetString(0, sparam, OBJPROP_TEXT), _Period);
      if(StringFind(sparam, UniqueID + ":time:", 0) == 0)
         ChartSetSymbolPeriod(0, _Symbol, TFMigrate(stringToTimeFrame(ObjectGetString(0, sparam, OBJPROP_TEXT))));
      if(StringFind(sparam, UniqueID + ":back:", 0) == 0)
         ObjectSetMQL4(sparam, OBJPROP_STATE, false);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//void PairChangerOnInt()
//  {
//   string Symbolsb=StringTrimRight(Symbols);
//   Symbols=StringTrimLeft(Symbolsb);
//   if(StringSubstr(Symbols,StringLen(Symbols)-1,1)!=";")
//     {
//      StringConcatenate(Symbols,Symbols,";");
//
//     }
//
//   int s=0,i=StringFind(Symbols,";",s);
//   string current;
//   while(i>0)
//     {
//      current=StringSubstr(Symbols,s,i-s);
//      ArrayResize(aSymbols,ArraySize(aSymbols)+1);
//      aSymbols[ArraySize(aSymbols)-1]=current;
//      s = i + 1;
//      i = StringFind(Symbols,";",s);
//     }
//
//   int xpos=0,ypos=0,maxx=0,maxy=0;
//   for(i=0; i<ArraySize(aSymbols); i++)
//     { if(i>0 && MathMod(i,ButtonsInARow)==0) { xpos=0; ypos+=YSize+1; } createButton(UniqueID+":symbol:"+string(i),aSymbols[i],XShift+xpos,YShift+ypos); xpos+=XSize+1; }
//   xpos=0; ypos+=YSize*2;
//   for(i=0; i<ArraySize(sTfTable); i++)
//     { if(i>0 && MathMod(i,ButtonsInARow)==0) { xpos=0; ypos+=YSize+1; } createButton(UniqueID+":time:"+string(i),sTfTable[i],XShift+xpos,YShift+ypos); xpos+=XSize+1; }
//
//   setSymbolButtonColor();
//   setTimeFrameButtonColor();
//  }
//Pair Changer External End
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
////+------------------------------------------------------------------+
////+------------------------------------------------------------------+
////Currency Strngth External Function Start
//// D1DDCE31F1A86B3140880F6B1877CBF8
//int f0_11(string As_0,int Ai_8,int Ai_12,int Ai_16,int Ai_20=1,int Ai_24=1,int Ai_28=0,int Ai_32=0,int Ai_36=0,int Ai_40=0,int Ai_44=0,string As_48="",int Ai_56=16777215)
//  {
//   int Li_60;
//   int Li_64;
//   string Ls_68;
//   int Li_76;
//   if(Ai_40!=0 && Ai_40!=1) Ai_40=0;
//   if(Ai_44<0) Ai_44=0;
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//   if(As_48!="")
//     {
//      if(f0_7(As_48))
//        {
//         Ai_12 += Gia_156[0];
//         Ai_16 += Gia_156[1];
//         Ai_40 = Gia_156[6];
//         Ai_44 = Gia_156[8];
//         Ai_32+= Gia_156[4];
//         Li_60 = Gia_156[9] + 1;
//        }
//     }
//   Gia_168[0] = Ai_12;
//   Gia_168[1] = Ai_16;
//   Gia_168[2] = Ai_12 + Ai_20 * Gia_172[Ai_28] - 1;
//   Gia_168[3] = Ai_16 + Ai_24 * Gia_172[Ai_28] - (Ai_24 * 2 - 1);
//   Gia_168[6] = Ai_32;
//   Gia_168[9] = Ai_8;
//   int Li_80 = 1;
//   int Li_84 = Gia_172[Ai_28] - 2;
//   int Li_88 = Gia_176[Ai_28];
//   string Ls_92="";
//   string Ls_100="g";
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//   if(Ai_20==1 && Ai_24==1)
//     {
//      Gia_168[4] = 0;
//      Gia_168[5] = 0;
//      Gia_168[7] = Li_60;
//      Gia_168[8] = Li_60;
//      Ls_92=f0_3(As_0,Gia_168,As_48);
//      if(!f0_0(Ls_92,Gia_168[0],Gia_168[1]+Gia_184[Ai_28],Ls_100,Li_88,Ai_40,Ai_56,Ai_44)) Print(GetLastError());
//      if(Ai_36 == Ai_56) return (0);
//      Gia_168[4] = 0;
//      Gia_168[5] = 1;
//      Gia_168[7] = Li_60;
//      Gia_168[8] = Li_60 + 1;
//      Ls_92=f0_3(As_0,Gia_168,As_48);
//      if(!f0_0(Ls_92,Gia_168[0]+Li_80,Gia_168[1]+Li_80+Gia_184[Ai_28],Ls_100,Li_88-Li_80,Ai_40,Ai_36,Ai_44)) Print(GetLastError());
//        } else {
//      //+------------------------------------------------------------------+
//      //|                                                                  |
//      //+------------------------------------------------------------------+
//      for(int Li_108=1; Li_108<Ai_20; Li_108++) Ls_100=Ls_100+"g";
//      for(int count_112=0; count_112<Ai_24; count_112++)
//        {
//         Gia_168[4] = Li_64 / 10;
//         Gia_168[5] = Li_64 % 10;
//         Gia_168[7] = Li_60;
//         Gia_168[8] = Li_60;
//         Ls_92=f0_3(As_0,Gia_168,As_48);
//         if(!f0_0(Ls_92,Gia_168[0],Gia_168[1]+Li_84*count_112+Gia_184[Ai_28],Ls_100,Li_88,Ai_40,Ai_56,Ai_44)) Print(GetLastError());
//         Li_64++;
//        }
//      if(Ai_36 == Ai_56) return (0);
//      Gia_168[7] = Li_60;
//      Gia_168[8] = Li_60 + 1;
//      for(count_112=0; count_112<Ai_24; count_112++)
//        {
//         if(Ai_20>1)
//           {
//            Gia_168[4] = Li_64 / 10;
//            Gia_168[5] = Li_64 % 10;
//            Ls_92 = f0_3(As_0, Gia_168, As_48);
//            Ls_68 = "g";
//            Li_76 = Ai_20 / 10 + 1;
//            for(int count_116=0; count_116<Li_76; count_116++) Ls_68=Ls_68+"g";
//            if(!f0_0(Ls_92,Gia_168[0]+Li_80,Gia_168[1]+(Li_84*count_112-count_112)+Gia_184[Ai_28]+Ai_24,Ls_68,Li_88-Li_80,Ai_40,Ai_36,Ai_44)) Print(GetLastError());
//            Li_64++;
//           }
//         Gia_168[4] = Li_64 / 10;
//         Gia_168[5] = Li_64 % 10;
//         Ls_92=f0_3(As_0,Gia_168,As_48);
//         if(!f0_0(Ls_92,Gia_168[0]+(Ai_20*2-Li_80),Gia_168[1]+(Li_84*count_112-count_112)+Gia_184[Ai_28]+Ai_24,Ls_100,Li_88-Li_80,Ai_40,Ai_36,Ai_44)) Print(GetLastError());
//         Li_64++;
//        }
//      if(Ai_24 < 2) return (0);
//      for(count_116=0; count_116<=Ai_24/Li_84; count_116++)
//        {
//         Gia_168[4] = Li_64 / 10;
//         Gia_168[5] = Li_64 % 10;
//         Ls_92=f0_3(As_0,Gia_168,As_48);
//         if(!f0_0(Ls_92,Gia_168[0]+Ai_20*2-Li_80,Gia_168[1]+Li_80+Gia_184[Ai_28]+(Li_84-1)*count_116,Ls_100,Li_88-Li_80,Ai_40,Ai_36,Ai_44)) Print(GetLastError());
//         Li_64++;
//         if(Ai_20>1)
//           {
//            Gia_168[4] = Li_64 / 10;
//            Gia_168[5] = Li_64 % 10;
//            Ls_92 = f0_3(As_0, Gia_168, As_48);
//            Ls_68 = "g";
//            Li_76 = Ai_20 / 10 + 1;
//            for(int count_120=0; count_120<Li_76; count_120++) Ls_68=Ls_68+"g";
//            if(!f0_0(Ls_92,Gia_168[0]+Li_80,Gia_168[1]+Li_80+Gia_184[Ai_28]+(Li_84-1)*count_116,Ls_68,Li_88-Li_80,Ai_40,Ai_36,Ai_44)) Print(GetLastError());
//            Li_64++;
//           }
//        }
//     }
//   return (0);
//  }
//// 2569208C5E61CB15E209FFE323DB48B7
//int f0_1(string As_0,string As_8,int Ai_16,string As_20,string As_28,int Ai_36,bool Ai_40=true,int Ai_44=0,int Ai_48=0,int Ai_52=0,int Ai_56=0,int Ai_60=0,int Ai_64=0,int Ai_68=0)
//  {
//   int Li_unused_72;
//   double Ld_76;
//   double Ld_84;
//   int Lia_92[19]= {10,14,20,26,32,35,41,50,56,62,65,68,71,74,77,86,89,92,95};
//   int Lia_96[7] = {0,3,2,3,2,3,4};
//   int Li_100 = 0;
//   int Li_104 = 0;
//   int Li_108 = 0;
//   int Li_unused_112=0;
//   int Li_116 = 0;
//   int Li_120 = 0;
//   int Li_unused_124=0;
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//   if(As_8!="")
//     {
//      if(f0_7(As_8))
//        {
//         Ai_60 = Gia_156[6];
//         Ai_64 = Gia_156[8];
//         Li_100 = Gia_156[0];
//         Li_104 = Gia_156[1];
//         Li_108 = Gia_156[2];
//         Li_116+= Gia_156[4] + 1;
//         Li_120 = Gia_156[9] + 1;
//         Ai_60 = Gia_156[6];
//         Ai_64 = Gia_156[8];
//         Li_unused_72=Gia_156[5];
//         if(Ai_56==0) Ai_56=Lia_92[Ai_52];
//         if(Ai_40)
//           {
//            Ld_76 = StringLen(As_20) * Ai_56 / 1.6;
//            Ld_84 = Li_108 - Li_100;
//            Ai_44 = Li_100 + (Ld_84 - Ld_76) / 2.0 + Ai_44;
//            Ai_48 = Li_104 + Lia_96[Ai_52];
//            if(As_28=="Webdings")
//              {
//               if(Ai_52==0)
//                 {
//                  Ai_56 = 11;
//                  Ai_44 = Li_100;
//                  Ai_48 = Li_104 - 3;
//                    } else {
//                  Ai_56 = 20;
//                  Ai_44 = Li_100 - 2;
//                  Ai_48 = Li_104 - 4;
//                 }
//                 } else {
//               if(As_28=="Wingdings")
//                 {
//                  Ai_56 = 11;
//                  Ai_44 = Li_100 + 1;
//                  Ai_48 = Li_104 + 2;
//                 }
//              }
//              } else {
//            Ai_44 += Li_100;
//            Ai_48 += Li_104;
//           }
//        }
//     }
//   Gia_168[0] = Ai_44;
//   Gia_168[1] = Ai_48;
//   Gia_168[6] = Li_116;
//   Gia_168[7] = Li_120;
//   Gia_168[8] = Li_120;
//   Gia_168[9] = Ai_16;
//   As_0=f0_3(As_0,Gia_168,As_8);
//   if(!f0_0(As_0, Ai_44, Ai_48, As_20, Ai_56, Ai_60, Ai_36, Ai_64, As_28, Ai_68)) return (GetLastError());
//   return (0);
//  }
//// 50257C26C4E5E915F022247BABD914FE
//int f0_2(string As_0,int Ai_8,int Ai_12,int Ai_16,int Ai_20=3,int Ai_24=1,int Ai_28=1,int Ai_32=0,int Ai_36=7346457,int Ai_40=0,int Ai_44=0,string As_48="",int Ai_56=16777215)
//  {
//   string Ls_60;
//   string Ls_unused_68;
//   int Li_76;
//   int Li_80;
//   int Li_84;
//   if(Ai_8 < 70 || Ai_8 > 75) return (1);
//   if(Ai_36 == 0) Ai_36 = 9109504;
//   if(Ai_28<= 1) Ai_28 = 1;
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//   switch(Ai_8)
//     {
//      case 70:
//         if(Ai_20<3) Ai_20=3;
//         f0_11(As_0,Ai_8,Ai_12,Ai_16,Ai_20,Ai_24,Ai_28,Ai_32,Ai_36,Ai_40,Ai_44,As_48,Ai_56);
//         break;
//      case 71:
//         if(Ai_20<3) Ai_20=3;
//         f0_11(As_0,Ai_8,Ai_12,Ai_16,Ai_20,Ai_24,Ai_28,Ai_32,Ai_36,Ai_40,Ai_44,As_48,Ai_56);
//         if(Ai_40==0) Li_76=Gia_168[2]-Gia_168[0]-(7 *(Ai_28-1)+19);
//         else Li_76=4;
//         Ls_60=StringSubstr(As_0,0,2)+"CL"+StringSubstr(As_0,2);
//         f0_11(Ls_60,52,Li_76,4,1,1,Ai_28-1,Ai_32+1,Ai_36,Ai_40,Ai_44,As_0,Ai_56);
//         string buffer;
//         StringSetCharacter(buffer,"",0,'r')
//         f0_1("Clt",Ls_60,69,buffer,"Webdings",Ai_56,1,4,4,Ai_28-1);
//         break;
//      case 72:
//         if(Ai_20<3) Ai_20=3;
//         f0_11(As_0,Ai_8,Ai_12,Ai_16,Ai_20,Ai_24,Ai_28,Ai_32,Ai_36,Ai_40,Ai_44,As_48,Ai_56);
//         if(Ai_40==0) Li_76=Gia_168[2]-Gia_168[0]-(7 *(Ai_28-1)+19);
//         else Li_76=4;
//         Ls_60=StringSubstr(As_0,0,2)+"HD"+StringSubstr(As_0,2);
//         f0_11(Ls_60,53,Li_80,4,1,1,Ai_28-1,Ai_32+1,Ai_36,Ai_40,Ai_44,As_0,Ai_56);
//         f0_1("Hdt",Ls_60,69,StringSetCharacter("",0,'0'),"Webdings",Ai_56,1,4,4,Ai_28-1);
//         break;
//      case 73:
//         if(Ai_20<3) Ai_20=3;
//         f0_11(As_0,Ai_8,Ai_12,Ai_16,Ai_20,Ai_24,Ai_28,Ai_32,Ai_36,Ai_40,Ai_44,As_48,Ai_56);
//         if(Ai_40==0)
//           {
//            Li_76 = Gia_168[2] - Gia_168[0] - (7 * (Ai_28 - 1) + 19);
//            Li_80 = Gia_168[2] - Gia_168[0] - (15 * (Ai_28 - 1) + 37);
//              } else {
//            Li_76 = 4;
//            Li_80 = 7 * (Ai_28 - 1) + 23;
//           }
//         Ls_60=StringSubstr(As_0,0,2)+"CL"+StringSubstr(As_0,2);
//         f0_11(Ls_60,52,Li_76,4,1,1,Ai_28-1,Ai_32+1,Ai_36,Ai_40,Ai_44,As_0,Ai_56);
//         f0_1("Clt",Ls_60,69,StringSetCharacter("",0,'r'),"Webdings",Ai_56,1,4,4,Ai_28-1);
//         Ls_60=StringSubstr(As_0,0,2)+"HD"+StringSubstr(As_0,2);
//         f0_11(Ls_60,53,Li_80,4,1,1,Ai_28-1,Ai_32+1,Ai_36,Ai_40,Ai_44,As_0,Ai_56);
//         f0_1("Hdt",Ls_60,69,StringSetCharacter("",0,'0'),"Webdings",Ai_56,1,4,4,Ai_28-1);
//         break;
//      case 74:
//         if(Ai_20<3) Ai_20=3;
//         f0_11(As_0,Ai_8,Ai_12,Ai_16,Ai_20,Ai_24,Ai_28,Ai_32,Ai_36,Ai_40,Ai_44,As_48,Ai_56);
//         if(Ai_40==0)
//           {
//            Li_76 = Gia_168[2] - Gia_168[0] - (7 * (Ai_28 - 1) + 19);
//            Li_80 = Gia_168[2] - Gia_168[0] - (15 * (Ai_28 - 1) + 37);
//            Li_84 = Gia_168[2] - Gia_168[0] - (23 * (Ai_28 - 1) + 55);
//              } else {
//            Li_76 = 4;
//            Li_80 = 7 * (Ai_28 - 1) + 23;
//            Li_84 = 14 * (Ai_28 - 1) + 42;
//           }
//         Ls_60=StringSubstr(As_0,0,2)+"CL"+StringSubstr(As_0,2);
//         f0_11(Ls_60,52,Li_76,4,1,1,Ai_28-1,Ai_32+1,Ai_36,Ai_40,Ai_44,As_0,Ai_56);
//         string buffer;
//         StringSetCharacter(buffer,"",0,'r');
//         f0_1("Clt",Ls_60,69,buffer,"Webdings",Ai_56,1,4,4,Ai_28-1);
//         Ls_60=StringSubstr(As_0,0,2)+"HD"+StringSubstr(As_0,2);
//         f0_11(Ls_60,53,Li_80,4,1,1,Ai_28-1,Ai_32+1,Ai_36,Ai_40,Ai_44,As_0,Ai_56);
//         string buffer;
//         StringSetCharacter(buffer,"",0,'0');
//         f0_1("Hdt",Ls_60,69,buffer,"Webdings",Ai_56,1,4,4,Ai_28-1);
//         Ls_60=StringSubstr(As_0,0,2)+"ST"+StringSubstr(As_0,2);
//         f0_11(Ls_60,55,Li_84,4,1,1,Ai_28-1,Ai_32+1,Ai_36,Ai_40,Ai_44,As_0,Ai_56);
//         string buffer;
//         StringSetCharacter(buffer,"",0,'@');
//         f0_1("Stt",Ls_60,69,buffer,"Webdings",Ai_56,1,4,4,Ai_28-1);
//         break;
//      default:
//         return (1);
//     }
//   return (0);
//  }
//// 9B1AEE847CFB597942D106A4135D4FE6
//int f0_9(string As_0,string As_8,int Ai_16,int Ai_20,int Ai_24=1,int Ai_28=1,int Ai_32=0,double Ad_36=0.0,double Ad_44=1.0,double Ad_52=1.0,int Ai_60=-1,int Ai_64=-1,int Ai_68=-1)
//  {
//   int Li_72;
//   int Li_76;
//   int Li_80;
//   int Li_84;
//   int Li_88;
//   int Li_92;
//   int Li_96;
//   int Li_100;
//   int Li_104;
//   string Ls_unused_108;
//   string Ls_unused_116;
//   int Li_124;
//   int Li_128;
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//   if(As_8=="")
//     {
//      if(Ai_64 < 0) Ai_64 = 0;
//      if(Ai_68 < 0) Ai_68 = 16777215;
//        } else {
//      //+------------------------------------------------------------------+
//      //|                                                                  |
//      //+------------------------------------------------------------------+
//      if(!f0_7(As_8)) return (-1);
//      if(Ai_64 < 0) Ai_64 = 0;
//      if(Ai_68 < 0) Ai_68 = 16777215;
//      Li_84=Gia_156[4]+1;
//     }
//   if(Ai_28 > 2) Ai_28 = 2;
//   if(Ai_24 > 8) Ai_24 = 8;
//   if(Ai_32 > 3) Ai_32 = 3;
//   if(Ai_32 < 0) Ai_32 = 0;
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//   switch(Ai_32)
//     {
//      case 0:
//         Li_72 = Ai_24;
//         Li_76 = 1;
//         break;
//      case 1:
//         Li_72 = 1;
//         Li_76 = Ai_24;
//         break;
//      case 2:
//         Li_72 = Ai_24;
//         Li_76 = 1;
//         break;
//      case 3:
//         Li_72 = 1;
//         Li_76 = Ai_24;
//     }
//   f0_4(As_0,As_8,30,Ai_16,Ai_20,Li_72,Li_76,Ai_28,Ai_64,Ai_68,Li_84);
//   f0_7(As_0);
//   int Li_136=Gia_156[6];
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//   if(Ai_32%2==0)
//     {
//      switch(Li_72)
//        {
//         case 1:
//            Li_80=1;
//            break;
//         case 2:
//            Li_80=2;
//            break;
//         case 3:
//            Li_80=2;
//            break;
//         case 4:
//            Li_80=2;
//            break;
//         case 5:
//            Li_80=3;
//            break;
//         case 6:
//            Li_80=3;
//            break;
//         case 7:
//            Li_80=3;
//            break;
//         case 8:
//            Li_80=4;
//        }
//        } else {
//      //+------------------------------------------------------------------+
//      //|                                                                  |
//      //+------------------------------------------------------------------+
//      switch(Li_76)
//        {
//         case 1:
//            Li_80=1;
//            break;
//         case 2:
//            Li_80=2;
//            break;
//         case 3:
//            Li_80=3;
//            break;
//         case 4:
//            Li_80=3;
//            break;
//         case 5:
//            Li_80=4;
//            break;
//         case 6:
//            Li_80=5;
//            break;
//         case 7:
//            Li_80=4;
//            break;
//         case 8:
//            Li_80=4;
//        }
//     }
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//   switch(Ai_32)
//     {
//      case 0:
//         switch(Ai_28)
//           {
//            case 0:
//               if(Li_136==0)
//                 {
//                  Li_88 = 1;
//                  Li_92 = -2;
//                  Li_96 = 9;
//                  Li_100 = 5 * Li_72 - 1;
//                  Li_104 = 0;
//                 }
//               if(Li_136!=1) break;
//               Li_88 = Gia_156[2] - Gia_156[0] - 1;
//               Li_92 = 17;
//               Li_96 = 9;
//               Li_100 = 5 * Li_72 - 1;
//               Li_104 = 180;
//               break;
//            case 1:
//               if(Li_136==0)
//                 {
//                  Li_88 = 1;
//                  Li_92 = -2;
//                  Li_96 = 9;
//                  Li_100 = Li_72 * 8 - Li_80;
//                  Li_104 = 0;
//                 }
//               if(Li_136!=1) break;
//               Li_88 = Gia_156[2] - Gia_156[0] - 1;
//               Li_92 = 17;
//               Li_96 = 9;
//               Li_100 = Li_72 * 8 - Li_80;
//               Li_104 = 180;
//               break;
//            case 2:
//               if(Li_136==0)
//                 {
//                  Li_88 = 1;
//                  Li_92 = -5;
//                  Li_96 = 15;
//                  Li_100 = 5 * Li_72;
//                  Li_104 = 0;
//                 }
//               if(Li_136!=1) break;
//               Li_88 = Gia_156[2] - Gia_156[0] - 1;
//               Li_92 = 28;
//               Li_96 = 15;
//               Li_100 = 5 * Li_72;
//               Li_104 = 180;
//           }
//         break;
//      case 1:
//         switch(Ai_28)
//           {
//            case 0:
//               if(Li_76>6) Li_80++;
//               if(Li_136==0)
//                 {
//                  Li_88 = -3;
//                  Li_92 = Gia_156[3] - Gia_156[1];
//                  Li_96 = 9;
//                  Li_100 = 5 * Li_76 - Li_80;
//                  Li_104 = 90;
//                 }
//               if(Li_136!=1) break;
//               Li_88 = -3;
//               Li_92 = Gia_156[3] - Gia_156[1] - 1;
//               Li_96 = 9;
//               Li_100 = 5 * Li_76 - Li_80;
//               Li_104 = 270;
//               break;
//            case 1:
//               if(Li_136==0)
//                 {
//                  Li_88 = -3;
//                  Li_92 = Gia_156[3] - Gia_156[1];
//                  Li_96 = 9;
//                  Li_100 = 7 * Li_76 - 1;
//                  Li_104 = 90;
//                 }
//               if(Li_136!=1) break;
//               Li_88 = -3;
//               Li_92 = Gia_156[3] - Gia_156[1] - 1;
//               Li_96 = 9;
//               Li_100 = 7 * Li_76 - 1;
//               Li_104 = 270;
//               break;
//            case 2:
//               if(Li_136==0)
//                 {
//                  Li_88 = -6;
//                  Li_92 = Gia_156[3] - Gia_156[1];
//                  Li_96 = 14;
//                  Li_100 = 7 * Li_76 - (Li_76 + Li_76 / 4);
//                  Li_104 = 90;
//                 }
//               if(Li_136!=1) break;
//               Li_88 = -6;
//               Li_92 = Gia_156[3] - Gia_156[1] + 1;
//               Li_96 = 14;
//               Li_100 = 7 * Li_76 - (Li_76 + Li_76 / 4);
//               Li_104 = 270;
//           }
//         break;
//      case 2:
//         switch(Ai_28)
//           {
//            case 0:
//               if(Li_136==1)
//                 {
//                  Li_88 = 2;
//                  Li_92 = -2;
//                  Li_96 = 9;
//                  Li_100 = 5 * Li_72 - 1;
//                  Li_104 = 0;
//                 }
//               if(Li_136!=0) break;
//               Li_88 = Gia_156[2] - Gia_156[0];
//               Li_92 = 17;
//               Li_96 = 9;
//               Li_100 = 5 * Li_72 - 1;
//               Li_104 = 180;
//               break;
//            case 1:
//               if(Li_136==1)
//                 {
//                  Li_88 = 2;
//                  Li_92 = -2;
//                  Li_96 = 9;
//                  Li_100 = Li_72 * 8 - Li_80;
//                  Li_104 = 0;
//                 }
//               if(Li_136!=0) break;
//               Li_88 = Gia_156[2] - Gia_156[0];
//               Li_92 = 17;
//               Li_96 = 9;
//               Li_100 = Li_72 * 8 - Li_80;
//               Li_104 = 180;
//               break;
//            case 2:
//               if(Li_136==1)
//                 {
//                  Li_88 = 1;
//                  Li_92 = -5;
//                  Li_96 = 15;
//                  Li_100 = 5 * Li_72;
//                  Li_104 = 0;
//                 }
//               if(Li_136!=0) break;
//               Li_88 = Gia_156[2] - Gia_156[0] - 1;
//               Li_92 = 28;
//               Li_96 = 15;
//               Li_100 = 5 * Li_72;
//               Li_104 = 180;
//           }
//         break;
//      case 3:
//         switch(Ai_28)
//           {
//            case 0:
//               if(Li_136==0)
//                 {
//                  Li_88 = 18;
//                  Li_92 = 1;
//                  Li_96 = 9;
//                  Li_100 = 5 * Li_76 - Li_80;
//                  Li_104 = 270;
//                 }
//               if(Li_136!=1) break;
//               Li_88 = 18;
//               Li_92 = 1;
//               Li_96 = 9;
//               Li_100 = 5 * Li_76 - Li_80;
//               Li_104 = 90;
//               break;
//            case 1:
//               if(Li_136==0)
//                 {
//                  Li_88 = 18;
//                  Li_92 = 1;
//                  Li_96 = 9;
//                  Li_100 = 7 * Li_76 - 1;
//                  Li_104 = 270;
//                 }
//               if(Li_136!=1) break;
//               Li_88 = 18;
//               Li_92 = 2;
//               Li_96 = 9;
//               Li_100 = 7 * Li_76 - 1;
//               Li_104 = 90;
//               break;
//            case 2:
//               if(Li_136==0)
//                 {
//                  Li_88 = 28;
//                  Li_92 = 1;
//                  Li_96 = 14;
//                  Li_100 = 7 * Li_76 - (Li_76 + Li_76 / 4);
//                  Li_104 = 270;
//                 }
//               if(Li_136!=1) break;
//               Li_88 = 28;
//               Li_92 = 1;
//               Li_96 = 14;
//               Li_100 = 7 * Li_76 - (Li_76 + Li_76 / 4);
//               Li_104 = 90;
//           }
//     }
//   double Ld_168 = (Ad_44 - Ad_36) / MathAbs(Li_100);
//   string Ls_176 = "";
//   for(int count_184=0; count_184<Li_100; count_184++)
//      //+------------------------------------------------------------------+
//      //|                                                                  |
//      //+------------------------------------------------------------------+
//     {
//      if(Ad_52<=Ad_36+Ld_168*count_184) break;
//      Ls_176=Ls_176+"|";
//     }
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//   if(Ai_60<0)
//     {
//      Li_124 = ArraySize(Gia_144) - 1;
//      Li_128 = count_184 / (Li_100 / Li_124);
//      if(Li_128>Li_124) Li_128=Li_124;
//      Ai_60=Gia_144[Li_128];
//     }
//   f0_1("LedIn",As_0,69,Ls_176,"Arial black",Ai_60,0,Li_88,Li_92,0,Li_96,0,0,Li_104);
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//   if(Ai_28>0)
//     {
//      if(Ai_32==1 || Ai_32==3) Li_88+=Ai_28-1+8;
//      else Li_92+=8;
//      f0_1("LedIn",As_0,69,Ls_176,"Arial black",Ai_60,0,Li_88,Li_92,0,Li_96,0,0,Li_104);
//     }
//   return (0);
//  }
//// 5710F6E623305B2C1458238C9757193B
//string f0_3(string As_0,int Aia_8[10],string As_12="chart")
//  {
//   string Ls_unused_20="";
//   if(As_12=="") As_12="chart";
//   return (StringConcatenate("wnd:", "z_", Aia_8[6], StringSetCharacter("", 0, Aia_8[7] + 97), StringSetCharacter("", 0, Aia_8[8] + 97), ":", "c_", Aia_8[9], ":", "lu_", Aia_8[0],
//           "_",Aia_8[1],":","rd_",Aia_8[2],"_",Aia_8[3],":","id",Aia_8[4],"",Aia_8[5],":","#",As_0,"|",As_12));
//  }
//// 58B0897F29A3AD862616D6CBF39536ED
//int f0_4(string As_0,string As_8,int Ai_16,int Ai_20=0,int Ai_24=0,int Ai_28=1,int Ai_32=1,int Ai_36=1,int Ai_40=0,int Ai_44=16777215,int Ai_48=0,int Ai_52=0,int Ai_56=0)
//  {
//   string Ls_60;
//   string Ls_68;
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//   switch(Ai_16)
//     {
//      case 30:
//         f0_11(As_0,Ai_16,Ai_20,Ai_24,Ai_28,Ai_32,Ai_36,Ai_48,Ai_40,Ai_52,Ai_56,As_8,Ai_44);
//         break;
//      case 40:
//         f0_11(As_0,Ai_16,Ai_20,Ai_24,Ai_28,Ai_32,Ai_36,Ai_48,Ai_40,Ai_52,Ai_56,As_8,Ai_44);
//         break;
//      case 70:
//         f0_2(As_0,Ai_16,Ai_20,Ai_24,Ai_28,Ai_32,Ai_36,Ai_48,Ai_40,Ai_52,Ai_56,As_8,Ai_44);
//         break;
//      case 71:
//         f0_2(As_0,Ai_16,Ai_20,Ai_24,Ai_28,Ai_32,Ai_36,Ai_48,Ai_40,Ai_52,Ai_56,As_8,Ai_44);
//         break;
//      case 72:
//         f0_2(As_0,Ai_16,Ai_20,Ai_24,Ai_28,Ai_32,Ai_36,Ai_48,Ai_40,Ai_52,Ai_56,As_8,Ai_44);
//         break;
//      case 73:
//         f0_2(As_0,Ai_16,Ai_20,Ai_24,Ai_28,Ai_32,Ai_36,Ai_48,Ai_40,Ai_52,Ai_56,As_8,Ai_44);
//         break;
//      case 74:
//         f0_2(As_0,Ai_16,Ai_20,Ai_24,Ai_28,Ai_32,Ai_36,Ai_48,Ai_40,Ai_52,Ai_56,As_8,Ai_44);
//         break;
//      case 44:
//         Ls_60 = "RevBb";
//         Ls_68 = "Revtt";
//         f0_11(Ls_60,44,Ai_20,Ai_24,4,1,0,Ai_48+1,16711935,Ai_52,Ai_56,As_8,Ai_44);
//         f0_1(Ls_68,Ls_60,69,"Revers","Tahoma",Ai_44);
//         break;
//      case 43:
//         Ls_60 = "ClBb";
//         Ls_68 = "Clott";
//         f0_11(Ls_60,43,Ai_20,Ai_24,4,1,0,Ai_48+1,65535,Ai_52,Ai_56,As_8,Ai_44);
//         f0_1(Ls_68,Ls_60,69,"close","Tahoma",0);
//         break;
//      case 42:
//         Ls_60 = "Sbb";
//         Ls_68 = "Seltt";
//         f0_11(Ls_60,42,Ai_20,Ai_24,4,1,0,Ai_48+1,4678655,Ai_52,Ai_56,As_8,Ai_44);
//         f0_1(Ls_68,Ls_60,69,"Sell","Tahoma",Ai_44);
//         break;
//      case 41:
//         Ls_60 = "Bbb";
//         Ls_68 = "Buytt";
//         f0_11(Ls_60,41,Ai_20,Ai_24,4,1,0,Ai_48+1,16748574,Ai_52,Ai_56,As_8,Ai_44);
//         f0_1(Ls_68,Ls_60,69,"Buy","Tahoma",Ai_44);
//         break;
//      case 52:
//         Ls_60 = "Cls";
//         Ls_68 = "Clt";
//         f0_11(Ls_60,52,Ai_20,4,1,1,0,Ai_48+1,Ai_40,Ai_52,Ai_56,As_8,Ai_44);
//         string buffer="";
//         StringSetCharacter(buffer,"",0,'r');
//         f0_1(Ls_68,Ls_60,69,buffer,"Webdings",Ai_44);
//         break;
//      case 53:
//         Ls_60 = "Hid";
//         Ls_68 = "Hdt";
//         f0_11(Ls_60,53,Ai_20,4,1,1,0,Ai_48+1,Ai_40,Ai_52,Ai_56,As_8,Ai_44);
//         string buffer;
//         StringSetCharacter(buffer,"",0,'0');
//         f0_1(Ls_68,Ls_60,69,buffer,"Webdings",Ai_44);
//         break;
//      case 54:
//         Ls_60 = "Shw";
//         Ls_68 = "Sht";
//         f0_11(Ls_60,54,Ai_20,4,1,1,0,Ai_48+1,Ai_40,Ai_52,Ai_56,As_8,Ai_44);
//         string buffer;
//         StringSetCharacter(buffer,"",0,'2');
//         f0_1(Ls_68,Ls_60,69,buffer,"Webdings",Ai_44);
//         break;
//      case 55:
//         Ls_60 = "Set";
//         Ls_68 = "Stt";
//         f0_11(Ls_60,55,Ai_20,4,1,1,0,Ai_48+1,Ai_40,Ai_52,Ai_56,As_8,Ai_44);
//         string buffer;
//         StringSetCharacter(buffer,"",0,'@');
//         f0_1(Ls_68,Ls_60,69,buffer,"Webdings",Ai_44);
//         break;
//      case 56:
//         Ls_60 = "Alr";
//         Ls_68 = "Altx";
//         f0_11(Ls_60,56,Ai_20,4,1,1,0,Ai_48+1,Ai_40,Ai_52,Ai_56,As_8,12632256);
//         string buffer;
//         StringSetCharacter(buffer,"",0,']');
//         f0_1(Ls_68,Ls_60,69,buffer,"Webdings",12632256);
//         break;
//      case 57:
//         Ls_60 = "Snd";
//         Ls_68 = "Sndtx";
//         f0_11(Ls_60,57,Ai_20,4,1,1,0,Ai_48+1,Ai_40,Ai_52,Ai_56,As_8,12632256);
//         string buffer;
//         StringSetCharacter(buffer,"",0,'¯');
//         f0_1(Ls_68,Ls_60,57,buffer,"Webdings",12632256);
//         break;
//      case 58:
//         Ls_60 = "Mil";
//         Ls_68 = "Mltx";
//         f0_11(Ls_60,58,Ai_20,4,1,1,0,Ai_48+1,Ai_40,Ai_52,Ai_56,As_8,12632256);
//         string buffer;
//         StringSetCharacter(buffer,"",0,'*');
//         f0_1(Ls_68,Ls_60,58,buffer,"Wingdings",12632256);
//         break;
//      case 60:
//         Ls_60 = As_0;
//         Ls_68 = "Lftx";
//         f0_11(Ls_60,60,Ai_20,Ai_24,1,1,0,Ai_48+1,Ai_40,Ai_52,Ai_56,As_8,Ai_44);
//         f0_1(Ls_68,Ls_60,60,StringSetCharacter("",0,'3'),"Webdings",Ai_44);
//         break;
//      case 61:
//         Ls_60 = As_0;
//         Ls_68 = "Rttx";
//         f0_11(Ls_60,61,Ai_20,Ai_24,1,1,0,Ai_48+1,Ai_40,Ai_52,Ai_56,As_8,Ai_44);
//         f0_1(Ls_68,Ls_60,61,StringSetCharacter("",0,'4'),"Webdings",Ai_44);
//         break;
//      case 62:
//         Ls_60 = As_0;
//         Ls_68 = "Uptx";
//         f0_11(Ls_60,62,Ai_20,Ai_24,1,1,0,Ai_48+1,Ai_40,Ai_52,Ai_56,As_8,Ai_44);
//         f0_1(Ls_68,Ls_60,62,StringSetCharacter("",0,'5'),"Webdings",Ai_44);
//         break;
//      case 63:
//         Ls_60 = As_0;
//         Ls_68 = "Dntx";
//         f0_11(Ls_60,63,Ai_20,Ai_24,1,1,0,Ai_48+1,Ai_40,Ai_52,Ai_56,As_8,Ai_44);
//         f0_1(Ls_68,Ls_60,63,StringSetCharacter("",0,'6'),"Webdings",Ai_44);
//         break;
//      case 59:
//         Ls_60 = As_0;
//         Ls_68 = "Sltx";
//         f0_11(Ls_60,59,Ai_20,Ai_24,1,1,0,Ai_48+1,Ai_40,Ai_52,Ai_56,As_8,Ai_44);
//         f0_1(Ls_68,Ls_60,59,StringSetCharacter("",0,'a'),"Webdings",Ai_44);
//         break;
//      default:
//         return (0);
//     }
//   return (1);
//  }
//// 78BAA8FAE18F93570467778F2E829047
//int f0_7(string As_0)
//  {
//   int Li_8;
//   int Li_12;
//   string name_16;
//   int Li_24;
//   for(int objs_total_28=ObjectsTotalMQL4(); objs_total_28>=0; objs_total_28--)
//      //+------------------------------------------------------------------+
//      //|                                                                  |
//      //+------------------------------------------------------------------+
//     {
//      name_16=ObjectNameMQL4(objs_total_28);
//      Li_24=StringFind(name_16,As_0);
//      if(Li_24>=0)
//        {
//         if(Li_24!=StringFind(name_16,"|")+1)
//           {
//            Li_8=StringFind(name_16,"z_")+2;
//            Gia_156[4] = StringToInteger(StringSubstr(name_16, Li_8, 1));
//            Gia_156[9] = StringToInteger(StringGetChar(StringSubstr(name_16, Li_8 + 3, 1), 0));
//            Li_8=StringFind(name_16,":c_")+3;
//            Gia_156[5]=StringToInteger(StringSubstr(name_16,Li_8,2));
//            Li_8=StringFind(name_16,"lu_")+3;
//            Li_12=StringFind(name_16,"_",Li_8);
//            Gia_156[0]=StringToInteger(StringSubstr(name_16,Li_8,Li_12-Li_8));
//            Li_8=StringFind(name_16,":",Li_12);
//            Gia_156[1]=StringToInteger(StringSubstr(name_16,Li_12+1,Li_8-Li_12+1));
//            Li_8=StringFind(name_16,"rd_")+3;
//            Li_12=StringFind(name_16,"_",Li_8);
//            Gia_156[2]=StringToInteger(StringSubstr(name_16,Li_8,Li_12-Li_8));
//            Li_8=StringFind(name_16,":",Li_12);
//            Gia_156[3] = StringToInteger(StringSubstr(name_16, Li_12 + 1, Li_8 - Li_12 + 1));
//            Gia_156[6] = ObjectGetMQL4(name_16, OBJPROP_CORNER);
//            Gia_156[7] = ObjectGetMQL4(name_16, OBJPROP_COLOR);
//            Gia_156[8] = ObjectFindMQL4(name_16);
//            Gs_148=StringSubstr(name_16,StringFind(name_16,"|")+1);
//            return (1);
//           }
//        }
//     }
//   ArrayInitialize(Gia_156,-1);
//   Gs_148=0;
//   return (0);
//  }
//// 6ABA3523C7A75AAEA41CC0DEC7953CC5
//void f0_6(string As_0)
//  {
//   int Li_8;
//   int Li_12;
//   string name_16;
//   string Ls_unused_24;
//   string Ls_32;
//   string Lsa_40[5000];
//   string Lsa_44[5000];
//   int Li_48;
//   int Li_52;
//   string Ls_56;
//   string Ls_64;
//   int Li_72=GetTickCount();
//   for(int Li_76=ObjectsTotalMQL4()-1; Li_76>=0; Li_76--)
//      //+------------------------------------------------------------------+
//      //|                                                                  |
//      //+------------------------------------------------------------------+
//     {
//      name_16=ObjectNameMQL4(Li_76);
//      if(StringFind(name_16,"wnd:")>=0)
//        {
//         if(StringFind(name_16,"#"+As_0)>0)
//           {
//            ObjectDeleteMQL4(name_16);
//            continue;
//           }
//         if(StringFind(name_16,"|"+As_0)>0)
//           {
//            Li_48 = StringFind(name_16, "#") + 1;
//            Li_52 = StringFind(name_16, "|" + As_0) - Li_48;
//            Lsa_40[Li_8]=StringSubstr(name_16,Li_48,Li_52);
//            Li_8++;
//            ObjectDeleteMQL4(name_16);
//            continue;
//           }
//         Lsa_44[Li_12]=name_16;
//         Li_12++;
//        }
//     }
//   ArrayResize(Lsa_44,Li_12);
//   for(Li_76=0; Li_76<Li_8; Li_76++)
//      //+------------------------------------------------------------------+
//      //|                                                                  |
//      //+------------------------------------------------------------------+
//     {
//      Ls_56="|"+Lsa_40[Li_76];
//      for(int index_80=0; index_80<Li_12; index_80++)
//        {
//         name_16=Lsa_44[index_80];
//         if(name_16!="")
//           {
//            if(StringFind(name_16,Ls_56)>=0)
//              {
//               Li_48 = StringFind(name_16, "#") + 1;
//               Li_52 = StringFind(name_16, Ls_56) - Li_48;
//               Ls_64 = StringSubstr(name_16, Li_48, Li_52);
//               if(Ls_32!=Ls_64)
//                 {
//                  Ls_32=Ls_64;
//                  Lsa_40[Li_8]=Ls_32;
//                  Li_8++;
//                 }
//               Lsa_44[index_80]="";
//               ObjectDeleteMQL4(name_16);
//              }
//           }
//        }
//     }
//  }
//// 689C35E4872BA754D7230B8ADAA28E48
//void f0_5(string As_0,bool Ai_8=true)
//  {
//   int objs_total_12=0;
//   string name_16="";
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//   if(Ai_8)
//     {
//      for(objs_total_12=ObjectsTotalMQL4(); objs_total_12>=0; objs_total_12--)
//        {
//         name_16=ObjectNameMQL4(objs_total_12);
//         if(StringFind(name_16,As_0)>=0) ObjectDeleteMQL4(name_16);
//        }
//        } else {
//      //+------------------------------------------------------------------+
//      //|                                                                  |
//      //+------------------------------------------------------------------+
//      for(objs_total_12=ObjectsTotalMQL4(); objs_total_12>=0; objs_total_12--)
//        {
//         name_16=ObjectNameMQL4(objs_total_12);
//         if(StringFind(name_16,"#"+As_0)>=0) ObjectDeleteMQL4(name_16);
//        }
//     }
//  }
//// 09CBB5F5CE12C31A043D5C81BF20AA4A
//bool f0_0(string As_0,int A_x_8,int A_y_12,string A_text_16="c",int A_fontsize_24=14,int A_corner_28=0,color A_color_32=0,int A_window_36=0,string A_fontname_40="Webdings",int A_angle_48=0)
//  {
//   if(A_window_36>ChartGetInteger(0,CHART_WINDOWS_TOTAL)-1) A_window_36=ChartGetInteger(0,CHART_WINDOWS_TOTAL)-1;
//   if(StringLen(As_0) < 1) return (false);
//   ObjectDeleteMQL4(As_0);
//   ObjectCreateMQL4(As_0,OBJ_LABEL,A_window_36,0,0);
//   ObjectSetMQL4(As_0,OBJPROP_XDISTANCE,A_x_8);
//   ObjectSetMQL4(As_0,OBJPROP_YDISTANCE,A_y_12);
//   ObjectSetMQL4(As_0,OBJPROP_CORNER,A_corner_28);
//   ObjectSetMQL4(As_0,OBJPROP_BACK,false);
//   ObjectSetMQL4(As_0,OBJPROP_ANGLE,A_angle_48);
//   ObjectSetTextMQL4(As_0,A_text_16,A_fontsize_24,A_fontname_40,A_color_32);
//   return (true);
//  }
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//void CurrencyStrengthOnint()
//  {
//   int Li_0;
//   string symbol_4;
////string Ls_unused_12;
//   string Ls_20= "";
//   G_color_216 = HandleBackGroundColor;
//   G_color_220 = DataTableBackGroundColor_1;
//   G_color_224 = DataTableBackGroundColor_2;
//   G_color_228 = CurrencysBackGroundColor;
//   G_color_232 = HandleTextColor;
//   G_color_236 = DataTableTextColor;
//   G_color_240 = CurrencysTextColor;
//   G_color_244 = TrendUpArrowsColor;
//   G_color_248 = TrendDownArrowsColor;
//   for(int index_28=0; index_28<28; index_28++)
//      //+------------------------------------------------------------------+
//      //|                                                                  |
//      //+------------------------------------------------------------------+
//     {
//      symbol_4=Gsa_196[index_28];
//      if(StringLen(SymbolPrefix)>1)
//        {
//         Gi_260=true;
//         if(StringFind(SymbolPrefix,"|")==0)
//           {
//            Gs_252=StringSubstr(SymbolPrefix,1);
//            symbol_4=symbol_4+Gs_252;
//            Gi_264=-StringLen(Gsa_196[index_28]);
//           }
//         if(StringFind(SymbolPrefix,"|")==StringLen(SymbolPrefix)-1)
//           {
//            Gs_252=StringSubstr(SymbolPrefix,0,StringFind(SymbolPrefix,"|"));
//            symbol_4=Gs_252+symbol_4;
//            Gi_264=StringLen(Gs_252)-1;
//           }
//        }
//      if(MarketInfoMQL4(symbol_4,MODE_POINT)==0.0) Ls_20=Ls_20+":"+Gsa_196[index_28];
//      else
//        {
//         Gsa_204[Li_0]=symbol_4;
//         Li_0++;
//        }
//     }
//   ArrayResize(Gsa_204,Li_0);
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//   if(UninitializeReason()!=REASON_CHARTCHANGE)
//     {
//      if(Ls_20!="")
//        {
//         Ls_20 = "Some currency pairs are not available\n for calculating the indices.\n" + Ls_20;
//         Ls_20 = Ls_20
//                +"\nCalculation formula will be changed.";
//         Alert(Ls_20);
//        }
//     }
//  }
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//void CurrencyStrengthDeInt()
//  {
////string Ls_unused_0;
//   string Ls_8="Curs";
//   string Ls_16="Pows";
//   f0_6("Header");
//   f0_6("Window");
//   f0_6(Ls_8);
//   f0_6(Ls_16);
//  }
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//void CurrencyStrengthStart()
//  {
//   int Li_0;
//   int Li_4;
//   int color_8;
//   int color_12;
//   int Li_16;
//   double Lda_20[8][2];
////string Ls_unused_24;
//   string Ls_32;
//   int Li_unused_40;
//   double Ld_44;
//   int Li_52=4;
//   string Ls_56="Curs";
//   string Ls_unused_64="Pows";
//   int Li_unused_72=0;
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//   if(ShowCurrencies && (!CurrenciesWindowBelowTable))
//     {
//      f0_4("Window","",30,4,18,18,1,0,G_color_216,G_color_216,0,0,0);
//      f0_4("Header","",30,260,18,1,1,0,G_color_216,G_color_216,0,0,0);
//      f0_1("hdTxt","Window",69,"Squeeze Bounce System","Courier new",G_color_232,0,34,-2,0,11);
//        } else {
//      //+------------------------------------------------------------------+
//      //|                                                                  |
//      //+------------------------------------------------------------------+
//      f0_4("Window","",30,4,18,11,1,0,G_color_216,G_color_216,0,0,0);
//      f0_1("hdTxt","Window",69,"Squeeze Bounce System","Courier new",G_color_232,0,1,-2,0,11);
//     }
//   int Li_76=14;
//   Li_52=2;
//   ArrayInitialize(Gda_212,0);
//   int index_80=f0_8();
//   if(ShowSymbolsSorted) ArraySortMQL4(Gda_212,WHOLE_ARRAY,0,MODE_DESCEND);
//   int count_84 = 0;
//   string Ls_88 = "";
//   for(int index_96=0; index_96<index_80; index_96++)
//      //+------------------------------------------------------------------+
//      //|                                                                  |
//      //+------------------------------------------------------------------+
//     {
//      Li_16=Gda_212[index_96][1];
//      if(StringFind(DontShowThisPairs,Gsa_196[index_96])<0)
//        {
//         if(count_84%2!=0) color_12=G_color_220;
//         else color_12=G_color_224;
//         f0_5("cWnd"+index_96);
//         f0_4("cWnd"+index_96,"Window",30,0,Li_76+Li_52,11,1,0,color_12,color_12,0,0,0);
//         if(Li_16>=0)
//           {
//            if(Gi_260)
//              {
//               if(Gi_264<0) Ls_88=StringSubstr(Gsa_204[Li_16],0,-Gi_264);
//               else Ls_88=StringSubstr(Gsa_204[Li_16],Gi_264);
//              }
//            else Ls_88=Gsa_204[Li_16];
//           }
//         else Ls_88="LOADING";
//         f0_1(Ls_88+"wnd","cWnd"+index_96,69,Ls_88,"Courier new",G_color_236,0,4,-2,0,11);
//         if(Li_16>=0)
//           {
//            f0_5(index_96+"sLED");
//            if(Gda_212[index_96][0]<0.0)
//              {
//               Li_4 = 2;
//               Li_0 = -14;
//               color_8=G_color_248;
//               f0_9(index_96+"sLED","Window",Li_0+75,Li_76+0+Li_52,2,0,Li_4,0,100,-Gda_212[index_96][0],color_8,color_12,color_12);
//               string buffer;
//               StringSetCharacter(buffer,"",0,'Ú')
//               f0_1(index_96+"TrDn","cWnd"+index_96,69,buffer,"Wingdings",color_8,0,99,-2,0,14);
//               if(Gda_212[index_96][0]<-99.99) f0_1("strench","cWnd"+index_96,69,"-100","Courier new",G_color_236,0,122,-1,0,10);
//               else f0_1("strench","cWnd"+index_96,69,DoubleToString(Gda_212[index_96][0],1),"Courier new",G_color_236,0,122,-1,0,10);
//                 } else {
//               Li_4 = 0;
//               Li_0 = 14;
//               color_8=G_color_244;
//               f0_9(index_96+"sLED","Window",Li_0+75,Li_76+0+Li_52,2,0,Li_4,0,100,Gda_212[index_96][0],color_8,color_12,color_12);
//               string buffer;
//               StringSetCharacter(buffer,"",0,'Ù');
//               f0_1(index_96+"TrUp","cWnd"+index_96,69,buffer,"Wingdings",color_8,0,65,-3,0,14);
//               if(Gda_212[index_96][0]>99.99) f0_1("strench","cWnd"+index_96,69,"100.0","Courier new",G_color_236,0,122,-1,0,10);
//               else f0_1("strench","cWnd"+index_96,69,DoubleToString(Gda_212[index_96][0],1),"Courier new",G_color_236,0,130,-1,0,10);
//              }
//           }
//         Li_52+=16;
//         count_84++;
//        }
//     }
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//   if(ShowCurrencies)
//     {
//      if(!CurrenciesWindowBelowTable)
//        {
//         Li_0=Li_52;
//         f0_4(Ls_56,"Window",30,166,16,7,9,0,G_color_228,G_color_228,0,0,0);
//         Ls_32="Led"+index_96;
//         Li_unused_40=Gia_208[index_96];
//         Li_52=0;
//         for(index_80=0; index_80<8; index_80++)
//           {
//            Ld_44=f0_10(Gsa_188[index_80]);
//            Lda_20[index_80][0] = Ld_44;
//            Lda_20[index_80][1] = index_80;
//           }
//         if(ShowCurrenciesSorted) ArraySortMQL4(Lda_20,WHOLE_ARRAY,0,MODE_DESCEND);
//         for(index_80=0; index_80<8; index_80++)
//           {
//            Ld_44 = Lda_20[index_80][0];
//            Li_16 = Lda_20[index_80][1];
//            f0_1("CuCur"+index_80,Ls_56,69,Gsa_188[Li_16],"Courier new",G_color_240,0,5,Li_52+0,0,11);
//            f0_1("CuDig"+index_80,Ls_56,69,DoubleToString(Lda_20[index_80][0],1),"Courier new",G_color_240,0,78,Li_52+1,0,10);
//            f0_9("sLED"+index_80,Ls_56,32,Li_52+2,3,0,0,0,10,Ld_44,-1,G_color_228,G_color_228);
//            Li_52+=14;
//           }
//           } else {
//         f0_4(Ls_56,"Window",30,0,Li_52+14,11,6,0,G_color_228,G_color_228,0,0,0);
//         Ls_32="Led"+index_96;
//         Li_unused_40=Gia_208[index_96];
//         Li_52=0;
//         for(index_80=0; index_80<8; index_80++)
//           {
//            Ld_44=f0_10(Gsa_188[index_80]);
//            Lda_20[index_80][0] = Ld_44;
//            Lda_20[index_80][1] = index_80;
//           }
//         if(ShowCurrenciesSorted) ArraySortMQL4(Lda_20,WHOLE_ARRAY,0,MODE_DESCEND);
//         for(index_80=0; index_80<8; index_80++)
//           {
//            Ld_44 = Lda_20[index_80][0];
//            Li_16 = Lda_20[index_80][1];
//            f0_1("CuCur"+index_80,Ls_56,69,Gsa_188[Li_16],"Courier new",G_color_240,0,Li_52+3,76,0,12,0,0,90);
//            f0_9("sLED"+index_80,Ls_56,Li_52+1,0,2,1,1,0,10,Ld_44,-1,G_color_228,G_color_228);
//            Li_52+=20;
//           }
//        }
//     }
//   ChartRedraw(0);
//  }
////+------------------------------------------------------------------+
////|                                                                  |
////+------------------------------------------------------------------+
//int f0_8()
//  {
//   double ihigh_0;
//   double ilow_8;
//   double iopen_16;
//   double iclose_24;
//   double point_32;
//   double Ld_40;
//   double Ld_48;
//   int Li_unused_56 = 0;
//   int timeframe_60 = 1440;
//   string symbol_64 = "";
//   int arr_size_72=ArraySize(Gsa_204);
//   ArrayResize(Gda_212,arr_size_72);
//   for(int index_76=0; index_76<arr_size_72; index_76++)
//      //+------------------------------------------------------------------+
//      //|                                                                  |
//      //+------------------------------------------------------------------+
//     {
//      symbol_64= Gsa_204[index_76];
//      point_32 = MarketInfoMQL4(symbol_64,MODE_POINT);
//      if(point_32==0.0)
//        {
//         init();
//         Gda_212[index_76][1]=-1;
//           } else {
//         ihigh_0= iHighMQL4(symbol_64,timeframe_60,0);
//         ilow_8 = iLowMQL4(symbol_64,timeframe_60,0);
//         iopen_16=iOpenMQL4(symbol_64,timeframe_60,0);
//         iclose_24=iCloseMQL4(symbol_64,timeframe_60,0);
//         if(iopen_16>iclose_24)
//           {
//            Ld_40=(ihigh_0-ilow_8)*point_32;
//            if(Ld_40==0.0)
//              {
//               init();
//               Gda_212[index_76][1]=-1;
//               continue;
//              }
//            Ld_48=(ihigh_0-iclose_24)/Ld_40*point_32/(-0.01);
//              } else {
//            Ld_40=(ihigh_0-ilow_8)*point_32;
//            if(Ld_40==0.0)
//              {
//               init();
//               Gda_212[index_76][1]=-1;
//               continue;
//              }
//            Ld_48=100.0 *((iclose_24-ilow_8)/Ld_40*point_32);
//           }
//         Gda_212[index_76][0] = Ld_48;
//         Gda_212[index_76][1] = index_76;
//         Gda_212[index_76][2] = 1;
//        }
//     }
//   return (arr_size_72);
//  }
//// A9B24A824F70CC1232D1C2BA27039E8D
//double f0_10(string As_0)
//  {
//   double point_8;
//   int Li_16;
//   string Ls_20;
//   double Ld_28;
//   double Ld_36;
//   int count_44=0;
//   double Ld_ret_48 = 0;
//   int timeframe_56 = 1440;
//   for(int index_60=0; index_60<ArraySize(Gsa_204); index_60++)
//      //+------------------------------------------------------------------+
//      //|                                                                  |
//      //+------------------------------------------------------------------+
//     {
//      Li_16 = 0;
//      Ls_20 = Gsa_204[index_60];
//      if(As_0==StringSubstr(Ls_20,0,3) || As_0==StringSubstr(Ls_20,3,3))
//        {
//         point_8=MarketInfoMQL4(Ls_20,MODE_POINT);
//         if(point_8==0.0)
//           {
//            init();
//            continue;
//           }
//         Ld_28=(iHighMQL4(Ls_20,timeframe_56,0)-iLowMQL4(Ls_20,timeframe_56,0))*point_8;
//         if(Ld_28==0.0)
//           {
//            init();
//            continue;
//           }
//         Ld_36=100.0 *((MarketInfoMQL4(Ls_20,MODE_BID)-iLowMQL4(Ls_20,timeframe_56,0))/Ld_28*point_8);
//         if(Ld_36>3.0) Li_16=1;
//         if(Ld_36 > 10.0) Li_16 = 2;
//         if(Ld_36 > 25.0) Li_16 = 3;
//         if(Ld_36 > 40.0) Li_16 = 4;
//         if(Ld_36 > 50.0) Li_16 = 5;
//         if(Ld_36 > 60.0) Li_16 = 6;
//         if(Ld_36 > 75.0) Li_16 = 7;
//         if(Ld_36 > 90.0) Li_16 = 8;
//         if(Ld_36 > 97.0) Li_16 = 9;
//         count_44++;
//         if(As_0==StringSubstr(Ls_20,3,3)) Li_16=9-Li_16;
//         Ld_ret_48+=Li_16;
//        }
//     }
//   if(count_44>0) Ld_ret_48/=count_44;
//   else Ld_ret_48=0;
//   return (Ld_ret_48);
//  }
//+------------------------------------------------------------------+
//Currency Strngth External Function End
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//Pivot Start
void PivotStart()
  {
   Pivot = iMAMQL4(Symbol(), 1440, 1, 0, MODE_SMA, PRICE_TYPICAL, 1);
//datetime Time[];
//int count=100;   // number of elements to copy
//ArraySetAsSeries(Time,true);
//CopyTime(_Symbol,_Period,0,count,Time);
   if(ArraySize(Time) < 41)
      return;
   if(ObjectFindMQL4("P line") != 0)
     {
      ObjectCreateMQL4("P line", OBJ_HLINE, 0, Time[40], Pivot);
      ObjectSetMQL4("P line", OBJPROP_STYLE, STYLE_DOT);
      ObjectSetMQL4("P line", OBJPROP_WIDTH, 2);
      ObjectSetMQL4("P line", OBJPROP_BACK, true);
      ObjectSetMQL4("P line", OBJPROP_COLOR, clrMaroon);
     }
   else
     {
      ObjectMoveMQL4("P line", 0, Time[40], Pivot);
     }
  }
//+------------------------------------------------------------------+
//| ADR External                                                     |
//+------------------------------------------------------------------+
void ComputeDayIndices(int Ai_0, int Ai_4, int &Ai_8, int &Ai_12, int &Ai_16)
  {
   int Li_20;
   int Li_24;
   int Li_28;
   int Li_32 = Ai_0 + Ai_4;
   int Li_36 = 3600 * Li_32;
   int Li_40 = 1440;
   int Li_44 = Li_40 / Period();
//datetime Time[];
//int count=Bars;   // number of elements to copy
//ArraySetAsSeries(Time,true);
//CopyTime(_Symbol,_Period,0,count,Time);
   int day_of_week_48 = TimeDayOfWeekMQL4(Time[0] - Li_36);
   int Li_52 = -1;
   Ai_8 = 0;
   Ai_12 = 0;
   Ai_16 = 0;
   switch(day_of_week_48)
     {
      case 6:
      case 0:
      case 1:
         Li_52 = 5;
         break;
      default:
         Li_52 = day_of_week_48 - 1;
     }
   if(DebugLogger)
     {
      Print("Dayofweektoday= ", day_of_week_48);
      Print("Dayofweekyesterday= ", Li_52);
     }
   int index_60;
   for(index_60 = 0; index_60 <= Li_44 + 1; index_60++)
     {
      Li_20 = Time[index_60] - Li_36;
      if(TimeDayOfWeekMQL4(Li_20) != day_of_week_48)
        {
         Ai_8 = index_60 - 1;
         break;
        }
     }
   int count_64;
   for(count_64 = 0; count_64 <= Li_44 * 2 + 1; count_64++)
     {
      Li_24 = Time[index_60 + count_64] - Li_36;
      if(TimeDayOfWeekMQL4(Li_24) == Li_52)
        {
         Ai_16 = index_60 + count_64;
         break;
        }
     }
   for(count_64 = 1; count_64 <= Li_44; count_64++)
     {
      Li_28 = Time[Ai_16 + count_64] - Li_36;
      if(TimeDayOfWeekMQL4(Li_28) != Li_52)
        {
         Ai_12 = Ai_16 + count_64 - 1;
         break;
        }
     }
   if(DebugLogger)
     {
      Print("Dest time zone\'s current day starts:", TimeToString(Time[Ai_8]), " (local time), idxbar= ", Ai_8);
      Print("Dest time zone\'s previous day starts:", TimeToString(Time[Ai_12]), " (local time), idxbar= ", Ai_12);
      Print("Dest time zone\'s previous day ends:", TimeToString(Time[Ai_16]), " (local time), idxbar= ", Ai_16);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SetLevel(string As_0, double A_price_8, color A_color_16, int A_style_20, int A_width_24, int A_datetime_28)
  {
   string name_32 = "[ADR] " + As_0 + " Label";
   string name_40 = "[ADR] " + As_0 + " Line";
   int count = 1; // number of elements to copy
   if(Display_ADR)
      if(ObjectFindMQL4(name_40) != 0)
         ObjectCreateMQL4(name_40, OBJ_TREND, 0, A_datetime_28, A_price_8, Time[0], A_price_8);
   ObjectSetMQL4(name_40, OBJPROP_BACK, true);
   ObjectSetMQL4(name_40, OBJPROP_STYLE, A_style_20);
   ObjectSetMQL4(name_40, OBJPROP_COLOR, A_color_16);
   ObjectSetMQL4(name_40, OBJPROP_WIDTH, A_width_24);
   ObjectMoveMQL4(name_40, 1, Time[0], A_price_8);
   ObjectMoveMQL4(name_40, 0, A_datetime_28, A_price_8);
   if(Display_ADR)
      if(ObjectFindMQL4(name_32) != 0)
         ObjectCreateMQL4(name_32, OBJ_TEXT, 0, Time[0], A_price_8);
   ObjectMoveMQL4(name_32, 0, Time[0] - 60 * (BarForLabels * Period()), A_price_8);
   string text_48 = " " + As_0;
   if(Gi_128 && StringToInteger(As_0) == 0)
      text_48 = text_48 + ": " + DoubleToString(A_price_8, Digits);
   ObjectSetTextMQL4(name_32, text_48, 8, "Arial", A_color_16);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SetTimeLine(string As_0, string A_text_8, int Ai_16, color A_color_20, double A_price_24)
  {
   string name_32 = "[ADR] " + As_0;
   int count = Ai_16 + 1; // number of elements to copy
   int time_40 = Time[Ai_16];
   if(Display_ADR)
      if(ObjectFindMQL4(name_32) != 0)
         ObjectCreateMQL4(name_32, OBJ_TREND, 0, time_40, 0, time_40, 100);
   ObjectMoveMQL4(name_32, 0, time_40, 0);
   ObjectMoveMQL4(name_32, 1, time_40, 100);
   ObjectSetMQL4(name_32, OBJPROP_BACK, true);
   ObjectSetMQL4(name_32, OBJPROP_STYLE, STYLE_DOT);
   ObjectSetMQL4(name_32, OBJPROP_COLOR, DarkGray);
   if(Display_ADR)
      if(ObjectFindMQL4(name_32 + " Label") != 0)
         ObjectCreateMQL4(name_32 + " Label", OBJ_TEXT, 0, time_40, A_price_24);
   ObjectMoveMQL4(name_32 + " Label", 0, time_40, A_price_24);
   ObjectSetTextMQL4(name_32 + " Label", A_text_8, 8, "Arial", A_color_20);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double SetPoint()
  {
   double Ld_ret_0;
   if(Digits < 4)
      Ld_ret_0 = 0.01;
   else
      Ld_ret_0 = 0.0001;
   return (Ld_ret_0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double CopyBufferMQL4(int handle, int index, int shift)
  {
   double buf[];
   switch(index)
     {
      case 0:
         if(CopyBuffer(handle, 0, shift, 1, buf) > 0)
            return(buf[0]);
         break;
      case 1:
         if(CopyBuffer(handle, 1, shift, 1, buf) > 0)
            return(buf[0]);
         break;
      case 2:
         if(CopyBuffer(handle, 2, shift, 1, buf) > 0)
            return(buf[0]);
         break;
      case 3:
         if(CopyBuffer(handle, 3, shift, 1, buf) > 0)
            return(buf[0]);
         break;
      case 4:
         if(CopyBuffer(handle, 4, shift, 1, buf) > 0)
            return(buf[0]);
         break;
      default:
         break;
     }
   return(EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ObjectDeleteMQL4(string name)
  {
   return(ObjectDelete(0, name));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int WindowFindMQL4(string name)
  {
   int window = -1;
   if((ENUM_PROGRAM_TYPE)MQLInfoInteger(MQL_PROGRAM_TYPE) == PROGRAM_INDICATOR)
     {
      window = ChartWindowFind();
     }
   else
     {
      window = ChartWindowFind(0, name);
      if(window == -1)
         Print(__FUNCTION__ + "(): Error = ", GetLastError());
     }
   return(window);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ObjectCreateMQL4(string name,
                      ENUM_OBJECT type,
                      int window,
                      datetime time1,
                      double price1,
                      datetime time2 = 0,
                      double price2 = 0,
                      datetime time3 = 0,
                      double price3 = 0)
  {
   return(ObjectCreate(0, name, type, window, time1, price1, time2, price2, time3, price3));
  }
//+------------------------------------------------------------------+
//|                                                              |
//+------------------------------------------------------------------+
bool ObjectSetMQL4(string name,
                   int index,
                   double value)
  {
   switch(index)
     {
      case OBJPROP_TIME1:
         ObjectSetInteger(0, name, OBJPROP_TIME, (int)value);
         return(true);
      case OBJPROP_PRICE1:
         ObjectSetDouble(0, name, OBJPROP_PRICE, value);
         return(true);
      case OBJPROP_TIME2:
         ObjectSetInteger(0, name, OBJPROP_TIME, 1, (int)value);
         return(true);
      case OBJPROP_PRICE2:
         ObjectSetDouble(0, name, OBJPROP_PRICE, 1, value);
         return(true);
      case OBJPROP_TIME3:
         ObjectSetInteger(0, name, OBJPROP_TIME, 2, (int)value);
         return(true);
      case OBJPROP_PRICE3:
         ObjectSetDouble(0, name, OBJPROP_PRICE, 2, value);
         return(true);
      case OBJPROP_COLOR:
         ObjectSetInteger(0, name, OBJPROP_COLOR, (int)value);
         return(true);
      case OBJPROP_STYLE:
         ObjectSetInteger(0, name, OBJPROP_STYLE, (int)value);
         return(true);
      case OBJPROP_WIDTH:
         ObjectSetInteger(0, name, OBJPROP_WIDTH, (int)value);
         return(true);
      case OBJPROP_BACK:
         ObjectSetInteger(0, name, OBJPROP_BACK, (int)value);
         return(true);
      case OBJPROP_RAY:
         ObjectSetInteger(0, name, OBJPROP_RAY_RIGHT, (int)value);
         return(true);
      case OBJPROP_ELLIPSE:
         ObjectSetInteger(0, name, OBJPROP_ELLIPSE, (int)value);
         return(true);
      case OBJPROP_SCALE:
         ObjectSetDouble(0, name, OBJPROP_SCALE, value);
         return(true);
      case OBJPROP_ANGLE:
         ObjectSetDouble(0, name, OBJPROP_ANGLE, value);
         return(true);
      case OBJPROP_ARROWCODE:
         ObjectSetInteger(0, name, OBJPROP_ARROWCODE, (int)value);
         return(true);
      case OBJPROP_TIMEFRAMES:
         ObjectSetInteger(0, name, OBJPROP_TIMEFRAMES, (int)value);
         return(true);
      case OBJPROP_DEVIATION:
         ObjectSetDouble(0, name, OBJPROP_DEVIATION, value);
         return(true);
      case OBJPROP_FONTSIZE:
         ObjectSetInteger(0, name, OBJPROP_FONTSIZE, (int)value);
         return(true);
      case OBJPROP_CORNER:
         ObjectSetInteger(0, name, OBJPROP_CORNER, (int)value);
         return(true);
      case OBJPROP_XDISTANCE:
         ObjectSetInteger(0, name, OBJPROP_XDISTANCE, (int)value);
         return(true);
      case OBJPROP_YDISTANCE:
         ObjectSetInteger(0, name, OBJPROP_YDISTANCE, (int)value);
         return(true);
      case OBJPROP_FIBOLEVELS:
         ObjectSetInteger(0, name, OBJPROP_LEVELS, (int)value);
         return(true);
      case OBJPROP_LEVELCOLOR:
         ObjectSetInteger(0, name, OBJPROP_LEVELCOLOR, (int)value);
         return(true);
      case OBJPROP_LEVELSTYLE:
         ObjectSetInteger(0, name, OBJPROP_LEVELSTYLE, (int)value);
         return(true);
      case OBJPROP_LEVELWIDTH:
         ObjectSetInteger(0, name, OBJPROP_LEVELWIDTH, (int)value);
         return(true);
      default:
         return(false);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ObjectSetTextMQL4(string name,
                       string text,
                       int font_size,
                       string font = "",
                       color text_color = CLR_NONE)
  {
   int tmpObjType = (int)ObjectGetInteger(0, name, OBJPROP_TYPE);
   if(tmpObjType != OBJ_LABEL && tmpObjType != OBJ_TEXT)
      return(false);
   if(StringLen(text) > 0 && font_size > 0)
     {
      if(ObjectSetString(0, name, OBJPROP_TEXT, text) == true
         && ObjectSetInteger(0, name, OBJPROP_FONTSIZE, font_size) == true)
        {
         if((StringLen(font) > 0)
            && ObjectSetString(0, name, OBJPROP_FONT, font) == false)
            return(false);
         if(text_color > -1 && ObjectSetInteger(0, name, OBJPROP_COLOR, text_color) == false)
            return(false);
         return(true);
        }
      return(false);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ENUM_TIMEFRAMES TFMigrate(int tf)
  {
   switch(tf)
     {
      case 0:
         return(PERIOD_CURRENT);
      case 1:
         return(PERIOD_M1);
      case 5:
         return(PERIOD_M5);
      case 15:
         return(PERIOD_M15);
      case 30:
         return(PERIOD_M30);
      case 60:
         return(PERIOD_H1);
      case 240:
         return(PERIOD_H4);
      case 1440:
         return(PERIOD_D1);
      case 10080:
         return(PERIOD_W1);
      case 43200:
         return(PERIOD_MN1);
      case 2:
         return(PERIOD_M2);
      case 3:
         return(PERIOD_M3);
      case 4:
         return(PERIOD_M4);
      case 6:
         return(PERIOD_M6);
      case 10:
         return(PERIOD_M10);
      case 12:
         return(PERIOD_M12);
      case 16385:
         return(PERIOD_H1);
      case 16386:
         return(PERIOD_H2);
      case 16387:
         return(PERIOD_H3);
      case 16388:
         return(PERIOD_H4);
      case 16390:
         return(PERIOD_H6);
      case 16392:
         return(PERIOD_H8);
      case 16396:
         return(PERIOD_H12);
      case 16408:
         return(PERIOD_D1);
      case 32769:
         return(PERIOD_W1);
      case 49153:
         return(PERIOD_MN1);
      default:
         return(PERIOD_CURRENT);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SetIndexStyleMQL4(int index, int type)
  {
   int style = EMPTY;
   int width = EMPTY;
   color clr = CLR_NONE;
   if(width > -1)
      PlotIndexSetInteger(index, PLOT_LINE_WIDTH, width);
   if(clr != CLR_NONE)
      PlotIndexSetInteger(index, PLOT_LINE_COLOR, clr);
   switch(type)
     {
      case 0:
         PlotIndexSetInteger(index, PLOT_DRAW_TYPE, DRAW_LINE);
      case 1:
         PlotIndexSetInteger(index, PLOT_DRAW_TYPE, DRAW_SECTION);
      case 2:
         PlotIndexSetInteger(index, PLOT_DRAW_TYPE, DRAW_HISTOGRAM);
      case 3:
         PlotIndexSetInteger(index, PLOT_DRAW_TYPE, DRAW_ARROW);
      case 4:
         PlotIndexSetInteger(index, PLOT_DRAW_TYPE, DRAW_ZIGZAG);
      case 12:
         PlotIndexSetInteger(index, PLOT_DRAW_TYPE, DRAW_NONE);
      default:
         PlotIndexSetInteger(index, PLOT_DRAW_TYPE, DRAW_LINE);
     }
   switch(style)
     {
      case 0:
         PlotIndexSetInteger(index, PLOT_LINE_STYLE, STYLE_SOLID);
      case 1:
         PlotIndexSetInteger(index, PLOT_LINE_STYLE, STYLE_DASH);
      case 2:
         PlotIndexSetInteger(index, PLOT_LINE_STYLE, STYLE_DOT);
      case 3:
         PlotIndexSetInteger(index, PLOT_LINE_STYLE, STYLE_DASHDOT);
      case 4:
         PlotIndexSetInteger(index, PLOT_LINE_STYLE, STYLE_DASHDOTDOT);
      default:
         return;
     }
  }
//+------------------------------------------------------------------+
double iATRMQL4(string symbol,
                int tf,
                int period,
                int shift)
  {
   ENUM_TIMEFRAMES timeframe = TFMigrate(tf);
   int handle = iATR(symbol, timeframe, period);
   if(handle < 0)
     {
      Print("The iATRMQL4 object is not created: Error", GetLastError());
      return(-1);
     }
   else
      return(CopyBufferMQL4(handle, 0, shift));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double iMAMQL4(string symbol,
               int tf,
               int period,
               int ma_shift,
               int method,
               int price,
               int shift)
  {
   ENUM_TIMEFRAMES timeframe = TFMigrate(tf);
   ENUM_MA_METHOD ma_method = MethodMigrate(method);
   ENUM_APPLIED_PRICE applied_price = PriceMigrate(price);
   int handle = iMA(symbol, timeframe, period, ma_shift,
                    ma_method, applied_price);
   if(handle < 0)
     {
      Print("The iMAMQL4 object is not created: Error", GetLastError());
      return(-1);
     }
   else
      return(CopyBufferMQL4(handle, 0, shift));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ObjectMoveMQL4(string name,
                    int point,
                    datetime time1,
                    double price1)
  {
   return(ObjectMove(0, name, point, time1, price1));
  }
int MACD_Handle;
double MACD_Buffer(int Buffer, int shift)
  {
   double buffer[];
   int val = CopyBuffer(MACD_Handle, Buffer, shift, 1, buffer);
   if(val <= 0)
     {
      return(EMPTY_VALUE);
     }
   return (buffer[0]);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double iStochasticMQL4(string symbol,
                       int tf,
                       int Kperiod,
                       int Dperiod,
                       int slowing,
                       int method,
                       int field,
                       int mode,
                       int shift)
  {
   ENUM_TIMEFRAMES timeframe = TFMigrate(tf);
   ENUM_MA_METHOD ma_method = MethodMigrate(method);
   ENUM_STO_PRICE price_field = StoFieldMigrate(field);
   int handle = iStochastic(symbol, timeframe, Kperiod, Dperiod,
                            slowing, ma_method, price_field);
   if(handle < 0)
     {
      Print("The iStochastic object is not created: Error", GetLastError());
      return(-1);
     }
   else
      return(CopyBufferMQL4(handle, mode, shift));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ObjectsTotalMQL4(int type = EMPTY_VALUE,
                     int window = -1)
  {
   return(ObjectsTotal(0, window, type));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ObjectFindMQL4(string name)
  {
   return(ObjectFind(0, name));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ObjectNameMQL4(int index)
  {
   return(ObjectName(0, index));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ObjectsDeleteAllMQL4(int window = EMPTY,
                         int type = EMPTY)
  {
   return(ObjectsDeleteAll(0, window, type));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int TimeHourMQL4MQL4(datetime date)
  {
   MqlDateTime tm;
   TimeToStruct(date, tm);
   return(tm.hour);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime iTimeMQL4(string symbol, int tf, int index)
  {
   if(index < 0)
      return(-1);
   ENUM_TIMEFRAMES timeframe = TFMigrate(tf);
   datetime Arr[];
   if(CopyTime(symbol, timeframe, index, 1, Arr) > 0)
      return(Arr[0]);
   else
      return(-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int iBarsMQL4(string symbol, int tf)
  {
   ENUM_TIMEFRAMES timeframe = TFMigrate(tf);
   return(Bars(symbol, timeframe));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int TimeHourMQL4(datetime date)
  {
   MqlDateTime tm;
   TimeToStruct(date, tm);
   return(tm.hour);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double ObjectGetMQL4(string name, int index)
  {
   switch(index)
     {
      case OBJPROP_TIME1:
         return(ObjectGetInteger(0, name, OBJPROP_TIME));
      case OBJPROP_PRICE1:
         return(ObjectGetDouble(0, name, OBJPROP_PRICE));
      case OBJPROP_TIME2:
         return(ObjectGetInteger(0, name, OBJPROP_TIME, 1));
      case OBJPROP_PRICE2:
         return(ObjectGetDouble(0, name, OBJPROP_PRICE, 1));
      case OBJPROP_TIME3:
         return(ObjectGetInteger(0, name, OBJPROP_TIME, 2));
      case OBJPROP_PRICE3:
         return(ObjectGetDouble(0, name, OBJPROP_PRICE, 2));
      case OBJPROP_COLOR:
         return(ObjectGetInteger(0, name, OBJPROP_COLOR));
      case OBJPROP_STYLE:
         return(ObjectGetInteger(0, name, OBJPROP_STYLE));
      case OBJPROP_WIDTH:
         return(ObjectGetInteger(0, name, OBJPROP_WIDTH));
      case OBJPROP_BACK:
         return(ObjectGetInteger(0, name, OBJPROP_WIDTH));
      case OBJPROP_RAY:
         return(ObjectGetInteger(0, name, OBJPROP_RAY_RIGHT));
      case OBJPROP_ELLIPSE:
         return(ObjectGetInteger(0, name, OBJPROP_ELLIPSE));
      case OBJPROP_SCALE:
         return(ObjectGetDouble(0, name, OBJPROP_SCALE));
      case OBJPROP_ANGLE:
         return(ObjectGetDouble(0, name, OBJPROP_ANGLE));
      case OBJPROP_ARROWCODE:
         return(ObjectGetInteger(0, name, OBJPROP_ARROWCODE));
      case OBJPROP_TIMEFRAMES:
         return(ObjectGetInteger(0, name, OBJPROP_TIMEFRAMES));
      case OBJPROP_DEVIATION:
         return(ObjectGetDouble(0, name, OBJPROP_DEVIATION));
      case OBJPROP_FONTSIZE:
         return(ObjectGetInteger(0, name, OBJPROP_FONTSIZE));
      case OBJPROP_CORNER:
         return(ObjectGetInteger(0, name, OBJPROP_CORNER));
      case OBJPROP_XDISTANCE:
         return(ObjectGetInteger(0, name, OBJPROP_XDISTANCE));
      case OBJPROP_YDISTANCE:
         return(ObjectGetInteger(0, name, OBJPROP_YDISTANCE));
      case OBJPROP_FIBOLEVELS:
         return(ObjectGetInteger(0, name, OBJPROP_LEVELS));
      case OBJPROP_LEVELCOLOR:
         return(ObjectGetInteger(0, name, OBJPROP_LEVELCOLOR));
      case OBJPROP_LEVELSTYLE:
         return(ObjectGetInteger(0, name, OBJPROP_LEVELSTYLE));
      case OBJPROP_LEVELWIDTH:
         return(ObjectGetInteger(0, name, OBJPROP_LEVELWIDTH));
      default:
         return("Unknown Timeframe");
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int iBarShiftMQL4(string symbol,
                  int tf,
                  datetime time,
                  bool exact = false)
  {
   if(time < 0)
      return(-1);
   ENUM_TIMEFRAMES timeframe = TFMigrate(tf);
   datetime Arr[], time1;
   if(CopyTime(symbol, PERIOD_M30, 0, 1, Arr) > 0)
     {
      time1 = Arr[0];
     }
   else
     {
      //Print("Error copytime");
      //Print(tf);
     }
   if(CopyTime(symbol, timeframe, time, time1, Arr) > 0)
     {
      if(ArraySize(Arr) > 2)
         return(ArraySize(Arr) - 1);
      if(time < time1)
         return(1);
      else
         return(0);
     }
   else
      return(-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int iVolumeMQL4(string symbol, int tf, int index)
  {
   if(index < 0)
      return(-1);
   long Arr[];
   ENUM_TIMEFRAMES timeframe = TFMigrate(tf);
   if(CopyTickVolume(symbol, timeframe, index, 1, Arr) > 0)
      return(Arr[0]);
   else
      return(-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double iOpenMQL4(string symbol, int tf, int index)
  {
   if(index < 0)
      return(-1);
   double Arr[];
   ENUM_TIMEFRAMES timeframe = TFMigrate(tf);
   if(CopyOpen(symbol, timeframe, index, 1, Arr) > 0)
      return(Arr[0]);
   else
      return(-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double iLowMQL4(string symbol, int tf, int index)
  {
   if(index < 0)
      return(-1);
   double Arr[];
   ENUM_TIMEFRAMES timeframe = TFMigrate(tf);
   if(CopyLow(symbol, timeframe, index, 1, Arr) > 0)
      return(Arr[0]);
   else
      return(-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double iHighMQL4(string symbol, int tf, int index)
  {
   if(index < 0)
      return(-1);
   double Arr[];
   ENUM_TIMEFRAMES timeframe = TFMigrate(tf);
   if(CopyHigh(symbol, timeframe, index, 1, Arr) > 0)
      return(Arr[0]);
   else
      return(-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double iCloseMQL4(string symbol, int tf, int index)
  {
   if(index < 0)
      return(-1);
   double Arr[];
   ENUM_TIMEFRAMES timeframe = TFMigrate(tf);
   if(CopyClose(symbol, timeframe, index, 1, Arr) > 0)
      return(Arr[0]);
   else
      return(-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double MarketInfoMQL4(string symbol,
                      int type)
  {
   MqlTick last_tick;
   SymbolInfoTick(_Symbol, last_tick);
   double Bid = last_tick.bid;
   MqlTick last_tick1;
   SymbolInfoTick(_Symbol, last_tick1);
   double Ask = last_tick1.ask;
   switch(type)
     {
      case MODE_LOW:
         return(SymbolInfoDouble(symbol, SYMBOL_LASTLOW));
      case MODE_HIGH:
         return(SymbolInfoDouble(symbol, SYMBOL_LASTHIGH));
      case MODE_TIME:
         return(SymbolInfoInteger(symbol, SYMBOL_TIME));
      case MODE_BID:
         return(Bid);
      case MODE_ASK:
         return(Ask);
      case MODE_POINT:
         return(SymbolInfoDouble(symbol, SYMBOL_POINT));
      case MODE_DIGITS:
         return(SymbolInfoInteger(symbol, SYMBOL_DIGITS));
      case MODE_SPREAD:
         return(SymbolInfoInteger(symbol, SYMBOL_SPREAD));
      case MODE_STOPLEVEL:
         return(SymbolInfoInteger(symbol, SYMBOL_TRADE_STOPS_LEVEL));
      case MODE_LOTSIZE:
         return(SymbolInfoDouble(symbol, SYMBOL_TRADE_CONTRACT_SIZE));
      case MODE_TICKVALUE:
         return(SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE));
      case MODE_TICKSIZE:
         return(SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_SIZE));
      case MODE_SWAPLONG:
         return(SymbolInfoDouble(symbol, SYMBOL_SWAP_LONG));
      case MODE_SWAPSHORT:
         return(SymbolInfoDouble(symbol, SYMBOL_SWAP_SHORT));
      case MODE_STARTING:
         return(0);
      case MODE_EXPIRATION:
         return(0);
      case MODE_TRADEALLOWED:
         return(0);
      case MODE_MINLOT:
         return(SymbolInfoDouble(symbol, SYMBOL_VOLUME_MIN));
      case MODE_LOTSTEP:
         return(SymbolInfoDouble(symbol, SYMBOL_VOLUME_STEP));
      case MODE_MAXLOT:
         return(SymbolInfoDouble(symbol, SYMBOL_VOLUME_MAX));
      case MODE_SWAPTYPE:
         return(SymbolInfoInteger(symbol, SYMBOL_SWAP_MODE));
      case MODE_PROFITCALCMODE:
         return(SymbolInfoInteger(symbol, SYMBOL_TRADE_CALC_MODE));
      case MODE_MARGINCALCMODE:
         return(0);
      case MODE_MARGININIT:
         return(0);
      case MODE_MARGINMAINTENANCE:
         return(0);
      case MODE_MARGINHEDGED:
         return(0);
      case MODE_MARGINREQUIRED:
         return(0);
      case MODE_FREEZELEVEL:
         return(SymbolInfoInteger(symbol, SYMBOL_TRADE_FREEZE_LEVEL));
      default:
         return(0);
     }
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ArraySortMQL4(double & array[],
                  int count = WHOLE_ARRAY,
                  int start = 0,
                  int sort_dir = MODE_ASCEND)
  {
   switch(sort_dir)
     {
      case MODE_ASCEND:
         ArraySetAsSeries(array, true);
      case MODE_DESCEND:
         ArraySetAsSeries(array, false);
      default:
         ArraySetAsSeries(array, true);
     }
   ArraySortMQL4(array);
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int TimeDayOfWeekMQL4(datetime date)
  {
   MqlDateTime tm;
   TimeToStruct(date, tm);
   return(tm.day_of_week);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ENUM_MA_METHOD MethodMigrate(int method)
  {
   switch(method)
     {
      case 0:
         return(MODE_SMA);
      case 1:
         return(MODE_EMA);
      case 2:
         return(MODE_SMMA);
      case 3:
         return(MODE_LWMA);
      default:
         return(MODE_SMA);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ENUM_APPLIED_PRICE PriceMigrate(int price)
  {
   switch(price)
     {
      case 1:
         return(PRICE_CLOSE);
      case 2:
         return(PRICE_OPEN);
      case 3:
         return(PRICE_HIGH);
      case 4:
         return(PRICE_LOW);
      case 5:
         return(PRICE_MEDIAN);
      case 6:
         return(PRICE_TYPICAL);
      case 7:
         return(PRICE_WEIGHTED);
      default:
         return(PRICE_CLOSE);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ENUM_STO_PRICE StoFieldMigrate(int field)
  {
   switch(field)
     {
      case 0:
         return(STO_LOWHIGH);
      case 1:
         return(STO_CLOSECLOSE);
      default:
         return(STO_LOWHIGH);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int iLowestMQL4(string symbol,
                int tf,
                int type,
                int count = WHOLE_ARRAY,
                int start = 0)
  {
   if(start < 0)
      return(-1);
   ENUM_TIMEFRAMES timeframe = TFMigrate(tf);
   if(count <= 0)
      count = Bars(symbol, timeframe);
   if(type <= MODE_OPEN)
     {
      double Open1[];
      ArraySetAsSeries(Open1, true);
      CopyOpen(symbol, timeframe, start, count, Open1);
      return(ArrayMinimum(Open1, 0, count) + start);
     }
   if(type == MODE_LOW)
     {
      double Low2[];
      ArraySetAsSeries(Low2, true);
      CopyLow(symbol, timeframe, start, count, Low2);
      return(ArrayMinimum(Low2, 0, count) + start);
     }
   if(type == MODE_HIGH)
     {
      double High2[];
      ArraySetAsSeries(High2, true);
      CopyHigh(symbol, timeframe, start, count, High2);
      return(ArrayMinimum(High2, 0, count) + start);
     }
   if(type == MODE_CLOSE)
     {
      double Close1[];
      ArraySetAsSeries(Close1, true);
      CopyClose(symbol, timeframe, start, count, Close1);
      return(ArrayMinimum(Close1, 0, count) + start);
     }
   if(type == MODE_VOLUME)
     {
      long Volume[];
      ArraySetAsSeries(Volume, true);
      CopyTickVolume(symbol, timeframe, start, count, Volume);
      return(ArrayMinimum(Volume, 0, count) + start);
     }
   if(type >= MODE_TIME)
     {
      datetime Time2[];
      ArraySetAsSeries(Time2, true);
      CopyTime(symbol, timeframe, start, count, Time2);
      return(ArrayMinimum(Time2, 0, count) + start);
     }
//---
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int iHighestMQL4(string symbol,
                 int tf,
                 int type,
                 int count = WHOLE_ARRAY,
                 int start = 0)
  {
   if(start < 0)
      return(-1);
   ENUM_TIMEFRAMES timeframe = TFMigrate(tf);
   if(count <= 0)
      count = Bars(symbol, timeframe);
   if(type <= MODE_OPEN)
     {
      double Open1[];
      ArraySetAsSeries(Open1, true);
      CopyOpen(symbol, timeframe, start, count, Open1);
      return(ArrayMaximum(Open1, 0, count) + start);
     }
   if(type == MODE_LOW)
     {
      double Low1[];
      ArraySetAsSeries(Low1, true);
      CopyLow(symbol, timeframe, start, count, Low1);
      return(ArrayMaximum(Low1, 0, count) + start);
     }
   if(type == MODE_HIGH)
     {
      double High1[];
      ArraySetAsSeries(High1, true);
      CopyHigh(symbol, timeframe, start, count, High1);
      return(ArrayMaximum(High1, 0, count) + start);
     }
   if(type == MODE_CLOSE)
     {
      double Close1[];
      ArraySetAsSeries(Close1, true);
      CopyClose(symbol, timeframe, start, count, Close1);
      return(ArrayMaximum(Close1, 0, count) + start);
     }
   if(type == MODE_VOLUME)
     {
      long Volume[];
      ArraySetAsSeries(Volume, true);
      CopyTickVolume(symbol, timeframe, start, count, Volume);
      return(ArrayMaximum(Volume, 0, count) + start);
     }
   if(type >= MODE_TIME)
     {
      datetime Time1[];
      ArraySetAsSeries(Time1, true);
      CopyTime(symbol, timeframe, start, count, Time1);
      return(ArrayMaximum(Time1, 0, count) + start);
      //---
     }
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int BarShift(string symbol, ENUM_TIMEFRAMES period, datetime time)
  {
   int i = 0;
   while(iTime(symbol, period, i) > 0)
     {
      if(time >= iTime(symbol, period, i))
        {
         return(i);
        }
      i++;
     }
   return(-1);
  }
int MA50_Handle;
double MA50_Buffer(int shift)
  {
   double buffer[];
   int Buffer = 0;
   if(CopyBuffer(MA50_Handle, Buffer, shift, 1, buffer) < 0)
     {
      return(EMPTY_VALUE);
     }
   return (buffer[0]);
  }
int MA100_Handle;
double MA100_Buffer(int shift)
  {
   double buffer[];
   int Buffer = 0;
   if(CopyBuffer(MA100_Handle, Buffer, shift, 1, buffer) < 0)
     {
      return(EMPTY_VALUE);
     }
   return (buffer[0]);
  }
int MA200_Handle;
double MA200_Buffer(int shift)
  {
   double buffer[];
   int Buffer = 0;
   if(CopyBuffer(MA200_Handle, Buffer, shift, 1, buffer) < 0)
     {
      return(EMPTY_VALUE);
     }
   return (buffer[0]);
  }
int PSAR_Handle;
double PSAR_Buffer(int shift)
  {
   double buffer[];
   int Buffer = 0;
   if(CopyBuffer(PSAR_Handle, Buffer, shift, 1, buffer) < 0)
     {
      return(EMPTY_VALUE);
     }
   return (buffer[0]);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CreateIndicatorsHandles()
  {
   MA50_Handle
      = iMA(_Symbol, _Period, 50, 0, MODE_EMA, PRICE_CLOSE);
   if(MA50_Handle == INVALID_HANDLE)
     {
      //--- tell about the failure and output the error code
      PrintFormat("Failed to create handle of the %s indicator for the symbol %s/%s, error code %d",
                  "MA50",
                  _Symbol,
                  EnumToString(_Period),
                  GetLastError());
      //--- the indicator is stopped early
      return(false);
     }
   MA100_Handle
      = iMA(_Symbol, _Period, 100, 0, MODE_EMA, PRICE_CLOSE);
   if(MA100_Handle == INVALID_HANDLE)
     {
      //--- tell about the failure and output the error code
      PrintFormat("Failed to create handle of the %s indicator for the symbol %s/%s, error code %d",
                  "MA100",
                  _Symbol,
                  EnumToString(_Period),
                  GetLastError());
      //--- the indicator is stopped early
      return(false);
     }
   MA200_Handle
      = iMA(_Symbol, _Period, 200, 0, MODE_EMA, PRICE_CLOSE);
   if(MA200_Handle == INVALID_HANDLE)
     {
      //--- tell about the failure and output the error code
      PrintFormat("Failed to create handle of the %s indicator for the symbol %s/%s, error code %d",
                  "MA200",
                  _Symbol,
                  EnumToString(_Period),
                  GetLastError());
      //--- the indicator is stopped early
      return(false);
     }
   PSAR_Handle
      = iSAR(_Symbol, _Period, 0.02, 0.02);
   if(PSAR_Handle == INVALID_HANDLE)
     {
      //--- tell about the failure and output the error code
      PrintFormat("Failed to create handle of the %s indicator for the symbol %s/%s, error code %d",
                  "PSAR",
                  _Symbol,
                  EnumToString(_Period),
                  GetLastError());
      //--- the indicator is stopped early
      return(false);
     }
   MACD_Handle
      = iMACD(_Symbol, _Period, 12, 26, 9, PRICE_CLOSE);
   if(MACD_Handle == INVALID_HANDLE)
     {
      //--- tell about the failure and output the error code
      PrintFormat("Failed to create handle of the %s indicator for the symbol %s/%s, error code %d",
                  "MACD",
                  _Symbol,
                  EnumToString(_Period),
                  GetLastError());
      //--- the indicator is stopped early
      return(false);
     }
   /*
      {
         HullIndicator_Handle = iCustom(NULL, 0
                                       , HullIndicatorName
                                       , inpPeriod
                                       , inpPrice
                                       , inpDisplayStyle
                                       , false
                                       , false
                                       , false
                                   );

         if(HullIndicator_Handle==INVALID_HANDLE)
         {
            //--- tell about the failure and output the error code
            PrintFormat("Failed to create handle of Hull trend indicator for the symbol %s/%s, error code %d",
                        _Symbol,
                        EnumToString(_Period),
                        GetLastError());
            //--- the indicator is stopped early
            return(false);
         }
      }*/
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsPivotDayOpenBreak(int dir)
  {
   if(Semafor3_Time == 0 || dir == 0)
      return(false);
   int SemaforBarShift = iBarShift(NULL, 0, Semafor3_Time);
   for(int i = SemaforBarShift; i >= 1; i--)
     {
      if(dir > 0
         ? Close[i] > Open[i] && (((Close[i] - Pivot) * (Open[i] - Pivot) < 0 && Low[SemaforBarShift] < Pivot) || ((Close[i] - DailyOpenBuffer[i]) * (Open[i] - DailyOpenBuffer[i]) < 0 && Low[SemaforBarShift] < DailyOpenBuffer[i]))
         : Close[i] < Open[i] && (((Close[i] - Pivot) * (Open[i] - Pivot) < 0 && High[SemaforBarShift] > Pivot) || ((Close[i] - DailyOpenBuffer[i]) * (Open[i] - DailyOpenBuffer[i]) < 0 && High[SemaforBarShift] > DailyOpenBuffer[i]))
        )
        {
         return(true);
        }
     }
   return(false);
  }
//int HullIndicator_Handle;
double HullIndicator_BufferValue(int Buffer, int shift)
  {
   int bars = iBars(_Symbol, _Period);
   shift = bars - 1 - shift;
   if(Buffer == 0)
      return(BuyArrow[shift]);
   else
      if(Buffer == 1)
         return(SellArrow[shift]);
   int zero = 0;
   zero /= zero;
   return(0);
   /*
   double buffer[];
   if(CopyBuffer(HullIndicator_Handle, Buffer, shift, 1, buffer)<0)
   {
      //--- if the copying fails, tell the error code
      //PrintFormat("Failed to copy data from the indicator, error code %d",GetLastError());
      //--- quit with zero result - it means that the indicator is considered as not calculated
      return(EMPTY_VALUE);
   }

   return (buffer[0]);*/
  }
//+-------------------- Hull trend start ----------------------------------------------+
int OnInit_HullTrend()
  {
   SetIndexBuffer(65 + 0, BuyArrow, INDICATOR_DATA);
   PlotIndexSetInteger(57 + 0, PLOT_DRAW_TYPE, DRAW_NONE);
   SetIndexBuffer(65 + 1, SellArrow, INDICATOR_DATA);
   PlotIndexSetInteger(57 + 1, PLOT_DRAW_TYPE, DRAW_NONE);
   SetIndexBuffer(65 + 2, baro, INDICATOR_DATA);
   SetIndexBuffer(65 + 3, barh, INDICATOR_DATA);
   SetIndexBuffer(65 + 4, barl, INDICATOR_DATA);
   SetIndexBuffer(65 + 5, barc, INDICATOR_DATA);
   SetIndexBuffer(65 + 6, barcl, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(65 + 7, cano, INDICATOR_DATA);
   SetIndexBuffer(65 + 8, canh, INDICATOR_DATA);
   SetIndexBuffer(65 + 9, canl, INDICATOR_DATA);
   SetIndexBuffer(65 + 10, canc, INDICATOR_DATA);
   SetIndexBuffer(65 + 11, cancl, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(65 + 12, line, INDICATOR_DATA);
   SetIndexBuffer(65 + 13, linecl, INDICATOR_COLOR_INDEX);
   SetIndexBuffer(65 + 14, hull, INDICATOR_CALCULATIONS);
   SetIndexBuffer(65 + 15, hullcl, INDICATOR_CALCULATIONS);
//IndicatorSetString(INDICATOR_SHORTNAME,"Hull trend ("+(string)inpPeriod+")");
   return (INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnCalculate_HullTrend(const int rates_total,
                          const int prev_calculated,
                          const datetime & time[],
                          const double & open[],
                          const double & high[],
                          const double & low[],
                          const double & close[],
                          const long & tick_volume[],
                          const long & volume[],
                          const int &spread[])
  {
   if(Bars(_Symbol, _Period) < rates_total)
      return(prev_calculated);
   int limit = prev_calculated - 1;
   static int prevDisplayType = -1;
   int currDisplayType = -1;
   switch(inpDisplayStyle)
     {
      case dis_line :
         currDisplayType = CHART_LINE;
         break;
      case dis_bars :
         currDisplayType = CHART_BARS;
         break;
      case dis_candles :
         currDisplayType = CHART_CANDLES;
         break;
      case dis_automatic :
         currDisplayType = CHART_CANDLES;
     }
   if(currDisplayType != prevDisplayType)
     {
      limit = 0;
      prevDisplayType = currDisplayType;
     }
   int i = (int)MathMax(limit, 0);
   for(; i < rates_total && !_StopFlag; i++)
     {
      hull[i]   = iHull(getPrice(inpPrice, open, close, high, low, i, rates_total), inpPeriod, i, rates_total);
      hullcl[i] = (i > 0) ? (hull[i] > hull[i - 1]) ? 1 : (hull[i] < hull[i - 1]) ? 2 : hullcl[i - 1] : 0;
      baro[i] = barh[i] = barl[i] = barc[i] = EMPTY_VALUE;
      cano[i] = canh[i] = canl[i] = canc[i] = EMPTY_VALUE;
      line[i] = EMPTY_VALUE;
      switch(currDisplayType)
        {
         case CHART_BARS :
            barh[i]  = high[i];
            barl[i]  = low[i];
            barc[i]  = close[i];
            baro[i]  = open[i];
            barcl[i] = hullcl[i];
            break;
         case CHART_CANDLES :
            canh[i]  = high[i];
            canl[i]  = low[i];
            canc[i]  = close[i];
            cano[i]  = open[i];
            cancl[i] = hullcl[i];
            break;
         case CHART_LINE :
            line[i] = hull[i];
            linecl[i] = hullcl[i];
        }
      //--- Arrow
      BuyArrow[i] = SellArrow[i] = EMPTY_VALUE;
      if(i >= 1
         && ((cancl[i] == 1 && cancl[i - 1] != 1)
             ||
             (cancl[i] == 2 && cancl[i - 1] != 2)
            )
        )
        {
         bool IsBuy = cancl[i] == 1 && cancl[i - 1] != 1;
         if(IsBuy)
            BuyArrow[i] = low[i];
         else
            SellArrow[i] = high[i];
        }
     }
   return (i);
  }
//+------------------------------------------------------------------+
//| custom functions                                                 |
//+------------------------------------------------------------------+
double workHull[][2];
//
//---
//
double iHull(double price, double period, int r, int bars, int instanceNo = 0)
  {
   if(ArrayRange(workHull, 0) != bars)
      ArrayResize(workHull, bars);
   instanceNo *= 2;
   workHull[r][instanceNo] = price;
   if(period <= 1)
      return(price);
//
//---
//
   int HmaPeriod  = (int)MathMax(period, 2);
   int HalfPeriod = (int)MathFloor(HmaPeriod / 2);
   int HullPeriod = (int)MathFloor(MathSqrt(HmaPeriod));
   double hma, hmw, weight;
   hmw = HalfPeriod;
   hma = hmw * price;
   for(int k = 1; k < HalfPeriod && (r - k) >= 0; k++)
     {
      weight = HalfPeriod - k;
      hmw   += weight;
      hma   += weight * workHull[r - k][instanceNo];
     }
   workHull[r][instanceNo + 1] = 2.0 * hma / hmw;
   hmw = HmaPeriod;
   hma = hmw * price;
   for(int k = 1; k < period && (r - k) >= 0; k++)
     {
      weight = HmaPeriod - k;
      hmw   += weight;
      hma   += weight * workHull[r - k][instanceNo];
     }
   workHull[r][instanceNo + 1] -= hma / hmw;
   hmw = HullPeriod;
   hma = hmw * workHull[r][instanceNo + 1];
   for(int k = 1; k < HullPeriod && (r - k) >= 0; k++)
     {
      weight = HullPeriod - k;
      hmw   += weight;
      hma   += weight * workHull[r - k][1 + instanceNo];
     }
   return(hma / hmw);
  }
//
//---
//
double getPrice(ENUM_APPLIED_PRICE tprice, const double & open[], const double & close[], const double & high[], const double & low[], int i, int _bars)
  {
   switch(tprice)
     {
      case PRICE_CLOSE:
         return(close[i]);
      case PRICE_OPEN:
         return(open[i]);
      case PRICE_HIGH:
         return(high[i]);
      case PRICE_LOW:
         return(low[i]);
      case PRICE_MEDIAN:
         return((high[i] + low[i]) / 2.0);
      case PRICE_TYPICAL:
         return((high[i] + low[i] + close[i]) / 3.0);
      case PRICE_WEIGHTED:
         return((high[i] + low[i] + close[i] + close[i]) / 4.0);
     }
   return(0);
  }
//+-------------------- Hull trend end ----------------------------------------------+
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
