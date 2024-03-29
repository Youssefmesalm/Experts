//+------------------------------------------------------------------+
//|                                               RiskCalculator.mq4 |
//|                                                     MohamedGamal |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "MohamedGamal"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include <Controls\Dialog.mqh>
#include <Controls/Button.mqh>
#include <Controls/ListView.mqh>
#include <Controls/Panel.mqh>
#include <Controls/Label.mqh>
#include <Controls\ListView.mqh>
#include <Controls\Edit.mqh>
#include <Controls\Picture.mqh>
#include <Controls\Scrolls.mqh>


extern string   General_Settings   = "------< General_Settings >------";
input double Lots =0.1;
input int takeprofit=0;
input int stoploss=0;
input int MagicNumber =789;

extern string   Risk_SetUP   = "------< Risk_SetUP >------";
input bool Money_Management = true;
input int Risk  = 5;
input double Ratio=1;

extern string   partial_close_SetUP   = "------< partial_close_SetUP >------";
input int partial_close_Step= 30;
input int Partial_Lots= 30;

extern string   Half_close_SetUP   = "------< Half_close_SetUP >------";
input int Half_close_Step= 30;

extern string   partial_TP_SetUP   = "------< partial_TP_SetUP >------";
input int partial_TP_Step=50;


extern string   BreakEven_SetUP   = "------< BreakEven_SetUP >------";
input bool UserBreakEven =true;
input int BreakEven= 30;
input int BreakEvenStep= 10;

extern string   Trailing_SetUP   = "------< Trailing_SetUP >------";
extern bool     Use_Trailing     = false;
extern int      TrailingStop     = 50;
extern int      TrailingStep     = 20;

extern string   Time_SetUP   = "------< Time_SetUP >------";
input bool UseTimeFilter=true;
input string StartTime="11:00";
input string EndTime="23:00";

extern string   Close_SetUP   = "------< Close_SetUP >------";
input bool     Use_Close_Profit     = false;
input double Close_USD_profit     = 0.0;
input double Close_USD_Loss     = 0.0;
input double Close_profit     = 0.0;//Close profit %
input double Close_Loss     = 0.0;//Close Loss %

CBmpButton BmpButton1;
CLabel m_risk_label;
CEdit m_risk_edit;
CScrollV Scroll;
CDialog Dialog;
CListView ListView;
CPanel Panel,Panel1,Panel2,Panel3,Panel4;
CLabel Label,Label1,Label2;
CEdit Edit1,Edit2;
CButton Button1,Button2,Button3,Button4,Button5,Button6,Button7,Button8,Button9,Button10;
CPicture Picture1,Picture2,Picture3,Picture4,Picture5,Picture6,Picture7,Picture8;

double TrailingProfit =0;
double NewLots,tp,sl,price,Steps;
double Lasttradetime=0;
double pt = 1;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

   Dialog.Create(0,"                    RISK CALCULATOR",0,5,40,380,560);
   Panel4.Create(0,"Pane4",0,5,63,380,560);
   Panel4.ColorBackground(clrMidnightBlue);
   Panel4.BorderType(BORDER_RAISED);
   /*Scroll.Create(0,"Scrol",0,50,100,100,200);
      Scroll.MinPos(0);
      Scroll.MaxPos(10);
      Scroll.Visible(true);*/
   Picture1.Create(0,"Pictur",0,90,80,0,0);
   Picture1.BmpName("\\Images\\.bmp");
   Label.Create(0,"Label",0,120,80,10,10);
   Label.Text("LOCK IN YOUR RISK");
   Label.Color(clrWhite);
   /*  m_risk_row.Create(0,"risk_row", 0,50,110,100,100);
     m_risk_label.Create(0,  "risk_label", 0,50,110,100,100);
     m_risk_edit.Create(0,  "risk_Edit", 0, 300,110,130,140);
     m_risk_label.Text("% Risk");
     m_risk_label.Color(clrWhite);
     m_risk_row.ColorBackground(Black);
     */
   Label1.Create(0,"Labe2",0,50,110,100,100);
   Label1.Text("% RISK");
   Label1.Color(clrWhite);
   Edit1.Create(0,"Edit1",0,300,110,130,140);
   Edit1.ReadOnly(false);
   Edit1.Text(0);
   Edit1.EditTextChange(0,"Edit1",1);
   Edit1.TextAlign(ALIGN_CENTER);


   Label2.Create(0,"Labe1",0,50,150,100,100);
   Label2.Text("RATIO");
   Label2.Color(clrWhite);
   Edit2.Create(0,"Edit2",0,300,150,130,180);
   Panel.Create(0,"Panel",0,80,190,280,190.5);
   Panel.ColorBackground(clrGray);

   Button1.Create(0,"Button1",0,50,250,120,200);
