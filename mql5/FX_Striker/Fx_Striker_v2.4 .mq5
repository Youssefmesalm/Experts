//+------------------------------------------------------------------+
//|                                                Fx Striker v1.mq5 |
//|                          Copyright 2021, davidhunterfx@gmail.com |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, davidhunterfx@gmail.com"
#property link      "https://t.me/forextradehunter"
#property strict
//#property version   "1.20"
#property strict
#define R3_NAME "Daily R3"
#define R2_NAME "Daily R2"
#define R1_NAME "Daily R1"
#define PIVOT_NAME "Daily PP"
#define S1_NAME "Daily S1"
#define S2_NAME "Daily S2"
#define S3_NAME "Daily S3"

//Version 2.1 : fixed the middle part of the text
//Version 2.2 : fixed TP & Sl showing 0 when strat 1 with sup2/res2 or sup3/res3
//V2.3 : hedge with all the strats
enum tpmode
  {
   TPMode1,//Res/Sup1
   TPMode2,//Res/Sup2
   TPMode3,//Res/Sup3
   FixTP//Fix Take Profit
  };
enum sellsl
  {
   SPointSL,//Fix Stop Loss
   ResLevel1,//Resistance1
   ResLevel2,//Resistance2
   ResLevel3//Resistance3
  };
enum buysl
  {
   BPointSL,//Fix Stop Loss
   SupLevel1,//Support1
   SupLevel2,//Support2
   SupLevel3//Support3
  };
enum lpmode
  {
   Strategy1,
   Strategy2,
   Strategy3
  };

enum bar
  {
   Current, //Current
   Closed      //Closed
  };

enum choosetrail
  {
   New,     //Max
   Original
  };

#include <Trade\PositionInfo.mqh>
#include <Trade\Trade.mqh>
#include <Trade\SymbolInfo.mqh>

CTrade  trade;

input string Set0 = "-------General Setting------";//==General Settings===
input bool TradeHedge = true;        //Trade Hedge
input bool TradeCrossovers = true;   //Trade Crossovers
input bool TradeBreakout = true;     //Trade Breakouts
input bool TradeRetests = true;      //Trade Retests/Retracements
input bool   Allow_Multi_Trade = false;//Allow Multiple Crossover Trades
input bool   Allow_Multi_Cons_Trade = false;//Allow Multiple Consolidation (Breakout+Retest) Trades
input bool   Allow_Multi_X_Trade = false;//Allow Multiple Crossover & Consolidation(Breakout+Retest) Trades

input string dt;//.
input buysl  Buy_SL_Mode  = SupLevel3;//Buy SL Mode
input sellsl Sell_SL_Mode = ResLevel3;//Sell SL Mode
input int    StopLoss   = 0;//Fix Stop Loss(0 means disable)
input int    TakeProfit = 100;//Fix Take Profit(0 means disable)
input lpmode StrategyType    = Strategy3;//Strategy Type
input double LotSize1 = 0.01;//1st Trade Lot Size
input tpmode TakeProfitMode1 = TPMode1;//1st Trade Take Profit
//...
input double LotSize2 = 0.01;//2nd Trade Lot Size
input tpmode TakeProfitMode2 = TPMode2;//2nd Trade Take Profit
//...
input double LotSize3 = 0.01;//3th Trade Lot Size
input tpmode TakeProfitMode3 = TPMode3;//3th Trade Take Profit
//...
input int    MagicNumber = 123;//Magic Number
input bool   Close_By_Reverse_Signal = false;//Close By Reverse Signal

input string ee = "-----Hedge Settings------";//==Hedge Settings===
input double distance_from_consolidation=50;//SL Distance from consolidation box (in Points)
input double use_trail_hedge=true;

input string TrailSet = "-----Crossover Trailing Setting------";//==Crossover Trailing Settings===
input bool trail_stop = true;//Use Trail Stop
input choosetrail TrailMode = Original; //Trail Mode
input int ExtTrailingStep = 50;//Trail Step
input double TrailPercentage = 50; //3rd trade Trail percentage
input int AllowancePoints = 1; //Breakeven Allowance Points

input string dty;//.
input string ConsolSet = "-----Consolidation Setting------";//==Consolidation Settings===
input int Consolidation_Points = 500; //Range size (points)
input int Consolidation_Bars = 20;    //Range length (bars)
input int ExtraPoints = 50;           //Trade Range Allowance Points
input color Consolidation_Color = clrOrangeRed; //Range Color
input bool Consolidation_Fill = true; //Range Fill

input string dtx= "-----Consolidation Trading Setting------";//
                  input buysl  Con_Buy_SL_Mode  = SupLevel3;//Buy SL Mode
input sellsl Con_Sell_SL_Mode = ResLevel3;//Sell SL Mode
input int    Con_StopLoss   = 0;//Fix Stop Loss(0 means disable)
input int    Con_TakeProfit = 100;//Fix Take Profit(0 means disable)
input lpmode Con_StrategyType    = Strategy3;//Strategy Type
input double Con_LotSize1 = 0.01;//1st Trade Lot Size
input tpmode Con_TakeProfitMode1 = TPMode1;//1st Trade Take Profit
//...
input double Con_LotSize2 = 0.01;//2nd Trade Lot Size
input tpmode Con_TakeProfitMode2 = TPMode2;//2nd Trade Take Profit
//...
input double Con_LotSize3 = 0.01;//3th Trade Lot Size
input tpmode Con_TakeProfitMode3 = TPMode3;//3th Trade Take Profit

input string Con_TrailSet = "-----Consolidation Trailing Setting------";//==Consolidation Trailing Settings===
input bool Con_trail_stop = true;//Use Trail Stop
input choosetrail Con_TrailMode = Original; //Trail Mode
input int Con_ExtTrailingStep = 50;//Trail Step
input double Con_TrailPercentage = 50; //3rd trade Trail percentage
input int Con_AllowancePoints = 1; //Breakeven Allowance Points

input string dtz;//.
input string MSet = "-----Moving Average Settings------";//==MA Settings===
input bar UseCandle                = Closed;  //Use Candle
input int    MAPeriod1             = 8;//Moving Period1
input ENUM_APPLIED_PRICE MAPrice1  = PRICE_CLOSE;//Applied Price1
input ENUM_MA_METHOD     MAMethod1 = MODE_SMA;//MA Method1
//...
input int    MAPeriod2             = 39;//Moving Period2
input ENUM_APPLIED_PRICE MAPrice2  = PRICE_CLOSE;//Applied Price2
input ENUM_MA_METHOD     MAMethod2 = MODE_SMA;//MA Method2

input string dtz1;//.
input string PSet = "-----Pivot Setting------";//==Pivot Settings===
input int ShiftHrs = 5;   // Pivot day shift
input bool  ShowLine        = true;
input bool  ShowText        = true;
input int   FontSize        = 8;
input color SupportColor    = clrGreen;//Support Level Color
input color ResistanceColor = clrRed;//Resistance Level Color
input color PivotColor      = clrGray;//Pivot Level Color
input color FontColor       = clrGray;

input string                               Time_SetUP = "------Trading Time Regulation------";
input bool                                 UseTimeFilter=false;
input string                               TimeStart="12:00";
input string                               TimeStop="14:00";
input string dtz2;//.
input string FilterSet = "-----MA Filter Setting------";//==MA Filter Settings===
input bool UseMAFilter = true; //Use MA Filter
input int FilterPeriod = 50; //Period
input int FilterShift= 0; //Shift
input ENUM_MA_METHOD FilterMethod= MODE_EMA; //Method
input ENUM_APPLIED_PRICE FilterAppliedPrice= PRICE_CLOSE; //Applied Price

enum ptype {BUYSTOP,BUYLIMIT,SELLSTOP,SELLLIMIT};
string Dash_Set         = "GUI Setting";//GUI Setting
int    Graphic_HPos     = 20;//Graphic Horizental Position
int    Graphic_VPos     = 20;//Graphic Vertical Position
int    Graphic_HSize    = 200;//Graphic Horizental Size
int    Graphic_VSize    = 170;//Graphic Vertical Size
color  DDBGColor        = clrWhiteSmoke;//Drop Down BG Color
string Font             = "Arial Bold";//Font
color  PanelBGColor     = clrLavender;//Panel BG Color
int    row              = 25;//Row Distance
string   datainfo[5];
double FirstTP = 0;
//+----------------------Local variable------------------------------+
//Hello this is new change
datetime LastTime;
int      Trend=2;
//+------------------------------------------------------------------+
// Input(s)
// positive value moves pivot day earlier

// Buffers for levels
double Res3[],Res2[],Res1[],Pivot[],Sup1[],Sup2[],Sup3[];

double PDayHigh,PDayLow;
string ThisSymbol;
datetime BarTime,PivotDayStartTime;
int VisibleBars,DayStartBar,LeftMostBar,RightMostBar;
double BuyFirstTP  = 0;
double BuySecondTP = 0;
double BuyThirdTP  = 0;
//...
double SellFirstTP  = 0;
double SellSecondTP = 0;

double SellThirdTP  = 0;

bool FirstTime = true;

#define OP_BUY ORDER_TYPE_BUY
#define OP_SELL ORDER_TYPE_SELL
#define OP_BUYSTOP ORDER_TYPE_BUY_STOP
#define OP_SELLSTOP ORDER_TYPE_SELL_STOP
#define OP_BUYLIMIT ORDER_TYPE_BUY_LIMIT
#define OP_SELLLIMIT ORDER_TYPE_SELL_LIMIT

#include <Trade\SymbolInfo.mqh>
#include <Trade\PositionInfo.mqh>
#include <Trade\Trade.mqh>// to make orders

CTrade         m_trade;                        //trading object
CPositionInfo other_m_position;
CPositionInfo  m_position;                   // trade position object. Alter trade position object
CSymbolInfo    m_symbol;                     // symbol info object
COrderInfo     m_order;                      //order object

MqlTradeRequest irequest;
MqlTradeResult iresult;
MqlTradeCheckResult checkResult;

