//+------------------------------------------------------------------+
//|                                                 Dr Zain Agha.mq5 |
//|                                   Copyright 2022, Yousuf Mesalm. |
//|                                    https://www.Yousuf-mesalm.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Yousuf Mesalm."
#property link      "https://www.Yousuf-mesalm.com"
#property version   "1.00"
// Includes
#include  <YM\Execute\Execute.mqh>
#include  <YM\Position\Position.mqh>


// User inputs
input long MagicNumber=2020;
input double Lot=0.1;
input double TpRR=2;
input string comment=" Yousuf Mesalm";
datetime lasttime=0;


CUtilities tools;
CExecute trade(Symbol(), MagicNumber);
CPosition SellPos(Symbol(), MagicNumber, GROUP_POSITIONS_SELLS);
CPosition BuyPos(Symbol(), MagicNumber, GROUP_POSITIONS_BUYS);
CPosition Pos(Symbol(), MagicNumber, GROUP_POSITIONS_ALL);
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
   double Last_High=iHigh(Symbol(),PERIOD_D1,1);
   double Last_Low =iLow(Symbol(),PERIOD_D1,1);
   double current_High=iHigh(Symbol(),PERIOD_M15,1);
   double current_Low=iLow(Symbol(),PERIOD_M15,1);
   double current_Open=iOpen(Symbol(),PERIOD_M15,1);
   double current_Close=iClose(Symbol(),PERIOD_M15,1);
   datetime current_time= iTime(Symbol(),PERIOD_M15,1);
   if(current_Low<Last_Low&&current_Close>Last_Low&&lasttime!=current_time)
     {
      lasttime=current_time;
      double tp=((tools.Bid()-Last_Low)*TpRR)+tools.Bid();
      trade.Position(TYPE_POSITION_BUY,Lot,Last_Low,tp,SLTP_PRICE,30,comment);
     }
   if(current_High>Last_High&&current_Close<Last_High&&lasttime!=current_time)
     {
      lasttime=current_time;
      double tp=tools.Bid()-((tools.Bid()+Last_High)*TpRR);
      trade.Position(TYPE_POSITION_SELL,Lot,Last_High,tp,SLTP_PRICE,30,comment);
     }
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

  }
//+------------------------------------------------------------------+
