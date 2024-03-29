//+------------------------------------------------------------------+
//|                     MARTINGALE VI HYBRID                         |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.01"
#property strict
/*-- These variables are shown in the EA and can be changed --*/
extern    int      Take_Profit   = 10;   // TP value of each trade in this Martingale EA
extern    int      Stop_Loss   = 10;   // SL value of each trade in this Martingale EA
extern    int      PipStep       = 10;   // Distance in pips which will open a new trade
extern    double   Lotsize=0.01;            // The value of the initial lots , will be duplicated every step
extern    double   Multiply=2.0;         // Multiplier value every step of new trade
extern    int      MaxTrade= 4;          // Maximum trades that can  run
input string       str5="Fast moving average";
input int          Period1=1;            //Fast moving average(in pips)
input string       str6="Slow moving average";
input int          Period2=50;          //Slow moving average(in pips)
extern    bool     CLOSEMAXORDERS=true; // Close Maximum Orders
extern    int      MagicNumber=8095;  // Magic Number
double   SetPoint=0;                    // Variable SetPoint to code 4 or 5 digit brokers
double        pips;
int T=0;
int Count_one_message=0;
int           Tp,err,ntp,result;
double priceopen,stoploss,takeprofit;
/*--These parameters are to be displayed on the screen --*/
string   EAName               = "Martingale ver 1.0"; // EA name , to be displayed on the screen
string   EAComment            = "Martingale";         // This variable will we put in each trade as a Comment
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   double ticksize=MarketInfo(Symbol(),MODE_TICKSIZE);
   if(ticksize==0.00001 || ticksize==0.001)
      pips=ticksize*10;
   else
      pips=ticksize;
   ntp=Take_Profit;
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
// Check for New Bar (Compatible with both MQL4 and MQL5)
   static datetime dtBarCurrent=WRONG_VALUE;
   datetime dtBarPrevious=dtBarCurrent;
   dtBarCurrent=(datetime) SeriesInfoInteger(_Symbol,_Period,SERIES_LASTBAR_DATE);
   bool NewBarFlag=(dtBarCurrent!=dtBarPrevious);
   if(OrdersTotal()==0)
      if(NewBarFlag)
        {
         if((trade()==1)||IfOrderopenBuy()==1)
            MARTINGALE_BUY();
         if((trade()==2)||IfOrderopenSell()==1)
            MARTINGALE_SELL();
        }
  }
//-----------------------------------------------------------------------------------------------------------
int trade()
//trading conditions
// -- This is where you insert coding indicators to trigger OP --*/
  {

   if(iMA(Symbol(),0,Period1,0,0,0,1)<iMA(Symbol(),0,Period2,0,0,0,1))//BUY
     {return(1);}
   else
      if(iMA(Symbol(),0,Period1,0,0,0,1)>iMA(Symbol(),0,Period2,0,0,0,1))//SELL
        {return(2);}
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| MARTINGALE_BUY                                                   |
//+------------------------------------------------------------------+
int  MARTINGALE_BUY()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderType()==OP_SELL && OrderSymbol()==Symbol() && OrderComment()==EAComment && OrderMagicNumber()== MagicNumber)
           {
            return(0);
           }
        }
     }

   int     ticket=0;
// Check for New Bar (Compatible with both MQL4 and MQL5)
   static datetime dtBarCurrent=WRONG_VALUE;
   datetime dtBarPrevious=dtBarCurrent;
   dtBarCurrent=(datetime) SeriesInfoInteger(_Symbol,_Period,SERIES_LASTBAR_DATE);
   bool NewBarFlag=(dtBarCurrent!=dtBarPrevious);
   int total=0;
   if(Bars<100)
     {
      Print("bars less than 100");
      return(0);
     }
   if(IsTradeAllowed()==false)
     {
      Print("Trade IS NOT Allowed");
      return(0);
     }
     {
      //----
      int stops_level=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL);
      int   iTrade=0;

      for(int i=OrdersTotal()-1; i>=0; i--)
        {
         if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
            Print("eror");//בודקים אם ישנה עסקה פתוחה בצמד הנוכחי
         if(OrderSymbol()==Symbol())
            total++;//סופרים סך הכל עסקאות

        }
      if(!openorderthispair(Symbol())>=1)
         // if(openorderthispair()==0)
         //if(OrdersTotal()==0)
        {
         //+------------------------------------------------------------------+
         //|                        /*-- Order Buy --*/                       |
         //+------------------------------------------------------------------+
         if(((AccountStopoutMode()==1) &&
             (AccountFreeMarginCheck(Symbol(),OP_BUY,Lotsize)>AccountStopoutLevel()))
            || ((AccountStopoutMode()==0) &&
                ((AccountEquity()/(AccountEquity()-AccountFreeMarginCheck(Symbol(),OP_BUY,Lotsize))*100)>AccountStopoutLevel())))
            if(CheckMoneyForTrade(Symbol(),LotsOptimized(Lotsize),OP_BUY))
               if(!OrderSend(Symbol(),OP_BUY,LotsOptimized(Lotsize),ND(Ask),3,NDTP(Ask-Stop_Loss*pips),NDTP(Ask+Take_Profit*pips),EAComment, MagicNumber))
                  Print("eror",GetLastError());

        }
      /* -- This is the function of Martingale . If there OP is wrong , then do martingale --*/
      if(OrdersTotal()>=1)
        {
         if(NewBarFlag)
            GoMartingalebuy();
        }
      //----
      return(0);
     }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                        MARTINGALE                                |
