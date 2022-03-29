//+------------------------------------------------------------------+
//|                                                Ashi_Arrow_EA.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

// General EA inputs for user 
extern string        General_Settings                   = "------< General Settings >------";
input double         Lots                               = 0.1;
input int            TakeProfit                         = 0;
input int            StopLoss                           = 0;
input int            MagicNumber                        = 789;
extern string        Close_SetUP                        = "------< Close_SetUP >------";
input bool           Use_Close                          = false;
extern string        Martingale_SetUP                   = "------< Martingale _SetUP >------";
input bool           Use_Martingale                     = false;
input double         Multi                              = 2;
input int            pip_martingle                      = 20;
input double         Close_USD_profit                   = 0.0;
extern string        Indicator_Channel_Signal_Settings  = "------< Indicator Channel Signal Settings >------";
input int            dist2                              = 21;
input int            dist1                              = 14;
input bool           alertsOn                           = true;
input string         note1                              = "alert all = 0";
input string         note2                              = "buy only = 1. sell only = 2";
input string         note3                              = "strong buy or strong sell =3";
input int            alertsOption                       = 0;
input bool           alertsOnCurrent                    = true;
input bool           alertsMessage                      = true;
input bool           alertsSound                        = true;
input bool           alertsEmail                        = false;
extern string        Indicator_Arrow_Settings           = "------< Indicator Arrow Settings >------";
input int            SignalGap                          = 3;
input bool           EnableSoundAlert                   = true;
input bool           EnableMailAlert                    = false;
extern string        Indicator_Heiken_Ashi_Settings     = "------< Indicator Heiken Ashi Settings >------";
input color          Shadow_of_bear_candlestick         =Red;
input color          Shadow_of_bull_candlestick         =White;
input color          Bear_candlestick_body              =true;
input color          Bull_candlestick_body              =false;

// Global variables for EA use 
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
//decleration of the indicators used in the EA 
   double Ashi_Open  =iCustom(Symbol(),0,"Heiken Ashi",Shadow_of_bear_candlestick,Shadow_of_bull_candlestick,Bear_candlestick_body,Bull_candlestick_body,2,1);
   double Ashi_Close  =iCustom(Symbol(),0,"Heiken Ashi",Shadow_of_bear_candlestick,Shadow_of_bull_candlestick,Bear_candlestick_body,Bull_candlestick_body,3,1);
  
   if(countOrder()==0)
     {
      if(Sell()>=0 &&Ashi_Close<Ashi_Open && Sell()<Buy())
        {
         if(Lasttradetime!=Time[Sell()])
           {
            if(StopLoss==0)
              {
               sl=0;
              }
            else
              {
               sl= Bid+StopLoss*Point;
              }
            if(TakeProfit==0)
              {
               tp=0;
              }
            else
              {
               tp= Bid-TakeProfit*Point;
              }

            if(OrderSend(Symbol(),OP_SELL,Lots,Bid,30,sl,tp,"",MagicNumber,0,clrRed)==false){GetLastError();}
            Lasttradetime =Time[Sell()];
           }
        }

      if(Buy()>=0 &&Ashi_Close>Ashi_Open && Sell()>Buy())
        {
         if(Lasttradetime1!=Time[Buy()])
           {
            if(StopLoss==0)
              {
               sl=0;
              }
            else
              {
               sl= Ask-StopLoss*Point;
              }
            if(TakeProfit==0)
              {
               tp=0;
              }
            else
              {
               tp= Ask+TakeProfit*Point;
              }
            if(OrderSend(Symbol(),OP_BUY,Lots,Ask,30,sl,tp,"",MagicNumber,0,clrBlue)==false){GetLastError();}
            Lasttradetime1 =Time[Buy()];
           }
        }

     }
     //Close sell
   if(Use_Close && AppearXsellArrow()>0)
     {
      if(Ashi_Close>Ashi_Open)
        {
         CloseSellOrder();
        }
     }
     //Close buy
   if(Use_Close && AppearXbuyArrow()>0)
     {
      if(Ashi_Close<Ashi_Open)
        {
         CloseBuyOrder();
        }
     }
     //Martingale
   if(Use_Martingale)
     {
      if(Close[0]<=LastBuyPrice()-pip_martingle*Point)
        {
         if(OrderSend(Symbol(),OP_BUY,NormalizeDouble(GetLastOrderlot(OP_BUY)*Multi,2),Ask,30,0,0,"Buy",MagicNumber,0,clrBlue)==false)
           {
            GetLastError();
           }
        }
      if(Close[0]>=LastSellPrice()+pip_martingle*Point)
        {
         if(OrderSend(Symbol(),OP_SELL,NormalizeDouble(GetLastOrderlot(OP_SELL)*Multi,2),Bid,30,0,0,"Sell",MagicNumber,0,clrRed)==false)
           {
            GetLastError();
           }
        }
     }
   if(Use_Martingale)
     {
      if(Close_USD_profit < Winprofit())
        {
         CloseOrder();
        }
     }


  }
