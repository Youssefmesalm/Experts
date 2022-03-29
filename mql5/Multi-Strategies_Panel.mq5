//+------------------------------------------------------------------+
//|                                       Multi-Strategies Panel.mq5 |
//|                                   Copyright 2022, TradeCube Ltd. |
//|                                        https://www.tradecube.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, TradeCube Ltd."
#property link      "https://www.tradecube.net"
#property version   "1.00"

datetime date0 = D'2022.01.13 00:00';

#include <Controls/Label.mqh>
#include <Controls\Dialog.mqh>

#define  NL "\n"

#include <Telegram.mqh>

//+------------------------------------------------------------------+
//|   CMyBot                                                         |
//+------------------------------------------------------------------+
class CMyBot: public CCustomBot
  {
private:
   string            m_button[35];
public:
   //+------------------------------------------------------------------+
   void              CMyBot::CMyBot(void)
     {

     }

   //+------------------------------------------------------------------+
   void              ProcessMessages(string update)
     {
      if(cc0!="")
        {
         int res = bot.SendMessage(InpChannelName,cc0,false,false);
         if(res!=0)
            Print("Error: ",GetErrorDescription(res));
         else
            cc0="";
        }
     }
  };

CMyBot bot;
int getme_result;

enum SL_TP
  {
   op1=0, // in pips
   op2=1, // SAR
   op3=2, // Supertrend
  };

input string p00= "PRELIMINARIES";                                   //******* PRELIMINARIES *******
input string pairs="EURUSD,USDJPY,USDCHF,GBPUSD,USDJPY";             // Pairs
input SL_TP sltype=0;                                                // SL Type
input int sl_pips=30;                                                // SL pips
input bool useAlerts=true;                                           // Use popup Alerts
input bool useTel=false;                                             // Use Telegram Alerts
input string InpChannelName="myinsideoutlink";                      // Telegram Channel ID
input string InpToken="1839295551:AAGNKAYQ6ayqyD_4juais2AekySoRPXdlIo";// Telegram Token

input string p14="SAR";                                              //******* SAR **************
input bool useSAR=true;                                              // Use SAR
input ENUM_TIMEFRAMES sar_tf=PERIOD_CURRENT;                         // Timeframe
input double sar_step=0.02;                                          // Step
input double sar_max=0.2;                                            // Maximum

input string p01= "SINGLE MA";                                       //******* SINGLE MA *********
input bool useSingleMA=true;                                         // Use single MA
input ENUM_TIMEFRAMES MA1_tf=PERIOD_CURRENT;                         // Timeframe
input int MA1_per=200;                                               // Period
input ENUM_MA_METHOD MA1_method=MODE_SMA;                            // Method
input ENUM_APPLIED_PRICE MA1_price=PRICE_CLOSE;                      // Applied price

input string p02= "DOUBLE MA";                                       //******** DOUBLE MA *********
input bool useDoubleMA=true;                                         // Use double MA
input ENUM_TIMEFRAMES MA2_tf=PERIOD_CURRENT;                         // Fast MA Timeframe
input int MA2_per=50;                                                // Fast MA Period
input ENUM_MA_METHOD MA2_method=MODE_SMA;                            // Fast MA Method
input ENUM_APPLIED_PRICE MA2_price=PRICE_CLOSE;                      // Fast MA Applied price
input ENUM_TIMEFRAMES MA3_tf=PERIOD_CURRENT;                         // Slow MA Timeframe
input int MA3_per=200;                                               // Slow MA Period
input ENUM_MA_METHOD MA3_method=MODE_SMA;                            // Slow MA Method
input ENUM_APPLIED_PRICE MA3_price=PRICE_CLOSE;                      // Slow MA Applied price

input string  p03="SUPERTREND";                                      //******** SUPERTREND ********
input bool useSuperTrend=true;                                       // Use supertrend
input ENUM_TIMEFRAMES st_tf=PERIOD_CURRENT;                          // Timeframe
input int st_per=10;                                                 // Period
input double st_mult=3;                                              // Multiplier

input string  p04="STO-RSI";                                         //******** STO-RSI ********
input bool useStoRSI=true;                                           // Use sto-rsi
input ENUM_TIMEFRAMES storsi_tf=PERIOD_CURRENT;                      // Timeframe
input int storsi1_per=14;                                            // RSI Period
input int storsi2_per=20;                                            // STO Period

input string  p05="STOCHASTIC";                                      //******** STOCHASTIC ********
input bool useSto=true;                                              // Use stochastic oscillator
input ENUM_TIMEFRAMES sto_tf=PERIOD_CURRENT;                         // Timeframe
input int sto_dper=10;                                               // STO D-Period
input int sto_kper=3 ;                                               // STO K-Period
input int sto_sper=3 ;                                               // STO Slow-Period

input string  p06="MACD";                                            //******** MACD ********
input bool useMacd=true;                                             // Use MACD
input ENUM_TIMEFRAMES mac_tf=PERIOD_CURRENT;                         // Timeframe
input int mac_fper=12;                                               // Fast EMA
input int mac_sper=26;                                               // Slow EMA
input int mac_smper=9;                                               // SMA

input string  p07="ADX";                                             //******** ADX ********
input bool useAdx=true;                                              // Use ADX
input ENUM_TIMEFRAMES adx_tf=PERIOD_CURRENT;                         // Timeframe
input int adx_per=14;                                                // Period
input double adx_lev=30;                                             // Level

input string  p08="ATR";                                             //******** ATR ********
input bool useAtr=true;                                              // Use ATR
input ENUM_TIMEFRAMES atr_tf=PERIOD_CURRENT;                         // Timeframe
input int atr_per=14;                                                // Period

