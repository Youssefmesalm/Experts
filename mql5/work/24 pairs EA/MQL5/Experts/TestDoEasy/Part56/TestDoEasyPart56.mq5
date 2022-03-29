//+------------------------------------------------------------------+
//|                                             TestDoEasyPart56.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//--- includes
#include <DoEasy\Engine.mqh>
//--- enums
enum ENUM_BUTTONS
  {
   BUTT_BUY,
   BUTT_BUY_LIMIT,
   BUTT_BUY_STOP,
   BUTT_BUY_STOP_LIMIT,
   BUTT_CLOSE_BUY,
   BUTT_CLOSE_BUY2,
   BUTT_CLOSE_BUY_BY_SELL,
   BUTT_SELL,
   BUTT_SELL_LIMIT,
   BUTT_SELL_STOP,
   BUTT_SELL_STOP_LIMIT,
   BUTT_CLOSE_SELL,
   BUTT_CLOSE_SELL2,
   BUTT_CLOSE_SELL_BY_BUY,
   BUTT_DELETE_PENDING,
   BUTT_CLOSE_ALL,
   BUTT_SET_STOP_LOSS,
   BUTT_SET_TAKE_PROFIT,
   BUTT_PROFIT_WITHDRAWAL,
   BUTT_TRAILING_ALL
  };
#define TOTAL_BUTT   (20)
#define MA1          (1)
#define MA2          (2)
#define AMA1         (3)
#define AMA2         (4)
//--- structures
struct SDataButt
  {
   string      name;
   string      text;
  };
//--- input variables
input    ushort            InpMagic             =  123;  // Magic number
input    double            InpLots              =  0.1;  // Lots
input    uint              InpStopLoss          =  150;  // StopLoss in points
input    uint              InpTakeProfit        =  150;  // TakeProfit in points
input    uint              InpDistance          =  50;   // Pending orders distance (points)
input    uint              InpDistanceSL        =  50;   // StopLimit orders distance (points)
input    uint              InpDistancePReq      =  50;   // Distance for Pending Request's activate (points)
input    uint              InpBarsDelayPReq     =  5;    // Bars delay for Pending Request's activate (current timeframe)
input    uint              InpSlippage          =  5;    // Slippage in points
input    uint              InpSpreadMultiplier  =  1;    // Spread multiplier for adjusting stop-orders by StopLevel
input    uchar             InpTotalAttempts     =  5;    // Number of trading attempts
sinput   double            InpWithdrawal        =  10;   // Withdrawal funds (in tester)
sinput   uint              InpButtShiftX        =  0;    // Buttons X shift 
sinput   uint              InpButtShiftY        =  10;   // Buttons Y shift 
input    uint              InpTrailingStop      =  50;   // Trailing Stop (points)
input    uint              InpTrailingStep      =  20;   // Trailing Step (points)
input    uint              InpTrailingStart     =  0;    // Trailing Start (points)
input    uint              InpStopLossModify    =  20;   // StopLoss for modification (points)
input    uint              InpTakeProfitModify  =  60;   // TakeProfit for modification (points)
sinput   ENUM_SYMBOLS_MODE InpModeUsedSymbols   =  SYMBOLS_MODE_CURRENT;            // Mode of used symbols list
sinput   string            InpUsedSymbols       =  "EURUSD,AUDUSD,EURAUD,EURCAD,EURGBP,EURJPY,EURUSD,GBPUSD,NZDUSD,USDCAD,USDJPY";  // List of used symbols (comma - separator)
sinput   ENUM_TIMEFRAMES_MODE InpModeUsedTFs    =  TIMEFRAMES_MODE_LIST;            // Mode of used timeframes list
sinput   string            InpUsedTFs           =  "M1,M5,M15,M30,H1,H4,D1,W1,MN1"; // List of used timeframes (comma - separator)
sinput   bool              InpUseSounds         =  true; // Use sounds
//--- global variables
CEngine        engine;
SDataButt      butt_data[TOTAL_BUTT];
string         prefix;
double         lot;
double         withdrawal=(InpWithdrawal<0.1 ? 0.1 : InpWithdrawal);
ushort         magic_number;
uint           stoploss;
uint           takeprofit;
uint           distance_pending;
uint           distance_stoplimit;
uint           distance_pending_request;
uint           bars_delay_pending_request;
uint           slippage;
bool           trailing_on;
bool           pressed_pending_buy;
bool           pressed_pending_buy_limit;
bool           pressed_pending_buy_stop;
bool           pressed_pending_buy_stoplimit;
bool           pressed_pending_close_buy;
bool           pressed_pending_close_buy2;
bool           pressed_pending_close_buy_by_sell;
bool           pressed_pending_sell;
bool           pressed_pending_sell_limit;
bool           pressed_pending_sell_stop;
bool           pressed_pending_sell_stoplimit;
bool           pressed_pending_close_sell;
bool           pressed_pending_close_sell2;
bool           pressed_pending_close_sell_by_buy;
bool           pressed_pending_delete_all;
bool           pressed_pending_close_all;
bool           pressed_pending_sl;
bool           pressed_pending_tp;
double         trailing_stop;
double         trailing_step;
uint           trailing_start;
uint           stoploss_to_modify;
uint           takeprofit_to_modify;
int            used_symbols_mode;
string         array_used_symbols[];
string         array_used_periods[];
bool           testing;
uchar          group1;
uchar          group2;
double         g_point;
int            g_digits;
//--- Arrays of custom indicator parameters
MqlParam       param_ma1[];
MqlParam       param_ma2[];
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- Calling the function displays the list of enumeration constants in the journal 
//--- (the list is set in the strings 22 and 25 of the DELib.mqh file) for checking the constants validity
   //EnumNumbersTest();

//--- Set EA global variables
   prefix=MQLInfoString(MQL_PROGRAM_NAME)+"_";
   testing=engine.IsTester();
   for(int i=0;i<TOTAL_BUTT;i++)
     {
      butt_data[i].name=prefix+EnumToString((ENUM_BUTTONS)i);
      butt_data[i].text=EnumToButtText((ENUM_BUTTONS)i);
     }
   lot=NormalizeLot(Symbol(),fmax(InpLots,MinimumLots(Symbol())*2.0));
   magic_number=InpMagic;
   stoploss=InpStopLoss;
   takeprofit=InpTakeProfit;
   distance_pending=InpDistance;
   distance_stoplimit=InpDistanceSL;
   slippage=InpSlippage;
   trailing_stop=InpTrailingStop*Point();
   trailing_step=InpTrailingStep*Point();
   trailing_start=InpTrailingStart;
   stoploss_to_modify=InpStopLossModify;
   takeprofit_to_modify=InpTakeProfitModify;
   distance_pending_request=(InpDistancePReq<5 ? 5 : InpDistancePReq);
   bars_delay_pending_request=(InpBarsDelayPReq<1 ? 1 : InpBarsDelayPReq);
   g_point=SymbolInfoDouble(NULL,SYMBOL_POINT);
   g_digits=(int)SymbolInfoInteger(NULL,SYMBOL_DIGITS);
//--- Initialize random group numbers
   group1=0;
   group2=0;
   srand(GetTickCount());
   
//--- Initialize DoEasy library
   OnInitDoEasy();
   
//--- Create indicators
   ArrayResize(param_ma1,4);
   //--- Name of indicator 1
   param_ma1[0].type=TYPE_STRING;
   param_ma1[0].string_value="Examples\\Custom Moving Average.ex5";
   //--- Calculation period
   param_ma1[1].type=TYPE_INT;
   param_ma1[1].integer_value=13;
   //--- Horizontal shift
   param_ma1[2].type=TYPE_INT;
   param_ma1[2].integer_value=0;
   //--- Smoothing method
   param_ma1[3].type=TYPE_INT;
   param_ma1[3].integer_value=MODE_SMA;
   //--- Create indicator 1
   engine.GetIndicatorsCollection().CreateCustom(NULL,PERIOD_CURRENT,MA1,INDICATOR_GROUP_TREND,param_ma1);
   
   ArrayResize(param_ma2,5);
   //--- Name of indicator 2
   param_ma2[0].type=TYPE_STRING;
   param_ma2[0].string_value="Examples\\Custom Moving Average.ex5";
   //--- Calculation period
   param_ma2[1].type=TYPE_INT;
   param_ma2[1].integer_value=13;
   //--- Horizontal shift
   param_ma2[2].type=TYPE_INT;
   param_ma2[2].integer_value=0;
   //--- Smoothing method
   param_ma2[3].type=TYPE_INT;
   param_ma2[3].integer_value=MODE_SMA;
   //--- Calculation price
   param_ma2[4].type=TYPE_INT;
   param_ma2[4].integer_value=PRICE_OPEN;
   //--- Create indicator 2
   engine.GetIndicatorsCollection().CreateCustom(NULL,PERIOD_CURRENT,MA2,INDICATOR_GROUP_TREND,param_ma2);
   
   //--- Create indicator 3
   engine.GetIndicatorsCollection().CreateAMA(NULL,PERIOD_CURRENT,AMA1);
   //--- Create indicator 4
   engine.GetIndicatorsCollection().CreateAMA(NULL,PERIOD_CURRENT,AMA2,14);
   
   //--- Display descriptions of created indicators
   engine.GetIndicatorsCollection().Print();
   engine.GetIndicatorsCollection().PrintShort();
   
//--- Check and remove remaining EA graphical objects
   if(IsPresentObectByPrefix(prefix))
      ObjectsDeleteAll(0,prefix);

//--- Create the button panel
   if(!CreateButtons(InpButtShiftX,InpButtShiftY))
      return INIT_FAILED;
//--- Set trailing activation button status
   ButtonState(butt_data[TOTAL_BUTT-1].name,trailing_on);
//--- Reset states of the buttons for working using pending requests
   for(int i=0;i<14;i++)
     {
      ButtonState(butt_data[i].name+"_PRICE",false);
      ButtonState(butt_data[i].name+"_TIME",false);
     }

//--- Check playing a standard sound by macro substitution and a custom sound by description
   engine.PlaySoundByDescription(SND_OK);
//--- Wait for 600 milliseconds
   engine.Pause(600);
   engine.PlaySoundByDescription(TextByLanguage("Звук упавшей монетки 2","Falling coin 2"));

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- Remove EA graphical objects by an object name prefix
   ObjectsDeleteAll(0,prefix);
   Comment("");
//--- Deinitialize library
   engine.OnDeinit();
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//--- Handle the NewTick event in the library
   engine.OnTick(rates_data);

//--- If working in the tester
   if(MQLInfoInteger(MQL_TESTER))
     {
      engine.OnTimer(rates_data);   // Working in the timer
      PressButtonsControl();        // Button pressing control
      engine.EventsHandling();      // Working with events
     }
//--- Get custom indicator objects
   CIndicatorDE *ma1=engine.GetIndicatorsCollection().GetIndByID(MA1);
   CIndicatorDE *ma2=engine.GetIndicatorsCollection().GetIndByID(MA2);
   CIndicatorDE *ama1=engine.GetIndicatorsCollection().GetIndByID(AMA1);
   CIndicatorDE *ama2=engine.GetIndicatorsCollection().GetIndByID(AMA2);
   Comment
     (
      "ma1=",DoubleToString(ma1.GetDataBuffer(0,0),6),
      ", ma2=",DoubleToString(ma2.GetDataBuffer(0,0),6),
      "\nama1=",DoubleToString(ama1.GetDataBuffer(0,0),6),
      ", ama2=",DoubleToString(ama2.GetDataBuffer(0,0),6)
     );
   
   
//--- If the trailing flag is set
   if(trailing_on)
     {
      TrailingPositions();          // Trailing positions
      TrailingOrders();             // Trailing pending orders
     }
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//--- Launch the library timer (only not in the tester)
   if(!MQLInfoInteger(MQL_TESTER))
      engine.OnTimer(rates_data);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//--- If working in the tester, exit
   if(MQLInfoInteger(MQL_TESTER))
      return;
//--- Handling mouse events
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Handling pressing the buttons in the panel
      if(StringFind(sparam,"BUTT_")>0)
         PressButtonEvents(sparam);
     }
//--- Handling DoEasy library events
   if(id>CHARTEVENT_CUSTOM-1)
     {
      OnDoEasyEvent(id,lparam,dparam,sparam);
     } 
  }