//BmpButton1.Create(0,"BmpButto1",0,50,250,120,200);
//BmpButton1.BmpNames("\\Images\\sell.bmp","\\Images\\sell.bmp");
   Button1.ColorBackground(clrRed);
   Button1.Text("SELL");
   Button1.ColorBorder(White);
   Picture2.Create(0,"Pictur2",0,50,250,120,200);
   Picture2.BmpName("\\Images\\settings.bmp");
   Button2.Create(0,"Button2",0,210,250,140,200);
   Button2.ColorBackground(Green);
   Button2.Text("BUY");
   Button2.ColorBorder(White);
   Picture3.Create(0,"Pictur3",0,145,205,0,0);
   Picture3.BmpName("\\Images\\.bmp");

   Panel3.Create(0,"Panel3",0,220,226,245,225);
   Panel3.ColorBackground(clrGray);
   Button3.Create(0,"Button3",0,320,250,250,200);
   Button3.ColorBackground(Blue);
   Button3.Text("SETTINGS");
   Button3.FontSize(8);
   Button3.ColorBorder(White);
   Picture4.Create(0,"Pictur4",0,255,205,0,0);
   Picture4.BmpName("\\Images\\.bmp");
   Button4.Create(0,"Button4",0,40,290,330,260);
   Button4.ColorBackground(clrLightGreen);
   Button4.Text("EXECUTE TRADE");
   Button4.ColorBorder(White);
   Panel1.Create(0,"Panel1",0,80,301,280,300);
   Panel1.ColorBackground(clrGray);
   Button5.Create(0,"Button5",0,40,340,330,310);
   Button5.ColorBackground(clrDarkViolet);
   Button5.Text("PENDING ORDER");
   Button5.ColorBorder(White);
   Button6.Create(0,"Button6",0,40,380,330,350);
   Button6.ColorBackground(clrLightGreen);
   Button6.Text("ENTER");
   Button6.ColorBorder(White);
   ListView.Create(0,"ListView",0,40,420,330,450);
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
      if(OrderMagicNumber()==MagicNumber)
        {
         ListView.AddItem(OrderTicket(),i);
        }
     }
   Panel2.Create(0,"Panel2",0,80,391,280,390);
   Panel2.ColorBackground(clrGray);
   Button7.Create(0,"Button7",0,10,550,90,470);
   Button7.ColorBackground(clrLightGray);
   Button7.Text("CLOSE HALF");
   Button7.FontSize(8);
   Button7.ColorBorder(White);
   Picture5.Create(0,"Pictur5",0,15,475,0,0);
   Picture5.BmpName("\\Images\\.bmp");
   Button8.Create(0,"Button8",0,190,550,100,470);
   Button8.ColorBackground(clrLightGray);
   Button8.Text("CLOSE CUST");
   Button8.FontSize(8);
   Button8.ColorBorder(White);
   Picture6.Create(0,"Pictur6",0,105,475,0,0);
   Picture6.BmpName("\\Images\\.bmp");
   Button9.Create(0,"Button9",0,280,550,200,470);
   Button9.ColorBackground(clrLightGray);
   Button9.Text("SL TO BE");
   Button9.FontSize(8);
   Button9.ColorBorder(White);
   Picture7.Create(0,"Pictur7",0,205,475,0,0);
   Picture7.BmpName("\\Images\\.bmp");
   Button10.Create(0,"Button10",0,370,550,290,470);
   Button10.ColorBackground(clrLightBlue);
   Button10.Text("PARTIAL TP");
   Button10.FontSize(8);
   Button10.ColorBorder(White);
   Picture8.Create(0,"Pictur8",0,295,475,0,0);
   Picture8.BmpName("\\Images\\.bmp");

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
      Comment(DoubleToStr(AccountProfit(),2));
     }
   if(Use_Close_Profit)
     {
      double lossss =Close_USD_Loss*-1;
      double lprofit = Close_profit*AccountEquity()/100;
      double lLoss = (Close_Loss*AccountEquity()/100)*-1;

      if((Close_USD_profit >= ProfitTotal())||(lprofit >= ProfitTotal())|| lLoss<= ProfitTotal() || lossss<= ProfitTotal())
        {
         CloseAllOrders();

        }
     }

  }

