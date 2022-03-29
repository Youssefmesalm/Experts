//+------------------------------------------------------------------+
//|                                                  test_orders.mqh |
//|                                                   Enrico Lambino |
//|                             https://www.mql5.com/en/users/iceron |
//+------------------------------------------------------------------+
#property copyright "Enrico Lambino"
#property link      "https://www.mql5.com/en/users/iceron"
#include <MQLx-Orders\Base\Trade\ExpertTradeXBase.mqh>
#include <MQLx-Orders\Base\Order\OrdersBase.mqh>
CExpertTradeX trade;
COrders orders;
CSymbolInfo symbolinfo;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   if(!symbolinfo.Name(Symbol()))
     {
      Print("failed to initialize symbol");
      return INIT_FAILED;
     }
   trade.SetSymbol(GetPointer(symbolinfo));
   trade.SetExpertMagicNumber(12345);
//---
   return(INIT_SUCCEEDED);
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
   if(!symbolinfo.RefreshRates())
     {
      Print("cannot refresh symbol");
      return;
     }
   if(trade.Buy(1.0,symbolinfo.Ask(),0,0))
     {
#ifdef __MQL5__
      int retcode=trade.ResultRetCode();
      ulong order= trade.ResultOrder();
      if(retcode==TRADE_RETCODE_DONE)
        {
         if(HistoryOrderSelect(order))
           {
            ulong ticket=HistoryOrderGetInteger(order,ORDER_TICKET);
            ulong magic=HistoryOrderGetInteger(order,ORDER_MAGIC);
            string symbol = HistoryOrderGetString(order,ORDER_SYMBOL);
            double volume = HistoryOrderGetDouble(order,ORDER_VOLUME_INITIAL);
            double price=HistoryOrderGetDouble(order,ORDER_PRICE_OPEN);
            ENUM_ORDER_TYPE order_type=order_type;
            m_orders.NewOrder((int)ticket,symbol,(int)magic,order_type,volume,price);
           }
        }
#else
      for(int i=0;i<OrdersTotal();i++)
        {
         if(!OrderSelect(i,SELECT_BY_POS))
            continue;
         if(OrderMagicNumber()==12345)
            orders.NewOrder(OrderTicket(),OrderSymbol(),OrderMagicNumber(),(ENUM_ORDER_TYPE)OrderType(),OrderLots(),OrderOpenPrice());
        }
#endif
     }
   Sleep(5000);
   ExpertRemove();
  }
//+------------------------------------------------------------------+
