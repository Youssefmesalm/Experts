//+------------------------------------------------------------------+
//|                                                        Waves.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include  <MQL_Easy\Execute\Execute.mqh>
#include  <MQL_Easy\Position\Position.mqh>
#include <Arrays\ArrayDouble.mqh>
#include <Arrays\ArrayString.mqh>
#include <Arrays\ArrayObj.mqh>
#include <ChartObjects\ChartObjectsLines.mqh>

extern string    General_Settings             = "------< General_Settings >------";
input  double    Lots_1                       = 0.1;
input  double    Lots_2                       = 0.2;
input  double    Lots_3                       = 0.3;
input  double    Lots_4                       = 0.4;
input  double    Lots_5                       = 0.5;
input  double    Lots_6                       = 0.6;
input  double    Lots_7                       = 0.7;
input  double    Lots_8                       = 0.8;

input  double       TakeProfit                   = 0;
input  double       StopLoss                     = 0;
input  long       MagicNumber                  = 789;
input bool use_close_Average_TPSL=false;
input int                                  closeTP_buy_in_pips_eachpair=50;
input int                                  closeTP_sell_in_pips_eachpair=50;
input int                                  closeSL_buy_in_pips_eachpair=-50;
input int                                  closeSL_sell_in_pips_eachpair=-50;
sinput string set1 = "<-------------- Currency Pairs Settings-------------->";
input string Suffix="";
input string Perfix="";
input string CustomPairs = "EURUSD,USDCHF,USDCAD,USDJPY,GBPUSD";
input int MAX_Pair_Number =5;
sinput string set2 = "<----------------Trading Settings-------------------->";
input  int       Dis_Level_2_3                = 10;
input  int       Dis_Level_3_4                = 10;
input  int       Dis_Level_4_5                = 10;
input  int       Dis_Level_5_6                = 10;
input  int       Dis_Level_6_7                = 10;
input  int       Dis_Level_7_8                = 10;
input  int       Dis_Level_8_9                = 10;
input  int       Dis_Level_9_10               = 10;
extern string    Trailing_SetUP               = "------< Trailing_SetUP >------";
extern bool      Use_Trailing                 = false;
extern int       TrailingStop                 = 50;
extern int       TrailingStep                 = 20;
input string    Time_SetUP = "------< Time_SetUP >------";
input bool UseTimeFilter=false;
input string   TimeStart="12:00";
input string   TimeStop="14:00";
extern string       Trade_Day_SetUP                    = "------< Trade_Day_SetUP >------";
extern bool         Trade_sunday                       = true;
extern bool         Trade_monday                       = true;
extern bool         Trade_tuseday                      = true;
extern bool         Trade_wednisday                    = true;
extern bool         Trade_Thursday                     = true;
extern bool         Trade_friday                       = true;

double TrailingProfit =0;
datetime Lasttradetime =0;
double sl, tp;
int pt;
int x=0;
int y=0;
// Arrays
string Symbols[];
bool fristWave[];
// Class object
CExecute *trades[];
CPosition *Positions[];
CPosition *SellPositions[];
CPosition *BuyPositions[];
CUtilities *tools[];
CArrayString *MaxPair=new CArrayString;
CChartObjectHLine HLine;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

   StringSplit(CustomPairs, StringGetCharacter(",", 0), Symbols);
   int size= ArraySize(Symbols);
   ArrayResize(trades,size,size);
   ArrayResize(Positions,size,size);
   ArrayResize(SellPositions,size,size);
   ArrayResize(BuyPositions,size,size);
   ArrayResize(fristWave,size,size);
   ArrayResize(tools,size,size);//---
   for(int i=0; i<size; i++)
     {
      Symbols[i]=Perfix+Symbols[i]+Suffix;
      if(SymbolSelect(Symbols[i],true))
        {
         Print(Symbols[i]+" added to Market watch");
        }
      else
        {
         Print(Symbols[i]+" does't Exist");
        }

      trades[i] = new CExecute(Symbols[i], MagicNumber);
      BuyPositions[i] = new CPosition(Symbols[i], MagicNumber, GROUP_POSITIONS_BUYS);
      SellPositions[i] = new CPosition(Symbols[i], MagicNumber, GROUP_POSITIONS_SELLS);
      Positions[i] = new CPosition(Symbols[i], MagicNumber, GROUP_POSITIONS_ALL);
      tools[i] = new CUtilities(Symbols[i]) ;
      fristWave[i]=false;
     }

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   int size= ArraySize(Symbols);
   for(int i=0; i<size; i++)
     {
      delete(trades[i]);
      delete(BuyPositions[i]);
      delete(SellPositions[i]);
      delete(Positions[i]);
      delete(tools[i]);
     }
  }
