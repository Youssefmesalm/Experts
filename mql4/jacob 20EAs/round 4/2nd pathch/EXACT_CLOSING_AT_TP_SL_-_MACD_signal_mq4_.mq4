//+------------------------------------------------------------------+
//|                                                  MACD_signal.mq4 |
//|                                                           tom112 |
//|                                            tom112@mail.wplus.net |
//+------------------------------------------------------------------+
#property copyright "tom112"
#property link "tom112@mail.wplus.net"
//---- input parameters
extern double TakeProfit = 10;
input double StopLoss=10;
extern double Lots = 10;
extern double TrailingStop = 25;
extern int Pfast = 9;
extern int Pslow = 15;
extern int Psignal = 8;
extern double LEVEL = 0.004;
double Points;
//+------------------------------------------------------------------+
//| expert initialization function |
//+------------------------------------------------------------------+
int init()
  {
   Points = MarketInfo(Symbol(), MODE_POINT);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function |
//+------------------------------------------------------------------+
int deinit()
  {
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function |
//+------------------------------------------------------------------+
int start()
  {
   double MacdCurrent = 0, MacdPrevious = 0, SignalCurrent = 0;
   double SignalPrevious = 0, MaCurrent = 0, MaPrevious = 0;
   int cnt = 0, total;
   int i1, pp, shift;
   double Tv[2][500] ;
   double Range, rr, Delta, Delta1, val3;
// ïåðâè÷íûå ïðîâåðêè äàííûõ
// âàæíî óäîñòîâåðèòüñÿ ÷òî ýêñïåðò ðàáîòàåò íà íîðìàëüíîì ãðàôèêå è
// ïîëüçîâàòåëü ïðàâèëüíî âûñòàâèë âíåøíèå ïåðåìåííûå (Lots, StopLoss,
// TakeProfit, TrailingStop)
// â íàøåì ñëó÷àå ïðîâåðÿåì òîëüêî TakeProfit
   if(Bars < 100)
     {
       Print("bars less than 100");
       return(0); // íà ãðàôèêå ìåíåå 100 áàðîâ
     }
   if(TakeProfit < 10)
     {
       Print("TakeProfit less than 10");
       return(0); // ïðîâåðÿåì TakeProfit
     }
   Range = iATR(NULL, 0, 200, 1);
   rr = Range*LEVEL;
   Delta = iMACD(NULL, 0, Pfast, Pslow, Psignal, PRICE_CLOSE, MODE_MAIN, 0)-
           iMACD(NULL, 0, Pfast, Pslow, Psignal, PRICE_CLOSE, MODE_SIGNAL, 0);
   Delta1 = iMACD(NULL, 0, Pfast, Pslow, Psignal, PRICE_CLOSE, MODE_MAIN, 1)-
            iMACD(NULL, 0, Pfast, Pslow, Psignal, PRICE_CLOSE, MODE_SIGNAL, 1);
// òåïåðü íàäî îïðåäåëèòüñÿ - â êàêîì ñîñòîÿíèè òîðãîâûé òåðìèíàë?
// ïðîâåðèì, åñòü ëè ðàíåå îòêðûòûå ïîçèöèè èëè îðäåðû?
   if(OrdersTotal() < 1) 
     {
       // íåò íè îäíîãî îòêðûòîãî îðäåðà
       // íà âñÿêèé ñëó÷àé ïðîâåðèì, åñëè ó íàñ ñâîáîäíûå äåíüãè íà ñ÷åòó?
       // çíà÷åíèå 1000 âçÿòî äëÿ ïðèìåðà, îáû÷íî ìîæíî îòêðûòü 1 ëîò
       if(AccountFreeMargin() < (1000*Lots))
         {
           Print("We have no money");
           return(0); // äåíåã íåò - âûõîäèì
         }
       // ïðîâåðèì, íå ñëèøêîì ëè ÷àñòî ïûòàåìñÿ îòêðûòüñÿ?
       // åñëè ïîñëåäíèé ðàç òîðãîâàëè ìåíåå ÷åì 5 ìèíóò(5*60=300 ñåê)
       // íàçàä, òî âûõîäèì
       // If((CurTime-LastTradeTime)<300) return(0);
       // ïðîâåðÿåì íà âîçìîæíîñòü âñòàòü â äëèííóþ ïîçèöèþ (BUY)
       if(Delta > rr && Delta1 < rr )
         {
           OrderSend(Symbol(), OP_BUY, Lots, Ask, 3, Ask - StopLoss*10*Point(), Ask + TakeProfit*10*Point(), 
                     "macd signal", 16384, 0, Red); // èñïîëíÿåì
           if(GetLastError() == 0)
               Print("Order opened : ", OrderOpenPrice());
           return(0); // âûõîäèì, òàê êàê âñå ðàâíî ïîñëå ñîâåðøåíèÿ òîðãîâîé îïåðàöèè
           // íàñòóïèë 10-òè ñåêóíäíûé òàéìàóò íà ñîâåðøåíèå òîðãîâûõ îïåðàöèé
         }
       // ïðîâåðÿåì íà âîçìîæíîñòü âñòàòü â êîðîòêóþ ïîçèöèþ (SELL)
       if(Delta < -rr && Delta1 > -rr )
         {
           OrderSend(Symbol(), OP_SELL, Lots, Bid, 3, Bid+StopLoss*10*Point(), Bid - TakeProfit*10*Point(), 
                     "macd sample", 16384, 0, Red); // èñïîëíÿåì
           if(GetLastError() == 0)
               Print("Order opened : ", OrderOpenPrice());
           return(0); // âûõîäèì
         }
       // çäåñü ìû çàâåðøèëè ïðîâåðêó íà âîçìîæíîñòü îòêðûòèÿ íîâûõ ïîçèöèé.
       // íîâûå ïîçèöèè îòêðûòû íå áûëè è ïðîñòî âûõîäèì ïî Exit, òàê êàê
       // âñå ðàâíî àíàëèçèðîâàòü íå÷åãî
       return(0);
     }
   // ïåðåõîäèì ê âàæíîé ÷àñòè ýêñïåðòà - êîíòðîëþ îòêðûòûõ ïîçèöèé
   // 'âàæíî ïðàâèëüíî âîéòè â ðûíîê, íî âûéòè - åùå âàæíåå...'
   total = OrdersTotal();
   for(cnt = 0; cnt < total; cnt++)
     {
       OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
       if(OrderType() <= OP_SELL && // ýòî îòêðûòàÿ ïîçèöèÿ? OP_BUY èëè OP_SELL 
          OrderSymbol()==Symbol())  // èíñòðóìåíò ñîâïàäàåò?
         {
           if(OrderType() == OP_BUY) // îòêðûòà äëèííàÿ ïîçèöèÿ
             {
               // ïðîâåðèì, ìîæåò óæå ïîðà çàêðûâàòüñÿ?
               //if(Delta < 0)
               //  {
               //    // çàêðûâàåì ïîçèöèþ
               //    OrderClose(OrderTicket(), OrderLots(), Bid, 3, Violet); 
               //    return(0); // âûõîäèì
               //  }
               // ïðîâåðèì - ìîæåò ìîæíî/íóæíî óæå òðåéëèíã ñòîï ñòàâèòü?
               if(TrailingStop > 0) // ïîëüçîâàòåëü âûñòàâèë â íàñòðîéêàõ òðåéëèíãñòîï
                 { // çíà÷èò ìû èäåì åãî ïðîâåðÿòü
                   if(Bid - OrderOpenPrice() > Points*TrailingStop)
                     {
                       if(OrderStopLoss() < Bid - Points*TrailingStop)
                         {
                           OrderModify(OrderTicket(), OrderOpenPrice(), 
                                       Bid - Points*TrailingStop, 
                                       OrderTakeProfit(), 0, Red);
                           return(0);
                         }
                     }
                 }
             }
           else // èíà÷å ýòî êîðîòêàÿ ïîçèöèÿ
             {
               // ïðîâåðèì, ìîæåò óæå ïîðà çàêðûâàòüñÿ?
               //if(Delta > 0)
               //  {
               //    // çàêðûâàåì ïîçèöèþ
               //    OrderClose(OrderTicket(), OrderLots(), Ask, 3, Violet); 
               //    return(0); // âûõîäèì
               //  }
               // ïðîâåðèì - ìîæåò ìîæíî/íóæíî óæå òðåéëèíã ñòîï ñòàâèòü?
               if(TrailingStop > 0) // ïîëüçîâàòåëü âûñòàâèë â íàñòðîéêàõ òðåéëèíãñòîï
                 { // çíà÷èò ìû èäåì åãî ïðîâåðÿòü
                   if((OrderOpenPrice() - Ask) > (Points*TrailingStop))
                     {
                       if(OrderStopLoss() == 0.0 || OrderStopLoss() > 
                          (Ask + Points*TrailingStop))
                         {
                           OrderModify(OrderTicket(), OrderOpenPrice(), 
                                       Ask + Points*TrailingStop, 
                                       OrderTakeProfit(), 0, Red);
                           return(0);
                         }
                     }
                 }
             }
         }
     }
   return(0);
  }
// the end.
//+------------------------------------------------------------------+

