//+------------------------------------------------------------------+
//|                                             ANDRESS_SMART_EA.mq4 |
//|                                                         batttoot |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "batttoot"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


   ///// functions to market type
enum markettype
{
Open_Sell=1,
Open_Buy=2, 
Open_Sell_Buy=3 
};
 
  ///// functions to enumerate the close moods 
enum Closemod
{
Profit_Loss=1,
TP_SL =2,
Profit_in_Pip=3

 };
 // General EA inputs for user 
extern string          General_EA_SetUP       = "------< General_SetUP >------";
input markettype       Market_Order_Type      = Open_Buy;
input double           Lots                   = 0.1;
input int              Magic_number           = 2015;
input string           Order_comment          = "   EA ";
input double           Max_Spread             = 100;
extern string          FIRST_GRID_SetUP       = "------< FIRST GRID SETTINGS >------";
input bool             FIRST_GRID             = true;
input markettype       Market_Order_Type_1    = Open_Buy;
input int              Magic_number_1         = 1;
input string           Order_comment_1        = "1st";
input double           Max_Spread_1           = 100;
input int              Max_orders_1           = 10;
input int              New_OrderStep_1        = 5; 
input int              Anti_MartingaleStep_1  = 5; 
input double           fixed_lot_1            = 0.1;
input bool             UseMultiple_1          = true;
input double           Multi_1                = 2;
input double           AddLot_1               = 0.1;
input double           MaxLot_1               = 1;
extern string          SECOND_GRID_SetUP      = "------< SECOND GRID SETTINGS >------";
input bool             SECOND_GRID            = true;
input markettype       Market_Order_Type_2    = Open_Buy;
input int              Magic_number_2         = 2;
input string           Order_comment_2        = "2nd";
input double           Max_Spread_2           = 100;
input int              Max_orders_2           = 10;
input int              New_OrderStep_2        = 5; 
input int              Anti_MartingaleStep_2  = 5; 
input double           fixed_lot_2            = 0.1;
input bool             UseMultiple_2          = true;
input double           Multi_2                = 2;
input double           AddLot_2               = 0.1;
input double           MaxLot_2               = 1;
extern string          THIRD_GRID_SetUP       = "------< THIRD GRID SETTINGS >------";
input bool             THIRD_GRID             = true;
input markettype       Market_Order_Type_3    = Open_Buy;
input int              Magic_number_3         =  3;
input string           Order_comment_3        = "3rd";
input double           Max_Spread_3           = 100;
input int              Max_orders_3           = 10;
input int              New_OrderStep_3        = 5; 
input int              Anti_MartingaleStep_3  = 5; 
input double           fixed_lot_3            = 0.1;
input bool             UseMultiple_3          = true;
input double           Multi_3                = 2;
input double           AddLot_3               = 0.1;
input double           MaxLot_3               = 1;
extern string          FOURTH_GRID_SetUP      = "------< FOURTH GRID SETTINGS >------";
input bool             FOURTH_GRID            = true;
input markettype       Market_Order_Type_4    = Open_Buy;
input int              Magic_number_4         = 4;
input string           Order_comment_4        = "4th";
input double           Max_Spread_4           = 100;
input int              Max_orders_4           = 10;
input int              New_OrderStep_4        = 5; 
input int              Anti_MartingaleStep_4  = 5; 
input double           fixed_lot_4            = 0.1;
input bool             UseMultiple_4          = true;
input double           Multi_4                = 2;
input double           AddLot_4               = 0.1;
input double           MaxLot_4               = 1;
extern string          FIFTH_GRID_SetUP       = "------< FIFTH GRID SETTINGS >------";
input bool             FIFTH_GRID             = true;
input markettype       Market_Order_Type_5    = Open_Buy;
input int              Magic_number_5         = 5;
input string           Order_comment_5        = "5th";
input double           Max_Spread_5           = 100;
input int              Max_orders_5           = 10;
input int              New_OrderStep_5        = 5; 
input int              Anti_MartingaleStep_5  = 5; 
input double           fixed_lot_5            = 0.1;
input bool             UseMultiple_5          = true;
input double           Multi_5                = 2;
input double           AddLot_5               = 0.1;
input double           MaxLot_5               = 1;
extern string          Trailing_SetUP         = "------< Trailing_SetUP >------";
input bool             Use_Trailing           = false;
input int              TrailingStop           = 50;
input int              TrailingStep           = 20; 
extern string          Clos_SetUP_1           = "------< Close_1_SetUP >------";
input Closemod         Close_Mood_1           =Profit_Loss;
input double           Profit_Close_1         = 20;
input double           Loss_Close_1           = 5000;
input double           Profit_Pip_1           = 20;
input double           Loss_Pip_1             = 5000;
input double           Take_Profit_1          = 200;
input double           Stop_loss_1            = 200;
extern string          Clos_SetUP_2           = "------< Close_2_SetUP >------";
input Closemod         Close_Mood_2           =Profit_Loss;
input double           Profit_Close_2         = 20;
input double           Loss_Close_2           = 5000;
input double           Profit_Pip_2           = 20;
input double           Loss_pip_2             = 5000;
input double           Take_Profit_2          = 200;
input double           Stop_loss_2            = 200;
extern string          Clos_SetUP_3           = "------< Close_3_SetUP >------";
input Closemod         Close_Mood_3           =Profit_Loss;
input double           Profit_Close_3         = 20;
input double           Loss_Close_3           = 5000;
input double           Profit_pip_3           = 20;
input double           Loss_pip_3             = 5000;
input double           Take_Profit_3          = 200;
input double           Stop_loss_3            = 200;
extern string          Clos_SetUP_4           = "------< Close_4_SetUP >------";
input Closemod         Close_Mood_4           =Profit_Loss;
input double           Profit_Close_4         = 20;
input double           Loss_Close_4           = 5000;
input double           Profit_Pip_4           = 20;
input double           Loss_Pip_4             = 5000;
input double           Take_Profit_4          = 200;
input double           Stop_loss_4            = 200;
extern string          Clos_SetUP_5           = "------< Close_5_SetUP >------";
input Closemod         Close_Mood_5           =Profit_Loss;
input double           Profit_Close_5         = 20;
input double           Loss_Close_5           = 5000;
input double           Profit_Pip_5           = 20;
input double           Loss_Pip_5             = 5000;
input double           Take_Profit_5          = 200;
input double           Stop_loss_5            = 200;


// Global variables for EA use 
double pt=1;
int TrailingProfit;
int i1=1;
int i2=1;
int i3=1;
int i4=1;
int i5=1;
int i6=1;
int i7=1;
int i8=1;
int i9=1;
int i0=1;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
      if (Digits == 3 || Digits == 5) pt = 10; else pt=1; 
   
   
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


  
 


indicator_code();
 
 ChartSetInteger(0,CHART_SHOW_GRID,false);
  
 
 
   
ObjectDelete("Lable2");
   ObjectCreate("Lable2", OBJ_LABEL, 0, 0, 1.0);
   ObjectSet("Lable2", OBJPROP_CORNER, 3);
   ObjectSet("Lable2", OBJPROP_XDISTANCE, 153);
   ObjectSet("Lable2", OBJPROP_YDISTANCE, 31);
   string g_dbl2str_1112 = DoubleToStr(AccountBalance(), 2);
   ObjectSetText("Lable2", "Account BALANCE:  " + g_dbl2str_1112 + "", 16, "Times New Roman", DodgerBlue);
   ObjectDelete("Lable3");
   ObjectCreate("Lable3", OBJ_LABEL, 0, 0, 1.0);
   ObjectSet("Lable3", OBJPROP_CORNER, 3);
   ObjectSet("Lable3", OBJPROP_XDISTANCE, 153);
   ObjectSet("Lable3", OBJPROP_YDISTANCE, 11);
   
   
   string g_dbl2str_1120 = DoubleToStr(AccountEquity(), 2);
   ObjectSetText("Lable3", "Account EQUITY:  " + g_dbl2str_1120 + "", 16, "Times New Roman", DodgerBlue);
 
  
   //+------------------------------------------------------------------+
    
     
