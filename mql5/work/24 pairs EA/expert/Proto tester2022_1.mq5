//+------------------------------------------------------------------+
//|                                                MT5 28Pair EA.mq5 |
//|                                    Copyright 2021,Yousuf Mesalm. |
//|                           https://www.mql5.com/en/users/20163440 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021,Yousuf Mesalm."
#property link      "https://www.mql5.com/en/users/20163440"
#property version   "1.00"
#property strict

#include  <MQL_Easy\Execute\Execute.mqh>
#include  <MQL_Easy\Position\Position.mqh>
#include <Arrays\ArrayString.mqh>
#include  <Trade\Trade.mqh>

CTrade myTrade ;
enum OrderType
  {
   BuyOnly,
   SellOnly,
  };



input double lot = 0.1;
input double recovryZonePoint=10;
input double lotMultipiler=1.5;
input OrderType Ordertype=BuyOnly;
input bool use_TimeFilter = false;
input string   TimeStart = "12:00";
input string   TimeStop = "14:00";
input bool use_tp_per_symbol_usd = true;
input bool use_tp_per_symbol_pt = true;
input bool use_tp_per_account_usd = true;
input bool use_sl_per_account_usd = true;
input bool use_tp_per_account_pt = true;
input bool Use_Trailing = true;
input int tp_pt = 50; //take profit for account with point
input double tp_usd = 0; // take profit for account with USD
input double sl_usd = 0; // Stop Loss for account with USD
input string suffix ="m";
input string perfix ="";
input bool Use_GBPUSD = true;
input double GBPUSD_TP_USD = 20;
input int GBPUSD_TP_Pips = 20;
input int GBPUSD_SL_Pips = 20;
input int GBPUSD_Trailing = 20;
input bool Use_EURUSD = false;
input double EURUSD_TP_USD = 20;
input int EURUSD_TP_Pips = 20;
input int EURUSD_SL_Pips = 20;
input int EURUSD_Trailing = 20;
input bool Use_USDJPY = false;
input double USDJPY_TP_USD = 20;
input int USDJPY_TP_Pips = 20;
input int USDJPY_SL_Pips = 20;
input int USDJPY_Trailing = 20;
input bool Use_USDCAD = false;
input double USDCAD_TP_USD = 20;
input int USDCAD_TP_Pips = 20;
input int USDCAD_SL_Pips = 20;
input int USDCAD_Trailing = 20;
input bool Use_USDCHF = false;
input double USDCHF_TP_USD = 20;
input int USDCHF_TP_Pips = 20;
input int USDCHF_SL_Pips = 20;
input int USDCHF_Trailing = 20;

input bool Use_AUDUSD = false;
input double AUDUSD_TP_USD = 20;
input int AUDUSD_TP_Pips = 20;
input int AUDUSD_SL_Pips = 20;
input int AUDUSD_Trailing = 20;
input bool Use_NZDUSD = false;
input double NZDUSD_TP_USD = 20;
input int NZDUSD_TP_Pips = 20;
input int NZDUSD_SL_Pips = 20;
input int NZDUSD_Trailing = 20;
input bool Use_AUDCAD = false;
input double AUDCAD_TP_USD = 20;
input int AUDCAD_TP_Pips = 20;
input int AUDCAD_SL_Pips = 20;
input int AUDCAD_Trailing = 20;
input bool Use_AUDCHF = false;
input double AUDCHF_TP_USD = 20;
input int AUDCHF_TP_Pips = 20;
input int AUDCHF_SL_Pips = 20;
input int AUDCHF_Trailing = 20;
input bool Use_AUDJPY = false;
input double AUDJPY_TP_USD = 20;
input int AUDJPY_TP_Pips = 20;
input int AUDJPY_SL_Pips = 20;
input int AUDJPY_Trailing = 20;
input bool Use_AUDNZD = false;
input double AUDNZD_TP_USD = 20;
input int AUDNZD_TP_Pips = 20;
input int AUDNZD_SL_Pips = 20;
input int AUDNZD_Trailing = 20;
input bool Use_CADCHF = false;
input double CADCHF_TP_USD = 20;
input int CADCHF_TP_Pips = 20;
input int CADCHF_SL_Pips = 20;
input int CADCHF_Trailing = 20;

