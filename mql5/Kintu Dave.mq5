//+------------------------------------------------------------------+
//|                                                   Kintu Dave.mq5 |
//|                                   Copyright 2022, Yousuf Mesalm. |
//|                                    https://www.Yousuf-mesalm.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Yousuf Mesalm."
#property link      "https://www.Yousuf-mesalm.com"
#property version   "1.00"

//enum
enum RiskOptions
  {
   CloseAll,
   No_Entry,
  };
// includes
#include  <YM\Execute\Execute.mqh>
#include  <YM\Position\Position.mqh>

//--- input parameters
input string               set0="====================Bplinger Band Settings=================";
input int                  bands_period=20;           // period of moving average
input int                  bands_shift=0;             // shift
input double               deviation=2.0;             // number of standard deviations
input ENUM_APPLIED_PRICE   applied_price=PRICE_CLOSE; // type of price
input ENUM_TIMEFRAMES      period=PERIOD_CURRENT;     // timeframe

input double               volume=0.1;
input RiskOptions          Risk_Options=CloseAll;
input double               Max_Risk=20;               // Max Risk in %
input long                 Magic_Number=2020;
input string               comment="";
input int                  Standard_Deviation   =40;
input double               USD_Loss_Max   = 5000   ; // DOLLAR VALUE STOP LOSS
input double               Max_total_volume  =2    ; // MaX Total Volume
input bool                 Market_Open_close_filtter    =true; //	Market Open - Close Filter 
input int                  H_open=  3;  // After Market open x Hours
input int                  H_clode =3;  // before Market Close x Hours
int handle0=0;

//objects
CUtilities tool;
CPosition Pos(Symbol(),Magic_Number,GROUP_POSITIONS_ALL);
CPosition BuyPos(Symbol(),Magic_Number,GROUP_POSITIONS_BUYS);
CPosition SellPos(Symbol(),Magic_Number,GROUP_POSITIONS_SELLS);
CExecute Trade(Symbol(),Magic_Number);
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   handle0=iBands(Symbol(),period,bands_period,bands_shift,deviation,applied_price); //---
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
   double M_Band[2],L_Band[2],U_Band[2];
   FillArraysFromBuffers(M_Band,U_Band,L_Band,0,handle0,2);
   bool touch_M = (M_Band[1]<=tool.Bid()&&M_Band[0]>=tool.Bid())||(M_Band[0]<=tool.Bid()&&M_Band[1]>=tool.Bid());
   bool touch_U = (U_Band[1]<=tool.Bid()&&U_Band[0]>=tool.Bid())||(U_Band[0]<=tool.Bid()&&U_Band[1]>=tool.Bid());
   bool touch_L = (L_Band[1]<=tool.Bid()&&L_Band[0]>=tool.Bid())||(L_Band[0]<=tool.Bid()&&L_Band[1]>=tool.Bid());

   int total=Pos.GroupTotal();
   double TotalLots=Pos.GroupTotalVolume();
   double totalProfit=Pos.GroupTotalProfit();
   bool Trade_Allowed=true;
   double Balance=AccountInfoDouble(ACCOUNT_BALANCE);
   if(Balance*(Max_Risk/100)<=MathAbs(totalProfit)&&totalProfit<0)
     {
      if(Risk_Options==CloseAll)
         Pos.GroupCloseAll(30);
      else
        {
         Trade_Allowed=false;
        }
     }
     if(Market_Open_close_filtter){
      datetime o=0,c=0;
      SymbolInfoSessionTrade(Symbol(),MONDAY,0,o,c);
      Print(TimeToString(o,TIME_MINUTES)+" "+TimeToString(c,TIME_DATE));
     }
   if(touch_M&&total==0&&TotalLots<Max_total_volume&&Trade_Allowed)
     {
      Trade.Position(TYPE_POSITION_BUY,volume,0,0,SLTP_PIPS,30,comment);
      Trade.Position(TYPE_POSITION_SELL,volume,0,0,SLTP_PIPS,30,comment);

     }
   int Buytotal=BuyPos.GroupTotal();
   double BuytotalProfit=BuyPos.GroupTotalProfit();
   if(touch_U&&Buytotal==1&&BuytotalProfit>0)
     {
      BuyPos.GroupCloseAll(30);
      Trade.Position(TYPE_POSITION_SELL,volume,0,0,SLTP_PIPS,30,comment);
     }
   int Selltotal=SellPos.GroupTotal();
   double SelltotalProfit=SellPos.GroupTotalProfit();
   if(touch_L&&Selltotal==1&&SelltotalProfit>0)
     {
      SellPos.GroupCloseAll(30);
      Trade.Position(TYPE_POSITION_BUY,volume,0,0,SLTP_PIPS,30,comment);
     }
   Selltotal=SellPos.GroupTotal();
   if(Selltotal>1)
     {
      double priceopen=SellPos[Selltotal-1].GetPriceOpen();
      if(priceopen+Standard_Deviation*tool.Pip()<=tool.Bid())
        {
         double NewLot=SellPos.GroupTotalVolume()+volume;
         Trade.Position(TYPE_POSITION_SELL,NewLot,0,0,SLTP_PIPS,30,comment);
        }
     }
   Buytotal=BuyPos.GroupTotal();
   if(Buytotal>1)
     {
      double priceopen=BuyPos[Buytotal-1].GetPriceOpen();
      if(priceopen-Standard_Deviation*tool.Pip()>=tool.Bid())
        {
         double NewLot=BuyPos.GroupTotalVolume()+volume;
         Trade.Position(TYPE_POSITION_BUY,NewLot,0,0,SLTP_PIPS,30,comment);
        }
     }
   Buytotal=BuyPos.GroupTotal();
   BuytotalProfit=BuyPos.GroupTotalProfit();
   if(touch_U&&Buytotal>1&&BuytotalProfit>0)
     {
      BuyPos.GroupCloseAll(30);
     }
   Selltotal=SellPos.GroupTotal();
   SelltotalProfit=SellPos.GroupTotalProfit();
   if(touch_L&&Selltotal>1&&SelltotalProfit>0)
     {
      SellPos.GroupCloseAll(30);
     }
   totalProfit=Pos.GroupTotalProfit();
   if(totalProfit<0&&MathAbs(totalProfit)>=USD_Loss_Max)
      Pos.GroupCloseAll(30);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Filling indicator buffers from the iBands indicator              |
