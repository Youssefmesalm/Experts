//+------------------------------------------------------------------+
//|                                                        Order.mqh |
//|                                                   Enrico Lambino |
//|                             https://www.mql5.com/en/users/iceron |
//+------------------------------------------------------------------+
#property copyright "Enrico Lambino"
#property link      "https://www.mql5.com/en/users/iceron"
#include <Arrays\ArrayInt.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class COrder : public COrderBase
  {
protected:
   CArrayInt         m_ticket_current;
   bool              m_ticket_updated;
public:
                     COrder(void);
                     COrder(const ulong ticket,const string symbol,const ENUM_ORDER_TYPE type,const double volume,const double price);
                    ~COrder(void);             
   virtual bool      IsSuspended(void);
   virtual void      Ticket(const ulong ticket);
   virtual ulong     Ticket(void) const;
   virtual void      NewTicket(const bool updated);
   virtual bool      NewTicket(void) const;
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrder::COrder(void): m_ticket_updated(false)
  {
   if(!m_ticket_current.IsSorted())
      m_ticket_current.Sort();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrder::COrder(const ulong ticket,const string symbol,const ENUM_ORDER_TYPE type,const double volume,const double price)
  {
   if(!m_ticket_current.IsSorted())
      m_ticket_current.Sort();
   m_ticket=ticket;
   m_ticket_current.InsertSort((int)ticket);
   m_symbol=symbol;
   m_type=type;
   m_volume_initial=volume;
   m_volume= m_volume_initial;
   m_price = price;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrder::~COrder(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrder::Ticket(const ulong ticket)
  {
   m_ticket_current.InsertSort((int)ticket);   
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ulong COrder::Ticket(void) const
  {
   return m_ticket_current.At(m_ticket_current.Total()-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COrder::NewTicket(const bool updated)
  {
   m_ticket_updated=updated;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool COrder::NewTicket(void) const
  {
   return m_ticket_updated;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool COrder::IsSuspended(void)
  {
   return m_suspend;
  }
//+------------------------------------------------------------------+
