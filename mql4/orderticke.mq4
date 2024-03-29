//+------------------------------------------------------------------+
//|                                                       eurusd.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property strict
extern double Risk=5;
extern double lots=0.01;
double NewLot;
double BuyTP,SellTP,BuySL,SellSL;
extern bool UseBreakEven=true;
extern bool Use_MM=true;
extern bool Use_TrailingStop=true;
extern int TrailingStop=20;
extern int TrailingSteps=20;
extern int BreakEven=10;
extern int BreakEvensteps=10;
bool zs;
extern int MagicNumber=2020;
double mypoint,BuyPrice,SellPrice;
int OrderRisk;
int Ticket,cnt,BuyTicket,SellTicket;
color N=clrNONE;
input color ObjectColor=clrLime;
input color ProfitColor=clrLime;
input color LoseColor=clrRed;
color ColorPS,ColorPB,ColorAccountP,ColorSymbolP;
double Spread=MarketInfo(Symbol(),MODE_SPREAD);
double A1=0.6,A2=1,A3=1.5,A4=2.1,A5=2.8,A6=3.6;
double B1=1.05,B2=1.2,B3=1.36,B4=1.53,B5=1.71,B6=1.90,B7=2.10;
double C1=1.035,C2=1.081,C3=1.128,C4=1.225,C5=1.275,C6=1.326;
double D1=1.0011,D2=1.0153,D3=1.0296,D4=1.0440,D5=1.0585,D6=1.0731,D7=1.0878,D8=1.1026,D9=1.1175,D10=1.1325,D11=1.1476;
double E1=1.00128,E2=1.01576,E3=1.01025,E4=1.01475,E5=1.01926,E6=1.02378,E7=1.02831,E8=1.03258,E9=1.03740,E10=1.04196,
       E11=1.04653,E12=1.05111,E13=1.0557,E14=1.06030,E15=1.06491,E16=1.06953,E17=1.07416,E18=1.0788,E19=1.08345,E20=1.08811,
       E21=1.09278,E22=1.09746,E23=1.10215,E24=1.10685,E25=1.11156,E26=1.11628,E27=1.12101,E28=1.12575,E29=1.1305,E30=1.13526;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   if(Digits==4  || Digits<=2)
      mypoint=Point;
   if(Digits==3  || Digits==5)
      mypoint=Point*10;
   Hline();

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

   OrderRisk=MathCeil((OrderOpenPrice()-OrderStopLoss())*10000);
   if(OrderRisk<0)
      OrderRisk=-OrderRisk;



   if(Use_MM && Risk>0)

     { NewLot=LotsMM();}

   else
     {NewLot=lots;}

   Order(E19,E20,E21,E22);
   Order(E20,E21,E22,E23);
   Order(E21,E22,E23,E24);
   Order(E22,E23,E24,E25);
   Order(E23,E24,E25,E26);
   Order(E24,E25,E26,E27);
   Order(E25,E26,E27,E28);
   Order(E26,E27,E28,E29);
   
   MTBuy();
   MTSell();
 DeleteHege();
   if(AccountProfit()>=0)
     {
      ColorAccountP=ProfitColor;
     }
   else
     {
      ColorAccountP=LoseColor;
     }
   if(SymbolProfit()>=0)
     {
      ColorSymbolP=ProfitColor;
     }
   else
     {
      ColorSymbolP=LoseColor;
     }
   if(SellProfit()>=0)
     {
      ColorPS=ProfitColor;
     }
   else
     {
      ColorPS=LoseColor;
     }
   if(BuyProfit()>=0)
     {
      ColorPB=ProfitColor;
     }
   else
     {
      ColorPB=LoseColor;
     }


   Info("info1",1,25,100,"Account Balance : ",12,"",clrLime);
   Info("info11",1,25,21,DoubleToStr(AccountBalance(),2),12,"",clrLime);
   Info("info2",1,50,100,"Account Equity : ",12,"",clrLime);
   Info("info22",1,50,21,DoubleToStr(AccountEquity(),2),12,"",clrLime);
   Info("info3",1,75,100,"Account Profit : ",12,"",clrLime);
   Info("info33",1,75,21,DoubleToStr(AccountProfit(),2),12,"",ColorAccountP);
   Info("info4",1,100,100,"Symbol Profit : ",12,"",clrLime);
   Info("info44",1,100,21,DoubleToStr(SymbolProfit(),2),12,"",ColorSymbolP);
   Info("info5",1,125,100,"Sell Profit : ",12,"",clrLime);
   Info("info55",1,125,21,DoubleToStr(SellProfit(),2),12,"",ColorPS);
   Info("info6",1,150,100,"Buy Profit : ",12,"",clrLime);
   Info("info66",1,150,21,DoubleToStr(BuyProfit(),2),12,"",ColorPB);
   Info("info7",1,175,100," Spread : ",12,"",clrLime);
   Info("info77",1,175,21,DoubleToStr(Spread,2),12,"",clrLime);
   Info("info8",1,200,100,"Symbol Profit : ",12,"",clrLime);
   Info("info88",1,200,21,DoubleToStr(SymbolProfit(),2),12,"",clrLime);
  }
