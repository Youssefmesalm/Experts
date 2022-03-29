//+------------------------------------------------------------------+
//|                                         TEST_EA_AO_DZZ_IB_OB.mq5 |
//|                                      Copyright 2014, PunkBASSter |
//|                      https://login.mql5.com/en/users/punkbasster |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, PunkBASSter"
#property link      "https://login.mql5.com/en/users/punkbasster"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+
#include <Expert\ExpertAdvanced.mqh>   //WHAT WAS BEFORE: #include <Expert\Expert.mqh>
//--- available signals
#include <Expert\Signal\SignalAO.mqh>
#include <Expert\MySignals\PriceDeltaZZ.mqh>
#include <Expert\MySignals\PriceInsideBar.mqh>
#include <Expert\MySignals\PriceOutsideBar.mqh>
//--- available trailing
#include <Expert\Trailing\TrailingNone.mqh>
//--- available money management
#include <Expert\Money\MoneyFixedLot.mqh>
//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+
//--- inputs for expert
input string Expert_Title                 ="TEST_EA_AO_DZZ_IB_OB"; // Document name
ulong        Expert_MagicNumber           =377;                    // 
bool         Expert_EveryTick             =false;                  // 
//--- inputs for main signal
input int    Signal_ThresholdOpen         =10;                     // Signal threshold value to open [0...100]
input int    Signal_ThresholdClose        =10;                     // Signal threshold value to close [0...100]
/*The commented parameters are not used. You can delete commented lines:
input double Signal_PriceLevel            =0.0;                    // Price level to execute a deal
input double Signal_StopLevel             =50.0;                   // Stop Loss level (in points)
input double Signal_TakeLevel             =50.0;                   // Take Profit level (in points)
input int    Signal_Expiration            =4;                      // Expiration of pending orders (in bars)
*/
input double Signal_AO_Weight             =1.0;                    // Awesome Oscillator H12 Weight [0...1.0]
input int    Signal_DeltaZZ_PM_setAppPrice=1;                      // DeltaZZ Price Module(1,0,...) Applied price: 0 - Close
input int    Signal_DeltaZZ_PM_setRevMode =0;                      // DeltaZZ Price Module(1,0,...) Reversal mode: 0 - Pips
input int    Signal_DeltaZZ_PM_setPips    =300;                    // DeltaZZ Price Module(1,0,...) Reverse in pips
input double Signal_DeltaZZ_PM_setPercent =0.5;                    // DeltaZZ Price Module(1,0,...) Reverse in percent
input int    Signal_DeltaZZ_PM_setLevels  =2;                      // DeltaZZ Price Module(1,0,...) Peaks number
input double Signal_DeltaZZ_PM_setTpRatio =1.6;                    // DeltaZZ Price Module(1,0,...) TP:SL ratio
input int    Signal_DeltaZZ_PM_setExpBars =10;                     // DeltaZZ Price Module(1,0,...) Expiration after bars number
input double Signal_DeltaZZ_PM_Weight     =1.0;                    // DeltaZZ Price Module(1,0,...) Weight [0...1.0]
input double Signal_IB_PM_setTpRatio      =2;                      // Inside Bar Price Module(2,...) TP:SL ratio
input int    Signal_IB_PM_setExpBars      =10;                     // Inside Bar Price Module(2,...) Expiration after bars number
input int    Signal_IB_PM_setOrderOffset  =5;                      // Inside Bar Price Module(2,...) Offset for open and stop loss
input double Signal_IB_PM_Weight          =0.5;                    // Inside Bar Price Module(2,...) Weight [0...1.0]
input double Signal_OB_PM_setTpRatio      =1.5;                    // Outside Bar Price Module TP:SL ratio
input int    Signal_OB_PM_setExpBars      =10;                     // Outside Bar Price Module Expiration after bars number
input int    Signal_OB_PM_setOrderOffset  =5;                      // Outside Bar Price Module Offset for open and stop loss
input double Signal_OB_PM_Weight          =0.7;                    // Outside Bar Price Module Weight [0...1.0]
//--- inputs for money
input double Money_FixLot_Percent         =10.0;                   // Percent
input double Money_FixLot_Lots            =0.1;                    // Fixed volume
//+------------------------------------------------------------------+
//| Global expert object                                             |
//+------------------------------------------------------------------+
CExpertAdvanced ExtExpert; //WHAT WAS BEFORE: CExpert ExtExpert;
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
   CExpertSignalAdvanced *signal=new CExpertSignalAdvanced; //WAS BEFORE: CExpertSignal *signal=new CExpertSignal;
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
   
   /*The commented parameters are not used. You can delete commented lines:
   signal.PriceLevel(Signal_PriceLevel);
   signal.StopLevel(Signal_StopLevel);
   signal.TakeLevel(Signal_TakeLevel);
   signal.Expiration(Signal_Expiration);
   */
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
//=====================================================================================
signal.CalcPriceModuleIndex();//<--- ADD THIS LINE BEFORE ADDING THE FIRST PRICE MODULE
//=====================================================================================
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
//--- Creating filter CPriceInsideBar
CPriceInsideBar *filter2=new CPriceInsideBar;
if(filter2==NULL)
  {
   //--- failed
   printf(__FUNCTION__+": error creating filter2");
   ExtExpert.Deinit();
   return(INIT_FAILED);
  }
signal.AddFilter(filter2);
//--- Set filter parameters
filter2.setTpRatio(Signal_IB_PM_setTpRatio);
filter2.setExpBars(Signal_IB_PM_setExpBars);
filter2.setOrderOffset(Signal_IB_PM_setOrderOffset);
filter2.Weight(Signal_IB_PM_Weight);
//--- Creating filter CPriceOutsideBar
CPriceOutsideBar *filter3=new CPriceOutsideBar;
if(filter3==NULL)
  {
   //--- failed
   printf(__FUNCTION__+": error creating filter3");
   ExtExpert.Deinit();
   return(INIT_FAILED);
  }
signal.AddFilter(filter3);
//--- Set filter parameters
filter3.setTpRatio(Signal_OB_PM_setTpRatio);
filter3.setExpBars(Signal_OB_PM_setExpBars);
filter3.setOrderOffset(Signal_OB_PM_setOrderOffset);
filter3.Weight(Signal_OB_PM_Weight);
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
