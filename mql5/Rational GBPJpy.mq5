//+------------------------------------------------------------------+
//|                                              Rational GBPJpy.mq5 |
//|                                    Copyright 2021,Yousuf Mesalm. |
//|                           https://www.mql5.com/en/users/20163440 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021,Yousuf Mesalm."
#property link      "https://www.mql5.com/en/users/20163440"
#property version   "1.00"

#include <ChartObjects\ChartObjectsLines.mqh>
#include <Indicators\Trend.mqh>
#include  <MQL_Easy\Execute\Execute.mqh>
#include  <MQL_Easy\Position\Position.mqh>
#include  <MQL_Easy\HistoryPosition\HistoryPosition.mqh>
long input MagicNumber = 2020;
double input Lot = 0.5;
input bool Use_MM = true;
input double   Risk = 2.0;
int input MASpace = 100;
int input MovingPriceSpace = 100;
bool input Use_BreakEven = true;
bool input Use_Trailing = true;
bool input MovingClose = false;
int input BreakEventPoint = 175;
int input TrailingStopPoint = 400;
double input HedgeMultipiler = 2;
CUtilities tools;
CExecute trade(Symbol(), MagicNumber);
CPosition SellPos(Symbol(), MagicNumber, GROUP_POSITIONS_SELLS);
CPosition BuyPos(Symbol(), MagicNumber, GROUP_POSITIONS_BUYS);
CPosition Pos(Symbol(), MagicNumber, GROUP_POSITIONS_ALL);
CHistoryPosition BuyHistory(Symbol(), MagicNumber, GROUP_HISTORY_POSITIONS_BUY);
CHistoryPosition SellHistory(Symbol(), MagicNumber, GROUP_HISTORY_POSITIONS_SELL);
CiMA MA7;
CiMA MA3;
long LastBuyTicket = -1;
datetime LastBuytime = 0;
long LastSellTicket = -1;
datetime LastSelltime = 0;
CChartObjectHLine Hline;
datetime Initialization;
double rational_Arr[];
int OrderNumber = 0;
int HedgeType = -1;
long HedgeTicket = 0;
string HedgeArray[];
double HedgeLot;
string HedgeComment;
bool Skip = false;
double LastBuyOpen = 0, LastSellOpen = 0;
int HedgeTotal = 0;
int totalSell = 0;
int totalBuy = 0;
int totalPos = 0;
// variables
bool update = true, crossed = false, first = true;
int MySignal = -1, oldMySignal, lowerIndex, upperIndex;
double Upper, Lower;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   RationalNumbers(1, 100, rational_Arr);
   MA7.Create(Symbol(), PERIOD_H4, 7, 0, MODE_EMA, MODE_CLOSE);
   MA7.AddToChart(0, 0);
   MA3.Create(Symbol(), PERIOD_H4, 3, 0, MODE_EMA, MODE_CLOSE);
   MA3.AddToChart(0, 0);
////--- create application dialog
//   if(!dash.Create(0, "IyKdavis", 0, 50, 50, 300, 400))
//      return (INIT_FAILED);
////--- run application
//   if(!dash.Run())
//      return (INIT_FAILED);
//---
   Initialization = TimeCurrent();
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
   MA7.Refresh(-1);
   MA3.Refresh(-1);
   HedgeTotal = ArraySize(HedgeArray);
   totalSell = SellPos.GroupTotal();
   totalBuy = BuyPos.GroupTotal();
   totalPos = Pos.GroupTotal();
   ArrayPrint(HedgeArray);
   if(update)
     {
      for(int i = 1; i < ArraySize(rational_Arr) ; i++)
        {
         if(tools.Ask() < rational_Arr[i - 1] && tools.Ask() > rational_Arr[i])
           {
            Lower = rational_Arr[i ];
            lowerIndex = i;
            Upper = rational_Arr[i - 1];
            upperIndex = i - 1;
           }
        }
      update = false;
     }
   if(!crossed)
     {
      if(tools.Ask() > Upper + 50 * tools.Pip())
        {
         MySignal = 1;
         update = true;
         crossed = true;
        }
      if(tools.Bid() < Lower - 50 * tools.Pip())
        {
         MySignal = 0;
         update = true;
         crossed = true;
        }
     }
