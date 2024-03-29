//+------------------------------------------------------------------+
//|               Aouto Adjusting                                    |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
extern int PADAMOUNT=3;//pips Beyond candle to stop
extern double RISKPRESENT=0.1;//Risk Present 
extern double REWARD_RATIO=2;//Rward_Ratio
extern int CANDELSBACK=3;//How much candles for min\max
extern double       Mom_Sell=0.3;           //Momentum_Sell 
extern double       Mom_Buy=0.3;            //Momentum_Buy 
extern int MAGICNUMBER=1234;
input double sl=100;
input double tp=100;

double pips;
double bsl;
double ssl;
double btp;
double stp;
int buyticket;
int selticket;
int BUYSTOPCANDLE;
int SELSTOPCANDLE;
int orderentry;
double Riskedamount;
double Rewadamount;
double LOTSIZE;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   double ticksize=MarketInfo(Symbol(),MODE_TICKSIZE);//המרה לפיפס מתאים
   if(ticksize==0.00001 || Point==0.01)
      pips=ticksize*10;
   else pips=ticksize;
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {

  }
//+------------------------------------------------------------------+
void OnTick()

  {
   if(Bars<100)
     {
      Print("bars less than 100");
      return;
     }
   if(AccountFreeMargin()<(1000*LOTSIZE))
     {
      Print("We have no money. Free Margin = ",AccountFreeMargin());
      return;
     }
   checkformatrade();
  }
//+---------------------------------------------------------------------------+
//            check   open order
//+---------------------------------------------------------------------------+
int openorderthispair(string pair)// 
  {
   int total=0;
   for(int i=OrdersTotal()-1;i>=0;i--)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))Print("eror");
      if(OrderSymbol()==pair) total++;// 
     }
   return(total);
  }
//+---------------------------------------------------------------------------+
//|            new candle check
//+---------------------------------------------------------------------------+
bool isnewcandle()
  {
   static int  barsonchart=0;
   if(Bars==barsonchart)
      return(false);
   barsonchart=Bars;
   return(true);
  }
//+---------------------------------------------------------------------------+
//|                      CONDITION CHECK
//+---------------------------------------------------------------------------+
void checkformatrade()
  {
 
   if(isnewcandle())
     {
      //----------------------------------------------------------------------------    
      double   MomLevel=MathAbs(100-iMomentum(NULL,0,14,PRICE_CLOSE,1));
      double   MomLevel1=MathAbs(100 - iMomentum(NULL,0,14,PRICE_CLOSE,2));
      double   MomLevel2=MathAbs(100 - iMomentum(NULL,0,14,PRICE_CLOSE,3));
      //--------------------------------------------------------------------------------------------------
      double    MA6=iMA(Symbol(),0,6,0,MODE_EMA,PRICE_MEDIAN,2);
      double    MA14= iMA(Symbol(),0,14,0,MODE_EMA,PRICE_MEDIAN,1);
      double    MA26= iMA(Symbol(),0,26,0,MODE_EMA,PRICE_MEDIAN,2);
      //---------------BUY---------------
      if(MA6<MA14 && MA14<MA26)
         if(Low[1]<=MA14)
            if(MomLevel>Mom_Buy || MomLevel1>Mom_Buy || MomLevel2>Mom_Buy)
               trade(0);
      //---------------SELL---------------      
      if(MA6>MA14 && MA14>MA26)
         if(High[1]>=MA14)
            if(MomLevel>Mom_Sell || MomLevel1>Mom_Sell || MomLevel2>Mom_Sell)
               trade(1);
     }
  }