//Firest Operation 
   
 if(  MarketInfo(Symbol(),MODE_SPREAD)<=Max_Spread  )
{ 
 
if((Market_Order_Type==Open_Buy || Market_Order_Type==Open_Sell_Buy)&& count_for_type(OP_BUY)==0)
 {
      if(OrderSend(Symbol(),OP_BUY,Lots,Ask,30,0,0,"Buy"+Order_comment ,Magic_number ,0,Green)==false){GetLastError();}

 } 
 if((Market_Order_Type==Open_Sell || Market_Order_Type==Open_Sell_Buy)&& count_for_type(OP_SELL)==0)
 {
      if(OrderSend(Symbol(),OP_SELL,Lots,Bid,30,0,0,"Sell"+Order_comment ,Magic_number ,0,Red)==false){GetLastError();}
     
 }
 }
 
 //Firest Grid 
 if(FIRST_GRID==true)
   {
   if(  MarketInfo(Symbol(),MODE_SPREAD)<=Max_Spread_1  )
{ 
if((Market_Order_Type_1==Open_Buy || Market_Order_Type_1==Open_Sell_Buy))
 {
 if(count_for_type(OP_BUY)>0 && count_chart_1(Symbol())<Max_orders_1)
 {
 if(Close[0]<=lowsell_1(OP_BUY)-New_OrderStep_1*pt*Point)
 {
 if(UseMultiple_1==true)
   {
    
  if(OrderSend(Symbol(),OP_BUY,MathMin(MaxLot_1,FindLastOrderParameterMarket_1("lot",OP_BUY)*Multi_1)+AddLot_1,Ask,30,0,0,Order_comment_1+"buy"+IntegerToString(count_for_type_1(OP_BUY)+1,0,0) ,Magic_number_1 ,0,Green)==false){GetLastError();}
  }
  else
    if(OrderSend(Symbol(),OP_BUY,fixed_lot_1+(AddLot_1*i1),Ask,30,0,0,Order_comment_1+"buy"+IntegerToString(count_for_type_1(OP_BUY)+1,0,0) ,Magic_number_1 ,0,Green)==false){GetLastError();}i1++;
  if(Close_Mood_1 ==TP_SL)
    {
    Modify_1();
    }
 }
 }
 
 
 if(count_for_type(OP_BUY)>0 && count_chart_1(Symbol())<Max_orders_1)
 {
 if(Close[0]>=highbuy_1(OP_BUY)+Anti_MartingaleStep_1*pt*Point)
 {
  if(OrderSend(Symbol(),OP_BUY,MathMax(MarketInfo(Symbol(),MODE_MINLOT),FindLastOrderParameterMarket_1("lot",OP_BUY)-MarketInfo(Symbol(),MODE_MINLOT))+AddLot_1,Ask,30,0,0,Order_comment_1+"buy"+IntegerToString(count_for_type_1(OP_BUY)+1,0,0) ,Magic_number_1 ,0,Green)==false){GetLastError();}
   if(Close_Mood_1 ==TP_SL)
    {
    Modify_1();
    }
 }
 }
 }
 
  if((Market_Order_Type_1==Open_Sell || Market_Order_Type_1==Open_Sell_Buy))
  {
  if(count_for_type(OP_SELL)>0&& count_chart_1(Symbol())<Max_orders_1)
 {
 if(Close[0]>=highbuy_1(OP_SELL)+New_OrderStep_1*pt*Point)
 {
  if(UseMultiple_1==true)
   {
  if(OrderSend(Symbol(),OP_SELL,MathMin(MaxLot_1,FindLastOrderParameterMarket_1("lot",OP_SELL)*Multi_1)+AddLot_1,Bid,30,0,0,Order_comment_1+"sell"+IntegerToString(count_for_type_1(OP_SELL)+1,0,0) ,Magic_number_1 ,0,Red)==false){GetLastError();}
  }
  else
    if(OrderSend(Symbol(),OP_SELL,fixed_lot_1+(AddLot_1*i2),Bid,30,0,0,Order_comment_1+"sell"+IntegerToString(count_for_type_1(OP_SELL)+1,0,0) ,Magic_number_1 ,0,Red)==false){GetLastError();}i2++;
    if(Close_Mood_1 ==TP_SL)
    {
    Modify_1();
    }
 }
 }
 
 
  if(count_for_type(OP_SELL)>0 && count_chart_1(Symbol())<Max_orders_1)
 {
 if(Close[0]<=lowsell_1(OP_SELL)-Anti_MartingaleStep_1*pt*Point)
 {
  if(OrderSend(Symbol(),OP_SELL,MathMax(MarketInfo(Symbol(),MODE_MINLOT),FindLastOrderParameterMarket_1("lot",OP_SELL)-MarketInfo(Symbol(),MODE_MINLOT))+AddLot_1,Bid,30,0,0,Order_comment_1+"sell"+IntegerToString(count_for_type_1(OP_SELL)+1,0,0) ,Magic_number_1 ,0,Red)==false){GetLastError();}
    if(Close_Mood_1 ==TP_SL)
    {
    Modify_1();
    }
 }
 }
 }
 }
 }
 
  //Second Grid 
  if(SECOND_GRID==true)
    {
   if(  MarketInfo(Symbol(),MODE_SPREAD)<=Max_Spread_2  )
{ 
if((Market_Order_Type_2==Open_Buy || Market_Order_Type_2==Open_Sell_Buy))
 {
 if(count_for_type(OP_BUY)>0 && count_chart_2(Symbol())<Max_orders_2)
 {
 if(Close[0]<=lowsell_2(OP_BUY)-New_OrderStep_2*pt*Point)
 {
 if(UseMultiple_2==true)
   {
    
  if(OrderSend(Symbol(),OP_BUY,MathMin(MaxLot_2,FindLastOrderParameterMarket_2("lot",OP_BUY)*Multi_2)+AddLot_2,Ask,30,0,0,Order_comment_2+"buy"+IntegerToString(count_for_type_2(OP_BUY)+1,0,0) ,Magic_number_2 ,0,Green)==false){GetLastError();}
  }
  else
    if(OrderSend(Symbol(),OP_BUY,fixed_lot_2+(AddLot_2*i3),Ask,30,0,0,Order_comment_2+"buy"+IntegerToString(count_for_type_2(OP_BUY)+1,0,0) ,Magic_number_2 ,0,Green)==false){GetLastError();}i3++;
   if(Close_Mood_2 ==TP_SL)
    {
    Modify_2();
    }
 }
 }
 
 
 if(count_for_type(OP_BUY)>0 && count_chart_2(Symbol())<Max_orders_2)
 {
 if(Close[0]>=highbuy_2(OP_BUY)+Anti_MartingaleStep_2*pt*Point)
 {
  if(OrderSend(Symbol(),OP_BUY,MathMax(MarketInfo(Symbol(),MODE_MINLOT),FindLastOrderParameterMarket_2("lot",OP_BUY)-MarketInfo(Symbol(),MODE_MINLOT))+AddLot_2,Ask,30,0,0,Order_comment_2+"buy"+IntegerToString(count_for_type_2(OP_BUY)+1,0,0) ,Magic_number_2 ,0,Green)==false){GetLastError();}
   if(Close_Mood_2 ==TP_SL)
    {
    Modify_2();
    }
 }
 }
 }
 
  if((Market_Order_Type_2==Open_Sell || Market_Order_Type_2==Open_Sell_Buy))
  {
  if(count_for_type(OP_SELL)>0&& count_chart_2(Symbol())<Max_orders_2)
 {
 if(Close[0]>=highbuy_2(OP_SELL)+New_OrderStep_2*pt*Point)
 {
  if(UseMultiple_2==true)
   {
  if(OrderSend(Symbol(),OP_SELL,MathMin(MaxLot_2,FindLastOrderParameterMarket_2("lot",OP_SELL)*Multi_2)+AddLot_2,Bid,30,0,0,Order_comment_2+"sell"+IntegerToString(count_for_type_2(OP_SELL)+1,0,0) ,Magic_number_2 ,0,Red)==false){GetLastError();}
  }
  else
    if(OrderSend(Symbol(),OP_SELL,fixed_lot_2+(AddLot_2*i4),Bid,30,0,0,Order_comment_2+"sell"+IntegerToString(count_for_type_2(OP_SELL)+1,0,0) ,Magic_number_2 ,0,Red)==false){GetLastError();}i4++;
   if(Close_Mood_2 ==TP_SL)
    {
    Modify_2();
    }
 }
 }
 
 
  if(count_for_type(OP_SELL)>0 && count_chart_2(Symbol())<Max_orders_2)
 {
 if(Close[0]<=lowsell_2(OP_SELL)-Anti_MartingaleStep_2*pt*Point)
 {
  if(OrderSend(Symbol(),OP_SELL,MathMax(MarketInfo(Symbol(),MODE_MINLOT)+AddLot_2,FindLastOrderParameterMarket_2("lot",OP_SELL)-MarketInfo(Symbol(),MODE_MINLOT)),Bid,30,0,0,Order_comment_2+"sell"+IntegerToString(count_for_type_2(OP_SELL)+1,0,0) ,Magic_number_2 ,0,Red)==false){GetLastError();}
   if(Close_Mood_2 ==TP_SL)
    {
    Modify_2();
    }
 }
 }
 }
 }
 }
 
