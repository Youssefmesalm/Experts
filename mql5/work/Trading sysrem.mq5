//+------------------------------------------------------------------+
//|                                                   Check Time.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
// Input variable of trading day
input bool              TradeOnMonday        = true;                       // Trade on Monday
input bool              TradeOnTuesday       = true;                       // Trade on Tuesday
input bool              TradeOnWednesday     = true;                       // Trade on Wednesday
input bool              TradeOnThursday      = true;                       // Trade on Thursday
input bool              TradeOnFriday        = true;                       // Trade on Friday
input bool              UsingTradingHour     = true;                       // Using Trade Hour
input int               StartHour            = 0;                          // Start Hour
input int               EndHour              = 12;                         // End Hour
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
 {
   if ( TimeCheck() == false ) return;
   
 }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Time Check Function                                              |
//+------------------------------------------------------------------+   
bool TimeCheck()
 {
   bool Result = false;
   bool CheckDay = false;
   bool CheckHour = false;
   MqlDateTime TimeNow;
   TimeToStruct(TimeCurrent(),TimeNow);
   // Check day
   if (  ( TimeNow.day_of_week == 1 && TradeOnMonday ) ||
         ( TimeNow.day_of_week == 2 && TradeOnTuesday ) ||
         ( TimeNow.day_of_week == 3 && TradeOnWednesday ) ||
         ( TimeNow.day_of_week == 4 && TradeOnThursday ) ||
         ( TimeNow.day_of_week == 5 && TradeOnFriday ) )
            CheckDay = true;
   // Check hour
   if ( StartHour < EndHour )
      if (  TimeNow.hour >= StartHour &&
         TimeNow.hour <= EndHour )  CheckHour = true;
   if ( StartHour > EndHour )
      if (  TimeNow.hour >= StartHour ||
         TimeNow.hour <= EndHour )  CheckHour = true;
   if ( StartHour == EndHour )
      if (  TimeNow.hour == StartHour )  CheckHour = true;
   // Check All
   if ( UsingTradingHour && CheckDay && CheckHour ) Result = true;
   if ( !UsingTradingHour && CheckDay ) Result = true;
   return(Result);
 }