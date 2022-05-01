//+------------------------------------------------------------------+
//|                                            Structur Level EA.mq5 |
//|                                   Copyright 2022, Yousuf Mesalm. |
//|                                    https://www.Yousuf-mesalm.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Yousuf Mesalm."
#property link      "https://www.Yousuf-mesalm.com"
#property version   "1.00"
#include  <YM\YM.mqh>
input ENUM_TIMEFRAMES Highest_TF=PERIOD_D1;
input ENUM_TIMEFRAMES Lowest_TF=PERIOD_CURRENT;
input double Total_Risk=3; //% Maximum Risk
input int max_Orders=10;
input double Risk_Per_Trade=0.5;
long input MagicNumber = 2020;
input bool Use_AutoSLTP=true;
input double Profit_Ratio=2;
double input Stoploss=100;  // Sl in pips when AutoSLTP is false
input double TakeProfit=100;// TP in pips when AutoSLTP is false
input string comment="Yousuf Mesalm";
bool input Use_BreakEven = true;
bool input Use_Trailing = true;
int input BreakEventPoint = 25;
int input TrailingStopPoint = 50;
double Last=0;
int trend=0;
// variables
int handle0,handle1;
//Arrays
ENUM_TIMEFRAMES TFS[10]= {PERIOD_M1,PERIOD_M5,PERIOD_M10,PERIOD_M15,PERIOD_M30,PERIOD_H1,PERIOD_H4,PERIOD_D1,PERIOD_W1,PERIOD_MN1};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CUtilities *tools=new CUtilities(Symbol());
CExecute *trade=new CExecute(Symbol(), MagicNumber);
CPosition *SellPos=new CPosition(Symbol(), MagicNumber, GROUP_POSITIONS_SELLS);
CPosition *BuyPos=new CPosition(Symbol(), MagicNumber, GROUP_POSITIONS_BUYS);
CPosition *Pos=new CPosition(Symbol(), MagicNumber, GROUP_POSITIONS_ALL);
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   handle0=iCustom(Symbol(),Highest_TF,"StructureLevel");
   handle1=iCustom(Symbol(),Lowest_TF,"StructureLevel");

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   delete trade;
   delete SellPos;
   delete Pos;
   delete BuyPos;
   delete tools;

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
   int Last_HH1_idx=0,Last_HL1_idx=0;
   double Last_HH2=-1,Last_HL2=-1;
   int Last_HH2_idx,Last_HL2_idx;
   ArraySetAsSeries(Highest_Highs,true);
   ArraySetAsSeries(Highest_Lows,true);
   double Last_LH1=-1,Last_LL1=-1;
   int Last_LH1_idx=0,Last_LL1_idx=0;
   double Last_LH2=-1,Last_LL2=-1;
   int Last_LH2_idx,Last_LL2_idx;
   ArraySetAsSeries(Lowest_Highs,true);
   ArraySetAsSeries(Lowest_Lows,true);

   bool TradeAllow=true;
   double Total_Profit=Pos.GroupTotalProfit();
   if(Total_Profit<0&&MathAbs(Total_Profit)>AccountInfoDouble(ACCOUNT_BALANCE)*(Total_Risk/100)||Pos.GroupTotal()>=max_Orders)
     {
      TradeAllow=false;
     }

   for(int i=4; i<ArraySize(Highest_Highs) ; i++)
     {
      if(Highest_Highs[i]>0&&Last_HH1<0)
        {
         Last_HH1=Highest_Highs[i];
         Last_HH1_idx=i;
         continue;
        }
      if(Highest_Highs[i]>0&&Last_HH1>0&&Last_HH2<0)
        {
         Last_HH2=Highest_Highs[i];
         Last_HH2_idx=i;
         continue;
        }
      if(Highest_Lows[i]>0&&Last_HL1<0)
        {
         Last_HL1=Highest_Lows[i];
         Last_HL1_idx=i;
         continue;
        }
      if(Highest_Lows[i]>0&&Last_HL1>0&&Last_HL2<0)
        {
         Last_HL2=Highest_Lows[i];
         Last_HL2_idx=i;
         continue;
        }
      if(Last_HH1>0&&Last_HL1>0&&Last_HH2>0&&Last_HL2>0)
        {
         break;
        }
     }
   if(Last_HH1_idx>Last_HL1_idx)
     {
      trend=1;
      Info("High_Trend",0,25,20,"High TF Trend is UP",10,"Arial",clrLimeGreen);
     }
   else
     {

      trend=-1;
      Info("High_Trend",0,25,20,"High TF Trend is Down",10,"Arial",clrRed);

     }
   if(_Period==Highest_TF)
     {
      if(Last_HH1>Last_HH2)
        {
         TextCreate(0,"HH",0,iTime(Symbol(),Highest_TF,Last_HH1_idx),Last_HH1,"HH");
        }
      else
        {
         TextCreate(0,"HH",0,iTime(Symbol(),Highest_TF,Last_HH1_idx),Last_HH1,"LH");

        }
      if(Last_HL1>Last_HL2)
        {
         TextCreate(0,"HL",0,iTime(Symbol(),Highest_TF,Last_HL1_idx),Last_HL1,"HL");
        }
      else
        {
         TextCreate(0,"HL",0,iTime(Symbol(),Highest_TF,Last_HL1_idx),Last_HL1,"LL");

        }
     }
   for(int i=4; i<ArraySize(Lowest_Highs) ; i++)
     {
      if(Lowest_Highs[i]>0&&Last_LH1<0)
        {
         Last_LH1=Lowest_Highs[i];
         Last_LH1_idx=i;
         continue;
        }
      if(Lowest_Highs[i]>0&&Last_LH1>0&&Last_LH2<0)
        {
         Last_LH2=Lowest_Highs[i];
         Last_LH2_idx=i;
         continue;
        }
      if(Lowest_Lows[i]>0&&Last_LL1<0)
        {
         Last_LL1=Lowest_Lows[i];
         Last_LL1_idx=i;
         continue;
        }
      if(Lowest_Lows[i]>0&&Last_LL1>0&&Last_LL2<0)
        {
         Last_LL2=Lowest_Lows[i];
         Last_LL2_idx=i;
         continue;
        }
      if(Last_LH1>0&&Last_LL1>0&&Last_LH2>0&&Last_LL2>0)
        {
         break;
        }
     }

   if(Last_LH1>Last_LH2)
     {
      TextCreate(0,"LH",0,iTime(Symbol(),Lowest_TF,Last_LH1_idx),Last_LH1,"HH");
      TrendCreate(0,"LH-Line",0,iTime(Symbol(),Lowest_TF,Last_LH1_idx),Last_LH1,TimeCurrent(),Last_LH1);
     }
   else
     {
      TextCreate(0,"LH",0,iTime(Symbol(),Lowest_TF,Last_LH1_idx),Last_LH1,"LH");
      TrendCreate(0,"LH-Line",0,iTime(Symbol(),Lowest_TF,Last_LH1_idx),Last_LH1,TimeCurrent(),Last_LH1);

     }
   if(Last_LL1>Last_LL2)
     {
      TextCreate(0,"LL",0,iTime(Symbol(),Lowest_TF,Last_LL1_idx),Last_LL1,"HL");
      TrendCreate(0,"LL-Line",0,iTime(Symbol(),Lowest_TF,Last_LL1_idx),Last_LL1,TimeCurrent(),Last_LL1);

     }
   else
     {
      TextCreate(0,"LL",0,iTime(Symbol(),Lowest_TF,Last_LL1_idx),Last_LL1,"LL");
      TrendCreate(0,"LL-Line",0,iTime(Symbol(),Lowest_TF,Last_LL1_idx),Last_LL1,TimeCurrent(),Last_LL1);

     }
   double lot=LotsMM();
   double sl=Stoploss,tp=TakeProfit;
   int L_trend=0;
   if(Last_LH1_idx<Last_LL1_idx)
     {
      L_trend=-1;
      Info("Low_Trend",0,50,20,"Low TF Trend is Down",10,"Arial",clrRed);

     }
   else
     {
      Info("Low_Trend",0,50,20,"Low TF Trend is Up",10,"Arial",clrLimeGreen);
      L_trend=1;
     }

   if(trend<0&&L_trend<0)
     {
      if(tools.Ask()<Last_LL1&&Last!=Last_LL1&&TradeAllow)
        {
         if(Use_AutoSLTP)
           {
            sl=Last_LH1;
            tp=tools.Bid()-(Profit_Ratio*(Last_LH1-tools.Bid()));
           }
         trade.Position(TYPE_POSITION_SELL,lot,sl,tp,Use_AutoSLTP?SLTP_PRICE:SLTP_PIPS,30,comment);
         Last=Last_LL1;
        }
     }
   if(trend>0&&L_trend>0)
     {
      if(tools.Ask()>Last_LH1&&Last!=Last_LH1&&TradeAllow)
        {
         if(Use_AutoSLTP)
           {
            sl=Last_LL1;
            tp=tools.Bid()+(Profit_Ratio*(tools.Bid()-Last_LL1));
           }
         trade.Position(TYPE_POSITION_BUY,lot,sl,tp,Use_AutoSLTP?SLTP_PRICE:SLTP_PIPS,30,comment);
         Last=Last_LH1;
        }
     }
   Traliling();
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Create a trend line by the given coordinates                     |
//+------------------------------------------------------------------+
bool TrendCreate(const long            chart_ID=0,        // chart's ID
                 const string          name="TrendLine",  // line name
                 const int             sub_window=0,      // subwindow index
                 datetime              time1=0,           // first point time
                 double                price1=0,          // first point price
                 datetime              time2=0,           // second point time
                 double                price2=0,          // second point price
                 const color           clr=clrLimeGreen,        // line color
                 const ENUM_LINE_STYLE style=STYLE_SOLID, // line style
                 const int             width=2,           // line width
                 const bool            back=true,        // in the background
                 const bool            selection=false,    // highlight to move
                 const bool            ray_left=false,    // line's continuation to the left
                 const bool            ray_right=false,   // line's continuation to the right
                 const bool            hidden=true,       // hidden in the object list
                 const long            z_order=0)         // priority for mouse click
  {
//--- set anchor points' coordinates if they are not set
   ChangeTrendEmptyPoints(time1,price1,time2,price2);
//--- reset the error value
   ResetLastError();
//--- create a trend line by the given coordinates
   ObjectCreate(chart_ID,name,OBJ_TREND,sub_window,time1,price1,time2,price2);
//--- set line color
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- set line display style
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- set line width
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of moving the line by mouse
//--- when creating a graphical object using ObjectCreate function, the object cannot be
//--- highlighted and moved by default. Inside this method, selection parameter
//--- is true by default making it possible to highlight and move the object
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- enable (true) or disable (false) the mode of continuation of the line's display to the left
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_LEFT,ray_left);
//--- enable (true) or disable (false) the mode of continuation of the line's display to the right
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
   return(true);
  }