//Third Grid 
if(THIRD_GRID==true)
  {
   if(  MarketInfo(Symbol(),MODE_SPREAD)<=Max_Spread_3  )
{ 
if((Market_Order_Type_3==Open_Buy || Market_Order_Type_3==Open_Sell_Buy))
 {
 if(count_for_type(OP_BUY)>0 && count_chart_3(Symbol())<Max_orders_3)
 {
 if(Close[0]<=lowsell_3(OP_BUY)-New_OrderStep_3*pt*Point)
 {
 if(UseMultiple_3==true)
   {
    
  if(OrderSend(Symbol(),OP_BUY,MathMin(MaxLot_3,FindLastOrderParameterMarket_3("lot",OP_BUY)*Multi_3)+AddLot_3,Ask,30,0,0,Order_comment_3+"buy"+IntegerToString(count_for_type_3(OP_BUY)+1,0,0) ,Magic_number_3 ,0,Green)==false){GetLastError();}
  }
  else
    if(OrderSend(Symbol(),OP_BUY,fixed_lot_3+(AddLot_3*i5),Ask,30,0,0,Order_comment_3+"buy"+IntegerToString(count_for_type_3(OP_BUY)+1,0,0) ,Magic_number_3 ,0,Green)==false){GetLastError();}i5++;
    if(Close_Mood_3 ==TP_SL)
    {
    Modify_3();
    }
 }
 }
 
 
 if(count_for_type(OP_BUY)>0 && count_chart_3(Symbol())<Max_orders_3)
 {
 if(Close[0]>=highbuy_3(OP_BUY)+Anti_MartingaleStep_3*pt*Point)
 {
  if(OrderSend(Symbol(),OP_BUY,MathMax(MarketInfo(Symbol(),MODE_MINLOT),FindLastOrderParameterMarket_3("lot",OP_BUY)-MarketInfo(Symbol(),MODE_MINLOT))+AddLot_3,Ask,30,0,0,Order_comment_3+"buy"+IntegerToString(count_for_type_3(OP_BUY)+1,0,0) ,Magic_number_3 ,0,Green)==false){GetLastError();}
    if(Close_Mood_3 ==TP_SL)
    {
    Modify_3();
    }
 }
 }
 }
 
  if((Market_Order_Type_3==Open_Sell || Market_Order_Type_3==Open_Sell_Buy))
  {
  if(count_for_type(OP_SELL)>0&& count_chart_3(Symbol())<Max_orders_3)
 {
 if(Close[0]>=highbuy_3(OP_SELL)+New_OrderStep_3*pt*Point)
 {
  if(UseMultiple_3==true)
   {
  if(OrderSend(Symbol(),OP_SELL,MathMin(MaxLot_3,FindLastOrderParameterMarket_3("lot",OP_SELL)*Multi_3)+AddLot_3,Bid,30,0,0,Order_comment_3+"sell"+IntegerToString(count_for_type_3(OP_SELL)+1,0,0) ,Magic_number_3 ,0,Red)==false){GetLastError();}
  }
  else
    if(OrderSend(Symbol(),OP_SELL,fixed_lot_3+(AddLot_3*i6),Bid,30,0,0,Order_comment_3+"sell"+IntegerToString(count_for_type_3(OP_SELL)+1,0,0) ,Magic_number_3 ,0,Red)==false){GetLastError();}i6++;
    if(Close_Mood_3 ==TP_SL)
    {
    Modify_3();
    }
 }
 }
 
 
  if(count_for_type(OP_SELL)>0 && count_chart_3(Symbol())<Max_orders_3)
 {
 if(Close[0]<=lowsell_3(OP_SELL)-Anti_MartingaleStep_3*pt*Point)
 {
  if(OrderSend(Symbol(),OP_SELL,MathMax(MarketInfo(Symbol(),MODE_MINLOT)+AddLot_3,FindLastOrderParameterMarket_3("lot",OP_SELL)-MarketInfo(Symbol(),MODE_MINLOT)),Bid,30,0,0,Order_comment_3+"sell"+IntegerToString(count_for_type_3(OP_SELL)+1,0,0) ,Magic_number_3 ,0,Red)==false){GetLastError();}
   if(Close_Mood_3 ==TP_SL)
    {
    Modify_3();
    }
 }
 }
 }
 }
 }
 //Fourth Grid 
 if(FOURTH_GRID==true)
   {
   if(  MarketInfo(Symbol(),MODE_SPREAD)<=Max_Spread_4  )
{ 
if((Market_Order_Type_4==Open_Buy || Market_Order_Type_4==Open_Sell_Buy))
 {
 if(count_for_type(OP_BUY)>0 && count_chart_4(Symbol())<Max_orders_4)
 {
 if(Close[0]<=lowsell_4(OP_BUY)-New_OrderStep_4*pt*Point)
 {
 if(UseMultiple_4==true)
   {
    
  if(OrderSend(Symbol(),OP_BUY,MathMin(MaxLot_4,FindLastOrderParameterMarket_4("lot",OP_BUY)*Multi_4)+AddLot_4,Ask,30,0,0,Order_comment_4+"buy"+IntegerToString(count_for_type_4(OP_BUY)+1,0,0) ,Magic_number_4 ,0,Green)==false){GetLastError();}
  }
  else
    if(OrderSend(Symbol(),OP_BUY,fixed_lot_4+(AddLot_4*i7),Ask,30,0,0,Order_comment_4+"buy"+IntegerToString(count_for_type_4(OP_BUY)+1,0,0) ,Magic_number_4 ,0,Green)==false){GetLastError();}i7++;
   if(Close_Mood_4 ==TP_SL)
    {
    Modify_4();
    }
 }
 }
 
 
 if(count_for_type(OP_BUY)>0 && count_chart_4(Symbol())<Max_orders_4)
 {
 if(Close[0]>=highbuy_4(OP_BUY)+Anti_MartingaleStep_4*pt*Point)
 {
  if(OrderSend(Symbol(),OP_BUY,MathMax(MarketInfo(Symbol(),MODE_MINLOT),FindLastOrderParameterMarket_4("lot",OP_BUY)-MarketInfo(Symbol(),MODE_MINLOT))+AddLot_4,Ask,30,0,0,Order_comment_4+"buy"+IntegerToString(count_for_type_4(OP_BUY)+1,0,0) ,Magic_number_4 ,0,Green)==false){GetLastError();}
    if(Close_Mood_4 ==TP_SL)
    {
    Modify_4();
    }
 }
 }
 }
 
  if((Market_Order_Type_4==Open_Sell || Market_Order_Type_4==Open_Sell_Buy))
  {
  if(count_for_type(OP_SELL)>0&& count_chart_4(Symbol())<Max_orders_4)
 {
 if(Close[0]>=highbuy_4(OP_SELL)+New_OrderStep_4*pt*Point)
 {
  if(UseMultiple_4==true)
   {
  if(OrderSend(Symbol(),OP_SELL,MathMin(MaxLot_4,FindLastOrderParameterMarket_4("lot",OP_SELL)*Multi_4)+AddLot_4,Bid,30,0,0,Order_comment_4+"sell"+IntegerToString(count_for_type_4(OP_SELL)+1,0,0) ,Magic_number_4 ,0,Red)==false){GetLastError();}
  }
  else
    if(OrderSend(Symbol(),OP_SELL,fixed_lot_4+(AddLot_4*i8),Bid,30,0,0,Order_comment_4+"sell"+IntegerToString(count_for_type_4(OP_SELL)+1,0,0) ,Magic_number_4 ,0,Red)==false){GetLastError();}i8++;
    if(Close_Mood_4 ==TP_SL)
    {
    Modify_4();
    }
 }
 }
 
 
  if(count_for_type(OP_SELL)>0 && count_chart_4(Symbol())<Max_orders_4)
 {
 if(Close[0]<=lowsell_4(OP_SELL)-Anti_MartingaleStep_4*pt*Point)
 {
  if(OrderSend(Symbol(),OP_SELL,MathMax(MarketInfo(Symbol(),MODE_MINLOT)+AddLot_4,FindLastOrderParameterMarket_4("lot",OP_SELL)-MarketInfo(Symbol(),MODE_MINLOT)),Bid,30,0,0,Order_comment_4+"sell"+IntegerToString(count_for_type_4(OP_SELL)+1,0,0) ,Magic_number_4 ,0,Red)==false){GetLastError();}
    if(Close_Mood_4 ==TP_SL)
    {
    Modify_4();
    }
 }
 }
 }
 }
 }
 
  //fifth Grid 
  if(FIFTH_GRID==true)
    {
   if(  MarketInfo(Symbol(),MODE_SPREAD)<=Max_Spread_5  )
{ 
if((Market_Order_Type_5==Open_Buy || Market_Order_Type_5==Open_Sell_Buy))
 {
 if(count_for_type(OP_BUY)>0 && count_chart_5(Symbol())<Max_orders_5)
 {
 if(Close[0]<=lowsell_5(OP_BUY)-New_OrderStep_5*pt*Point)
 {
 if(UseMultiple_5==true)
   {
    
  if(OrderSend(Symbol(),OP_BUY,MathMin(MaxLot_5,FindLastOrderParameterMarket_5("lot",OP_BUY)*Multi_5)+AddLot_5,Ask,30,0,0,Order_comment_5+"buy"+IntegerToString(count_for_type_5(OP_BUY)+1,0,0) ,Magic_number_5 ,0,Green)==false){GetLastError();}
  }
  else
    if(OrderSend(Symbol(),OP_BUY,fixed_lot_5+(AddLot_5*i9),Ask,30,0,0,Order_comment_5+"buy"+IntegerToString(count_for_type_5(OP_BUY)+1,0,0) ,Magic_number_5 ,0,Green)==false){GetLastError();}i9++;
    if(Close_Mood_5 ==TP_SL)
    {
    Modify_5();
    }
 }
 }
 
 
 if(count_for_type(OP_BUY)>0 && count_chart_5(Symbol())<Max_orders_5)
 {
 if(Close[0]>=highbuy_5(OP_BUY)+Anti_MartingaleStep_5*pt*Point)
 {
  if(OrderSend(Symbol(),OP_BUY,MathMax(MarketInfo(Symbol(),MODE_MINLOT),FindLastOrderParameterMarket_5("lot",OP_BUY)-MarketInfo(Symbol(),MODE_MINLOT))+AddLot_5,Ask,30,0,0,Order_comment_5+"buy"+IntegerToString(count_for_type_5(OP_BUY)+1,0,0) ,Magic_number_5 ,0,Green)==false){GetLastError();}
    if(Close_Mood_5 ==TP_SL)
    {
    Modify_5();
    }
 }
 }
 }
 
  if((Market_Order_Type_5==Open_Sell || Market_Order_Type_5==Open_Sell_Buy))
  {
  if(count_for_type(OP_SELL)>0&& count_chart_5(Symbol())<Max_orders_5)
 {
 if(Close[0]>=highbuy_5(OP_SELL)+New_OrderStep_5*pt*Point)
 {
  if(UseMultiple_5==true)
   {
  if(OrderSend(Symbol(),OP_SELL,MathMin(MaxLot_5,FindLastOrderParameterMarket_5("lot",OP_SELL)*Multi_5)+AddLot_5,Bid,30,0,0,Order_comment_5+"sell"+IntegerToString(count_for_type_5(OP_SELL)+1,0,0) ,Magic_number_5 ,0,Red)==false){GetLastError();}
  }
  else
    if(OrderSend(Symbol(),OP_SELL,fixed_lot_5+(AddLot_5*i0),Bid,30,0,0,Order_comment_5+"sell"+IntegerToString(count_for_type_5(OP_SELL)+1,0,0) ,Magic_number_5 ,0,Red)==false){GetLastError();}i0++;
     if(Close_Mood_5 ==TP_SL)
    {
    Modify_5();
    }
 }
 }
 
 
  if(count_for_type(OP_SELL)>0 && count_chart_5(Symbol())<Max_orders_5)
 {
 if(Close[0]<=lowsell_5(OP_SELL)-Anti_MartingaleStep_5*pt*Point)
 {
  if(OrderSend(Symbol(),OP_SELL,MathMax(MarketInfo(Symbol(),MODE_MINLOT)+AddLot_5,FindLastOrderParameterMarket_5("lot",OP_SELL)-MarketInfo(Symbol(),MODE_MINLOT)),Bid,30,0,0,Order_comment_5+"sell"+IntegerToString(count_for_type_5(OP_SELL)+1,0,0) ,Magic_number_5 ,0,Red)==false){GetLastError();}
  if(Close_Mood_5 ==TP_SL)
    {
    Modify_5();
    }
 }
 }
 }
 }
 }
 
 //profit or loss in USD for First Grid  
    if(Close_Mood_1 ==Profit_Loss  )
    {
     if(ProfitTotal_1() >=Profit_Close_1 && ProfitTotal_1()>0)
    {
     CloseAllOrders_1();
     i1=1;
     i2=1;
    }   
     if(MathAbs(ProfitTotal_1()) >=Loss_Close_1 && ProfitTotal_1()<0 )
    {
     CloseAllOrders_1();
     i1=1;
     i2=1;
    }   
    
     } 
         
 //profit or loss in PIP for First Grid  
     if(Close_Mood_1 ==Profit_in_Pip  )
    {
     if( pipprofit_1() >=Profit_Pip_1 && pipprofit_1()>0)
    {
     CloseAllOrders_1();
     i1=1;
     i2=1;
    }   
     if(MathAbs( pipprofit_1()) >=Loss_Pip_1 && pipprofit_1()<0 )
    {
     CloseAllOrders_1();
     i1=1;
     i2=1;    }     
    
     } 
           
      //profit or loss in USD for Second Grid  
    if(Close_Mood_2 ==Profit_Loss  )
    {
     if(ProfitTotal_2() >=Profit_Close_2 && ProfitTotal_2()>0)
    {
     CloseAllOrders_2();
     i3=1;
     i4=1;
    }   
     if(MathAbs(ProfitTotal_2()) >=Loss_Close_2 && ProfitTotal_2()<0 )
    {
     CloseAllOrders_2();
     i3=1;
     i4=1;
    }   
    
     }    
 //profit or loss in PIP for Second Grid  
     if(Close_Mood_2 ==Profit_in_Pip  )
    {
     if( pipprofit_2() >=Profit_Pip_2 && pipprofit_2()>0)
    {
     CloseAllOrders_2();
     i3=1;
     i4=1;
    }   
     if(MathAbs( pipprofit_2()) >=Loss_pip_2 && pipprofit_2()<0 )
    {
     CloseAllOrders_2();
     i3=1;
     i4=1;
    }     
    
     } 

      //profit or loss in USD for Third Grid  
    if(Close_Mood_3 ==Profit_Loss  )
    {
     if(ProfitTotal_3() >=Profit_Close_3 && ProfitTotal_3()>0)
    {
     CloseAllOrders_3();
     i5=1;
     i6=1;
    }   
     if(MathAbs(ProfitTotal_3()) >=Loss_Close_3 && ProfitTotal_3()<0 )
    {
     CloseAllOrders_3();
     i5=1;
     i6=1;
    }   
    
     }    
 //profit or loss in PIP for Third Grid  
     if(Close_Mood_3 ==Profit_in_Pip  )
    {
     if( pipprofit_3() >=Profit_pip_3 && pipprofit_3()>0)
    {
     CloseAllOrders_3();
     i5=1;
     i6=1;
    }   
     if(MathAbs( pipprofit_3()) >=Loss_pip_3 && pipprofit_3()<0 )
    {
     CloseAllOrders_3();
     i5=1;
     i6=1;
    }     
    
     } 

      //profit or loss in USD for Fourth Grid  
    if(Close_Mood_4 ==Profit_Loss  )
    {
     if(ProfitTotal_4() >=Profit_Close_4 && ProfitTotal_4()>0)
    {
     CloseAllOrders_4();
     i7=1;
     i8=1;
    }   
     if(MathAbs(ProfitTotal_4()) >=Loss_Close_4 && ProfitTotal_4()<0 )
    {
     CloseAllOrders_4();
     i7=1;
     i8=1;
    }   
    
     }    
 //profit or loss in PIP for Fourth Grid  
     if(Close_Mood_4 ==Profit_in_Pip  )
    {
     if( pipprofit_4() >=Profit_Pip_4 && pipprofit_4()>0)
    {
     CloseAllOrders_4();
     i7=1;
     i8=1;
    }   
     if(MathAbs( pipprofit_4()) >=Loss_Pip_4 && pipprofit_4()<0 )
    {
     CloseAllOrders_4();
     i7=1;
     i8=1;
    }     
    
     } 

      //profit or loss in USD for Fifth Grid  
    if(Close_Mood_5 ==Profit_Loss  )
    {
     if(ProfitTotal_5() >=Profit_Close_5 && ProfitTotal_5()>0)
    {
     CloseAllOrders_5();
     i9=1;
     i0=1;
    }   
     if(MathAbs(ProfitTotal_5()) >=Loss_Close_5 && ProfitTotal_5()<0 )
    {
     CloseAllOrders_5();
     i9=1;
     i0=1;
    }   
    
     }    
 //profit or loss in PIP for Fifth Grid  
     if(Close_Mood_5 ==Profit_in_Pip  )
    {
     if( pipprofit_5() >=Profit_Pip_5 && pipprofit_5()>0)
    {
     CloseAllOrders_5();
     i9=1;
     i0=1;
    }   
     if(MathAbs( pipprofit_5()) >=Loss_Pip_5 && pipprofit_5()<0 )
    {
     CloseAllOrders_5();
     i9=1;
     i0=1;
    }     
    
     } 
     
   
     
     
    
     
     
     
     
  if(Use_Trailing == true)TrailingStopp(); 
  

   
  
  }
  
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| count for Ordertype for first operation                                              |
//+------------------------------------------------------------------+

 int  count_for_type(int type)
{
   
int cnt =0;
   for (int i=OrdersTotal() ;i>=0;i--)
    {
       if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if (  OrderSymbol()==Symbol()&&  OrderMagicNumber()== Magic_number && OrderType()==type )
      {
      cnt++;
      }
     }
     return(cnt);
}  
//+------------------------------------------------------------------+
//| count for Ordertype for FIRST GRID                                              |
//+------------------------------------------------------------------+
 int  count_for_type_1(int type)
{
   
int cnt =0;
   for (int i=OrdersTotal() ;i>=0;i--)
    {
       if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if (  OrderSymbol()==Symbol()&&  OrderMagicNumber()== Magic_number_1 && OrderType()==type )
      {
      cnt++;
      }
     }
     return(cnt);
} 
//+------------------------------------------------------------------+
//| count for Ordertype for FIRST GRID                                              |
//+------------------------------------------------------------------+     
 int  count_chart_1(string sym)
{
   
int cnt =0;
   for (int i1=OrdersTotal() ;i1>=0;i1--)
    {
        if(OrderSelect(i1,SELECT_BY_POS,MODE_TRADES) ==false){GetLastError();}
      if (  OrderSymbol()==sym&&  OrderMagicNumber()== Magic_number_1 )
      {
      cnt++;
      }
     }
     return(cnt);
}  
//+------------------------------------------------------------------+
//| Max for Price for FIRST GRID                                              |
//+------------------------------------------------------------------+  
 double highbuy_1(int type  )
{
double cnt =0;
for(int i=OrdersTotal() ;i>=0;i--)
 { 
  if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
  if( OrderSymbol()==Symbol() && (OrderMagicNumber()==Magic_number || OrderMagicNumber()==Magic_number_1)  && OrderType()==type)
  {
    cnt =MathMax(OrderOpenPrice(),cnt);
     
   }
  }
  return(cnt);
}
 
 
 //+------------------------------------------------------------------+
