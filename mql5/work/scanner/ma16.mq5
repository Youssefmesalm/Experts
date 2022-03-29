//+------------------------------------------------------------------+
//|                                                         MA16.mq5 |
//|                        Copyright 2009, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "2009, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
 
#property indicator_chart_window
#property indicator_buffers 16
#property indicator_plots   16
//---- plot MA
#property indicator_type1   DRAW_LINE
#property indicator_type2   DRAW_LINE
#property indicator_type3   DRAW_LINE
#property indicator_type4   DRAW_LINE
#property indicator_type5   DRAW_LINE
#property indicator_type6   DRAW_LINE
#property indicator_type7   DRAW_LINE
#property indicator_type8   DRAW_LINE
#property indicator_type9   DRAW_LINE
#property indicator_type10  DRAW_LINE
#property indicator_type11  DRAW_LINE
#property indicator_type12  DRAW_LINE
#property indicator_type13  DRAW_LINE
#property indicator_type14  DRAW_LINE
#property indicator_type15  DRAW_LINE
#property indicator_type16  DRAW_LINE

#property  indicator_color1  Red
#property  indicator_color2  OrangeRed //DarkOrange
#property  indicator_color3  Gold
#property  indicator_color4  Yellow
#property  indicator_color5  Lime
#property  indicator_color6  Aqua
#property  indicator_color7  Blue
#property  indicator_color8  Magenta
#property  indicator_color9  Red
#property  indicator_color10  OrangeRed
#property  indicator_color11  Gold
#property  indicator_color12  Yellow
#property  indicator_color13  Lime
#property  indicator_color14  Aqua
#property  indicator_color15  Blue
#property  indicator_color16  Magenta

#property indicator_style1  STYLE_SOLID
#property indicator_style2  STYLE_SOLID
#property indicator_style3  STYLE_SOLID
#property indicator_style4  STYLE_SOLID
#property indicator_style5  STYLE_SOLID
#property indicator_style6  STYLE_SOLID
#property indicator_style7  STYLE_SOLID
#property indicator_style8  STYLE_SOLID
#property indicator_style9  STYLE_DASHDOT
#property indicator_style10 STYLE_DASHDOT
#property indicator_style11 STYLE_DASHDOT
#property indicator_style12 STYLE_DASHDOT
#property indicator_style13 STYLE_DASHDOT
#property indicator_style14 STYLE_DASHDOT
#property indicator_style15 STYLE_DASHDOT
#property indicator_style16 STYLE_DASHDOT

#property indicator_label1  "MA1"
#property indicator_width1  1

//--- input parameters
input bool               AsSeries=true;
input ENUM_MA_METHOD     smootMode=MODE_EMA;
input ENUM_APPLIED_PRICE price=PRICE_CLOSE;
input int                shift=0;
//---- indicator parameters X
int P1=10;
int P2=20;
int P3=30;
int P4=40;
int P5=50;
int P6=60;
int P7=70;
int P8=80;
int P9=90;
int Pa=100;
int Pb=110;
int Pc=120;
int Pd=130;
int Pe=140;
int Pf=150;
int Pg=160;
//--- indicator buffers
double MA1[];
double MA2[];
double MA3[];
double MA4[];
double MA5[];
double MA6[];
double MA7[];
double MA8[];
double MA9[];
double MAa[];
double MAb[];
double MAc[];
double MAd[];
double MAe[];
double MAf[];
double MAg[];

