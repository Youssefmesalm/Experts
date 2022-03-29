//+------------------------------------------------------------------+
//|                                              Market profile .mq4 |
//|                                                         batttoot |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "batttoot"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property description "Displays the Market Profile indicator for daily, weekly, or monthly trading sessions."
#property description "Daily - should be attached to M5, M15, or M30 timeframes. M30 is recommended."
#property description "Weekly - should be attached to M30, H1, or H4 timeframes. H1 is recommended."
#property description "Weeks start on Sunday."
#property description "Monthly - should be attached to H1, H4, or D1 timeframes. H4 is recommended."
#property description ""
#property description "Designed for standard currency pairs. May work incorrectly with very exotic pairs, CFDs or commodities."
#include <CsvReader.mqh>
#include  <MQL_Easy\Utilities\Utilities.mqh>
#property indicator_chart_window
#property indicator_plots 0
enum color_scheme
  {
   Blue_to_Red,
   Red_to_Green,
   Green_to_Blue
  };

enum Profile_Mode
  {
   Ticks,
   bars,
   Sessions,
  };

enum session_period
  {
   Daily,
   Weekly,
   Monthly
  };

enum sessions_to_draw_rays
  {
   None,
   Previous,
   Current,
   PreviousCurrent,    // Previous & Current
   AllPrevious,        // All Previous
   All
  };

input Profile_Mode Mode=Ticks;
input session_period Session   = Daily;
input int       SessionsToCount    = 2; // SessionsToCount - Number of sessions for which to count the Market Profile
input int Tick_Numbers=500;  // Number of tick for each Profile
sinput string hint="the greater the timeframe , the greater the TickFactor";
input int TicksFactor=50;
input bool ShowNumbersofTicks=false; // Show Numbers of ticks for each Pip
input int number_ticks_FS=10; //Font size for ticks numbers
input int Profile_start_Bar=5; // bars distance from current bar to start drawing profiles
input int BarsToCounnt=50;
input color_scheme ColorScheme = Red_to_Green;
input color     MedianColor    = clrWhite;
input color     ValueAreaColor = clrWhite;


int DigitsM;               // Amount of digits normalized for standard 4 and 2 digits after dot
datetime StartDate;        // Will hold either StartFromDate or Time[0]
double onetick;            // One normalized pip
bool FirstRunDone = false; // If true - OnCalculate() was already executed once
string Suffix = "";        // Will store object name suffix depending on timeframe.

double CurrentPrice=0;
double oneTickforTicks;
datetime sessionStartForTicks=0;
int numberofticksforbar[],TicksCounterFactor=0,sessionCounter=0,barsCounter=0;
//Arrays
double PipPrices[];
int TicksCounter[];
int NumberofDosforPip[];


int number_of_dots[];
int T_handle;
bool first=true;
bool fileopened=false;
bool firstsessions=true;
//objects
CCsvReader TicksData;

//param
MqlParam TicksData_column_desc[]=
  {
     { TYPE_DATETIME,  0, 0.0, "M1" },       // 1. field
     { TYPE_DATETIME,  0, 0.0, "M5" },       // 2. field
     { TYPE_DATETIME,  0, 0.0, "M15" },       // 3. field
     { TYPE_DATETIME,  0, 0.0, "M30" },       // 4. field
     { TYPE_DATETIME,  0, 0.0, "H1" },       // 5. field
     { TYPE_DATETIME,  0, 0.0, "H4" },       // 6. field
     { TYPE_DATETIME,  0, 0.0, "D1" },       // 7. field
     { TYPE_DATETIME,  0, 0.0, "W1" },       // 8. field
     { TYPE_DATETIME,  0, 0.0, "MN" },       // 9. field
     { TYPE_DOUBLE,   0, 0.0, "Bid" },          // 10. field
     { TYPE_DOUBLE,   0, 0.0, "Ask" },         // 11. field
     { TYPE_DOUBLE,   0, 0.0, "Spread" }         // 12. field
  };

