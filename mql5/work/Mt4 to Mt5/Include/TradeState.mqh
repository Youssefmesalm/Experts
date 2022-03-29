
//+------------------------------------------------------------------+
//|                                                  TimeControl.mqh |
//|                                 Copyright 2015, Vasiliy Sokolov. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, Vasiliy Sokolov."
#property link      "http://www.mql5.com"

#define ALL_DAYS_OF_WEEK 7
//+------------------------------------------------------------------+
//| ?????????? ???????? ????????? ????????                           |
//+------------------------------------------------------------------+
enum ENUM_TRADE_STATE
  {
   TRADE_BUY_AND_SELL,              // ????????? ??????? ? ???????.
   TRADE_BUY_ONLY,                  // ????????? ?????? ???????. ??????? ?????????.
   TRADE_SELL_ONLY,                 // ????????? ?????? ???????. ??????? ?????????.
   TRADE_STOP,                      // ???????? ?????????. ?????????? ??????? ??? ???????. ????? ??????? ?? ???? ?? ?????????.
   TRADE_WAIT,                      // ???????? ??? ????????? ????????? ????????. ????? ??????? ????????????. ??????? ? ??????? ?????? ????????.
   TRADE_NO_NEW_ENTRY               // ??????? ?? ???? ????????????. ?????? ??? ???????? ??????? ?????????????? ???????? ???????? ??????.
  };
//+------------------------------------------------------------------+
//| ?????? ???????? ????????? TradeState                             |
//+------------------------------------------------------------------+
class CTradeState
  {
private:
   ENUM_TRADE_STATE  m_state[60*24*7];  // ?????? ???????? ?????????
public:
                     CTradeState(void);
                     CTradeState(ENUM_TRADE_STATE default_state);
   ENUM_TRADE_STATE  GetTradeState(void);
   ENUM_TRADE_STATE  GetTradeState(datetime time_current);
   void              SetTradeState(datetime time_begin,datetime time_end,int day_of_week,ENUM_TRADE_STATE state);
  };
//+------------------------------------------------------------------+
//| ????? ?? ????????? TRADE_BUY_AND_SELL                            |
//+------------------------------------------------------------------+
CTradeState::CTradeState(void)
  {
   ArrayInitialize(m_state,TRADE_BUY_AND_SELL);
  }
//+------------------------------------------------------------------+
//| ????? ?? ????????? ???????? ????????? default_state              |
//+------------------------------------------------------------------+
CTradeState::CTradeState(ENUM_TRADE_STATE default_state)
  {
   ArrayInitialize(m_state,default_state);
  }
//+------------------------------------------------------------------+
//| ????????????? ???????? ????????? TradeState                      |
//| INPUT:                                                           |
//| time_begin  - ?????, ??????? ? ???????? ????????? ????????       |
//|               ?????????.                                         |
//| time_end    - ?????, ?? ???????? ????????? ???????? ?????????    |
//| day_of_week - ???? ??????, ?? ??????? ???????????????? ????????? |
//|               ????????? ?????????. ????????????? ?????????????   |
//|               ENUM_DAY_OF_WEEK ??? ???????????? ALL_DAYS_OF_WEEK |
//| state       - ???????? ?????????.                                |
//| ????????, ?????????? ???? ? time_begin ? time_end ????????????.  |
//+------------------------------------------------------------------+
void CTradeState::SetTradeState(datetime time_begin,datetime time_end,int day_of_week,ENUM_TRADE_STATE state)
  {
   if(time_begin>time_end)
     {
      string sb = TimeToString(time_begin, TIME_MINUTES);
      string se = TimeToString(time_end, TIME_MINUTES);
      printf("Time "+sb+" must be more time "+se);
      return;
     }
   MqlDateTime btime,etime;
   TimeToStruct(time_begin,btime);
   TimeToStruct(time_end,etime);
   for(int day=0; day<ALL_DAYS_OF_WEEK; day++)
     {
      if(day!=day_of_week && day_of_week!=ALL_DAYS_OF_WEEK)
         continue;
      int i_day=day*60*24;
      int i_begin=i_day+(btime.hour*60)+btime.min;
      int i_end = i_day + (etime.hour*60) + etime.min;
      for(int i = i_begin; i <= i_end; i++)
         m_state[i]=state;
     }
  }
//+------------------------------------------------------------------+
//| ?????????? ????? ???????? ??? ???????? ??????? ???????? ?????????|
//+------------------------------------------------------------------+
ENUM_TRADE_STATE CTradeState::GetTradeState(void)
  {
   return GetTradeState(TimeCurrent());
  }
//+------------------------------------------------------------------+
//| ?????????? ????? ???????? ???????? ????????? ??? ???????????     |
//| ???????.                                                         |
//+------------------------------------------------------------------+
ENUM_TRADE_STATE CTradeState::GetTradeState(datetime time_current)
  {
   MqlDateTime dt;
   TimeToStruct(time_current,dt);
   int i_day = dt.day_of_week*60*24;
   int index = i_day + (dt.hour*60) + dt.min;
   return m_state[index];
  }
//+------------------------------------------------------------------+