//+------------------------------------------------------------------+
//أدارة رأس المال
double LotsMM()
  {

   double L=MathCeil((AccountFreeMargin()*Risk)/1000)/55;
   if(L<MarketInfo(Symbol(),MODE_MINLOT))
      L=MarketInfo(Symbol(),MODE_MINLOT);
   if(L>MarketInfo(Symbol(),MODE_MAXLOT))
      L=MarketInfo(Symbol(),MODE_MAXLOT);
   return (L);
  }

//  تحديد عدد الصفقات البيع
int TS()
  {
   int s=0,i;
   for(i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         if(Symbol()==OrderSymbol()&& OrderMagicNumber()==MagicNumber&&OrderType()==OP_SELL)
           {s++;}
     }
   return(s);

  }
//+------------------------------------------------------------------+
//|        تحديد عدد صفقات الشراء                                                          |
//+------------------------------------------------------------------+
int TB()
  {
   int b=0,i;
   for(i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         if(Symbol()==OrderSymbol()&& OrderMagicNumber()==MagicNumber&&OrderType()==OP_BUY)
           {b++;}
     }
   return(b);

  }

//+------------------------------------------------------------------+
//|   عدد الصفقات الكعلقو                                                               |
//+------------------------------------------------------------------+
int Total(int type)
  {
   int total=0,i;
   for(i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         if(Symbol()==OrderSymbol()&& OrderMagicNumber()==MagicNumber&&OrderType()==type)
           {total++;}
     }
   return(total);

  }
//+------------------------------------------------------------------+
//|   استوب متحرك للشراء                                                               |
//+------------------------------------------------------------------+
void MTBuy()
  {
   for(cnt=OrdersTotal()-1; cnt>=0; cnt--)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber()==MagicNumber)
               if(OrderType()==OP_BUY)
                  if(Bid-OrderOpenPrice()>TrailingStop*mypoint)
                     if(OrderStopLoss()<Bid-TrailingSteps*mypoint)
                        zs=OrderModify(OrderTicket(),OrderOpenPrice(),Bid-TrailingSteps*mypoint,OrderTakeProfit(),0,N);

     }

  }
//+------------------------------------------------------------------+
//|       اسنوب متحرك بيع                                                           |
//+------------------------------------------------------------------+
void MTSell()
  {
   for(cnt=OrdersTotal()-1; cnt>=0; cnt--)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber()==MagicNumber)
               if(OrderType()==OP_SELL)
                  if(OrderOpenPrice()-Ask>TrailingStop*mypoint)
                     if(OrderStopLoss()>Ask+TrailingSteps*mypoint)
                        zs=OrderModify(OrderTicket(),OrderOpenPrice(),Ask+TrailingSteps*mypoint,OrderTakeProfit(),0,N);

     }

  }



//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|  بريك أيفين  شراء                                                              |
//+------------------------------------------------------------------+
void BEBuy()
  {
   for(cnt=OrdersTotal()-1; cnt>=0; cnt--)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber()==MagicNumber)
               if(OrderType()==OP_BUY)
                  if(Bid-OrderOpenPrice()>BreakEven*mypoint)
                     if(OrderOpenPrice()>OrderStopLoss())
                        zs=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),0,N);




     }
  }

//+------------------------------------------------------------------+
//|             بريك إيفين بيع                                                     |
//+------------------------------------------------------------------+
void BESell()
  {
   for(cnt=OrdersTotal()-1; cnt>=0; cnt--)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber()==MagicNumber)
               if(OrderType()==OP_SELL)
                  if(OrderOpenPrice()-Ask>BreakEven*mypoint)
                     if(OrderOpenPrice()<OrderStopLoss())
                        zs=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),0,N);




     }
  }



//+------------------------------------------------------------------+
//|           إغلاق صفقات البيع                                                       |
//+------------------------------------------------------------------+
void CS()
  {

   for(cnt=OrdersTotal()-1; cnt>=0; cnt--)
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber()==MagicNumber)
               if(OrderType()==OP_SELL)
                 {
                  bool close_s= OrderClose(OrderTicket(),OrderLots(),Ask,3,clrRed);
                 }
  }

