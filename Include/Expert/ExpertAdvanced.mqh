//+------------------------------------------------------------------+
//|                                               ExpertAdvanced.mqh |
//|                                      Copyright 2014, PunkBASSter |
//|                      https://login.mql5.com/en/users/punkbasster |
//+------------------------------------------------------------------+

#include "Expert.mqh"
#include "ExpertSignalAdvanced.mqh"

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CExpertAdvanced : public CExpert
  {
protected:
   int               used_symbols_mode;
   bool              testing;
   ENUM_SYMBOLS_MODE InpModeUsedSymbols;              // Mode of used symbols list
   string            InpUsedSymbols;         // List of used symbols (comma - separator)
   ENUM_TIMEFRAMES_MODE InpModeUsedTFs ;               // Mode of used timeframes list
   string            InpUsedTFs ;           // List of used timeframes (comma - separator)
   string            array_used_symbols[];
   string            array_used_periods[];

   ENUM_INPUT_YES_NO InpUseBook;                                // Use Depth of Market
   ENUM_INPUT_YES_NO InpUseMqlSignals ;                           // Use signal service
   ENUM_INPUT_YES_NO InpUseCharts;                               // Use Charts control
   ENUM_INPUT_YES_NO InpUseSounds;                               // Use sounds

   //--- global variables
   CEngine           engine;
   ushort            magic_number;

   uint              InpSpreadMultiplier ;    // Spread multiplier for adjusting stop-orders by StopLevel
   uchar             InpTotalAttempts     ;    // Number of trading attempts


protected:
   virtual bool      CheckTrailingOrderLong();
   virtual bool      CheckTrailingOrderShort();
   virtual bool      UpdateOrder(double price,double sl,double tp,datetime ex);

public:
                     CExpertAdvanced();
                    ~CExpertAdvanced();
   //--- initialization
   bool              Init(string symbol,ENUM_TIMEFRAMES period,bool every_tick,ulong magic=0);
   //--- deinitialization
   virtual void      Deinit(void);
   void              DoEasyInit();
   void              OnDoEasyEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //Setter
   void              Set_ModeUsedSymbols(ENUM_SYMBOLS_MODE value) {InpModeUsedSymbols=value;};
   void              Set_ModeUsedTFs(ENUM_TIMEFRAMES_MODE value) {InpModeUsedTFs=value;};
   void              Set_UsedTFs(string value) {InpUsedTFs=value;};
   void              Set_UsedSymbols(string value) {InpUsedSymbols=value;};
   void              Set_UseBook(ENUM_INPUT_YES_NO value) {InpUseBook=value;};
   void              Set_UseSounds(ENUM_INPUT_YES_NO value) {InpUseSounds=value;};
   void              Set_UseCharts(ENUM_INPUT_YES_NO value) {InpUseCharts=value;};
   void              Set_UseMqlSignals(ENUM_INPUT_YES_NO value) {InpUseMqlSignals=value;};
   //--- event handlers
   virtual void      OnTick(void);
   virtual void      OnTimer(void);
   virtual void      OnChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   virtual void      OnBookEvent(const string &symbol);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CExpertAdvanced::CExpertAdvanced()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CExpertAdvanced::~CExpertAdvanced()
  {
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Initialization and checking for input parameters                 |
//+------------------------------------------------------------------+
bool CExpertAdvanced::Init(string symbol,ENUM_TIMEFRAMES period,bool every_tick,ulong magic)
  {
   if(CExpert::Init(symbol,period,every_tick,magic)==false)
     {
      return false;
     }
   testing=engine.IsTester();
//--- Initialize DoEasy library
   DoEasyInit();

//--- Check playing a standard sound by macro substitution and a custom sound by description
   engine.PlaySoundByDescription(SND_OK);
//--- Wait for 600 milliseconds
   engine.Pause(600);
   engine.PlaySoundByDescription(TextByLanguage("Звук упавшей монетки 2","Falling coin 2"));
   return true;

  }

//+------------------------------------------------------------------+
//| Deinitialization expert                                          |
//+------------------------------------------------------------------+
void CExpertAdvanced::Deinit(void)
  {
//Deinitialize Expert
   CExpert::Deinit();
//--- Deinitialize library
   engine.OnDeinit();

  }

//+------------------------------------------------------------------+
//| OnTick handler                                                   |
//+------------------------------------------------------------------+
void CExpertAdvanced::OnTick(void)
  {
//--- check process flag
   if(!m_on_tick_process)
      return;
//--- updated quotes and indicators
   if(!Refresh())
      return;
//--- Handle the NewTick event in the library
   engine.OnTick(rates_data);

//--- If working in the tester
   if(MQLInfoInteger(MQL_TESTER))
     {
      engine.OnTimer(rates_data);   // Working in the timer
      engine.EventsHandling();      // Working with events
     }
//--- If it is the first launch
   static bool done=false;
   if(!done)
     {
      //--- Get the chart with the EA from the collection and display its full description
      CChartObj *chart_main=engine.ChartGetMainChart();
      Print("");
      chart_main.Print();
      done=true;
     }
//--- expert processing
   Processing();
  }

//+------------------------------------------------------------------+
//| OnTimer handler                                                  |
//+------------------------------------------------------------------+
void CExpertAdvanced::OnTimer(void)
  {
//--- Launch the library timer (only not in the tester)
   if(!MQLInfoInteger(MQL_TESTER))
      engine.OnTimer(rates_data);
//--- check process flag
   if(!m_on_timer_process)
      return;
  }
//+------------------------------------------------------------------+
//| OnChartEvent handler                                             |
//+------------------------------------------------------------------+
void CExpertAdvanced::OnChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- If working in the tester, exit
   if(MQLInfoInteger(MQL_TESTER))
      return;
//--- Handling DoEasy library events
   if(id>CHARTEVENT_CUSTOM-1)
     {
      OnDoEasyEvent(id,lparam,dparam,sparam);
     }
//--- Check ChartXYToTimePrice()
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Get the chart object of the current (main) program chart
      CChartObj *chart=engine.ChartGetMainChart();
      if(chart==NULL)
         return;
      //--- Get the index of a subwindow the cursor is located at
      int wnd_num=chart.XYToTimePrice(lparam,dparam);
      if(wnd_num==WRONG_VALUE)
         return;
      //--- Get the calculated cursor location time and price
      datetime time=chart.TimeFromXY();
      double price=chart.PriceFromXY();
      //--- Get the window object of the chart the cursor is located in by the subwindow index
      CChartWnd *wnd=chart.GetWindowByNum(wnd_num);
      if(wnd==NULL)
         return;
      //--- If X and Y coordinates are calculated by time and price (make a reverse conversion),
      if(wnd.TimePriceToXY(time,price))
        {
         //--- in the comment, show the time, price and index of the window that are calculated by X and Y cursor coordinates,
         //--- as well as the cursor X and Y coordinates converted back from the time and price
         Comment
         (
            DFUN,"time: ",TimeToString(time),", price: ",DoubleToString(price,Digits()),
            ", win num: ",(string)wnd_num,": x: ",(string)wnd.XFromTimePrice(),
            ", y: ",(string)wnd.YFromTimePrice()," (",(string)wnd.YFromTimePriceRelative(),")")
         ;
        }
     }
//--- check process flag
   if(!m_on_chart_event_process)
      return;

  }
