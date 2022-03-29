
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
   for(int i=ObjectsTotal(0)-1; i>=0; i--)
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
    return((Check == INT_MAX) ? MT4ORDERS::
