//+------------------------------------------------------------------+
//|                                                          Vps.mq4 |
//|                                Copyright 2022, Dr Yousuf Mesalm. |
//|                                    https://www.youssefmesalm.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Dr Yousuf Mesalm."
#property link      "https://www.youssefmesalm.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

#include  <MQL_Easy\Execute\Execute.mqh>
#include  <MQL_Easy\Position\Position.mqh>
#include <Arrays\ArrayString.mqh>
//inputs
input long magic_Number=2020;
input double takeprofit=100;
input double stopLoss=100;
input string suffix ="";
input string perfix ="";
input bool Use_GBPUSD = true;
input double GBPUSD_LOT=0.1;
input bool Use_EURUSD = true;
input double EURUSD_LOT=0.1;
input bool Use_USDJPY = true;
input double USDJPY_LOT=0.1;
input bool Use_USDCAD = true;
input double USDCAD_LOT=0.1;
input bool Use_USDCHF = true;
input double USDCHF_LOT=0.1;
input bool Use_AUDUSD = true;
input double AUDUSD_LOT=0.1;
input bool Use_NZDUSD = true;
input double NZDUSD_LOT=0.1;
input bool Use_AUDCAD = true;
input double AUDCAD_LOT=0.1;
input bool Use_AUDCHF = true;
input double AUDCHF_LOT=0.1;
input bool Use_AUDJPY = true;
input double AUDJPY_LOT=0.1;
input bool Use_AUDNZD = true;
input double AUDNZD_LOT=0.1;
input bool Use_CADCHF = true;
input double CADCHF_LOT=0.1;
input bool Use_CADJPY = true;
input double CADJPY_LOT=0.1;
input bool Use_CHFJPY = true;
input double CHFJPY_LOT=0.1;
input bool Use_EURAUD = true;
input double EURAUD_LOT=0.1;
input bool Use_EURCAD = true;
input double EURCAD_LOT=0.1;
input bool Use_EURCHF = true;
input double EURCHF_LOT=0.1;
input bool Use_EURGBP = true;
input double EURGBP_LOT=0.1;
input bool Use_EURJPY = true;
input double EURJPY_LOT=0.1;
input bool Use_EURNZD = true;
input double EURNZD_LOT=0.1;
input bool Use_GBPAUD = true;
input double GBPAUD_LOT=0.1;
input bool Use_GBPCHF = true;
input double GBPCHF_LOT=0.1;
input bool Use_GBPJPY = true;
input double GBPJPY_LOT=0.1;
input bool Use_GBPCAD = true;
input double GBPCAD_LOT=0.1;
input bool Use_GBPNZD = true;
input double GBPNZD_LOT=0.1;
input bool Use_NZDJPY = true;
input double NZDJPY_LOT=0.1;
input bool Use_NZDCHF = true;
input double NZDCHF_LOT=0.1;
input bool Use_NZDCAD = true;
input double NZDCAD_LOT=0.1;

input string        Time_SetUP = "------< Time_SetUP >------";
input bool          UseTimeFilter=false;
input string        TimeStart="12:00";
input string        TimeStop="14:00";
extern string       Trade_Day_SetUP                    = "------< Trade_Day_SetUP >------";
extern bool         Trade_sunday                       = true;
extern bool         Trade_monday                       = true;
extern bool         Trade_tuseday                      = true;
extern bool         Trade_wednisday                    = true;
extern bool         Trade_Thursday                     = true;
extern bool         Trade_friday                       = true;
input color CloseButtton_Color=clrYellow;
input color StopButton_Color=clrYellowGreen;
//variables
string Pairs = "GBPUSD,EURUSD,USDJPY,USDCAD,USDCHF,AUDUSD,NZDUSD,AUDCAD,AUDCHF,AUDJPY,AUDNZD,CADCHF,CADJPY,CHFJPY,EURAUD,EURCAD,EURCHF,EURGBP,EURJPY,EURNZD,GBPAUD,GBPCHF,GBPJPY,GBPCAD,GBPNZD,NZDJPY,NZDCHF,NZDCAD";

