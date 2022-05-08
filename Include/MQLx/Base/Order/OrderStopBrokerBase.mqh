//+------------------------------------------------------------------+
//|                                          OrderStopBrokerBase.mqh |
//|                                                   Enrico Lambino |
//|                             https://www.mql5.com/en/users/iceron |
//+------------------------------------------------------------------+
#property copyright "Enrico Lambino"
#property link      "https://www.mql5.com/en/users/iceron"
#include "OrderStopBase.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class COrderStopBrokerBase : public COrderStop
  {
public:
                     COrderStopBrokerBase(void);
                    ~COrderStopBrokerBase(void);
   virtual int       Type(void) const {return CLASS_TYPE_ORDERSTOP_BROKER;}
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrderStopBrokerBase::COrderStopBrokerBase(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrderStopBrokerBase::~COrderStopBrokerBase(void)
  {
  }
//+------------------------------------------------------------------+
#ifdef __MQL5__
#include "..\..\MQL5\Order\OrderStopBroker.mqh"
#else
#include "..\..\MQL4\Order\OrderStopBroker.mqh"
#endif
//+------------------------------------------------------------------+