//+------------------------------------------------------------------+
bool GoMartingalebuy()
  {
   int      iCount      =  0;
   double   LastOP      =  0;
   double   LastLots    =  0;
   bool     LastIsBuy   =  FALSE;
   int      iTotalBuy   =  0;
   int      iTotalSell  =  0;
   double      Spread=0;

   Spread=MarketInfo(Symbol(),MODE_SPREAD);

   for(iCount=0; iCount<OrdersTotal(); iCount++)
     {

      if(!OrderSelect(iCount,SELECT_BY_POS,MODE_TRADES))
         Print("eror");

      if(OrderType()==OP_BUY && OrderSymbol()==Symbol() && OrderComment()==EAComment && OrderMagicNumber()== MagicNumber)
        {
         if(LastOP==0)
           {
            LastOP=OrderOpenPrice();
           }
         if(LastOP>OrderOpenPrice())
           {
            LastOP=OrderOpenPrice();
           }
         if(LastLots<OrderLots())
           {
            LastLots=OrderLots();
           }
         LastIsBuy=TRUE;
         iTotalBuy++;

         //When it reaches the maximum limit of OP , OP do not add anymore */

        }
     }

   /* If the Price is downtrend .... direction , check the Bid (*/
   if(LastIsBuy)
     {
      if(Bid<=LastOP-(Spread*pips)-(PipStep*pips))
        {
         if(((AccountStopoutMode()==1) &&
             (AccountFreeMarginCheck(Symbol(),OP_BUY,Lotsize)>AccountStopoutLevel()))
            || ((AccountStopoutMode()==0) &&
                ((AccountEquity()/(AccountEquity()-AccountFreeMarginCheck(Symbol(),OP_BUY,Lotsize))*100)>AccountStopoutLevel())))
            if(CheckMoneyForTrade(Symbol(),LotsOptimized(Multiply*LastLots),OP_BUY))
               if(!OrderSend(Symbol(),OP_BUY,LotsOptimized(Multiply*LastLots),ND(Ask),3,NDTP(Ask-Stop_Loss*pips),NDTP(Ask+Take_Profit*pips),EAComment, MagicNumber))
                  Print("eror",GetLastError());
         ModifyTPbuy();
         LastIsBuy=FALSE;
         return(0);
        }
     }
   return(0);
  }
//============================================================================================================================================
//+------------------------------------------------------------------+
//| MARTINGALE_SELL                                                  |
//+------------------------------------------------------------------+
int  MARTINGALE_SELL()
  {

   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderType()==OP_BUY && OrderSymbol()==Symbol() && OrderComment()==EAComment && OrderMagicNumber()== MagicNumber)
           {
            return(0);
           }
        }
     }

   int     ticket=0;