//+------------------------------------------------------------------+

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
      if(sparam=="Button1")
        {
         ObjectCreate("TP",OBJ_HLINE,0,Time[0],Ratio*300*Point-Close[0]);
         ObjectCreate("SL",OBJ_HLINE,0,Time[0],300*Point+Close[0]);
        }
      if(sparam=="Button2")
        {
         ObjectCreate("TP_",OBJ_HLINE,0,Time[0],Ratio*300*Point+Close[0]);
         ObjectCreate("SL_",OBJ_HLINE,0,Time[0],300*Point-Close[0]);
        }
      if(sparam=="Button4")
        {
         if(Ratio*300*Point+Close[0]>300*Point-Close[0])
           {
            if(Money_Management)
               NewLots=Money_Management();
            else
               NewLots=Lots;
              {
               OrderSend(Symbol(),OP_BUY,NewLots,Ask,30,300*Point-Close[0],Ratio*300*Point+Close[0],"Buy",MagicNumber,0,clrBlue);
              }
           }
         if(Ratio*300*Point-Close[0]<300*Point+Close[0])
           {
            if(Money_Management)
               NewLots=Money_Management();
            else
               NewLots=Lots;
              {
               OrderSend(Symbol(),OP_SELL,NewLots,Bid,30,300*Point+Close[0],Ratio*300*Point-Close[0],"Sell",MagicNumber,0,clrRed);
              }
           }
        }
      double  Price=Close[0];
      double TP=Ratio*300*Point+Close[1];
      double SL=300*Point-Close[1];
      if(sparam=="Button5")
        {

         ObjectCreate("_Price_",OBJ_HLINE,0,Time[0],Price);
         ObjectCreate("_TP_",OBJ_HLINE,0,Time[0],TP);
         ObjectCreate("_SL_",OBJ_HLINE,0,Time[0],SL);
        }
      if(sparam=="Button6")
        {
         if(Money_Management)
            NewLots=Money_Management();
         else
            NewLots=Lots;
           {
            if(Close[0]<Price && TP>SL)
              {
               OrderSend(Symbol(),OP_BUYSTOP, NewLots, Price,30,SL,TP,"BUYSTOP",MagicNumber,0,clrBlue);
              }
            if(Close[0]<Price && TP<SL)
              {
               OrderSend(Symbol(),OP_SELLLIMIT, NewLots, Price,30,SL,TP,"SELLLIMIT",MagicNumber,0,clrRed);
              }
            if(Close[0]>Price && TP>SL)
              {
               OrderSend(Symbol(),OP_BUYLIMIT, NewLots, Price,30, SL,TP,"BUYLIMIT",MagicNumber,0,clrBlue);
              }
            if(Close[0]>Price && TP<SL)
              {
               OrderSend(Symbol(),OP_SELLSTOP, NewLots, Price,30,SL,TP,"SELLSTOP",MagicNumber,0,clrRed);
              }
           }
         if(sparam=="Button7")
           {
            Close_Half();
           }
         if(sparam=="Button8")
           {
            Close_Cus();
           }
         if(sparam=="Button9")
           {
            BreakEvenOrder();
           }
         if(sparam=="Button10")
           {
            Partial_TP();
           }
        }


     }
  }


//+------------------------------------------------------------------+
//| Money_Management                                 |
//+------------------------------------------------------------------+
double Money_Management()
  {
   double risk = (AccountBalance()*Risk)/100;

   return(risk);
  }