//+-----|-------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   bool TradeAlow=(sTimeFilter(TimeStart,TimeStop)&&UseTimeFilter)||!UseTimeFilter;
   double profit = 0;
   double points = 0;

   int total=ArraySize(Symbols);
   for(int i=0; i<total; i++)
     {

      if(Positions[i].GroupTotal()==0)
        {
         if(MaxPair.Search(Symbols[i])!=-1)
           {
            int idx=MaxPair.Search(Symbols[i]);
            MaxPair.Delete(idx);
           }
        }
      MaxPair.Sort();
      if(day_trade()==true&&TradeAlow==true)
        {
         if(MaxPair.Total()<MAX_Pair_Number||(MaxPair.Search(symbols[i])!=-1&&MaxPair.Total()==MAX_Pair_Number))
           {
            double Wave_1_up  = iCustom(Symbols[i],0,"Market Maker Map Shades",19,0);
            double Wave_1_dn  = iCustom(Symbols[i],0,"Market Maker Map Shades",18,0);
            double Wave_2_up  = iCustom(Symbols[i],0,"Market Maker Map Shades",17,0);
            double Wave_2_dn  = iCustom(Symbols[i],0,"Market Maker Map Shades",16,0);
            double Wave_3_up  = iCustom(Symbols[i],0,"Market Maker Map Shades",15,0);
            double Wave_3_dn  = iCustom(Symbols[i],0,"Market Maker Map Shades",14,0);
            double Wave_4_up  = iCustom(Symbols[i],0,"Market Maker Map Shades",13,0);
            double Wave_4_dn  = iCustom(Symbols[i],0,"Market Maker Map Shades",12,0);
            double Wave_5_up  = iCustom(Symbols[i],0,"Market Maker Map Shades",11,0);
            double Wave_5_dn  = iCustom(Symbols[i],0,"Market Maker Map Shades",10,0);
            double Wave_6_up  = iCustom(Symbols[i],0,"Market Maker Map Shades",9,0);
            double Wave_6_dn  = iCustom(Symbols[i],0,"Market Maker Map Shades",8,0);
            double Wave_7_up  = iCustom(Symbols[i],0,"Market Maker Map Shades",7,0);
            double Wave_7_dn  = iCustom(Symbols[i],0,"Market Maker Map Shades",6,0);
            double Wave_8_up  = iCustom(Symbols[i],0,"Market Maker Map Shades",5,0);
            double Wave_8_dn  = iCustom(Symbols[i],0,"Market Maker Map Shades",4,0);
            double Wave_9_up  = iCustom(Symbols[i],0,"Market Maker Map Shades",3,0);
            double Wave_9_dn  = iCustom(Symbols[i],0,"Market Maker Map Shades",2,0);
            double Wave_10_up  = iCustom(Symbols[i],0,"Market Maker Map Shades",1,0);
            double Wave_10_dn  = iCustom(Symbols[i],0,"Market Maker Map Shades",0,0);
            if(tools[i].Bid()<Wave_1_up&&tools[i].Bid()>Wave_1_dn&&!fristWave[i])
              {
               fristWave[i]=true;
              }
            if(fristWave[i]&&tools[i].Bid()>=Wave_3_up&&count(Symbols[i],"Level_3_up")==0)
              {
               trades[i].Position(TYPE_POSITION_SELL,Lots_1,StopLoss,TakeProfit,SLTP_PIPS,30,"Level_3_up");
               fristWave[i]=false;
              }
               if(tools[i].Bid()>=Wave_4_up&&count(Symbols[i],"Level_4_up")==0)
              {
               trades[i].Position(TYPE_POSITION_SELL,Lots_2,StopLoss,TakeProfit,SLTP_PIPS,30,"Level_4_up");
              }
               if(tools[i].Bid()>=Wave_5_up&&count(Symbols[i],"Level_5_up")==0)
              {
               trades[i].Position(TYPE_POSITION_SELL,Lots_3,StopLoss,TakeProfit,SLTP_PIPS,30,"Level_5_up");
              }
               if(tools[i].Bid()>=Wave_6_up&&count(Symbols[i],"Level_6_up")==0)
              {
               trades[i].Position(TYPE_POSITION_SELL,Lots_4,StopLoss,TakeProfit,SLTP_PIPS,30,"Level_6_up");
              }
               if(tools[i].Bid()>=Wave_7_up&&count(Symbols[i],"Level_7_up")==0)
              {
               trades[i].Position(TYPE_POSITION_SELL,Lots_5,StopLoss,TakeProfit,SLTP_PIPS,30,"Level_7_up");
              }
               if(tools[i].Bid()>=Wave_8_up&&count(Symbols[i],"Level_8_up")==0)
              {
               trades[i].Position(TYPE_POSITION_SELL,Lots_6,StopLoss,TakeProfit,SLTP_PIPS,30,"Level_8_up");
              }
               if(tools[i].Bid()>=Wave_9_up&&count(Symbols[i],"Level_9_up")==0)
              {
               trades[i].Position(TYPE_POSITION_SELL,Lots_7,StopLoss,TakeProfit,SLTP_PIPS,30,"Level_9_up");
              }
               if(tools[i].Bid()>=Wave_10_up&&count(Symbols[i],"Level_10_up")==0)
              {
               trades[i].Position(TYPE_POSITION_SELL,Lots_8,StopLoss,TakeProfit,SLTP_PIPS,30,"Level_10_up");
              }
              if(fristWave[i]&&tools[i].Bid()<=Wave_3_dn&&count(Symbols[i],"Level_3_dn")==0)
              {
               trades[i].Position(TYPE_POSITION_BUY,Lots_1,StopLoss,TakeProfit,SLTP_PIPS,30,"Level_3_dn");
               fristWave[i]=false;
              }
               if(tools[i].Bid()<=Wave_4_dn&&count(Symbols[i],"Level_4_dn")==0)
              {
               trades[i].Position(TYPE_POSITION_BUY,Lots_2,StopLoss,TakeProfit,SLTP_PIPS,30,"Level_4_dn");
              }
                if(tools[i].Bid()<=Wave_5_dn&&count(Symbols[i],"Level_5_dn")==0)
              {
               trades[i].Position(TYPE_POSITION_BUY,Lots_3,StopLoss,TakeProfit,SLTP_PIPS,30,"Level_5_dn");
              }
                if(tools[i].Bid()<=Wave_6_dn&&count(Symbols[i],"Level_6_dn")==0)
              {
               trades[i].Position(TYPE_POSITION_BUY,Lots_4,StopLoss,TakeProfit,SLTP_PIPS,30,"Level_6_dn");
              }
                if(tools[i].Bid()<=Wave_7_dn&&count(Symbols[i],"Level_7_dn")==0)
              {
               trades[i].Position(TYPE_POSITION_BUY,Lots_5,StopLoss,TakeProfit,SLTP_PIPS,30,"Level_7_dn");
              }
                if(tools[i].Bid()<=Wave_8_dn&&count(Symbols[i],"Level_8_dn")==0)
              {
               trades[i].Position(TYPE_POSITION_BUY,Lots_6,StopLoss,TakeProfit,SLTP_PIPS,30,"Level_8_dn");
              }
                if(tools[i].Bid()<=Wave_9_dn&&count(Symbols[i],"Level_9_dn")==0)
              {
               trades[i].Position(TYPE_POSITION_BUY,Lots_7,StopLoss,TakeProfit,SLTP_PIPS,30,"Level_9_dn");
              }
                if(tools[i].Bid()<=Wave_10_dn&&count(Symbols[i],"Level_10_dn")==0)
              {
               trades[i].Position(TYPE_POSITION_BUY,Lots_8,StopLoss,TakeProfit,SLTP_PIPS,30,"Level_10_dn");
              }
                
           }
        }
      averageTpSl(Positions[i],BuyPositions[i],SellPositions[i],tools[i],symbols[i],BSL[i],BTP[i],SSL[i],STP[i]);

      profit+=Positions[i].GroupTotalProfit();
      //ClosingEachSymbol(Positions[i],BuyPositions[i],SellPositions[i],tools[i],points);
     }