input string  p09="RSI";                                             //******** RSI ********
input bool useRSI=true;                                              // Use RSI
input ENUM_TIMEFRAMES rsi_tf=PERIOD_CURRENT;                         // Timeframe
input int rsi_per=14;                                                // Period
input double rsi_level=50;                                           // level

input string  p10="BOLLINGER";                                       //******** BOLLINGER BAND ********
input bool useBB=true;                                               // Use Bollinger
input ENUM_TIMEFRAMES bb_tf=PERIOD_CURRENT;                          // Timeframe
input int BB_per=28;                                                 // Period
input double BB_dev=2 ;                                              // Deviation

input string  p11="BOLLINGER WIDTH";                                 //******** BOLLINGER BAND WIDTH ********
input bool useBBw=true;                                              // Use Bollinger width
input ENUM_TIMEFRAMES bbw_tf=PERIOD_CURRENT;                         // Timeframe
input int BBw_per=20;                                                // Period
input double BBw_dev=2 ;                                             // Deviation

input string  p12="ICHIMOKU";                                        //******** ICHIMOKU ********
input bool useIchi=true;                                             // Use Ichimoku
input ENUM_TIMEFRAMES Ichi_tf=PERIOD_CURRENT;                        // Timeframe
input int tekan=9;                                                   // Tekan
input int kijun=26;                                                  // Kijun
input int senkou=52;                                                 // Senkou-Span B

input string  p13="RSI-DIVERGENCE";                                  //******** RSI-DIVERGENCE ********
input bool useRsiDiv=true;                                           // Use RSI-Divergence
input ENUM_TIMEFRAMES RsiDiv_tf=PERIOD_CURRENT;                      // Timeframe
input int RsiDiv_per=14;                                             // Period