//+------------------------------------------------------------------+
//| Initializing DoEasy library                                      |
//+------------------------------------------------------------------+
void OnInitDoEasy()
  {
//--- Check if working with the full list is selected
   used_symbols_mode=InpModeUsedSymbols;
   if((ENUM_SYMBOLS_MODE)used_symbols_mode==SYMBOLS_MODE_ALL)
     {
      int total=SymbolsTotal(false);
      string ru_n="\nNumber of symbols on server "+(string)total+".\nMaximal number: "+(string)SYMBOLS_COMMON_TOTAL+" of symbols.";
      string en_n="\nNumber of symbols on server "+(string)total+".\nMaximum number: "+(string)SYMBOLS_COMMON_TOTAL+" symbols.";
      string caption=TextByLanguage("Внимание!","Attention!");
      string ru="Выбран режим работы с полным списком.\nВ этом режиме первичная подготовка списков коллекций символов и таймсерий может занять длительное время."+ru_n+"\nПродолжить?\n\"Нет\" - работа с текущим символом \""+Symbol()+"\"";
      string en="Full list mode selected.\nIn this mode, the initial preparation of lists of symbol collections and timeseries can take a long time."+en_n+"\nContinue?\n\"No\" - working with the current symbol \""+Symbol()+"\"";
      string message=TextByLanguage(ru,en);
      int flags=(MB_YESNO | MB_ICONWARNING | MB_DEFBUTTON2);
      int mb_res=MessageBox(message,caption,flags);
      switch(mb_res)
        {
         case IDNO : 
           used_symbols_mode=SYMBOLS_MODE_CURRENT; 
           break;
         default:
           break;
        }
     }
//--- Set the counter start point to measure the approximate library initialization time
   ulong begin=GetTickCount();
   Print(TextByLanguage("--- Инициализация библиотеки \"DoEasy\" ---","--- Initializing \"DoEasy\" library ---"));
//--- Fill in the array of used symbols
   CreateUsedSymbolsArray((ENUM_SYMBOLS_MODE)used_symbols_mode,InpUsedSymbols,array_used_symbols);
//--- Set the type of the used symbol list in the symbol collection and fill in the list of symbol timeseries
   engine.SetUsedSymbols(array_used_symbols);
//--- Displaying the selected mode of working with the symbol object collection in the journal
   string num=
     (
      used_symbols_mode==SYMBOLS_MODE_CURRENT ? ": \""+Symbol()+"\"" : 
      TextByLanguage(". Количество используемых символов: ",". Number of symbols used: ")+(string)engine.GetSymbolsCollectionTotal()
     );
   Print(engine.ModeSymbolsListDescription(),num);
//--- Implement displaying the list of used symbols only for MQL5 - MQL4 has no ArrayPrint() function
#ifdef __MQL5__
   if(InpModeUsedSymbols!=SYMBOLS_MODE_CURRENT)
     {
      string array_symbols[];
      CArrayObj* list_symbols=engine.GetListAllUsedSymbols();
      for(int i=0;i<list_symbols.Total();i++)
        {
         CSymbol *symbol=list_symbols.At(i);
         if(symbol==NULL)
            continue;
         ArrayResize(array_symbols,ArraySize(array_symbols)+1,SYMBOLS_COMMON_TOTAL);
         array_symbols[ArraySize(array_symbols)-1]=symbol.Name();
        }
      ArrayPrint(array_symbols);
     }
#endif   
//--- Set used timeframes
   CreateUsedTimeframesArray(InpModeUsedTFs,InpUsedTFs,array_used_periods);
//--- Display the selected mode of working with the timeseries object collection
   string mode=
     (
      InpModeUsedTFs==TIMEFRAMES_MODE_CURRENT   ? 
         TextByLanguage("Работа только с текущим таймфреймом: ","Work only with current Period: ")+TimeframeDescription((ENUM_TIMEFRAMES)Period())   :
      InpModeUsedTFs==TIMEFRAMES_MODE_LIST      ? 
         TextByLanguage("Работа с заданным списком таймфреймов:","Work with predefined list of Periods:")                                              :
      TextByLanguage("Работа с полным списком таймфреймов:","Work with full list of all Periods:")
     );
   Print(mode);
//--- Implement displaying the list of used timeframes only for MQL5 - MQL4 has no ArrayPrint() function
#ifdef __MQL5__
   if(InpModeUsedTFs!=TIMEFRAMES_MODE_CURRENT)
      ArrayPrint(array_used_periods);
#endif 
//--- Create timeseries of all used symbols
   engine.SeriesCreateAll(array_used_periods);
//--- Check created timeseries - display descriptions of all created timeseries in the journal
//--- (true - only created ones, false - created and declared ones)
   engine.GetTimeSeriesCollection().PrintShort(false); // Short descriptions
   //engine.GetTimeSeriesCollection().Print(true);      // Full descriptions

//--- Create resource text files
   engine.CreateFile(FILE_TYPE_WAV,"sound_array_coin_01",TextByLanguage("Звук упавшей монетки 1","Falling coin 1"),sound_array_coin_01);
   engine.CreateFile(FILE_TYPE_WAV,"sound_array_coin_02",TextByLanguage("Звук упавших монеток","Falling coins"),sound_array_coin_02);
   engine.CreateFile(FILE_TYPE_WAV,"sound_array_coin_03",TextByLanguage("Звук монеток","Coins"),sound_array_coin_03);
   engine.CreateFile(FILE_TYPE_WAV,"sound_array_coin_04",TextByLanguage("Звук упавшей монетки 2","Falling coin 2"),sound_array_coin_04);
   engine.CreateFile(FILE_TYPE_WAV,"sound_array_click_01",TextByLanguage("Звук щелчка по кнопке 1","Button click 1"),sound_array_click_01);
   engine.CreateFile(FILE_TYPE_WAV,"sound_array_click_02",TextByLanguage("Звук щелчка по кнопке 2","Button click 2"),sound_array_click_02);
   engine.CreateFile(FILE_TYPE_WAV,"sound_array_click_03",TextByLanguage("Звук щелчка по кнопке 3","Button click 3"),sound_array_click_03);
   engine.CreateFile(FILE_TYPE_WAV,"sound_array_cash_machine_01",TextByLanguage("Звук кассового аппарата","Cash machine"),sound_array_cash_machine_01);
   engine.CreateFile(FILE_TYPE_BMP,"img_array_spot_green",TextByLanguage("Изображение \"Зелёный светодиод\"","Image \"Green Spot lamp\""),img_array_spot_green);
   engine.CreateFile(FILE_TYPE_BMP,"img_array_spot_red",TextByLanguage("Изображение \"Красный светодиод\"","Image \"Red Spot lamp\""),img_array_spot_red);

//--- Pass all existing collections to the main library class
   engine.CollectionOnInit();

//--- Set the default magic number for all used symbols
   engine.TradingSetMagic(engine.SetCompositeMagicNumber(magic_number));
//--- Set synchronous passing of orders for all used symbols
   engine.TradingSetAsyncMode(false);
//--- Set the number of trading attempts in case of an error
   engine.TradingSetTotalTry(InpTotalAttempts);
//--- Set correct order expiration and filling types to all trading objects
   engine.TradingSetCorrectTypeExpiration();
   engine.TradingSetCorrectTypeFilling();

//--- Set standard sounds for trading objects of all used symbols
   engine.SetSoundsStandart();
//--- Set the general flag of using sounds
   engine.SetUseSounds(InpUseSounds);
//--- Set the spread multiplier for symbol trading objects in the symbol collection
   engine.SetSpreadMultiplier(InpSpreadMultiplier);
      
//--- Set controlled values for symbols
   //--- Get the list of all collection symbols
   CArrayObj *list=engine.GetListAllUsedSymbols();
   if(list!=NULL && list.Total()!=0)
     {
      //--- In a loop by the list, set the necessary values for tracked symbol properties
      //--- By default, the LONG_MAX value is set to all properties, which means "Do not track this property" 
      //--- It can be enabled or disabled (by setting the value less than LONG_MAX or vice versa - set the LONG_MAX value) at any time and anywhere in the program
      /*
      for(int i=0;i<list.Total();i++)
        {
         CSymbol* symbol=list.At(i);
         if(symbol==NULL)
            continue;
         //--- Set control of the symbol price increase by 100 points
         symbol.SetControlBidInc(100000*symbol.Point());
         //--- Set control of the symbol price decrease by 100 points
         symbol.SetControlBidDec(100000*symbol.Point());
         //--- Set control of the symbol spread increase by 40 points
         symbol.SetControlSpreadInc(400);
         //--- Set control of the symbol spread decrease by 40 points
         symbol.SetControlSpreadDec(400);
         //--- Set control of the current spread by the value of 40 points
         symbol.SetControlSpreadLevel(400);
        }
      */
     }
//--- Set controlled values for the current account
   CAccount* account=engine.GetAccountCurrent();
   if(account!=NULL)
     {
      //--- Set control of the profit increase to 10
      account.SetControlledValueINC(ACCOUNT_PROP_PROFIT,10.0);
      //--- Set control of the funds increase to 15
      account.SetControlledValueINC(ACCOUNT_PROP_EQUITY,15.0);
      //--- Set profit control level to 20
      account.SetControlledValueLEVEL(ACCOUNT_PROP_PROFIT,20.0);
     }
//--- Get the end of the library initialization time counting and display it in the journal
   ulong end=GetTickCount();
   Print(TextByLanguage("Время инициализации библиотеки: ","Library initialization time: "),TimeMSCtoString(end-begin,TIME_MINUTES|TIME_SECONDS));
  }
