///////////////////////////////////////////////////////////////////////////////////////////////
//      This is a job done by developer (User ID : helptotraders) on MQL5.com
//      Seller Profile  : https://www.mql5.com/en/users/helptotraders/seller
//      Order Num       : 145144
//      Job Name        : Writing of an Expert Advisor that opens and closes trades based on any arrow indicator
//      Date            : 2021.04.25                                        
//      User (Customer) : Etobillion Venture
//      User (Developer): HelpToTraders (Ismail Hakki Delibas)
///////////////////////////////////////////////////////////////////////////////////////////////
#property copyright "Copyright, helptotraders. "
#property link   "https://www.mql5.com/en/users/helptotraders/seller"
#property version   "1.1"
#property strict


enum SigModeEnum
{
	ClosedCandle,	//Closed Candle Calue
	CurrentCandle	//Current Candle Value
};

enum EmptValEnum
{
	Zero,	//0
	EmptVal	//0x7FFFFFFF
};


input string IndiName="Name.ex4";		//Indicator Name
input int BuyBuffer=2;				//Indicator Buy Buffer
input int SellBuffer=3;				//Indicator Sell Buffer
input EmptValEnum EmptValMode=EmptVal;	//Indicator Buffer Empty Value

input SigModeEnum SigMode=ClosedCandle;	//Signal Based On :

input int MagicNum=145144;	//Magic Number

input double LotSize=0.01;	//First Lot Size

input double StopLoss=500;		//Stop Loss (Points)
input double TakeProfit=100;		//Take Profit (Points)
input bool OppositeClose=true;	//Opposite Arrow Close 

input int OpenOrders=5;		//Number of Orders to Open

input bool EnableTrailing=false;	//Trailing Stop Loss
input int TrailingStart=100;	//Trailing Start (Points)
input int TrailingStop=100;	//Trailing Stop (Points)
input int TrailingStep=10;	//Trailing Step (Points)


datetime LastCandle;

int idxSig;

int OnInit()
{
	if( SigMode==ClosedCandle )
	{
		idxSig=1;
		LastCandle=iTime(Symbol(),Period(),0);
	}
	else
	{
		idxSig=0;
		LastCandle=0;
	}
	

	return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{

}

void OnTick()
{
	double SigBuy,SigSell;
	int sig;
	
	DoTrailing();
	
	if( LastCandle==iTime(Symbol(),Period(),0) ) return;
	
	
	sig=0;
	SigBuy=iCustom(Symbol(),Period(),IndiName,BuyBuffer,idxSig);
	SigSell=iCustom(Symbol(),Period(),IndiName,SellBuffer,idxSig);
	if( SigBuy<EMPTY_VALUE-10 && EmptValMode==EmptVal ) sig=1;
	if( SigSell<EMPTY_VALUE-10 && EmptValMode==EmptVal ) sig=2;
	if( SigBuy>0.000001 && EmptValMode==Zero ) sig=1;
	if( SigSell>0.000001 && EmptValMode==Zero ) sig=2;
	
	if( sig==1 )
	{
		if( PosExist(OP_SELL) && OppositeClose )
		ClosePos(OP_SELL);
		
		if( !PosExist(OP_BUY) )
		PlaceOrder(OP_BUY);
		LastCandle=iTime(Symbol(),Period(),0);
	}
	
	if( sig==2 )
	{
		if( PosExist(OP_BUY) && OppositeClose )
		ClosePos(OP_BUY);
		
		if( !PosExist(OP_SELL) )
		PlaceOrder(OP_SELL);
		LastCandle=iTime(Symbol(),Period(),0);
	}
		

}

bool PosExist(int OT)
{
	int i,n;
	
	n=OrdersTotal();
	for( i=0; i<n; i++)
		if( OrderSelect(i,SELECT_BY_POS) )
			if( OrderSymbol()==Symbol() )
				if( OrderMagicNumber()==MagicNum )
					if( OrderType()==OT )
						return true;
	return false;
}

void ClosePos(int OT)
{
	int i,n;
	
	n=OrdersTotal();
	for( i=n-1; i>=0; i--)
		if( OrderSelect(i,SELECT_BY_POS) )
			if( OrderSymbol()==Symbol() )
				if( OrderMagicNumber()==MagicNum )
					if( OrderType()==OT )
						if( !OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),100) )
							Print("Error on closing order : ",GetLastError());
}

void PlaceOrder(int OT)
{
	double pr,sl,tp,v;
	int i;
	
	v=LotSize;
	v=NormalizeDouble(v,2);
	
	if( OT==OP_BUY )
	{
		pr=Ask;
		sl=pr-StopLoss*Point();
		tp=pr+TakeProfit*Point();
	}
	else
	{
		pr=Bid;
		sl=pr+StopLoss*Point();
		tp=pr-TakeProfit*Point();
	}
	
	sl=NormalizeDouble(sl,Digits());
	tp=NormalizeDouble(tp,Digits());
	pr=NormalizeDouble(pr,Digits());
	
	for( i=0; i<OpenOrders; i++)
		if( OrderSend(Symbol(),OT,v,pr,100,sl,tp,"",MagicNum)<0 )
			Print("Error on order opening : ",GetLastError());
}


void DoTrailing()
{
	if( EnableTrailing==false ) return;
	
	int i,n;
	double dp;
	double sl;
	double pt;
	
	n=OrdersTotal();
	for( i=0; i<n; i++)
	{
		if( OrderSelect(i,SELECT_BY_POS) )
		{
			if( OrderSymbol()!=Symbol() ) continue;
			if( OrderMagicNumber()==MagicNum )
			{
				if( OrderProfit()>0 )
				{
					dp=MathAbs(OrderOpenPrice()-OrderClosePrice());
					pt=SymbolInfoDouble(OrderSymbol(),SYMBOL_POINT);
					if( dp>TrailingStart*pt )
					{
						if( OrderType()==OP_BUY )
						{
							sl=OrderClosePrice()-TrailingStop*pt;
							if( sl>OrderStopLoss()+TrailingStep*pt ) 
								ModifyTPSL(OrderTicket(),OrderTakeProfit(),sl);
						}
						else if( OrderType()==OP_SELL )
						{
							sl=OrderClosePrice()+TrailingStop*pt;
							if( sl<OrderStopLoss()-TrailingStep*pt || OrderStopLoss()<0.000001 ) 
								ModifyTPSL(OrderTicket(),OrderTakeProfit(),sl);
							
						}
					}
				}
			}
		}
	}

}



void ModifyTPSL( int TicketNum, double TPvalue, double SLvalue )
{

	if( OrderSelect(TicketNum,SELECT_BY_TICKET) )
		if( !OrderModify(TicketNum,OrderOpenPrice(),SLvalue,TPvalue,0) )
				PrintFormat("SL/TP OrderSend error %d %s %d",GetLastError(),OrderSymbol(),TicketNum);  // if unable to send the request, output the error code
}