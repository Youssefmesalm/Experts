//+------------------------------------------------------------------+
//|                                                     Cycle EA.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#define BUTTON_NAME3 "CloseAllOrders"
#define BUTTON_NAME2 "NewCycle"

extern string   General_Settings   = "------< General_Settings >------";
input double Lots =0.1;
input int takeprofit=300;
input int stoploss=200;
input int MagicNumber =121221;
input int Maximum_Order = 10;

extern string   Multiple_SetUP   = "------< Multiple_SetUP >------";
input bool UseMultiple= true;
input int Multi = 2;

extern string   Money_Management_Settings   = "------< Money_Management_Settings >------";
input bool Money_Management = true;

extern string   Strategy_type_Settings   = "------< Strategy_type_Settings >------";
enum Order {AUTO,MANUAL};
input Order Strategy_type=AUTO;

extern string   RSI_SetUP   = "------< RSI_SetUP >------";
input bool UseRSI= true;
input int RSI_Period = 14;
input ENUM_APPLIED_PRICE RSI_price = PRICE_CLOSE;
input int RSI_High_Value = 70;
input int RSI_Low_Value = 30;
extern string   Stochastic_SetUP   = "------< Stochastic_SetUP >------";
input bool UseStochastic= true;
input int K_Period = 5;
input int D_Period= 3;
input int Slowing =3;
input ENUM_MA_METHOD Stochastic_Method = MODE_SMA;
input ENUM_STO_PRICE Stochastic_price = STO_CLOSECLOSE;
input int STO_High_Value = 80;
input int STO_Low_Value = 20;

extern string   MA_SetUP   = "------< MA_SetUP >------";
input bool UseMA= true;
input int period = 13;
input ENUM_MA_METHOD MA_Method = MODE_SMA;
input ENUM_APPLIED_PRICE MA_price = PRICE_CLOSE;

extern string   Time_SetUP   = "------< Time_SetUP >------";
input bool UseTimeFilter=true;
input string StartTime="10:00";
input string EndTime="23:00";

extern string   Trailing_SetUP   = "------< Trailing_SetUP >------";
extern bool     Use_Trailing     = false;
extern int      TrailingStop     = 300;
extern int      TrailingStep     = 100;