//+------------------------------------------------------------------+
//| Handling DoEasy library events                                   |
//+------------------------------------------------------------------+
void OnDoEasyEvent(const int id,
                   const long &lparam,
                   const double &dparam,
                   const string &sparam)
  {
   int idx=id-CHARTEVENT_CUSTOM;
//--- Retrieve (1) event time milliseconds, (2) reason and (3) source from lparam, as well as (4) set the exact event time
   ushort msc=engine.EventMSC(lparam);
   ushort reason=engine.EventReason(lparam);
   ushort source=engine.EventSource(lparam);
   long time=TimeCurrent()*1000+msc;
   
//--- Handling symbol events
   if(source==COLLECTION_SYMBOLS_ID)
     {
      CSymbol *symbol=engine.GetSymbolObjByName(sparam);
      if(symbol==NULL)
         return;
      //--- Number of decimal places in the event value - in case of a 'long' event, it is 0, otherwise - Digits() of a symbol
      int digits=(idx<SYMBOL_PROP_INTEGER_TOTAL ? 0 : symbol.Digits());
      //--- Event text description
      string id_descr=(idx<SYMBOL_PROP_INTEGER_TOTAL ? symbol.GetPropertyDescription((ENUM_SYMBOL_PROP_INTEGER)idx) : symbol.GetPropertyDescription((ENUM_SYMBOL_PROP_DOUBLE)idx));
      //--- Property change text value
      string value=DoubleToString(dparam,digits);
      
      //--- Check event reasons and display its description in the journal
      if(reason==BASE_EVENT_REASON_INC)
        {
         Print(symbol.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_DEC)
        {
         Print(symbol.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_MORE_THEN)
        {
         Print(symbol.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_LESS_THEN)
        {
         Print(symbol.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_EQUALS)
        {
         Print(symbol.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
     }   
     
//--- Handling account events
   else if(source==COLLECTION_ACCOUNT_ID)
     {
      CAccount *account=engine.GetAccountCurrent();
      if(account==NULL)
         return;
      //--- Number of decimal places in the event value - in case of a 'long' event, it is 0, otherwise - Digits() of a symbol
      int digits=int(idx<ACCOUNT_PROP_INTEGER_TOTAL ? 0 : account.CurrencyDigits());
      //--- Event text description
      string id_descr=(idx<ACCOUNT_PROP_INTEGER_TOTAL ? account.GetPropertyDescription((ENUM_ACCOUNT_PROP_INTEGER)idx) : account.GetPropertyDescription((ENUM_ACCOUNT_PROP_DOUBLE)idx));
      //--- Property change text value
      string value=DoubleToString(dparam,digits);
      
      //--- Checking event reasons and handling the increase of funds by a specified value,
      
      //--- In case of a property value increase
      if(reason==BASE_EVENT_REASON_INC)
        {
         //--- Display an event in the journal
         Print(account.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
         //--- if this is an equity increase
         if(idx==ACCOUNT_PROP_EQUITY)
           {
            //--- Get the list of all open positions for the current symbol
            CArrayObj* list_positions=engine.GetListMarketPosition();
            list_positions=CSelect::ByOrderProperty(list_positions,ORDER_PROP_SYMBOL,Symbol(),EQUAL);
            //--- Select positions with the profit exceeding zero
            list_positions=CSelect::ByOrderProperty(list_positions,ORDER_PROP_PROFIT_FULL,0,MORE);
            if(list_positions!=NULL)
              {
               //--- Sort the list by profit considering commission and swap
               list_positions.Sort(SORT_BY_ORDER_PROFIT_FULL);
               //--- Get the position index with the highest profit
               int index=CSelect::FindOrderMax(list_positions,ORDER_PROP_PROFIT_FULL);
               if(index>WRONG_VALUE)
                 {
                  COrder* position=list_positions.At(index);
                  if(position!=NULL)
                    {
                     //--- Get a ticket of a position with the highest profit and close the position by a ticket
                     engine.ClosePosition(position.Ticket());
                    }
                 }
              }
           }
        }
      //--- Other events are simply displayed in the journal
      if(reason==BASE_EVENT_REASON_DEC)
        {
         Print(account.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_MORE_THEN)
        {
         Print(account.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_LESS_THEN)
        {
         Print(account.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_EQUALS)
        {
         Print(account.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
     } 
     
//--- Handling market watch window events
   else if(idx>MARKET_WATCH_EVENT_NO_EVENT && idx<SYMBOL_EVENTS_NEXT_CODE)
     {
      //--- Market Watch window event
      string descr=engine.GetMWEventDescription((ENUM_MW_EVENT)idx);
      string name=(idx==MARKET_WATCH_EVENT_SYMBOL_SORT ? "" : ": "+sparam);
      Print(TimeMSCtoString(lparam)," ",descr,name);
     }
     
//--- Handling timeseries events
   else if(idx>SERIES_EVENTS_NO_EVENT && idx<SERIES_EVENTS_NEXT_CODE)
     {
      //--- "New bar" event
      if(idx==SERIES_EVENTS_NEW_BAR)
        {
         Print(TextByLanguage("Новый бар на ","New Bar on "),sparam," ",TimeframeDescription((ENUM_TIMEFRAMES)dparam),": ",TimeToString(lparam));
        }
     }
     
//--- Handling trading events
   else if(idx>TRADE_EVENT_NO_EVENT && idx<TRADE_EVENTS_NEXT_CODE)
     {
      //--- Get the list of trading events
      CArrayObj *list=engine.GetListAllOrdersEvents();
      if(list==NULL)
         return;
      //--- get the event index shift relative to the end of the list
      //--- in the tester, the shift is passed by the lparam parameter to the event handler
      //--- outside the tester, events are sent one by one and handled in OnChartEvent()
      int shift=(testing ? (int)lparam : 0);
      CEvent *event=list.At(list.Total()-1-shift);
      if(event==NULL)
      return;
      //--- Accrue the credit
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_CREDIT)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Additional charges
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_CHARGE)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Correction
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_CORRECTION)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Enumerate bonuses
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_BONUS)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Additional commissions
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_COMISSION)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Daily commission
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_COMISSION_DAILY)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Monthly commission
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_COMISSION_MONTHLY)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Daily agent commission
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_COMISSION_AGENT_DAILY)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Monthly agent commission
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_COMISSION_AGENT_MONTHLY)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Interest rate
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_INTEREST)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Canceled buy deal
      if(event.TypeEvent()==TRADE_EVENT_BUY_CANCELLED)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Canceled sell deal
      if(event.TypeEvent()==TRADE_EVENT_SELL_CANCELLED)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Dividend operations
      if(event.TypeEvent()==TRADE_EVENT_DIVIDENT)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Accrual of franked dividend
      if(event.TypeEvent()==TRADE_EVENT_DIVIDENT_FRANKED)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Tax charges
      if(event.TypeEvent()==TRADE_EVENT_TAX)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Replenishing account balance
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_BALANCE_REFILL)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Withdrawing funds from balance
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_BALANCE_WITHDRAWAL)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      
      //--- Pending order placed
      if(event.TypeEvent()==TRADE_EVENT_PENDING_ORDER_PLASED)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Pending order removed
      if(event.TypeEvent()==TRADE_EVENT_PENDING_ORDER_REMOVED)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Pending order activated by price
      if(event.TypeEvent()==TRADE_EVENT_PENDING_ORDER_ACTIVATED)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Pending order partially activated by price
      if(event.TypeEvent()==TRADE_EVENT_PENDING_ORDER_ACTIVATED_PARTIAL)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Position opened
      if(event.TypeEvent()==TRADE_EVENT_POSITION_OPENED)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Position opened partially
      if(event.TypeEvent()==TRADE_EVENT_POSITION_OPENED_PARTIAL)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Position closed
      if(event.TypeEvent()==TRADE_EVENT_POSITION_CLOSED)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Position closed by an opposite one
      if(event.TypeEvent()==TRADE_EVENT_POSITION_CLOSED_BY_POS)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Position closed by StopLoss
      if(event.TypeEvent()==TRADE_EVENT_POSITION_CLOSED_BY_SL)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Position closed by TakeProfit
      if(event.TypeEvent()==TRADE_EVENT_POSITION_CLOSED_BY_TP)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Position reversal by a new deal (netting)
      if(event.TypeEvent()==TRADE_EVENT_POSITION_REVERSED_BY_MARKET)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Position reversal by activating a pending order (netting)
      if(event.TypeEvent()==TRADE_EVENT_POSITION_REVERSED_BY_PENDING)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Position reversal by partial market order execution (netting)
      if(event.TypeEvent()==TRADE_EVENT_POSITION_REVERSED_BY_MARKET_PARTIAL)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Position reversal by activating a pending order (netting)
      if(event.TypeEvent()==TRADE_EVENT_POSITION_REVERSED_BY_PENDING_PARTIAL)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Added volume to a position by a new deal (netting)
      if(event.TypeEvent()==TRADE_EVENT_POSITION_VOLUME_ADD_BY_MARKET)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Added volume to a position by partial execution of a market order (netting)
      if(event.TypeEvent()==TRADE_EVENT_POSITION_VOLUME_ADD_BY_MARKET_PARTIAL)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Added volume to a position by activating a pending order (netting)
      if(event.TypeEvent()==TRADE_EVENT_POSITION_VOLUME_ADD_BY_PENDING)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Added volume to a position by partial activation of a pending order (netting)
      if(event.TypeEvent()==TRADE_EVENT_POSITION_VOLUME_ADD_BY_PENDING_PARTIAL)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Position closed partially
      if(event.TypeEvent()==TRADE_EVENT_POSITION_CLOSED_PARTIAL)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Position partially closed by an opposite one
      if(event.TypeEvent()==TRADE_EVENT_POSITION_CLOSED_PARTIAL_BY_POS)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Position closed partially by StopLoss
      if(event.TypeEvent()==TRADE_EVENT_POSITION_CLOSED_PARTIAL_BY_SL)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Position closed partially by TakeProfit
      if(event.TypeEvent()==TRADE_EVENT_POSITION_CLOSED_PARTIAL_BY_TP)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- StopLimit order activation
      if(event.TypeEvent()==TRADE_EVENT_TRIGGERED_STOP_LIMIT_ORDER)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing order price
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_ORDER_PRICE)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing order and StopLoss price
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_ORDER_PRICE_SL)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing order and TakeProfit price
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_ORDER_PRICE_TP)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing order, StopLoss and TakeProfit price
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_ORDER_PRICE_SL_TP)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing order's StopLoss and TakeProfit price
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_ORDER_SL_TP)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing order's StopLoss
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_ORDER_SL)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing order's TakeProfit
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_ORDER_TP)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing position's StopLoss and TakeProfit
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_POSITION_SL_TP)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing position StopLoss
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_POSITION_SL)
        {
         Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing position TakeProfit
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_POSITION_TP)
        {
         Print(DFUN,event.TypeEventDescription());
        }
     }
  }
//+------------------------------------------------------------------+
//| Tracking the buttons' status                                     |
//+------------------------------------------------------------------+
void PressButtonsControl(void)
  {
   int total=ObjectsTotal(0,0);
   for(int i=0;i<total;i++)
     {
      string obj_name=ObjectName(0,i);
      if(StringFind(obj_name,prefix+"BUTT_")<0)
         continue;
      PressButtonEvents(obj_name);
     }
  }
//+------------------------------------------------------------------+
//| Create the buttons panel                                         |
//+------------------------------------------------------------------+
bool CreateButtons(const int shift_x=20,const int shift_y=0)
  {
   int h=18,w=82,offset=2,wpt=14;
   int cx=offset+shift_x+wpt*2+2,cy=offset+shift_y+(h+1)*(TOTAL_BUTT/2)+3*h+1;
   int x=cx,y=cy;
   int shift=0;
   for(int i=0;i<TOTAL_BUTT;i++)
     {
      x=x+(i==7 ? w+2 : 0);
      if(i==TOTAL_BUTT-6) x=cx;
      y=(cy-(i-(i>6 ? 7 : 0))*(h+1));
      if(!ButtonCreate(butt_data[i].name,x,y,(i<TOTAL_BUTT-6 ? w : w*2+2),h,butt_data[i].text,(i<4 ? clrGreen : i>6 && i<11 ? clrRed : clrBlue)))
        {
         Alert(TextByLanguage("Не удалось создать кнопку \"","Could not create button \""),butt_data[i].text);
         return false;
        }
     }
   
   h=18; offset=2;
   cx=offset+shift_x; cy=offset+shift_y+(h+1)*(TOTAL_BUTT/2)+3*h+1;
   x=cx; y=cy;
   shift=0;
   for(int i=0;i<18;i++)
     {
      y=(cy-(i-(i>6 ? 7 : 0))*(h+1));
      if(!ButtonCreate(butt_data[i].name+"_PRICE",((i>6 && i<14) || i>17 ? x+wpt*2+w*2+5 : x),y,wpt,h,"P",(i<4 ? clrGreen : i>6 && i<11 ? clrChocolate : clrBlue)))
        {
         Alert(TextByLanguage("Не удалось создать кнопку \"","Could not create button \""),butt_data[i].text+" \"P\"");
         return false;
        }
      if(!ButtonCreate(butt_data[i].name+"_TIME",((i>6 && i<14) || i>17 ? x+wpt*2+w*2+5+wpt+1 : x+wpt+1),y,wpt,h,"T",(i<4 ? clrGreen : i>6 && i<11 ? clrChocolate : clrBlue)))
        {
         Alert(TextByLanguage("Не удалось создать кнопку \"","Could not create button \""),butt_data[i].text+" \"T\"");
         return false;
        }
     }
   ChartRedraw(0);
   return true;
  }
//+------------------------------------------------------------------+
//| Create the button                                                |
//+------------------------------------------------------------------+
bool ButtonCreate(const string name,const int x,const int y,const int w,const int h,const string text,const color clr,const string font="Calibri",const int font_size=8)
  {
   if(ObjectFind(0,name)<0)
     {
      if(!ObjectCreate(0,name,OBJ_BUTTON,0,0,0)) 
        { 
         Print(DFUN,TextByLanguage("не удалось создать кнопку! Код ошибки=","Could not create button! Error code="),GetLastError()); 
         return false; 
        } 
      ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false);
      ObjectSetInteger(0,name,OBJPROP_HIDDEN,true);
      ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
      ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
      ObjectSetInteger(0,name,OBJPROP_XSIZE,w);
      ObjectSetInteger(0,name,OBJPROP_YSIZE,h);
      ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_LOWER);
      ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_LEFT_LOWER);
      ObjectSetInteger(0,name,OBJPROP_FONTSIZE,font_size);
      ObjectSetString(0,name,OBJPROP_FONT,font);
      ObjectSetString(0,name,OBJPROP_TEXT,text);
      ObjectSetInteger(0,name,OBJPROP_COLOR,clr);
      ObjectSetString(0,name,OBJPROP_TOOLTIP,"\n");
      ObjectSetInteger(0,name,OBJPROP_BORDER_COLOR,clrGray);
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Return the button status                                         |
//+------------------------------------------------------------------+
bool ButtonState(const string name)
  {
   return (bool)ObjectGetInteger(0,name,OBJPROP_STATE);
  }
