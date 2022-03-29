//+------------------------------------------------------------------+
//|                                                   4 R GBPJPY.mq5 |
//|                                Copyright 2022, Dr Yousuf Mesalm. |
//|                               https://www.mql5.com/user/20163440 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Dr Yousuf Mesalm."
#property link      "https://www.mql5.com/user/20163440"
#property version   "1.00"
//includes
#include  <MQL_Easy\Execute\Execute.mqh>
#include  <MQL_Easy\Position\Position.mqh>
#include  <MQL_Easy\HistoryPosition\HistoryPosition.mqh>
// Inputs
input long MagicNumber=2020;
double input Lot = 0.1;
input bool Use_MM = true;
input double   Risk = 0.10;
bool input Use_BreakEven = true;
bool input Use_Trailing = true;
int input BreakEventPoint = 5;
int input TrailingStopPoint = 12;
//objects
CExecute trade(Symbol(),MagicNumber);
CPosition Pos(Symbol(),MagicNumber,GROUP_POSITIONS_ALL);
CPosition BuyPos(Symbol(),MagicNumber,GROUP_POSITIONS_BUYS);
CPosition SellPos(Symbol(),MagicNumber,GROUP_POSITIONS_SELLS);
CUtilities tools;
//variables
int handle1,handle2,handle3,handle4;
double LastBuyPrice,LastSellPrice;
double signal1[],signal2[],signal3[],signal4[];
double buy1[],buy2[],buy3[],buy4[];
double sell1[],sell2[],sell3[],sell4[];
double up1[],up2[],up3[],up4[];
double dn1[],dn2[],dn3[],dn4[];
double upB4[],dnB4[];
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   handle1=iCustom(Symbol(),PERIOD_M5,"Rational Indicator.ex5",1,1000,10000,clrRed,true,5);
   handle2=iCustom(Symbol(),PERIOD_M5,"Rational Indicator.ex5",2,1000,10000,clrGreen,true,5);
   handle3=iCustom(Symbol(),PERIOD_M5,"Rational Indicator.ex5",3,1000,10000,clrSteelBlue,true,5);
   handle4=iCustom(Symbol(),PERIOD_M5,"Rational Indicator.ex5",1,1000,100000,clrBlack,true,2);
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

   CopyBuffer(handle1,0,0,1,buy1);
   CopyBuffer(handle2,0,0,1,buy2);
   CopyBuffer(handle3,0,0,1,buy3);
   CopyBuffer(handle4,0,0,1,buy4);
   CopyBuffer(handle1,1,0,1,sell1);
   CopyBuffer(handle2,1,0,1,sell2);
   CopyBuffer(handle3,1,0,1,sell3);
   CopyBuffer(handle4,1,0,1,sell4);
   CopyBuffer(handle1,2,0,1,up1);
   CopyBuffer(handle2,2,0,1,up2);
   CopyBuffer(handle3,2,0,1,up3);
   CopyBuffer(handle4,2,0,1,up4);
   CopyBuffer(handle1,3,0,1,dn1);
   CopyBuffer(handle2,3,0,1,dn2);
   CopyBuffer(handle3,3,0,1,dn3);
   CopyBuffer(handle4,3,0,1,dn4);
   CopyBuffer(handle1,4,0,1,signal1);
   CopyBuffer(handle2,4,0,1,signal2);
   CopyBuffer(handle3,4,0,1,signal3);
   CopyBuffer(handle4,4,0,1,signal4);
   CopyBuffer(handle2,5,0,1,upB4);
   CopyBuffer(handle2,6,0,1,dnB4);
   double lot,NewLot,tp;

   if(Use_MM && Risk > 0)
     { lot = LotsMM();}
   else
     {lot = Lot;}
   Traliling();
   Closing();
   
   double multiplier=Pos.GroupTotalVolume()>1?1.4:Pos.GroupTotalVolume()>1.2?0.9:Pos.GroupTotalVolume()>1.5?0.5:4;
   if(checkPositinInSameChannel(up4[0],dn4[0]))
     {
      if(signal1[0]==0&&signal2[0]==0&&signal3[0]==0&&signal4[0]==0)
        {
         if(sell4[0]>0&&sell4[0]!=sell1[0]&&up4[0]!=up1[0]&&sell4[0]==up4[0]&&up1[0]!=up4[0]&&up1[0]!=dn4[0]&&dn1[0]!=dn4[0]&&dn1[0]!=up4[0])
           {
            if(tools.Bid()<up4[0]&&tools.Bid()>dn4[0])
              {
               if(BuyPos.GroupTotalProfit()<0)
                 {
                  NewLot=SellPos.GroupTotalVolume()<BuyPos.GroupTotalVolume()?BuyPos.GroupTotalVolume()*multiplier:lot;
                  tp=0;
                 }
               else
                 {
                  NewLot=lot;
                  tp=dn3[0]+3*tools.Pip();
                 }
               trade.Position(TYPE_POSITION_SELL,tools.NormalizeVolume(NewLot,0),0,tp,SLTP_PRICE,30,"PowerSignal");
               LastSellPrice=sell4[0];
              }
           }

        }
      if(signal1[0]==1&&signal2[0]==1&&signal3[0]==1&&signal4[0]==1)
        {
         if(buy4[0]>0&&buy1[0]!=buy4[0]&&dn1[0]!=dn4[0]&&buy4[0]==dn4[0]&&up1[0]!=up4[0]&&up1[0]!=dn4[0]&&dn1[0]!=dn4[0]&&dn1[0]!=up4[0])
           {
            if(tools.Ask()<up4[0]&&tools.Ask()>dn4[0])
              {
               if(SellPos.GroupTotalProfit()<0)
                 {

                  NewLot=BuyPos.GroupTotalVolume()<SellPos.GroupTotalVolume()?SellPos.GroupTotalVolume()*multiplier:lot;


                  tp=0;
                 }
               else
                 {
                  NewLot=lot;
                  tp=up3[0]-3*tools.Pip();
                 }
               trade.Position(TYPE_POSITION_BUY,tools.NormalizeVolume(NewLot,0),0,tp,SLTP_PRICE,30,"PowerSignal");
               LastBuyPrice=buy4[0];
              }
           }

        }
      if(signal1[0]==1&&signal2[0]==0&&signal3[0]==0&&signal4[0]==0)
        {
         if(sell4[0]>0&&sell4[0]!=sell1[0]&&up4[0]!=up1[0]&&sell4[0]==up4[0]&&up1[0]!=up4[0]&&up1[0]!=dn4[0]&&dn1[0]!=dn4[0]&&dn1[0]!=up4[0])
           {
            if(tools.Bid()<up4[0]&&tools.Bid()>dn4[0])
              {
               if(BuyPos.GroupTotalProfit()<0)
                 {
                  NewLot=SellPos.GroupTotalVolume()<BuyPos.GroupTotalVolume()?BuyPos.GroupTotalVolume()*multiplier:lot;
                  tp=0;
                 }
               else
                 {
                  NewLot=lot;
                  tp=dn4[0]+3*tools.Pip();
                 }
               trade.Position(TYPE_POSITION_SELL,tools.NormalizeVolume(NewLot,0),0,tp,SLTP_PRICE,30,"MidSignal");
               LastSellPrice=sell4[0];
              }
           }

        }
      if(signal1[0]==0&&signal2[0]==1&&signal3[0]==1&&signal4[0]==1)
        {
         if(buy4[0]>0&&buy1[0]!=buy4[0]&&dn1[0]!=dn4[0]&&buy4[0]==dn4[0]&&up1[0]!=up4[0]&&up1[0]!=dn4[0]&&dn1[0]!=dn4[0]&&dn1[0]!=up4[0])
           {
            if(tools.Ask()<up4[0]&&tools.Ask()>dn4[0])
              {
               if(SellPos.GroupTotalProfit()<0)
                 {
                  NewLot=BuyPos.GroupTotalVolume()<SellPos.GroupTotalVolume()?SellPos.GroupTotalVolume()*multiplier:lot;
                  tp=0;
                 }
               else
                 {
                  NewLot=lot;
                  tp=up4[0]-3*tools.Pip();
                 }
               trade.Position(TYPE_POSITION_BUY,tools.NormalizeVolume(NewLot,0),0,tp,SLTP_PRICE,30,"MidSignal");
               LastBuyPrice=buy4[0];
              }
           }
        }


      if(BuyPos.GroupTotal()>0&&SellPos.GroupTotal()>0)
        {
         if(signal1[0]==1&&signal2[0]==1&&signal3[0]==0&&signal4[0]==0)
           {
            if(sell4[0]>0&&sell4[0]!=sell1[0]&&up4[0]!=up1[0]&&sell4[0]==up4[0]&&up1[0]!=up4[0]&&up1[0]!=dn4[0]&&dn1[0]!=dn4[0]&&dn1[0]!=up4[0])
              {
               if(tools.Bid()<up4[0]&&tools.Bid()>dn4[0])
                 {
                  if(BuyPos.GroupTotalProfit()<0)
                    {
                     NewLot=SellPos.GroupTotalVolume()<BuyPos.GroupTotalVolume()?BuyPos.GroupTotalVolume()*multiplier:lot;
                     tp=0;
                    }
                  else
                    {
                     NewLot=lot;
                     tp=dn3[0]+3*tools.Pip();
                    }
                  trade.Position(TYPE_POSITION_SELL,tools.NormalizeVolume(NewLot,0),0,tp,SLTP_PRICE,30,"WeakSignal");
                  LastSellPrice=sell4[0];
                 }
              }

           }
         if(signal1[0]==0&&signal2[0]==0&&signal3[0]==1&&signal4[0]==1)
           {
            if(buy4[0]>0&&buy1[0]!=buy4[0]&&dn1[0]!=dn4[0]&&buy4[0]==dn4[0]&&up1[0]!=up4[0]&&up1[0]!=dn4[0]&&dn1[0]!=dn4[0]&&dn1[0]!=up4[0])
              {
               if(tools.Ask()<up4[0]&&tools.Ask()>dn4[0])
                 {
                  if(SellPos.GroupTotalProfit()<0)
                    {

                     NewLot=BuyPos.GroupTotalVolume()<SellPos.GroupTotalVolume()?SellPos.GroupTotalVolume()*multiplier:lot;


                     tp=0;
                    }
                  else
                    {
                     NewLot=lot;
                     tp=up3[0]-3*tools.Pip();
                    }
                  trade.Position(TYPE_POSITION_BUY,tools.NormalizeVolume(NewLot,0),0,tp,SLTP_PRICE,30,"WeakSignal");
                  LastBuyPrice=buy4[0];
                 }
              }
           }
        }

     }
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---

  }
//+------------------------------------------------------------------+
bool checkPositinInSameChannel(double up,double dn)
  {

   int total=Pos.GroupTotal();
   for(int i=0; i<total; i++)
     {
      double PriceOpen=Pos[i].GetPriceOpen();
      if(PriceOpen>dn&&PriceOpen<up)
        {
         return false;
        }
     }
   return true;
  }
//+------------------------------------------------------------------+
void Traliling()
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
void Closing()
  {
   if(BuyPos.GroupTotal()>0&&SellPos.GroupTotal()>0)
     {

      if(Pos.GroupTotalProfit()>10)
        {
         Pos.GroupCloseAll(30);
        }
     }

  }
//+------------------------------------------------------------------+
double LotsMM()
  {
   double L = MathCeil((AccountInfoDouble(ACCOUNT_MARGIN_FREE) * Risk) / 1000) / 40;
   if(L < SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN))
      L = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN);
   if(L > SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MAX))
      L = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MAX);
   return (tools.NormalizeVolume(L));
  }
//+------------------------------------------------------------------+