double TrailingProfit =0;
double pt = 1;
double MyPoint;
datetime Lasttradetime =0;
double sl, tp,NewLots;
int z=0;
int x=1;
int y=0;
int xx=0;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   if(Digits==4 || Digits<=2)
      MyPoint=Point;
   if(Digits==3 || Digits<=5)
      MyPoint=Point*10;
   Button(BUTTON_NAME3,OBJ_BUTTON,0,1040,25,200,50,"CloseBuy",13,clrWhite,clrGreen);
   Button(BUTTON_NAME2,OBJ_BUTTON,0,1040,70,200,50,"New Cycle",13,clrWhite,clrGoldenrod);
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
   Comment(GetLastOrderProfit());

   Button("A",OBJ_BUTTON,0,60,50,60,30,"Pair",8,clrBlack,clrWhite);
   Button("aa",OBJ_BUTTON,0,120,50,60,30,"",6,clrBlack,clrWhite);
   Button("t",OBJ_BUTTON,0,180,50,60,30,"Buy Lot",7,clrBlack,clrWhite);
   Button("qa",OBJ_BUTTON,0,240,50,60,30,"Sell Lot",8,clrBlack,clrWhite);
   Button("qnb",OBJ_BUTTON,0,300,50,60,30,"Buy Profit",8,clrBlack,clrWhite);
   Button("aq",OBJ_BUTTON,0,360,50,60,30,"Sell Profit",8,clrBlack,clrWhite);
   Button("Aa",OBJ_BUTTON,0,60,80,60,30,Symbol(),6,clrBlack,clrWhite);
   Button("aaa",OBJ_BUTTON,0,120,80,60,30,"",6,clrBlack,clrWhite);
   Button("ta",OBJ_BUTTON,0,180,80,60,30,DoubleToStr(LotBuy(),2),7,clrBlack,clrWhite);
   Button("qaa",OBJ_BUTTON,0,240,80,60,30,DoubleToStr(LotSell(),2),8,clrBlack,clrWhite);
   Button("qnba",OBJ_BUTTON,0,300,80,60,30,DoubleToStr(BuyProfit(),2),8,clrBlack,clrWhite);
   Button("aqa",OBJ_BUTTON,0,360,80,60,30,DoubleToStr(SellProfit(),2),8,clrBlack,clrWhite);

   double ma =iMA(Symbol(),0,period,0,MA_Method,MA_price,1);
   double sto=  iStochastic(Symbol(),0,K_Period,D_Period,Slowing,Stochastic_Method, Stochastic_price,0,1);
   double RSI = iRSI(Symbol(),0,RSI_Period,RSI_price,1);

   if(Strategy_type==AUTO && z!=1)
     {
      if((UseMA && Close[1]<ma &&Open[1]<ma && UseStochastic&& sto>STO_High_Value)||(UseStochastic &&sto>STO_High_Value && UseRSI && RSI>RSI_High_Value) ||(UseMA &&UseRSI && Close[1]<ma &&Open[1]<ma && RSI>RSI_High_Value))
        {
         if(Lasttradetime!=Time[0] && OrdersTotal()==0)
           {
            if(stoploss==0)
              {
               sl=0;
              }
            else
              {
               sl= Bid+stoploss*Point;
              }
            if(takeprofit==0)
              {
               tp=0;
              }
            else
              {
               tp= Bid-takeprofit*Point;
              }
            if(Money_Management)
               NewLots=money_Management();
            else
               NewLots=Lots;

            OrderSend(Symbol(),OP_SELL,NewLots,Bid,30,sl,tp,"",MagicNumber,0,clrRed);
            Lasttradetime =Time[0];
            z++;
           }
        }
      if((Close[1]>ma &&Open[1]>ma && sto<STO_Low_Value)||(sto<STO_Low_Value && RSI<RSI_Low_Value) ||(Close[1]>ma &&Open[1]>ma && RSI<RSI_Low_Value))
        {
         if(Lasttradetime!=Time[0])
           {
            if(stoploss==0)
              {
               sl=0;
              }
            else
              {
               sl= Ask-stoploss*Point;
              }
            if(takeprofit==0)
              {
               tp=0;
              }
            else
              {
               tp= Ask+takeprofit*Point;
              }
            if(Money_Management)
               NewLots=money_Management();
            else
               NewLots=Lots;
            OrderSend(Symbol(),OP_BUY,NewLots,Ask,30,sl,tp,"",MagicNumber,0,clrBlue);
            Lasttradetime =Time[0];
            z++;
           }
        }

     }

   if(UseTimeFilter && TimeFilter(StartTime,EndTime)==true || x!=1)
     {
      if(x==10)
        {
         x=1;
         y=1;
        }
      if(Maximum_Order>=x && xx==0)
        {
         if(GetLastOrderProfit()>0)
           {
            if(stoploss==0)
              {
               sl=0;
              }
            else
              {
               sl= Ask-stoploss*Point;
              }
            if(takeprofit==0)
              {
               tp=0;
              }
            else
              {
               tp= Ask+takeprofit*Point;
              }
            if(x==1 && y==1)
              {
               if(Money_Management)
                  NewLots=money_Management();
               else
                  NewLots=Lots;
               OrderSend(Symbol(),OP_BUY,NewLots,Ask,30,sl,tp,"",MagicNumber,0,clrBlue);
               y++;
              }
            else
               OrderSend(Symbol(),OP_BUY,GetLastOrderlot(),Ask,30,sl,tp,"",MagicNumber,0,clrBlue);
            x++;
           }
         if(GetLastOrderProfit()<0)
           {
            if(stoploss==0)
              {
               sl=0;
              }
            else
              {
               sl= Bid+stoploss*Point;
              }
            if(takeprofit==0)
              {
               tp=0;
              }
            else
              {
               tp= Bid-takeprofit*Point;
              }
            if(x==1 && y==1)
              {
               if(Money_Management)
                  NewLots=money_Management();
               else
                  NewLots=Lots;
               OrderSend(Symbol(),OP_SELL,NewLots,Bid,30,sl,tp,"",MagicNumber,0,clrRed);
               y++;
              }
            else
               OrderSend(Symbol(),OP_SELL,GetLastOrderlot(),Bid,30,sl,tp,"",MagicNumber,0,clrRed);
            x++;
           }
         if(GetLastOrderProfit()>0)
           {
            if(stoploss==0)
              {
               sl=0;
              }
            else
              {
               sl= Bid+stoploss*Point;
              }
            if(takeprofit==0)
              {
               tp=0;
              }
            else
              {
               tp= Bid-takeprofit*Point;
              }

            if(x==1 && y==1)
              {
               if(Money_Management)
                  NewLots=money_Management();
               else
                  NewLots=Lots;
               OrderSend(Symbol(),OP_SELL,NewLots,Bid,30,sl,tp,"",MagicNumber,0,clrRed);
               y++;
              }
            else
               OrderSend(Symbol(),OP_SELL,NormalizeDouble(GetLastOrderlot()*Multi,2),Bid,30,sl,tp,"",MagicNumber,0,clrRed);
            x++;
           }
         if(GetLastOrderProfit()<0)
           {
            if(stoploss==0)
              {
               sl=0;
              }
            else
              {
               sl= Ask-stoploss*Point;
              }
            if(takeprofit==0)
              {
               tp=0;
              }
            else
              {
               tp= Ask+takeprofit*Point;
              }
            if(x==1 && y==1)
              {
               if(Money_Management)
                  NewLots=money_Management();
               else
                  NewLots=Lots;
               OrderSend(Symbol(),OP_BUY,NewLots,Ask,30,sl,tp,"",MagicNumber,0,clrBlue);
               y++;
              }
            else
               OrderSend(Symbol(),OP_BUY,NormalizeDouble(GetLastOrderlot()*Multi,2),Ask,30,sl,tp,"",MagicNumber,0,clrBlue);
            x++;
           }
        }
     }









   if(Use_Trailing)
     {
      TrailingStopp(Symbol());
     }

  }
