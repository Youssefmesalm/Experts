//+------------------------------------------------------------------+
//|                                                    Close All.mq4 |
//|                                  Copyright 2020,Dr Yousuf Mesalm |
//|                                       https://www.MedicaCasa.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020,Dr Yousuf Mesalm"
#property link      "https://www.MedicaCasa.com"
#property version   "1.00"
#property strict
int cnt;
color N=clrNONE;
bool zs;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {

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
for(cnt=OrdersTotal()-1; cnt>=0; cnt--)
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol())
              {
               if(OrderType()==OP_BUY)
                 {
                  zs=OrderClose(OrderTicket(),OrderLots(),Bid,3,N);
                 }
               else
                  if(OrderType()==OP_SELL)
                    {
                     zs=OrderClose(OrderTicket(),OrderLots(),Ask,3,N);
                    }
                  else
                    {
                     zs=OrderDelete(OrderTicket(),clrRed);
                    }

              }
   
  }
//+------------------------------------------------------------------+