//+---------------------------------------------------------------------------+
//|                         *TRADE*
//+---------------------------------------------------------------------------+  
void  trade(int type)
  {
   int total=OrdersTotal();
   LOTSIZE=0;
   double Equity=AccountEquity();
   Riskedamount=Equity*RISKPRESENT*0.01;
   BUYSTOPCANDLE=iLowest(NULL,0,1,CANDELSBACK,1);
   SELSTOPCANDLE=iHighest(NULL,0,2,CANDELSBACK,1);
   double BUY_STOP_PRICE=Low[BUYSTOPCANDLE]-PADAMOUNT*pips;
   double PIPS_TO_BSL=Ask-BUY_STOP_PRICE;
   double BUY_TAKEPROFIT_PRICE=Ask+PIPS_TO_BSL*REWARD_RATIO;
   double SELL_STOP_PRICE=High[SELSTOPCANDLE]+PADAMOUNT*pips;
   double PIPS_TO_SSL=SELL_STOP_PRICE-Bid;
   double SELL_TAKEPROFIT_PRICE=Bid-PIPS_TO_SSL*REWARD_RATIO;

//--- check for long position (BUY) possibility
//+------------------------------------------------------------------+ 
//| BUY                      BUY                 BUY                 |
//+------------------------------------------------------------------+ 
   if(type==0)
     {
        if(AccountFreeMargin()<(1000*LOTSIZE))
     {
      Print("We have no money. Free Margin = ",AccountFreeMargin());
      return;
     }
      LOTSIZE=(Riskedamount/(PIPS_TO_BSL/pips))/10;
      if( CheckMoneyForTrade(Symbol(), LotsOptimized(LOTSIZE),OP_BUY))
      if(openorderthispair(Symbol())==0)buyticket=OrderSend(Symbol(),OP_BUY,LotsOptimized(LOTSIZE),ND(Ask),3,Ask-sl*10*Point(),Ask+tp*10*Point(),NULL,MAGICNUMBER,0,Green);
     }
//--- check for short position (SELL) possibility
//+------------------------------------------------------------------+
//| SELL             SELL                       SELL                 |
//+------------------------------------------------------------------+     
   if(type==1)
     {
        if(AccountFreeMargin()<(1000*LOTSIZE))
     {
      Print("We have no money. Free Margin = ",AccountFreeMargin());
      return;
     }
      LOTSIZE=(Riskedamount/(PIPS_TO_SSL/pips))/10;
      if( CheckMoneyForTrade(Symbol(), LotsOptimized(LOTSIZE),OP_SELL))
      if(openorderthispair(Symbol())==0) selticket=OrderSend(Symbol(),OP_SELL,LotsOptimized(LOTSIZE),ND(Bid),3,Bid+sl*10*Point(),Bid-tp*10*Point(),NULL,MAGICNUMBER,0,Red);
     }
//------------- Trail-----------------------------
   for(int cnt=0;cnt<total;cnt++)
     {
      if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         continue;
      if(OrderType()<=OP_SELL &&   // check for opened position 
         OrderSymbol()==Symbol())  // check for symbol
        {
         //--- long position is opened
         if(OrderType()==OP_BUY)
           {
            bsl=BUY_STOP_PRICE;
            btp=BUY_TAKEPROFIT_PRICE;
            LOTSIZE=(Riskedamount/(PIPS_TO_BSL/pips))/10;
            RefreshRates();
            double StopLevel=MarketInfo(Symbol(),MODE_STOPLEVEL)+MarketInfo(Symbol(),MODE_SPREAD);
            if(bsl<StopLevel*pips) bsl=StopLevel*pips;
            if(btp<StopLevel*pips) btp=StopLevel*pips;
            string symbol=OrderSymbol();
            double point=SymbolInfoDouble(symbol,SYMBOL_POINT);
            if(MathAbs(OrderStopLoss()-bsl)>point)
               if((pips*PIPS_TO_BSL)>(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_FREEZE_LEVEL)*pips)
                  //--- modify order and exit
                  if(CheckStopLoss_Takeprofit(OP_BUY,bsl,btp))
                     if(OrderModifyCheck(OrderTicket(),OrderOpenPrice(),bsl,btp))
                        if(buyticket>0)if(!OrderModify(OrderTicket(),OrderOpenPrice(),NDTP(bsl),NDTP(btp),0,CLR_NONE))Print("eror");
            return;
           }
         else // go to short position
           {
            //--- check for trailing stop
            ssl=SELL_STOP_PRICE;
            stp=SELL_TAKEPROFIT_PRICE;
            LOTSIZE=(Riskedamount/(PIPS_TO_SSL/pips))/10;
            RefreshRates();
            double StopLevel=MarketInfo(Symbol(),MODE_STOPLEVEL)+MarketInfo(Symbol(),MODE_SPREAD);
            if(ssl<StopLevel*pips) ssl=StopLevel*pips;
            if(stp<StopLevel*pips) stp=StopLevel*pips;
            string symbol=OrderSymbol();
            double point=SymbolInfoDouble(symbol,SYMBOL_POINT);
            if(MathAbs(OrderStopLoss()-ssl)>point)
               if((pips*PIPS_TO_SSL)>(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_FREEZE_LEVEL)*pips)
                  //--- modify order and exit
                  if(CheckStopLoss_Takeprofit(OP_SELL,ssl,stp))
                     if(OrderModifyCheck(OrderTicket(),OrderOpenPrice(),ssl,stp))
                        if(selticket>0)if(!OrderModify(OrderTicket(),OrderOpenPrice(),NDTP(ssl),NDTP(stp),0,CLR_NONE))Print("eror");//מכירה    
            return;
           }
        }
     }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Calculate optimal lot size                                       |
//+------------------------------------------------------------------+
double LotsOptimized(double Lotsize)
  {
   double lot=Lotsize;
   int    orders=OrdersHistoryTotal();     // history orders total
   int    losses=0;                  // number of losses orders without a break
//--- minimal allowed volume for trade operations
   double minlot=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN);
   if(lot<minlot)
     { lot=minlot; }
//--- maximal allowed volume of trade operations
   double maxlot=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX);
   if(lot>maxlot)
     { lot=maxlot;  }