//+------------------------------------------------------------------+
//| Move trend line anchor point                                     |
//+------------------------------------------------------------------+
bool TrendPointChange(const long   chart_ID=0,       // chart's ID
                      const string name="TrendLine", // line name
                      const int    point_index=0,    // anchor point index
                      datetime     time=0,           // anchor point time coordinate
                      double       price=0)          // anchor point price coordinate
  {
//--- if point position is not set, move it to the current bar having Bid price
   if(!time)
      time=TimeCurrent();
   if(!price)
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID);
//--- reset the error value
   ResetLastError();
//--- move trend line's anchor point
   if(!ObjectMove(chart_ID,name,point_index,time,price))
     {
      Print(__FUNCTION__,
            ": failed to move the anchor point! Error code = ",GetLastError());
      return(false);
     }
//--- successful execution
   return(true);
  }
//+------------------------------------------------------------------+
//| The function deletes the trend line from the chart.              |
//+------------------------------------------------------------------+
bool TrendDelete(const long   chart_ID=0,       // chart's ID
                 const string name="TrendLine") // line name
  {
//--- reset the error value
   ResetLastError();
//--- delete a trend line
   if(!ObjectDelete(chart_ID,name))
     {
      Print(__FUNCTION__,
            ": failed to delete a trend line! Error code = ",GetLastError());
      return(false);
     }
//--- successful execution
   return(true);
  }