//| Min for Price for FIRST GRID                                              |
//+------------------------------------------------------------------+  
 
double lowsell_1(int type)
{
double cnt =99999999;
for(int i=OrdersTotal() ;i>=0;i--)
 { 
  if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
  if( OrderSymbol()==Symbol() && (OrderMagicNumber()==Magic_number || OrderMagicNumber()==Magic_number_1)&& OrderType()==type)
  {
    cnt =MathMin(OrderOpenPrice(),cnt);
     
   }
  }
  return(cnt);
}
//+------------------------------------------------------------------+
//| Find Last Order Parameter Market for FIRST GRID                                              |
//+------------------------------------------------------------------+  
 double FindLastOrderParameterMarket_1(string ParamName ,int type  ){
  double mOrderPrice = 0, mOrderLot = 0, mOrderProfit = 0;
  int PrevTicket = 0, CurrTicket = 0, mOrderTicket = 0,typ=0;
  datetime tim = 0;
  for (int i = OrdersTotal() - 1; i >= 0; i--) 
    if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) 
      if (OrderSymbol() == Symbol() && OrderType()==type   &&( OrderMagicNumber()==Magic_number || OrderMagicNumber()==Magic_number_1)){
        CurrTicket = OrderTicket();
        if (CurrTicket > PrevTicket){
          PrevTicket = CurrTicket;
          tim = OrderOpenTime();
          mOrderPrice = OrderOpenPrice();
          mOrderTicket = OrderTicket();
          mOrderLot = OrderLots();
          mOrderProfit = OrderProfit() + OrderSwap() + OrderCommission();   
          typ = OrderType();}}   
  if(ParamName == "price") return(mOrderPrice);
  else if(ParamName == "ticket") return(mOrderTicket);
  else if(ParamName == "lot") return(mOrderLot);
  else if(ParamName == "profit") return(mOrderProfit);
  else if(ParamName == "tm") return((int)tim);
  else if(ParamName == "type") return(typ);
  return(0);
}
//+------------------------------------------------------------------+
//| count for Ordertype for Second GRID                                              |
//+------------------------------------------------------------------+
 int  count_for_type_2(int type)
{
   
int cnt =0;
   for (int i=OrdersTotal() ;i>=0;i--)
    {
       if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if (  OrderSymbol()==Symbol()&&  OrderMagicNumber()== Magic_number_2 && OrderType()==type )
      {
      cnt++;
      }
     }
     return(cnt);
} 
//+------------------------------------------------------------------+
//| count for Ordertype for Second GRID                                              |
//+------------------------------------------------------------------+     
 int  count_chart_2(string sym)
{
   
int cnt =0;
   for (int i1=OrdersTotal() ;i1>=0;i1--)
    {
        if(OrderSelect(i1,SELECT_BY_POS,MODE_TRADES) ==false){GetLastError();}
      if (  OrderSymbol()==sym&&  OrderMagicNumber()== Magic_number_2 )
      {
      cnt++;
      }
     }
     return(cnt);
}  
//+------------------------------------------------------------------+
//| Max for Price for Second GRID                                              |
//+------------------------------------------------------------------+  
 double highbuy_2(int type  )
{
double cnt =0;
for(int i=OrdersTotal() ;i>=0;i--)
 { 
  if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
  if( OrderSymbol()==Symbol() && (OrderMagicNumber()==Magic_number || OrderMagicNumber()==Magic_number_2)  && OrderType()==type)
  {
    cnt =MathMax(OrderOpenPrice(),cnt);
     
   }
  }
  return(cnt);
}
 
 
 //+------------------------------------------------------------------+
//| Min for Price for Second GRID                                              |
//+------------------------------------------------------------------+  
 
double lowsell_2(int type)
{
double cnt =99999999;
for(int i=OrdersTotal() ;i>=0;i--)
 { 
  if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
  if( OrderSymbol()==Symbol() && (OrderMagicNumber()==Magic_number || OrderMagicNumber()==Magic_number_2)&& OrderType()==type)
  {
    cnt =MathMin(OrderOpenPrice(),cnt);
     
   }
  }
  return(cnt);
}
//+------------------------------------------------------------------+
//| Find Last Order Parameter Market for Second GRID                                              |
//+------------------------------------------------------------------+  
 double FindLastOrderParameterMarket_2(string ParamName ,int type  ){
  double mOrderPrice = 0, mOrderLot = 0, mOrderProfit = 0;
  int PrevTicket = 0, CurrTicket = 0, mOrderTicket = 0,typ=0;
  datetime tim = 0;
  for (int i = OrdersTotal() - 1; i >= 0; i--) 
    if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) 
      if (OrderSymbol() == Symbol() && OrderType()==type   &&( OrderMagicNumber()==Magic_number || OrderMagicNumber()==Magic_number_2)){
        CurrTicket = OrderTicket();
        if (CurrTicket > PrevTicket){
          PrevTicket = CurrTicket;
          tim = OrderOpenTime();
          mOrderPrice = OrderOpenPrice();
          mOrderTicket = OrderTicket();
          mOrderLot = OrderLots();
          mOrderProfit = OrderProfit() + OrderSwap() + OrderCommission();   
          typ = OrderType();}}   
  if(ParamName == "price") return(mOrderPrice);
  else if(ParamName == "ticket") return(mOrderTicket);
  else if(ParamName == "lot") return(mOrderLot);
  else if(ParamName == "profit") return(mOrderProfit);
  else if(ParamName == "tm") return((int)tim);
  else if(ParamName == "type") return(typ);
  return(0);
}
//+------------------------------------------------------------------+
//| count for Ordertype for Third GRID                                              |
//+------------------------------------------------------------------+
 int  count_for_type_3(int type)
{
   
int cnt =0;
   for (int i=OrdersTotal() ;i>=0;i--)
    {
       if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if (  OrderSymbol()==Symbol()&&  OrderMagicNumber()== Magic_number_3 && OrderType()==type )
      {
      cnt++;
      }
     }
     return(cnt);
} 
//+------------------------------------------------------------------+
//| count for Ordertype for Third GRID                                              |
//+------------------------------------------------------------------+     
 int  count_chart_3(string sym)
{
   
int cnt =0;
   for (int i1=OrdersTotal() ;i1>=0;i1--)
    {
        if(OrderSelect(i1,SELECT_BY_POS,MODE_TRADES) ==false){GetLastError();}
      if (  OrderSymbol()==sym&&  OrderMagicNumber()== Magic_number_3 )
      {
      cnt++;
      }
     }
     return(cnt);
}  
//+------------------------------------------------------------------+
//| Max for Price for Third GRID                                              |
//+------------------------------------------------------------------+  
 double highbuy_3(int type  )
{
double cnt =0;
for(int i=OrdersTotal() ;i>=0;i--)
 { 
  if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
  if( OrderSymbol()==Symbol() && (OrderMagicNumber()==Magic_number || OrderMagicNumber()==Magic_number_3)  && OrderType()==type)
  {
    cnt =MathMax(OrderOpenPrice(),cnt);
     
   }
  }
  return(cnt);
}
 
 
 //+------------------------------------------------------------------+