input bool Use_CADJPY = false;
input double CADJPY_TP_USD = 20;
input int CADJPY_TP_Pips = 20;
input int CADJPY_SL_Pips = 20;
input int CADJPY_Trailing = 20;
input bool Use_CHFJPY = false;
input double CHFJPY_TP_USD = 20;
input int CHFJPY_TP_Pips = 20;
input int CHFJPY_SL_Pips = 20;
input int CHFJPY_Trailing = 20;
input bool Use_EURAUD = false;
input double EURAUD_TP_USD = 20;
input int EURAUD_TP_Pips = 20;
input int EURAUD_SL_Pips = 20;
input int EURAUD_Trailing = 20;
input bool Use_EURCAD = false;
input double EURCAD_TP_USD = 20;
input int EURCAD_TP_Pips = 20;
input int EURCAD_SL_Pips = 20;
input int EURCAD_Trailing = 20;
input bool Use_EURCHF = false;
input double EURCHF_TP_USD = 20;
input int EURCHF_TP_Pips = 20;
input int EURCHF_SL_Pips = 20;
input int EURCHF_Trailing = 20;
input bool Use_EURGBP = false;
input double EURGBP_TP_USD = 20;
input int EURGBP_TP_Pips = 20;
input int EURGBP_SL_Pips = 20;
input int EURGBP_Trailing = 20;
input bool Use_EURJPY = false;
input double EURJPY_TP_USD = 20;
input int EURJPY_TP_Pips = 20;
input int EURJPY_SL_Pips = 20;
input int EURJPY_Trailing = 20;

input bool Use_EURNZD = false;
input double EURNZD_TP_USD = 20;
input int EURNZD_TP_Pips = 20;
input int EURNZD_SL_Pips = 20;
input int EURNZD_Trailing = 20;
input bool Use_GBPAUD = false;
input double GBPAUD_TP_USD = 20;
input int GBPAUD_TP_Pips = 20;
input int GBPAUD_SL_Pips = 20;
input int GBPAUD_Trailing = 20;
input bool Use_GBPCHF = false;
input double GBPCHF_TP_USD = 20;
input int GBPCHF_TP_Pips = 20;
input int GBPCHF_SL_Pips = 20;
input int GBPCHF_Trailing = 20;
input bool Use_GBPJPY = false;
input double GBPJPY_TP_USD = 20;
input int GBPJPY_TP_Pips = 20;
input int GBPJPY_SL_Pips = 20;
input int GBPJPY_Trailing = 20;
input bool Use_GBPCAD = false;
input double GBPCAD_TP_USD = 20;
input int GBPCAD_TP_Pips = 20;
input int GBPCAD_SL_Pips = 20;
input int GBPCAD_Trailing = 20;
input bool Use_GBPNZD = false;
input double GBPNZD_TP_USD = 20;
input int GBPNZD_TP_Pips = 20;
input int GBPNZD_SL_Pips = 20;
input int GBPNZD_Trailing = 20;
input bool Use_NZDJPY = false;
input double NZDJPY_TP_USD = 20;
input int NZDJPY_TP_Pips = 20;
input int NZDJPY_SL_Pips = 20;
input int NZDJPY_Trailing = 20;
input bool Use_NZDCHF = false;
input double NZDCHF_TP_USD = 20;
input int NZDCHF_TP_Pips = 20;
input int NZDCHF_SL_Pips = 20;
input int NZDCHF_Trailing = 20;
input bool Use_NZDCAD = false;
input double NZDCAD_TP_USD = 20;
input int NZDCAD_TP_Pips = 20;
input int NZDCAD_SL_Pips = 20;
input int NZDCAD_Trailing = 20;



MqlTick tick;             // ٍهêَùàے êîٍèًîâêà
MqlTick first_tick;       // ïهًâàے êîٍèًîâêà
MqlTradeRequest request;  // ïàًàىهًٍû ٍîًمîâîمî çàïًîٌà
MqlTradeResult result;    // ًهçَëüٍàٍ ٍîًمîâîمî çàïًîٌà