//+------------------------------------------------------------------+
//| Check the values of trend line's anchor points and set default   |
//| values for empty ones                                            |
//+------------------------------------------------------------------+
void ChangeTrendEmptyPoints(datetime &time1,double &price1,
                            datetime &time2,double &price2)
  {
//--- if the first point's time is not set, it will be on the current bar
   if(!time1)
      time1=TimeCurrent();
//--- if the first point's price is not set, it will have Bid value
   if(!price1)
      price1=SymbolInfoDouble(Symbol(),SYMBOL_BID);
//--- if the second point's time is not set, it is located 9 bars left from the second one
   if(!time2)
     {
      //--- array for receiving the open time of the last 10 bars
      datetime temp[10];
      CopyTime(Symbol(),Period(),time1,10,temp);
      //--- set the second point 9 bars left from the first one
      time2=temp[0];
     }
//--- if the second point's price is not set, it is equal to the first point's one
   if(!price2)
      price2=price1;
  }
//+------------------------------------------------------------------+
//| Creating Text object                                             |
//+------------------------------------------------------------------+
bool TextCreate(const long              chart_ID=0,               // chart's ID
                const string            name="Text",              // object name
                const int               sub_window=0,             // subwindow index
                datetime                time=0,                   // anchor point time
                double                  price=0,                  // anchor point price
                const string            text="Text",              // the text itself
                const string            font="Arial",             // font
                const int               font_size=10,             // font size
                const color             clr=clrRed,               // color
                const double            angle=0.0,                // text slope
                const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // anchor type
                const bool              back=false,               // in the background
                const bool              selection=false,          // highlight to move
                const bool              hidden=true,              // hidden in the object list
                const long              z_order=0)                // priority for mouse click
  {
//--- set anchor point coordinates if they are not set
   ChangeTextEmptyPoint(time,price);
//--- reset the error value
   ResetLastError();
//--- create Text object
   if(!ObjectCreate(chart_ID,name,OBJ_TEXT,sub_window,time,price))
     {
      Print(__FUNCTION__,
            ": failed to create \"Text\" object! Error code = ",GetLastError());
      return(false);
     }
//--- set the text
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
//--- set text font
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
//--- set font size
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
//--- set the slope angle of the text
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
//--- set anchor type
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
//--- set color
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of moving the object by mouse
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
   return(true);
  }