CAppDialog appDialog;
CLabel lbl_PairName[], //labels
       lbl_SingleMA[],
       lbl_DoubleMA[],
       lbl_Supertrend[],
       lbl_STORSI[],
       lbl_STO[],
       lbl_MACD[],
       lbl_ADX[],
       lbl_ATR[],
       lbl_RSI[],
       lbl_BB[],
       lbl_BBW[],
       lbl_RSIDIV[],
       lbl_ICHI[],
       lbl_SAR[],
       lbl_perc[];

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Initialize()
  {
   ArrayResize(lbl_PairName,ArraySize(pair)+1);
   ArrayResize(lbl_SingleMA,ArraySize(pair)+1);
   ArrayResize(lbl_DoubleMA,ArraySize(pair)+1);
   ArrayResize(lbl_STORSI,ArraySize(pair)+1);
   ArrayResize(lbl_STO,ArraySize(pair)+1);
   ArrayResize(lbl_MACD,ArraySize(pair)+1);
   ArrayResize(lbl_ADX,ArraySize(pair)+1);
   ArrayResize(lbl_ATR,ArraySize(pair)+1);
   ArrayResize(lbl_RSI,ArraySize(pair)+1);
   ArrayResize(lbl_BB,ArraySize(pair)+1);
   ArrayResize(lbl_BBW,ArraySize(pair)+1);
   ArrayResize(lbl_RSIDIV,ArraySize(pair)+1);
   ArrayResize(lbl_ICHI,ArraySize(pair)+1);
   ArrayResize(lbl_Supertrend,ArraySize(pair)+1);
   ArrayResize(lbl_SAR,ArraySize(pair)+1);
   ArrayResize(lbl_perc,ArraySize(pair)+1);

   int y_size=(ArraySize(pair)+1)*30;
   appDialog.Create(0,"MULTI-STRATEGIES PANEL",0,0,20,810,20+y_size);
//appDialog.setBackColor(clrBlack);
//---
   lbl_PairName[0].Create(0,"lbl_PairName",0,0,0,0,0);
   lbl_PairName[0].Shift(5,5);
   lbl_PairName[0].Text("SYMBOLS");
   lbl_PairName[0].Color(clrRed);
   appDialog.Add(lbl_PairName[0]);

   lbl_SingleMA[0].Create(0,"lbl_SingleMA",0,0,0,0,0);
   lbl_SingleMA[0].Shift(85,5);
   lbl_SingleMA[0].Text("1 MA");
   lbl_SingleMA[0].Color(clrRed);
   appDialog.Add(lbl_SingleMA[0]);

   lbl_DoubleMA[0].Create(0,"lbl_DoubleMA",0,0,0,0,0);
   lbl_DoubleMA[0].Shift(135,5);
   lbl_DoubleMA[0].Text("2 MA");
   lbl_DoubleMA[0].Color(clrRed);
   appDialog.Add(lbl_DoubleMA[0]);

   lbl_STORSI[0].Create(0,"lbl_STORSI",0,0,0,0,0);
   lbl_STORSI[0].Shift(185,5);
   lbl_STORSI[0].Text("STO-RSI");
   lbl_STORSI[0].Color(clrRed);
   appDialog.Add(lbl_STORSI[0]);

   lbl_STO[0].Create(0,"lbl_STO",0,0,0,0,0);
   lbl_STO[0].Shift(255,5);
   lbl_STO[0].Text("STO");
   lbl_STO[0].Color(clrRed);
   appDialog.Add(lbl_STO[0]);

   lbl_MACD[0].Create(0,"lbl_MACD",0,0,0,0,0);
   lbl_MACD[0].Shift(295,5);
   lbl_MACD[0].Text("MACD");
   lbl_MACD[0].Color(clrRed);
   appDialog.Add(lbl_MACD[0]);

   lbl_ADX[0].Create(0,"lbl_ADX",0,0,0,0,0);
   lbl_ADX[0].Shift(345,5);
   lbl_ADX[0].Text("ADX");
   lbl_ADX[0].Color(clrRed);
   appDialog.Add(lbl_ADX[0]);

   lbl_ATR[0].Create(0,"lbl_ATR",0,0,0,0,0);
   lbl_ATR[0].Shift(385,5);
   lbl_ATR[0].Text("ATR");
   lbl_ATR[0].Color(clrRed);
   appDialog.Add(lbl_ATR[0]);

   lbl_RSI[0].Create(0,"lbl_RSI",0,0,0,0,0);
   lbl_RSI[0].Shift(425,5);
   lbl_RSI[0].Text("RSI");
   lbl_RSI[0].Color(clrRed);
   appDialog.Add(lbl_RSI[0]);

   lbl_BB[0].Create(0,"lbl_BB",0,0,0,0,0);
   lbl_BB[0].Shift(465,5);
   lbl_BB[0].Text("BB");
   lbl_BB[0].Color(clrRed);
   appDialog.Add(lbl_BB[0]);

   lbl_BBW[0].Create(0,"lbl_BBW",0,0,0,0,0);
   lbl_BBW[0].Shift(500,5);
   lbl_BBW[0].Text("BB w");
   lbl_BBW[0].Color(clrRed);
   appDialog.Add(lbl_BBW[0]);

   lbl_RSIDIV[0].Create(0,"lbl_RSIDIV",0,0,0,0,0);
   lbl_RSIDIV[0].Shift(550,5);
   lbl_RSIDIV[0].Text("RSI-DIV");
   lbl_RSIDIV[0].Color(clrRed);
   appDialog.Add(lbl_RSIDIV[0]);

   lbl_ICHI[0].Create(0,"lbl_ICHI",0,0,0,0,0);
   lbl_ICHI[0].Shift(610,5);
   lbl_ICHI[0].Text("ICHI");
   lbl_ICHI[0].Color(clrRed);
   appDialog.Add(lbl_ICHI[0]);

   lbl_Supertrend[0].Create(0,"lbl_Supertrend",0,0,0,0,0);
   lbl_Supertrend[0].Shift(660,5);
   lbl_Supertrend[0].Text("STR");
   lbl_Supertrend[0].Color(clrRed);
   appDialog.Add(lbl_Supertrend[0]);

   lbl_SAR[0].Create(0,"lbl_SAR",0,0,0,0,0);
   lbl_SAR[0].Shift(700,5);
   lbl_SAR[0].Text("SAR");
   lbl_SAR[0].Color(clrRed);
   appDialog.Add(lbl_SAR[0]);

   lbl_perc[0].Create(0,"lbl_perc",0,0,0,0,0);
   lbl_perc[0].Shift(740,5);
   lbl_perc[0].Text("Avg %");
   lbl_perc[0].Color(clrRed);
   appDialog.Add(lbl_perc[0]);

   for(int i=0; i<ArraySize(pair); i++)
     {
      lbl_PairName[i+1].Create(0,"lbl_PairName"+IntegerToString(i),0,0,0,0,0);
      lbl_PairName[i+1].Shift(5,5+(20*(i+1)));
      lbl_PairName[i+1].Text(pair[i]);
      lbl_PairName[i+1].Color(clrBlue);
      appDialog.Add(lbl_PairName[i+1]);

      lbl_SingleMA[i+1].Create(0,"lbl_SingleMA"+IntegerToString(i),0,0,0,0,0);
      lbl_SingleMA[i+1].Shift(85,5+(20*(i+1)));
      lbl_SingleMA[i+1].Text("--");
      lbl_SingleMA[i+1].Color(clrDarkSlateGray);
      appDialog.Add(lbl_SingleMA[i+1]);

      lbl_DoubleMA[i+1].Create(0,"lbl_DoubleMA"+IntegerToString(i),0,0,0,0,0);
      lbl_DoubleMA[i+1].Shift(135,5+(20*(i+1)));
      lbl_DoubleMA[i+1].Text("--");
      lbl_DoubleMA[i+1].Color(clrDarkSlateGray);
      appDialog.Add(lbl_DoubleMA[i+1]);

      lbl_STORSI[i+1].Create(0,"lbl_STORSI"+IntegerToString(i),0,0,0,0,0);
      lbl_STORSI[i+1].Shift(185,5+(20*(i+1)));
      lbl_STORSI[i+1].Text("--");
      lbl_STORSI[i+1].Color(clrDarkSlateGray);
      appDialog.Add(lbl_STORSI[i+1]);

      lbl_STO[i+1].Create(0,"lbl_STO"+IntegerToString(i),0,0,0,0,0);
      lbl_STO[i+1].Shift(255,5+(20*(i+1)));
      lbl_STO[i+1].Text("--");
      lbl_STO[i+1].Color(clrDarkSlateGray);
      appDialog.Add(lbl_STO[i+1]);

      lbl_MACD[i+1].Create(0,"lbl_MACD"+IntegerToString(i),0,0,0,0,0);
      lbl_MACD[i+1].Shift(295,5+(20*(i+1)));
      lbl_MACD[i+1].Text("--");
      lbl_MACD[i+1].Color(clrDarkSlateGray);
      appDialog.Add(lbl_MACD[i+1]);

      lbl_ADX[i+1].Create(0,"lbl_ADX"+IntegerToString(i),0,0,0,0,0);
      lbl_ADX[i+1].Shift(345,5+(20*(i+1)));
      lbl_ADX[i+1].Text("--");
      lbl_ADX[i+1].Color(clrDarkSlateGray);
      appDialog.Add(lbl_ADX[i+1]);

      lbl_ATR[i+1].Create(0,"lbl_ATR"+IntegerToString(i),0,0,0,0,0);
      lbl_ATR[i+1].Shift(385,5+(20*(i+1)));
      lbl_ATR[i+1].Text("--");
      lbl_ATR[i+1].Color(clrDarkSlateGray);
      appDialog.Add(lbl_ATR[i+1]);

      lbl_RSI[i+1].Create(0,"lbl_RSI"+IntegerToString(i),0,0,0,0,0);
      lbl_RSI[i+1].Shift(425,5+(20*(i+1)));
      lbl_RSI[i+1].Text("--");
      lbl_RSI[i+1].Color(clrDarkSlateGray);
      appDialog.Add(lbl_RSI[i+1]);

      lbl_BB[i+1].Create(0,"lbl_BB"+IntegerToString(i),0,0,0,0,0);
      lbl_BB[i+1].Shift(465,5+(20*(i+1)));
      lbl_BB[i+1].Text("--");
      lbl_BB[i+1].Color(clrDarkSlateGray);
      appDialog.Add(lbl_BB[i+1]);

      lbl_BBW[i+1].Create(0,"lbl_BBW"+IntegerToString(i),0,0,0,0,0);
      lbl_BBW[i+1].Shift(500,5+(20*(i+1)));
      lbl_BBW[i+1].Text("--");
      lbl_BBW[i+1].Color(clrDarkSlateGray);
      appDialog.Add(lbl_BBW[i+1]);

      lbl_RSIDIV[i+1].Create(0,"lbl_RSIDIV"+IntegerToString(i),0,0,0,0,0);
      lbl_RSIDIV[i+1].Shift(550,5+(20*(i+1)));
      lbl_RSIDIV[i+1].Text("--");
      lbl_RSIDIV[i+1].Color(clrDarkSlateGray);
      appDialog.Add(lbl_RSIDIV[i+1]);

      lbl_ICHI[i+1].Create(0,"lbl_ICHI"+IntegerToString(i),0,0,0,0,0);
      lbl_ICHI[i+1].Shift(610,5+(20*(i+1)));
      lbl_ICHI[i+1].Text("--");
      lbl_ICHI[i+1].Color(clrDarkSlateGray);
      appDialog.Add(lbl_ICHI[i+1]);

      lbl_Supertrend[i+1].Create(0,"lbl_Supertrend"+IntegerToString(i),0,0,0,0,0);
      lbl_Supertrend[i+1].Shift(660,5+(20*(i+1)));
      lbl_Supertrend[i+1].Text("--");
      lbl_Supertrend[i+1].Color(clrDarkSlateGray);
      appDialog.Add(lbl_Supertrend[i+1]);

      lbl_SAR[i+1].Create(0,"lbl_SAR"+IntegerToString(i),0,0,0,0,0);
      lbl_SAR[i+1].Shift(700,5+(20*(i+1)));
      lbl_SAR[i+1].Text("--");
      lbl_SAR[i+1].Color(clrDarkSlateGray);
      appDialog.Add(lbl_SAR[i+1]);

      lbl_perc[i+1].Create(0,"lbl_perc"+IntegerToString(i),0,0,0,0,0);
      lbl_perc[i+1].Shift(740,5+(20*(i+1)));
      lbl_perc[i+1].Text("0.00%");
      lbl_perc[i+1].Color(clrDarkSlateGray);
      appDialog.Add(lbl_perc[i+1]);
     }

   appDialog.Run();
  }