//ClosingAccount(profit);
  }
////+------------------------------------------------------------------+
////|   Body                                                               |
////+------------------------------------------------------------------+
//void EABody()
//  {
//   string sep=",";
//   ushort u_sep;
//   string result[];
//   u_sep=StringGetCharacter(sep,0);
//   int k=StringSplit(Symbols_Names,u_sep,result);
//   if(k>0)
//     {
//      for(int i=0; i<k; i++)
//        {
//         if(countSymbol(result[i])<Symbols_Numbers)
//           {
//
//            if(Close[0]<=Wave_19-Dis_Level_2_3*pt*Point)
//              {
//               if(Close[0]<Wave_17 && Close[0]>Wave_15 && Wave_17!=EMPTY_VALUE && count(result[i],"BuyLevel3")==0)
//                 {
//                  HiddenClose(result[i],Wave_19);
//                  OpenBuy(result[i],Lots_1,"BuyLevel3");
//                 }
//              }
//            if(Close[0]>=Wave_20+Dis_Level_2_3*pt*Point)
//              {
//               if(Close[0]>Wave_18 && Close[0]<Wave_16 &&  Wave_18!=EMPTY_VALUE && count(result[i],"SellLevel3")==0)
//                 {
//                  HiddenClose(result[i],Wave_20);
//                  OpenSell(result[i],Lots_1,"SellLevel3");
//                 }
//              }
//
//            if(Close[0]<=Wave_17-Dis_Level_3_4*pt*Point)
//              {
//               if(Close[0]<Wave_15  &&Close[0]>Wave_13 && Wave_15!=EMPTY_VALUE  && count(result[i],"BuyLevel4")==0)
//                 {
//                  HiddenClose(result[i],Wave_17);
//                  OpenBuy(result[i],Lots_2,"BuyLevel4");
//                 }
//              }
//            if(Close[0]>=Wave_18+Dis_Level_3_4*pt*Point)
//              {
//               if(Close[0]>Wave_16 && Close[0]<Wave_14 && Wave_16!=EMPTY_VALUE && count(result[i],"SellLevel4")==0)
//                 {
//                  HiddenClose(result[i],Wave_18);
//                  OpenSell(result[i],Lots_2,"SellLevel4");
//                 }
//              }
//
//            if(Close[0]<=Wave_15-Dis_Level_4_5*pt*Point)
//              {
//               if(Close[0]<Wave_13 &&Close[0]>Wave_11 && Wave_13!=EMPTY_VALUE && count(result[i],"BuyLevel5")==0)
//                 {
//                  HiddenClose(result[i],Wave_15);
//                  OpenBuy(result[i],Lots_3,"BuyLevel5");
//                 }
//              }
//            if(Close[0]>=Wave_16+Dis_Level_4_5*pt*Point)
//              {
//               if(Close[0]>Wave_14 &&Close[0]<Wave_12 && Wave_14!=EMPTY_VALUE && count(result[i],"SellLevel5")==0)
//                 {
//                  HiddenClose(result[i],Wave_16);
//                  OpenSell(result[i],Lots_3,"SellLevel5");
//                 }
//              }
//            if(Close[0]<=Wave_13-Dis_Level_4_5*pt*Point)
//              {
//               if(Close[0]<Wave_11 && Close[0]>Wave_9 && Wave_11!=EMPTY_VALUE && count(result[i],"BuyLevel6")==0)
//                 {
//                  HiddenClose(result[i],Wave_13);
//                  OpenBuy(result[i],Lots_4,"BuyLevel6");
//                 }
//              }
//            if(Close[0]>=Wave_14+Dis_Level_4_5*pt*Point)
//              {
//               if(Close[0]>Wave_12 && Close[0]<Wave_10 && Wave_12!=EMPTY_VALUE && count(result[i],"SellLevel6")==0)
//                 {
//                  HiddenClose(result[i],Wave_14);
//                  OpenSell(result[i],Lots_4,"SellLevel6");
//                 }
//              }
//            if(Close[0]<=Wave_11-Dis_Level_5_6*pt*Point)
//              {
//               if(Close[0]<Wave_9 && Close[0]>Wave_7 && Wave_9!=EMPTY_VALUE && count(result[i],"BuyLevel7")==0)
//                 {
//                  HiddenClose(result[i],Wave_11);
//                  OpenBuy(result[i],Lots_5,"BuyLevel7");
//                 }
//              }
//            if(Close[0]>=Wave_12+Dis_Level_5_6*pt*Point)
//              {
//               if(Close[0]>Wave_10 && Close[0]<Wave_8 && Wave_10!=EMPTY_VALUE && count(result[i],"SellLevel7")==0)
//                 {
//                  HiddenClose(result[i],Wave_12);
//                  OpenSell(result[i],Lots_5,"SellLevel7");
//                 }
//              }
//
//            if(Close[0]<=Wave_9- Dis_Level_6_7*pt*Point)
//              {
//               if(Close[0]<Wave_7 &&Close[0]>Wave_5 && Wave_7!=EMPTY_VALUE && count(result[i],"BuyLevel8")==0)
//                 {
//                  HiddenClose(result[i],Wave_9);
//                  OpenBuy(result[i],Lots_6,"BuyLevel8");
//                 }
//              }
//            if(Close[0]>=Wave_10+Dis_Level_6_7*pt*Point)
//              {
//               if(Close[0]>Wave_8 &&Close[0]<Wave_6 && Wave_8!=EMPTY_VALUE && count(result[i],"SellLevel8")==0)
//                 {
//                  HiddenClose(result[i],Wave_10);
//                  OpenSell(result[i],Lots_6,"SellLevel8");
//                 }
//              }
//
//            if(Close[0]<=Wave_7-Dis_Level_7_8*pt*Point)
//              {
//               if(Close[0]<Wave_5 && Close[0]>Wave_3 && Wave_5!=EMPTY_VALUE && count(result[i],"BuyLevel9")==0)
//                 {
//                  HiddenClose(result[i],Wave_7);
//                  OpenBuy(result[i],Lots_7,"BuyLevel9");
//                 }
//              }
//            if(Close[0]>=Wave_8+Dis_Level_7_8*pt*Point)
//              {
//               if(Close[0]>Wave_6 && Close[0]<Wave_4 && Wave_6!=EMPTY_VALUE && count(result[i],"SellLevel9")==0)
//                 {
//                  HiddenClose(result[i],Wave_8);
//                  OpenSell(result[i],Lots_7,"SellLevel9");
//                 }
//              }
//            if(Close[0]<=Wave_5-Dis_Level_8_9*pt*Point)
//              {
//               if(Close[0]<Wave_3 && Close[0]>Wave_1 && Wave_3!=EMPTY_VALUE && count(result[i],"BuyLevel10")==0)
//                 {
//                  HiddenClose(result[i],Wave_5);
//                  OpenBuy(result[i],Lots_8,"BuyLevel10");
//                 }
//              }
//            if(Close[0]>=Wave_6+Dis_Level_8_9*pt*Point)
//              {
//               if(Close[0]>Wave_4 &&Close[0]<Wave_2 && Wave_4!=EMPTY_VALUE && count(result[i],"SellLevel10")==0)
//                 {
//                  HiddenClose(result[i],Wave_6);
//                  OpenSell(result[i],Lots_8,"SellLevel10");
//                 }
//              }
//            if(Close[0]<=Wave_3-Dis_Level_9_10*pt*Point)
//              {
//               if(Close[0]<Wave_1 && Wave_1!=EMPTY_VALUE && count(result[i],"BuyLevel11")==0)
//                 {
//                  HiddenClose(result[i],Wave_3);
//                  OpenBuy(result[i],Lots_9,"BuyLevel11");
//                 }
//              }
//            if(Close[0]>=Wave_4+Dis_Level_9_10*pt*Point)
//              {
//               if(Close[0]>Wave_2 && Wave_2!=EMPTY_VALUE && count(result[i],"SellLevel11")==0)
//                 {
//                  HiddenClose(result[i],Wave_4);
//                  OpenSell(result[i],Lots_9,"SellLevel11");
//                 }
//              }
//           }
//        }
//     }
//  }

