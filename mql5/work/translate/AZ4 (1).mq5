//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
input bool Show_message_box=true;// Show message box
enum oneway
  {
   Buy=1,Sell=2,
  };
enum lotState
  {
   Fixed,Continue,
  };
input oneway Positions=1;// Positions
input bool Hedge_option=true;// Hedge option
input double trade_entry_price=0;// trade entry price
input double stop_loss_price=0;// stop loss price
input double target_price=0;// target price
input double target_calculating_adjustment_price=0;// target calculating adjustment price
input bool target_profit_booking_fuction=true;// target profit booking fuction
input double quantity=0.1;// quantity
input int parameter1=2; 
input double parameter2=0.5 ; 
input lotState parameter3=Fixed  ;
input double xPoints=0.99;
enum XLK1
  {
   Multiplication=1,
   Addition=2,
  };
input XLK1 Reverse_adjustment_method=2;// Reverse adjustment method
input double Loss_reversal_adjustment=2;// Loss reversal adjustment
double sl=0;//SL
double tp=0;//TP
string Remarks="";//Remarks
input int magic=15420;
input string comm1X="----------------------------";//  ----------------------------
double slippage=30;
bool showtextlabels=true;//Whether to display text labels//Whether to display text labels
input bool Use_Pips=true;// Use Pips
datetime finalcompilationtime=__DATETIME__;//Program final compilation time
long check;
long X=20;
long Y=20;
long Yinterval=15;
color labelcolor=Yellow;
long Labelfontsize=10;
ENUM_BASE_CORNER fixedangle=0;
//////////////////////////////////////////////////////////////
datetime time1,time2;
datetime fixedandletime;
double close=0;
string NAME;
bool showinformationbox;
oneway unidirectionalchoice;
bool Hedgingoptions;
double entryprice;
double stopprice;
double targetprice;
double targetprice1;
bool targetcloseswitch;
double singlequantity;
XLK1 Reversemethod;
double LossReverse;
bool spreadadaptation;
int lossNumbers=0;
int OnInit()
  {
   showinformationbox=Show_message_box;
   unidirectionalchoice=Positions;
   Hedgingoptions=Hedge_option;
   entryprice=trade_entry_price;
   stopprice=stop_loss_price;
   targetprice=target_price;
   targetprice1=target_calculating_adjustment_price;
   targetcloseswitch=target_profit_booking_fuction;
   singlequantity=quantity;
   Reversemethod=Reverse_adjustment_method;
   LossReverse=Loss_reversal_adjustment;
   spreadadaptation=Use_Pips;



   NAME=(string)ChartID();
//Alert("急速模式程序,修改参数后需重置EA开关");
   fixedandletime=TimeCurrent();

//EventSetMillisecondTimer(300);
   return(INIT_SUCCEEDED);
  }
//| expert deinitialization function |
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   if(MQLInfoInteger(MQL_TESTER)==false)
      ObjectsDeleteAll(0,"BQ");
  }