//+------------------------------------------------------------------+
//| Move the anchor point                                            |
//+------------------------------------------------------------------+
bool TextMove(const long   chart_ID=0,  // chart's ID
              const string name="Text", // object name
              datetime     time=0,      // anchor point time coordinate
              double       price=0)     // anchor point price coordinate
  {
//--- if point position is not set, move it to the current bar having Bid price
   if(!time)
      time=TimeCurrent();
   if(!price)
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID);
//--- reset the error value
   ResetLastError();
//--- move the anchor point
   if(!ObjectMove(chart_ID,name,0,time,price))
     {
      Print(__FUNCTION__,
            ": failed to move the anchor point! Error code = ",GetLastError());
      return(false);
     }
//--- successful execution
   return(true);
  }
//+------------------------------------------------------------------+
//| Change the object text                                           |
//+------------------------------------------------------------------+
bool TextChange(const long   chart_ID=0,  // chart's ID
                const string name="Text", // object name
                const string text="Text") // text
  {
//--- reset the error value
   ResetLastError();
//--- change object text
   if(!ObjectSetString(chart_ID,name,OBJPROP_TEXT,text))
     {
      Print(__FUNCTION__,
            ": failed to change the text! Error code = ",GetLastError());
      return(false);
     }
//--- successful execution
   return(true);
  }
//+------------------------------------------------------------------+
//| Delete Text object                                               |
//+------------------------------------------------------------------+
bool TextDelete(const long   chart_ID=0,  // chart's ID
                const string name="Text") // object name
  {
//--- reset the error value
   ResetLastError();
//--- delete the object
   if(!ObjectDelete(chart_ID,name))
     {
      Print(__FUNCTION__,
            ": failed to delete \"Text\" object! Error code = ",GetLastError());
      return(false);
     }
//--- successful execution
   return(true);
  }
//+------------------------------------------------------------------+
//| Check anchor point values and set default values                 |
//| for empty ones                                                   |
//+------------------------------------------------------------------+
void ChangeTextEmptyPoint(datetime &time,double &price)
  {
//--- if the point's time is not set, it will be on the current bar
   if(!time)
      time=TimeCurrent();
//--- if the point's price is not set, it will have Bid value
   if(!price)
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double LotsMM()
  {
   double L = MathCeil((AccountInfoDouble(ACCOUNT_MARGIN_FREE) * Risk_Per_Trade) / 1000) / Stoploss;
   if(L < SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN))
      L = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN);
   if(L > SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MAX))
      L = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MAX);
   return (tools.NormalizeVolume(L));
  }
//+------------------------------------------------------------------+
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

            if(Use_BreakEven)
              {
               if((BuyPos.GetStopLoss() < BuyPos.GetPriceOpen() || BuyPos.GetStopLoss() == 0)
                  && tools.Bid() >= (BuyPos.GetPriceOpen() + BreakEventPoint * tools.Pip()))
                 {
                  BuyPos.Modify(BuyPos.GetPriceOpen(), BuyPos.GetTakeProfit(), SLTP_PRICE);
                 }
              }

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

            if(Use_BreakEven)
              {
               if((SellPos.GetStopLoss() > SellPos.GetPriceOpen() || SellPos.GetStopLoss() == 0)
                  && tools.Ask() <= (SellPos.GetPriceOpen() - BreakEventPoint * tools.Pip()))
                 {
                  SellPos.Modify(SellPos.GetPriceOpen(), SellPos.GetTakeProfit(), SLTP_PRICE);
                 }
              }
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
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Info(string NAME,int CORNER,int Y,int X,string TEXT,int FONTSIZE,string FONT,color FONTCOLOR)
  {
   ObjectCreate(0,NAME,OBJ_LABEL,0,0,0);
   ObjectSetString(0,NAME,OBJPROP_TEXT,TEXT);
   ObjectSetInteger(0,NAME,OBJPROP_FONTSIZE,FONTSIZE);
   ObjectSetInteger(0,NAME,OBJPROP_COLOR,FONTCOLOR);
   ObjectSetString(0,NAME,OBJPROP_FONT,FONT);
   ObjectSetInteger(0,NAME,OBJPROP_CORNER,CORNER);
   ObjectSetInteger(0,NAME,OBJPROP_XDISTANCE,X);
   ObjectSetInteger(0,NAME,OBJPROP_YDISTANCE,Y);

  }
//+------------------------------------------------------------------+
