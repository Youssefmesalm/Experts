//+------------------------------------------------------------------+
//|                                                SlidingPuzzle.mq5 |
//|                                                   Enrico Lambino |
//|                                      www.mql5.com/en/users/iceron|
//+------------------------------------------------------------------+
#property copyright "Enrico Lambino"
#property link      "www.mql5.com/en/users/iceron"
#property strict
#include "SlidingPuzzle.mqh"
CSlidingPuzzleDialog ExtDialog;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create application dialog
   if(!ExtDialog.Create(0,"Sliding Puzzle",0,50,50,250,250))
      return(INIT_FAILED);
//--- run application
   if(!ExtDialog.Run())
      return(INIT_FAILED);
//--- ok
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   ExtDialog.Destroy(reason);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
   ExtDialog.ChartEvent(id,lparam,dparam,sparam);
  }
//+------------------------------------------------------------------+
