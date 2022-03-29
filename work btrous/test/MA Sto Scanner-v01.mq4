//+------------------------------------------------------------------+
//|                                               MA Sto Scanner.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

// General EA inputs for user 
input string              Symbols_Names          = "EURUSDm,GBPUSDm,USDCHFm,USDJPYm";
extern string             MA1_SetUP              = "------< MA1_SetUP >------";
input ENUM_TIMEFRAMES     Time1                  = PERIOD_M5;
input int                 period1                = 8;
input ENUM_MA_METHOD      MA_Method1             = MODE_EMA;
input ENUM_APPLIED_PRICE  MA_price1              = PRICE_CLOSE;
extern string             MA2_SetUP              = "------< MA2_SetUP >------";
input ENUM_TIMEFRAMES     Time2                  = PERIOD_M5;
input int                 period2                = 21;
input ENUM_MA_METHOD      MA_Method2             = MODE_EMA;
input ENUM_APPLIED_PRICE  MA_price2              = PRICE_CLOSE;
extern string             Stochastic1_SetUP      = "------< Stochastic1_SetUP >------";
input int                 K_Period1              = 33;
input int                 D_Period1              = 1;
input int                 Slowing1               = 11;
input ENUM_TIMEFRAMES     STO_Time1              = PERIOD_M5;
input ENUM_MA_METHOD      Stochastic_Method1     = MODE_SMA;
input ENUM_STO_PRICE      Stochastic_price1      = STO_CLOSECLOSE;
input double              STO_Up                 = 61.8;
input double              STO_Dn                 = 38.2;
input bool                Sound_alert            = true;
input bool                Mobile_alert           = true;
input bool                Email_alert            = true;
input color               Buy_color              = clrGreen;
input color               Sell_color             = clrRed;

// Global variables for EA use 
color Color1,Color2,Color3,Color4,Color5,Color6,Color7,Color8,Color9,Color10;
int num1, num2,num3,num4,num5,num6,num7,num8,num9,num10;
int z;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

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