//+------------------------------------------------------------------+
//| Set the button status                                            |
//+------------------------------------------------------------------+
void ButtonState(const string name,const bool state)
  {
   ObjectSetInteger(0,name,OBJPROP_STATE,state);
//--- Trailing activation button
   if(name==butt_data[TOTAL_BUTT-1].name)
     {
      if(state)
         ObjectSetInteger(0,name,OBJPROP_BGCOLOR,C'220,255,240');
      else
         ObjectSetInteger(0,name,OBJPROP_BGCOLOR,C'240,240,240');
     }
//--- Buttons enabling pending requests
   if(StringFind(name,"_PRICE")>0 || StringFind(name,"_TIME")>0)
     {
      if(state)
         ObjectSetInteger(0,name,OBJPROP_BGCOLOR,C'255,220,90');
      else
         ObjectSetInteger(0,name,OBJPROP_BGCOLOR,C'240,240,240');
     }
  }
//+------------------------------------------------------------------+
//| Transform enumeration into the button text                       |
//+------------------------------------------------------------------+
string EnumToButtText(const ENUM_BUTTONS member)
  {
   string txt=StringSubstr(EnumToString(member),5);
   StringToLower(txt);
   StringReplace(txt,"set_take_profit","Set TakeProfit");
   StringReplace(txt,"set_stop_loss","Set StopLoss");
   StringReplace(txt,"trailing_all","Trailing All");
   StringReplace(txt,"buy","Buy");
   StringReplace(txt,"sell","Sell");
   StringReplace(txt,"_limit"," Limit");
   StringReplace(txt,"_stop"," Stop");
   StringReplace(txt,"close_","Close ");
   StringReplace(txt,"2"," 1/2");
   StringReplace(txt,"_by_"," by ");
   StringReplace(txt,"profit_","Profit ");
   StringReplace(txt,"delete_","Delete ");
   return txt;
  }
