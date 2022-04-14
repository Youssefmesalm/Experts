//+------------------------------------------------------------------+
//|                                   Copyright 2022, Yousuf Mesalm. |
//|                                    https://www.Yousuf-mesalm.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Yousuf Mesalm."
#property link      "https://www.Yousuf-mesalm.com"
#property link      "https://www.mql5.com/en/users/20163440"
#property description      "Developed by Yousuf Mesalm"
#property description      "https://www.Yousuf-mesalm.com"
#property description      "https://www.mql5.com/en/users/20163440"
#property version   "1.00"
#include<Trade\Trade.mqh>
CTrade trade;

CPositionInfo m_position;
COrderInfo m_order;
CHistoryOrderInfo;

int AccountNumber=0;
datetime Expiry_Date        = D'2023.01.18 21:00';
input  ENUM_TIMEFRAMES  TF = PERIOD_CURRENT;

enum enPrices
  {
   pr_close,      // Close
   pr_open,       // Open
   pr_high,       // High
   pr_low,        // Low
   pr_median,     // Median
   pr_typical,    // Typical
   pr_weighted,   // Weighted
   pr_average,    // Average (high+low+open+close)/4
   pr_medianb,    // Average median body (open+close)/2
   pr_tbiased,    // Trend biased price
   pr_tbiased2,   // Trend biased (extreme) price
   pr_haclose,    // Heiken ashi close
   pr_haopen,     // Heiken ashi open
   pr_hahigh,     // Heiken ashi high
   pr_halow,      // Heiken ashi low
   pr_hamedian,   // Heiken ashi median
   pr_hatypical,  // Heiken ashi typical
   pr_haweighted, // Heiken ashi weighted
   pr_haaverage,  // Heiken ashi average
   pr_hamedianb,  // Heiken ashi median body
   pr_hatbiased,  // Heiken ashi trend biased price
   pr_hatbiased2  // Heiken ashi trend biased (extreme) price
  };
enum enMaTypes
  {
   ma_sma,    // Simple moving average
   ma_ema,    // Exponential moving average
   ma_smma,   // Smoothed MA
   ma_lwma,   // Linear weighted MA
   ma_adxvma  // AdxVma
  };
enum DISPLAY_SIGNALS_MODE // Type of constant
  {
   OnlyStops= 0,          // Only Stops
   SignalsStops,          // Signals & Stops
   OnlySignals            // Only Signals
  };
bool AllowArrowS = true;
input bool            Manual_Trad   = false;
input bool            BuyOnly   = true;
input bool            SellOnly   = true;
input bool            Use_first_Pending      = true;
input double Pending_Pip=1500;//first pending pip
input bool            Use_Second_Pending      = true;
input double Pending_Pip2=2000;//Second pending pip
input bool            DeletP1   = true;//pending First deletion
input bool            DeletP2   = true;//pending Second deletion
input double   NivDelet1 = 1;//Minimum Pip to delet First Pending
input double   NivDelet2 = 1;//Minimum Pip to delet Second Pending
input double   Break1 = 200;//Minimum Pip In Profit to Close First Pending At 0
input double   Break2 = 200;//Minimum Pip In Profit to Close Second Pending At 0
input bool            Use_BreakEvenM       = false;//BreakEven for Market Order
input double   StartBreakEvenAtM = 7;//pip to start breakeven for Market order
input bool            Use_BreakEvenP       = false;//BreakEven for Pending Order
input double   StartBreakEvenAtP = 7;//pip to start breakeven for Pending order
input bool            Use_Close_WhenBE_P1     = true; //Close Pending when BreakEven for Pending 1
input int             BreakEven_To_Close_P1=  0;   // Breakeven RePending after xPips (pending 1)
input bool            Use_Close_WhenBE_P2     = true; //Close Pending when BreakEven for Pending 2
input int             BreakEven_To_Close_P2=  0;   // Breakeven RePending after xPips (pending 2)
input int             xpip_Positive         =3;   //xpip in Positive

input double   TakeProfit = 1000;
input double   TakeProfit1 = 500;//Take Profit for first Pending
input double   TakeProfit2 = 500;//Take Profit for Second Pending
input double   StopLoss = 2000;
input double   StopLoss1 = 2500;//StopLoss for first Pending
input double   StopLoss2 = 2500;//StopLoss for Second Pending
input double Lots   = 0.3;
input double Lots_Pending   = 1.8;//First Pending Lots
input double Lots_Pending2   = 10;//Second Pending Lots
input string s2="########## INDI SETTING ##########";
input ENUM_TIMEFRAMES  TF_Indi = PERIOD_CURRENT;
input bool AllowNotifs= true;
input bool AllowMails = true;
input bool AllowAlerts = true;
input bool AllowArrows = true;
input bool BUYSELLs = false;//Option BUY,SELL,BUY,SELL
input bool Use_MACDs = false;
input bool Use_ADXTRENDs = true;
input bool Use_AROONs = false;
input bool Use_BBANDSs = true;
input bool Use_VERVOORTs = false;
input bool Use_HeikenAshis = false;
input string s2s="-MACD SETTING-";
input int Fast_ema_MAs=12;
input int Slow_ema_MAs=26;
input int Signal_Periods=9;
input  ENUM_APPLIED_PRICE MACD_Applys = PRICE_CLOSE;
input string s12s="--ADX TREND SETTING--";
input ENUM_TIMEFRAMES  ADX_TFs = PERIOD_CURRENT;
input double ADX_Periods=10;
input enPrices        ADX_Prices       = pr_close;
input enMaTypes        ADX_SmoothMethods       = ma_adxvma;
input int             ADX_SmoothPeriods      = 5;
input bool            ADX_AlertsOns          = false;          // Turn alerts on?
input bool            ADX_AlertsOnCurrents   = true;           // Alert on current bar?
input bool            ADX_AlertsMessages     = true;           // Display messageas on alerts?
input bool            ADX_AlertsSounds       = false;          // Play sound on alerts?
input bool            ADX_AlertsEmails       = false;          // Send email on alerts?
input bool            ADX_AlertsNotifys      = false;          // Send push notification on alerts?
input bool            ADX_Interpolates      = true;           // Interpolate in multi time frame mode?
input string s912s="-------AROON PARAMETRE----------";
input int             Aroon_Periods      = 9;
input int             Aroon_Shifts      = 0;
input string s28s="-------BBANDS PARAMETRE----------";
input int             Bband_Periods      = 20;
input double             Bband_Deviations      = 2;
input double             Bband_Factors      = 1;
input bool            Bband_Lines       = true;
input DISPLAY_SIGNALS_MODE Bband_Signals=SignalsStops; // Display signals mode
input string s8s="-------VERVOORT PARAMETRE----------";
input double   Vervoort_Period1s = 55;           // Fast tema period
input enPrices Vervoort_Price1s  = pr_typical;   // Fast tema price
input double   Vervoort_Period2s= 55;           // Slow tema period
input enPrices Vervoort_Price2s  = pr_haaverage; // Slow tema price
input int NbBars=10000;//Number of bar for Look Back
input double Ecarts=1;
double Ecart=1;
int OldT1,Y,Y1;
double INDI1[],INDI2[],OP;
int INDI_handle;
double B2=0.0;
double A2=0.0;
bool Again = true;
bool BreakAgainM = true;
bool BreakAgainP = true;
bool NewSell = false;
bool NewBuy = false;
bool NewSell2 = false;
bool NewBuy2 = false;
static int BARS;
double pips,p,Dinero,Dineros,OPb,OPs,TPb,TPs,SLs,SLb,Lob,Los,OPb2,OPs2,TPb2,TPs2,SLs2,SLb2,Lob2,Los2;
double BEOPb,BEOPs,BEtpb,BEslb,BEsls,BEtps;
double BEOPb2,BEOPs2,BEtpb2,BEslb2,BEsls2,BEtps2;

