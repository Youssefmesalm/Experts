//+------------------------------------------------------------------+
//|                                                 Dr Zain Agha.mq5 |
//+------------------------------------------------------------------+
//|                                   Copyright 2022, Yousuf Mesalm. |
//|                                    https://www.Yousuf-mesalm.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Yousuf Mesalm."
#property link      "https://www.Yousuf-mesalm.com"
#property link      "https://www.mql5.com/en/users/20163440"
#property description      "Developed by Yousuf Mesalm"
#property description      "https://www.Yousuf-mesalm.com"
#property description      "https://www.mql5.com/en/users/20163440"
#property version   "1.00"

// Includes
#include  <YM\Execute\Execute.mqh>
#include  <YM\Position\Position.mqh>

// enum
enum SNR_Mode
  {
   Auto,Maunal,
  };

// User inputs
input SNR_Mode snr=Auto; // Type To Detect High and low
input double Manual_High= 1.5000;
input double Manual_Low=  1.2000;
input long MagicNumber=2020;
input double Lot=0.1;
input double TpRR=2;
input int Max_Open_Trades= 1;
input string comment=" Yousuf Mesalm";
datetime lasttime=0;


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
   ObjectDelete(0,"High");
   ObjectDelete(0,"Low");
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   double Last_High;
   double Last_Low ;
   datetime lasttime_time= 0;

   if(snr==Auto)
     {
      Last_High=iHigh(Symbol(),PERIOD_D1,1);
      Last_Low =iLow(Symbol(),PERIOD_D1,1);
      lasttime_time= iTime(Symbol(),PERIOD_D1,1);
     }
   else
     {
      Last_High=Manual_High;
      Last_Low =Manual_Low;
      lasttime_time= iTime(Symbol(),PERIOD_D1,1);
     }
   double current_High=iHigh(Symbol(),PERIOD_M15,1);
   double current_Low=iLow(Symbol(),PERIOD_M15,1);
   double current_Open=iOpen(Symbol(),PERIOD_M15,1);
   double current_Close=iClose(Symbol(),PERIOD_M15,1);
   datetime current_time= iTime(Symbol(),PERIOD_M15,1);
   TrendCreate(0,"High",0,lasttime_time,Last_High,TimeCurrent(),Last_High);
   TrendCreate(0,"Low",0,lasttime_time,Last_Low,TimeCurrent(),Last_Low);
   if(current_Low<Last_Low&&current_Close>Last_Low&&tools.IsNewBar(PERIOD_M15))
     {
      lasttime=current_time;
      double sl=iLow(Symbol(),PERIOD_D1,0);
      double tp=((tools.Bid()-sl)*TpRR)+tools.Bid();
      if(Pos.GroupTotal()<Max_Open_Trades)
         trade.Position(TYPE_POSITION_BUY,Lot,sl,tp,SLTP_PRICE,30,comment);
     }
   if(current_High>Last_High&&current_Close<Last_High&&tools.IsNewBar(PERIOD_M15))
     {
      lasttime=current_time;
      double sl=iLow(Symbol(),PERIOD_D1,0);
      double tp=tools.Bid()-((sl-tools.Bid())*TpRR);
      if(Pos.GroupTotal()<Max_Open_Trades)
         trade.Position(TYPE_POSITION_SELL,Lot,sl,tp,SLTP_PRICE,30,comment);
     }
  }
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
                 const color           clr=clrRed,        // line color
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
   if(!ObjectCreate(chart_ID,name,OBJ_TREND,sub_window,time1,price1,time2,price2))
     {
      Print(__FUNCTION__,
            ": failed to create a trend line! Error code = ",GetLastError());
      return(false);
     }
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