double order_open_price;  // ِهيà îٍêًûٍèے îًنهًà
double spread;            // âهëè÷èيà ٌïً‎نà
ulong stop_level;         // ىèيèىàëüيûé îٌٍٍَï îٍ ِهيû نëے ٌٍَàيîâêè ٌٍîï ëîٌٌà / ٍهéê ïًîôèٍà
ulong order_type;         // ٍèï îًنهًà
ulong order_ticket;       // ٍèêهٍ îًنهًà

string  symToWork;
input long magic_Number = 2020;

string Pairs = "GBPUSD,EURUSD,USDJPY,USDCAD,USDCHF,AUDUSD,NZDUSD,AUDCAD,AUDCHF,AUDJPY,AUDNZD,CADCHF,CADJPY,CHFJPY,EURAUD,EURCAD,EURCHF,EURGBP,EURJPY,EURNZD,GBPAUD,GBPCHF,GBPJPY,GBPCAD,GBPNZD,NZDJPY,NZDCHF,NZDCAD";
bool use[28] = {Use_GBPUSD,Use_EURUSD,Use_USDJPY,Use_USDCAD,Use_USDCHF,Use_AUDUSD,Use_NZDUSD,Use_AUDCAD,Use_AUDCHF,
                Use_AUDJPY,Use_AUDNZD,Use_CADCHF,Use_CADJPY,Use_CHFJPY,Use_EURAUD,Use_EURCAD,Use_EURCHF,Use_EURGBP,Use_EURJPY,Use_EURNZD,
                Use_GBPAUD,Use_GBPCAD,Use_GBPJPY,Use_GBPCAD,Use_GBPNZD,Use_NZDJPY,Use_NZDCHF,Use_NZDCAD
               };

int tp[28] = {GBPUSD_TP_Pips,EURUSD_TP_Pips,USDJPY_TP_Pips,USDCAD_TP_Pips,USDCHF_TP_Pips,AUDUSD_TP_Pips,NZDUSD_TP_Pips,
              AUDCAD_TP_Pips,AUDCHF_TP_Pips,AUDJPY_TP_Pips, AUDNZD_TP_Pips,CADCHF_TP_Pips,CADJPY_TP_Pips,CHFJPY_TP_Pips,
              EURAUD_TP_Pips,EURCAD_TP_Pips,EURCHF_TP_Pips,EURGBP_TP_Pips,EURJPY_TP_Pips,EURNZD_TP_Pips,GBPAUD_TP_Pips,GBPCHF_TP_Pips,
              GBPJPY_TP_Pips,GBPCAD_TP_Pips,GBPNZD_TP_Pips,NZDJPY_TP_Pips,NZDCHF_TP_Pips,NZDCAD_TP_Pips
             };
int sl[28] = {GBPUSD_SL_Pips,EURUSD_SL_Pips,USDJPY_SL_Pips,USDCAD_SL_Pips,USDCHF_SL_Pips,AUDUSD_SL_Pips,
              NZDUSD_SL_Pips,AUDCAD_SL_Pips,AUDCHF_SL_Pips,AUDJPY_SL_Pips,AUDNZD_SL_Pips,CADCHF_SL_Pips,
              CADJPY_SL_Pips,CHFJPY_SL_Pips,EURAUD_SL_Pips,EURCAD_SL_Pips,EURCHF_SL_Pips,EURGBP_SL_Pips,EURJPY_SL_Pips,
              EURNZD_SL_Pips,GBPAUD_SL_Pips,GBPCHF_SL_Pips,GBPJPY_SL_Pips,GBPCAD_SL_Pips,GBPNZD_SL_Pips,NZDJPY_SL_Pips,
              NZDCHF_SL_Pips,NZDCAD_SL_Pips
             };
double tpUSD[28] = {GBPUSD_TP_USD,EURUSD_TP_USD,USDJPY_TP_USD,USDCAD_TP_USD,USDCHF_TP_USD,AUDUSD_TP_USD,
                    NZDUSD_TP_USD,AUDCAD_TP_USD,AUDCHF_TP_USD, AUDJPY_TP_USD,AUDNZD_TP_USD,CADCHF_TP_USD,CADJPY_TP_USD,
                    CHFJPY_TP_USD,EURAUD_TP_USD,EURCAD_TP_USD,EURCHF_TP_USD,EURGBP_TP_USD,EURJPY_TP_USD,EURNZD_TP_USD,GBPAUD_TP_USD,
                    GBPCHF_TP_USD,GBPJPY_TP_USD,GBPCAD_TP_USD,GBPNZD_TP_USD,NZDJPY_TP_USD,NZDCHF_TP_USD,NZDCAD_TP_USD
                   };
