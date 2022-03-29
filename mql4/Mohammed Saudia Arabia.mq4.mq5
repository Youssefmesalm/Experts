//+------------------------------------------------------------------+
//|                                                    Mohammed .mq5 |
//|                                   Copyright 2022, Yousuf Mesalm. |
//|                          https://www.mql5.com/en/users/20163440  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, YouSuf Mesalm."
#property link      "https://www.mql5.com/en/users/20163440"
#property version   "1.00"

#include  <MQL_Easy\Execute\Execute.mqh>
#include  <MQL_Easy\Position\Position.mqh>
#include  <MQL_Easy\Order\Order.mqh>

// inputs
sinput string set1 = "Currency Pairs Settings";
input string Suffix="";
input string Perfix="";
input string CustomPairs = "EURUSD,USDCHF,USDCAD,USDJPY,GBPUSD";
sinput string set2 = "Trading Settings";
input double lot = 0.1;
input int TradingLevelsNumbers=10;
input int GapBetweenLevels=100;
input int AveragingTp=10;
input int trailingStop=50;  //trailing stop for Profit trades
input long magic_Number = 2020;

//global variables
int TB=0,TS=0;
// Arrays
string Symbols[];

// Class object
CExecute *trades[];
CPosition *Positions[];
CPosition *SellPositions[];
CPosition *BuyPositions[];
COrder *Pendings[];
COrder *SellPendings[];
COrder *BuyPendings[];
CUtilities *tools[];
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
   ArrayResize(Pendings,size,size);
   ArrayResize(tools,size,size);

   for(int i=0; i<size; i++)
     {
      Symbols[i]=Perfix+Symbols[i]+Suffix;
      trades[i] = new CExecute(Symbols[i], magic_Number);
      BuyPositions[i] = new CPosition(Symbols[i], magic_Number, GROUP_POSITIONS_BUYS);
      SellPositions[i] = new CPosition(Symbols[i], magic_Number, GROUP_POSITIONS_SELLS);
      Positions[i] = new CPosition(Symbols[i], magic_Number, GROUP_POSITIONS_ALL);
      Pendings[i]=new COrder(Symbols[i],magic_Number,GROUP_ORDERS_ALL);
      tools[i] = new CUtilities(Symbols[i]);
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
      delete(Pendings[i]);
      delete(tools[i]);
     }
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   int size= ArraySize(Symbols);
   for(int i=0; i<size; i++)
     {
      int TotalPositions=Positions[i].GroupTotal();
      int TotalPendings=Pendings[i].GroupTotal();
      if(TotalPendings==0&&TotalPositions==0)
        {
         double upPrice=tools[i].Bid();
         double dnPrice=tools[i].Bid();
         double ssl=tools[i].Bid()+(GapBetweenLevels*(TradingLevelsNumbers+0.5)*tools[i].Pip());
         double bsl=tools[i].Ask()-(GapBetweenLevels*(TradingLevelsNumbers+0.5)*tools[i].Pip());
         bool first=true;
         for(int x=0; x<TradingLevelsNumbers; x++)
           {
            upPrice =first?(upPrice+(GapBetweenLevels/2)*tools[i].Pip()):upPrice+(GapBetweenLevels*tools[i].Pip());
            dnPrice =first?(dnPrice-(GapBetweenLevels/2)*tools[i].Pip()):dnPrice-(GapBetweenLevels*tools[i].Pip());
            trades[i].Order(TYPE_ORDER_BUYSTOP,lot,upPrice,bsl,0,SLTP_PRICE,0,30,(string)x);
            trades[i].Order(TYPE_ORDER_SELLLIMIT,lot,upPrice,ssl,0,SLTP_PRICE,0,30,(string)x);
            trades[i].Order(TYPE_ORDER_BUYLIMIT,lot,dnPrice,bsl,0,SLTP_PRICE,0,30,"-"+(string)x);
            trades[i].Order(TYPE_ORDER_SELLSTOP,lot,dnPrice,ssl,0,SLTP_PRICE,0,30,"-"+(string)x);
            first=false;
           }

        }
      //Trailing
      Traliling(BuyPositions[i],SellPositions[i],tools[i]);
      Closing(BuyPositions[i],SellPositions[i],tools[i],Pendings[i]);
      if(Positions[i].GroupTotal()==0&&Pendings[i].GroupTotal()<TradingLevelsNumbers*4)
        {
         Pendings[i].GroupCloseAll(20);
        }

     }

  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Traliling(CPosition & BuyPos,CPosition & SellPos, CUtilities & tool)
  {
// Positions numbers
   int totalBuy = BuyPos.GroupTotal();
   int totalSell = SellPos.GroupTotal();
//
   if(TB>0&&totalBuy==0)
     {
      TB=0;
     }
   if(TS>0&&totalSell==0)
     {
      TS=0;
     }
//Buy trailing
   if(totalBuy>=2&&TB<totalBuy&&BuyPos.GroupTotalProfit()>0)
     {
      double buyPriceOpen=0;
      //Get High Buy PriceOpen
      for(int i = 0; i < totalBuy; i++)
        {
         if(BuyPos.SelectByIndex(i))
           {
            if(BuyPos[i].GetPriceOpen()>buyPriceOpen)
              {
               buyPriceOpen=BuyPos[i].GetPriceOpen();
              }
           }
        }

      double sl=buyPriceOpen -(trailingStop*tool.Pip());
      TB=totalBuy;
      for(int i = 0; i < totalBuy; i++)
        {
         if(BuyPos.SelectByIndex(i))
           {
            BuyPos.Modify(sl,BuyPos.GetTakeProfit(),SLTP_PRICE);

           }
        }
     }
//Sell Trailing
   if(totalSell>=2&&TS<totalSell&&SellPos.GroupTotalProfit()>0)
     {
      double sellPriceOpen=0;
      //Get low sell PriceOpen
      for(int i = 0; i < totalSell; i++)
        {
         if(SellPos.SelectByIndex(i))
           {
            if(sellPriceOpen==0)
              {
               sellPriceOpen=SellPos[i].GetPriceOpen();
              }

            if(SellPos[i].GetPriceOpen()<sellPriceOpen)
              {
               sellPriceOpen=SellPos[i].GetPriceOpen();
              }
           }
        }
      double sl=sellPriceOpen +(trailingStop*tool.Pip());
      TS=totalSell;
      for(int i = 0; i < totalSell; i++)
        {
         if(SellPos.SelectByIndex(i))
           {
            SellPos.Modify(sl,SellPos.GetTakeProfit(),SLTP_PRICE);

           }
        }
     }
  }
//+------------------------------------------------------------------+
void Closing(CPosition & BuyPos,CPosition & SellPos, CUtilities & tool,COrder & Pending)
  {
// Positions numbers
   int totalBuy = BuyPos.GroupTotal();
   int totalSell = SellPos.GroupTotal();
   double profitpoint=0;
// logics
   if(totalSell>0&&totalBuy==0)
     {
      if(SellPos.GroupTotalProfit()>0)
        {
         for(int i=0; i<totalSell; i++)
           {
            profitpoint+=SellPos[i].GetPriceOpen()-tool.Bid();
           }
         if(profitpoint>=AveragingTp*tool.Pip())
           {
            SellPos.GroupCloseAll(20);
            Pending.GroupCloseAll(20);
           }

        }
     }
   else
      if(totalBuy>0&&totalSell==0)
        {
         if(BuyPos.GroupTotalProfit()>0)
           {
            for(int i=0; i<totalBuy; i++)
              {
               profitpoint+=tool.Bid()-BuyPos[i].GetPriceOpen();
              }
            if(profitpoint>=AveragingTp*tool.Pip())
              {
               BuyPos.GroupCloseAll(20);
               Pending.GroupCloseAll(20);
              }

           }
        }
  }
//+------------------------------------------------------------------+
