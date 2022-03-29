//+------------------------------------------------------------------+
//|                                             TrendBreakout EA.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

extern string   General_Settings   = "------< General_Settings >------";
input double Lots1 =0.1;
input int TakeProfit1=0;
input double Lots2 =0.1;
input int TakeProfit2=0;
input double Lots3 =0.1;
input int TakeProfit3=0;
input int MagicNumber =121221;
enum Order {BUY,SELL,BUYSELL};
input Order TypeOrder=BUYSELL;

extern string   Renko_SetUP   = "------< Renko Super-signals_v3 double_SetUP >------";
input ENUM_TIMEFRAMES Time1 = PERIOD_M5;
input int PeriodWeekChannel = 24;
input int PeriodMainChannel = 96;
input bool alertsOn = true;
input bool alertsMessage = true;
input bool alertsSound = false;
input bool alertsEmail = false;
input string soundFile = "alert2.wav";

datetime Lasttradetime =0;
double sl, tp1,tp2,tp3;
double Loww1=100;
double Highh1=0;
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
//---
   double Value0 = iCustom(Symbol(),Time1,"Renko Super-signals_v3 double",PeriodWeekChannel,PeriodMainChannel,alertsOn,alertsMessage,alertsSound,alertsEmail,soundFile,0,AppearSellSignal());
   double Value1 = iCustom(Symbol(),Time1,"Renko Super-signals_v3 double",PeriodWeekChannel,PeriodMainChannel,alertsOn,alertsMessage,alertsSound,alertsEmail,soundFile,1,AppearBuySignal());
   double UWC = iCustom(Symbol(),Time1,"Renko Super-signals_v3 double",PeriodWeekChannel,PeriodMainChannel,alertsOn,alertsMessage,alertsSound,alertsEmail,soundFile,4,1);
   double LWC = iCustom(Symbol(),Time1,"Renko Super-signals_v3 double",PeriodWeekChannel,PeriodMainChannel,alertsOn,alertsMessage,alertsSound,alertsEmail,soundFile,5,1);
   Loww1 = MathMin(UWC,Loww1);
   Highh1 = MathMax(LWC,Highh1);
   if(countOrder()==0)
     {
   if(TypeOrder == BUY || TypeOrder==BUYSELL)
     {
      if(Close[1]>Loww1 && Open[1]<Loww1)
        {
         if(Lasttradetime!=Time[0])
           {
            CloseOrderSell();
            if(TakeProfit1==0){tp1=0;}else{tp1= Ask+TakeProfit1*Point;}
            if(TakeProfit2==0){tp2=0;}else{tp2= Ask+TakeProfit2*Point;}
            if(TakeProfit3==0){tp3=0;}else{tp3= Ask+TakeProfit3*Point;}
            
            if(OrderSend(Symbol(),OP_BUY,Lots1,Ask,30,Value1,tp1,"Buy1",MagicNumber,0,clrBlue)==false){GetLastError();}
            if(OrderSend(Symbol(),OP_BUY,Lots2,Ask,30,Value1,tp2,"Buy2",MagicNumber,0,clrBlue)==false){GetLastError();}
            if(OrderSend(Symbol(),OP_BUY,Lots3,Ask,30,Value1,tp3,"Buy3",MagicNumber,0,clrBlue)==false){GetLastError();}
            
            Lasttradetime =Time[0];
           }
        }
     }
   if(TypeOrder == SELL || TypeOrder==BUYSELL)
     {
      if(Close[1]<Highh1 && Open[1]>Highh1)
        {
         if(Lasttradetime!=Time[0])
           {
            CloseOrderBuy();
            if(TakeProfit1==0){tp1=0;}else{tp1= Bid-TakeProfit1*Point;}
            if(TakeProfit2==0){tp2=0;}else{tp2= Bid-TakeProfit2*Point;}
            if(TakeProfit3==0){tp3=0;}else{tp3= Bid-TakeProfit3*Point;}
            
            if(OrderSend(Symbol(),OP_SELL,Lots1,Bid,30,Value0,tp1,"Sell1",MagicNumber,0,clrRed)==false){GetLastError();}
            if(OrderSend(Symbol(),OP_SELL,Lots2,Bid,30,Value0,tp2,"Sell2",MagicNumber,0,clrRed)==false){GetLastError();}
            if(OrderSend(Symbol(),OP_SELL,Lots3,Bid,30,Value0,tp3,"Sell3",MagicNumber,0,clrRed)==false){GetLastError();}
            
            Lasttradetime =Time[0];
           }
        }
     }
          }
  }
//+------------------------------------------------------------------+
void CloseOrderBuy()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {

      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         GetLastError();
        }
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber && OrderComment()=="Buy3")
        {
         if(OrderType() == OP_BUY)
           {
            if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,clrWhite)==false)
              {
               GetLastError();
              }
           }
        }

     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseOrderSell()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {

      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         GetLastError();
        }
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber && OrderComment()=="Sell1")
        {
         if(OrderType() == OP_SELL)
           {
            if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,clrWhite)==false)
              {
               GetLastError();
              }
           }

        }

     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int  AppearBuySignal()
  {
   double p = 0;
   for(int i=1; i<Bars; i++)
     {
      double Value1 = iCustom(Symbol(),Time1,"Renko Super-signals_v3 double",PeriodWeekChannel,PeriodMainChannel,alertsOn,alertsMessage,alertsSound,alertsEmail,soundFile,1,i);
      if(Value1!=0 && Value1!=EMPTY_VALUE)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
int  AppearSellSignal()
  {
   double p = 0;
   for(int i=1; i<Bars; i++)
     {
      double Value0 = iCustom(Symbol(),Time1,"Renko Super-signals_v3 double",PeriodWeekChannel,PeriodMainChannel,alertsOn,alertsMessage,alertsSound,alertsEmail,soundFile,0,i);
      if(Value0!=0 && Value0!=EMPTY_VALUE)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
int countOrder()
  {
   int count =0;
   for(int i=OrdersTotal(); i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
           {
            GetLastError();
           }
      if(OrderSymbol()==Symbol()&& OrderMagicNumber()== MagicNumber)
        {
         count++;

        }
     }
   return(count);
  }