bool SellReady2=false;
bool BuyReady2=false;
bool SellReady=false;
bool BuyReady=false;
bool Start=false;
bool NewSecPendBuy=false;
bool NewSecPendSell=false;
input int    MagicNumber      = 1234454;
datetime Ref_day        = D'2022.02.27 21:00';
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

   if(TimeCurrent() > Expiry_Date && Expiry_Date!=D'0000.00.00 00:00')
     {
      Alert("Please contact Zaria@yahoo.com");
      ExpertRemove();
     }

   if(AccountInfoInteger(ACCOUNT_LOGIN)!= AccountNumber && AccountNumber!=0)
     {
      Alert("Please contact Zaria@yahoo.com");
      ExpertRemove();
     }


   Dinero= AccountInfoDouble(ACCOUNT_BALANCE);
   Dineros= AccountInfoDouble(ACCOUNT_BALANCE);
   if(Digits() == 3 || Digits() == 5)
     {
      pips = 10*Point();
      p = 10;
     }
   else
     {
      pips = Point();
      p = 1;
     }

   INDI_handle=iCustom(NULL,TF,"Indi_Zaria_vf1",TF_Indi,AllowNotifs,AllowMails,AllowAlerts,AllowArrows,BUYSELLs,Use_MACDs,Use_ADXTRENDs,Use_AROONs,Use_BBANDSs,Use_VERVOORTs,Use_HeikenAshis,s2s,Fast_ema_MAs,Slow_ema_MAs,Signal_Periods,MACD_Applys,s12s,ADX_TFs,ADX_Periods,ADX_Prices,ADX_SmoothMethods,ADX_SmoothPeriods,ADX_AlertsOns,ADX_AlertsOnCurrents,ADX_AlertsMessages,ADX_AlertsSounds,ADX_AlertsEmails,ADX_AlertsNotifys,ADX_Interpolates,s912s,Aroon_Periods,Aroon_Shifts,s28s,Bband_Periods,Bband_Deviations,Bband_Factors,Bband_Lines,Bband_Signals,s8s,Vervoort_Period1s,Vervoort_Price1s,Vervoort_Period2s,Vervoort_Price2s,Ecarts);

   if(INDI_handle<0)
     {
      Print("The creation of Indi_Zaria_vf1 fail INDI_handle=",INVALID_HANDLE);
      Print("Runtime error=",GetLastError());
      return(-1);
     }


   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   IsObjectExist();
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//Alert(MathAbs(iClose(NULL,PERIOD_CURRENT,1)-iOpen(NULL,PERIOD_CURRENT,1))/pips);
   MqlDateTime STime;
   CopyBuffer(INDI_handle,0,0,1000,INDI1);
   CopyBuffer(INDI_handle,1,0,1000,INDI2);
   ArraySetAsSeries(INDI1,true);
   ArraySetAsSeries(INDI2,true);

   if(AccountInfoDouble(ACCOUNT_BALANCE)<=Dineros)
      Dineros=AccountInfoDouble(ACCOUNT_BALANCE);
   if(AccountInfoDouble(ACCOUNT_BALANCE)>Dineros)
     {
      //Alert("FFFFFF");
      ClosAll();
      // DeletAll();
      NewSecPendBuy=false;
      NewSecPendSell=false;

      A2=0.0;
      B2=0.0;
      Dineros=AccountInfoDouble(ACCOUNT_BALANCE);
     }
   if(Manual_Trad==false)
     {
      if(!PositionExist(MagicNumber))
        {
         NewBuy=false;
         NewSell=false;
         NewBuy2=false;
         NewSell2=false;
         BuyReady=false;
         SellReady=false;
         BuyReady2=false;
         SellReady2=false;
         BEOPb2=0.0;
         BEOPs2=0.0;
         BEtpb=0;
         BEtpb2=0;
         BEtps2=0;
         BEtps=0;
         BEsls2=0;
         BEslb2=0;
         BEsls=0;
         BEslb=0;
         OPb=0.0;
         OPb2=0.0;
         OPs=0.0;
         OPs2=0.0;
         BEOPb=0.0;
         BEOPs=0.0;
        }
     }
   if(IsNewBar())
     {
      Again=true;
     }
   if(Manual_Trad==false)
     {
      if(!PositionExist(MagicNumber) && !OrderExist(MagicNumber) && INDI1[1]!=0 && Again==true)
        {
         Y=CountPosition(MagicNumber);
         if(BuyOnly==true)
            OpenBuy(MagicNumber,Lots);
         if(SellOnly==true && Use_first_Pending==true)
           {
            Y1=CountPosition(MagicNumber);
            OpenSellStop(MagicNumber,Lots_Pending,0);
            NewSell=false;
            NewBuy=false;
            BuyReady=false;
            SellReady=false;
            BuyReady2=false;
            SellReady2=false;

            if(Y1!=CountPosition(MagicNumber))
              {
               if(BuyOnly==true && Use_Second_Pending==true)
                 {
                  NewSecPendBuy=true;
                  B2=SymbolInfoDouble(NULL,SYMBOL_ASK)-Pending_Pip*pips;
                 }
               Y1=CountPosition(MagicNumber);
              }
           }
         if(Y!=CountPosition(MagicNumber))
           {
            BreakAgainM = true;
            BreakAgainP = true;
            if(AllowArrowS==true)
               AffichageB("Buy"+iHigh(NULL,TF,1),iTime(NULL,TF,1),iHigh(NULL,TF,1)+Ecart*pips,clrBlue);
            Y=CountPosition(MagicNumber);
           }
         Again=false;
        }
      if(!PositionExist(MagicNumber) && !OrderExist(MagicNumber) && INDI2[1]!=0 && Again==true)
        {
         Y=CountPosition(MagicNumber);
         if(SellOnly==true)
            OpenSell(MagicNumber,Lots);
         NewSell=false;
         NewBuy=false;
         BuyReady=false;
         SellReady=false;
         BuyReady2=false;
         SellReady2=false;

         if(BuyOnly==true && Use_first_Pending==true)
           {
            Y1=CountPosition(MagicNumber);
            OpenBuyStop(MagicNumber,Lots_Pending,0);
            if(Y1!=CountPosition(MagicNumber))
              {
               if(SellOnly==true && Use_Second_Pending==true)
                 {
                  A2=SymbolInfoDouble(NULL,SYMBOL_BID)+Pending_Pip*pips;
                  NewSecPendSell=true;
                 }
               Y1=CountPosition(MagicNumber);
              }
           }
         if(Y!=CountPosition(MagicNumber))
           {
            BreakAgainM = true;
            BreakAgainP = true;
            if(AllowArrowS==true)
               AffichageS("Sell"+iLow(NULL,TF,1),iTime(NULL,TF,1),iLow(NULL,TF,1)-Ecart*pips,clrRed);
            Y=CountPosition(MagicNumber);
           }
         Again=false;
        }
     }
   Closerder();
   SetOrder();
   Closerder2();
   SetOrder2();
   Manual();
   BreakEvenP();
   BreakEvenM();
   BreakEvenM_ManualTrad();
   SecondPending();
   DeletPending();

  }
