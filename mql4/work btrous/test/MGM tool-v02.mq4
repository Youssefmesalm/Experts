//+------------------------------------------------------------------+
//|                                                     MGM tool.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

extern string   General_Settings   = "------< General_Settings >------";
input double Lots =0.1;
input int MagicNumber =77789;
input int point=300;
input int Max_num_buy = 2;
input int Max_num_sell = 2;

extern string   Multiple_SetUP   = "------< Multiple_SetUP >------";
input bool UseMultiple= true;
input int Multi = 2;

extern string   Profit_SetUP   = "------< Profit_SetUP >------";
input bool     Use_Close_Profit     = false;
input double Close_USD_profit     = 0.0;

int z=0;

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
   if(OrdersTotal()==0)
     {
      OrderSend(Symbol(),OP_SELL,0.1,Bid,30,0,0,"Sell",MagicNumber,0,clrRed);
     }
   if(z!=1)
     {


      if((Close[0]>(LastSellPrice()+ (point *Point))) && LastSellPrice()>0)
        {

         if(GetLastOrderlotSell()>0 && UseMultiple)
           {
            if(OrderSend(Symbol(),OP_SELL,NormalizeDouble(GetLastOrderlotSell()*Multi,2),Bid,30,0,0,"Sell",MagicNumber,0,clrRed)==false)
              {
               GetLastError();
              }
           }
         else
           {
            if(OrderSend(Symbol(),OP_SELL,Lots,Bid,30,0,0,"Sell",MagicNumber,0,clrRed)==false)
              {
               GetLastError();
              }
           }

        }
      if((Close[0]<(LastBuyPrice() - (point*Point))) && LastBuyPrice()>0)
        {

         if(GetLastOrderlotBuy()>0 && UseMultiple)
           {
            if(OrderSend(Symbol(),OP_BUY,NormalizeDouble(GetLastOrderlotBuy()*Multi,2),Ask,30,0,0,"Buy",MagicNumber,0,clrBlue)==false)
              {
               GetLastError();
              }
           }
         else
           {
            if(OrderSend(Symbol(),OP_BUY,Lots,Ask,30,0,0,"Buy",MagicNumber,0,clrBlue)==false)
              {
               GetLastError();
              }

           }
        }
     }
   if(Use_Close_Profit)
     {

      if(Close_USD_profit <= ProfitTotal())
        {
         AllCloseOrder();
         z++;
        }

     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseSellOrder()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {

      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         GetLastError();
        }
      if(OrderSymbol()==Symbol())
        {
         if(OrderType() == OP_SELL)
           {
            if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==false)
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
void CloseBuyOrder()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {

      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         GetLastError();
        }
      if(OrderSymbol()==Symbol())
        {
         if(OrderType() == OP_BUY)
           {
            if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==false)
              {
               GetLastError();
              }
           }
        }

     }
  }
//+------------------------------------------------------------------+
//| Last Sell Price                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double LastSellPrice()
  {
   double openpricesell =0;
   for(int i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         GetLastError();
        }

      if(OrderSymbol()==Symbol() && (OrderMagicNumber()==MagicNumber || OrderMagicNumber()==0)  && OrderType() ==OP_SELL)
        {
         openpricesell =OrderOpenPrice();
        }
     }
   return (openpricesell);
  }



//+------------------------------------------------------------------+
//| Last Buy Price                                                                   |
//+------------------------------------------------------------------+
double LastBuyPrice()
  {
   double openpriceBuy=0;
   for(int i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         GetLastError();
        }

      if(OrderSymbol()==Symbol() && (OrderMagicNumber()==MagicNumber || OrderMagicNumber()==0) && OrderType() ==OP_BUY)
        {
         openpriceBuy =OrderOpenPrice();
        }
     }
   return (openpriceBuy);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double GetLastOrderlotBuy()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         GetLastError();
        }
      if(OrderSymbol()==Symbol())
        {
         if(OrderType() ==OP_BUY)
           {

            return(OrderLots());
           }

        }
     }
   return(-1);
  }
//+------------------------------------------------------------------+
//| Total Profit                                                                |
//+------------------------------------------------------------------+
double ProfitTotal()
  {
   double p = 0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         GetLastError();
        }

      if(OrderSymbol()==Symbol())
        {
         p += OrderProfit()+OrderCommission()+OrderSwap();
        }
     }
   return (p);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double GetLastOrderlotSell()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         GetLastError();
        }
      if(OrderSymbol()==Symbol())
        {
         if(OrderType() ==OP_SELL)
           {

            return(OrderLots());
           }

        }
     }
   return(-1);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Close Open Order s                                                                |
//+------------------------------------------------------------------+


//|                                                                  |
//+------------------------------------------------------------------+
void AllCloseOrder()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {

      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         GetLastError();
        }
      if(OrderSymbol()==Symbol() && (OrderMagicNumber()==MagicNumber || OrderMagicNumber()==0))
        {
         if(OrderType() == OP_BUY || OrderType() == OP_SELL)
           {
            if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==false)
              {
               GetLastError();
              }
           }
        }

     }
  }
//+------------------------------------------------------------------+
