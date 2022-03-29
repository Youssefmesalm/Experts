//+------------------------------------------------------------------+
//|                                                   Pip Seeker.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

extern string   General_Settings   = "------< General_Settings >------";
input double Lots =0.1;
input int TakeProfit=0;
input int StopLoss=0;
input int MagicNumber =121221;
input bool Strategy_S1=true;
input bool Strategy_S2=True;
input int TackeProfit_S2=5;
input bool Strategy_S3=True;

extern string   MA1_SetUP   = "------< MA1_SetUP >------";
input ENUM_TIMEFRAMES Time1 = PERIOD_M5;
input int period1 = 8;
input ENUM_MA_METHOD MA_Method1 = MODE_EMA;
input ENUM_APPLIED_PRICE MA_price1 = PRICE_CLOSE;

extern string   MA2_SetUP   = "------< MA2_SetUP >------";
input ENUM_TIMEFRAMES Time2 = PERIOD_M5;
input int period2 = 21;
input ENUM_MA_METHOD MA_Method2 = MODE_EMA;
input ENUM_APPLIED_PRICE MA_price2 = PRICE_CLOSE;

extern string   MA3_SetUP   = "------< MA3_SetUP >------";
input ENUM_TIMEFRAMES Time3 = PERIOD_M5;
input int period3 = 50;
input ENUM_MA_METHOD MA_Method3 = MODE_SMA;
input ENUM_APPLIED_PRICE MA_price3 = PRICE_CLOSE;

extern string   Stochastic1_SetUP   = "------< Stochastic1_SetUP >------";
input int K_Period1 = 33;
input int D_Period1= 1;
input int Slowing1 =11;
input ENUM_TIMEFRAMES STO_Time1 = PERIOD_M5;
input ENUM_MA_METHOD Stochastic_Method1 = MODE_SMA;
input ENUM_STO_PRICE Stochastic_price1 = STO_CLOSECLOSE;

extern string   Stochastic2_SetUP   = "------< Stochastic2_SetUP >------";
input int K_Period2 = 11;
input int D_Period2= 1;
input int Slowing2 =1;
input ENUM_TIMEFRAMES STO_Time2 = PERIOD_M5;
input ENUM_MA_METHOD Stochastic_Method2 = MODE_SMA;
input ENUM_STO_PRICE Stochastic_price2 = STO_CLOSECLOSE;


input double STO_Value1 = 61.8;
input double STO_Value2 = 38.2;
input double STO_Value3 = 50;
input double STO_Value4 = 56;
input double STO_Value5 = 44;


datetime Lasttradetime =0;
datetime Lasttradetime1 =0;
datetime Lasttradetime2 =0;

