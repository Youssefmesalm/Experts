//+------------------------------------------------------------------+
//|                                                Ashi_Arrow_EA.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


extern string   General_Settings   = "------< General Settings >------";
input double Lots =0.1;
input int takeprofit=0;
input int stoploss=0;
input int MagicNumber =789;
extern string   Close_SetUP   = "------< Close_SetUP >------";
input bool     Use_Close     = false;

extern string   Martingale_SetUP   = "------< Martingale _SetUP >------";
input bool     Use_Martingale      = false;
input int Multi = 2;
input int pip_martingle = 20;
extern string  Indicator_Channel_Signal_Settings   = "------< Indicator Channel Signal Settings >------";
input int dist2=21;
input int dist1=14;
input bool alertsOn=true;
input string note1="alert all = 0";
input string note2="buy only = 1. sell only = 2";
input string note3="strong buy or strong sell =3";
input int alertsOption=0;
input bool alertsOnCurrent=true;
input bool alertsMessage=true;
input bool alertsSound=true;
input bool alertsEmail=false;

extern string  Indicator_Arrow_Settings   = "------< Indicator Arrow Settings >------";
input int SignalGap=3;
input bool EnableSoundAlert=true;
input bool EnableMailAlert=false;

extern string  Indicator_Heiken_Ashi_Settings   = "------< Indicator Heiken Ashi Settings >------";
input color Shadow_of_bear_candlestick=Red;
input color Shadow_of_bull_candlestick=White;
input color Bear_candlestick_body=true;
input color Bull_candlestick_body=false;

datetime Lasttradetime =0;
datetime Lasttradetime1 =0;
double sl, tp,NewLots;
double firstprice;
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



   double Ashi_Open  =iCustom(Symbol(),0,"Heiken Ashi",Shadow_of_bear_candlestick,Shadow_of_bull_candlestick,Bear_candlestick_body,Bull_candlestick_body,2,1);
   double Ashi_Close  =iCustom(Symbol(),0,"Heiken Ashi",Shadow_of_bear_candlestick,Shadow_of_bull_candlestick,Bear_candlestick_body,Bull_candlestick_body,3,1);
   if(countOrder()==0)
     {
      if(Sell()>=0 &&Ashi_Close<Ashi_Open && Sell()<Buy())
        {
         if(Lasttradetime!=Time[Sell()])
           {
            if(stoploss==0)
              {
               sl=0;
              }
            else
              {
               sl= Bid+stoploss*Point;
              }
            if(takeprofit==0)
              {
               tp=0;
              }
            else
              {
               tp= Bid-takeprofit*Point;
              }
            if(Use_Martingale &&Profit()<0&& (LastPrice()-Close[0])>pip_martingle*Point)
               NewLots=NormalizeDouble(GetLastOrderlot()*Multi,2);
            else
               NewLots=Lots;

            OrderSend(Symbol(),OP_SELL,NewLots,Bid,30,sl,tp,"",MagicNumber,0,clrRed);
            Lasttradetime =Time[Sell()];
           }
        }

      if(Buy()>=0 &&Ashi_Close>Ashi_Open && Sell()>Buy())
        {
         if(Lasttradetime1!=Time[Buy()])
           {
            if(stoploss==0)
              {
               sl=0;
              }
            else
              {
               sl= Ask-stoploss*Point;
              }
            if(takeprofit==0)
              {
               tp=0;
              }
            else
              {
               tp= Ask+takeprofit*Point;
              }
            if(Use_Martingale &&Profit()<0&& (LastPrice()-Close[0])>pip_martingle*Point)

               NewLots=NormalizeDouble(GetLastOrderlot()*Multi,2);
            else
               NewLots=Lots;
            OrderSend(Symbol(),OP_BUY,NewLots,Ask,30,sl,tp,"",MagicNumber,0,clrBlue);
            Lasttradetime1 =Time[Buy()];
           }
        }

     }
   if(Use_Close && AppearXsellArrow()>0)
     {
      if(Ashi_Close>Ashi_Open)
        {
         CloseSellOrder();
        }
     }
   if(Use_Close && AppearXbuyArrow()>0)
     {
      if(Ashi_Close<Ashi_Open)
        {
         CloseBuyOrder();
        }
     }

   if(Use_Martingale && losspipprofit()*-1>=pip_martingle)
     {
      CloseOrder();
     }

  }
//+------------------------------------------------------------------+
int Sell()
  {
   for(int i=1; i<Bars; i++)
     {
      double RedSignal  =iCustom(Symbol(),0,"channel-signal",dist2,dist1,alertsOn,note1,note2,note3,alertsOption,alertsOnCurrent,alertsMessage,alertsSound,alertsEmail,2,i);
      double ArrowDown  =iCustom(Symbol(),0,"arrows",SignalGap,EnableSoundAlert,EnableMailAlert,0,i);
      double ArrowUp  =iCustom(Symbol(),0,"arrows",SignalGap,EnableSoundAlert,EnableMailAlert,1,i);

      if(RedSignal>0 && RedSignal!=EMPTY_VALUE &&ArrowDown>0 && ArrowDown!=EMPTY_VALUE && ArrowUp==EMPTY_VALUE)
        {
         return(i);
        }


     }
   return (-1);
  }
