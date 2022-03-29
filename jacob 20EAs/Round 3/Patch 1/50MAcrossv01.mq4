//+------------------------------------------------------------------+
//|                                                          CCI.mq4 |
//|                                         Lowphat Copyright © 2005 |
//|                    http://www.forex-tsd.com/showthread.php?t=523 |
//+------------------------------------------------------------------+
#property copyright "Mod and code by Lowphat Original idea by nina Copyright © 2005"
#property link      "http://www.forex-tsd.com/showthread.php?t=523"

#define MAGIC 999

extern double MinutesBetweenOrders = 120;
extern double MAperiod = 50;
extern double StopLoss = 30;
extern double TakeProfit = 50;
extern double TrailingStop = 0;
extern color clOpenBuy = Blue;
extern color clCloseBuy = Aqua;
extern color clOpenSell = Red;
extern color clCloseSell = Violet;
extern color clModiBuy = Blue;
extern color clModiSell = Red;
extern string Name_Expert = "MA Cross";
extern int Slippage = 5;
extern bool UseSound = True;
extern string NameFileSound = "alert.wav";
extern double Lots = 0.10;

void deinit() {
   Comment("");
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start(){
   if(Bars<100){
      Print("bars less than 100");
      return(0);
   }
   if(StopLoss<10){
      Print("StopLoss less than 10");
      return(0);
   }
   if(TakeProfit<10){
      Print("TakeProfit less than 10");
      return(0);
   }
   if(StopLoss<10){
      Print("StopLoss less than 10");
      return(0);
   }
   if(TakeProfit<10){
      Print("TakeProfit less than 10");
      return(0);
   }

   double ma;
   double ma1;
   double ma2;
   double ma3;
   ma=iMA(NULL,0,MAperiod,MODE_EMA,0,PRICE_CLOSE,0);
   ma1=iMA(NULL,0,MAperiod,MODE_EMA,0,PRICE_CLOSE,1);  
   ma2=iMA(NULL,0,MAperiod,MODE_EMA,0,PRICE_CLOSE,2);
   ma3=iMA(NULL,0,MAperiod,MODE_EMA,0,PRICE_CLOSE,3);
  
static datetime lastordertime= 0;
int sometimelimit= MinutesBetweenOrders * 60;  // don't re-order within 10 minutes

   if(AccountFreeMargin()<(1000*Lots)){
      Print("We have no money. Free Margin = ", AccountFreeMargin());
      return(0);
   }
   if (!ExistPositions()){

      if ((ma3>Close[3] && ma2<Close[2] && ma1<Close[1] && ma<Bid && CurTime()-lastordertime > sometimelimit)){
         OpenBuy();
         lastordertime= CurTime();
         return(0);
      }

      if ((ma3<Close[3] && ma2>Close[2] && ma1>Close[1] && ma>Ask && CurTime()-lastordertime > sometimelimit)){
         OpenSell();
         lastordertime= CurTime();
         return(0);
      }
   }
   if (ExistPositions()){
      if(OrderType()==OP_BUY){

         if ((Bid!=Bid)){  //To be determined
            CloseBuy();
            return(0);
         }
      }
      if(OrderType()==OP_SELL){

         if ((Bid!=Bid)){//To be determined
            CloseSell();
            return(0);
         }
      }
   }
   TrailingPositionsBuy(TrailingStop);
   TrailingPositionsSell(TrailingStop);
   return (0);
}

bool ExistPositions() {
	for (int i=0; i<OrdersTotal(); i++) {
		if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
			if (OrderSymbol()==Symbol() && OrderMagicNumber()==MAGIC) {
				return(True);
			}
		} 
	} 
	return(false);
}
void TrailingPositionsBuy(int trailingStop) { 
   for (int i=0; i<OrdersTotal(); i++) { 
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) { 
         if (OrderSymbol()==Symbol() && OrderMagicNumber()==MAGIC) { 
            if (OrderType()==OP_BUY) { 
               if (Bid-OrderOpenPrice()>trailingStop*Point) { 
                  if (OrderStopLoss()<Bid-trailingStop*Point) 
                     ModifyStopLoss(Bid-trailingStop*Point); 
               } 
            } 
         } 
      } 
   } 
} 
void TrailingPositionsSell(int trailingStop) { 
   for (int i=0; i<OrdersTotal(); i++) { 
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) { 
         if (OrderSymbol()==Symbol() && OrderMagicNumber()==MAGIC) { 
            if (OrderType()==OP_SELL) { 
               if (OrderOpenPrice()-Ask>trailingStop*Point) { 
                  if (OrderStopLoss()>Ask+trailingStop*Point || OrderStopLoss()==0)  
                     ModifyStopLoss(Ask+trailingStop*Point); 
               } 
            } 
         } 
      } 
   } 
} 
void ModifyStopLoss(double ldStopLoss) { 
   bool fm;
   fm = OrderModify(OrderTicket(),OrderOpenPrice(),ldStopLoss,OrderTakeProfit(),0,CLR_NONE); 
   if (fm && UseSound) PlaySound(NameFileSound); 
} 

void OpenBuy() { 
   double ldLot, ldStop, ldTake; 
   string lsComm; 
   ldLot = GetSizeLot(); 
   ldStop = GetStopLossBuy(); 
   ldTake = GetTakeProfitBuy(); 
   lsComm = GetCommentForOrder(); 
   OrderSend(Symbol(),OP_BUY,ldLot,Ask,Slippage,ldStop,ldTake,lsComm,MAGIC,0,clOpenBuy); 
   if (UseSound) PlaySound(NameFileSound); 
} 

void CloseBuy() { 
   bool fc; 
   fc=OrderClose(OrderTicket(), OrderLots(), Bid, Slippage, clCloseBuy); 
   if (fc && UseSound) PlaySound(NameFileSound); 
} 
void CloseSell() { 
   bool fc; 
   fc=OrderClose(OrderTicket(), OrderLots(), Ask, Slippage, clCloseSell); 
   if (fc && UseSound) PlaySound(NameFileSound); 
} 
void OpenSell() { 
   double ldLot, ldStop, ldTake; 
   string lsComm; 

   ldLot = GetSizeLot(); 
   ldStop = GetStopLossSell(); 
   ldTake = GetTakeProfitSell(); 
   lsComm = GetCommentForOrder(); 
   OrderSend(Symbol(),OP_SELL,ldLot,Bid,Slippage,ldStop,ldTake,lsComm,MAGIC,0,clOpenSell); 
   if (UseSound) PlaySound(NameFileSound); 
} 
string GetCommentForOrder() { 	return(Name_Expert); } 
double GetSizeLot() { 	return(Lots); } 
double GetStopLossBuy() { 	return (Bid-StopLoss*Point);} 
double GetStopLossSell() { 	return(Ask+StopLoss*Point); } 
double GetTakeProfitBuy() { 	return(Ask+TakeProfit*Point); } 
double GetTakeProfitSell() { 	return(Bid-TakeProfit*Point); } 