int trailing[28] = {GBPUSD_Trailing,EURUSD_Trailing,USDJPY_Trailing,USDCAD_Trailing,USDCHF_Trailing,AUDUSD_Trailing,
                    NZDUSD_Trailing,AUDCAD_Trailing,AUDCHF_Trailing,AUDJPY_Trailing,AUDNZD_Trailing,CADCHF_Trailing,
                    CADJPY_Trailing,CHFJPY_Trailing,EURAUD_Trailing,EURCAD_Trailing,EURCHF_Trailing,EURGBP_Trailing,EURJPY_Trailing,
                    EURNZD_Trailing,GBPAUD_Trailing,GBPCHF_Trailing,GBPJPY_Trailing,GBPCAD_Trailing,GBPNZD_Trailing,NZDJPY_Trailing,
                    NZDCHF_Trailing,NZDCAD_Trailing
                   };
datetime time[28];

string Symbols[28];


// Class object
CExecute *trade[28];
CPosition *Position[28];
CPosition *SellPosition[28];
CPosition *BuyPosition[28];
CUtilities *tools[28];
bool isCustom[28];
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   int size = StringSplit(Pairs, StringGetCharacter(",", 0), Symbols);
   for(int i = 0; i < size; i++)
     {
      if(use[i])
        {
         Symbols[i]=perfix+Symbols[i]+suffix;
         SymbolSelect(Symbols[i],true);
         trade[i] = new CExecute(Symbols[i], magic_Number);
         BuyPosition[i] = new CPosition(Symbols[i], magic_Number, GROUP_POSITIONS_BUYS);
         SellPosition[i] = new CPosition(Symbols[i], magic_Number, GROUP_POSITIONS_SELLS);
         Position[i] = new CPosition(Symbols[i], magic_Number, GROUP_POSITIONS_ALL);

         tools[i] = new CUtilities(Symbols[i]);
        }
     }
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


   double profit = 0;
   double points = 0;
   int symtotal = ArraySize(Symbols);
   bool TradeAllow = !use_TimeFilter || (use_TimeFilter && sTimeFilter(TimeStart, TimeStop));


   for(int i = 0; i < symtotal; i++)
     {
      if(SymbolExist(Symbols[i],isCustom[i]))
        {
         if(use[i])
           {

            if(use_tp_per_account_usd)
              {
               if(AccountInfoDouble(ACCOUNT_EQUITY)>=AccountInfoDouble(ACCOUNT_BALANCE)+tp_usd)
                 {
                  closeall(Symbols[i]);
                 }
              }

            if(use_sl_per_account_usd)
              {
               if(AccountInfoDouble(ACCOUNT_EQUITY)<=AccountInfoDouble(ACCOUNT_BALANCE)-sl_usd)
                 {
                  closeall(Symbols[i]);
                 }
              }
           }
        }
     }


   for(int i = 0; i < symtotal; i++)
     {
      if(SymbolExist(Symbols[i],isCustom[i]))
        {
         if(use[i])
           {

            datetime canldeTime = iTime(Symbols[i], PERIOD_CURRENT, 0);
            if(TradeAllow)
              {
               if(Ordertype==BuyOnly)
                 {
                  //if(BuyBuff[0] > 0 && time[i] != canldeTime)
                  //  {
                  //   if((oneTradeOnly&&Position[i].GroupTotal()==0)|| !oneTradeOnly)
                  //     {
                  //      OrderNumber++;
                  //      string comment = (string)OrderNumber;
                  //      trade[i].Position(TYPE_POSITION_BUY, lot, sl[i], tp[i], SLTP_PIPS, 30,comment);
                  //      time[i] = canldeTime;
                  //     }
                  //  }
                  if(Position[i].GroupTotal()==0)
                    {
                     trade[i].Position(TYPE_POSITION_BUY, lot, sl[i], tp[i], SLTP_PIPS, 30);
                    }
                 }

               if(Ordertype==SellOnly)
                 {
                  //if(SellBuff[0] > 0 && time[i] != canldeTime)
                  //  {
                  //   if((oneTradeOnly&&Position[i].GroupTotal()==0)|| !oneTradeOnly)
                  //     {
                  //      OrderNumber++;
                  //      string comment = (string)OrderNumber;
                  //      trade[i].Position(TYPE_POSITION_SELL, lot, sl[i], tp[i], SLTP_PIPS, 30,comment);
                  //      time[i] = canldeTime;
                  //     }
                  //  }
                  if(count_for_type(Symbols[i],ORDER_TYPE_SELL)==0)
                    {
                     trade[i].Position(TYPE_POSITION_SELL, lot, sl[i], tp[i], SLTP_PIPS, 30);
                    }
                 }
               Hedging(trade[i],Position[i],BuyPosition[i],SellPosition[i],tools[i]);

              }
            // take profit with dollar for each symbol
            if(use_tp_per_symbol_usd)
              {
               if(Position[i].GroupTotalProfit() >= tpUSD[i])
                 {
                  Position[i].GroupCloseAll(20);
                 }
              }
            // take profit with point for each symbol
            if(use_tp_per_symbol_pt || use_tp_per_account_pt)
              {
               double pt = 0;
               int tt = Position[i].GroupTotal();
               for(int x = 0; x < tt; x++)
                 {
                  if(Position[i][x].GetType() == ORDER_TYPE_BUY)
                    {
                     pt += tools[i].Bid() - Position[i][x].GetPriceOpen() ;
                    }
                  else
                     if(Position[i][x].GetType() == ORDER_TYPE_SELL)
                       {
                        pt += Position[i][x].GetPriceOpen() - tools[i].Bid() ;
                       }
                 }
               if(use_tp_per_symbol_pt)
                 {
                  if(pt >= tp_pt * tools[i].Pip())
                    {
                     Position[i].GroupCloseAll(20);
                    }
                 }
               points += pt / tools[i].Pip();
              }
            //trailing stop
            Traliling(Position[i], tools[i], trailing[i]);


           }
        }
      /* else
       {Print(Symbols[i]+" didn't exist , is custom? "+(string)isCustom[i]);}*/
     }