//+------------------------------------------------------------------+
//| Handle pressing the buttons                                      |
//+------------------------------------------------------------------+
void PressButtonEvents(const string button_name)
  {
   bool comp_magic=true;   // Temporary variable selecting the composite magic number with random group IDs
   string comment="";
   //--- Convert button name into its string ID
   string button=StringSubstr(button_name,StringLen(prefix));
   //--- Random group 1 and 2 numbers within the range of 0 - 15
   group1=(uchar)Rand();
   group2=(uchar)Rand();
   uint magic=(comp_magic ? engine.SetCompositeMagicNumber(magic_number,group1,group2) : magic_number);
   //--- If the button is pressed
   if(ButtonState(button_name))
     {
      //--- If the BUTT_BUY button is pressed: Open Buy position
      if(button==EnumToString(BUTT_BUY))
        {
         //--- If the pending request creation buttons are not pressed, open Buy 
         if(!pressed_pending_buy)
            engine.OpenBuy(lot,Symbol(),magic,stoploss,takeprofit);   // No comment - the default comment is to be set
         //--- Otherwise, create a pending request for opening a Buy position
         else
           {
            int id=engine.OpenBuyPending(lot,Symbol(),magic,stoploss,takeprofit);
            if(id>0)
              {
               //--- set the pending request activation price and time, as well as activation parameters
               double ask=SymbolInfoDouble(NULL,SYMBOL_ASK);
               double price_activation=NormalizeDouble(ask-distance_pending_request*g_point,g_digits);
               ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
               SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_BUY,EQUAL_OR_LESS,ask,TimeCurrent());
              }
           }
        }
      //--- If the BUTT_BUY_LIMIT button is pressed: Place BuyLimit
      else if(button==EnumToString(BUTT_BUY_LIMIT))
        {
         //--- If the pending request creation buttons are not pressed, set BuyLimit
         if(!pressed_pending_buy_limit)
            engine.PlaceBuyLimit(lot,Symbol(),distance_pending,stoploss,takeprofit,magic,TextByLanguage("Отложенный BuyLimit","Pending BuyLimit order"));
         //--- Otherwise, create a pending request to place a BuyLimit order with the placement distance
         //--- and set the conditions depending on active buttons
         else
           {
            int id=engine.PlaceBuyLimitPending(lot,Symbol(),distance_pending,stoploss,takeprofit,magic);
            if(id>0)
              {
               //--- set the pending request activation price and time, as well as activation parameters
               double ask=SymbolInfoDouble(NULL,SYMBOL_ASK);
               double price_activation=NormalizeDouble(ask-distance_pending_request*g_point,g_digits);
               ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
               SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_BUY_LIMIT,EQUAL_OR_LESS,ask,TimeCurrent());
              }
           }
        }
      //--- If the BUTT_BUY_STOP button is pressed: Set BuyStop
      else if(button==EnumToString(BUTT_BUY_STOP))
        {
         //--- If the pending request creation buttons are not pressed, set BuyStop
         if(!pressed_pending_buy_stop)
            engine.PlaceBuyStop(lot,Symbol(),distance_pending,stoploss,takeprofit,magic,TextByLanguage("Отложенный BuyStop","Pending BuyStop order"));
         //--- Otherwise, create a pending request to place a BuyStop order with the placement distance
         //--- and set the conditions depending on active buttons
         else
           {
            int id=engine.PlaceBuyStopPending(lot,Symbol(),distance_pending,stoploss,takeprofit,magic);
            if(id>0)
              {
               //--- set the pending request activation price and time, as well as activation parameters
               double ask=SymbolInfoDouble(NULL,SYMBOL_ASK);
               double price_activation=NormalizeDouble(ask-distance_pending_request*g_point,g_digits);
               ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
               SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_BUY_STOP,EQUAL_OR_LESS,ask,TimeCurrent());
              }
           }
        }
      //--- If the BUTT_BUY_STOP_LIMIT button is pressed: Set BuyStopLimit
      else if(button==EnumToString(BUTT_BUY_STOP_LIMIT))
        {
         //--- If the pending request creation buttons are not pressed, set BuyStopLimit
         if(!pressed_pending_buy_stoplimit)
            engine.PlaceBuyStopLimit(lot,Symbol(),distance_pending,distance_stoplimit,stoploss,takeprofit,magic,TextByLanguage("Отложенный BuyStopLimit","Pending BuyStopLimit order"));
         //--- Otherwise, create a pending request to place a BuyStopLimit order with the placement distances
         //--- and set the conditions depending on active buttons
         else
           {
            int id=engine.PlaceBuyStopLimitPending(lot,Symbol(),distance_pending,distance_stoplimit,stoploss,takeprofit,magic);
            if(id>0)
              {
               //--- set the pending request activation price and time, as well as activation parameters
               double ask=SymbolInfoDouble(NULL,SYMBOL_ASK);
               double price_activation=NormalizeDouble(ask-distance_pending_request*g_point,g_digits);
               ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
               SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_BUY_STOP_LIMIT,EQUAL_OR_LESS,ask,TimeCurrent());
              }
           }
        }
      //--- If the BUTT_SELL button is pressed: Open Sell position
      else if(button==EnumToString(BUTT_SELL))
        {
         //--- If the pending request creation buttons are not pressed, open Sell
         if(!pressed_pending_sell)
            engine.OpenSell(lot,Symbol(),magic,stoploss,takeprofit);  // No comment - the default comment is to be set
         //--- Otherwise, create a pending request for opening a Sell position
         else
           {
            int id=engine.OpenSellPending(lot,Symbol(),magic,stoploss,takeprofit);
            if(id>0)
              {
               //--- set the pending request activation price and time, as well as activation parameters
               double bid=SymbolInfoDouble(NULL,SYMBOL_BID);
               double price_activation=NormalizeDouble(bid+distance_pending_request*g_point,g_digits);
               ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
               SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_SELL,EQUAL_OR_MORE,bid,TimeCurrent());
              }
           }
        }
      //--- If the BUTT_SELL_LIMIT button is pressed: Set SellLimit
      else if(button==EnumToString(BUTT_SELL_LIMIT))
        {
         //--- If the pending request creation buttons are not pressed, set SellLimit
         if(!pressed_pending_sell_limit)
            engine.PlaceSellLimit(lot,Symbol(),distance_pending,stoploss,takeprofit,magic,TextByLanguage("Отложенный SellLimit","Pending SellLimit order"));
         //--- Otherwise, create a pending request to place a SellLimit order with the placement distance
         //--- and set the conditions depending on active buttons
         else
           {
            int id=engine.PlaceSellLimitPending(lot,Symbol(),distance_pending,stoploss,takeprofit,magic);
            if(id>0)
              {
               //--- set the pending request activation price and time, as well as activation parameters
               double bid=SymbolInfoDouble(NULL,SYMBOL_BID);
               double price_activation=NormalizeDouble(bid+distance_pending_request*g_point,g_digits);
               ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
               SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_SELL_LIMIT,EQUAL_OR_MORE,bid,TimeCurrent());
              }
           }
        }
      //--- If the BUTT_SELL_STOP button is pressed: Set SellStop
      else if(button==EnumToString(BUTT_SELL_STOP))
        {
         //--- If the pending request creation buttons are not pressed, set SellStop
         if(!pressed_pending_sell_stop)
            engine.PlaceSellStop(lot,Symbol(),distance_pending,stoploss,takeprofit,magic,TextByLanguage("Отложенный SellStop","Pending SellStop order"));
         //--- Otherwise, create a pending request to place a SellStop order with the placement distance
         //--- and set the conditions depending on active buttons
         else
           {
            int id=engine.PlaceSellStopPending(lot,Symbol(),distance_pending,stoploss,takeprofit,magic);
            if(id>0)
              {
               //--- set the pending request activation price and time, as well as activation parameters
               double bid=SymbolInfoDouble(NULL,SYMBOL_BID);
               double price_activation=NormalizeDouble(bid+distance_pending_request*g_point,g_digits);
               ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
               SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_SELL_STOP,EQUAL_OR_MORE,bid,TimeCurrent());
              }
           }
        }
      //--- If the BUTT_SELL_STOP_LIMIT button is pressed: Set SellStopLimit
      else if(button==EnumToString(BUTT_SELL_STOP_LIMIT))
        {
         //--- If the pending request creation buttons are not pressed, set SellStopLimit
         if(!pressed_pending_sell_stoplimit)
            engine.PlaceSellStopLimit(lot,Symbol(),distance_pending,distance_stoplimit,stoploss,takeprofit,magic,TextByLanguage("Отложенный SellStopLimit","Pending SellStopLimit order"));
         //--- Otherwise, create a pending request to place a SellStopLimit order with the placement distances
         //--- and set the conditions depending on active buttons
         else
           {
            int id=engine.PlaceSellStopLimitPending(lot,Symbol(),distance_pending,distance_stoplimit,stoploss,takeprofit,magic);
            if(id>0)
              {
               //--- set the pending request activation price and time, as well as activation parameters
               double bid=SymbolInfoDouble(NULL,SYMBOL_BID);
               double price_activation=NormalizeDouble(bid+distance_pending_request*g_point,g_digits);
               ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
               SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_SELL_STOP_LIMIT,EQUAL_OR_MORE,bid,TimeCurrent());
              }
           }
        }
      //--- If the BUTT_CLOSE_BUY button is pressed: Close Buy with the maximum profit
      else if(button==EnumToString(BUTT_CLOSE_BUY))
        {
         //--- Get the list of all open positions
         CArrayObj* list=engine.GetListMarketPosition();
         //--- Select only Buy positions from the list and for the current symbol only
         list=CSelect::ByOrderProperty(list,ORDER_PROP_SYMBOL,Symbol(),EQUAL);
         list=CSelect::ByOrderProperty(list,ORDER_PROP_TYPE,POSITION_TYPE_BUY,EQUAL);
         //--- Sort the list by profit considering commission and swap
         list.Sort(SORT_BY_ORDER_PROFIT_FULL);
         //--- Get the index of the Buy position with the maximum profit
         int index=CSelect::FindOrderMax(list,ORDER_PROP_PROFIT_FULL);
         if(index>WRONG_VALUE)
           {
            //--- Get the Buy position object and close a position by ticket
            COrder* position=list.At(index);
            if(position!=NULL)
              {
               //--- If the pending request creation buttons are not pressed, close a position
               if(!pressed_pending_close_buy)
                  engine.ClosePosition((ulong)position.Ticket());
               //--- Otherwise, create a pending request for closing a position by ticket
               //--- and set the conditions depending on active buttons
               else
                 {
                  int id=engine.ClosePositionPending(position.Ticket());
                  if(id>0)
                    {
                     //--- set the pending request activation price and time, as well as activation parameters
                     double bid=SymbolInfoDouble(NULL,SYMBOL_BID);
                     double price_activation=NormalizeDouble(bid+distance_pending_request*g_point,g_digits);
                     ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
                     SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_CLOSE_BUY,EQUAL_OR_MORE,bid,TimeCurrent());
                    }
                 }
              }
           }
        }
      //--- If the BUTT_CLOSE_BUY2 button is pressed: Close the half of the Buy with the maximum profit
      else if(button==EnumToString(BUTT_CLOSE_BUY2))
        {
         //--- Get the list of all open positions
         CArrayObj* list=engine.GetListMarketPosition();
         //--- Select only Buy positions from the list and for the current symbol only
         list=CSelect::ByOrderProperty(list,ORDER_PROP_SYMBOL,Symbol(),EQUAL);
         list=CSelect::ByOrderProperty(list,ORDER_PROP_TYPE,POSITION_TYPE_BUY,EQUAL);
         //--- Sort the list by profit considering commission and swap
         list.Sort(SORT_BY_ORDER_PROFIT_FULL);
         //--- Get the index of the Buy position with the maximum profit
         int index=CSelect::FindOrderMax(list,ORDER_PROP_PROFIT_FULL);
         if(index>WRONG_VALUE)
           {
            //--- Get the Buy position object and close a position by ticket
            COrder* position=list.At(index);
            if(position!=NULL)
              {
               //--- If the pending request creation buttons are not pressed, close a position by ticket
               if(!pressed_pending_close_buy2)
                  engine.ClosePositionPartially((ulong)position.Ticket(),position.Volume()/2.0);
               //--- Otherwise, create a pending request for closing a position partially by ticket
               //--- and set the conditions depending on active buttons
               else
                 {
                  int id=engine.ClosePositionPartiallyPending(position.Ticket(),position.Volume()/2.0);
                  if(id>0)
                    {
                     //--- set the pending request activation price and time, as well as activation parameters
                     double bid=SymbolInfoDouble(NULL,SYMBOL_BID);
                     double price_activation=NormalizeDouble(bid+distance_pending_request*g_point,g_digits);
                     ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
                     SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_CLOSE_BUY2,EQUAL_OR_MORE,bid,TimeCurrent());
                    }
                 }
              }
           }
        }
      //--- If the BUTT_CLOSE_BUY_BY_SELL button is pressed: Close Buy with the maximum profit by the opposite Sell with the maximum profit
      else if(button==EnumToString(BUTT_CLOSE_BUY_BY_SELL))
        {
         //--- In case of a hedging account
         if(engine.IsHedge())
           {
            CArrayObj *list_buy=NULL, *list_sell=NULL;
            //--- Get the list of all open positions
            CArrayObj* list=engine.GetListMarketPosition();
            if(list==NULL)
               return;
            //--- Select only current symbol positions from the list
            list=CSelect::ByOrderProperty(list,ORDER_PROP_SYMBOL,Symbol(),EQUAL);
            
            //--- Select only Buy positions from the list
            list_buy=CSelect::ByOrderProperty(list,ORDER_PROP_TYPE,POSITION_TYPE_BUY,EQUAL);
            if(list_buy==NULL)
               return;
            //--- Sort the list by profit considering commission and swap
            list_buy.Sort(SORT_BY_ORDER_PROFIT_FULL);
            //--- Get the index of the Buy position with the maximum profit
            int index_buy=CSelect::FindOrderMax(list_buy,ORDER_PROP_PROFIT_FULL);
            
            //--- Select only Sell positions from the list
            list_sell=CSelect::ByOrderProperty(list,ORDER_PROP_TYPE,POSITION_TYPE_SELL,EQUAL);
            if(list_sell==NULL)
               return;
            //--- Sort the list by profit considering commission and swap
            list_sell.Sort(SORT_BY_ORDER_PROFIT_FULL);
            //--- Get the index of the Sell position with the maximum profit
            int index_sell=CSelect::FindOrderMax(list_sell,ORDER_PROP_PROFIT_FULL);
            if(index_buy>WRONG_VALUE && index_sell>WRONG_VALUE)
              {
               //--- Select the Buy position with the maximum profit
               COrder* position_buy=list_buy.At(index_buy);
               //--- Select the Sell position with the maximum profit
               COrder* position_sell=list_sell.At(index_sell);
               if(position_buy!=NULL && position_sell!=NULL)
                 {
                  //--- If the pending request creation buttons are not pressed, close positions by ticket
                  if(!pressed_pending_close_buy_by_sell)
                     engine.ClosePositionBy((ulong)position_buy.Ticket(),(ulong)position_sell.Ticket());
                  //--- Otherwise, create a pending request for closing a Buy position by an opposite Sell one
                  //--- and set the conditions depending on active buttons
                  else
                    {
                     int id=engine.ClosePositionByPending(position_buy.Ticket(),position_sell.Ticket());
                     if(id>0)
                       {
                        //--- set the pending request activation price and time, as well as activation parameters
                        double bid=SymbolInfoDouble(NULL,SYMBOL_BID);
                        double price_activation=NormalizeDouble(bid+distance_pending_request*g_point,g_digits);
                        ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
                        SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_CLOSE_BUY_BY_SELL,EQUAL_OR_MORE,bid,TimeCurrent());
                       }
                    }
                 }
              }
           }
        }
        
      //--- If the BUTT_CLOSE_SELL button is pressed: Close Sell with the maximum profit
      else if(button==EnumToString(BUTT_CLOSE_SELL))
        {
         //--- Get the list of all open positions
         CArrayObj* list=engine.GetListMarketPosition();
         //--- Select only Sell positions from the list and for the current symbol only
         list=CSelect::ByOrderProperty(list,ORDER_PROP_SYMBOL,Symbol(),EQUAL);
         list=CSelect::ByOrderProperty(list,ORDER_PROP_TYPE,POSITION_TYPE_SELL,EQUAL);
         //--- Sort the list by profit considering commission and swap
         list.Sort(SORT_BY_ORDER_PROFIT_FULL);
         //--- Get the index of the Sell position with the maximum profit
         int index=CSelect::FindOrderMax(list,ORDER_PROP_PROFIT_FULL);
         if(index>WRONG_VALUE)
           {
            //--- Get the Sell position object and close a position by ticket
            COrder* position=list.At(index);
            if(position!=NULL)
              {
               //--- If the pending request creation buttons are not pressed, close a position
               if(!pressed_pending_close_sell)
                  engine.ClosePosition((ulong)position.Ticket());
               //--- Otherwise, create a pending request for closing a position by ticket
               //--- and set the conditions depending on active buttons
               else
                 {
                  int id=engine.ClosePositionPending(position.Ticket());
                  if(id>0)
                    {
                     //--- set the pending request activation price and time, as well as activation parameters
                     double ask=SymbolInfoDouble(NULL,SYMBOL_ASK);
                     double price_activation=NormalizeDouble(ask-distance_pending_request*g_point,g_digits);
                     ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
                     SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_CLOSE_SELL,EQUAL_OR_LESS,ask,TimeCurrent());
                    }
                 }
              }
           }
        }
      //--- If the BUTT_CLOSE_SELL2 button is pressed: Close the half of the Sell with the maximum profit
      else if(button==EnumToString(BUTT_CLOSE_SELL2))
        {
         //--- Get the list of all open positions
         CArrayObj* list=engine.GetListMarketPosition();
         //--- Select only Sell positions from the list and for the current symbol only
         list=CSelect::ByOrderProperty(list,ORDER_PROP_SYMBOL,Symbol(),EQUAL);
         list=CSelect::ByOrderProperty(list,ORDER_PROP_TYPE,POSITION_TYPE_SELL,EQUAL);
         //--- Sort the list by profit considering commission and swap
         list.Sort(SORT_BY_ORDER_PROFIT_FULL);
         //--- Get the index of the Sell position with the maximum profit
         int index=CSelect::FindOrderMax(list,ORDER_PROP_PROFIT_FULL);
         if(index>WRONG_VALUE)
           {
            //--- Get the Sell position object and close a position by ticket
            COrder* position=list.At(index);
            if(position!=NULL)
              {
               //--- If the pending request creation buttons are not pressed, close a position by ticket
               if(!pressed_pending_close_sell2)
                  engine.ClosePositionPartially((ulong)position.Ticket(),position.Volume()/2.0);
               //--- Otherwise, create a pending request for closing a position partially by ticket
               //--- and set the conditions depending on active buttons
               else
                 {
                  int id=engine.ClosePositionPartiallyPending(position.Ticket(),position.Volume()/2.0);
                  if(id>0)
                    {
                     //--- set the pending request activation price and time, as well as activation parameters
                     double ask=SymbolInfoDouble(NULL,SYMBOL_ASK);
                     double price_activation=NormalizeDouble(ask-distance_pending_request*g_point,g_digits);
                     ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
                     SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_CLOSE_SELL2,EQUAL_OR_LESS,ask,TimeCurrent());
                    }
                 }
              }
           }
        }
      //--- If the BUTT_CLOSE_SELL_BY_BUY button is pressed: Close Sell with the maximum profit by the opposite Buy with the maximum profit
      else if(button==EnumToString(BUTT_CLOSE_SELL_BY_BUY))
        {
         //--- In case of a hedging account
         if(engine.IsHedge())
           {
            CArrayObj *list_buy=NULL, *list_sell=NULL;
            //--- Get the list of all open positions
            CArrayObj* list=engine.GetListMarketPosition();
            if(list==NULL)
               return;
            //--- Select only current symbol positions from the list
            list=CSelect::ByOrderProperty(list,ORDER_PROP_SYMBOL,Symbol(),EQUAL);
            
            //--- Select only Sell positions from the list
            list_sell=CSelect::ByOrderProperty(list,ORDER_PROP_TYPE,POSITION_TYPE_SELL,EQUAL);
            if(list_sell==NULL)
               return;
            //--- Sort the list by profit considering commission and swap
            list_sell.Sort(SORT_BY_ORDER_PROFIT_FULL);
            //--- Get the index of the Sell position with the maximum profit
            int index_sell=CSelect::FindOrderMax(list_sell,ORDER_PROP_PROFIT_FULL);
            
            //--- Select only Buy positions from the list
            list_buy=CSelect::ByOrderProperty(list,ORDER_PROP_TYPE,POSITION_TYPE_BUY,EQUAL);
            if(list_buy==NULL)
               return;
            //--- Sort the list by profit considering commission and swap
            list_buy.Sort(SORT_BY_ORDER_PROFIT_FULL);
            //--- Get the index of the Buy position with the maximum profit
            int index_buy=CSelect::FindOrderMax(list_buy,ORDER_PROP_PROFIT_FULL);
            if(index_sell>WRONG_VALUE && index_buy>WRONG_VALUE)
              {
               //--- Select the Sell position with the maximum profit
               COrder* position_sell=list_sell.At(index_sell);
               //--- Select the Buy position with the maximum profit
               COrder* position_buy=list_buy.At(index_buy);
               if(position_sell!=NULL && position_buy!=NULL)
                 {
                  //--- If the pending request creation buttons are not pressed, close positions by ticket
                  if(!pressed_pending_close_sell_by_buy)
                     engine.ClosePositionBy((ulong)position_sell.Ticket(),(ulong)position_buy.Ticket());
                  //--- Otherwise, create a pending request for closing a Sell position by an opposite Buy one
                  //--- and set the conditions depending on active buttons
                  else
                    {
                     int id=engine.ClosePositionByPending(position_sell.Ticket(),position_buy.Ticket());
                     if(id>0)
                       {
                        //--- set the pending request activation price and time, as well as activation parameters
                        double ask=SymbolInfoDouble(NULL,SYMBOL_ASK);
                        double price_activation=NormalizeDouble(ask-distance_pending_request*g_point,g_digits);
                        ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
                        SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_CLOSE_SELL_BY_BUY,EQUAL_OR_LESS,ask,TimeCurrent());
                       }
                    }
                 }
              }
           }
        }
      //--- If the BUTT_CLOSE_ALL is pressed: Close all positions starting with the one with the least profit
      else if(button==EnumToString(BUTT_CLOSE_ALL))
        {
         //--- Get the list of all open positions
         CArrayObj* list=engine.GetListMarketPosition();
         //--- Select only current symbol positions from the list
         list=CSelect::ByOrderProperty(list,ORDER_PROP_SYMBOL,Symbol(),EQUAL);
         if(list!=NULL)
           {
            //--- Sort the list by profit considering commission and swap
            list.Sort(SORT_BY_ORDER_PROFIT_FULL);
            int total=list.Total();
            //--- In the loop from the position with the least profit
            for(int i=0;i<total;i++)
              {
               COrder* position=list.At(i);
               if(position==NULL)
                  continue;
               //--- If the pending request creation buttons are not pressed, close each position by its ticket
               if(!pressed_pending_close_all)
                  engine.ClosePosition((ulong)position.Ticket());
               //--- Otherwise, create a pending request for closing each position
               //--- and set the conditions depending on active buttons
               else
                 {
                  int id=engine.ClosePositionPending(position.Ticket());
                  if(id>0)
                    {
                     //--- set the pending request activation price and time, as well as activation parameters
                     double price=SymbolInfoDouble(NULL,SYMBOL_BID);
                     double price_activation=NormalizeDouble(position.PriceOpen()+distance_pending_request*g_point,g_digits);
                     ENUM_COMPARER_TYPE comparer=EQUAL_OR_MORE;
                     if(position.TypeOrder()==POSITION_TYPE_SELL)
                       {
                        price=SymbolInfoDouble(NULL,SYMBOL_ASK);
                        price_activation=NormalizeDouble(position.PriceOpen()-distance_pending_request*g_point,g_digits);
                        comparer=EQUAL_OR_LESS;
                       }
                     ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
                     SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_CLOSE_ALL,comparer,price,TimeCurrent());
                    }
                 }
              }
           }
        }
      //--- If the BUTT_DELETE_PENDING button is pressed: Remove pending orders starting from the oldest one
      else if(button==EnumToString(BUTT_DELETE_PENDING))
        {
         //--- Get the list of all orders
         CArrayObj* list=engine.GetListMarketPendings();
         //--- Select only current symbol orders from the list
         list=CSelect::ByOrderProperty(list,ORDER_PROP_SYMBOL,Symbol(),EQUAL);
         if(list!=NULL)
           {
            //--- Sort the list by placement time
            list.Sort(SORT_BY_ORDER_TIME_OPEN);
            int total=list.Total();
            //--- In a loop from an order with the longest time
            for(int i=total-1;i>=0;i--)
              {
               COrder* order=list.At(i);
               if(order==NULL)
                  continue;
               //--- If the pending request creation buttons are not pressed, remove each order by its ticket
               if(!pressed_pending_delete_all)
                  engine.DeleteOrder((ulong)order.Ticket());
               //--- Otherwise, create a pending request for removing each order
               //--- and set the conditions depending on active buttons
               else
                 {
                  int id=engine.DeleteOrderPending(order.Ticket());
                  if(id>0)
                    {
                     //--- set the pending request activation price and time, as well as activation parameters
                     double price=SymbolInfoDouble(NULL,SYMBOL_ASK);
                     double price_activation=NormalizeDouble(order.PriceOpen()+(distance_pending+distance_pending_request)*g_point,g_digits);
                     ENUM_COMPARER_TYPE comparer=EQUAL_OR_MORE;
                     if(order.TypeByDirection()==ORDER_TYPE_SELL)
                       {
                        price=SymbolInfoDouble(NULL,SYMBOL_BID);
                        price_activation=NormalizeDouble(order.PriceOpen()-(distance_pending+distance_pending_request)*g_point,g_digits);
                        comparer=EQUAL_OR_LESS;
                       }
                     ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
                     SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_DELETE_PENDING,comparer,price,TimeCurrent());
                    }
                 }
              }
           }
        }
               
      //--- If the BUTT_SET_STOP_LOSS button is pressed: Place StopLoss to all orders and positions where it is not present
      if(button==EnumToString(BUTT_SET_STOP_LOSS))
        {
         SetStopLoss();
        }
      //--- If the BUTT_SET_TAKE_PROFIT button is pressed: Place TakeProfit to all orders and positions where it is not present
      if(button==EnumToString(BUTT_SET_TAKE_PROFIT))
        {
         SetTakeProfit();
        }
      //--- If the BUTT_PROFIT_WITHDRAWAL button is pressed: Withdraw funds from the account
      if(button==EnumToString(BUTT_PROFIT_WITHDRAWAL))
        {
         //--- If the program is launched in the tester
         if(MQLInfoInteger(MQL_TESTER))
           {
            //--- Emulate funds withdrawal
            TesterWithdrawal(withdrawal);
           }
        }
      //--- Wait for 1/10 of a second
      Sleep(100);
      //--- "Unpress" the button (if this is neither a trailing button, nor the buttons enabling pending requests)
      if(button!=EnumToString(BUTT_TRAILING_ALL) && StringFind(button,"_PRICE")<0 && StringFind(button,"_TIME")<0)
         ButtonState(button_name,false);
      //--- If the BUTT_TRAILING_ALL button or the buttons enabling pending requests are pressed
      else
        {
         //--- Set the active button color for the button enabling trailing
         if(button==EnumToString(BUTT_TRAILING_ALL))
           {
            ButtonState(button_name,true);
            trailing_on=true;
           }
         
         //--- Buying
         //--- Set the active button color for the button enabling pending requests for opening Buy by price or time
         if(button==EnumToString(BUTT_BUY)+"_PRICE" || button==EnumToString(BUTT_BUY)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_buy=true;
           }
         //--- Set the active button color for the button enabling pending requests for placing BuyLimit by price or time
         if(button==EnumToString(BUTT_BUY_LIMIT)+"_PRICE" || button==EnumToString(BUTT_BUY_LIMIT)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_buy_limit=true;
           }
         //--- Set the active button color for the button enabling pending requests for placing BuyStop by price or time
         if(button==EnumToString(BUTT_BUY_STOP)+"_PRICE" || button==EnumToString(BUTT_BUY_STOP)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_buy_stop=true;
           }
         //--- Set the active button color for the button enabling pending requests for placing BuyStopLimit by price or time
         if(button==EnumToString(BUTT_BUY_STOP_LIMIT)+"_PRICE" || button==EnumToString(BUTT_BUY_STOP_LIMIT)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_buy_stoplimit=true;
           }
         //--- Set the active button color for the button enabling pending requests for closing Buy by price or time
         if(button==EnumToString(BUTT_CLOSE_BUY)+"_PRICE" || button==EnumToString(BUTT_CLOSE_BUY)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_close_buy=true;
           }
         //--- Set the active button color for the button enabling pending requests for closing 1/2 Buy by price or time
         if(button==EnumToString(BUTT_CLOSE_BUY2)+"_PRICE" || button==EnumToString(BUTT_CLOSE_BUY2)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_close_buy2=true;
           }
         //--- Set the active button color for the button enabling pending requests for closing Buy by an opposite Sell by price or time
         if(button==EnumToString(BUTT_CLOSE_BUY_BY_SELL)+"_PRICE" || button==EnumToString(BUTT_CLOSE_BUY_BY_SELL)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_close_buy_by_sell=true;
           }
         
         //--- Selling
         //--- Set the active button color for the button enabling pending requests for opening Sell by price or time
         if(button==EnumToString(BUTT_SELL)+"_PRICE" || button==EnumToString(BUTT_SELL)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_sell=true;
           }
         //--- Set the active button color for the button enabling pending requests for placing SellLimit by price or time
         if(button==EnumToString(BUTT_SELL_LIMIT)+"_PRICE" || button==EnumToString(BUTT_SELL_LIMIT)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_sell_limit=true;
           }
         //--- Set the active button color for the button enabling pending requests for placing SellStop by price or time
         if(button==EnumToString(BUTT_SELL_STOP)+"_PRICE" || button==EnumToString(BUTT_SELL_STOP)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_sell_stop=true;
           }
         //--- Set the active button color for the button enabling pending requests for placing SellStopLimit by price or time
         if(button==EnumToString(BUTT_SELL_STOP_LIMIT)+"_PRICE" || button==EnumToString(BUTT_SELL_STOP_LIMIT)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_sell_stoplimit=true;
           }
         //--- Set the active button color for the button enabling pending requests for closing Sell by price or time
         if(button==EnumToString(BUTT_CLOSE_SELL)+"_PRICE" || button==EnumToString(BUTT_CLOSE_SELL)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_close_sell=true;
           }
         //--- Set the active button color for the button enabling pending requests for closing 1/2 Sell by price or time
         if(button==EnumToString(BUTT_CLOSE_SELL2)+"_PRICE" || button==EnumToString(BUTT_CLOSE_SELL2)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_close_sell2=true;
           }
         //--- Set the active button color for the button enabling pending requests for closing Sell by an opposite Buy by price or time
         if(button==EnumToString(BUTT_CLOSE_SELL_BY_BUY)+"_PRICE" || button==EnumToString(BUTT_CLOSE_SELL_BY_BUY)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_close_sell_by_buy=true;
           }
         //--- Set the active button color for the button enabling pending requests for removing orders by price or time
         if(button==EnumToString(BUTT_DELETE_PENDING)+"_PRICE" || button==EnumToString(BUTT_DELETE_PENDING)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_delete_all=true;
           }
         //--- Set the active button color for the button enabling pending requests for closing positions by price or time
         if(button==EnumToString(BUTT_CLOSE_ALL)+"_PRICE" || button==EnumToString(BUTT_CLOSE_ALL)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_close_all=true;
           }
         //--- Set the active button color for the button enabling pending requests for placing StopLoss by price or time
         if(button==EnumToString(BUTT_SET_STOP_LOSS)+"_PRICE" || button==EnumToString(BUTT_SET_STOP_LOSS)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_sl=true;
           }
         //--- Set the active button color for the button enabling pending requests for placing TakeProfit by price or time
         if(button==EnumToString(BUTT_SET_TAKE_PROFIT)+"_PRICE" || button==EnumToString(BUTT_SET_TAKE_PROFIT)+"_TIME")
           {
            ButtonState(button_name,true);
            pressed_pending_tp=true;
           }
        }
      //--- re-draw the chart
      ChartRedraw();
     }
   //--- Return a color for the inactive buttons
   else 
     {
      //--- trailing button
      if(button==EnumToString(BUTT_TRAILING_ALL))
        {
         ButtonState(button_name,false);
         trailing_on=false;
        }
      
      //--- Buying
      //--- the button enabling pending requests for opening Buy by price
      if(button==EnumToString(BUTT_BUY)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_buy=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_BUY)+"_TIME"));
        }
      //--- the button enabling pending requests for opening Buy by time
      if(button==EnumToString(BUTT_BUY)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_buy=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_BUY)+"_PRICE"));
        }
      
      //--- the button enabling pending requests for placing BuyLimit by price
      if(button==EnumToString(BUTT_BUY_LIMIT)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_buy_limit=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_BUY_LIMIT)+"_TIME"));
        }
      //--- the button enabling pending requests for placing BuyLimit by time
      if(button==EnumToString(BUTT_BUY_LIMIT)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_buy_limit=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_BUY_LIMIT)+"_PRICE"));
        }
      
      //--- the button enabling pending requests for placing BuyStop by price
      if(button==EnumToString(BUTT_BUY_STOP)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_buy_stop=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_BUY_STOP)+"_TIME"));
        }
      //--- the button enabling pending requests for placing BuyStop by time
      if(button==EnumToString(BUTT_BUY_STOP)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_buy_stop=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_BUY_STOP)+"_PRICE"));
        }
      
      //--- the button enabling pending requests for placing BuyStopLimit by price
      if(button==EnumToString(BUTT_BUY_STOP_LIMIT)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_buy_stoplimit=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_BUY_STOP_LIMIT)+"_TIME"));
        }
      //--- the button enabling pending requests for placing BuyStopLimit by time
      if(button==EnumToString(BUTT_BUY_STOP_LIMIT)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_buy_stoplimit=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_BUY_STOP_LIMIT)+"_PRICE"));
        }
      
      //--- the button enabling pending requests for closing Buy by price
      if(button==EnumToString(BUTT_CLOSE_BUY)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_close_buy=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_CLOSE_BUY)+"_TIME"));
        }
      //--- the button enabling pending requests for closing Buy by time
      if(button==EnumToString(BUTT_CLOSE_BUY)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_close_buy=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_CLOSE_BUY)+"_PRICE"));
        }
      
      //--- the button enabling pending requests for closing 1/2 Buy by price
      if(button==EnumToString(BUTT_CLOSE_BUY2)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_close_buy2=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_CLOSE_BUY2)+"_TIME"));
        }
      //--- the button enabling pending requests for closing 1/2 Buy by time
      if(button==EnumToString(BUTT_CLOSE_BUY2)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_close_buy2=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_CLOSE_BUY2)+"_PRICE"));
        }
      
      //--- the button enabling pending requests for closing Buy by an opposite Sell by price
      if(button==EnumToString(BUTT_CLOSE_BUY_BY_SELL)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_close_buy_by_sell=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_CLOSE_BUY_BY_SELL)+"_TIME"));
        }
      //--- the button enabling pending requests for closing Buy by an opposite Sell by time
      if(button==EnumToString(BUTT_CLOSE_BUY_BY_SELL)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_close_buy_by_sell=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_CLOSE_BUY_BY_SELL)+"_PRICE"));
        }

      //--- Selling
      //--- the button enabling pending requests for opening Sell by price
      if(button==EnumToString(BUTT_SELL)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_sell=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_SELL)+"_TIME"));
        }
      //--- the button enabling pending requests for opening Sell by time
      if(button==EnumToString(BUTT_SELL)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_sell=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_SELL)+"_PRICE"));
        }
      
      //--- the button enabling pending requests for placing SellLimit by price
      if(button==EnumToString(BUTT_SELL_LIMIT)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_sell_limit=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_SELL_LIMIT)+"_TIME"));
        }
      //--- the button enabling pending requests for placing SellLimit by time
      if(button==EnumToString(BUTT_SELL_LIMIT)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_sell_limit=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_SELL_LIMIT)+"_PRICE"));
        }
      
      //--- the button enabling pending requests for placing SellStop by price
      if(button==EnumToString(BUTT_SELL_STOP)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_sell_stop=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_SELL_STOP)+"_TIME"));
        }
      //--- the button enabling pending requests for placing SellStop by time
      if(button==EnumToString(BUTT_SELL_STOP)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_sell_stop=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_SELL_STOP)+"_PRICE"));
        }
      
      //--- the button enabling pending requests for placing SellStopLimit by price
      if(button==EnumToString(BUTT_SELL_STOP_LIMIT)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_sell_stoplimit=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_SELL_STOP_LIMIT)+"_TIME"));
        }
      //--- the button enabling pending requests for placing SellStopLimit by time
      if(button==EnumToString(BUTT_SELL_STOP_LIMIT)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_sell_stoplimit=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_SELL_STOP_LIMIT)+"_PRICE"));
        }
      
      //--- the button enabling pending requests for closing Sell by price
      if(button==EnumToString(BUTT_CLOSE_SELL)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_close_sell=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_CLOSE_SELL)+"_TIME"));
        }
      //--- the button enabling pending requests for closing Sell by time
      if(button==EnumToString(BUTT_CLOSE_SELL)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_close_sell=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_CLOSE_SELL)+"_PRICE"));
        }
      
      //--- the button enabling pending requests for closing 1/2 Sell by price
      if(button==EnumToString(BUTT_CLOSE_SELL2)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_close_sell2=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_CLOSE_SELL2)+"_TIME"));
        }
      //--- the button enabling pending requests for closing 1/2 Sell by time
      if(button==EnumToString(BUTT_CLOSE_SELL2)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_close_sell2=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_CLOSE_SELL2)+"_PRICE"));
        }
      
      //--- the button enabling pending requests for closing Sell by an opposite Buy by price
      if(button==EnumToString(BUTT_CLOSE_SELL_BY_BUY)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_close_sell_by_buy=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_CLOSE_SELL_BY_BUY)+"_TIME"));
        }
      //--- the button enabling pending requests for closing Sell by an opposite Buy by time
      if(button==EnumToString(BUTT_CLOSE_SELL_BY_BUY)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_close_sell_by_buy=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_CLOSE_SELL_BY_BUY)+"_PRICE"));
        }
      
      //--- the button enabling pending requests for removing orders by price
      if(button==EnumToString(BUTT_DELETE_PENDING)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_delete_all=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_DELETE_PENDING)+"_TIME"));
        }
      //--- the button enabling pending requests for removing orders by time
      if(button==EnumToString(BUTT_DELETE_PENDING)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_delete_all=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_DELETE_PENDING)+"_PRICE"));
        }
      
      //--- the button enabling pending requests for closing positions by price
      if(button==EnumToString(BUTT_CLOSE_ALL)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_close_all=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_CLOSE_ALL)+"_TIME"));
        }
      //--- the button enabling pending requests for closing positions by time
      if(button==EnumToString(BUTT_CLOSE_ALL)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_close_all=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_CLOSE_ALL)+"_PRICE"));
        }
      
      //--- the button enabling pending requests for placing StopLoss by price
      if(button==EnumToString(BUTT_SET_STOP_LOSS)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_sl=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_SET_STOP_LOSS)+"_TIME"));
        }
      //--- the button enabling pending requests for placing StopLoss by time
      if(button==EnumToString(BUTT_SET_STOP_LOSS)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_sl=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_SET_STOP_LOSS)+"_PRICE"));
        }
      
      //--- the button enabling pending requests for placing TakeProfit by price
      if(button==EnumToString(BUTT_SET_TAKE_PROFIT)+"_PRICE")
        {
         ButtonState(button_name,false);
         pressed_pending_tp=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_SET_TAKE_PROFIT)+"_TIME"));
        }
      //--- the button enabling pending requests for placing TakeProfit by time
      if(button==EnumToString(BUTT_SET_TAKE_PROFIT)+"_TIME")
        {
         ButtonState(button_name,false);
         pressed_pending_tp=(ButtonState(button_name) | ButtonState(prefix+EnumToString(BUTT_SET_TAKE_PROFIT)+"_PRICE"));
        }
      //--- re-draw the chart
      ChartRedraw();
     }
  }
