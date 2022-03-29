//+------------------------------------------------------------------+
//|                                                profit locker.mq4 |
//|                                     Copyright 2021,Yousuf Mesalm |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021,Yousuf Mesalm"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

//variables inputs
input double Pips=3; //Pips Profit Lock

//arrays
long Tickets[];
bool Profit[];
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
// for Testing
//   if(OrdersTotal()==0)
//     {
//      OrderSend(Symbol(),OP_BUY,0.1,Ask,30,0,0,"Buy",0,0,clrBlue);
//     }
//   if(OrdersTotal()==1)
//     {
//      OrderSend(Symbol(),OP_SELL,0.1,Bid,30,0,0,"Buy",0,0,clrBlue);
//     }
////if(OrdersTotal()==1){OrderSend("GBPUSD",OP_BUY,0.1,MarketInfo("GBPUSD",MODE_ASK),30,0,0,"Buy",0,0,clrBlue);}

   int tickets_Size=ArraySize(Tickets);
   if(tickets_Size==0&&OrdersTotal()>0)
     {
      ArrayResize(Tickets,OrdersTotal());
      ArrayResize(Profit,OrdersTotal());
      ArrayInitialize(Profit,false);
      int size=OrdersTotal();
      for(int i=0; i < size; i++)
         if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
           {
            Tickets[i]=OrderTicket();
            Profit[i]=false;
           }
     }



   int size=OrdersTotal();
   for(int i=0; i < size; i++)
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
         bool Exist=false;
         int closedTicketIndex=-1;
         tickets_Size=ArraySize(Tickets);
         Print(tickets_Size);
         for(int x=0; x<tickets_Size; x++)
           {
            if(OrderTicket()==Tickets[x])
              {
               Exist=true;

               if(Profit[x]==false)
                 {
                  double intendClose;
                  if(OrderType()==OP_BUY)
                    {
                     intendClose=OrderOpenPrice()+(Pips+1)*MarketInfo(OrderSymbol(),MODE_POINT)*10;
                     if(MarketInfo(OrderSymbol(),MODE_BID)>=intendClose)
                       {
                        Profit[x]=true;
                       }
                    }
                  else
                     if(OrderType()==OP_SELL)
                       {
                        intendClose=OrderOpenPrice()-(Pips+1)*MarketInfo(OrderSymbol(),MODE_POINT)*10;
                        if(MarketInfo(OrderSymbol(),MODE_ASK)<=intendClose)
                          {
                           Profit[x]=true;
                          }
                       }


                 }
               else
                  if(Profit[x]==true)
                    {

                     double intendClose;
                     if(OrderType()==OP_BUY)
                       {
                        intendClose=OrderOpenPrice()+Pips*MarketInfo(OrderSymbol(),MODE_POINT)*10;
                        if(MarketInfo(OrderSymbol(),MODE_BID)<=intendClose)
                          {
                           if(!OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,clrRed))
                             {
                              GetLastError();
                             }
                           closedTicketIndex=x;
                          }
                       }
                     else
                        if(OrderType()==OP_SELL)
                          {
                           intendClose=OrderOpenPrice()-Pips*MarketInfo(OrderSymbol(),MODE_POINT)*10;
                           if(MarketInfo(OrderSymbol(),MODE_ASK)>=intendClose)
                             {
                              if(!OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,clrRed))
                                {
                                 GetLastError();
                                }
                              closedTicketIndex=x;
                             }
                          }

                    }
              }
           }
         if(closedTicketIndex>0)
           {
            RemoveElementfromlongArray(closedTicketIndex,Tickets);
            RemoveElementfromboolenArray(closedTicketIndex,Profit);
           }
         if(!Exist)
           {
            tickets_Size=ArraySize(Tickets);
            ArrayResize(Tickets,tickets_Size+1);
            ArrayResize(Profit,tickets_Size+1);
            Tickets[tickets_Size]=OrderTicket();
            Profit[tickets_Size]=false;
           }


        }




  }

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void RemoveElementfromlongArray(int idx, long &Array[])
  {
   long temp[];
   int num = 0;
   ArrayCopy(temp, Array, 0, 0, WHOLE_ARRAY);
   ArrayFree(Array);
   for(int i = 0; i < ArraySize(temp); i++)
     {
      if(i != idx)
        {
         num++;
         ArrayResize(Array, num);
         Array[num - 1] = temp[i];
        }
     }
  }

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void RemoveElementfromboolenArray(int idx, bool &Array[])
  {

   bool temp[];
   int num = 0;
   ArrayCopy(temp, Array, 0, 0, WHOLE_ARRAY);
   ArrayFree(Array);
   for(int i = 0; i < ArraySize(temp); i++)
     {
      if(i != idx)
        {
         num++;
         ArrayResize(Array, num);
         Array[num - 1] = temp[i];
        }
     }
  }
//+------------------------------------------------------------------+