//+------------------------------------------------------------------+
//|        Appear Sell Arrow                                                               |
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
//|        Appear Buy Arrow                                                               |
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
//|        Appear Sell Arrow  for close                                                             |
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
//|          Appear buy Arrow   for close                                                     |
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
//|         Close Sell Order                                                         |
//+------------------------------------------------------------------+
void CloseSellOrder()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {

      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if(OrderType() == OP_SELL)
           {
            if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==false){GetLastError();}
           }
        }

     }
  }
//+------------------------------------------------------------------+
//|       Close Buy Order                                                           |
//+------------------------------------------------------------------+
void CloseBuyOrder()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {

      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if(OrderType() == OP_BUY)
           {
            if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==false){GetLastError();}
           }
        }

     }
  }
//+------------------------------------------------------------------+
 // Get Last Order lot   |
//+------------------------------------------------------------------+
double GetLastOrderlot()
  {
   for(int i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if(OrderSymbol()==Symbol()&& OrderMagicNumber()== MagicNumber)
        {

         return(OrderLots());

        }
     }
   return(-1);
  }
//+------------------------------------------------------------------+
 //  close order    |
//+------------------------------------------------------------------+
void CloseOrder()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {

     if( OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if(OrderType() == OP_BUY || OrderType() == OP_SELL)
           {
            if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==false){GetLastError();}
           }
        }

     }
  }

//+------------------------------------------------------------------+
//|     Count Order                                                             |
//+------------------------------------------------------------------+
int countOrder()
  {
   int count =0;
   for(int i=OrdersTotal(); i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if(OrderSymbol()==Symbol()&& OrderMagicNumber()== MagicNumber)
        {
         count++;

        }
     }
   return(count);
  }

//+------------------------------------------------------------------+
//|   profit function                                                               |
//+------------------------------------------------------------------+
double Winprofit()
  {
   double profits;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
        {
         if(OrderSymbol()==Symbol() && OrderMagicNumber()== MagicNumber)

               profits += OrderProfit()+OrderSwap()+OrderCommission();
        }
     }

   return(profits);
  }
//+------------------------------------------------------------------+
//|     Last Order  type                                                           |
//+------------------------------------------------------------------+
int GetLastOrder()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if(OrderSymbol()==Symbol()&& OrderMagicNumber()== MagicNumber)
        {

         return(OrderType());

        }
     }
   return(-1);
  }
//+------------------------------------------------------------------+
//|     Last Order  Lot                                                           |
//+------------------------------------------------------------------+
double GetLastOrderlot(string cmnt)
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if(OrderSymbol()==Symbol()&& OrderMagicNumber()== MagicNumber)
        {
         if(OrderType()==cmnt)
           {

            return(OrderLots());
           }

        }
     }
   return(-1);
  }

//+------------------------------------------------------------------+
//|     Last Buy  Order                                                           |
//+------------------------------------------------------------------+
double LastBuyPrice()
  {
   double openpriceBuy;
   for(int i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}

      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber  && OrderType() ==OP_BUY)
        {
         openpriceBuy =OrderOpenPrice();
        }
     }
   return (openpriceBuy);
  }
//+------------------------------------------------------------------+
//|      Last Sell  Order                                                             |
//+------------------------------------------------------------------+
double LastSellPrice()
  {
   double openpricesell;
   for(int i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}

      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber  && OrderType() ==OP_SELL)
        {
         openpricesell =OrderOpenPrice();
        }
     }
   return (openpricesell);
  }

//+------------------------------------------------------------------+
