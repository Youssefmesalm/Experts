//+------------------------------------------------------------------+
//|                                                  MA index EA.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

extern string              General_Settings                     = "------< General_Settings >------";
input  double              Lots                                 = 0.1;
input  int                 TakeProfit                           = 0;
input  int                 StopLoss                             = 0;
input  int                 MagicNumber                          = 121221;
input  double              Xpip                                 = 3;
extern string              MA1_SetUP                            = "------< MA1_SetUP >------";
input  bool                UseMA1                               = true;
input  int                 period1                              = 8;
input  ENUM_MA_METHOD      MA_Method1                           = MODE_EMA;
input  ENUM_APPLIED_PRICE  MA_price1                            = PRICE_CLOSE;
extern string              MA2_SetUP                            = "------< MA2_SetUP >------";
input  bool                UseMA2                               = true;
input  int                 period2                              = 21;
input  ENUM_MA_METHOD      MA_Method2                           = MODE_EMA;
input  ENUM_APPLIED_PRICE  MA_price2                            = PRICE_CLOSE;
extern string              VSA_support_and_resistance_SetUP     = "------< VSA support and resistance_SetUP >------";
input  bool                Use_VSA_support_and_resistance       = true;
extern string              two_index_lines_SetUP                = "------< two index lines_SetUP >------";
input  bool                Use_two_index_lines                  = true;
input  string              pair2                                = "GBPLFX";
input  string              pair3                                = "AUDLFX";
input  bool                Reverse_Line                         = false;
extern string              Time_SetUP                           = "------< Time_SetUP >------";
input  bool                UseTimeFilter                        = true;
input  string              StartTime                            = "01:00";
input  string              EndTime                              = "23:00";
extern string              Clos_USD_SetUP                       = "------< Clos_USD_SetUP >------";
input bool                 Close_USD                            =true;
input double               Profit_Close                         = 20;
input double               Loss_Close                           = 5000;
input bool                 Close_Pip                            =true;
input double               Profit_Pip                           = 20;
input double               Loss_Pip                             = 5000;


double sl, tp;
int pt;
datetime Lasttradetime =0;
double place;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   if(Digits == 3 || Digits == 5)
      pt = 10;
   else
      pt=1;

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
   if(UseTimeFilter && TimeFilter(StartTime,EndTime)==true)
     {
      double FristPair  =iCustom(Symbol(),0,"3line all index",pair2,pair3,Reverse_Line,1,1);
      double SecondPair  =iCustom(Symbol(),0,"3line all index",pair2,pair3,Reverse_Line,2,1);
      double MA1 =iMA(Symbol(),0,period1,0,MA_Method1,MA_price1,1);
      double MA2 =iMA(Symbol(),0,period2,0,MA_Method2,MA_price2,1);

      if( (Use_two_index_lines &&FristPair>SecondPair) || (MA1>MA2 &&UseMA1&&UseMA2 ) || (NearLine()>0 && High[0]>NearLine() && Close[0]<NearLine() && MathAbs(High[0]-NearLine())>=Xpip*pt*Point && Use_VSA_support_and_resistance))
        {
         if(Lasttradetime!=Time[0]  || place!=NearLine())
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

            if(OrderSend(Symbol(),OP_BUY,Lots,Ask,30,sl,tp,"",MagicNumber,0,clrBlue) ==false)
              {
               GetLastError();
              }
            Lasttradetime =Time[0];
            place=NearLine();
           }
        }
      if((Use_two_index_lines &&FristPair<SecondPair) || (MA1<MA2&&UseMA1&&UseMA2) ||( NearLine()>0 && Low[0]<NearLine() && Close[0]>NearLine() && MathAbs(Low[0]-NearLine())>=Xpip*pt*Point &&Use_VSA_support_and_resistance))
        {
         if(Lasttradetime!=Time[0] || place!=NearLine())
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
            if(OrderSend(Symbol(),OP_SELL,Lots,Bid,30,sl,tp,"",MagicNumber,0,clrRed) ==false)
              {
               GetLastError();
              }
            Lasttradetime =Time[0];
            place=NearLine();

           }
        }
     }