datetime Lasttime1 =0;
datetime Lasttime2 =0;
datetime Lasttime3 =0;
double sl, tp;
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
   double MA1_1 =iMA(Symbol(),Time1,period1,0,MA_Method1,MA_price1,1);
   double ma2_1 =iMA(Symbol(),Time2,period2,0,MA_Method2,MA_price2,1);
   double ma3_1 =iMA(Symbol(),Time3,period3,0,MA_Method3,MA_price3,1);
   double sto=  iStochastic(Symbol(),STO_Time1,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,0,1);
   double sto_2=  iStochastic(Symbol(),STO_Time1,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,0,2);
   double sto2=  iStochastic(Symbol(),STO_Time2,K_Period2,D_Period2,Slowing2,Stochastic_Method2, Stochastic_price2,0,1);
   double sto2_2=  iStochastic(Symbol(),STO_Time2,K_Period2,D_Period2,Slowing2,Stochastic_Method2, Stochastic_price2,0,2);
   double sto_segnal=  iStochastic(Symbol(),STO_Time1,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,1,1);
   double sto_segnal_2=  iStochastic(Symbol(),STO_Time1,K_Period1,D_Period1,Slowing1,Stochastic_Method1, Stochastic_price1,1,2);
   double sto_segnal2=  iStochastic(Symbol(),STO_Time2,K_Period2,D_Period2,Slowing2,Stochastic_Method2, Stochastic_price2,1,1);


   double spread = MarketInfo(Symbol(),MODE_SPREAD)/10;

   if(Lasttime1!=Time[0])
     {
      if((sto < STO_Value5 && sto2 > STO_Value5)|| (sto > STO_Value5 && sto2 < STO_Value5))
        {
         Alert("The Stochastic has hit the 44 level");
        }
      Lasttime1 =Time[0];
     }

   if(Lasttime2!=Time[0])
     {
      if((sto < STO_Value3 && sto2 > STO_Value3)|| (sto > STO_Value3 && sto2 < STO_Value3))
        {
         Alert("the Stochastic has hit the 50 level");
        }
      Lasttime2 =Time[0];
     }

   if(Lasttime3!=Time[0])
     {
      if((sto < STO_Value4 && sto2 > STO_Value4)|| (sto > STO_Value4 && sto2 < STO_Value4))
        {
         Alert("the Stochastic has hit the 56 level");
        }
      Lasttime3 =Time[0];
     }


   if(Strategy_S1==true)
     {
      if(MA1_1>ma2_1 && High[1]>ma3_1 && Low[1]>ma3_1 && sto>sto_segnal)
        {
         if(countchartBuy()==0)
           {
            OpenBuy();
           }
        }
      if(MA1_1<ma2_1 && High[1]<ma3_1 && Low[1]<ma3_1 && sto<sto_segnal)
        {
         if(countchartSell()==0)
           {
            OpenSell();
           }

        }
     }


   if(Strategy_S2==true)
     {
      if(sto_segnal<STO_Value2 &&((sto>STO_Value3 && sto2<STO_Value3)||(sto<STO_Value3 && sto2>STO_Value3)) &&sto< STO_Value4)
        {
         if(Lasttradetime1!=Time[0])
           {
            int LowestCandle1 = iLowest(Symbol(),0,MODE_LOW,K_Period1,0);
            double Loww1 = Low[LowestCandle1];
            if(countchartBuys2()==0)
              {
               if(OrderSend(Symbol(),OP_BUY,Lots,Ask,30,Loww1,Ask+(spread+TackeProfit_S2)*Point,"BuyS2",MagicNumber,0,clrBlue)==false)
                 {
                  GetLastError();
                 }
              }
            Lasttradetime1 =Time[0];
           }
        }
      if(sto_segnal>STO_Value1 &&((sto<STO_Value3 && sto2>STO_Value3)||(sto>STO_Value3 && sto2<STO_Value3))  &&sto> STO_Value5)
        {
         if(Lasttradetime1!=Time[0])
           {
            int HighestCandle1 = iHighest(Symbol(),0,MODE_HIGH,K_Period1,0);
            double Highh1 = High[HighestCandle1];
            if(countchartSells2()==0)
              {
               if(OrderSend(Symbol(),OP_SELL,Lots,Bid,30,Highh1,Bid-(spread+TackeProfit_S2)*Point,"SellS2",MagicNumber,0,clrRed)==false)
                 {
                  GetLastError();
                 }
              }
            Lasttradetime1 =Time[0];
           }
        }

      if((sto<STO_Value2 && sto_2>STO_Value2)||(sto>STO_Value2 && sto_2<STO_Value2))
        {
         CloseOrderBuyS2();
        }
      if((sto>STO_Value1 && sto_2<STO_Value1) ||(sto<STO_Value1 && sto_2 >STO_Value1))
        {
         CloseOrderSellS2();
        }
     }



   if(Strategy_S3==True)
     {
      if(sto>STO_Value3 &&sto2<STO_Value3 &&sto2_2> STO_Value3)
        {
           {
            if(Lasttradetime2!=Time[0])
              {
               int LowestCandle1 = iLowest(Symbol(),0,MODE_LOW,K_Period1,0);
               double Loww1 = Low[LowestCandle1];
               if(countchartBuys3()==0)
                 {
                  if(TakeProfit==0)
                    {
                     tp=0;
                    }
                  else
                    {
                     tp= Ask+TakeProfit*Point;
                    }
                  if(OrderSend(Symbol(),OP_BUY,Lots,Ask,30,Loww1,tp,"BuyS3",MagicNumber,0,clrBlue)==false)
                    {
                     GetLastError();
                    }
                 }
               Lasttradetime2 =Time[0];
              }
           }
        }
      if(sto<STO_Value3 &&sto2>STO_Value3 &&sto2_2< STO_Value3)
        {
         if(Lasttradetime2!=Time[0])
           {
            int HighestCandle1 = iHighest(Symbol(),0,MODE_HIGH,K_Period1,0);
            double Highh1 = High[HighestCandle1];
            if(countchartSells3()==0)
              {
               if(TakeProfit==0)
                 {
                  tp=0;
                 }
               else
                 {
                  tp= Bid-TakeProfit*Point;
                 }
               if(OrderSend(Symbol(),OP_SELL,Lots,Bid,30,Highh1,tp,"SellS3",MagicNumber,0,clrRed)==false)
                 {
                  GetLastError();
                 }
              }
            Lasttradetime2 =Time[0];
           }
        }
     }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Open Sell Order                                         |