//+------------------------------------------------------------------+
//| Break Even for Buy Order                                                                 |
//+------------------------------------------------------------------+
void BreakEvenOrder()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol() &&OrderMagicNumber()== MagicNumber)
        {
         if(OrderType()==OP_BUY)
           {
            if(Bid-OrderOpenPrice()>BreakEven*Point)
              {
               if(OrderOpenPrice()>OrderStopLoss())
                  OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice()+(BreakEvenStep*Point), OrderTakeProfit(), 0, Green);
              }
           }
         if(OrderType()==OP_SELL)
           {

            if(OrderOpenPrice()-Ask>BreakEven*Point)
              {
               if(OrderOpenPrice()<OrderStopLoss())
                  OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice()-(BreakEvenStep*Point), OrderTakeProfit(), 0, Green);
              }

           }
        }
     }
  }
//+------------------------------------------------------------------+
void Close_Cus()
  {

   for(int i=0; i<OrdersTotal(); i++)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol())
        {
         if(OrderType()==OP_BUY&& OrderMagicNumber()== MagicNumber)
           {
            if(Close[0]>OrderOpenPrice()+partial_close_Step*Point || Close[0]<OrderOpenPrice()-partial_close_Step*Point)
              {
               NewLots = Partial_Lots*OrderLots()/100;
               OrderClose(OrderTicket(),NewLots,OrderClosePrice(),30,clrGreen);
              }
            else
               if(OrderType()==OP_SELL&& OrderMagicNumber()== 0)
                 {
                  if(Close[0]>OrderOpenPrice()+partial_close_Step*Point || Close[0]<OrderOpenPrice()-partial_close_Step*Point)
                    {
                     NewLots = Partial_Lots*OrderLots()/100;
                     OrderClose(OrderTicket(),NewLots,OrderClosePrice(),30,clrGreen);
                    }


                 }
           }
        }
     }
  }

//+------------------------------------------------------------------+
void Close_Half()
  {

   for(int i=0; i<OrdersTotal(); i++)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol())
        {
         if(OrderType()==OP_BUY&& OrderMagicNumber()== MagicNumber)
           {
            if(Close[0]>OrderOpenPrice()+Half_close_Step*Point || Close[0]<OrderOpenPrice()-Half_close_Step*Point)
              {
               NewLots = 0.5*OrderLots();
               OrderClose(OrderTicket(),NewLots,OrderClosePrice(),30,clrGreen);
              }
            else
               if(OrderType()==OP_SELL&& OrderMagicNumber()== 0)
                 {
                  if(Close[0]>OrderOpenPrice()+Half_close_Step*Point || Close[0]<OrderOpenPrice()-Half_close_Step*Point)
                    {
                     NewLots = 0.5*OrderLots();
                     OrderClose(OrderTicket(),NewLots,OrderClosePrice(),30,clrGreen);
                    }


                 }
           }
        }
     }
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Partial TP                                                                 |
//+------------------------------------------------------------------+
void Partial_TP()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol() &&OrderMagicNumber()== MagicNumber)
        {
         if(OrderType()==OP_BUY)
           {

            if(OrderOpenPrice()<OrderTakeProfit())
               OrderModify(OrderTicket(), OrderOpenPrice(), OrderStopLoss(), OrderTakeProfit()*(partial_TP_Step/100), 0, Green);
           }
         if(OrderType()==OP_SELL)
           {

            if(OrderOpenPrice()>OrderTakeProfit())
               OrderModify(OrderTicket(), OrderOpenPrice(), OrderStopLoss(), OrderTakeProfit()*(partial_TP_Step/100), 0, Green);

           }
        }
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
void CloseAllOrders()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         if(OrderType() == OP_BUY)
           {
            OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,Red);
           }
         else
            if(OrderType() == OP_BUY || OrderType() == OP_SELL)
              {
               OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,Red);
              }
            else
              {
               OrderDelete(OrderTicket());
              }
        }
     }
  }
//+------------------------------------------------------------------+
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
//+------------------------------------------------------------------+
//| Total Profit                                                                |
//+------------------------------------------------------------------+
double ProfitTotal()
  {
   double p = 0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
        {
         p += OrderProfit()+OrderCommission()+OrderSwap();
        }
     }
   return (p);
  }
//+------------------------------------------------------------------+