//+------------------------------------------------------------------+
void TrailingStopp(string sym)
  {
   for(int i=OrdersTotal()-1; i >= 0; i--)
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
         if(OrderSymbol() == sym &&  OrderMagicNumber()== MagicNumber)
           {
            double takeprofit = OrderTakeProfit();

            if(OrderType() == OP_BUY && iClose(sym,0,0) - OrderOpenPrice() > TrailingStop*pt*MarketInfo(sym,MODE_POINT))
              {
               if((OrderStopLoss() < iClose(sym,0,0)-(TrailingStop+TrailingStep)*pt*MarketInfo(sym,MODE_POINT)) || (OrderStopLoss()==0))
                 {
                  if(TrailingProfit != 0)
                     takeprofit = iClose(sym,0,0)+(TrailingProfit + TrailingStop)*pt*MarketInfo(sym,MODE_POINT);
                  bool ret1 = OrderModify(OrderTicket(), OrderOpenPrice(), iClose(sym,0,0)-TrailingStop*pt*MarketInfo(sym,MODE_POINT), takeprofit,0, White);
                  if(ret1 == false)
                     Print(" OrderModify() error - , ErrorDescription: ",(GetLastError()));
                 }
              }
            if(OrderType() == OP_SELL && OrderOpenPrice() - iClose(sym,0,0) > TrailingStop*pt*MarketInfo(sym,MODE_POINT))
              {
               if((OrderStopLoss() > iClose(sym,0,0)+(TrailingStop+TrailingStep)*pt*MarketInfo(sym,MODE_POINT)) || (OrderStopLoss()==0))
                 {
                  if(TrailingProfit != 0)
                     takeprofit = iClose(sym,0,0)-(TrailingProfit + TrailingStop)*pt*MarketInfo(sym,MODE_POINT);
                  bool ret2 = OrderModify(OrderTicket(), OrderOpenPrice(),iClose(sym,0,0)+TrailingStop*pt*MarketInfo(sym,MODE_POINT), takeprofit, 0, White);
                  if(ret2 == false)
                     Print("OrderModify() error - , ErrorDescription: ",(GetLastError()));
                 }
              }
           }
        }
      else
         Print("OrderSelect() error - , ErrorDescription: ",(GetLastError()));
  }
//+------------------------------------------------------------------+
//|                                                                  |
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
//|                                                                  |
//+------------------------------------------------------------------+
double GetLastOrderProfit()
  {
   double p = 0;
   for(int i=0; i<=OrdersHistoryTotal(); i++)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_HISTORY);

      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber || OrderMagicNumber()==0)
        {
            p = OrderProfit();
        }
     }
   return (p);
  }

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Profit for Sell Orders                                                                |
//+------------------------------------------------------------------+
double SellProfit()
  {
   double p = 0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber || OrderMagicNumber()==0)
        {
         if(OrderType() ==OP_SELL)
           {
            p += OrderProfit()+OrderCommission()+OrderSwap();

           }
        }
     }
   return (p);
  }