//+------------------------------------------------------------------+
void OpenSell()
  {
   if(Lasttradetime!=Time[0])
     {
      if(StopLoss==0)
        {
         sl=0;
        }
      else
        {
         sl= Bid+StopLoss*Point;
        }
      if(TakeProfit==0)
        {
         tp=0;
        }
      else
        {
         tp= Bid-TakeProfit*Point;
        }
      if(OrderSend(Symbol(),OP_SELL,Lots,Bid,30,sl,tp,"SellS1",MagicNumber,0,clrRed)==false)
        {
         GetLastError();
        }
      Lasttradetime =Time[0];
     }
  }
//+------------------------------------------------------------------+
//| Open Buy Order                                                                 |
//+------------------------------------------------------------------+
void OpenBuy()
  {
   if(Lasttradetime!=Time[0])
     {
      if(StopLoss==0)
        {
         sl=0;
        }
      else
        {
         sl= Ask-StopLoss*Point;
        }
      if(TakeProfit==0)
        {
         tp=0;
        }
      else
        {
         tp= Ask+TakeProfit*Point;
        }

      if(OrderSend(Symbol(),OP_BUY,Lots,Ask,30,sl,tp,"BuyS1",MagicNumber,0,clrBlue)==false)
        {
         GetLastError();
        }
      Lasttradetime =Time[0];
     }
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Close Open Order S2                                                             |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseOrderBuyS2()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {

      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         GetLastError();
        }
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber && OrderComment()=="BuyS2")
        {
         if(OrderType() == OP_BUY)
           {
            if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==false)
              {
               GetLastError();
              }
           }
        }

     }
  }
//+------------------------------------------------------------------+
void CloseOrderSellS2()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {

      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         GetLastError();
        }
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber && OrderComment()=="SellS2")
        {
         if(OrderType() == OP_SELL)
           {
            if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==false)
              {
               GetLastError();
              }
           }
        }

     }
  }
//+------------------------------------------------------------------+
int countchartSell()
  {
   int count =0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
                    {
                     GetLastError();
                    }
      if(OrderSymbol()==Symbol()&& OrderMagicNumber()== MagicNumber && OrderComment()=="SellS1")
        {
         count++;

        }
     }
   return(count);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int countchartBuy()
  {
   int count =0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
                    {
                     GetLastError();
                    }
      if(OrderSymbol()==Symbol()&& OrderMagicNumber()== MagicNumber && OrderComment()=="BuyS1")
        {
         count++;

        }
     }
   return(count);
  }
//+------------------------------------------------------------------+
int countchartSells2()
  {
   int count =0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
                    {
                     GetLastError();
                    }
      if(OrderSymbol()==Symbol()&& OrderMagicNumber()== MagicNumber && OrderComment()=="SellS2")
        {
         count++;

        }
     }
   return(count);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int countchartBuys2()
  {
   int count =0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
                    {
                     GetLastError();
                    }
      if(OrderSymbol()==Symbol()&& OrderMagicNumber()== MagicNumber && OrderComment()=="BuyS2")
        {
         count++;

        }
     }
   return(count);
  }
//+------------------------------------------------------------------+
int countchartSells3()
  {
   int count =0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
                    {
                     GetLastError();
                    }
      if(OrderSymbol()==Symbol()&& OrderMagicNumber()== MagicNumber && OrderComment()=="SellS3")
        {
         count++;

        }
     }
   return(count);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int countchartBuys3()
  {
   int count =0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
                    {
                     GetLastError();
                    }
      if(OrderSymbol()==Symbol()&& OrderMagicNumber()== MagicNumber && OrderComment()=="BuyS3")
        {
         count++;

        }
     }
   return(count);
  }
//+------------------------------------------------------------------+
