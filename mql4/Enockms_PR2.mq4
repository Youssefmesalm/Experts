//+------------------------------------------------------------------+
//|                                               mql job 164282.mq5 |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+


string short_name=MQLInfoString(MQL_PROGRAM_NAME);
input int Magic=123;
input ENUM_TIMEFRAMES TimeFrame=PERIOD_CURRENT;
input double Max_Spread=0;
int barShift=0;
string Comment_ea=short_name;


input bool TradeOnMonday=true;
input bool TradeOnTuesday=true;
input bool TradeOnWednessday=true;
input bool TradeOnThursday=true;
input bool TradeOnFriday=true;


input double close_byEquity=100;//autoClose_Profit 
input double close_byEquityLoss=-100;//autoClose_Loss
input int xAxix=2;
input int yAxix=120;
// int yAxix=100;

input color clrBg=clrMidnightBlue;// Background color



struct panel_string_s
  {
   string Lots;
   string StopLoss_inPip;
   string TakeProfit_inPip;
   string maxOrder_perBar;

   string buy;
   string sell;
   string close;
   string autoClose;
  };
struct panel_double_s
  {
   double Lots;
   double StopLoss_inPip;
   double TakeProfit_inPip;
   double maxOrder_perBar;
  };

struct panel_s
  {
  panel_double_s val;
  panel_string_s objName;
  };
  panel_s panel;
int Width=220;
int Height=5;
int fontSize=12;
void delletAllObjectByPrefix(string sPrefix)
  {
   string c_name;
   for(int i=ObjectsTotal()-1; i>=0; i--)
     {
      if(StringFind(ObjectName(0,i),sPrefix)==0)
        {
         c_name=ObjectName(0,i);
         ObjectDelete(0,c_name);
        }
     }
  }
//#include "MT4orders.mqh"
//#include "Candle Countdown.mqh"

#ifdef __MQL5__
#ifndef __MT4ORDERS__

#define __MT4ORDERS__

#ifdef MT4_TICKET_TYPE
  #define TICKET_TYPE int
  #define MAGIC_TYPE  int

  #undef MT4_TICKET_TYPE
#else // MT4_TICKET_TYPE
  #define TICKET_TYPE long
  #define MAGIC_TYPE  long
#endif // MT4_TICKET_TYPE

struct MT4_ORDER
{
  long Ticket;
  int Type;

  long TicketOpen;

  double Lots;

  string Symbol;
  string Comment;

  double OpenPriceRequest;
  double OpenPrice;

  long OpenTimeMsc;
  datetime OpenTime;

  ENUM_DEAL_REASON OpenReason;

  double StopLoss;
  double TakeProfit;

  double ClosePriceRequest;
  double ClosePrice;

  long CloseTimeMsc;
  datetime CloseTime;

  ENUM_DEAL_REASON CloseReason;

  ENUM_ORDER_STATE State;

  datetime Expiration;

  long MagicNumber;

  double Profit;

  double Commission;
  double Swap;

#define POSITION_SELECT (-1)
#define ORDER_SELECT (-2)

  static const MT4_ORDER GetPositionData( void )
  {
    MT4_ORDER Res = {0};

    Res.Ticket = ::PositionGetInteger(POSITION_TICKET);
    Res.Type = (int)::PositionGetInteger(POSITION_TYPE);

    Res.Lots = ::PositionGetDouble(POSITION_VOLUME);

    Res.Symbol = ::PositionGetString(POSITION_SYMBOL);
//    Res.Comment = NULL; // MT4ORDERS::CheckPositionCommissionComment();

    Res.OpenPrice = ::PositionGetDouble(POSITION_PRICE_OPEN);
    Res.OpenTime = (datetime)::PositionGetInteger(POSITION_TIME);

    Res.StopLoss = ::PositionGetDouble(POSITION_SL);
    Res.TakeProfit = ::PositionGetDouble(POSITION_TP);

    Res.ClosePrice = ::PositionGetDouble(POSITION_PRICE_CURRENT);
    Res.CloseTime = 0;

    Res.Expiration = 0;

    Res.MagicNumber = ::PositionGetInteger(POSITION_MAGIC);

    Res.Profit = ::PositionGetDouble(POSITION_PROFIT);

    Res.Swap = ::PositionGetDouble(POSITION_SWAP);

//    Res.Commission = UNKNOWN_COMMISSION; // MT4ORDERS::CheckPositionCommissionComment();

    return(Res);
  }

  static const MT4_ORDER GetOrderData( void )
  {
    MT4_ORDER Res = {0};

    Res.Ticket = ::OrderGetInteger(ORDER_TICKET);
    Res.Type = (int)::OrderGetInteger(ORDER_TYPE);

    Res.Lots = ::OrderGetDouble(ORDER_VOLUME_CURRENT);

    Res.Symbol = ::OrderGetString(ORDER_SYMBOL);
    Res.Comment = ::OrderGetString(ORDER_COMMENT);

    Res.OpenPrice = ::OrderGetDouble(ORDER_PRICE_OPEN);
    Res.OpenTime = (datetime)::OrderGetInteger(ORDER_TIME_SETUP);

    Res.StopLoss = ::OrderGetDouble(ORDER_SL);
    Res.TakeProfit = ::OrderGetDouble(ORDER_TP);

    Res.ClosePrice = ::OrderGetDouble(ORDER_PRICE_CURRENT);
    Res.CloseTime = 0; // (datetime)::OrderGetInteger(ORDER_TIME_DONE)

    Res.Expiration = (datetime)::OrderGetInteger(ORDER_TIME_EXPIRATION);

    Res.MagicNumber = ::OrderGetInteger(ORDER_MAGIC);

    Res.Profit = 0;

    Res.Commission = 0;
    Res.Swap = 0;

    return(Res);
  }

  string ToString( void ) const
  {
    static const string Types[] = {"buy", "sell", "buy limit", "sell limit", "buy stop", "sell stop", "balance"};
    const int digits = (int)::SymbolInfoInteger(this.Symbol, SYMBOL_DIGITS);

    MT4_ORDER TmpOrder = {0};

    if (this.Ticket == POSITION_SELECT)
    {
      TmpOrder = MT4_ORDER::GetPositionData();

      TmpOrder.Comment = this.Comment;
      TmpOrder.Commission = this.Commission;
    }
    else if (this.Ticket == ORDER_SELECT)
      TmpOrder = MT4_ORDER::GetOrderData();

    return(((this.Ticket == POSITION_SELECT) || (this.Ticket == ORDER_SELECT)) ? TmpOrder.ToString() :
           ("#" + (string)this.Ticket + " " +
            (string)this.OpenTime + " " +
            ((this.Type < ::ArraySize(Types)) ? Types[this.Type] : "unknown") + " " +
            ::DoubleToString(this.Lots, 2) + " " +
            this.Symbol + " " +
            ::DoubleToString(this.OpenPrice, digits) + " " +
            ::DoubleToString(this.StopLoss, digits) + " " +
            ::DoubleToString(this.TakeProfit, digits) + " " +
            ((this.CloseTime > 0) ? ((string)this.CloseTime + " ") : "") +
            ::DoubleToString(this.ClosePrice, digits) + " " +
            ::DoubleToString(this.Commission, 2) + " " +
            ::DoubleToString(this.Swap, 2) + " " +
            ::DoubleToString(this.Profit, 2) + " " +
            ((this.Comment == "") ? "" : (this.Comment + " ")) +
            (string)this.MagicNumber +
            (((this.Expiration > 0) ? (" expiration " + (string)this.Expiration): ""))));
  }
};