string sep=",";
ushort u_sep=StringGetCharacter(sep,0);
string pair[];

int s_ma_handle[],d_fma_handle[],d_sma_handle[],st_handle[],storsi_handle[],sto_handle[],mac_handle[],adx_handle[],atr_handle[],rsi_handle[],bb_handle[],bbw_handle[];
int Ichi_handle[],rsiDiv_handle[],sar_handle[];
datetime time0[];
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   if(useTel)
     {
      //--- set token
      bot.Token(InpToken);
      //--- check token
      getme_result=bot.GetMe();
     }
//---
   int k=StringSplit(pairs,u_sep,pair);
   string p[];
   ArrayResize(p,10);
   int n=0;
   for(int i=0; i<k; i++)
     {
      if(IsSymbol(pair[i]))
        {
         p[n]=pair[i];
         n=n+1;
         ArrayResize(p,ArraySize(p)+1);
        }
     }
   ArrayFree(pair);
   ArrayCopy(pair,p,0,0,ArraySize(p)-10);
   ArraySetAsSeries(pair,true);

   ArrayResize(s_ma_handle,ArraySize(pair));
   ArrayResize(d_fma_handle,ArraySize(pair));
   ArrayResize(d_sma_handle,ArraySize(pair));
   ArrayResize(st_handle,ArraySize(pair));
   ArrayResize(storsi_handle,ArraySize(pair));
   ArrayResize(sto_handle,ArraySize(pair));
   ArrayResize(mac_handle,ArraySize(pair));
   ArrayResize(adx_handle,ArraySize(pair));
   ArrayResize(atr_handle,ArraySize(pair));
   ArrayResize(rsi_handle,ArraySize(pair));
   ArrayResize(bb_handle,ArraySize(pair));
   ArrayResize(bbw_handle,ArraySize(pair));
   ArrayResize(Ichi_handle,ArraySize(pair));
   ArrayResize(rsiDiv_handle,ArraySize(pair));
   ArrayResize(time0,ArraySize(pair));
   ArrayResize(sar_handle,ArraySize(pair));