// Here the values of one line will be returned
MqlParam TicksData_Line[];
CUtilities tool;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
void OnInit()
  {
//--- create a timer with a 1 second period
   EventSetTimer(1);

   if(Mode==Sessions)
     {
      if(Session == Daily)
        {
         Suffix = "_D";
         if((Period() != PERIOD_M5) && (Period() != PERIOD_M15) && (Period() != PERIOD_M30))
           {
            Alert("Timeframe should be set to M30, M15, or M5 for Daily session.");
            return;
           }
        }
      else
         if(Session == Weekly)
           {
            Suffix = "_W";
            if((Period() != PERIOD_M30) && (Period() != PERIOD_H1) && (Period() != PERIOD_H4))
              {
               Alert("Timeframe should be set to M30, H1, or H4 for Weekly session.");
               return;
              }
           }
         else
            if(Session == Monthly)
              {
               Suffix = "_M";
               if((Period() != PERIOD_H1) && (Period() != PERIOD_H4) && (Period() != PERIOD_D1))
                 {
                  Alert("Timeframe should be set to H1, H4, or D1 for Monthly session.");
                  return;
                 }
              }
     }
   if(Mode==Ticks)
     {
      if(TicksFactor<50)
        {
         Alert("TicksFactor must be above 50");

        }
      if(TicksFactor>=50&&TicksFactor<100&&Period()>60)
        {
         Alert("It's recommended to put TicksFactor above 100");
        }
      if(TicksFactor<100&&Period()>240)
        {
         Alert("It's recommended to put TicksFactor above 300");
        }
     }

   IndicatorShortName("MarketProfile " + EnumToString(Session));

// Normalizing the digits to standard 4- and 2-digit quotes.
   if(Digits == 5)
      DigitsM = 4;
   else
      if(Digits == 3)
         DigitsM = 2;
      else
         DigitsM = Digits;



   ArrayResize(TicksCounter,1);
   ArrayResize(PipPrices,1);
   ArrayResize(numberofticksforbar,1);
   PipPrices[0]=0;
   TicksCounter[0]=0;
   TicksCounterFactor=0;
   sessionCounter=0;
   onetick = NormalizeDouble(1 / (MathPow(10, DigitsM)), DigitsM);
   oneTickforTicks=Point*10;
   barsCounter=0;

  }

//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
// Delete all rectangles with set prefix.
   ObjectsDeleteAll(0, "MP" + Suffix, EMPTY, OBJ_RECTANGLE);
   ObjectsDeleteAll(0, "Median" + Suffix, EMPTY, OBJ_RECTANGLE);
   ObjectsDeleteAll(0, "Value Area" + Suffix, EMPTY, OBJ_RECTANGLE);
   ObjectsDeleteAll(-1);

//--- destroy the timer after completing the work
   EventKillTimer();
  }


