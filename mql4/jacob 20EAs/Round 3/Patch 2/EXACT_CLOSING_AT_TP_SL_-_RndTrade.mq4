//+------------------------------------------------------------------+
//|                                                     RndTrade.mq4 |
//|                                            Copyright © 2008 Grib |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2008 Grib"
#property link      ""

#define NUM_BUY  20050611
#define NUM_SELL  20050612
int ticket;
input double sl=100;
input double tp=100;
//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----
   
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
if(OrdersTotal() == 0)
{
   checkForOpen();
}
//else
//{
//   checkForClose();
//}

//----
   return(0);
  }
  
//+------------------------------------------------------------------+
//| Ïðîâåðêà íà îòêðûòèå ïîçèöèè                                    |
//+------------------------------------------------------------------+
void checkForOpen()
{
int a = 0;
MathSrand(TimeLocal());
  // Îòîáðàæàåò 10 ÷èñåë.
  for(int i=0;i<10;i++ )
    if(i==5)
    {
      a = MathRand();
      if(a > 16383.5)
      {
      // Ñîâåðøàåì ïîêóïêó
        ticket = OrderSend(Symbol(),OP_BUY,1,Ask,3,Ask-sl*10*Point,Ask+tp*10*Point,"TestDrawSell",NUM_BUY);
        if (ticket == -1) Alert("Îøèáêà ïðè ñîâåðøåíèè îïåðàöèè ïîêóïêè");
      }
      else
      {
      //Ñîâåðøàåì ïðîäàæó
        ticket = OrderSend(Symbol(),OP_SELL,1,Bid,3,Bid+sl*10*Point,Bid-tp*10*Point,"TestDrawBuy",NUM_SELL);
        if (ticket == -1) Alert("Îøèáêà ïðè ñîâåðøåíèè îïåðàöèè ïðîäàæè");
      }
    }
    else
    {
      a = MathRand();
    } 
}
//+------------------------------------------------------------------+
//| Ïðîâåðêà íà çàêðûòèå ïîçèöèè                                     |
//+------------------------------------------------------------------+
void checkForClose()
{
  if(OrderSelect(0, SELECT_BY_POS)==true)
  {
    if( (OrderOpenTime()+14400) < TimeLocal() )
       if(OrderClose(OrderTicket(),1,Ask,3) == false)
          Print("Îøèáêà ïðè çàêðûòèè ïîçèöèè");
  }
  else
  {
    Print("OrderSelect() âåðíóë îøèáêó - ",GetLastError());
  }
}
//+------------------------------------------------------------------+