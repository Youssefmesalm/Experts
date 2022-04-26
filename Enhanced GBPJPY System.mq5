//+------------------------------------------------------------------+
//|                                       Enhanced GBPJPY System.mq5 |
//|                                   Copyright 2022, Yousuf Mesalm. |
//|                                    https://www.Yousuf-mesalm.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Yousuf Mesalm."
#property link      "https://www.Yousuf-mesalm.com"
#property version   "1.00"

#include <ChartObjects\ChartObjectsLines.mqh>
#include  <YM\Execute\Execute.mqh>
#include  <YM\Position\Position.mqh>
#include  <YM\Order\Order.mqh>
#include  <YM\HistoryPosition\HistoryPosition.mqh>
long input                             MagicNumber = 2020;
input double                           Lot = 0.5;
input bool                             Use_MM = true;
input double                           Risk = 2.0;
input double                           F_Pips_Factor=5;
bool input Use_BreakEven = true;
bool input Use_Trailing = true;
int input BreakEventPoint = 5;
int input TrailingStopPoint = 12;
double input TrailingStopPrecentage = 50;
input double HedgeMultipiler = 4;
CUtilities *tools=new CUtilities(Symbol());
CExecute *trade=new CExecute(Symbol(), MagicNumber);
CPosition *SellPos=new CPosition(Symbol(), MagicNumber, GROUP_POSITIONS_SELLS);
CPosition *BuyPos=new CPosition(Symbol(), MagicNumber, GROUP_POSITIONS_BUYS);
CPosition *Pos=new CPosition(Symbol(), MagicNumber, GROUP_POSITIONS_ALL);
CHistoryPosition *History=new CHistoryPosition(Symbol(), MagicNumber, GROUP_HISTORY_POSITIONS_ALL);
CHistoryPosition *BuyHistory=new CHistoryPosition(Symbol(), MagicNumber, GROUP_HISTORY_POSITIONS_BUY);
CHistoryPosition *SellHistory=new CHistoryPosition(Symbol(), MagicNumber, GROUP_HISTORY_POSITIONS_SELL);
COrder *Pending= new COrder(Symbol(),MagicNumber,GROUP_ORDERS_ALL);
CChartObjectHLine *Hline=new CChartObjectHLine;
datetime Initialization_Time=0,Last_open_Position_Time=0;
double rational_Arr[];
double lot;
int MySignal = -1, oldMySignal, lowerIndex, upperIndex;
double Upper, Lower;
long LastTicket=0;
datetime Last_open_Time=0;
long HighestTicket=0;
datetime Last_open_Buy_Time=0;
long LowestTicket=0;
datetime Last_open_Sell_Time=0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   RationalNumbers(1, 100, rational_Arr);
//---
   Initialization_Time = TimeCurrent();
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   ObjectsDeleteAll(0,0,OBJ_HLINE);
   delete trade;
   delete SellPos;
   delete Pos;
   delete BuyPos;
   delete tools;
   delete History;
   delete BuyHistory;
   delete SellHistory;
   delete Hline;

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   GetSNR();
   if(Use_MM && Risk > 0)
     { lot = LotsMM();}
   else
     {lot = Lot;}
   initial_Trades();
   if(checkIfNewPositionOpen())
     {
      PlaceHedgeTrade();
     }
   Trailing();
   if(Pos.GroupTotal()>0)
      PlaceAdditionTrade();
   Restart();
   NormalTraliling();
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RationalNumbers(int num, int n, double& arr[])
  {
   ArrayResize(arr, n, n);
   for(int i = n; i > 0; i--)
     {

      double result = ((double)num / (double) i) * 10000;
      arr[i-1] = result;
      CreateHline(Hline, "Hline" + (string)i, result);
     }
  }