//+------------------------------------------------------------------+
//| Set pending request activation conditions                        |
//+------------------------------------------------------------------+
void SetPReqCriterion(const uchar id,const double price_activation,const ulong time_activation,ENUM_BUTTONS button,ENUM_COMPARER_TYPE comp_type,const double price_curr,const datetime time_curr)
  {
//--- If the price criterion is selected
   if(ButtonState(prefix+EnumToString(button)+"_PRICE"))
     {
      //--- set the pending request activation price
      engine.SetNewActivationProperties((uchar)id,PEND_REQ_ACTIVATION_SOURCE_SYMBOL,PEND_REQ_ACTIVATE_BY_SYMBOL_BID,price_activation,comp_type,price_curr);
     }
//--- If the time criterion is selected
   if(ButtonState(prefix+EnumToString(button)+"_TIME"))
     {
      //--- set the pending request activation time
      engine.SetNewActivationProperties((uchar)id,PEND_REQ_ACTIVATION_SOURCE_SYMBOL,PEND_REQ_ACTIVATE_BY_SYMBOL_TIME,time_activation,EQUAL_OR_MORE,time_curr);
     }
//--- Get a newly created pending request by ID and display the message about adding the conditions to the journal
   CPendRequest *req_obj=engine.GetPendRequestByID((uchar)id);
   if(req_obj==NULL)
      return;
   if(engine.TradingGetLogLevel(Symbol())>LOG_LEVEL_NO_MSG)
     {
      ::Print(CMessage::Text(MSG_LIB_TEXT_PEND_REQUEST_ADD_CRITERIONS),", ID #",req_obj.ID(),":");
      req_obj.PrintActivations();
     }
  }
