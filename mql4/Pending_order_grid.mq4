//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2018, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+

extern double     StartingLot = 0.01;
extern double     IncreasePercentage = 0.001;
extern double     DistanceFromPrice = 0.0010;
extern int        SpaceBetweenTrades = 150;
extern int        NumberOfTrades = 200;
extern int        Takeprofit = 200;
extern int        StopLoss = 9999;
extern int        TrailingStop = 150;
extern bool        TradeLong = true;
extern bool        TradeShort = true;
extern int         Magic = 1;

//---------
int     POS_n_BUY;
int     POS_n_SELL;
int     POS_n_BUYSTOP;
int     POS_n_SELLSTOP;
int     POS_n_total;
int limit_order;
bool first=true;

//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----
   limit_order=AccountInfoInteger(ACCOUNT_LIMIT_ORDERS);
   if(NumberOfTrades>=limit_order)
     {
      Alert("Please Decrease the total Number of Trades,because the market Limit order is " +limit_order);
     }
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//----

//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {
//----

   string DisplayText = "\n" +  "______ AntiFragile EA ______\n" +
                        "Coded By: MT-Coder\n" +
                        "** MT-CoderØhotmail.com **\n" ;

   Comment(DisplayText);

   int i ;
   double TradedLot;
   double TradedBLevel;
   double TradedSLevel;
   int ticketB;
   int ticketS;
   int total;
   int cnt;

//-------
   count_position();
//-------
//-------
// place orders
//-------
   if(first)
     {
      if(OrdersTotal()<=NumberOfTrades)
        {

         for(i=1; i<=NumberOfTrades; i++)
           {
            RefreshRates();

            TradedLot = NormalizeDouble(StartingLot*(1+((i-1)*(IncreasePercentage/100))),2);
            TradedBLevel = NormalizeDouble((Bid + DistanceFromPrice) + ((SpaceBetweenTrades * i)*Point),Digits);
            TradedSLevel = NormalizeDouble((Ask - DistanceFromPrice) -((SpaceBetweenTrades * i)*Point),Digits);

            if(TradeLong)
              {
               ticketB=OrderSend(Symbol(),OP_BUYSTOP,TradedLot,TradedBLevel,1,TradedBLevel-StopLoss*Point,TradedBLevel+Takeprofit*Point,"AF EA",Magic,0,Green);
               if(ticketB>0)
                 {
                  if(OrderSelect(ticketB,SELECT_BY_TICKET,MODE_TRADES))
                     Print("BUYSTOP order sent : ",OrderOpenPrice());
                 }
               else
                 {
                  Print("Error sending BUYSTOP order : ",GetLastError());
                 }

              }

            //---------------
            if(TradeShort)
              {

               ticketS=OrderSend(Symbol(),OP_SELLSTOP,TradedLot,TradedSLevel,1,TradedSLevel+StopLoss*Point,TradedSLevel-Takeprofit*Point,"AF EA",Magic,0,Red);
               if(ticketS>0)
                 {
                  if(OrderSelect(ticketS,SELECT_BY_TICKET,MODE_TRADES))
                     Print("SELLSTOP order sent : ",OrderOpenPrice());
                 }
               else
                 {
                  Print("Error sending SELLSTOP order : ",GetLastError());
                 }


              }

           }
        }
        TradedLot = NormalizeDouble(StartingLot*(IncreasePercentage/100),2);
      TradedBLevel = NormalizeDouble((Bid + DistanceFromPrice) + ((SpaceBetweenTrades)*Point),Digits);
      ticketB=OrderSend(Symbol(),OP_BUYSTOP,TradedLot,TradedBLevel,1,TradedBLevel-StopLoss*Point,TradedBLevel+Takeprofit*Point,"AF EA",Magic,0,Green);
     Print(TradedBLevel,TradedSLevel,TradedLot);
      if(ticketB>0)
        {
         if(OrderSelect(ticketB,SELECT_BY_TICKET,MODE_TRADES))
            Print("BUYSTOP order sent : ",OrderOpenPrice());
        }
      else
        {
         Print("Error sending BUYSTOP order : ",GetLastError());
        }
      TradedSLevel = NormalizeDouble((Ask - DistanceFromPrice) -((SpaceBetweenTrades)*Point),Digits);
      ticketS=OrderSend(Symbol(),OP_SELLSTOP,TradedLot,TradedSLevel,1,TradedSLevel+StopLoss*Point,TradedSLevel-Takeprofit*Point,"AF EA",Magic,0,Red);
      if(ticketS>0)
        {
         if(OrderSelect(ticketS,SELECT_BY_TICKET,MODE_TRADES))
            Print("SELLSTOP order sent : ",OrderOpenPrice());
        }
      else
        {
         Print("Error sending SELLSTOP order : ",GetLastError());
        }
      first=false;
     }
   if(TradeLong)
     {
      double lastBSOpen=LastOrderInfo("OpenPrice",OP_BUYSTOP);
      double distancefromLastOpen=lastBSOpen-Bid;
      if(distancefromLastOpen>=NormalizeDouble((SpaceBetweenTrades*2)*Point,Digits))
        {
         TradedBLevel = NormalizeDouble((Bid + DistanceFromPrice) + ((SpaceBetweenTrades)*Point),Digits);
         ticketB=OrderSend(Symbol(),OP_BUYSTOP,TradedLot,TradedBLevel,1,TradedBLevel-StopLoss*Point,TradedBLevel+Takeprofit*Point,"AF EA",Magic,0,Green);
         if(ticketB>0)
           {
            if(OrderSelect(ticketB,SELECT_BY_TICKET,MODE_TRADES))
               Print("BUYSTOP order sent : ",OrderOpenPrice());
           }
         else
           {
            Print("Error sending BUYSTOP order : ",GetLastError());
           }
        }
     }

   if(TradeShort)
     {
      double lastSSOpen=LastOrderInfo("OpenPrice",OP_SELLSTOP);
      double distancefromLastSell=Ask-lastSSOpen;
      if(distancefromLastSell>=NormalizeDouble((SpaceBetweenTrades*2)*Point,Digits))
        {
         TradedSLevel = NormalizeDouble((Ask - DistanceFromPrice) -((SpaceBetweenTrades)*Point),Digits);
         ticketS=OrderSend(Symbol(),OP_SELLSTOP,TradedLot,TradedSLevel,1,TradedSLevel+StopLoss*Point,TradedSLevel-Takeprofit*Point,"AF EA",Magic,0,Red);
         if(ticketS>0)
           {
            if(OrderSelect(ticketS,SELECT_BY_TICKET,MODE_TRADES))
               Print("SELLSTOP order sent : ",OrderOpenPrice());
           }
         else
           {
            Print("Error sending SELLSTOP order : ",GetLastError());
           }
        }
     }

