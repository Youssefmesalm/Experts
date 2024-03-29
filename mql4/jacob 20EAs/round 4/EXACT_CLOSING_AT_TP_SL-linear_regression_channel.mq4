//+------------------------------------------------------------------+
//|             LINEAR REGRETION CHANNEL                             |
//|             http://algorithmic-trading-ea-mt4.000webhostapp.com/ |
//|                                                    AHARON TZADIK |
//+------------------------------------------------------------------+
#property copyright   "AHARON TZADIK"
#property link        "http://algorithmic-trading-ea-mt4.000webhostapp.com/"
#property version     "1.00"
#property strict

//--------------------------------------------------------------------
extern int   Len_Cn=50;                // Channel length (bars)
extern color Col_Cn=Orange;            // Channel color
//--------------------------------------------------------

extern bool         USEMOVETOBREAKEVEN=false;//Enable "no loss"
extern double       WHENTOMOVETOBE=10;      //When to move break even
extern double       PIPSTOMOVESL=5;         //How much pips to move sl
extern double       Lots=0.01;              //Lots size 
input  double       MaximumRisk   =0.02;
input  double       DecreaseFactor=0.001;
extern double       TrailingStop=40;        //TrailingStop 
extern double       Stop_Loss=400;           //Stop Loss  
extern int          MagicNumber=1234;       //MagicNumber 
input  double       TakeProfit=400;          //TakeProfit
extern int          FastMA=6;               //FastMA 
extern int          SlowMA=85;              //SlowMA
extern double       Distance=5;             //Distance 
extern double       Mom_Sell=0.3;           //Momentum_Sell 
extern double       Mom_Buy=0.3;            //Momentum_Buy 

                                            // double       TakeProfit=iATR(NULL,0,14,0)*2;          //TakeProfit
//double       Stop_Loss=iATR(NULL,0,14,0)*2;           //Stop Loss 



int           err;

bool               FractalsUp=false;
bool               FractalsDown=false;
double             FractalsUpPrice=0;
double             FractalsDownPrice=0;
int                FractalsLimit=250;
int total=0;
double
Lot,Dmax,Dmin,// Amount of lots in a selected order
Lts,                             // Amount of lots in an opened order
Min_Lot,                         // Minimal amount of lots
Step,                            // Step of lot size change
Free,                            // Current free margin
One_Lot,                         // Price of one lot
Price,                           // Price of a selected order,
pips,
MA_1,MA_2,MA_3,MACD_SIGNAL;
int Type,freeze_level,Spread;
//--- price levels for orders and positions
double priceopen,stoploss,takeprofit;
//--- ticket of the current order 
int orderticket;
double  Linenow=0;
double  Lineprev=0;
//--------------------------------------------------------------- 3 --
int
Period_MA_2,  Period_MA_3,       // Calculation periods of MA for other timefr.
Period_MA_02, Period_MA_03,      // Calculation periods of supp. MAs
K2,K3,T;
//---
datetime dt=0;
datetime dt1=0;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   Create();
//--------------------------------------------------------------- 5 --

   double ticksize=MarketInfo(Symbol(),MODE_TICKSIZE);
   if(ticksize==0.00001 || ticksize==0.001)
      pips=ticksize*10;
   else pips=ticksize;
   return(INIT_SUCCEEDED);
