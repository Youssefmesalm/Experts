//+------------------------------------------------------------------+
//|                                             ExpertsWithCSM.mq5 |
//|                           Copyright 2019, Alexander Shukalovich. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Alexander Shukalovich."
#property link      "https://www.mql5.com/en/users/nomadmain"
#property version   "1.00"

#define AUD_BUFFER_INDEX 0
#define CAD_BUFFER_INDEX 1
#define CHF_BUFFER_INDEX 2
#define EUR_BUFFER_INDEX 3
#define GBP_BUFFER_INDEX 4
#define JPY_BUFFER_INDEX 5
#define NZD_BUFFER_INDEX 6
#define USD_BUFFER_INDEX 7

#define CURRENCIES_COUNT 8

// Map symbols name to their indexes
string g_symbols[CURRENCIES_COUNT] = {"AUD", "CAD", "CHF", "EUR", "GBP", "JPY", "NZD", "USD"};

// CSM indicator handle
int g_handle = INVALID_HANDLE;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit(void)
  {
// Initializing of CMS indicator
   g_handle = iCustom(
                 NULL,       // Symbol for CMS
                 PERIOD_H4,  // Period for CMS
                 "Market\\Currency Strength Meter Pro for EA MT5",     // Indicator path
                 0,          // Latency (Refresh delay in seconds) 0 means every tick
                 3,          // Log level (Trace = 0, Info = 1, Warning = 2, Error = 3, Critical = 4)
                 1,          // Candles for calculation
                 0,          // Candles shift from the beginning
                 false,      // Use Moving Average smoothing
                 0,          // Moving Average Period for smoothing
                 0,          // Moving Average Method for smoothing (MODE_SMA = 0 (Simple averaging), MODE_EMA = 1 (Exponential averaging), MODE_SMMA = 2 (Smoothed averaging), MODE_LWMA = 3 (Linear-weighted averaging))
                 true,       // Auto detect symbols suffix ("Use suffix" should be disabled)
                 false,      // Use suffix
                 "",         // Symbols Suffix
                 0,          // CSM algorithm type (RSI = 0, CCI = 1, RVI = 2, MFI = 3, Stochastic = 4, DeMarket = 5, Momentum = 6)
                 ""          // CSM algorithm params (Empty string means default params)
              );

// Checking that CSM indicator was initialised
   if(g_handle == INVALID_HANDLE)
     {
      printf("Error creating CSM indicator");
      return INIT_FAILED;
     }

//--- ok
   return INIT_SUCCEEDED;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick(void)
  {
   double currenciesStrength[CURRENCIES_COUNT];
   ArrayInitialize(currenciesStrength, 0);

// Getting currencies strength for all 8 currencies to the currenciesStrength buffer
   if(!fetchCurrenciesStrength(currenciesStrength))
     {
      return;
     }

// Searching for strong and weak currencies
   const int strongCurrencyIndex = findFirstStrongCurrency(currenciesStrength);
   const int weakCurrencyIndex = findFirstWeakCurrency(currenciesStrength);

   if(strongCurrencyIndex < 0 || weakCurrencyIndex < 0)
     {
      // There is no strong or weak currency (do nothing)
      return;
     }

// Building symbol for trading
   string symbol;
   const string strongCurrencyName = g_symbols[strongCurrencyIndex];
   const string weakCurrencyName = g_symbols[weakCurrencyIndex];
   if(!buildSymbolName(strongCurrencyName, weakCurrencyName, "", symbol))
     {
      Print("Failed to build symbol name)");
      return;
     }

// Determining direction of the trade long or short
   const bool isLongTrade = (StringSubstr(symbol, 0, StringLen(strongCurrencyName)) == strongCurrencyName);

   if(isLongTrade)
     {
      Print(StringFormat(
         "Placing long order for symbol = %s and strength = %.2f/%.2f", 
         symbol, 
         currenciesStrength[strongCurrencyIndex], 
         currenciesStrength[weakCurrencyIndex]));
     }
   else
     {
      Print(StringFormat(
         "Placing short order for symbol = %s and strength = %.2f/%.2f", 
         symbol, 
         currenciesStrength[weakCurrencyIndex], 
         currenciesStrength[strongCurrencyIndex]));
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool fetchCurrenciesStrength(double& currenciesStrength[])
  {
   for(int index = 0; index < CURRENCIES_COUNT; ++index)
     {
      double strength[1] = { EMPTY_VALUE };
      // Copying currency strength data from CMS indicator to strength buffer
      if(CopyBuffer(g_handle, index, 0, 1, strength) != 1)
        {
         Print("CopyBuffer from CSM failed, no data");
         return false;
        }

      if(MathAbs(strength[0] - EMPTY_VALUE) < 0.0001)
        {
         Print("Currency strength is not ready yet (downloading historical data..)");
         return false;
        }

      currenciesStrength[index] = strength[0];
     }

   return true;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool buildSymbolName(string firstInstrumentName, string secondInstrumentName, string suffix, string& symbolName)
  {
   string outTmp;
   symbolName = firstInstrumentName + secondInstrumentName + suffix;
   if(!SymbolInfoString(symbolName, SYMBOL_CURRENCY_BASE, outTmp))
     {
      symbolName = secondInstrumentName + firstInstrumentName + suffix;
      if(!SymbolInfoString(symbolName, SYMBOL_CURRENCY_BASE, outTmp))
        {
         return false;
        }
     }

   return true;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int findFirstStrongCurrency(double& currenciesStrength[])
  {
   for(int index = 0; index < ArraySize(currenciesStrength); ++index)
     {
      if(currenciesStrength[index] >= 60)
        {
         return index;
        }
     }

   return -1;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int findFirstWeakCurrency(double& currenciesStrength[])
  {

   for(int index = 0; index < ArraySize(currenciesStrength); ++index)
     {
      if(currenciesStrength[index] <= 40)
        {
         return index;
        }
     }

   return -1;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
  }
//+------------------------------------------------------------------+