//| Min for Price for Third GRID                                              |
//+------------------------------------------------------------------+  
 
double lowsell_3(int type)
{
double cnt =99999999;
for(int i=OrdersTotal() ;i>=0;i--)
 { 
  if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
  if( OrderSymbol()==Symbol() && (OrderMagicNumber()==Magic_number || OrderMagicNumber()==Magic_number_3)&& OrderType()==type)
  {
    cnt =MathMin(OrderOpenPrice(),cnt);
     
   }
  }
  return(cnt);
}
//+------------------------------------------------------------------+
//| Find Last Order Parameter Market for Third GRID                                              |
//+------------------------------------------------------------------+  
 double FindLastOrderParameterMarket_3(string ParamName ,int type  ){
  double mOrderPrice = 0, mOrderLot = 0, mOrderProfit = 0;
  int PrevTicket = 0, CurrTicket = 0, mOrderTicket = 0,typ=0;
  datetime tim = 0;
  for (int i = OrdersTotal() - 1; i >= 0; i--) 
    if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) 
      if (OrderSymbol() == Symbol() && OrderType()==type   &&( OrderMagicNumber()==Magic_number || OrderMagicNumber()==Magic_number_3)){
        CurrTicket = OrderTicket();
        if (CurrTicket > PrevTicket){
          PrevTicket = CurrTicket;
          tim = OrderOpenTime();
          mOrderPrice = OrderOpenPrice();
          mOrderTicket = OrderTicket();
          mOrderLot = OrderLots();
          mOrderProfit = OrderProfit() + OrderSwap() + OrderCommission();   
          typ = OrderType();}}   
  if(ParamName == "price") return(mOrderPrice);
  else if(ParamName == "ticket") return(mOrderTicket);
  else if(ParamName == "lot") return(mOrderLot);
  else if(ParamName == "profit") return(mOrderProfit);
  else if(ParamName == "tm") return((int)tim);
  else if(ParamName == "type") return(typ);
  return(0);
}

//+------------------------------------------------------------------+
//| count for Ordertype for Fourth GRID                                              |
//+------------------------------------------------------------------+
 int  count_for_type_4(int type)
{
   
int cnt =0;
   for (int i=OrdersTotal() ;i>=0;i--)
    {
       if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if (  OrderSymbol()==Symbol()&&  OrderMagicNumber()== Magic_number_4 && OrderType()==type )
      {
      cnt++;
      }
     }
     return(cnt);
} 
//+------------------------------------------------------------------+
//| count for Ordertype for Fourth GRID                                              |
//+------------------------------------------------------------------+     
 int  count_chart_4(string sym)
{
   
int cnt =0;
   for (int i1=OrdersTotal() ;i1>=0;i1--)
    {
        if(OrderSelect(i1,SELECT_BY_POS,MODE_TRADES) ==false){GetLastError();}
      if (  OrderSymbol()==sym&&  OrderMagicNumber()== Magic_number_4 )
      {
      cnt++;
      }
     }
     return(cnt);
}  
//+------------------------------------------------------------------+
//| Max for Price for Fourth GRID                                              |
//+------------------------------------------------------------------+  
 double highbuy_4(int type  )
{
double cnt =0;
for(int i=OrdersTotal() ;i>=0;i--)
 { 
  if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
  if( OrderSymbol()==Symbol() && (OrderMagicNumber()==Magic_number || OrderMagicNumber()==Magic_number_4)  && OrderType()==type)
  {
    cnt =MathMax(OrderOpenPrice(),cnt);
     
   }
  }
  return(cnt);
}
 
 
 //+------------------------------------------------------------------+
//| Min for Price for Fourth GRID                                              |
//+------------------------------------------------------------------+  
 
double lowsell_4(int type)
{
double cnt =99999999;
for(int i=OrdersTotal() ;i>=0;i--)
 { 
  if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
  if( OrderSymbol()==Symbol() && (OrderMagicNumber()==Magic_number || OrderMagicNumber()==Magic_number_4)&& OrderType()==type)
  {
    cnt =MathMin(OrderOpenPrice(),cnt);
     
   }
  }
  return(cnt);
}
//+------------------------------------------------------------------+
//| Find Last Order Parameter Market for Fourth GRID                                              |
//+------------------------------------------------------------------+  
 double FindLastOrderParameterMarket_4(string ParamName ,int type  ){
  double mOrderPrice = 0, mOrderLot = 0, mOrderProfit = 0;
  int PrevTicket = 0, CurrTicket = 0, mOrderTicket = 0,typ=0;
  datetime tim = 0;
  for (int i = OrdersTotal() - 1; i >= 0; i--) 
    if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) 
      if (OrderSymbol() == Symbol() && OrderType()==type   &&( OrderMagicNumber()==Magic_number || OrderMagicNumber()==Magic_number_4)){
        CurrTicket = OrderTicket();
        if (CurrTicket > PrevTicket){
          PrevTicket = CurrTicket;
          tim = OrderOpenTime();
          mOrderPrice = OrderOpenPrice();
          mOrderTicket = OrderTicket();
          mOrderLot = OrderLots();
          mOrderProfit = OrderProfit() + OrderSwap() + OrderCommission();   
          typ = OrderType();}}   
  if(ParamName == "price") return(mOrderPrice);
  else if(ParamName == "ticket") return(mOrderTicket);
  else if(ParamName == "lot") return(mOrderLot);
  else if(ParamName == "profit") return(mOrderProfit);
  else if(ParamName == "tm") return((int)tim);
  else if(ParamName == "type") return(typ);
  return(0);
}
//+------------------------------------------------------------------+
//| count for Ordertype for Fifth GRID                                              |
//+------------------------------------------------------------------+
 int  count_for_type_5(int type)
{
   
int cnt =0;
   for (int i=OrdersTotal() ;i>=0;i--)
    {
       if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if (  OrderSymbol()==Symbol()&&  OrderMagicNumber()== Magic_number_5 && OrderType()==type )
      {
      cnt++;
      }
     }
     return(cnt);
} 
//+------------------------------------------------------------------+
//| count for Ordertype for Fifth GRID                                              |
//+------------------------------------------------------------------+     
 int  count_chart_5(string sym)
{
   
int cnt =0;
   for (int i1=OrdersTotal() ;i1>=0;i1--)
    {
        if(OrderSelect(i1,SELECT_BY_POS,MODE_TRADES) ==false){GetLastError();}
      if (  OrderSymbol()==sym&&  OrderMagicNumber()== Magic_number_5 )
      {
      cnt++;
      }
     }
     return(cnt);
}  
//+------------------------------------------------------------------+
//| Max for Price for Fifth GRID                                              |
//+------------------------------------------------------------------+  
 double highbuy_5(int type  )
{
double cnt =0;
for(int i=OrdersTotal() ;i>=0;i--)
 { 
  if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
  if( OrderSymbol()==Symbol() && (OrderMagicNumber()==Magic_number || OrderMagicNumber()==Magic_number_5)  && OrderType()==type)
  {
    cnt =MathMax(OrderOpenPrice(),cnt);
     
   }
  }
  return(cnt);
}
 
 
 //+------------------------------------------------------------------+
//| Min for Price for Fifth GRID                                              |
//+------------------------------------------------------------------+  
 
double lowsell_5(int type)
{
double cnt =99999999;
for(int i=OrdersTotal() ;i>=0;i--)
 { 
  if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
  if( OrderSymbol()==Symbol() && (OrderMagicNumber()==Magic_number || OrderMagicNumber()==Magic_number_5)&& OrderType()==type)
  {
    cnt =MathMin(OrderOpenPrice(),cnt);
     
   }
  }
  return(cnt);
}
//+------------------------------------------------------------------+
//| Find Last Order Parameter Market for Fifth GRID                                              |
//+------------------------------------------------------------------+  
 double FindLastOrderParameterMarket_5(string ParamName ,int type  ){
  double mOrderPrice = 0, mOrderLot = 0, mOrderProfit = 0;
  int PrevTicket = 0, CurrTicket = 0, mOrderTicket = 0,typ=0;
  datetime tim = 0;
  for (int i = OrdersTotal() - 1; i >= 0; i--) 
    if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) 
      if (OrderSymbol() == Symbol() && OrderType()==type   &&( OrderMagicNumber()==Magic_number || OrderMagicNumber()==Magic_number_5)){
        CurrTicket = OrderTicket();
        if (CurrTicket > PrevTicket){
          PrevTicket = CurrTicket;
          tim = OrderOpenTime();
          mOrderPrice = OrderOpenPrice();
          mOrderTicket = OrderTicket();
          mOrderLot = OrderLots();
          mOrderProfit = OrderProfit() + OrderSwap() + OrderCommission();   
          typ = OrderType();}}   
  if(ParamName == "price") return(mOrderPrice);
  else if(ParamName == "ticket") return(mOrderTicket);
  else if(ParamName == "lot") return(mOrderLot);
  else if(ParamName == "profit") return(mOrderProfit);
  else if(ParamName == "tm") return((int)tim);
  else if(ParamName == "type") return(typ);
  return(0);
}
//+------------------------------------------------------------------+
//| TrailingStop Function                                            |
//+------------------------------------------------------------------+  
void TrailingStopp()
{
    for (int i=OrdersTotal()-1; i >= 0; i--)
    if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) 
    {
        if (OrderSymbol() == Symbol() && OrderMagicNumber() == Magic_number)
        {
            double takeprofit = OrderTakeProfit();
            
            if (OrderType() == OP_BUY && Close[0] - OrderOpenPrice() > TrailingStop*pt*Point) 
            {
                if ((OrderStopLoss() < Close[0]-(TrailingStop+TrailingStep)*pt*Point) || (OrderStopLoss()==0))
                {
                    if (TrailingProfit != 0) takeprofit = Close[0]+(TrailingProfit + TrailingStop)*pt*Point; 
                    bool ret1 = OrderModify(OrderTicket(), OrderOpenPrice(), Close[0]-TrailingStop*pt*Point, takeprofit,0, White);
                    if (ret1 == false)
                    Print(" OrderModify() error - , ErrorDescription: ",(GetLastError()));
                }
            }
            if (OrderType() == OP_SELL && OrderOpenPrice() - Close[0] > TrailingStop*pt*Point)
            {
                if ((OrderStopLoss() > Close[0]+(TrailingStop+TrailingStep)*pt*Point) || (OrderStopLoss()==0))
                {
                    if (TrailingProfit != 0) takeprofit = Close[0]-(TrailingProfit + TrailingStop)*pt*Point;
                    bool ret2 = OrderModify(OrderTicket(), OrderOpenPrice(), Close[0]+TrailingStop*pt*Point, takeprofit, 0, White);
                    if (ret2 == false)
                    Print("OrderModify() error - , ErrorDescription: ",(GetLastError()));
                }
            }
        }
    }
    else 
    Print("OrderSelect() error - , ErrorDescription: ",(GetLastError()));
}
//+------------------------------------------------------------------+
//| profit Function for First GRID                                           |
//+------------------------------------------------------------------+ 
double ProfitTotal_1()
  {
   double p = 0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if(OrderSymbol()==Symbol() &&  (OrderMagicNumber()== Magic_number_1 || OrderMagicNumber()== Magic_number))
        {

            p +=OrderProfit()+OrderCommission()+OrderSwap();
        }
     }
   return (p);
  }