//--- distance from the activation price, within which it is not allowed to modify orders and positions
   freeze_level=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_FREEZE_LEVEL);
   if(freeze_level!=0)
     {
      PrintFormat("SYMBOL_TRADE_FREEZE_LEVEL=%d: order or position modification is not allowed,"+
                  " if there are %d points to the activation price",freeze_level,freeze_level);
     }
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick(void)
  {
   drow();
   if(USEMOVETOBREAKEVEN) MOVETOBREAKEVEN();
   Trail1();
   int    ticket=0;
// Check for New Bar (Compatible with both MQL4 and MQL5)
   static datetime dtBarCurrent=WRONG_VALUE;
   datetime dtBarPrevious=dtBarCurrent;
   dtBarCurrent=(datetime) SeriesInfoInteger(_Symbol,_Period,SERIES_LASTBAR_DATE);
   bool NewBarFlag=(dtBarCurrent!=dtBarPrevious);
// initial data checks
// it is important to make sure that the expert works with a normal
// chart and the user did not make any mistakes setting external 
// variables (Lots, StopLoss, TakeProfit, 
// TrailingStop) in our case, we check TakeProfit
// on a chart of less than 100 bars
//---
   if(Bars<100)
     {
      Print("bars less than 100");
      return;
     }
   if(TakeProfit<10)
     {
      Print("TakeProfit less than 10");
      return;
     }
//--- to simplify the coding and speed up access data are put into internal variables     
   double MA_250=iMA(NULL,0,FastMA,0,MODE_LWMA,PRICE_TYPICAL,1); // МА_2
   double MA_500=iMA(NULL,0,SlowMA,0,MODE_LWMA,PRICE_TYPICAL,1); // МА_2
//----------------------------------------------------------------------------    
   double   MomLevel=MathAbs(100-iMomentum(NULL,0,14,PRICE_CLOSE,1));
   double   MomLevel1=MathAbs(100 - iMomentum(NULL,0,14,PRICE_CLOSE,2));
   double   MomLevel2=MathAbs(100 - iMomentum(NULL,0,14,PRICE_CLOSE,3));
//--------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
   double middleBB=iBands(Symbol(),0,20, 2,0,0,MODE_MAIN,1);//middle
   double lowerBB=iBands(Symbol(),0,20, 2,0,0,MODE_LOWER,1);//lower
   double upperBB=iBands(Symbol(),0,20, 2,0,0,MODE_UPPER,1);//upper
//+------------------------------------------------------------------+ 
//+------------------------------------------------------------------+                                        
   double  MacdMAIN=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,1);
   double  MacdSIGNAL=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_SIGNAL,1);
   double  MacdMAIN1=iMACD(NULL,0,12,26,1,PRICE_CLOSE,MODE_MAIN,1);
   double  MacdMAIN2=iMACD(NULL,0,6,13,1,PRICE_CLOSE,MODE_MAIN,1);
//+------------------------------------------------------------------+
//----------------------------------------------------------------------------    
   double  MA_1_t=iMA(NULL,0,FastMA,0,MODE_LWMA,PRICE_TYPICAL,0); // МА_1
   double  MA_2_t=iMA(NULL,0,SlowMA,0,MODE_LWMA,PRICE_TYPICAL,0); // МА_2  
//-------------------------------------------------------------------------------------------------
   Linenow=ObjectGet("Obj_Reg_Ch",OBJPROP_TIME2);//2nd time coord.
   Lineprev=ObjectGet("Obj_Reg_Ch",OBJPROP_TIME1);//1st time coord.
   dt=(datetime)Linenow;//convert double to datetime 2nd time coord.
   dt1=(datetime)Lineprev;//convert double to datetime 1st time coord.
