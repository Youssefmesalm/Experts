//+------------------------------------------------------------------+
//|                                           Telegram_Signal_EA.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict

#include <Telegram.mqh>

//--- input parameters
input string InpChannelName="EurusdMaster";//Channel Name
input string InpToken="2043876400:AAEMW9M249adjW7vVgcFBsP-4WoCPx81Q74";//Token

//--- global variables
CCustomBot bot;
int handle1;
datetime time_signal=0;
bool checked;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   time_signal=0;

   bot.Token(InpToken);


   

   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   if(reason==REASON_PARAMETERS ||
         reason==REASON_RECOMPILE ||
         reason==REASON_ACCOUNT)
   {
      checked=false;
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
      if(StringLen(InpChannelName)==0)
      {
         Print("Error: Channel name is empty");
         Sleep(10000);
         return;
      }

      int result=bot.GetMe();
      if(result==0)
      {
         Print("Bot name: ",bot.Name());
         checked=true;
      }
      else
      {
         Print("Error: ",GetErrorDescription(result));
         Sleep(10000);
         return;
      }
   }

//--- get time
   datetime time[1];
   //--- Send signal sell
               string msg = "sell Signal after semafor2 diamond";
               int res = bot.SendMessage(InpChannelName, msg);
               if(res != 0)
               Print("Error: ", GetErrorDescription(res));

//--- check the signal on each bar
   
      
   
}
//+------------------------------------------------------------------+