// Check for New Bar (Compatible with both MQL4 and MQL5)
   static datetime dtBarCurrent=WRONG_VALUE;
   datetime dtBarPrevious=dtBarCurrent;
   dtBarCurrent=(datetime) SeriesInfoInteger(_Symbol,_Period,SERIES_LASTBAR_DATE);
   bool NewBarFlag=(dtBarCurrent!=dtBarPrevious);
   int total=0;
   if(Bars<100)
     {
      Print("bars less than 100");
      return(0);
     }
   if(IsTradeAllowed()==false)
     {
      Print("Trade IS NOT Allowed");
      return(0);
     }
     {
      //----
      int stops_level=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL);
      int   iTrade=0;

      Comment(EAName);             // Show Name EA on screen
      /* --If no OP at all , then perform the following functions --*/
      /* -- This is where you insert coding indicators to trigger OP --*/
      for(int i=OrdersTotal()-1; i>=0; i--)
        {
         if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
            Print("eror");//בודקים אם ישנה עסקה פתוחה בצמד הנוכחי
         if(OrderSymbol()==Symbol())
            total++;//סופרים סך הכל עסקאות

        }
      if(!openorderthispair(Symbol())>=1)
         // if(openorderthispair()==0)
         // if(OrdersTotal()==0)
        {

         //+------------------------------------------------------------------+
         //|                          /*-- Order Sell --*/                    |
         //+------------------------------------------------------------------+
         if(((AccountStopoutMode()==1) &&
             (AccountFreeMarginCheck(Symbol(),OP_SELL,Lotsize)>AccountStopoutLevel()))
            || ((AccountStopoutMode()==0) &&
                ((AccountEquity()/(AccountEquity()-AccountFreeMarginCheck(Symbol(),OP_SELL,Lotsize))*100)>AccountStopoutLevel())))
            if(CheckMoneyForTrade(Symbol(),LotsOptimized(Lotsize),OP_SELL))
               if(OrdersTotal()>=0)
                  if(!OrderSend(Symbol(),OP_SELL,LotsOptimized(Lotsize),ND(Bid),3,NDTP(Bid+Stop_Loss*pips),NDTP(Bid-Take_Profit*pips),EAComment, MagicNumber))
                     Print("eror",GetLastError());

        }
      /* -- This is the function of Martingale . If there OP is wrong , then do martingale --*/
      if(OrdersTotal()>=0)
        {
         if(NewBarFlag)
            GoMartingalesell();
        }
      //----
      return(0);
     }
  }
//+------------------------------------------------------------------+
//|                        MARTINGALE                                |
//+------------------------------------------------------------------+
bool GoMartingalesell()
  {
   int      iCount      =  0;
   double   LastOP      =  0;
   double   LastLots    =  0;
   bool     LastIsBuy   =  FALSE;
   int      iTotalBuy   =  0;
   int      iTotalSell  =  0;
   double      Spread=0;

   Spread=MarketInfo(Symbol(),MODE_SPREAD);

   for(iCount=0; iCount<OrdersTotal(); iCount++)
     {

      if(!OrderSelect(iCount,SELECT_BY_POS,MODE_TRADES))
         Print("eror");

      if(OrderType()==OP_SELL && OrderSymbol()==Symbol() && OrderComment()==EAComment && OrderMagicNumber()== MagicNumber)
        {
         if(LastOP==0)
           {
            LastOP=OrderOpenPrice();
           }
         if(LastOP<OrderOpenPrice())
           {
            LastOP=OrderOpenPrice();
           }
         if(LastLots<OrderLots())
           {
            LastLots=OrderLots();
           }
         LastIsBuy=FALSE;
         iTotalSell++;

         //When it reaches the maximum limit of OP , OP do not add anymore */


        }

     }

   /* If the direction is Sell Price .... , check the value of Ask(*/
   if(!LastIsBuy)
     {

      if(Ask>=LastOP+(Spread*pips)+(PipStep*pips))

        {
         if(((AccountStopoutMode()==1) &&
             (AccountFreeMarginCheck(Symbol(),OP_SELL,Lotsize)>AccountStopoutLevel()))
            || ((AccountStopoutMode()==0) &&
                ((AccountEquity()/(AccountEquity()-AccountFreeMarginCheck(Symbol(),OP_SELL,Lotsize))*100)>AccountStopoutLevel())))
            if(CheckMoneyForTrade(Symbol(),LotsOptimized(Multiply*LastLots),OP_SELL))
               if(!OrderSend(Symbol(),OP_SELL,LotsOptimized(Multiply*LastLots),ND(Bid),3,NDTP(Bid+Stop_Loss*pips),NDTP(Bid-Take_Profit*pips),EAComment, MagicNumber))
                  Print("eror",GetLastError());

         ModifyTPsell();
         return(0);
        }
     }
   return(0);
  }