//+------------------------------------------------------------------+
//| Set StopLoss to all orders and positions                         |
//+------------------------------------------------------------------+
void SetStopLoss(void)
  {
   if(stoploss_to_modify==0)
      return;
//--- Set StopLoss to all positions where it is absent
   //--- Get the list of all positions
   CArrayObj* list=engine.GetListMarketPosition();
   //--- Select only current symbol positions from the list
   list=CSelect::ByOrderProperty(list,ORDER_PROP_SYMBOL,Symbol(),EQUAL);
   //--- select positions with zero StopLoss from the list
   list=CSelect::ByOrderProperty(list,ORDER_PROP_SL,0,EQUAL);
   if(list==NULL)
      return;
   int total=list.Total();
   for(int i=total-1;i>=0;i--)
     {
      COrder* position=list.At(i);
      if(position==NULL)
         continue;
      double sl=CorrectStopLoss(position.Symbol(),position.TypeByDirection(),0,stoploss_to_modify);
      //--- If the pending request creation buttons are not pressed, set StopLoss for each position by its ticket
      if(!pressed_pending_sl)
         engine.ModifyPosition((ulong)position.Ticket(),sl,-1);
      //--- Otherwise, create a pending request for setting StopLoss for each position
      //--- and set the conditions depending on active buttons
      else
        {
         int id=engine.ModifyPositionPending(position.Ticket(),sl,-1);
         if(id>0)
           {
            //--- set the pending request activation price and time, as well as activation parameters
            double price=SymbolInfoDouble(NULL,SYMBOL_BID);
            double price_activation=NormalizeDouble(position.PriceOpen()+distance_pending_request*g_point,g_digits);
            ENUM_COMPARER_TYPE comparer=EQUAL_OR_MORE;
            if(position.TypeByDirection()==ORDER_TYPE_SELL)
              {
               price=SymbolInfoDouble(NULL,SYMBOL_ASK);
               price_activation=NormalizeDouble(position.PriceOpen()-distance_pending_request*g_point,g_digits);
               comparer=EQUAL_OR_LESS;
              }
            ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
            SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_SET_STOP_LOSS,comparer,price,TimeCurrent());
           }
        }
     }