#define RESERVE_SIZE 1000
#define DAY (24 * 3600)
#define HISTORY_PAUSE (MT4HISTORY::IsTester ? 0 : 5)
#define END_TIME D'31.12.3000 23:59:59'
#define THOUSAND 1000
#define LASTTIME(A)                                          \
  if (Time##A >= LastTimeMsc)                                \
  {                                                          \
    const datetime TmpTime = (datetime)(Time##A / THOUSAND); \
                                                             \
    if (TmpTime > this.LastTime)                             \
    {                                                        \
      this.LastTotalOrders = 0;                              \
      this.LastTotalDeals = 0;                               \
                                                             \
      this.LastTime = TmpTime;                               \
      LastTimeMsc = this.LastTime * THOUSAND;                \
    }                                                        \
                                                             \
    this.LastTotal##A##s++;                                  \
  }

#ifndef MT4ORDERS_FASTHISTORY_OFF
  #include <Generic\HashMap.mqh>
#endif // MT4ORDERS_FASTHISTORY_OFF

class MT4HISTORY
{
private:
  static const bool MT4HISTORY::IsTester;
  static long MT4HISTORY::AccountNumber;

#ifndef MT4ORDERS_FASTHISTORY_OFF
  CHashMap<ulong, ulong> DealsIn;
#endif // MT4ORDERS_FASTHISTORY_OFF

  long Tickets[];
  uint Amount;

  datetime LastTime;

  int LastTotalDeals;
  int LastTotalOrders;

  datetime LastInitTime;

  bool RefreshHistory( void )
  {
    bool Res = false;

    const datetime LastTimeCurrent = ::TimeCurrent();

    if (!MT4HISTORY::IsTester && ((LastTimeCurrent >= this.LastInitTime + DAY) || (MT4HISTORY::AccountNumber != ::AccountInfoInteger(ACCOUNT_LOGIN))))
    {
      MT4HISTORY::AccountNumber = ::AccountInfoInteger(ACCOUNT_LOGIN);

      this.LastTime = 0;

      this.LastTotalOrders = 0;
      this.LastTotalDeals = 0;

      this.Amount = 0;

      ::ArrayResize(this.Tickets, this.Amount, RESERVE_SIZE);

      this.LastInitTime = LastTimeCurrent;

    #ifndef MT4ORDERS_FASTHISTORY_OFF
      this.DealsIn.Clear();
    #endif // MT4ORDERS_FASTHISTORY_OFF
    }

    const datetime LastTimeCurrentLeft = LastTimeCurrent - HISTORY_PAUSE;

    if (::HistorySelect(this.LastTime, END_TIME))
    {
      const int TotalOrders = ::HistoryOrdersTotal();
      const int TotalDeals = ::HistoryDealsTotal();

      Res = ((TotalOrders > this.LastTotalOrders) || (TotalDeals > this.LastTotalDeals));

      if (Res)
      {
        int iOrder = this.LastTotalOrders;
        int iDeal = this.LastTotalDeals;

        ulong TicketOrder = 0;
        ulong TicketDeal = 0;

        long TimeOrder = (iOrder < TotalOrders) ? ::HistoryOrderGetInteger((TicketOrder = ::HistoryOrderGetTicket(iOrder)), ORDER_TIME_DONE_MSC) : LONG_MAX;
        long TimeDeal = (iDeal < TotalDeals) ? ::HistoryDealGetInteger((TicketDeal = ::HistoryDealGetTicket(iDeal)), DEAL_TIME_MSC) : LONG_MAX;

        if (this.LastTime < LastTimeCurrentLeft)
        {
          this.LastTotalOrders = 0;
          this.LastTotalDeals = 0;

          this.LastTime = LastTimeCurrentLeft;
        }

        long LastTimeMsc = this.LastTime * THOUSAND;

        while ((iDeal < TotalDeals) || (iOrder < TotalOrders))
          if (TimeOrder < TimeDeal)
          {
            LASTTIME(Order)

            if (MT4HISTORY::IsMT4Order(TicketOrder))
            {
              this.Amount = ::ArrayResize(this.Tickets, this.Amount + 1, RESERVE_SIZE);

              this.Tickets[this.Amount - 1] = -(long)TicketOrder;
            }

            iOrder++;

            TimeOrder = (iOrder < TotalOrders) ? ::HistoryOrderGetInteger((TicketOrder = ::HistoryOrderGetTicket(iOrder)), ORDER_TIME_DONE_MSC) : LONG_MAX;
          }
          else
          {
            LASTTIME(Deal)

            if (MT4HISTORY::IsMT4Deal(TicketDeal))
            {
              this.Amount = ::ArrayResize(this.Tickets, this.Amount + 1, RESERVE_SIZE);

              this.Tickets[this.Amount - 1] = (long)TicketDeal;
            }
          #ifndef MT4ORDERS_FASTHISTORY_OFF
            else if ((ENUM_DEAL_ENTRY)::HistoryDealGetInteger(TicketDeal, DEAL_ENTRY) == DEAL_ENTRY_IN)
              this.DealsIn.Add(::HistoryDealGetInteger(TicketDeal, DEAL_POSITION_ID), TicketDeal);
          #endif // MT4ORDERS_FASTHISTORY_OFF

            iDeal++;

            TimeDeal = (iDeal < TotalDeals) ? ::HistoryDealGetInteger((TicketDeal = ::HistoryDealGetTicket(iDeal)), DEAL_TIME_MSC) : LONG_MAX;
          }
      }
      else if (LastTimeCurrentLeft > this.LastTime)
      {
        this.LastTime = LastTimeCurrentLeft;

        this.LastTotalOrders = 0;
        this.LastTotalDeals = 0;
      }
    }

    return(Res);
  }

public:
  static bool IsMT4Deal( const ulong &Ticket )
  {
    const ENUM_DEAL_TYPE DealType = (ENUM_DEAL_TYPE)::HistoryDealGetInteger(Ticket, DEAL_TYPE);
    const ENUM_DEAL_ENTRY DealEntry = (ENUM_DEAL_ENTRY)::HistoryDealGetInteger(Ticket, DEAL_ENTRY);

    return(((DealType != DEAL_TYPE_BUY) && (DealType != DEAL_TYPE_SELL)) ||      // не торговая сделка
           ((DealEntry == DEAL_ENTRY_OUT) || (DealEntry == DEAL_ENTRY_OUT_BY))); // торговая
  }

  static bool IsMT4Order( const ulong &Ticket )
  {
    // Если отложенный ордер исполнился, его ORDER_POSITION_ID заполняется.
    // https://www.mql5.com/ru/forum/170952/page70#comment_6543162
    // https://www.mql5.com/ru/forum/93352/page19#comment_6646726
    return(/*(::HistoryOrderGetDouble(Ticket, ORDER_VOLUME_CURRENT) > 0) ||*/ !::HistoryOrderGetInteger(Ticket, ORDER_POSITION_ID));
  }

  MT4HISTORY( void ) : Amount(::ArrayResize(this.Tickets, 0, RESERVE_SIZE)),
                       LastTime(0), LastTotalDeals(0), LastTotalOrders(0), LastInitTime(0)
  {
//    this.RefreshHistory(); // Если история не используется, незачем забивать ресурсы.
  }

  ulong GetPositionDealIn( const ulong PositionIdentifier = -1 ) // 0 - нельзя, т.к. балансовая сделка тестера имеет ноль
  {
    ulong Ticket = 0;

    if (PositionIdentifier == -1)
    {
      const ulong MyPositionIdentifier = ::PositionGetInteger(POSITION_IDENTIFIER);

    #ifndef MT4ORDERS_FASTHISTORY_OFF
      if (!this.DealsIn.TryGetValue(MyPositionIdentifier, Ticket))
    #endif // MT4ORDERS_FASTHISTORY_OFF
      {
        const datetime PosTime = (datetime)::PositionGetInteger(POSITION_TIME);

        if (::HistorySelect(PosTime, PosTime))
        {
          const int Total = ::HistoryDealsTotal();

          for (int i = 0; i < Total; i++)
          {
            const ulong TicketDeal = ::HistoryDealGetTicket(i);

            if ((::HistoryDealGetInteger(TicketDeal, DEAL_POSITION_ID) == MyPositionIdentifier) /*&&
                ((ENUM_DEAL_ENTRY)::HistoryDealGetInteger(TicketDeal, DEAL_ENTRY) == DEAL_ENTRY_IN) */) // Первое упоминание и так будет DEAL_ENTRY_IN
            {
              Ticket = TicketDeal;

            #ifndef MT4ORDERS_FASTHISTORY_OFF
              this.DealsIn.Add(MyPositionIdentifier, Ticket);
            #endif // MT4ORDERS_FASTHISTORY_OFF

              break;
            }
          }
        }
      }
    }
    else if (PositionIdentifier && // PositionIdentifier балансовых сделок равен нулю
           #ifndef MT4ORDERS_FASTHISTORY_OFF
             !this.DealsIn.TryGetValue(PositionIdentifier, Ticket) &&
           #endif // MT4ORDERS_FASTHISTORY_OFF
             ::HistorySelectByPosition(PositionIdentifier) && (::HistoryDealsTotal() > 1)) // Почему > 1, а не > 0 ?!
    {
      Ticket = ::HistoryDealGetTicket(0); // Первое упоминание и так будет DEAL_ENTRY_IN

      /*
      const int Total = ::HistoryDealsTotal();

      for (int i = 0; i < Total; i++)
      {
        const ulong TicketDeal = ::HistoryDealGetTicket(i);

        if (TicketDeal > 0)
          if ((ENUM_DEAL_ENTRY)::HistoryDealGetInteger(TicketDeal, DEAL_ENTRY) == DEAL_ENTRY_IN)
          {
            Ticket = TicketDeal;

            break;
          }
      } */

    #ifndef MT4ORDERS_FASTHISTORY_OFF
      this.DealsIn.Add(PositionIdentifier, Ticket);
    #endif // MT4ORDERS_FASTHISTORY_OFF
    }

    return(Ticket);
  }

  int GetAmount( void )
  {
    this.RefreshHistory();

    return((int)this.Amount);
  }

  long operator []( const uint &Pos )
  {
    long Res = 0;

    if ((Pos >= this.Amount) || (!MT4HISTORY::IsTester && (MT4HISTORY::AccountNumber != ::AccountInfoInteger(ACCOUNT_LOGIN))))
    {
      this.RefreshHistory();

      if (Pos < this.Amount)
        Res = this.Tickets[Pos];
    }
    else
      Res = this.Tickets[Pos];

    return(Res);
  }
};

static const bool MT4HISTORY::IsTester = ::MQLInfoInteger(MQL_TESTER);
static long MT4HISTORY::AccountNumber = ::AccountInfoInteger(ACCOUNT_LOGIN);

#undef LASTTIME
#undef THOUSAND
#undef END_TIME
#undef HISTORY_PAUSE
#undef DAY
#undef RESERVE_SIZE

#define OP_BUY ORDER_TYPE_BUY
#define OP_SELL ORDER_TYPE_SELL
#define OP_BUYLIMIT ORDER_TYPE_BUY_LIMIT
#define OP_SELLLIMIT ORDER_TYPE_SELL_LIMIT
#define OP_BUYSTOP ORDER_TYPE_BUY_STOP
#define OP_SELLSTOP ORDER_TYPE_SELL_STOP
#define OP_BALANCE 6

#define SELECT_BY_POS 0
#define SELECT_BY_TICKET 1

#define MODE_TRADES 0
#define MODE_HISTORY 1

class MT4ORDERS
{
private:
  static MT4_ORDER Order;
  static MT4HISTORY History;

  static const bool MT4ORDERS::IsTester;
  static const bool MT4ORDERS::IsHedging;

  static bool OrderSendBug;

  static bool HistorySelectOrder( const ulong &Ticket )
  {
    return((::HistoryOrderGetInteger(Ticket, ORDER_TICKET) == Ticket) || ::HistoryOrderSelect(Ticket));
  }

  static bool HistorySelectDeal( const ulong &Ticket )
  {
    return((::HistoryDealGetInteger(Ticket, DEAL_TICKET) == Ticket) || ::HistoryDealSelect(Ticket));
  }

#define UNKNOWN_COMMISSION DBL_MIN
#define UNKNOWN_REQUEST_PRICE DBL_MIN
#define UNKNOWN_TICKET 0
// #define UNKNOWN_REASON (-1)

  static bool CheckNewTicket( void )
  {
    static long PrevPosTimeUpdate = 0;
    static long PrevPosTicket = 0;

    const long PosTimeUpdate = ::PositionGetInteger(POSITION_TIME_UPDATE_MSC);
    const long PosTicket = ::PositionGetInteger(POSITION_TICKET);

    // На случай, если пользователь сделал выбор позиции не через MT4Orders
    // Перегружать MQL5-PositionSelect* и MQL5-OrderSelect нерезонно.
    // Этой проверки достаточно, т.к. несколько изменений позиции + PositionSelect в одну миллисекунду возможно только в тестере
    const bool Res = ((PosTimeUpdate != PrevPosTimeUpdate) || (PosTicket != PrevPosTicket));

    if (Res)
    {
      MT4ORDERS::GetPositionData();

      PrevPosTimeUpdate = PosTimeUpdate;
      PrevPosTicket = PosTicket;
    }

    return(Res);
  }

  static bool CheckPositionTicketOpen( void )
  {
    if ((MT4ORDERS::Order.TicketOpen == UNKNOWN_TICKET) || MT4ORDERS::CheckNewTicket())
      MT4ORDERS::Order.TicketOpen = (long)MT4ORDERS::History.GetPositionDealIn(); // Все из-за этой очень дорогой функции

    return(true);
  }

  static bool CheckPositionCommissionComment( void )
  {
    if ((MT4ORDERS::Order.Commission == UNKNOWN_COMMISSION) || MT4ORDERS::CheckNewTicket())
    {
      MT4ORDERS::Order.Commission = ::PositionGetDouble(POSITION_COMMISSION);
      MT4ORDERS::Order.Comment = ::PositionGetString(POSITION_COMMENT);

      if (!MT4ORDERS::Order.Commission || (MT4ORDERS::Order.Comment == ""))
      {
        MT4ORDERS::CheckPositionTicketOpen();

        const ulong Ticket = MT4ORDERS::Order.TicketOpen;

        if ((Ticket > 0) && MT4ORDERS::HistorySelectDeal(Ticket))
        {
          if (!MT4ORDERS::Order.Commission)
          {
            const double LotsIn = ::HistoryDealGetDouble(Ticket, DEAL_VOLUME);

            if (LotsIn > 0)
              MT4ORDERS::Order.Commission = ::HistoryDealGetDouble(Ticket, DEAL_COMMISSION) * ::PositionGetDouble(POSITION_VOLUME) / LotsIn;
          }

          if (MT4ORDERS::Order.Comment == "")
            MT4ORDERS::Order.Comment = ::HistoryDealGetString(Ticket, DEAL_COMMENT);
        }
      }
    }

    return(true);
  }
/*
  static bool CheckPositionOpenReason( void )
  {
    if ((MT4ORDERS::Order.OpenReason == UNKNOWN_REASON) || MT4ORDERS::CheckNewTicket())
    {
      MT4ORDERS::CheckPositionTicketOpen();

      const ulong Ticket = MT4ORDERS::Order.TicketOpen;

      if ((Ticket > 0) && (MT4ORDERS::IsTester || MT4ORDERS::HistorySelectDeal(Ticket)))
        MT4ORDERS::Order.OpenReason = (ENUM_DEAL_REASON)::HistoryDealGetInteger(Ticket, DEAL_REASON);
    }

    return(true);
  }
*/
  static bool CheckPositionOpenPriceRequest( void )
  {
    const long PosTicket = ::PositionGetInteger(POSITION_TICKET);

    if (((MT4ORDERS::Order.OpenPriceRequest == UNKNOWN_REQUEST_PRICE) || MT4ORDERS::CheckNewTicket()) &&
        !(MT4ORDERS::Order.OpenPriceRequest = (::HistoryOrderSelect(PosTicket) &&
                                              (MT4ORDERS::IsTester || (::PositionGetInteger(POSITION_TIME_MSC) ==
                                              ::HistoryOrderGetInteger(PosTicket, ORDER_TIME_DONE_MSC)))) // А нужна ли эта проверка?
                                            ? ::HistoryOrderGetDouble(PosTicket, ORDER_PRICE_OPEN)
                                            : ::PositionGetDouble(POSITION_PRICE_OPEN)))
      MT4ORDERS::Order.OpenPriceRequest = ::PositionGetDouble(POSITION_PRICE_OPEN); // На случай, если цена ордера нулевая

    return(true);
  }

  static void GetPositionData( void )
  {
    MT4ORDERS::Order.Ticket = POSITION_SELECT;

    MT4ORDERS::Order.Commission = UNKNOWN_COMMISSION; // MT4ORDERS::CheckPositionCommissionComment();
    MT4ORDERS::Order.OpenPriceRequest = UNKNOWN_REQUEST_PRICE; // MT4ORDERS::CheckPositionOpenPriceRequest()
    MT4ORDERS::Order.TicketOpen = UNKNOWN_TICKET;
//    MT4ORDERS::Order.OpenReason = UNKNOWN_REASON;

    return;
  }

// #undef UNKNOWN_REASON
#undef UNKNOWN_TICKET
#undef UNKNOWN_REQUEST_PRICE
#undef UNKNOWN_COMMISSION

  static void GetOrderData( void )
  {
    MT4ORDERS::Order.Ticket = ORDER_SELECT;

    return;
  }

  static void GetHistoryOrderData( const ulong Ticket )
  {
    MT4ORDERS::Order.Ticket = ::HistoryOrderGetInteger(Ticket, ORDER_TICKET);
    MT4ORDERS::Order.Type = (int)::HistoryOrderGetInteger(Ticket, ORDER_TYPE);

    MT4ORDERS::Order.TicketOpen = MT4ORDERS::Order.Ticket;

    MT4ORDERS::Order.Lots = ::HistoryOrderGetDouble(Ticket, ORDER_VOLUME_CURRENT);

    if (!MT4ORDERS::Order.Lots)
      MT4ORDERS::Order.Lots = ::HistoryOrderGetDouble(Ticket, ORDER_VOLUME_INITIAL);

    MT4ORDERS::Order.Symbol = ::HistoryOrderGetString(Ticket, ORDER_SYMBOL);
    MT4ORDERS::Order.Comment = ::HistoryOrderGetString(Ticket, ORDER_COMMENT);

    MT4ORDERS::Order.OpenTimeMsc = ::HistoryOrderGetInteger(Ticket, ORDER_TIME_SETUP_MSC);
    MT4ORDERS::Order.OpenTime = (datetime)(MT4ORDERS::Order.OpenTimeMsc / 1000);

    MT4ORDERS::Order.OpenPrice = ::HistoryOrderGetDouble(Ticket, ORDER_PRICE_OPEN);
    MT4ORDERS::Order.OpenPriceRequest = MT4ORDERS::Order.OpenPrice;

    MT4ORDERS::Order.OpenReason = (ENUM_DEAL_REASON)::HistoryOrderGetInteger(Ticket, ORDER_REASON);

    MT4ORDERS::Order.StopLoss = ::HistoryOrderGetDouble(Ticket, ORDER_SL);
    MT4ORDERS::Order.TakeProfit = ::HistoryOrderGetDouble(Ticket, ORDER_TP);

    MT4ORDERS::Order.CloseTimeMsc = ::HistoryOrderGetInteger(Ticket, ORDER_TIME_DONE_MSC);
    MT4ORDERS::Order.CloseTime = (datetime)(MT4ORDERS::Order.CloseTimeMsc / 1000);

    MT4ORDERS::Order.ClosePrice = ::HistoryOrderGetDouble(Ticket, ORDER_PRICE_CURRENT);
    MT4ORDERS::Order.ClosePriceRequest = MT4ORDERS::Order.ClosePrice;

    MT4ORDERS::Order.CloseReason = MT4ORDERS::Order.OpenReason;

    MT4ORDERS::Order.State = (ENUM_ORDER_STATE)::HistoryOrderGetInteger(Ticket, ORDER_STATE);

    MT4ORDERS::Order.Expiration = (datetime)::HistoryOrderGetInteger(Ticket, ORDER_TIME_EXPIRATION);

    MT4ORDERS::Order.MagicNumber = ::HistoryOrderGetInteger(Ticket, ORDER_MAGIC);

    MT4ORDERS::Order.Profit = 0;

    MT4ORDERS::Order.Commission = 0;
    MT4ORDERS::Order.Swap = 0;

    return;
  }

  static void GetHistoryPositionData( const ulong Ticket )
  {
    MT4ORDERS::Order.Ticket = (long)Ticket;
    MT4ORDERS::Order.Type = (int)::HistoryDealGetInteger(Ticket, DEAL_TYPE);

    if ((MT4ORDERS::Order.Type > OP_SELL))
      MT4ORDERS::Order.Type += (OP_BALANCE - OP_SELL - 1);
    else
      MT4ORDERS::Order.Type = 1 - MT4ORDERS::Order.Type;

    MT4ORDERS::Order.Lots = ::HistoryDealGetDouble(Ticket, DEAL_VOLUME);

    MT4ORDERS::Order.Symbol = ::HistoryDealGetString(Ticket, DEAL_SYMBOL);
    MT4ORDERS::Order.Comment = ::HistoryDealGetString(Ticket, DEAL_COMMENT);

    MT4ORDERS::Order.CloseTimeMsc = ::HistoryDealGetInteger(Ticket, DEAL_TIME_MSC);
    MT4ORDERS::Order.CloseTime = (datetime)(MT4ORDERS::Order.CloseTimeMsc / 1000); // (datetime)::HistoryDealGetInteger(Ticket, DEAL_TIME);

    MT4ORDERS::Order.ClosePrice = ::HistoryDealGetDouble(Ticket, DEAL_PRICE);

    MT4ORDERS::Order.CloseReason = (ENUM_DEAL_REASON)::HistoryDealGetInteger(Ticket, DEAL_REASON);;

    MT4ORDERS::Order.Expiration = 0;

    MT4ORDERS::Order.MagicNumber = ::HistoryDealGetInteger(Ticket, DEAL_MAGIC);

    MT4ORDERS::Order.Profit = ::HistoryDealGetDouble(Ticket, DEAL_PROFIT);

    MT4ORDERS::Order.Commission = ::HistoryDealGetDouble(Ticket, DEAL_COMMISSION);
    MT4ORDERS::Order.Swap = ::HistoryDealGetDouble(Ticket, DEAL_SWAP);

    const ulong OrderTicket = ::HistoryDealGetInteger(Ticket, DEAL_ORDER);
    const ulong PosTicket = ::HistoryDealGetInteger(Ticket, DEAL_POSITION_ID);
    const ulong OpenTicket = (OrderTicket > 0) ? MT4ORDERS::History.GetPositionDealIn(PosTicket) : 0;

    if (OpenTicket > 0)
    {
      const ENUM_DEAL_REASON Reason = (ENUM_DEAL_REASON)HistoryDealGetInteger(Ticket, DEAL_REASON);
      const ENUM_DEAL_ENTRY DealEntry = (ENUM_DEAL_ENTRY)::HistoryDealGetInteger(Ticket, DEAL_ENTRY);

    // История (OpenTicket и OrderTicket) подгружена, благодаря GetPositionDealIn, - HistorySelectByPosition
    #ifndef MT4ORDERS_FASTHISTORY_OFF
      if (MT4ORDERS::HistorySelectOrder(OrderTicket) && MT4ORDERS::HistorySelectDeal(OpenTicket))
    #endif // MT4ORDERS_FASTHISTORY_OFF
      {
        MT4ORDERS::Order.TicketOpen = (long)OpenTicket;

        MT4ORDERS::Order.OpenReason = Reason;

        MT4ORDERS::Order.State = (ENUM_ORDER_STATE)::HistoryOrderGetInteger(OrderTicket, ORDER_STATE);

        // Перевернуто - не ошибка: см. OrderClose.
        MT4ORDERS::Order.StopLoss = ::HistoryOrderGetDouble(OrderTicket, (Reason == DEAL_REASON_SL) ? ORDER_PRICE_OPEN : ORDER_TP);
        MT4ORDERS::Order.TakeProfit = ::HistoryOrderGetDouble(OrderTicket, (Reason == DEAL_REASON_TP) ? ORDER_PRICE_OPEN : ORDER_SL);

        MT4ORDERS::Order.OpenPrice = ::HistoryDealGetDouble(OpenTicket, DEAL_PRICE);

        MT4ORDERS::Order.OpenTimeMsc = ::HistoryDealGetInteger(OpenTicket, DEAL_TIME_MSC);
        MT4ORDERS::Order.OpenTime = (datetime)(MT4ORDERS::Order.OpenTimeMsc / 1000);

        const double OpenLots = ::HistoryDealGetDouble(OpenTicket, DEAL_VOLUME);

        if (OpenLots > 0)
          MT4ORDERS::Order.Commission += ::HistoryDealGetDouble(OpenTicket, DEAL_COMMISSION) * MT4ORDERS::Order.Lots / OpenLots;

        if (!MT4ORDERS::Order.MagicNumber)
          MT4ORDERS::Order.MagicNumber = ::HistoryDealGetInteger(OpenTicket, DEAL_MAGIC);

        if (MT4ORDERS::Order.Comment == "")
          MT4ORDERS::Order.Comment = ::HistoryDealGetString(OpenTicket, DEAL_COMMENT);

        if (!(MT4ORDERS::Order.ClosePriceRequest = (DealEntry == DEAL_ENTRY_OUT_BY) ?
                                                   MT4ORDERS::Order.ClosePrice : ::HistoryOrderGetDouble(OrderTicket, ORDER_PRICE_OPEN)))
          MT4ORDERS::Order.ClosePriceRequest = MT4ORDERS::Order.ClosePrice;

        if (!(MT4ORDERS::Order.OpenPriceRequest = (MT4ORDERS::HistorySelectOrder(PosTicket) &&
                                                  // А нужна ли эта проверка?
                                                  (MT4ORDERS::IsTester || (::HistoryDealGetInteger(OpenTicket, DEAL_TIME_MSC) == ::HistoryOrderGetInteger(PosTicket, ORDER_TIME_DONE_MSC)))) ?
                                                 ::HistoryOrderGetDouble(PosTicket, ORDER_PRICE_OPEN) : MT4ORDERS::Order.OpenPrice))
          MT4ORDERS::Order.OpenPriceRequest = MT4ORDERS::Order.OpenPrice;
      }
    }
    else
    {
      MT4ORDERS::Order.TicketOpen = MT4ORDERS::Order.Ticket;

      MT4ORDERS::Order.StopLoss = 0; // ::HistoryDealGetDouble(Ticket, DEAL_SL);
      MT4ORDERS::Order.TakeProfit = 0; // ::HistoryDealGetDouble(Ticket, DEAL_TP);

      MT4ORDERS::Order.OpenPrice = MT4ORDERS::Order.ClosePrice; // ::HistoryDealGetDouble(Ticket, DEAL_PRICE);

      MT4ORDERS::Order.OpenTimeMsc = MT4ORDERS::Order.CloseTimeMsc;
      MT4ORDERS::Order.OpenTime = MT4ORDERS::Order.CloseTime;   // (datetime)::HistoryDealGetInteger(Ticket, DEAL_TIME);

      MT4ORDERS::Order.OpenReason = MT4ORDERS::Order.CloseReason;

      MT4ORDERS::Order.State = ORDER_STATE_FILLED;

      MT4ORDERS::Order.ClosePriceRequest = MT4ORDERS::Order.ClosePrice;
      MT4ORDERS::Order.OpenPriceRequest = MT4ORDERS::Order.OpenPrice;
    }

    return;
  }

  static bool Waiting( const bool FlagInit = false )
  {
    static ulong StartTime = 0;

    const bool Res = FlagInit ? false : (::GetMicrosecondCount() - StartTime < MT4ORDERS::OrderSend_MaxPause);

    if (FlagInit)
    {
      StartTime = ::GetMicrosecondCount();

      MT4ORDERS::OrderSendBug = false;
    }
    else if (Res)
    {
      ::Sleep(0);

      MT4ORDERS::OrderSendBug = true;
    }

    return(Res);
  }

  static bool EqualPrices( const double Price1, const double &Price2, const int &digits)
  {
    return(!::NormalizeDouble(Price1 - Price2, digits));
  }

  static bool HistoryDealSelect( MqlTradeResult &Result )
  {
    // Заменить HistorySelectByPosition на HistorySelect(PosTime, PosTime)
    if (!Result.deal && Result.order && ::HistorySelectByPosition(::HistoryOrderGetInteger(Result.order, ORDER_POSITION_ID)))
      for (int i = ::HistoryDealsTotal() - 1; i >= 0; i--)
      {
        const ulong DealTicket = ::HistoryDealGetTicket(i);

        if (Result.order == ::HistoryDealGetInteger(DealTicket, DEAL_ORDER))
        {
          Result.deal = DealTicket;

          break;
        }
      }

    return(::HistoryDealSelect(Result.deal));
  }

/*
#define MT4ORDERS_BENCHMARK Alert(MT4ORDERS::LastTradeRequest.symbol + " " +       \
                                  (string)MT4ORDERS::LastTradeResult.order + " " + \
                                  MT4ORDERS::LastTradeResult.comment);             \
                            Print(ToString(MT4ORDERS::LastTradeRequest) +          \
                                  ToString(MT4ORDERS::LastTradeResult));
*/

#define TMP_MT4ORDERS_BENCHMARK(A) \
  static ulong Max##A = 0;         \
                                   \
  if (Interval##A > Max##A)        \
  {                                \
    MT4ORDERS_BENCHMARK            \
                                   \
    Max##A = Interval##A;          \
  }

  static void OrderSend_Benchmark( const ulong &Interval1, const ulong &Interval2 )
  {
    #ifdef MT4ORDERS_BENCHMARK
      TMP_MT4ORDERS_BENCHMARK(1)
      TMP_MT4ORDERS_BENCHMARK(2)
    #endif // MT4ORDERS_BENCHMARK

    return;
  }

#undef TMP_MT4ORDERS_BENCHMARK

#define TOSTR(A)  #A + " = " + (string)(A) + "\n"
#define TOSTR2(A) #A + " = " + EnumToString(A) + " (" + (string)(A) + ")\n"

  static string ToString( const MqlTradeRequest &Request )
  {
    return(TOSTR2(Request.action) + TOSTR(Request.magic) + TOSTR(Request.order) +
           TOSTR(Request.symbol) + TOSTR(Request.volume) + TOSTR(Request.price) +
           TOSTR(Request.stoplimit) + TOSTR(Request.sl) +  TOSTR(Request.tp) +
           TOSTR(Request.deviation) + TOSTR2(Request.type) + TOSTR2(Request.type_filling) +
           TOSTR2(Request.type_time) + TOSTR(Request.expiration) + TOSTR(Request.comment) +
           TOSTR(Request.position) + TOSTR(Request.position_by));
  }

  static string ToString( const MqlTradeResult &Result )
  {
    return(TOSTR(Result.retcode) + TOSTR(Result.deal) + TOSTR(Result.order) +
           TOSTR(Result.volume) + TOSTR(Result.price) + TOSTR(Result.bid) +
           TOSTR(Result.ask) + TOSTR(Result.comment) + TOSTR(Result.request_id) +
           TOSTR(Result.retcode_external));
  }


#define WHILE(A) while ((!(Res = (A))) && MT4ORDERS::Waiting())

  static bool OrderSend( const MqlTradeRequest &Request, MqlTradeResult &Result )
  {
    const ulong StartTime1 = MT4ORDERS::IsTester ? 0 : ::GetMicrosecondCount();

    bool Res = ::OrderSend(Request, Result);

    const ulong Interval1 = MT4ORDERS::IsTester ? 0 : (::GetMicrosecondCount() - StartTime1);

    const ulong StartTime2 = MT4ORDERS::IsTester ? 0 : ::GetMicrosecondCount();

    if (Res && !MT4ORDERS::IsTester && (Result.retcode < TRADE_RETCODE_ERROR) && (MT4ORDERS::OrderSend_MaxPause > 0))
    {
      Res = (Result.retcode == TRADE_RETCODE_DONE);
      MT4ORDERS::Waiting(true);

      // TRADE_ACTION_CLOSE_BY отсутствует в перечне проверок
      if (Request.action == TRADE_ACTION_DEAL)
      {
        if (!Result.deal)
        {
          WHILE(::OrderSelect(Result.order))
            ;

          if (!Res)
            ::Print(TOSTR(::OrderSelect(Result.order)));
          else if (!(Res = ((ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE) == ORDER_STATE_PLACED) ||
                           ((ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE) == ORDER_STATE_PARTIAL)))
            ::Print(TOSTR2((ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE)));
        }

        if (Res)
        {
          const bool ResultDeal = (!Result.deal) && (!MT4ORDERS::OrderSendBug);

          if (MT4ORDERS::OrderSendBug && (!Result.deal))
            ::Print(TOSTR(Result.deal));

          WHILE(::HistoryOrderSelect(Result.order))
            ;

          // Если ранее не было OrderSend-бага и был Result.deal == 0
          if (ResultDeal)
            MT4ORDERS::OrderSendBug = false;

          if (!Res)
            ::Print(TOSTR(::HistoryOrderSelect(Result.order)));
          else if (!(Res = ((ENUM_ORDER_STATE)::HistoryOrderGetInteger(Result.order, ORDER_STATE) == ORDER_STATE_FILLED) ||
                           ((ENUM_ORDER_STATE)::HistoryOrderGetInteger(Result.order, ORDER_STATE) == ORDER_STATE_PARTIAL)))
            ::Print(TOSTR2((ENUM_ORDER_STATE)::HistoryOrderGetInteger(Result.order, ORDER_STATE)));
        }

        if (Res)
        {
          const bool ResultDeal = (!Result.deal) && (!MT4ORDERS::OrderSendBug);

          if (MT4ORDERS::OrderSendBug && (!Result.deal))
            ::Print(TOSTR(Result.deal));

          WHILE(MT4ORDERS::HistoryDealSelect(Result))
            ;

          // Если ранее не было OrderSend-бага и был Result.deal == 0
          if (ResultDeal)
            MT4ORDERS::OrderSendBug = false;

          if (!Res)
            ::Print(TOSTR(MT4ORDERS::HistoryDealSelect(Result)));
        }
      }
      else if (Request.action == TRADE_ACTION_PENDING)
      {
        if (Res)
        {
          WHILE(::OrderSelect(Result.order))
            ;

          if (!Res)
            ::Print(TOSTR(::OrderSelect(Result.order)));
          else if (!(Res = ((ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE) == ORDER_STATE_PLACED) ||
                           ((ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE) == ORDER_STATE_PARTIAL)))
            ::Print(TOSTR2((ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE)));
        }
        else
        {
          WHILE(::HistoryOrderSelect(Result.order))
            ;

          ::Print(TOSTR(::HistoryOrderSelect(Result.order)));

          Res = false;
        }
      }
      else if (Request.action == TRADE_ACTION_SLTP)
      {
        if (Res)
        {
          const int digits = (int)::SymbolInfoInteger(Request.symbol, SYMBOL_DIGITS);

          bool EqualSL = false;
          bool EqualTP = false;

          do
            if (Request.position ? ::PositionSelectByTicket(Request.position) : ::PositionSelect(Request.symbol))
            {
              EqualSL = MT4ORDERS::EqualPrices(::PositionGetDouble(POSITION_SL), Request.sl, digits);
              EqualTP = MT4ORDERS::EqualPrices(::PositionGetDouble(POSITION_TP), Request.tp, digits);
            }
          WHILE(EqualSL && EqualTP);

          if (!Res)
            ::Print(TOSTR(::PositionGetDouble(POSITION_SL)) + TOSTR(::PositionGetDouble(POSITION_TP)) +
                    TOSTR(EqualSL) + TOSTR(EqualTP) +
                    TOSTR(Request.position ? ::PositionSelectByTicket(Request.position) : ::PositionSelect(Request.symbol)));
        }
      }
      else if (Request.action == TRADE_ACTION_MODIFY)
      {
        if (Res)
        {
          const int digits = (int)::SymbolInfoInteger(Request.symbol, SYMBOL_DIGITS);

          bool EqualSL = false;
          bool EqualTP = false;
          bool EqualPrice = false;

          do
            if (::OrderSelect(Result.order) && ((ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE) != ORDER_STATE_REQUEST_MODIFY))
            {
              EqualSL = MT4ORDERS::EqualPrices(::OrderGetDouble(ORDER_SL), Request.sl, digits);
              EqualTP = MT4ORDERS::EqualPrices(::OrderGetDouble(ORDER_TP), Request.tp, digits);
              EqualPrice = MT4ORDERS::EqualPrices(::OrderGetDouble(ORDER_PRICE_OPEN), Request.price, digits);
            }
          WHILE((EqualSL && EqualTP && EqualPrice));

          if (!Res)
            ::Print(TOSTR(::OrderGetDouble(ORDER_SL)) + TOSTR(Request.sl)+
                    TOSTR(::OrderGetDouble(ORDER_TP)) + TOSTR(Request.tp) +
                    TOSTR(::OrderGetDouble(ORDER_PRICE_OPEN)) + TOSTR(Request.price) +
                    TOSTR(EqualSL) + TOSTR(EqualTP) + TOSTR(EqualPrice) +
                    TOSTR(::OrderSelect(Result.order)) +
                    TOSTR2((ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE)));
        }
      }
      else if (Request.action == TRADE_ACTION_REMOVE)
      {
        if (Res)
          WHILE(::HistoryOrderSelect(Result.order))
            ;

        if (!Res)
          ::Print(TOSTR(::HistoryOrderSelect(Result.order)));
      }

      const ulong Interval2 = ::GetMicrosecondCount() - StartTime2;

      Result.comment += " " + ::DoubleToString(Interval1 / 1000.0, 3) + " + " + ::DoubleToString(Interval2 / 1000.0, 3) + " ms";

      if (!Res || MT4ORDERS::OrderSendBug)
      {
        //::Alert(Res ? "OrderSend - BUG!" : "MT4ORDERS - not Sync with History!");
        //::Alert("Please send the logs to the author - https://www.mql5.com/en/users/fxsaber");

        ::Print(TOSTR(::AccountInfoString(ACCOUNT_SERVER)) + TOSTR((bool)::TerminalInfoInteger(TERMINAL_CONNECTED)) +
                TOSTR(::TerminalInfoInteger(TERMINAL_PING_LAST)) + TOSTR(::TerminalInfoDouble(TERMINAL_RETRANSMISSION)) +
                TOSTR(::TerminalInfoInteger(TERMINAL_BUILD)) + TOSTR((bool)::TerminalInfoInteger(TERMINAL_X64)) +
                TOSTR(Res) + TOSTR(MT4ORDERS::OrderSendBug) +
                MT4ORDERS::ToString(Request) + MT4ORDERS::ToString(Result));

        Print( "MT4ORDERS: ", (Res ? "OrderSend - BUG!" : "not Sync with History!"), ", please, send logs to the owner!" );
      }
      else
        MT4ORDERS::OrderSend_Benchmark(Interval1, Interval2);
    }
    else if (!MT4ORDERS::IsTester)
    {
      Result.comment += " " + ::DoubleToString(Interval1 / 1000.0, 3) + " ms";

      ::Print(MT4ORDERS::ToString(Request) + MT4ORDERS::ToString(Result));

//      ExpertRemove();
    }

    return(Res);
  }

#undef WHILE
#undef TOSTR2
#undef TOSTR

  static ENUM_DAY_OF_WEEK GetDayOfWeek( const datetime &time )
  {
    MqlDateTime sTime = {0};

    ::TimeToStruct(time, sTime);

    return((ENUM_DAY_OF_WEEK)sTime.day_of_week);
  }

  static bool SessionTrade( const string &Symb )
  {
    datetime TimeNow = ::TimeCurrent();

    const ENUM_DAY_OF_WEEK DayOfWeek = MT4ORDERS::GetDayOfWeek(TimeNow);

    TimeNow %= 24 * 60 * 60;

    bool Res = false;
    datetime From, To;

    for (int i = 0; (!Res) && ::SymbolInfoSessionTrade(Symb, DayOfWeek, i, From, To); i++)
      Res = ((From <= TimeNow) && (TimeNow < To));

    return(Res);
  }

  static bool SymbolTrade( const string &Symb )
  {
    MqlTick Tick;

    return(::SymbolInfoTick(Symb, Tick) ? (Tick.bid && Tick.ask && MT4ORDERS::SessionTrade(Symb) /* &&
           ((ENUM_SYMBOL_TRADE_MODE)::SymbolInfoInteger(Symb, SYMBOL_TRADE_MODE) == SYMBOL_TRADE_MODE_FULL) */) : false);
  }

  static bool NewOrderCheck( void )
  {
    return(::OrderCheck(MT4ORDERS::LastTradeRequest, MT4ORDERS::LastTradeCheckResult) &&
           (MT4ORDERS::IsTester || MT4ORDERS::SymbolTrade(MT4ORDERS::LastTradeRequest.symbol)));
  }

  static bool NewOrderSend( const int &Check )
  {
    return((Check == INT_MAX) ? MT4ORDERS::NewOrderCheck() :
           (((Check != INT_MIN) || MT4ORDERS::NewOrderCheck()) && MT4ORDERS::OrderSend(MT4ORDERS::LastTradeRequest, MT4ORDERS::LastTradeResult) ? MT4ORDERS::LastTradeResult.retcode < TRADE_RETCODE_ERROR : false));
  }

  static bool ModifyPosition( const long &Ticket, MqlTradeRequest &Request )
  {
    const bool Res = ::PositionSelectByTicket(Ticket);

    if (Res)
    {
      Request.action = TRADE_ACTION_SLTP;

      Request.position = Ticket;
      Request.symbol = ::PositionGetString(POSITION_SYMBOL); // указания одного тикета не достаточно!
    }

    return(Res);
  }

  static ENUM_ORDER_TYPE_FILLING GetFilling( const string &Symb, const uint Type = ORDER_FILLING_FOK )
  {
    static ENUM_ORDER_TYPE_FILLING Res = ORDER_FILLING_FOK;
    static string LastSymb = NULL;
    static uint LastType = ORDER_FILLING_FOK;

    const bool SymbFlag = (LastSymb != Symb);

    if (SymbFlag || (LastType != Type))
    {
      LastType = Type;

      if (SymbFlag)
        LastSymb = Symb;

      const ENUM_SYMBOL_TRADE_EXECUTION ExeMode = (ENUM_SYMBOL_TRADE_EXECUTION)::SymbolInfoInteger(Symb, SYMBOL_TRADE_EXEMODE);
      const int FillingMode = (int)::SymbolInfoInteger(Symb, SYMBOL_FILLING_MODE);

      Res = (!FillingMode || (Type >= ORDER_FILLING_RETURN) || ((FillingMode & (Type + 1)) != Type + 1)) ?
            (((ExeMode == SYMBOL_TRADE_EXECUTION_EXCHANGE) || (ExeMode == SYMBOL_TRADE_EXECUTION_INSTANT)) ?
             ORDER_FILLING_RETURN : ((FillingMode == SYMBOL_FILLING_IOC) ? ORDER_FILLING_IOC : ORDER_FILLING_FOK)) :
            (ENUM_ORDER_TYPE_FILLING)Type;
    }

    return(Res);
  }

  static ENUM_ORDER_TYPE_TIME GetExpirationType( const string &Symb, uint Expiration = ORDER_TIME_GTC )
  {
    static ENUM_ORDER_TYPE_TIME Res = ORDER_TIME_GTC;
    static string LastSymb = NULL;
    static uint LastExpiration = ORDER_TIME_GTC;

    const bool SymbFlag = (LastSymb != Symb);

    if ((LastExpiration != Expiration) || SymbFlag)
    {
      LastExpiration = Expiration;

      if (SymbFlag)
        LastSymb = Symb;

      const int ExpirationMode = (int)::SymbolInfoInteger(Symb, SYMBOL_EXPIRATION_MODE);

      if ((Expiration > ORDER_TIME_SPECIFIED_DAY) || (!((ExpirationMode >> Expiration) & 1)))
      {
        if ((Expiration < ORDER_TIME_SPECIFIED) || (ExpirationMode < SYMBOL_EXPIRATION_SPECIFIED))
          Expiration = ORDER_TIME_GTC;
        else if (Expiration > ORDER_TIME_DAY)
          Expiration = ORDER_TIME_SPECIFIED;

        uint i = 1 << Expiration;

        while ((Expiration <= ORDER_TIME_SPECIFIED_DAY) && ((ExpirationMode & i) != i))
        {
          i <<= 1;
          Expiration++;
        }
      }

      Res = (ENUM_ORDER_TYPE_TIME)Expiration;
    }

    return(Res);
  }

  static bool ModifyOrder( const long &Ticket, const double &Price, const datetime &Expiration, MqlTradeRequest &Request )
  {
    const bool Res = ::OrderSelect(Ticket);

    if (Res)
    {
      Request.action = TRADE_ACTION_MODIFY;
      Request.order = Ticket;

      Request.price = Price;

      Request.symbol = ::OrderGetString(ORDER_SYMBOL);

      // https://www.mql5.com/ru/forum/1111/page1817#comment_4087275
//      Request.type_filling = (ENUM_ORDER_TYPE_FILLING)::OrderGetInteger(ORDER_TYPE_FILLING);
      Request.type_filling = MT4ORDERS::GetFilling(Request.symbol);
      Request.type_time = MT4ORDERS::GetExpirationType(Request.symbol, (uint)Expiration);

      if (Expiration > ORDER_TIME_DAY)
        Request.expiration = Expiration;
    }

    return(Res);
  }

  static bool SelectByPosHistory( const int Index )
  {
    const long Ticket = MT4ORDERS::History[Index];
    const bool Res = (Ticket > 0) ? ::HistoryDealSelect(Ticket) : ((Ticket < 0) ? ::HistoryOrderSelect(-Ticket) : false);

    if (Res)
    {
      if (Ticket > 0)
        MT4ORDERS::GetHistoryPositionData(Ticket);
      else
        MT4ORDERS::GetHistoryOrderData(-Ticket);
    }

    return(Res);
  }

  static bool OrderVisible( void )
  {
/*
    const ENUM_ORDER_STATE OrderState = (ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE);

    return((OrderState == ORDER_STATE_PLACED) || (OrderState == ORDER_STATE_PARTIAL)); */

    return((!OrderGetInteger(ORDER_POSITION_ID))/* && (!OrderGetInteger(ORDER_POSITION_BY_ID))*/);
  }

  static ulong OrderGetTicket( const int Index )
  {
    ulong Res = 0;

    const int Total = ::OrdersTotal();

    if (Index < Total)
    {
      const long PrevTicket = ::OrderGetInteger(ORDER_TICKET);

      int Count = 0;

      for (int i = 0; i < Total; i++)
      {
        const ulong Ticket = ::OrderGetTicket(i);

        if (Ticket && MT4ORDERS::OrderVisible())
        {
          if (Count == Index)
          {
            Res = Ticket;

            break;
          }

          Count++;
        }
      }

      if (!Res)
        const bool AntiWarning = ::OrderSelect(PrevTicket);
    }

    return(Res);
  }

  // С одним и тем же тикетом приоритет выбора позиции выше ордера
  static bool SelectByPos( const int Index )
  {
    const int Total = ::PositionsTotal();
    const bool Flag = (Index < Total);

    const bool Res = (Flag) ? ::PositionGetTicket(Index) :
                                                         #ifdef MT4ORDERS_SELECTFILTER_OFF
                                                           ::OrderGetTicket(Index - Total);
                                                         #else // MT4ORDERS_SELECTFILTER_OFF
                                                           (MT4ORDERS::IsTester ? ::OrderGetTicket(Index - Total) : MT4ORDERS::OrderGetTicket(Index - Total));
                                                         #endif //MT4ORDERS_SELECTFILTER_OFF

    if (Res)
    {
      if (Flag)
        MT4ORDERS::GetPositionData();
      else
        MT4ORDERS::GetOrderData();
    }

    return(Res);
  }

  static bool SelectByHistoryTicket( const long &Ticket )
  {
    bool Res = ::HistoryDealSelect(Ticket) ? MT4HISTORY::IsMT4Deal(Ticket) : false;

    if (Res)
      MT4ORDERS::GetHistoryPositionData(Ticket);
    else
    {
      Res = ::HistoryOrderSelect(Ticket) ? MT4HISTORY::IsMT4Order(Ticket) : false;

      if (Res)
        MT4ORDERS::GetHistoryOrderData(Ticket);
    }

    return(Res);
  }

  static bool SelectByExistingTicket( const long &Ticket )
  {
    bool Res = true;

    if (::PositionSelectByTicket(Ticket))
      MT4ORDERS::GetPositionData();
    else if (::OrderSelect(Ticket))
      MT4ORDERS::GetOrderData();
    else
      Res = false;

    return(Res);
  }

  // С одним и тем же тикетом приоритеты выбора:
  // MODE_TRADES:  существующая позиция > существующий ордер > сделка > отмененный ордер
  // MODE_HISTORY: сделка > отмененный ордер > существующая позиция > существующий ордер
  static bool SelectByTicket( const long &Ticket, const int &Pool )
  {
    return((Pool == MODE_TRADES) ?
           (MT4ORDERS::SelectByExistingTicket(Ticket) ? true : MT4ORDERS::SelectByHistoryTicket(Ticket)) :
           (MT4ORDERS::SelectByHistoryTicket(Ticket) ? true : MT4ORDERS::SelectByExistingTicket(Ticket)));
  }

  static void CheckPrices( double &MinPrice, double &MaxPrice, const double Min, const double Max )
  {
    if (MinPrice && (MinPrice >= Min))
      MinPrice = 0;

    if (MaxPrice && (MaxPrice <= Max))
      MaxPrice = 0;

    return;
  }

public:
  static uint OrderSend_MaxPause; // максимальное время на синхронизацию в мкс.

  static MqlTradeResult LastTradeResult;
  static MqlTradeRequest LastTradeRequest;
  static MqlTradeCheckResult LastTradeCheckResult;

  static bool MT4OrderSelect( const long &Index, const int &Select, const int &Pool )
  {
    return((Select == SELECT_BY_POS) ?
           ((Pool == MODE_TRADES) ? MT4ORDERS::SelectByPos((int)Index) : MT4ORDERS::SelectByPosHistory((int)Index)) :
           MT4ORDERS::SelectByTicket(Index, Pool));
  }

  // Такая "перегрузка" позволяет использоваться совместно и MT5-вариант OrderSelect
  static bool MT4OrderSelect( const ulong &Ticket )
  {
    return(::OrderSelect(Ticket));
  }

  static int OrdersTotal( void )
  {
    int Res = 0;

    const long PrevTicket = ::OrderGetInteger(ORDER_TICKET);

    for (int i = ::OrdersTotal() - 1; i >= 0; i--)
      if (::OrderGetTicket(i) && MT4ORDERS::OrderVisible())
        Res++;

    const bool AntiWarning = ::OrderSelect(PrevTicket);

    return(Res);
  }

  static int MT4OrdersTotal( void )
  {
    return(::PositionsTotal() +
                              #ifdef MT4ORDERS_SELECTFILTER_OFF
                                ::OrdersTotal()
                              #else // MT4ORDERS_SELECTFILTER_OFF
                                (MT4ORDERS::IsTester ? ::OrdersTotal() : MT4ORDERS::OrdersTotal())
                              #endif //MT4ORDERS_SELECTFILTER_OFF
          );
  }

  // Такая "перегрузка" позволяет использоваться совместно и MT5-вариант OrdersTotal
  static int MT4OrdersTotal( const bool )
  {
    return(::OrdersTotal());
  }

  static int MT4OrdersHistoryTotal( void )
  {
    return(MT4ORDERS::History.GetAmount());
  }

  static long MT4OrderSend( const string &Symb, const int &Type, const double &dVolume, const double &Price, const int &SlipPage, const double &SL, const double &TP,
                            const string &comment, const MAGIC_TYPE &magic, const datetime &dExpiration, const color &arrow_color )

  {
    ::ZeroMemory(MT4ORDERS::LastTradeRequest);

    MT4ORDERS::LastTradeRequest.action = (((Type == OP_BUY) || (Type == OP_SELL)) ? TRADE_ACTION_DEAL : TRADE_ACTION_PENDING);
    MT4ORDERS::LastTradeRequest.magic = magic;

    MT4ORDERS::LastTradeRequest.symbol = ((Symb == NULL) ? ::Symbol() : Symb);
    MT4ORDERS::LastTradeRequest.volume = dVolume;
    MT4ORDERS::LastTradeRequest.price = Price;

    MT4ORDERS::LastTradeRequest.tp = TP;
    MT4ORDERS::LastTradeRequest.sl = SL;
    MT4ORDERS::LastTradeRequest.deviation = SlipPage;
    MT4ORDERS::LastTradeRequest.type = (ENUM_ORDER_TYPE)Type;

    MT4ORDERS::LastTradeRequest.type_filling = MT4ORDERS::GetFilling(MT4ORDERS::LastTradeRequest.symbol, (uint)MT4ORDERS::LastTradeRequest.deviation);

    if (MT4ORDERS::LastTradeRequest.action == TRADE_ACTION_PENDING)
    {
      MT4ORDERS::LastTradeRequest.type_time = MT4ORDERS::GetExpirationType(MT4ORDERS::LastTradeRequest.symbol, (uint)dExpiration);

      if (dExpiration > ORDER_TIME_DAY)
        MT4ORDERS::LastTradeRequest.expiration = dExpiration;
    }

    if (comment != NULL)
      MT4ORDERS::LastTradeRequest.comment = comment;

    return((arrow_color == INT_MAX) ? (MT4ORDERS::NewOrderCheck() ? 0 : -1) :
           ((((int)arrow_color != INT_MIN) || MT4ORDERS::NewOrderCheck()) &&
            MT4ORDERS::OrderSend(MT4ORDERS::LastTradeRequest, MT4ORDERS::LastTradeResult) ?
            (MT4ORDERS::IsHedging ? (long)MT4ORDERS::LastTradeResult.order : // PositionID == Result.order - особенность MT5-Hedge
             ((MT4ORDERS::LastTradeRequest.action == TRADE_ACTION_DEAL) ?
              (MT4ORDERS::IsTester ? (::PositionSelect(MT4ORDERS::LastTradeRequest.symbol) ? PositionGetInteger(POSITION_TICKET) : 0) :
                                      // HistoryDealSelect в MT4ORDERS::OrderSend
                                      ::HistoryDealGetInteger(MT4ORDERS::LastTradeResult.deal, DEAL_POSITION_ID)) :
              (long)MT4ORDERS::LastTradeResult.order)) : -1));
  }

  static bool MT4OrderModify( const long &Ticket, const double &Price, const double &SL, const double &TP, const datetime &Expiration, const color &Arrow_Color )
  {
    ::ZeroMemory(MT4ORDERS::LastTradeRequest);

               // Учитывается случай, когда присутствуют ордер и позиция с одним и тем же тикетом
    bool Res = ((Ticket != MT4ORDERS::Order.Ticket) || (MT4ORDERS::Order.Ticket <= OP_SELL)) ?
               (MT4ORDERS::ModifyPosition(Ticket, MT4ORDERS::LastTradeRequest) ? true : MT4ORDERS::ModifyOrder(Ticket, Price, Expiration, MT4ORDERS::LastTradeRequest)) :
               (MT4ORDERS::ModifyOrder(Ticket, Price, Expiration, MT4ORDERS::LastTradeRequest) ? true : MT4ORDERS::ModifyPosition(Ticket, MT4ORDERS::LastTradeRequest));

//    if (Res) // Игнорируем проверку - есть OrderCheck
    {
      MT4ORDERS::LastTradeRequest.tp = TP;
      MT4ORDERS::LastTradeRequest.sl = SL;

      Res = MT4ORDERS::NewOrderSend(Arrow_Color);
    }

    return(Res);
  }

  static bool MT4OrderClose( const long &Ticket, const double &dLots, const double &Price, const int &SlipPage, const color &Arrow_Color )
  {
    // Есть MT4ORDERS::LastTradeRequest и MT4ORDERS::LastTradeResult, поэтому на результат не влияет, но нужно для PositionGetString ниже
    ::PositionSelectByTicket(Ticket);

    ::ZeroMemory(MT4ORDERS::LastTradeRequest);

    MT4ORDERS::LastTradeRequest.action = TRADE_ACTION_DEAL;
    MT4ORDERS::LastTradeRequest.position = Ticket;

    MT4ORDERS::LastTradeRequest.symbol = ::PositionGetString(POSITION_SYMBOL);

    MT4ORDERS::LastTradeRequest.volume = dLots;
    MT4ORDERS::LastTradeRequest.price = Price;

    // Нужно для определения SL/TP-уровней у закрытой позиции. Перевернуто - не ошибка
    // SYMBOL_SESSION_PRICE_LIMIT_MIN и SYMBOL_SESSION_PRICE_LIMIT_MAX проверять не требуется, т.к. исходные SL/TP уже установлены
    MT4ORDERS::LastTradeRequest.tp = ::PositionGetDouble(POSITION_SL);
    MT4ORDERS::LastTradeRequest.sl = ::PositionGetDouble(POSITION_TP);

    if (MT4ORDERS::LastTradeRequest.tp || MT4ORDERS::LastTradeRequest.sl)
    {
      const double StopLevel = ::SymbolInfoInteger(MT4ORDERS::LastTradeRequest.symbol, SYMBOL_TRADE_STOPS_LEVEL) *
                               ::SymbolInfoDouble(MT4ORDERS::LastTradeRequest.symbol, SYMBOL_POINT);

      const bool FlagBuy = (::PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY);
      const double CurrentPrice = SymbolInfoDouble(MT4ORDERS::LastTradeRequest.symbol, FlagBuy ? SYMBOL_ASK : SYMBOL_BID);

      if (CurrentPrice)
      {
        if (FlagBuy)
          MT4ORDERS::CheckPrices(MT4ORDERS::LastTradeRequest.tp, MT4ORDERS::LastTradeRequest.sl, CurrentPrice - StopLevel, CurrentPrice + StopLevel);
        else
          MT4ORDERS::CheckPrices(MT4ORDERS::LastTradeRequest.sl, MT4ORDERS::LastTradeRequest.tp, CurrentPrice - StopLevel, CurrentPrice + StopLevel);
      }
      else
      {
        MT4ORDERS::LastTradeRequest.tp = 0;
        MT4ORDERS::LastTradeRequest.sl = 0;
      }
    }

    MT4ORDERS::LastTradeRequest.deviation = SlipPage;

    MT4ORDERS::LastTradeRequest.type = (ENUM_ORDER_TYPE)(1 - ::PositionGetInteger(POSITION_TYPE));

    MT4ORDERS::LastTradeRequest.type_filling = MT4ORDERS::GetFilling(MT4ORDERS::LastTradeRequest.symbol, (uint)MT4ORDERS::LastTradeRequest.deviation);

    return(MT4ORDERS::NewOrderSend(Arrow_Color));
  }

  static bool MT4OrderCloseBy( const long &Ticket, const long &Opposite, const color &Arrow_Color )
  {
    ::ZeroMemory(MT4ORDERS::LastTradeRequest);

    MT4ORDERS::LastTradeRequest.action = TRADE_ACTION_CLOSE_BY;
    MT4ORDERS::LastTradeRequest.position = Ticket;
    MT4ORDERS::LastTradeRequest.position_by = Opposite;

    if ((!MT4ORDERS::IsTester) && ::PositionSelectByTicket(Ticket)) // нужен для MT4ORDERS::SymbolTrade()
      MT4ORDERS::LastTradeRequest.symbol = ::PositionGetString(POSITION_SYMBOL);

    return(MT4ORDERS::NewOrderSend(Arrow_Color));
  }

  static bool MT4OrderDelete( const long &Ticket, const color &Arrow_Color )
  {
//    bool Res = ::OrderSelect(Ticket); // Надо ли это, когда нужны MT4ORDERS::LastTradeRequest и MT4ORDERS::LastTradeResult ?

    ::ZeroMemory(MT4ORDERS::LastTradeRequest);

    MT4ORDERS::LastTradeRequest.action = TRADE_ACTION_REMOVE;
    MT4ORDERS::LastTradeRequest.order = Ticket;

    if ((!MT4ORDERS::IsTester) && ::OrderSelect(Ticket)) // нужен для MT4ORDERS::SymbolTrade()
      MT4ORDERS::LastTradeRequest.symbol = ::OrderGetString(ORDER_SYMBOL);

    return(MT4ORDERS::NewOrderSend(Arrow_Color));
  }

#define MT4_ORDERFUNCTION(NAME,T,A,B,C)                               \
  static T MT4Order##NAME( void )                                     \
  {                                                                   \
    return(POSITION_ORDER((T)(A), (T)(B), MT4ORDERS::Order.NAME, C)); \
  }

#define POSITION_ORDER(A,B,C,D) (((MT4ORDERS::Order.Ticket == POSITION_SELECT) && (D)) ? (A) : ((MT4ORDERS::Order.Ticket == ORDER_SELECT) ? (B) : (C)))

  MT4_ORDERFUNCTION(Ticket, long, ::PositionGetInteger(POSITION_TICKET), ::OrderGetInteger(ORDER_TICKET), true)
  MT4_ORDERFUNCTION(Type, int, ::PositionGetInteger(POSITION_TYPE), ::OrderGetInteger(ORDER_TYPE), true)
  MT4_ORDERFUNCTION(Lots, double, ::PositionGetDouble(POSITION_VOLUME), ::OrderGetDouble(ORDER_VOLUME_CURRENT), true)
  MT4_ORDERFUNCTION(OpenPrice, double, ::PositionGetDouble(POSITION_PRICE_OPEN), ::OrderGetDouble(ORDER_PRICE_OPEN), true)
  MT4_ORDERFUNCTION(OpenTimeMsc, long, ::PositionGetInteger(POSITION_TIME_MSC), ::OrderGetInteger(ORDER_TIME_SETUP_MSC), true)
  MT4_ORDERFUNCTION(OpenTime, datetime, ::PositionGetInteger(POSITION_TIME), ::OrderGetInteger(ORDER_TIME_SETUP), true)
  MT4_ORDERFUNCTION(StopLoss, double, ::PositionGetDouble(POSITION_SL), ::OrderGetDouble(ORDER_SL), true)
  MT4_ORDERFUNCTION(TakeProfit, double, ::PositionGetDouble(POSITION_TP), ::OrderGetDouble(ORDER_TP), true)
  MT4_ORDERFUNCTION(ClosePrice, double, ::PositionGetDouble(POSITION_PRICE_CURRENT), ::OrderGetDouble(ORDER_PRICE_CURRENT), true)
  MT4_ORDERFUNCTION(CloseTimeMsc, long, 0, 0, true)
  MT4_ORDERFUNCTION(CloseTime, datetime, 0, 0, true)
  MT4_ORDERFUNCTION(Expiration, datetime, 0, ::OrderGetInteger(ORDER_TIME_EXPIRATION), true)
  MT4_ORDERFUNCTION(MagicNumber, long, ::PositionGetInteger(POSITION_MAGIC), ::OrderGetInteger(ORDER_MAGIC), true)
  MT4_ORDERFUNCTION(Profit, double, ::PositionGetDouble(POSITION_PROFIT), 0, true)
  MT4_ORDERFUNCTION(Swap, double, ::PositionGetDouble(POSITION_SWAP), 0, true)
  MT4_ORDERFUNCTION(Symbol, string, ::PositionGetString(POSITION_SYMBOL), ::OrderGetString(ORDER_SYMBOL), true)
  MT4_ORDERFUNCTION(Comment, string, MT4ORDERS::Order.Comment, ::OrderGetString(ORDER_COMMENT), MT4ORDERS::CheckPositionCommissionComment())
  MT4_ORDERFUNCTION(Commission, double, MT4ORDERS::Order.Commission, 0, MT4ORDERS::CheckPositionCommissionComment())

  MT4_ORDERFUNCTION(OpenPriceRequest, double, MT4ORDERS::Order.OpenPriceRequest, ::OrderGetDouble(ORDER_PRICE_OPEN), MT4ORDERS::CheckPositionOpenPriceRequest())
  MT4_ORDERFUNCTION(ClosePriceRequest, double, ::PositionGetDouble(POSITION_PRICE_CURRENT), ::OrderGetDouble(ORDER_PRICE_CURRENT), true)

  MT4_ORDERFUNCTION(TicketOpen, long, MT4ORDERS::Order.TicketOpen, ::OrderGetInteger(ORDER_TICKET), MT4ORDERS::CheckPositionTicketOpen())
//  MT4_ORDERFUNCTION(OpenReason, ENUM_DEAL_REASON, MT4ORDERS::Order.OpenReason, ::OrderGetInteger(ORDER_REASON), MT4ORDERS::CheckPositionOpenReason())
  MT4_ORDERFUNCTION(OpenReason, ENUM_DEAL_REASON, ::PositionGetInteger(POSITION_REASON), ::OrderGetInteger(ORDER_REASON), true)
  MT4_ORDERFUNCTION(CloseReason, ENUM_DEAL_REASON, 0, ::OrderGetInteger(ORDER_REASON), true)

#undef POSITION_ORDER
#undef MT4_ORDERFUNCTION

  static void MT4OrderPrint( void )
  {
    if (MT4ORDERS::Order.Ticket == POSITION_SELECT)
      MT4ORDERS::CheckPositionCommissionComment();

    ::Print(MT4ORDERS::Order.ToString());

    return;
  }

#undef ORDER_SELECT
#undef POSITION_SELECT
};

// #define OrderToString MT4ORDERS::MT4OrderToString

static MT4_ORDER MT4ORDERS::Order = {0};

static MT4HISTORY MT4ORDERS::History;

static const bool MT4ORDERS::IsTester = ::MQLInfoInteger(MQL_TESTER);

static const bool MT4ORDERS::IsHedging = ((ENUM_ACCOUNT_MARGIN_MODE)::AccountInfoInteger(ACCOUNT_MARGIN_MODE) ==
                                          ACCOUNT_MARGIN_MODE_RETAIL_HEDGING);

static bool MT4ORDERS::OrderSendBug = false;

static uint MT4ORDERS::OrderSend_MaxPause = 1000000; // максимальное время на синхронизацию в мкс.

static MqlTradeResult MT4ORDERS::LastTradeResult = {0};
//static MqlTradeRequest MT4ORDERS::LastTradeRequest = {0};
static MqlTradeRequest MT4ORDERS::LastTradeRequest = {};
static MqlTradeCheckResult MT4ORDERS::LastTradeCheckResult = {0};

bool OrderClose( const long Ticket, const double dLots, const double Price, const int SlipPage, const color Arrow_Color = clrNONE )
{
  return(MT4ORDERS::MT4OrderClose(Ticket, dLots, Price, SlipPage, Arrow_Color));
}

bool OrderModify( const long Ticket, const double Price, const double SL, const double TP, const datetime Expiration, const color Arrow_Color = clrNONE )
{
  return(MT4ORDERS::MT4OrderModify(Ticket, Price, SL, TP, Expiration, Arrow_Color));
}

bool OrderCloseBy( const long Ticket, const long Opposite, const color Arrow_Color = clrNONE )
{
  return(MT4ORDERS::MT4OrderCloseBy(Ticket, Opposite, Arrow_Color));
}

bool OrderDelete( const long Ticket, const color Arrow_Color = clrNONE )
{
  return(MT4ORDERS::MT4OrderDelete(Ticket, Arrow_Color));
}

void OrderPrint( void )
{
  MT4ORDERS::MT4OrderPrint();

  return;
}

#define MT4_ORDERGLOBALFUNCTION(NAME,T)     \
  T Order##NAME( void )                     \
  {                                         \
    return((T)MT4ORDERS::MT4Order##NAME()); \
  }

MT4_ORDERGLOBALFUNCTION(sHistoryTotal, int)
MT4_ORDERGLOBALFUNCTION(Ticket, TICKET_TYPE)
MT4_ORDERGLOBALFUNCTION(Type, int)
MT4_ORDERGLOBALFUNCTION(Lots, double)
MT4_ORDERGLOBALFUNCTION(OpenPrice, double)
MT4_ORDERGLOBALFUNCTION(OpenTimeMsc, long)
MT4_ORDERGLOBALFUNCTION(OpenTime, datetime)
MT4_ORDERGLOBALFUNCTION(StopLoss, double)
MT4_ORDERGLOBALFUNCTION(TakeProfit, double)
MT4_ORDERGLOBALFUNCTION(ClosePrice, double)
MT4_ORDERGLOBALFUNCTION(CloseTimeMsc, long)
MT4_ORDERGLOBALFUNCTION(CloseTime, datetime)
MT4_ORDERGLOBALFUNCTION(Expiration, datetime)
MT4_ORDERGLOBALFUNCTION(MagicNumber, MAGIC_TYPE)
MT4_ORDERGLOBALFUNCTION(Profit, double)
MT4_ORDERGLOBALFUNCTION(Commission, double)
MT4_ORDERGLOBALFUNCTION(Swap, double)
MT4_ORDERGLOBALFUNCTION(Symbol, string)
MT4_ORDERGLOBALFUNCTION(Comment, string)

MT4_ORDERGLOBALFUNCTION(OpenPriceRequest, double)
MT4_ORDERGLOBALFUNCTION(ClosePriceRequest, double)

MT4_ORDERGLOBALFUNCTION(TicketOpen, long)
MT4_ORDERGLOBALFUNCTION(OpenReason, ENUM_DEAL_REASON)
MT4_ORDERGLOBALFUNCTION(CloseReason, ENUM_DEAL_REASON)

#undef MT4_ORDERGLOBALFUNCTION

// Перегруженные стандартные функции
#define OrdersTotal MT4ORDERS::MT4OrdersTotal // ПОСЛЕ Expert/Expert.mqh - идет вызов MT5-OrdersTotal()

bool OrderSelect( const long Index, const int Select, const int Pool = MODE_TRADES )
{
  return(MT4ORDERS::MT4OrderSelect(Index, Select, Pool));
}

TICKET_TYPE OrderSend( const string Symb, const int Type, const double dVolume, const double Price, const int SlipPage, const double SL, const double TP,
                       const string comment = NULL, const MAGIC_TYPE magic = 0, const datetime dExpiration = 0, color arrow_color = clrNONE )
{
  return((TICKET_TYPE)MT4ORDERS::MT4OrderSend(Symb, Type, dVolume, Price, SlipPage, SL, TP, comment, magic, dExpiration, arrow_color));
}

#define RETURN_ASYNC(A) return((A) && ::OrderSendAsync(MT4ORDERS::LastTradeRequest, MT4ORDERS::LastTradeResult) &&                        \
                               (MT4ORDERS::LastTradeResult.retcode == TRADE_RETCODE_PLACED) ? MT4ORDERS::LastTradeResult.request_id : 0);

uint OrderCloseAsync( const long Ticket, const double dLots, const double Price, const int SlipPage, const color Arrow_Color = clrNONE )
{
  RETURN_ASYNC(OrderClose(Ticket, dLots, Price, SlipPage, INT_MAX))
}

uint OrderModifyAsync( const long Ticket, const double Price, const double SL, const double TP, const datetime Expiration, const color Arrow_Color = clrNONE )
{
  RETURN_ASYNC(OrderModify(Ticket, Price, SL, TP, Expiration, INT_MAX))
}

uint OrderDeleteAsync( const long Ticket, const color Arrow_Color = clrNONE )
{
  RETURN_ASYNC(OrderDelete(Ticket, INT_MAX))
}

uint OrderSendAsync( const string Symb, const int Type, const double dVolume, const double Price, const int SlipPage, const double SL, const double TP,
                    const string comment = NULL, const MAGIC_TYPE magic = 0, const datetime dExpiration = 0, color arrow_color = clrNONE )
{
  RETURN_ASYNC(!OrderSend(Symb, Type, dVolume, Price, SlipPage, SL, TP, comment, magic, dExpiration, INT_MAX))
}

#undef RETURN_ASYNC

// #undef TICKET_TYPE
#endif // __MT4ORDERS__
#else  // __MQL5__
  #define TICKET_TYPE int
  #define MAGIC_TYPE  int
#endif // __MQL5__



input int bar_countDown=10;// seconds before Candle close 

struct candleCountdown_s
  {
   int d;
   int h;
   int m;
   int s;
   string comment;
  };
  candleCountdown_s Bar_timeTrack;


class candleCountdown
  {
  
public:
                     candleCountdown(void){};
                    ~candleCountdown(void){};
                void candleCountdown_m(string c_Symbol,ENUM_TIMEFRAMES c_tf,candleCountdown_s &c_count)
                     {
                        int tS,iS,iM,iH;
                        string sS,sM,sH;
                     
                        datetime time=iTime(c_Symbol,c_tf,0);
                        tS=(int) time+PeriodSeconds(c_tf) -(int) TimeCurrent();
                     
                        iS=tS%60;
                     
                        iM=(tS-iS);
                        if(iM!=0) iM/=60;
                        iM-=(iM-iM%60);
                     
                        iH=(tS-iS-iM*60);
                        if(iH != 0) iH /= 60;
                        if(iH != 0) iH /= 60;
                     
                        sS = IntegerToString(iS,2,'0');
                        sM = IntegerToString(iM,2,'0');
                        sH = IntegerToString(iH,2,'0');
                     
                        string cmt=sH+":"+sM+":"+sS;
                        c_count.h=(int)sH;
                        c_count.m=(int)sM;
                        c_count.s=(int)sS;                     
                        c_count.comment=cmt;                     
                        
//                        Comment(__FUNCTION__+" :: "+cmt);//+c_count.h+" :: "+c_count.m+" :: "+c_count.s);
//--                        Comment(__FUNCTION__+" :: "+cmt);//+c_count.h+" :: "+c_count.m+" :: "+c_count.s);
                     }                        

  };

candleCountdown CcandleCountdown;


int OnInit()
  {
//--- create timer
   EventSetTimer(1);
   
//   delletAllObjectByPrefix(short_name);

OnTick();
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   if(reason==REASON_CHARTCHANGE)
     {
      
     }else
        {
   delletAllObjectByPrefix(short_name);         
        }
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
      if(CheckAuth()==true)
        {
      Panel(short_name+"pn",xAxix,yAxix,Width,Height);         
      autoClose_Profit();
        } 
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   OnTick();

  }
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
double OnTester()
  {
//---
   double ret=0.0;
//---

//---
   return(ret);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
//+------------------------------------------------------------------+

enum pn_l
  {
   pnl_none,
   pnl_Edt,
   pnl_Btn,
   pnl_Lbl,
  };
void Panel(string c_Name,int c_x,int c_y,int c_width,int c_height)
{
//Print(__FUNCTION__+" :: ");   
string c_name=c_Name;

   int cWid_1=(c_width/5)*2;
    cWid_1=50;//(c_width/5)*2;

   int cCol_1=c_x+10+5;
   int cCol_2=c_x+cCol_1+70;
   int cCol_3=c_x+cCol_2+70;
   int cCol_4=c_x+cCol_3+80;
   int cCol_5=c_x+cCol_4+50;
   int cCol_6=c_x+cCol_5+80;

   int cRow=0;
   int cRowGap=3;
   int cBut_H=25;


ENUM_BASE_CORNER corner=CORNER_LEFT_UPPER;
//ENUM_BASE_CORNER corner=CORNER_LEFT_UPPER;

   c_name=c_Name+"Bg";
   string c_txt="";
   if(object_new(c_name)==true)
     {     
      RectLabelCreate(0,c_name,0,c_x,c_y-5,c_width,20,clrBg,BORDER_SUNKEN,corner,clrBg,STYLE_SOLID,1,false,false,true,0,"\n");
     }

   c_name=c_Name+"hd";
   c_txt=short_name;
   if(object_new(c_name)==true)
     {     
//      LabelCreate(0,c_name, 0,c_x+(c_width/4),c_y+(cRow*(30)),corner, c_txt, "Arial Black",fontSize,clrGold, 0.0, ANCHOR_LEFT_UPPER, false, false,true,0,"\n",true);
     }

  // cRow++;



   for(int i=0;i<5;i++)
     {
      string c_nameA=c_Name+"mP"+IntegerToString(i)+"A";
      string c_nameB=c_Name+"mP"+IntegerToString(i)+"B";
      string c_nameC=c_Name+"mP"+IntegerToString(i)+"C";
      string c_nameD=c_Name+"mP"+IntegerToString(i)+"D";
      string c_nameE=c_Name+"mP"+IntegerToString(i)+"E";
      string c_nameF=c_Name+"mP"+IntegerToString(i)+"F";
      
      int ix=i;

      if(object_new(c_nameA)==true)
        {     
//         LabelCreate(0,c_nameA, 0,cCol_1,c_y+(cRow*(cBut_H+cRowGap))+3, corner,Table_txt(ix,0) , "Arial",fontSize,Table_clr(ix,0), 0.0, ANCHOR_LEFT_UPPER, false, false,true,0,"\n",true);
//         LabelCreate(0,c_nameA, 0,cCol_1,c_y+(cRow*(cBut_H+cRowGap))+3, corner,"Rule "+IntegerToString(i+1) , "Arial",fontSize,Table_clr(ix,0), 0.0, ANCHOR_LEFT_UPPER, false, false,true,0,"\n",true);
         if(showNow(ix,0)==pnl_Edt)EditCreate(0,c_nameA,0,cCol_1,c_y+(cRow*(cBut_H+cRowGap)),cWid_1,cBut_H,Table_txt(ix,0),"Trebuchet MS",fontSize,ALIGN_CENTER,false,corner,clrBlack,Table_clr(ix,0), clrNONE, false, false, true, 0,"\n");            
         if(showNow(ix,0)==pnl_Btn)ButtonCreate(0,c_nameA,0,cCol_1,c_y+(cRow*(cBut_H+cRowGap)),cWid_1,cBut_H,corner,Table_txt(ix,0),"Arial",fontSize,clrBlack,Table_clr(ix,0),clrNONE,false,false,false,true,0,"\n");
         if(showNow(ix,0)==pnl_Lbl)LabelCreate(0,c_nameA, 0,cCol_1,c_y+(cRow*(cBut_H+cRowGap))+3, corner,Table_txt(ix,0) , "Arial",fontSize,Table_clr(ix,0), 0.0, ANCHOR_LEFT_UPPER, false, false,true,0,"\n",true);
//         ,clrBlack,Table_clr(ix,0), clrNONE, false, false, true, 0,"\n");            
        }
//      if(i==0){    cRow++; continue;}
      if(object_new(c_nameB)==true)
        {     
         if(showNow(ix,1)==pnl_Edt)EditCreate(0,c_nameB,0,cCol_2,c_y+(cRow*(cBut_H+cRowGap)),cWid_1,cBut_H,Table_txt(ix,1),"Trebuchet MS",fontSize,ALIGN_CENTER,false,corner,clrBlack,Table_clr(ix,1), clrNONE, false, false, true, 0,"\n");
//         if(showNow(ix,1)==pnl_Edt)EditCreate(0,c_nameB,0,cCol_2,c_y+(cRow*(cBut_H+cRowGap)),cWid_1,cBut_H,Table_txt(ix,1),"Trebuchet MS",fontSize,ALIGN_CENTER,false,corner,clrBlack,Table_clr(ix,1), clrNONE, false, false, true, 0,"\n");
//         LabelCreate(0,c_nameB, 0,cCol_2,c_y+(cRow*(cBut_H+cRowGap))+3, corner,Table_txt(ix,1) , "Arial",fontSize,Table_clr(ix,1), 0.0, ANCHOR_LEFT_UPPER, false, false,true,0,"\n",true);
         if(showNow(ix,1)==pnl_Btn)ButtonCreate(0,c_nameB,0,cCol_2,c_y+(cRow*(cBut_H+cRowGap)),cWid_1,cBut_H,corner,Table_txt(ix,1),"Arial",fontSize,clrBlack,Table_clr(ix,1),clrNONE,false,false,false,true,0,"\n");
         if(showNow(ix,1)==pnl_Lbl)LabelCreate(0,c_nameB, 0,cCol_2,c_y+(cRow*(cBut_H+cRowGap))+3, corner,Table_txt(ix,1) , "Arial",fontSize,Table_clr(ix,1), 0.0, ANCHOR_LEFT_UPPER, false, false,true,0,"\n",true);

        }

      if(object_new(c_nameC)==true)
        {     
         if(showNow(ix,2)==pnl_Edt)EditCreate(0,c_nameC,0,cCol_3,c_y+(cRow*(cBut_H+cRowGap)),cWid_1,cBut_H,Table_txt(ix,2),"Trebuchet MS",fontSize,ALIGN_CENTER,false,corner,clrBlack,Table_clr(ix,2), clrNONE, false, false, true, 0,"\n");
         if(showNow(ix,2)==pnl_Btn)ButtonCreate(0,c_nameC,0,cCol_3,c_y+(cRow*(cBut_H+cRowGap)),cWid_1,cBut_H,corner,Table_txt(ix,2),"Arial",fontSize,clrBlack,Table_clr(ix,2),clrNONE,false,false,false,true,0,"\n");
         if(showNow(ix,2)==pnl_Lbl)LabelCreate(0,c_nameC, 0,cCol_3,c_y+(cRow*(cBut_H+cRowGap))+3, corner,Table_txt(ix,2) , "Arial",fontSize,Table_clr(ix,2), 0.0, ANCHOR_LEFT_UPPER, false, false,true,0,"\n",true);
        }

     
   cRow++;
     }


   c_name=c_Name+"Bg";
   ObjectSetInteger(0,c_name,OBJPROP_YSIZE,(cRow*(cBut_H+cRowGap))+5);

   Panel_set(c_Name);
}
void Panel_set(string c_Name)
{
   for(int i=0;i<5;i++)
     {
      string c_nameA=c_Name+"mP"+IntegerToString(i)+"A";
      string c_nameB=c_Name+"mP"+IntegerToString(i)+"B";
      string c_nameC=c_Name+"mP"+IntegerToString(i)+"C";
      string c_nameD=c_Name+"mP"+IntegerToString(i)+"D";
      string c_nameE=c_Name+"mP"+IntegerToString(i)+"E";
      string c_nameF=c_Name+"mP"+IntegerToString(i)+"F";
      
      int c_x=i;
      int c_y=0;
/*
   if(c_x==0&&c_y==0)return "Buy";   if(c_x==0&&c_y==1)return "0.01";   if(c_x==0&&c_y==2)return "Sell";
   if(c_x==1&&c_y==0)return "StopLoss";   if(c_x==1&&c_y==1)return "20";   if(c_x==1&&c_y==2)return "20";
   if(c_x==2&&c_y==0)return "TakeProfit";   if(c_x==2&&c_y==1)return "20";   if(c_x==2&&c_y==2)return "20";//pnl_none;
   if(c_x==3&&c_y==0)return "noOfTrade/Bar";   if(c_x==3&&c_y==1)return "";   if(c_x==3&&c_y==2)return "2";//pnl_none;
   if(c_x==4&&c_y==0)return "Auto.C";   if(c_x==4&&c_y==1)return "";   if(c_x==4&&c_y==2)return "Close";

       c_y=1;
      
        if(c_x==0&&c_y==1)panel.Lots=ObjectGetString(0,c_nameB,OBJPROP_TEXT);    

       c_y=2;
        if(c_x==1&&c_y==2)panel.StopLoss_inPip=ObjectGetString(0,c_nameC,OBJPROP_TEXT);    
        if(c_x==2&&c_y==2)panel.TakeProfit_inPip=ObjectGetString(0,c_nameC,OBJPROP_TEXT);    
        if(c_x==3&&c_y==2)panel.maxOrder_perBar=ObjectGetString(0,c_nameC,OBJPROP_TEXT);    
*/      

       c_y=0;
      
        if(c_x==0&&c_y==0)panel.objName.buy=c_nameA;
        if(c_x==4&&c_y==0)panel.objName.autoClose=c_nameA;
        
       c_y=1;
      
        if(c_x==0&&c_y==1)panel.objName.Lots=c_nameB;
//        Print(__FUNCTION__+" :panel.objName.Lots: "+panel.objName.Lots); 

       c_y=2;
        if(c_x==1&&c_y==2)panel.objName.StopLoss_inPip=c_nameC;//panel.StopLoss_inPip=ObjectGetString(0,c_nameC,OBJPROP_TEXT);    
        if(c_x==2&&c_y==2)panel.objName.TakeProfit_inPip=c_nameC;//panel.TakeProfit_inPip=ObjectGetString(0,c_nameC,OBJPROP_TEXT);    
        if(c_x==3&&c_y==2)panel.objName.maxOrder_perBar=c_nameC;//panel.maxOrder_perBar=ObjectGetString(0,c_nameC,OBJPROP_TEXT);    

        if(c_x==0&&c_y==2)panel.objName.sell=c_nameC;
        if(c_x==4&&c_y==2)panel.objName.close=c_nameC;
      
//panel.Lots     
     } 


//         LabelCreate(0,c_nameA, 0,cCol_1,c_y+(cRow*(cBut_H+cRowGap))+3, corner,Table_txt(ix,0) , "Arial",fontSize,Table_clr(ix,0), 0.0, ANCHOR_LEFT_UPPER, false, false,true,0,"\n",true);

      panel.val.Lots=(double)ObjectGetString(0,panel.objName.Lots,OBJPROP_TEXT);    
      panel.val.StopLoss_inPip=(double)ObjectGetString(0,panel.objName.StopLoss_inPip,OBJPROP_TEXT);    
      panel.val.TakeProfit_inPip=(double)ObjectGetString(0,panel.objName.TakeProfit_inPip,OBJPROP_TEXT);    
      panel.val.maxOrder_perBar=(double)ObjectGetString(0,panel.objName.maxOrder_perBar,OBJPROP_TEXT);    

   /*
      Comment(__FUNCTION__
               +" \n------Lots: "+panel.val.Lots+" :: "+panel.objName.Lots
               +" \n------StopLoss_inPip: "+panel.val.StopLoss_inPip+" :: "+panel.objName.StopLoss_inPip
               +" \n------TakeProfit_inPip: "+panel.val.TakeProfit_inPip+" :: "+panel.objName.TakeProfit_inPip
               +" \n------maxOrder_perBar: "+panel.val.maxOrder_perBar+" :: "+panel.objName.maxOrder_perBar
      
               );
   
   */


   start4open(TimeFrame); 

}
bool nextBar=true;
void start4open(ENUM_TIMEFRAMES c_tf)
{
//Bar_timeTrack

      if(ObjectGetInteger(0,panel.objName.buy,OBJPROP_STATE)==true)
        {
        ObjectSetInteger(0,panel.objName.buy,OBJPROP_BGCOLOR,clrMediumAquamarine);
        }else
           {
        ObjectSetInteger(0,panel.objName.buy,OBJPROP_BGCOLOR,clrBlue);            
           }

      if(ObjectGetInteger(0,panel.objName.sell,OBJPROP_STATE)==true)
        {
        ObjectSetInteger(0,panel.objName.sell,OBJPROP_BGCOLOR,clrOrange);
        }else
           {
        ObjectSetInteger(0,panel.objName.sell,OBJPROP_BGCOLOR,clrRed);            
           }

      if(ObjectGetInteger(0,panel.objName.close,OBJPROP_STATE)==true)
        {
         closeOrderType(_Symbol,-1,Magic,-1,0);   
         Print(__FUNCTION__+" :Close:Pressed ");     
        ObjectSetInteger(0,panel.objName.close,OBJPROP_STATE,false);
        }

         if(myTradeDay()==false)
           {
            return;
           }

      CcandleCountdown.candleCountdown_m(_Symbol,c_tf,Bar_timeTrack);
         if(Bar_timeTrack.s<bar_countDown&&Bar_timeTrack.h==0&&Bar_timeTrack.m==0)
           {
//           isTimeHit=true;
           }else
              {
              nextBar=false;
               return;
              }
         
         if(nextBar==true)
           {
            return;
           }
         
      if(ObjectGetInteger(0,panel.objName.buy,OBJPROP_STATE)==true)
        {
         check4open(_Symbol,ORDER_TYPE_BUY,Magic);
         check4open(_Symbol,ORDER_TYPE_BUY,Magic);         
        }

      if(ObjectGetInteger(0,panel.objName.sell,OBJPROP_STATE)==true)
        {
         check4open(_Symbol,ORDER_TYPE_SELL,Magic);
         check4open(_Symbol,ORDER_TYPE_SELL,Magic);         
        }
     nextBar=true;
}
bool object_new(string c_name)
{
   if(ObjectFind(0,c_name)>=0)
     {
      return false;
     }
return true;
}

//(ix,0)==pnl_Edt
pn_l showNow(int c_x,int c_y)
{
   if(c_x==0&&c_y==0)return pnl_Btn;   if(c_x==0&&c_y==1)return pnl_Edt;   if(c_x==0&&c_y==2)return pnl_Btn;
   if(c_x==1&&c_y==0)return pnl_Lbl;   if(c_x==1&&c_y==1)return pnl_none;   if(c_x==1&&c_y==2)return pnl_Edt;//pnl_none;
   if(c_x==2&&c_y==0)return pnl_Lbl;   if(c_x==2&&c_y==1)return pnl_none;   if(c_x==2&&c_y==2)return pnl_Edt;//pnl_none;
   if(c_x==3&&c_y==0)return pnl_Lbl;   if(c_x==3&&c_y==1)return pnl_none;   if(c_x==3&&c_y==2)return pnl_Edt;//pnl_none;
   if(c_x==4&&c_y==0)return pnl_Btn;   if(c_x==4&&c_y==1)return pnl_none;   if(c_x==4&&c_y==2)return pnl_Btn;


return pnl_Lbl;
}
string Table_txt(int c_x,int c_y)
{
   if(c_x==0&&c_y==0)return "Buy";   if(c_x==0&&c_y==1)return "0.01";   if(c_x==0&&c_y==2)return "Sell";
//   if(c_x==1&&c_y==0)return "StopLoss";   if(c_x==1&&c_y==1)return "20";   if(c_x==1&&c_y==2)return "Pip";
  // if(c_x==2&&c_y==0)return "TakeProfit";   if(c_x==2&&c_y==1)return "20";   if(c_x==2&&c_y==2)return "Pip";//pnl_none;

   if(c_x==1&&c_y==0)return "StopLoss";   if(c_x==1&&c_y==1)return "20";   if(c_x==1&&c_y==2)return "20";
   if(c_x==2&&c_y==0)return "TakeProfit";   if(c_x==2&&c_y==1)return "20";   if(c_x==2&&c_y==2)return "20";//pnl_none;
   if(c_x==3&&c_y==0)return "noOfTrade/Bar";   if(c_x==3&&c_y==1)return "";   if(c_x==3&&c_y==2)return "2";//pnl_none;
   if(c_x==4&&c_y==0)return "Auto";   if(c_x==4&&c_y==1)return "";   if(c_x==4&&c_y==2)return "Close";

return "hih";
}

color Table_clr(int c_x,int c_y)
{
   if(c_x==0&&c_y==0)return clrBlue;   if(c_x==0&&c_y==1)return clrWhite;   if(c_x==0&&c_y==2)return clrRed;
//   if(c_x==1&&c_y==0)return clrWhite;   if(c_x==1&&c_y==1)return clrWhite;   if(c_x==1&&c_y==2)return clrLime;
//   if(c_x==2&&c_y==0)return clrWhite;   if(c_x==2&&c_y==1)return clrWhite;   if(c_x==2&&c_y==2)return clrLime;//pnl_none;

   if(c_x==4&&c_y==0)return clrLime;   if(c_x==4&&c_y==1)return clrWhite;   if(c_x==4&&c_y==2)return clrRed;//pnl_none;

return clrWhite;
}

bool RectLabelCreate(const long             chart_ID=0,
                     const string           name="RectLabel",
                     const int              sub_window=0,
                     const int              x=0,
                     const int              y=0,
                     const int              width=50,
                     const int              height=18,
                     const color            back_clr=C'236,233,216',
                     const ENUM_BORDER_TYPE border=BORDER_SUNKEN,
                     const ENUM_BASE_CORNER corner=CORNER_LEFT_UPPER,
                     const color            clr=clrRed,
                     const ENUM_LINE_STYLE  style=STYLE_SOLID,
                     const int              line_width=1,
                     const bool             back=false,
                     const bool             selection=false,
                     const bool             hidden=true,
                     const long             z_order=0,
                     const string           tooltip="\n")
  {
   ResetLastError();
   if(ObjectFind(chart_ID,name)!=0)
     {
      if(!ObjectCreate(chart_ID,name,OBJ_RECTANGLE_LABEL,sub_window,0,0))
        {
         Print(__FUNCTION__,
               ": failed to create a rectangle label! Error code = ",_LastError);
         return(false);
        }
      ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
      ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
      ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
      ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
      ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_TYPE,border);
      ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
      ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
      ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,line_width);
      ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
      ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
      ObjectSetString(chart_ID,name,OBJPROP_TOOLTIP,tooltip);
     }
   return(true);
  }



bool ButtonCreate(const long              chart_ID=0,
                  const string            name="Button",
                  const int               sub_window=0,
                  const int               x=0,
                  const int               y=0,
                  const int               width=50,
                  const int               height=18,
                  const ENUM_BASE_CORNER  corner=CORNER_LEFT_UPPER,
                  const string            text="Button",
                  const string            font="Arial",
                  const int               font_size=10,
                  const color             clr=clrBlack,
                  const color             back_clr=C'236,233,216',
                  const color             border_clr=clrNONE,
                  const bool              state=false,
                  const bool              back=false,
                  const bool              selection=false,
                  const bool              hidden=true,
                  const long              z_order=0,
                  const string            tooltip="\n")
  {
   ResetLastError();
   if(ObjectFind(chart_ID,name)!=0)
     {
      if(!ObjectCreate(chart_ID,name,OBJ_BUTTON,sub_window,0,0))
        {
         Print(__FUNCTION__,
               ": failed to create the button! Error code = ",_LastError);
         return(false);
        }
      ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
      ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
      ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
      ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
      ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
      ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
      ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
      ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
      ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
      ObjectSetInteger(chart_ID,name,OBJPROP_STATE,state);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
      ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
      ObjectSetString(chart_ID,name,OBJPROP_TOOLTIP,tooltip);
     }
   return(true);
  }

bool LabelCreate(const long              chart_ID=0,
                 const string            name="Label",
                 const int               sub_window=0,
                 const int               x=0,
                 const int               y=0,
                 const ENUM_BASE_CORNER  corner=CORNER_LEFT_UPPER,
                 const string            text="Label",
                 const string            font="Arial",
                 const int               font_size=10,
                 const color             clr=clrRed,
                 const double            angle=0.0,
                 const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER,
                 const bool              back=false,
                 const bool              selection=false,
                 const bool              hidden=true,
                 const long              z_order=0,
                 const string            tooltip="\n",
                 const bool              tester=true)
  {
   ResetLastError();
   if(ObjectFind(chart_ID,name)!=0)
     {
      if(!ObjectCreate(chart_ID,name,OBJ_LABEL,sub_window,0,0))
        {
     //    Print(__FUNCTION__,
       //        ": failed to create text label! Error code = ",_LastError);
         return(false);
        }
      ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
      ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
      ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
      ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
      ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
      ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
      ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
      ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
      ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
      ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
      ObjectSetString(chart_ID,name,OBJPROP_TOOLTIP,tooltip);
     }
   return(true);
  }

bool EditCreate(const long             chart_ID=0,
                const string           name="Edit",
                const int              sub_window=0,
                const int              x=0,
                const int              y=0,
                const int              width=50,
                const int              height=18,
                const string           text="Text",
                const string           font="Arial",
                const int              font_size=10,
                const ENUM_ALIGN_MODE  align=ALIGN_CENTER,
                const bool             read_only=false,
                const ENUM_BASE_CORNER corner=CORNER_LEFT_UPPER,
                const color            clr=clrBlack,
                const color            back_clr=clrWhite,
                const color            border_clr=clrNONE,
                const bool             back=false,
                const bool             selection=false,
                const bool             hidden=true,
                const long             z_order=0,
                const string           tooltip="\n")
  {
   ResetLastError();
   if(ObjectFind(chart_ID,name)!=0)
     {
      if(!ObjectCreate(chart_ID,name,OBJ_EDIT,sub_window,0,0))
        {
         Print(__FUNCTION__,
               ": failed to create \"Edit\" object! Error code = ",_LastError);
         return(false);
        }
      ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
      ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
      ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
      ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
      ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
      ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
      ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
      ObjectSetInteger(chart_ID,name,OBJPROP_ALIGN,align);
      ObjectSetInteger(chart_ID,name,OBJPROP_READONLY,read_only);
      ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
      ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
      ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
      ObjectSetString(chart_ID,name,OBJPROP_TOOLTIP,tooltip);
     }
   return(true);
  }
int candleType(string c_Symbol,ENUM_TIMEFRAMES c_Tf,int c_i)
{
   double c_Open=iOpen(c_Symbol,c_Tf,c_i);
   double c_Close=iClose(c_Symbol,c_Tf,c_i);
   
   if(c_Open<c_Close)
     {
      return ORDER_TYPE_BUY;
     }
   if(c_Open>c_Close)
     {
      return ORDER_TYPE_SELL;
     }
return -1;
}
void check4open(string c_Symbol,int c_OrderType,int c_magic)
{
    
    int c_sig=candleType(c_Symbol,TimeFrame,barShift);
    if(c_sig==c_OrderType)
      {
       openOrder(c_Symbol,c_sig,c_magic);       
      }
    
}
void openOrder(string c_Symbol,int c_OrderType,int c_magic)
{

double c_lots=panel.val.Lots;
double TakeProfit_inPip=panel.val.TakeProfit_inPip;
double Stoploss_inPip=panel.val.StopLoss_inPip;

//            int c_OrderType=OrderType();
            double c_close=iClose(c_Symbol,0,0);
            double c_tp=0;            
            if(TakeProfit_inPip>0)
              {
               c_tp=getTakeProfit_inPrice(c_Symbol,c_OrderType,c_close,TakeProfit_inPip);
              }
            double c_sl=0;
            if(Stoploss_inPip>0)
              {
               c_sl=getStopLoss_inPrice(c_Symbol,c_OrderType,c_close,Stoploss_inPip);
              }
                 sendOrder(c_Symbol,c_magic,c_OrderType,c_lots,0,c_sl,c_tp,Comment_ea,0); 
}
long sendOrder(string c_Symbol,int c_magic,int c_OrderType,double c_Lot,double c_Price,double Sl,double Tp,string c_OrderComment,double c_ExpiryTime_Minute)//,double c_ExpiryTime_Minute)
  {
   Print(c_Symbol," :mN: " + (string)c_magic,  " :ot: " +(string)c_OrderType, " :Lot: " + (string)c_Lot," :op: " + (string)c_Price,  " :sl: " +(string)Sl,  " :tp: " +(string)Tp, " :cm: " + c_OrderComment);
   int c_return=0;
   datetime c_expiryTime=0;
   double csp=getPipDiff(c_Symbol,SymbolInfoDouble(c_Symbol,SYMBOL_ASK),SymbolInfoDouble(c_Symbol,SYMBOL_BID));

   if(Max_Spread>0&&csp>Max_Spread)
     {
      Print(__FUNCTION__+" Spread is above:"+DoubleToString(Max_Spread,2));
      return(false);
     }
   if(c_OrderType==-1)
     {
      return(false);
     }
   double c_Ask = SymbolInfoDouble(c_Symbol,SYMBOL_ASK);
   double c_Bid = SymbolInfoDouble(c_Symbol,SYMBOL_BID);
   int c_digits=(int)SymbolInfoInteger(c_Symbol,SYMBOL_DIGITS);
   string csssdd="";
  // if(CheckVolumeValue(c_Lot,csssdd)==false)
     {
//      return -1;
     }
//-------
//-------
long ticket=-1;
   if(c_OrderType==OP_BUY||c_OrderType==ORDER_TYPE_BUY)
     {
      ticket=OrderSend(c_Symbol,OP_BUY,c_Lot,NormalizeDouble(c_Ask,c_digits),100,Sl, Tp,c_OrderComment,c_magic,c_expiryTime,clrGreen);
     }
   if(c_OrderType==OP_BUYLIMIT||c_OrderType==ORDER_TYPE_BUY_LIMIT)
     {
      ticket=OrderSend(c_Symbol,OP_BUYLIMIT,c_Lot,NormalizeDouble(c_Price,c_digits),100,Sl, Tp,c_OrderComment,c_magic,c_expiryTime,clrGreen);
     }
   if(c_OrderType==OP_BUYSTOP||c_OrderType==ORDER_TYPE_BUY_STOP)
     {
      ticket=OrderSend(c_Symbol,OP_BUYSTOP,c_Lot,NormalizeDouble(c_Price,c_digits),100,Sl, Tp,c_OrderComment,c_magic,c_expiryTime,clrGreen);
     }

   if(c_OrderType==OP_SELL||c_OrderType==ORDER_TYPE_SELL)
     {
      ticket=OrderSend(c_Symbol,OP_SELL,c_Lot,NormalizeDouble(c_Bid,c_digits),100,Sl, Tp,c_OrderComment,c_magic,c_expiryTime,clrRed);
     }
   if(c_OrderType==OP_SELLLIMIT||c_OrderType==ORDER_TYPE_SELL_LIMIT)
     {
      ticket=OrderSend(c_Symbol,OP_SELLLIMIT,c_Lot,NormalizeDouble(c_Price,c_digits),100,Sl, Tp,c_OrderComment,c_magic,c_expiryTime,clrRed);
     }
   if(c_OrderType==OP_SELLSTOP||c_OrderType==ORDER_TYPE_SELL_STOP)
     {
      ticket=OrderSend(c_Symbol,OP_SELLSTOP,c_Lot,NormalizeDouble(c_Price,c_digits),100,Sl, Tp,c_OrderComment,c_magic,c_expiryTime,clrRed);
     }
 



   if(ticket<=0)
     {
      int error = GetLastError();
      Print(__FUNCTION__+c_Symbol+":OrderSend GetLastError() :: "+(string)error);      
     }else
        {
         
        }
   return(ticket);
  }

double getPipDiff(string c_Symbol,double val_A,double val_B)
  {
   double cd=val_A- val_B;
   if(val_A < val_B)
     {
      cd=val_B-val_A;
     }
   int c_digits=(int)SymbolInfoInteger(c_Symbol,SYMBOL_DIGITS);
   double c_Point;
   if(c_digits%2==1)
     {
      c_Point=SymbolInfoDouble(c_Symbol,SYMBOL_POINT) *10;
     }
   else
     {
      c_Point=SymbolInfoDouble(c_Symbol,SYMBOL_POINT);
     }
   double c_Spread=NormalizeDouble((cd/c_Point),2);
   return(c_Spread);
  }

double getStopLoss_inPrice(string c_Symbol,int c_OrderType,double c_openPrice,double c_pipDiff)
  {
   int c_Digits=(int)SymbolInfoInteger(c_Symbol,SYMBOL_DIGITS);
   double c_Point,pip2dbl;
   if(c_Digits%2==1)
     {
      c_Point=SymbolInfoDouble(c_Symbol,SYMBOL_POINT) *10;
     }
   else
     {
      c_Point=SymbolInfoDouble(c_Symbol,SYMBOL_POINT);
     }
   double c_return=-1;
   pip2dbl=c_Point;
   if(c_OrderType==ORDER_TYPE_BUY ||c_OrderType==ORDER_TYPE_BUY_LIMIT ||c_OrderType==ORDER_TYPE_BUY_STOP)
      c_return=(NormalizeDouble(c_openPrice-(c_pipDiff*pip2dbl),c_Digits));
   if(c_OrderType==ORDER_TYPE_SELL ||c_OrderType==ORDER_TYPE_SELL_LIMIT ||c_OrderType==ORDER_TYPE_SELL_STOP)
      c_return=(NormalizeDouble(c_openPrice+(c_pipDiff*pip2dbl),c_Digits));
   if(c_pipDiff>0)
     {
      return(c_return);
     }
   else
     {
      return(0);
     }
  }
double getTakeProfit_inPrice(string c_Symbol,int c_OrderType,double c_openPrice,double c_pipDiff)
  {
   int c_Digits=(int)SymbolInfoInteger(c_Symbol,SYMBOL_DIGITS);
   double c_Point,pip2dbl;
   if(c_Digits%2==1)
     {
      c_Point=SymbolInfoDouble(c_Symbol,SYMBOL_POINT) *10;
     }
   else
     {
      c_Point=SymbolInfoDouble(c_Symbol,SYMBOL_POINT);
     }
   double c_return=-1;
   pip2dbl=c_Point;
   if(c_OrderType==ORDER_TYPE_BUY ||c_OrderType==ORDER_TYPE_BUY_LIMIT ||c_OrderType==ORDER_TYPE_BUY_STOP)
      c_return=(NormalizeDouble(c_openPrice+(c_pipDiff*pip2dbl),c_Digits));
   if(c_OrderType==ORDER_TYPE_SELL ||c_OrderType==ORDER_TYPE_SELL_LIMIT ||c_OrderType==ORDER_TYPE_SELL_STOP)
      c_return=(NormalizeDouble(c_openPrice-(c_pipDiff*pip2dbl),c_Digits));
   if(c_pipDiff>0)
     {
      return(c_return);
     }
   else
     {
      return(0);
     }
  }


bool closeOrderType(string c_Symbol,int c_OrderType,int c_magic,int c_ticket,double c_Profit)
{

bool c_return=false;
string c_print="";
  for(int cnt = OrdersTotal()-1 ; cnt >= 0; cnt--)
     {
    if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)==true)
      {
     if(OrderSymbol() == c_Symbol||c_Symbol=="allSym"||c_Symbol=="")
       {
         string c_ordSymbol=OrderSymbol();
      if(c_magic==OrderMagicNumber()||c_magic==(-1))
        {
      if(c_ticket==OrderTicket()||c_ticket==(-1))
        {
        if(c_OrderType==OrderType()||c_OrderType==(-1))
          {
          double c_OrderProfit=OrderProfit();
         if((c_Profit==0)||(c_Profit>0&&c_OrderProfit>c_Profit)||(c_Profit<0&&c_OrderProfit<c_Profit))
           {
         if(OrderType()==OP_BUY||OrderType()==OP_SELL)
           {
            c_return=OrderClose (OrderTicket(), OrderLots(), OrderClosePrice(), 1000, clrNONE); 
            c_print=c_print+(c_ordSymbol+" Closed ? "+(string)c_return);
           }else
              {
             c_return=OrderDelete( OrderTicket() );
            c_print=c_print+(c_ordSymbol+" Deleted ? "+(string)c_return);
              }            
           } 
          }
        }}
       }
      
      }
     }
   if(c_print=="")
     {
        SamPrint_Gap(__FUNCTION__+" :"+(string)c_return);               
     }else
        {
        SamPrint_Gap(__FUNCTION__+" :"+c_print);         
        }
     
return(c_return);
}