//+------------------------------------------------------------------+
//|   Count of orders                                                               |
//+------------------------------------------------------------------+
int count(string symbol,string comment)
  {
   int count =0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         GetLastError();
        }
      if(OrderSymbol()==symbol&& OrderMagicNumber()== MagicNumber)
        {
         if(OrderComment()==comment)
           {
            count++;
           }
        }
     }
   return(count);
  }
//+------------------------------------------------------------------+
//|   Trailing stop                                                               |
//+------------------------------------------------------------------+
void TrailingStopp(string sym)
  {
   for(int i=OrdersTotal()-1; i >= 0; i--)
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
         if(OrderSymbol() == sym && OrderMagicNumber() == MagicNumber)
           {
            double takeprofit = OrderTakeProfit();

            if(OrderType() == OP_BUY && iClose(sym,0,0) - OrderOpenPrice() > TrailingStop*pt*MarketInfo(sym,MODE_POINT))
              {
               if((OrderStopLoss() < iClose(sym,0,0)-(TrailingStop+TrailingStep)*pt*MarketInfo(sym,MODE_POINT)) || (OrderStopLoss()==0))
                 {
                  if(TrailingProfit != 0)
                     takeprofit = iClose(sym,0,0)+(TrailingProfit + TrailingStop)*pt*MarketInfo(sym,MODE_POINT);
                  bool ret1 = OrderModify(OrderTicket(), OrderOpenPrice(), iClose(sym,0,0)-TrailingStop*pt*MarketInfo(sym,MODE_POINT), takeprofit,0, White);
                  if(ret1 == false)
                     Print(" OrderModify() error - , ErrorDescription: ",(GetLastError()));
                 }
              }
            if(OrderType() == OP_SELL && OrderOpenPrice() - iClose(sym,0,0) > TrailingStop*pt*MarketInfo(sym,MODE_POINT))
              {
               if((OrderStopLoss() > iClose(sym,0,0)+(TrailingStop+TrailingStep)*pt*MarketInfo(sym,MODE_POINT)) || (OrderStopLoss()==0))
                 {
                  if(TrailingProfit != 0)
                     takeprofit = iClose(sym,0,0)-(TrailingProfit + TrailingStop)*pt*MarketInfo(sym,MODE_POINT);
                  bool ret2 = OrderModify(OrderTicket(), OrderOpenPrice(),iClose(sym,0,0)+TrailingStop*pt*MarketInfo(sym,MODE_POINT), takeprofit, 0, White);
                  if(ret2 == false)
                     Print("OrderModify() error - , ErrorDescription: ",(GetLastError()));
                 }
              }
           }
        }
      else
         Print("OrderSelect() error - , ErrorDescription: ",(GetLastError()));
  }