//---
   for(int i=0; i<ArraySize(pair); i++)
     {
      s_ma_handle[i]=iMA(pair[i],MA1_tf,MA1_per,0,MA1_method,MA1_price);
      if(s_ma_handle[i]<0)
        {
         Print("The iMA object is not created: Error",GetLastError());
         return(-1);
        }
      //---
      d_fma_handle[i]=iMA(pair[i],MA2_tf,MA2_per,0,MA2_method,MA2_price);
      if(d_fma_handle[i]<0)
        {
         Print("The iMA object is not created: Error",GetLastError());
         return(-1);
        }
      //---
      d_sma_handle[i]=iMA(pair[i],MA3_tf,MA3_per,0,MA3_method,MA3_price);
      if(d_sma_handle[i]<0)
        {
         Print("The iMA object is not created: Error",GetLastError());
         return(-1);
        }
      //---
      st_handle[i]=iCustom(pair[i],st_tf,"supertrend",st_per,st_mult,false);
      if(st_handle[i]<0)
        {
         Print("The iCustom::Supertrend object is not created: Error",GetLastError());
         return(-1);
        }
      //---
      storsi_handle[i]=iRSI(pair[i],storsi_tf,int((storsi1_per+storsi2_per)/2),PRICE_CLOSE);
      if(storsi_handle[i]<0)
        {
         Print("The iCustom::irsi object is not created: Error",GetLastError());
         return(-1);
        }
      //---
      sto_handle[i]=iStochastic(pair[i],sto_tf,sto_kper,sto_dper,sto_sper,MODE_SMA,STO_LOWHIGH);
      if(sto_handle[i]<0)
        {
         Print("The iStochastic object is not created: Error",GetLastError());
         return(-1);
        }
      //---
      mac_handle[i]=iMACD(pair[i],mac_tf,mac_fper,mac_sper,mac_smper,PRICE_CLOSE);
      if(mac_handle[i]<0)
        {
         Print("The iMACD object is not created: Error",GetLastError());
         return(-1);
        }
      //---
      adx_handle[i]=iADX(pair[i],adx_tf,adx_per);
      if(adx_handle[i]<0)
        {
         Print("The iADX object is not created: Error",GetLastError());
         return(-1);
        }
      //---
      atr_handle[i]=iADX(pair[i],atr_tf,atr_per);
      if(atr_handle[i]<0)
        {
         Print("The iATR object is not created: Error",GetLastError());
         return(-1);
        }
      //---
      rsi_handle[i]=iRSI(pair[i],rsi_tf,rsi_per,PRICE_CLOSE);
      if(rsi_handle[i]<0)
        {
         Print("The iRSI object is not created: Error",GetLastError());
         return(-1);
        }
      //---
      bb_handle[i]=iBands(pair[i],bb_tf,BB_per,0,BB_dev,PRICE_CLOSE);
      if(bb_handle[i]<0)
        {
         Print("The iBands object is not created: Error",GetLastError());
         return(-1);
        }
      //---
      bbw_handle[i]=iCustom(pair[i],bbw_tf,"bbandwidth",BB_per,0,BB_dev);
      if(bbw_handle[i]<0)
        {
         Print("The Custom::iBands object is not created: Error",GetLastError());
         return(-1);
        }
      //---
      Ichi_handle[i]=iIchimoku(pair[i],Ichi_tf,tekan,kijun,senkou);
      if(Ichi_handle[i]<0)
        {
         Print("The iIchimoku object is not created: Error",GetLastError());
         return(-1);
        }
      //---
      rsiDiv_handle[i]=iCustom(pair[i],RsiDiv_tf,"rsi-divergence-indicator",RsiDiv_per);
      if(rsiDiv_handle[i]<0)
        {
         Print("The Custom::irsi_divergence object is not created: Error",GetLastError());
         return(-1);
        }
      sar_handle[i]=iSAR(pair[i],sar_tf,sar_step,sar_max);
      if(sar_handle[i]<0)
        {
         Print("The iSAR object is not created: Error",GetLastError());
         return(-1);
        }
     }
   Initialize();
   cc0="Started Successfuly!";
   EventSetTimer(3);
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   EventKillTimer();
   appDialog.Destroy(reason);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   run();
  }

