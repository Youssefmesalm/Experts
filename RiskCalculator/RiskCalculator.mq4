
//+------------------------------------------------------------------+
//|                                              Risk Calculator.mq5 |
//|                                  Copyright 2021,DR Yousuf Mesalm |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021,DR Yousuf Mesalm"
#property link "https://www.mql5.com"
#property version "1.00"
#property strict

#include <Experts/RiskCalculator/RiskCalculator.mqh>

CRiskCalculator ExtDialog;

int OnInit()
{
   //---
   //--- create application dialog
   if (!ExtDialog.Create(0, "Risk Calculator", 0, 50, 50, 300, 400))
      return (INIT_FAILED);
   //--- run application

   if (!ExtDialog.Run())
      return (INIT_FAILED);
   //--- ok
   return (INIT_SUCCEEDED);
}
void OnDeinit(const int reason)
{
   //---
   ExtDialog.Destroy(reason);
}

void OnTick()
{
   //---
   ExtDialog.OnTick();
}
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
   ExtDialog.ChartEvent(id, lparam, dparam, sparam);
   ExtDialog.ChartDrag(id, lparam, dparam, sparam);
}
//+------------------------------------------------------------------+
