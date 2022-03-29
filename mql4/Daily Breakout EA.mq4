//+------------------------------------------------------------------+
//|                                            Daily Breakout EA.mq4 |
//|                                Copyright 2022, Dr Yousuf Mesalm. |
//|                                    https://www.youssefmesalm.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Dr Yousuf Mesalm."
#property link      "https://www.youssefmesalm.com"
#property version   "1.00"
#property strict

#include  <MQL_Easy\Execute\Execute.mqh>
#include  <MQL_Easy\Position\Position.mqh>
#include  <MQL_Easy\Order\Order.mqh>
#include <Indicators\TimeSeries.mqh>


input string    Time_SetUP = "------< Time_SetUP >------";
input string   Session1Start="12:00";
input string   Session1End="14:00";
input int Session1MinRange=1;
input int Session1MaxRange=100;
input string   Session2Start="12:00";
input string   Session2End="14:00";
input int Session2MinRange=1;
input int Session2MaxRange=100;
input int TradeBuffer=3;
input double FixedLot=0.01;
input int VariableLot=1;
input int TakeProfit=2;
input bool CancelOppoiste=true;
input string TradeEndTime="12:00";
input long MagicNumber=2020;

//varaibles
double UpperBand,LowerBand;
bool F1=false,F2=false;
datetime st1,st2;
double Lot,NewLot;
bool TradeAllow=true;
int Buffer;
//Objects
CUtilities tools;
CExecute trade(Symbol(),MagicNumber);
CiHigh H;
CiLow L;
CPosition Pos(Symbol(),MagicNumber,GROUP_POSITIONS_ALL);
COrder order(Symbol(),MagicNumber,GROUP_ORDERS_ALL);;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   H.Create(Symbol(),PERIOD_CURRENT);
   L.Create(Symbol(),PERIOD_CURRENT);

   if(Session1MaxRange<1|| Session2MaxRange<1)
      Alert("Sessinon Max should be greater than 0");

   Buffer=-TradeBuffer==0?1:TradeBuffer;
   if(FixedLot==0&&VariableLot==0)
      TradeAllow=false;
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

   bool s1=sTimeFilter(Session1Start,Session1End,Session1MaxRange,Session1MinRange,F1);
   bool s2=sTimeFilter(Session2Start,Session2End,Session2MaxRange,Session2MinRange,F2);
   if(s2&&!F2&&!F1&& TradeAllow)
     {
      
      if(FixedLot==0)
        {
         double RiP=(UpperBand-LowerBand)/tools.Pip();
         NewLot=(((AccountInfoDouble(ACCOUNT_BALANCE)*VariableLot)/RiP)/10)/2;
        }
      else
         NewLot=FixedLot;
      double BuyPrice=UpperBand+Buffer*tools.Pip();
      trade.Order(TYPE_ORDER_BUYSTOP,NewLot,BuyPrice,LowerBand,BuyPrice+((BuyPrice-LowerBand)*TakeProfit),SLTP_PRICE,0,30);
      double SellPrice=LowerBand-Buffer*tools.Pip();
      trade.Order(TYPE_ORDER_SELLSTOP,NewLot,SellPrice,UpperBand,SellPrice-((UpperBand-SellPrice)*TakeProfit),SLTP_PRICE,0,30);
     }
   if(TradeEndTime!=""&&TimeFilter(TradeEndTime))
     {
      Pos.GroupCloseAll(30);
      order.GroupCloseAll(20);
      
     }
   if(CancelOppoiste&&Pos.GroupTotal()>0)
     {
     
      order.GroupCloseAll(20);
     }

  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool sTimeFilter(string inStart,string inEnd,int SMax,int SMin,bool & F,string inString=":")
  {
   bool Result=false;
   int TimeHourStart,TimeMinuteStart,TimeHourEnd,TimeMinuteEnd;
   static datetime TimeStarts,TimeEnd;
//---
   sInputTimeConvert(TimeHourStart,TimeMinuteStart,inStart,inString);
   sInputTimeConvert(TimeHourEnd,TimeMinuteEnd,inEnd,inString);
   TimeStarts=StringToTime(IntegerToString(TimeHourStart)+":"+IntegerToString(TimeMinuteStart));
   TimeEnd=StringToTime(IntegerToString(TimeHourEnd)+":"+IntegerToString(TimeMinuteEnd));
//---
   if(Time[0]==TimeEnd)
     {


      int startidx=iBarShift(Symbol(),PERIOD_CURRENT,TimeStarts);

      UpperBand=High[iHighest(Symbol(),PERIOD_CURRENT,MODE_HIGH,startidx+1,0)];
      LowerBand=Low[iLowest(Symbol(),PERIOD_CURRENT,MODE_LOW,startidx+1,0)];
      Print(UpperBand," ",LowerBand);
      Print(UpperBand-LowerBand);
      Print(startidx);
      if(UpperBand-LowerBand>SMax*tools.Pip())
        {
         F=true;
         Print(1);
        }
      else
        {F=false;}
      if(UpperBand-LowerBand<SMin*tools.Pip())
        {
         F=true;
         
        }
      else
        {F=false;}
      Result= true;
     }

//---
   return(Result);
  }
//+------------------------------------------------------------------+
//| sInputTimeConvert                                                |
//+------------------------------------------------------------------+
int sInputTimeConvert(int &inHour,int &inMinute,string inInput,string inString=":")
  {
   int PS;
//---
   PS=StringFind(inInput,inString,0);
   inMinute=(int)StringToDouble(StringSubstr(inInput,PS+1,StringLen(inInput)-PS));
   inHour=(int)StringToDouble(StringSubstr(inInput,0,PS));
//---
   return(PS);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Time Filter                                                                 |
//+------------------------------------------------------------------+
bool TimeFilter(string ET)
  {

   datetime End   =StrToTime(TimeToStr(TimeCurrent(),TIME_DATE)+" "+ET);

   if((Time[0]<=End))
     {
      return(false);
     }
   return(true);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseAllOrders()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if(OrderType() == OP_BUY || OrderType() == OP_SELL)
           {
            OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,Red);
           }
         else
           {
            OrderDelete(OrderTicket());
           }
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DeletePending()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if(OrderType() == OP_BUYSTOP || OrderType() == OP_SELLSTOP)
           {
            OrderDelete(OrderTicket());
            
           }

        }
     }
  }
//+------------------------------------------------------------------+
