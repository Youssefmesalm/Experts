//+------------------------------------------------------------------+
//|                                                    functipns.mqh |
//|                                    Copyright 2021,Yousuf Mesalm. |
//|                           https://www.mql5.com/en/users/20163440 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021,Yousuf Mesalm."
#property link      "https://www.mql5.com/en/users/20163440"
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HideChartCandles()
  {
   ChartSetInteger(0, CHART_SHOW_GRID, false);
   ChartSetInteger(0, CHART_SHOW_VOLUMES, false);
   ChartSetInteger(0, CHART_SHOW_BID_LINE, false);
   ChartSetInteger(0, CHART_COLOR_CHART_UP, clrNONE);
   ChartSetInteger(0, CHART_COLOR_CHART_DOWN, clrNONE);
   ChartSetInteger(0, CHART_COLOR_CHART_LINE, clrNONE);
   ChartSetInteger(0, CHART_COLOR_CANDLE_BULL, clrNONE);
   ChartSetInteger(0, CHART_COLOR_CANDLE_BEAR, clrNONE);
   ChartSetInteger(0, CHART_COLOR_BID, clrNONE);
   ChartSetInteger(0, CHART_COLOR_ASK, clrNONE);
   ChartSetInteger(0, CHART_COLOR_BID, clrNONE);
   ChartSetInteger(0, CHART_COLOR_BID, clrNONE);
   ChartSetInteger(0, CHART_COLOR_LAST, clrNONE);
   ChartSetInteger(0, CHART_COLOR_STOP_LEVEL, clrNONE);
   ChartSetInteger(0, CHART_COLOR_BACKGROUND, clrNONE);
   ChartSetInteger(0, CHART_COLOR_FOREGROUND, clrNONE);
  }
  
    }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ENUM_TIMEFRAMES getTimeFrame(int i)
  {
   switch(i)
     {
      case 0:
         return(PERIOD_M1);
      case 1:
         return(PERIOD_M5);
      case 2:
         return(PERIOD_M15);
      case 3:
         return(PERIOD_M30);
      case 4:
         return(PERIOD_H1);
      case 5:
         return(PERIOD_H4);
      case 6:
         return(PERIOD_D1);
      case 7:
         return(PERIOD_W1);
      case 8:
         return(PERIOD_MN1);
      default:
         return(PERIOD_CURRENT);
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string TimeFrameString(int TF)
  {
   switch(TF)
     {
      case 1:
         return("M1");
      case 5:
         return("M5");
      case 15:
         return("M15");
      case 30:
         return("M30");
      case 60:
         return("H1");
      case 240:
         return("H4");
      case 1440:
         return("D1");
      case 10080:
         return("W1");
      case 43200:
         return("MN");
     }
   return("current");
  }