//+------------------------------------------------------------------+
//|     Timer Event                                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   if(first)
     {

      int resultread=0;

      TicksData.HasHeader(true);
      TicksData.FieldDesc(TicksData_column_desc);
      TicksData.Open(Symbol()+".csv", FILE_READ);
      //---
      // If the file has a header skip the header
      if(TicksData.HasHeader())
        {
         resultread=TicksData.ReadLine();
        }

      do
        {
         resultread=TicksData.ReadLine(TicksData_Line);
         if(resultread>=0)
           {
            if(resultread<12)
              {
               printf("Not 12 fields in Ticks data line.");
              }
            else
              {
               string M1             = TicksData_Line[0].string_value;
               string M5             = TicksData_Line[1].string_value;
               string M15             = TicksData_Line[2].string_value;
               string M30             = TicksData_Line[3].string_value;
               string H1             = TicksData_Line[4].string_value;
               string H4             = TicksData_Line[5].string_value;
               string D1             = TicksData_Line[6].string_value;
               string W1             = TicksData_Line[7].string_value;
               string MN             = TicksData_Line[8].string_value;
               double bid                = TicksData_Line[9].double_value;
               double ask              = TicksData_Line[10].double_value;
               double Spread              = TicksData_Line[11].double_value;
               int current_tf=Period();
               datetime SSB=0;


               switch(current_tf)
                 {
                  case 1:
                     SSB=StringToTime(M1);

                     break;
                  case 5:
                     SSB=StringToTime(M5);

                     break;
                  case 15:
                     SSB=StringToTime(M15);

                     break;
                  case 30:
                     SSB=StringToTime(M30);

                     break;
                  case 60:
                     SSB=StringToTime(H1);

                     break;
                  case 240:
                     SSB=StringToTime(H4);

                     break;
                  case 1440:
                     SSB=StringToTime(D1);

                     break;
                  case 10080:
                     SSB=StringToTime(W1);
                     break;
                  case 34200:
                     SSB=StringToTime(MN);

                     break;
                 }
               if(firstsessions)
                 {
                  sessionStartForTicks=SSB;
                  firstsessions=false;
                 }

               DrawTickProfle(bid,SSB);
              }
           }
        }
      while(resultread>0 && !IsStopped());
      //---
      TicksData.Close();
      first=false;
     }
   DrawTickProfle(Bid,Time[Profile_start_Bar]);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawTickProfle(double bid,datetime sessionStart)
  {
   if(Mode==Sessions)
     {
      if(Session == Daily)
        {
         if((Period() != PERIOD_M5) && (Period() != PERIOD_M15) && (Period() != PERIOD_M30))
           {
            Print("Timeframe should be set to M30, M15, or M5 for Daily session.");
            return ;
           }
        }
      else
         if(Session == Weekly)
           {
            if((Period() != PERIOD_M30) && (Period() != PERIOD_H1) && (Period() != PERIOD_H4))
              {
               Print("Timeframe should be set to M30, H1, or H4 for Weekly session.");
               return ;
              }
           }
         else
            if(Session == Monthly)
              {
               if((Period() != PERIOD_H1) && (Period() != PERIOD_H4) && (Period() != PERIOD_D1))
                 {
                  Print("Timeframe should be set to H1, H4, or D1 for Monthly session.");
                  return ;
                 }
              }
     }


   double price=NormalizeDouble(bid,DigitsM);
   if(CurrentPrice!=bid)
     {

      //Reset tick  counter
      if((TicksCounterFactor==Tick_Numbers&&Mode==Ticks)||(Mode==Sessions&&sessionCounter==SessionsToCount)||(Mode==bars&&BarsToCounnt==barsCounter))
        {

         TicksCounterFactor=0;
         ArrayFree(PipPrices);
         ArrayFree(TicksCounter);
         ArrayFree(NumberofDosforPip);
         ArrayResize(TicksCounter,1);
         ArrayResize(PipPrices,1);
         ArrayResize(NumberofDosforPip,1);
         PipPrices[0]=price;
         TicksCounter[0]=0;
         NumberofDosforPip[0]=0;
         numberofticksforbar[0]=0;
         sessionCounter=0;
         barsCounter=0;
         sessionStartForTicks=sessionStart;

        }
      if(Mode==Sessions)
        {
         if(Session==Daily)
           {
            if(tool.IsNewBar(PERIOD_D1))
              {
               sessionCounter++;
              }
           }
         else
            if(Session==Weekly)
              {
               if(tool.IsNewBar(PERIOD_W1))
                 {
                  sessionCounter++;
                 }
              }
            else
               if(Session==Monthly)
                 {
                  if(tool.IsNewBar(PERIOD_MN1))
                    {
                     sessionCounter++;
                    }
                 }
        }
      if(Mode==bars)
        {
         if(tool.IsNewBar(PERIOD_CURRENT))
           {
            barsCounter++;
           }

        }



      if(ArraySize(PipPrices)==0)
        {
         ArrayResize(PipPrices,1);
         PipPrices[0]=price;
         ArrayResize(TicksCounter,1);
         ArrayResize(NumberofDosforPip,1);
         ArrayResize(numberofticksforbar,1);
         numberofticksforbar[0]=0;
         TicksCounter[0]=1;
         NumberofDosforPip[0]=0;

        }
      int startbar=iBarShift(Symbol(),Period(),sessionStartForTicks);
      bool tickExist=false;
      for(int i=0; i<ArraySize(PipPrices); i++)
        {

         if(price==PipPrices[i])
           {
            if(TicksCounter[i]==1)
              {
               PutDot(PipPrices[i], startbar, NumberofDosforPip[i],NumberofDosforPip[i]-startbar,oneTickforTicks);
               NumberofDosforPip[i]++;
               Comment(NumberofDosforPip[i]);
              }

            if(ShowNumbersofTicks)
              {
               if(startbar-NumberofDosforPip[i]-1>1)
                 {
                  ObjectDelete(0,TimeToString(Time[startbar-1],TIME_DATE)+TimeToString(Time[startbar-1],TIME_MINUTES)+TimeToString(Time[startbar-1],TIME_SECONDS)+DoubleToString(price,DigitsM));
                  TextCreate(0,TimeToString(Time[startbar-1],TIME_DATE)+TimeToString(Time[startbar-1],TIME_MINUTES)+TimeToString(Time[startbar-1],TIME_SECONDS)+DoubleToString(price,DigitsM),0,Time[startbar-NumberofDosforPip[i]-1],price+10*Point,number_ticks_FS,IntegerToString(numberofticksforbar[i]));
                 }
               else
                 {
                  Alert("Please increase tick factor or decrease Ticks Numbers to work well");
                  return ;

                 }

              }

            tickExist=true;
            TicksCounter[i]++;
            numberofticksforbar[i]++;
           }
         if(TicksCounter[i]==TicksFactor)
           {
            TicksCounterFactor++;

            TicksCounter[i]=0;
           }


        }
      if(!tickExist)
        {
         int PipPricesSize=ArraySize(PipPrices);
         ArrayResize(PipPrices,PipPricesSize+1);
         PipPrices[PipPricesSize]=price;
         ArrayResize(TicksCounter,PipPricesSize+1);
         TicksCounter[PipPricesSize]=1;
         ArrayResize(NumberofDosforPip,PipPricesSize+1);
         NumberofDosforPip[PipPricesSize]=0;
         ArrayResize(numberofticksforbar,PipPricesSize+1);
         numberofticksforbar[PipPricesSize]=1;
         if(ShowNumbersofTicks)
            if(ObjectFind(0,TimeToString(Time[startbar-1],TIME_DATE)+TimeToString(Time[startbar-1],TIME_MINUTES)+TimeToString(Time[startbar-1],TIME_SECONDS)+DoubleToString(price,DigitsM)))
              {
               ObjectDelete(0,TimeToString(Time[startbar-1],TIME_DATE)+TimeToString(Time[startbar-1],TIME_MINUTES)+TimeToString(Time[startbar-1],TIME_SECONDS)+DoubleToString(price,DigitsM));
               TextCreate(0,TimeToString(Time[startbar-1],TIME_DATE)+TimeToString(Time[startbar-1],TIME_MINUTES)+TimeToString(Time[startbar-1],TIME_SECONDS)+DoubleToString(price,DigitsM),0,Time[startbar-NumberofDosforPip[PipPricesSize-1]-1],price+10*Point,number_ticks_FS,IntegerToString(numberofticksforbar[PipPricesSize]));
              }
            else
              {
               TextCreate(0,TimeToString(Time[startbar-1],TIME_DATE)+TimeToString(Time[startbar-1],TIME_MINUTES)+TimeToString(Time[startbar-1],TIME_SECONDS)+DoubleToString(price,DigitsM),0,Time[startbar-NumberofDosforPip[PipPricesSize-1]-1],price+10*Point,number_ticks_FS,IntegerToString(numberofticksforbar[PipPricesSize]));

              }
        }



      CurrentPrice=bid;

     }

  }