//trailing stop

   total=OrdersTotal();
   for(cnt=0; cnt<total; cnt++)
     {
      OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
      if(OrderType()<=OP_SELL &&   // check for opened position
         OrderSymbol()==Symbol())  // check for symbol
        {
         if(OrderType()==OP_BUY)   // long position is opened
           {
            // check for trailing stop
            if(TrailingStop>0)
              {
               if(Bid-OrderOpenPrice()>Point*TrailingStop)
                 {
                  if(OrderStopLoss()<Bid-Point*TrailingStop)
                    {
                     OrderModify(OrderTicket(),OrderOpenPrice(),Bid-Point*TrailingStop,OrderTakeProfit(),0,Green);
                     return(0);
                    }
                 }
              }
           }
         else // go to short position
           {
            // check for trailing stop
            if(TrailingStop>0)
              {
               if((OrderOpenPrice()-Ask)>(Point*TrailingStop))
                 {
                  if((OrderStopLoss()>(Ask+Point*TrailingStop)) || (OrderStopLoss()==0))
                    {
                     OrderModify(OrderTicket(),OrderOpenPrice(),Ask+Point*TrailingStop,OrderTakeProfit(),0,Red);
                     return(0);
                    }
                 }
              }
           }
        }
     }


   return(0);
  }

//-----
void count_position()
  {
   POS_n_BUY  = 0;
   POS_n_SELL = 0;

   POS_n_BUYSTOP = 0;
   POS_n_SELLSTOP = 0;

   for(int i = 0 ; i < OrdersTotal() ; i++)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES) == true || OrderMagicNumber() != Magic)
        {
         break;
        }
      if(OrderType() == OP_BUY  && OrderSymbol() == Symbol() && OrderMagicNumber()==Magic)
        {
         POS_n_BUY++;
        }
      else
         if(OrderType() == OP_SELL  && OrderSymbol() == Symbol() && OrderMagicNumber()==Magic)
           {
            POS_n_SELL++;
           }
         else
            if(OrderType() == OP_BUYSTOP  && OrderSymbol() == Symbol() && OrderMagicNumber()==Magic)
              {
               POS_n_BUYSTOP++;
              }
            else
               if(OrderType() == OP_SELLSTOP  && OrderSymbol() == Symbol() && OrderMagicNumber()==Magic)
                 {
                  POS_n_SELLSTOP++;
                 }

     }
   POS_n_total = POS_n_BUY + POS_n_SELL + POS_n_BUYSTOP + POS_n_SELLSTOP;
  }
//-------

// get last order information
double LastOrderInfo(string S,int type)
  {
   for(int cnt=OrdersTotal()-1; cnt>=0; cnt--)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber()==Magic)
               if(OrderType()==type)
                 {
                  if(S=="type")
                     return(OrderType());
                  else
                     if(S=="Ticket")
                        return(OrderTicket());
                     else
                        if(S=="Time")
                           return(OrderOpenTime());
                        else
                           if(S=="Profit")
                              return(OrderProfit());
                           else
                              if(S=="OpenPrice")
                                 return(OrderOpenPrice());
                              else
                                 if(S=="SL")
                                    return(OrderStopLoss());

                 }


     }
   return(0);


  }
//+------------------------------------------------------------------+
