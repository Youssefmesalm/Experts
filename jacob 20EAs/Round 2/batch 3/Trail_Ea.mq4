//+------------------------------------------------------------------+
//|                                                     Trail Ea.mq4 |
//|                                     Copyright 2021,Yousuf Mesalm |
//|                          https://www.mql5.com/en/users/20163440  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, YouSuf Mesalm."
#property link      "https://www.mql5.com/en/users/20163440"
#property version   "1.00"

#property strict
input bool FirstTrail=true; // first trailing stop loss movement for first pip Profit
input int TrailingStopFirstPipProfit=2;// stoploss in pip for first 1 pip Profit
input int TrailingStop=2;//stoploss in pip
input int TrailingStep=2;//change stoploss every numbers of pip (default=1)
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

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
   if(OrdersTotal()==0)
      OrderSend(Symbol(),0,0.1,Ask,100,0,0,"",0,0,clrBlue);
   TrailingStopp();
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void TrailingStopp()
  {
   for(int i=0; i<OrdersTotal(); i++)
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
         double sl = OrderTakeProfit();
         string sym=OrderSymbol();
         if(OrderType() == OP_BUY)
           {
            if(FirstTrail&&MarketInfo(OrderSymbol(),MODE_BID) - OrderOpenPrice()<3*10*MarketInfo(sym,MODE_POINT)
               &&MarketInfo(OrderSymbol(),MODE_BID) - OrderOpenPrice()>=10*MarketInfo(sym,MODE_POINT))
              {
               sl = MarketInfo(OrderSymbol(),MODE_BID)-TrailingStopFirstPipProfit*10*MarketInfo(sym,MODE_POINT);
               if(sl-OrderStopLoss()>=TrailingStopFirstPipProfit*10*MarketInfo(sym,MODE_POINT))
                 {
                  bool ret1 = OrderModify(OrderTicket(), OrderOpenPrice(), sl,OrderTakeProfit(),30, White);
                  if(ret1 == false)
                     Print(" OrderModify() error - , ErrorDescription: ",(GetLastError()));
                 }
              }
            else
               if(MarketInfo(OrderSymbol(),MODE_BID) - OrderOpenPrice() >= (TrailingStop+TrailingStep)*10*MarketInfo(sym,MODE_POINT))
                 {
                  if((OrderStopLoss() < MarketInfo(OrderSymbol(),MODE_BID)-(TrailingStop+TrailingStep)*10*MarketInfo(sym,MODE_POINT)) || (OrderStopLoss()==0))
                    {

                     sl = MarketInfo(OrderSymbol(),MODE_BID)-TrailingStop*MarketInfo(sym,MODE_POINT);
                     bool ret1 = OrderModify(OrderTicket(), OrderOpenPrice(), sl,OrderTakeProfit(),30, White);
                     if(ret1 == false)
                        Print(" OrderModify() error - , ErrorDescription: ",(GetLastError()));

                    }
                 }
           }
         if(OrderType() == OP_SELL)
           {
            if(FirstTrail && OrderOpenPrice() - MarketInfo(OrderSymbol(),MODE_ASK) < 3*10*MarketInfo(sym,MODE_POINT)
               &&OrderOpenPrice() - MarketInfo(OrderSymbol(),MODE_ASK) >= 1*10*MarketInfo(sym,MODE_POINT))
              {
               sl = MarketInfo(OrderSymbol(),MODE_ASK)+TrailingStopFirstPipProfit*10*MarketInfo(sym,MODE_POINT);
               if(OrderStopLoss()-sl>=TrailingStopFirstPipProfit*10*MarketInfo(sym,MODE_POINT))
                 {
                  bool ret2 = OrderModify(OrderTicket(), OrderOpenPrice(),sl, OrderTakeProfit(), 30, White);
                  if(ret2 == false)
                     Print("OrderModify() error - , ErrorDescription: ",(GetLastError()));
                 }
              }
            else
            if(OrderOpenPrice() - MarketInfo(OrderSymbol(),MODE_ASK) >= (TrailingStep+TrailingStop)*10*MarketInfo(sym,MODE_POINT))
               if((OrderStopLoss() > (TrailingStop+TrailingStep)*10*MarketInfo(sym,MODE_POINT)+MarketInfo(OrderSymbol(),MODE_ASK)) || (OrderStopLoss()==0))
                 {

                  sl = MarketInfo(OrderSymbol(),MODE_ASK)+TrailingStop*MarketInfo(sym,MODE_POINT);
                  bool ret2 = OrderModify(OrderTicket(), OrderOpenPrice(),sl, OrderTakeProfit(), 30, White);
                  if(ret2 == false)
                     Print("OrderModify() error - , ErrorDescription: ",(GetLastError()));
                 }
           }
        }
      else
         Print("OrderSelect() error - , ErrorDescription: ",(GetLastError()));
  }
//+------------------------------------------------------------------+
