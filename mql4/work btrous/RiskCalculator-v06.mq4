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

input double Lots =0.1;
input int takeprofit=0;
input int stoploss=0;
input int MagicNumber =789;
extern string   Risk_SetUP   = "------< Risk_SetUP >------";
input bool Money_Management = true;
input int Risk  = 5;
input double Ratio=1;
extern string   partial_close_SetUP   = "------< partial_close_SetUP >------";
input bool partial_close =true;
input int partial_close_Step= 30;
input int Partial_Lots= 30;



extern string   BreakEven_SetUP   = "------< BreakEven_SetUP >------";
input bool UserBreakEven =true;
input int BreakEven= 30;
input int BreakEvenStep= 10;



CScrollV Scroll;
CDialog Dialog;
CListView ListView;
CPanel Panel,Panel1,Panel2,Panel3,Panel4;
CLabel Label,Label1,Label2;
CEdit Edit1,Edit2;
CButton Button1,Button2,Button3,Button4,Button5,Button6,Button7,Button8,Button9,Button10;
CPicture Picture1,Picture2,Picture3,Picture4,Picture5,Picture6,Picture7,Picture8;

double NewLots,tp,sl,price,Steps;
double Lasttradetime=0;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

   Dialog.Create(0,"                    RISK CALCULATOR",0,5,40,380,560);
   Panel4.Create(0,"Pane4",0,5,63,380,560);
   Panel4.ColorBackground(clrDarkRed);
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
   Button1.ColorBackground(clrRed);
   Button1.Text("SELL");
   Button1.ColorBorder(White);
   Picture2.Create(0,"Pictur2",0,55,205,0,0);
   Picture2.BmpName("\\Images\\.bmp");
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
         ObjectCreate("TP",OBJ_HLINE,0,Time[0],High[10]);
         ObjectCreate("SL",OBJ_HLINE,0,Time[0],High[20]);
        }
      if(sparam=="Button2")
        {
         ObjectCreate("TP_",OBJ_HLINE,0,Time[0],High[10]);
         ObjectCreate("SL_",OBJ_HLINE,0,Time[0],High[20]);
        }
      if(sparam=="Button4")
        {
         if(High[10]>High[20])
           {
            OrderSend(Symbol(),OP_BUY,Lots,Ask,30,High[20],High[10],"Buy",MagicNumber,0,clrBlue);
           }
         if(High[10]<High[20])
           {
            OrderSend(Symbol(),OP_SELL,Lots,Bid,30,High[20],High[10],"Sell",MagicNumber,0,clrRed);
           }
        }
      if(sparam=="Button5")
        {
         ObjectCreate("_Price_",OBJ_HLINE,0,Time[0],Close[1]);
         ObjectCreate("_TP_",OBJ_HLINE,0,Time[0],High[10]);
         ObjectCreate("_SL_",OBJ_HLINE,0,Time[0],High[20]);
        }
      if(sparam=="Button6")
        {
         if(Close[0]<Close[1] && High[10]>High[20])
           {
            OrderSend(Symbol(),OP_BUYSTOP, Lots, Close[1],30,High[20],High[10],"BUYSTOP",MagicNumber,0,clrBlue);
           }
         if(Close[0]<Close[1] && High[10]<High[20])
           {
            OrderSend(Symbol(),OP_SELLLIMIT, Lots, Close[1],30,High[20],High[10],"SELLLIMIT",MagicNumber,0,clrRed);
           }
         if(Close[0]>Close[1] && High[10]>High[20])
           {
            OrderSend(Symbol(),OP_BUYLIMIT, Lots, Close[1],30, Close[1],High[20],"BUYLIMIT",MagicNumber,0,clrBlue);
           }
         if(Close[0]>Close[1] && High[10]<High[20])
           {
            OrderSend(Symbol(),OP_SELLSTOP, Lots, Close[1],30,High[20],High[10],"SELLSTOP",MagicNumber,0,clrRed);
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
void BreakEvenOrder(string type)
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==type &&OrderMagicNumber()== MagicNumber)
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
         if(OrderType()==OP_BUY&& OrderMagicNumber()== 0)
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
         if(OrderType()==OP_BUY&& OrderMagicNumber()== 0)
           {
            if(Close[0]>OrderOpenPrice()+partial_close_Step*Point || Close[0]<OrderOpenPrice()-partial_close_Step*Point)
              {
               NewLots = 0.5*OrderLots();
               OrderClose(OrderTicket(),NewLots,OrderClosePrice(),30,clrGreen);
              }
            else
               if(OrderType()==OP_SELL&& OrderMagicNumber()== 0)
                 {
                  if(Close[0]>OrderOpenPrice()+partial_close_Step*Point || Close[0]<OrderOpenPrice()-partial_close_Step*Point)
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