//+------------------------------------------------------------------+
//| Time Filter                                                                 |
//+------------------------------------------------------------------+
bool TimeFilter(string ST, string ET)
  {
   datetime Start =StrToTime(TimeToStr(TimeCurrent(),TIME_DATE)+" "+ST);
   datetime End   =StrToTime(TimeToStr(TimeCurrent(),TIME_DATE)+" "+ET);

   if(!(Time[0]>=Start) && (Time[0]<=End))
     {
      return(false);
     }
   return(true);
  }

//+------------------------------------------------------------------+
//|     Day Trade                                                             |
//+------------------------------------------------------------------+
bool day_trade()
  {
   if(Trade_sunday == true&& DayOfWeek() ==0)
      return (true);
   if(Trade_monday  == true&& DayOfWeek() ==1)
      return (true);
   if(Trade_tuseday  == true&& DayOfWeek() ==2)
      return (true);
   if(Trade_wednisday  == true&& DayOfWeek() ==3)
      return (true);
   if(Trade_Thursday  == true&& DayOfWeek() ==4)
      return (true);
   if(Trade_friday  == true&& DayOfWeek() ==5)
      return (true);

   if(Trade_sunday == false&& DayOfWeek() ==0)
      return (false);
   if(Trade_monday  == false&& DayOfWeek() ==1)
      return (false);
   if(Trade_tuseday  == false&& DayOfWeek() ==2)
      return (false);
   if(Trade_wednisday  == false&& DayOfWeek() ==3)
      return (false);
   if(Trade_Thursday  == false&& DayOfWeek() ==4)
      return (false);
   if(Trade_friday  == false&& DayOfWeek() ==5)
      return (false);

   return(false);
  }