//profit or loss in USD
   if(Close_USD ==true)
     {
      if(ProfitTotal() >=Profit_Close&& ProfitTotal()>0)
        {
         CloseAllOrders();
        }
      if(MathAbs(ProfitTotal()) >=Loss_Close && ProfitTotal()<0)
        {
         CloseAllOrders();
        }

     }

//profit or loss in PIP 
   if(Close_Pip ==true)
     {
      if(pipprofit() >=Profit_Pip && pipprofit()>0)
        {
         CloseAllOrders();

        }
      if(MathAbs(pipprofit()) >=Loss_Pip && pipprofit()<0)
        {
         CloseAllOrders();

        }
     }
  }

//+------------------------------------------------------------------+
//| Time Filter                                                                 |
//+------------------------------------------------------------------+
bool TimeFilter(string ST, string ET)
  {
   datetime Start =StrToTime(TimeToStr(TimeCurrent(),TIME_DATE)+" "+ST);
   datetime End   =StrToTime(TimeToStr(TimeCurrent(),TIME_DATE)+" "+ET);

   if(!(Time[0]>=Start) && (Time[0]<=End))
     {
      return(false);
     }
   return(true);
  }
//+------------------------------------------------------------------+
//| profit Function                                        |
//+------------------------------------------------------------------+
double ProfitTotal()
  {
   double p = 0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
        {
         GetLastError();
        }
      if(OrderSymbol()==Symbol() && OrderMagicNumber()== MagicNumber)
        {

         p +=OrderProfit()+OrderCommission()+OrderSwap();
        }
     }
   return (p);
  }

//+------------------------------------------------------------------+
//|    profit in pip                                                           |
//+------------------------------------------------------------------+
double pipprofit()
  {
   double profits=0;
   for(int i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true)
        {
         GetLastError();
        }
        {
         if(OrderSymbol()==Symbol()&& OrderMagicNumber()== MagicNumber)
           {
            profits += OrderProfit()+OrderSwap()+OrderCommission()/GetPPP(OrderSymbol());;
           }
        }
     }

   return(profits);
  }
//+------------------------------------------------------------------+
//|   Calculate pip                                                               |
//+------------------------------------------------------------------+
double GetPPP(string A)
  {
   double B = (((MarketInfo(A,MODE_TICKSIZE)/MarketInfo(A,MODE_BID))* MarketInfo(A,MODE_LOTSIZE)) * MarketInfo(A,MODE_BID))/10; //For 5 Digit

   return(B);
  }
//+------------------------------------------------------------------+
//|   Near Line                                                               |
//+------------------------------------------------------------------+
double NearLine()
  {
   double Candlle;
   double price;
   string name;
   string a;
   for(int i=0; i<ObjectsTotal(); i++)
     {

      name = ObjectName(i);
      a    = ObjectDescription(name);
      string MN1= StringSubstr(a,0,3);
      int MN = StringFind("MN1",MN1,0);
      string D1= StringSubstr(a,0,2);
      int D = StringFind("D1",D1,0);
      string W1= StringSubstr(a,0,2);
      int W = StringFind("W1",W1,0);
      string H4= StringSubstr(a,0,2);
      int H_4 = StringFind("H4",H4,0);
      if(MN != -1 ||D != -1 ||W != -1 ||H_4 != -1)
        {
         price = ObjectGetDouble(0, name, OBJPROP_PRICE1);
         if((Open[0]>price && Close[0]<price) ||(Open[0]<price && Close[0]>price))
           {
            Candlle = price;
           }
        }
     }
   return (Candlle);
  }


//+------------------------------------------------------------------+
//|   Close Orders                                                               |
//+------------------------------------------------------------------+
void CloseAllOrders()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true)
        {
         GetLastError();
        }
      if(OrderSymbol()==Symbol() &&(OrderMagicNumber()== MagicNumber))
        {
         if(OrderType() == OP_BUY)
           {
            if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==true)
              {
               GetLastError();
              }
           }
         else
            if(OrderType() == OP_SELL)
              {
               if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==true)
                 {
                  GetLastError();
                 }
              }
            else
              {
               if(OrderDelete(OrderTicket(),White)==true)
                 {
                  GetLastError();
                 }
              }
        }
     }
  }