//| expert start function|
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   if(TerminalInfoInteger(TERMINAL_CONNECTED)==false)
      return;
   if(MQLInfoInteger(MQL_TESTER)==false)
      if(TimeCurrent()-SymbolInfoInteger(Symbol(),SYMBOL_TIME)>=30)
         return;


   if(close==0)
      close=iClose(Symbol(),0,0);



   if(OpendOrdersTotal(-100,magic,"")==0)
     {
      drawLine("JC",1,entryprice,0,Red,0,0);
      drawLine("ZS",1,stopprice,0,clrYellow,0,0);
      drawLine("MB",1,targetprice,0,clrAqua,0,0);

      if(
         (iClose(Symbol(),0,0)>=entryprice&&close<entryprice)
         ||(iClose(Symbol(),0,0)<=entryprice&&close>entryprice)
      )
        {
         if(unidirectionalchoice==1 || unidirectionalchoice==3)
            ulong t1=CreateOrder(Symbol(),ENUM_ORDER_TYPE(Hedgingoptions==false?0:1),singlequantity,0,0,sl,tp,Remarks,magic);

         if(unidirectionalchoice==2 || unidirectionalchoice==3)
            ulong t2=CreateOrder(Symbol(),ENUM_ORDER_TYPE(Hedgingoptions==false?1:0),singlequantity,0,0,sl,tp,Remarks,magic);
        }
     }
   else
     {
      if(ReadWriteOrderInformation(findlassorder(-100,-100,magic,"Rear","now","",0),"position"))
        {

         if(cc.OrderType==(Hedgingoptions==false?0:1)&&iClose(Symbol(),0,0)>=(ObjectGetDouble(0,"MB",OBJPROP_PRICE,0)-xPoints*Point()))
           {
            double ApproachX=ObjectGetDouble(0,"JC",OBJPROP_PRICE,0);
            double StopLossX=ObjectGetDouble(0,"ZS",OBJPROP_PRICE,0);
            double targetX=ObjectGetDouble(0,"MB",OBJPROP_PRICE,0);

            drawLine("JC",1,targetX,0,Red,0,0);
            drawLine(Hedgingoptions==Hedge_option?"ZS":"MB",1,targetX-MathAbs(entryprice-stopprice),0,clrYellow,0,0);
            drawLine(Hedgingoptions==Hedge_option?"MB":"ZS",1,targetX+MathAbs(entryprice-targetprice),0,clrAqua,0,0);

            if(targetcloseswitch)
              {
               request.action=TRADE_ACTION_DEAL;
               if(cc.OrderType==POSITION_TYPE_BUY)
                  request.type=1;
               if(cc.OrderType==POSITION_TYPE_SELL)
                  request.type=0;
               request.tp=0;
               request.sl=0;

               if(OrderSend(request,result))
                 {
                  ulong t1=CreateOrder(Symbol(),ENUM_ORDER_TYPE(Hedgingoptions==false?0:1),singlequantity,0,0,sl,tp,Remarks,magic);
                  lossNumbers=0;
                  Hedgingoptions=Hedge_option;
                 }
              }
           }
         else
            if(cc.OrderType==(Hedgingoptions==false?1:0)&&iClose(Symbol(),0,0)<=(ObjectGetDouble(0,"MB",OBJPROP_PRICE,0)+xPoints*Point()))
              {
               double ApproachX=ObjectGetDouble(0,"JC",OBJPROP_PRICE,0);
               double StopLossX=ObjectGetDouble(0,"ZS",OBJPROP_PRICE,0);
               double targetX=ObjectGetDouble(0,"MB",OBJPROP_PRICE,0);




               drawLine("JC",1,targetX,0,Red,0,0);
               drawLine(Hedgingoptions==Hedge_option?"ZS":"MB",1,targetX+MathAbs(entryprice-stopprice),0,clrYellow,0,0);
               drawLine(Hedgingoptions==Hedge_option?"MB":"ZS",1,targetX-MathAbs(entryprice-targetprice),0,clrAqua,0,0);

               if(targetcloseswitch)
                 {
                  request.action=TRADE_ACTION_DEAL;
                  if(cc.OrderType==POSITION_TYPE_BUY)
                     request.type=1;
                  if(cc.OrderType==POSITION_TYPE_SELL)
                     request.type=0;
                  request.tp=0;
                  request.sl=0;

                  if(OrderSend(request,result))
                    {
                     ulong t1=CreateOrder(Symbol(),ENUM_ORDER_TYPE(Hedgingoptions==false?1:0),singlequantity,0,0,sl,tp,Remarks,magic);
                     lossNumbers=0;
                     Hedgingoptions=Hedge_option;
                    }
                 }
              }
            else
               if(
                  (cc.OrderType==(Hedgingoptions==false?0:1)&&iClose(Symbol(),0,0)<=(ObjectGetDouble(0,"ZS",OBJPROP_PRICE,0)+xPoints*Point()))
                  ||(cc.OrderType==(Hedgingoptions==false?1:0)&&iClose(Symbol(),0,0)>=(ObjectGetDouble(0,"ZS",OBJPROP_PRICE,0)-xPoints*Point()))
               )
                 {
                  request.action=TRADE_ACTION_DEAL;
                  if(cc.OrderType==POSITION_TYPE_BUY)
                     request.type=1;
                  if(cc.OrderType==POSITION_TYPE_SELL)
                     request.type=0;
                  request.tp=0;
                  request.sl=0;

                  if(OrderSend(request,result))
                    {
                     double lots=0;
                     if(Reversemethod==1)
                        lots=cc.OrderLots*LossReverse;
                     if(Reversemethod==2)
                        lots=cc.OrderLots+LossReverse;

                     if(
                        (cc.OrderType==(Hedgingoptions==false?0:1)&&cc.OrderClosePrice>=cc.OrderOpenPrice)
                        ||(cc.OrderType==(Hedgingoptions==false?1:0)&&cc.OrderClosePrice<=cc.OrderOpenPrice)
                     )
                        lots=singlequantity;

                     double ApproachX=ObjectGetDouble(0,"JC",OBJPROP_PRICE,0);
                     double StopLossX=ObjectGetDouble(0,"ZS",OBJPROP_PRICE,0);
                     double targetX=ObjectGetDouble(0,"MB",OBJPROP_PRICE,0);
                     if(lossNumbers>=parameter1*2)
                       {
                        lossNumbers=parameter1;
                       }
                     if(lossNumbers==parameter1)
                       {
                        if(Hedgingoptions)
                          {Hedgingoptions=false;}
                        else
                          {
                           Hedgingoptions=true;
                          }
                        lots=parameter2;
                       }

                     if(lossNumbers>parameter1)
                       {
                        if(parameter3==Fixed)
                           lots=parameter2;
                        if(parameter3==Continue)
                          {
                           if(Reversemethod==1)
                              lots=cc.OrderLots*LossReverse;
                           if(Reversemethod==2)
                              lots=cc.OrderLots+LossReverse;
                          }
                       }
                     if(cc.OrderType==(Hedgingoptions==false?1:0))
                       {
                        ulong t1=CreateOrder(Symbol(),ENUM_ORDER_TYPE(Hedgingoptions==false?0:1),lots,0,0,sl,tp,Remarks,magic);

                        drawLine("JC",1,StopLossX-targetprice1,0,Red,0,0);
                        drawLine(Hedgingoptions==Hedge_option?"ZS":"MB",1,StopLossX-targetprice1-MathAbs(entryprice-stopprice),0,clrYellow,0,0);
                        drawLine(Hedgingoptions==Hedge_option?"MB":"ZS",1,StopLossX-targetprice1+MathAbs(entryprice-targetprice),0,clrAqua,0,0);

                        lossNumbers++;
                        Hedgingoptions=Hedge_option;
                       }
                     else
                       {
                        ulong t2=CreateOrder(Symbol(),ENUM_ORDER_TYPE(Hedgingoptions==false?1:0),lots,0,0,sl,tp,Remarks,magic);

                        lossNumbers++;
                        drawLine("JC",1,StopLossX+targetprice1,0,Red,0,0);
                        drawLine(Hedgingoptions==Hedge_option?"ZS":"MB",1,StopLossX+targetprice1+MathAbs(entryprice-stopprice),0,clrYellow,0,0);
                        drawLine(Hedgingoptions==Hedge_option?"MB":"ZS",1,StopLossX+targetprice1-MathAbs(entryprice-targetprice),0,clrAqua,0,0);
                        Hedgingoptions=Hedge_option;
                       }

                    }
                 }
        }
     }

   close=iClose(Symbol(),0,0);

   if(showinformationbox)
      if(MQLInfoInteger(MQL_OPTIMIZATION)==false)
         if(MQLInfoInteger(MQL_TESTER)==false||MQLInfoInteger(MQL_VISUAL_MODE))
           {
            string content[100];
            int pp=0;
            content[pp]="";
            pp++;
            content[pp]="Platform provider:" +AccountInfoString(ACCOUNT_COMPANY)+" Leverage:"+DoubleToString(AccountInfoInteger(ACCOUNT_LEVERAGE),0);
            pp++;
            content[pp]="Magic:"+(string)magic;
            pp++;
            content[pp]="Start time:"+DoubleToString((TimeCurrent()-fixedandletime)/60/60,1)+"Hours";
            pp++;
            content[pp]="------------------------------------";
            pp++;
            content[pp]="BUY Number:"+(string)OpendOrdersTotal(0,magic,"");
            pp++;
            content[pp]="BUY Profit:"+DoubleToString(OrderProfit(0,magic,""),2);
            pp++;
            content[pp]="BUY Lots:"+DoubleToString(totalVolume(0,magic,""),2);
            pp++;
            content[pp]="------------------------------------";
            pp++;
            content[pp]="SELL Number:"+(string)OpendOrdersTotal(1,magic,"");
            pp++;
            content[pp]="SELL Profit:"+DoubleToString(OrderProfit(1,magic,""),2);
            pp++;
            content[pp]="SELL Lots:"+DoubleToString(totalVolume(1,magic,""),2);
            pp++;
            content[pp]="------------------------------------";
            pp++;
            content[pp]="Total profit:"+DoubleToString(OrderProfit(-100,magic,""),2);
            pp++;
            content[pp]="------------------------------------";
            pp++;

            for(int ixx=0; ixx<pp; ixx++)
               FixedPositionLabel("BQ"+(string)ixx,content[ixx],X,Y+Yinterval*ixx+(ChartGetInteger(0,CHART_SHOW_ONE_CLICK)==0?0:60),labelcolor,Labelfontsize,fixedangle);
           }
   return;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   OnTick();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void stoploss_protection(long typeX,double protectionDistance,double startDistance,long magicX,string comm)
  {
   for(int i=PositionsTotal()-1; i>=0; i--)
      if(ReadWriteOrderInformation(PositionGetTicket(i),"position"))
         if(cc.OrderTicket>0)
            if(cc.OrderSymbol==Symbol())
               if(cc.OrderMagicNumber==magicX || magicX==-1)
                  if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                     if(typeX==-100 || typeX==-200 || typeX==cc.OrderType)
                        if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                          {
                           if(cc.OrderType==0)
                              if(cc.OrderClosePrice-cc.OrderOpenPrice>=startDistance*cc.POINT*coefficient(cc.OrderSymbol))
                                 if(cc.OrderStopLoss+cc.POINT<cc.OrderOpenPrice+protectionDistance*cc.POINT*coefficient(cc.OrderSymbol) || cc.OrderStopLoss==0)
                                   {
                                    request.action=TRADE_ACTION_SLTP;
                                    request.sl=NormalizeDouble(cc.OrderOpenPrice+protectionDistance*cc.POINT*coefficient(cc.OrderSymbol),cc.DIGITS);
                                    check=OrderSend(request,result);
                                   }
                           if(cc.OrderType==1)
                              if(cc.OrderOpenPrice-cc.OrderClosePrice>=startDistance*cc.POINT*coefficient(cc.OrderSymbol))
                                 if(cc.OrderStopLoss-cc.POINT>cc.OrderOpenPrice-protectionDistance *cc.POINT*coefficient(cc.OrderSymbol) || cc.OrderStopLoss==0)
                                   {
                                    request.action=TRADE_ACTION_SLTP;
                                    request.sl=NormalizeDouble(cc.OrderOpenPrice-protectionDistance*cc.POINT*coefficient(cc.OrderSymbol),cc.DIGITS);
                                    check=OrderSend(request,result);
                                   }
                          }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void TpSlModifiy(long typeX,double insideSL,double withinSl,long magicX,string comm)
  {
   if(insideSL!=0)
      for(int i=PositionsTotal()-1; i>=0; i--)
         if(ReadWriteOrderInformation(PositionGetTicket(i),"position"))
            if(cc.OrderTicket>0)
               if(cc.OrderSymbol==Symbol())
                  if(cc.OrderMagicNumber==magicX || magicX==-1)
                     if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                        if(typeX==-100 || typeX==-200 || typeX==cc.OrderType)
                           if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                             {
                              if(cc.OrderType==0)
                                 if(cc.OrderTakeProfit>NormalizeDouble(insideSL,cc.DIGITS)+SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT) || cc.OrderTakeProfit<NormalizeDouble(insideSL,cc.DIGITS)-SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT))
                                    //if(cc.OrderTakeProfit>NormalizeDouble(insideSL,cc.DIGITS)+SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT))
                                   {
                                    request.action=TRADE_ACTION_SLTP;
                                    request.tp=NormalizeDouble(insideSL,cc.DIGITS);
                                    check=OrderSend(request,result);
                                   }
                              if(cc.OrderType==1)
                                 if(cc.OrderTakeProfit>NormalizeDouble(insideSL,cc.DIGITS)+SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT) || cc.OrderTakeProfit<NormalizeDouble(insideSL,cc.DIGITS)-SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT))
                                    //if(cc.OrderTakeProfit<NormalizeDouble(insideSL,cc.DIGITS)-SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT))
                                   {
                                    request.action=TRADE_ACTION_SLTP;
                                    request.tp=NormalizeDouble(insideSL,cc.DIGITS);
                                    check=OrderSend(request,result);
                                   }
                             }

   if(withinSl!=0)
      for(int i=PositionsTotal()-1; i>=0; i--)
         if(ReadWriteOrderInformation(PositionGetTicket(i),"position"))
            if(cc.OrderTicket>0)
               if(cc.OrderSymbol==Symbol())
                  if(cc.OrderMagicNumber==magicX || magicX==-1)
                     if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                        if(typeX==-100 || typeX==-200 || typeX==cc.OrderType)
                           if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                             {
                              if(cc.OrderType==0)
                                 //if(cc.OrderStopLoss>NormalizeDouble(withinSl,cc.DIGITS)+SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT) || cc.OrderStopLoss<NormalizeDouble(withinSl,cc.DIGITS)-SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT))
                                 if(cc.OrderStopLoss<NormalizeDouble(withinSl,cc.DIGITS)-SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT) || cc.OrderStopLoss==0)
                                   {
                                    request.action=TRADE_ACTION_SLTP;
                                    request.sl=NormalizeDouble(withinSl,cc.DIGITS);
                                    check=OrderSend(request,result);
                                   }
                              if(cc.OrderType==1)
                                 //if(cc.OrderStopLoss>NormalizeDouble(withinSl,cc.DIGITS)+SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT) || cc.OrderStopLoss<NormalizeDouble(withinSl,cc.DIGITS)-SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT))
                                 if(cc.OrderStopLoss>NormalizeDouble(withinSl,cc.DIGITS)+SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT) || cc.OrderStopLoss==0)
                                   {
                                    request.action=TRADE_ACTION_SLTP;
                                    request.sl=NormalizeDouble(withinSl,cc.DIGITS);
                                    check=OrderSend(request,result);
                                   }
                             }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Trailingstop(long typeX,double StartDistance1,double StartDistance2,long callbackMode,double keepDistance,double keepProportions,long magicX,string comm)
  {
   for(int i=PositionsTotal()-1; i>=0; i--)
      if(ReadWriteOrderInformation(PositionGetTicket(i),"position"))
         if(cc.OrderTicket>0)
            if(cc.OrderSymbol==Symbol())
               if(cc.OrderMagicNumber==magicX || magicX==-1)
                  if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                     if(typeX==-100 || typeX==-200 || typeX==cc.OrderType)
                        if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                          {
                           double yourDistancex=0;
                           if(callbackMode==1)
                              yourDistancex=keepDistance;
                           if(callbackMode==2)
                              yourDistancex=MathAbs(cc.OrderClosePrice-cc.OrderOpenPrice)*keepProportions/100/cc.POINT/coefficient(cc.OrderSymbol);
                           if(cc.OrderType==0)
                              if(cc.OrderClosePrice-cc.OrderOpenPrice>StartDistance1*cc.POINT*coefficient(cc.OrderSymbol))
                                 if(StartDistance2==0||cc.OrderClosePrice-cc.OrderOpenPrice<=StartDistance2*cc.POINT*coefficient(cc.OrderSymbol))
                                    if(NormalizeDouble(cc.OrderClosePrice-(yourDistancex*coefficient(cc.OrderSymbol)+1)*cc.POINT,cc.DIGITS)>=cc.OrderStopLoss || cc.OrderStopLoss==0)
                                      {
                                       request.action=TRADE_ACTION_SLTP;
                                       request.sl=NormalizeDouble(cc.OrderClosePrice-yourDistancex*coefficient(cc.OrderSymbol)*cc.POINT,cc.DIGITS);
                                       check=OrderSend(request,result);
                                      }
                           if(cc.OrderType==1)
                              if(-cc.OrderClosePrice+cc.OrderOpenPrice>StartDistance1*cc.POINT*coefficient(cc.OrderSymbol))
                                 if(StartDistance2==0||-cc.OrderClosePrice+cc.OrderOpenPrice<=StartDistance2*cc.POINT*coefficient(cc.OrderSymbol))
                                    if(NormalizeDouble(cc.OrderClosePrice+(yourDistancex*coefficient(cc.OrderSymbol)+1)*cc.POINT,cc.DIGITS)<=cc.OrderStopLoss || cc.OrderStopLoss==0)
                                      {
                                       request.action=TRADE_ACTION_SLTP;
                                       request.sl=NormalizeDouble(cc.OrderClosePrice+yourDistancex*coefficient(cc.OrderSymbol)*cc.POINT,cc.DIGITS);
                                       check=OrderSend(request,result);
                                      }
                          }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ulong HighestAndLowestOrderNumber(long a,long b,long magicX,string HL,string comm,long pc1,long pc2)
  {
   double price=0;
   ulong orderNumber=0;
   for(int i=PositionsTotal()-1; i>=0; i--)
      if(ReadWriteOrderInformation(PositionGetTicket(i),"position"))
         if(cc.OrderTicket>0)
            if(cc.OrderTicket!=pc1 && cc.OrderTicket!=pc2)
               if(cc.OrderSymbol==Symbol())
                  if(cc.OrderMagicNumber==magicX || magicX==-1)
                     if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                        if(cc.OrderType==a || cc.OrderType==b || a==-100 || b==-100 || a==-200 || b==-200)
                           if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                             {
                              if(((price==0 || price>cc.OrderOpenPrice) && HL=="L")
                                 || ((price==0 || price<cc.OrderOpenPrice) && HL=="H"))
                                {
                                 price=cc.OrderOpenPrice;
                                 orderNumber=cc.OrderTicket;
                                }
                             }

   for(int i=OrdersTotal()-1; i>=0; i--)
      if(ReadWriteOrderInformation(OrderGetTicket(i),"pending order"))
         if(cc.OrderTicket>0)
            if(cc.OrderTicket!=pc1 && cc.OrderTicket!=pc2)
               if(cc.OrderSymbol==Symbol())
                  if(cc.OrderMagicNumber==magicX || magicX==-1)
                     if(cc.OrderType==ORDER_TYPE_BUY_LIMIT || cc.OrderType==ORDER_TYPE_SELL_LIMIT || cc.OrderType==ORDER_TYPE_BUY_STOP || cc.OrderType==ORDER_TYPE_SELL_STOP || cc.OrderType==ORDER_TYPE_BUY_STOP_LIMIT || cc.OrderType==ORDER_TYPE_SELL_STOP_LIMIT)
                        if(cc.OrderType==a || cc.OrderType==b || a==-100 || b==-100 || a==-300 || b==-300)
                           if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                             {
                              if(((price==0 || price>cc.OrderOpenPrice) && HL=="L")
                                 || ((price==0 || price<cc.OrderOpenPrice) && HL=="H"))
                                {
                                 price=cc.OrderOpenPrice;
                                 orderNumber=cc.OrderTicket;
                                }
                             }
   return(orderNumber);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   OnTick();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void button(string name,string txt1,string txt2,long XX,long YX,long XL,long YL,long WZ,color A,color B)
  {
   if(ObjectFind(0,name)==-1)
      ObjectCreate(0,name,OBJ_BUTTON,0,0,0);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,XX);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,YX);
   ObjectSetInteger(0,name,OBJPROP_XSIZE,XL);
   ObjectSetInteger(0,name,OBJPROP_YSIZE,YL);
   ObjectSetString(0,name,OBJPROP_FONT,"Microsoft Yahei");
   ObjectSetInteger(0,name,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,name,OBJPROP_CORNER,WZ);
   if(ObjectGetInteger(0,name,OBJPROP_STATE)==1)
     {
      ObjectSetInteger(0,name,OBJPROP_COLOR,A);
      ObjectSetInteger(0,name,OBJPROP_BGCOLOR,B);
      ObjectSetString(0,name,OBJPROP_TEXT,txt1);
     }
   else
     {
      ObjectSetInteger(0,name,OBJPROP_COLOR,B);
      ObjectSetInteger(0,name,OBJPROP_BGCOLOR,A);
      ObjectSetString(0,name,OBJPROP_TEXT,txt2);
     }
  }