//--------------------------------------------------------------------------------------------------  
   if(getOpenOrders()==0)

     {
      //--- no opened orders identified
      if(AccountFreeMargin()<(1000*Lots))
        {
         Print("We have no money. Free Margin = ",AccountFreeMargin());
         return;
        }
      if(NewBarFlag)
        {
         //--- check for long position (BUY) possibility
         //+------------------------------------------------------------------+ 
         //| BUY                      BUY                 BUY                 |
         //+------------------------------------------------------------------+ 
         if(MA_1_t>MA_2_t/*+Distance*10*Point()*/)
            if(MomLevel<Mom_Buy || MomLevel1<Mom_Buy || MomLevel2<Mom_Buy)
              {
               if(IsTesting()==true)
                 {
                  ticket=OrderSend(Symbol(),OP_BUY,LotsOptimized(),ND(Ask),3,NDTP(Bid-Stop_Loss*10*Point()),NDTP(Bid+TakeProfit*10*Point()),"renko",MagicNumber,0,PaleGreen);
                  if(ticket>0)
                    {
                     if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
                        Print("BUY order opened : ",OrderOpenPrice());
                    }
                  else
                     Print("Error opening BUY order : ",GetLastError());
                  return;
                 }
               if(IsTesting()==false)//only in live trading we use the channel
                 {
                  if(High[iBarShift(NULL,0,dt)]>High[iBarShift(NULL,0,dt1)])
                     ticket=OrderSend(Symbol(),OP_BUY,LotsOptimized(),ND(Ask),3,NDTP(Bid-Stop_Loss*10*Point()),NDTP(Bid+TakeProfit*10*Point()),"renko",MagicNumber,0,PaleGreen);
                  if(ticket>0)
                    {
                     if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
                        Print("BUY order opened : ",OrderOpenPrice());
                    }
                  else
                     Print("Error opening BUY order : ",GetLastError());
                  return;
                 }
              }
         //--- check for short position (SELL) possibility
         //+------------------------------------------------------------------+
         //| SELL             SELL                       SELL                 |
         //+------------------------------------------------------------------+
         if(MA_1_t<MA_2_t/*-Distance*10*Point()*/)
            if(MomLevel<Mom_Sell || MomLevel1<Mom_Sell || MomLevel2<Mom_Sell)
              {
               if(IsTesting()==true)
                 {
                  ticket=OrderSend(Symbol(),OP_SELL,LotsOptimized(),ND(Bid),3,NDTP(Ask+Stop_Loss*10*Point()),NDTP(Ask-TakeProfit*10*Point()),"Short 1",MagicNumber,0,Red);
                  if(ticket>0)
                    {
                     if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
                        Print("SELL order opened : ",OrderOpenPrice());
                    }
                  else
                     Print("Error opening SELL order : ",GetLastError());
                 }
               if(IsTesting()==false)//only in live trading we use the channel
                 {
                  if(High[iBarShift(NULL,0,dt)]<High[iBarShift(NULL,0,dt1)])
                     ticket=OrderSend(Symbol(),OP_SELL,LotsOptimized(),ND(Bid),3,NDTP(Ask+Stop_Loss*10*Point()),NDTP(Ask-TakeProfit*10*Point()),"Short 1",MagicNumber,0,Red);
                  if(ticket>0)
                    {
                     if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
                        Print("SELL order opened : ",OrderOpenPrice());
                    }
                  else
                     Print("Error opening SELL order : ",GetLastError());
                 }
               return;
              }
         //--- exit from the "no opened orders" block
         return;
        }
     }
  }
//+------------------------------------------------------------------+
//|   stop                                                           |
//+------------------------------------------------------------------+   
//-----------------------------------------------------------------------------+ 
void stop()
  {
   int cnt;
//+------------------------------------------------------------------+
   double middleBB=iBands(Symbol(),0,20, 2,0,0,MODE_MAIN,1);//middle
   double lowerBB=iBands(Symbol(),0,20, 2,0,0,MODE_LOWER,1);//lower
   double upperBB=iBands(Symbol(),0,20, 2,0,0,MODE_UPPER,1);//upper
//+------------------------------------------------------------------+                                        
   double  MacdMAIN=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,1);
   double  MacdSIGNAL=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_SIGNAL,1);
