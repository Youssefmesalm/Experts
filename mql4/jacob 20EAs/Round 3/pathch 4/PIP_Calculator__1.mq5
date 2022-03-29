

//+------------------------------------------------------------------+
//|                                           PipValueCalculator.mq4 |
//|                           Copyright 2015, Stuart Browne (Filter) |
//|                             https://www.mql5.com/en/users/filter |
//+------------------------------------------------------------------+

// Version History
// ---------------
// V1.01 - corrected formula for calculating points and pips
// V1.02 - further refinement to calculation for clarity

#property copyright    "Open Source 2015, by Stuart Browne (Filter)"
#property link         "https://www.mql5.com/en/users/filter"
#property version      "1.02"
#property description  "Provided free of charge and free of copyright to the MQL community by Filter\n"
#property description  "A very simple calculator for you to calculate the value of 1 point and 1 pip in your"
#property description  "base (deposit) currency.\n"
#property description  "Either use the calculator 'as is' for a handy tool or adapt the main formula for use"
#property description  "in your own EA money management strategies."
#property strict
#property indicator_chart_window
#property indicator_plots 0



#define MODE_TICKVALUE 
#define MODE_TICKSIZE 
#define MODE_DIGITS


input double LotSize=1;   // Lot Size
double point;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+

int OnInit()
  {
// Broker digits
   
    point=_Point;
   
   double Digits=_Digits;
   if((_Digits==3) || (_Digits==5))
     {
      point*=10;
     }

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator de-init function                         |
//+------------------------------------------------------------------+  

void OnDeinit(const int reason)
  {
   Comment("");   // Cleanup

   Print(__FUNCTION__,"_UninitReason = ",getUninitReasonText(_UninitReason));
   return;
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
                const int &spread[]
                )
  {
//---
   string CommentString="";
 
   string DepositCurrency=AccountInfoString(ACCOUNT_CURRENCY);
  
   double PipValue=((((SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE))*point)/(SymbolInfoDouble(Symbol(),SYMBOL_TRADE_TICK_SIZE)))*LotSize);
   double PointValue=PipValue/10;
   

   CommentString+="\n" + "Your deposit currency: " + DepositCurrency + "\n";
   CommentString+="Lot size requested: " + DoubleToString(LotSize,2) + "\n";
   CommentString+="-----------------------------------------------------------------\n";
   CommentString+="Value of one point (" + Symbol() + "):  $" + DepositCurrency + " " + DoubleToString(PointValue,3) + "\n";
   CommentString+="Value of one pip    (" + Symbol() + ") : $" + DepositCurrency + " " + DoubleToString(PipValue,3) + "\n";
   CommentString+="-----------------------------------------------------------------\n";

   Comment(CommentString);

//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| Custom functions                                                 |
//+------------------------------------------------------------------+

string getUninitReasonText(int reasonCode) // Return reason for De-init function
  {
   string text="";

   switch(reasonCode)
     {
      case REASON_ACCOUNT:
         text="Account was changed";break;
      case REASON_CHARTCHANGE:
         text="Symbol or timeframe was changed";break;
      case REASON_CHARTCLOSE:
         text="Chart was closed";break;
      case REASON_PARAMETERS:
         text="Input-parameter was changed";break;
      case REASON_RECOMPILE:
         text="Program "+__FILE__+" was recompiled";break;
      case REASON_REMOVE:
         text="Program "+__FILE__+" was removed from chart";break;
      case REASON_TEMPLATE:
         text="New template was applied to chart";break;
      default:text="Another reason";
     }

   return text;
  }
//+------------------------------------------------------------------+
