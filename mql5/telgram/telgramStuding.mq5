//+------------------------------------------------------------------+
//|                                         Telegram_SendMessage.mq5 |
//|                        Copyright 2014, MetaQuotes Software Corp. |
//|                                              https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include <Telegram.mqh>
//+------------------------------------------------------------------+
//|   CMyBot                                                         |
//+------------------------------------------------------------------+
class CMyBot: public CCustomBot
  {
private:
   string            m_button[3];
public:
   //+------------------------------------------------------------------+
   void CMyBot::CMyBot(void)
     {
      m_button[0]="Button #1";
      m_button[1]="Button #2";
      m_button[2]="Button #3";
     }

   //+------------------------------------------------------------------+
   string GetKeyboard()
     {
      return("[[\""+m_button[0]+"\"],[\""+m_button[1]+"\"],[\""+m_button[2]+"\"]]");
     }

   //+------------------------------------------------------------------+
   void ProcessMessages(void)
     {
      for(int i=0;i<m_chats.Total();i++)
        {
         CCustomChat *chat=m_chats.GetNodeAtIndex(i);
         if(!chat.m_new_one.done)
           {
            chat.m_new_one.done=true;
            string text=chat.m_new_one.message_text;

            //--- start or help commands
            if(text=="/start" || text=="/help")
               bot.SendMessage(chat.m_id,"Click on the buttons",bot.ReplyKeyboardMarkup(GetKeyboard(),false,false));

            //--- on click event
            int total=ArraySize(m_button);
            for(int k=0;k<total;k++)
              {
               if(text==m_button[k])
                  bot.SendMessage(chat.m_id,m_button[k],bot.ReplyKeyboardMarkup(GetKeyboard(),false,false));
              }
           }
        }
     }
  };

string InpToken="2043876400:AAEMW9M249adjW7vVgcFBsP-4WoCPx81Q74";//Token
CMyBot bot;
int getme_result;
//+------------------------------------------------------------------+
//|   OnInit                                                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- set token
   bot.Token(InpToken);
//--- check token
   getme_result=bot.GetMe();
//--- run timer
   EventSetTimer(1);
   OnTimer();
//--- done
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//|   OnDeinit                                                       |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   Comment("");
  }
//+------------------------------------------------------------------+
//|   OnTimer                                                        |
//+------------------------------------------------------------------+
void OnTimer()
  {
//--- show error message end exit
   if(getme_result!=0)
     {
      Comment("Error: ",GetErrorDescription(getme_result));
      return;
     }
//--- show bot name
   Comment("Bot name: ",bot.Name());
//--- reading messages
   bot.GetUpdates();
//--- processing messages
   bot.ProcessMessages();
  }