//+------------------------------------------------------------------+
//|  غلاق صفقات الشراء                                                                |
//+------------------------------------------------------------------+
void CB()
  {

   for(cnt=OrdersTotal()-1; cnt>=0; cnt--)
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber()==MagicNumber)
               if(OrderType()==OP_BUY)
                 {
                  bool close_B= OrderClose(OrderTicket(),OrderLots(),Bid,3,clrRed);
                 }
  }


//+------------------------------------------------------------------+
//|      حذف جميع الصفقات المعلقة                                                            |
//+------------------------------------------------------------------+
void Delete()
  {
   for(cnt=OrdersTotal()-1; cnt>=0; cnt--)
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber()==MagicNumber)
              {
               bool Delet= OrderDelete(OrderTicket(),clrRed);
              }

  }

//+------------------------------------------------------------------+
//|            حذف نوع صفقات معين                                                      |
//+------------------------------------------------------------------+
void DeleteType(int type)
  {
   for(cnt=OrdersTotal()-1; cnt>=0; cnt--)
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber()==MagicNumber)
               if(OrderType()==type)
                 {
                  bool Delet= OrderDelete(OrderTicket(),clrRed);
                 }

  }

//+------------------------------------------------------------------+
//|      حذف جميع الصفقات                                                            |
//+------------------------------------------------------------------+
void CA()
  {
   for(cnt=OrdersTotal()-1; cnt>=0; cnt--)
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber()==MagicNumber)
              {
               if(OrderType()==OP_BUY)
                 {
                  zs=OrderClose(OrderTicket(),OrderLots(),Bid,3,N);
                 }
               else
                  if(OrderType()==OP_SELL)
                    {
                     zs=OrderClose(OrderTicket(),OrderLots(),Ask,3,N);
                    }
                  else
                    {
                     zs=OrderDelete(OrderTicket(),clrRed);
                    }

              }
  }
//+------------------------------------------------------------------+
//|                                            رسم الاعداد المثلثية                      |
//+------------------------------------------------------------------+
void Hline()
  {

   ObjectCreate(_Symbol,"D1",OBJ_HLINE,0,0,D1);
   ObjectCreate(_Symbol,"D2",OBJ_HLINE,0,0,D2);
   ObjectCreate(_Symbol,"D3",OBJ_HLINE,0,0,D3);
   ObjectCreate(_Symbol,"D4",OBJ_HLINE,0,0,D4);
   ObjectCreate(_Symbol,"D5",OBJ_HLINE,0,0,D5);
   ObjectCreate(_Symbol,"D6",OBJ_HLINE,0,0,D6);
   ObjectCreate(_Symbol,"D7",OBJ_HLINE,0,0,D7);
   ObjectCreate(_Symbol,"D8",OBJ_HLINE,0,0,D8);
   ObjectCreate(_Symbol,"D9",OBJ_HLINE,0,0,D9);
   ObjectCreate(_Symbol,"D10",OBJ_HLINE,0,0,D10);
   ObjectCreate(_Symbol,"D11",OBJ_HLINE,0,0,D11);

   ObjectCreate(_Symbol,"E1",OBJ_HLINE,0,0,E1);
   ObjectCreate(_Symbol,"E2",OBJ_HLINE,0,0,E2);
   ObjectCreate(_Symbol,"E3",OBJ_HLINE,0,0,E3);
   ObjectCreate(_Symbol,"E4",OBJ_HLINE,0,0,E4);
   ObjectCreate(_Symbol,"E5",OBJ_HLINE,0,0,E5);
   ObjectCreate(_Symbol,"E6",OBJ_HLINE,0,0,E6);
   ObjectCreate(_Symbol,"E7",OBJ_HLINE,0,0,E7);
   ObjectCreate(_Symbol,"E8",OBJ_HLINE,0,0,E8);
   ObjectCreate(_Symbol,"E9",OBJ_HLINE,0,0,E9);
   ObjectCreate(_Symbol,"E10",OBJ_HLINE,0,0,E10);
   ObjectCreate(_Symbol,"E11",OBJ_HLINE,0,0,E11);
   ObjectCreate(_Symbol,"E12",OBJ_HLINE,0,0,E12);
   ObjectCreate(_Symbol,"E13",OBJ_HLINE,0,0,E13);
   ObjectCreate(_Symbol,"E14",OBJ_HLINE,0,0,E14);
   ObjectCreate(_Symbol,"E15",OBJ_HLINE,0,0,E15);
   ObjectCreate(_Symbol,"E16",OBJ_HLINE,0,0,E16);
   ObjectCreate(_Symbol,"E17",OBJ_HLINE,0,0,E17);
   ObjectCreate(_Symbol,"E18",OBJ_HLINE,0,0,E18);
   ObjectCreate(_Symbol,"E19",OBJ_HLINE,0,0,E19);
   ObjectCreate(_Symbol,"E20",OBJ_HLINE,0,0,E20);
   ObjectCreate(_Symbol,"E21",OBJ_HLINE,0,0,E21);
   ObjectCreate(_Symbol,"E22",OBJ_HLINE,0,0,E22);
   ObjectCreate(_Symbol,"E23",OBJ_HLINE,0,0,E23);
   ObjectCreate(_Symbol,"E24",OBJ_HLINE,0,0,E24);
   ObjectCreate(_Symbol,"E25",OBJ_HLINE,0,0,E25);
   ObjectCreate(_Symbol,"E26",OBJ_HLINE,0,0,E26);
   ObjectCreate(_Symbol,"E27",OBJ_HLINE,0,0,E27);
   ObjectCreate(_Symbol,"E28",OBJ_HLINE,0,0,E28);
   ObjectCreate(_Symbol,"E29",OBJ_HLINE,0,0,E29);
   ObjectCreate(_Symbol,"E30",OBJ_HLINE,0,0,E30);


   ObjectSetInteger(_Symbol,"E1",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E2",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E3",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E4",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E5",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E6",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E7",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E8",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E9",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E10",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E11",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E12",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E13",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E14",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E15",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E16",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E17",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E18",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E19",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E20",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E21",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E22",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E23",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E24",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E25",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E26",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E27",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E28",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E29",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(_Symbol,"E30",OBJPROP_COLOR,clrBlue);


  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
double SymbolProfit()
  {

   double p=0;
   for(cnt=0; cnt<OrdersTotal(); cnt++)
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber()==MagicNumber)

              {
               p=p+OrderProfit()+OrderCommission()+OrderSwap();
              }
   return (p);
  }
//+----------------------------- حساب أرباح الشراء-------------------------------------+
double BuyProfit()
  {

   double p=0;
   for(cnt=0; cnt<OrdersTotal(); cnt++)
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber()==MagicNumber)
               if(OrderType()== OP_BUY)
                 {
                  p=p+OrderProfit()+OrderCommission()+OrderSwap();
                 }
   return (p);
  }