//+------------------------------------------------------------------+       
   for(cnt=0;cnt<total;cnt++)
     {
      if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         continue;
      if(OrderType()<=OP_SELL &&   // check for opened position 
         OrderSymbol()==Symbol())  // check for symbol
        {
         //--- long position is opened
         if(OrderType()==OP_BUY)
           {
            //--- should it be closed?

            if((((Bid<OrderOpenPrice()-iATR(NULL,0,14,0))
               || ((MacdMAIN>0 && MacdMAIN<MacdSIGNAL) || (MacdMAIN<0 && (MathAbs(MacdMAIN)>MathAbs(MacdSIGNAL))))
               || Close[1]==upperBB))
               || (((Ask>OrderOpenPrice()+iATR(NULL,0,14,0))
               || Close[1]==lowerBB)))
               exitbuys();
            //--- check for trailing stop
           }
         else // go to short position
           {
            //--- should it be closed?

            if((((Ask>OrderOpenPrice()+iATR(NULL,0,14,0)))
               || Close[1]==lowerBB)
               || (((Bid<OrderOpenPrice()-iATR(NULL,0,14,0))
               || ((MacdMAIN>0 && MacdMAIN>MacdSIGNAL) || (MacdMAIN<0 && (MathAbs(MacdMAIN)<MathAbs(MacdSIGNAL))))
               || Close[1]==upperBB)))
               exitsells();
            //--- check for trailing stop
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Trailing stop loss                                               |
//+------------------------------------------------------------------+ 
// --------------- ----------------------------------------------------------- ------------------------                    
void Trail1()
  {
   total=OrdersTotal();
//--- it is important to enter the market correctly, but it is more important to exit it correctly...   
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

            //--- check for trailing stop
            if(TrailingStop>0)
              {
               if(Bid-OrderOpenPrice()>10*Point()*TrailingStop)
                 {
                  if(OrderStopLoss()<Bid-10*Point()*TrailingStop)
                    {

                     RefreshRates();
                     stoploss=Bid-(10*Point()*TrailingStop);
                     takeprofit=OrderTakeProfit()+10*Point()*TrailingStop;
                     double StopLevel=MarketInfo(Symbol(),MODE_STOPLEVEL)+MarketInfo(Symbol(),MODE_SPREAD);
                     if(stoploss<StopLevel*10*Point()) stoploss=StopLevel*10*Point();
                     string symbol=OrderSymbol();
                     double point=SymbolInfoDouble(symbol,SYMBOL_POINT);
                     if(MathAbs(OrderStopLoss()-stoploss)>point)
                        if((10*Point()*TrailingStop)>(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_FREEZE_LEVEL)*10*Point())

                           //--- modify order and exit
                           if(CheckStopLoss_Takeprofit(OP_BUY,stoploss,takeprofit))
                              if(OrderModifyCheck(OrderTicket(),OrderOpenPrice(),stoploss,takeprofit))
                                 if(!OrderModify(OrderTicket(),OrderOpenPrice(),stoploss,takeprofit,0,Green))
                                    Print("OrderModify error ",GetLastError());
                     return;
                    }
                 }
              }
           }
         else // go to short position
           {
            //--- check for trailing stop
            if(TrailingStop>0)
              {
               if((OrderOpenPrice()-Ask)>(10*Point()*TrailingStop))
                 {
                  if((OrderStopLoss()>(Ask+10*Point()*TrailingStop)) || (OrderStopLoss()==0))
                    {

                     RefreshRates();
                     stoploss=Ask+(10*Point()*TrailingStop);
                     takeprofit=OrderTakeProfit()-10*Point()*TrailingStop;
                     double StopLevel=MarketInfo(Symbol(),MODE_STOPLEVEL)+MarketInfo(Symbol(),MODE_SPREAD);
                     if(stoploss<StopLevel*10*Point()) stoploss=StopLevel*10*Point();
                     if(takeprofit<StopLevel*10*Point()) takeprofit=StopLevel*10*Point();
                     string symbol=OrderSymbol();
                     double point=SymbolInfoDouble(symbol,SYMBOL_POINT);
                     if(MathAbs(OrderStopLoss()-stoploss)>point)
                        if((10*Point()*TrailingStop)>(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_FREEZE_LEVEL)*10*Point())

                           //--- modify order and exit
                           if(CheckStopLoss_Takeprofit(OP_SELL,stoploss,takeprofit))
                              if(OrderModifyCheck(OrderTicket(),OrderOpenPrice(),stoploss,takeprofit))
                                 if(!OrderModify(OrderTicket(),OrderOpenPrice(),stoploss,takeprofit,0,Red))
                                    Print("OrderModify error ",GetLastError());
                     return;
                    }
                 }
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//+---------------------------------------------------------------------------+
//|                          MOVE TO BREAK EVEN                               |
//+---------------------------------------------------------------------------+
void MOVETOBREAKEVEN()

  {
   for(int b=OrdersTotal()-1;b>=0;b--)
     {
      if(OrderSelect(b,SELECT_BY_POS,MODE_TRADES))
         if(OrderMagicNumber()!=MagicNumber)continue;
      if(OrderSymbol()==Symbol())
         if(OrderType()==OP_BUY)
            if(Bid-OrderOpenPrice()>WHENTOMOVETOBE*10*Point())
               if(OrderOpenPrice()>OrderStopLoss())
                  if(!OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+(PIPSTOMOVESL*10*Point()),OrderTakeProfit(),0,CLR_NONE))
                     Print("eror");
     }

   for(int s=OrdersTotal()-1;s>=0;s--)
     {
      if(OrderSelect(s,SELECT_BY_POS,MODE_TRADES))
         if(OrderMagicNumber()!=MagicNumber)continue;
      if(OrderSymbol()==Symbol())
         if(OrderType()==OP_SELL)
            if(OrderOpenPrice()-Ask>WHENTOMOVETOBE*10*Point())
               if(OrderOpenPrice()<OrderStopLoss())
                  if(!OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-(PIPSTOMOVESL*10*Point()),OrderTakeProfit(),0,CLR_NONE))
                     Print("eror");
     }
  }
//--------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------

double FindFractals()
  {
//Initialization of the variables
   FractalsUp=false;
   FractalsDown=false;
   FractalsUpPrice=0;
   FractalsDownPrice=0;
   double JAW=iAlligator(NULL,T,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORJAW,1);
   double TEETH=iAlligator(NULL,T,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORTEETH,1);
   double LIPS=iAlligator(NULL,T,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN,MODE_GATORLIPS,1);
//For loop to scan the last FractalsLimit candles starting from the oldest and finishing with the most recent
   for(int i=FractalsLimit; i>=0; i--)
     {
      //If there is a fractal on the candle the value will be greater than zero and equal to the highest or lowest price
      double fu=iFractals(NULL,T,MODE_UPPER,i);
      double fd=iFractals(NULL,T,MODE_LOWER,i);
      //If there is an upper fractal I store the value and set true the FractalsUp variable
      if(fu>0)
         if(JAW>TEETH>LIPS && Ask>fu)
           {
            FractalsUp=true;
            FractalsDown=false;
            FractalsUpPrice++;
            Print("FractalsUpPrice",FractalsUpPrice);
            if((High[1]<fu || High[2]<fu || High[3]<fu) && (Ask/*Open[0]*/>=fu))
               return(1);
           }
      //If there is an lower fractal I store the value and set true the FractalsDown variable
      if(fd>0)
         //  if(JAW<TEETH<LIPS&&Bid<fd)
        {
         FractalsUp=false;
         FractalsDown=true;
         FractalsDownPrice++;
         Print("FractalsDownPrice",FractalsDownPrice);
         //  if((Low[1]>fd || Low[2]>fd || Low[3]>fd) && (Ask/*Open[0]*/<=fd))
         return(2);
        }
      //if the candle has both upper and lower fractal the values are stored but we do not consider it as last fractal
      if(fu>0 && fd>0)
        {
         FractalsUp=false;
         FractalsDown=false;
         FractalsUpPrice=fu;
         FractalsDownPrice=fd;
         return(0);
        }
     }
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Calculate optimal lot size                                       |
//+------------------------------------------------------------------+
double LotsOptimized()
  {
   double lot=Lots;
   int    orders=OrdersHistoryTotal();     // history orders total
   int    losses=0;                  // number of losses orders without a break
//--- select lot size
   if(MaximumRisk>0)
     {
      lot=NormalizeDouble(AccountFreeMargin()*MaximumRisk/1000.0,1);
     }
//--- calcuulate number of losses orders without a break
   if(DecreaseFactor>0)
     {
      for(int i=orders-1;i>=0;i--)
        {
         if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false)
           {
            Print("Error in history!");
            break;
           }
         if(OrderSymbol()!=Symbol() /*|| OrderType()>OP_SELL*/)
            continue;
         //---
         if(OrderProfit()>0) break;
         if(OrderProfit()<0) losses++;
        }
      if(losses>1)
         lot=NormalizeDouble(lot-lot*losses/DecreaseFactor,1);
     }
//--- minimal allowed volume for trade operations
   double minlot=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN);
   if(lot<minlot)
     { lot=minlot; }
// Print("Volume is less than the minimal allowed ,we use",minlot);}
// lot=minlot;

//--- maximal allowed volume of trade operations
   double maxlot=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX);
   if(lot>maxlot)
     { lot=maxlot;  }
//  Print("Volume is greater than the maximal allowed,we use",maxlot);}
// lot=maxlot;

//--- get minimal step of volume changing
   double volume_step=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_STEP);
   int ratio=(int)MathRound(lot/volume_step);
   if(MathAbs(ratio*volume_step-lot)>0.0000001)
     {  lot=ratio*volume_step;}
   return(lot);
/* else  Print("StopOut level  Not enough money for ",OP_SELL," ",lot," ",Symbol());
   return(0);*/
  }
