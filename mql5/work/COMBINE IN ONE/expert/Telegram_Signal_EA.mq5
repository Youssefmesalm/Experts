
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict

#include <Telegram.mqh>

//--- input parameters
input string InpChannelName = "EurusdMaster"; //Channel Name
input string InpToken = "2101168788:AAElaxmMYxN-dOZcIAOjErtRnt3p_TaFdBY"; //Token


//--- global variables
CCustomBot bot;
int handle1;
datetime time_signal = 0;
bool checked;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   time_signal = 0;
   bot.Token(InpToken);
   handle1 = iCustom(NULL, 0, "Arlen’s Premium Box & Arrow Signals"
                    );
   if(handle1 == INVALID_HANDLE)
      return(INIT_FAILED);
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   if(reason == REASON_PARAMETERS ||
      reason == REASON_RECOMPILE ||
      reason == REASON_ACCOUNT)
     {
      checked = false;
     }
//--- delete the indicator
  }

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   if(!checked)
     {
      if(StringLen(InpChannelName) == 0)
        {
         Print("Error: Channel name is empty");
         Sleep(10000);
         return;
        }
      int result = bot.GetMe();
      if(result == 0)
        {
         Print("Bot name: ", bot.Name());
         checked = true;
        }
      else
        {
         Print("Error: ", GetErrorDescription(result));
         Sleep(10000);
         return;
        }
     }
   datetime time = iTime(NULL, 0, 0);
//--- check the signal on each bar
   if(time_signal != time)
     {
      //--- first calc
      if(time_signal == 0)
        {
         time_signal = time;
         return ;
        }
      double SellHull[1] = {0};
      double BuyHull[1] = {0};
      double SellDiamond[1] = {0};
      double BuyDiamond[1] = {0};
      Print(SellHull[0]);
      if(CopyBuffer(handle1, 62, 0, 1, BuyHull) != 1)
         return;
      if(CopyBuffer(handle1, 63, 0, 1, SellHull) != 1)
         return;
      if(CopyBuffer(handle1, 64, 0, 1, BuyDiamond) != 1)
         return;
      if(CopyBuffer(handle1, 65, 0, 1, SellDiamond) != 1)
         return;
      time_signal = time;
      //--- Send signal BUY
      if(BuyHull[0] != 0)
        {
         string msg = "Buy signal MA1 Cross MA3";
         int res = bot.SendMessage(InpChannelName, msg);
         if(res != 0)
            Print("Error: ", GetErrorDescription(res));
        }
      //--- Send signal SELL
      //--- Send signal BUY
      if(SellHull[0] != 0)
        {
         string msg = "sell signal MA1 Cross MA3";
         int res = bot.SendMessage(InpChannelName, msg);
         if(res != 0)
            Print("Error: ", GetErrorDescription(res));
        }
      //--- Send signal BUY
      if(BuyDiamond[0] != 0)
        {
         string msg = "Buy signal Semafor2up diamond";
         int res = bot.SendMessage(InpChannelName, msg);
         if(res != 0)
            Print("Error: ", GetErrorDescription(res));
        }
      //--- Send signal SELL
      //--- Send signal BUY
      if(SellDiamond[0] != 0)
        {
         string msg = "sell signal Semafor2Dn diamond";
         int res = bot.SendMessage(InpChannelName, msg);
         if(res != 0)
            Print("Error: ", GetErrorDescription(res));
        }
     }
  }
//+------------------------------------------------------------------+