int ma1_handle;
int ma2_handle;
int ma3_handle;
int ma4_handle;
int ma5_handle;
int ma6_handle;
int ma7_handle;
int ma8_handle;
int ma9_handle;
int maa_handle;
int mab_handle;
int mac_handle;
int mad_handle;
int mae_handle;
int maf_handle;
int mag_handle;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
/*   if(AsSeries) {
      ArraySetAsSeries(MA1,true);
      ArraySetAsSeries(MA2,true);
      ArraySetAsSeries(MA3,true);
      ArraySetAsSeries(MA4,true);
      ArraySetAsSeries(MA5,true);
      ArraySetAsSeries(MA6,true);
      ArraySetAsSeries(MA7,true);
      ArraySetAsSeries(MA8,true);
      ArraySetAsSeries(MA9,true);
      ArraySetAsSeries(MAa,true);
      ArraySetAsSeries(MAb,true);
      ArraySetAsSeries(MAc,true);
      ArraySetAsSeries(MAd,true);
      ArraySetAsSeries(MAe,true);
      ArraySetAsSeries(MAf,true);
      ArraySetAsSeries(MAg,true);
   }
   Print("Indicator buffer is timeseries =",ArrayGetAsSeries(MA1));
*/
   SetIndexBuffer(0,MA1,INDICATOR_DATA);
   SetIndexBuffer(1,MA2,INDICATOR_DATA);
   SetIndexBuffer(2,MA3,INDICATOR_DATA);
   SetIndexBuffer(3,MA4,INDICATOR_DATA);
   SetIndexBuffer(4,MA5,INDICATOR_DATA);
   SetIndexBuffer(5,MA6,INDICATOR_DATA);
   SetIndexBuffer(6,MA7,INDICATOR_DATA);
   SetIndexBuffer(7,MA8,INDICATOR_DATA);
   SetIndexBuffer(8,MA9,INDICATOR_DATA);
   SetIndexBuffer(9,MAa,INDICATOR_DATA);
   SetIndexBuffer(10,MAb,INDICATOR_DATA);
   SetIndexBuffer(11,MAc,INDICATOR_DATA);
   SetIndexBuffer(12,MAd,INDICATOR_DATA);
   SetIndexBuffer(13,MAe,INDICATOR_DATA);
   SetIndexBuffer(14,MAf,INDICATOR_DATA);
   SetIndexBuffer(15,MAg,INDICATOR_DATA);
   Print("Indicator buffer after SetIndexBuffer() is timeseries =", ArrayGetAsSeries(MA1));
   ArraySetAsSeries(MA1,AsSeries);
   ArraySetAsSeries(MA2,AsSeries);
   ArraySetAsSeries(MA3,AsSeries);
   ArraySetAsSeries(MA4,AsSeries);
   ArraySetAsSeries(MA5,AsSeries);
   ArraySetAsSeries(MA6,AsSeries);
   ArraySetAsSeries(MA7,AsSeries);
   ArraySetAsSeries(MA8,AsSeries);
   ArraySetAsSeries(MA9,AsSeries);
   ArraySetAsSeries(MAa,AsSeries);
   ArraySetAsSeries(MAb,AsSeries);
   ArraySetAsSeries(MAc,AsSeries);
   ArraySetAsSeries(MAd,AsSeries);
   ArraySetAsSeries(MAe,AsSeries);
   ArraySetAsSeries(MAf,AsSeries);
   ArraySetAsSeries(MAg,AsSeries);
   IndicatorSetString(INDICATOR_SHORTNAME,"MA16(N*10)"+IntegerToString(AsSeries));
   PlotIndexSetString(0,PLOT_LABEL,"MA1");
   PlotIndexSetString(1,PLOT_LABEL,"MA2");
   PlotIndexSetString(2,PLOT_LABEL,"MA3");
   PlotIndexSetString(3,PLOT_LABEL,"MA4");
   PlotIndexSetString(4,PLOT_LABEL,"MA5");
   PlotIndexSetString(5,PLOT_LABEL,"MA6");
   PlotIndexSetString(6,PLOT_LABEL,"MA7");
   PlotIndexSetString(7,PLOT_LABEL,"MA8");
   PlotIndexSetString(8,PLOT_LABEL,"MA9");
   PlotIndexSetString(9,PLOT_LABEL,"MAa");
   PlotIndexSetString(10,PLOT_LABEL,"MAb");
   PlotIndexSetString(11,PLOT_LABEL,"MAc");
   PlotIndexSetString(12,PLOT_LABEL,"MAd");
   PlotIndexSetString(13,PLOT_LABEL,"MAe");
   PlotIndexSetString(14,PLOT_LABEL,"MAf");
   PlotIndexSetString(15,PLOT_LABEL,"MAg");
//---
   ma1_handle=iMA(Symbol(),0,P1,shift,smootMode,price);
   ma2_handle=iMA(Symbol(),0,P2,shift,smootMode,price);
   ma3_handle=iMA(Symbol(),0,P3,shift,smootMode,price);
   ma4_handle=iMA(Symbol(),0,P4,shift,smootMode,price);
   ma5_handle=iMA(Symbol(),0,P5,shift,smootMode,price);
   ma6_handle=iMA(Symbol(),0,P6,shift,smootMode,price);
   ma7_handle=iMA(Symbol(),0,P7,shift,smootMode,price);
   ma8_handle=iMA(Symbol(),0,P8,shift,smootMode,price);
   ma9_handle=iMA(Symbol(),0,P9,shift,smootMode,price);
   maa_handle=iMA(Symbol(),0,Pa,shift,smootMode,price);
   mab_handle=iMA(Symbol(),0,Pb,shift,smootMode,price);
   mac_handle=iMA(Symbol(),0,Pc,shift,smootMode,price);
   mad_handle=iMA(Symbol(),0,Pd,shift,smootMode,price);
   mae_handle=iMA(Symbol(),0,Pe,shift,smootMode,price);
   maf_handle=iMA(Symbol(),0,Pf,shift,smootMode,price);
   mag_handle=iMA(Symbol(),0,Pg,shift,smootMode,price);
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//--- Copy the values of the moving average in the buffer MABuffer
   int copied;
   copied=CopyBuffer(ma1_handle,0,0,rates_total,MA1);
   copied=CopyBuffer(ma2_handle,0,0,rates_total,MA2);
   copied=CopyBuffer(ma3_handle,0,0,rates_total,MA3);
   copied=CopyBuffer(ma4_handle,0,0,rates_total,MA4);
   copied=CopyBuffer(ma5_handle,0,0,rates_total,MA5);
   copied=CopyBuffer(ma6_handle,0,0,rates_total,MA6);
   copied=CopyBuffer(ma7_handle,0,0,rates_total,MA7);
   copied=CopyBuffer(ma8_handle,0,0,rates_total,MA8);
   copied=CopyBuffer(ma9_handle,0,0,rates_total,MA9);
   copied=CopyBuffer(maa_handle,0,0,rates_total,MAa);
   copied=CopyBuffer(mab_handle,0,0,rates_total,MAb);
   copied=CopyBuffer(mac_handle,0,0,rates_total,MAc);
   copied=CopyBuffer(mad_handle,0,0,rates_total,MAd);
   copied=CopyBuffer(mae_handle,0,0,rates_total,MAe);
   copied=CopyBuffer(maf_handle,0,0,rates_total,MAf);
   copied=CopyBuffer(mag_handle,0,0,rates_total,MAg);
 
   //Print("MA1[0] =",MA1[0]);// Depending on the value AsSeries
                            // Will receive a very old value
                            // Or for the current unfinished bar
 
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