//--------------------------------------------------------------------------------
//cross
   if(crossed)
     {
      double lot;
      if(Use_MM && Risk > 0)
        { lot = LotsMM();}
      else
        {lot = Lot;}
      //
      Skip = false;
      int Buytotal = BuyPos.GroupTotal();
      int Selltotal = SellPos.GroupTotal();
      int SellHistorytotal = SellHistory.GroupTotal();
      int BuyHistorytotal = BuyHistory.GroupTotal();
      BuyHistory.SetHistoryRange(Initialization, TimeCurrent());
      SellHistory.SetHistoryRange(Initialization, TimeCurrent());
     
      if(MySignal == 0)
        {
         MA3.Refresh(-1);
         MA7.Refresh(-1);
         double up = tools.NormalizePrice(rational_Arr[upperIndex], ROUNDING_OFF);
         double down = tools.NormalizePrice(rational_Arr[lowerIndex + 1 ], ROUNDING_OFF);
         double tp = MovingClose ? 0 : down + 30 * tools.Pip();
         if(SellHistorytotal > 0 && Selltotal > 0)
           {
            if(!(SellHistory[SellHistorytotal - 1].GetPriceOpen() < rational_Arr[lowerIndex] && SellHistory[SellHistorytotal - 1].GetPriceOpen() > rational_Arr[lowerIndex + 1]))
              {
               if(!Hedging() && !Skip)
                 {
                  if(MA7.Main(0) > MA3.Main(0) && MA7.Main(0) - MASpace * tools.Pip() < MA3.Main(0)
                     && MA3.Main(0) - tools.Bid() < MovingPriceSpace * tools.Pip())
                    {
                     OrderNumber++;
                     string comment = (string)OrderNumber;
                     trade.Position(TYPE_POSITION_SELL, lot, 0, tp, SLTP_PRICE, 30, comment);
                     Skip = false;
                    }
                 }
              }
           }
         else
            if(!Hedging() && !Skip)
              {
               if(MA7.Main(0) > MA3.Main(0) && MA7.Main(0) - MASpace * tools.Pip() < MA3.Main(0)
                  && MA3.Main(0) - tools.Bid() < MovingPriceSpace * tools.Pip())
                 {
                  OrderNumber++;
                  string comment = (string)OrderNumber;
                  trade.Position(TYPE_POSITION_SELL, lot, 0, tp, SLTP_PRICE, 30, comment);
                 }
              }
        }
      if(MySignal == 1)
        {
         MA3.Refresh(-1);
         MA7.Refresh(-1);
         double up = tools.NormalizePrice(rational_Arr[upperIndex - 1], ROUNDING_OFF);
         double down = tools.NormalizePrice(rational_Arr[lowerIndex], ROUNDING_OFF);
         double tp = MovingClose ? 0 : up - 30 * tools.Pip();
         if(BuyHistorytotal > 0 && Buytotal > 0)
           {
            if(!(BuyHistory[BuyHistorytotal - 1].GetPriceOpen() > rational_Arr[upperIndex] && BuyHistory[BuyHistorytotal - 1].GetPriceOpen() < rational_Arr[upperIndex - 1]))
              {
               if(!Hedging() && !Skip)
                 {
                  if(MA7.Main(0) < MA3.Main(0) && MA7.Main(0) + MASpace * tools.Pip() > MA3.Main(0)
                     && tools.Bid() - MA3.Main(0) < MovingPriceSpace * tools.Pip())
                    {
                     OrderNumber++;
                     string comment = (string)OrderNumber;
                     trade.Position(TYPE_POSITION_BUY, lot, 0, tp, SLTP_PRICE, 30, comment);
                    }
                 }
              }
           }
         else
            if(!Hedging() && !Skip)
              {
               if(MA7.Main(0) < MA3.Main(0) && MA7.Main(0) + MASpace * tools.Pip() > MA3.Main(0)
                  && tools.Bid() - MA3.Main(0) < MovingPriceSpace * tools.Pip())
                 {
                  OrderNumber++;
                  string comment = (string)OrderNumber;
                  trade.Position(TYPE_POSITION_BUY, lot, 0, tp, SLTP_PRICE, 30, comment);
                 }
              }
        }
      crossed = false;
     }
   CloseHedge();
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   Traliling();
   CloseWithMoving();
   ClearHedgeArray();
  }