//--- get minimal step of volume changing
   double volume_step=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_STEP);
   int ratio=(int)MathRound(lot/volume_step);
   if(MathAbs(ratio*volume_step-lot)>0.0000001)
     {  lot=ratio*volume_step;}
   return(lot);
  }
//+------------------------------------------------------------------+
double NDTP(double val)
  {
   RefreshRates();
   double SPREAD=MarketInfo(Symbol(),MODE_SPREAD);
   double StopLevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
   if(val<StopLevel*pips+SPREAD*pips) val=StopLevel*pips+SPREAD*pips;
   return(NormalizeDouble(val, Digits));
  }
//+------------------------------------------------------------------+
double ND(double val)
  {
   return(NormalizeDouble(val, Digits));
  }
////////////////////////////////////////////////////////////////////////////////////
int getOpenOrders()
  {

   int Orders=0;
   for(int i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         continue;
        }
      if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=MAGICNUMBER)
        {
         continue;
        }
      Orders++;
     }
   return(Orders);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Checking the new values of levels before order modification      |
//+------------------------------------------------------------------+
bool OrderModifyCheck(int ticket,double price,double sl,double tp)
  {
//--- select order by ticket
   if(OrderSelect(ticket,SELECT_BY_TICKET))
     {
      //--- point size and name of the symbol, for which a pending order was placed
      string symbol=OrderSymbol();
      double point=SymbolInfoDouble(symbol,SYMBOL_POINT);
      //--- check if there are changes in the Open price
      bool PriceOpenChanged=true;
      int type=OrderType();
      if(!(type==OP_BUY || type==OP_SELL))
        {
         PriceOpenChanged=(MathAbs(OrderOpenPrice()-price)>point);
        }
      //--- check if there are changes in the StopLoss level
      bool StopLossChanged=(MathAbs(OrderStopLoss()-sl)>point);
      //--- check if there are changes in the Takeprofit level
      bool TakeProfitChanged=(MathAbs(OrderTakeProfit()-tp)>point);
      //--- if there are any changes in levels
      if(PriceOpenChanged || StopLossChanged || TakeProfitChanged)
         return(true);  // order can be modified      
      //--- there are no changes in the Open, StopLoss and Takeprofit levels
      else
      //--- notify about the error
         PrintFormat("Order #%d already has levels of Open=%.5f SL=%.5f TP=%.5f",
                     ticket,OrderOpenPrice(),OrderStopLoss(),OrderTakeProfit());
     }
//--- came to the end, no changes for the order
   return(false);       // no point in modifying 
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
bool CheckStopLoss_Takeprofit(ENUM_ORDER_TYPE type,double SL,double TP)
  {
//--- get the SYMBOL_TRADE_STOPS_LEVEL level
   int stops_level=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL);
   if(stops_level!=0)
     {
      PrintFormat("SYMBOL_TRADE_STOPS_LEVEL=%d: StopLoss and TakeProfit must"+
                  " not be nearer than %d points from the closing price",stops_level,stops_level);
     }
//---
   bool SL_check=false,TP_check=false;
//--- check only two order types
   switch(type)
     {
      //--- Buy operation
      case  ORDER_TYPE_BUY:
        {
         //--- check the StopLoss
         SL_check=(Bid-SL>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s StopLoss=%.5f must be less than %.5f"+
                        " (Bid=%.5f - SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,Bid-stops_level*_Point,Bid,stops_level);
         //--- check the TakeProfit
         TP_check=(TP-Bid>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s TakeProfit=%.5f must be greater than %.5f"+
                        " (Bid=%.5f + SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,Bid+stops_level*_Point,Bid,stops_level);
         //--- return the result of checking
         return(SL_check&&TP_check);
        }
      //--- Sell operation
      case  ORDER_TYPE_SELL:
        {
         //--- check the StopLoss
         SL_check=(SL-Ask>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s StopLoss=%.5f must be greater than %.5f "+
                        " (Ask=%.5f + SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,Ask+stops_level*_Point,Ask,stops_level);
         //--- check the TakeProfit
         TP_check=(Ask-TP>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s TakeProfit=%.5f must be less than %.5f "+
                        " (Ask=%.5f - SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,Ask-stops_level*_Point,Ask,stops_level);
         //--- return the result of checking
         return(TP_check&&SL_check);
        }
      break;
     }
//--- a slightly different function is required for pending orders
   return false;
  }
//+------------------------------------------------------------------+
bool CheckMoneyForTrade(string symb, double lots,int type)
  {
   double free_margin=AccountFreeMarginCheck(symb,type, lots);
   //-- if there is not enough money
   if(free_margin<0)
     {
      string oper=(type==OP_BUY)? "Buy":"Sell";
      Print("Not enough money for ", oper," ",lots, " ", symb, " Error code=",GetLastError());
      return(false);
     }
   //--- checking successful
   return(true);
  }