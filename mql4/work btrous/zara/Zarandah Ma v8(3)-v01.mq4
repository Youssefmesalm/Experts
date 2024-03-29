//+------------------------------------------------------------------+
//|                                            Zarandah MA v1.1.mq4  |
//|                                          Copyright 2020, Sami Zh |
//|                           https://www.facebook.com/sami.zhralden |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020,Sami Zh"
#property link      "https://www.facebook.com/sami.zhralden"
#property version   "1.00"
#property strict



input int Magic=3002;
input double Lots=0.01;//Started Lots
extern bool Use_MM=false;////Money Managment
extern double Risk=5;
input double Multiplier =2;
input int Max_num_buy = 2;
input int Max_num_sell = 2;
input string ss1 ="";//`
input double UsdP =0;//Profit Usd This Pair
input double UsdL =0;//Loss Usd This Pair
input int MaxSpread=30;
input string sf4 ="";//`

input int Stop  = 100;  // TrailingStop
input int Step = 30;   // TrailingStep

input string sf5 ="";//`
extern int LB = 3;
extern int maxBarsForPeriod = 1000;

input string sfi5 ="";//`

input string M1="Moving Average 1 Inputs";//Moving Average 1 Inputs
input int Pe1=100;//Period 1
input ENUM_MA_METHOD Me1=0;//Moving Method
input ENUM_APPLIED_PRICE Ap1=2;//Moving Applied Price
input ENUM_TIMEFRAMES Time1=0;// Moving Time Frames
input int Shift1=0;

input string M2="Moving Average 2 Inputs";//Moving Average 2 Inputs
input int Pe2=100;//Period 2
input ENUM_MA_METHOD Me2=0;//Moving Method
input ENUM_APPLIED_PRICE Ap2=3;//Moving Applied Price
input ENUM_TIMEFRAMES Time2=0;// Moving Time Frames
input int Shift2=0;


input string sr4 ="";//`
input bool UseTimeFilter=false;
input string StartH="01:00";
input string EndH  ="23:00";
input color clri=clrBlue;// Close Line Color

input  string Co="";//Order Comment

input bool TaradingFriday=true;//Tarading Friday

string EaName="(Sami Zh) - ";

color ObjectColor=clrLime;
color ProfitColor=clrLime;
color LoseColor=clrRed;
color Color_Profit_Sell,Color_Profit_Buy,Color_Account_Profit,Color_Symbol_Profit;

color Backs=clrBlack;
color UpCandel=clrLime;
color DownCandel=clrRed;
input string DD="=-=-=-=-=-=-=-=-=-="; //=-=-=-=-=-=-=-=-=-=
input  string    FAc  ="https://www.facebook.com/sami.zhralden"; //FaceBook

extern string   close_win_loss_SetUP   = "------< close_win_loss_SetUP >------";
input bool     Use_close_win_loss     = true;
input double Profit = 10;
input int Num_Win_Trades  = 2;
input int Num_Lose_Trades = 3;

double SepecificNumOfProfitOrder[];
int ProfitIndex[];
double SepecificNumOfLosstOrder[];
int LossIndex[];

double MyPoint,Buyt,Buys,Sellt,Sells,price,tp,sl,slot,blot,BuyLot,SellLot,MAXD=0,MAXP=0,bl,sll;
int Ticket,cnt,Z=-1,Decimal,B,i;
bool zs,Trade,Modify,sell,buy,Trb,Trs,TF;
color N=clrNONE;
string Buy,Sell,Go="",Go1="";

double Nlot,LastBuyPrice,LastSellPrice,USD,tps,tpb,nlot,Do,up,NewLot;
int TS,TB,total;


double RedLine,BlueLine;
datetime TT;
string Mult="Mult",zo="zo";

