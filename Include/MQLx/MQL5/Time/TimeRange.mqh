//+------------------------------------------------------------------+
//|                                                    TimeRange.mqh |
//|                                                   Enrico Lambino |
//|                             https://www.mql5.com/en/users/iceron |
//+------------------------------------------------------------------+
#property copyright "Enrico Lambino"
#property link      "https://www.mql5.com/en/users/iceron"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CTimeRange : public CTimeRangeBase
  {
public:
                     CTimeRange(datetime,datetime);
                    ~CTimeRange(void);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CTimeRange::CTimeRange(datetime begin,datetime end) : CTimeRangeBase(begin,end)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CTimeRange::~CTimeRange(void)
  {
  }
//+------------------------------------------------------------------+