//+------------------------------------------------------------------+
int Buy()
  {
   for(int i=1; i<Bars; i++)
     {
      double BlueSignal  =iCustom(Symbol(),0,"channel-signal",dist2,dist1,alertsOn,note1,note2,note3,alertsOption,alertsOnCurrent,alertsMessage,alertsSound,alertsEmail,3,i);
      double ArrowDown  =iCustom(Symbol(),0,"arrows",SignalGap,EnableSoundAlert,EnableMailAlert,0,i);
      double ArrowUp  =iCustom(Symbol(),0,"arrows",SignalGap,EnableSoundAlert,EnableMailAlert,1,i);

      if(BlueSignal>0 && BlueSignal!=EMPTY_VALUE &&ArrowUp>0 && ArrowUp!=EMPTY_VALUE && ArrowDown==EMPTY_VALUE)
        {
         return(i);
        }


     }
   return (-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int AppearXsellArrow()
  {
   for(int i=1; i<Bars; i++)
     {
      double RedSignal  =iCustom(Symbol(),0,"channel-signal",dist2,dist1,alertsOn,note1,note2,note3,alertsOption,alertsOnCurrent,alertsMessage,alertsSound,alertsEmail,2,i);
      double BlueSignal  =iCustom(Symbol(),0,"channel-signal",dist2,dist1,alertsOn,note1,note2,note3,alertsOption,alertsOnCurrent,alertsMessage,alertsSound,alertsEmail,3,i);
      double ArrowDown  =iCustom(Symbol(),0,"arrows",SignalGap,EnableSoundAlert,EnableMailAlert,0,i);
      double ArrowUp  =iCustom(Symbol(),0,"arrows",SignalGap,EnableSoundAlert,EnableMailAlert,1,i);

      if((BlueSignal>0 && BlueSignal!=EMPTY_VALUE) || (ArrowUp>0 && ArrowUp!=EMPTY_VALUE))
        {
         return(i);
        }


     }
   return (-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int AppearXbuyArrow()
  {
   for(int i=1; i<Bars; i++)
     {
      double RedSignal  =iCustom(Symbol(),0,"channel-signal",dist2,dist1,alertsOn,note1,note2,note3,alertsOption,alertsOnCurrent,alertsMessage,alertsSound,alertsEmail,2,i);
      double BlueSignal  =iCustom(Symbol(),0,"channel-signal",dist2,dist1,alertsOn,note1,note2,note3,alertsOption,alertsOnCurrent,alertsMessage,alertsSound,alertsEmail,3,i);
      double ArrowDown  =iCustom(Symbol(),0,"arrows",SignalGap,EnableSoundAlert,EnableMailAlert,0,i);
      double ArrowUp  =iCustom(Symbol(),0,"arrows",SignalGap,EnableSoundAlert,EnableMailAlert,1,i);

      if((RedSignal>0 && RedSignal!=EMPTY_VALUE) || (ArrowDown>0 && ArrowDown!=EMPTY_VALUE))
        {
         return(i);
        }


     }
   return (-1);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Close Open Order s                                                                |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseSellOrder()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {

      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if(OrderType() == OP_SELL)
           {
            OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White);
           }
        }

     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseBuyOrder()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {

      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if(OrderType() == OP_BUY)
           {
            OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White);
           }
        }

     }
  }
//+------------------------------------------------------------------+
double GetLastOrderlot()
  {
   for(int i=0; i<OrdersTotal(); i++)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol()&& OrderMagicNumber()== MagicNumber)
        {

         return(OrderLots());

        }
     }
   return(-1);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Last  Price                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double LastPrice()
  {
   double openprice;
   for(int i=0; i<OrdersTotal(); i++)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         openprice =OrderOpenPrice();
        }
     }
   return (openprice);
  }
//+------------------------------------------------------------------+
double Profit()
  {
   double p = 0;
   for(int i=0; i<OrdersTotal(); i++)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {

         p = OrderProfit()+OrderCommission()+OrderSwap();

        }
     }
   return (p);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
void CloseOrder()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {

      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if(OrderType() == OP_BUY || OrderType() == OP_SELL)
           {
            OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White);
           }
        }

     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int countOrder()
  {
   int count =0;
   for(int i=OrdersTotal(); i>=0; i--)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol()&& OrderMagicNumber()== MagicNumber)
        {
         count++;

        }
     }
   return(count);
  }
//+------------------------------------------------------------------+
double losspipprofit()
  {
   double profits;
   for(int i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true)
        {
         if(OrderSymbol()==Symbol())
            if((OrderProfit()+OrderCommission()+OrderSwap()) < 0)
              {
               profits += OrderProfit()+OrderSwap()+OrderCommission()/GetPPP(OrderSymbol());;
              }
        }
     }

   return(profits);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double GetPPP(string A)
  {
   double B = (((MarketInfo(A,MODE_TICKSIZE)/MarketInfo(A,MODE_BID))* MarketInfo(A,MODE_LOTSIZE)) * MarketInfo(A,MODE_BID))/10; //For 5 Digit

   return(B);
  }
//+------------------------------------------------------------------+
