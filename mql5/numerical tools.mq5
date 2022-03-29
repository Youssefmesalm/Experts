//+------------------------------------------------------------------+
//|                                              numerical tools.mq5 |
//|                                    Copyright 2021,Yousuf Mesalm. |
//|                           https://www.mql5.com/en/users/20163440 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021,Yousuf Mesalm."
#property link      "https://www.mql5.com/en/users/20163440"
#property version   "1.00"
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
   
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void RationalNumbers(int num, int n, double& arr[])
  {
   ArrayResize(arr, n, n);
   for(int i = 1; i <= n; i++)
     {
      double result = ((double)num / (double) i) * 10000;
      arr[i - 1] = result;
      CreateHline(Hline, "Hline" + (string) i, result);
     }
  }
//+------------------------------------------------------------------+
bool CreateHline(CChartObjectHLine &line, string name, double price)
  {
   if(!line.Create(0, name, 0, price))
     {
      return false;
     }
   return true;
  }