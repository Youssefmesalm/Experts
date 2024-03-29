//+------------------------------------------------------------------+
//|                                                      El3sawy.mq4 |
//|                                  Copyright 2020,Dr Yousuf Mesalm |
//|                                       https://www.MedicaCasa.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020,Dr Yousuf Mesalm"
#property link      "https://www.MedicaCasa.com"
#property version   "1.00"
#property strict


extern double Risk=0.5;
extern double lots=0.01,Lots;
double NewLot;
double BuyTP,SellTP,BuySL,SellSL;
extern bool UseBreakEven=true;
extern bool Use_MM=true;
extern bool Use_TrailingStop=true;
extern int TrailingStop=9;
extern int TrailingSteps=9;
extern int BreakEven=5;
extern int BreakEvensteps=5;
extern color ColorF=clrBlue;
extern color ColorE=clrRed;
extern color ColorD=clrGold;
extern color ColorG=clrHotPink;

bool zs;

extern int MagicNumber=2000;
double mypoint,BuyPrice,SellPrice,LoseSellPrice,LoseSellSL,LoseSellTP,LoseBuyPrice,LoseBuySL,LoseBuyTP,Price;
int OrderRisk;
int Ticket,cnt,BuyTicket,SellTicket;
color N=clrNONE;
input color ObjectColor=clrBlue;
input color ProfitColor=clrBlue;
input color LoseColor=clrRed;
color ColorPS,ColorPB,ColorAccountP,ColorSymbolP;
double Spread=MarketInfo(Symbol(),MODE_SPREAD);
double LotB=0,LotS=0,MAXP=0,MAXD=0,Prof=AccountProfit();
extern int Steps=10;
extern double Duplicator=2;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
    if(Digits==4  || Digits<=2)
      mypoint=Point;
   if(Digits==3  || Digits==5)
      mypoint=Point*10;
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
 
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
if(Use_MM && Risk>0)

     { NewLot=LotsMM();}

   else
     {NewLot=lots;}
     
     if(BuyProfit()>0){CB();}
     if(TB()<1)
    { Ticket=OrderSend(Symbol(),OP_BUY,NewLot,Ask,13,0,0,"FirstBuy",MagicNumber,0,clrBlue);}
    
    if(TB()>0 && BuyProfit()<0 )
    Price=LastOrderInfo("OpenPrice",OP_BUY)-Steps*mypoint;
    Lots=LastOrderInfo("Lots",OP_BUY)*Duplicator;
    {Ticket=OrderSend(Symbol(),OP_BUY,Lots,Price,13,0,0,NULL,MagicNumber,0,clrBlue);}
    
     
      if(SellProfit()>0){CS();}
     if(TS()<1)
     {Ticket=OrderSend(Symbol(),OP_SELL,NewLot,Bid,3,0,0,"FirstBuy",MagicNumber,0,clrBlue);}
     
      if(TS()>0 && SellProfit()<0 )
      Lots=LastOrderInfo("Lots",OP_SELL)*Duplicator;
      Price=LastOrderInfo("OpenPrice",OP_SELL)+Steps*mypoint;
    {Ticket=OrderSend(Symbol(),OP_SELL,Lots,Price,13,0,0,NULL,MagicNumber,0,clrBlue);}


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


   if(Prof<0 && Prof<MAXD)
     {
      MAXD=Prof;
     }
   if(Prof>0&&Prof>MAXD)
     {
      MAXP=Prof;
     }

   Info("info9",0,25,20,"Max Account DrawDown : ",12,"",clrLime);
   Info("info00",0,25,200,DoubleToStr(MAXD,2),12,"",clrLime);
   Info("infoP",0,50,20,"Max Account Profit : ",12,"",clrLime);
   Info("infoP1",0,50,200,DoubleToStr(MAXP,2),12,"",clrLime);
  }
//+------------------------------------------------------------------+
double LotsMM()
  {

   double L=MathCeil((AccountFreeMargin()*Risk)/1000)/20;
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
//|  بريك أيفين  شراء        حجز أرباح                                                      |
//+------------------------------------------------------------------+
void BEBuyProfit()
  {
   for(cnt=OrdersTotal()-1; cnt>=0; cnt--)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber()==MagicNumber)
               if(OrderType()==OP_BUY)
                  if(Bid-OrderOpenPrice()>BreakEven*mypoint)
                     if(OrderOpenPrice()==OrderStopLoss())
                        zs=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+(BreakEvensteps+mypoint),OrderTakeProfit(),0,N);




     }
  }

//+------------------------------------------------------------------+
//|             بريك إيفين بيع            حجز أرباح                                         |
//+------------------------------------------------------------------+
void BESellProfit()
  {
   for(cnt=OrdersTotal()-1; cnt>=0; cnt--)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber()==MagicNumber)
               if(OrderType()==OP_SELL)
                  if(OrderOpenPrice()-Ask>BreakEven*mypoint)
                     if(OrderOpenPrice()==OrderStopLoss())
                        zs=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-(BreakEvensteps*mypoint),OrderTakeProfit(),0,N);




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
//+-----------------------------بيانات الحساب-------------------------------------+
void Info(string NAME,double CORNER,int Y,int X,string TEXT,int FONTSIZE,string FONT,color FONTCOLOR)
  {
   ObjectCreate(NAME,OBJ_LABEL,0,0,0);
   ObjectSetText(NAME,TEXT,FONTSIZE,FONTCOLOR);
   ObjectSet(NAME,OBJPROP_CORNER,CORNER);
   ObjectSet(NAME,OBJPROP_XDISTANCE,X);
   ObjectSet(NAME,OBJPROP_YDISTANCE,Y);

  }
//+---------------------------------شرط دخول الصفقة---------------------------------+

//+------------------------------------------------------------------+
//|                   معلومات الصفقة الحالية                                |
//+------------------------------------------------------------------+
double LastOrderInfo(string S,int type)
  {
   for(cnt=OrdersTotal()-1; cnt>=0; cnt--)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber()==MagicNumber)
               if(OrderType()==type)
                 {
                  if(S=="type")
                     return(OrderType());
                  else
                     if(S=="Ticket")
                        return(OrderTicket());
                     else
                        if(S=="Time")
                           return(OrderOpenTime());
                        else
                           if(S=="Profit")
                              return(OrderProfit());
                           else
                              if(S=="OpenPrice")
                                 return(OrderOpenPrice());
                              else
                                 if(S=="SL")
                                    return(OrderStopLoss());
                                    else
                                 if(S=="Lots")
                                    return(OrderLots());

                 }


     }
   return(0);


  }

//+------------------------------------------------------------------+
//|           معلومات أخر صفقة مغلقة                                                       |
//+------------------------------------------------------------------+
double LastCloseInfo(string S,int type)
  {
   for(cnt=OrdersHistoryTotal()-1; cnt>=0; cnt--)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_HISTORY))
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber()==MagicNumber)
               if(OrderType()==type)
                 {
                  if(S=="type")
                     return(OrderType());
                  else
                     if(S=="Ticket")
                        return(OrderTicket());
                     else
                        if(S=="CloseTime")
                           return(OrderCloseTime());
                        else
                           if(S=="ClosePrice")
                              return(OrderClosePrice());
                           else
                              if(S=="OpenPrice")
                                 return(OrderOpenPrice());
                              else
                                 if(S=="Profit")
                                    return(OrderProfit());
                                 else
                                    if(S=="SL")
                                       return(OrderStopLoss());
                                    else
                                       if(S=="TP")
                                          return(OrderTakeProfit());



                 }


     }
   return(0);


  }