//============================================================================================================================================
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                         MODIFY TAKE PROFIT BUY                   |
//+------------------------------------------------------------------+
/*-- ModifyTP function is to change all that OP TP at the same point --*/
void ModifyTPbuy()
  {
   int      iCount=0;
   double   NewTP=0;

   /*- Take Take Profit of the last Order -*/
   for(iCount=0; iCount<OrdersTotal(); iCount++)
     {
      if(!OrderSelect(iCount,SELECT_BY_POS,MODE_TRADES))
         Print("eror");

      /*-- If it is OP - BUY , TP take the smallest value . Make TP together --*/
      if(OrderType()==OP_BUY && OrderSymbol()==Symbol() && OrderComment()==EAComment && OrderMagicNumber()== MagicNumber)
        {
         if(NewTP==0)
           {
            NewTP=OrderTakeProfit();
           }
         if(NewTP>OrderTakeProfit())
           {
            NewTP=OrderTakeProfit();
           }
        }
     }

   /*- Change all values ​​TakeProfit with the new OP ( 2X ) -*/
   for(iCount=0; iCount<OrdersTotal(); iCount++)
     {
      if(!OrderSelect(iCount,SELECT_BY_POS,MODE_TRADES))
         Print("eror");

      /*-If all OP is BUY , change their TP -*/
      if(OrderType()==OP_BUY && OrderSymbol()==Symbol() && OrderComment()==EAComment && OrderMagicNumber()== MagicNumber)
        {
         RefreshRates();
         //stoploss=Bid-(pips*TrailingStop);
         double StopLevel=MarketInfo(Symbol(),MODE_STOPLEVEL)+MarketInfo(Symbol(),MODE_SPREAD);
         if(NewTP<StopLevel*pips)
            stoploss=StopLevel*pips;
         string symbol=OrderSymbol();
         double point=SymbolInfoDouble(symbol,SYMBOL_POINT);
         if(MathAbs(OrderTakeProfit()-NewTP)>point)
            if((NewTP-Ask)>(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_FREEZE_LEVEL)*pips)
               if(OrderModifyCheck(OrderTicket(),OrderOpenPrice(),0,NewTP))
                  if(!OrderModify(OrderTicket(),OrderLots(),0,NewTP,0))
                     Print("eror");
        }
     }
  }
//====================================================================================================================================
//+------------------------------------------------------------------+
//|                         MODIFY TAKE PROFIT   SELL                |
//+------------------------------------------------------------------+
/*-- ModifyTP function is to change all that OP TP at the same point --*/
void ModifyTPsell()
  {
   int      iCount=0;
   double   NewTP=0;

   /*- Take Take Profit of the last Order -*/
   for(iCount=0; iCount<OrdersTotal(); iCount++)
     {
      if(!OrderSelect(iCount,SELECT_BY_POS,MODE_TRADES))
         Print("eror");

      /*-- If it is OP - SELL , TP take the greatest value . Make TP together --*/
      if(OrderType()==OP_SELL && OrderSymbol()==Symbol() && OrderComment()==EAComment && OrderMagicNumber()== MagicNumber)
        {
         if(NewTP==0)
           {
            NewTP=OrderTakeProfit();
           }
         if(NewTP<OrderTakeProfit())
           {
            NewTP=OrderTakeProfit();
           }
        }
     }

   /*- Change all values ​​TakeProfit with the new OP ( 2X ) -*/
   for(iCount=0; iCount<OrdersTotal(); iCount++)
     {
      if(!OrderSelect(iCount,SELECT_BY_POS,MODE_TRADES))
         Print("eror");

      /*- If all OP is SELL , then change their TP -*/
      if(OrderType()==OP_SELL && OrderSymbol()==Symbol() && OrderComment()==EAComment && OrderMagicNumber()== MagicNumber)
        {

         RefreshRates();
         // stoploss=Ask+(pips*TrailingStop);
         double  StopLevel=MarketInfo(Symbol(),MODE_STOPLEVEL)+MarketInfo(Symbol(),MODE_SPREAD);
         if(NewTP<StopLevel*pips)
            stoploss=StopLevel*pips;
         string symbol=OrderSymbol();
         double point=SymbolInfoDouble(symbol,SYMBOL_POINT);
         if(MathAbs(OrderTakeProfit()-NewTP)>point)
            if((Bid-NewTP)>(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_FREEZE_LEVEL)*pips)
               if(OrderModifyCheck(OrderTicket(),OrderOpenPrice(),0,NewTP))
                  if(!OrderModify(OrderTicket(),OrderLots(),0,NewTP,0))
                     Print("eror");
        }
     }
  }
//====================================================================================================================================
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Calculate optimal lot size buy                                   |
//+------------------------------------------------------------------+
double LotsOptimized(double lot)
  {
   int    orders=OrdersHistoryTotal();     // history orders total
//--- minimal allowed volume for trade operations
   double minlot=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN);
   if(lot<minlot)
     {
      lot=minlot;
      Print("Volume is less than the minimal allowed ,we use",minlot);
     }