//DashBoard
   string sep=",";
   ushort u_sep;
   string result[];
   u_sep=StringGetCharacter(sep,0);
   int k=StringSplit(Symbols_Names,u_sep,result);


   Button("Head11",OBJ_BUTTON,0,60,50,60,30,"",10,clrBlack,clrWhite);
   Button("Head12",OBJ_BUTTON,0,120,50,120,30,"M15",10,clrBlack,clrWhite);
   Button("Head13",OBJ_BUTTON,0,240,50,120,30,"H1",10,clrBlack,clrWhite);
   Button("Head14",OBJ_BUTTON,0,360,50,120,30,"H4",10,clrBlack,clrWhite);
   Button("Head15",OBJ_BUTTON,0,480,50,120,30,"D1",10,clrBlack,clrWhite);
   Button("Head16",OBJ_BUTTON,0,600,50,120,30,"W",10,clrBlack,clrWhite);

   Button("Head21",OBJ_BUTTON,0,60,80,60,30,"",8,clrBlack,clrWhite);
   Button("Head22",OBJ_BUTTON,0,120,80,60,30,"MA Cross",7,clrBlack,clrWhite);
   Button("Head23",OBJ_BUTTON,0,180,80,60,30,"Stoch",7,clrBlack,clrWhite);
   Button("Head24",OBJ_BUTTON,0,240,80,60,30,"MA Cross",7,clrBlack,clrWhite);
   Button("Head25",OBJ_BUTTON,0,300,80,60,30,"Stoch",7,clrBlack,clrWhite);
   Button("Head26",OBJ_BUTTON,0,360,80,60,30,"MA Cross",7,clrBlack,clrWhite);
   Button("Head27",OBJ_BUTTON,0,420,80,60,30,"Stoch",7,clrBlack,clrWhite);
   Button("Head28",OBJ_BUTTON,0,480,80,60,30,"MA Cross",7,clrBlack,clrWhite);
   Button("Head29",OBJ_BUTTON,0,540,80,60,30,"Stoch",7,clrBlack,clrWhite);
   Button("Head210",OBJ_BUTTON,0,600,80,60,30,"MA Cross",7,clrBlack,clrWhite);
   Button("Head211",OBJ_BUTTON,0,660,80,60,30,"Stoch",7,clrBlack,clrWhite);

   if(k>0)
     {
      for(int i=0; i<k; i++)
        {
         double MA1_M15   =iMA(result[i],PERIOD_M15,period1,0,MA_Method1,MA_price1,1);
         double MA1_2_M15 =iMA(result[i],PERIOD_M15,period1,0,MA_Method1,MA_price1,2);
         double ma2_M15   =iMA(result[i],PERIOD_M15,period2,0,MA_Method2,MA_price2,1);
         double ma2_2_M15 =iMA(result[i],PERIOD_M15,period2,0,MA_Method2,MA_price2,2);
         double MA1_H1    =iMA(result[i],PERIOD_H1,period1,0,MA_Method1,MA_price1,1);
         double MA1_2_H1  =iMA(result[i],PERIOD_H1,period1,0,MA_Method1,MA_price1,2);
         double ma2_H1    =iMA(result[i],PERIOD_H1,period2,0,MA_Method2,MA_price2,1);
         double ma2_2_H1  =iMA(result[i],PERIOD_H1,period2,0,MA_Method2,MA_price2,2);
         double MA1_H4    =iMA(result[i],PERIOD_H4,period1,0,MA_Method1,MA_price1,1);
         double MA1_2_H4  =iMA(result[i],PERIOD_H4,period1,0,MA_Method1,MA_price1,2);
         double ma2_H4    =iMA(result[i],PERIOD_H4,period2,0,MA_Method2,MA_price2,1);
         double ma2_2_H4  =iMA(result[i],PERIOD_H4,period2,0,MA_Method2,MA_price2,2);
         double MA1_D1    =iMA(result[i],PERIOD_D1,period1,0,MA_Method1,MA_price1,1);
         double MA1_2_D1  =iMA(result[i],PERIOD_D1,period1,0,MA_Method1,MA_price1,2);
         double ma2_D1    =iMA(result[i],PERIOD_D1,period2,0,MA_Method2,MA_price2,1);
         double ma2_2_D1  =iMA(result[i],PERIOD_D1,period2,0,MA_Method2,MA_price2,2);
         double MA1_W1    =iMA(result[i],PERIOD_W1,period1,0,MA_Method1,MA_price1,1);
         double MA1_2_W1  =iMA(result[i],PERIOD_W1,period1,0,MA_Method1,MA_price1,2);
         double ma2_W1    =iMA(result[i],PERIOD_W1,period2,0,MA_Method2,MA_price2,1);
         double ma2_2_W1  =iMA(result[i],PERIOD_W1,period2,0,MA_Method2,MA_price2,2);
         double sto_M15   =  iStochastic(result[i],PERIOD_M15,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,0,1);
         double sto_H1    =  iStochastic(result[i],PERIOD_H1,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,0,1);
         double sto_H4    =  iStochastic(result[i],PERIOD_H4,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,0,1);
         double sto_D1    =  iStochastic(result[i],PERIOD_D1,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,0,1);
         double sto_W1    =  iStochastic(result[i],PERIOD_W1,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,0,1);

         Button("Data1"+IntegerToString(z),OBJ_BUTTON,0,60,110+z,60,30,result[i],6,clrBlack,clrWhite);

         if(MA_BUY_M15(result[i])>0 && MA_BUY_M15(result[i])< MA_SELL_M15(result[i]))
           {
            Color1=Buy_color;
            num1=MA_BUY_M15(result[i]);
           }
         if(MA_SELL_M15(result[i])>0 && MA_BUY_M15(result[i])> MA_SELL_M15(result[i]))
           {
            Color1=Sell_color;
            num1=MA_SELL_M15(result[i]);
           }
         Button("Data2"+IntegerToString(z),OBJ_BUTTON,0,120,110+z,60,30,IntegerToString(num1),7,clrBlack,Color1);

         if(STO_BUY_M15(result[i])>0 && STO_SELL_M15(result[i])> STO_BUY_M15(result[i]))
           {
            Color2=Buy_color;
            num2=STO_BUY_M15(result[i]);
           }
         if(STO_SELL_M15(result[i])>0 && STO_SELL_M15(result[i])< STO_BUY_M15(result[i]))
           {
            Color2=Sell_color;
            num2=STO_SELL_M15(result[i]);
           }
         if(sto_M15 < STO_Up && sto_M15 > STO_Dn)
           {
            Color2=clrGray;
            num2=NULL;
           }

         Button("Data3"+IntegerToString(z),OBJ_BUTTON,0,180,110+z,60,30,IntegerToString(num2),7,clrBlack,Color2);

         if(MA_BUY_H1(result[i])>0 && MA_BUY_H1(result[i])< MA_SELL_H1(result[i]))
           {
            Color3=Buy_color;
            num3=MA_BUY_H1(result[i]);
           }
         if(MA_SELL_H1(result[i])>0 && MA_BUY_H1(result[i])> MA_SELL_H1(result[i]))
           {
            Color3=Sell_color;
            num3=MA_SELL_H1(result[i]);
           }

         Button("Data4"+IntegerToString(z),OBJ_BUTTON,0,240,110+z,60,30,IntegerToString(num3),7,clrBlack,Color3);

         if(STO_BUY_H1(result[i])>0 && STO_SELL_H1(result[i])> STO_BUY_H1(result[i]))
           {
            Color4=Buy_color;
            num4=STO_BUY_H1(result[i]);
           }
         if(STO_SELL_H1(result[i])>0 && STO_SELL_H1(result[i])< STO_BUY_H1(result[i]))
           {
            Color4=Sell_color;
            num4=STO_SELL_H1(result[i]);
           }
         if(sto_H1 < STO_Up && sto_H1 > STO_Dn)
           {
            Color4=clrGray;
            num4=NULL;
           }

         Button("Data5"+IntegerToString(z),OBJ_BUTTON,0,300,110+z,60,30,IntegerToString(num4),7,clrBlack,Color4);






         if(MA_BUY_H4(result[i])>0 && MA_BUY_H4(result[i])< MA_SELL_H4(result[i]))
           {
            Color5=Buy_color;
            num5=MA_BUY_H4(result[i]);
           }
         if(MA_SELL_H4(result[i])>0 && MA_BUY_H4(result[i])> MA_SELL_H4(result[i]))
           {
            Color5=Sell_color;
            num5=MA_SELL_H4(result[i]);
           }
         Button("Data6"+IntegerToString(z),OBJ_BUTTON,0,360,110+z,60,30,IntegerToString(num5),7,clrBlack,Color5);

         if(STO_BUY_H4(result[i])>0 && STO_SELL_H4(result[i])> STO_BUY_H4(result[i]))
           {
            Color6=Buy_color;
            num6=STO_BUY_H4(result[i]);
           }
         if(STO_SELL_H4(result[i])>0 && STO_SELL_H4(result[i])< STO_BUY_H4(result[i]))
           {
            Color6=Sell_color;
            num6=STO_SELL_H4(result[i]);
           }
         if(sto_H4 < STO_Up && sto_H4 > STO_Dn)
           {
            Color6=clrGray;
            num6=NULL;
           }

         Button("Data7"+IntegerToString(z),OBJ_BUTTON,0,420,110+z,60,30,IntegerToString(num6),7,clrBlack,Color6);



         if(MA_BUY_D1(result[i])>0 && MA_BUY_D1(result[i])< MA_SELL_D1(result[i]))
           {
            Color7=Buy_color;
            num7=MA_BUY_D1(result[i]);
           }
         if(MA_SELL_D1(result[i])>0 && MA_BUY_D1(result[i])> MA_SELL_D1(result[i]))
           {
            Color7=Sell_color;
            num7=MA_SELL_D1(result[i]);
           }

         Button("Data8"+IntegerToString(z),OBJ_BUTTON,0,480,110+z,60,30,IntegerToString(num7),7,clrBlack,Color7);

         if(STO_BUY_D1(result[i])>0 && STO_SELL_D1(result[i])> STO_BUY_D1(result[i]))
           {
            Color8=Buy_color;
            num8=STO_BUY_H4(result[i]);
           }
         if(STO_SELL_D1(result[i])>0 && STO_SELL_D1(result[i])< STO_BUY_D1(result[i]))
           {
            Color8=Sell_color;
            num8=STO_SELL_D1(result[i]);
           }
         if(sto_D1 < STO_Up && sto_D1 > STO_Dn)
           {
            Color8=clrGray;
            num8=NULL;
           }

         Button("Data9"+IntegerToString(z),OBJ_BUTTON,0,540,110+z,60,30,IntegerToString(num8),7,clrBlack,Color8);



         if(MA_BUY_W1(result[i])>0 && MA_BUY_W1(result[i])< MA_SELL_W1(result[i]))
           {
            Color9=Buy_color;
            num9=MA_BUY_W1(result[i]);
           }
         if(MA_SELL_W1(result[i])>0 && MA_BUY_W1(result[i])> MA_SELL_W1(result[i]))
           {
            Color9=Sell_color;
            num9=MA_SELL_D1(result[i]);
           }

         Button("Data10"+IntegerToString(z),OBJ_BUTTON,0,600,110+z,60,30,IntegerToString(num9),7,clrBlack,Color9);

         if(STO_BUY_W1(result[i])>0 && STO_SELL_W1(result[i])> STO_BUY_W1(result[i]))
           {
            Color10=Buy_color;
            num10=STO_BUY_W1(result[i]);
           }
         if(STO_SELL_W1(result[i])>0 && STO_SELL_W1(result[i])< STO_BUY_W1(result[i]))
           {
            Color10=Sell_color;
            num10=STO_SELL_W1(result[i]);
           }
         if(sto_W1 < STO_Up && sto_W1 > STO_Dn)
           {
            Color10=clrGray;
            num10=NULL;
           }

         Button("Data11"+IntegerToString(z),OBJ_BUTTON,0,660,110+z,60,30,IntegerToString(num10),7,clrBlack,Color10);
//Alert MA Cross Alert
         if(MA1_M15>ma2_M15 && MA1_2_M15<ma2_2_M15)
           {
            Alert("MA Cross Alert :" + "Symbol =" +result[i]+ "TimeFrame ="+ "M15" + "Trend = "+ "UP");
           }
         if(MA1_H1>ma2_H1 && MA1_2_H1<ma2_2_H1)
           {
            Alert("MA Cross Alert :" + "Symbol =" +result[i]+ "TimeFrame ="+ "H1" + "Trend = "+ "UP");
           }
         if(MA1_H4>ma2_H4 && MA1_2_H4<ma2_2_H4)
           {
            Alert("MA Cross Alert :" + "Symbol =" +result[i]+ "TimeFrame ="+ "H4" + "Trend = "+ "UP");
           }
         if(MA1_D1>ma2_D1 && MA1_2_D1<ma2_2_D1)
           {
            Alert("MA Cross Alert :" + "Symbol =" +result[i]+ "TimeFrame ="+ "D1" + "Trend = "+ "UP");
           }
         if(MA1_W1>ma2_W1 && MA1_2_W1<ma2_2_W1)
           {
            Alert("MA Cross Alert :" + "Symbol =" +result[i]+ "TimeFrame ="+ "W1" + "Trend = "+ "UP");
           }

         if(MA1_M15<ma2_M15 && MA1_2_M15>ma2_2_M15)
           {
            Alert("MA Cross Alert :" + "Symbol =" +result[i]+ "TimeFrame ="+ "M15" + "Trend = "+ "Dn");
           }
         if(MA1_H1<ma2_H1 && MA1_2_H1>ma2_2_H1)
           {
            Alert("MA Cross Alert :" + "Symbol =" +result[i]+ "TimeFrame ="+ "H1" + "Trend = "+ "Dn");
           }
         if(MA1_H4<ma2_H4 && MA1_2_H4>ma2_2_H4)
           {
            Alert("MA Cross Alert :" + "Symbol =" +result[i]+ "TimeFrame ="+ "H4" + "Trend = "+ "Dn");
           }
         if(MA1_D1<ma2_D1 && MA1_2_D1>ma2_2_D1)
           {
            Alert("MA Cross Alert :" + "Symbol =" +result[i]+ "TimeFrame ="+ "D1" + "Trend = "+ "Dn");
           }
         if(MA1_W1<ma2_W1 && MA1_2_W1>ma2_2_W1)
           {
            Alert("MA Cross Alert :" + "Symbol =" +result[i]+ "TimeFrame ="+ "W1" + "Trend = "+ "Dn");
           }
//Alert OS condition Alert
         if(sto_M15 < STO_Dn)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "M15" + "Trend = "+ "Over Sold");
           }
         if(sto_H1 < STO_Dn)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "H1" + "Trend = "+ "Over Sold");
           }
         if(sto_H4 < STO_Dn)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "H4" + "Trend = "+ "Over Sold");
           }
         if(sto_D1 < STO_Dn)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "D1" + "Trend = "+ "Over Sold");
           }
         if(sto_W1 < STO_Dn)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "W1" + "Trend = "+ "Over Sold");
           }
         if(sto_M15 > STO_Up)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "M15" + "Trend = "+ "overbought");
           }
         if(sto_H1 > STO_Up)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "H1" + "Trend = "+ "overbought");
           }
         if(sto_H4 > STO_Up)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "H4" + "Trend = "+ "overbought");
           }
         if(sto_D1 > STO_Up)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "D1" + "Trend = "+ "overbought");
           }
         if(sto_W1 > STO_Up)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "W1" + "Trend = "+ "overbought");
           }
           //Trend is UP and OS condition is met
         if(sto_M15 < STO_Dn && MA1_M15>ma2_M15 && MA1_2_M15<ma2_2_M15)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "M15" + "Trend = "+ "is UP and OS condition is met");
           }
         if(sto_H1 < STO_Dn && MA1_H1>ma2_H1 && MA1_2_H1<ma2_2_H1)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "H1" + "Trend = "+ "is UP and OS condition is met");
           }
         if(sto_H4 < STO_Dn && MA1_H4>ma2_H4 && MA1_2_H4<ma2_2_H4)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "H4" + "Trend = "+ "is UP and OS condition is met");
           }
         if(sto_D1 < STO_Dn && MA1_D1>ma2_D1 && MA1_2_D1<ma2_2_D1)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "D1" + "Trend = "+ "is UP and OS condition is met");
           }
         if(sto_W1 < STO_Dn && MA1_W1>ma2_W1 && MA1_2_W1<ma2_2_W1)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "W1" + "Trend = "+ "is UP and OS condition is met");
           }
           
           //Trend is Down and OS condition is met
         if(sto_M15 > STO_Up && MA1_M15<ma2_M15 && MA1_2_M15>ma2_2_M15)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "M15" + "Trend = "+ "is DOWN and OB condition is met");
           }
         if(sto_H1 > STO_Up && MA1_H1<ma2_H1 && MA1_2_H1>ma2_2_H1)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "H1" + "Trend = "+ "is DOWN and OB condition is met");
           }
         if(sto_H4 > STO_Up && MA1_H4<ma2_H4 && MA1_2_H4>ma2_2_H4)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "H4" + "Trend = "+ "is DOWN and OB condition is met");
           }
         if(sto_D1 > STO_Up && MA1_D1<ma2_D1 && MA1_2_D1>ma2_2_D1)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "D1" + "Trend = "+ "is DOWN and OB condition is met");
           }
         if(sto_W1 > STO_Up && MA1_W1<ma2_W1 && MA1_2_W1>ma2_2_W1)
           {
            Alert("OS condition :" + "Symbol =" +result[i]+ "TimeFrame ="+ "W1" + "Trend = "+ "is DOWN and OB condition is met");
           }
         z+=30;
        }
      z=0;
     }














  }
