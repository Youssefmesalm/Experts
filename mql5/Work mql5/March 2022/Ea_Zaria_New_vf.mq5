//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+

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
#include  <YM\YM.mqh>
CTrade trade;

CPositionInfo m_position;
COrderInfo m_order;
CHistoryOrderInfo;
int AccountNumber=0;
datetime Expiry_Date        = D'2022.05.25 21:00';
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
input bool            DeletXpip   = true;//Xpip deletion
input double   NivDelet1 = 1;//Minimum Pip to delet First Pending
input double   NivDelet2 = 1;//Minimum Pip to delet Second Pending
input double   NivDeletx = 1;//Minimum Pip to delet Xpip
input double   Break1 = 200;//Minimum Pip In Profit to Close First Pending At 0
input double   Break2 = 200;//Minimum Pip In Profit to Close Second Pending At 0
input bool            Use_BreakEvenM       = false;//BreakEven for Market Order
input double   StartBreakEvenAtM = 7;//pip to start breakeven for Market order
input bool            Use_BreakEvenP       = false;//BreakEven for Pending Order
input double   StartBreakEvenAtP = 7;//pip to start breakeven for Pending order 1
input double   StartBreakEvenAtP2 = 7;//pip to start breakeven for Pending order 2
input double   StartBreakEvenAtxpip = 7;//pip to start breakeven for xpip order

input bool            Use_Close_WhenBE_P1     = true; //Close Pending when BreakEven for Pending 1
input int             BreakEven_To_Close_P1=  0;   // Breakeven RePending after xPips (pending 1)
input bool            Use_Close_WhenBE_P2     = true; //Close Pending when BreakEven for Pending 2
input int             BreakEven_To_Close_P2=  0;   // Breakeven RePending after xPips (pending 2)
input int             xpip_Positive         =3;   //xpip in Positive
bool input            Use_Trailing = true;
int input             TrailingStopPoint = 50; // Market order trailing Stop
int input             TrailingStepPoint = 85; // Market order trailing Step