string Sam_Print_Gap="";
void SamPrint_Gap(string c_note)
{
   if(Sam_Print_Gap==c_note)
     {
      
     }else
        {
         Print(c_note);
         Sam_Print_Gap=c_note;
        }
}

bool myTradeDay()
{
   MqlDateTime sTime; TimeCurrent(sTime);
   
   if(sTime.day_of_week==1&&TradeOnMonday==true)return true;
   if(sTime.day_of_week==2&&TradeOnTuesday==true)return true;
   if(sTime.day_of_week==3&&TradeOnWednessday==true)return true;
   if(sTime.day_of_week==4&&TradeOnThursday==true)return true;
   if(sTime.day_of_week==5&&TradeOnFriday==true)return true;

return false;
}

bool CheckAuth()
{

return true;
}

void autoClose_Profit()
{
   
   double c_top=TotalOrderProfit(_Symbol,-1,Magic); 
   if(close_byEquity>0)
     {
      if(c_top>=close_byEquity)
        {
        Print(__FUNCTION__+" close_byEquity:Hit");
         closeOrderType(_Symbol,-1,Magic,-1,0);
        }
     }
   
   if(close_byEquityLoss<0)
     {
      if(c_top<=close_byEquityLoss)
        {
        Print(__FUNCTION__+" close_byEquityLoss:Hit");
         closeOrderType(_Symbol,-1,Magic,-1,0);
        }               
     }
}
double TotalOrderProfit(string c_Symbol,int c_OrderType,int c_magic)
  {
  if(MQLInfoInteger(MQL_TESTER)==true)
    {
//     return OrdersTotal();
    }
   double c_return=0;
   for(int cnt = OrdersTotal()-1 ; cnt >= 0; cnt--)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)==false)
         break;
      if(OrderSymbol() == c_Symbol||c_Symbol=="allSym"||c_Symbol=="")
        {
         if(c_magic==OrderMagicNumber()||c_magic==-1)
           {
            if(c_OrderType==OrderType()||c_OrderType==-1)
              {
               c_return=c_return+OrderProfit();//OrderProfit()+OrderCommission()+OrderSwap();
              }
           }
        }
     }
   return(c_return);
  }


