//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#property copyright "shivamtech365@gmail.com"                          //|XX
#property link      "shivamtech365@gmail.com"                          //|XX
#property version   "1.2"                                       //|XX
#property strict "BCL"                                           //|XX
//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
string EA_NAME = "CLOSE ALL EA";// Change EA Name then Press F7 to save it 


 string GM1    = "--------------< Use TestingBuy/ TestingSell for Backtesting>-------------------";//:- For Quick Checking -:
 bool TestingBuy=false;
 bool TestingSell=false;
 
#include <WinUser32.mqh>
#import "user32.dll"  // Uncomment This

int GetAncestor(int, int);
#define MT4_WMCMD_EXPERTS  33020

#import 


input double ProfitTargert=8;// P/L Value 
input double LossTargert=10000;// S/L Value

int CO_Orders; double COPL;
datetime CO_Time,XYtime;
int Select,cnt;
int OpenOrders ,PendOrders;
double ProfitALL;
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||
int OnInit()
{
EventSetMillisecondTimer(500);

GlobalVariableSet("activated",1);


return(0);
}

//+
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM||



//=============================================================================||
int deinit()  
{

CleanUp();

return(0);
}
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||
void OnTimer()
  {
 //Print("he");
 
  int is_allowed=TerminalInfoInteger(TERMINAL_TRADE_ALLOWED);
 
 if(is_allowed==1){ 
   //is_allowed=TerminalInfoInteger(TERMINAL_TRADE_ALLOWED);

      GlobalVariableSet("activated",1);
      
      //so user just activated the system, so can go back to normal
         
   }
 else{
   GlobalVariableSet("activated",0);
   }
 

//------------------------------------------------------------------------------------|| 
 
CO_Orders=0; COPL=0;
CO_Time=0;
for( cnt=0; cnt<OrdersHistoryTotal(); cnt++)   
   {
     Select=OrderSelect(cnt, SELECT_BY_POS, MODE_HISTORY);
	  if ( OrderSymbol()==Symbol() && OrderType()<2 )
	     {
	     CO_Orders++;	
	     COPL+=(OrderProfit()+OrderSwap()+OrderCommission()) ;  
	     CO_Time=OrderCloseTime();
	     }
	}
//------------------------------------------------------------------------------------------------||	


OpenOrders    = 0;  PendOrders=0;
XYtime=0;
ProfitALL=0;
for( cnt=0; cnt<OrdersTotal(); cnt++)   
   {
     Select=OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
     {
	  if (//OrderSymbol()==Symbol() && OrderMagicNumber() == Magic_Number &&
	   OrderType()<2)
	     {
	     OpenOrders++;
	     ProfitALL+=(OrderProfit() +OrderCommission()+OrderSwap());
	     }	
	   }
	 }  
//------------------------------------------------------------------------------------------------||	
	int ord_send;
if ( OpenOrders==0 && TestingBuy==true) 
   
   {    
   ord_send=OrderSend (Symbol(),0,0.1,Ask,100,0,0,"",0,0,clrBlue);
   
   }	
   
 if ( OpenOrders==0 && TestingSell==true) 
   
   {    
   ord_send=OrderSend (Symbol(),0,0.1,Ask,100,0,0,"",0,0,clrBlue);
   
   }	  
	
	
if(OpenOrders>0&& ProfitALL>=ProfitTargert &&	ProfitTargert)
{
GlobalVariableSet("activated",0);
CloseALL();


if(TerminalInfoInteger(TERMINAL_TRADE_ALLOWED)){ 
   stop_autotrading();
   }

}

if(OpenOrders>0&& ProfitALL<=-LossTargert &&	LossTargert)
{
GlobalVariableSet("activated",0);
CloseALL();


if(TerminalInfoInteger(TERMINAL_TRADE_ALLOWED)){ 
   stop_autotrading();
   }
   

}
	
if (AccountEquity()>=AccountBalance())  clr_eq= clrLime; else clr_eq= clrRed;

   string_window( "Balance", 5, 20, 0); //
   ObjectSetText( "Balance","Balance   : " + DoubleToStr(AccountBalance(),2) , text_size, "Cambria", color_text);  
   ObjectSet( "Balance", OBJPROP_CORNER,text_corner);  
   
   string_window( "Equity", 5, 40, 0); //
   ObjectSetText( "Equity","Equity     : " + DoubleToStr(AccountEquity(),2) , text_size, "Cambria", color_text); 
   ObjectSet( "Equity", OBJPROP_CORNER, text_corner);  
   
   string_window( "Profit", 5, 60, 0); 
   ObjectSetText( "Profit", "Profit/Loss    : " +DoubleToStr( ProfitALL,2) , text_size, "Impact", clr_eq); 
   ObjectSet( "Profit", OBJPROP_CORNER, text_corner);	
   
   string_window( "P/L", 5, 80, 0); 
   ObjectSetText( "P/L", "Input P/L Value    : " +DoubleToStr( ProfitTargert,2) , text_size, "Impact", clrLime); 
   ObjectSet( "P/L", OBJPROP_CORNER, text_corner);	
   
   string_window( "S/L", 5, 100, 0); 
   ObjectSetText( "S/L", "Input S/L Value    : " +DoubleToStr( LossTargert,2) , text_size, "Impact", clrRed); 
   ObjectSet( "S/L", OBJPROP_CORNER, text_corner);	
   
   
   return;
  }
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||