int multis=0,Zo=0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   int arr[] = {1, 2, 3, 4, 5};
   double a= ArraySort(arr, WHOLE_ARRAY, 0, MODE_DESCEND);
   Alert("second highest ",arr[1]);
   ArrayInitialize(ProfitIndex,Num_Win_Trades);
   ArrayInitialize(LossIndex,Num_Lose_Trades);
   ChartBackColor(true);
   CandelMode(true);
   ShowGrid(false);
   BullColor(true);
   BaerColor(true);
   BaerColorDown(true);
   BullColorUp(true);
   ChartShift(true);
   ChartPeriodSet(false);
   TT=Time[0];

   if(Digits==4 || Digits<=2)
      MyPoint=Point;
   if(Digits==3 || Digits==5)
      MyPoint=Point*10;



   if(MarketInfo(Symbol(),MODE_MINLOT)<0.1)
      Decimal=2;
   else
      Decimal=1;

   if(IsTesting())
     {
      Mult="MultT";
      zo="zoT";
     }
   else
     {
      Mult="Mult";
      zo="zo";
     }


   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   for(int t=20; t>=0; t--)
     {

      ObjectDelete("A"+t);

     }

   if(IsTesting())
     {
      GlobalVariableDel(Symbol()+Mult);
      GlobalVariableDel(Symbol()+zo);
     }
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {


   for(int i=0; i<OrdersTotal(); i++)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic)
        {

        }
     }

   if(Use_MM && Risk>0)
      NewLot=LotsMM();
   else
      NewLot=Lots;


   if(UsdP>0 && SymbolProfit()>=UsdP)
     {
      CS();
      CB();
      if(TS()>0 || TB()>0)
        {
         CS();
         CB();
        }
      Trs=false;
      Trb=false;
      ObjectDelete("Stars");
      ObjectDelete("Starb");
      ObjectDelete("Do");
      ObjectDelete("Do");
      Z=-1;
      TT=Time[0];
     }
   if(UsdL>0 && SymbolProfit()<=-1*UsdL)
     {
      CS();
      CB();
      Trs=false;
      Trb=false;
      ObjectDelete("Stars");
      ObjectDelete("Starb");
      ObjectDelete("Do");
      ObjectDelete("Do");
      Z=-1;
      TT=Time[0];
     }


   if(SymbolProfit()<0 || Total()<1)
     {
      ObjectDelete("Starb");
      ObjectDelete("Stars");
      ObjectDelete("UP");
      ObjectDelete("Do");
     }

   if(SymbolProfit()>0 && Stop>0 && Step>0)
     {
      if(TB()>0&&BuyProfit()>0&& SymbolProfit()>0)
        {
         if(ObjectFind(ChartID(),"Starb")==-1)
           {
            lineHide("Starb",Bid,clri,3,1,0,1);
           }
        }
      if(TS()>0&&SellProfit()>0&& SymbolProfit()>0)
        {
         if(ObjectFind(ChartID(),"Stars")==-1)
           {
            lineHide("Stars",Ask,clri,3,1,0,1);
           }
        }

     }

   double starts=0,startb=0;


   if(SymbolProfit()>0)
     {

      startb=NormalizeDouble(ObjectGet("Starb",OBJPROP_PRICE1),Digits);
      if(BuyProfit()>0 && startb>0)
        {

         if(Bid-startb>=Stop*MyPoint)
           {

            lineHide("UP",Bid-Step*MyPoint,clri,3,1,0,1);
            up=NormalizeDouble(ObjectGet("UP",OBJPROP_PRICE1),Digits);

            if(up>0&&Bid-up>Step*MyPoint)
              {
               ObjectDelete("UP");
               lineHide("UP",Bid-Step*MyPoint,clri,3,1,0,1);

              }

           }
        }
      starts=NormalizeDouble(ObjectGet("Stars",OBJPROP_PRICE1),Digits);

      if(SellProfit()>0&&starts>0)
        {
         if(starts-Ask>=Stop*MyPoint)
           {
            if(ObjectFind(ChartID(),"Do")==-1)
              {
               lineHide("Do",Ask+Step*MyPoint,clri,3,1,0,1);
              }
           }
         Do=NormalizeDouble(ObjectGet("Do",OBJPROP_PRICE1),Digits);
         if(Do>0&&Do-Ask>Step*MyPoint)
           {
            ObjectDelete("Do");
            lineHide("Do",Ask+Step*MyPoint,clri,3,1,0,1);
            Trs=true;
           }
        }

     }
   else
     {

      ObjectDelete("Stars");
      ObjectDelete("Starb");
      ObjectDelete("Do");
      ObjectDelete("Do");
      Do=0;
      up=0;
     }




   up=NormalizeDouble(ObjectGet("UP",OBJPROP_PRICE1),Digits);
   Do=NormalizeDouble(ObjectGet("Do",OBJPROP_PRICE1),Digits);


   if(up>0 &&TB()>0 && BuyProfit()>0 && Bid<=up)
     {
      CS();
      CB();
      if(TS()>0 || TB()>0)
        {
         CS();
         CB();
        }
      Trb=false;
      Trs=false;
      ObjectDelete("Stars");
      ObjectDelete("Starb");
      ObjectDelete("Do");
      ObjectDelete("Do");

      TT=Time[0];
     }

   if(Do>0&&TS()>0 && SellProfit()>0 && Ask>=Do)
     {
      CS();
      CB();
      if(TS()>0 || TB()>0)
        {
         CS();
         CB();
        }
      Trs=false;
      Trb=false;
      ObjectDelete("Stars");
      ObjectDelete("Starb");
      ObjectDelete("Do");
      ObjectDelete("Do");

      TT=Time[0];
     }
















   if(UseTimeFilter)
     {

      if(TimeFilter(StartH,EndH)==true)
        {
         Trade=true;
        }
      else
        {
         Trade=false;
        }

     }
   else
     {
      Trade=true;
     }

   double spread = MarketInfo(Symbol(),MODE_SPREAD);
   RefreshRates();
   ResetLastError();


   TB=TB();
   TS=TS();



   double Profit=AccountProfit();
   color pp,bc,sc;
   if(Profit>0)
     {
      pp=clrLime;
     }
   else
     {
      pp=clrRed;
     }
   if(SellProfit()>0)
     {
      sc=clrLime;
     }
   else
     {
      sc=clrRed;
     }
   if(BuyProfit()>0)
     {
      bc=clrLime;
     }
   else
     {
      bc=clrRed;
     }

   RefreshRates();
   ResetLastError();


   Info("A1",1,25,120,"Account Balance : ",12,"",ObjectColor);
   Info("A2",1,25,10,DoubleToStr(AccountBalance(),2),14,"",ObjectColor);

   Info("A3",1,50,120,"Account Equity : ",12,"",ObjectColor);
   Info("A4",1,50,10,DoubleToStr(AccountEquity(),2),14,"",ObjectColor);

   Info("A9",1,75,120,"Account Profit : ",12,"",ObjectColor);
   Info("A10",1,75,10,DoubleToStr(AccountProfit(),2),14,"",pp);


   Info("A5",1,100,120,"Buy Profit : ",12,"",ObjectColor);
   Info("A6",1,100,10,DoubleToStr(BuyProfit(),2),14,"",bc);

   Info("A7",1,125,120,"Sell Profit : ",12,"",ObjectColor);
   Info("A8",1,125,10,DoubleToStr(SellProfit(),2),14,"",sc);



   Info("A11",1,150,120,"Spread Size : ",12,"",ObjectColor);
   Info("A12",1,150,30,DoubleToStr(spread,0),14,"",ObjectColor);


   total=TS()+TB();


   double MaH=iMA(Symbol(),Time1,Pe1,Shift1,Me1,Ap1,1);
   double MaL=iMA(Symbol(),Time2,Pe2,Shift2,Me2,Ap2,1);
   double Lin=iCustom(Symbol(),0,"Zarandah",LB,maxBarsForPeriod,0,1);
   double cl=iClose(Symbol(),0,1);



   RedLine=NormalizeDouble(ObjectGet("M5 Res C",OBJPROP_PRICE1),Digits);
   BlueLine=NormalizeDouble(ObjectGet("M5 Sup C",OBJPROP_PRICE1),Digits);





   int Dy=DayOfWeek();


   if(TaradingFriday)
     {
      TF=true;
     }
   else
     {
      if(Dy==5)
        {
         TF=false;
        }
      else
        {
         TF=true;
        }
     }


   if(Total()<1)
     {
      GlobalVariableSet(Symbol()+Mult,1);
      GlobalVariableSet(Symbol()+zo,0);
     }



   if(cl<MaL&&BlueLine<MaL && Close[1]<=BlueLine) //Sell
     {
      if(Total()<1)
        {
         slot=NewLot;
        }
      Zo=(int)GlobalVariableGet(Symbol()+zo);




      if(TS()>0&&TB()>1&& Zo!=1)
        {
         GlobalVariableSet(Symbol()+Mult,multis+1);
         GlobalVariableSet(Symbol()+zo,1);
        }


     }

   if(cl>MaH&&RedLine>MaH && Close[1]>=RedLine)
     {
      if(Total()<1)
        {
         blot=NewLot;
        }

      Zo=(int)GlobalVariableGet(Symbol()+zo);


      if(TB()>0&&TS()>=1 &&Zo!=2)
        {
         GlobalVariableSet(Symbol()+Mult,multis+1);
         GlobalVariableSet(Symbol()+zo,2);
        }
     }






   if(Trade && TF && SymbolProfit()<=0&&spread<=MaxSpread)
     {

      if(cl<MaL&&TT!=Time[0])
        {
         if(BlueLine<MaL && Close[1]<=BlueLine)
           {
            if(TS()>=1 && TB()>=1)
              {

               multis=GlobalVariableGet(Symbol()+Mult);
               slot=NormalizeDouble(NewLot*MathPow(Multiplier,multis),Decimal);
              }
            if(Max_num_sell>TotalSell())
              {
               if(TS()==0 && TB()>=1)
                 {


                  slot=NormalizeDouble(NewLot*MathPow(Multiplier,1),Decimal);
                  GlobalVariableSet(Symbol()+zo,1);
                 }
               Ticket=OrderSend(Symbol(),OP_SELL,slot,Bid,3,0,0,EaName+Co,Magic,0,clrRed);
              }
            TT=Time[0];
           }
        }

      if(cl>MaH&&TT!=Time[0])
        {
         if(RedLine>MaH && Close[1]>=RedLine)
           {

            if(TS()>=1 && TB()>=1)
              {
               multis=GlobalVariableGet(Symbol()+Mult);
               blot=NormalizeDouble(NewLot*MathPow(Multiplier,multis),Decimal);

              }
            if(Max_num_buy>TotalBuy())
              {
               if(TS()>=1 && TB()==0)
                 {

                  blot=NormalizeDouble(NewLot*MathPow(Multiplier,1),Decimal);
                  GlobalVariableSet(Symbol()+zo,2);

                 }

               Ticket = OrderSend(Symbol(),OP_BUY,blot,Ask,3,0,0,EaName+Co,Magic,0,clrGreen);
              }
            TT=Time[0];
           }
        }
     }
   if(Use_close_win_loss)
     {
     if(OrdersTotal()>0&&TB()>0&&TS()>0){
      if(NUmwinProfitTotal()>=Num_Win_Trades &&NumloseProfitTotal()>=Num_Lose_Trades)
        {
         if(winProfitTotal()-loseProfitTotal()>=Profit)
           {
            winCloseOrder();
            LoseCloseOrder();
           }
        }
     }}
   int total=ArraySize(ProfitIndex);
   for(int i=0; i<total; i++)
     {
      Comment(ProfitIndex[i]);
     }
   Comment(winProfitTotal());
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+