//+------------------------------------------------------------------+
//| Finds the session's starting bar number for any given bar number.|
//| n - bar number for which to find starting bar.                   |
//+------------------------------------------------------------------+
int FindSessionStart(int n)
  {
   if(Session == Daily)
      return(FindDayStart(n));
   else
      if(Session == Weekly)
         return(FindWeekStart(n));
      else
         if(Session == Monthly)
            return(FindMonthStart(n));

   return(-1);
  }

//+------------------------------------------------------------------+
//| Finds the day's starting bar number for any given bar number.    |
//| n - bar number for which to find starting bar.                   |
//+------------------------------------------------------------------+
int FindDayStart(int n)
  {
   int x = n;

   while((x < Bars) && (TimeDayOfYear(Time[n]) == TimeDayOfYear(Time[x])))
      x++;

   return(x - 1);
  }

//+------------------------------------------------------------------+
//| Finds the week's starting bar number for any given bar number.   |
//| n - bar number for which to find starting bar.                   |
//+------------------------------------------------------------------+
int FindWeekStart(int n)
  {
   int x = n;
   int day_of_week = TimeDayOfWeek(Time[n]);
   while((x < Bars) && (SameWeek(Time[n], Time[x])))
      x++;

   return(x - 1);
  }

//+------------------------------------------------------------------+
//| Finds the month's starting bar number for any given bar number.  |
//| n - bar number for which to find starting bar.                   |
//+------------------------------------------------------------------+
int FindMonthStart(int n)
  {
   int x = n;

   while((x < Bars) && (TimeMonth(Time[n]) == TimeMonth(Time[x])))
      x++;

   return(x - 1);
  }

