//+------------------------------------------------------------------+
//|                                      SMC MaxMin at 1200.mq4      |
//+------------------------------------------------------------------+

input double Lots=0.1;
 input double sl=100;
input double tp =100;
 double InitialStop=10;
 double TrailingStop=30;
 int SetHour=15;
 int cnt,total,ticket,MinDist;
 int SigPos;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int init()
  {
//---- 
//----
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start()
  {
   int Flag;
   double Spread;
   double ATR;
   double StopMA;
   int cnt, tmp;
   double SetupHigh, SetupLow;
   // initial data checks
   // it is important to make sure that the expert works with a normal
   // chart and the user did not make any mistakes setting external 
   // variables (Lots, StopLoss, TakeProfit, 
   // TrailingStop) in our case, we check TakeProfit
   // on a chart of less than 100 bars
   Spread=(Ask-Bid);
     if(Bars<100)
     {
      Print("bars less than 100");
      return(0);
     }
     
   //TrailingStop=iATR(NULL,0,10,0)*2; // BE CAREFUL OF EFFECTING THE AUTO TRAIL STOPS
   StopMA=iMA(NULL,0,24,0,MODE_SMA,PRICE_CLOSE,0);
   if (TimeHour(CurTime())==SetHour+2)
     {
      if (total>0)
        {
         for(cnt=0;cnt<total;cnt++)
           {
            OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
            if(OrderType()==OP_BUYSTOP && OrderSymbol()==Symbol())
              {OrderDelete(OrderTicket() );
              Print("BUYSTOP Deleted" );
              }
            OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
            if(OrderType()==OP_SELLSTOP && OrderSymbol()==Symbol())
              {OrderDelete(OrderTicket() );
               Print("BUYSTOP Deleted" );
              }
             } 
            }
           }
   //ALWAYS TRY TO COME OUT WITH A PROFIT:
   if(0==1)
     {
      total=OrdersTotal();
      if (total>0)
        {
         for(cnt=0;cnt<total;cnt++)
           {
            //LONG
            OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
            if(OrderType()==OP_BUY && OrderSymbol()==Symbol())
              {
               if(OrderStopLoss() < OrderOpenPrice())
                 {
                  if (OrderStopLoss() < Bid -(Point*(MinDist*2)))
                    {
                     OrderModify(OrderTicket(),OrderOpenPrice(),Bid -(Point*(2*MinDist)),OrderTakeProfit(),0,Lime);
                    }
                 }
              }
            // SHORT
            OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
            if(OrderType()==OP_SELL && OrderSymbol()==Symbol())
              {
               if(OrderStopLoss() > OrderOpenPrice())
                 {
                  if (OrderStopLoss() > Ask + (Point*(MinDist*2)))
                    {
                     OrderModify(OrderTicket(),OrderOpenPrice(),Ask+(Point*(MinDist*2)),OrderTakeProfit(),0,Lime);
                    }
                 }
              }
           }
        }
     }
   // If Orders are in force then check for closure against Technicals LONG & SHORT
   //CLOSE LONG Entries
   total=OrdersTotal();
   //if(total>0)
   //  {
   //   for(cnt=0;cnt<total;cnt++)
   //     {
   //      OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
   //      if(OrderType()==OP_BUY && OrderSymbol()==Symbol())
   //         //##   LONG Closure Rules   ###
   //        {
   //         if(0==1)
   //           {
   //            OrderClose(OrderTicket(),OrderLots(),Bid,3,Violet); // close LONG position
   //            return(0);
   //           }
   //        }
   //      //CLOSE SHORT ENTRIES: 
   //      OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
   //      if(OrderType()==OP_SELL && OrderSymbol()==Symbol()) // check for symbol
   //         //##  SHORT Closure Rules  ##
   //        {
   //         if(0==1)               
   //           {
   //            OrderClose(OrderTicket(),OrderLots(),Ask,3,Violet); // close SHORT position
   //            return(0);
   //           }
   //        }
   //     }  // for loop return
   //  }   // close 1st if 
   //TRAILING STOP: LONG
   total=OrdersTotal();
   if(total>0)
     {
      for(cnt=0;cnt<total;cnt++)
        {
         OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
         if(OrderType()==OP_BUY && OrderSymbol()==Symbol())
           {
            if(TrailingStop>0)
              {
               if(Bid-OrderOpenPrice()>Point*TrailingStop)
                 {
                  if(OrderStopLoss()<Bid-Point*TrailingStop)
                    {
                     OrderModify(OrderTicket(),OrderOpenPrice(),Bid-Point*TrailingStop,OrderTakeProfit(),0,White);
                    }
                 }
              }
           }
        }
     }
   //TRAILING STOP: SHORT
   total=OrdersTotal();
   if(total>0)
     {
      for(cnt=0;cnt<total;cnt++)
        {
         OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
         if(OrderType()==OP_SELL && OrderSymbol()==Symbol())
           {
            if((OrderOpenPrice()-Ask)>(Point*TrailingStop))
              {
               if((OrderStopLoss()>(Ask+Point*TrailingStop)) || (OrderStopLoss()==0))
                 {
                  OrderModify(OrderTicket(),OrderOpenPrice(),Ask+Point*TrailingStop,OrderTakeProfit(),0,White);
                 }
              }
           }
        }
     }
   //#########################  NEW POSITIONS ?  ######################################
   //Possibly add in timer to stop multiple entries within Period
   // Check Margin available
   // ONLY ONE ORDER per SYMBOL
   // ADD in code to elimante spikes
   // Loop around orders to check symbol doesn't appear more than once
   // Check for elapsed time from last entry
   tmp= TimeHour(CurTime());
   // Print(" time ",tmp);
   if (0==1) // switch to turn ON/OFF history check
     {
      total=HistoryTotal();
      if(total>0)
        {
         for(cnt=0;cnt<total;cnt++)
           {
            OrderSelect(cnt, SELECT_BY_POS, MODE_HISTORY);
            if(OrderSymbol()==Symbol()
            && CurTime()- OrderCloseTime() < (Period() * 60 )
            )
              {
               return(0);
              }
           }
        }
     }
   total=OrdersTotal();
   if(total>0)
     {
      for(cnt=0;cnt<total;cnt++)
        {
         OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
         if(OrderSymbol()==Symbol()) return(0);
        }
     }
   if(AccountFreeMargin()<(1000*Lots))
     {Print("We have no money. Free Margin = ", AccountFreeMargin());
     return(0);}
   //ENTRY RULES: LONG 
   double MinDist=(MarketInfo(Symbol(),MODE_STOPLEVEL)*Point);
   double HighPrice, LowPrice;
   if(MinDist-(High[1] - Ask) > 0) HighPrice=High[1]+ (MinDist-(High[1] - Ask));
   if(MinDist-(High[1] - Ask) < 0) HighPrice=High[1];
   if(MinDist-(Bid -Low[1]) > 0) LowPrice=Low[1]+ (MinDist-(Bid -Low[1]));
   if(MinDist-(Bid -Low[1]) < 0) LowPrice=Low[1];
   //Print(SetHour," ",LowPrice," ",HighPrice);
   if (TimeHour(CurTime())==SetHour)
     {
      //Place BUY Stop order 
      ticket=OrderSend(Symbol(),OP_BUYSTOP,Lots,HighPrice+(1*Point),3,HighPrice+(1*Point)-(sl*10*Point),HighPrice+(1*Point)+(tp*10*Point),"MaxMin Long",16384,0,Orange);
      if(ticket>0)
        {
         if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) Print("BUYSTOP order opened : ",OrderOpenPrice());
        }
      else // Place  actual Order
        {
         Print("Error opening BUYSTOP order : ",GetLastError());
         ticket=OrderSend(Symbol(),OP_BUY,Lots,Ask,3,Bid-(sl*10*Point),Ask+(tp*10*Point),"MaxMin Long",16384,0,Yellow);
         if(ticket>0)
           {
            if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) Print("BUY order opened : ",OrderOpenPrice());
           }
         else Print("Error opening BUY order : ",GetLastError());
        }
      ticket=OrderSend(Symbol(),OP_SELLSTOP,Lots,LowPrice-(1*Point),3,LowPrice-(1*Point)+(sl*10*Point),LowPrice-(1*Point)-(tp*10*Point),"MaxMin Long",16384,0,Red);
      if(ticket>0)
        {
         if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) Print("SELLSTOP order opened : ",OrderOpenPrice());
        }
      else
        {
         Print("Error opening SELLSTOP order : ",GetLastError());
         ticket=OrderSend(Symbol(),OP_SELL,Lots,Bid,3,Ask+-(sl*10*Point),Bid-(tp*10*Point),"MaxMin Long",16384,0,Pink);
//----
         if(ticket>0)
           {
            if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) Print("BUY order opened : ",OrderOpenPrice());
           }
         else Print("Error opening SELL order : ",GetLastError());
        }
      return(0);
     }
   return(0);
  }
//+------------------------------------------------------------------+