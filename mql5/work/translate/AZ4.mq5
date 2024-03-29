//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
input bool Show_message_box=true;// Show message box
enum 做单方向
  {
   Buy=1,Sell=2,
  };
input 做单方向 Positions=1;// Positions
input bool Hedge_option=true;// Hedge option
input double trade_entry_price=0;// trade entry price
input double stop_loss_price=0;// stop loss price
input double target_price=0;// target price
input double target_calculating_adjustment_price=0;// target calculating adjustment price
input bool target_profit_booking_fuction=true;// target profit booking fuction
input double quantity=0.1;// quantity
enum XLK1
  {
   Multiplication=1,
   Addition=2,
  };
input XLK1 Reverse_adjustment_method=2;// Reverse adjustment method
input double Loss_reversal_adjustment=2;// Loss reversal adjustment
double 止损=0;//SL
double 止盈=0;//TP
string 备注="";//Remarks
input int magic=15420;
input string comm1X="----------------------------";//  ----------------------------
double 滑点=30;
bool 是否显示文字标签=true;//Whether to display text labels//Whether to display text labels
input bool Use_Pips=true;// Use Pips
datetime 程序最终编译时间=__DATETIME__;//Program final compilation time
long check;
long X=20;
long Y=20;
long Y间隔=15;
color 标签颜色=Yellow;
long 标签字体大小=10;
ENUM_BASE_CORNER 固定角=0;
//////////////////////////////////////////////////////////////
datetime time1,time2;
datetime 启动时间;
double close=0;
string NAME;
bool 是否显示信息框;
做单方向 做单方向选择;
bool 对冲选项;
double 进场价格;
double 止损价格;
double 目标价格;
double 目标调价格;
bool 达到目标平仓开关;
double 单量;
XLK1 反向调整方式;
double 亏损反向调整;
bool 国际点差自适应;
int OnInit()
  {
是否显示信息框=Show_message_box;
做单方向选择=Positions;
对冲选项=Hedge_option;
进场价格=trade_entry_price;
止损价格=stop_loss_price;
目标价格=target_price;
目标调价格=target_calculating_adjustment_price;
达到目标平仓开关=target_profit_booking_fuction;
单量=quantity;
反向调整方式=Reverse_adjustment_method;
亏损反向调整=Loss_reversal_adjustment;
国际点差自适应=Use_Pips;



   NAME=(string)ChartID();
//Alert("急速模式程序,修改参数后需重置EA开关");
   启动时间=TimeCurrent();

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



   if(分项单据统计(-100,magic,"")==0)
     {
      画直线("JC",1,进场价格,0,Red,0,0);
      画直线("ZS",1,止损价格,0,clrYellow,0,0);
      画直线("MB",1,目标价格,0,clrAqua,0,0);

      if(
         (iClose(Symbol(),0,0)>=进场价格&&close<进场价格)
         ||(iClose(Symbol(),0,0)<=进场价格&&close>进场价格)
      )
        {
         if(做单方向选择==1 || 做单方向选择==3)
            ulong t1=建立单据(Symbol(),ENUM_ORDER_TYPE(对冲选项==false?0:1),单量,0,0,止损,止盈,备注,magic);

         if(做单方向选择==2 || 做单方向选择==3)
            ulong t2=建立单据(Symbol(),ENUM_ORDER_TYPE(对冲选项==false?1:0),单量,0,0,止损,止盈,备注,magic);
        }
     }
   else
     {
      if(读写订单信息(findlassorder(-100,-100,magic,"后","现在","",0),"持仓"))
        {
         if(cc.OrderType==(对冲选项==false?0:1)&&iClose(Symbol(),0,0)>=ObjectGetDouble(0,"MB",OBJPROP_PRICE,0))
           {
            double 进场X=ObjectGetDouble(0,"JC",OBJPROP_PRICE,0);
            double 止损X=ObjectGetDouble(0,"ZS",OBJPROP_PRICE,0);
            double 目标X=ObjectGetDouble(0,"MB",OBJPROP_PRICE,0);

            画直线("JC",1,目标X,0,Red,0,0);
            画直线("ZS",1,目标X-MathAbs(进场价格-止损价格),0,clrYellow,0,0);
            画直线("MB",1,目标X+MathAbs(进场价格-目标价格),0,clrAqua,0,0);

            if(达到目标平仓开关)
              {
               request.action=TRADE_ACTION_DEAL;
               if(cc.OrderType==POSITION_TYPE_BUY)
                  request.type=1;
               if(cc.OrderType==POSITION_TYPE_SELL)
                  request.type=0;
               request.tp=0;
               request.sl=0;

               if(OrderSend(request,result))
                  ulong t1=建立单据(Symbol(),ENUM_ORDER_TYPE(对冲选项==false?0:1),单量,0,0,止损,止盈,备注,magic);
              }
           }
         else
            if(cc.OrderType==(对冲选项==false?1:0)&&iClose(Symbol(),0,0)<=ObjectGetDouble(0,"MB",OBJPROP_PRICE,0))
              {
               double 进场X=ObjectGetDouble(0,"JC",OBJPROP_PRICE,0);
               double 止损X=ObjectGetDouble(0,"ZS",OBJPROP_PRICE,0);
               double 目标X=ObjectGetDouble(0,"MB",OBJPROP_PRICE,0);

               画直线("JC",1,目标X,0,Red,0,0);
               画直线("ZS",1,目标X+MathAbs(进场价格-止损价格),0,clrYellow,0,0);
               画直线("MB",1,目标X-MathAbs(进场价格-目标价格),0,clrAqua,0,0);

               if(达到目标平仓开关)
                 {
                  request.action=TRADE_ACTION_DEAL;
                  if(cc.OrderType==POSITION_TYPE_BUY)
                     request.type=1;
                  if(cc.OrderType==POSITION_TYPE_SELL)
                     request.type=0;
                  request.tp=0;
                  request.sl=0;

                  if(OrderSend(request,result))
                     ulong t1=建立单据(Symbol(),ENUM_ORDER_TYPE(对冲选项==false?1:0),单量,0,0,止损,止盈,备注,magic);
                 }
              }
            else
               if(
                  (cc.OrderType==(对冲选项==false?0:1)&&iClose(Symbol(),0,0)<=ObjectGetDouble(0,"ZS",OBJPROP_PRICE,0))
                  ||(cc.OrderType==(对冲选项==false?1:0)&&iClose(Symbol(),0,0)>=ObjectGetDouble(0,"ZS",OBJPROP_PRICE,0))
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
                     if(反向调整方式==1)
                        lots=cc.OrderLots*亏损反向调整;
                     if(反向调整方式==2)
                        lots=cc.OrderLots+亏损反向调整;

                     if(
                        (cc.OrderType==(对冲选项==false?0:1)&&cc.OrderClosePrice>=cc.OrderOpenPrice)
                        ||(cc.OrderType==(对冲选项==false?1:0)&&cc.OrderClosePrice<=cc.OrderOpenPrice)
                     )
                        lots=单量;

                     double 进场X=ObjectGetDouble(0,"JC",OBJPROP_PRICE,0);
                     double 止损X=ObjectGetDouble(0,"ZS",OBJPROP_PRICE,0);
                     double 目标X=ObjectGetDouble(0,"MB",OBJPROP_PRICE,0);

                     if(cc.OrderType==(对冲选项==false?1:0))
                       {
                        ulong t1=建立单据(Symbol(),ENUM_ORDER_TYPE(对冲选项==false?0:1),lots,0,0,止损,止盈,备注,magic);

                        画直线("JC",1,止损X-目标调价格,0,Red,0,0);
                        画直线("ZS",1,止损X-目标调价格-MathAbs(进场价格-止损价格),0,clrYellow,0,0);
                        画直线("MB",1,止损X-目标调价格+MathAbs(进场价格-目标价格),0,clrAqua,0,0);
                       }
                     else
                       {
                        ulong t2=建立单据(Symbol(),ENUM_ORDER_TYPE(对冲选项==false?1:0),lots,0,0,止损,止盈,备注,magic);

                        画直线("JC",1,止损X+目标调价格,0,Red,0,0);
                        画直线("ZS",1,止损X+目标调价格+MathAbs(进场价格-止损价格),0,clrYellow,0,0);
                        画直线("MB",1,止损X+目标调价格-MathAbs(进场价格-目标价格),0,clrAqua,0,0);
                       }
                    }
                 }
        }
     }

   close=iClose(Symbol(),0,0);

   if(是否显示信息框)
      if(MQLInfoInteger(MQL_OPTIMIZATION)==false)
         if(MQLInfoInteger(MQL_TESTER)==false||MQLInfoInteger(MQL_VISUAL_MODE))
           {
            string 内容[100];
            int pp=0;
            内容[pp]="";
            pp++;
            内容[pp]="Platform provider:" +AccountInfoString(ACCOUNT_COMPANY)+" Leverage:"+DoubleToString(AccountInfoInteger(ACCOUNT_LEVERAGE),0);
            pp++;
            内容[pp]="Magic:"+(string)magic;
            pp++;
            内容[pp]="Start time:"+DoubleToString((TimeCurrent()-启动时间)/60/60,1)+"Hours";
            pp++;
            内容[pp]="------------------------------------";
            pp++;
            内容[pp]="BUY Number:"+(string)分项单据统计(0,magic,"");
            pp++;
            内容[pp]="BUY Profit:"+DoubleToString(分类单据利润(0,magic,""),2);
            pp++;
            内容[pp]="BUY Lots:"+DoubleToString(总交易量(0,magic,""),2);
            pp++;
            内容[pp]="------------------------------------";
            pp++;
            内容[pp]="SELL Number:"+(string)分项单据统计(1,magic,"");
            pp++;
            内容[pp]="SELL Profit:"+DoubleToString(分类单据利润(1,magic,""),2);
            pp++;
            内容[pp]="SELL Lots:"+DoubleToString(总交易量(1,magic,""),2);
            pp++;
            内容[pp]="------------------------------------";
            pp++;
            内容[pp]="Total profit:"+DoubleToString(分类单据利润(-100,magic,""),2);
            pp++;
            内容[pp]="------------------------------------";
            pp++;

            for(int ixx=0; ixx<pp; ixx++)
               固定位置标签("BQ"+(string)ixx,内容[ixx],X,Y+Y间隔*ixx+(ChartGetInteger(0,CHART_SHOW_ONE_CLICK)==0?0:60),标签颜色,标签字体大小,固定角);
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
void 获利后一次性止损保护(long typeX,double 保护距离,double 启动距离,long magicX,string comm)
  {
   for(int i=PositionsTotal()-1; i>=0; i--)
      if(读写订单信息(PositionGetTicket(i),"持仓"))
         if(cc.OrderTicket>0)
            if(cc.OrderSymbol==Symbol())
               if(cc.OrderMagicNumber==magicX || magicX==-1)
                  if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                     if(typeX==-100 || typeX==-200 || typeX==cc.OrderType)
                        if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                          {
                           if(cc.OrderType==0)
                              if(cc.OrderClosePrice-cc.OrderOpenPrice>=启动距离*cc.POINT*系数(cc.OrderSymbol))
                                 if(cc.OrderStopLoss+cc.POINT<cc.OrderOpenPrice+保护距离*cc.POINT*系数(cc.OrderSymbol) || cc.OrderStopLoss==0)
                                   {
                                    request.action=TRADE_ACTION_SLTP;
                                    request.sl=NormalizeDouble(cc.OrderOpenPrice+保护距离*cc.POINT*系数(cc.OrderSymbol),cc.DIGITS);
                                    check=OrderSend(request,result);
                                   }
                           if(cc.OrderType==1)
                              if(cc.OrderOpenPrice-cc.OrderClosePrice>=启动距离*cc.POINT*系数(cc.OrderSymbol))
                                 if(cc.OrderStopLoss-cc.POINT>cc.OrderOpenPrice-保护距离 *cc.POINT*系数(cc.OrderSymbol) || cc.OrderStopLoss==0)
                                   {
                                    request.action=TRADE_ACTION_SLTP;
                                    request.sl=NormalizeDouble(cc.OrderOpenPrice-保护距离*cc.POINT*系数(cc.OrderSymbol),cc.DIGITS);
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
void 批量修改止盈止损(long typeX,double 止盈内,double 止损内,long magicX,string comm)
  {
   if(止盈内!=0)
      for(int i=PositionsTotal()-1; i>=0; i--)
         if(读写订单信息(PositionGetTicket(i),"持仓"))
            if(cc.OrderTicket>0)
               if(cc.OrderSymbol==Symbol())
                  if(cc.OrderMagicNumber==magicX || magicX==-1)
                     if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                        if(typeX==-100 || typeX==-200 || typeX==cc.OrderType)
                           if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                             {
                              if(cc.OrderType==0)
                                 if(cc.OrderTakeProfit>NormalizeDouble(止盈内,cc.DIGITS)+SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT) || cc.OrderTakeProfit<NormalizeDouble(止盈内,cc.DIGITS)-SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT))
                                    //if(cc.OrderTakeProfit>NormalizeDouble(止盈内,cc.DIGITS)+SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT))
                                   {
                                    request.action=TRADE_ACTION_SLTP;
                                    request.tp=NormalizeDouble(止盈内,cc.DIGITS);
                                    check=OrderSend(request,result);
                                   }
                              if(cc.OrderType==1)
                                 if(cc.OrderTakeProfit>NormalizeDouble(止盈内,cc.DIGITS)+SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT) || cc.OrderTakeProfit<NormalizeDouble(止盈内,cc.DIGITS)-SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT))
                                    //if(cc.OrderTakeProfit<NormalizeDouble(止盈内,cc.DIGITS)-SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT))
                                   {
                                    request.action=TRADE_ACTION_SLTP;
                                    request.tp=NormalizeDouble(止盈内,cc.DIGITS);
                                    check=OrderSend(request,result);
                                   }
                             }

   if(止损内!=0)
      for(int i=PositionsTotal()-1; i>=0; i--)
         if(读写订单信息(PositionGetTicket(i),"持仓"))
            if(cc.OrderTicket>0)
               if(cc.OrderSymbol==Symbol())
                  if(cc.OrderMagicNumber==magicX || magicX==-1)
                     if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                        if(typeX==-100 || typeX==-200 || typeX==cc.OrderType)
                           if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                             {
                              if(cc.OrderType==0)
                                 //if(cc.OrderStopLoss>NormalizeDouble(止损内,cc.DIGITS)+SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT) || cc.OrderStopLoss<NormalizeDouble(止损内,cc.DIGITS)-SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT))
                                 if(cc.OrderStopLoss<NormalizeDouble(止损内,cc.DIGITS)-SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT) || cc.OrderStopLoss==0)
                                   {
                                    request.action=TRADE_ACTION_SLTP;
                                    request.sl=NormalizeDouble(止损内,cc.DIGITS);
                                    check=OrderSend(request,result);
                                   }
                              if(cc.OrderType==1)
                                 //if(cc.OrderStopLoss>NormalizeDouble(止损内,cc.DIGITS)+SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT) || cc.OrderStopLoss<NormalizeDouble(止损内,cc.DIGITS)-SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT))
                                 if(cc.OrderStopLoss>NormalizeDouble(止损内,cc.DIGITS)+SymbolInfoDouble(cc.OrderSymbol,SYMBOL_POINT) || cc.OrderStopLoss==0)
                                   {
                                    request.action=TRADE_ACTION_SLTP;
                                    request.sl=NormalizeDouble(止损内,cc.DIGITS);
                                    check=OrderSend(request,result);
                                   }
                             }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void 移动止损距离比例(long typeX,double 启动距离1,double 启动距离2,long 回调模式,double 保持距离,double 保持比例,long magicX,string comm)
  {
   for(int i=PositionsTotal()-1; i>=0; i--)
      if(读写订单信息(PositionGetTicket(i),"持仓"))
         if(cc.OrderTicket>0)
            if(cc.OrderSymbol==Symbol())
               if(cc.OrderMagicNumber==magicX || magicX==-1)
                  if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                     if(typeX==-100 || typeX==-200 || typeX==cc.OrderType)
                        if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                          {
                           double 保持距离X=0;
                           if(回调模式==1)
                              保持距离X=保持距离;
                           if(回调模式==2)
                              保持距离X=MathAbs(cc.OrderClosePrice-cc.OrderOpenPrice)*保持比例/100/cc.POINT/系数(cc.OrderSymbol);
                           if(cc.OrderType==0)
                              if(cc.OrderClosePrice-cc.OrderOpenPrice>启动距离1*cc.POINT*系数(cc.OrderSymbol))
                                 if(启动距离2==0||cc.OrderClosePrice-cc.OrderOpenPrice<=启动距离2*cc.POINT*系数(cc.OrderSymbol))
                                    if(NormalizeDouble(cc.OrderClosePrice-(保持距离X*系数(cc.OrderSymbol)+1)*cc.POINT,cc.DIGITS)>=cc.OrderStopLoss || cc.OrderStopLoss==0)
                                      {
                                       request.action=TRADE_ACTION_SLTP;
                                       request.sl=NormalizeDouble(cc.OrderClosePrice-保持距离X*系数(cc.OrderSymbol)*cc.POINT,cc.DIGITS);
                                       check=OrderSend(request,result);
                                      }
                           if(cc.OrderType==1)
                              if(-cc.OrderClosePrice+cc.OrderOpenPrice>启动距离1*cc.POINT*系数(cc.OrderSymbol))
                                 if(启动距离2==0||-cc.OrderClosePrice+cc.OrderOpenPrice<=启动距离2*cc.POINT*系数(cc.OrderSymbol))
                                    if(NormalizeDouble(cc.OrderClosePrice+(保持距离X*系数(cc.OrderSymbol)+1)*cc.POINT,cc.DIGITS)<=cc.OrderStopLoss || cc.OrderStopLoss==0)
                                      {
                                       request.action=TRADE_ACTION_SLTP;
                                       request.sl=NormalizeDouble(cc.OrderClosePrice+保持距离X*系数(cc.OrderSymbol)*cc.POINT,cc.DIGITS);
                                       check=OrderSend(request,result);
                                      }
                          }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ulong 最高最低单据订单号(long a,long b,long magicX,string HL,string comm,long pc1,long pc2)
  {
   double 价格=0;
   ulong 订单号=0;
   for(int i=PositionsTotal()-1; i>=0; i--)
      if(读写订单信息(PositionGetTicket(i),"持仓"))
         if(cc.OrderTicket>0)
            if(cc.OrderTicket!=pc1 && cc.OrderTicket!=pc2)
               if(cc.OrderSymbol==Symbol())
                  if(cc.OrderMagicNumber==magicX || magicX==-1)
                     if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                        if(cc.OrderType==a || cc.OrderType==b || a==-100 || b==-100 || a==-200 || b==-200)
                           if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                             {
                              if(((价格==0 || 价格>cc.OrderOpenPrice) && HL=="L")
                                 || ((价格==0 || 价格<cc.OrderOpenPrice) && HL=="H"))
                                {
                                 价格=cc.OrderOpenPrice;
                                 订单号=cc.OrderTicket;
                                }
                             }

   for(int i=OrdersTotal()-1; i>=0; i--)
      if(读写订单信息(OrderGetTicket(i),"挂单"))
         if(cc.OrderTicket>0)
            if(cc.OrderTicket!=pc1 && cc.OrderTicket!=pc2)
               if(cc.OrderSymbol==Symbol())
                  if(cc.OrderMagicNumber==magicX || magicX==-1)
                     if(cc.OrderType==ORDER_TYPE_BUY_LIMIT || cc.OrderType==ORDER_TYPE_SELL_LIMIT || cc.OrderType==ORDER_TYPE_BUY_STOP || cc.OrderType==ORDER_TYPE_SELL_STOP || cc.OrderType==ORDER_TYPE_BUY_STOP_LIMIT || cc.OrderType==ORDER_TYPE_SELL_STOP_LIMIT)
                        if(cc.OrderType==a || cc.OrderType==b || a==-100 || b==-100 || a==-300 || b==-300)
                           if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                             {
                              if(((价格==0 || 价格>cc.OrderOpenPrice) && HL=="L")
                                 || ((价格==0 || 价格<cc.OrderOpenPrice) && HL=="H"))
                                {
                                 价格=cc.OrderOpenPrice;
                                 订单号=cc.OrderTicket;
                                }
                             }
   return(订单号);
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
void 按钮(string name,string txt1,string txt2,long XX,long YX,long XL,long YL,long WZ,color A,color B)
  {
   if(ObjectFind(0,name)==-1)
      ObjectCreate(0,name,OBJ_BUTTON,0,0,0);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,XX);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,YX);
   ObjectSetInteger(0,name,OBJPROP_XSIZE,XL);
   ObjectSetInteger(0,name,OBJPROP_YSIZE,YL);
   ObjectSetString(0,name,OBJPROP_FONT,"微软雅黑");
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
ulong findlassorder(long type1,long type2,long magicX,string fx,string 现在与历史,string comm,long 排除)
  {
   if(现在与历史=="现在")
      if(fx=="后")
         for(int i=PositionsTotal()-1; i>=0; i--)
            if(读写订单信息(PositionGetTicket(i),"持仓"))
               if(cc.OrderTicket>0)
                  if(cc.OrderSymbol==Symbol())
                     if(cc.OrderMagicNumber==magicX || magicX==-1)
                        if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                           if(cc.OrderType==type1 || cc.OrderType==type2 || type1==-100 || type2==-100 || type1==-200 || type2==-200)
                              if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                                 return(cc.OrderTicket);

   if(现在与历史=="现在")
      if(fx=="前")
         for(int i=0; i<PositionsTotal(); i++)
            if(读写订单信息(PositionGetTicket(i),"持仓"))
               if(cc.OrderTicket>0)
                  if(cc.OrderSymbol==Symbol())
                     if(cc.OrderMagicNumber==magicX || magicX==-1)
                        if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                           if(cc.OrderType==type1 || cc.OrderType==type2 || type1==-100 || type2==-100 || type1==-200 || type2==-200)
                              if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                                 return(cc.OrderTicket);

   if(现在与历史=="现在")
      if(fx=="后")
         for(int i=OrdersTotal()-1; i>=0; i--)
            if(读写订单信息(OrderGetTicket(i),"挂单"))
               if(cc.OrderTicket>0)
                  if(cc.OrderSymbol==Symbol())
                     if(cc.OrderMagicNumber==magicX || magicX==-1)
                        if(cc.OrderType==ORDER_TYPE_BUY_LIMIT || cc.OrderType==ORDER_TYPE_SELL_LIMIT || cc.OrderType==ORDER_TYPE_BUY_STOP || cc.OrderType==ORDER_TYPE_SELL_STOP || cc.OrderType==ORDER_TYPE_BUY_STOP_LIMIT || cc.OrderType==ORDER_TYPE_SELL_STOP_LIMIT)
                           if(cc.OrderType==type1 || cc.OrderType==type2 || type1==-100 || type2==-100 || type1==-300 || type2==-300)
                              if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                                 return(cc.OrderTicket);

   if(现在与历史=="现在")
      if(fx=="前")
         for(int i=0; i<OrdersTotal(); i++)
            if(读写订单信息(OrderGetTicket(i),"挂单"))
               if(cc.OrderTicket>0)
                  if(cc.OrderSymbol==Symbol())
                     if(cc.OrderMagicNumber==magicX || magicX==-1)
                        if(cc.OrderType==ORDER_TYPE_BUY_LIMIT || cc.OrderType==ORDER_TYPE_SELL_LIMIT || cc.OrderType==ORDER_TYPE_BUY_STOP || cc.OrderType==ORDER_TYPE_SELL_STOP || cc.OrderType==ORDER_TYPE_BUY_STOP_LIMIT || cc.OrderType==ORDER_TYPE_SELL_STOP_LIMIT)
                           if(cc.OrderType==type1 || cc.OrderType==type2 || type1==-100 || type2==-100 || type1==-300 || type2==-300)
                              if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                                 return(cc.OrderTicket);

   HistorySelect(启动时间,TimeCurrent());
   if(现在与历史=="历史")
      if(fx=="后")
         for(int i=HistoryDealsTotal()-1; i>=0; i--)
            if(HistoryDealGetInteger(HistoryDealGetTicket(i),DEAL_ENTRY)==DEAL_ENTRY_OUT)
               if(读写订单信息(HistoryDealGetTicket(i),"历史持仓"))
                  if(cc.OrderTicket>0)
                     if(cc.OrderSymbol==Symbol())
                        if(cc.OrderMagicNumber==magicX || magicX==-1)
                           if(cc.OrderType==DEAL_TYPE_BUY || cc.OrderType==DEAL_TYPE_SELL)
                              if(cc.OrderType==type1 || cc.OrderType==type2 || type1==-100 || type2==-100 || type1==-200 || type2==-200)
                                 if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                                    return(cc.TICKETOUT);
   HistorySelect(启动时间,TimeCurrent());
   if(现在与历史=="历史")
      if(fx=="前")
         for(int i=0; i<HistoryDealsTotal(); i++)
            if(HistoryDealGetInteger(HistoryDealGetTicket(i),DEAL_ENTRY)==DEAL_ENTRY_OUT)
               if(读写订单信息(HistoryDealGetTicket(i),"历史持仓"))
                  if(cc.OrderTicket>0)
                     if(cc.OrderSymbol==Symbol())
                        if(cc.OrderMagicNumber==magicX || magicX==-1)
                           if(cc.OrderType==DEAL_TYPE_BUY || cc.OrderType==DEAL_TYPE_SELL)
                              if(cc.OrderType==type1 || cc.OrderType==type2 || type1==-100 || type2==-100 || type1==-200 || type2==-200)
                                 if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                                    return(cc.TICKETOUT);
   HistorySelect(启动时间,TimeCurrent());
   if(现在与历史=="历史")
      if(fx=="后")
         for(int i=HistoryOrdersTotal()-1; i>=0; i--)
            if(读写订单信息(HistoryOrderGetTicket(i),"历史挂单"))
               if(cc.OrderTicket>0)
                  if(cc.OrderSymbol==Symbol())
                     if(cc.OrderMagicNumber==magicX || magicX==-1)
                        if(cc.OrderType==ORDER_TYPE_BUY_LIMIT || cc.OrderType==ORDER_TYPE_SELL_LIMIT || cc.OrderType==ORDER_TYPE_BUY_STOP || cc.OrderType==ORDER_TYPE_SELL_STOP || cc.OrderType==ORDER_TYPE_BUY_STOP_LIMIT || cc.OrderType==ORDER_TYPE_SELL_STOP_LIMIT)
                           if(cc.OrderType==type1 || cc.OrderType==type2 || type1==-100 || type2==-100 || type1==-300 || type2==-300)
                              if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                                 return(cc.OrderTicket);
   HistorySelect(启动时间,TimeCurrent());
   if(现在与历史=="历史")
      if(fx=="前")
         for(int i=0; i<HistoryOrdersTotal(); i++)
            if(读写订单信息(HistoryOrderGetTicket(i),"历史挂单"))
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
      if(读写订单信息(PositionGetTicket(i),"持仓"))
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
      if(读写订单信息(OrderGetTicket(i),"挂单"))
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
long 分项单据统计(long typeX,long magicX,string comm)
  {
   long 数量=0;
   for(int i=PositionsTotal()-1; i>=0; i--)
      if(读写订单信息(PositionGetTicket(i),"持仓"))
         if(cc.OrderTicket>0)
            if(cc.OrderSymbol==Symbol())
               if(cc.OrderMagicNumber==magicX || magicX==-1)
                  if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                     if(cc.OrderType==typeX || typeX==-100 || typeX==-200)
                        if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                           数量++;

   for(int i=OrdersTotal()-1; i>=0; i--)
      if(读写订单信息(OrderGetTicket(i),"挂单"))
         if(cc.OrderTicket>0)
            if(cc.OrderSymbol==Symbol())
               if(cc.OrderMagicNumber==magicX || magicX==-1)
                  if(cc.OrderType==ORDER_TYPE_BUY_LIMIT || cc.OrderType==ORDER_TYPE_SELL_LIMIT || cc.OrderType==ORDER_TYPE_BUY_STOP || cc.OrderType==ORDER_TYPE_SELL_STOP || cc.OrderType==ORDER_TYPE_BUY_STOP_LIMIT || cc.OrderType==ORDER_TYPE_SELL_STOP_LIMIT)
                     if(cc.OrderType==typeX || typeX==-100 || typeX==-300)
                        if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                           数量++;

   return(数量);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double 分类单据利润(long typeX,long magicX,string comm)
  {
   double 利润=0;
   for(int i=PositionsTotal()-1; i>=0; i--)
      if(读写订单信息(PositionGetTicket(i),"持仓"))
         if(cc.OrderTicket>0)
            if(cc.OrderSymbol==Symbol())
               if(cc.OrderMagicNumber==magicX || magicX==-1)
                  if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                     if(cc.OrderType==typeX || typeX==-100 || typeX==-200)
                        if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                           利润+=(cc.OrderProfit+cc.OrderSwap);//OrderCommission()

   return(利润);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double 总交易量(long typeX,long magicX,string comm)
  {
   double 交易量=0;
   for(int i=PositionsTotal()-1; i>=0; i--)
      if(读写订单信息(PositionGetTicket(i),"持仓"))
         if(cc.OrderTicket>0)
            if(cc.OrderSymbol==Symbol())
               if(cc.OrderMagicNumber==magicX || magicX==-1)
                  if(cc.OrderType==POSITION_TYPE_BUY || cc.OrderType==POSITION_TYPE_SELL)
                     if(cc.OrderType==typeX || typeX==-100 || typeX==-200)
                        if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                           交易量+=cc.OrderLots;

   for(int i=OrdersTotal()-1; i>=0; i--)
      if(读写订单信息(OrderGetTicket(i),"挂单"))
         if(cc.OrderTicket>0)
            if(cc.OrderSymbol==Symbol())
               if(cc.OrderMagicNumber==magicX || magicX==-1)
                  if(cc.OrderType==ORDER_TYPE_BUY_LIMIT || cc.OrderType==ORDER_TYPE_SELL_LIMIT || cc.OrderType==ORDER_TYPE_BUY_STOP || cc.OrderType==ORDER_TYPE_SELL_STOP || cc.OrderType==ORDER_TYPE_BUY_STOP_LIMIT || cc.OrderType==ORDER_TYPE_SELL_STOP_LIMIT)
                     if(cc.OrderType==typeX || typeX==-100 || typeX==-300)
                        if(StringFind(cc.OrderComment,comm,0)!=-1 || comm=="")
                           交易量+=cc.OrderLots;

   return(交易量);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void 固定位置标签(string 名称,string 内容,long XX,long YX,color C,long 字体大小,long 固定角内)
  {
   if(内容==NULL||内容=="")
      return;
   if(ObjectFind(0,名称)==-1)
     {
      ObjectDelete(0,名称);
      ObjectCreate(0,名称,OBJ_LABEL,0,0,0);
     }
   ObjectSetInteger(0,名称,OBJPROP_XDISTANCE,XX);
   ObjectSetInteger(0,名称,OBJPROP_YDISTANCE,YX);
   ObjectSetString(0,名称,OBJPROP_TEXT,内容);
   ObjectSetString(0,名称,OBJPROP_FONT,"宋体");
   ObjectSetInteger(0,名称,OBJPROP_FONTSIZE,字体大小);
   ObjectSetInteger(0,名称,OBJPROP_COLOR,C);
   ObjectSetInteger(0,名称,OBJPROP_CORNER,固定角内);
   ObjectSetInteger(0,名称,OBJPROP_ANCHOR,ANCHOR_LEFT);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ulong 建立单据(string 货币对,ENUM_ORDER_TYPE 类型,double 单量内,double 价位,double 间隔,double 止损内,double 止盈内,string 备注内,long magicX)
  {
   备注内=备注内+"-"+EnumToString(Period())+"-"+(string)magicX;

   if(SymbolInfoDouble(货币对,SYMBOL_VOLUME_STEP)!=0)
      单量内=NormalizeDouble(单量内/SymbolInfoDouble(货币对,SYMBOL_VOLUME_STEP),0)*SymbolInfoDouble(货币对,SYMBOL_VOLUME_STEP);

   if(单量内<SymbolInfoDouble(货币对,SYMBOL_VOLUME_MIN))
     {
      laber("Below the minimum order quantity",Yellow,0);
      return(0);
     }

   if(单量内>SymbolInfoDouble(货币对,SYMBOL_VOLUME_MAX))
      单量内=SymbolInfoDouble(货币对,SYMBOL_VOLUME_MAX);

   ulong     t=0;
   double POINT=SymbolInfoDouble(货币对,SYMBOL_POINT)*系数(货币对);
   int DIGITS=(int)SymbolInfoInteger(货币对,SYMBOL_DIGITS);
   long 滑点内=(long)(滑点*系数(货币对));

   if(类型==0 || 类型==1)
     {
      double AA=0;
      if(类型==0)
         check=OrderCalcMargin(ORDER_TYPE_BUY,货币对,单量内,SymbolInfoDouble(货币对,SYMBOL_ASK),AA);
      if(类型==1)
         check=OrderCalcMargin(ORDER_TYPE_SELL,货币对,单量内,SymbolInfoDouble(货币对,SYMBOL_BID),AA);
      if(AccountInfoDouble(ACCOUNT_MARGIN_FREE)<AA)
        {
         Print("Insufficient deposit");
         return(0);
        }
     }

   if(类型==0 || 类型==1)
     {
      t=0;
      for(long ix2=0; ix2<3; ix2++)
        {
         ZeroMemory(request);
         ZeroMemory(result);
         request.type_filling=币种返回filling(货币对);
         request.action=TRADE_ACTION_DEAL;
         request.symbol=货币对;
         request.type=类型;
         request.volume=单量内;
         request.deviation=滑点内;
         request.comment=备注内;
         request.magic=magicX;
         request.deviation=(ulong)(滑点*系数(货币对));
         if(类型==0)
           {
            request.price=SymbolInfoDouble(货币对,SYMBOL_ASK);
            request.tp=止盈内!=0?NormalizeDouble(SymbolInfoDouble(货币对,SYMBOL_ASK)+止盈内 *POINT,DIGITS):0;
            request.sl=止损内!=0?NormalizeDouble(SymbolInfoDouble(货币对,SYMBOL_ASK)-止损内 *POINT,DIGITS):0;
           }
         if(类型==1)
           {
            request.price=SymbolInfoDouble(货币对,SYMBOL_BID);
            request.tp=止盈内!=0?NormalizeDouble(SymbolInfoDouble(货币对,SYMBOL_BID)-止盈内 *POINT,DIGITS):0;
            request.sl=止损内!=0?NormalizeDouble(SymbolInfoDouble(货币对,SYMBOL_BID)+止损内 *POINT,DIGITS):0;
           }
         if(OrderSend(request,result)==false)
            报错组件("");
         else
           {
            t=(long)result.order;
            break;
           }
        }
     }

   if(类型==ORDER_TYPE_BUY_LIMIT || 类型==ORDER_TYPE_BUY_STOP || 类型==ORDER_TYPE_SELL_LIMIT || 类型==ORDER_TYPE_SELL_STOP)
     {
      t=0;
      for(long ix2=0; ix2<3; ix2++)
        {
         ZeroMemory(request);
         ZeroMemory(result);
         request.type_filling=币种返回filling(货币对);
         request.action=TRADE_ACTION_PENDING;
         request.symbol=货币对;
         request.type=类型;
         request.volume=单量内;
         request.deviation=滑点内;
         request.comment=备注内;
         request.magic=magicX;
         request.deviation=(ulong)(滑点*系数(货币对));
         if(类型==0 || 类型==ORDER_TYPE_BUY_LIMIT || 类型==ORDER_TYPE_BUY_STOP)
           {
            if(价位==0)
               价位=SymbolInfoDouble(货币对,SYMBOL_ASK);
            double price=0;
            if(类型==0)
               price=NormalizeDouble(SymbolInfoDouble(货币对,SYMBOL_ASK),DIGITS);
            if(类型==ORDER_TYPE_BUY_LIMIT)
               price=NormalizeDouble(价位-间隔*POINT,DIGITS);
            if(类型==ORDER_TYPE_BUY_STOP)
               price=NormalizeDouble(价位+间隔*POINT,DIGITS);
            request.price=price;
            request.tp=止盈内!=0?NormalizeDouble(price+止盈内 *POINT,DIGITS):0;
            request.sl=止损内!=0?NormalizeDouble(price-止损内 *POINT,DIGITS):0;
           }
         if(类型==1 || 类型==ORDER_TYPE_SELL_LIMIT || 类型==ORDER_TYPE_SELL_STOP)
           {
            if(价位==0)
               价位=SymbolInfoDouble(货币对,SYMBOL_BID);
            double price=0;
            if(类型==1)
               price=NormalizeDouble(SymbolInfoDouble(货币对,SYMBOL_BID),DIGITS);
            if(类型==ORDER_TYPE_SELL_LIMIT)
               price=NormalizeDouble(价位+间隔*POINT,DIGITS);
            if(类型==ORDER_TYPE_SELL_STOP)
               price=NormalizeDouble(价位-间隔*POINT,DIGITS);
            request.price=price;
            request.tp=止盈内!=0?NormalizeDouble(price-止盈内 *POINT,DIGITS):0;
            request.sl=止损内!=0?NormalizeDouble(price+止损内 *POINT,DIGITS):0;
           }
         if(OrderSend(request,result)==false)
            报错组件("");
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
//double 滑点=30;
//input bool 是否显示文字标签=true;
//input bool 国际点差自适应=true;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double 系数(string symbol)
  {
   double 系数=1;
   if(
      SymbolInfoInteger(symbol,SYMBOL_DIGITS)==3
      || SymbolInfoInteger(symbol,SYMBOL_DIGITS)==5
      || (StringFind(symbol,"XAU",0)==0 && SymbolInfoInteger(symbol,SYMBOL_DIGITS)==2)
      ||(StringFind(symbol,"GOLD",0)==0&&SymbolInfoInteger(symbol,SYMBOL_DIGITS)==2)
      ||(StringFind(symbol,"Gold",0)==0&&SymbolInfoInteger(symbol,SYMBOL_DIGITS)==2)
      || (StringFind(symbol,"USD_GLD",0)==0 && SymbolInfoInteger(symbol,SYMBOL_DIGITS)==2)
   )
      系数=10;
   if(StringFind(symbol,"XAU",0)==0 && SymbolInfoInteger(symbol,SYMBOL_DIGITS)==3)
      系数=100;
   if(StringFind(symbol,"GOLD",0)==0 && SymbolInfoInteger(symbol,SYMBOL_DIGITS)==3)
      系数=100;
   if(StringFind(symbol,"Gold",0)==0 && SymbolInfoInteger(symbol,SYMBOL_DIGITS)==3)
      系数=100;
   if(StringFind(symbol,"USD_GLD",0)==0 && SymbolInfoInteger(symbol,SYMBOL_DIGITS)==3)
      系数=100;
   if(国际点差自适应==false)
      return(1);
   return(系数);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void laber(string a,color b,long jl)
  {
   Print(a);

   if(是否显示文字标签==true)
     {
      double hh=ChartGetDouble(0,CHART_PRICE_MAX);
      double ll=ChartGetDouble(0,CHART_PRICE_MIN);
      double 文字小距离=(hh-ll)*0.03;
      ObjectDelete(0,"箭头"+TimeToString(iTime(Symbol(),0,0),TIME_DATE|TIME_MINUTES)+a);
      ObjectCreate(0,"箭头"+TimeToString(iTime(Symbol(),0,0),TIME_DATE|TIME_MINUTES)+a,OBJ_TEXT,0,iTime(Symbol(),0,0),iLow(Symbol(),0,0)-jl*文字小距离);
      ObjectSetString(0,"箭头"+TimeToString(iTime(Symbol(),0,0),TIME_DATE|TIME_MINUTES)+a,OBJPROP_TEXT,a);
      ObjectSetString(0,"箭头"+TimeToString(iTime(Symbol(),0,0),TIME_DATE|TIME_MINUTES)+a,OBJPROP_FONT,"Times New Roman");
      ObjectSetInteger(0,"箭头"+TimeToString(iTime(Symbol(),0,0),TIME_DATE|TIME_MINUTES)+a,OBJPROP_FONTSIZE,8);
      ObjectSetInteger(0,"箭头"+TimeToString(iTime(Symbol(),0,0),TIME_DATE|TIME_MINUTES)+a,OBJPROP_COLOR,b);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void 报错组件(string a)
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
void laber0(string name,string txt,color 颜色,datetime 时间,double 价位,long 字体大小,long 定位,int 窗口)
  {
   ObjectDelete(0,name);
   ObjectCreate(0,name,OBJ_TEXT,窗口,时间,价位);
   ObjectSetString(0,name,OBJPROP_TEXT,txt);
   ObjectSetString(0,name,OBJPROP_FONT,"Times New Roman");
   ObjectSetInteger(0,name,OBJPROP_FONTSIZE,字体大小);
   ObjectSetInteger(0,name,OBJPROP_COLOR,颜色);
   ObjectSetInteger(0,name,OBJPROP_ANCHOR,定位);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void 画直线(string e,ENUM_OBJECT type,double b,datetime c,color d,long type2,long width)
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
struct 单据数据
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
   double            剩余LOTS;
   datetime          OrderCloseTime;
   double            LOTSOUT;
   double            LOTSINT;
  };
单据数据 cc;
bool 读写订单信息(ulong OrderTicket,string 持仓_挂单_历史持仓_历史挂单X)
  {
   bool 成功通过=false;
   if(持仓_挂单_历史持仓_历史挂单X=="持仓")
      if(PositionSelectByTicket(OrderTicket))
        {
         成功通过=true;
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
   if(持仓_挂单_历史持仓_历史挂单X=="挂单")
      if(OrderSelect(OrderTicket))
        {
         成功通过=true;
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
      (持仓_挂单_历史持仓_历史挂单X=="持仓"&&PositionSelectByTicket(OrderTicket))
      ||(持仓_挂单_历史持仓_历史挂单X=="挂单"&&OrderSelect(OrderTicket))
   )
     {
      成功通过=true;
      ZeroMemory(request);
      ZeroMemory(result);
      request.action=TRADE_ACTION_DEAL;
      request.magic=cc.OrderMagicNumber;
      if(持仓_挂单_历史持仓_历史挂单X=="挂单")
         request.order=cc.OrderTicket;
      request.symbol=cc.OrderSymbol;
      request.volume=cc.OrderLots;
      request.price=cc.OrderClosePrice;
      //request.stoplimit=;        // 订单止损限价点位
      request.sl=cc.OrderStopLoss;
      request.tp=cc.OrderTakeProfit;
      request.deviation=(ulong)(滑点*系数(cc.OrderSymbol));
      request.type=(ENUM_ORDER_TYPE)cc.OrderType;
      request.type_filling=币种返回filling(cc.OrderSymbol);
      //request.type_time=;        // 订单执行时间
      //request.expiration=;       // 订单终止期 (为 ORDER_TIME_SPECIFIED 类型订单)
      request.comment=cc.OrderComment;
      if(持仓_挂单_历史持仓_历史挂单X=="持仓")
         request.position=cc.OrderTicket;
      //request.position_by=;      // 反向持仓编号
     }

   if(持仓_挂单_历史持仓_历史挂单X=="历史持仓"||持仓_挂单_历史持仓_历史挂单X=="历史挂单")
      HistorySelect(启动时间,TimeCurrent());

   if(持仓_挂单_历史持仓_历史挂单X=="历史持仓")
      if(HistoryDealSelect(OrderTicket))
        {
         成功通过=true;
         cc.TICKETOUT=OrderTicket;
         cc.OrderTicket=HistoryDealGetInteger(cc.TICKETOUT,DEAL_POSITION_ID);
         cc.TICKETINT=0;
         HistorySelect(启动时间,TimeCurrent());
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
         cc.剩余LOTS=0;
         if(PositionSelectByTicket(cc.OrderTicket))
            cc.剩余LOTS=PositionGetDouble(POSITION_VOLUME);
        }

   if(持仓_挂单_历史持仓_历史挂单X=="历史挂单")
      if(HistoryOrderSelect(OrderTicket))
        {
         成功通过=true;
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
   return(成功通过);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ENUM_ORDER_TYPE_FILLING 币种返回filling(string symbol)
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