//--- Set StopLoss to all pending orders where it is absent
   //--- Get the list of all orders
   list=engine.GetListMarketPendings();
   //--- Select only current symbol positions from the list
   list=CSelect::ByOrderProperty(list,ORDER_PROP_SYMBOL,Symbol(),EQUAL);
   //--- select orders with zero StopLoss from the list
   list=CSelect::ByOrderProperty(list,ORDER_PROP_SL,0,EQUAL);
   if(list==NULL)
      return;
   total=list.Total();
   for(int i=total-1;i>=0;i--)
     {
      COrder* order=list.At(i);
      if(order==NULL)
         continue;
      double sl=CorrectStopLoss(order.Symbol(),(ENUM_ORDER_TYPE)order.TypeOrder(),order.PriceOpen(),stoploss_to_modify);
      //--- If the pending request creation buttons are not pressed, set StopLoss for each order by its ticket
      if(!pressed_pending_sl)
         engine.ModifyOrder((ulong)order.Ticket(),-1,sl,-1,-1);
      //--- Otherwise, create a pending request for setting StopLoss for each order
      //--- and set the conditions depending on active buttons
      else
        {
         int id=engine.ModifyOrderPending(order.Ticket(),-1,sl,-1,-1);
         if(id>0)
           {
            //--- set the pending request activation price and time, as well as activation parameters
            double price=SymbolInfoDouble(NULL,SYMBOL_ASK);
            double price_activation=NormalizeDouble(order.PriceOpen()+(distance_pending+distance_pending_request)*g_point,g_digits);
            ENUM_COMPARER_TYPE comparer=EQUAL_OR_MORE;
            if(order.TypeByDirection()==ORDER_TYPE_SELL)
              {
               price=SymbolInfoDouble(NULL,SYMBOL_BID);
               price_activation=NormalizeDouble(order.PriceOpen()-(distance_pending+distance_pending_request)*g_point,g_digits);
               comparer=EQUAL_OR_LESS;
              }
            ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
            SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_SET_STOP_LOSS,comparer,price,TimeCurrent());
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Set TakeProfit to all orders and positions                       |
//+------------------------------------------------------------------+
void SetTakeProfit(void)
  {
   if(takeprofit_to_modify==0)
      return;
//--- Set TakeProfit to all positions where it is absent
   //--- Get the list of all positions
   CArrayObj* list=engine.GetListMarketPosition();
   //--- Select only current symbol positions from the list
   list=CSelect::ByOrderProperty(list,ORDER_PROP_SYMBOL,Symbol(),EQUAL);
   //--- select positions with zero TakeProfit from the list
   list=CSelect::ByOrderProperty(list,ORDER_PROP_TP,0,EQUAL);
   if(list==NULL)
      return;
   int total=list.Total();
   for(int i=total-1;i>=0;i--)
     {
      COrder* position=list.At(i);
      if(position==NULL)
         continue;
      double tp=CorrectTakeProfit(position.Symbol(),position.TypeByDirection(),0,takeprofit_to_modify);
      //--- If the pending request creation buttons are not pressed, set TakeProfit for each position by its ticket
      if(!pressed_pending_tp)
         engine.ModifyPosition((ulong)position.Ticket(),-1,tp);
      //--- Otherwise, create a pending request for setting TakeProfit for each position
      //--- and set the conditions depending on active buttons
      else
        {
         int id=engine.ModifyPositionPending(position.Ticket(),-1,tp);
         if(id>0)
           {
            //--- set the pending request activation price and time, as well as activation parameters
            double price=SymbolInfoDouble(NULL,SYMBOL_BID);
            double price_activation=NormalizeDouble(position.PriceOpen()+distance_pending_request*g_point,g_digits);
            ENUM_COMPARER_TYPE comparer=EQUAL_OR_MORE;
            if(position.TypeByDirection()==ORDER_TYPE_SELL)
              {
               price=SymbolInfoDouble(NULL,SYMBOL_ASK);
               price_activation=NormalizeDouble(position.PriceOpen()-distance_pending_request*g_point,g_digits);
               comparer=EQUAL_OR_LESS;
              }
            ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
            SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_SET_TAKE_PROFIT,comparer,price,TimeCurrent());
           }
        }
     }
//--- Set TakeProfit to all pending orders where it is absent
   //--- Get the list of all orders
   list=engine.GetListMarketPendings();
   //--- Select only current symbol orders from the list
   list=CSelect::ByOrderProperty(list,ORDER_PROP_SYMBOL,Symbol(),EQUAL);
   //--- select orders with zero TakeProfit from the list
   list=CSelect::ByOrderProperty(list,ORDER_PROP_TP,0,EQUAL);
   if(list==NULL)
      return;
   total=list.Total();
   for(int i=total-1;i>=0;i--)
     {
      COrder* order=list.At(i);
      if(order==NULL)
         continue;
      double tp=CorrectTakeProfit(order.Symbol(),(ENUM_ORDER_TYPE)order.TypeOrder(),order.PriceOpen(),takeprofit_to_modify);
      //--- If the pending request creation buttons are not pressed, set TakeProfit for each order by its ticket
      if(!pressed_pending_sl)
         engine.ModifyOrder((ulong)order.Ticket(),-1,-1,tp,-1);
      //--- Otherwise, create a pending request for setting TakeProfit for each order
      //--- and set the conditions depending on active buttons
      else
        {
         int id=engine.ModifyOrderPending(order.Ticket(),-1,-1,tp,-1);
         if(id>0)
           {
            //--- set the pending request activation price and time, as well as activation parameters
            double price=SymbolInfoDouble(NULL,SYMBOL_ASK);
            double price_activation=NormalizeDouble(order.PriceOpen()+(distance_pending+distance_pending_request)*g_point,g_digits);
            ENUM_COMPARER_TYPE comparer=EQUAL_OR_MORE;
            if(order.TypeByDirection()==ORDER_TYPE_SELL)
              {
               price=SymbolInfoDouble(NULL,SYMBOL_BID);
               price_activation=NormalizeDouble(order.PriceOpen()-(distance_pending+distance_pending_request)*g_point,g_digits);
               comparer=EQUAL_OR_LESS;
              }
            ulong  time_activation=TimeCurrent()+bars_delay_pending_request*PeriodSeconds();
            SetPReqCriterion((uchar)id,price_activation,time_activation,BUTT_SET_TAKE_PROFIT,comparer,price,TimeCurrent());
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Trailing stop of a position with the maximum profit              |
//+------------------------------------------------------------------+
void TrailingPositions(void)
  {
   MqlTick tick;
   if(!SymbolInfoTick(Symbol(),tick))
      return;
   double stop_level=StopLevel(Symbol(),2)*Point();
   //--- Get the list of all open positions
   CArrayObj* list=engine.GetListMarketPosition();
   //--- Select only current symbol positions from the list
   list=CSelect::ByOrderProperty(list,ORDER_PROP_SYMBOL,Symbol(),EQUAL);
   //--- Select only Buy positions from the list
   CArrayObj* list_buy=CSelect::ByOrderProperty(list,ORDER_PROP_TYPE,POSITION_TYPE_BUY,EQUAL);
   //--- Sort the list by profit considering commission and swap
   list_buy.Sort(SORT_BY_ORDER_PROFIT_FULL);
   //--- Get the index of the Buy position with the maximum profit
   int index_buy=CSelect::FindOrderMax(list_buy,ORDER_PROP_PROFIT_FULL);
   if(index_buy>WRONG_VALUE)
     {
      COrder* buy=list_buy.At(index_buy);
      if(buy!=NULL)
        {
         //--- Calculate the new StopLoss
         double sl=NormalizeDouble(tick.bid-trailing_stop,Digits());
         //--- If the price and the StopLevel based on it are higher than the new StopLoss (the distance by StopLevel is maintained)
         if(tick.bid-stop_level>sl) 
           {
            //--- If the new StopLoss level exceeds the trailing step based on the current StopLoss
            if(buy.StopLoss()+trailing_step<sl)
              {
               //--- If we trail at any profit or position profit in points exceeds the trailing start, modify StopLoss
               if(trailing_start==0 || buy.ProfitInPoints()>(int)trailing_start)
                 {
                  engine.ModifyPosition((ulong)buy.Ticket(),sl,-1);
                 }
              }
           }
        }
     }
   //--- Select only Sell positions from the list
   CArrayObj* list_sell=CSelect::ByOrderProperty(list,ORDER_PROP_TYPE,POSITION_TYPE_SELL,EQUAL);
   //--- Sort the list by profit considering commission and swap
   list_sell.Sort(SORT_BY_ORDER_PROFIT_FULL);
   //--- Get the index of the Sell position with the maximum profit
   int index_sell=CSelect::FindOrderMax(list_sell,ORDER_PROP_PROFIT_FULL);
   if(index_sell>WRONG_VALUE)
     {
      COrder* sell=list_sell.At(index_sell);
      if(sell!=NULL)
        {
         //--- Calculate the new StopLoss
         double sl=NormalizeDouble(tick.ask+trailing_stop,Digits());
         //--- If the price and StopLevel based on it are below the new StopLoss (the distance by StopLevel is maintained)
         if(tick.ask+stop_level<sl) 
           {
            //--- If the new StopLoss level is below the trailing step based on the current StopLoss or a position has no StopLoss
            if(sell.StopLoss()-trailing_step>sl || sell.StopLoss()==0)
              {
               //--- If we trail at any profit or position profit in points exceeds the trailing start, modify StopLoss
               if(trailing_start==0 || sell.ProfitInPoints()>(int)trailing_start)
                 {
                  engine.ModifyPosition((ulong)sell.Ticket(),sl,-1);
                 }
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Trailing the farthest pending orders                             |
//+------------------------------------------------------------------+
void TrailingOrders(void)
  {
   MqlTick tick;
   if(!SymbolInfoTick(Symbol(),tick))
      return;
   double stop_level=StopLevel(Symbol(),2)*Point();
//--- Get the list of all placed orders
   CArrayObj* list=engine.GetListMarketPendings();
   //--- Select only current symbol orders from the list
   list=CSelect::ByOrderProperty(list,ORDER_PROP_SYMBOL,Symbol(),EQUAL);
//--- Select only Buy orders from the list
   CArrayObj* list_buy=CSelect::ByOrderProperty(list,ORDER_PROP_DIRECTION,ORDER_TYPE_BUY,EQUAL);
   //--- Sort the list by distance from the price in points (by profit in points)
   list_buy.Sort(SORT_BY_ORDER_PROFIT_PT);
   //--- Get the index of the Buy order with the greatest distance
   int index_buy=CSelect::FindOrderMax(list_buy,ORDER_PROP_PROFIT_PT);
   if(index_buy>WRONG_VALUE)
     {
      COrder* buy=list_buy.At(index_buy);
      if(buy!=NULL)
        {
         //--- If the order is below the price (BuyLimit) and it should be "elevated" following the price
         if(buy.TypeOrder()==ORDER_TYPE_BUY_LIMIT)
           {
            //--- Calculate the new order price and stop levels based on it
            double price=NormalizeDouble(tick.ask-trailing_stop,Digits());
            double sl=(buy.StopLoss()>0 ? NormalizeDouble(price-(buy.PriceOpen()-buy.StopLoss()),Digits()) : 0);
            double tp=(buy.TakeProfit()>0 ? NormalizeDouble(price+(buy.TakeProfit()-buy.PriceOpen()),Digits()) : 0);
            //--- If the calculated price is below the StopLevel distance based on Ask order price (the distance by StopLevel is maintained)
            if(price<tick.ask-stop_level) 
              {
               //--- If the calculated price exceeds the trailing step based on the order placement price, modify the order price
               if(price>buy.PriceOpen()+trailing_step)
                 {
                  engine.ModifyOrder((ulong)buy.Ticket(),price,sl,tp,-1);
                 }
              }
           }
         //--- If the order exceeds the price (BuyStop and BuyStopLimit), and it should be "decreased" following the price
         else
           {
            //--- Calculate the new order price and stop levels based on it
            double price=NormalizeDouble(tick.ask+trailing_stop,Digits());
            double sl=(buy.StopLoss()>0 ? NormalizeDouble(price-(buy.PriceOpen()-buy.StopLoss()),Digits()) : 0);
            double tp=(buy.TakeProfit()>0 ? NormalizeDouble(price+(buy.TakeProfit()-buy.PriceOpen()),Digits()) : 0);
            //--- If the calculated price exceeds the StopLevel based on Ask order price (the distance by StopLevel is maintained)
            if(price>tick.ask+stop_level) 
              {
               //--- If the calculated price is lower than the trailing step based on order price, modify the order price
               if(price<buy.PriceOpen()-trailing_step)
                 {
                  engine.ModifyOrder((ulong)buy.Ticket(),price,sl,tp,-1);
                 }
              }
           }
        }
     }
//--- Select only Sell order from the list
   CArrayObj* list_sell=CSelect::ByOrderProperty(list,ORDER_PROP_DIRECTION,ORDER_TYPE_SELL,EQUAL);
   //--- Sort the list by distance from the price in points (by profit in points)
   list_sell.Sort(SORT_BY_ORDER_PROFIT_PT);
   //--- Get the index of the Sell order having the greatest distance
   int index_sell=CSelect::FindOrderMax(list_sell,ORDER_PROP_PROFIT_PT);
   if(index_sell>WRONG_VALUE)
     {
      COrder* sell=list_sell.At(index_sell);
      if(sell!=NULL)
        {
         //--- If the order exceeds the price (SellLimit), and it needs to be "decreased" following the price
         if(sell.TypeOrder()==ORDER_TYPE_SELL_LIMIT)
           {
            //--- Calculate the new order price and stop levels based on it
            double price=NormalizeDouble(tick.bid+trailing_stop,Digits());
            double sl=(sell.StopLoss()>0 ? NormalizeDouble(price+(sell.StopLoss()-sell.PriceOpen()),Digits()) : 0);
            double tp=(sell.TakeProfit()>0 ? NormalizeDouble(price-(sell.PriceOpen()-sell.TakeProfit()),Digits()) : 0);
            //--- If the calculated price exceeds the StopLevel distance based on the Bid order price (the distance by StopLevel is maintained)
            if(price>tick.bid+stop_level) 
              {
               //--- If the calculated price is lower than the trailing step based on order price, modify the order price
               if(price<sell.PriceOpen()-trailing_step)
                 {
                  engine.ModifyOrder((ulong)sell.Ticket(),price,sl,tp,-1);
                 }
              }
           }
         //--- If the order is below the price (SellStop and SellStopLimit), and it should be "elevated" following the price
         else
           {
            //--- Calculate the new order price and stop levels based on it
            double price=NormalizeDouble(tick.bid-trailing_stop,Digits());
            double sl=(sell.StopLoss()>0 ? NormalizeDouble(price+(sell.StopLoss()-sell.PriceOpen()),Digits()) : 0);
            double tp=(sell.TakeProfit()>0 ? NormalizeDouble(price-(sell.PriceOpen()-sell.TakeProfit()),Digits()) : 0);
            //--- If the calculated price is below the StopLevel distance based on the Bid order price (the distance by StopLevel is maintained)
            if(price<tick.bid-stop_level) 
              {
               //--- If the calculated price exceeds the trailing step based on the order placement price, modify the order price
               if(price>sell.PriceOpen()+trailing_step)
                 {
                  engine.ModifyOrder((ulong)sell.Ticket(),price,sl,tp,-1);
                 }
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| A random value within the range                                  |
//+------------------------------------------------------------------+
uint Rand(const uint min=0, const uint max=15)
  {
   return (rand() % (max+1-min))+min;
  }
//+------------------------------------------------------------------+
