//+------------------------------------------------------------------+
//|                                               RL gmdh trader.mq5 |
//|                                 Copyright 2018, Max Dmitrievskiy |
//|                        https://www.mql5.com/ru/users/dmitrievsky |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Max Dmitrievskiy"
#property link      "https://www.mql5.com/ru/users/dmitrievsky"
#property version   "1.00"

#include <RL Monte Carlo.mqh>
#include <Trade\AccountInfo.mqh>

input int       number_of_passes = 50;
input double    shift_probab = 0.01;
input double    regularize=0.2;
input int       number_of_best_features = 15;
sinput double   treshhold = 0.0;
sinput double   MaximumRisk=0.01;
sinput double   CustomLot=0;

CRLAgents *ag1=new CRLAgents("RlMonteCarloMulti",5,500,number_of_best_features,50,regularize,shift_probab);

static datetime last_time=0;
double Tsignal;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
   ag1.setAgentSettings(0,500,20,50,regularize,shift_probab);
   ag1.setAgentSettings(1,200,15,50,regularize,shift_probab);
   ag1.setAgentSettings(2,100,10,50,regularize,shift_probab);
   ag1.setAgentSettings(3,50,5,50,regularize,shift_probab);
   ag1.setAgentSettings(4,25,2,50,regularize,shift_probab);
   return(INIT_SUCCEEDED);
  }
  
//+------------------------------------------------------------------+
//| Expert ontester function                                         |
//+------------------------------------------------------------------+
double OnTester() {
   if(MQLInfoInteger(MQL_OPTIMIZATION)) return ag1.learnAllAgents();
   else return NULL;
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
   delete ag1;
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
   if(!isNewBar())
      return;
   calcTsignal();
   placeOrders();
  }
//+------------------------------------------------------------------+
//| Calculate Tsignal                                                 |
//+------------------------------------------------------------------+
void calcTsignal() {
   Tsignal=0;
   for(int i=0;i<ArraySize(ag1.agent);i++) {
      CopyClose(_Symbol,0,1,ArraySize(ag1.agent[i].inpVector),ag1.agent[i].inpVector);
      ArraySetAsSeries(ag1.agent[i].inpVector,true);
     }
   Tsignal=ag1.getTradeSignal();
  }
//+------------------------------------------------------------------+
//| Place orders                                                     |
//+------------------------------------------------------------------+
void placeOrders() {
   for(int b=OrdersTotal()-1; b>=0; b--)
     if(OrderSelect(b,SELECT_BY_POS)==true) {
        if(OrderType()==0 && Tsignal>0.5) if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,Red)) {ag1.updateRewards();}
        if(OrderType()==1 && Tsignal<0.5) if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,Red)) {ag1.updateRewards();}
       }
      
   if((countOrders(0)!=0 || countOrders(1)!=0)) return;
     
   if(countOrders(0)==0 && Tsignal<0.5-treshhold && (OrderSend(Symbol(),OP_BUY,lotsOptimized(),SymbolInfoDouble(_Symbol,SYMBOL_ASK),0,0,0,NULL,OrderMagic,INT_MIN)>0)) { ag1.updatePolicies(Tsignal); }
   if(countOrders(1)==0 && Tsignal>0.5+treshhold && (OrderSend(Symbol(),OP_SELL,lotsOptimized(),SymbolInfoDouble(_Symbol,SYMBOL_BID),0,0,0,NULL,OrderMagic,INT_MIN)>0)) { ag1.updatePolicies(Tsignal); }
  }
//+------------------------------------------------------------------+
//| Optimize lots                                                    |
//+------------------------------------------------------------------+
double lotsOptimized() {
   double lot;

   if(MQLInfoInteger(MQL_OPTIMIZATION)==true) {
      lot=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN);
      return lot;
     }
   CAccountInfo myaccount; SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_STEP);

   lot=NormalizeDouble(myaccount.FreeMargin()*MaximumRisk/1000.0,2);
   if(CustomLot!=0.0) lot=CustomLot;

   double volume_step=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_STEP);
   int ratio=(int)MathRound(lot/volume_step);
   if(MathAbs(ratio*volume_step-lot)>0.0000001)
      lot=ratio*volume_step;

   if(lot<SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN)) lot=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN);
   if(lot>SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX)) lot=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX);
   return(lot);
  }
//+------------------------------------------------------------------+
//| New bar func                                                     |
//+------------------------------------------------------------------+
bool isNewBar() {
   datetime lastbar_time=datetime(SeriesInfoInteger(Symbol(),_Period,SERIES_LASTBAR_DATE));
   if(last_time==0) {
      last_time=lastbar_time;
      return(false);
     }
   if(last_time!=lastbar_time) {
      last_time=lastbar_time;
      return(true);
     }
   return(false);
  }