string Perfix="SI_FXV_LINE_RATIOS24";
string Symbols[28];
bool use[28];
double lot[28];
datetime lastSignal[28];
bool StopEA=true;
#define  OBJPREFIX "Button - "
// Class object
CExecute *trade[28];
CPosition *Position[28];
CPosition *SellPosition[28];
CPosition *BuyPosition[28];
CUtilities *tools[28];
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   use[0] = Use_GBPUSD;
   lot[0] = GBPUSD_LOT;
   use[1] =  Use_EURUSD;
   lot[1] = EURUSD_LOT;
   use[2] =  Use_USDJPY;
   lot[2] = USDJPY_LOT;

   use[3] =  Use_USDCAD;
   lot[3] = USDCAD_LOT;

   use[4] =  Use_USDCHF;
   lot[4] = USDCHF_LOT;
   use[5] =  Use_AUDUSD;
   lot[5] = AUDUSD_LOT;

   use[6] =  Use_NZDUSD;
   lot[6] = NZDUSD_LOT;
   use[7] =  Use_AUDCAD;
   lot[7] = AUDCAD_LOT;
   use[8] =  Use_AUDCHF;
   lot[8] = AUDCHF_LOT;
   use[9] =  Use_AUDJPY;
   lot[9] = AUDJPY_LOT;
   use[10] =  Use_AUDNZD;
   lot[10] = AUDNZD_LOT;
   use[11] =  Use_CADCHF;
   lot[11] = CADCHF_LOT;
   use[12] =  Use_CADJPY;
   lot[12] = CADJPY_LOT;
   use[13] =  Use_CHFJPY;
   lot[13] = CHFJPY_LOT;
   use[14] =  Use_EURAUD;
   lot[14] = EURAUD_LOT;
   use[15] =  Use_EURCAD;
   lot[15] = EURCAD_LOT;
   use[16] =  Use_EURCHF;
   lot[16] = EURCHF_LOT;
   use[17] =  Use_EURGBP;
   lot[17] = EURGBP_LOT;
   use[18] =  Use_EURJPY;

   lot[18] = EURJPY_LOT;
   use[19] =  Use_EURNZD;
   lot[19] = EURNZD_LOT;
   use[20] =  Use_GBPAUD;
   lot[20] = GBPAUD_LOT;
   use[21] =  Use_GBPCAD;
   lot[21] = GBPCAD_LOT;
   use[22] =  Use_GBPJPY;
   lot[22] = GBPJPY_LOT;
   use[23] =  Use_GBPCAD;
   lot[23] = GBPCAD_LOT;
   use[24] =  Use_GBPNZD;
   lot[24] = GBPNZD_LOT;
   use[25] =  Use_NZDJPY;
   lot[25] = NZDJPY_LOT;
   use[26] =  Use_NZDCHF;
   lot[26] = NZDCHF_LOT;
   use[27] =  Use_NZDCAD;
   lot[27] = NZDCAD_LOT;
//--- create timer
   EventSetTimer(60);
   int size = StringSplit(Pairs, StringGetCharacter(",", 0), Symbols);

   for(int i = 0; i < size; i++)
     {
      if(use[i])
        {
         Symbols[i]=perfix+Symbols[i]+suffix;
         SymbolSelect(Symbols[i],true);
         trade[i] = new CExecute(Symbols[i], magic_Number);
         BuyPosition[i] = new CPosition(Symbols[i], magic_Number, GROUP_POSITIONS_BUYS);
         SellPosition[i] = new CPosition(Symbols[i], magic_Number, GROUP_POSITIONS_SELLS);
         Position[i] = new CPosition(Symbols[i], magic_Number, GROUP_POSITIONS_ALL);
         tools[i] = new CUtilities(Symbols[i]);

        }
     }

   ButtonCreate(0,OBJPREFIX+"CLOSE",0,165,50,100,25,CORNER_LEFT_UPPER,"Close","Trebuchet MS",10,C'59,41,40',CloseButtton_Color,CloseButtton_Color,false,false,false,true,1,"\n");
   ButtonCreate(0,OBJPREFIX+"Stop",0,50,50,100,25,CORNER_LEFT_UPPER,"Stop EA","Trebuchet MS",10,C'59,41,40',StopButton_Color,StopButton_Color,false,false,false,true,1,"\n");


