//+------------------------------------------------------------------+
//|                                           MAchannel Renko EA.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

extern string   General_Settings   = "------< General_Settings >------";
input double Lots =0.1;
input int TakeProfit=0;
input int StopLoss=0;
input int MagicNumber =121221;

extern string   MA1_SetUP   = "------< MA1_SetUP >------";
input ENUM_TIMEFRAMES Time1 = PERIOD_M5;
input int period1 = 8;
input ENUM_MA_METHOD MA_Method1 = MODE_EMA;
input ENUM_APPLIED_PRICE MA_price1 = PRICE_CLOSE;

extern string   MA2_SetUP   = "------< MA2_SetUP >------";
input ENUM_TIMEFRAMES Time2 = PERIOD_M5;
input int period2 = 21;
input ENUM_MA_METHOD MA_Method2 = MODE_EMA;
input ENUM_APPLIED_PRICE MA_price2 = PRICE_CLOSE;

extern string   close_win_loss_SetUP   = "------< close_win_loss_SetUP >------";
input bool     Use_close_win_loss     = true;
input double Profit = 10;
input int Num_Win_Trades     = 1;
input int Num_Lose_Trades     = 3;

datetime Lasttradetime =0;
double sl, tp;

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
   double MA1_1 =iMA(Symbol(),Time1,period1,0,MA_Method1,MA_price1,1);
   double MA2_1 =iMA(Symbol(),Time2,period2,0,MA_Method2,MA_price2,1);
   if(MA1_1<Close[0] && MA2_1<Close[0])
     {
      if(Close[2]>Open[2]&&Close[1]>Open[1])
        {

         if(Lasttradetime!=Time[0])
           {
            CloseOrderBuy();
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

            if(OrderSend(Symbol(),OP_BUY,Lots,Ask,30,sl,tp,"BuyRenko",MagicNumber,0,clrBlue)==false){GetLastError();}
            Lasttradetime =Time[0];
           }
        }
     }
   if(MA1_1>Close[0] && MA2_1>Close[0])
     {
      if(Close[2]<Open[2]&&Close[1]<Open[1])
        {

         if(Lasttradetime!=Time[0])
           {
            CloseOrderSell();
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
            if(OrderSend(Symbol(),OP_SELL,Lots,Bid,30,sl,tp,"SellRenko",MagicNumber,0,clrRed)==false){GetLastError();}
            Lasttradetime =Time[0];
           }
        }
     }
   if(Use_close_win_loss)
     {
      if(NUmwinProfitTotal()==Num_Win_Trades &&NumloseProfitTotal()==Num_Lose_Trades)
        {
         if(winProfitTotal()-loseProfitTotal()>Profit)
           {
            winCloseOrder();
            LoseCloseOrder();
           }
        }
     }
  }
//+------------------------------------------------------------------+
void CloseOrderBuy()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {

      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if(OrderType() == OP_BUY)
           {
           if( OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,clrWhite)==false){GetLastError();}
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

      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if(OrderType() == OP_SELL)
           {
            if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,clrWhite)==false){GetLastError();}
           }

        }

     }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double winProfitTotal()
  {
   int Num=0;
   double p = 0;
   double  num_array[];
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      num_array[i]=OrderProfit()+OrderCommission()+OrderSwap();
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {

         if((OrderProfit()+OrderCommission()+OrderSwap()) > 0 && Num_Win_Trades!=Num)
           {
            ArraySort(num_array, WHOLE_ARRAY, 0, MODE_DESCEND);
            p +=num_array[i];

            Num++;
           }
        }
     }
   return (p);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double loseProfitTotal()
  {
   int Num=0;
   double p = 0;
   double  num_array[];
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      double z= OrderProfit()+OrderCommission()+OrderSwap();
      num_array[i]=z;
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if((OrderProfit()+OrderCommission()+OrderSwap()) < 0 && Num_Lose_Trades!=Num)
           {
            ArraySort(num_array, WHOLE_ARRAY, 0, MODE_DESCEND);
            p +=num_array[i];
            Num++;
           }
        }
     }
   return (p);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double NUmwinProfitTotal()
  {
   int Num=0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}

      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if((OrderProfit()+OrderCommission()+OrderSwap()) > 0 && Num_Win_Trades!=Num)
           {
            Num++;
           }
        }
     }
   return (Num);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double NumloseProfitTotal()
  {
   int Num=0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}

      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if((OrderProfit()+OrderCommission()+OrderSwap()) < 0 && Num_Lose_Trades!=Num)
           {
            Num++;
           }
        }
     }
   return (Num);
  }
//+------------------------------------------------------------------+
void winCloseOrder()
  {
   int Num=0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}

      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if(OrderType() == OP_BUY || OrderType() == OP_SELL)
           {
            if((OrderProfit()+OrderCommission()+OrderSwap()) < 0 && Num_Lose_Trades!=Num)
              {
               if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,Red)==false){GetLastError();}
               Num++;
              }
           }
        }

     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void LoseCloseOrder()
  {
   int Num=0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if(OrderType() == OP_BUY || OrderType() == OP_SELL)
           {
            if((OrderProfit()+OrderCommission()+OrderSwap()) < 0 && Num_Lose_Trades!=Num)
              {
               if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,Red)==false){GetLastError();}
               Num++;
              }
           }
        }

     }
  }
//+------------------------------------------------------------------+
