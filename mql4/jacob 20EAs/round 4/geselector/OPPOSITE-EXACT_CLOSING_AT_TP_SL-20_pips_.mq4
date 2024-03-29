//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2018, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property version     "1.00"

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
input  int       TP1  = 100; //TP (In Points)
input  int       SL1  = 100; //SL (In Points)
extern double    LOT  = 0.1; //Lots

extern int Period_PCh = 20; // ïåðèîä Price Channel
int TP = 20; // Âåëè÷èíà TakeProfit â ïèïñàõ
extern int Ìíîæèòåëü = 20; // Âî ñêîëüêî ðàç íåîáõîäèìî óìíîæèòü âåëè÷èíó ëîòà ïîñëå óáûòî÷íîé ñäåëêè
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start()
  {
   double Price_Channel_UP,Price_Channel_DOUN;
   double MA_Fast,MA_Low;
   int cnt, ticket, total;
   double Lots = 0.01;

// ïðèñâîåíèå ïåðåìåííûì çíà÷åíèé

   Price_Channel_UP=iCustom(NULL,0,"Price Channel",Period_PCh,0,2);
   Price_Channel_DOUN=iCustom(NULL,0,"Price Channel",Period_PCh,1,2);
   MA_Fast=iMA(NULL, 0, 1, 0, MODE_SMA, PRICE_TYPICAL, 1);  // áûñòðàÿ ÌÀ
   MA_Low=iMA(NULL, 0, 20, 0, MODE_SMA, PRICE_CLOSE, 1);  // ìåäëåííàÿ ÌÀ

   total=OrdersTotal();
   if(total<1) // åñëè íåò ïîçèöèé
     {
      OrderSelect(OrdersHistoryTotal()-1, SELECT_BY_POS, MODE_HISTORY);
      // îòêðûòèå äëèííîé ïîçèöèè ïî ìàðòèíãåéëó
      if(MA_Fast>MA_Low && Open[0]<Open[1] && OrderProfit()<0)
        {
         OrderSend(Symbol(),OP_SELL,LOT, Bid, 3, Bid+SL1*Point, Bid-TP1*Point,"ïðîäàæà ìàðòèíãåéë",16384,0,Red);
        }

      // îòêðûòèå êîðîòêîé ïîçèöèè ïî ìàðòèíãåéëó
      if(MA_Fast<MA_Low && Open[0]>Open[1] && OrderProfit()<0)
        {
         OrderSend(Symbol(),OP_BUY,LOT,Ask, 3, Ask-SL1*Point, Ask+TP1*Point,"ïîêóïêà ìàðòèíãåéë",16384,0,Green);

        }
      // îòêðûòèå äëèííîé ïîçèöèè
      if(MA_Fast>MA_Low && Open[0]<Open[1] && OrderProfit()>=0)
        {
         OrderSend(Symbol(),OP_SELL,LOT, Bid, 3, Bid+SL1*Point, Bid-TP1*Point,"ïðîäàæà",16384,0,Red);

        }

      // îòêðûòèå êîðîòêîé ïîçèöèè
      if(MA_Fast<MA_Low && Open[0]>Open[1] && OrderProfit()>=0)
        {
         OrderSend(Symbol(),OP_BUY,LOT,Ask, 3, Ask-SL1*Point, Ask+TP1*Point,"ïîêóïêà",16384,0,Green);

        }
     }

   total=OrdersTotal();
   for(cnt=0; cnt<total; cnt++)
     {
      //1
      OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
      if(OrderType()<=OP_SELL &&
         OrderSymbol()==Symbol())
        {
         if(OrderType()==OP_BUY)
           {
            if(Low[1]<Price_Channel_DOUN)
              {
               if(Open[0]<Low[1])
                 {
                  //OrderClose(OrderTicket(),OrderLots(),Open[0],5,Red);
                  return(0);
                 }
               OrderModify(OrderTicket(),OrderOpenPrice(),Low[1]-10*Point,0,0,Red);
               return(0);
              }

           }
         if(OrderType()==OP_SELL)
           {
            if(High[1]>Price_Channel_UP)
              {
               if(Open[0]>High[1])
                 {
                  //OrderClose(OrderTicket(),OrderLots(),Open[0],5,Red);
                  return(0);
                 }
               OrderModify(OrderTicket(),OrderOpenPrice(),High[1]+10*Point,0,0,Red);
               return(0);
              }
           }
        }

     }

   return(0);
  }
//+------------------------------------------------------------------+