//+----------------------------------------------------- -------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ulong findlassorder(long type1,long type2,long magicX,string fx,string present_and_history,string comm,long exclude)
  {
   if(present_and_history=="now")
      if(fx=="Rear")
         for(int i=PositionsTotal()-1; i>=0; i--)
            if(ReadWriteOrderInformation(PositionGetTicket(i),"position"))
               if(cc.OrderTicket>0)
                  if(cc.OrderSymbol==Symbol())
                     if(cc.OrderMagicNumber==magicX || magicX==-1)
                        if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                           if(cc.OrderType==type1 || cc.OrderType==type2 || type1==-100 || type2==-100 || type1==-200 || type2==-200)
                              if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                                 return(cc.OrderTicket);

   if(present_and_history=="now")
      if(fx=="forward")
         for(int i=0; i<PositionsTotal(); i++)
            if(ReadWriteOrderInformation(PositionGetTicket(i),"position"))
               if(cc.OrderTicket>0)
                  if(cc.OrderSymbol==Symbol())
                     if(cc.OrderMagicNumber==magicX || magicX==-1)
                        if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                           if(cc.OrderType==type1 || cc.OrderType==type2 || type1==-100 || type2==-100 || type1==-200 || type2==-200)
                              if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                                 return(cc.OrderTicket);

   if(present_and_history=="now")
      if(fx=="Rear")
         for(int i=OrdersTotal()-1; i>=0; i--)
            if(ReadWriteOrderInformation(OrderGetTicket(i),"pending order"))
               if(cc.OrderTicket>0)
                  if(cc.OrderSymbol==Symbol())
                     if(cc.OrderMagicNumber==magicX || magicX==-1)
                        if(cc.OrderType==ORDER_TYPE_BUY_LIMIT || cc.OrderType==ORDER_TYPE_SELL_LIMIT || cc.OrderType==ORDER_TYPE_BUY_STOP || cc.OrderType==ORDER_TYPE_SELL_STOP || cc.OrderType==ORDER_TYPE_BUY_STOP_LIMIT || cc.OrderType==ORDER_TYPE_SELL_STOP_LIMIT)
                           if(cc.OrderType==type1 || cc.OrderType==type2 || type1==-100 || type2==-100 || type1==-300 || type2==-300)
                              if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                                 return(cc.OrderTicket);

   if(present_and_history=="now")
      if(fx=="forward")
         for(int i=0; i<OrdersTotal(); i++)
            if(ReadWriteOrderInformation(OrderGetTicket(i),"pending order"))
               if(cc.OrderTicket>0)
                  if(cc.OrderSymbol==Symbol())
                     if(cc.OrderMagicNumber==magicX || magicX==-1)
                        if(cc.OrderType==ORDER_TYPE_BUY_LIMIT || cc.OrderType==ORDER_TYPE_SELL_LIMIT || cc.OrderType==ORDER_TYPE_BUY_STOP || cc.OrderType==ORDER_TYPE_SELL_STOP || cc.OrderType==ORDER_TYPE_BUY_STOP_LIMIT || cc.OrderType==ORDER_TYPE_SELL_STOP_LIMIT)
                           if(cc.OrderType==type1 || cc.OrderType==type2 || type1==-100 || type2==-100 || type1==-300 || type2==-300)
                              if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                                 return(cc.OrderTicket);

   HistorySelect(fixedandletime,TimeCurrent());
   if(present_and_history=="history")
      if(fx=="Rear")
         for(int i=HistoryDealsTotal()-1; i>=0; i--)
            if(HistoryDealGetInteger(HistoryDealGetTicket(i),DEAL_ENTRY)==DEAL_ENTRY_OUT)
               if(ReadWriteOrderInformation(HistoryDealGetTicket(i),"Historical positions"))
                  if(cc.OrderTicket>0)
                     if(cc.OrderSymbol==Symbol())
                        if(cc.OrderMagicNumber==magicX || magicX==-1)
                           if(cc.OrderType==DEAL_TYPE_BUY || cc.OrderType==DEAL_TYPE_SELL)
                              if(cc.OrderType==type1 || cc.OrderType==type2 || type1==-100 || type2==-100 || type1==-200 || type2==-200)
                                 if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                                    return(cc.TICKETOUT);
   HistorySelect(fixedandletime,TimeCurrent());
   if(present_and_history=="history")
      if(fx=="forward")
         for(int i=0; i<HistoryDealsTotal(); i++)
            if(HistoryDealGetInteger(HistoryDealGetTicket(i),DEAL_ENTRY)==DEAL_ENTRY_OUT)
               if(ReadWriteOrderInformation(HistoryDealGetTicket(i),"Historical positions"))
                  if(cc.OrderTicket>0)
                     if(cc.OrderSymbol==Symbol())
                        if(cc.OrderMagicNumber==magicX || magicX==-1)
                           if(cc.OrderType==DEAL_TYPE_BUY || cc.OrderType==DEAL_TYPE_SELL)
                              if(cc.OrderType==type1 || cc.OrderType==type2 || type1==-100 || type2==-100 || type1==-200 || type2==-200)
                                 if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                                    return(cc.TICKETOUT);
   HistorySelect(fixedandletime,TimeCurrent());
   if(present_and_history=="history")
      if(fx=="Rear")
         for(int i=HistoryOrdersTotal()-1; i>=0; i--)
            if(ReadWriteOrderInformation(HistoryOrderGetTicket(i),"History pending order"))
               if(cc.OrderTicket>0)
                  if(cc.OrderSymbol==Symbol())
                     if(cc.OrderMagicNumber==magicX || magicX==-1)
                        if(cc.OrderType==ORDER_TYPE_BUY_LIMIT || cc.OrderType==ORDER_TYPE_SELL_LIMIT || cc.OrderType==ORDER_TYPE_BUY_STOP || cc.OrderType==ORDER_TYPE_SELL_STOP || cc.OrderType==ORDER_TYPE_BUY_STOP_LIMIT || cc.OrderType==ORDER_TYPE_SELL_STOP_LIMIT)
                           if(cc.OrderType==type1 || cc.OrderType==type2 || type1==-100 || type2==-100 || type1==-300 || type2==-300)
                              if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                                 return(cc.OrderTicket);
   HistorySelect(fixedandletime,TimeCurrent());
   if(present_and_history=="history")
      if(fx=="forward")
         for(int i=0; i<HistoryOrdersTotal(); i++)
            if(ReadWriteOrderInformation(HistoryOrderGetTicket(i),"History pending order"))
               if(cc.OrderTicket>0)
                  if(cc.OrderSymbol==Symbol())
                     if(cc.OrderMagicNumber==magicX || magicX==-1)
                        if(cc.OrderType==ORDER_TYPE_BUY_LIMIT || cc.OrderType==ORDER_TYPE_SELL_LIMIT || cc.OrderType==ORDER_TYPE_BUY_STOP || cc.OrderType==ORDER_TYPE_SELL_STOP || cc.OrderType==ORDER_TYPE_BUY_STOP_LIMIT || cc.OrderType==ORDER_TYPE_SELL_STOP_LIMIT)
                           if(cc.OrderType==type1 || cc.OrderType==type2 || type1==-100 || type2==-100 || type1==-300 || type2==-300)
                              if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                                 return(cc.OrderTicket);

   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void deleteorder(long typeX,long magicX,string comm)
  {
   for(int i=PositionsTotal()-1; i>=0; i--)
      if(ReadWriteOrderInformation(PositionGetTicket(i),"position"))
         if(cc.OrderTicket>0)
            if(cc.OrderSymbol==Symbol())
               if(cc.OrderMagicNumber==magicX || magicX==-1)
                  if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                     if(cc.OrderType==typeX || typeX==-100 || typeX==-200)
                        if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                           //if(OrderOpenTime()<=time)
                          {
                           request.action=TRADE_ACTION_DEAL;
                           if(cc.OrderType==POSITION_TYPE_BUY)
                              request.type=1;
                           if(cc.OrderType==POSITION_TYPE_SELL)
                              request.type=0;
                           request.tp=0;
                           request.sl=0;
                           check=OrderSend(request,result);
                           i=PositionsTotal();
                          }

   for(int i=OrdersTotal()-1; i>=0; i--)
      if(ReadWriteOrderInformation(OrderGetTicket(i),"pending order"))
         if(cc.OrderTicket>0)
            if(cc.OrderSymbol==Symbol())
               if(cc.OrderMagicNumber==magicX || magicX==-1)
                  if(cc.OrderType==ORDER_TYPE_BUY_LIMIT || cc.OrderType==ORDER_TYPE_SELL_LIMIT || cc.OrderType==ORDER_TYPE_BUY_STOP || cc.OrderType==ORDER_TYPE_SELL_STOP || cc.OrderType==ORDER_TYPE_BUY_STOP_LIMIT || cc.OrderType==ORDER_TYPE_SELL_STOP_LIMIT)
                     if(cc.OrderType==typeX || typeX==-100 || typeX==-300)
                        if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                          {
                           request.action=TRADE_ACTION_REMOVE;
                           check=OrderSend(request,result);
                           i=OrdersTotal();
                          }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
long OpendOrdersTotal(long typeX,long magicX,string comm)
  {
   long numbers=0;
   for(int i=PositionsTotal()-1; i>=0; i--)
      if(ReadWriteOrderInformation(PositionGetTicket(i),"position"))
         if(cc.OrderTicket>0)
            if(cc.OrderSymbol==Symbol())
               if(cc.OrderMagicNumber==magicX || magicX==-1)
                  if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                     if(cc.OrderType==typeX || typeX==-100 || typeX==-200)
                        if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                           numbers++;

   for(int i=OrdersTotal()-1; i>=0; i--)
      if(ReadWriteOrderInformation(OrderGetTicket(i),"pending order"))
         if(cc.OrderTicket>0)
            if(cc.OrderSymbol==Symbol())
               if(cc.OrderMagicNumber==magicX || magicX==-1)
                  if(cc.OrderType==ORDER_TYPE_BUY_LIMIT || cc.OrderType==ORDER_TYPE_SELL_LIMIT || cc.OrderType==ORDER_TYPE_BUY_STOP || cc.OrderType==ORDER_TYPE_SELL_STOP || cc.OrderType==ORDER_TYPE_BUY_STOP_LIMIT || cc.OrderType==ORDER_TYPE_SELL_STOP_LIMIT)
                     if(cc.OrderType==typeX || typeX==-100 || typeX==-300)
                        if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                           numbers++;

   return(numbers);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double OrderProfit(long typeX,long magicX,string comm)
  {
   double Profit=0;
   for(int i=PositionsTotal()-1; i>=0; i--)
      if(ReadWriteOrderInformation(PositionGetTicket(i),"position"))
         if(cc.OrderTicket>0)
            if(cc.OrderSymbol==Symbol())
               if(cc.OrderMagicNumber==magicX || magicX==-1)
                  if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                     if(cc.OrderType==typeX || typeX==-100 || typeX==-200)
                        if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                           Profit+=(cc.OrderProfit+cc.OrderSwap);//OrderCommission()

   return(Profit);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double totalVolume(long typeX,long magicX,string comm)
  {
   double lots=0;
   for(int i=PositionsTotal()-1; i>=0; i--)
      if(ReadWriteOrderInformation(PositionGetTicket(i),"position"))
         if(cc.OrderTicket>0)
            if(cc.OrderSymbol==Symbol())
               if(cc.OrderMagicNumber==magicX || magicX==-1)
                  if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                     if(cc.OrderType==typeX || typeX==-100 || typeX==-200)
                        if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                           lots+=cc.OrderLots;

   for(int i=OrdersTotal()-1; i>=0; i--)
      if(ReadWriteOrderInformation(OrderGetTicket(i),"pending order"))
         if(cc.OrderTicket>0)
            if(cc.OrderSymbol==Symbol())
               if(cc.OrderMagicNumber==magicX || magicX==-1)
                  if(cc.OrderType==ORDER_TYPE_BUY_LIMIT || cc.OrderType==ORDER_TYPE_SELL_LIMIT || cc.OrderType==ORDER_TYPE_BUY_STOP || cc.OrderType==ORDER_TYPE_SELL_STOP || cc.OrderType==ORDER_TYPE_BUY_STOP_LIMIT || cc.OrderType==ORDER_TYPE_SELL_STOP_LIMIT)
                     if(cc.OrderType==typeX || typeX==-100 || typeX==-300)
                        if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                           lots+=cc.OrderLots;

   return(lots);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void FixedPositionLabel(string name,string content,long XX,long YX,color C,long FontSize,long corner)
  {
   if(content==NULL||content=="")
      return;
   if(ObjectFind(0,name)==-1)
     {
      ObjectDelete(0,name);
      ObjectCreate(0,name,OBJ_LABEL,0,0,0);
     }
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,XX);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,YX);
   ObjectSetString(0,name,OBJPROP_TEXT,content);
   ObjectSetString(0,name,OBJPROP_FONT,"Song Dynasty");
   ObjectSetInteger(0,name,OBJPROP_FONTSIZE,FontSize);
   ObjectSetInteger(0,name,OBJPROP_COLOR,C);
   ObjectSetInteger(0,name,OBJPROP_CORNER,corner);
   ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_LEFT);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ulong CreateOrder(string symb,ENUM_ORDER_TYPE type,double lot,double OpenPrice,double interval,double withinSl,double insideSL,string comment,long magicX)
  {
   comment=comment+"-"+EnumToString(Period())+"-"+(string)magicX;

   if(SymbolInfoDouble(symb,SYMBOL_VOLUME_STEP)!=0)
      lot=NormalizeDouble(lot/SymbolInfoDouble(symb,SYMBOL_VOLUME_STEP),0)*SymbolInfoDouble(symb,SYMBOL_VOLUME_STEP);

   if(lot<SymbolInfoDouble(symb,SYMBOL_VOLUME_MIN))
     {
      laber("Below the minimum order quantity",Yellow,0);
      return(0);
     }

   if(lot>SymbolInfoDouble(symb,SYMBOL_VOLUME_MAX))
      lot=SymbolInfoDouble(symb,SYMBOL_VOLUME_MAX);

   ulong     t=0;
   double POINT=SymbolInfoDouble(symb,SYMBOL_POINT)*coefficient(symb);
   int DIGITS=(int)SymbolInfoInteger(symb,SYMBOL_DIGITS);
   long deviation=(long)(slippage*coefficient(symb));

   if(type==0 || type==1)
     {
      double AA=0;
      if(type==0)
         check=OrderCalcMargin(ORDER_TYPE_BUY,symb,lot,SymbolInfoDouble(symb,SYMBOL_ASK),AA);
      if(type==1)
         check=OrderCalcMargin(ORDER_TYPE_SELL,symb,lot,SymbolInfoDouble(symb,SYMBOL_BID),AA);
      if(AccountInfoDouble(ACCOUNT_MARGIN_FREE)<AA)
        {
         Print("Insufficient deposit");
         return(0);
        }
     }

   if(type==0 || type==1)
     {
      t=0;
      for(long ix2=0; ix2<3; ix2++)
        {
         ZeroMemory(request);
         ZeroMemory(result);
         request.type_filling=currency_returns_filling(symb);
         request.action=TRADE_ACTION_DEAL;
         request.symbol=symb;
         request.type=type;
         request.volume=lot;
         request.deviation=deviation;
         request.comment=comment;
         request.magic=magicX;
         request.deviation=(ulong)(slippage*coefficient(symb));
         if(type==0)
           {
            request.price=SymbolInfoDouble(symb,SYMBOL_ASK);
            request.tp=insideSL!=0?NormalizeDouble(SymbolInfoDouble(symb,SYMBOL_ASK)+insideSL *POINT,DIGITS):0;
            request.sl=withinSl!=0?NormalizeDouble(SymbolInfoDouble(symb,SYMBOL_ASK)-withinSl *POINT,DIGITS):0;
           }
         if(type==1)
           {
            request.price=SymbolInfoDouble(symb,SYMBOL_BID);
            request.tp=insideSL!=0?NormalizeDouble(SymbolInfoDouble(symb,SYMBOL_BID)-insideSL *POINT,DIGITS):0;
            request.sl=withinSl!=0?NormalizeDouble(SymbolInfoDouble(symb,SYMBOL_BID)+withinSl *POINT,DIGITS):0;
           }
         if(OrderSend(request,result)==false)
            error("");
         else
           {
            t=(long)result.order;
            break;
           }
        }
     }

   if(type==ORDER_TYPE_BUY_LIMIT || type==ORDER_TYPE_BUY_STOP || type==ORDER_TYPE_SELL_LIMIT || type==ORDER_TYPE_SELL_STOP)
     {
      t=0;
      for(long ix2=0; ix2<3; ix2++)
        {
         ZeroMemory(request);
         ZeroMemory(result);
         request.type_filling=currency_returns_filling(symb);
         request.action=TRADE_ACTION_PENDING;
         request.symbol=symb;
         request.type=type;
         request.volume=lot;
         request.deviation=deviation;
         request.comment=comment;
         request.magic=magicX;
         request.deviation=(ulong)(slippage*coefficient(symb));
         if(type==0 || type==ORDER_TYPE_BUY_LIMIT || type==ORDER_TYPE_BUY_STOP)
           {
            if(OpenPrice==0)
               OpenPrice=SymbolInfoDouble(symb,SYMBOL_ASK);
            double price=0;
            if(type==0)
               price=NormalizeDouble(SymbolInfoDouble(symb,SYMBOL_ASK),DIGITS);
            if(type==ORDER_TYPE_BUY_LIMIT)
               price=NormalizeDouble(OpenPrice-interval*POINT,DIGITS);
            if(type==ORDER_TYPE_BUY_STOP)
               price=NormalizeDouble(OpenPrice+interval*POINT,DIGITS);
            request.price=price;
            request.tp=insideSL!=0?NormalizeDouble(price+insideSL *POINT,DIGITS):0;
            request.sl=withinSl!=0?NormalizeDouble(price-withinSl *POINT,DIGITS):0;
           }
         if(type==1 || type==ORDER_TYPE_SELL_LIMIT || type==ORDER_TYPE_SELL_STOP)
           {
            if(OpenPrice==0)
               OpenPrice=SymbolInfoDouble(symb,SYMBOL_BID);
            double price=0;
            if(type==1)
               price=NormalizeDouble(SymbolInfoDouble(symb,SYMBOL_BID),DIGITS);
            if(type==ORDER_TYPE_SELL_LIMIT)
               price=NormalizeDouble(OpenPrice+interval*POINT,DIGITS);
            if(type==ORDER_TYPE_SELL_STOP)
               price=NormalizeDouble(OpenPrice-interval*POINT,DIGITS);
            request.price=price;
            request.tp=insideSL!=0?NormalizeDouble(price-insideSL *POINT,DIGITS):0;
            request.sl=withinSl!=0?NormalizeDouble(price+withinSl *POINT,DIGITS):0;
           }
         if(OrderSend(request,result)==false)
            error("");
         else
           {
            t=(long)result.order;
            break;
           }
        }
     }
   return(t);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//double slippage=30;
//input bool showtextlabels=true;
//input bool spreadadaptation=true;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double coefficient(string symbol)
  {
   double coefficient=1;
   if(
      SymbolInfoInteger(symbol,SYMBOL_DIGITS)==3
      || SymbolInfoInteger(symbol,SYMBOL_DIGITS)==5
      || (StringFind(symbol,"XAU",0)==0 && SymbolInfoInteger(symbol,SYMBOL_DIGITS)==2)
      ||(StringFind(symbol,"GOLD",0)==0&&SymbolInfoInteger(symbol,SYMBOL_DIGITS)==2)
      ||(StringFind(symbol,"Gold",0)==0&&SymbolInfoInteger(symbol,SYMBOL_DIGITS)==2)
      || (StringFind(symbol,"USD_GLD",0)==0 && SymbolInfoInteger(symbol,SYMBOL_DIGITS)==2)
   )
      coefficient=10;
   if(StringFind(symbol,"XAU",0)==0 && SymbolInfoInteger(symbol,SYMBOL_DIGITS)==3)
      coefficient=100;
   if(StringFind(symbol,"GOLD",0)==0 && SymbolInfoInteger(symbol,SYMBOL_DIGITS)==3)
      coefficient=100;
   if(StringFind(symbol,"Gold",0)==0 && SymbolInfoInteger(symbol,SYMBOL_DIGITS)==3)
      coefficient=100;
   if(StringFind(symbol,"USD_GLD",0)==0 && SymbolInfoInteger(symbol,SYMBOL_DIGITS)==3)
      coefficient=100;
   if(spreadadaptation==false)
      return(1);
   return(coefficient);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void laber(string a,color b,long jl)
  {
   Print(a);

   if(showtextlabels==true)
     {
      double hh=ChartGetDouble(0,CHART_PRICE_MAX);
      double ll=ChartGetDouble(0,CHART_PRICE_MIN);
      double textDistance=(hh-ll)*0.03;
      ObjectDelete(0,"arrow"+TimeToString(iTime(Symbol(),0,0),TIME_DATE|TIME_MINUTES)+a);
      ObjectCreate(0,"arrow"+TimeToString(iTime(Symbol(),0,0),TIME_DATE|TIME_MINUTES)+a,OBJ_TEXT,0,iTime(Symbol(),0,0),iLow(Symbol(),0,0)-jl*textDistance);
      ObjectSetString(0,"arrow"+TimeToString(iTime(Symbol(),0,0),TIME_DATE|TIME_MINUTES)+a,OBJPROP_TEXT,a);
      ObjectSetString(0,"arrow"+TimeToString(iTime(Symbol(),0,0),TIME_DATE|TIME_MINUTES)+a,OBJPROP_FONT,"Times New Roman");
      ObjectSetInteger(0,"arrow"+TimeToString(iTime(Symbol(),0,0),TIME_DATE|TIME_MINUTES)+a,OBJPROP_FONTSIZE,8);
      ObjectSetInteger(0,"arrow"+TimeToString(iTime(Symbol(),0,0),TIME_DATE|TIME_MINUTES)+a,OBJPROP_COLOR,b);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void error(string a)
  {
   long t=GetLastError();
   if(t!=0)
     {
      Sleep(300);
      Print(t);
      laber((string)t,Yellow,0);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void laber0(string name,string txt,color Color,datetime Anchor,double OpenPrice,long FontSize,long 定位,int 窗口)
  {
   ObjectDelete(0,name);
   ObjectCreate(0,name,OBJ_TEXT,窗口,Anchor,OpenPrice);
   ObjectSetString(0,name,OBJPROP_TEXT,txt);
   ObjectSetString(0,name,OBJPROP_FONT,"Times New Roman");
   ObjectSetInteger(0,name,OBJPROP_FONTSIZE,FontSize);
   ObjectSetInteger(0,name,OBJPROP_COLOR,Color);
   ObjectSetInteger(0,name,OBJPROP_ANCHOR,定位);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void drawLine(string e,ENUM_OBJECT type,double b,datetime c,color d,long type2,long width)
  {
   ObjectDelete(0,e);
   ObjectCreate(0,e,type,0,0,0);
   ObjectSetDouble(0,e,OBJPROP_PRICE,0,b);
   ObjectSetInteger(0,e,OBJPROP_TIME,0,c);
   ObjectSetInteger(0,e,OBJPROP_COLOR,d);
   ObjectSetInteger(0,e,OBJPROP_STYLE,type2);
   ObjectSetInteger(0,e,OBJPROP_WIDTH,width);
  }


MqlTradeRequest request= {};
MqlTradeResult  result= {};
struct OrderStruct
  {
   ulong             OrderTicket;
   string            OrderSymbol;
   double            OrderClosePrice;
   double            OrderOpenPrice;
   int               OrderType;
   double            OrderStopLoss;
   double            OrderTakeProfit;
   double            POINT;
   int               DIGITS;
   long              OrderMagicNumber;
   string            OrderComment;
   double            OrderLots;
   double            OrderSwap;
   double            OrderProfit;
   datetime          OrderOpenTime;
   ulong             TICKETOUT;
   ulong             TICKETINT;
   double            RemainingLOTS;
   datetime          OrderCloseTime;
   double            LOTSOUT;
   double            LOTSINT;
  };
OrderStruct cc;
bool ReadWriteOrderInformation(ulong OrderTicket,string Hist_Pos_Pend_Order)
  {
   bool Passed=false;
   if(Hist_Pos_Pend_Order=="position")
      if(PositionSelectByTicket(OrderTicket))
        {
         Passed=true;
         cc.OrderTicket=OrderTicket;
         cc.OrderSymbol=PositionGetString(POSITION_SYMBOL);
         cc.OrderClosePrice=PositionGetDouble(POSITION_PRICE_CURRENT);
         cc.OrderOpenPrice=PositionGetDouble(POSITION_PRICE_OPEN);
         cc.OrderType=(int)PositionGetInteger(POSITION_TYPE);
         cc.OrderStopLoss=PositionGetDouble(POSITION_SL);
         cc.OrderTakeProfit=PositionGetDouble(POSITION_TP);
         cc.POINT=SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT);
         cc.DIGITS=(int)SymbolInfoInteger(cc.OrderSymbol,SYMBOL_DIGITS);
         cc.OrderMagicNumber=(long)PositionGetInteger(POSITION_MAGIC);
         cc.OrderComment=PositionGetString(POSITION_COMMENT);
         cc.OrderLots=PositionGetDouble(POSITION_VOLUME);
         cc.OrderSwap=PositionGetDouble(POSITION_SWAP);
         cc.OrderProfit=PositionGetDouble(POSITION_PROFIT);
         cc.OrderOpenTime=(datetime)PositionGetInteger(POSITION_TIME);
        }
   if(Hist_Pos_Pend_Order=="pending order")
      if(OrderSelect(OrderTicket))
        {
         Passed=true;
         cc.OrderTicket=OrderTicket;
         cc.OrderSymbol=OrderGetString(ORDER_SYMBOL);
         cc.OrderClosePrice=OrderGetDouble(ORDER_PRICE_CURRENT);
         cc.OrderOpenPrice=OrderGetDouble(ORDER_PRICE_OPEN);
         cc.OrderType=(int)OrderGetInteger(ORDER_TYPE);
         cc.OrderStopLoss=OrderGetDouble(ORDER_SL);
         cc.OrderTakeProfit=OrderGetDouble(ORDER_TP);
         cc.POINT=SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT);
         cc.DIGITS=(int)SymbolInfoInteger(cc.OrderSymbol,SYMBOL_DIGITS);
         cc.OrderMagicNumber=OrderGetInteger(ORDER_MAGIC);
         cc.OrderComment=OrderGetString(ORDER_COMMENT);
         cc.OrderLots=OrderGetDouble(ORDER_VOLUME_CURRENT);
         cc.OrderProfit=0;
         cc.OrderOpenTime=(datetime)OrderGetInteger(ORDER_TIME_SETUP);
        }
   if(
      (Hist_Pos_Pend_Order=="position"&&PositionSelectByTicket(OrderTicket))
      ||(Hist_Pos_Pend_Order=="pending order"&&OrderSelect(OrderTicket))
   )
     {
      Passed=true;
      ZeroMemory(request);
      ZeroMemory(result);
      request.action=TRADE_ACTION_DEAL;
      request.magic=cc.OrderMagicNumber;
      if(Hist_Pos_Pend_Order=="pending order")
         request.order=cc.OrderTicket;
      request.symbol=cc.OrderSymbol;
      request.volume=cc.OrderLots;
      request.price=cc.OrderClosePrice;
      //request.stoplimit=;        // 订单止损限价点位
      request.sl=cc.OrderStopLoss;
      request.tp=cc.OrderTakeProfit;
      request.deviation=(ulong)(slippage*coefficient(cc.OrderSymbol));
      request.type=(ENUM_ORDER_TYPE)cc.OrderType;
      request.type_filling=currency_returns_filling(cc.OrderSymbol);
      //request.type_time=;        // 订单执行时间
      //request.expiration=;       // 订单终止期 (为 ORDER_TIME_SPECIFIED 类型订单)
      request.comment=cc.OrderComment;
      if(Hist_Pos_Pend_Order=="position")
         request.position=cc.OrderTicket;
      //request.position_by=;      // 反向持仓编号
     }

   if(Hist_Pos_Pend_Order=="Historical positions"||Hist_Pos_Pend_Order=="History pending order")
      HistorySelect(fixedandletime,TimeCurrent());

   if(Hist_Pos_Pend_Order=="Historical positions")
      if(HistoryDealSelect(OrderTicket))
        {
         Passed=true;
         cc.TICKETOUT=OrderTicket;
         cc.OrderTicket=HistoryDealGetInteger(cc.TICKETOUT,DEAL_POSITION_ID);
         cc.TICKETINT=0;
         HistorySelect(fixedandletime,TimeCurrent());
         for(int i2=HistoryDealsTotal()-1; i2>=0; i2--)
            if(HistoryDealGetInteger(HistoryDealGetTicket(i2),DEAL_ENTRY)==DEAL_ENTRY_IN)
               if(HistoryDealGetInteger(HistoryDealGetTicket(i2),DEAL_POSITION_ID)==cc.OrderTicket)
                 {
                  cc.TICKETINT=HistoryDealGetTicket(i2);
                  break;
                 }
         cc.OrderSymbol=HistoryDealGetString(cc.TICKETINT,DEAL_SYMBOL);
         cc.OrderClosePrice=HistoryDealGetDouble(cc.TICKETOUT,DEAL_PRICE);
         cc.OrderOpenPrice=HistoryDealGetDouble(cc.TICKETINT,DEAL_PRICE);
         cc.OrderType=(int)HistoryDealGetInteger(cc.TICKETINT,DEAL_TYPE);
         cc.OrderStopLoss=HistoryDealGetDouble(cc.TICKETOUT,DEAL_SL);
         cc.OrderTakeProfit=HistoryDealGetDouble(cc.TICKETOUT,DEAL_TP);
         cc.POINT=SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT);
         cc.DIGITS=(int)SymbolInfoInteger(cc.OrderSymbol,SYMBOL_DIGITS);
         cc.OrderMagicNumber=HistoryDealGetInteger(cc.TICKETINT,DEAL_MAGIC);//未落实
         cc.OrderComment=HistoryDealGetString(cc.TICKETOUT,DEAL_COMMENT);
         cc.LOTSOUT=HistoryDealGetDouble(cc.TICKETOUT,DEAL_VOLUME);
         cc.LOTSINT=HistoryDealGetDouble(cc.TICKETINT,DEAL_VOLUME);
         cc.OrderSwap=HistoryDealGetDouble(cc.TICKETOUT,DEAL_SWAP);//未落实
         cc.OrderProfit=HistoryDealGetDouble(cc.TICKETOUT,DEAL_PROFIT);
         cc.OrderOpenTime=(datetime)HistoryDealGetInteger(cc.TICKETINT,DEAL_TIME);
         cc.OrderCloseTime=(datetime)HistoryDealGetInteger(cc.TICKETOUT,DEAL_TIME);
         cc.RemainingLOTS=0;
         if(PositionSelectByTicket(cc.OrderTicket))
            cc.RemainingLOTS=PositionGetDouble(POSITION_VOLUME);
        }

   if(Hist_Pos_Pend_Order=="History pending order")
      if(HistoryOrderSelect(OrderTicket))
        {
         Passed=true;
         cc.OrderTicket=OrderTicket;
         cc.OrderSymbol=HistoryOrderGetString(cc.OrderTicket,ORDER_SYMBOL);
         cc.OrderOpenPrice=HistoryOrderGetDouble(cc.OrderTicket,ORDER_PRICE_OPEN);
         cc.OrderType=(int)HistoryOrderGetInteger(cc.OrderTicket,ORDER_TYPE);
         cc.OrderStopLoss=HistoryOrderGetDouble(cc.OrderTicket,ORDER_SL);
         cc.OrderTakeProfit=HistoryOrderGetDouble(cc.OrderTicket,ORDER_TP);
         cc.POINT=SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT);
         cc.DIGITS=(int)SymbolInfoInteger(cc.OrderSymbol,SYMBOL_DIGITS);
         cc.OrderMagicNumber=HistoryOrderGetInteger(cc.OrderTicket,ORDER_MAGIC);
         cc.OrderComment=HistoryOrderGetString(cc.OrderTicket,ORDER_COMMENT);
         cc.OrderLots=HistoryOrderGetDouble(cc.OrderTicket,ORDER_VOLUME_INITIAL);
         cc.OrderOpenTime=(datetime)HistoryOrderGetInteger(cc.OrderTicket,ORDER_TIME_SETUP);
         cc.OrderCloseTime=(datetime)HistoryOrderGetInteger(cc.OrderTicket,ORDER_TIME_DONE);
        }
   return(Passed);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ENUM_ORDER_TYPE_FILLING currency_returns_filling(string symbol)
  {
   uint filling=(uint)SymbolInfoInteger(symbol,SYMBOL_FILLING_MODE);
   if((filling&SYMBOL_FILLING_FOK)==SYMBOL_FILLING_FOK)
      return(ORDER_FILLING_FOK);
   if((filling&SYMBOL_FILLING_IOC)==SYMBOL_FILLING_IOC)
      return(ORDER_FILLING_IOC);
   return(ORDER_FILLING_IOC);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