//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   ObjectDelete(0,OBJPREFIX+"Stop");
   ObjectDelete(0,OBJPREFIX+"CLOSE");
   EventKillTimer();

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   bool TradeAlow=(sTimeFilter(TimeStart,TimeStop)&&UseTimeFilter)||!UseTimeFilter;
   if(!StopEA)
     {
      if(day_trade()==true&&TradeAlow==true)
        {
         for(int i=0; i<ObjectsTotal(0,0,OBJ_LABEL); i++)
           {
            string Name=ObjectName(0,i);
            int size=ArraySize(Symbols);
            for(int x=0; x<size; x++)
              {
               if(use[x])
                 {
                  string symbol=Symbols[x];
                  if(StringFind(Name,Perfix,0)!=-1)
                    {
                     string value=ObjectGetString(0,Name,OBJPROP_TEXT);
                     if(StringFind(value,symbol,0)!=-1)
                       {
                        int len=StringLen(value);
                        string n= StringSubstr(value,len-2,WHOLE_ARRAY);
                        datetime time=ObjectGetInteger(0,Name,OBJPROP_TIME);

                        if(n=="+1"&&lastSignal[x]<time)
                          {
                           trade[x].Position(TYPE_POSITION_BUY,lot[x],stopLoss,takeprofit,SLTP_PIPS,30,Symbols[x]);
                           lastSignal[x]=time;
                          }
                        if(n=="-1"&&lastSignal[x]<time)
                          {
                           trade[x].Position(TYPE_POSITION_SELL,lot[x],stopLoss,takeprofit,SLTP_PIPS,30,Symbols[x]);
                           lastSignal[x]=time;
                          }
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
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //-- CloseClick
      if(sparam==OBJPREFIX+"CLOSE")
        {

         //-- CloseOrder(s)
         int size=ArraySize(Symbols);
         for(int z=0; z<size; z++)
           {
            if(use[z])
              {
               int t= Position[z].GroupTotal();
               if(t>0)
                  Position[z].GroupCloseAll(30);
              }
           }
         //-- ResetButton
         Sleep(100);
         ObjectSetInteger(0,OBJPREFIX+"CLOSE",OBJPROP_STATE,false);//SetObject
        }
      //-- Stop Click
      if(sparam==OBJPREFIX+"Stop")
        {
         //-- Stop Ea
         if(StopEA)
           {
            StopEA=false;
            ObjectDelete(0,OBJPREFIX+"Stop"); 
            ButtonCreate(0,OBJPREFIX+"Stop",0,50,50,100,25,CORNER_LEFT_UPPER,"Play EA","Trebuchet MS",10,C'59,41,40',StopButton_Color,StopButton_Color,false,false,false,true,1,"\n");
           }
         else
            if(!StopEA)
              {
               StopEA=true;
               ObjectDelete(0,OBJPREFIX+"Stop");              
               ButtonCreate(0,OBJPREFIX+"Stop",0,50,50,100,25,CORNER_LEFT_UPPER,"Stop EA","Trebuchet MS",10,C'59,41,40',StopButton_Color,StopButton_Color,false,false,false,true,1,"\n");

              }
         //-- ResetButton
         Sleep(100);
         ObjectSetInteger(0,OBJPREFIX+"Stop",OBJPROP_STATE,false);//SetObject
        }
     }
  }
//+------
//+------------------------------------------------------------------+
//| OnTester                                                         |
//+------------------------------------------------------------------+
void _OnTester()
  {

//-- CloseClick
   if(ObjectFind(0,OBJPREFIX+"CLOSE")==0)//ObjectIsPresent
     {
      if(ObjectGetInteger(0,OBJPREFIX+"CLOSE",OBJPROP_STATE))
        {
         //-- CloseOrder(s)
         int size=ArraySize(Symbols);
         for(int z=0; z<size; z++)
           {
            if(use[z])
              {
               int t= Position[z].GroupTotal();
               if(t>0)
                  Position[z].GroupCloseAll(30);
              }
           }
         ObjectSetInteger(0,OBJPREFIX+"CLOSE",OBJPROP_STATE,false);//ResetButton
        }
     }

//-- Stop Click
   if(ObjectFind(0,OBJPREFIX+"Stop")==0)//ObjectIsPresent
     {
      if(ObjectGetInteger(0,OBJPREFIX+"Stop",OBJPROP_STATE))
        {
         //-- Stop Ea
         if(StopEA)
           {
            StopEA=false;
            ObjectSetString(0,OBJPREFIX+"Stop",OBJPROP_TEXT,"Play EA");
           }
         if(!StopEA)
           {
            StopEA=true;
            ObjectSetString(0,OBJPREFIX+"Stop",OBJPROP_TEXT,"Stop EA");
           }
         ObjectSetInteger(0,OBJPREFIX+"Stop",OBJPROP_STATE,false);//ResetButton
        }
     }

//---
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---

  }
//+------------------------------------------------------------------+
bool day_trade()
  {
   if(Trade_sunday == true&& DayOfWeek() ==0)
      return (true);
   if(Trade_monday  == true&& DayOfWeek() ==1)
      return (true);
   if(Trade_tuseday  == true&& DayOfWeek() ==2)
      return (true);
   if(Trade_wednisday  == true&& DayOfWeek() ==3)
      return (true);
   if(Trade_Thursday  == true&& DayOfWeek() ==4)
      return (true);
   if(Trade_friday  == true&& DayOfWeek() ==5)
      return (true);

   if(Trade_sunday == false&& DayOfWeek() ==0)
      return (false);
   if(Trade_monday  == false&& DayOfWeek() ==1)
      return (false);
   if(Trade_tuseday  == false&& DayOfWeek() ==2)
      return (false);
   if(Trade_wednisday  == false&& DayOfWeek() ==3)
      return (false);
   if(Trade_Thursday  == false&& DayOfWeek() ==4)
      return (false);
   if(Trade_friday  == false&& DayOfWeek() ==5)
      return (false);

   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
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
//|                                                                  |
//+------------------------------------------------------------------+
//------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Create the button                                                |
//+------------------------------------------------------------------+
bool ButtonCreate(const long              chart_ID=0,               // chart's ID
                  const string            name="Button",            // button name
                  const int               sub_window=0,             // subwindow index
                  const int               x=0,                      // X coordinate
                  const int               y=0,                      // Y coordinate
                  const int               width=50,                 // button width
                  const int               height=18,                // button height
                  const ENUM_BASE_CORNER  corner=CORNER_LEFT_UPPER, // chart corner for anchoring
                  const string            text="Button",            // text
                  const string            font="Arial",             // font
                  const int               font_size=10,             // font size
                  const color             clr=clrBlack,             // text color
                  const color             back_clr=C'236,233,216',  // background color
                  const color             border_clr=clrNONE,       // border color
                  const bool              state=false,              // pressed/released
                  const bool              back=false,               // in the background
                  const bool              selection=false,          // highlight to move
                  const bool              hidden=true,              // hidden in the object list
                  const long              z_order=0,                // priority for mouse click
                  const string            tooltip="\n")             // tooltip for mouse hover
  {
//-- reset the error value
   ResetLastError();
//--
   if(ObjectFind(chart_ID,name)!=0)
     {
      if(!ObjectCreate(chart_ID,name,OBJ_BUTTON,sub_window,0,0))
        {
         Print(__FUNCTION__,
               ": failed to create the button! Error code = ",_LastError);
         return(false);
        }
      //-- SetObjects
      ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
      ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
      ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
      ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
      ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
      ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
      ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
      ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
      ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
      ObjectSetInteger(chart_ID,name,OBJPROP_STATE,state);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
      ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
      ObjectSetString(chart_ID,name,OBJPROP_TOOLTIP,tooltip);
     }
//--
   return(true);
  }
//+------------------------------------------------------------------+
