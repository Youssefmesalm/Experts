//+------------------------------------------------------------------+
//|                                                   myTelegram.mq5 |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link "https://www.mql5.com"
#property version "1.00"
#include <Telegram.mqh>
#include <Trade/AccountInfo.mqh>
//--- input parameters
input string InpChannelName = "EurusdMaster"; //Channel Name
input string InpToken = "2101168788:AAElaxmMYxN-dOZcIAOjErtRnt3p_TaFdBY"; //Token


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CMyBot : public CCustomBot
{
private:
  string m_Button[3];
  string m_radio_button[3];
  int m_radio_index;
  bool m_lock_state;
  bool m_mute_state;

  CAccountInfo m_Account;

public:
  void CMyBot::CMyBot(void)
  {
    m_Button[0] = "Balance";
    m_Button[1] = "Equity";
    m_Button[2] = "Margin";
    m_radio_button[0] = "Radio Button #1";
    m_radio_button[1] = "Radio Button #2";
    m_radio_button[2] = "Radio Button #3";
    m_radio_index = 0;
    m_lock_state = false;
    m_mute_state = true;
  }
  string GetKeyboard()
  {
    return ("[[\"" + m_Button[0] + "\"],[\"" + m_Button[1] + "\"],[\"" + m_Button[2] + "\"]]");
  }
  void ProcessMessages(void)
  {
    for (int i = 0; i < m_chats.Total(); i++)
    {
      CCustomChat *chat = m_chats.GetNodeAtIndex(i);
      // if the message is not processed
      if (!chat.m_new_one.done)
      {
        chat.m_new_one.done = true;
        string text = chat.m_new_one.message_text;
        // start
        if (text == "/start")
        {
          bot.SendMessage(chat.m_id, "Hello. Please choose one", bot.ReplyKeyboardMarkup(GetKeyboard(), false, false));

          int total = ArraySize(m_Button);
          for (int i = 0; i < total; i++)
          {
            if (text == m_Button[i])
            {
              bot.SendMessage(chat.m_id, ReplyKeyboardMarkup(GetKeyboard(), false, false));
            }
          }
        }
        if (text == "/fm")
        {
          string FreeMargin = m_Account.Login();
          SendMessage(chat.m_id, FreeMargin);
        }
        if (text == "/help")
        {
          SendMessage(chat.m_id, "My commands list: \n/start-start chatting with me \n/help-get help");
        }
      }
    }
  }
};

CMyBot bot;
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