//+-------------- حساب أرباح البيع----------------------------------------------------+
double SellProfit()
  {

   double p=0;
   for(cnt=0; cnt<OrdersTotal(); cnt++)
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber()==MagicNumber)
               if(OrderType()== OP_SELL)
                 {
                  p=p+OrderProfit()+OrderCommission()+OrderSwap();
                 }
   return (p);
  }
//+------------------------------------------------------------------+
void Info(string NAME,double CORNER,int Y,int X,string TEXT,int FONTSIZE,string FONT,color FONTCOLOR)
  {
   ObjectCreate(NAME,OBJ_LABEL,0,0,0);
   ObjectSetText(NAME,TEXT,FONT,FONTSIZE,FONTCOLOR);
   ObjectSet(NAME,OBJPROP_CORNER,CORNER);
   ObjectSet(NAME,OBJPROP_XDISTANCE,X);
   ObjectSet(NAME,OBJPROP_YDISTANCE,Y);

  }
//+---------------------------------شرط دخول الصفقة---------------------------------+
void Order(double Lower2,double Lower1,double Upper1,double Upper2)
  {

   if(Total(OP_BUYSTOP)<1)
      if(TB()<1)
         if(Bid>Lower1)
            if(Bid<Upper1)
              {
               BuyPrice=Upper1+5*mypoint;
               BuySL=Lower1-4*mypoint;
               BuyTP=Upper2-6*mypoint;

               Ticket=OrderSend(Symbol(),OP_BUYSTOP,NewLot,BuyPrice,3,BuySL,BuyTP,NULL,MagicNumber,0,N);
Print(Ticket);
              }
   if(Total(OP_SELLSTOP)<1)
      if(TS()<1)
         if(Bid>Lower1)
            if(Bid<Upper1)
              {
               SellPrice=Lower1-5*mypoint;
               SellSL=Upper1+4*mypoint;
               SellTP=Lower2+6*mypoint;
               Ticket=OrderSend(Symbol(),OP_SELLSTOP,NewLot,SellPrice,3,SellSL,SellTP,NULL,MagicNumber,0,N);
Print(Ticket);
              }
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
void DeleteHege(){
 for(int i=OrdersHistoryTotal()-1;i>=0;i--)
 {
   OrderSelect(i, SELECT_BY_POS,MODE_HISTORY);  //error was here
   if(OrderSymbol()==Symbol() && OrderMagicNumber()==MagicNumber)
    {
       //for buy order
       if(OrderType()==OP_BUY && OrderClosePrice()> OrderOpenPrice()) DeleteType(OP_SELLSTOP);
       if(OrderType()==OP_SELL && OrderClosePrice()< OrderOpenPrice()) DeleteType(OP_BUYSTOP);
    }
 }
 
  
}