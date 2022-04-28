//+------------------------------------------------------------------+
//|                                            Structur Level EA.mq5 |
//|                                   Copyright 2022, Yousuf Mesalm. |
//|                                    https://www.Yousuf-mesalm.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Yousuf Mesalm."
#property link      "https://www.Yousuf-mesalm.com"
#property version   "1.00"
input ENUM_TIMEFRAMES Highert_TF=PERIOD_D1;
input ENUM_TIMEFRAMES Lowest_TF=PERIOD_M1;
input double Total_Risk=3;
input double Risk_Per_Trade=0.5;
input double Profit_Ratio=2;


// variables
int handle0,handle1;
//Arrays
ENUM_TIMEFRAMES TFS[10]= {PERIOD_M1,PERIOD_M5,PERIOD_M10,PERIOD_M15,PERIOD_M30,PERIOD_H1,PERIOD_H4,PERIOD_D1,PERIOD_W1,PERIOD_MN1};
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   handle0=iCustom(Symbol(),Highert_TF,"ZigzagColor.ex5");
   handle0=iCustom(Symbol(),Lowest_TF,"ZigzagColor.ex5");

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
   double Highest_Highs[],Highest_Lows[],Lowest_Lows[],Lowest_Highs[];
   CopyBuffer(handle0,0,0,500,Highest_Highs);
   CopyBuffer(handle0,1,0,500,Highest_Lows);
   CopyBuffer(handle1,0,0,500,Lowest_Highs);
   CopyBuffer(handle1,1,0,500,Lowest_Lows);
   double Last_HH1=-1,Last_HL1=-1;
   int Last_HH1_idx,Last_HL1_idx;
   double Last_HH2=-1,Last_HL2=-1;
   int Last_HH_idx2,Last_HL_idx2;
   for(int i=0; i<ArraySize(Highest_Highs); i++)
     {
      if(Highest_Highs[i]>0&&Last_HH1<0)
        {
         Last_HH1=Highest_Highs[i];
         Last_HH1_idx=i;
        }
      if(Highest_Highs[i]>0&&Last_HH1>0&&Last_HH2<0)
        {
         Last_HH2=Highest_Highs[i];
         Last_HH2_idx=i;
        }
      if(Highest_Lows[i]>0&&Last_HL<0)
        {
         Last_HL1=Highest_Lows[i];
         Last_HL1_idx=i;
        }
      if(Highest_Lows[i]>0&&Last_HL1>&&Last_HL2<0)
        {
         Last_HL2=Highest_Lows[i];
         Last_HL2_idx=i;
        }
      if(Last_HH1>0&&Last_HL1>0&&Last_HH2>0&&Last_HL2>0)
        {
         break;
        }
     }
   if(Last_HH_idx<Last_HL_idx)
     {
     
     }

  }
//+------------------------------------------------------------------+