double LotsMM()

  {
   double L=MathCeil(AccountFreeMargin() * Risk/1000)/100;


   if(L<MarketInfo(Symbol(),MODE_MINLOT))
      L=MarketInfo(Symbol(),MODE_MINLOT);
   if(L>MarketInfo(Symbol(),MODE_MAXLOT))
      L=MarketInfo(Symbol(),MODE_MAXLOT);

   return(L);
  }




//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Loss()
  {
   int  ly=0;
   for(int f=0; f<OrdersHistoryTotal(); f++)
     {
      if(OrderSelect(f,SELECT_BY_POS,MODE_HISTORY))
         if(OrderSymbol()==Symbol()&& OrderMagicNumber()==Magic)
           {
            if(OrderProfit()<0)
              {
               ly++;
              }
            else
              {
               ly=0;
              }
           }
     }
   return(ly);
  }




//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CS()
  {

   for(i=OrdersTotal()-1; i>=0; i--)
     {
      bool select=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol()&& OrderMagicNumber()==Magic)
        {
         if(OrderType()==OP_SELL)
           {
            bool close_s=OrderClose(OrderTicket(),OrderLots(),Ask,3);
           }
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CB()
  {

   for(i=OrdersTotal()-1; i>=0; i--)
     {
      bool select=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol()&& OrderMagicNumber()==Magic)
        {
         if(OrderType()==OP_BUY)
           {
            bool close_b=OrderClose(OrderTicket(),OrderLots(),Bid,3);
           }
        }
     }
  }








//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void lineHide(string name1, double prss1,color clrr, int style, int width,bool back,bool ss)
  {
   if(ObjectFind(name1) != 0)
     {
      ObjectCreate(name1, OBJ_HLINE, 0, 0,prss1);
      ObjectSet(name1, OBJPROP_COLOR, clrr);
      ObjectSet(name1, OBJPROP_STYLE, style);
      ObjectSet(name1,OBJPROP_WIDTH,width);
      ObjectSetInteger(0,name1,OBJPROP_BACK,back);
      ObjectSetInteger(0,name1,OBJPROP_SELECTABLE,ss);

     }
  }












//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool TimeFilter(string Sh,string Eh)
  {
   datetime Strat=StrToTime(TimeToStr(TimeCurrent(),TIME_DATE)+" " +Sh);
   datetime End  =StrToTime(TimeToStr(TimeCurrent(),TIME_DATE)+" "+ Eh);

   if(!(Time[0]>=Strat &&Time[0]<=End))
     {
      return(false);
     }
   return(true);

  }




//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double lastOrderInfo(string Info,int type=-1)
  {
   for(i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol()&& OrderMagicNumber()==Magic && (OrderType()==type ||type==-1))
           {
            if(Info=="Type")
               return(OrderType());
            else
               if(Info=="Lots")
                  return(OrderLots());
               else
                  if(Info=="Price")
                     return(OrderOpenPrice());
                  else
                     if(Info=="TP")
                        return(OrderTakeProfit());
                     else
                        if(Info=="Time")
                           return(OrderOpenTime());

           }
     }
   return(0);

  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Info(string NAME,double CORNER,int Y,int X,string TEXT,int FONTSIZE,string Font,color FONTCOLOR)
  {
   ObjectCreate(NAME,OBJ_LABEL,0,0,0);
   ObjectSetText(NAME,TEXT,FONTSIZE,Font,FONTCOLOR);
   ObjectSet(NAME,OBJPROP_CORNER,CORNER);
   ObjectSet(NAME,OBJPROP_XDISTANCE,X);
   ObjectSet(NAME,OBJPROP_YDISTANCE,Y);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double SymbolProfit()
  {
   double p=0;
   for(cnt=0; cnt<OrdersTotal(); cnt++)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol()&& OrderMagicNumber()==Magic)
           {
            p=p+OrderProfit()+OrderCommission()+OrderSwap();
           }
     }
   return(p);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double SellProfit()
  {
   double p=0;
   for(cnt=0; cnt<OrdersTotal(); cnt++)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderSymbol()==Symbol()  && OrderMagicNumber()==Magic)
            if(OrderType()==OP_SELL)
              {
               p=p+OrderProfit()+OrderCommission()+OrderSwap();
              }
     }
   return(p);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double BuyProfit()
  {
   double p=0;
   for(cnt=0; cnt<OrdersTotal(); cnt++)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))


         if(OrderSymbol()==Symbol()   && OrderMagicNumber()==Magic)
            if(OrderType()==OP_BUY)
              {
               p=p+OrderProfit()+OrderCommission()+OrderSwap();
              }
     }
   return(p);
  }