//+------------------------------------------------------------------+
//|    profit in pip for First GRID                                                             |
//+------------------------------------------------------------------+
double pipprofit_1()
  {
   double profits;
   for(int i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
        {
         if(OrderSymbol()==Symbol()&&  (OrderMagicNumber()== Magic_number_1 || OrderMagicNumber()== Magic_number))
              {
               profits += OrderProfit()+OrderSwap()+OrderCommission()/GetPPP(OrderSymbol());;
              }
        }
     }

   return(profits);
  }

//+------------------------------------------------------------------+
//|   Close Orders  for First GRID                                                             |
//+------------------------------------------------------------------+
void CloseAllOrders_1()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if(OrderSymbol()==Symbol() &&  (OrderMagicNumber()== Magic_number_1 || OrderMagicNumber()== Magic_number))
        {
         if(OrderType() == OP_BUY)
           {
           if( OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==false){GetLastError();}
           }
         else
            if(OrderType() == OP_SELL)
              {
              if( OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==false){GetLastError();}
              }
            else
              {
               if(OrderDelete(OrderTicket(),White)==false){GetLastError();}
              }
        }
     }
  }
 //+------------------------------------------------------------------+
//|   Modify TP_SL  for First GRID                                                              |
//+------------------------------------------------------------------+ 
 void Modify_1()
  {
      for(int i=0; i<OrdersTotal(); i++)
        {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
         if(OrderSymbol()==Symbol())
           {
            if(OrderType()==OP_BUY&&  (OrderMagicNumber()== Magic_number_1 || OrderMagicNumber()== Magic_number))
              {

               if(OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice()-Stop_loss_1*Point, OrderOpenPrice()+Take_Profit_1*Point, 0, Green)==false){GetLastError();}

              }
            if(OrderType()==OP_SELL&&  (OrderMagicNumber()== Magic_number_1 || OrderMagicNumber()== Magic_number))
              {
              if( OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice()+Stop_loss_1*Point, OrderOpenPrice()-Take_Profit_1*Point, 0, Green)==false){GetLastError();}

              }
           }
        }
    
  }
//+------------------------------------------------------------------+
//| profit Function for Second GRID                                           |
//+------------------------------------------------------------------+ 
double ProfitTotal_2()
  {
   double p = 0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
     if( OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if(OrderSymbol()==Symbol() && (OrderMagicNumber()== Magic_number_2 || OrderMagicNumber()== Magic_number))
        {

            p +=OrderProfit()+OrderCommission()+OrderSwap();
        }
     }
   return (p);
  }


//+------------------------------------------------------------------+
//|    profit in pip for Second GRID                                                             |
//+------------------------------------------------------------------+
double pipprofit_2()
  {
   double profits;
   for(int i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true){GetLastError();}
        {
         if(OrderSymbol()==Symbol()&&   (OrderMagicNumber()== Magic_number_2 || OrderMagicNumber()== Magic_number))
              {
               profits += OrderProfit()+OrderSwap()+OrderCommission()/GetPPP(OrderSymbol());;
              }
        }
     }

   return(profits);
  }

//+------------------------------------------------------------------+
//|   Close Orders  for Second GRID                                                             |
//+------------------------------------------------------------------+
void CloseAllOrders_2()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true){GetLastError();}
      if(OrderSymbol()==Symbol() && (OrderMagicNumber()== Magic_number_2 || OrderMagicNumber()== Magic_number))
        {
         if(OrderType() == OP_BUY)
           {
            if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==true){GetLastError();}
           }
         else
            if(OrderType() == OP_SELL)
              {
               if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==true){GetLastError();}
              }
            else
              {
               if(OrderDelete(OrderTicket(),White)==true){GetLastError();}
              }
        }
     }
  }
 //+------------------------------------------------------------------+
//|   Modify TP_SL  for Second GRID                                                              |
//+------------------------------------------------------------------+ 
 void Modify_2()
  {
      for(int i=0; i<OrdersTotal(); i++)
        {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){GetLastError();}
         if(OrderSymbol()==Symbol())
           {
            if(OrderType()==OP_BUY&&  (OrderMagicNumber()== Magic_number_2 || OrderMagicNumber()== Magic_number))
              {

               if(OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice()-Stop_loss_2*Point, OrderOpenPrice()+Take_Profit_2*Point, 0, Green)==true){GetLastError();}

              }
            if(OrderType()==OP_SELL&&  (OrderMagicNumber()== Magic_number_2 || OrderMagicNumber()== Magic_number))
              {
              if( OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice()+Stop_loss_2*Point, OrderOpenPrice()-Take_Profit_2*Point, 0, Green)==true){GetLastError();}

              }
           }
        }
    
  }
//+------------------------------------------------------------------+
//| profit Function for Third GRID                                           |
//+------------------------------------------------------------------+ 
double ProfitTotal_3()
  {
   double p = 0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){GetLastError();}
      if(OrderSymbol()==Symbol() &&  (OrderMagicNumber()== Magic_number_3 || OrderMagicNumber()== Magic_number))
        {

            p +=OrderProfit()+OrderCommission()+OrderSwap();
        }
     }
   return (p);
  }


//+------------------------------------------------------------------+
//|    profit in pip for Third GRID                                                             |
//+------------------------------------------------------------------+
double pipprofit_3()
  {
   double profits;
   for(int i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true){GetLastError();}
        {
         if(OrderSymbol()==Symbol()&&   (OrderMagicNumber()== Magic_number_3 || OrderMagicNumber()== Magic_number))
              {
               profits += OrderProfit()+OrderSwap()+OrderCommission()/GetPPP(OrderSymbol());;
              }
        }
     }

   return(profits);
  }

//+------------------------------------------------------------------+
//|   Close Orders  for Third GRID                                                             |
//+------------------------------------------------------------------+
void CloseAllOrders_3()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true){GetLastError();}
      if(OrderSymbol()==Symbol() && (OrderMagicNumber()== Magic_number_3 || OrderMagicNumber()== Magic_number))
        {
         if(OrderType() == OP_BUY)
           {
           if( OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==true){GetLastError();}
           }
         else
            if(OrderType() == OP_SELL)
              {
              if( OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==true){GetLastError();}
              }
            else
              {
               if(OrderDelete(OrderTicket(),White)==true){GetLastError();}
              }
        }
     }
  }
 //+------------------------------------------------------------------+
//|   Modify TP_SL  for Third GRID                                                              |
//+------------------------------------------------------------------+ 
 void Modify_3()
  {
      for(int i=0; i<OrdersTotal(); i++)
        {
        if( OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){GetLastError();}
         if(OrderSymbol()==Symbol())
           {
            if(OrderType()==OP_BUY&&  (OrderMagicNumber()== Magic_number_3 || OrderMagicNumber()== Magic_number))
              {

               if(OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice()-Stop_loss_3*Point, OrderOpenPrice()+Take_Profit_3*Point, 0, Green)==true){GetLastError();}

              }
            if(OrderType()==OP_SELL&&  (OrderMagicNumber()== Magic_number_3 || OrderMagicNumber()== Magic_number))
              {
               if(OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice()+Stop_loss_3*Point, OrderOpenPrice()-Take_Profit_3*Point, 0, Green)==true){GetLastError();}

              }
           }
        }
    
  }
//+------------------------------------------------------------------+
//| profit Function for Fourth GRID                                           |
//+------------------------------------------------------------------+ 
double ProfitTotal_4()
  {
   double p = 0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){GetLastError();}
      if(OrderSymbol()==Symbol() &&  (OrderMagicNumber()== Magic_number_4 || OrderMagicNumber()== Magic_number))
        {

            p +=OrderProfit()+OrderCommission()+OrderSwap();
        }
     }
   return (p);
  }


//+------------------------------------------------------------------+
//|    profit in pip for Fourth GRID                                                             |
//+------------------------------------------------------------------+
double pipprofit_4()
  {
   double profits;
   for(int i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true){GetLastError();}
        {
         if(OrderSymbol()==Symbol()&&   (OrderMagicNumber()== Magic_number_4 || OrderMagicNumber()== Magic_number))
              {
               profits += OrderProfit()+OrderSwap()+OrderCommission()/GetPPP(OrderSymbol());;
              }
        }
     }

   return(profits);
  }

//+------------------------------------------------------------------+
//|   Close Orders  for Fourth GRID                                                             |
//+------------------------------------------------------------------+
void CloseAllOrders_4()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true){GetLastError();}
      if(OrderSymbol()==Symbol() &&  (OrderMagicNumber()== Magic_number_4 || OrderMagicNumber()== Magic_number))
        {
         if(OrderType() == OP_BUY)
           {
            if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==true){GetLastError();}
           }
         else
            if(OrderType() == OP_SELL)
              {
               if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==true){GetLastError();}
              }
            else
              {
              if( OrderDelete(OrderTicket(),White)==true){GetLastError();}
              }
        }
     }
  }
 //+------------------------------------------------------------------+
//|   Modify TP_SL  for Fourth GRID                                                              |
//+------------------------------------------------------------------+ 
 void Modify_4()
  {
      for(int i=0; i<OrdersTotal(); i++)
        {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){GetLastError();}
         if(OrderSymbol()==Symbol())
           {
            if(OrderType()==OP_BUY&&  (OrderMagicNumber()== Magic_number_4 || OrderMagicNumber()== Magic_number))
              {

               if(OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice()-Stop_loss_4*Point, OrderOpenPrice()+Take_Profit_4*Point, 0, Green)==true){GetLastError();}

              }
            if(OrderType()==OP_SELL&& (OrderMagicNumber()== Magic_number_4 || OrderMagicNumber()== Magic_number))
              {
               if(OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice()+Stop_loss_4*Point, OrderOpenPrice()-Take_Profit_4*Point, 0, Green)==true){GetLastError();}

              }
           }
        }
    
  }