//+------------------------------------------------------------------+
//| Finds the session's end bar by the session's date.               |
//+------------------------------------------------------------------+
int FindSessionEndByDate(datetime date)
  {
   if(Session == Daily)
      return(FindDayEndByDate(date));
   else
      if(Session == Weekly)
         return(FindWeekEndByDate(date));
      else
         if(Session == Monthly)
            return(FindMonthEndByDate(date));

   return(-1);
  }

//+------------------------------------------------------------------+
//| Finds the day's end bar by the day's date.                       |
//+------------------------------------------------------------------+
int FindDayEndByDate(datetime date)
  {
   int x = 0;

   while((x < Bars) && (TimeDayOfYear(date) < TimeDayOfYear(Time[x])))
      x++;

   return(x);
  }

//+------------------------------------------------------------------+
//| Finds the week's end bar by the week's date.                     |
//+------------------------------------------------------------------+
int FindWeekEndByDate(datetime date)
  {
   int x = 0;

   while((x < Bars) && (SameWeek(date, Time[x]) != true))
      x++;

   return(x);
  }

//+------------------------------------------------------------------+
//| Finds the month's end bar by the month's date.                   |
//+------------------------------------------------------------------+
int FindMonthEndByDate(datetime date)
  {
   int x = 0;

   while((x < Bars) && (SameMonth(date, Time[x]) != true))
      x++;

   return(x);
  }

//+------------------------------------------------------------------+
//| Check if two dates are in the same week.                         |
//+------------------------------------------------------------------+
int SameWeek(datetime date1, datetime date2)
  {
   int seconds_from_start = TimeDayOfWeek(date1) * 24 * 3600 + TimeHour(date1) * 3600 + TimeMinute(date1) * 60 + TimeSeconds(date1);

   if(date1 == date2)
      return(true);
   else
      if(date2 < date1)
        {
         if(date1 - date2 <= seconds_from_start)
            return(true);
        }
      // 604800 - seconds in a week.
      else
         if(date2 - date1 < 604800 - seconds_from_start)
            return(true);

   return(false);
  }

//+------------------------------------------------------------------+
//| Check if two dates are in the same month.                        |
//+------------------------------------------------------------------+
int SameMonth(datetime date1, datetime date2)
  {
   if((TimeMonth(date1) == TimeMonth(date2)) && (TimeYear(date1) == TimeYear(date2)))
      return(true);
   return(false);
  }

