//+------------------------------------------------------------------+
//|                                             TEST_EA_MACD_DZZ.mq5 |
//|                                      Copyright 2014, PunkBASSter |
//|                      https://login.mql5.com/en/users/punkbasster |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, PunkBASSter"
#property link      "https://login.mql5.com/en/users/punkbasster"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+
#include <Expert\ExpertAdvanced.mqh>
//--- available signals
#include <Expert\Signal\SignalAO.mqh>
#include <Expert\MySignals\PriceDeltaZZ.mqh>
//--- available trailing
#include <Expert\Trailing\TrailingNone.mqh>
//--- available money management
#include <Expert\Money\MoneyFixedLot.mqh>
//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+
//--- inputs for expert
input string Expert_Title                 ="TEST_EA_MACD_DZZ"; // Document name
ulong        Expert_MagicNumber           =19743;              // 
bool         Expert_EveryTick             =false;              // 
//--- inputs for main signal
input int    Signal_ThresholdOpen         =10;                 // Signal threshold value to open [0...100]
input int    Signal_ThresholdClose        =10;                 // Signal threshold value to close [0...100]

input double Signal_AO_Weight             =1.0;                // Awesome Oscillator H12 Weight [0...1.0]
input int    Signal_DeltaZZ_PM_setAppPrice=1;                  // DeltaZZ Price Module(1,0,...) Applied price: 0 - Close
input int    Signal_DeltaZZ_PM_setRevMode =0;                  // DeltaZZ Price Module(1,0,...) Reversal mode: 0 - Pips
input int    Signal_DeltaZZ_PM_setPips    =300;                // DeltaZZ Price Module(1,0,...) Reverse in pips
input double Signal_DeltaZZ_PM_setPercent =0.5;                // DeltaZZ Price Module(1,0,...) Reverse in percent
input int    Signal_DeltaZZ_PM_setLevels  =2;                  // DeltaZZ Price Module(1,0,...) Peaks number
input double Signal_DeltaZZ_PM_setTpRatio =1.6;                // DeltaZZ Price Module(1,0,...) TP:SL ratio
input int    Signal_DeltaZZ_PM_setExpBars =10;                 // DeltaZZ Price Module(1,0,...) Expiration after bars number
input double Signal_DeltaZZ_PM_Weight     =1.0;                // DeltaZZ Price Module(1,0,...) Weight [0...1.0]
//--- inputs for money
input double Money_FixLot_Percent         =10.0;               // Percent
input double Money_FixLot_Lots            =0.1;                // Fixed volume
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

//--- Creating filter CSignalAO
CSignalAO *filter0=new CSignalAO;
if(filter0==NULL)
  {
   //--- failed
   printf(__FUNCTION__+": error creating filter0");
   ExtExpert.Deinit();
   return(INIT_FAILED);
  }
signal.AddFilter(filter0);
//--- Set filter parameters
filter0.Period(PERIOD_H12);
filter0.Weight(Signal_AO_Weight);
//--- Creating filter CPriceDeltaZZ
CPriceDeltaZZ *filter1=new CPriceDeltaZZ;
if(filter1==NULL)
  {
   //--- failed
   printf(__FUNCTION__+": error creating filter1");
   ExtExpert.Deinit();
   return(INIT_FAILED);
  }
signal.CalcPriceModuleIndex();
signal.AddFilter(filter1);
//--- Set filter parameters
filter1.setAppPrice(Signal_DeltaZZ_PM_setAppPrice);
filter1.setRevMode(Signal_DeltaZZ_PM_setRevMode);
filter1.setPips(Signal_DeltaZZ_PM_setPips);
filter1.setPercent(Signal_DeltaZZ_PM_setPercent);
filter1.setLevels(Signal_DeltaZZ_PM_setLevels);
filter1.setTpRatio(Signal_DeltaZZ_PM_setTpRatio);
filter1.setExpBars(Signal_DeltaZZ_PM_setExpBars);
filter1.Weight(Signal_DeltaZZ_PM_Weight);
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