input double   TakeProfit = 1000;
input double   TakeProfit1 = 500;//Take Profit for first Pending
input double   TakeProfit2 = 500;//Take Profit for Second Pending
input double   StopLoss = 2000;
input double   StopLoss1 = 2500;//StopLoss for first Pending
input double   StopLoss2 = 2500;//StopLoss for Second Pending
input double Lots   = 0.3;
input double Lots_Pending   = 1.8;//First Pending Lots
input double Lots_Pending2   = 10;//Second Pending Lots
input double Lots_Xpips   = 10;//Xpips Lots
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
double BEOPbP,BEOPsP,BEtpbP,BEslbP,BEslsP,BEtpsP;
double BEOPb2,BEOPs2,BEtpb2,BEslb2,BEsls2,BEtps2;
double BEOPb2P,BEOPs2P,BEtpb2P,BEslb2P,BEsls2P,BEtps2P;
bool SellReady2=false;
bool BuyReady2=false;
bool SellReady=false;
bool BuyReady=false;
bool Start=false;
bool NewSecPendBuy=false;
bool NewSecPendSell=false;
input int    MagicNumber      = 1234454;
datetime Ref_day        = D'2022.05.27 21:00';

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CExecute *execute=new CExecute(Symbol(), MagicNumber);

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CPosition *Pos=new CPosition(Symbol(), MagicNumber, GROUP_POSITIONS_ALL);
COrder *order= new COrder(Symbol(),MagicNumber,GROUP_ORDERS_ALL);
CPosition *SellPos=new CPosition(Symbol(), MagicNumber, GROUP_POSITIONS_SELLS);
CPosition *BuyPos=new CPosition(Symbol(), MagicNumber, GROUP_POSITIONS_BUYS);
CUtilities *tools=new CUtilities(Symbol());
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

   if(TimeCurrent() > Expiry_Date)
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

         BEOPb2P=0.0;
         BEOPs2P=0.0;
         BEtpbP=0;
         BEtpb2P=0;
         BEtps2P=0;
         BEtpsP=0;
         BEsls2P=0;
         BEslb2P=0;
         BEslsP=0;
         BEslbP=0;
         BEOPbP=0.0;
         BEOPsP=0.0;
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
   Traliling();
   SecondPending();
   DeletPending();
   DeletePending2();
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
               BEOPb2P=0.0;
               BEOPs2P=0.0;
               BEtpbP=0;
               BEtpb2P=0;
               BEtps2P=0;
               BEtpsP=0;
               BEsls2P=0;
               BEslb2P=0;
               BEslsP=0;
               BEslbP=0;
               BEOPbP=0.0;
               BEOPsP=0.0;
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
               BEOPb2P=0.0;
               BEOPs2P=0.0;
               BEtpbP=0;
               BEtpb2P=0;
               BEtps2P=0;
               BEtpsP=0;
               BEsls2P=0;
               BEslb2P=0;
               BEslsP=0;
               BEslbP=0;
               BEOPbP=0.0;
               BEOPsP=0.0;
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

               Y=CountPosition(MagicNumber);
               trade.PositionClose(PositionTicket);

               NewBuy=true;
               // OpenBuyStopStop1(MagicNumber,Lo,OP,Tp,Sl);
               Y=CountPosition(MagicNumber);
               if(Use_Close_WhenBE_P1)
                 {
                  BEOPb=PositionGetDouble(POSITION_PRICE_OPEN);
                  BEslb=PositionGetDouble(POSITION_SL);
                  BEtpb=PositionGetDouble(POSITION_TP);
                  BEOPbP=PositionGetDouble(POSITION_PRICE_OPEN)+xpip_Positive*pips;
                  BEslbP=PositionGetDouble(POSITION_SL);
                  BEtpbP=PositionGetDouble(POSITION_TP);
                 }
               else
                 {
                  OPb=PositionGetDouble(POSITION_PRICE_OPEN);
                  TPb=PositionGetDouble(POSITION_TP);
                  SLb=PositionGetDouble(POSITION_SL);
                  Lob=PositionGetDouble(POSITION_VOLUME);
                 }
              }
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL && (SymbolInfoDouble(_Symbol,SYMBOL_BID)-PositionGetDouble(POSITION_PRICE_OPEN))>=NivDelet1*pips)
              {
               if(Use_Close_WhenBE_P1)
                 {
                  BEOPs=PositionGetDouble(POSITION_PRICE_OPEN);
                  BEsls=PositionGetDouble(POSITION_SL);
                  BEtps=PositionGetDouble(POSITION_TP);
                  BEOPsP=PositionGetDouble(POSITION_PRICE_OPEN)-xpip_Positive*pips;
                  BEslsP=PositionGetDouble(POSITION_SL);
                  BEtpsP=PositionGetDouble(POSITION_TP);

                 }
               else
                 {
                  OPs=PositionGetDouble(POSITION_PRICE_OPEN);
                  TPs=PositionGetDouble(POSITION_TP);
                  SLs=PositionGetDouble(POSITION_SL);
                  Los=PositionGetDouble(POSITION_VOLUME);
                 }
               Y=CountPosition(MagicNumber);
               trade.PositionClose(PositionTicket);

               //OpenSellStopStop1(MagicNumber,Lo2,OP2,Tp2,Sl2);
               NewSell=true;
               Y=CountPosition(MagicNumber);

              }
           }
        }
     }
   if(DeletXpip==true)
     {
      for(int i=PositionsTotal()-1; i>=0; i--)
        {
         ulong PositionTicket = PositionGetTicket(i);

         if(PositionGetString(POSITION_SYMBOL) == Symbol() && PositionGetInteger(POSITION_MAGIC) == MagicNumber && PositionGetString(POSITION_COMMENT) == "KEENE+")
           {
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY && (PositionGetDouble(POSITION_PRICE_OPEN)-SymbolInfoDouble(_Symbol,SYMBOL_ASK))>=NivDeletx*pips)
              {

               Y=CountPosition(MagicNumber);
               trade.PositionClose(PositionTicket);

               NewBuy=true;
               // OpenBuyStopStop1(MagicNumber,Lo,OP,Tp,Sl);
               Y=CountPosition(MagicNumber);

               BEOPbP=PositionGetDouble(POSITION_PRICE_OPEN);
               BEslbP=PositionGetDouble(POSITION_SL);
               BEtpbP=PositionGetDouble(POSITION_TP);


              }
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL && (SymbolInfoDouble(_Symbol,SYMBOL_BID)-PositionGetDouble(POSITION_PRICE_OPEN))>=NivDeletx*pips)
              {


               BEOPsP=PositionGetDouble(POSITION_PRICE_OPEN);
               BEslsP=PositionGetDouble(POSITION_SL);
               BEtpsP=PositionGetDouble(POSITION_TP);



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
      if(BuyReady&&CountOrderswithcomment(MagicNumber,"KEENE")==0&&CountPositionwithcomment(MagicNumber,"KEENE")==0&&CountPositionwithcomment(MagicNumber,"KEENE+")==0&&CountOrderswithcomment(MagicNumber,"KEENE+")==0)
        {

         NewBuy=true;
         BuyReady=false;
         Y=CountPosition(MagicNumber);
        }

      if(SellReady&&CountOrderswithcomment(MagicNumber,"KEENE")==0&&CountPositionwithcomment(MagicNumber,"KEENE")==0&&CountPositionwithcomment(MagicNumber,"KEENE+")==0&&CountOrderswithcomment(MagicNumber,"KEENE+")==0)
        {

         NewSell=true;
         SellReady=false;
         Y=CountPosition(MagicNumber);

        }

     }

   DeletePending2();
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
   if(DeletXpip==true)
     {
      for(int i=PositionsTotal()-1; i>=0; i--)
        {
         ulong PositionTicket = PositionGetTicket(i);

         if(PositionGetString(POSITION_SYMBOL) == Symbol() && PositionGetInteger(POSITION_MAGIC) == MagicNumber && PositionGetString(POSITION_COMMENT) == "KEENE2+")
           {
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY && (PositionGetDouble(POSITION_PRICE_OPEN)-SymbolInfoDouble(_Symbol,SYMBOL_ASK))>=NivDeletx*pips)
              {

               Y=CountPosition(MagicNumber);
               trade.PositionClose(PositionTicket);
               NewBuy=true;
               // OpenBuyStopStop1(MagicNumber,Lo,OP,Tp,Sl);
               Y=CountPosition(MagicNumber);
               BEOPb2P=PositionGetDouble(POSITION_PRICE_OPEN);
               BEslb2P=PositionGetDouble(POSITION_SL);
               BEtpb2P=PositionGetDouble(POSITION_TP);

              }
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL && (SymbolInfoDouble(_Symbol,SYMBOL_BID)-PositionGetDouble(POSITION_PRICE_OPEN))>=NivDeletx*pips)
              {

               BEOPs2P=PositionGetDouble(POSITION_PRICE_OPEN);
               BEsls2P=PositionGetDouble(POSITION_SL);
               BEtps2P=PositionGetDouble(POSITION_TP);
               Y=CountPosition(MagicNumber);
               trade.PositionClose(PositionTicket);

               //OpenSellStopStop1(MagicNumber,Lo2,OP2,Tp2,Sl2);
               NewSell=true;
               Y=CountPosition(MagicNumber);

              }
           }
        }
     }
   if(Use_Close_WhenBE_P2)
     {
      if(BuyReady2&&CountPositionwithcomment(MagicNumber,"KEENE2")==0&&CountPositionwithcomment(MagicNumber,"KEENE2+")==0&&CountOrderswithcomment(MagicNumber,"KEENE2")==0&&CountOrderswithcomment(MagicNumber,"KEENE2+")==0)
        {

         NewBuy2=true;
         BuyReady2=false;
         Y=CountPosition(MagicNumber);

        }

      if(SellReady2&&CountPositionwithcomment(MagicNumber,"KEENE2")==0&&CountPositionwithcomment(MagicNumber,"KEENE2+")==0&&CountOrderswithcomment(MagicNumber,"KEENE2")==0&&CountOrderswithcomment(MagicNumber,"KEENE2+")==0)
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
   if(DeletP1==true&&!Use_Close_WhenBE_P1)
     {
      if(NewBuy==true)
        {
         if(SymbolInfoDouble(_Symbol,SYMBOL_ASK)>=OPb && OPb!=0.0)
           {
            Y=CountPosition(MagicNumber);
            execute.Position(TYPE_POSITION_BUY,Lob,SLb,TPb,SLTP_PRICE,30,"KEENE");
            NewBuy=false;
            Y=CountPosition(MagicNumber);

           }
        }
      if(NewSell==true)
        {
         if(SymbolInfoDouble(_Symbol,SYMBOL_BID)<=OPs && OPs!=0.0)
           {
            Y=CountPosition(MagicNumber);
            execute.Position(TYPE_POSITION_SELL,Los,SLs,TPs,SLTP_PRICE,30,"KEENE");
            NewSell=false;
            Y=CountPosition(MagicNumber);

           }
        }
     }
   if(Use_Close_WhenBE_P1)
     {
      if(NewBuy)
        {
         if(SymbolInfoDouble(_Symbol,SYMBOL_ASK)<=BEOPb-BreakEven_To_Close_P1*pips && BEOPb!=0.0)
           {
            Y=CountPosition(MagicNumber);
            int z=order.GroupTotal();
            int x=CountPosition1(MagicNumber);
            double p=SymbolInfoDouble(_Symbol,SYMBOL_ASK);
            execute.Order(TYPE_ORDER_BUYSTOP,Lots_Pending,BEOPb,BEslb,BEtpb,SLTP_PRICE,0,30,"KEENE");
            if(x!=CountPosition1(MagicNumber))
              {
               BreakAgainM = true;
               BreakAgainP = true;
              }
            if(Y1!=CountPosition(MagicNumber)||x!=CountPosition1(MagicNumber)||z!=order.GroupTotal())
              {
               NewBuy=false;
               BEOPb=0;
               BreakAgainP=true;
               NewSecPendSell=true;
               Y=CountPosition(MagicNumber);
              }
           }
         if(SymbolInfoDouble(_Symbol,SYMBOL_ASK)>=BEOPbP && BEOPbP!=0.0&&BEOPbP!=0)
           {
            Y=CountPosition(MagicNumber);
            int x=CountPosition1(MagicNumber);
            int z=Pos.GroupTotal();
            double p=SymbolInfoDouble(_Symbol,SYMBOL_ASK);
            execute.Position(TYPE_POSITION_BUY,Lots_Xpips,BEslbP,BEtpbP,SLTP_PRICE,30,"KEENE+");
            if(x!=CountPosition1(MagicNumber))
              {
               BreakAgainM = true;
               BreakAgainP = true;
              }


            if(Y1!=CountPosition(MagicNumber)||x!=CountPosition1(MagicNumber)||z!=Pos.GroupTotal())
              {
               NewBuy=false;
               BEOPbP=0;
               BreakAgainP=true;
               NewSecPendSell=true;

               Y=CountPosition(MagicNumber);
              }
           }
        }
      if(NewSell)
        {
         double Bid=SymbolInfoDouble(_Symbol,SYMBOL_BID);
         if(Bid>=BEOPs+BreakEven_To_Close_P1*pips && BEOPs!=0.0)
           {
            int x=CountPosition1(MagicNumber);
            Y=CountPosition(MagicNumber);
            int z=order.GroupTotal();
            execute.Order(TYPE_ORDER_SELLSTOP,Lots_Pending,BEOPs,BEsls,BEtps,SLTP_PRICE,0,30,"KEENE");
            if(x!=CountPosition1(MagicNumber))
              {
               BreakAgainM = true;
               BreakAgainP = true;
              }
            if(Y1!=CountPosition(MagicNumber)||x!=CountPosition1(MagicNumber)||z!=order.GroupTotal())
              {
               BEOPs=0.0;
               NewSell=false;
               BreakAgainP=true;
               NewSecPendBuy=true;
               Y=CountPosition(MagicNumber);
              }
           }
         if(SymbolInfoDouble(_Symbol,SYMBOL_BID)<=BEOPsP && BEOPs!=0.0&&BEOPsP!=0)
           {
            int x=CountPosition1(MagicNumber);
            Y=CountPosition(MagicNumber);
            int z=Pos.GroupTotal();
            double p=SymbolInfoDouble(_Symbol,SYMBOL_BID);
            execute.Position(TYPE_POSITION_SELL,Lots_Xpips,BEslsP,BEtpsP,SLTP_PRICE,30,"KEENE+");

            if(x!=CountPosition1(MagicNumber))
              {
               BreakAgainM = true;
               BreakAgainP = true;
              }
            if(Y1!=CountPosition(MagicNumber)||x!=CountPosition1(MagicNumber)||z!=Pos.GroupTotal())
              {
               BEOPsP=0.0;
               NewSell=false;
               BreakAgainP=true;
               NewSecPendBuy=true;
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
   if(DeletP2==true&&!Use_Close_WhenBE_P2)
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
         if(SymbolInfoDouble(_Symbol,SYMBOL_ASK)<=BEOPb2-BreakEven_To_Close_P2*pips && BEOPb2!=0.0)
           {
            Y=CountPosition(MagicNumber);
            int x=CountPosition1(MagicNumber);
            int z=order.GroupTotal();
            double p=SymbolInfoDouble(_Symbol,SYMBOL_ASK);
            execute.Order(TYPE_ORDER_BUYSTOP,Lots_Pending2,BEOPb2,BEslb2,BEtpb2,SLTP_PRICE,0,30,"KEENE2");
            if(x!=CountPosition1(MagicNumber))
              {
               BreakAgainM = true;
               BreakAgainP = true;
              }
            if(Y1!=CountPosition(MagicNumber)||x!=CountPosition1(MagicNumber)||z!=order.GroupTotal())
              {
               NewBuy2=false;
               BEOPb2=0;
               BreakAgainP=true;
               NewSecPendSell=false;
               Y=CountPosition(MagicNumber);
              }
           }
         if(SymbolInfoDouble(_Symbol,SYMBOL_ASK)>=BEOPb2P&& BEOPb2!=0.0&& BEOPb2P!=0.0)
           {
            Y=CountPosition(MagicNumber);
            int x=CountPosition1(MagicNumber);
            int z=Pos.GroupTotal();
            execute.Position(TYPE_POSITION_BUY,Lots_Pending2,BEslb2P,BEtpb2P,SLTP_PRICE,30,"KEENE2+");

            if(x!=CountPosition1(MagicNumber))
              {
               BreakAgainM = true;
               BreakAgainP = true;
              }
            if(Y1!=CountPosition(MagicNumber)||x!=CountPosition1(MagicNumber)||z!=Pos.GroupTotal())
              {
               NewBuy2=false;
               BEOPb2P=0;
               BreakAgainP=true;
               NewSecPendSell=false;
               Y=CountPosition(MagicNumber);
              }
           }
        }
      if(NewSell2)
        {
         if(SymbolInfoDouble(_Symbol,SYMBOL_BID)>=BEOPs2+BreakEven_To_Close_P2*pips && BEOPs2!=0.0)
           {
            int x=CountPosition1(MagicNumber);

            Y=CountPosition(MagicNumber);
            double p=SymbolInfoDouble(_Symbol,SYMBOL_BID);
            int z=order.GroupTotal();
            execute.Order(TYPE_ORDER_SELLSTOP,Lots_Pending,BEOPs2,BEsls2,BEtps2,SLTP_PRICE,0,30,"KEENE2");
            if(x!=CountPosition1(MagicNumber))
              {
               BreakAgainM = true;
               BreakAgainP = true;
              }
            if(Y1!=CountPosition(MagicNumber)||x!=CountPosition1(MagicNumber)||z!=order.GroupTotal())
              {
               BEOPs2=0.0;
               NewSell2=false;
               NewSecPendBuy=false;
               BreakAgainP=true;
               Y=CountPosition(MagicNumber);
              }
           }
         if(SymbolInfoDouble(_Symbol,SYMBOL_BID)<=BEOPs2P && BEOPs2!=0.0&& BEOPs2P!=0.0)

           {
            int x=CountPosition1(MagicNumber);
            Y=CountPosition(MagicNumber);
            int z=Pos.GroupTotal();
            double p=SymbolInfoDouble(_Symbol,SYMBOL_BID);
            execute.Position(TYPE_POSITION_SELL,Lots_Pending2,BEsls2P,BEtps2P,SLTP_PRICE,30,"KEENE2+");

            if(x!=CountPosition1(MagicNumber))
              {
               BreakAgainM = true;
               BreakAgainP = true;
              }
            if(Y1!=CountPosition(MagicNumber)||x!=CountPosition1(MagicNumber)||z!=Pos.GroupTotal())
              {
               BEOPs2P=0.0;
               NewSell2=false;
               NewSecPendBuy=false;
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
void DeletePending2()
  {
   int N=0;
   for(int x=0; x<Pos.GroupTotal(); x++)
     {
      if(Pos[x].GetComment()=="KEENE"||Pos[x].GetComment()=="KEENE+")
        {
         N++;
        }
     }
   if(N==0)
     {
      for(int x=0; x<order.GroupTotal(); x++)
        {
         if(order[x].GetComment()=="KEENE2"||order[x].GetComment()=="KEENE2+")
           {
            order[x].Close();
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

         if(PositionGetString(POSITION_SYMBOL) == Symbol() && PositionGetInteger(POSITION_MAGIC) == MagicNumber && (PositionGetString(POSITION_COMMENT) == "KEENE"||PositionGetString(POSITION_COMMENT) == "KEENE2"||PositionGetString(POSITION_COMMENT) == "KEENE+")||PositionGetString(POSITION_COMMENT) == "KEENE2+")
           {
            double pp=0;
            if(PositionGetString(POSITION_COMMENT) == "KEENE")
              {
               pp=StartBreakEvenAtP;
              }
            else
               if(PositionGetString(POSITION_COMMENT) == "KEENE+")
                 {
                  pp=StartBreakEvenAtxpip;
                 }
               else
                  if(PositionGetString(POSITION_COMMENT) == "KEENE2")
                    {
                     pp=StartBreakEvenAtP2;
                    }
                  else
                    {
                     pp=StartBreakEvenAtxpip;
                    }
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY && (SymbolInfoDouble(_Symbol,SYMBOL_ASK)-PositionGetDouble(POSITION_PRICE_OPEN))>=pp*pips)
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
                  BEOPbP=PositionGetDouble(POSITION_PRICE_OPEN)+xpip_Positive*pips;
                  BEslbP=PositionGetDouble(POSITION_SL);
                  BEtpbP=PositionGetDouble(POSITION_TP);
                  BreakAgainP=false;
                  BuyReady=true;
                 }
               if(Use_Close_WhenBE_P1&&PositionGetString(POSITION_COMMENT) == "KEENE+")
                 {
                  BEOPbP=PositionGetDouble(POSITION_PRICE_OPEN);
                  BEslbP=PositionGetDouble(POSITION_SL);
                  BEtpbP=PositionGetDouble(POSITION_TP);
                  BreakAgainP=false;
                  BuyReady=true;
                 }
               if(Use_Close_WhenBE_P2&&PositionGetString(POSITION_COMMENT) == "KEENE2")
                 {
                  BEOPb2=PositionGetDouble(POSITION_PRICE_OPEN);
                  BEslb2=PositionGetDouble(POSITION_SL);
                  BEtpb2=PositionGetDouble(POSITION_TP);
                  BEOPb2P=PositionGetDouble(POSITION_PRICE_OPEN)+xpip_Positive*pips;
                  BEslb2P=PositionGetDouble(POSITION_SL);
                  BEtpb2P=PositionGetDouble(POSITION_TP);
                  BreakAgainP=false;
                  BuyReady2=true;
                 }
               if(Use_Close_WhenBE_P2&&PositionGetString(POSITION_COMMENT) == "KEENE2+")
                 {
                  BEOPb2P=PositionGetDouble(POSITION_PRICE_OPEN);
                  BEslb2P=PositionGetDouble(POSITION_SL);
                  BEtpb2P=PositionGetDouble(POSITION_TP);
                  BreakAgainP=false;
                  BuyReady2=true;
                 }
              }
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL && (PositionGetDouble(POSITION_PRICE_OPEN)-SymbolInfoDouble(_Symbol,SYMBOL_BID))>=pp*pips)
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
                  BEOPsP=PositionGetDouble(POSITION_PRICE_OPEN)-xpip_Positive*pips;
                  BEslsP=PositionGetDouble(POSITION_SL);
                  BEtpsP=PositionGetDouble(POSITION_TP);
                  SellReady=true;
                  BreakAgainP=false;
                 }
               if(Use_Close_WhenBE_P1&&PositionGetString(POSITION_COMMENT) == "KEENE+")
                 {
                  BEOPsP=PositionGetDouble(POSITION_PRICE_OPEN);
                  BEslsP=PositionGetDouble(POSITION_SL);
                  BEtpsP=PositionGetDouble(POSITION_TP);
                  SellReady=true;
                  BreakAgainP=false;
                 }
               if(Use_Close_WhenBE_P2&&PositionGetString(POSITION_COMMENT) == "KEENE2")
                 {
                  BEOPs2=PositionGetDouble(POSITION_PRICE_OPEN);
                  BEsls2=PositionGetDouble(POSITION_SL);
                  BEtps2=PositionGetDouble(POSITION_TP);
                  BEOPs2P=PositionGetDouble(POSITION_PRICE_OPEN)-xpip_Positive*pips;
                  BEsls2P=PositionGetDouble(POSITION_SL);
                  BEtps2P=PositionGetDouble(POSITION_TP);
                  SellReady2=true;
                  BreakAgainP=false;
                 }
               if(Use_Close_WhenBE_P2&&PositionGetString(POSITION_COMMENT) == "KEENE2+")
                 {
                  BEOPs2P=PositionGetDouble(POSITION_PRICE_OPEN);
                  BEsls2P=PositionGetDouble(POSITION_SL);
                  BEtps2P=PositionGetDouble(POSITION_TP);
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
      if(PositionGetInteger(POSITION_MAGIC) == magic && (PositionGetString(POSITION_COMMENT)=="KEENE"||PositionGetString(POSITION_COMMENT)=="KEENE+"))
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
   int x=0;
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
   int x=0;
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
   int x=0;
   for(int i=0; i<Pos.GroupTotal(); i++)
     {
      if(Pos[i].GetComment()==cmnt&&Pos[i].GetMagicNumber()==magic)
        {
         x++;
        }
     }
   return x;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CountOrderswithcomment(int magic,string cmnt)
  {
   int x=0;
   for(int i=0; i<order.GroupTotal(); i++)
     {
      if(order[i].GetComment()==cmnt&&order[i].GetMagicNumber()==magic)
        {
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
void Traliling()
  {
   int buy_total = BuyPos.GroupTotal();
   if(Use_Trailing)
     {
      for(int i = 0; i < buy_total; i++)
        {
         if(BuyPos.SelectByIndex(i))
           {
            if(BuyPos.GetComment()=="ZARIA"&&buy_total==1)
               if(Use_Trailing)
                 {
                  if(tools.Bid() - BuyPos.GetPriceOpen() > tools.Pip() * TrailingStepPoint)
                    {
                     if(BuyPos.GetStopLoss() < tools.Bid() - tools.Pip() * TrailingStopPoint)
                       {
                        double ModfiedSl = tools.Bid() - (tools.Pip() * TrailingStopPoint);
                        BuyPos.Modify(ModfiedSl, BuyPos.GetTakeProfit(), SLTP_PRICE);
                       }
                    }
                 }
           }
        }
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   int sell_total = SellPos.GroupTotal();
   if(Use_Trailing)
     {
      for(int i = 0; i < sell_total; i++)
        {
         if(SellPos.SelectByIndex(i))
           {
            if(SellPos.GetComment()=="ZARIA"&&sell_total==1)
               if(Use_Trailing)
                 {
                  if(SellPos.GetPriceOpen() - tools.Ask() > tools.Pip() * TrailingStepPoint)
                    {
                     if(SellPos.GetStopLoss() > tools.Ask() + tools.Pip() * TrailingStopPoint)
                       {
                        double ModfiedSl = tools.Ask() + tools.Pip() * TrailingStopPoint;
                        SellPos.Modify(ModfiedSl, SellPos.GetTakeProfit(), SLTP_PRICE);
                       }
                    }
                 }
           }
        }
     }
  }
//+------------------------------------------------------------------+