//+------------------------------------------------------------------+
//| OnBookEvent handler                                              |
//+------------------------------------------------------------------+
void CExpertAdvanced::OnBookEvent(const string &symbol)
  {
//--- check process flag
   if(!m_on_book_event_process)
      return;

  }
//+------------------------------------------------------------------+
//|      DoEasy Library Initialization                               |                            |
//+------------------------------------------------------------------+
void CExpertAdvanced::DoEasyInit(void)
  {
//--- Check if working with the full list is selected
   used_symbols_mode=InpModeUsedSymbols;

   if((ENUM_SYMBOLS_MODE)used_symbols_mode==SYMBOLS_MODE_ALL)
     {
      int total=SymbolsTotal(false);
      string ru_n="\nNumber of symbols on server "+(string)total+".\nMaximal number: "+(string)SYMBOLS_COMMON_TOTAL+" of symbols.";
      string en_n="\nNumber of symbols on server "+(string)total+".\nMaximum number: "+(string)SYMBOLS_COMMON_TOTAL+" symbols.";
      string caption=TextByLanguage("Внимание!","Attention!");
      string ru="Выбран режим работы с полным списком.\nВ этом режиме первичная подготовка списков коллекций символов и таймсерий может занять длительное время."+ru_n+"\nПродолжить?\n\"Нет\" - работа с текущим символом \""+_Symbol+"\"";
      string en="Full list mode selected.\nIn this mode, the initial preparation of lists of symbol collections and timeseries can take a long time."+en_n+"\nContinue?\n\"No\" - working with the current symbol \""+_Symbol+"\"";
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
         used_symbols_mode==SYMBOLS_MODE_CURRENT ? ": \""+_Symbol+"\"" :
         TextByLanguage(". Количество используемых символов: ",". Number of symbols used: ")+(string)engine.GetSymbolsCollectionTotal()
      );
   Print(engine.ModeSymbolsListDescription(),num);
//--- Implement displaying the list of used symbols only for MQL5 - MQL4 has no ArrayPrint() function
#ifdef __MQL5__
   if(InpModeUsedSymbols!=SYMBOLS_MODE_CURRENT)
     {
      string array_symbols[];
      CArrayObj* list_symbols=engine.GetListAllUsedSymbols();
      for(int i=0; i<list_symbols.Total(); i++)
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
         TextByLanguage("Работа только с текущим таймфреймом: ","Work only with current Period: ")+TimeframeDescription((ENUM_TIMEFRAMES)_Period)   :
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

//--- Create tick series of all used symbols
   engine.TickSeriesCreateAll();
//--- Check created tick series - display descriptions of all created tick series in the journal
   engine.GetTickSeriesCollection().Print();

//--- Check created DOM series - display descriptions of all created DOM series in the journal
   engine.GetMBookSeriesCollection().Print();

//--- Create the collection of mql5.com Signals service signals
//--- If working with signals is enabled and the signal collection is created
   if(InpUseMqlSignals && engine.SignalsMQL5Create())
     {
      //--- Enable copying deals by subscription
      engine.SignalsMQL5CurrentSetSubscriptionEnableON();
      //--- Check created MQL5 signal objects of the Signals service - display the short collection description in the journal
      engine.SignalsMQL5PrintShort();
     }
//--- If working with signals is not enabled or failed to create the signal collection,
//--- disable copying deals by subscription
   else
      engine.SignalsMQL5CurrentSetSubscriptionEnableOFF();

//--- Create the chart collection
//--- If working with charts and the chart collection is created
   if(InpUseCharts && engine.ChartCreateCollection())
     {
      //--- Check created chart objects - display the short collection description in the journal
      engine.GetChartObjCollection().PrintShort();
     }

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
      for(int i=0; i<list.Total(); i++)
        {
         CSymbol* symbol=list.At(i);
         if(symbol==NULL)
            continue;
         if(InpUseBook)
            symbol.BookAdd();
         /*
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
         */
        }
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

//--- Set controlled values for charts
//--- Get the list of all collection charts
   CArrayObj *list_charts=engine.GetListCharts();
   if(list_charts!=NULL && list_charts.Total()>0)
     {
      //--- In a loop by the list, set the necessary values for tracked chart properties
      //--- By default, the LONG_MAX value is set to all properties, which means "Do not track this property"
      //--- It can be enabled or disabled (by setting the value less than LONG_MAX or vice versa - set the LONG_MAX value) at any time and anywhere in the program
      for(int i=0; i<list_charts.Total(); i++)
        {
         CChartObj* chart=list_charts.At(i);
         if(chart==NULL)
            continue;
         //--- Set reference values for the selected chart windows
         int total_wnd=chart.WindowsTotal();
         for(int j=0; j<total_wnd; j++)
           {
            CChartWnd *wnd=engine.ChartGetChartWindow(chart.ID(),j);
            if(wnd==NULL)
               continue;
            //--- Set control of the chart window height increase by 20 pixelsй
            wnd.SetControlHeightInPixelsInc(20);
            //--- Set control of the chart window height decrease by 20 pixels
            wnd.SetControlHeightInPixelsDec(20);
            //--- Set the control height of the chart window to 50 pixels
            wnd.SetControlledValueLEVEL(CHART_WINDOW_PROP_HEIGHT_IN_PIXELS,50);
           }
        }
     }

//--- Get the end of the library initialization time counting and display it in the journal
   ulong end=GetTickCount();
   Print(TextByLanguage("Время инициализации библиотеки: ","Library initialization time: "),TimeMSCtoString(end-begin,TIME_MINUTES|TIME_SECONDS));

  }
//+------------------------------------------------------------------+
//| Handling DoEasy library events                                   |
//+------------------------------------------------------------------+
void CExpertAdvanced::OnDoEasyEvent(const int id,
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
   else
      if(source==COLLECTION_ACCOUNT_ID)
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
               list_positions=CSelect::ByOrderProperty(list_positions,ORDER_PROP_SYMBOL,_Symbol,EQUAL);
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
      else
         if(idx>MARKET_WATCH_EVENT_NO_EVENT && idx<SYMBOL_EVENTS_NEXT_CODE)
           {
            //--- Market Watch window event
            string descr=engine.GetMWEventDescription((ENUM_MW_EVENT)idx);
            string name=(idx==MARKET_WATCH_EVENT_SYMBOL_SORT ? "" : ": "+sparam);
            Print(TimeMSCtoString(lparam)," ",descr,name);
           }

         //--- Handling timeseries events
         else
            if(idx>SERIES_EVENTS_NO_EVENT && idx<SERIES_EVENTS_NEXT_CODE)
              {
               //--- "New bar" event
               if(idx==SERIES_EVENTS_NEW_BAR)
                 {
                  Print(TextByLanguage("Новый бар на ","New Bar on "),sparam," ",TimeframeDescription((ENUM_TIMEFRAMES)dparam),": ",TimeToString(lparam));
                 }
              }

//--- Handle chart auto events
//--- Handle chart and window events
   if(source==COLLECTION_CHART_WND_ID)
     {
      int pos=StringFind(sparam,"_");
      long chart_id=StringToInteger(StringSubstr(sparam,0,pos));
      int wnd_num=(int)StringToInteger(StringSubstr(sparam,pos+1));

      CChartObj *chart=engine.ChartGetChartObj(chart_id);
      if(chart==NULL)
         return;
      CSymbol *symbol=engine.GetSymbolObjByName(chart.Symbol());
      if(symbol==NULL)
         return;
      CChartWnd *wnd=chart.GetWindowByNum(wnd_num);
      if(wnd==NULL)
         return;
      //--- Number of decimal places in the event value - in case of a 'long' event, it is 0, otherwise - Digits() of a symbol
      int digits=(idx<CHART_WINDOW_PROP_INTEGER_TOTAL ? 0 : symbol.Digits());
      //--- Event text description
      string id_descr=(idx<CHART_WINDOW_PROP_INTEGER_TOTAL ? wnd.GetPropertyDescription((ENUM_CHART_WINDOW_PROP_INTEGER)idx) : wnd.GetPropertyDescription((ENUM_CHART_WINDOW_PROP_DOUBLE)idx));
      //--- Property change text value
      string value=DoubleToString(dparam,digits);

      //--- Check event reasons and display its description in the journal
      if(reason==BASE_EVENT_REASON_INC)
        {
         Print(wnd.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_DEC)
        {
         Print(wnd.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_MORE_THEN)
        {
         Print(wnd.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_LESS_THEN)
        {
         Print(wnd.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_EQUALS)
        {
         Print(wnd.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
     }
//--- Handle chart auto events
   if(source==COLLECTION_CHARTS_ID)
     {
      long chart_id=StringToInteger(sparam);

      CChartObj *chart=engine.ChartGetChartObj(chart_id);
      if(chart==NULL)
         return;
      Print(DFUN,"chart_id=",chart_id,", chart.Symbol()=",chart.Symbol());
      //--- Number of decimal places in the event value - in case of a 'long' event, it is 0, otherwise - Digits() of a symbol
      int digits=int(idx<CHART_PROP_INTEGER_TOTAL ? 0 : SymbolInfoInteger(chart.Symbol(),SYMBOL_DIGITS));
      //--- Event text description
      string id_descr=(idx<CHART_PROP_INTEGER_TOTAL ? chart.GetPropertyDescription((ENUM_CHART_PROP_INTEGER)idx) : chart.GetPropertyDescription((ENUM_CHART_PROP_DOUBLE)idx));
      //--- Property change text value
      string value=DoubleToString(dparam,digits);

      //--- Check event reasons and display its description in the journal
      if(reason==BASE_EVENT_REASON_INC)
        {
         Print(chart.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_DEC)
        {
         Print(chart.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_MORE_THEN)
        {
         Print(chart.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_LESS_THEN)
        {
         Print(chart.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_EQUALS)
        {
         Print(chart.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
     }

//--- Handle non-auto chart events
   else
      if(idx>CHART_OBJ_EVENT_NO_EVENT && idx<CHART_OBJ_EVENTS_NEXT_CODE)
        {
         //--- "New chart opening" event
         if(idx==CHART_OBJ_EVENT_CHART_OPEN)
           {
            //::EventChartCustom(this.m_chart_id_main,(ushort)event,chart.ID(),chart.Timeframe(),chart.Symbol());
            CChartObj *chart=engine.ChartGetLastOpenedChart();
            if(chart!=NULL)
              {
               string symbol=sparam;
               long chart_id=lparam;
               ENUM_TIMEFRAMES timeframe=(ENUM_TIMEFRAMES)dparam;
               string header=symbol+" "+TimeframeDescription(timeframe)+", ID "+(string)chart_id;
               Print(DFUN,CMessage::Text(MSG_CHART_COLLECTION_CHART_OPENED),": ",header);
              }
           }
         //--- "Chart closure" event
         if(idx==CHART_OBJ_EVENT_CHART_CLOSE)
           {
            //::EventChartCustom(this.m_chart_id_main,(ushort)event,chart.ID(),chart.Timeframe(),chart.Symbol());
            CChartObj *chart=engine.ChartGetLastClosedChart();
            if(chart!=NULL)
              {
               string symbol=sparam;
               long   chart_id=lparam;
               ENUM_TIMEFRAMES timeframe=(ENUM_TIMEFRAMES)dparam;
               string header=symbol+" "+TimeframeDescription(timeframe)+", ID "+(string)chart_id;
               Print(DFUN,CMessage::Text(MSG_CHART_COLLECTION_CHART_CLOSED),": ",header);
              }
           }
         //--- "Chart symbol changed" event
         if(idx==CHART_OBJ_EVENT_CHART_SYMB_CHANGE)
           {
            //::EventChartCustom(this.m_chart_id_main,(ushort)event,this.m_chart_id,this.Timeframe(),this.m_symbol_prev);
            long chart_id=lparam;
            ENUM_TIMEFRAMES timeframe=(ENUM_TIMEFRAMES)dparam;
            string symbol_prev=sparam;
            CChartObj *chart=engine.ChartGetChartObj(chart_id);
            if(chart!=NULL)
              {
               string header=chart.Symbol()+" "+TimeframeDescription(timeframe)+", ID "+(string)chart_id;
               Print(DFUN,CMessage::Text(MSG_CHART_COLLECTION_CHART_SYMB_CHANGED),": ",header,": ",symbol_prev," >>> ",chart.Symbol());
              }
           }
         //--- "Chart timeframe changed" event
         if(idx==CHART_OBJ_EVENT_CHART_TF_CHANGE)
           {
            //::EventChartCustom(this.m_chart_id_main,(ushort)event,this.m_chart_id,this.m_timeframe_prev,this.Symbol());
            long chart_id=lparam;
            ENUM_TIMEFRAMES timeframe_prev=(ENUM_TIMEFRAMES)dparam;
            string symbol=sparam;
            CChartObj *chart=engine.ChartGetChartObj(chart_id);
            if(chart!=NULL)
              {
               string header=chart.Symbol()+" "+TimeframeDescription(chart.Timeframe())+", ID "+(string)chart_id;
               Print
               (
                  DFUN,CMessage::Text(MSG_CHART_COLLECTION_CHART_TF_CHANGED),": ",header,": ",
                  TimeframeDescription(timeframe_prev)," >>> ",TimeframeDescription(chart.Timeframe())
               );
              }
           }
         //--- "Chart symbol and timeframe changed" event
         if(idx==CHART_OBJ_EVENT_CHART_SYMB_TF_CHANGE)
           {
            //::EventChartCustom(this.m_chart_id_main,(ushort)event,this.m_chart_id,this.m_timeframe_prev,this.m_symbol_prev);
            long chart_id=lparam;
            ENUM_TIMEFRAMES timeframe_prev=(ENUM_TIMEFRAMES)dparam;
            string symbol_prev=sparam;
            CChartObj *chart=engine.ChartGetChartObj(chart_id);
            if(chart!=NULL)
              {
               string header=chart.Symbol()+" "+TimeframeDescription(chart.Timeframe())+", ID "+(string)chart_id;
               Print
               (
                  DFUN,CMessage::Text(MSG_CHART_COLLECTION_CHART_SYMB_TF_CHANGED),": ",header,": ",
                  symbol_prev," >>> ",chart.Symbol(),", ",TimeframeDescription(timeframe_prev)," >>> ",TimeframeDescription(chart.Timeframe())
               );
              }
           }

         //--- "Adding a new window on the chart" event
         if(idx==CHART_OBJ_EVENT_CHART_WND_ADD)
           {
            //::EventChartCustom(this.m_chart_id_main,(ushort)event,this.m_chart_id,wnd.WindowNum(),this.Symbol());
            ENUM_TIMEFRAMES timeframe=WRONG_VALUE;
            string ind_name="";
            string symbol=sparam;
            long   chart_id=lparam;
            int    win_num=(int)dparam;
            string header=symbol+" "+TimeframeDescription(timeframe)+", ID "+(string)chart_id+": ";

            CChartObj *chart=engine.ChartGetLastOpenedChart();
            if(chart!=NULL)
              {
               timeframe=chart.Timeframe();
               CChartWnd *wnd=engine.ChartGetLastAddedChartWindow(chart.ID());
               if(wnd!=NULL)
                 {
                  CWndInd *ind=wnd.GetLastAddedIndicator();
                  if(ind!=NULL)
                     ind_name=ind.Name();
                 }
              }
            Print(DFUN,header,CMessage::Text(MSG_CHART_OBJ_WINDOW_ADDED)," ",(string)win_num," ",ind_name);
           }
         //--- "Removing a window from the chart" event
         if(idx==CHART_OBJ_EVENT_CHART_WND_DEL)
           {
            //::EventChartCustom(this.m_chart_id_main,(ushort)event,this.m_chart_id,wnd.WindowNum(),this.Symbol());
            CChartWnd *wnd=engine.ChartGetLastDeletedChartWindow();
            ENUM_TIMEFRAMES timeframe=WRONG_VALUE;
            string symbol=sparam;
            long   chart_id=lparam;
            int    win_num=(int)dparam;
            string header=symbol+" "+TimeframeDescription(timeframe)+", ID "+(string)chart_id+": ";
            Print(DFUN,header,CMessage::Text(MSG_CHART_OBJ_WINDOW_REMOVED)," ",(string)win_num);
           }
         //--- "Adding a new indicator to the chart window" event
         if(idx==CHART_OBJ_EVENT_CHART_WND_IND_ADD)
           {
            //::EventChartCustom(this.m_chart_id_main,(ushort)event,this.m_chart_id,this.WindowNum(),ind.Name());
            ENUM_TIMEFRAMES timeframe=WRONG_VALUE;
            string ind_name=sparam;
            string symbol=NULL;
            long   chart_id=lparam;
            int    win_num=(int)dparam;
            string header=NULL;

            CWndInd *ind=engine.ChartGetLastAddedIndicator(chart_id,win_num);
            if(ind!=NULL)
              {
               CChartObj *chart=engine.ChartGetChartObj(chart_id);
               if(chart!=NULL)
                 {
                  symbol=chart.Symbol();
                  timeframe=chart.Timeframe();
                  CChartWnd *wnd=chart.GetWindowByNum(win_num);
                  if(wnd!=NULL)
                     header=wnd.Header();
                 }
              }
            Print(DFUN,symbol," ",TimeframeDescription(timeframe),", ID ",chart_id,", ",header,": ",CMessage::Text(MSG_CHART_OBJ_INDICATOR_ADDED)," ",ind_name);
           }
         //--- "Removing an indicator from the chart window" event
         if(idx==CHART_OBJ_EVENT_CHART_WND_IND_DEL)
           {
            //::EventChartCustom(this.m_chart_id_main,(ushort)event,this.m_chart_id,this.WindowNum(),ind.Name());
            ENUM_TIMEFRAMES timeframe=WRONG_VALUE;
            string ind_name=sparam;
            string symbol=NULL;
            long   chart_id=lparam;
            int    win_num=(int)dparam;
            string header=NULL;

            CWndInd *ind=engine.ChartGetLastDeletedIndicator();
            if(ind!=NULL)
              {
               CChartObj *chart=engine.ChartGetChartObj(chart_id);
               if(chart!=NULL)
                 {
                  symbol=chart.Symbol();
                  timeframe=chart.Timeframe();
                  CChartWnd *wnd=chart.GetWindowByNum(win_num);
                  if(wnd!=NULL)
                     header=wnd.Header();
                 }
              }
            Print(DFUN,symbol," ",TimeframeDescription(timeframe),", ID ",chart_id,", ",header,": ",CMessage::Text(MSG_CHART_OBJ_INDICATOR_REMOVED)," ",ind_name);
           }
         //--- "Changing indicator parameters in the chart window" event
         if(idx==CHART_OBJ_EVENT_CHART_WND_IND_CHANGE)
           {
            //::EventChartCustom(this.m_chart_id_main,(ushort)event,this.m_chart_id,this.WindowNum(),ind.Name());
            ENUM_TIMEFRAMES timeframe=WRONG_VALUE;
            string ind_name=sparam;
            string symbol=NULL;
            long   chart_id=lparam;
            int    win_num=(int)dparam;
            string header=NULL;

            CWndInd *ind=NULL;
            CWndInd *ind_changed=engine.ChartGetLastChangedIndicator();
            if(ind_changed!=NULL)
              {
               ind=engine.ChartGetIndicator(chart_id,win_num,ind_changed.Index());
               if(ind!=NULL)
                 {
                  CChartObj *chart=engine.ChartGetChartObj(chart_id);
                  if(chart!=NULL)
                    {
                     symbol=chart.Symbol();
                     timeframe=chart.Timeframe();
                     CChartWnd *wnd=chart.GetWindowByNum(win_num);
                     if(wnd!=NULL)
                        header=wnd.Header();
                    }
                 }
              }
            Print(DFUN,symbol," ",TimeframeDescription(timeframe),", ID ",chart_id,", ",header,": ",CMessage::Text(MSG_CHART_OBJ_INDICATOR_CHANGED)," ",ind_name," >>> ",ind.Name());
           }
        }

      //--- Handling trading events
      else
         if(idx>TRADE_EVENT_NO_EVENT && idx<TRADE_EVENTS_NEXT_CODE)
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
//| Check for trailing long limit/stop order                         |
//+------------------------------------------------------------------+
bool CExpertAdvanced::CheckTrailingOrderLong(void)
  {
   CExpertSignalAdvanced *signal_ptr=m_signal;
//--- check the possibility of modifying the long order
   double price,sl,tp;
   datetime ex;
   if(signal_ptr.CheckUpdateOrderLong(GetPointer(m_order),price,sl,tp,ex))
      return(UpdateOrder(price,sl,tp,ex));
//--- return without operations
   return(false);
  }
//+------------------------------------------------------------------+
//| Check for trailing short limit/stop order                        |
//+------------------------------------------------------------------+
bool CExpertAdvanced::CheckTrailingOrderShort(void)
  {
   CExpertSignalAdvanced *signal_ptr=m_signal;
//--- check the possibility of modifying the short order
   double price,sl,tp;
   datetime ex;
   if(signal_ptr.CheckUpdateOrderShort(GetPointer(m_order),price,sl,tp,ex))
      return(UpdateOrder(price,sl,tp,ex));
//--- return without operations
   return(false);
  }
//+------------------------------------------------------------------+
//| Updates or deletes an out-of-date pending order                  |
//+------------------------------------------------------------------+
bool CExpertAdvanced::UpdateOrder(double price,double sl,double tp,datetime ex)
  {
//Print(m_order.Ticket());
   ulong  ticket=m_order.Ticket();
   if(price==EMPTY_VALUE)
      return(m_trade.OrderDelete(ticket));
//--- modifying the order
   return(m_trade.OrderModify(ticket,price,sl,tp,m_order.TypeTime(),ex));
  }
//+------------------------------------------------------------------+