//+------------------------------------------------------------------+
//| Puts a dot (rectangle) at a given position and color.            |
//| price and time are coordinates.                                  |
//| range is for the second coordinate.                              |
//| bar is to determine the color of the dot.                        |
//+------------------------------------------------------------------+
bool PutDot(double price, int start_bar, int range, int bar,double tick)
  {

   string LastName = " " + TimeToString(Time[start_bar - range]) + " " + DoubleToString(price, 4);
   if(ObjectFind("MP" + Suffix + LastName) >= 0)
      return false;

// Protection from 'Array out of range' error.
   if(start_bar - (range + 1) < 0)
      return false;
   if(start_bar-range>1)
     {
      ObjectCreate("MP" + Suffix + LastName, OBJ_RECTANGLE, 0, Time[start_bar - range], price, Time[start_bar - (range + 1)], price + tick);
     }
   else
     {
      Alert("Please increase tick factor or decrease Ticks Numbers to work well");
      return false;
     }
// Color switching depending on the distance of the bar from the session's beginning.
   int colour, offset1, offset2;
   switch(ColorScheme)
     {
      case Blue_to_Red:
         colour = clrDarkBlue;
         offset1 = 0x020000;
         offset2 = 0x000002;
         break;
      case Red_to_Green:
         colour = clrDarkRed;
         offset1 = 0x000002;
         offset2 = 0x000200;
         break;
      case Green_to_Blue:
         colour = clrDarkGreen;
         offset1 = 0x000200;
         offset2 = 0x020000;
         break;
      default:
         colour = clrDarkBlue;
         offset1 = 0x020000;
         offset2 = 0x000002;
         break;
     }
   if(Mode==Sessions)
     {
      if(((Session == Daily) && (Period() == PERIOD_M30)) || ((Session == Weekly) && (Period() == PERIOD_H4)) || ((Session == Monthly) && (Period() == PERIOD_D1)))
        {
         colour += bar * offset1;
         colour -= bar * offset2;
        }
      else
         if(((Session == Daily) && (Period() == PERIOD_M15)) || ((Session == Weekly) && (Period() == PERIOD_H1)) || ((Session == Monthly) && (Period() == PERIOD_H4)))
           {
            colour += bar * (offset1 / 2);
            colour -= bar * (offset2 / 2);
           }
         else
            if(((Session == Daily) && (Period() == PERIOD_M5)) || ((Session == Weekly) && (Period() == PERIOD_M30)) || ((Session == Monthly) && (Period() == PERIOD_H1)))
              {
               colour += (bar / 3)
                         * (offset1 / 2);
               colour -= (bar / 3) * (offset2 / 2);
              }
     }

   else
      if(Mode==Ticks||Mode==bars)
        {
         if(Period() == PERIOD_M30|| Period() == PERIOD_H4 || Period() == PERIOD_D1)
           {
            colour += bar * offset1;
            colour -= bar * offset2;
           }
         else
            if(Period() == PERIOD_M15 ||Period() == PERIOD_H1)
              {
               colour += bar * (offset1 / 2);
               colour -= bar * (offset2 / 2);
              }
            else
               if(Period() == PERIOD_M5)
                 {
                  colour += (bar / 3)
                            * (offset1 / 2);
                  colour -= (bar / 3) * (offset2 / 2);
                 }

        }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   ObjectSet("MP" + Suffix + LastName, OBJPROP_COLOR, colour);
// Fills rectangle.
   ObjectSet("MP" + Suffix + LastName, OBJPROP_BACK, true);
   ObjectSet("MP" + Suffix + LastName, OBJPROP_SELECTABLE, false);
   return true;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Creating Text object                                             |
//+------------------------------------------------------------------+
bool TextCreate(const long              chart_ID=0,               // chart's ID
                const string            name="Text",              // object name
                const int               sub_window=0,             // subwindow index
                datetime                time=0,                   // anchor point time
                double                  price=0,                  // anchor point price
                const int               font_size=10,             // font size
                const string            text="Text",              // the text itself
                const string            font="Arial",             // font
                const color             clr=clrBlue,               // color
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
//+------------------------------------------------------------------+
//| Check anchor point values and set default values                 |
//| for empty ones                                                   |
//+------------------------------------------------------------------+
void ChangeTextEmptyPoint(datetime &time,double &price)
  {
//--- if the point's time is not set, it will be on the current bar
   if(!time)
      time=Time[0];
//--- if the point's price is not set, it will have current bar value
   if(!price)
      price=High[0];
  }
//+------------------------------------------------------------------+
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