//+------------------------------------------------------------------+
bool CreateHline(CChartObjectHLine &line, string name, double price)
  {
   if(!line.Create(0, name, 0, price))
     {
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
bool checkIfPositinInSameChannel(double up,double dn,ENUM_ORDER_TYPE type)
  {

   int total=Pos.GroupTotal();
   for(int i=0; i<total; i++)
     {
      double PriceOpen=Pos[i].GetPriceOpen();
      if(PriceOpen>dn&&PriceOpen<up&&Pos[i].GetType()==type)
        {
         return true;
        }
     }
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool checkIfOrderInSameChannel(double up,double dn,ENUM_ORDER_TYPE type)
  {

   int total=Pending.GroupTotal();
   for(int i=0; i<total; i++)
     {
      double PriceOpen=Pending[i].GetPriceOpen();
      if(PriceOpen>dn&&PriceOpen<up&&Pending[i].GetType()==type)
        {
         return true;
        }
     }
   return false;
  }
////+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void GetSNR()
  {
   int size= ArraySize(rational_Arr);
   for(int i=1; i<size-1; i++)
     {
      if(tools.Ask() > rational_Arr[i] && tools.Ask() < rational_Arr[i-1])
        {
         Lower = rational_Arr[i ];
         lowerIndex = i;
         Upper = rational_Arr[i-1];
         upperIndex = i-1;
        }
     }

  }
//+------------------------------------------------------------------+
void initial_Trades()
  {
   int PosTotal=Pos.GroupTotal();
   int PendingTotal=Pending.GroupTotal();
   if(PosTotal==0&&PendingTotal==0)
     {
      double Filter_Pips=(Upper-Lower)/F_Pips_Factor;
      double BuyPrice=tools.NormalizePrice(Upper+Filter_Pips);
      double SellPrice=tools.NormalizePrice(Lower-Filter_Pips);
      trade.Order(TYPE_ORDER_BUYSTOP,lot,BuyPrice,0,0,SLTP_PIPS,0,30,"Initial Trade");
      trade.Order(TYPE_ORDER_SELLSTOP,lot,SellPrice,0,0,SLTP_PIPS,0,30,"Initial Trade");

     }
  }
//+------------------------------------------------------------------+
double LotsMM()
  {
   double sl= (Upper-Lower)/tools.Pip();
   double L = MathCeil((AccountInfoDouble(ACCOUNT_MARGIN_FREE) * Risk) / 1000) / sl;
   if(L < SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN))
      L = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN);
   if(L > SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MAX))
      L = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MAX);
   return (tools.NormalizeVolume(L));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void GetLastOpen()
  {
   int TotalOpen=Pos.GroupTotal();
// Get Last Open
   datetime time=0;

   for(int i=0; i<TotalOpen; i++)
     {
      time=Pos[i].GetTimeOpen();
      if(Last_open_Time<time)
        {
         LastTicket=Pos[i].GetTicket();
         Last_open_Time=time;
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void GetHighetsBuy()
  {
   int TotalOpen=BuyPos.GroupTotal();
// Get Highest Open
   double Highest =0;
   double Highest_price=0;
   for(int i=0; i<TotalOpen; i++)
     {
      Highest=BuyPos[i].GetPriceOpen();
      if(Highest_price<Highest)
        {
         Highest_price=Highest;
         HighestTicket=BuyPos[i].GetTicket();

        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void GetLowestSell()
  {
   int TotalOpen=SellPos.GroupTotal();
// Get Lowest Open
   double Lowest =0;
   double Lowest_price=0;
   for(int i=0; i<TotalOpen; i++)
     {
      Lowest=SellPos[i].GetPriceOpen();
      if(Lowest_price>Lowest||Lowest_price==0)
        {
         LowestTicket=SellPos[i].GetTicket();
         Lowest_price=Lowest;
        }
     }
  }
//+------------------------------------------------------------------+
bool checkIfNewPositionOpen()
  {
   GetLastOpen();
   if(Last_open_Time>Last_open_Position_Time)
     {
      Last_open_Position_Time=Last_open_Time;
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
void PlaceHedgeTrade()
  {
   double Filter_Pips=(Upper-Lower)/F_Pips_Factor;
   int TotalOpen=Pos.GroupTotal();

   if(Pos[LastTicket].GetType()==ORDER_TYPE_BUY)
     {
      double NewLower=rational_Arr[lowerIndex+2];
      double NewUpper=rational_Arr[lowerIndex+1];
      double SellPrice=tools.NormalizePrice(NewUpper-Filter_Pips);

      if(!checkIfPositinInSameChannel(NewUpper,NewLower,ORDER_TYPE_SELL))
         if(!checkIfOrderInSameChannel(NewUpper,NewLower,ORDER_TYPE_SELL_STOP))
            trade.Order(TYPE_ORDER_SELLSTOP,lot,SellPrice,0,0,SLTP_PIPS,0,30,"Hedge Sell");
     }
   else
      if(Pos[LastTicket].GetType()==ORDER_TYPE_SELL)
        {
         double NewUpper=rational_Arr[upperIndex-2];
         double NewLower=rational_Arr[upperIndex-1];
         double BuyPrice=tools.NormalizePrice(NewLower+Filter_Pips);

         if(!checkIfPositinInSameChannel(NewUpper,NewLower,ORDER_TYPE_BUY))
            if(!checkIfOrderInSameChannel(NewUpper,NewLower,ORDER_TYPE_BUY_STOP))
               trade.Order(TYPE_ORDER_BUYSTOP,lot,BuyPrice,0,0,SLTP_PIPS,0,30,"Hedge Buy");
        }
  }
//+------------------------------------------------------------------+
void PlaceAdditionTrade()
  {
   double NewLower=rational_Arr[lowerIndex+2];
   double NewUpper=rational_Arr[lowerIndex+1];
   double Filter_Pips=(Upper-Lower)/F_Pips_Factor;
   double SellPrice=tools.NormalizePrice(NewUpper-Filter_Pips);
   int TotalOpen=Pos.GroupTotal();


   if(!checkIfPositinInSameChannel(NewUpper,NewLower,ORDER_TYPE_SELL))
      if(!checkIfOrderInSameChannel(NewUpper,NewLower,ORDER_TYPE_SELL_STOP))
         if(!checkIfOrderInSameChannel(Upper,Lower,ORDER_TYPE_BUY_STOP))
            trade.Order(TYPE_ORDER_SELLSTOP,lot,SellPrice,0,0,SLTP_PIPS,0,30,"Addition Sell");


   NewUpper=rational_Arr[upperIndex-2];
   NewLower=rational_Arr[upperIndex-1];
   double BuyPrice=tools.NormalizePrice(NewLower+Filter_Pips);

   if(!checkIfPositinInSameChannel(NewUpper,NewLower,ORDER_TYPE_BUY))
      if(!checkIfOrderInSameChannel(NewUpper,NewLower,ORDER_TYPE_BUY_STOP))
         if(!checkIfOrderInSameChannel(Upper,Lower,ORDER_TYPE_SELL_STOP))
            trade.Order(TYPE_ORDER_BUYSTOP,lot,BuyPrice,0,0,SLTP_PIPS,0,30,"Addition Buy");


  }
//+------------------------------------------------------------------+
void Trailing()
  {
// Buy Trailing
   int TotalBuy=BuyPos.GroupTotal();
   int TotalSell=SellPos.GroupTotal();
   double SellsProfit=SellPos.GroupTotalProfit();
   double BuysProfit=BuyPos.GroupTotalProfit();
   if(TotalBuy>2&&BuysProfit>0)
     {
      double NewLower=rational_Arr[lowerIndex+1];
      double NewUpper=Lower;
      double diff=NewUpper-NewLower;
      double step=diff*(TrailingStopPrecentage/100);
      double sl=tools.NormalizePrice(NewUpper-step);
      for(int i=0; i<TotalBuy; i++)
        {
         if((BuyPos[i].GetStopLoss()<sl||BuyPos[i].GetStopLoss()==0))
            BuyPos[i].Modify(sl,0,SLTP_PRICE);

        }

     }



   if(TotalSell>2&&SellsProfit>0)
     {
      double NewUpper=rational_Arr[upperIndex-1];
      double NewLower=Upper;
      double diff=NewUpper-NewLower;
      double step=diff*(TrailingStopPrecentage/100);
      double sl=tools.NormalizePrice(step+NewLower);
      for(int i=0; i<TotalSell; i++)
        {
         if((SellPos[i].GetStopLoss()>sl||SellPos[i].GetStopLoss()==0))
            SellPos[i].Modify(sl,0,SLTP_PRICE);
        }



     }
  }
//+------------------------------------------------------------------+
void Restart()
  {
   if(Pos.GroupTotal()==0&&Pending.GroupTotal()>2)
     {
      Pending.GroupCloseAll(30);
     }
   if(Pos.GroupTotalProfit()>10&&BuyPos.GroupTotal()>0&&SellPos.GroupTotal()>0)
     {
      Pos.GroupCloseAll(30);
     }
  }
//+------------------------------------------------------------------+
void BreakEven()
  {

   int TotalBuy=BuyPos.GroupTotal();
   int TotalSell=SellPos.GroupTotal();
   double SellsProfit=SellPos.GroupTotalProfit();
   double BuysProfit=BuyPos.GroupTotalProfit();
   if(TotalBuy>0&&TotalSell==0)
     {
      GetHighetsBuy();

     }

  }
//+------------------------------------------------------------------+
void NormalTraliling()
  {
   int sell_total = SellPos.GroupTotal();

   int buy_total = BuyPos.GroupTotal();
   if(Use_Trailing || Use_BreakEven)
     {
      for(int i = 0; i < buy_total; i++)
        {
         if(BuyPos.SelectByIndex(i))
           {

            if(Use_BreakEven)
              {
               if((BuyPos.GetStopLoss() < BuyPos.GetPriceOpen() || BuyPos.GetStopLoss() == 0)
                  && tools.Bid() >= (BuyPos.GetPriceOpen() + BreakEventPoint * tools.Pip()))
                 {
                  BuyPos.Modify(BuyPos.GetPriceOpen(), BuyPos.GetTakeProfit(), SLTP_PRICE);
                 }
              }

            if(Use_Trailing&&sell_total==0)
              {
               if(tools.Bid() - BuyPos.GetPriceOpen() > tools.Pip() * TrailingStopPoint)
                 {
                  if(BuyPos.GetStopLoss() < tools.Bid() - tools.Pip() * TrailingStopPoint)
                    {
                     double ModfiedSl = tools.Bid() - (tools.Pip() * TrailingStopPoint);
                     BuyPos.Modify(ModfiedSl, BuyPos.GetTakeProfit(), SLTP_PRICE);
                    }
                 }
              }

           }
        }
     }
   if(Use_Trailing || Use_BreakEven)
     {
      for(int i = 0; i < sell_total; i++)
        {
         if(SellPos.SelectByIndex(i))
           {

            if(Use_BreakEven)
              {
               if((SellPos.GetStopLoss() > SellPos.GetPriceOpen() || SellPos.GetStopLoss() == 0)
                  && tools.Ask() <= (SellPos.GetPriceOpen() - BreakEventPoint * tools.Pip()))
                 {
                  SellPos.Modify(SellPos.GetPriceOpen(), SellPos.GetTakeProfit(), SLTP_PRICE);
                 }
              }

            if(Use_Trailing&&buy_total==0)
              {
               if(SellPos.GetPriceOpen() - tools.Ask() > tools.Pip() * TrailingStopPoint)
                 {
                  if(SellPos.GetStopLoss() > tools.Ask() + tools.Pip() * TrailingStopPoint)
                    {
                     double ModfiedSl = tools.Ask() + tools.Pip() * TrailingStopPoint;
                     SellPos.Modify(ModfiedSl, SellPos.GetTakeProfit(), SLTP_PRICE);
                    }
                 }
              }
           }

        }
     }
  }
//+------------------------------------------------------------------+