//+------------------------------------------------------------------+
double NDTP(double val)
  {
   RefreshRates();
   double SPREAD=MarketInfo(Symbol(),MODE_SPREAD);
   double StopLevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
   if(val<StopLevel*10*Point()+SPREAD*10*Point()) val=StopLevel*10*Point()+SPREAD*10*Point();
// double STOPLEVEL = MarketInfo(Symbol(),MODE_STOPLEVEL);
//int Stops_level=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL);

//if (Stops_level*10*Point()<val-Bid)
//val=Ask+Stops_level*10*Point();
   return(NormalizeDouble(val, Digits));
// return(val);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double ND(double val)
  {
   return(NormalizeDouble(val, Digits));
  }
//+------------------------------------------------------------------+ 
int IfOrderDoesNotExistBuy()
  {
   bool exists=false;
   for(int i=OrdersTotal(); i>=0; i--)
     {

      if(OrderSelect(i,SELECT_BY_POS)==true && OrderSymbol()==Symbol())
        {
         exists = true; return(exists);
           }else{
         Print("OrderSelect() error - ",(GetLastError()));
        }
     }

   if(exists==false)
     {
      //BuyOrderType();
      // return(exists);
     }
   return(0);
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
      if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=MagicNumber)
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

//+------------------------------------------------------------------+
//|                                      exitbuys()                  |
//+------------------------------------------------------------------+
void exitbuys()
  {
   double result;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderType()==OP_BUY && OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
           {
            result=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,clrNONE);
            if(result!=true)//if it did not close
              {
               err=GetLastError(); Print("LastError = ",err);//get the reason why it didn't close
              }

           }
        }

     }
  }