//+------------------------------------------------------------------+
//| Profit for Buy Orders                                                                |
//+------------------------------------------------------------------+
double BuyProfit()
  {
   double p = 0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber|| OrderMagicNumber()==0)
        {
         if(OrderType() ==OP_BUY)
           {
            p += OrderProfit()+OrderCommission()+OrderSwap();

           }
        }
     }
   return (p);
  }

//+------------------------------------------------------------------+
//| Lots for Buy Orders                                                                |
//+------------------------------------------------------------------+
double LotBuy()
  {
   double p = 0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber|| OrderMagicNumber()==0)
        {
         if(OrderType() ==OP_BUY)
           {
            p += OrderLots();

           }
        }
     }
   return (p);
  }
//+------------------------------------------------------------------+
//| Lots for Sell Orders                                                                |
//+------------------------------------------------------------------+
double LotSell()
  {
   double p = 0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber|| OrderMagicNumber()==0)
        {
         if(OrderType() ==OP_SELL)
           {
            p += OrderLots();

           }
        }
     }
   return (p);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Button(string name,ENUM_OBJECT type, int CORNER, int XDISTANCE, int YDISTANCE, int XSIZE, int YSIZE,
            string Text, int Fontsize, color FontColor, color Background)
  {
   ObjectCreate(Symbol(),name,type,0,0,0);
   ObjectSetInteger(Symbol(),name,OBJPROP_CORNER,CORNER);
   ObjectSetInteger(Symbol(),name,OBJPROP_XDISTANCE,XDISTANCE);
   ObjectSetInteger(Symbol(),name,OBJPROP_XSIZE,XSIZE);
   ObjectSetInteger(Symbol(),name,OBJPROP_YDISTANCE,YDISTANCE);
   ObjectSetInteger(Symbol(),name,OBJPROP_YSIZE,YSIZE);
   ObjectSetString(Symbol(),name,OBJPROP_TEXT,Text);
   ObjectSetInteger(Symbol(),name,OBJPROP_FONTSIZE,Fontsize);
   ObjectSetInteger(Symbol(),name,OBJPROP_COLOR,FontColor);
   ObjectSetInteger(Symbol(),name,OBJPROP_BGCOLOR,Background);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,         // Event ID
                  const long& lparam,   // Parameter of type long event
                  const double& dparam, // Parameter of type double event
                  const string& sparam  // Parameter of type string events
                 )

  {
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      if(sparam=="NewCycle")
        {
         while(x==1)
           {
            xx++;
           }
        }
      if(sparam=="CloseAllOrders")
        {
         CloseOrder();
        }
     }
  }

//+------------------------------------------------------------------+
void CloseOrder()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {

      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber || OrderMagicNumber()==0)
        {
         if(OrderType() == OP_BUY || OrderType() == OP_SELL)
           {
            OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,Red);
           }
        }

     }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Last Sell Price                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double LastSellPrice()
  {
   double openpricesell;
   for(int i=0; i<=OrdersHistoryTotal(); i++)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_HISTORY);

      if(OrderSymbol()==Symbol() && (OrderMagicNumber()==MagicNumber || OrderMagicNumber()==0)  && OrderType() ==OP_SELL)
        {
         openpricesell =OrderOpenPrice();
        }
     }
   return (openpricesell);
  }



//+------------------------------------------------------------------+
//| Last Buy Price                                                                   |
//+------------------------------------------------------------------+
double LastBuyPrice()
  {
   double openpriceBuy;
   for(int i=0; i<=OrdersHistoryTotal(); i++)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_HISTORY);

      if(OrderSymbol()==Symbol() && (OrderMagicNumber()==MagicNumber || OrderMagicNumber()==0)  && OrderType() ==0)
        {
         openpriceBuy =OrderOpenPrice();
        }
     }
   return (openpriceBuy);
  }

//+------------------------------------------------------------------+
double GetLastOrderlot()
  {
   for(int i=0; i<=OrdersHistoryTotal(); i++)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_HISTORY);
      if(OrderSymbol()==Symbol()&& (OrderMagicNumber()== MagicNumber || OrderMagicNumber()==0))
        {

         return(OrderLots());
        }
     }
   return(-1);
  }
//+------------------------------------------------------------------+
double money_Management()
  {
   double LotSize = AccountBalance()/100000;

   return(LotSize);
  }
//+------------------------------------------------------------------+