//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||
void CleanUp()
{  ObjectDelete("Profit");   ObjectDelete("Equity");
   ObjectDelete("Balance");  ObjectDelete("S/L");
   ObjectDelete("P/L");   ObjectDelete("TimeCO");
   ObjectDelete("expiredlabel");   ObjectDelete("Contact_Me");
    
   return;
}
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||
int string_window( string n, int xoff, int yoff, int WindowToUse )
   {
   ObjectCreate(n, OBJ_LABEL, WindowToUse, 0, 0 );
   ObjectSet( n, OBJPROP_XDISTANCE, xoff );
   ObjectSet( n, OBJPROP_YDISTANCE, yoff );
   ObjectSet( n, OBJPROP_BACK, true );
   return (0);
   }
//KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK||


//----------------------------------------------------------------------------------------||
int CloseOrder;
datetime Server_Time ; string Time_Servs ;
void CloseALL()
{
for(cnt=OrdersTotal()-1;cnt>=0;cnt--)
{
Select= OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
	//if (OrderSymbol()==Symbol() && OrderMagicNumber() == Magic_Number) 
		 //{ 
		  if (OrderType()<2)
		  { CloseOrder=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),1000,clrRed); 
		  Server_Time = TimeCurrent(); 
        Time_Servs =TimeToStr(Server_Time,TIME_DATE|TIME_MINUTES|TIME_SECONDS);
		  string_window( "TimeCO", 5, 120, 0); 
        ObjectSetText( "TimeCO", "Close Time : " +TimeToString( Server_Time) 
        , text_size, "Impact", clrYellow); 
        ObjectSet( "TimeCO", OBJPROP_CORNER, text_corner);	
		  
		  }
		  
		   if (OrderType()>=2)
		  { CloseOrder=OrderDelete(OrderTicket(),clrRed); }
		  
			//}
	 }
}
//----------------------------------------------------------------------------------------||
input ENUM_BASE_CORNER text_corner=1;
input int text_size=12;
input color color_text= clrWhite;
color clr_eq;


void stop_autotrading(){
   int main = GetAncestor(WindowHandle(Symbol(), Period()), 2/*GA_ROOT*/);   // Uncomment This
   
   PostMessageA(main, WM_COMMAND,  MT4_WMCMD_EXPERTS, 0 ) ;  // Uncomment This
   }
   