//--- maximal allowed volume of trade operations
   double maxlot=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX);
   if(lot>maxlot)
     {
      lot=maxlot;
      Print("Volume is greater than the maximal allowed,we use",maxlot);
     }
//--- get minimal step of volume changing
   double volume_step=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_STEP);
   int ratio=(int)MathRound(lot/volume_step);
   if(MathAbs(ratio*volume_step-lot)>0.0000001)
     {
      lot=ratio*volume_step;

      Print("Volume is not a multiple of the minimal step ,we use the closest correct volume ",ratio*volume_step);
     }
   return(ND(lot));
  }
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
double NDTP(double val)
  {
   RefreshRates();
   double FREEZELEVEL=MarketInfo(Symbol(),MODE_FREEZELEVEL);
   double SPREAD=MarketInfo(Symbol(),MODE_SPREAD);
   double StopLevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
   if(val<StopLevel*SetPoint+SPREAD*SetPoint+FREEZELEVEL*SetPoint)
      val=StopLevel*SetPoint+SPREAD*SetPoint+FREEZELEVEL*SetPoint;
   return(NormalizeDouble(val, Digits));
  }
//+------------------------------------------------------------------+
bool CheckMoneyForTrade(string symb,double lots,int type)
  {
   double free_margin=AccountFreeMarginCheck(symb,type,lots);
   if(free_margin<0)
     {
      string oper=(type==OP_BUY)? "Buy":"Sell";
      Print("Not enough money for ",oper," ",lots," ",symb," Error code=",GetLastError());
      return(false);
     }
//--- checking successful
   return(true);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double ND(double val)
  {
   return(NormalizeDouble(val, Digits));
  }
//+------------------------------------------------------------------+
//|                                      exitbuys()                  |
//+------------------------------------------------------------------+
void exitbuys()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderType()==OP_BUY && OrderSymbol()==Symbol() && OrderComment()==EAComment && OrderMagicNumber()==MagicNumber)
           {
            result=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,clrNONE);
            if(result!=true)//if it did not close
              {
               err=GetLastError();
               Print("LastError = ",err);//get the reason why it didn't close
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
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {

         if(OrderType()==OP_SELL && OrderSymbol()==Symbol() && OrderComment()==EAComment && OrderMagicNumber()==MagicNumber)
           {
            result=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),3,clrNONE);
            if(result!=true)//if it did not close
              {
               err=GetLastError();
               Print("LastError = ",err);//get the reason why it didn't close
              }

           }
        }

     }
  }
//+------------------------------------------------------------------+
//+---------------------------------------------------------------------------+
//               בדיקה אם יש עסקאות פתוחות בצמד הנוכחי
//+---------------------------------------------------------------------------+
int openorderthispair(string pair)//בוחרים עסקה בצמד המטבעות הנוכחי
  {
   int total=0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(! OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         Print("eror");//בודקים אם ישנה עסקה פתוחה בצמד הנוכחי
      if(OrderSymbol()==pair)
         total++;//סופרים סך הכל עסקאות
     }
   return(total);
  }
//-----------------------------------------------------------------------------------------------------------
//              IfOrderDoesNotExistBuy
//+---------------------------------------------------------------------------+
bool IfOrderDoesNotExistBuy()
  {
   bool exists=false;
   for(int i=OrdersTotal(); i>=0; i--)
     {

      if(OrderSelect(i,SELECT_BY_POS)==true && OrderSymbol()==Symbol())
        {
         exists = true;
         return(exists);
        }
      else
        {
         Print("OrderSelect() error - ",(GetLastError()));
        }
     }

   return(0);
  }
//-----------------------------------------------------------------------------------------------------------
//+---------------------------------------------------------------------------+
//          CHECK    Open Buy
//+---------------------------------------------------------------------------+
bool IfOrderopenBuy()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderType()==OP_BUY && OrderSymbol()==Symbol() && OrderComment()==EAComment && OrderMagicNumber()==MagicNumber)
           {
            return(1);
           }
        }
     }
   return(0);
  }
//-----------------------------------------------------------------------------------------------------------
//+---------------------------------------------------------------------------+
//           CHECK   Open Sell
//+---------------------------------------------------------------------------+
bool IfOrderopenSell()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderType()==OP_SELL && OrderSymbol()==Symbol() && OrderComment()==EAComment && OrderMagicNumber()==MagicNumber)
           {
            return(1);
           }
        }
     }
   return(0);
  }
//-----------------------------------------------------------------------------------------------------------