// close all account postion with profit
   /* for(int i = 0; i < symtotal; i++)
      {
       if(use[i])
         {
          if(profit >= tp_usd && use_tp_per_account_usd)
            {
             Position[i].GroupCloseAll(20);
            }
          if(points >= tp_pt && use_tp_per_account_pt)
            {
             Position[i].GroupCloseAll(20);
            }
         }
      }*/
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int  count_for_type(string sym,ENUM_ORDER_TYPE type)
  {

   int cnt =0;
   for(int i=PositionsTotal() ; i>=0; i--)
     {
      if(PositionGetSymbol(i)==sym && PositionGetInteger(POSITION_MAGIC)==magic_Number)
        {
         if(PositionGetInteger(POSITION_TYPE)==type)
           {

            cnt++;

           }
        }
     }
   return(cnt);
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void closeall(string &sym)
  {
   if(PositionSelect(sym)==true)
     {
      ClosePosition(sym);
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ClosePosition(string sSymbol)
  {

   request.symbol = sSymbol;
   request.volume = PositionGetDouble(POSITION_VOLUME);
   request.action=TRADE_ACTION_DEAL; // îïهًàِèے ٌ ًûيêà
   request.tp=0;
   request.sl=0;
   request.deviation=(ulong)((SymbolInfoDouble(sSymbol,SYMBOL_ASK)-SymbolInfoDouble(sSymbol,SYMBOL_BID))/SymbolInfoDouble(sSymbol,SYMBOL_POINT)); // ïî ٌïًهنَ
// request.type_filling=ORDER_FILLING_CANCEL;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY)
     {
      request.type=ORDER_TYPE_SELL;
      request.price=SymbolInfoDouble(sSymbol,SYMBOL_BID);
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL)
     {
      request.type=ORDER_TYPE_BUY;
      request.price=SymbolInfoDouble(sSymbol,SYMBOL_ASK);
     }

   OrderSend(request,result);
   if(result.retcode==TRADE_RETCODE_DONE)
      PlaySound("ok.wav");
   else
      PlaySound("stops.wav");

  }
//+------------------------------------------------------------------+
bool sTimeFilter(string inStart, string inEnd, string inString = ":")
  {
   bool Result = true;
   int TimeHourStart, TimeMinuteStart, TimeHourEnd, TimeMinuteEnd;
   static datetime Start, TimeEnd;
//---
   sInputTimeConvert(TimeHourStart, TimeMinuteStart, inStart, inString);
   sInputTimeConvert(TimeHourEnd, TimeMinuteEnd, inEnd, inString);
   Start = StringToTime(IntegerToString(TimeHourStart) + ":" + IntegerToString(TimeMinuteStart));
   TimeEnd = StringToTime(IntegerToString(TimeHourEnd) + ":" + IntegerToString(TimeMinuteEnd));
//---
   if((Start <= TimeEnd) && (((string)TimeCurrent() < TimeStart) || (TimeCurrent() > TimeEnd)))
      Result = false;
   if((Start > TimeEnd) && ((string)TimeCurrent() < TimeStart) && (TimeCurrent() > TimeEnd))
      Result = false;
//---
   return(Result);
  }
//+------------------------------------------------------------------+
//| sInputTimeConvert                                                |
//+------------------------------------------------------------------+
int sInputTimeConvert(int &inHour, int &inMinute, string inInput, string inString = ":")
  {
   int PS;
//---
   PS = StringFind(inInput, inString, 0);
   inMinute = (int)StringToDouble(StringSubstr(inInput, PS + 1, StringLen(inInput) - PS));
   inHour = (int)StringToDouble(StringSubstr(inInput, 0, PS));
//---
   return(PS);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void Traliling(CPosition & Pos, CUtilities & tool, int TrailingStopPoint)
  {
   int total = Pos.GroupTotal();
   for(int i = 0; i < total; i++)
     {
      if(Pos.SelectByIndex(i))
        {
         if(Use_Trailing)
           {
            if(tool.Bid() - Pos.GetPriceOpen() > tool.Pip() * TrailingStopPoint)
              {
               if(Pos.GetStopLoss() < tool.Bid() - tool.Pip() * TrailingStopPoint)
                 {
                  double ModfiedSl = tool.Bid() - (tool.Pip() * TrailingStopPoint);
                  Pos.Modify(ModfiedSl, Pos.GetTakeProfit(), SLTP_PRICE);
                 }
              }
           }
        }
     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Hedging(CExecute & OpenHedge,CPosition & Pos,CPosition  & BuyPos,CPosition & SellPos, CUtilities & tool)
  {
   int  posTotal=Pos.GroupTotal();
   if(Pos[posTotal-1].GetType()==ORDER_TYPE_SELL&&Pos[posTotal-1].GetProfit()<0&&tool.Bid()-Pos[posTotal-1].GetPriceOpen()>=recovryZonePoint*tool.Pip())
     {
      if(BuyPos.GroupTotal()==0)
        {
         OpenHedge.Position(TYPE_POSITION_BUY,lot*lotMultipiler,0,0,SLTP_PIPS,30);
         long lastTicket=SellPos[0].GetTicket();
         SellPos[lastTicket].Modify(0, 0, SLTP_PIPS);
        }
      else
         if(BuyPos.GroupTotal()>0)
           {
            OpenHedge.Position(TYPE_POSITION_BUY,lot*lotMultipiler,0,0,SLTP_PIPS,30);

           }
     }
   if(Pos[posTotal-1].GetType()==ORDER_TYPE_BUY&&Pos[posTotal-1].GetProfit()<0&&Pos[posTotal-1].GetPriceOpen()-tool.Bid()>=recovryZonePoint*tool.Pip())
     {
      if(SellPos.GroupTotal()==0)
        {
         OpenHedge.Position(TYPE_POSITION_SELL,lot*lotMultipiler,0,0,SLTP_PIPS,30);
         long lastTicket=BuyPos[0].GetTicket();
         BuyPos[lastTicket].Modify(0, 0, SLTP_PIPS);
        }
      else
         if(SellPos.GroupTotal()>0)
           {
            OpenHedge.Position(TYPE_POSITION_SELL,lot*lotMultipiler,0,0,SLTP_PIPS,30);

           }
     }

  }
//+------------------------------------------------------------------+