//+------------------------------------------------------------------+
//| profit Function for Fifth GRID                                           |
//+------------------------------------------------------------------+ 
double ProfitTotal_5()
  {
   double p = 0;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){GetLastError();}
      if(OrderSymbol()==Symbol() && (OrderMagicNumber()== Magic_number_5 || OrderMagicNumber()== Magic_number))
        {

            p +=OrderProfit()+OrderCommission()+OrderSwap();
        }
     }
   return (p);
  }


//+------------------------------------------------------------------+
//|    profit in pip for First GRID                                                             |
//+------------------------------------------------------------------+
double pipprofit_5()
  {
   double profits;
   for(int i=0; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true){GetLastError();}
        {
         if(OrderSymbol()==Symbol()&&  (OrderMagicNumber()== Magic_number_5 || OrderMagicNumber()== Magic_number))
              {
               profits += OrderProfit()+OrderSwap()+OrderCommission()/GetPPP(OrderSymbol());;
              }
        }
     }

   return(profits);
  }

//+------------------------------------------------------------------+
//|   Close Orders  for Fifth GRID                                                             |
//+------------------------------------------------------------------+
void CloseAllOrders_5()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true){GetLastError();}
      if(OrderSymbol()==Symbol() &&(OrderMagicNumber()== Magic_number_5 || OrderMagicNumber()== Magic_number))
        {
         if(OrderType() == OP_BUY)
           {
            if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==true){GetLastError();}
           }
         else
            if(OrderType() == OP_SELL)
              {
              if( OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,White)==true){GetLastError();}
              }
            else
              {
               if(OrderDelete(OrderTicket(),White)==true){GetLastError();}
              }
        }
     }
  }
 //+------------------------------------------------------------------+
//|   Modify TP_SL  for Fifth GRID                                                              |
//+------------------------------------------------------------------+ 
 void Modify_5()
  {
      for(int i=0; i<OrdersTotal(); i++)
        {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true){GetLastError();}
         if(OrderSymbol()==Symbol())
           {
            if(OrderType()==OP_BUY&& (OrderMagicNumber()== Magic_number_5 || OrderMagicNumber()== Magic_number))
              {

               if(OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice()-Stop_loss_5*Point, OrderOpenPrice()+Take_Profit_5*Point, 0, Green)==true){GetLastError();}

              }
            if(OrderType()==OP_SELL&& (OrderMagicNumber()== Magic_number_5 || OrderMagicNumber()== Magic_number))
              {
               if(OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice()+Stop_loss_5*Point, OrderOpenPrice()-Take_Profit_5*Point, 0, Green)==true){GetLastError();}

              }
           }
        }
    
  }








//+------------------------------------------------------------------+
//|   Calculate pip                                                               |
//+------------------------------------------------------------------+
double GetPPP(string A)
  {
   double B = (((MarketInfo(A,MODE_TICKSIZE)/MarketInfo(A,MODE_BID))* MarketInfo(A,MODE_LOTSIZE)) * MarketInfo(A,MODE_BID))/10; //For 5 Digit

   return(B);
  }










 


 

//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH 
  //HHHHHHHHHHHHHHHHHHHHHHHH------functions calculate trades number on chart  ----- HHHHHH
  //HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
  

  
 int  count_cmnt(string cmt)
{
   
int cnt =0;
   for (int i1=OrdersTotal() ;i1>=0;i1--)
    {
        if(OrderSelect(i1,SELECT_BY_POS,MODE_TRADES) ==false){GetLastError();}
      if (  OrderSymbol()==Symbol()&& OrderComment()==cmt&&  OrderMagicNumber()== Magic_number )
      {
      cnt++;
      }
     }
     return(cnt);
}  
 
  
 int  count_orderprice(double price)
{
   
int cnt =0;
   for (int i1=OrdersTotal() ;i1>=0;i1--)
    {
        if(OrderSelect(i1,SELECT_BY_POS,MODE_TRADES) ==false){GetLastError();}
      if (  OrderSymbol()==Symbol()&&  OrderMagicNumber()== Magic_number )
      {
      if(OrderOpenPrice()==price)
      {
      cnt++;
      }
      }
     }
     return(cnt);
}  
 
//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH 
  //HHHHHHHHHHHHHHHHHHHHHHHH------functions close orders by type                ----- HHHHHH
  //HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
  
void close_bytype (int type , string sym )
{
 for(int i=OrdersTotal()-1;i>=0;i--)
 { 
    if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES) ==false){GetLastError();}
  if(OrderSymbol()==sym &&OrderMagicNumber()==Magic_number )
  {
   if(OrderType()==type)
   {
       if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,clrYellow)  ==false){GetLastError();}
   }
  }
 }
 
 } 
 
 
 //HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH 
  //HHHHHHHHHHHHHHHHHHHHHHHH------functions used to close trades with pair symbol ----- HHHHHH
  //HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH


void close_bypair ( string sym )
{
 for(int i=OrdersTotal()-1;i>=0;i--)
 { 
    if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES) ==false){GetLastError();}
  if(OrderSymbol()==sym &&OrderMagicNumber()==Magic_number )
  {
  
       if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,clrYellow)  ==false){GetLastError();}
   
  }
 }
 
 } 
 
  //HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH 
  //HHHHHHHHHHHHHHHHHHHHHHHH------functions check if the order is opened or not    ----- HHHHHH
  //HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

bool IsOrderOpened (string sym)
{
 for(int i=OrdersTotal()-1;i>=0;i--)
 { 
    if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES) ==false){GetLastError();}
  if(OrderSymbol()==sym&&OrderMagicNumber()==Magic_number )
  {
   if(OrderOpenTime()>=iTime(sym,0,0))return(true);
   else if(OrderOpenTime()<iTime(sym,0,0))return(false);
  }
 }
 return(false);
 } 
 
  
 
   //HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH 
  //HHHHHHHHHHHHHHHHHHHHHHHH------functions check if the order is closed  or not    ----- HHHHHH
  //HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

bool IsOrderClosed ()
{
 for(int i=OrdersHistoryTotal()-1;i>=0;i--)
 { 
     if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)  ==false){GetLastError();}
  if(OrderSymbol()==Symbol()&&OrderMagicNumber()==Magic_number )
  {
   if(OrderCloseTime()>=iTime(Symbol(),0,0))return(true);
   else if(OrderCloseTime()<iTime(Symbol(),0,0))return(false);
  }
 }
 return(false);
 } 
 
 
 
  
   


bool IsOrderOpened (int  type , datetime time )
{
 for(int i=OrdersTotal()-1;i>=0;i--)
 { 
  if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
  if(OrderSymbol()==Symbol()&&OrderMagicNumber()==Magic_number && OrderType() ==type)
  {
   if(OrderOpenTime()>=time)return(true);
   else if(OrderOpenTime()<time)return(false);
  }
 }
 return(false);
 } 
 
 

 
  

