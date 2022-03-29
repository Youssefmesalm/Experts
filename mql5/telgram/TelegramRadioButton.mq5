//+------------------------------------------------------------------+
//|                                         Telegram_SendMessage.mq5 |
//|                        Copyright 2014, MetaQuotes Software Corp. |
//|                                              https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link "https://www.mql5.com"
#property version "1.00"
#property strict

#include <Telegram.mqh>

#define MUTE_TEXT "Mute"
#define UNMUTE_TEXT "Unmute"

#define LOCK_TEXT "Lock"
#define UNLOCK_TEXT "Unlock"

#define RADIO_SELECT "\xF518"
#define RADIO_EMPTY "\x26AA"

#define MUTE_CODE "\xF515"
#define UNMUTE_CODE "\xF514"

#define LOCK_CODE "\xF512"
#define UNLOCK_CODE "\xF513"
//+------------------------------------------------------------------+
//|   CMyBot                                                         |
//+------------------------------------------------------------------+
class CMyBot : public CCustomBot
{
private:
   string m_radio_button[3];
   int m_radio_index;
   bool m_lock_state;
   bool m_mute_state;

public:
   //+------------------------------------------------------------------+
   void CMyBot::CMyBot(void)
   {
      m_radio_button[0] = "Radio Button #1";
      m_radio_button[1] = "Radio Button #2";
      m_radio_button[2] = "Radio Button #3";
      m_radio_index = 0;
      m_lock_state = false;
      m_mute_state = true;
   }

   //+------------------------------------------------------------------+
   string GetKeyboard()
   {
      //---
      string radio_code[3] = {RADIO_EMPTY, RADIO_EMPTY, RADIO_EMPTY};
      if (m_radio_index >= 0 && m_radio_index <= 2)
         radio_code[m_radio_index] = RADIO_SELECT;
      //---
      string mute_text = UNMUTE_TEXT;
      string mute_code = UNMUTE_CODE;
      if (m_mute_state)
      {
         mute_text = MUTE_TEXT;
         mute_code = MUTE_CODE;
      }
      //---
      string lock_text = UNLOCK_TEXT;
      string lock_code = UNLOCK_CODE;
      if (m_lock_state)
      {
         lock_text = LOCK_TEXT;
         lock_code = LOCK_CODE;
      }
      //---
      //Print(m_lock.GetKey());
      return (StringFormat("[[\"%s %s\"],[\"%s %s\"],[\"%s %s\"],[\"%s %s\",\"%s %s\"]]",
                           radio_code[0], m_radio_button[0],
                           radio_code[1], m_radio_button[1],
                           radio_code[2], m_radio_button[2],
                           lock_code, lock_text,
                           mute_code, mute_text));
   }

   //+------------------------------------------------------------------+
   void ProcessMessages(void)
   {
      for (int i = 0; i < m_chats.Total(); i++)
      {
         CCustomChat *chat = m_chats.GetNodeAtIndex(i);
         if (!chat.m_new_one.done)
         {
            chat.m_new_one.done = true;
            string text = chat.m_new_one.message_text;

            //--- start
            if (text == "/start" || text == "/help")
            {
               bot.SendMessage(chat.m_id, "Click on the buttons", bot.ReplyKeyboardMarkup(GetKeyboard(), false, false));
            }

            //--- Click on a RadioButton
            int total = ArraySize(m_radio_button);
            for (int k = 0; k < total; k++)
            {
               if (text == RADIO_EMPTY + " " + m_radio_button[k])
               {
                  m_radio_index = k;
                  bot.SendMessage(chat.m_id, m_radio_button[k], bot.ReplyKeyboardMarkup(GetKeyboard(), false, false));
               }
            }

            //--- Unlock
            if (text == LOCK_CODE + " " + LOCK_TEXT)
            {
               m_lock_state = false;
               bot.SendMessage(chat.m_id, UNLOCK_TEXT, bot.ReplyKeyboardMarkup(GetKeyboard(), false, false));
            }

            //--- Lock
            if (text == UNLOCK_CODE + " " + UNLOCK_TEXT)
            {
               m_lock_state = true;
               bot.SendMessage(chat.m_id, LOCK_TEXT, bot.ReplyKeyboardMarkup(GetKeyboard(), false, false));
            }

            //--- Unmute
            if (text == MUTE_CODE + " " + MUTE_TEXT)
            {
               m_mute_state = false;
               bot.SendMessage(chat.m_id, UNMUTE_TEXT, bot.ReplyKeyboardMarkup(GetKeyboard(), false, false));
            }

            //--- Mute
            if (text == UNMUTE_CODE + " " + UNMUTE_TEXT)
            {
               m_mute_state = true;
               bot.SendMessage(chat.m_id, MUTE_TEXT, bot.ReplyKeyboardMarkup(GetKeyboard(), false, false));
            }
         }
      }
   }
};
CMyBot bot;
input string Token = "2101168788:AAElaxmMYxN-dOZcIAOjErtRnt3p_TaFdBY";
int get_Result;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   //---
   // set token
   bot.Token(Token);
   //check token
   get_Result = bot.GetMe();
   // run timer
   EventSetTimer(3);
   OnTimer();
   //---
   return (INIT_SUCCEEDED);
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
void OnTimer()
{
   if (get_Result != 0)
   {
      Comment("Error", GetErrorDescription(get_Result));
      return;
   }
   //show bot name
   Comment("Bot Name", bot.Name());
   bot.GetUpdates();
   bot.ProcessMessages();
}

//+------------------------------------------------------------------+