//+------------------------------------------------------------------+  
//+------------------------------------------------------------------+
//|                    exitsells()                                   |
//+------------------------------------------------------------------+
void exitsells()
  {
   double result;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {

         if(OrderType()==OP_SELL && OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
           {
            result=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,clrNONE);
            if(result!=true)//if it did not close
              {
               err=GetLastError(); Print("LastError = ",err);//get the reason why it didn't close
              }

           }
        }

     }
  }
//+------------------------------------------------------------------+  
//+------------------------------------------------------------------+ 
int drow()
  {
   datetime T2=0;                        // Second time coordinate
   double t2=0;
   int Error;                          // Error code
//--------------------------------------------------------------- 3 --   
   t2=ObjectGet("Obj_Reg_Ch",OBJPROP_TIME2);// Requesting t2 coord.
                                            //T2=t2;
   Error=GetLastError();               // Getting an error code
   if(Error==4202) // If no object :(
     {
      //  Alert("Regression channel is being managed",
      //       "\n Book_expert_82_2. deletion prohibited.");
      Create();
      T2=Time[0];                      // Current value of t2 coordinate
     }

//--------------------------------------------------------------- 4 --
   if(T2!=Time[0]) // If object is not in its place
     {
      ObjectMove("Obj_Reg_Ch", 0, Time[Len_Cn-1],0); //New t1 coord.
      ObjectMove("Obj_Reg_Ch", 1, Time[0],       0); //New t2 coord.
      WindowRedraw();                  // Redrawing the image 
     }
   return (0);
  }
//--------------------------------------------------------------- 6 --
int Create()                           // User-defined function..
  {                                    // ..of object creation
   datetime T1=Time[Len_Cn-1];         // Defining 1st time coord.
   datetime T2=Time[0];                // Defining 2nd time coord.
   ObjectCreate("Obj_Reg_Ch",OBJ_REGRESSION,0,T1,0,T2,0);// Creation
   ObjectSet(   "Obj_Reg_Ch", OBJPROP_COLOR, Col_Cn);    // Color
   ObjectSet(   "Obj_Reg_Ch", OBJPROP_RAY,   false);     // Ray
   ObjectSet(   "Obj_Reg_Ch", OBJPROP_STYLE, STYLE_DASH);// Style
   ObjectSetText("Obj_Reg_Ch","Created by the EA moveobjects",10);
   WindowRedraw();                     // Image redrawing
   return(0);
  }
//--------------------------------------------------------------- 7 --