//+------------------------------------------------------------------+
void RationalNumbers(int num, int n, double& arr[])
  {
   ArrayResize(arr, n, n);
   for(int i = 1; i <= n; i++)
     {
      double result = ((double)num / (double) i) * 10000;
      arr[i - 1] = result;
      CreateHline(Hline, "Hline" + (string) i, result);
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

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Traliling()
  {
   int buy_total = BuyPos.GroupTotal();
   if(Use_Trailing || Use_BreakEven)
     {
      for(int i = 0; i < buy_total; i++)
        {
         if(BuyPos.SelectByIndex(i))
           {
            bool Exist = false;
            for(int x = 0; x < HedgeTotal; x++)
              {
               string comment = HedgeArray[x];
               if(comment == BuyPos.GetComment())
                 {
                  Exist = true;
                 }
              }
            if(Use_BreakEven)
              {
               if((BuyPos.GetStopLoss() < BuyPos.GetPriceOpen() || BuyPos.GetStopLoss() == 0)
                  && tools.Bid() >= (BuyPos.GetPriceOpen() + BreakEventPoint * tools.Pip()))
                 {
                  BuyPos.Modify(BuyPos.GetPriceOpen(), BuyPos.GetTakeProfit(), SLTP_PRICE);
                 }
              }
            if(!Exist)
              {
               if(Use_Trailing)
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
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   int sell_total = SellPos.GroupTotal();
   if(Use_Trailing || Use_BreakEven)
     {
      for(int i = 0; i < sell_total; i++)
        {
         if(SellPos.SelectByIndex(i))
           {
            bool Exist = false;
            for(int x = 0; x < HedgeTotal; x++)
              {
               string comment = HedgeArray[x];
               if(comment == SellPos.GetComment())
                 {
                  Exist = true;
                 }
              }
            if(Use_BreakEven)
              {
               if((SellPos.GetStopLoss() > SellPos.GetPriceOpen() || SellPos.GetStopLoss() == 0)
                  && tools.Ask() <= (SellPos.GetPriceOpen() - BreakEventPoint * tools.Pip()))
                 {
                  SellPos.Modify(SellPos.GetPriceOpen(), SellPos.GetTakeProfit(), SLTP_PRICE);
                 }
              }
            if(!Exist)
              {
               if(Use_Trailing)
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
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseWithMoving()
  {
   if(MovingClose)
     {
      double Profit = BuyPos.GroupTotalProfit();
      if(Profit > 0)
        {
         MA3.Refresh(-1);
         MA7.Refresh(-1);
         if(MA7.Main(0) > MA3.Main(0))
           {
            int buy_total = BuyPos.GroupTotal();
            for(int i = 0; i < buy_total; i++)
              {
               if(BuyPos.SelectByIndex(i))
                 {
                  BuyPos.Close();
                 }
              }
           }
        }
      Profit = SellPos.GroupTotalProfit();
      if(Profit > 0)
        {
         MA3.Refresh(-1);
         MA7.Refresh(-1);
         if(MA7.Main(0) < MA3.Main(0))
           {
            int sell_total = SellPos.GroupTotal();
            for(int i = 0; i < sell_total; i++)
              {
               if(SellPos.SelectByIndex(i))
                 {
                  SellPos.Close();
                 }
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double LotsMM()
  {
   double L = MathCeil((AccountInfoDouble(ACCOUNT_MARGIN_FREE) * Risk) / 1000) / 400;
   if(L < SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN))
      L = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN);
   if(L > SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MAX))
      L = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MAX);
   return (tools.NormalizeVolume(L));
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//void DashUpdate()
//  {
//   dash.Set_M1_MySignal((string)MySignal);
//  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
bool Hedging()
  {
   if(totalPos > 0)
     {
      for(int i = 0; i < totalPos; i++)
        {
         if(Pos[i].GetProfit() < 0)
           {
            if(HedgeTotal > 0)
              {
               bool Exist = false;
               for(int x = 0; x < HedgeTotal; x++)
                 {
                  string comment = HedgeArray[x];
                  if(Pos[i].GetComment() == comment)
                    {
                     Exist = true;
                     double PriceOpen = Pos[i].GetPriceOpen();
                     datetime TimeOpen = Pos[i].GetTimeOpen();
                     if(MySignal == 0)
                       {
                        if(Pos[i].GetType() == ORDER_TYPE_BUY)
                          {
                           // GetLast Sell
                           LastBuyTicket = -1;
                           LastSellTicket = -1;
                           for(int z = 0; z < totalSell; z++)
                             {
                              if(SellPos.SelectByIndex(z))
                                {
                                 if(SellPos[z].GetComment() == comment && SellPos[z].GetPriceOpen() < PriceOpen
                                    && SellPos[z].GetPriceOpen() < rational_Arr[lowerIndex] && SellPos[z].GetPriceOpen() > rational_Arr[lowerIndex + 1])
                                   {
                                    if(SellPos[z].GetTimeOpen() > LastSelltime)
                                      {
                                       LastSellTicket = SellPos[z].GetTicket();
                                       LastSelltime = SellPos[z].GetTimeOpen();
                                       Skip = true;
                                      }
                                   }
                                }
                             }
                           // GetLast Buy
                           for(int z = 0; z < totalBuy; z++)
                             {
                              if(BuyPos[z].GetComment() == comment && BuyPos[z].GetPriceOpen() > rational_Arr[upperIndex - 1]
                                )
                                {
                                 if(BuyPos[z].GetTimeOpen() > LastBuytime)
                                   {
                                    LastBuyTicket = BuyPos[z].GetTicket();
                                    LastBuytime = BuyPos[z].GetTimeOpen();
                                   }
                                }
                             }
                           if(LastBuyTicket != -1 && LastSellTicket != -1)
                             {
                              if(SellPos[LastSellTicket].GetTimeOpen() < BuyPos[LastBuyTicket].GetTimeOpen()
                                 && SellPos.GroupTotalVolume() * 2 < BuyPos.GroupTotalVolume())
                                {
                                 double LastLot = BuyPos[LastBuyTicket].GetVolume();
                                 HedgeTicket = LastBuyTicket;
                                 HedgeLot = tools.NormalizeVolume(LastLot * HedgeMultipiler, ROUNDING_OFF);
                                 HedgeComment = BuyPos[LastBuyTicket].GetComment();
                                 trade.Position(TYPE_POSITION_SELL, HedgeLot, 0, 0, SLTP_PIPS, 30, HedgeComment);
                                 BuyPos[HedgeTicket].Modify(0, 0, SLTP_PIPS);
                                 UpdatHedgeArray();
                                 return true;
                                }
                             }
                          }
                       }
                     if(MySignal == 1)
                       {
                        if(Pos[i].GetType() == ORDER_TYPE_SELL)
                          {
                           // GetLast Buy
                           for(int z = 0; z < totalBuy; z++)
                             {
                              if(BuyPos[z].GetComment() == comment && BuyPos[z].GetPriceOpen() > PriceOpen && BuyPos[z].GetPriceOpen() > rational_Arr[upperIndex]
                                 && BuyPos[z].GetPriceOpen() < rational_Arr[upperIndex - 1])
                                {
                                 if(BuyPos[z].GetTimeOpen() > LastBuytime && BuyPos[z].GetTimeOpen() > LastSelltime)
                                   {
                                    LastBuyTicket = BuyPos[z].GetTicket();
                                    LastBuytime = BuyPos[z].GetTimeOpen();
                                    Skip = true;
                                   }
                                }
                             }
                           // GetLast Sell
                           for(int z = 0; z < totalSell; z++)
                             {
                              if(SellPos[z].GetComment() == comment
                                 && SellPos[z].GetPriceOpen() < rational_Arr[lowerIndex + 1])
                                {
                                 if(SellPos[z].GetTimeOpen() > LastSelltime && SellPos[z].GetTimeOpen() > LastBuytime)
                                   {
                                    LastSellTicket = SellPos[z].GetTicket();
                                    LastSelltime = SellPos[z].GetTimeOpen();
                                   }
                                }
                             }
                           if(LastBuyTicket != -1 && LastSellTicket != -1)
                             {
                              if(SellPos[LastSellTicket].GetTimeOpen() > BuyPos[LastBuyTicket].GetTimeOpen()
                                 && SellPos.GroupTotalVolume() > BuyPos.GroupTotalVolume() * 2)
                                {
                                 double LastLot = SellPos[LastSellTicket].GetVolume();
                                 HedgeTicket = LastSellTicket;
                                 HedgeLot = tools.NormalizeVolume(LastLot * HedgeMultipiler, ROUNDING_OFF);
                                 HedgeComment = SellPos[LastSellTicket].GetComment();
                                 trade.Position(TYPE_POSITION_BUY, HedgeLot, 0, 0, SLTP_PRICE, 30, HedgeComment);
                                 SellPos[HedgeTicket].Modify(0, 0, SLTP_PIPS);
                                 UpdatHedgeArray();
                                 return true;
                                }
                             }
                          }
                       }
                    }
                 }
               if(!Exist)
                 {
                  double PriceOpen = Pos[i].GetPriceOpen();
                  datetime TimeOpen = Pos[i].GetTimeOpen();
                  if(MySignal == 0)
                    {
                     if(Pos[i].GetType() == ORDER_TYPE_BUY)
                       {
                        if(
                           Pos[i].GetPriceOpen() > rational_Arr[upperIndex - 1])
                          {
                           double LastLot = Pos[i].GetVolume();
                           HedgeTicket = Pos[i].GetTicket();
                           HedgeLot = tools.NormalizeVolume(LastLot * HedgeMultipiler, ROUNDING_OFF);
                           HedgeComment = Pos[i].GetComment();
                           trade.Position(TYPE_POSITION_SELL, HedgeLot, 0, 0, SLTP_PIPS, 30, HedgeComment);
                           Pos[HedgeTicket].Modify(0, 0, SLTP_PIPS);
                           UpdatHedgeArray();
                           return true;
                          }
                       }
                    }
                  if(MySignal == 1)
                    {
                     if(Pos[i].GetType() == ORDER_TYPE_SELL)
                       {
                        if(
                           Pos[i].GetPriceOpen() < rational_Arr[lowerIndex + 1])
                          {
                           double LastLot = Pos[i].GetVolume();
                           HedgeTicket = Pos[i].GetTicket();
                           HedgeLot = tools.NormalizeVolume(LastLot * HedgeMultipiler, ROUNDING_OFF);
                           HedgeComment = Pos[i].GetComment();;
                           trade.Position(TYPE_POSITION_BUY, HedgeLot, 0, 0, SLTP_PRICE, 30, HedgeComment);
                           Pos[HedgeTicket].Modify(0, 0, SLTP_PIPS);
                           UpdatHedgeArray();
                           return true;
                          }
                       }
                    }
                 }
              }
            else
              {
               double PriceOpen = Pos[i].GetPriceOpen();
               datetime TimeOpen = Pos[i].GetTimeOpen();
               if(MySignal == 0)
                 {
                  if(Pos[i].GetType() == ORDER_TYPE_BUY)
                    {
                     if(
                        Pos[i].GetPriceOpen() > rational_Arr[upperIndex - 1])
                       {
                        double LastLot = Pos[i].GetVolume();
                        HedgeTicket = Pos[i].GetTicket();
                        HedgeLot = tools.NormalizeVolume(LastLot * HedgeMultipiler, ROUNDING_OFF);
                        HedgeComment = Pos[i].GetComment();
                        trade.Position(TYPE_POSITION_SELL, HedgeLot, 0, 0, SLTP_PIPS, 30, HedgeComment);
                        Pos[HedgeTicket].Modify(0, 0, SLTP_PIPS);
                        UpdatHedgeArray();
                        return true;
                       }
                    }
                 }
               if(MySignal == 1)
                 {
                  if(Pos[i].GetType() == ORDER_TYPE_SELL)
                    {
                     if(
                        Pos[i].GetPriceOpen() < rational_Arr[lowerIndex + 1])
                       {
                        double LastLot = Pos[i].GetVolume();
                        HedgeTicket = Pos[i].GetTicket();
                        HedgeLot = tools.NormalizeVolume(LastLot * HedgeMultipiler, ROUNDING_OFF);
                        HedgeComment = Pos[i].GetComment();;
                        trade.Position(TYPE_POSITION_BUY, HedgeLot, 0, 0, SLTP_PRICE, 30, HedgeComment);
                        Pos[HedgeTicket].Modify(0, 0, SLTP_PIPS);
                        UpdatHedgeArray();
                        return true;
                       }
                    }
                 }
              }
           }
        }
     }
   return false;
  }

//+------------------------------------------------------------------+
void CloseHedge()
  {
   if(HedgeTotal > 0)
     {
      int RemovedElement[];
      int elm = 0;
      for(int x = 0; x < HedgeTotal; x++)
        {
         string comment = HedgeArray[x];
         double Profit[];
         long index[];
         int num = 0;
         if(totalPos > 0)
           {
            for(int i = 0; i < totalPos; i++)
              {
               if(Pos[i].GetComment() == comment)
                 {
                  num++;
                  ArrayResize(Profit, num);
                  ArrayResize(index, num);
                  Profit[num - 1] = Pos[i].GetProfit();
                  index[num - 1] = Pos[i].GetTicket();
                 }
              }
            double totalProfit = 0;
            for(int z = 0; z < num; z++)
              {
               totalProfit = totalProfit + Profit[z];
              }
            if(totalProfit > 1)
              {
               for(int s = 0; s < num; s++)
                 {
                  Pos[index[s]].Close(20);
                  Print("Must close");
                 }
               elm++;
               ArrayResize(RemovedElement, elm);
               RemovedElement[elm - 1] = x;
              }
           }
        }
      if(elm > 0)
        {
         for(int m = 0; m < elm; m++)
           {
            RemoveElement(RemovedElement[m], HedgeArray);
           }
        }
     }
  }
//+------------------------------------------------------------------+
void UpdatHedgeArray()
  {
   bool Exist = false;
   if(HedgeTotal > 0)
     {
      for(int x = 0; x < HedgeTotal; x++)
        {
         if(HedgeComment == HedgeArray[x])
           {
            Exist = true;
           }
        }
      if(!Exist)
        {
         ArrayResize(HedgeArray, HedgeTotal + 1);
         HedgeArray[HedgeTotal] = HedgeComment;
        }
     }
   else
     {
      ArrayResize(HedgeArray, HedgeTotal + 1);
      HedgeArray[HedgeTotal] = HedgeComment;
     }
  }
//+------------------------------------------------------------------+
void RemoveElement(int idx, string &Array[])
  {
   string temp[];
   int num = 0;
   ArrayCopy(temp, Array, 0, 0, WHOLE_ARRAY);
   ArrayFree(Array);
   for(int i = 0; i < ArraySize(temp); i++)
     {
      if(i != idx)
        {
         num++;
         ArrayResize(Array, num);
         Array[num - 1] = temp[i];
        }
     }
  }
//+------------------------------------------------------------------+
void ClearHedgeArray()
  {
   int n = 0;
   if(HedgeTotal > 0)
     {
      for(int x = 0; x < HedgeTotal; x++)
        {
         for(int z = 0; z < HedgeTotal; z++)
           {
            if(HedgeArray[z] == HedgeArray[x])
              {
               n++;
              }
           }
         if(n < 2)
           {
            RemoveElement(x, HedgeArray);
           }
        }
     }
  }
//+------------------------------------------------------------------+
