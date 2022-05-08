//+------------------------------------------------------------------+
//|                                                    OrderBase.mqh |
//|                                                   Enrico Lambino |
//|                             https://www.mql5.com/en/users/iceron |
//+------------------------------------------------------------------+
#property copyright "Enrico Lambino"
#property link      "https://www.mql5.com/en/users/iceron"
#include "..\Symbol\SymbolManagerBase.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class COrderBase : public CObject
  {
protected:
   bool              m_closed;
   bool              m_suspend;
   long              m_order_flags;
   int               m_magic;
   double            m_price;
   ulong             m_ticket;
   ENUM_ORDER_TYPE   m_type;
   double            m_volume;
   double            m_volume_initial;
   string            m_symbol;
public:
                     COrderBase(void);
                    ~COrderBase(void);
   //--- getters and setters     
   void              IsClosed(const bool);
   bool              IsClosed(void) const;
   void              IsSuspended(const bool);
   bool              IsSuspended(void) const;
   void              Magic(const int);
   int               Magic(void) const;
   void              Price(const double);
   double            Price(void) const;
   void              OrderType(const ENUM_ORDER_TYPE);
   ENUM_ORDER_TYPE   OrderType(void) const;
   void              Symbol(const string);
   string            Symbol(void) const;
   void              Ticket(const ulong);
   ulong             Ticket(void) const;
   void              Volume(const double);
   double            Volume(void) const;
   void              VolumeInitial(const double);
   double            VolumeInitial(void) const;
   //--- output
   virtual string    OrderTypeToString(void) const;
   //--- static methods
   static bool       IsOrderTypeLong(const ENUM_ORDER_TYPE);
   static bool       IsOrderTypeShort(const ENUM_ORDER_TYPE);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrderBase::COrderBase(void) : m_closed(false),
                               m_suspend(false),
                               m_order_flags(0),
                               m_magic(0),
                               m_price(0.0),
                               m_ticket(0),
                               m_type(0),
                               m_volume(0.0),
                               m_volume_initial(0.0)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrderBase::~COrderBase(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrderBase::IsClosed(const bool value)
  {
   m_closed=value;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool COrderBase::IsClosed(void) const
  {
   return m_closed;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrderBase::IsSuspended(const bool value)
  {
   m_suspend=value;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool COrderBase::IsSuspended(void) const
  {
   return m_suspend;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrderBase::Magic(const int value)
  {
   m_magic=value;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int COrderBase::Magic(void) const
  {
   return m_magic;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrderBase::Price(const double value)
  {
   m_price=value;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double COrderBase::Price(void) const
  {
   return m_price;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrderBase::OrderType(const ENUM_ORDER_TYPE value)
  {
   m_type=value;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ENUM_ORDER_TYPE COrderBase::OrderType(void) const
  {
   return m_type;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrderBase::Symbol(const string value)
  {
   m_symbol=value;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string COrderBase::Symbol(void) const
  {
   return m_symbol;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrderBase::Ticket(const ulong value)
  {
   m_ticket=value;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ulong COrderBase::Ticket(void) const
  {
   return m_ticket;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrderBase::Volume(const double value)
  {
   m_volume=value;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double COrderBase::Volume(void) const
  {
   return m_volume;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrderBase::VolumeInitial(const double value)
  {
   m_volume_initial=value;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double COrderBase::VolumeInitial(void) const
  {
   return m_volume_initial;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string COrderBase::OrderTypeToString(void) const
  {
   switch(OrderType())
     {
      case ORDER_TYPE_BUY:          return "BUY";
      case ORDER_TYPE_SELL:         return "SELL";
      case ORDER_TYPE_BUY_LIMIT:    return "BUY LIMIT";
      case ORDER_TYPE_BUY_STOP:     return "BUY STOP";
      case ORDER_TYPE_SELL_LIMIT:   return "SELL LIMIT";
      case ORDER_TYPE_SELL_STOP:    return "SELL STOP";
     }
   return NULL;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool COrderBase::IsOrderTypeLong(const ENUM_ORDER_TYPE type)
  {
   return type==ORDER_TYPE_BUY || type==ORDER_TYPE_BUY_LIMIT || type==ORDER_TYPE_BUY_STOP;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool COrderBase::IsOrderTypeShort(const ENUM_ORDER_TYPE type)
  {
   return type==ORDER_TYPE_SELL || type==ORDER_TYPE_SELL_LIMIT || type==ORDER_TYPE_SELL_STOP;
  }
//+------------------------------------------------------------------+
#ifdef __MQL5__
#include "..\..\MQL5\Order\Order.mqh"
#else
#include "..\..\MQL4\Order\Order.mqh"
#endif
//+------------------------------------------------------------------+
