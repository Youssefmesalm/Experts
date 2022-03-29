//+------------------------------------------------------------------+
//|                                                         MA96.mq5 |
//|                        Copyright 2009, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "2009, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#define iNum 96

#property indicator_chart_window
#property indicator_buffers iNum
#property indicator_plots   iNum
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
input bool               AsSeries = true;
input ENUM_MA_METHOD     smootMode = MODE_EMA;
input ENUM_APPLIED_PRICE price = PRICE_CLOSE;
input int                shift = 0;
//---- indicator parameters]
int Param[iNum];
//--- indicator buffers
class CIndicatorBuffer
  {
public:
   int               mParam;
   int               mhandle;
   double            mbuffer[];
   //--- Constructor
                     CIndicatorBuffer() {} // {Print("CIndicatorBuffer::Constructor()");}//called when add indicator to chart
   //--- Destructor
                    ~CIndicatorBuffer() {} // {Print("CIndicatorBuffer::Destructor()");}//called when del indicator from chart
   void              Init() {} //{Print("CIndicatorBuffer::Init()");}//called after Constructor
   void              Deinit()
     {
      ArrayFree(mbuffer);
      //Print("CIndicatorBuffer::Deinit()");
     }//called before Destructor
   bool              mArraySetAsSeries(bool set)
     {return         ArraySetAsSeries(mbuffer, set);}
   bool              mSetIndexBuffer(int index, ENUM_INDEXBUFFER_TYPE data_type = INDICATOR_DATA)
     {return         SetIndexBuffer(index, mbuffer, data_type);}
   bool              mPlotIndexSetInteger(int plot_index, ENUM_PLOT_PROPERTY_INTEGER prop_id = PLOT_DRAW_TYPE, int prop_value = DRAW_LINE)
     {return         PlotIndexSetInteger(plot_index, prop_id, prop_value);}
   bool              mPlotIndexSetString(int plot_index, ENUM_PLOT_PROPERTY_STRING prop_id = PLOT_LABEL, string prop_value = "")
     {return         PlotIndexSetString(plot_index, prop_id, prop_value);}
   int               mCopyBuffer(int count)
     {return         CopyBuffer(mhandle, 0, 0, count, mbuffer);}
  };
CIndicatorBuffer MAA[iNum];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//Print("true=",IntegerToString(true));
//Print("false=",IntegerToString(false));
//Print("Param=",IntegerToString(&Param[0]));
//--- indicator buffers mapping
   IndicatorSetString(INDICATOR_SHORTNAME, "MA96(N*10)" + IntegerToString(AsSeries));
//---
   /*
      for(int i=0; i<iNum; i++)
      {
         MAA[i].Init();
         Param[i]=10*(i+1);
         //Print("Param["+IntegerToString(i)+"]=",IntegerToString(Param[i]));//OK
         MAA[i].mSetIndexBuffer(i,INDICATOR_DATA);
         MAA[i].mPlotIndexSetInteger(i,PLOT_DRAW_TYPE,DRAW_LINE);
         MAA[i].mPlotIndexSetString(i,PLOT_LABEL,"MA"+IntegerToString(i,2,'0'));//Print(IntegerToString())
         MAA[i].mhandle=iMA(NULL,0,Param[i],shift,smootMode,price); //Symbol()
         Print("MAA["+IntegerToString(i)+"].mhandle=",IntegerToString(MAA[i].mhandle));
         //first call iMA(), return 10; later call, return 0?
      }
   */
   for(int i = 0; i < iNum; i++)
     {
      MAA[i].Init();
      MAA[i].mParam = 10 * (i + 1);
      //Print("MAA["+IntegerToString(i)+"].mParam=",IntegerToString(MAA[i].mParam));//OK
      MAA[i].mSetIndexBuffer(i, INDICATOR_DATA);
      MAA[i].mPlotIndexSetInteger(i, PLOT_DRAW_TYPE, DRAW_LINE);
      MAA[i].mPlotIndexSetString(i, PLOT_LABEL, "MA" + IntegerToString(i, 2, '0')); //Print(IntegerToString())
      MAA[i].mhandle = iMA(NULL, 0, MAA[i].mParam, shift, smootMode, price); //Symbol()
      //Print("MAA["+IntegerToString(i)+"].mhandle=",IntegerToString(MAA[i].mhandle));
     }
//It's OK, just move iMA() to the line above SetIndexBuffer()?
//No, the sequence is independent.
//It's OK, just move Param into CIndicatorBuffer as a member.
//But why? array member cannot be a ma_period of iMA?
//No, I has tested, iMA(NULL,0,Param[i],shift,smootMode,price) is OK.
//It's strange.
   /*
      for(int i=0; i<16; i++)
      {
         Param[i]=10*(i+1);
         mhandle[i]=iMA(NULL,0,Param[i],shift,smootMode,price); //Symbol()
         Print("Param["+IntegerToString(i)+"]=",IntegerToString(Param[i]));
         Print("mhandle["+IntegerToString(i)+"]=",IntegerToString(mhandle[i]));
      }
   */
   if(AsSeries)
     {
      for(int i = 0; i < iNum; i++)
        {
         MAA[i].mArraySetAsSeries(true);
        }
     }
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   for(int i = 0; i < iNum; i++)
     {
      MAA[i].Deinit();
     }
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
   int ibars;
//Print("rates_total=",IntegerToString(rates_total));
   for(int i = 0; i < iNum; i++)
     {
      ibars = BarsCalculated(MAA[i].mhandle);
      //Print("ibars=",IntegerToString(ibars)); //ibars=-1?
      if(ibars < rates_total)
         return(0);
      copied = MAA[i].mCopyBuffer(ibars);
      //copied=MAA[i].mCopyBuffer(rates_total);
     }
//Print(IntegerToString(copied)," copied");
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