void delettype(int type)
{
for(int i=OrdersTotal() ;i>=0;i--)
 { 
  if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
  if( OrderSymbol()==Symbol() && OrderMagicNumber()==Magic_number )
  {
    
    if(OrderType()==type)
    {
   if(OrderDelete(OrderTicket())==false){GetLastError();}
    }
     
   }
  }
 }


 
 int order_count_for_chart ()
{
   
int cnt =0;
   for (int i1=OrdersTotal() ;i1>=0;i1--)
    {
     if(OrderSelect(i1,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if (  OrderSymbol()==Symbol()&&  OrderMagicNumber()== Magic_number  )
      {
      cnt++;
      }
     }
     return(cnt);
}  
  
   

  
  
  
  


 double order_profit_for_chart ()
{
   
double cnt =0;
   for (int i1=OrdersTotal() ;i1>=0;i1--)
    {
     if(OrderSelect(i1,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if (  OrderSymbol()==Symbol()&&  OrderMagicNumber()!= Magic_number  )
      {
      cnt=cnt+OrderProfit();
      }
     }
     return(cnt);
}




 



 
 




 



void close_all ()
{
 for(int i=OrdersTotal();i>=0;i--)
 { 
  if( OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
  if(OrderSymbol()==Symbol()&&OrderMagicNumber()==Magic_number )
  {
    
     if(!OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),30,Red))Print(GetLastError()) ;
  
  }
 }
 
 } 
 
 
 
 
 double  count_profit_chart()
{
   
double cnt =0;
   for (int i1=OrdersTotal() ;i1>=0;i1--)
    {
        if(OrderSelect(i1,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if (  OrderSymbol()==Symbol()&&  OrderMagicNumber()== Magic_number )
      {
      cnt= cnt+ OrderProfit();
      }
     }
     return(cnt);
}  
     

      



 int  count_chart_type(int type)
{
   
int cnt =0;
   for (int i1=OrdersTotal() ;i1>=0;i1--)
    {
        if(OrderSelect(i1,SELECT_BY_POS,MODE_TRADES) ==false){GetLastError();}
      if (  OrderSymbol()==Symbol()&&  OrderMagicNumber()== Magic_number && OrderType()==type)
      {
      cnt++;
      }
     }
     return(cnt);
}  


 double  count_lot_type(int type)
{
   
double cnt =0;
   for (int i1=OrdersTotal() ;i1>=0;i1--)
    {
        if(OrderSelect(i1,SELECT_BY_POS,MODE_TRADES) ==false){GetLastError();}
      if (  OrderSymbol()==Symbol()&&  OrderMagicNumber()== Magic_number && OrderType()==type)
      {
      cnt=cnt+OrderLots();
      }
     }
     return(cnt);
}  


 double  count_char_loss( )
{
   
double cnt =0;
   for (int i1=OrdersTotal() ;i1>=0;i1--)
    {
        if(OrderSelect(i1,SELECT_BY_POS,MODE_TRADES) ==false){GetLastError();}
      if (  OrderSymbol()==Symbol()&&  OrderMagicNumber()== Magic_number  )
      {
      cnt=cnt+OrderProfit();
      }
     }
     return(cnt);
}  


 
 
 /////////////////////////
 /////////////////////////
 /////////////////////////
 /////////////////////////
 /////////////////////////
 /////////////////////////
 /////////////////////////
 /////////////////////////
 /////////////////////////
 /////////////////////////
 /////////////////////////
 /////////////////////////
 /////////////////////////
 /////////////////////////
 
 
 
#define SYMBOLS_MAX 1024
#define DEALS          0
#define BUY_LOTS       1
#define BUY_PRICE      2
#define SELL_LOTS      3
#define SELL_PRICE     4
#define NET_LOTS       5
#define PROFIT         6
#define Swaps           7
#define Swapb           8

extern color ExtColor=clrLimeGreen;
extern int  ExtFont=9;

string ExtName="Exposure";
string ExtSymbols[SYMBOLS_MAX];
int    ExtSymbolsTotal=0;
double ExtSymbolsSummaries[SYMBOLS_MAX][9];
int    ExtLines=-1;
string ExtCols[10]={"Symbol",
                   "Deals",
                   "Buy lots",
                   "Buy price",
                   "Sell lots",
                   "Sell price",
                   "Net lots",
                   "Profit",
                   "Swap Sell",
                   "Swap Buy"};
int    ExtShifts[10]={ 10, 80, 130, 180, 260, 310, 390, 460,520,600 };
int    ExtVertShift=14;
double ExtMapBuffer[];
 
 
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
void indicator_code()
  {
   string name;
   int    i,col,line,windex=0; // WindowFind(ExtName);
//----
   if(windex<0) return;
//---- header line
   if(ExtLines<0)
     {
      for(col=0; col<10; col++)
        {
         name="Head_"+IntegerToString(col,0,0);
         if(ObjectCreate(name,OBJ_LABEL,windex,0,0))
           {
            ObjectSet(name,OBJPROP_XDISTANCE,ExtShifts[col]);
            ObjectSet(name,OBJPROP_YDISTANCE,ExtVertShift);
            ObjectSetText(name,ExtCols[col],ExtFont,"Arial",ExtColor);
           }
        }
      ExtLines=0;
     }
//----
   ArrayInitialize(ExtSymbolsSummaries,0.0);
   int total=Analyze();
   if(total>0)
     {
      line=0;
      for(i=0; i<ExtSymbolsTotal; i++)
        {
         if(ExtSymbolsSummaries[i][DEALS]<=0) continue;
         line++;
         //---- add line
         if(line>ExtLines)
           {
            int y_dist=ExtVertShift*(line+1)+1;
            for(col=0; col<10; col++)
              {
               name="Line_"+line+"_"+col;
               if(ObjectCreate(name,OBJ_LABEL,windex,0,0))
                 {
                  ObjectSet(name,OBJPROP_XDISTANCE,ExtShifts[col]);
                  ObjectSet(name,OBJPROP_YDISTANCE,y_dist);
                 }
              }
            ExtLines++;
           }
         //---- set line
         int    digits=MarketInfo(ExtSymbols[i],MODE_DIGITS);
         double buy_lots=ExtSymbolsSummaries[i][BUY_LOTS];
         double sell_lots=ExtSymbolsSummaries[i][SELL_LOTS];
         double buy_price=0.0;
         double sell_price=0.0;
         if(buy_lots!=0)  buy_price=ExtSymbolsSummaries[i][BUY_PRICE]/buy_lots;
         if(sell_lots!=0) sell_price=ExtSymbolsSummaries[i][SELL_PRICE]/sell_lots;
         name="Line_"+line+"_0";
         ObjectSetText(name,ExtSymbols[i],ExtFont,"Arial",ExtColor);
         name="Line_"+line+"_1";
         ObjectSetText(name,DoubleToStr(ExtSymbolsSummaries[i][DEALS],0),ExtFont,"Arial",ExtColor);
         name="Line_"+line+"_2";
         ObjectSetText(name,DoubleToStr(buy_lots,2),ExtFont,"Arial",ExtColor);
         name="Line_"+line+"_3";
         ObjectSetText(name,DoubleToStr(buy_price,digits),ExtFont,"Arial",ExtColor);
         name="Line_"+line+"_4";
         ObjectSetText(name,DoubleToStr(sell_lots,2),ExtFont,"Arial",ExtColor);
         name="Line_"+line+"_5";
         ObjectSetText(name,DoubleToStr(sell_price,digits),ExtFont,"Arial",ExtColor);
         name="Line_"+line+"_6";
         ObjectSetText(name,DoubleToStr(buy_lots-sell_lots,2),ExtFont,"Arial",ExtColor);
         name="Line_"+line+"_7";   
         if(ExtSymbolsSummaries[i][PROFIT] >0){
         ObjectSetText(name,DoubleToStr(ExtSymbolsSummaries[i][PROFIT],2),ExtFont,"Arial",clrLime);}
         if(ExtSymbolsSummaries[i][PROFIT] <0){
         ObjectSetText(name,DoubleToStr(ExtSymbolsSummaries[i][PROFIT],2),ExtFont,"Arial",clrRed);}
          if(ExtSymbolsSummaries[i][PROFIT] ==0){
         ObjectSetText(name,DoubleToStr(ExtSymbolsSummaries[i][PROFIT],2),ExtFont,"Arial",ExtColor);}
         name="Line_"+line+"_8";
         if(ExtSymbolsSummaries[i][Swaps]>0){
         ObjectSetText(name,DoubleToStr(ExtSymbolsSummaries[i][Swaps],2),ExtFont,"Arial",clrLime);}
         if(ExtSymbolsSummaries[i][Swaps]<0){
         ObjectSetText(name,DoubleToStr(ExtSymbolsSummaries[i][Swaps],2),ExtFont,"Arial",clrRed);}
          if(ExtSymbolsSummaries[i][Swaps]==0){
         ObjectSetText(name,DoubleToStr(ExtSymbolsSummaries[i][Swaps],2),ExtFont,"Arial",ExtColor);}
          name="Line_"+line+"_9";
          if(ExtSymbolsSummaries[i][Swapb]>0){
         ObjectSetText(name,DoubleToStr(ExtSymbolsSummaries[i][Swapb],2),ExtFont,"Arial",clrLime);}
        if(ExtSymbolsSummaries[i][Swapb]<0){
         ObjectSetText(name,DoubleToStr(ExtSymbolsSummaries[i][Swapb],2),ExtFont,"Arial",clrRed);}
        if(ExtSymbolsSummaries[i][Swapb]==0){
         ObjectSetText(name,DoubleToStr(ExtSymbolsSummaries[i][Swapb],2),ExtFont,"Arial",ExtColor);}
       
         
        
        }
     }
//---- remove lines
   if(total<ExtLines)
     {
      for(line=ExtLines; line>total; line--)
        {
         name="Line_"+line+"_0";
         ObjectSetText(name,"");
         name="Line_"+line+"_1";
         ObjectSetText(name,"");
         name="Line_"+line+"_2";
         ObjectSetText(name,"");
         name="Line_"+line+"_3";
         ObjectSetText(name,"");
         name="Line_"+line+"_4";
         ObjectSetText(name,"");
         name="Line_"+line+"_5";
         ObjectSetText(name,"");
         name="Line_"+line+"_6";
         ObjectSetText(name,"");
         name="Line_"+line+"_7";
         ObjectSetText(name,""); 
         name="Line_"+line+"_8";
         ObjectSetText(name,"");
          name="Line_"+line+"_9";
         ObjectSetText(name,"");
        }
     }
//---- to avoid minimum==maximum
   
//----
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Analyze()
  {
   double profit;
   int    i,index,type,total=OrdersTotal();
//----
   for(i=0; i<total; i++)
     {
      if(!OrderSelect(i,SELECT_BY_POS)) continue;
      type=OrderType();
      if(type!=OP_BUY && type!=OP_SELL) continue;
      index=SymbolsIndex(OrderSymbol());
      if(index<0 || index>=SYMBOLS_MAX) continue;
      //----
      ExtSymbolsSummaries[index][DEALS]++;
      profit=OrderProfit()+OrderCommission()+OrderSwap();
      ExtSymbolsSummaries[index][PROFIT]+=profit;
      if(type==OP_BUY)
        {
         ExtSymbolsSummaries[index][BUY_LOTS]+=OrderLots();
         ExtSymbolsSummaries[index][BUY_PRICE]+=OrderOpenPrice()*OrderLots();
         ExtSymbolsSummaries[index][Swapb]+=OrderSwap();
        }
      else
        {
         ExtSymbolsSummaries[index][SELL_LOTS]+=OrderLots();
         ExtSymbolsSummaries[index][SELL_PRICE]+=OrderOpenPrice()*OrderLots();
          ExtSymbolsSummaries[index][Swaps]+=OrderSwap();
        }
     }
//----
   total=0;
   for(i=0; i<ExtSymbolsTotal; i++)
     {
      if(ExtSymbolsSummaries[i][DEALS]>0) total++;
     }
//----
   return(total);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int SymbolsIndex(string SymbolName)
  {
   bool found=false;
   int i=0;
//----
   for(  i=0; i<ExtSymbolsTotal; i++)
     {
      if(SymbolName==ExtSymbols[i])
        {
         found=true;
         break;
        }
     }
//----
   if(found) return(i);
   if(ExtSymbolsTotal>=SYMBOLS_MAX) return(-1);
//----
   i=ExtSymbolsTotal;
   ExtSymbolsTotal++;
   ExtSymbols[i]=SymbolName;
   ExtSymbolsSummaries[i][DEALS]=0;
   ExtSymbolsSummaries[i][BUY_LOTS]=0;
   ExtSymbolsSummaries[i][BUY_PRICE]=0;
   ExtSymbolsSummaries[i][SELL_LOTS]=0;
   ExtSymbolsSummaries[i][SELL_PRICE]=0;
   ExtSymbolsSummaries[i][NET_LOTS]=0;
   ExtSymbolsSummaries[i][PROFIT]=0;
   ExtSymbolsSummaries[i][Swaps]=0;
   ExtSymbolsSummaries[i][Swapb]=0;
//----
   return(i);
  }
//+-----------




 
 //HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM




 int  counttype (int types)
{
   
int cnt =0;
   for (int i1=OrdersTotal() ;i1>=0;i1--)
    {
     if(OrderSelect(i1,SELECT_BY_POS,MODE_TRADES)==false){GetLastError();}
      if (  OrderSymbol()==Symbol()&&  OrderType()==types && OrderMagicNumber()==Magic_number)
      {
      cnt++;
      }
     }
     return(cnt);
}  
     
    








 //HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH 
  //HHHHHHHHHHHHHHHHHHHHHHHH------functions calculate average price of total lots  ----- HHHHHH
  //HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
  
double zeroprice(int type)
{double totlot=0;double zeropoint=0;
for(int i=OrdersTotal();i>=0;i--)
 { 
   if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES) ==false){GetLastError();}
  if(OrderSymbol()==Symbol() && OrderType()==type&& OrderMagicNumber()==Magic_number )
  {
   
     totlot =totlot+ (OrderLots()*OrderOpenPrice());
   zeropoint = totlot/ totaltypelot(type);
  }
 }
 return(zeropoint);

}

//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH 
  //HHHHHHHHHHHHHHHHHHHHHHHH------functions calculate total lots  ----- HHHHHH
  //HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
  
double totaltypelot(int type)
{double totlot=0;
for(int i=OrdersTotal();i>=0;i--)
 { 
   if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)  ==false){GetLastError();}
  if(OrderSymbol()==Symbol() &&  OrderType()==type &&  OrderMagicNumber()==Magic_number )
  {
   
     totlot =totlot+ OrderLots();
  
  }
 }
 return(totlot);

}



   
    


  