//+------------------------------------------------------------------+
//|                h                                                 |
//+------------------------------------------------------------------+
void Manual()
  {
   double A=0.0;
   double B=0.0;
   if(Manual_Trad==true)
     {
      for(int i=PositionsTotal()-1; i>=0; i--)
        {
         ulong PositionTicket = PositionGetTicket(i);

         if(PositionGetString(POSITION_SYMBOL) == Symbol() && PositionGetInteger(POSITION_MAGIC) == 0 && PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
           {
            A=PositionGetDouble(POSITION_PRICE_OPEN);
            double Sl=A-StopLoss*pips;
            double Tp=A+TakeProfit*pips;
            if(!PositionExist(MagicNumber) && !OrderExist(MagicNumber))
              {
               trade.PositionModify(PositionTicket,Sl,Tp);
               NewSell=false;
               NewBuy=false;
               BuyReady=false;
               SellReady=false;
               BuyReady2=false;
               SellReady2=false;
               BEOPb2=0.0;
               BEOPs2=0.0;
                    BEtpb=0;
         BEtpb2=0;
         BEtps2=0;
         BEtps=0;
         BEsls2=0;
         BEslb2=0;
         BEsls=0;
         BEslb=0;
               OPb=0.0;
               OPb2=0.0;
               OPs=0.0;
               OPs2=0.0;
               BEOPb=0.0;
               BEOPs=0.0;
               if(SellOnly==true && Use_first_Pending==true)
                 {
                  Y=CountPosition(MagicNumber);
                  OpenSellStopStop1(MagicNumber,Lots_Pending,A-Pending_Pip*pips,TakeProfit1,StopLoss1);
                  if(Y!=CountPosition(MagicNumber))
                    {
                     if(BuyOnly==true && Use_Second_Pending==true)
                       {
                        NewSecPendBuy=true;
                        B2=A-Pending_Pip*pips;
                       }
                     Y=CountPosition(MagicNumber);
                    }
                 }
               BreakAgainM = true;
               BreakAgainP = true;
              }
           }
         if(PositionGetString(POSITION_SYMBOL) == Symbol() && PositionGetInteger(POSITION_MAGIC) == 0 && PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
           {
            B=PositionGetDouble(POSITION_PRICE_OPEN);
            double Sls=B+StopLoss*pips;
            double Tps=B-TakeProfit*pips;
            if(!PositionExist(MagicNumber) && !OrderExist(MagicNumber))
              {
               trade.PositionModify(PositionTicket,Sls,Tps);
               NewSell=false;
               NewBuy=false;
               BuyReady=false;
               SellReady=false;
               BuyReady2=false;
               SellReady2=false;
               BEOPb2=0.0;
               BEOPs2=0.0;
                   BEtpb=0;
         BEtpb2=0;
         BEtps2=0;
         BEtps=0;
         BEsls2=0;
         BEslb2=0;
         BEsls=0;
         BEslb=0;
               OPb=0.0;
               OPb2=0.0;
               OPs=0.0;
               OPs2=0.0;
               BEOPb=0.0;
               BEOPs=0.0;
               if(BuyOnly==true && Use_first_Pending==true)
                 {
                  Y=CountPosition(MagicNumber);
                  OpenBuyStopStop1(MagicNumber,Lots_Pending,B+Pending_Pip*pips,TakeProfit1,StopLoss1);
                  if(Y!=CountPosition(MagicNumber))
                    {
                     if(SellOnly==true && Use_Second_Pending==true)
                       {
                        NewSecPendSell=true;
                        A2=B+Pending_Pip*pips;
                       }
                     Y=CountPosition(MagicNumber);
                    }
                 }
               BreakAgainM = true;
               BreakAgainP = true;
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SecondPending()
  {
   if(NewSecPendSell==true && Use_Second_Pending==true && SellOnly==true)
     {
      if(SymbolInfoDouble(NULL,SYMBOL_ASK)>=A2 && PositionExistP1(MagicNumber) && A2!=0)
        {
         Y=CountPosition(MagicNumber);
         OpenSellStopStop(MagicNumber,Lots_Pending2,A2-Pending_Pip2*pips,TakeProfit2,StopLoss2);
         if(Y!=CountPosition(MagicNumber))
           {
            OP=A2;
            NewSecPendBuy=false;
            NewSecPendSell=false;
            // Alert("OP"+OP);
            A2=0.0;
            B2=0.0;
           }
        }
     }
   if(NewSecPendBuy==true && Use_Second_Pending==true && BuyOnly==true)
     {
      if(SymbolInfoDouble(NULL,SYMBOL_BID)<=B2 && PositionExistP1(MagicNumber) && B2!=0)
        {
         Y=CountPosition(MagicNumber);
         OpenBuyStopStop(MagicNumber,Lots_Pending2,B2+Pending_Pip2*pips,TakeProfit2,StopLoss2);
         if(Y!=CountPosition(MagicNumber))
           {
            NewSecPendSell=false;
            NewSecPendBuy=false;
            A2=0.0;
            B2=0.0;
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Closerder()
  {
   if(DeletP1==true)
     {
      for(int i=PositionsTotal()-1; i>=0; i--)
        {
         ulong PositionTicket = PositionGetTicket(i);

         if(PositionGetString(POSITION_SYMBOL) == Symbol() && PositionGetInteger(POSITION_MAGIC) == MagicNumber && PositionGetString(POSITION_COMMENT) == "KEENE")
           {
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY && (PositionGetDouble(POSITION_PRICE_OPEN)-SymbolInfoDouble(_Symbol,SYMBOL_ASK))>=NivDelet1*pips)
              {
               OPb=PositionGetDouble(POSITION_PRICE_OPEN);
               TPb=PositionGetDouble(POSITION_TP);
               SLb=PositionGetDouble(POSITION_SL);
               Lob=PositionGetDouble(POSITION_VOLUME);
               Y=CountPosition(MagicNumber);
               trade.PositionClose(PositionTicket);

               NewBuy=true;
               // OpenBuyStopStop1(MagicNumber,Lo,OP,Tp,Sl);
               Y=CountPosition(MagicNumber);

              }
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL && (SymbolInfoDouble(_Symbol,SYMBOL_BID)-PositionGetDouble(POSITION_PRICE_OPEN))>=NivDelet1*pips)
              {
               OPs=PositionGetDouble(POSITION_PRICE_OPEN);
               TPs=PositionGetDouble(POSITION_TP);
               SLs=PositionGetDouble(POSITION_SL);
               Los=PositionGetDouble(POSITION_VOLUME);
               Y=CountPosition(MagicNumber);
               trade.PositionClose(PositionTicket);

               //OpenSellStopStop1(MagicNumber,Lo2,OP2,Tp2,Sl2);
               NewSell=true;
               Y=CountPosition(MagicNumber);

              }
           }
        }
     }
   if(Use_Close_WhenBE_P1)
     {
      if(BuyReady&&CountPositionwithcomment(MagicNumber,"KEENE")==0)
        {

         NewBuy=true;
         BuyReady=false;
         Y=CountPosition(MagicNumber);

        }
      if(SellReady&&CountPositionwithcomment(MagicNumber,"KEENE")==0)
        {

         NewSell=true;
         SellReady=false;
         Y=CountPosition(MagicNumber);

        }
     }

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Closerder2()
  {
   if(DeletP2==true)
     {
      for(int i=PositionsTotal()-1; i>=0; i--)
        {
         ulong PositionTicket = PositionGetTicket(i);

         if(PositionGetString(POSITION_SYMBOL) == Symbol() && PositionGetInteger(POSITION_MAGIC) == MagicNumber && PositionGetString(POSITION_COMMENT) == "KEENE2")
           {
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY && (PositionGetDouble(POSITION_PRICE_OPEN)-SymbolInfoDouble(_Symbol,SYMBOL_ASK))>=NivDelet2*pips)
              {
               OPb2=PositionGetDouble(POSITION_PRICE_OPEN);
               TPb2=PositionGetDouble(POSITION_TP);
               SLb2=PositionGetDouble(POSITION_SL);
               Lob2=PositionGetDouble(POSITION_VOLUME);
               Y=CountPosition(MagicNumber);
               trade.PositionClose(PositionTicket);

               NewBuy2=true;
               // OpenBuyStopStop1(MagicNumber,Lo,OP,Tp,Sl);
               Y=CountPosition(MagicNumber);

              }
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL && (SymbolInfoDouble(_Symbol,SYMBOL_BID)-PositionGetDouble(POSITION_PRICE_OPEN))>=NivDelet2*pips)
              {
               OPs2=PositionGetDouble(POSITION_PRICE_OPEN);
               TPs2=PositionGetDouble(POSITION_TP);
               SLs2=PositionGetDouble(POSITION_SL);
               Los2=PositionGetDouble(POSITION_VOLUME);
               Y=CountPosition(MagicNumber);
               trade.PositionClose(PositionTicket);

               //OpenSellStopStop1(MagicNumber,Lo2,OP2,Tp2,Sl2);
               NewSell2=true;
               Y=CountPosition(MagicNumber);

              }
           }
        }
     }
   if(Use_Close_WhenBE_P2)
     {
      if(BuyReady2&&CountPositionwithcomment(MagicNumber,"KEENE2")==0)
        {

         NewBuy2=true;
         BuyReady2=false;
         Y=CountPosition(MagicNumber);

        }
      if(SellReady2&&CountPositionwithcomment(MagicNumber,"KEENE2")==0)
        {

         NewSell2=true;
         SellReady2=false;
         Y=CountPosition(MagicNumber);

        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SetOrder()
  {
   if(DeletP1==true)
     {
      if(NewBuy==true)
        {
         if(SymbolInfoDouble(_Symbol,SYMBOL_ASK)>=OPb && OPb!=0.0)
           {
            Y=CountPosition(MagicNumber);
            OpenBuy1(MagicNumber,Lob,TPb,SLb,"KEENE");

            NewBuy=false;
            Y=CountPosition(MagicNumber);

           }
        }
      if(NewSell==true)
        {
         if(SymbolInfoDouble(_Symbol,SYMBOL_BID)<=OPs && OPs!=0.0)
           {
            Y=CountPosition(MagicNumber);
            OpenSell1(MagicNumber,Los,TPs,SLs,"KEENE");

            NewSell=false;
            Y=CountPosition(MagicNumber);

           }
        }
     }
   if(Use_Close_WhenBE_P1)
     {
      if(NewBuy)
        {
         if(SymbolInfoDouble(_Symbol,SYMBOL_ASK)<=BEOPb+xpip_Positive*pips-BreakEven_To_Close_P1*pips && BEOPb!=0.0)
           {
            Y=CountPosition(MagicNumber);
            int x=CountPosition1(MagicNumber);

            double p=SymbolInfoDouble(_Symbol,SYMBOL_ASK);
            if(p>=BEOPb)
              {
               OpenBuy1(MagicNumber,Lots_Pending,BEtpb,BEslb,"KEENE");
              }
            else
               OpenBuyStop(MagicNumber,Lots_Pending,BEOPb);
            if(x!=CountPosition1(MagicNumber))
              {
               BreakAgainM = true;
               BreakAgainP = true;
              }
            if(Y1!=CountPosition(MagicNumber)||x!=CountPosition1(MagicNumber))
              {
               NewBuy=false;
               BEOPb=0;
               BreakAgainP=true;
               Y=CountPosition(MagicNumber);
              }
           }
        }
      if(NewSell)
        {
         if(SymbolInfoDouble(_Symbol,SYMBOL_BID)>=BEOPs-xpip_Positive*pips+BreakEven_To_Close_P1*pips && BEOPs!=0.0)
           {
            int x=CountPosition1(MagicNumber);
            Y=CountPosition(MagicNumber);
            double p=SymbolInfoDouble(_Symbol,SYMBOL_BID);
            if(SymbolInfoDouble(_Symbol,SYMBOL_BID)<=BEOPs)
              {
               OpenSell1(MagicNumber,Lots_Pending,BEtps,BEsls,"KEENE");
              }
            else
               OpenSellStop(MagicNumber,Lots_Pending,BEOPs);
            if(x!=CountPosition1(MagicNumber))
              {
               BreakAgainM = true;
               BreakAgainP = true;
              }
            if(Y1!=CountPosition(MagicNumber)||x!=CountPosition1(MagicNumber))
              {

               BEOPs=0.0;
               NewSell=false;
               BreakAgainP=true;
               Y=CountPosition(MagicNumber);
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SetOrder2()
  {
   if(DeletP2==true)
     {
      if(NewBuy2==true)
        {
         if(SymbolInfoDouble(_Symbol,SYMBOL_ASK)>=OPb2 && OPb2!=0.0)
           {
            Y=CountPosition(MagicNumber);

            OpenBuy1(MagicNumber,Lob2,TPb2,SLb2,"KEENE2");

            NewBuy2=false;
            Y=CountPosition(MagicNumber);

           }
        }
      if(NewSell2==true)
        {
         if(SymbolInfoDouble(_Symbol,SYMBOL_BID)<=OPs2 && OPs2!=0.0)
           {
            Y=CountPosition(MagicNumber);
            OpenSell1(MagicNumber,Los2,TPs2,SLs2,"KEENE2");

            NewSell2=false;
            Y=CountPosition(MagicNumber);

           }
        }
     }
   if(Use_Close_WhenBE_P2)
     {
      if(NewBuy2)
        {
         if(SymbolInfoDouble(_Symbol,SYMBOL_ASK)<=BEOPb2+xpip_Positive*pips-BreakEven_To_Close_P2*pips && BEOPb2!=0.0)
           {
            Y=CountPosition(MagicNumber);
            int x=CountPosition1(MagicNumber);

            double p=SymbolInfoDouble(_Symbol,SYMBOL_ASK);
            if(p>=BEOPb2)
               OpenBuy1(MagicNumber,Lots_Pending,BEtpb2,BEslb2,"KEENE2");
            else
               OpenBuyStopStop(MagicNumber,Lots_Pending2,p,TakeProfit2,StopLoss2);

            if(x!=CountPosition1(MagicNumber))
              {
               BreakAgainM = true;
               BreakAgainP = true;
              }
            if(Y1!=CountPosition(MagicNumber))
              {
               NewBuy2=false;
               BEOPb2=0;
               BreakAgainP=true;
               Y=CountPosition(MagicNumber);
              }
           }
        }
      if(NewSell2)
        {
         if(SymbolInfoDouble(_Symbol,SYMBOL_BID)>=BEOPs2-xpip_Positive*pips+BreakEven_To_Close_P2*pips && BEOPs2!=0.0)
           {
            int x=CountPosition1(MagicNumber);

            Y=CountPosition(MagicNumber);
            double p=SymbolInfoDouble(_Symbol,SYMBOL_BID);
            if(SymbolInfoDouble(_Symbol,SYMBOL_BID)<=BEOPs2)
               OpenSell1(MagicNumber,Lots_Pending,BEsls2,BEtps2,"KEENE2");
            else
               OpenSellStopStop(MagicNumber,Lots_Pending2,p,TakeProfit2,StopLoss2);
            if(x!=CountPosition1(MagicNumber))
              {
               BreakAgainM = true;
               BreakAgainP = true;
              }
            if(Y1!=CountPosition(MagicNumber))
              {

               BEOPs2=0.0;
               NewSell2=false;
               BreakAgainP=true;
               Y=CountPosition(MagicNumber);
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DeletPending()
  {
//---
   static ulong recdd=0,tmprecdd=0,ticket,record=0,tmprecord=0,tmprecord2=0;
   int i,j,ih,hstTotal,cnt;
   ENUM_ORDER_TYPE Type;
   int M_N;
   uint total;
   double prof;
   string Symb;
   MqlDateTime str1,str2;
   static double profit=0,stoplose=0;
   static double nowkj;
   datetime date1,date2;
   MqlTradeRequest request;
   MqlTradeResult result;
   CTrade  trade;
   COrderInfo  order;
   CPositionInfo position;
   bool success;
   HistorySelect(0,TimeCurrent());
   hstTotal=HistoryOrdersTotal();  //get history orders
   total = PositionsTotal();       //get pengding order
   if(hstTotal>0&&total==0)
     {

      for(ih=hstTotal-1; ih<hstTotal; ih++)
        {
         tmprecord=HistoryOrderGetTicket(ih);

         if(record!=tmprecord)
           {
            record=tmprecord;
            prof=HistoryDealGetDouble(record,DEAL_PROFIT);
            Type=HistoryOrderGetInteger(record,ORDER_TYPE);
            M_N=HistoryOrderGetInteger(record,ORDER_MAGIC);
            Symb=HistoryOrderGetString(record,ORDER_SYMBOL);
            if(OldT1!=record &&  prof>=0  && (M_N==MagicNumber||M_N==0) && Symb==_Symbol)
              {
               DeletAll();
               ClosAll();
               //Alert("AALLo");
               NewSecPendBuy=false;
               NewSecPendSell=false;
               A2=0.0;
               B2=0.0;
               OldT1=record;
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int DayOfWeeks()
  {
   MqlDateTime tm;
   TimeCurrent(tm);
   return(tm.day_of_week);
  }
//+------------------------------------------------------------------+
//| NewBar function                                                  |
//+------------------------------------------------------------------+
bool IsNewBar()
  {
   if(BARS!=Bars(_Symbol,TF))
     {
      BARS=Bars(_Symbol,TF);
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint OpenSellStop(int magic,double lot,double OPprice)
  {
//--- prépare la requête
   MqlTradeRequest req= {};
   req.action =TRADE_ACTION_PENDING;
   req.symbol =_Symbol;
   req.magic  = magic;
   req.volume = lot;
   req.type   = ORDER_TYPE_SELL_STOP;
   req.price  =OPprice!=0?OPprice: SymbolInfoDouble(req.symbol,SYMBOL_ASK)-Pending_Pip*pips;
   if(TakeProfit==0)
      req.tp = 0.0;
   if(TakeProfit!=0)
      req.tp = req.price-TakeProfit1*pips;
   if(StopLoss==0)
      req.sl     = 0.0;
   if(StopLoss!=0)
      req.sl     = req.price+StopLoss1*pips;
   req.comment ="KEENE";
   MqlTradeResult result= {0};
   if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_FOK))
      req.type_filling = ORDER_FILLING_FOK;
   else
      if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_IOC))
         req.type_filling = ORDER_FILLING_IOC;
   OrderSend(req,result);
//--- write the server reply to log
   Print(__FUNCTION__,":",result.comment);
   if(result.retcode==10016)
      Print(result.bid,result.ask,result.price);
//--- return code of the trade server reply
   return result.retcode;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint OpenSellStopStop(int magic,double lot,double Prix,double TP,double SL)
  {
//--- prépare la requête
   MqlTradeRequest req= {};
   req.action =TRADE_ACTION_PENDING;
   req.symbol =_Symbol;
   req.magic  = magic;
   req.volume = lot;
   req.type   = ORDER_TYPE_SELL_STOP;
   req.price  = Prix;
   if(TP==0)
      req.tp = 0.0;
   if(TP!=0)
      req.tp = req.price-TP*pips;
   if(SL==0)
      req.sl     = 0.0;
   if(SL!=0)
      req.sl     = req.price+SL*pips;
   req.comment ="KEENE2";
   MqlTradeResult result= {0};
   if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_FOK))
      req.type_filling = ORDER_FILLING_FOK;
   else
      if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_IOC))
         req.type_filling = ORDER_FILLING_IOC;
   OrderSend(req,result);
//--- write the server reply to log
   Print(__FUNCTION__,":",result.comment);
   if(result.retcode==10016)
      Print(result.bid,result.ask,result.price);
//--- return code of the trade server reply
   return result.retcode;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint OpenSellStopStop1(int magic,double lot,double Prix,double TP,double SL)
  {
//--- prépare la requête
   MqlTradeRequest req= {};
   req.action =TRADE_ACTION_PENDING;
   req.symbol =_Symbol;
   req.magic  = magic;
   req.volume = lot;
   req.type   = ORDER_TYPE_SELL_STOP;
   req.price  = Prix;
   if(TP==0)
      req.tp = 0.0;
   if(TP!=0)
      req.tp = req.price-TP*pips;
   if(SL==0)
      req.sl     = 0.0;
   if(SL!=0)
      req.sl     = req.price+SL*pips;
   req.comment ="KEENE";
   MqlTradeResult result= {0};
   if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_FOK))
      req.type_filling = ORDER_FILLING_FOK;
   else
      if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_IOC))
         req.type_filling = ORDER_FILLING_IOC;
   OrderSend(req,result);
//--- write the server reply to log
   Print(__FUNCTION__,":",result.comment);
   if(result.retcode==10016)
      Print(result.bid,result.ask,result.price);
//--- return code of the trade server reply
   return result.retcode;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint OpenSell1(int magic,double lot,double TP,double SL,string t)
  {
//--- prépare la requête
   MqlTradeRequest req= {};
   req.action =TRADE_ACTION_DEAL;
   req.symbol =_Symbol;
   req.magic  = magic;
   req.volume = lot;
   req.type   = ORDER_TYPE_SELL;
   req.price  = SymbolInfoDouble(req.symbol,SYMBOL_BID);
   if(TP==0)
      req.tp = 0.0;
   if(TP!=0)
      req.tp = TP;
   if(SL==0)
      req.sl     = 0.0;
   if(SL!=0)
      req.sl     = SL;
   req.comment =t;
   MqlTradeResult result= {0};
   if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_FOK))
      req.type_filling = ORDER_FILLING_FOK;
   else
      if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_IOC))
         req.type_filling = ORDER_FILLING_IOC;
   OrderSend(req,result);
//--- write the server reply to log
   Print(__FUNCTION__,":",result.comment);
   if(result.retcode==10016)
      Print(result.bid,result.ask,result.price);
//--- return code of the trade server reply
   return result.retcode;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint OpenSell(int magic,double lot)
  {
//--- prépare la requête
   MqlTradeRequest req= {};
   req.action =TRADE_ACTION_DEAL;
   req.symbol =_Symbol;
   req.magic  = magic;
   req.volume = lot;
   req.type   = ORDER_TYPE_SELL;
   req.price  = SymbolInfoDouble(req.symbol,SYMBOL_BID);
   if(TakeProfit==0)
      req.tp = 0.0;
   if(TakeProfit!=0)
      req.tp = req.price-TakeProfit*pips;
   if(StopLoss==0)
      req.sl     = 0.0;
   if(StopLoss!=0)
      req.sl     = req.price+StopLoss*pips;
   req.comment ="ZARIA";
   MqlTradeResult result= {0};
   if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_FOK))
      req.type_filling = ORDER_FILLING_FOK;
   else
      if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_IOC))
         req.type_filling = ORDER_FILLING_IOC;
   OrderSend(req,result);
//--- write the server reply to log
   Print(__FUNCTION__,":",result.comment);
   if(result.retcode==10016)
      Print(result.bid,result.ask,result.price);
//--- return code of the trade server reply
   return result.retcode;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint OpenBuy(int magic,double lot)
  {
//--- prépare la requête
   MqlTradeRequest req= {};
   req.action =TRADE_ACTION_DEAL;
   req.symbol =_Symbol;
   req.magic  = magic;
   req.volume = lot;
   req.type   = ORDER_TYPE_BUY;
   req.price  = SymbolInfoDouble(req.symbol,SYMBOL_ASK);
   if(TakeProfit==0)
      req.tp = 0.0;
   if(TakeProfit!=0)
      req.tp = req.price+TakeProfit*pips;
   if(StopLoss==0)
      req.sl     = 0.0;
   if(StopLoss!=0)
      req.sl     = req.price-StopLoss*pips;
   req.comment ="ZARIA";
   MqlTradeResult result= {0};
   if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_FOK))
      req.type_filling = ORDER_FILLING_FOK;
   else
      if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_IOC))
         req.type_filling = ORDER_FILLING_IOC;
   OrderSend(req,result);
//--- write the server reply to log
   Print(__FUNCTION__,":",result.comment);
   if(result.retcode==10016)
      Print(result.bid,result.ask,result.price);
//--- return code of the trade server reply
   return result.retcode;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint OpenBuyStop(int magic,double lot,double OPprice)
  {
//--- prépare la requête
   MqlTradeRequest req= {};
   req.action =TRADE_ACTION_PENDING;
   req.symbol =_Symbol;
   req.magic  = magic;
   req.volume = lot;
   req.type   = ORDER_TYPE_BUY_STOP;
   req.price  =OPprice!=0?OPprice:SymbolInfoDouble(req.symbol,SYMBOL_BID)+Pending_Pip*pips;
   if(TakeProfit==0)
      req.tp = 0.0;
   if(TakeProfit!=0)
      req.tp = req.price+TakeProfit1*pips;
   if(StopLoss==0)
      req.sl     = 0.0;
   if(StopLoss!=0)
      req.sl     = req.price-StopLoss1*pips;
   req.comment ="KEENE";
   MqlTradeResult result= {0};
   if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_FOK))
      req.type_filling = ORDER_FILLING_FOK;
   else
      if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_IOC))
         req.type_filling = ORDER_FILLING_IOC;
   OrderSend(req,result);
//--- write the server reply to log
   Print(__FUNCTION__,":",result.comment);
   if(result.retcode==10016)
      Print(result.bid,result.ask,result.price);
//--- return code of the trade server reply
   return result.retcode;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint OpenBuyStopStop(int magic,double lot,double Prix,double TP,double SL)
  {
//--- prépare la requête
   MqlTradeRequest req= {};
   req.action =TRADE_ACTION_PENDING;
   req.symbol =_Symbol;
   req.magic  = magic;
   req.volume = lot;
   req.type   = ORDER_TYPE_BUY_STOP;
   req.price  = Prix;
   if(TP==0)
      req.tp = 0.0;
   if(TP!=0)
      req.tp = req.price+TP*pips;
   if(SL==0)
      req.sl     = 0.0;
   if(SL!=0)
      req.sl     = req.price-SL*pips;
   req.comment ="KEENE2";
   MqlTradeResult result= {0};
   if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_FOK))
      req.type_filling = ORDER_FILLING_FOK;
   else
      if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_IOC))
         req.type_filling = ORDER_FILLING_IOC;
   OrderSend(req,result);
//--- write the server reply to log
   Print(__FUNCTION__,":",result.comment);
   if(result.retcode==10016)
      Print(result.bid,result.ask,result.price);
//--- return code of the trade server reply
   return result.retcode;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint OpenBuyStopStop1(int magic,double lot,double Prix,double TP,double SL)
  {
//--- prépare la requête
   MqlTradeRequest req= {};
   req.action =TRADE_ACTION_PENDING;
   req.symbol =_Symbol;
   req.magic  = magic;
   req.volume = lot;
   req.type   = ORDER_TYPE_BUY_STOP;
   req.price  = Prix;
   if(TP==0)
      req.tp = 0.0;
   if(TP!=0)
      req.tp = req.price+TP*pips;
   if(SL==0)
      req.sl     = 0.0;
   if(SL!=0)
      req.sl     = req.price-SL*pips;
   req.comment ="KEENE";
   MqlTradeResult result= {0};
   if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_FOK))
      req.type_filling = ORDER_FILLING_FOK;
   else
      if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_IOC))
         req.type_filling = ORDER_FILLING_IOC;
   OrderSend(req,result);
//--- write the server reply to log
   Print(__FUNCTION__,":",result.comment);
   if(result.retcode==10016)
      Print(result.bid,result.ask,result.price);
//--- return code of the trade server reply
   return result.retcode;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint OpenBuy1(int magic,double lot,double TP,double SL,string t)
  {
//--- prépare la requête
   MqlTradeRequest req= {};
   req.action =TRADE_ACTION_DEAL;
   req.symbol =_Symbol;
   req.magic  = magic;
   req.volume = lot;
   req.type   = ORDER_TYPE_BUY;
   req.price  = SymbolInfoDouble(req.symbol,SYMBOL_ASK);
   if(TP==0)
      req.tp = 0.0;
   if(TP!=0)
      req.tp = TP;
   if(SL==0)
      req.sl     = 0.0;
   if(SL!=0)
      req.sl     = SL;
   req.comment =t;
   MqlTradeResult result= {0};
   if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_FOK))
      req.type_filling = ORDER_FILLING_FOK;
   else
      if(IsFillingTypeAllowed(req.symbol,SYMBOL_FILLING_IOC))
         req.type_filling = ORDER_FILLING_IOC;
   OrderSend(req,result);