//+------------------------------------------------------------------+
bool FillArraysFromBuffers(double &base_values[],     // indicator buffer of the middle line of Bollinger Bands
                           double &upper_values[],    // indicator buffer of the upper border
                           double &lower_values[],    // indicator buffer of the lower border
                           int shift,                 // shift
                           int ind_handle,            // handle of the iBands indicator
                           int amount                 // number of copied values
                          )
  {
//--- reset error code
   ResetLastError();
//--- fill a part of the MiddleBuffer array with values from the indicator buffer that has 0 index
   if(CopyBuffer(ind_handle,0,-shift,amount,base_values)<0)
     {
      //--- if the copying fails, tell the error code
      PrintFormat("Failed to copy data from the iBands indicator, error code %d",GetLastError());
      //--- quit with zero result - it means that the indicator is considered as not calculated
      return(false);
     }

//--- fill a part of the UpperBuffer array with values from the indicator buffer that has index 1
   if(CopyBuffer(ind_handle,1,-shift,amount,upper_values)<0)
     {
      //--- if the copying fails, tell the error code
      PrintFormat("Failed to copy data from the iBands indicator, error code %d",GetLastError());
      //--- quit with zero result - it means that the indicator is considered as not calculated
      return(false);
     }

//--- fill a part of the LowerBuffer array with values from the indicator buffer that has index 2
   if(CopyBuffer(ind_handle,2,-shift,amount,lower_values)<0)
     {
      //--- if the copying fails, tell the error code
      PrintFormat("Failed to copy data from the iBands indicator, error code %d",GetLastError());
      //--- quit with zero result - it means that the indicator is considered as not calculated
      return(false);
     }
//--- everything is fine
   return(true);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
