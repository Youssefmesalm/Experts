//+------------------------------------------------------------------+
//|                                                   Kintu Dave 2.mq5 |
//|                                   Copyright 2022, Yousuf Mesalm. |
//|                                    https://www.Yousuf-mesalm.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Yousuf Mesalm."
#property link      "https://www.Yousuf-mesalm.com"
#property link      "https://www.mql5.com/en/users/20163440"
#property description      "Developed by Yousuf Mesalm"
#property description      "https://www.Yousuf-mesalm.com"
#property description      "https://www.mql5.com/en/users/20163440"
#property version   "1.00"
//enum
enum RiskOptions
  {
   CloseAll,
   No_Entry,
  };
enum add_Mode
  {
   Pips_Distance,
   StdDev,
  };
// includes
#include  <YM\Execute\Execute.mqh>
#include  <YM\Position\Position.mqh>

//--- input parameters
input string               set0="====================Bolinger Band Settings=================";
input int                  bands_period=20;           // period of moving average
input int                  bands_shift=0;             // shift
input double               deviation=2.0;             // number of standard deviations
input ENUM_APPLIED_PRICE   applied_price=PRICE_CLOSE; // type of price
input ENUM_TIMEFRAMES      period=PERIOD_CURRENT;     // timeframe
input string               set1="====================STD  Settings=================";
input int                  std_Ma_period=20;           // period of moving average
input int                  std_shift=0;             // shift
input ENUM_MA_METHOD       Std_Method=MODE_EMA;   // Metod
input double               std_deviation=2.0;             // number of standard deviations
input ENUM_APPLIED_PRICE   std_applied_price=PRICE_CLOSE; // type of price
input ENUM_TIMEFRAMES      std_period=PERIOD_CURRENT;     // timeframe
input string               set2="====================RSI  Settings=================";
input int                  RSI_Ma_period=20;           // period of moving average
input ENUM_TIMEFRAMES      RSI_period=PERIOD_CURRENT;     // timeframe
input ENUM_APPLIED_PRICE   RSI_applied_price=PRICE_CLOSE; // type of price
input string               set3="====================Close  Settings=================";
input bool                 CloseWithRrverse   =true;
input string               set430="====================MA1 Settings=================";
input int                  MA1_period2=20;           // period of moving average
input int                  MA1_shift=0;             // shift
input ENUM_MA_METHOD       MA1_Method=MODE_EMA;   // Metod
input ENUM_APPLIED_PRICE   MA1_applied_price=PRICE_CLOSE; // type of price
input ENUM_TIMEFRAMES      MA1_period=PERIOD_CURRENT;     // timeframe
input string               set31="====================MA2 Settings=================";
input int                  MA2_period2=20;           // period of moving average
input int                  MA2_shift=0;             // shift
input ENUM_MA_METHOD       MA2_Method=MODE_EMA;   // Metod
input ENUM_APPLIED_PRICE   MA2_applied_price=PRICE_CLOSE; // type of price
input ENUM_TIMEFRAMES      MA2_period=PERIOD_CURRENT;     // timeframe
input string               set32="====================closing Filtters=================";
input RiskOptions          Risk_Options=CloseAll;
input double               USD_Loss_Max   = 5000   ; // DOLLAR VALUE STOP LOSS
input double               Max_Risk=20;               // Max Risk in %
input string               set4="====================Trading Settings=================";
input double               volume=0.1;
input double               Added_Lot            =0.1;
input add_Mode             Addition_Entry_Mode   =StdDev;
input double               Standard_Deviation =3;
input long                 Magic_Number=2020;
input string               comment="";
input double               Max_total_volume  =2    ; // MaX Total Volume
input bool                 Market_Open_close_filtter    =true; // Market Open - Close Filter
input int                  H_open=  3;  // After Market open x Hours
input int                  H_close =3;  // before Market Close x Hours
int handle0=0;
int handle1=0;
int handle2=0;
int handle3=0;
int handle4=0;
double devValue=0;
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
   if(Addition_Entry_Mode==StdDev)
      handle1=iStdDev(Symbol(),std_period,std_Ma_period,std_shift,Std_Method,std_applied_price);
   handle2=iRSI(Symbol(),RSI_period,RSI_Ma_period,RSI_applied_price);
   if(CloseWithRrverse)
     {
      handle3=iMA(Symbol(),MA1_period,MA1_period2,MA1_shift,MA1_Method,MA1_applied_price);
      handle4=iMA(Symbol(),MA2_period,MA2_period2,MA2_shift,MA2_Method,MA2_applied_price);
     }
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

   double M_Band[2],L_Band[2],U_Band[2],Std[1],Rsi[1],MA1[1],MA2[1];
   FillArraysFromBuffers(M_Band,U_Band,L_Band,0,handle0,2);
   if(Addition_Entry_Mode==StdDev)
      CopyBuffer(handle1,0,0,1,Std);
   CopyBuffer(handle2,0,0,1,Rsi);
   if(CloseWithRrverse){
   CopyBuffer(handle3,0,0,1,MA1);
   CopyBuffer(handle4,0,0,1,MA2);
   }
   bool touch_M = (M_Band[1]<=tool.Bid()&&M_Band[0]>=tool.Bid())||(M_Band[0]<=tool.Bid()&&M_Band[1]>=tool.Bid());
   bool touch_U = (U_Band[1]<=tool.Bid()&&U_Band[0]>=tool.Bid())||(U_Band[0]<=tool.Bid()&&U_Band[1]>=tool.Bid());
   bool touch_L = (L_Band[1]<=tool.Bid()&&L_Band[0]>=tool.Bid())||(L_Band[0]<=tool.Bid()&&L_Band[1]>=tool.Bid());