//--- write the server reply to log
   Print(__FUNCTION__,":",result.comment);
   if(result.retcode==10016)
      Print(result.bid,result.ask,result.price);
//--- return code of the trade server reply
   return result.retcode;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void BreakEvenM()
  {
   if(Use_BreakEvenM==true && BreakAgainM==true && Manual_Trad==false)
     {
      for(int i=PositionsTotal()-1; i>=0; i--)
        {
         ulong PositionTicket = PositionGetTicket(i);

         if(PositionGetString(POSITION_SYMBOL) == Symbol() && PositionGetInteger(POSITION_MAGIC) == MagicNumber && PositionGetString(POSITION_COMMENT) == "ZARIA")
           {
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY && (SymbolInfoDouble(_Symbol,SYMBOL_ASK)-PositionGetDouble(POSITION_PRICE_OPEN))>=StartBreakEvenAtM*pips)
              {
               double Sl=PositionGetDouble(POSITION_PRICE_OPEN);
               double Tp=PositionGetDouble(POSITION_TP);
               if(! trade.PositionModify(PositionTicket,Sl,Tp));
               Print("Error modifying the position",GetLastError());
               BreakAgainM=false;
              }
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL && (PositionGetDouble(POSITION_PRICE_OPEN)-SymbolInfoDouble(_Symbol,SYMBOL_BID))>=StartBreakEvenAtM*pips)
              {
               double Sl=PositionGetDouble(POSITION_PRICE_OPEN);
               double Tp=PositionGetDouble(POSITION_TP);
               if(!trade.PositionModify(PositionTicket,Sl,Tp));
               Print("Error modifying the position",GetLastError());
               BreakAgainM=false;
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void BreakEvenM_ManualTrad()
  {
   if(Use_BreakEvenM==true && BreakAgainM==true && Manual_Trad==true)
     {
      for(int i=PositionsTotal()-1; i>=0; i--)
        {
         ulong PositionTicket = PositionGetTicket(i);

         if(PositionGetString(POSITION_SYMBOL) == Symbol() && PositionGetInteger(POSITION_MAGIC) == 0)
           {
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY && (SymbolInfoDouble(_Symbol,SYMBOL_ASK)-PositionGetDouble(POSITION_PRICE_OPEN))>=StartBreakEvenAtM*pips)
              {
               double Sl=PositionGetDouble(POSITION_PRICE_OPEN);
               double Tp=PositionGetDouble(POSITION_TP);
               if(! trade.PositionModify(PositionTicket,Sl,Tp));
               Print("Error modifying the position",GetLastError());
               BreakAgainM=false;
              }
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL && (PositionGetDouble(POSITION_PRICE_OPEN)-SymbolInfoDouble(_Symbol,SYMBOL_BID))>=StartBreakEvenAtM*pips)
              {
               double Sl=PositionGetDouble(POSITION_PRICE_OPEN);
               double Tp=PositionGetDouble(POSITION_TP);
               if(!trade.PositionModify(PositionTicket,Sl,Tp));
               Print("Error modifying the position",GetLastError());
               BreakAgainM=false;
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void BreakEvenP()
  {
   if(Use_BreakEvenP==true && BreakAgainP==true)
     {
      for(int i=PositionsTotal()-1; i>=0; i--)
        {
         ulong PositionTicket = PositionGetTicket(i);

         if(PositionGetString(POSITION_SYMBOL) == Symbol() && PositionGetInteger(POSITION_MAGIC) == MagicNumber && (PositionGetString(POSITION_COMMENT) == "KEENE"||PositionGetString(POSITION_COMMENT) == "KEENE2"))
           {
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY && (SymbolInfoDouble(_Symbol,SYMBOL_ASK)-PositionGetDouble(POSITION_PRICE_OPEN))>=StartBreakEvenAtP*pips)
              {
               ResetLastError();
               double Sl=PositionGetDouble(POSITION_PRICE_OPEN);
               double Tp=PositionGetDouble(POSITION_TP);

               if(! trade.PositionModify(PositionTicket,Sl,Tp))
                 {
                  Print("Error modifying the position",GetLastError());
                  break;
                 }
               if(Use_Close_WhenBE_P1&&PositionGetString(POSITION_COMMENT) == "KEENE")
                 {
                  BEOPb=PositionGetDouble(POSITION_PRICE_OPEN);
                  BEslb=PositionGetDouble(POSITION_SL);
                  BEtpb=PositionGetDouble(POSITION_TP);
                  BreakAgainP=false;
                  BuyReady=true;
                 }
               if(Use_Close_WhenBE_P2&&PositionGetString(POSITION_COMMENT) == "KEENE2")
                 {
                  BEOPb2=PositionGetDouble(POSITION_PRICE_OPEN);
                  BEslb2=PositionGetDouble(POSITION_SL);
                  BEtpb2=PositionGetDouble(POSITION_TP);
                  BreakAgainP=false;
                  BuyReady2=true;
                 }
              }
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL && (PositionGetDouble(POSITION_PRICE_OPEN)-SymbolInfoDouble(_Symbol,SYMBOL_BID))>=StartBreakEvenAtP*pips)
              {
               ResetLastError();
               double Sl=PositionGetDouble(POSITION_PRICE_OPEN);
               double Tp=PositionGetDouble(POSITION_TP);

               if(!trade.PositionModify(PositionTicket,Sl,Tp))
                 {
                  Print("Error modifying the position",GetLastError());
                  break;
                 }
               if(Use_Close_WhenBE_P1&&PositionGetString(POSITION_COMMENT) == "KEENE")
                 {
                  BEOPs=PositionGetDouble(POSITION_PRICE_OPEN);
                  BEsls=PositionGetDouble(POSITION_SL);
                  BEtps=PositionGetDouble(POSITION_TP);
                  SellReady=true;
                  BreakAgainP=false;
                 }
               if(Use_Close_WhenBE_P2&&PositionGetString(POSITION_COMMENT) == "KEENE2")
                 {
                  BEOPs2=PositionGetDouble(POSITION_PRICE_OPEN);
                  BEsls2=PositionGetDouble(POSITION_SL);
                  BEtps2=PositionGetDouble(POSITION_TP);
                  SellReady2=true;
                  BreakAgainP=false;
                 }
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AffichageB(string nom,datetime temps,double niveau,color couleur)
  {
   ObjectDelete(0,nom);
   ObjectCreate(0,nom,OBJ_ARROW_UP,0,temps,niveau);
   ObjectSetInteger(0,nom,OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(0,nom,OBJPROP_COLOR,couleur);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AffichageS(string nom,datetime temps,double niveau,color couleur)
  {
   ObjectDelete(0,nom);
   ObjectCreate(0,nom,OBJ_ARROW_DOWN,0,temps,niveau);
   ObjectSetInteger(0,nom,OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(0,nom,OBJPROP_COLOR,couleur);
  }

//+------------------------------------------------------------------+
int GetTime(datetime date)
  {
   MqlDateTime tm;
   TimeToStruct(date,tm);
   return(tm.hour*60*60+tm.min*60+tm.sec);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ClosAll()
  {
   for(int i=PositionsTotal()-1; i>=0; i--)
     {
      ulong PositionTicket = PositionGetTicket(i);
      if(PositionGetString(POSITION_SYMBOL) == _Symbol && PositionGetInteger(POSITION_MAGIC) == MagicNumber)
        {

         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY || PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
           {
            trade.PositionClose(PositionTicket);
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ClosAllS()
  {
   for(int i=PositionsTotal()-1; i>=0; i--)
     {
      ulong PositionTicket = PositionGetTicket(i);
      if(PositionGetString(POSITION_SYMBOL) == _Symbol && PositionGetInteger(POSITION_MAGIC) == MagicNumber)
        {

         if((PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY || PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL) && (PositionGetDouble(POSITION_PRICE_OPEN)>=(OP+(Pending_Pip/10)*pips)||PositionGetDouble(POSITION_PRICE_OPEN)<=(OP-(Pending_Pip/10)*pips)))
           {
            // Alert("8888");
            trade.PositionClose(PositionTicket);
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DeletAll()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      ulong OrderTicket = OrderGetTicket(i);
      if(/*OrderGetString(ORDER_SYMBOL) == NULL &&*/ OrderGetInteger(ORDER_MAGIC) == MagicNumber)
        {
         if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY_STOP || OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_STOP)
           {
            trade.OrderDelete(OrderTicket);
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                            "KEENE"      |
//+------------------------------------------------------------------+
bool PositionExist(int magic)
  {
   for(int i=PositionsTotal()-1; i>=0; i--)
     {
      ulong PositionTicket = PositionGetTicket(i);
      if(PositionGetInteger(POSITION_MAGIC) == magic)
         return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool PositionExistP1(int magic)
  {
   for(int i=PositionsTotal()-1; i>=0; i--)
     {
      ulong PositionTicket = PositionGetTicket(i);
      if(PositionGetInteger(POSITION_MAGIC) == magic && PositionGetString(POSITION_COMMENT)=="KEENE")
         return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool OrderExist(int magic)
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      ulong OrderTicket = OrderGetTicket(i);
      if(OrderGetInteger(ORDER_MAGIC) == magic && (OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY_STOP || OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_STOP))
         return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void IsObjectExist()
  {
   for(int i=ObjectsTotal(0,-1,OBJ_ARROW); i>=0; i--)
     {
      string name = ObjectName(0,i,-1,OBJ_ARROW);
      ObjectDelete(0,name);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CountPosition(int magic)
  {
   double x=0;
   for(int i=0; i<OrdersTotal(); i++)
     {
      ulong Ticket = OrderGetTicket(i);
      if(OrderGetInteger(ORDER_MAGIC) == magic)
         x++;
     }
   return x;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CountPosition1(int magic)
  {
   double x=0;
   for(int i=0; i<PositionsTotal(); i++)
     {
      ulong Ticket = PositionGetTicket(i);
      if(PositionGetInteger(POSITION_MAGIC) == magic)
         x++;
     }
   return x;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CountPositionwithcomment(int magic,string cmnt)
  {
   double x=0;
   for(int i=PositionsTotal()-1; i>=0; i--)
     {
      ulong Ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(Ticket))
        {
         if(PositionGetInteger(POSITION_MAGIC) == magic&&PositionGetString(POSITION_COMMENT)==cmnt)
            x++;
        }
     }
   return x;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsFillingTypeAllowed(string symbol, int fill_type)
  {
   int filling = (int)SymbolInfoInteger(symbol,SYMBOL_FILLING_MODE);
   return ((filling & fill_type) == fill_type);
  }

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
