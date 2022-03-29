//+------------------------------------------------------------------+
//|                                                    EntryZone.mq4 |
//|                                     Copyright 2021,Yousuf Mesalm |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021,Yousuf Mesalm"
#property link "https://www.mql5.com"
#property version "1.00"
#property strict

#include "EntryZone.mqh"

CEntry EnrtyExpert;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   //---
   //--- create application dialog
   if (!EnrtyExpert.Create(0, "Entry Zone", 0, 50, 50, 300, 250))
      return (INIT_FAILED);
   //--- run application

   if (!EnrtyExpert.Run())
      return (INIT_FAILED);
   //--- ok
   return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   //---
   EnrtyExpert.Destroy();
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   //---
}
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
   //---
   EnrtyExpert.ChartEvent(id, lparam, dparam, sparam);
}
//+------------------------------------------------------------------+