//+------------------------------------------------------------------+
//| Dashboard function                                   |
//+------------------------------------------------------------------+
void Button(string name,ENUM_OBJECT type, int CORNER, int XDISTANCE, int YDISTANCE, int XSIZE, int YSIZE,
            string Text, int Fontsize, color FontColor, color Background)
  {
   ObjectCreate(0,name,type,0,0,0);
   ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,XDISTANCE);
   ObjectSetInteger(0,name,OBJPROP_XSIZE,XSIZE);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,YDISTANCE);
   ObjectSetInteger(0,name,OBJPROP_YSIZE,YSIZE);
   ObjectSetString(0,name,OBJPROP_TEXT,Text);
   ObjectSetInteger(0,name,OBJPROP_FONTSIZE,Fontsize);
   ObjectSetInteger(0,name,OBJPROP_COLOR,FontColor);
   ObjectSetInteger(0,name,OBJPROP_BGCOLOR,Background);
  }
//+------------------------------------------------------------------+
//| MA_BUY_M15 function                                   |
//+------------------------------------------------------------------+
int  MA_BUY_M15(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double MA1_M15   =iMA(symbol,PERIOD_M15,period1,0,MA_Method1,MA_price1,i);
      double MA1_2_M15 =iMA(symbol,PERIOD_M15,period1,0,MA_Method1,MA_price1,i+1);
      double ma2_M15   =iMA(symbol,PERIOD_M15,period2,0,MA_Method2,MA_price2,i);
      double ma2_2_M15 =iMA(symbol,PERIOD_M15,period2,0,MA_Method2,MA_price2,i+1);
      if(MA1_M15>ma2_M15 && MA1_2_M15<ma2_2_M15)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| MA_Sell_M15 function                                   |
//+------------------------------------------------------------------+
int  MA_SELL_M15(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double MA1_M15   =iMA(symbol,PERIOD_M15,period1,0,MA_Method1,MA_price1,i);
      double MA1_2_M15 =iMA(symbol,PERIOD_M15,period1,0,MA_Method1,MA_price1,i+1);
      double ma2_M15   =iMA(symbol,PERIOD_M15,period2,0,MA_Method2,MA_price2,i);
      double ma2_2_M15 =iMA(symbol,PERIOD_M15,period2,0,MA_Method2,MA_price2,i+1);
      if(MA1_M15<ma2_M15 && MA1_2_M15>ma2_2_M15)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| STO_BUY_M15 function                                   |
//+------------------------------------------------------------------+
int  STO_BUY_M15(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double sto_M15   =  iStochastic(symbol,PERIOD_M15,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,0,i);

      if(sto_M15 < STO_Dn)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| STO_SELL_M15 function                                   |
//+------------------------------------------------------------------+
int  STO_SELL_M15(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double sto_M15   =  iStochastic(symbol,PERIOD_M15,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,0,i);

      if(sto_M15 > STO_Up)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| MA_BUY_H1 function                                   |
//+------------------------------------------------------------------+
int  MA_BUY_H1(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double MA1_H1    =iMA(symbol,PERIOD_H1,period1,0,MA_Method1,MA_price1,i);
      double MA1_2_H1  =iMA(symbol,PERIOD_H1,period1,0,MA_Method1,MA_price1,i+1);
      double ma2_H1    =iMA(symbol,PERIOD_H1,period2,0,MA_Method2,MA_price2,i);
      double ma2_2_H1  =iMA(symbol,PERIOD_H1,period2,0,MA_Method2,MA_price2,i+1);
      if(MA1_H1>ma2_H1 && MA1_2_H1<ma2_2_H1)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| MA_SELL_H1 function                                   |
//+------------------------------------------------------------------+
int  MA_SELL_H1(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double MA1_H1    =iMA(symbol,PERIOD_H1,period1,0,MA_Method1,MA_price1,i);
      double MA1_2_H1  =iMA(symbol,PERIOD_H1,period1,0,MA_Method1,MA_price1,i+1);
      double ma2_H1    =iMA(symbol,PERIOD_H1,period2,0,MA_Method2,MA_price2,i);
      double ma2_2_H1  =iMA(symbol,PERIOD_H1,period2,0,MA_Method2,MA_price2,i+1);

      if(MA1_H1<ma2_H1 && MA1_2_H1>ma2_2_H1)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| STO_BUY_H1 function                                   |
//+------------------------------------------------------------------+
int  STO_BUY_H1(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double sto_H1    =  iStochastic(symbol,PERIOD_H1,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,0,i);
      if(sto_H1 < STO_Dn)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| STO_SELL_H1 function                                   |
//+------------------------------------------------------------------+
int  STO_SELL_H1(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double sto_H1    =  iStochastic(symbol,PERIOD_H1,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,0,i);
      if(sto_H1 > STO_Up)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| MA_BUY_H4 function                                   |
//+------------------------------------------------------------------+
int  MA_BUY_H4(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double MA1_H4    =iMA(symbol,PERIOD_H4,period1,0,MA_Method1,MA_price1,i);
      double MA1_2_H4  =iMA(symbol,PERIOD_H4,period1,0,MA_Method1,MA_price1,i+1);
      double ma2_H4    =iMA(symbol,PERIOD_H4,period2,0,MA_Method2,MA_price2,i);
      double ma2_2_H4  =iMA(symbol,PERIOD_H4,period2,0,MA_Method2,MA_price2,i+1);

      if(MA1_H4>ma2_H4 && MA1_2_H4<ma2_2_H4)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| MA_SELL_H4 function                                   |
//+------------------------------------------------------------------+
int  MA_SELL_H4(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double MA1_H4    =iMA(symbol,PERIOD_H4,period1,0,MA_Method1,MA_price1,i);
      double MA1_2_H4  =iMA(symbol,PERIOD_H4,period1,0,MA_Method1,MA_price1,i+1);
      double ma2_H4    =iMA(symbol,PERIOD_H4,period2,0,MA_Method2,MA_price2,i);
      double ma2_2_H4  =iMA(symbol,PERIOD_H4,period2,0,MA_Method2,MA_price2,i+1);

      if(MA1_H4<ma2_H4 && MA1_2_H4>ma2_2_H4)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| STO_BUY_H4 function                                   |
//+------------------------------------------------------------------+
int  STO_BUY_H4(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double sto_H4    =  iStochastic(symbol,PERIOD_H4,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,0,i);
      if(sto_H4 < STO_Dn)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| STO_SELL_H4 function                                   |
//+------------------------------------------------------------------+
int  STO_SELL_H4(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double sto_H4    =  iStochastic(symbol,PERIOD_H4,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,0,i);
      if(sto_H4 > STO_Up)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| MA_BUY_D1 function                                   |
//+------------------------------------------------------------------+
int  MA_BUY_D1(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double MA1_D1    =iMA(symbol,PERIOD_D1,period1,0,MA_Method1,MA_price1,i);
      double MA1_2_D1  =iMA(symbol,PERIOD_D1,period1,0,MA_Method1,MA_price1,i+1);
      double ma2_D1    =iMA(symbol,PERIOD_D1,period2,0,MA_Method2,MA_price2,i);
      double ma2_2_D1  =iMA(symbol,PERIOD_D1,period2,0,MA_Method2,MA_price2,i+1);

      if(MA1_D1>ma2_D1 && MA1_2_D1<ma2_2_D1)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| MA_SELL_D1 function                                   |
//+------------------------------------------------------------------+
int  MA_SELL_D1(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double MA1_D1    =iMA(symbol,PERIOD_D1,period1,0,MA_Method1,MA_price1,i);
      double MA1_2_D1  =iMA(symbol,PERIOD_D1,period1,0,MA_Method1,MA_price1,i+1);
      double ma2_D1    =iMA(symbol,PERIOD_D1,period2,0,MA_Method2,MA_price2,i);
      double ma2_2_D1  =iMA(symbol,PERIOD_D1,period2,0,MA_Method2,MA_price2,i+1);

      if(MA1_D1<ma2_D1 && MA1_2_D1>ma2_2_D1)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| STO_BUY_D1 function                                   |
//+------------------------------------------------------------------+
int  STO_BUY_D1(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double sto_D1    =  iStochastic(symbol,PERIOD_D1,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,0,i);
      if(sto_D1 < STO_Dn)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| STO_SELL_D1 function                                   |
//+------------------------------------------------------------------+
int  STO_SELL_D1(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double sto_D1    =  iStochastic(symbol,PERIOD_D1,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,0,i);
      if(sto_D1 > STO_Up)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| MA_BUY_W1 function                                   |
//+------------------------------------------------------------------+
int  MA_BUY_W1(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double MA1_W1    =iMA(symbol,PERIOD_W1,period1,0,MA_Method1,MA_price1,i);
      double MA1_2_W1  =iMA(symbol,PERIOD_W1,period1,0,MA_Method1,MA_price1,i+1);
      double ma2_W1    =iMA(symbol,PERIOD_W1,period2,0,MA_Method2,MA_price2,i);
      double ma2_2_W1  =iMA(symbol,PERIOD_W1,period2,0,MA_Method2,MA_price2,i+1);
      if(MA1_W1>ma2_W1 && MA1_2_W1<ma2_2_W1)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| MA_SELL_W1 function                                   |
//+------------------------------------------------------------------+
int  MA_SELL_W1(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double MA1_W1    =iMA(symbol,PERIOD_W1,period1,0,MA_Method1,MA_price1,i);
      double MA1_2_W1  =iMA(symbol,PERIOD_W1,period1,0,MA_Method1,MA_price1,i+1);
      double ma2_W1    =iMA(symbol,PERIOD_W1,period2,0,MA_Method2,MA_price2,i);
      double ma2_2_W1  =iMA(symbol,PERIOD_W1,period2,0,MA_Method2,MA_price2,i+1);

      if(MA1_W1<ma2_W1 && MA1_2_W1>ma2_2_W1)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| STO_BUY_W1 function                                   |
//+------------------------------------------------------------------+
int  STO_BUY_W1(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double sto_W1    =  iStochastic(symbol,PERIOD_W1,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,0,i);
      if(sto_W1 < STO_Dn)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
//| STO_SELL_W1 function                                   |
//+------------------------------------------------------------------+
int  STO_SELL_W1(string symbol)
  {
   for(int i=1; i<iBars(symbol,0); i++)
     {
      double sto_W1    =  iStochastic(symbol,PERIOD_W1,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,0,i);
      if(sto_W1 > STO_Up)
        {
         return(i);
        }
     }

   return(-1);
  }
//+------------------------------------------------------------------+