/// عدد صفقات البيع
int TS()
  {
   int s=0;
   for(i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         if(Magic==0)
           {
            if(Symbol()==OrderSymbol()&&OrderType()==OP_SELL)
              {
               s++;
              }
           }
         else
           {

            if(Symbol()==OrderSymbol() && OrderMagicNumber()==Magic&&OrderType()==OP_SELL)
              {
               s++;
              }
           }
     }
   return(s);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int TB()
  {

   int b=0;
   for(i=0; i<OrdersTotal(); i++)
     {

      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         if(Symbol()==OrderSymbol() && OrderMagicNumber()==Magic   && OrderType()==OP_BUY)

           {
            b++;
           }
     }
   return(b);


  }
//+------------------------------------------------------------------+
int Total()
  {

   int b=0;
   for(i=0; i<OrdersTotal(); i++)
     {

      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         if(Symbol()==OrderSymbol() && OrderMagicNumber()==Magic)
           {
            if(OrderType()<=1)

              {
               b++;
              }
           }
     }
   return(b);


  }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                        Chart Color                               |
//+------------------------------------------------------------------+
// خلفيه الشارت
bool ChartBackColor(const color clr)
  {

   ResetLastError();
   if(!ChartSetInteger(0,CHART_COLOR_BACKGROUND,Backs))
     {

      Print(__FUNCTION__," Error Code = ",GetLastError());
      return(false);
     }
   return(true);
  }
// شكل الشمعه
bool CandelMode(const long V)
  {
   ResetLastError();
   if(!ChartSetInteger(0,CHART_MODE,V))
     {

      Print(__FUNCTION__," Error Code = ",GetLastError());
      return(false);
     }
   return(true);
  }

// إخفاء الشبكه او الخطوط
bool ShowGrid(const bool V)
  {


   ResetLastError();
   if(!ChartSetInteger(0,CHART_SHOW_GRID,V))
     {

      Print(__FUNCTION__," Error Code = ",GetLastError());
      return(false);
     }
   return(true);
  }
//  لون جسم الشمعه الصاعده
bool BullColor(const color C)
  {
   ResetLastError();
   if(!ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,UpCandel))
     {

      Print(__FUNCTION__," Error Code = ",GetLastError());
      return(false);
     }
   return(true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool BaerColor(const color C)
  {
   ResetLastError();
   if(!ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,DownCandel))
     {

      Print(__FUNCTION__," Error Code = ",GetLastError());
      return(false);
     }
   return(true);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool BaerColorDown(const color C)
  {
   ResetLastError();
   if(!ChartSetInteger(0,CHART_COLOR_CHART_DOWN,DownCandel))
     {

      Print(__FUNCTION__," Error Code = ",GetLastError());
      return(false);
     }
   return(true);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool BullColorUp(const color C)
  {
   ResetLastError();
   if(!ChartSetInteger(0,CHART_COLOR_CHART_UP,UpCandel))
     {

      Print(__FUNCTION__," Error Code = ",GetLastError());
      return(false);
     }
   return(true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ChartShift(const bool V)
  {

   ResetLastError();
   if(!ChartSetInteger(0,CHART_SHIFT,V))
     {

      Print(__FUNCTION__," Error Code = ",GetLastError());
      return(false);
     }
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ChartPeriodSet(const bool V)
  {

   ResetLastError();
   if(!ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,V))
     {

      Print(__FUNCTION__," Error Code = ",GetLastError());
      return(false);
     }
   return(true);
  }
//+------------------------------------------------------------------+
double winProfitTotal()
  {
   double p = 0;
   double  num_array[];
   ArrayResize(num_array,OrdersTotal()-1,OrdersTotal()-1);
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol() && (OrderMagicNumber()==Magic || OrderMagicNumber()==0))
        {

         if((OrderProfit()+OrderCommission()+OrderSwap()) > 0)
           {
            num_array[i]=OrderProfit()+OrderCommission()+OrderSwap();

           }
        }
     }
   //FilterProfit(ProfitIndex,num_array);
   //for(int i; i<ArraySize(ProfitIndex); i++)
   //  {
   //   p=p+num_array[ProfitIndex[i]];
   //  }
   return (p);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double loseProfitTotal()
  {

   double p = 0;
   double  num_array[];
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

      if(OrderSymbol()==Symbol() && (OrderMagicNumber()==Magic || OrderMagicNumber()==0))
        {
         if((OrderProfit()+OrderCommission()+OrderSwap()) < 0)
           {
            num_array[i]=OrderProfit()+OrderCommission()+OrderSwap();

           }
        }
     }
   FilterLoss(LossIndex,num_array);
   for(int i; i<ArraySize(LossIndex); i++)
     {
      p=p+num_array[LossIndex[i]];
     }
   return (p);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void winCloseOrder()
  {

   int total=ArraySize(ProfitIndex);
   for(int i=0; i<total; i++)
     {

      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

      if(OrderSymbol()==Symbol() && (OrderMagicNumber()==Magic || OrderMagicNumber()==0))
        {
         if(OrderType() == OP_BUY || OrderType() == OP_SELL)
           {

            OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,Red);

           }
        }

     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void LoseCloseOrder()
  {
   int total=ArraySize(LossIndex);
   for(int i=0; i<total; i++)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol() && (OrderMagicNumber()==Magic || OrderMagicNumber()==0))
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
//| Calculate Total Sell Order                                         |
//+------------------------------------------------------------------+
int TotalSell()
  {
   int s=0;
   for(int i=0; i<OrdersTotal(); i++)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(Symbol()==OrderSymbol() && (OrderMagicNumber()== Magic || OrderMagicNumber()==0))
        {
         if(OrderType()==OP_SELL)
           {
            s++;
           }
        }
     }
   return(s);
  }


//+------------------------------------------------------------------+
//| Calculate Total Buy Order                                         |
//+------------------------------------------------------------------+
int TotalBuy()
  {
   int b=0;
   for(int i=0; i<OrdersTotal(); i++)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(Symbol()==OrderSymbol() && (OrderMagicNumber()== Magic || OrderMagicNumber()==0))
        {
         if(OrderType()==OP_BUY)
           {
            b++;
           }
        }
     }
   return(b);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double NUmwinProfitTotal()
  {
   int Num=0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

      if(OrderSymbol()==Symbol() && (OrderMagicNumber()==Magic || OrderMagicNumber()==0))
        {
         if((OrderProfit()+OrderCommission()+OrderSwap()) > 0)
           {
            Num++;
           }
        }
     }
   return (Num);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double NumloseProfitTotal()
  {
   int Num=0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);

      if(OrderSymbol()==Symbol() && (OrderMagicNumber()==Magic || OrderMagicNumber()==0))
        {
         if((OrderProfit()+OrderCommission()+OrderSwap()) < 0)
           {
            Num++;
           }
        }
     }
   return (Num);
  }
//+------------------------------------------------------------------+
void FilterProfit(int &profitIndex[],double &profit[])
  {
   double temp[];
   ArrayCopy(temp,profit,0,0,WHOLE_ARRAY);

   for(int i=0; i<Num_Win_Trades; i++)
     {
      int index=ArrayMaximum(temp,WHOLE_ARRAY,0);
      profitIndex[i]=index;
      temp[index]=0;
      
     }
  }

//+------------------------------------------------------------------+
void FilterLoss(int &lossIndex[],double &loss[])
  {
   double temp[];
   ArrayCopy(temp,loss,0,0,WHOLE_ARRAY);
   
   for(int i=0; i<Num_Win_Trades; i++)
     {
      int index=ArrayMinimum(temp,WHOLE_ARRAY,0);
      lossIndex[i]=index;
      temp[index]=0;

     }
  }
//+------------------------------------------------------------------+