#define ID "FxS-1.7-"
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
int OnInit()
  {
//---

   DoPivot();

   FirstTime = true;

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   Comment("");

//   if(reason!=3)
   Del(ID);

   DeleteOrders(OP_BUYSTOP);
   DeleteOrders(OP_SELLSTOP);
//---
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void OnTick()
  {

//---
   if(LastTime!=iBars(_Symbol,PERIOD_CURRENT) || FirstTime)
     {
      FirstTime = false;

      Trend=2;
      LastTime=iBars(_Symbol,PERIOD_CURRENT);
      DoPivot();
      CheckSignal(Symbol());
      Consolidation();
      GetOrder(Symbol(),LotSize1);
      MATrades();
     }

   BreakoutTrade();
   DoTrail1();
   DoTrail2();

   TrailHedge();
   DeleteOppositeOrder();

//---
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Del(string r6)
  {
   int t1;

   t1=ObjectsTotal(0,0);
   while(t1>=0)
     {
      if(StringFind(ObjectName(0,t1,0),r6,0)!=-1)
        {
         ObjectDelete(0,ObjectName(0,t1));
        }
      t1--;
     }
  }

//+------------------------------------------------------------------+
int GetOrder(string sym,double lot)
  {
   double SL=0;
   double TP=0;
   int    Ticket=0;
   int    TT = TotalOrder(0,sym,"C:")+TotalOrder(1,sym,"C:");
   int    TT2 = PendingTrades(sym,"R:")+PendingTrades(sym,"B:");
   double Ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   double Bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);

   if(TradeCrossovers)
     {
      if((!Consolidation() && Trend==0) && ((TT2==0 && (TT==0 || Allow_Multi_Trade)) || (Allow_Multi_X_Trade && (TT==0 || Allow_Multi_Trade))))
         if(Ask<BuySecondTP)
           {
            if(Buy_SL_Mode==BPointSL)
               if(StopLoss>0)
                  SL = Ask-StopLoss*_Point;
            //...
            if(Buy_SL_Mode==SupLevel1)
               SL = SellFirstTP;
            if(Buy_SL_Mode==SupLevel2)
               SL = SellSecondTP;
            if(Buy_SL_Mode==SupLevel3)
               SL = SellThirdTP;
            //...
            if(TakeProfit>0)
               TP=Ask+TakeProfit*_Point;
            //...
            //TP = BuyFirstTP;
            double TP1=0;
            double TP2=0;
            double TP3=0;
            //...
            if(TakeProfitMode1==TPMode1)
              {
               TP1 = BuyFirstTP;
              }
            //ADDED OPTION
            if(TakeProfitMode1==TPMode2)
              {
               TP1 = BuySecondTP;
              }

            if(TakeProfitMode1==TPMode3)
              {
               TP1 = BuyThirdTP;
              }
            //END ADDED OPTION

            if(TakeProfitMode2==TPMode2)
               TP2 = BuySecondTP;
            if(TakeProfitMode3==TPMode3)
               TP3 = BuyThirdTP;
            //...
            if(TakeProfitMode1==FixTP)
               TP1 = TP;
            if(TakeProfitMode2==FixTP)
               TP2 = TP;
            if(TakeProfitMode3==FixTP)
               TP3 = TP;
            //...
            if(TP1>200000)
               TP1 = TP;
            if(TP2>200000)
               TP2 = TP;
            if(TP3>200000)
               TP3 = TP;
            //...
            if(Validity(sym,LotValidity(sym,lot),OP_BUY,Ask,SL,TP)==true)
              {
               if(StrategyType==Strategy1)
                 {
                  if(Ask<TP1)
                     Ticket=Trade(sym,OP_BUY,LotValidity(sym,LotSize1),Ask,0,SL,TP1,"_1C:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,0,clrBlue);
                  else
                     Print("No trade. Buy Entry is above the TP 1");
                 }
               if(StrategyType==Strategy2)
                 {
                  if(Ask<TP1)
                     Ticket=Trade(sym,OP_BUY,LotValidity(sym,LotSize1),Ask,0,SL,TP1,"_2C:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,0,clrBlue);
                  else
                     Print("No trade. Buy Entry is above the TP 1");

                  Ticket=Trade(sym,OP_BUY,LotValidity(sym,LotSize2),Ask,0,SL,TP2,"_3C:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,0,clrBlue);
                 }
               if(StrategyType==Strategy3)
                 {
                  if(Ask<TP1)
                     Ticket=Trade(sym,OP_BUY,LotValidity(sym,LotSize1),Ask,0,SL,TP1,"_1C:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,0,clrBlue);
                  else
                     Print("No trade. Buy Entry is above the TP 1");

                  Ticket=Trade(sym,OP_BUY,LotValidity(sym,LotSize2),Ask,0,SL,TP2,"_2C:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,0,clrBlue);
                  Ticket=Trade(sym,OP_BUY,LotValidity(sym,LotSize3),Ask,0,SL,TP3,"_3C:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,0,clrBlue);
                 }
              }
           }
      //...
      if((!Consolidation() && Trend==1) && (TT==0 || Allow_Multi_Trade==true))
         if(Bid>SellSecondTP)
           {
            if(Sell_SL_Mode==SPointSL)
               if(StopLoss>0)
                  SL=Bid+StopLoss*_Point;
            //...
            if(Sell_SL_Mode==ResLevel1)
               SL = BuyFirstTP;
            if(Sell_SL_Mode==ResLevel2)
               SL = BuySecondTP;
            if(Sell_SL_Mode==ResLevel3)
               SL = BuyThirdTP;
            //...
            if(TakeProfit>0)
               TP=Bid-TakeProfit*_Point;
            //...
            //TP = SellFirstTP;
            double TP1=0;
            double TP2=0;
            double TP3=0;
            if(TakeProfitMode1==TPMode1)
               TP1 = SellFirstTP;
            //ADDED OPTION FOR THE SELL
            if(TakeProfitMode1==TPMode2)
               TP1 = SellSecondTP;
            if(TakeProfitMode1==TPMode3)
               TP1 = SellThirdTP;

            if(TakeProfitMode2==TPMode2)
               TP2 = SellSecondTP;
            if(TakeProfitMode3==TPMode3)
               TP3 = SellThirdTP;
            //...
            if(TakeProfitMode1==FixTP)
               TP1 = TP;
            if(TakeProfitMode2==FixTP)
               TP2 = TP;
            if(TakeProfitMode3==FixTP)
               TP3 = TP;
            //...
            if(TP1>200000)
               TP1 = TP;
            if(TP2>200000)
               TP2 = TP;
            if(TP3>200000)
               TP3 = TP;
            //...
            if(Validity(sym,LotValidity(sym,lot),OP_SELL,Bid,SL,TP)==true)
              {
               if(StrategyType==Strategy1)
                 {
                  Print(TP1);
                  if(Bid>TP1)
                     Ticket=Trade(sym,OP_SELL,LotValidity(sym,LotSize1),Bid,0,SL,TP1,"_1C:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,0,clrRed);
                  else
                     Print("No trade. Sell Entry is above the TP 1");
                 }
               if(StrategyType==Strategy2)
                 {
                  if(Bid>TP1)
                     Ticket=Trade(sym,OP_SELL,LotValidity(sym,LotSize1),Bid,0,SL,TP1,"_2C:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,0,clrRed);
                  else
                     Print("No trade. Sell Entry is above the TP 1");

                  Ticket=Trade(sym,OP_SELL,LotValidity(sym,LotSize2),Bid,0,SL,TP2,"_3C:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,0,clrRed);
                 }
               if(StrategyType==Strategy3)
                 {
                  if(Bid>TP1)
                     Ticket=Trade(sym,OP_SELL,LotValidity(sym,LotSize1),Bid,0,SL,TP1,"_1C:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,0,clrRed);
                  else
                     Print("No trade. Sell Entry is above the TP 1");

                  Ticket=Trade(sym,OP_SELL,LotValidity(sym,LotSize2),Bid,0,SL,TP2,"_2C:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,0,clrRed);
                  Ticket=Trade(sym,OP_SELL,LotValidity(sym,LotSize3),Bid,0,SL,TP3,"_3C:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,0,clrRed);
                 }
              }
           }
     }
   return(Ticket);
  }

int TheBars;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void BreakoutTrade(int shift=2)
  {
   if(TheBars==iBars(_Symbol,PERIOD_CURRENT))
      return;

   TheBars=iBars(_Symbol,PERIOD_CURRENT);

   int BarHighShift = iHighest(_Symbol,PERIOD_CURRENT,MODE_HIGH,Consolidation_Bars,shift);
   int BarLowShift = iHighest(_Symbol,PERIOD_CURRENT,MODE_LOW,Consolidation_Bars,shift);

   double BarHigh = iHigh(_Symbol,PERIOD_CURRENT,BarHighShift);
   double BarLow = iLow(_Symbol,PERIOD_CURRENT,BarLowShift);

   double TheClose = iClose(_Symbol,PERIOD_CURRENT,1);
   double TheOpen = iOpen(_Symbol,PERIOD_CURRENT,1);

   string TheName = ID+"Consolidation-xx";

//---
   double SL=0;
   double TP=0;
   int    Ticket=-1;
   string sym = _Symbol;
   double lot = Con_LotSize1;
   int    TT = TotalOrder(0,sym,"C:")+TotalOrder(1,sym,"C:");
   int    TT2 = PendingTrades(sym,"R:")+PendingTrades(sym,"B:");
   datetime TimeDifference = iTime(_Symbol,PERIOD_D1,0)-iTime(_Symbol,PERIOD_D1,1);
   datetime ExpireTime = iTime(_Symbol,PERIOD_D1,0)+TimeDifference;

   if(ObjectFind(0,TheName)==0)
     {
      double PriceHigh = ObjectGetDouble(0,TheName,OBJPROP_PRICE,0);
      double PriceLow = ObjectGetDouble(0,TheName,OBJPROP_PRICE,1);
      datetime Time1 = (datetime)ObjectGetInteger(0,TheName,OBJPROP_TIME,0);
      datetime Time2 = (datetime)ObjectGetInteger(0,TheName,OBJPROP_TIME,1);

      double BuyPrice = PriceLow+Consolidation_Points*_Point;
      double SellPrice = PriceHigh-Consolidation_Points*_Point;

      string CreateTime = (string)((int)ObjectGetInteger(0,TheName,OBJPROP_CREATETIME));
      //---

      if((TT==0 && (TT2==0 || Allow_Multi_Cons_Trade)) || (Allow_Multi_X_Trade && (TT2==0 || Allow_Multi_Cons_Trade)))
        {
         if(TradeRetests)
           {
            if(TheClose>BuyPrice)
              {
               Print("Bullish breakout from consolidation zone");

               if(NoTrade(OP_BUYLIMIT,"R:"))
                 {
                  if(Con_Buy_SL_Mode==BPointSL)
                     if(Con_StopLoss>0)
                        SL = BuyPrice-Con_StopLoss*_Point;
                  //...
                  if(Con_Buy_SL_Mode==SupLevel1)
                     SL = SellFirstTP;
                  if(Con_Buy_SL_Mode==SupLevel2)
                     SL = SellSecondTP;
                  if(Con_Buy_SL_Mode==SupLevel3)
                     SL = SellThirdTP;
                  //...
                  if(Con_TakeProfit>0)
                     TP=BuyPrice+Con_TakeProfit*_Point;
                  //...
                  //TP = BuyFirstTP;
                  double TP1=0;
                  double TP2=0;
                  double TP3=0;
                  //...
                  if(Con_TakeProfitMode1==TPMode1)
                    {
                     TP1 = BuyFirstTP;
                    }
                  if(Con_TakeProfitMode1==TPMode2)
                    {
                     TP1 = BuySecondTP;
                    }
                  if(Con_TakeProfitMode1==TPMode3)
                    {
                     TP1 = BuyThirdTP;
                    }

                  if(Con_TakeProfitMode2==TPMode2)
                     TP2 = BuySecondTP;
                  if(Con_TakeProfitMode3==TPMode3)
                     TP3 = BuyThirdTP;
                  //...
                  if(Con_TakeProfitMode1==FixTP)
                     TP1 = TP;
                  if(Con_TakeProfitMode2==FixTP)
                     TP2 = TP;
                  if(Con_TakeProfitMode3==FixTP)
                     TP3 = TP;
                  //...
                  if(TP1>200000)
                     TP1 = TP;
                  if(TP2>200000)
                     TP2 = TP;
                  if(TP3>200000)
                     TP3 = TP;
                  //...
                  if(Validity(sym,LotValidity(sym,lot),OP_BUYLIMIT,BuyPrice,SL,TP)==true)
                    {
                     if(Con_StrategyType==Strategy1)
                       {
                        if(BuyPrice<TP1)
                           Ticket=Trade(sym,OP_BUYLIMIT,LotValidity(sym,Con_LotSize1),BuyPrice,0,SL,TP1,CreateTime+"_1R:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrBlue);
                        else
                           Print("No trade 1. Buy Entry is above the TP 1");
                       }
                     if(Con_StrategyType==Strategy2)
                       {
                        if(BuyPrice<TP1)
                           Ticket=Trade(sym,OP_BUYLIMIT,LotValidity(sym,Con_LotSize1),BuyPrice,0,SL,TP1,CreateTime+"_2R:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrBlue);
                        else
                           Print("No trade 1. Buy Entry is above the TP 1");

                        Ticket=Trade(sym,OP_BUYLIMIT,LotValidity(sym,Con_LotSize2),BuyPrice,0,SL,TP2,CreateTime+"_3R:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrBlue);
                       }
                     if(Con_StrategyType==Strategy3)
                       {
                        if(BuyPrice<TP1)
                           Ticket=Trade(sym,OP_BUYLIMIT,LotValidity(sym,Con_LotSize1),BuyPrice,0,SL,TP1,CreateTime+"_1R:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrBlue);
                        else
                           Print("No trade 1. Buy Entry is above the TP 1");

                        if(BuyPrice<TP2)
                           Ticket=Trade(sym,OP_BUYLIMIT,LotValidity(sym,Con_LotSize2),BuyPrice,0,SL,TP2,CreateTime+"_2R:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrBlue);
                        else
                           Print("No trade 2. Buy Entry is above the TP 2");

                        if(BuyPrice<TP3)
                           Ticket=Trade(sym,OP_BUYLIMIT,LotValidity(sym,Con_LotSize3),BuyPrice,0,SL,TP3,CreateTime+"_3R:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrBlue);
                        else
                           Print("No trade 3. Buy Entry is above the TP 3");
                       }
                    }
                 }
              }

            //---

            if(TheClose<SellPrice)
              {
               Print("Bearish breakout from consolidation zone");

               if(NoTrade(OP_SELLLIMIT,"R:"))
                 {
                  if(Con_Sell_SL_Mode==SPointSL)
                     if(Con_StopLoss>0)
                        SL=SellPrice+Con_StopLoss*_Point;
                  //...
                  if(Con_Sell_SL_Mode==ResLevel1)
                     SL = BuyFirstTP;
                  if(Con_Sell_SL_Mode==ResLevel2)
                     SL = BuySecondTP;
                  if(Con_Sell_SL_Mode==ResLevel3)
                     SL = BuyThirdTP;
                  //...
                  if(Con_TakeProfit>0)
                     TP=SellPrice-Con_TakeProfit*_Point;
                  //...
                  //TP = SellFirstTP;
                  double TP1=0;
                  double TP2=0;
                  double TP3=0;
                  if(Con_TakeProfitMode1==TPMode1)
                     TP1 = SellFirstTP;
                  if(Con_TakeProfitMode1==TPMode2)
                    {
                     TP1 = SellSecondTP;
                    }
                  if(Con_TakeProfitMode1==TPMode3)
                    {
                     TP1 = SellThirdTP;
                    }

                  if(Con_TakeProfitMode2==TPMode2)
                     TP2 = SellSecondTP;
                  if(Con_TakeProfitMode3==TPMode3)
                     TP3 = SellThirdTP;
                  //...
                  if(Con_TakeProfitMode1==FixTP)
                     TP1 = TP;
                  if(Con_TakeProfitMode2==FixTP)
                     TP2 = TP;
                  if(Con_TakeProfitMode3==FixTP)
                     TP3 = TP;
                  //...
                  if(TP1>200000)
                     TP1 = TP;
                  if(TP2>200000)
                     TP2 = TP;
                  if(TP3>200000)
                     TP3 = TP;
                  //...
                  if(Validity(sym,LotValidity(sym,lot),OP_SELLLIMIT,SellPrice,SL,TP)==true)
                    {
                     if(Con_StrategyType==Strategy1)
                       {
                        if(SellPrice>TP1)
                           Ticket=Trade(sym,OP_SELLLIMIT,LotValidity(sym,Con_LotSize1),SellPrice,0,SL,TP1,CreateTime+"_1R:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrRed);
                        else
                           Print("No trade 1. Sell Entry is below the TP 1");
                       }
                     if(Con_StrategyType==Strategy2)
                       {
                        if(SellPrice>TP1)
                           Ticket=Trade(sym,OP_SELLLIMIT,LotValidity(sym,Con_LotSize1),SellPrice,0,SL,TP1,CreateTime+"_2R:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrRed);
                        else
                           Print("No trade 1. Sell Entry is below the TP 1");

                        if(SellPrice>TP2)
                           Ticket=Trade(sym,OP_SELLLIMIT,LotValidity(sym,Con_LotSize2),SellPrice,0,SL,TP2,CreateTime+"_3R:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrRed);
                        else
                           Print("No trade 2. Sell Entry is below the TP 2");
                       }
                     if(Con_StrategyType==Strategy3)
                       {
                        Print("Going for the sell");
                        if(SellPrice>TP1)
                           Ticket=Trade(sym,OP_SELLLIMIT,LotValidity(sym,Con_LotSize1),SellPrice,0,SL,TP1,CreateTime+"_1R:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrRed);
                        else
                           Print("No trade 1. Sell Entry is below the TP 1");

                        if(SellPrice>TP2)
                           Ticket=Trade(sym,OP_SELLLIMIT,LotValidity(sym,Con_LotSize2),SellPrice,0,SL,TP2,CreateTime+"_2R:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrRed);
                        else
                           Print("No trade 2. Sell Entry is below the TP 2");

                        if(SellPrice>TP3)
                           Ticket=Trade(sym,OP_SELLLIMIT,LotValidity(sym,Con_LotSize3),SellPrice,0,SL,TP3,CreateTime+"_3R:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrRed);
                        else
                           Print("No trade 3. Sell Entry is below the TP 3");
                       }

                    }
                 }
              }
           }

         //---
         //---

         if(TradeBreakout)
           {
            //---
            //---BUY STOP---//
            if(NoTrade(OP_BUYSTOP,"B:"))
              {
               BuyPrice = BuyPrice + ExtraPoints*_Point;

               if(Con_Buy_SL_Mode==BPointSL)
                  if(Con_StopLoss>0)
                     SL = BuyPrice-Con_StopLoss*_Point;
               //...
               if(Con_Buy_SL_Mode==SupLevel1)
                  SL = SellFirstTP;
               if(Con_Buy_SL_Mode==SupLevel2)
                  SL = SellSecondTP;
               if(Con_Buy_SL_Mode==SupLevel3)
                  SL = SellThirdTP;
               //...
               if(Con_TakeProfit>0)
                  TP=BuyPrice+Con_TakeProfit*_Point;
               //...
               //TP = BuyFirstTP;
               double TP1=0;
               double TP2=0;
               double TP3=0;
               //...
               if(Con_TakeProfitMode1==TPMode1)
                 {
                  TP1 = BuyFirstTP;
                 }
               if(Con_TakeProfitMode1==TPMode2)
                 {
                  TP1 = BuySecondTP;
                 }
               if(Con_TakeProfitMode1==TPMode3)
                 {
                  TP1 = BuyThirdTP;
                 }

               if(Con_TakeProfitMode2==TPMode2)
                  TP2 = BuySecondTP;
               if(Con_TakeProfitMode3==TPMode3)
                  TP3 = BuyThirdTP;
               //...
               if(Con_TakeProfitMode1==FixTP)
                  TP1 = TP;
               if(Con_TakeProfitMode2==FixTP)
                  TP2 = TP;
               if(Con_TakeProfitMode3==FixTP)
                  TP3 = TP;
               //...
               if(TP1>200000)
                  TP1 = TP;
               if(TP2>200000)
                  TP2 = TP;
               if(TP3>200000)
                  TP3 = TP;
               //...
               if(Validity(sym,LotValidity(sym,lot),OP_BUYSTOP,BuyPrice,SL,TP)==true)
                 {
                  if(Con_StrategyType==Strategy1)
                    {
                     if(BuyPrice<TP1)
                        Ticket=Trade(sym,OP_BUYSTOP,LotValidity(sym,Con_LotSize1),BuyPrice,0,SL,TP1,CreateTime+"_1B:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrBlue);
                     else
                        Print("No trade 1. Buy Entry is above the TP 1");
                    }
                  if(Con_StrategyType==Strategy2)
                    {
                     if(BuyPrice<TP1)
                        Ticket=Trade(sym,OP_BUYSTOP,LotValidity(sym,Con_LotSize1),BuyPrice,0,SL,TP1,CreateTime+"_2B:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrBlue);
                     else
                        Print("No trade 1. Buy Entry is above the TP 1");

                     Ticket=Trade(sym,OP_BUYSTOP,LotValidity(sym,Con_LotSize2),BuyPrice,0,SL,TP2,CreateTime+"_3B:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrBlue);
                    }
                  if(Con_StrategyType==Strategy3)
                    {
                     if(BuyPrice<TP1)
                        Ticket=Trade(sym,OP_BUYSTOP,LotValidity(sym,Con_LotSize1),BuyPrice,0,SL,TP1,CreateTime+"_1B:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrBlue);
                     else
                        Print("No trade 1. Buy Entry is above the TP 1");

                     if(BuyPrice<TP2)
                        Ticket=Trade(sym,OP_BUYSTOP,LotValidity(sym,Con_LotSize2),BuyPrice,0,SL,TP2,CreateTime+"_2B:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrBlue);
                     else
                        Print("No trade 2. Buy Entry is above the TP 2");

                     if(BuyPrice<TP3)
                        Ticket=Trade(sym,OP_BUYSTOP,LotValidity(sym,Con_LotSize3),BuyPrice,0,SL,TP3,CreateTime+"_3B:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrBlue);
                     else
                        Print("No trade 3. Buy Entry is above the TP 3");
                    }

                  //if(Ticket!=-1)
                  //   TradeBox(TheName+"_Perm:"+(string)Time1,Time1,PriceHigh,Time2,PriceLow);

                 }
              }
            //---
            //---SELL STOP---//
            if(NoTrade(OP_SELLSTOP,"B:"))
              {
               SellPrice = SellPrice - ExtraPoints*_Point;

               if(Con_Sell_SL_Mode==SPointSL)
                  if(Con_StopLoss>0)
                     SL=SellPrice+Con_StopLoss*_Point;
               //...
               if(Con_Sell_SL_Mode==ResLevel1)
                  SL = BuyFirstTP;
               if(Con_Sell_SL_Mode==ResLevel2)
                  SL = BuySecondTP;
               if(Con_Sell_SL_Mode==ResLevel3)
                  SL = BuyThirdTP;
               //...
               if(Con_TakeProfit>0)
                  TP=SellPrice-Con_TakeProfit*_Point;
               //...
               //TP = SellFirstTP;
               double TP1=0;
               double TP2=0;
               double TP3=0;
               if(Con_TakeProfitMode1==TPMode1)
                  TP1 = SellFirstTP;
               if(Con_TakeProfitMode1==TPMode2)
                  TP1 = SellSecondTP;
               if(Con_TakeProfitMode1==TPMode3)
                  TP1 = SellThirdTP;


               if(Con_TakeProfitMode2==TPMode2)
                  TP2 = SellSecondTP;
               if(Con_TakeProfitMode3==TPMode3)
                  TP3 = SellThirdTP;
               //...
               if(Con_TakeProfitMode1==FixTP)
                  TP1 = TP;
               if(Con_TakeProfitMode2==FixTP)
                  TP2 = TP;
               if(Con_TakeProfitMode3==FixTP)
                  TP3 = TP;
               //...
               if(TP1>200000)
                  TP1 = TP;
               if(TP2>200000)
                  TP2 = TP;
               if(TP3>200000)
                  TP3 = TP;
               //...
               if(Validity(sym,LotValidity(sym,lot),OP_SELLSTOP,SellPrice,SL,TP)==true)
                 {
                  if(Con_StrategyType==Strategy1)
                    {
                     if(SellPrice>TP1)
                        Ticket=Trade(sym,OP_SELLSTOP,LotValidity(sym,Con_LotSize1),SellPrice,0,SL,TP1,CreateTime+"_1B:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrRed);
                     else
                        Print("No trade 1. Sell Entry is below the TP 1");
                    }
                  if(Con_StrategyType==Strategy2)
                    {
                     if(SellPrice>TP1)
                        Ticket=Trade(sym,OP_SELLSTOP,LotValidity(sym,Con_LotSize1),SellPrice,0,SL,TP1,CreateTime+"_2B:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrRed);
                     else
                        Print("No trade 1. Sell Entry is below the TP 1");

                     if(SellPrice>TP2)
                        Ticket=Trade(sym,OP_SELLSTOP,LotValidity(sym,Con_LotSize2),SellPrice,0,SL,TP2,CreateTime+"_3B:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrRed);
                     else
                        Print("No trade 2. Sell Entry is below the TP 2");
                    }
                  if(Con_StrategyType==Strategy3)
                    {
                     Print("Going for the sell");
                     if(SellPrice>TP1)
                        Ticket=Trade(sym,OP_SELLSTOP,LotValidity(sym,Con_LotSize1),SellPrice,0,SL,TP1,CreateTime+"_1B:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrRed);
                     else
                        Print("No trade 1. Sell Entry is below the TP 1");

                     if(SellPrice>TP2)
                        Ticket=Trade(sym,OP_SELLSTOP,LotValidity(sym,Con_LotSize2),SellPrice,0,SL,TP2,CreateTime+"_2B:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrRed);
                     else
                        Print("No trade 2. Sell Entry is below the TP 2");

                     if(SellPrice>TP3)
                        Ticket=Trade(sym,OP_SELLSTOP,LotValidity(sym,Con_LotSize3),SellPrice,0,SL,TP3,CreateTime+"_3B:"+DoubleToString(TP1,_Digits)+":"+DoubleToString(TP2,_Digits),MagicNumber,ExpireTime,clrRed);
                     else
                        Print("No trade 3. Sell Entry is below the TP 3");
                    }

                  //if(Ticket!=-1)
                  //   TradeBox(TheName+"_Perm:"+(string)Time1,Time1,PriceHigh,Time2,PriceLow);

                 }
              }
           }
        }

      //---

      if(iHigh(_Symbol,PERIOD_CURRENT,1)>PriceHigh)
        {
         if(iHigh(_Symbol,PERIOD_CURRENT,1)-PriceLow>Consolidation_Points*_Point)
           {
            ObjectDelete(0,TheName);
           }
         else
           {
            ObjectSetDouble(0,TheName,OBJPROP_PRICE,0,iHigh(_Symbol,PERIOD_CURRENT,1));
           }
        }

      if(iLow(_Symbol,PERIOD_CURRENT,1)<PriceLow)
        {
         if(PriceHigh-iLow(_Symbol,PERIOD_CURRENT,1)>Consolidation_Points*_Point)
           {
            ObjectDelete(0,TheName);
           }
         else
           {
            ObjectSetDouble(0,TheName,OBJPROP_PRICE,1,iLow(_Symbol,PERIOD_CURRENT,1));
           }
        }
     }

//---
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Consolidation(int shift=1)
  {
   int BarHighShift = iHighest(_Symbol,PERIOD_CURRENT,MODE_HIGH,Consolidation_Bars,shift);
   int BarLowShift = iLowest(_Symbol,PERIOD_CURRENT,MODE_LOW,Consolidation_Bars,shift);

   double BarHigh = iHigh(_Symbol,PERIOD_CURRENT,BarHighShift);
   double BarLow = iLow(_Symbol,PERIOD_CURRENT,BarLowShift);

   datetime BarHighTime = iTime(_Symbol,PERIOD_CURRENT,BarHighShift);
   datetime BarLowTime = iTime(_Symbol,PERIOD_CURRENT,BarLowShift);

   string TheName = ID+"Consolidation-xx";

   if(ObjectFind(0,TheName)!=0)
      if(BarHigh-BarLow<=Consolidation_Points*_Point)
        {
         //Print("new consolidation");
         datetime Time2 = BarHighTime>BarLowTime?BarLowTime:BarHighTime;
         datetime Time1 = Time2==BarLowTime?BarHighTime:BarLowTime;

         if(TradeHedge)
           {

            double middle_price=BarHigh-(BarHigh-BarLow)/2;

            double BuySL=BarLow-distance_from_consolidation*_Point;
            double SellSL=BarHigh+distance_from_consolidation*_Point;
            double Ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
            double Bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);

            Print("middle price for consolidation : ",BarHigh-(BarHigh-BarLow)/2," current ask : ",Ask);

            double BuyTP=middle_price+TakeProfit*_Point;
            double SellTP=middle_price-TakeProfit*_Point;
            datetime TimeDifference = iTime(_Symbol,PERIOD_D1,0)-iTime(_Symbol,PERIOD_D1,1);

            datetime ExpireTime = iTime(_Symbol,PERIOD_D1,0)+TimeDifference;

            int ticket=-1;
            double TPs[3],TPs_sell[3];

            calculate_TP_buy(middle_price,TPs);
            calculate_TP_sell(middle_price,TPs_sell);

            //first for the buy direction
            if(Ask<middle_price)
              {

               //price is above line, buystop to the middle price
               if(StrategyType==Strategy1)
                 {
                  Print("strat 1 hedging");
                  Print("[BUYSTOP+SELLLIMIT]    TP : ",TPs[0]," TP_SELL : ",TPs_sell[0]);
                  ticket=Trade(_Symbol,OP_BUYSTOP,LotValidity(_Symbol,LotSize1),middle_price,5,BuySL,TPs[0],"BUYSTOP_1",MagicNumber,ExpireTime,clrRed,false);

                  if(ticket==-1)
                     Print("error while sending buystop");

                  ticket=Trade(_Symbol,OP_SELLLIMIT,LotValidity(_Symbol,LotSize1),middle_price,5,SellSL,TPs_sell[0],"SELLLIMIT_1",MagicNumber,ExpireTime,clrRed,false);

                  if(ticket==-1)
                     Print("error while sending sellimit");
                 }


               if(StrategyType==Strategy2)
                 {
                  Print("strat 2 hedging");
                  Print("[BUYSTOP+SELLLIMIT]    TP : ",TPs[0]," TP_SELL : ",TPs_sell[0]);
                  ticket=Trade(_Symbol,OP_BUYSTOP,LotValidity(_Symbol,LotSize1),middle_price,5,BuySL,TPs[0],"BUYSTOP_1",MagicNumber,ExpireTime,clrRed,false);
                  if(ticket==-1)
                     Print("error while sending buystop1");

                  ticket=Trade(_Symbol,OP_BUYSTOP,LotValidity(_Symbol,LotSize1),middle_price,5,BuySL,TPs[1],"BUYSTOP_2;"+(string)SellSL,MagicNumber,ExpireTime,clrRed,false);
                  if(ticket==-1)
                     Print("error while sending buystop2");


                  ticket=Trade(_Symbol,OP_SELLLIMIT,LotValidity(_Symbol,LotSize1),middle_price,5,SellSL,TPs_sell[0],"SELLLIMIT_1",MagicNumber,ExpireTime,clrRed,false);
                  if(ticket==-1)
                     Print("error while sending sellimit1");

                  ticket=Trade(_Symbol,OP_SELLLIMIT,LotValidity(_Symbol,LotSize1),middle_price,5,SellSL,TPs_sell[1],"SELLLIMIT_2;"+(string)BuySL,MagicNumber,ExpireTime,clrRed,false);
                  if(ticket==-1)
                     Print("error while sending sellimit2");
                 }

               if(StrategyType==Strategy3)
                 {
                  Print("strat 3 hedging");
                  Print("[BUYSTOP+SELLLIMIT]    TP : ",TPs[0]," TP_SELL : ",TPs_sell[0]);
                  ticket=Trade(_Symbol,OP_BUYSTOP,LotValidity(_Symbol,LotSize1),middle_price,5,BuySL,TPs[0],"BUYSTOP_1",MagicNumber,ExpireTime,clrRed,false);
                  if(ticket==-1)
                     Print("error while sending buystop1");

                  ticket=Trade(_Symbol,OP_BUYSTOP,LotValidity(_Symbol,LotSize1),middle_price,5,BuySL,TPs[1],"BUYSTOP_2;"+(string)SellSL,MagicNumber,ExpireTime,clrRed,false);
                  if(ticket==-1)
                     Print("error while sending buystop2");

                  ticket=Trade(_Symbol,OP_BUYSTOP,LotValidity(_Symbol,LotSize1),middle_price,5,BuySL,TPs[2],"BUYSTOP_3;"+(string)TPs[0],MagicNumber,ExpireTime,clrRed,false);
                  if(ticket==-1)
                     Print("error while sending buystop3");


                  ticket=Trade(_Symbol,OP_SELLLIMIT,LotValidity(_Symbol,LotSize1),middle_price,5,SellSL,TPs_sell[0],"SELLLIMIT_1",MagicNumber,ExpireTime,clrRed,false);
                  if(ticket==-1)
                     Print("error while sending sellimit1");

                  ticket=Trade(_Symbol,OP_SELLLIMIT,LotValidity(_Symbol,LotSize1),middle_price,5,SellSL,TPs_sell[1],"SELLLIMIT_2;"+(string)BuySL,MagicNumber,ExpireTime,clrRed,false);
                  if(ticket==-1)
                     Print("error while sending sellimit2");

                  ticket=Trade(_Symbol,OP_SELLLIMIT,LotValidity(_Symbol,LotSize1),middle_price,5,SellSL,TPs_sell[2],"SELLLIMIT_3;"+(string)TPs_sell[0],MagicNumber,ExpireTime,clrRed,false);
                  if(ticket==-1)
                     Print("error while sending sellimit3");
                 }


              }
            else
               if(Ask>middle_price)
                 {
                  if(StrategyType==Strategy1)
                    {
                     Print("[BUYLIMIT+SELLSTOP]    TP : ",TPs[0]," TP_SELL : ",TPs_sell[0]);


                     ticket=Trade(_Symbol,OP_BUYLIMIT,LotValidity(_Symbol,LotSize1),middle_price,5,BuySL,TPs[0],"BUYLIMIT_1",MagicNumber,ExpireTime,clrRed,false);

                     if(ticket==-1)
                        Print("error while sending BUYLIMIT_1");

                     ticket=Trade(_Symbol,OP_SELLSTOP,LotValidity(_Symbol,LotSize1),middle_price,5,SellSL,TPs_sell[0],"SELLSTOP_1",MagicNumber,ExpireTime,clrRed,false);


                     if(ticket==-1)
                        Print("error while sending SELLSTOP_1");
                    }

                  if(StrategyType==Strategy2)
                    {
                     Print("strat 2 hedging");
                     Print("[BUYSTOP+SELLLIMIT]    TP : ",TPs[0]," TP_SELL : ",TPs_sell[0]);
                     ticket=Trade(_Symbol,OP_BUYLIMIT,LotValidity(_Symbol,LotSize1),middle_price,5,BuySL,TPs[0],"BUYLIMIT_1",MagicNumber,ExpireTime,clrRed,false);
                     if(ticket==-1)
                        Print("error while sending BUYLIMIT_1");

                     ticket=Trade(_Symbol,OP_BUYLIMIT,LotValidity(_Symbol,LotSize1),middle_price,5,BuySL,TPs[1],"BUYLIMIT_2;"+(string)SellSL,MagicNumber,ExpireTime,clrRed,false);
                     if(ticket==-1)
                        Print("error while sending BUYLIMIT_2");


                     ticket=Trade(_Symbol,OP_SELLSTOP,LotValidity(_Symbol,LotSize1),middle_price,5,SellSL,TPs_sell[0],"SELLSTOP_1",MagicNumber,ExpireTime,clrRed,false);
                     if(ticket==-1)
                        Print("error while sending SELLSTOP_1");

                     ticket=Trade(_Symbol,OP_SELLSTOP,LotValidity(_Symbol,LotSize1),middle_price,5,SellSL,TPs_sell[1],"SELLSTOP_2;"+(string)BuySL,MagicNumber,ExpireTime,clrRed,false);
                     if(ticket==-1)
                        Print("error while sending SELLSTOP_2");
                    }

                  if(StrategyType==Strategy3)
                    {
                     Print("strat 2 hedging");
                     Print("[BUYSTOP+SELLLIMIT]    TP : ",TPs[0]," TP_SELL : ",TPs_sell[0]);
                     ticket=Trade(_Symbol,OP_BUYLIMIT,LotValidity(_Symbol,LotSize1),middle_price,5,BuySL,TPs[0],"BUYSTOP_1",MagicNumber,ExpireTime,clrRed,false);
                     if(ticket==-1)
                        Print("error while sending BUYSTOP_1");

                     ticket=Trade(_Symbol,OP_BUYLIMIT,LotValidity(_Symbol,LotSize1),middle_price,5,BuySL,TPs[1],"BUYSTOP_2;"+(string)SellSL,MagicNumber,ExpireTime,clrRed,false);
                     if(ticket==-1)
                        Print("error while sending BUYSTOP_2");

                     ticket=Trade(_Symbol,OP_BUYLIMIT,LotValidity(_Symbol,LotSize1),middle_price,5,BuySL,TPs[2],"BUYSTOP_3;"+(string)TPs[0],MagicNumber,ExpireTime,clrRed,false);
                     if(ticket==-1)
                        Print("error while sending BUYSTOP_3");


                     ticket=Trade(_Symbol,OP_SELLSTOP,LotValidity(_Symbol,LotSize1),middle_price,5,SellSL,TPs_sell[0],"SELLSTOP_1",MagicNumber,ExpireTime,clrRed,false);
                     if(ticket==-1)
                        Print("error while sending SELLSTOP_1");

                     ticket=Trade(_Symbol,OP_SELLSTOP,LotValidity(_Symbol,LotSize1),middle_price,5,SellSL,TPs_sell[1],"SELLSTOP_2;"+(string)BuySL,MagicNumber,ExpireTime,clrRed,false);
                     if(ticket==-1)
                        Print("error while sending SELLSTOP_2");

                     ticket=Trade(_Symbol,OP_SELLSTOP,LotValidity(_Symbol,LotSize1),middle_price,5,SellSL,TPs_sell[2],"SELLSTOP_3;"+(string)TPs_sell[0],MagicNumber,ExpireTime,clrRed,false);
                     if(ticket==-1)
                        Print("error while sending SELLSTOP_3");
                    }

                 }

               else
                 {
                  Print("should be buy and sell");
                 }
           }
         else
           {
            DeleteOrders(OP_BUYLIMIT);
            DeleteOrders(OP_SELLLIMIT);
            DeleteOrders(OP_BUYSTOP);
            DeleteOrders(OP_SELLSTOP);
           }



         ObjectCreate(0,TheName, OBJ_RECTANGLE, 0, iTime(_Symbol,PERIOD_CURRENT,Consolidation_Bars),BarHigh,Time2,BarLow);
         ObjectSetInteger(0,TheName, OBJPROP_COLOR, Consolidation_Color);
         ObjectSetInteger(0,TheName, OBJPROP_WIDTH, 2);
         ObjectSetInteger(0,TheName, OBJPROP_SELECTABLE, false);
         ObjectSetInteger(0,TheName, OBJPROP_HIDDEN, true);
         ObjectSetInteger(0,TheName,OBJPROP_BACK,true);
         ObjectSetInteger(0,TheName,OBJPROP_FILL,Consolidation_Fill);
         ObjectSetString(0,TheName,OBJPROP_TOOLTIP,"Consolidation Range");



         return true;
        }

   if(ObjectFind(0,TheName)==0)
     {
      ObjectSetInteger(0,TheName,OBJPROP_TIME,1,iTime(_Symbol,PERIOD_CURRENT,1));

      return true;
     }


   return false;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void TrailHedge()
  {
   if(!use_trail_hedge)
      return;


   for(int i=0; i<PositionsTotal(); i++)
     {
      double Bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
      double Ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);

      if(m_position.SelectByIndex(i))
         if(m_position.Symbol()==_Symbol && m_position.Magic()==MagicNumber)
           {
            //BUY ORDER WAS FOUND, SELL IS CLOSED SO GET SL TO ENTRY PRICE
            double price_box_high=m_position.PriceOpen()+(distance_from_consolidation+Consolidation_Points/2)*_Point;
            double price_box_low=m_position.PriceOpen()-(distance_from_consolidation+Consolidation_Points/2)*_Point;

            //Print("price box high : ",price_box_high);
            //Print("price box low : ",price_box_low);

            bool condition_buy=((StringFind(m_position.Comment(),"BUYSTOP")!=-1&&StringFind(m_position.Comment(),"SELLLIMIT")==-1)
                                ||(StringFind(m_position.Comment(),"BUYLIMIT")!=-1&&StringFind(m_position.Comment(),"SELLSTOP")==-1))
                               &&m_position.StopLoss()<m_position.PriceOpen()&&Ask>=price_box_high;

            if(condition_buy)
              {
               Print("trailing buy orders");
               m_trade.PositionModify(m_position.Ticket(),
                                      NormalizeDouble(m_position.PriceOpen(),_Digits),
                                      m_position.TakeProfit());
              }

            bool condition_sell=((StringFind(m_position.Comment(),"BUYSTOP")==-1&&StringFind(m_position.Comment(),"SELLLIMIT")!=-1)
                                 ||(StringFind(m_position.Comment(),"BUYLIMIT")==-1&&StringFind(m_position.Comment(),"SELLSTOP")!=-1))
                                &&m_position.StopLoss()>m_position.PriceOpen()&&Bid<=price_box_low;

            if(condition_sell)
              {
               Print("trailing sells");
               m_trade.PositionModify(m_position.Ticket(),
                                      NormalizeDouble(m_position.PriceOpen(),_Digits),
                                      m_position.TakeProfit());
              }
            //FURTHER STEPS DEPENDING ON THE STRATEGY

            if(StrategyType==Strategy2)
              {

               //condition buy when the first order closed
               condition_buy=m_position.StopLoss()==m_position.PriceOpen()
                             &&!search_by_comment("BUYSTOP_1")
                             &&search_by_comment("BUYSTOP_2")
                             &&StringFind(m_position.Comment(),"BUYSTOP_2")!=-1;

               double tp_val=(double)StringSubstr(m_position.Comment(),StringLen("BUYSTOP_2;"));
               tp_val=NormalizeDouble(tp_val,_Digits);
               //si c pour un limit order, chercher limit orders
               if(!condition_buy)
                 {
                  condition_buy=m_position.StopLoss()==m_position.PriceOpen()
                                &&!search_by_comment("BUYLIMIT_1")
                                &&search_by_comment("BUYLIMIT_2")
                                &&StringFind(m_position.Comment(),"BUYLIMIT_2")!=-1;
                  tp_val=(double)StringSubstr(m_position.Comment(),StringLen("BUYLIMIT_2;"));
                  tp_val=NormalizeDouble(tp_val,_Digits);
                 }


               if(condition_buy)
                  m_trade.PositionModify(m_position.Ticket(),
                                         NormalizeDouble(tp_val,_Digits),
                                         m_position.TakeProfit());

               //condition SELL when the first order closed
               condition_sell=m_position.StopLoss()==m_position.PriceOpen()
                              &&!search_by_comment("SELLSTOP_1")
                              &&search_by_comment("SELLSTOP_2")
                              &&StringFind(m_position.Comment(),"SELLSTOP_2")!=-1;

               double tp_val_sell=(double)StringSubstr(m_position.Comment(),StringLen("SELLSTOP_2;"));
               tp_val_sell=NormalizeDouble(tp_val_sell,_Digits);

               //si c pour un limit order, chercher limit orders
               if(!condition_sell)
                 {
                  condition_sell=m_position.StopLoss()==m_position.PriceOpen()
                                 &&!search_by_comment("SELLLIMIT_1")
                                 &&search_by_comment("SELLLIMIT_2")
                                 &&StringFind(m_position.Comment(),"SELLLIMIT_2")!=-1;
                  tp_val_sell=(double)StringSubstr(m_position.Comment(),StringLen("SELLLIMIT_2;"));
                  tp_val_sell=NormalizeDouble(tp_val_sell,_Digits);
                 }


               if(condition_sell)
                  m_trade.PositionModify(m_position.Ticket(),
                                         NormalizeDouble(tp_val_sell,_Digits),
                                         m_position.TakeProfit());
              }

            if(StrategyType==Strategy3)
              {
               //condition buy when the first order closed
               condition_buy=m_position.StopLoss()==m_position.PriceOpen()
                             &&!search_by_comment("BUYSTOP_1")
                             &&search_by_comment("BUYSTOP_2")
                             &&(StringFind(m_position.Comment(),"BUYSTOP_2")!=-1||StringFind(m_position.Comment(),"BUYSTOP_3")!=-1);

               double tp_val=(double)StringSubstr(search_by_comment_("BUYSTOP_2"),StringLen("BUYSTOP_2;"));
               tp_val=NormalizeDouble(tp_val,_Digits);

               //si c pour un limit order, chercher limit orders
               if(!condition_buy)
                 {
                  condition_buy=m_position.StopLoss()==m_position.PriceOpen()
                                &&!search_by_comment("BUYLIMIT_1")
                                &&search_by_comment("BUYLIMIT_2")
                                &&(StringFind(m_position.Comment(),"BUYLIMIT_2")!=-1||StringFind(m_position.Comment(),"BUYLIMIT_3")!=-1);
                  tp_val=(double)StringSubstr(search_by_comment_("BUYLIMIT_2"),StringLen("BUYLIMIT_2;"));
                  tp_val=NormalizeDouble(tp_val,_Digits);
                 }

               //OLBATAR ENUKEUOLKDND
               m_position.SelectByIndex(i);

               if(condition_buy)
                  m_trade.PositionModify(m_position.Ticket(),
                                         NormalizeDouble(tp_val,_Digits),
                                         m_position.TakeProfit());

               //SECOND ORDER CLOSES FOR BUY
               tp_val=(double)StringSubstr(search_by_comment_("BUYSTOP_3"),StringLen("BUYSTOP_3;"));
               tp_val=NormalizeDouble(tp_val,_Digits);
               condition_buy=m_position.StopLoss()!=tp_val
                             &&!search_by_comment("BUYSTOP_1")
                             &&!search_by_comment("BUYSTOP_2")
                             &&StringFind(m_position.Comment(),"BUYSTOP_3")!=-1;


               //si c pour un limit order, chercher limit orders
               if(!condition_buy)
                 {
                  tp_val=(double)StringSubstr(search_by_comment_("BUYLIMIT_3"),StringLen("BUYLIMIT_3;"));
                  tp_val=NormalizeDouble(tp_val,_Digits);
                  condition_buy=m_position.StopLoss()!=tp_val
                                &&!search_by_comment("BUYLIMIT_1")
                                &&!search_by_comment("BUYLIMIT_2")
                                &&StringFind(m_position.Comment(),"BUYLIMIT_3")!=-1;

                 }

               //OLBATAR ENUKEUOLKDND
               m_position.SelectByIndex(i);

               if(condition_buy)
                  m_trade.PositionModify(m_position.Ticket(),
                                         NormalizeDouble(tp_val,_Digits),
                                         m_position.TakeProfit());





               //condition SELL when the first order closed
               condition_sell=m_position.StopLoss()==m_position.PriceOpen()
                              &&!search_by_comment("SELLSTOP_1")
                              &&search_by_comment("SELLSTOP_2")
                              &&(StringFind(m_position.Comment(),"SELLSTOP_2")!=-1||StringFind(m_position.Comment(),"SELLSTOP_3")!=-1);

               double tp_val_sell=(double)StringSubstr(search_by_comment_("SELLSTOP_2;"),StringLen("SELLSTOP_2;"));

               tp_val_sell=NormalizeDouble(tp_val_sell,_Digits);

               //si c pour un limit order, chercher limit orders
               if(!condition_sell)
                 {

                  condition_sell=m_position.StopLoss()==m_position.PriceOpen()
                                 &&!search_by_comment("SELLLIMIT_1")
                                 &&search_by_comment("SELLLIMIT_2")
                                 &&(StringFind(m_position.Comment(),"SELLLIMIT_2")!=-1||StringFind(m_position.Comment(),"SELLLIMIT_3")!=-1);

                  tp_val_sell=(double)StringSubstr(search_by_comment_("SELLLIMIT_2;"),StringLen("SELLLIMIT_2;"));
                  tp_val_sell=NormalizeDouble(tp_val_sell,_Digits);
                 }

               m_position.SelectByIndex(i);

               if(condition_sell)
                  m_trade.PositionModify(m_position.Ticket(),
                                         NormalizeDouble(tp_val_sell,_Digits),
                                         m_position.TakeProfit());
              }

            //CONDITION SELL WHEN SECOND ORDER CLOSES

            double tp_val_sell=(double)StringSubstr(search_by_comment_("SELLSTOP_3;"),StringLen("SELLSTOP_3;"));
            tp_val_sell=NormalizeDouble(tp_val_sell,_Digits);

            condition_sell=m_position.StopLoss()!=tp_val_sell
                           &&!search_by_comment("SELLSTOP_1")
                           &&!search_by_comment("SELLSTOP_2")
                           &&StringFind(m_position.Comment(),"SELLSTOP_3")!=-1;



            //si c pour un limit order, chercher limit orders
            if(!condition_sell)
              {
               tp_val_sell=(double)StringSubstr(search_by_comment_("SELLLIMIT_3;"),StringLen("SELLLIMIT_3;"));
               tp_val_sell=NormalizeDouble(tp_val_sell,_Digits);

               condition_sell=m_position.StopLoss()!=tp_val_sell
                              &&!search_by_comment("SELLLIMIT_1")
                              &&!search_by_comment("SELLLIMIT_2")
                              &&StringFind(m_position.Comment(),"SELLLIMIT_3")!=-1;


              }

            m_position.SelectByIndex(i);

            if(condition_sell)
               m_trade.PositionModify(m_position.Ticket(),
                                      NormalizeDouble(tp_val_sell,_Digits),
                                      m_position.TakeProfit());
           }
         else
            Print("error selecting trade :",i);
     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string search_by_comment_(string comment)
  {
   for(int i=0; i<PositionsTotal(); i++)
     {

      if(other_m_position.SelectByIndex(i))
         if(other_m_position.Symbol()==_Symbol && other_m_position.Magic()==MagicNumber)
            if(StringFind(other_m_position.Comment(),comment)!=-1)
               return other_m_position.Comment();
     }
   return "";
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool search_by_comment(string comment)
  {
   for(int i=0; i<PositionsTotal(); i++)
     {

      if(other_m_position.SelectByIndex(i))
         if(other_m_position.Symbol()==_Symbol && other_m_position.Magic()==MagicNumber)
            if(StringFind(other_m_position.Comment(),comment)!=-1)
               return true;
     }
   return false;
  }
/*
double get_TP_level(lpmode strat,ENUM_ORDER_TYPE type){
   for(int i=0;i<PositionsTotal();i++){

   double Bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
   double Ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   bool found=false;

   if(m_position.SelectByIndex(i))
         if(m_position.Symbol()==_Symbol && m_position.Magic()==MagicNumber)
            //if strat 2 and BUY order opened
            if(strat==Strategy2&&type==OP_BUY)
               if(StringFind(m_position.Comment(),"BUYSTOP_1")!=-1)
                  return m_position.TakeProfit();

            if(strat==Strategy3&&type==OP_SELL)
               if(StringFind(m_position.Comment(),"SELL_1")!=-1)
                  return m_position.TakeProfit();
      }
   return -1;
   }
*/
double calculate_TP_sell(double price,double &tps[])
  {
   double TP=0,SL=0;
   if(Sell_SL_Mode==SPointSL)
      if(StopLoss>0)
         SL=price+StopLoss*_Point;
//...
   if(Sell_SL_Mode==ResLevel1)
      SL = BuyFirstTP;
   if(Sell_SL_Mode==ResLevel2)
      SL = BuySecondTP;
   if(Sell_SL_Mode==ResLevel3)
      SL = BuyThirdTP;
//...
   if(TakeProfit>0)
      TP=price-TakeProfit*_Point;
//...
//TP = SellFirstTP;
   double TP1=0;
   double TP2=0;
   double TP3=0;
   if(TakeProfitMode1==TPMode1)
      TP1 = SellFirstTP;
//ADDED OPTION FOR THE SELL
   if(TakeProfitMode1==TPMode2)
      TP1 = SellSecondTP;
   if(TakeProfitMode1==TPMode3)
      TP1 = SellThirdTP;

   if(TakeProfitMode2==TPMode2)
      TP2 = SellSecondTP;
   if(TakeProfitMode3==TPMode3)
      TP3 = SellThirdTP;
//...
   if(TakeProfitMode1==FixTP)
      TP1 = TP;
   if(TakeProfitMode2==FixTP)
      TP2 = TP;
   if(TakeProfitMode3==FixTP)
      TP3 = TP;
//...
   if(TP1>200000)
      TP1 = TP;
   if(TP2>200000)
      TP2 = TP;
   if(TP3>200000)
      TP3 = TP;

   if(ArraySize(tps)>2)
     {
      tps[0]=TP1;
      tps[1]=TP2;
      tps[2]=TP3;
     }
   else
     {
      return 0;
     }
   return 1;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double calculate_TP_buy(double price,double &tps[])
  {
   double TP=0,SL=0;

   if(Buy_SL_Mode==BPointSL)
      if(StopLoss>0)
         SL = price-StopLoss*_Point;
//...
   if(Buy_SL_Mode==SupLevel1)
      SL = SellFirstTP;
   if(Buy_SL_Mode==SupLevel2)
      SL = SellSecondTP;
   if(Buy_SL_Mode==SupLevel3)
      SL = SellThirdTP;
//...
   if(TakeProfit>0)
      TP=price+TakeProfit*_Point;
//...
//TP = BuyFirstTP;
   double TP1=0;
   double TP2=0;
   double TP3=0;
//...
   if(TakeProfitMode1==TPMode1)
     {
      TP1 = BuyFirstTP;
     }
//ADDED OPTION
   if(TakeProfitMode1==TPMode2)
     {
      TP1 = BuySecondTP;
     }

   if(TakeProfitMode1==TPMode3)
     {
      TP1 = BuyThirdTP;
     }
//END ADDED OPTION

   if(TakeProfitMode2==TPMode2)
      TP2 = BuySecondTP;
   if(TakeProfitMode3==TPMode3)
      TP3 = BuyThirdTP;
//...
   if(TakeProfitMode1==FixTP)
      TP1 = TP;
   if(TakeProfitMode2==FixTP)
      TP2 = TP;
   if(TakeProfitMode3==FixTP)
      TP3 = TP;
//...
   if(TP1>200000)
      TP1 = TP;
   if(TP2>200000)
      TP2 = TP;
   if(TP3>200000)
      TP3 = TP;

   if(ArraySize(tps)>2)
     {
      tps[0]=TP1;
      tps[1]=TP2;
      tps[2]=TP3;
     }
   else
     {
      return 0;
     }
   return 1;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void TradeBox(string TheName,datetime Time1,double Price1,datetime Time2,double Price2)
  {
   ObjectCreate(0,TheName, OBJ_RECTANGLE, 0, Time1,Price1,Time2,Price2);
   ObjectSetInteger(0,TheName, OBJPROP_COLOR, clrLightGray);
   ObjectSetInteger(0,TheName, OBJPROP_WIDTH, 2);
   ObjectSetInteger(0,TheName, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0,TheName, OBJPROP_HIDDEN, true);
   ObjectSetInteger(0,TheName,OBJPROP_BACK,true);
   ObjectSetInteger(0,TheName,OBJPROP_FILL,Consolidation_Fill);
   ObjectSetString(0,TheName,OBJPROP_TOOLTIP,"Consolidation Range");

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Trade(string TheSymbol,ENUM_ORDER_TYPE TYPE,double Lot,double EntryPrice,int Slipage,double TheSL, double TheTP, string comment, int TheMagic, datetime Expiry, color Rangi, bool Again=true)
  {
   if(TYPE==OP_BUY || TYPE==OP_SELL)
      if(UseMAFilter && !CheckMAFilter(TYPE))
         return 0;
   bool TradeAlow=(sTimeFilter(TimeStart,TimeStop)&&UseTimeFilter)||!UseTimeFilter;

   if(!TradeAlow)
      return 0;
   int TheDigits = (int)SymbolInfoInteger(TheSymbol,SYMBOL_DIGITS);
   double TheAsk = SymbolInfoDouble(TheSymbol,SYMBOL_ASK);
   double TheBid = SymbolInfoDouble(TheSymbol,SYMBOL_BID);

   double price=EntryPrice;

   double Takeprofit = TheTP;
   double Stoploss = TheSL;

   if(Takeprofit==0)
      Takeprofit = NULL;

   if(Stoploss==0)
      Stoploss = NULL;

   ZeroMemory(irequest);
   irequest.symbol = TheSymbol;

   if(TYPE==ORDER_TYPE_BUY || TYPE==ORDER_TYPE_SELL)
      irequest.action = TRADE_ACTION_DEAL;
   else
      irequest.action = TRADE_ACTION_PENDING;

   irequest.type = TYPE;
   irequest.volume = NormalizeDouble(Lot,2);
   irequest.price = NormalizeDouble(price,TheDigits);
   irequest.sl  = Stoploss!=NULL?NormalizeDouble(Stoploss,TheDigits):NULL;
   irequest.tp  = Takeprofit!=NULL?NormalizeDouble(Takeprofit,TheDigits):NULL;
   irequest.comment = comment;
   irequest.magic  = TheMagic;
   irequest.type_time = ORDER_TIME_SPECIFIED;

   irequest.expiration = Expiry;

   if(Again)
      irequest.type_filling=ORDER_FILLING_IOC;
   else
      irequest.type_filling=ORDER_FILLING_FOK;

   irequest.deviation = Slipage;

   if(OrderCheck(irequest,checkResult))
     {
      Print("Checked!");
     }
   else
      if(Again)
        {
         Print("Retrying..");
         Trade(TheSymbol,TYPE,Lot,EntryPrice,Slipage,TheSL,TheTP,comment,TheMagic,Expiry,Rangi,false);
        }
      else
        {
         Print("Not Checked | ERROR :"+IntegerToString(checkResult.retcode));
        }

   if(OrderSend(irequest,iresult))
     {
      Print("Order successful");
     }
   else
     {
      Print("Order unsuccessful | ERROR :"+IntegerToString(checkResult.retcode)," Ask = ",TheAsk," || Bid = ",TheBid);
     }

   return 0;
  }

//+------------------------------------------------------------------+
double LotValidity(string sym,double L)
  {
   if(L>SymbolInfoDouble(sym,SYMBOL_VOLUME_MAX))
      L = SymbolInfoDouble(sym,SYMBOL_VOLUME_MAX);
   if(L<SymbolInfoDouble(sym,SYMBOL_VOLUME_MIN))
      L = SymbolInfoDouble(sym,SYMBOL_VOLUME_MIN);
   return(L);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int TotalOrder(int T, string sym,string TheComment="")
  {
   int C=0;

   for(int i=0; i<PositionsTotal(); i++) // returns the number of open positions
     {
      if(m_position.SelectByIndex(i) && (m_position.Type()==T|| T==-1) && m_position.Magic()==MagicNumber && m_position.Symbol()==sym && (TheComment=="" || StringFind(m_position.Comment(),TheComment)!=-1))
        {
         C++;
        }
     }

   return(C);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int PendingTrades(string sym,string TheComment="")
  {
   int C=0;

   for(int i=0; i<OrdersTotal(); i++) // returns the number of open positions
     {
      if(m_order.SelectByIndex(i))
        {
         if(m_order.Magic()==MagicNumber && m_order.Symbol()==sym && (TheComment=="" || StringFind(m_order.Comment(),TheComment)!=-1))
           {
            C++;
           }
        }
     }

   for(int i=0; i<PositionsTotal(); i++) // returns the number of open positions
     {
      if(m_position.SelectByIndex(i) && m_position.Magic()==MagicNumber && m_position.Symbol()==sym && (TheComment=="" || StringFind(m_position.Comment(),TheComment)!=-1))
        {
         C++;
        }
     }


   return C;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool NoTrade(ENUM_ORDER_TYPE TYPE,string Find="")
  {
   for(int i=0; i<OrdersTotal(); i++) // returns the number of open positions
     {
      if(m_order.SelectByIndex(i))
        {
         if(m_order.OrderType()==TYPE && m_order.Magic()==MagicNumber && m_order.Symbol()==_Symbol && (Find=="" || StringFind(m_order.Comment(),Find)!=-1))
           {
            return false;
           }
        }
     }

   return true;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void GTC()
  {
   for(int i=0; i<OrdersTotal(); i++) // returns the number of open positions
     {
      if(m_order.SelectByIndex(i))
        {
         if((m_order.OrderType()==OP_BUYSTOP || m_order.OrderType()==OP_SELLSTOP || m_order.OrderType()==OP_BUYLIMIT || m_order.OrderType()==OP_SELLLIMIT) &&
            m_order.Magic()==MagicNumber && m_order.Symbol()==_Symbol && (StringFind(m_order.Comment(),"R:")!=-1 || StringFind(m_order.Comment(),"B:")!=-1))
           {
            if(iBarShift(_Symbol,PERIOD_D1,m_order.TimeSetup())>0)
              {
               m_trade.OrderDelete(m_order.Ticket());
               i--;
              }
           }
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DeleteOrders(ENUM_ORDER_TYPE TYPE)
  {
   for(int i=0; i<OrdersTotal(); i++) // returns the number of open positions
     {
      if(m_order.SelectByIndex(i))
        {
         if(m_order.OrderType()==TYPE && m_order.Magic()==MagicNumber && m_order.Symbol()==_Symbol)
           {
            m_trade.OrderDelete(m_order.Ticket());
            i--;
           }
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DeleteOppositeOrder()
  {
   for(int i=0; i<PositionsTotal(); i++) // returns the number of open positions
     {
      if(m_position.SelectByIndex(i) && m_position.Magic()==MagicNumber && m_position.Symbol()==_Symbol && StringFind(m_position.Comment(),"R:")!=-1)
        {
         int TradeType = m_position.PositionType();

         string Divide[];

         int div = StringSplit(m_position.Comment(),StringGetCharacter("_",0),Divide);

         if(div==2)
           {
            string TheRangeTime = Divide[0];

            for(int j=0; j<OrdersTotal(); j++) // returns the number of open positions
              {
               if(m_order.SelectByIndex(j))
                 {
                  string Divide2[];

                  int div2 = StringSplit(m_order.Comment(),StringGetCharacter("_",0),Divide2);

                  if(div2==2)
                    {
                     string TheRangeTime2 = Divide2[0];

                     if(((TradeType==OP_BUY && m_order.OrderType()==OP_SELLLIMIT) || (TradeType==OP_SELL && m_order.OrderType()==OP_BUYLIMIT)) &&
                        m_order.Magic()==MagicNumber && m_order.Symbol()==_Symbol && StringFind(m_order.Comment(),"R:")!=-1 && TheRangeTime==TheRangeTime2)
                       {
                        Print("Going to delete #",(string)m_order.Ticket()," | Opposite order entry");
                        m_trade.OrderDelete(m_order.Ticket());
                        i--;
                       }
                    }
                 }
              }
           }
        }

      if(m_position.SelectByIndex(i) && m_position.Magic()==MagicNumber && m_position.Symbol()==_Symbol && StringFind(m_position.Comment(),"B:")!=-1)
        {
         int TradeType = m_position.PositionType();

         datetime TheOrderOpenTime = m_position.Time();

         string Divide[];

         int div = StringSplit(m_position.Comment(),StringGetCharacter("_",0),Divide);

         if(div==2)
           {
            string TheRangeTime = Divide[0];

            for(int j=0; j<OrdersTotal(); j++) // returns the number of open positions
              {
               if(m_order.SelectByIndex(j))
                 {
                  string Divide2[];

                  int div2 = StringSplit(m_order.Comment(),StringGetCharacter("_",0),Divide2);

                  if(div2==2)
                    {
                     string TheRangeTime2 = Divide2[0];

                     if(((TradeType==OP_BUY && m_order.OrderType()==OP_SELLSTOP) || (TradeType==OP_SELL && m_order.OrderType()==OP_BUYSTOP)) &&
                        m_order.Magic()==MagicNumber && m_order.Symbol()==_Symbol && StringFind(m_order.Comment(),"B:")!=-1 && TheRangeTime==TheRangeTime2)
                       {
                        Print("Going to delete #",(string)m_order.Ticket()," | Opposite order entry");
                        m_trade.OrderDelete(m_order.Ticket());
                        i--;
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
int CheckTrades(ENUM_ORDER_TYPE TYPE,string TheComment="")
  {
   int counter=0;
   for(int i=0; i<OrdersTotal(); i++) // returns the number of open positions
     {
      if(m_order.SelectByIndex(i))
        {
         if(m_order.OrderType()==TYPE && m_order.Magic()==MagicNumber && m_order.Symbol()==_Symbol && (TheComment=="" || StringFind(m_order.Comment(),TheComment)!=-1))
           {
            counter++;
           }
        }
     }

   return counter;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ModifyOrder(ENUM_ORDER_TYPE TYPE,double EntryPrice)
  {
   for(int i=0; i<OrdersTotal(); i++) // returns the number of open positions
     {
      if(m_order.SelectByIndex(i))
        {
         if(m_order.OrderType()==TYPE && m_order.Magic()==MagicNumber && m_order.Symbol()==_Symbol && m_order.PriceOpen()!=EntryPrice)
           {
            m_trade.OrderModify(m_order.Ticket(),EntryPrice,m_order.StopLoss(),m_order.TakeProfit(),0,0);
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseAll(ENUM_POSITION_TYPE T,string TheSymbol="")
  {
   for(int i=0; i<PositionsTotal(); i++) // returns the number of open positions
     {
      if(m_position.SelectByIndex(i) && (m_position.Type()==T|| T==6) && m_position.Symbol()==TheSymbol && m_position.Magic()==MagicNumber)
        {
         m_trade.PositionClose(m_position.Ticket());
         i--;
         continue;
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DeleteAll(ENUM_POSITION_TYPE T,string TheSymbol="")
  {
   for(int i=0; i<OrdersTotal(); i++) // returns the number of open positions
     {
      if(m_order.SelectByIndex(i) && (m_order.Type()==T|| T==6) && m_order.Symbol()==TheSymbol && m_order.Magic()==MagicNumber)
        {
         m_trade.OrderDelete(OrderGetTicket(i));
         i--;
         continue;
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double TotalProfit(string TheSymbol)
  {
   double Profit=0;
   for(int i=0; i<PositionsTotal(); i++) // returns the number of open positions
     {
      if(m_position.SelectByIndex(i) && m_position.Symbol()==TheSymbol && m_position.Magic()==MagicNumber)
        {
         Profit += m_position.Swap()+m_position.Commission()+m_position.Profit();
        }
     }

   return Profit;
  }

//+------------------------------------------------------------------+
bool Validity(string sym, double lot, int type, double entry, double sl, double tp)
  {
//---
   if(AccountInfoDouble(ACCOUNT_MARGIN_FREE)<0)
     {
      Print("Not Enough Free Margin!");
      return(false);
     }
//---
   if(lot<SymbolInfoDouble(sym,SYMBOL_VOLUME_MIN) || lot>SymbolInfoDouble(sym,SYMBOL_VOLUME_MAX))
     {
      Print("Lot Size is not in range");
      return(false);
     }
//---
   int SLDiss = int(MathAbs((entry-sl)*MathPow(10,SymbolInfoInteger(sym,SYMBOL_DIGITS))));
   int TPDiss = int(MathAbs((entry-tp)*MathPow(10,SymbolInfoInteger(sym,SYMBOL_DIGITS))));
   /*   if(SLDiss<MarketInfo(sym,MODE_STOPLEVEL) || TPDiss<MarketInfo(sym,MODE_STOPLEVEL))
        {
         Print("SL Or TP is closer than valid stop level");
         return(false);
        }
   //---
   if(IsConnected()==false && MQLInfoInteger(MQL_TESTER)==false)
     {
      Print("Termianl Connection Error");
      return(false);
     }
     */
//---
   if((AccountInfoInteger(ACCOUNT_TRADE_ALLOWED)==false || MQLInfoInteger(MQL_TRADE_ALLOWED)==false) && MQLInfoInteger(MQL_TESTER)==false)
     {
      Print("Automatic Trading Permission Error");
      return(false);
     }
//---
   /*   if(IsTradeContextBusy()==true && MQLInfoInteger(MQL_TESTER)==false)
        {
         Print("Broker Is Busy");
         return(false);
        }
   *///---
   return(true);
  }
//+------------------------------------------------------------------+
int PlacePending(string sym, int type, double price,double lot)
  {
//---
   price = NormalizeDouble(price,int(SymbolInfoInteger(sym,SYMBOL_DIGITS)));
   double sl = 0;
   double tp = 0;
   double point = SymbolInfoDouble(sym,SYMBOL_POINT);
   color  cl = clrBlue;
   if(type==0 || type==2 || type==4)
     {
      cl = clrBlue;
      if(StopLoss>0)
         sl = price-StopLoss*point;
      if(TakeProfit>0)
         tp = price+TakeProfit*point;
     }
//---
   if(type==1 || type==3 || type==5)
     {
      cl = clrRed;
      if(StopLoss>0)
         sl = price+StopLoss*point;
      if(TakeProfit>0)
         tp = price-TakeProfit*point;
     }
//---
   int Ticket = -1;
   Ticket = Trade(sym,(ENUM_ORDER_TYPE)type,LotValidity(sym,lot),price,0,sl,tp,"Pending",MagicNumber,0,cl);
//---
   return(Ticket);
  }
//+------------------------------------------------------------------+
bool StopLevelValidity(string sym, double entry, double sl, double tp)
  {
//---
//RefreshRates();
   double bid = SymbolInfoDouble(sym,SYMBOL_BID);
   double ask = SymbolInfoDouble(sym,SYMBOL_ASK);
//   double stoplevel = SymbolInfoDouble(sym,SYMBOL_S);
   double spread = (double)SymbolInfoInteger(sym,SYMBOL_SPREAD);

   if(DiffPrice(bid,entry,sym)<spread /*|| DiffPrice(bid,entry,sym)<stoplevel*/)
      return(false);
   if(sl>0)
      if(DiffPrice(bid,sl,sym)<spread /*|| DiffPrice(bid,sl,sym)<stoplevel*/)
         return(false);
   if(tp>0)
      if(DiffPrice(bid,tp,sym)<spread /*|| DiffPrice(bid,tp,sym)<stoplevel*/)
         return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
double DiffPrice(double price1, double price2, string sym)
  {
//---
   double diff = MathAbs((price1-price2)*MathPow(10,SymbolInfoInteger(sym,SYMBOL_DIGITS)));
//---
   return(diff);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void MakePanel()
  {
//---
   UpgradeDataInfo();
   string lablestext[5]  = {"...","...","...","...","..."};
   color  lablecolors[5] = {clrRed,clrBlue,clrGreen,clrYellow,clrOrange};
   MakeBackGround("BG",Graphic_HPos,Graphic_VPos,Graphic_HSize,Graphic_VSize,PanelBGColor,0,true);
   MakeGroupLable(lablestext,lablecolors,CORNER_LEFT_UPPER,Graphic_HPos,Graphic_VPos,"");
   UpgradeDataInfo();
//---
  }
//+------------------------------------------------------------------+
void MakeBackGround(string name, int hpos, int vpos, int hsize, int vsize, color cl, int zorder, bool select)
  {
//---
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE_LABEL,0,0,0);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,hpos);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,vpos);
   ObjectSetInteger(0,name,OBJPROP_XSIZE,hsize);
   ObjectSetInteger(0,name,OBJPROP_YSIZE,vsize);
   ObjectSetInteger(0,name,OBJPROP_BGCOLOR,cl);
   ObjectSetInteger(0,name,OBJPROP_SELECTABLE,select);
   ObjectSetInteger(0,name,OBJPROP_BORDER_COLOR,clrBlack);
   ObjectSetInteger(0,name,OBJPROP_BORDER_TYPE,BORDER_SUNKEN);
//---
  }
//+------------------------------------------------------------------+
void MakeButton(string name, string text, int fontsize, int hpos, int vpos, int hsize, int vsize, color cl, color fontcl, bool select, string font)
  {
//---
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_BUTTON,0,0,0);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,hpos);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,vpos);
   ObjectSetInteger(0,name,OBJPROP_XSIZE,hsize);
   ObjectSetInteger(0,name,OBJPROP_YSIZE,vsize);
   ObjectSetInteger(0,name,OBJPROP_BGCOLOR,cl);
   TextSetFont(name,fontsize,FONT_STRIKEOUT,FW_BLACK);
   ObjectSetString(0,name,OBJPROP_TEXT,text);
   ObjectSetString(0,name,OBJPROP_FONT,font);
   ObjectSetInteger(0,name,OBJPROP_FONTSIZE,fontsize);
   ObjectSetInteger(0,name,OBJPROP_COLOR,fontcl);
   ObjectSetInteger(0,name,OBJPROP_SELECTABLE,select);
//---
  }
//+------------------------------------------------------------------+
void MakeDropDown(string name, string text, string &item[], color cl, int hpos, int vpos, int hsize, int vsize, bool DDStatus)
  {
//---
   int i = 0;
   MakeButton(name,text,10,hpos,vpos,hsize,22,cl,clrBlack,false,Font);
   MakeLable(name+"arrow",CharToString(218),"WingDings",10,hpos+hsize-15,vpos+2,clrBlack,CORNER_LEFT_UPPER);
   if(DDStatus==true)
     {
      MakeBackGround(name+"List",hpos+2,vpos+20,hsize-1,row*ArraySize(item)+5,cl,1,false);
      for(i=0; i<ArraySize(item); i++)
         MakeLable(name+"Lable"+IntegerToString(i),item[i],Font,8,hpos+5,(vpos+5)+((i+1)*row),clrBlack,CORNER_LEFT_UPPER);
     }
   else
     {
      ObjectDelete(ChartID(),name+"List");
      for(i=0; i<ArraySize(item); i++)
         ObjectDelete(ChartID(),name+"Lable"+IntegerToString(i));
     }
//---
  }
//+------------------------------------------------------------------+
void MakeLable(string name, string text, string font, int fontsize, int hpos, int vpos, color cl, ENUM_BASE_CORNER corner)
  {
//---
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_LABEL,0,0,0);
   ObjectSetString(0,name,OBJPROP_TEXT,text);
   ObjectSetString(0,name,OBJPROP_FONT,font);
   ObjectSetInteger(0,name,OBJPROP_FONTSIZE,fontsize);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,hpos);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,vpos);
   ObjectSetInteger(0,name,OBJPROP_COLOR,cl);
   ObjectSetInteger(0,name,OBJPROP_CORNER,corner);
   ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false);
   TextSetFont(name,fontsize,FONT_STRIKEOUT,FW_BLACK);
//---
  }
//+------------------------------------------------------------------+
void DrawVLine(string name, datetime time, color cl)
  {
//---
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,time,0);
   ObjectSetInteger(0,name,OBJPROP_COLOR,cl);
//---
  }
//+------------------------------------------------------------------+
void MakeEditBox(string name, string lable, string value, int hpos, int vpos, int hsize, int vsize, int fontsize, string font, color cl)
  {
//---
   ObjectCreate(ChartID(),name,OBJ_EDIT,0,0,0);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,hpos);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,vpos);
   ObjectSetInteger(0,name,OBJPROP_XSIZE,hsize);
   ObjectSetInteger(0,name,OBJPROP_YSIZE,vsize);
   ObjectSetInteger(0,name,OBJPROP_BGCOLOR,clrWhite);
   ObjectSetInteger(0,name,OBJPROP_COLOR,cl);
   ObjectSetInteger(0,name,OBJPROP_ALIGN,ALIGN_CENTER);
   ObjectSetString(0,name,OBJPROP_TEXT,value);
   ObjectSetString(0,name,OBJPROP_FONT,font);
   ObjectSetInteger(0,name,OBJPROP_FONTSIZE,fontsize);
//---
   if(StringLen(value)>0)
     {
      MakeButton(name+"btnup","",10,hpos+hsize+1,vpos-2,15,12,clrWhiteSmoke,clrBlack,false,Font);
      MakeButton(name+"btndn","",10,hpos+hsize+1,vpos+10,15,12,clrWhiteSmoke,clrBlack,false,Font);
      MakeLable(name+"up",CharToString(217),"WingDings",10,hpos+hsize+1,vpos-3,clrBlack,CORNER_LEFT_UPPER);
      MakeLable(name+"dn",CharToString(218),"WingDings",10,hpos+hsize+1,vpos+6,clrBlack,CORNER_LEFT_UPPER);
     }
   if(StringLen(lable)>0)
      MakeLable(name+"lable",lable,Font,10,hpos-35,vpos,clrBlack,CORNER_LEFT_UPPER);
//---
  }
//+------------------------------------------------------------------+
void UpDownAction(string editname, bool flag, double step, int dg)
  {
//---
   double value = double(StringToDouble(ObjectGetString(ChartID(),editname,OBJPROP_TEXT)));
   if(flag==true)
      value = value + step;
   if(flag==false)
      value = value - step;
   ObjectSetString(ChartID(),editname,OBJPROP_TEXT,DoubleToString(NormalizeDouble(value,dg),dg));
//---
  }
//+------------------------------------------------------------------+
int GetArrayIndex(string text, string &array[])
  {
//---
   for(int i=0; i<ArraySize(array); i++)
      if(text==array[i])
         return(i);
//---
   return(0);
  }
//+------------------------------------------------------------------+
void DisableDropDown(string name,string &item[])
  {
//---
   int hpos    = int(ObjectGetInteger(ChartID(),name,OBJPROP_XDISTANCE));
   int vpos    = int(ObjectGetInteger(ChartID(),name,OBJPROP_YDISTANCE));
   int hsize   = int(ObjectGetInteger(ChartID(),name,OBJPROP_XSIZE));
   int vsize   = int(ObjectGetInteger(ChartID(),name,OBJPROP_YSIZE));
   string text = ObjectGetString(ChartID(),name,OBJPROP_TEXT);
   MakeDropDown(name,text,item,DDBGColor,hpos,vpos,hsize,vsize,false);
//---
  }
//+------------------------------------------------------------------+
void CheckDropDownEvent(string &darray[], string sparam, string ddname, string disablename1, string disablename2)//, string text)
  {
   int hpos    = int(ObjectGetInteger(ChartID(),ddname,OBJPROP_XDISTANCE));
   int vpos    = int(ObjectGetInteger(ChartID(),ddname,OBJPROP_YDISTANCE));
   int hsize   = int(ObjectGetInteger(ChartID(),ddname,OBJPROP_XSIZE));
   int vsize   = int(ObjectGetInteger(ChartID(),ddname,OBJPROP_YSIZE));
   string text = ObjectGetString(ChartID(),ddname,OBJPROP_TEXT);
   if(sparam==ddname || sparam==ddname+"arrow")
     {
      //---
      if(ObjectFind(ChartID(),ddname+"List")>=0)
        {
         MakeDropDown(ddname,text,darray,DDBGColor,hpos,vpos,hsize,vsize,false);
        }
      else
        {
         DisableAllDropDown();
         MakeDropDown(ddname,text,darray,DDBGColor,hpos,vpos,hsize,vsize,true);
        }
      //---
     }
   for(int i=0; i<ArraySize(darray); i++)
     {
      string name = ddname+"Lable"+IntegerToString(i);
      if(sparam==name)
        {
         MakeDropDown(ddname,darray[i],darray,DDBGColor,hpos,vpos,hsize,vsize,false);
        }
     }
  }
//+------------------------------------------------------------------+
void DisableAllDropDown()
  {
//---
//All Drop Down Box can be diable one by one here
//++++++++++++Example Code Is Here+++++++++++++++
//---
  }
//+------------------------------------------------------------------+
void OnChartEvent(const int id,         // Event ID
                  const long& lparam,   // Parameter of type long event
                  const double& dparam, // Parameter of type double event
                  const string& sparam  // Parameter of type string events
                 )
  {
//---
//All Chart Events can ve detect here
//++++++++++++Here Is An Example Code+++++++++++++
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
     }
   if(id==CHARTEVENT_CLICK)
     {
     }
//++++++++++++++++++++++++++++++++++++++++++++//
  }
//+------------------------------------------------------------------+
void Update()
  {
   UpgradeDataInfo();
   for(int i=0; i<ArraySize(datainfo); i++)
     {
      ObjectSetString(ChartID(),"Lable_"+IntegerToString(i),OBJPROP_TEXT,datainfo[i]);
     }
  }
//+------------------------------------------------------------------+
void UpgradeDataInfo()
  {
   datainfo[0] = "Total Buy : ";
   datainfo[1] = "Total Sell : ";
   datainfo[2] = "Equity : "+DoubleToString(AccountInfoDouble(ACCOUNT_EQUITY),2)+"$";
   datainfo[3] = "Time : "+TimeToString(TimeCurrent(),TIME_SECONDS);
   datainfo[4] = "Profit : "+DoubleToString(MathAbs(AccountInfoDouble(ACCOUNT_EQUITY)-AccountInfoDouble(ACCOUNT_BALANCE)),2)+"$";
  }
//+-------------------------------------------------------
void MakeGroupButton(int number, string &text[], color &cl[], ENUM_BASE_CORNER corner, int hposoffset, int vposoffset, string extraname)
  {
//---
   for(int i=0; i<MathMin(ArraySize(text),ArraySize(cl)); i++)
     {
      string name = "But_"+IntegerToString(i)+extraname;
      int hsize = 100;//Button Width
      int vsize = 40;//Button Height
      int hpos  = hposoffset+20;//Button Horizental Position
      int vpos  = i * (vsize+5)+vposoffset+20;//Button Vertical Position
      if(corner==CORNER_LEFT_UPPER)
         vpos  = i * (vsize+5)+vposoffset+20;//Button Vertical Position
      if(corner==CORNER_LEFT_LOWER)
         vpos  = i * (vsize+5)+vsize+vposoffset+20;//Button Vertical Position
      if(corner==CORNER_RIGHT_UPPER)
         hpos  = hposoffset+hpos+hsize;//Button Horizental Position
      if(corner==CORNER_RIGHT_LOWER)
        {
         vpos  = i * (vsize+5)+vsize+vposoffset+20;//Button Vertical Position
         hpos  = hposoffset+hpos+hsize;//Button Horizental Position
        }
      MakeButton(name,text[i],FontSize,hpos,vpos,hsize,vsize,cl[i],FontColor,true,Font);
     }
//---
  }
//+------------------------------------------------------------------+
void MakeGroupLable(string &text[], color &cl[], ENUM_BASE_CORNER corner, int hposoffset, int vposoffset, string extraname)
  {
//---
   for(int i=0; i<MathMin(ArraySize(text),ArraySize(cl)); i++)
     {
      string name = "Lable_"+IntegerToString(i)+extraname;
      int hsize = 100;//Lable Width
      int vsize = 15;//Lable Height
      int hpos  = hposoffset+5;//Button Horizental Position
      int vpos  = i * (vsize+5)+vposoffset+20;//Button Vertical Position
      if(corner==CORNER_LEFT_UPPER)
         vpos  = i * (vsize+5)+vposoffset+20;//Button Vertical Position
      if(corner==CORNER_LEFT_LOWER)
         vpos  = i * (vsize+5)+vposoffset+20;//Button Vertical Position
      if(corner==CORNER_RIGHT_UPPER)
         hpos  = hpos;//Button Horizental Position
      if(corner==CORNER_RIGHT_LOWER)
        {
         vpos  = i * (vsize+5)+20;//Button Vertical Posi3tion
         hpos  = hpos;//Button Horizental Position
        }
      MakeLable(name,text[i],Font,FontSize,hpos,vpos,FontColor,corner);
     }
//---
  }
//+------------------------------------------------------------------+
void MakeTableLable(int number, string &text[], color &cl[], ENUM_BASE_CORNER corner)
  {
//---
   for(int i=0; i<MathMin(ArraySize(text),ArraySize(cl)); i++)
     {
      string name = "Lable_"+IntegerToString(i);
      int hsize = 100;//Button Width
      int vsize = 40;//Button Height
      int hpos  = 20;//Button Horizental Position
      int vpos  = i * (vsize+5)+20;//Button Vertical Position
      if(corner==CORNER_LEFT_UPPER)
         vpos  = i * (vsize+5)+20;//Button Vertical Position
      if(corner==CORNER_LEFT_LOWER)
         vpos  = i * (vsize+5)+20;//Button Vertical Position
      if(corner==CORNER_RIGHT_UPPER)
         hpos  = hpos;//Button Horizental Position
      if(corner==CORNER_RIGHT_LOWER)
        {
         vpos  = i * (vsize+5)+20;//Button Vertical Posi3tion
         hpos  = hpos;//Button Horizental Position
        }
      MakeLable(name,text[i],Font,FontSize,hpos,vpos,cl[i],corner);
     }
//---
  }
//+------------------------------------------------------------------+
void MakeTableButton(int rownum, int colnum, string &text[][], color &cl[], ENUM_BASE_CORNER corner)
  {
//---
   for(int j=0; j<colnum; j++)
      for(int i=0; i<MathMin(rownum,colnum); i++)
        {
         string name = "But_"+IntegerToString(i)+"_"+IntegerToString(j);
         int hsize   = int((ChartGetInteger(ChartID(),CHART_WIDTH_IN_PIXELS,0)/2)/colnum);//Button Width
         int vsize   = int((ChartGetInteger(ChartID(),CHART_HEIGHT_IN_PIXELS,0)-50)/rownum);//Button Height
         int hpos    = (j*hsize+5)+20;//Button Horizental Position
         int vpos    = i * (vsize+5)+20;//Button Vertical Position
         if(corner==CORNER_LEFT_UPPER)
            vpos  = i * (vsize+5)+20;//Button Vertical Position
         if(corner==CORNER_LEFT_LOWER)
            vpos  = i * (vsize+5)+vsize+20;//Button Vertical Position
         if(corner==CORNER_RIGHT_UPPER)
            hpos  = hpos+hsize;//Button Horizental Position
         if(corner==CORNER_RIGHT_LOWER)
           {
            vpos  = i * (vsize+5)+vsize+20;//Button Vertical Position
            hpos  = hpos+hsize;//Button Horizental Position
           }
         MakeButton(name,"",FontSize,hpos,vpos,hsize,vsize,cl[i],FontColor,true,Font);
         string lable[4] = {"1","2","3","4"};
         MakeGroupLable(lable,cl,CORNER_LEFT_UPPER,hpos,vpos,"_"+IntegerToString(j)+"_"+IntegerToString(i));
        }
//---
  }
//+------------------------------------------------------------------+
void ButtonAction(string name)
  {
//---
   int hpos    = int(ObjectGetInteger(ChartID(),name,OBJPROP_XDISTANCE));
   int vpos    = int(ObjectGetInteger(ChartID(),name,OBJPROP_YDISTANCE));
   int hsize   = int(ObjectGetInteger(ChartID(),name,OBJPROP_XSIZE));
   int vsize   = int(ObjectGetInteger(ChartID(),name,OBJPROP_YSIZE));
   color cl    = color(ObjectGetInteger(ChartID(),name,OBJPROP_BGCOLOR));
   string text = ObjectGetString(ChartID(),name,OBJPROP_TEXT);
   ObjectDelete(ChartID(),name);
   Sleep(200);
   MakeButton(name,text,FontSize,hpos,vpos,hsize,vsize,cl,FontColor,true,"Arial");
//---
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CheckMAFilter(ENUM_ORDER_TYPE TheType)
  {
   double Bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);

   double MA1_Array[];

   ArraySetAsSeries(MA1_Array,true);

   int MA1_Handle= iMA(_Symbol,0,FilterPeriod,FilterShift,FilterMethod,FilterAppliedPrice);

   CopyBuffer(MA1_Handle,0,0,3,MA1_Array);

//---Write your main logic here
   double MAPrice = MA1_Array[1];

   if((TheType==OP_BUY && Bid>MAPrice) || (TheType==OP_SELL && Bid<MAPrice))
      return true;


   return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void MATrades()
  {
   /*   if(TotalOrder(6,_Symbol)==0)
         return;

      double Open1 = iOpen(_Symbol,0,1);
      double High1 = iHigh(_Symbol,0,1);
      double Low1 = iLow(_Symbol,0,1);
      double Close1 = iClose(_Symbol,0,1);

      double Bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
      double Ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);

      double MA1_Array[];

      ArraySetAsSeries(MA1_Array,true);

      int MA1_Handle= iMA(_Symbol,0,FilterPeriod,FilterShift,FilterMethod,FilterAppliedPrice);

      CopyBuffer(MA1_Handle,0,0,3,MA1_Array);

   //---Write your main logic here
      double MAPrice = MA1_Array[1];

      if(Close1>MAPrice && Ask<=MAPrice)
        {
         Trade(_Symbol,ORDER_TYPE_BUY,);
        }

      if(Close1<MAPrice && Bid>=MAPrice)
        {
         Trade(_Symbol,ORDER_TYPE_SELL,);

         if(StrategyType==Strategy1)
            Ticket=Trade(sym,OP_SELL,LotValidity(sym,LotSize1),Bid,0,SL,TP1,"_1st",MagicNumber,0,clrRed);
         if(StrategyType==Strategy2)
           {
            Ticket=Trade(sym,OP_SELL,LotValidity(sym,LotSize1),Bid,0,SL,TP1,"_2nd",MagicNumber,0,clrRed);
            Ticket=Trade(sym,OP_SELL,LotValidity(sym,LotSize2),Bid,0,SL,TP2,"_3th",MagicNumber,0,clrRed);
           }
         if(StrategyType==Strategy3)
           {
            Ticket=Trade(sym,OP_SELL,LotValidity(sym,LotSize1),Bid,0,SL,TP1,"_1st",MagicNumber,0,clrRed);
            Ticket=Trade(sym,OP_SELL,LotValidity(sym,LotSize2),Bid,0,SL,TP2,"_2nd",MagicNumber,0,clrRed);
            Ticket=Trade(sym,OP_SELL,LotValidity(sym,LotSize3),Bid,0,SL,TP3,"_3th",MagicNumber,0,clrRed);
           }
        }
   */
  }

//+------------------------------------------------------------------+
void CheckSignal(string sym)
  {
//---
   double MA1_Array[];

   double MA2_Array[];

   ArraySetAsSeries(MA1_Array,true);
   ArraySetAsSeries(MA2_Array,true);

   int MA1_Handle= iMA(sym,PERIOD_CURRENT,MAPeriod1,0,MAMethod1,MAPrice1);

   int MA2_Handle= iMA(sym,PERIOD_CURRENT,MAPeriod2,0,MAMethod2,MAPrice2);

   CopyBuffer(MA1_Handle,0,0,3,MA1_Array);
   CopyBuffer(MA2_Handle,0,0,3,MA2_Array);

//---Write your main logic here
   double MA10 = MA1_Array[0];
   double MA20 = MA2_Array[0];

   double MA11 = MA1_Array[1];
   double MA12 = MA1_Array[2];
   double MA21 = MA2_Array[1];
   double MA22 = MA2_Array[2];
//---
   if(UseCandle==Closed)
     {
      if(MA11>MA21 && MA12<MA22)
        {
         Trend = 0;
        }
      if(MA11<MA21 && MA12>MA22)
        {
         Trend = 1;
        }
     }

   if(UseCandle==Current)
     {
      if((MA10>MA20 && MA11<MA21) || (MA10>MA20 && MA11==MA21 && MA12<MA22))
        {
         Trend = 0;
        }
      if((MA10<MA20 && MA11>MA21) || (MA10<MA20 && MA11==MA21 && MA12>MA22))
        {
         Trend = 1;
        }
     }
//---
   if(Close_By_Reverse_Signal==true)
     {
      if(Trend==0)
         CloseAll(1,sym);
      if(Trend==1)
         CloseAll(0,sym);
     }
//---
  }
//+------------------------------------------------------------------+
void DoTrail1()
  {
   if(!trail_stop)
      return;
//---
   if(TrailMode==New)
     {
      for(int i=PositionsTotal()-1; i>=0; i--) // returns the number of open positions
         if(m_position.SelectByIndex(i))
            if(m_position.Symbol()==_Symbol && m_position.Magic()==MagicNumber && StringFind(m_position.Comment(),"R:")==-1 && StringFind(m_position.Comment(),"B:")==-1)
              {
               double TheBid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
               double TheAsk = SymbolInfoDouble(_Symbol,SYMBOL_ASK);

               if(m_position.PositionType()==POSITION_TYPE_BUY)
                 {
                  if(TheBid-m_position.PriceOpen()>ExtTrailingStep*_Point && TheBid>m_position.PriceOpen()+AllowancePoints*_Point)
                    {
                     if(m_position.StopLoss()==0 || m_position.StopLoss()==NULL || m_position.StopLoss()<TheBid-ExtTrailingStep*_Point)
                       {
                        if(m_position.StopLoss()>=m_position.PriceOpen() &&
                           m_position.StopLoss()!=NormalizeDouble(TheBid-ExtTrailingStep*_Point,_Digits))
                          {
                           if(!m_trade.PositionModify(m_position.Ticket(),
                                                      NormalizeDouble(TheBid-ExtTrailingStep*_Point,_Digits),
                                                      m_position.TakeProfit()))
                              Print("Error:",GetLastError());
                           else
                             {
                              Print("Trailing..");
                             }

                           continue;
                          }

                        if(m_position.StopLoss()==0 || m_position.StopLoss()==NULL || m_position.StopLoss()<m_position.PriceOpen())
                          {
                           if(!m_trade.PositionModify(m_position.Ticket(),
                                                      m_position.PriceOpen()+AllowancePoints*_Point,
                                                      m_position.TakeProfit()))
                              Print("Error:",GetLastError());
                           else
                             {
                              Print("Trailing..");
                             }

                           continue;
                          }
                       }
                    }
                 }
               else
                  if(m_position.PositionType()==POSITION_TYPE_SELL)
                    {
                     if(m_position.PriceOpen()-TheAsk>ExtTrailingStep*_Point && TheAsk<m_position.PriceOpen()-AllowancePoints*_Point)
                       {
                        if(m_position.StopLoss()==0 || m_position.StopLoss()==NULL || m_position.StopLoss()>TheAsk+ExtTrailingStep*_Point)
                          {
                           if(m_position.StopLoss()<=m_position.PriceOpen() &&
                              m_position.StopLoss()!=NormalizeDouble(TheAsk+ExtTrailingStep*_Point,_Digits))
                             {
                              if(!m_trade.PositionModify(m_position.Ticket(),
                                                         NormalizeDouble(TheAsk+ExtTrailingStep*_Point,_Digits),
                                                         m_position.TakeProfit()))
                                 Print("Error:",GetLastError());
                              else
                                {
                                 Print("Trailing..");
                                }
                             }

                           if(m_position.StopLoss()>m_position.PriceOpen() || m_position.StopLoss()==0 || m_position.StopLoss()==NULL)
                             {
                              if(!m_trade.PositionModify(m_position.Ticket(),
                                                         m_position.PriceOpen()-AllowancePoints*_Point,
                                                         m_position.TakeProfit()))
                                 Print("Error:",GetLastError());
                              else
                                {
                                 Print("Trailing..");
                                }
                             }
                          }
                       }
                    }
              }
     }
   else
     {
      for(int i=PositionsTotal()-1; i>=0; i--) // returns the number of open positions
         if(m_position.SelectByIndex(i))
            if(m_position.Symbol()==_Symbol && m_position.Magic()==MagicNumber && StringFind(m_position.Comment(),"R:")==-1 && StringFind(m_position.Comment(),"B:")==-1)
              {
               double TheBid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
               double TheAsk = SymbolInfoDouble(_Symbol,SYMBOL_ASK);

               if(m_position.PositionType()==POSITION_TYPE_BUY)
                 {
                  string Comments[];

                  int Split = StringSplit(m_position.Comment(),StringGetCharacter(":",0),Comments);

                  if(Split==3)
                    {
                     if((StringFind(Comments[0],"_2")!=-1 || StringFind(Comments[0],"_3")!=-1) &&
                        TheBid>=(double)Comments[1] && TheBid>m_position.PriceOpen()+AllowancePoints*_Point &&
                        (m_position.StopLoss()<m_position.PriceOpen() || m_position.StopLoss()==NULL || m_position.StopLoss()==0) &&
                        m_position.StopLoss()!=m_position.PriceOpen()+AllowancePoints*_Point)
                       {
                        if(!m_trade.PositionModify(m_position.Ticket(),
                                                   NormalizeDouble(m_position.PriceOpen()+AllowancePoints*_Point,_Digits),
                                                   m_position.TakeProfit()))
                           Print("Error:",GetLastError());
                        else
                          {
                           Print("Trailing..");
                          }
                        continue;
                       }

                     if(StringFind(Comments[0],"_3")!=-1 &&
                        TheBid>=(double)Comments[2] &&
                        (m_position.StopLoss()<(double)Comments[2] || m_position.StopLoss()==NULL || m_position.StopLoss()==0) &&
                        m_position.StopLoss()!=(double)Comments[1] &&
                        (double)Comments[1]>m_position.PriceOpen())
                       {
                        if(!m_trade.PositionModify(m_position.Ticket(),
                                                   NormalizeDouble((double)Comments[1],_Digits),
                                                   m_position.TakeProfit()))
                           Print("Error:",GetLastError());
                        else
                          {
                           Print("Trailing..");
                          }
                        continue;
                       }

                     if(StringFind(Comments[0],"_3")!=-1 &&
                        TheBid>=((double)Comments[2]+(m_position.TakeProfit()-(double)Comments[2])*TrailPercentage*0.01) &&
                        (m_position.StopLoss()<(double)Comments[2] || m_position.StopLoss()==NULL || m_position.StopLoss()==0) &&
                        m_position.StopLoss()!=(double)Comments[2])
                       {
                        if(!m_trade.PositionModify(m_position.Ticket(),
                                                   NormalizeDouble((double)Comments[2],_Digits),
                                                   m_position.TakeProfit()))
                           Print("Error:",GetLastError());
                        else
                          {
                           Print("Trailing..");
                          }
                        continue;
                       }
                    }
                 }
               else
                  if(m_position.PositionType()==POSITION_TYPE_SELL)
                    {
                     string Comments[];

                     int Split = StringSplit(m_position.Comment(),StringGetCharacter(":",0),Comments);

                     if(Split==3)
                       {
                        if((StringFind(Comments[0],"_2")!=-1 || StringFind(Comments[0],"_3")!=-1) &&
                           TheAsk<=(double)Comments[1] && TheAsk<m_position.PriceOpen()-AllowancePoints*_Point &&
                           (m_position.StopLoss()>m_position.PriceOpen() || m_position.StopLoss()==NULL || m_position.StopLoss()==0) &&
                           m_position.StopLoss()!=m_position.PriceOpen()-AllowancePoints*_Point)
                          {
                           if(!m_trade.PositionModify(m_position.Ticket(),
                                                      NormalizeDouble(m_position.PriceOpen()-AllowancePoints*_Point,_Digits),
                                                      m_position.TakeProfit()))
                              Print("Error:",GetLastError());
                           else
                             {
                              Print("Trailing..");
                             }
                           continue;
                          }

                        if(StringFind(Comments[0],"_3")!=-1 &&
                           TheAsk<=(double)Comments[2] &&
                           (m_position.StopLoss()>(double)Comments[2] || m_position.StopLoss()==NULL || m_position.StopLoss()==0) &&
                           m_position.StopLoss()!=(double)Comments[1] &&
                           (double)Comments[1]<m_position.PriceOpen())
                          {
                           if(!m_trade.PositionModify(m_position.Ticket(),
                                                      NormalizeDouble((double)Comments[1],_Digits),
                                                      m_position.TakeProfit()))
                              Print("Error:",GetLastError());
                           else
                             {
                              Print("Trailing..");
                             }
                           continue;
                          }

                        if(StringFind(Comments[0],"_3")!=-1 &&
                           TheAsk<=((double)Comments[2]-((double)Comments[2]-m_position.TakeProfit())*TrailPercentage*0.01) &&
                           (m_position.StopLoss()>(double)Comments[2] || m_position.StopLoss()==NULL || m_position.StopLoss()==0) &&
                           m_position.StopLoss()!=(double)Comments[2])
                          {
                           if(!m_trade.PositionModify(m_position.Ticket(),
                                                      NormalizeDouble((double)Comments[2],_Digits),
                                                      m_position.TakeProfit()))
                              Print("Error:",GetLastError());
                           else
                             {
                              Print("Trailing..");
                             }
                           continue;
                          }
                       }

                    }
              }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DoTrail2()
  {
   if(!Con_trail_stop)
      return;
//---
   if(Con_TrailMode==New)
     {
      for(int i=PositionsTotal()-1; i>=0; i--) // returns the number of open positions
         if(m_position.SelectByIndex(i))
            if(m_position.Symbol()==_Symbol && m_position.Magic()==MagicNumber && (StringFind(m_position.Comment(),"R:")!=-1 || StringFind(m_position.Comment(),"B:")!=-1))
              {
               double TheBid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
               double TheAsk = SymbolInfoDouble(_Symbol,SYMBOL_ASK);

               if(m_position.PositionType()==POSITION_TYPE_BUY)
                 {
                  if(TheBid-m_position.PriceOpen()>Con_ExtTrailingStep*_Point && TheBid>m_position.PriceOpen()+Con_AllowancePoints*_Point)
                    {
                     if(m_position.StopLoss()==0 || m_position.StopLoss()==NULL || m_position.StopLoss()<TheBid-Con_ExtTrailingStep*_Point)
                       {
                        if(m_position.StopLoss()>=m_position.PriceOpen() &&
                           m_position.StopLoss()!=NormalizeDouble(TheBid-Con_ExtTrailingStep*_Point,_Digits))
                          {
                           if(!m_trade.PositionModify(m_position.Ticket(),
                                                      NormalizeDouble(TheBid-Con_ExtTrailingStep*_Point,_Digits),
                                                      m_position.TakeProfit()))
                              Print("Error:",GetLastError());
                           else
                             {
                              Print("Trailing..");
                             }

                           continue;
                          }

                        if(m_position.StopLoss()==0 || m_position.StopLoss()==NULL || m_position.StopLoss()<m_position.PriceOpen())
                          {
                           if(!m_trade.PositionModify(m_position.Ticket(),
                                                      m_position.PriceOpen()+Con_AllowancePoints*_Point,
                                                      m_position.TakeProfit()))
                              Print("Error:",GetLastError());
                           else
                             {
                              Print("Trailing..");
                             }

                           continue;
                          }
                       }
                    }
                 }
               else
                  if(m_position.PositionType()==POSITION_TYPE_SELL)
                    {
                     if(m_position.PriceOpen()-TheAsk>Con_ExtTrailingStep*_Point && TheAsk<m_position.PriceOpen()-Con_AllowancePoints*_Point)
                       {
                        if(m_position.StopLoss()==0 || m_position.StopLoss()==NULL || m_position.StopLoss()>TheAsk+Con_ExtTrailingStep*_Point)
                          {
                           if(m_position.StopLoss()<=m_position.PriceOpen() &&
                              m_position.StopLoss()!=NormalizeDouble(TheAsk+Con_ExtTrailingStep*_Point,_Digits))
                             {
                              if(!m_trade.PositionModify(m_position.Ticket(),
                                                         NormalizeDouble(TheAsk+Con_ExtTrailingStep*_Point,_Digits),
                                                         m_position.TakeProfit()))
                                 Print("Error:",GetLastError());
                              else
                                {
                                 Print("Trailing..");
                                }
                             }

                           if(m_position.StopLoss()>m_position.PriceOpen() || m_position.StopLoss()==0 || m_position.StopLoss()==NULL)
                             {
                              if(!m_trade.PositionModify(m_position.Ticket(),
                                                         m_position.PriceOpen()-Con_AllowancePoints*_Point,
                                                         m_position.TakeProfit()))
                                 Print("Error:",GetLastError());
                              else
                                {
                                 Print("Trailing..");
                                }
                             }
                          }
                       }
                    }
              }
     }
   else
     {
      for(int i=PositionsTotal()-1; i>=0; i--) // returns the number of open positions
         if(m_position.SelectByIndex(i))
            if(m_position.Symbol()==_Symbol && m_position.Magic()==MagicNumber && (StringFind(m_position.Comment(),"R:")!=-1 || StringFind(m_position.Comment(),"B:")!=-1))
              {
               double TheBid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
               double TheAsk = SymbolInfoDouble(_Symbol,SYMBOL_ASK);

               if(m_position.PositionType()==POSITION_TYPE_BUY)
                 {
                  string Comments[];

                  int Split = StringSplit(m_position.Comment(),StringGetCharacter(":",0),Comments);

                  if(Split==3)
                    {
                     if((StringFind(Comments[0],"2")!=-1 || StringFind(Comments[0],"3")!=-1) &&
                        TheBid>=(double)Comments[1] && TheBid>m_position.PriceOpen()+Con_AllowancePoints*_Point &&
                        (m_position.StopLoss()<m_position.PriceOpen() || m_position.StopLoss()==NULL || m_position.StopLoss()==0) &&
                        m_position.StopLoss()!=m_position.PriceOpen()+Con_AllowancePoints*_Point)
                       {
                        if(!m_trade.PositionModify(m_position.Ticket(),
                                                   NormalizeDouble(m_position.PriceOpen()+Con_AllowancePoints*_Point,_Digits),
                                                   m_position.TakeProfit()))
                           Print("Error:",GetLastError());
                        else
                          {
                           Print("Trailing..");
                          }
                        continue;
                       }

                     if(StringFind(Comments[0],"3")!=-1 &&
                        TheBid>=(double)Comments[2] &&
                        (m_position.StopLoss()<(double)Comments[2] || m_position.StopLoss()==NULL || m_position.StopLoss()==0) &&
                        m_position.StopLoss()!=(double)Comments[1] &&
                        (double)Comments[1]>m_position.PriceOpen())
                       {
                        if(!m_trade.PositionModify(m_position.Ticket(),
                                                   NormalizeDouble((double)Comments[1],_Digits),
                                                   m_position.TakeProfit()))
                           Print("Error:",GetLastError());
                        else
                          {
                           Print("Trailing..");
                          }
                        continue;
                       }

                     if(StringFind(Comments[0],"3")!=-1 &&
                        TheBid>=((double)Comments[2]+(m_position.TakeProfit()-(double)Comments[2])*Con_TrailPercentage*0.01) &&
                        (m_position.StopLoss()<(double)Comments[2] || m_position.StopLoss()==NULL || m_position.StopLoss()==0) &&
                        m_position.StopLoss()!=(double)Comments[2])
                       {
                        if(!m_trade.PositionModify(m_position.Ticket(),
                                                   NormalizeDouble((double)Comments[2],_Digits),
                                                   m_position.TakeProfit()))
                           Print("Error:",GetLastError());
                        else
                          {
                           Print("Trailing..");
                          }
                        continue;
                       }
                    }
                 }
               else
                  if(m_position.PositionType()==POSITION_TYPE_SELL)
                    {
                     string Comments[];

                     int Split = StringSplit(m_position.Comment(),StringGetCharacter(":",0),Comments);

                     if(Split==3)
                       {
                        if((StringFind(Comments[0],"2")!=-1 || StringFind(Comments[0],"3")!=-1) &&
                           TheAsk<=(double)Comments[1] && TheAsk<m_position.PriceOpen()-Con_AllowancePoints*_Point &&
                           (m_position.StopLoss()>m_position.PriceOpen() || m_position.StopLoss()==NULL || m_position.StopLoss()==0) &&
                           m_position.StopLoss()!=m_position.PriceOpen()-Con_AllowancePoints*_Point)
                          {
                           if(!m_trade.PositionModify(m_position.Ticket(),
                                                      NormalizeDouble(m_position.PriceOpen()-Con_AllowancePoints*_Point,_Digits),
                                                      m_position.TakeProfit()))
                              Print("Error:",GetLastError());
                           else
                             {
                              Print("Trailing..");
                             }
                           continue;
                          }

                        if(StringFind(Comments[0],"3")!=-1 &&
                           TheAsk<=(double)Comments[2] &&
                           (m_position.StopLoss()>(double)Comments[2] || m_position.StopLoss()==NULL || m_position.StopLoss()==0) &&
                           m_position.StopLoss()!=(double)Comments[1] &&
                           (double)Comments[1]<m_position.PriceOpen())
                          {
                           if(!m_trade.PositionModify(m_position.Ticket(),
                                                      NormalizeDouble((double)Comments[1],_Digits),
                                                      m_position.TakeProfit()))
                              Print("Error:",GetLastError());
                           else
                             {
                              Print("Trailing..");
                             }
                           continue;
                          }

                        if(StringFind(Comments[0],"3")!=-1 &&
                           TheAsk<=((double)Comments[2]-((double)Comments[2]-m_position.TakeProfit())*Con_TrailPercentage*0.01) &&
                           (m_position.StopLoss()>(double)Comments[2] || m_position.StopLoss()==NULL || m_position.StopLoss()==0) &&
                           m_position.StopLoss()!=(double)Comments[2])
                          {
                           if(!m_trade.PositionModify(m_position.Ticket(),
                                                      NormalizeDouble((double)Comments[2],_Digits),
                                                      m_position.TakeProfit()))
                              Print("Error:",GetLastError());
                           else
                             {
                              Print("Trailing..");
                             }
                           continue;
                          }
                       }

                    }
              }
     }
  }

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DoPivot()
  {
//---
   int Count;
   double Range;
   bool check = false;
   double newsl = 0;
//i = Bars - IndicatorCounted() - 1;
   int i=iBars(Symbol(),PERIOD_CURRENT)-10;
   ArrayResize(Res1,i+2);
   ArrayResize(Res2,i+2);
   ArrayResize(Res3,i+2);
   ArrayResize(Sup1,i+2);
   ArrayResize(Sup2,i+2);
   ArrayResize(Sup3,i+2);
   ArrayResize(Pivot,i+2);
   while(i>=0)
     {
      // If the pivot day changes...
      if(PivotDay(iTime(_Symbol,0,i+1),ShiftHrs)!=PivotDay(iTime(_Symbol,0,i),ShiftHrs))
        {
         // Determine High & Low for the previous Pivot Day
         Count = iBarShift(NULL, 0, PivotDayStartTime) - i;             // number of bars in the day
         PDayHigh = iHigh(_Symbol,0,iHighest(NULL, 0, MODE_HIGH, Count, i+1));   // Pivot Day high
         PDayLow = iLow(_Symbol,0,iLowest(NULL, 0, MODE_LOW, Count, i+1));       // Pivot Day low

         // Pivot calculations
         Pivot[i]=(PDayHigh+PDayLow+iClose(_Symbol,PERIOD_CURRENT,i+1))/3;    // Pivot point
         Range=PDayHigh-PDayLow;
         Res1[i] = 2 * Pivot[i] - PDayLow;                     // R1
         Res2[i] = Pivot[i] + Range;                           // R2
         Res3[i] = Res1[i] + Range;                            // R3
         Sup1[i] = 2 * Pivot[i] - PDayHigh;                    // S1
         Sup2[i] = Pivot[i] - Range;                           // S2
         Sup3[i] = Sup1[i] - Range;                            // S3

         // Don't draw the transition between levels
         Res3[i+1] = EMPTY_VALUE;
         Res2[i+1] = EMPTY_VALUE;
         Res1[i+1] = EMPTY_VALUE;
         Pivot[i+1]= EMPTY_VALUE;
         Sup1[i+1] = EMPTY_VALUE;
         Sup2[i+1] = EMPTY_VALUE;
         Sup3[i+1] = EMPTY_VALUE;

         // Remember when the Day changed over
         PivotDayStartTime=iTime(_Symbol,PERIOD_CURRENT,i);
        }
      else     // no change to pivot levels
        {
         Res3[i] = Res3[i+1];
         Res2[i] = Res2[i+1];
         Res1[i] = Res1[i+1];
         Pivot[i]= Pivot[i+1];
         Sup1[i] = Sup1[i+1];
         Sup2[i] = Sup2[i+1];
         Sup3[i] = Sup3[i+1];
        }

      // Move the labels to sensible places
      // If this is the last bar and (it's a new bar or time scale has changed)...
      if(i==0 && (BarTime!=iTime(_Symbol,0,i) || VisibleBars!=WindowBarsPerChart()))
        {
         DayStartBar = iBarShift(ThisSymbol, Period(), PivotDayStartTime);
         LeftMostBar = WindowFirstVisibleBar()-7;
         RightMostBar= 15;
         if(DayStartBar<RightMostBar) // label too close to the right
           {
            ObjectMove(0,R3_NAME,0,iTime(_Symbol,0,RightMostBar),Res3[i]);
            ObjectMove(0,R2_NAME,0,iTime(_Symbol,0,RightMostBar),Res2[i]);
            ObjectMove(0,R1_NAME,0,iTime(_Symbol,0,RightMostBar),Res1[i]);
            ObjectMove(0,PIVOT_NAME,0,iTime(_Symbol,0,RightMostBar),Pivot[i]);
            ObjectMove(0,S1_NAME,0,iTime(_Symbol,0,RightMostBar),Sup1[i]);
            ObjectMove(0,S2_NAME,0,iTime(_Symbol,0,RightMostBar),Sup2[i]);
            ObjectMove(0,S3_NAME,0,iTime(_Symbol,0,RightMostBar),Sup3[i]);
           }
         else
            if(DayStartBar>LeftMostBar) // label too close to the left
              {
               ObjectMove(0,R3_NAME,0,iTime(_Symbol,0,LeftMostBar),Res3[i]);
               ObjectMove(0,R2_NAME,0,iTime(_Symbol,0,LeftMostBar),Res2[i]);
               ObjectMove(0,R1_NAME,0,iTime(_Symbol,0,LeftMostBar),Res1[i]);
               ObjectMove(0,PIVOT_NAME,0,iTime(_Symbol,0,LeftMostBar),Pivot[i]);
               ObjectMove(0,S1_NAME,0,iTime(_Symbol,0,LeftMostBar),Sup1[i]);
               ObjectMove(0,S2_NAME,0,iTime(_Symbol,0,LeftMostBar),Sup2[i]);
               ObjectMove(0,S3_NAME,0,iTime(_Symbol,0,LeftMostBar),Sup3[i]);
              }
            else                                      // move it with the bars
              {
               ObjectMove(0,R3_NAME,0,PivotDayStartTime,Res3[i]);
               ObjectMove(0,R2_NAME,0,PivotDayStartTime,Res2[i]);
               ObjectMove(0,R1_NAME,0,PivotDayStartTime,Res1[i]);
               ObjectMove(0,PIVOT_NAME,0,PivotDayStartTime,Pivot[i]);
               ObjectMove(0,S1_NAME,0,PivotDayStartTime,Sup1[i]);
               ObjectMove(0,S2_NAME,0,PivotDayStartTime,Sup2[i]);
               ObjectMove(0,S3_NAME,0,PivotDayStartTime,Sup3[i]);
              }
        }

      VisibleBars=WindowBarsPerChart();
      BarTime=iTime(_Symbol,0,i);
      i--;
     }
//if(TotalOrder(-1,Symbol())==0)
//  {
   BuyFirstTP  = Res1[1];
   SellFirstTP = Sup1[1];
//...
   BuySecondTP  = Res2[1];
   SellSecondTP = Sup2[1];
//...
   BuyThirdTP  = Res3[1];
   SellThirdTP = Sup3[1];
//xPrint("pivots defined! TP1 SELL : ",Pivot[1]);
//...
//}
   /*string text = "";
   text += "Buy TP1 :"+DoubleToString(BuyFirstTP,_Digits);
   text += "\nBuy TP2 : "+DoubleToString(BuySecondTP,_Digits);
   text += "\nBuy TP3 : "+DoubleToString(BuyThirdTP,_Digits);
   text += "\nSell TP1 : "+DoubleToString(SellFirstTP,_Digits);
   text += "\nSell TP2 : "+DoubleToString(SellSecondTP,_Digits);
   text += "\nSell TP3 : "+DoubleToString(SellThirdTP,_Digits);
   Comment(text);*/
//...
   int daycounter = 0;
   for(int d=1; d<ArraySize(Res1)-1; d++)
     {
      //      if(TimeDayOfYear(iTime(_Symbol,0,d))!=TimeDayOfYear(iTime(_Symbol,0,d+1)))
      datetime date1=iTime(_Symbol,0,d);
      datetime date2=iTime(_Symbol,0,d+1);

      MqlDateTime str1, str2;

      TimeToStruct(date1,str1);
      TimeToStruct(date2,str2);

      if(str1.day_of_year!=str2.day_of_year)
        {
         daycounter++;
         datetime startt = iTime(_Symbol,0,d);
         datetime stopt  = startt+(1440*60);
         //FIXED IN V2
         datetime middle = datetime(((startt+stopt)/2)-10800);
         int StartBar = iBarShift(_Symbol,PERIOD_CURRENT,startt);
         int EndBar = iBarShift(_Symbol,PERIOD_CURRENT,stopt);

         int Dividend = (StartBar - EndBar)/30;
         int MiddleBar = (StartBar - EndBar)/3;

         //datetime middle = (datetime)(iTime(_Symbol,PERIOD_CURRENT,StartBar-(int)MathFloor(Dividend>=1?(Dividend*13):0)));

         DrawTLine(ID+"Res1_"+TimeToString(iTime(_Symbol,0,d)),startt,Res1[d],stopt,Res1[d],ResistanceColor);
         DrawText(ID+"Res1Text_"+TimeToString(iTime(_Symbol,0,d)),middle,Res1[d],"Res1 : "+DoubleToString(Res1[d],_Digits),FontColor);
         DrawTLine(ID+"Res2_"+TimeToString(iTime(_Symbol,0,d)),startt,Res2[d],stopt,Res2[d],ResistanceColor);
         DrawText(ID+"Res2Text_"+TimeToString(iTime(_Symbol,0,d)),middle,Res2[d],"Res2 : "+DoubleToString(Res2[d],_Digits),FontColor);
         DrawTLine(ID+"Res3_"+TimeToString(iTime(_Symbol,0,d)),startt,Res3[d],stopt,Res3[d],ResistanceColor);
         DrawText(ID+"Res3Text_"+TimeToString(iTime(_Symbol,0,d)),middle,Res3[d],"Res3 : "+DoubleToString(Res3[d],_Digits),FontColor);
         DrawTLine(ID+"Pivot_"+TimeToString(iTime(_Symbol,0,d)),startt,Pivot[d],stopt,Pivot[d],PivotColor);
         DrawText(ID+"PivotText_"+TimeToString(iTime(_Symbol,0,d)),middle,Pivot[d],"Pivot : "+DoubleToString(Pivot[d],_Digits),FontColor);
         //...
         DrawTLine(ID+"Sup1_"+TimeToString(iTime(_Symbol,0,d)),startt,Sup1[d],stopt,Sup1[d],SupportColor);
         DrawText(ID+"Sup1Text_"+TimeToString(iTime(_Symbol,0,d)),middle,Sup1[d],"Sup1 : "+DoubleToString(Sup1[d],_Digits),FontColor);
         DrawTLine(ID+"Sup2_"+TimeToString(iTime(_Symbol,0,d)),startt,Sup2[d],stopt,Sup2[d],SupportColor);
         DrawText(ID+"Sup2Text_"+TimeToString(iTime(_Symbol,0,d)),middle,Sup2[d],"Sup2 : "+DoubleToString(Sup2[d],_Digits),FontColor);
         DrawTLine(ID+"Sup3_"+TimeToString(iTime(_Symbol,0,d)),startt,Sup3[d],stopt,Sup3[d],SupportColor);
         DrawText(ID+"Sup3Text_"+TimeToString(iTime(_Symbol,0,d)),middle,Sup3[d],"Sup3 : "+DoubleToString(Sup3[d],_Digits),FontColor);
         //...
        }
      if(daycounter>10)
         break;
     }
//Comment("Res1 : "+Res1[1]+"\nRes2 : "+Res2[1]+"\nRes3 : "+Res3[1]+"\nSup1 : "+Sup1[1]+"\nSup2 : "+Sup2[1]+"\nSup3 : "+Sup3[1]);
//---
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int WindowBarsPerChart()
  {
   return (int)ChartGetInteger(0,CHART_WIDTH_IN_BARS,0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int WindowFirstVisibleBar()
  {
   return (int)ChartGetInteger(0,CHART_FIRST_VISIBLE_BAR,0);
  }
//+------------------------------------------------------------------+
void DrawText(string name,datetime t1, double p1, string text, color cl)
  {
//---
   if(ShowText==false)
      return;
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TEXT,0,t1,p1);
   ObjectSetInteger(0,name,OBJPROP_COLOR,cl);
   ObjectSetString(0,name,OBJPROP_TEXT,text);
   ObjectSetString(0,name,OBJPROP_FONT,"Arial Black");
   ObjectSetInteger(0,name,OBJPROP_FONTSIZE,FontSize);
//---
  }
//+------------------------------------------------------------------+
void DrawTLine(string name,datetime t1, double p1, datetime t2, double p2, color cl)
  {
//---
   if(ShowLine==false)
      return;
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,t1,p1,t2,p2);
   ObjectSetInteger(0,name,OBJPROP_COLOR,cl);
   ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASH);
   ObjectSetInteger(0,name,OBJPROP_RAY,false);
//---
  }
//+------------------------------------------------------------------+
void DrawHLine(string name, double price, color cl)
  {
//---
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_HLINE,0,0,price);
   ObjectSetInteger(0,name,OBJPROP_COLOR,cl);
   ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASH);
//---
  }
//+------------------------------------------------------------------+
int PivotDay(datetime Bar_Time,datetime Shift_Hrs)
  {
   datetime date1=Bar_Time+Shift_Hrs*3600;

   MqlDateTime str1;

   TimeToStruct(date1,str1);

   int PDay=str1.day_of_week;

   if(PDay == 0)
      PDay = 1;      // Count Sunday as Monday
   if(PDay == 6)
      PDay = 5;      // Count Saturday as Friday

   return(PDay);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

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