//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer(void)
  {
//---
   run();
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void run()
  {
   for(int i=0; i<ArraySize(pair); i++)
     {
      double countb=0,counts=0,countf=0;
      //--
      if(sig_SingleMA(i)==1)
        {
         if(useSingleMA)countb++;
         lbl_SingleMA[i+1].Text("B");
         lbl_SingleMA[i+1].Color(clrLime);
        }
      else
         if(sig_SingleMA(i)==-1)
           {
            if(useSingleMA)counts++;
            lbl_SingleMA[i+1].Text("S");
            lbl_SingleMA[i+1].Color(clrMaroon);
           }
         else
           {
            if(useSingleMA)countf++;
            lbl_SingleMA[i+1].Text("--");
            lbl_SingleMA[i+1].Color(clrDarkSlateGray);
           }
      //--
      if(sig_DoubleMA(i)==1)
        {
         if(useDoubleMA)countb++;
         lbl_DoubleMA[i+1].Text("B");
         lbl_DoubleMA[i+1].Color(clrLime);
        }
      else
         if(sig_DoubleMA(i)==-1)
           {
            if(useDoubleMA)counts++;
            lbl_DoubleMA[i+1].Text("S");
            lbl_DoubleMA[i+1].Color(clrMaroon);
           }
         else
           {
            if(useDoubleMA)countf++;
            lbl_DoubleMA[i+1].Text("--");
            lbl_DoubleMA[i+1].Color(clrDarkSlateGray);
           }
      //--
      if(sig_Supertrend(i)==1)
        {
         if(useSuperTrend)countb++;
         lbl_Supertrend[i+1].Text("B");
         lbl_Supertrend[i+1].Color(clrLime);
        }
      else
         if(sig_Supertrend(i)==-1)
           {
            if(useSuperTrend)counts++;
            lbl_Supertrend[i+1].Text("S");
            lbl_Supertrend[i+1].Color(clrMaroon);
           }
         else
           {
            if(useSuperTrend)countf++;
            lbl_Supertrend[i+1].Text("--");
            lbl_Supertrend[i+1].Color(clrDarkSlateGray);
           }
      //--
      if(sig_STORSI(i)==1)
        {
         if(useStoRSI)countb++;
         lbl_STORSI[i+1].Text("B");
         lbl_STORSI[i+1].Color(clrLime);
        }
      else
         if(sig_STORSI(i)==-1)
           {
            if(useStoRSI)counts++;
            lbl_STORSI[i+1].Text("S");
            lbl_STORSI[i+1].Color(clrMaroon);
           }
         else
           {
            if(useStoRSI)countf++;
            lbl_STORSI[i+1].Text("--");
            lbl_STORSI[i+1].Color(clrDarkSlateGray);
           }
      //--
      if(sig_STO(i)==1)
        {
         if(useSto)countb++;
         lbl_STO[i+1].Text("B");
         lbl_STO[i+1].Color(clrLime);
        }
      else
         if(sig_STO(i)==-1)
           {
            if(useSto)counts++;
            lbl_STO[i+1].Text("S");
            lbl_STO[i+1].Color(clrMaroon);
           }
         else
           {
            if(useSto)countf++;
            lbl_STO[i+1].Text("--");
            lbl_STO[i+1].Color(clrDarkSlateGray);
           }
      //--
      if(sig_MACD(i)==1)
        {
         if(useMacd)countb++;
         lbl_MACD[i+1].Text("B");
         lbl_MACD[i+1].Color(clrLime);
        }
      else
         if(sig_MACD(i)==-1)
           {
            if(useMacd)counts++;
            lbl_MACD[i+1].Text("S");
            lbl_MACD[i+1].Color(clrMaroon);
           }
         else
           {
            if(useMacd)countf++;
            lbl_MACD[i+1].Text("--");
            lbl_MACD[i+1].Color(clrDarkSlateGray);
           }
      //--
      if(sig_ADX(i)==1)
        {
         if(useAdx)countb++;
         lbl_ADX[i+1].Text("B");
         lbl_ADX[i+1].Color(clrLime);
        }
      else
         if(sig_ADX(i)==-1)
           {
            if(useAdx)counts++;
            lbl_ADX[i+1].Text("S");
            lbl_ADX[i+1].Color(clrMaroon);
           }
         else
           {
            if(useAdx)countf++;
            lbl_ADX[i+1].Text("--");
            lbl_ADX[i+1].Color(clrDarkSlateGray);
           }
      //--
      if(sig_ATR(i)==1)
        {
         if(useAtr)countb++;
         lbl_ATR[i+1].Text("B");
         lbl_ATR[i+1].Color(clrLime);
        }
      else
         if(sig_ATR(i)==-1)
           {
            if(useAtr)counts++;
            lbl_ATR[i+1].Text("S");
            lbl_ATR[i+1].Color(clrMaroon);
           }
         else
           {
            if(useAtr)countf++;
            lbl_ATR[i+1].Text("--");
            lbl_ATR[i+1].Color(clrDarkSlateGray);
           }
      //--
      if(sig_RSI(i)==1)
        {
         if(useRSI)countb++;
         lbl_RSI[i+1].Text("B");
         lbl_RSI[i+1].Color(clrLime);
        }
      else
         if(sig_RSI(i)==-1)
           {
            if(useRSI)counts++;
            lbl_RSI[i+1].Text("S");
            lbl_RSI[i+1].Color(clrMaroon);
           }
         else
           {
            if(useRSI)countf++;
            lbl_RSI[i+1].Text("--");
            lbl_RSI[i+1].Color(clrDarkSlateGray);
           }
      //--
      if(sig_BB(i)==1)
        {
         if(useBB)countb++;
         lbl_BB[i+1].Text("B");
         lbl_BB[i+1].Color(clrLime);
        }
      else
         if(sig_BB(i)==-1)
           {
            if(useBB)counts++;
            lbl_BB[i+1].Text("S");
            lbl_BB[i+1].Color(clrMaroon);
           }
         else
           {
            if(useBB)countf++;
            lbl_BB[i+1].Text("--");
            lbl_BB[i+1].Color(clrDarkSlateGray);
           }
      //--
      if(sig_BBw(i)==1)
        {
         if(useBBw)countb++;
         lbl_BBW[i+1].Text("B");
         lbl_BBW[i+1].Color(clrLime);
        }
      else
         if(sig_BBw(i)==-1)
           {
            if(useBBw)counts++;
            lbl_BBW[i+1].Text("S");
            lbl_BBW[i+1].Color(clrMaroon);
           }
         else
           {
            if(useBBw)countf++;
            lbl_BBW[i+1].Text("--");
            lbl_BBW[i+1].Color(clrDarkSlateGray);
           }
      //--
      if(sig_RSI_DIV(i)==1)
        {
         if(useRsiDiv)countb++;
         lbl_RSIDIV[i+1].Text("B");
         lbl_RSIDIV[i+1].Color(clrLime);
        }
      else
         if(sig_RSI_DIV(i)==-1)
           {
            if(useRsiDiv)counts++;
            lbl_RSIDIV[i+1].Text("S");
            lbl_RSIDIV[i+1].Color(clrMaroon);
           }
         else
           {
            if(useRsiDiv)countf++;
            lbl_RSIDIV[i+1].Text("--");
            lbl_RSIDIV[i+1].Color(clrDarkSlateGray);
           }
      //--
      if(sig_ICHI(i)==1)
        {
         if(useIchi)countb++;
         lbl_ICHI[i+1].Text("B");
         lbl_ICHI[i+1].Color(clrLime);
        }
      else
         if(sig_ICHI(i)==-1)
           {
            if(useIchi)counts++;
            lbl_ICHI[i+1].Text("S");
            lbl_ICHI[i+1].Color(clrMaroon);
           }
         else
           {
            if(useIchi)countf++;
            lbl_ICHI[i+1].Text("--");
            lbl_ICHI[i+1].Color(clrDarkSlateGray);
           }
      //--
      if(sig_SAR(i)==1)
        {
         if(useSAR)countb++;
         lbl_SAR[i+1].Text("B");
         lbl_SAR[i+1].Color(clrLime);
        }
      else
         if(sig_SAR(i)==-1)
           {
            if(useSAR)counts++;
            lbl_SAR[i+1].Text("S");
            lbl_SAR[i+1].Color(clrMaroon);
           }
         else
           {
            if(useSAR)countf++;
            lbl_SAR[i+1].Text("--");
            lbl_SAR[i+1].Color(clrDarkSlateGray);
           }
      double perc_b=(countb/(countb+countf+counts))*100;    
      double perc_s=(counts/(countb+countf+counts))*100;
      //--
      if(perc_b>perc_s)
        {
         lbl_perc[i+1].Text(DoubleToString(perc_b,2)+"%");
         lbl_perc[i+1].Color(clrBlue);
        }
      else
         if(perc_b<perc_s)
           {
            lbl_perc[i+1].Text(DoubleToString(perc_s,2)+"%");
            lbl_perc[i+1].Color(clrRed);
           }
         else
           {
            lbl_perc[i+1].Text("--");
            lbl_perc[i+1].Color(clrDarkSlateGray);
           }
           
      bool buy=(perc_b==100);
      bool sell=(perc_s==100);

      if(buy)
        {
         double temp[],temp1[];
         ArraySetAsSeries(temp,true);
         if(CopyBuffer(sar_handle[i],0,0,10,temp)<=0)
            return;
         ArraySetAsSeries(temp1,true);
         if(CopyBuffer(st_handle[i],0,0,10,temp1)<=0)
            return;
         double sl=0;
         if(sltype==0)
            sl=SymbolInfoDouble(pair[i],SYMBOL_ASK)-sl_pips*SymbolInfoDouble(pair[i],SYMBOL_POINT)*10;
         if(sltype==1)
            sl=temp[1];
         if(sltype==2)
            sl=temp1[1];
         cc0=pair[i]+" BUY SL "+DoubleToString(sl,SymbolInfoInteger(pair[i],SYMBOL_DIGITS));
        }
      if(sell)
        {
         double temp[],temp1[];
         ArraySetAsSeries(temp,true);
         if(CopyBuffer(sar_handle[i],0,0,10,temp)<=0)
            return;
         ArraySetAsSeries(temp1,true);
         if(CopyBuffer(st_handle[i],0,0,10,temp1)<=0)
            return;
         double sl=0;
         if(sltype==0)
            sl=SymbolInfoDouble(pair[i],SYMBOL_BID)+sl_pips*SymbolInfoDouble(pair[i],SYMBOL_POINT)*10;
         if(sltype==1)
            sl=temp[1];
         if(sltype==2)
            sl=temp1[1];
         cc0=pair[i]+" SELL SL "+DoubleToString(sl,SymbolInfoInteger(pair[i],SYMBOL_DIGITS));
        }
      //---
      if(useTel && cc0!="" && time0[i]!=iTime(_Symbol,PERIOD_CURRENT,0))
        {
         time0[i]=iTime(_Symbol,PERIOD_CURRENT,0);
         if(getme_result!=0)
           {
            Print("Error : ",(getme_result));
            continue;
           }
         //--- popup alerts
         if(useAlerts)Alert(cc0);
         //--- reading messages
         bot.GetUpdates();
         //--- processing messages
         bot.ProcessMessages(cc0);
        }
     }
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
   appDialog.OnEvent(id,lparam,dparam,sparam);
  }

string cc0="";
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsSymbol(string symbol)
  {
   if((SymbolInfoDouble(symbol, SYMBOL_BID)==4106)||(SymbolInfoDouble(symbol, SYMBOL_BID)==4051)||(SymbolInfoDouble(symbol, SYMBOL_BID)==4024)||(SymbolInfoDouble(symbol, SYMBOL_BID)==0))
      return false;

   return true;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_SAR(int index)
  {
   int res=0;
   double temp[];
   ArraySetAsSeries(temp,true);
   if(CopyBuffer(sar_handle[index],0,0,10,temp)<=0)
      return res;
   if(iClose(pair[index],PERIOD_CURRENT,0)>temp[0])
      res=1;
   if(iClose(pair[index],PERIOD_CURRENT,0)<temp[0])
      res=-1;
   return res;
  }
  
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_SingleMA(int index)
  {
   int res=0;
   double temp[];
   ArraySetAsSeries(temp,true);
   if(CopyBuffer(s_ma_handle[index],0,0,10,temp)<=0)
      return res;
   if(iClose(pair[index],PERIOD_CURRENT,0)>temp[0])
      res=1;
   if(iClose(pair[index],PERIOD_CURRENT,0)<temp[0])
      res=-1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_DoubleMA(int index)
  {
   int res=0;
   double temp1[],temp2[];
   ArraySetAsSeries(temp1,true);
   ArraySetAsSeries(temp2,true);
   if(CopyBuffer(d_fma_handle[index],0,0,10,temp1)<=0)
      return res;
   if(CopyBuffer(d_sma_handle[index],0,0,10,temp2)<=0)
      return res;
   if(temp1[0]>temp2[0])
      res=1;
   if(temp1[0]<temp2[0])
      res=-1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_Supertrend(int index)
  {
   int res=0;
   double temp1[];
   ArraySetAsSeries(temp1,true);
   if(CopyBuffer(st_handle[index],2,0,10,temp1)<=0)
      return res;
   if(temp1[0]<=iClose(pair[index],st_tf,0))
      res=1;
   if(temp1[0]>=iClose(pair[index],st_tf,0))
      res=-1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_STORSI(int index)
  {
   int res=0;
   double temp1[];
   ArraySetAsSeries(temp1,true);
   if(CopyBuffer(storsi_handle[index],0,0,10,temp1)<=0)
      return res;
   if(temp1[0]>=50)
      res=1;
   if(temp1[0]<=50)
      res=-1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_RSI(int index)
  {
   int res=0;
   double temp1[];
   ArraySetAsSeries(temp1,true);
   if(CopyBuffer(rsi_handle[index],0,0,10,temp1)<=0)
      return res;
   if(temp1[0]>=rsi_level)
      res=1;
   if(temp1[0]<=rsi_level)
      res=-1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_STO(int index)
  {
   int res=0;
   double temp1[];
   double temp2[];
   ArraySetAsSeries(temp1,true);
   ArraySetAsSeries(temp2,true);
   if(CopyBuffer(sto_handle[index],MAIN_LINE,0,10,temp1)<=0)
      return res;
   if(CopyBuffer(sto_handle[index],SIGNAL_LINE,0,10,temp2)<=0)
      return res;
   if(temp1[0]>temp2[0])
      res=1;
   if(temp1[0]<temp2[0])
      res=-1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_MACD(int index)
  {
   int res=0;
   double temp1[];
   ArraySetAsSeries(temp1,true);
   if(CopyBuffer(mac_handle[index],0,0,10,temp1)<=0)
      return res;
   if(temp1[0]>0)
      res=1;
   if(temp1[0]<0)
      res=-1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_ADX(int index)
  {
   int res=0;
   double temp1[];
   double temp2[];
   double temp3[];
   ArraySetAsSeries(temp1,true);
   ArraySetAsSeries(temp2,true);
   ArraySetAsSeries(temp3,true);
   if(CopyBuffer(adx_handle[index],PLUSDI_LINE,0,10,temp1)<=0)
      return res;
   if(CopyBuffer(adx_handle[index],MINUSDI_LINE,0,10,temp2)<=0)
      return res;
   if(CopyBuffer(adx_handle[index],MAIN_LINE,0,10,temp3)<=0)
      return res;
   if(temp1[0]>temp2[0] && temp3[0]>=adx_lev)
      res=1;
   if(temp1[0]<temp2[0] && temp3[0]>=adx_lev)
      res=-1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_ATR(int index)
  {
   int res=0;
   double temp1[];
   ArraySetAsSeries(temp1,true);
   if(CopyBuffer(atr_handle[index],0,0,10,temp1)<=0)
      return res;
   if(temp1[0]>temp1[1] && temp1[1]>temp1[2])
      res=1;
   if(temp1[0]<temp1[1] && temp1[1]<temp1[2])
      res=-1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_BB(int index)
  {
   int res=0;
   double temp1[];
   ArraySetAsSeries(temp1,true);
   if(CopyBuffer(bb_handle[index],0,0,10,temp1)<=0)
      return res;
   if(temp1[0]<iClose(pair[index],st_tf,0))
      res=1;
   if(temp1[0]>iClose(pair[index],st_tf,0))
      res=-1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_BBw(int index)
  {
   int res=0;
   double temp1[];
   ArraySetAsSeries(temp1,true);
   if(CopyBuffer(bbw_handle[index],0,0,10,temp1)<=0)
      return res;
   if(temp1[0]>temp1[1] && temp1[1]>temp1[2])
      res=1;
   if(temp1[0]<temp1[1] && temp1[1]<temp1[2])
      res=-1;
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_RSI_DIV(int index)
  {
   int res=0;
   double temp1[];
   double temp2[];
   ArraySetAsSeries(temp1,true);
   ArraySetAsSeries(temp2,true);
   if(CopyBuffer(rsiDiv_handle[index],0,0,500,temp1)<=0)
      return res;
   if(CopyBuffer(rsiDiv_handle[index],1,0,500,temp2)<=0)
      return res;
   for(int i=0; i<500; i++)
     {
      if(temp1[i]>0 && temp1[i]!=EMPTY_VALUE)
         return 1;
      if(temp2[i]>0 && temp2[i]!=EMPTY_VALUE)
         return -1;
     }
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int sig_ICHI(int index)
  {
   int res=0;
   double temp1[];
   double temp2[];
   ArraySetAsSeries(temp1,true);
   ArraySetAsSeries(temp2,true);
   if(CopyBuffer(Ichi_handle[index],SENKOUSPANA_LINE,0,10,temp1)<=0)
      return res;
   if(CopyBuffer(Ichi_handle[index],SENKOUSPANB_LINE,0,10,temp2)<=0)
      return res;

   if(iClose(pair[index],Ichi_tf,0)>MathMax(temp1[0],temp2[0]))
      return 1;
   if(iClose(pair[index],Ichi_tf,0)<MathMin(temp1[0],temp2[0]))
      return -1;

   return res;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool isExpired()
  {
   if(date0 > 0)
     {
      if(TimeCurrent() > date0)
        {
         string text = "License Expired, Contact Seller: austoe6@gmail.com";
         Alert(text);
         Comment(text);
         return true;
        }
     }
   return false;
  }
//+------------------------------------------------------------------+
