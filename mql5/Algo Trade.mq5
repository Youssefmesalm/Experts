//+------------------------------------------------------------------+
//|                                                   Algo Trade.mq5 |
//|                                  Copyright 2021,DR Yousuf Mesalm |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021,DR Yousuf Mesalm"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+
#include <Expert\ExpertAdvanced.mqh>
//--- available signals
#include <Expert\MySignals\TRI.mqh>
//--- available trailing
#include <Expert\Trailing\TrailingNone.mqh>
//--- available money management
#include <Expert\Money\MoneyFixedLot.mqh>
//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+
//--- inputs for expert
input string          Expert_Title          ="Algo Trade";   // Document name
ulong                 Expert_MagicNumber    =15963;          //
bool                  Expert_EveryTick      =false;          //
//--- inputs for main signal
input   ENUM_SYMBOLS_MODE InpModeUsedSymbols   =  SYMBOLS_MODE_CURRENT;            // Mode of used symbols list
input   string            InpUsedSymbols       =  "EURUSD,AUDUSD,EURAUD,EURCAD,EURGBP,EURJPY,EURUSD,GBPUSD,NZDUSD,USDCAD,USDJPY";  // List of used symbols (comma - separator)
input   ENUM_TIMEFRAMES_MODE InpModeUsedTFs    =  TIMEFRAMES_MODE_LIST;            // Mode of used timeframes list
input   string            InpUsedTFs           =  "M1,M5,M15,M30,H1,H4,D1,W1,MN1"; // List of used timeframes (comma - separator)
input   ENUM_INPUT_YES_NO InpUseBook           =  INPUT_No;                       // Use Depth of Market
input   ENUM_INPUT_YES_NO InpUseMqlSignals     =  INPUT_NO;                       // Use signal service
input   ENUM_INPUT_YES_NO InpUseCharts         =  INPUT_NO;                       // Use Charts control
input   ENUM_INPUT_YES_NO InpUseSounds         =  INPUT_YES;                       // Use sounds

input int             Signal_ThresholdOpen  =10;             // Signal threshold value to open [0...100]
input int             Signal_ThresholdClose =10;             // Signal threshold value to close [0...100]
input double          Signal_PriceLevel     =0.0;            // Price level to execute a deal
input double          Signal_StopLevel      =50.0;           // Stop Loss level (in points)
input double          Signal_TakeLevel      =50.0;           // Take Profit level (in points)
input int             Signal_Expiration     =4;              // Expiration of pending orders (in bars)
input int             Signal_Tri_Set_Numbers=2000;           // Triangular Signal(2000,...) Number of N
input ENUM_TIMEFRAMES Signal_Tri_Set_Period =PERIOD_CURRENT; // Triangular Signal(2000,...) chart period
input double          Signal_Tri_Weight     =1.0;            // Triangular Signal(2000,...) Weight [0...1.0]
//--- inputs for money
input double          Money_FixLot_Percent  =10.0;           // Percent
input double          Money_FixLot_Lots     =0.1;            // Fixed volume
//+------------------------------------------------------------------+
//| Global expert object                                             |
//+------------------------------------------------------------------+
CExpertAdvanced ExtExpert;
//+------------------------------------------------------------------+
//| Initialization function of the expert                            |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- Initializing expert
//--- Initializing expert
   ExtExpert.Set_UsedSymbols(InpUsedSymbols);
   ExtExpert.Set_UsedTFs(InpUsedTFs);
   ExtExpert.Set_ModeUsedSymbols(InpModeUsedSymbols);
   ExtExpert.Set_ModeUsedTFs(InpModeUsedTFs);
   ExtExpert.Set_UseBook(InpUseBook);
   ExtExpert.Set_UseCharts(InpUseCharts);
   ExtExpert.Set_UseSounds(InpUseSounds);
   ExtExpert.Set_UseMqlSignals(InpUseMqlSignals);
   //-------------------------------------------------
   if(!ExtExpert.Init(Symbol(),Period(),Expert_EveryTick,Expert_MagicNumber))
     {
      //--- failed
      printf(__FUNCTION__+": error initializing expert");
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
//--- Creating signal
   CExpertSignalAdvanced *signal=new CExpertSignalAdvanced;
   if(signal==NULL)
     {
      //--- failed
      printf(__FUNCTION__+": error creating signal");
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
//---
   ExtExpert.InitSignal(signal);
   signal.ThresholdOpen(Signal_ThresholdOpen);
   signal.ThresholdClose(Signal_ThresholdClose);
   signal.PriceLevel(Signal_PriceLevel);
   signal.StopLevel(Signal_StopLevel);
   signal.TakeLevel(Signal_TakeLevel);
   signal.Expiration(Signal_Expiration);
//--- Creating filter CTriangularSignal
   CTriangularSignal *filter0=new CTriangularSignal;
   if(filter0==NULL)
     {
      //--- failed
      printf(__FUNCTION__+": error creating filter0");
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
   signal.AddFilter(filter0);
//--- Set filter parameters
   filter0.Set_Numbers(Signal_Tri_Set_Numbers);
   filter0.Set_Period(Signal_Tri_Set_Period);
   filter0.Weight(Signal_Tri_Weight);
//--- Creation of trailing object
   CTrailingNone *trailing=new CTrailingNone;
   if(trailing==NULL)
     {
      //--- failed
      printf(__FUNCTION__+": error creating trailing");
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
//--- Add trailing to expert (will be deleted automatically))
   if(!ExtExpert.InitTrailing(trailing))
     {
      //--- failed
      printf(__FUNCTION__+": error initializing trailing");
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
//--- Set trailing parameters
//--- Creation of money object
   CMoneyFixedLot *money=new CMoneyFixedLot;
   if(money==NULL)
     {
      //--- failed
      printf(__FUNCTION__+": error creating money");
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
//--- Add money to expert (will be deleted automatically))
   if(!ExtExpert.InitMoney(money))
     {
      //--- failed
      printf(__FUNCTION__+": error initializing money");
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
//--- Set money parameters
   money.Percent(Money_FixLot_Percent);
   money.Lots(Money_FixLot_Lots);
//--- Check all trading objects parameters
   if(!ExtExpert.ValidationSettings())
     {
      //--- failed
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
//--- Tuning of all necessary indicators
   if(!ExtExpert.InitIndicators())
     {
      //--- failed
      printf(__FUNCTION__+": error initializing indicators");
      ExtExpert.Deinit();
      return(INIT_FAILED);
     }
//--- ok
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Deinitialization function of the expert                          |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   ExtExpert.Deinit();
  }
//+------------------------------------------------------------------+
//| "Tick" event handler function                                    |
//+------------------------------------------------------------------+
void OnTick()
  {
   ExtExpert.OnTick();
  }
//+------------------------------------------------------------------+
//| "Trade" event handler function                                   |
//+------------------------------------------------------------------+
void OnTrade()
  {
   ExtExpert.OnTrade();
  }
//+------------------------------------------------------------------+
//| "Timer" event handler function                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
   ExtExpert.OnTimer();
  }
//+------------------------------------------------------------------+