//  Trend Detection
   double WeekOpen=iOpen(Symbol(),PERIOD_W1,0);
   int trend=tool.Bid()>WeekOpen?1:-1;
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
   if(Market_Open_close_filtter)
     {
      MqlDateTime open, close,current;
      datetime openDT, closeDT,currentDT;
      currentDT=TimeCurrent();
      bool sessionTrade = SymbolInfoSessionQuote(Symbol(), MONDAY, 0, openDT, closeDT);
      TimeToStruct(openDT, open);
      TimeToStruct(closeDT, close);
      TimeToStruct(currentDT,current);
      if(current.day_of_week==1&&current.hour<=open.hour+H_open)
        {
         Trade_Allowed=false;
        }
      else
         if(current.day_of_week==5&&current.hour>=close.hour-H_close)
           {
            Trade_Allowed=false;
           }


     }
   if(touch_U&&total==0&&TotalLots<Max_total_volume&&Trade_Allowed&&trend<0&&Rsi[0]>70)
     {
      Trade.Position(TYPE_POSITION_SELL,volume,0,0,SLTP_PIPS,30,comment);
      if(Addition_Entry_Mode==StdDev)
         devValue=Std[0]*Standard_Deviation;
     }
   if(touch_L&&total==0&&TotalLots<Max_total_volume&&Trade_Allowed&&trend>0&&Rsi[0]<20)
     {
      Trade.Position(TYPE_POSITION_BUY,volume,0,0,SLTP_PIPS,30,comment);
      if(Addition_Entry_Mode==StdDev)
         devValue=Std[0]*Standard_Deviation;
     }
   int Buytotal=BuyPos.GroupTotal();
   double BuytotalProfit=BuyPos.GroupTotalProfit();
   if(touch_U&&Buytotal==1&&BuytotalProfit>0)
     {
      BuyPos.GroupCloseAll(30);
     }
   int Selltotal=SellPos.GroupTotal();
   double SelltotalProfit=SellPos.GroupTotalProfit();
   if(touch_L&&Selltotal==1&&SelltotalProfit>0)
     {
      SellPos.GroupCloseAll(30);
     }
   Selltotal=SellPos.GroupTotal();
   if(Selltotal>=1&&SelltotalProfit<0&&Trade_Allowed&&trend<0&&Rsi[0]>70)
     {
      double priceopen=SellPos[Selltotal-1].GetPriceOpen();
      if(Addition_Entry_Mode==Pips_Distance)
        {
         if(priceopen+Standard_Deviation*tool.Pip()<=tool.Bid())
           {
            double NewLot=SellPos[Selltotal-1].GetVolume()+Added_Lot;
            Trade.Position(TYPE_POSITION_SELL,NewLot,0,0,SLTP_PIPS,30,comment);
           }
        }
      else
        {
         if(devValue<=Std[0])
           {
            double NewLot=SellPos[Selltotal-1].GetVolume()+Added_Lot;
            Trade.Position(TYPE_POSITION_SELL,NewLot,0,0,SLTP_PIPS,30,comment);
            devValue=Std[0]*Standard_Deviation;
           }
        }
     }
   Buytotal=BuyPos.GroupTotal();
   if(Buytotal>=1&&BuytotalProfit<0&&Trade_Allowed&&trend>0&&Rsi[0]<20)
     {
      double priceopen=BuyPos[Buytotal-1].GetPriceOpen();
      if(Addition_Entry_Mode==Pips_Distance)
        {
         if(priceopen-Standard_Deviation*tool.Pip()>=tool.Bid())
           {
            double NewLot=BuyPos[Buytotal-1].GetVolume()+Added_Lot;
            Trade.Position(TYPE_POSITION_BUY,NewLot,0,0,SLTP_PIPS,30,comment);
           }
        }
      else
        {
         if(Std[0]>=devValue)
           {
            double NewLot=BuyPos[Buytotal-1].GetVolume()+Added_Lot;
            Trade.Position(TYPE_POSITION_BUY,NewLot,0,0,SLTP_PIPS,30,comment);
            devValue=Std[0]*Standard_Deviation;

           }

        }
     }
     if(CloseWithRrverse){
     if
     }
   Buytotal=BuyPos.GroupTotal();
   Selltotal=SellPos.GroupTotal();
   BuytotalProfit=BuyPos.GroupTotalProfit();
   if(touch_U&&Buytotal>1&&BuytotalProfit>0&&Selltotal==0)
     {
      BuyPos.GroupCloseAll(30);
     }
   SelltotalProfit=SellPos.GroupTotalProfit();
   if(touch_L&&Selltotal>1&&SelltotalProfit>0&&Buytotal==0)
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