//+------------------------------------------------------------------+
int countSymbol(string symbol)
  {
   int count =0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         GetLastError();
        }
      if(OrderSymbol()==symbol&& OrderMagicNumber()== MagicNumber)
        {
         if(OrderType() == OP_BUY || OrderType() == OP_SELL)
           {
            count++;
           }
        }
     }
   return(count);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Hidden Close Orders                                                                 |
//+------------------------------------------------------------------+
void HiddenClose(string symbol,double takeprofit)
  {
   for(int i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         GetLastError();
        }
      if(OrderSymbol()==symbol)
        {
         if(OrderType()==OP_BUY&& OrderMagicNumber()== MagicNumber)
           {
            if(Close[0]>OrderOpenPrice()+takeprofit*Point)
              {
               if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,clrGreen)==false)
                 {
                  GetLastError();
                 }
              }
           }

         else
            if(OrderType()==OP_SELL&& OrderMagicNumber()== MagicNumber)
              {
               if(Close[0]<OrderOpenPrice()-takeprofit*Point)
                 {
                  if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,clrGreen)==false)
                    {
                     GetLastError();
                    }
                 }

              }
        }
     }
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool sTimeFilter(string inStart,string inEnd,string inString=":")
  {
   bool Result=true;
   int TimeHourStart,TimeMinuteStart,TimeHourEnd,TimeMinuteEnd;
   static datetime TimeStarts,TimeEnd;
//---
   sInputTimeConvert(TimeHourStart,TimeMinuteStart,inStart,inString);
   sInputTimeConvert(TimeHourEnd,TimeMinuteEnd,inEnd,inString);
   TimeStarts=StringToTime(IntegerToString(TimeHourStart)+":"+IntegerToString(TimeMinuteStart));
   TimeEnd=StringToTime(IntegerToString(TimeHourEnd)+":"+IntegerToString(TimeMinuteEnd));
//---
   if((TimeStarts<=TimeEnd) && ((TimeCurrent()<TimeStarts) || (TimeCurrent()>TimeEnd)))
      Result=false;
   if((TimeStarts>TimeEnd) && (TimeCurrent()<TimeStarts) && (TimeCurrent()>TimeEnd))
      Result=false;
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
//|     get average tp ,sl, BE                                                             |
//+------------------------------------------------------------------+
void averageTpSl(CPosition & Pos,CPosition & buyPos, CPosition & sellPos,CUtilities & tool,string  symb,double & BSl,double & BTp,double & SSl,double & STp)
  {
   double buy_order_lots=0,sell_order_lots=0,BuyLotprice=0,SellLotprice=0,BUY_L=0,SELL_L=0;
   double last_buy_price=0,last_sell_price=0;
   double NewAverageBUYprice, NewAverageSELLprice;
   if(symb==Symbol())
     {
      
         ObjectDelete(0,"buySl");
         ObjectDelete(0,"buyTp");  
         ObjectDelete(0,"sellSl");
         ObjectDelete(0,"sellTp");
        
     }
   if(use_close_Average_TPSL)
     {
      int tb=buyPos.GroupTotal();
      if(tb>1)
        {
         for(int i=0; i<tb; i++)
           {
            BUY_L=buyPos[i].GetVolume();
            BuyLotprice+=(BUY_L*buyPos.GetPriceOpen());
            buy_order_lots+=BUY_L;

           }
         NewAverageBUYprice=BuyLotprice/buy_order_lots;
         BTp=tool.NormalizePrice(NewAverageBUYprice+closeTP_buy_in_pips_eachpair*(tool.Pip()/tb),ROUNDING_OFF);
         BSl=tool.NormalizePrice(NewAverageBUYprice-(-closeSL_buy_in_pips_eachpair)*(tool.Pip()/tb),ROUNDING_OFF);
         //Draw lines
         if(symb==Symbol())
           {
            HLine.Create(0,"buySl",0,BSl);
            HLine.Color(clrRed);
            HLine.Create(0,"buyTp",0,BTp);
            HLine.Color(clrGreen);

           }
        }

      int ts=sellPos.GroupTotal();
      if(ts>1)
        {
         for(int i=0; i<ts; i++)
           {
            SELL_L=sellPos[i].GetVolume();
            SellLotprice+=(SELL_L*sellPos.GetPriceOpen());
            sell_order_lots+=SELL_L;

           }
         NewAverageSELLprice=SellLotprice/sell_order_lots;
         STp=tool.NormalizePrice(NewAverageSELLprice-closeTP_sell_in_pips_eachpair*(tool.Pip()/ts),ROUNDING_OFF);
         SSl=tool.NormalizePrice(NewAverageSELLprice+(-closeSL_sell_in_pips_eachpair)*(tool.Pip()/ts),ROUNDING_OFF);
         //Draw lines
         if(symb==Symbol())
           {        
            HLine.Create(0,"sellSl",0,SSl);
            HLine.Color(clrRed);
            HLine.Create(0,"sellTp",0,STp);
            HLine.Color(clrGreen);
           }
        }
     }
  }