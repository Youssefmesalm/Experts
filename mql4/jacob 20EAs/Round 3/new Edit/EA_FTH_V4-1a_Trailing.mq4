//+------------------------------------------------------------------+
//|                   
//|                                   
//|                                        
//+------------------------------------------------------------------+
#property copyright "EA FTH V4"
#property link      "https://t.me/JIMBARWANAFX"
#property version   "2.00"
#property strict

extern string     _1                = "Basic Settings";
extern double     Lots              = 0.01;
string     NamaIndi          = "slope Direction Line111";//Nama Indikator
int        BufferBuy         = 2;//Buffer Buy
int        BufferSell        = 3;//Buffer Sell
extern double     trailing          = 10.0;
input  bool       Hedging           = true;
input  bool       UsePO             = false;//Use Pending Order
input  double     DIstancePO        = 10;//Distance Pending Order
input  double     TPPO              = 0;//Take Profit PO
input  double     SLPO              = 0;//Stop Loss PO
input  double     LotPO             = 0.01;//Lot PO
input  bool       CutSwitch         = false;
input  int        MaxTrade          = 20;
input  double     TPMoney1          = 0;//Close Current Pair When Profit
input  double     TPMoney2          = 0;//Close All Pair When Profit
extern bool       Reverse           = false;//Reverse Trade
extern string     _2                = "Settings For TP & SL";
extern bool       Manual_Next_Lots  = true;
input  string     Next_Lots         = "0.01;0.02;0.03;0.04;0.05;0.06;0.07;0.08;0.09;0.1;0.12;0.14.0.16;0.18;0.20;0.25;0.3;0.35;0.4;0.5;0.6;0.7;0.8;0.9;1.0;1.2;1.4;1.6;1.8;2.0;2.2;2.4;2.6;2.8;2;3.0;3.2;3.4;3.6;3.8;4.0;4.2;4.4;4.6;4.8;5.0;5.2;5.4;5.6;5.8;6.0;6.2;6.6;7.0;8.0;10.0;12.0;14.0;16.0;18.0;20,0;22.0;24.0;26.0;28.0;30.0;32.0;34.0;36.0;38.0;40.0";
extern double     TakeProfit        = 20;
extern double     StopLoss          = 0;
extern string     _3                = "Settings For Trading Hour";
extern int        Mulai             = 1;//Time Start
extern int        Berhenti          = 23;//Time End
extern string     _4                = "Settings For Averaging";

input  int        Distance1         = 30;//Pipstep For Averaging
input  double     Marti             = 1.4;//Lot Multiplier
input  double     TPAV              = 5;//TP Averaging
extern string     _5                = "Settings For Trailing";
extern bool       Trailing          = false;//Use Trailing Stop
extern int        TrailingStart     = 10;//Trailing Start Single Order
extern int        TrailingStop      = 3;//Trailing Stop Single Order
extern int        TrailingStartAV   = 5;//Trailing Start Averaging
extern int        TrailingStopAV    = 3;//Trailing Stop Averaging
extern string     _6                = "Slippage - Magic Number";
extern int        Slippage          = 5;
extern int        MagicNumber       = 696969;
string     EAComment         = "EA FTH V4";


double minlot, maxlot, minstop, lotstep;
int    digit, spread, digitlot, limitorder;
double    TPSell, TPBuy, SLSell, SLBuy;
datetime openedtime;
double g_Point,pr,BalanceAwal;
int ticket=0;
double Next_Lots_Arr[];
double vlot;

bool     useexpDate            =false;//<-- true (for use expired date)
datetime expDate               =D'2021.12.01 02:00';//yyyy.mm.dd<-- expired date

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {

   if(useexpDate)
    {
   if(TimeCurrent()>expDate)
     {
      MessageBox("The version has expired! contact https://t.me/putu_artha");
      return(1);
     }
    }
   BalanceAwal= AccountBalance();
   
   StringToDoubleArray_f(Next_Lots,Next_Lots_Arr);
   
   if(Digits==3 || Digits==5) g_Point=10*Point;   else   g_Point=Point;
   digit = (int)MarketInfo(Symbol(),MODE_DIGITS);
   
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
   ObjectsDeleteAll();
   ChartRedraw();

}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() 
{
   info();

   int buy = 0, sell = 0;
   int buy1 = 0, sell1 = 0;
   
   
   if(StopLoss==0)SLBuy=0;          else SLBuy=Ask - StopLoss*g_Point;
   if((TakeProfit && trailing)==0)TPBuy=0;          else TPBuy=Ask + TakeProfit*g_Point;
   if(StopLoss==0)SLSell=0;         else SLSell=Bid + StopLoss*g_Point;
   if((TakeProfit && trailing)==0)TPSell=0;         else TPSell=Bid - TakeProfit*g_Point;


   if(AccountFreeMargin()<(100*Lots)) {
      Print("Not Enough Money. Free Margin = ", AccountFreeMargin());
      return;
   }

   HideTestIndicators(True);
   double   buysignal   = iCustom(Symbol(),0,NamaIndi,BufferBuy,1),
            sellsignal  = iCustom(Symbol(),0,NamaIndi,BufferSell,1);

   
   if(CountOrder(0)+CountOrder(1)>=2){
   if(TPMoney1>0 && (ProfitOrder1(OP_BUY)+ProfitOrder1(OP_SELL)) >= TPMoney1)
                  {
                     CloseAllBuy();
                     CloseAllSell();
                  }
    }
   
    
   if(CountOrder(0)>=2 && CountOrder(1)==0){
   if(TPMoney1>0 && ProfitOrder1(OP_BUY) >= TPMoney1)
                  {
                     CloseAllBuy();
                  }
    }
   
   
   if(CountOrder(1)>=2 && CountOrder(0)==0){
   if(TPMoney1>0 && ProfitOrder1(OP_SELL) >= TPMoney1)
                  {
                     CloseAllSell();
                  }
    }
   
//-----------------------------------------------------------------   
   if(CountOrder2(0)+CountOrder2(1)>=2){
   if(TPMoney2>0 && (ProfitOrder2(OP_BUY)+ProfitOrder2(OP_SELL)) >= TPMoney2)
                  {
                     CloseAllBuy2();
                     CloseAllSell2();
                  }
    }
   
    
   if(CountOrder2(0)>=2 && CountOrder2(1)==0){
   if(TPMoney2>0 && ProfitOrder2(OP_BUY) >= TPMoney2)
                  {
                     CloseAllBuy2();
                  }
    }
   
   
   if(CountOrder2(1)>=2 && CountOrder2(0)==0){
   if(TPMoney2>0 && ProfitOrder2(OP_SELL) >= TPMoney2)
                  {
                     CloseAllSell2();
                  }
    }
   
   if(CountOrder(0)==0){
    closeall(OP_SELLSTOP);
    }
   
   if(CountOrder(1)==0){
    closeall(OP_BUYSTOP);
    }
   
   bool Modified = 0;
   if(JamTrading() == 1) {
      if(!Reverse){
      if(!Hedging){
      if(CountOrder(0)<1 && buysignal != EMPTY_VALUE  && openedtime != iTime(Symbol(),0,1)) {
         buy = OrderSend(Symbol(),OP_BUY,Lots,Ask,Slippage,SLBuy,TPBuy,EAComment,MagicNumber,0,clrMagenta);
         openedtime = iTime(Symbol(),0,1);

         if(CutSwitch) {
         CloseAllSell();
         }
         if(UsePO){
         sell1 = OrderSend(Symbol(),OP_SELLSTOP,LotPO,Ask-DIstancePO*g_Point,Slippage,(Ask-DIstancePO*g_Point)+(SLPO*g_Point),(Ask-DIstancePO*g_Point)-(TPPO*g_Point),EAComment,MagicNumber,0,clrDarkOrchid);
         }
      }

      if(CountOrder(1)<1 && sellsignal != EMPTY_VALUE  && openedtime != iTime(Symbol(),0,1)) {
         sell = OrderSend(Symbol(),OP_SELL,Lots,Bid,Slippage,SLSell,TPSell,EAComment,MagicNumber,0,clrDarkOrchid);
         openedtime = iTime(Symbol(),0,1);
         
         if(CutSwitch) {
          CloseAllBuy();
         }
         if(UsePO){
         buy1 = OrderSend(Symbol(),OP_BUYSTOP,LotPO,Bid+DIstancePO*g_Point,Slippage,(Bid+DIstancePO*g_Point)-(SLPO*g_Point),(Bid+DIstancePO*g_Point)+(TPPO*g_Point),EAComment,MagicNumber,0,clrMagenta);
         }
      }
     }
     
     
     if(Hedging){
      if(CountOrder(0)<1 && buysignal != EMPTY_VALUE  && openedtime != iTime(Symbol(),0,1)) {
         buy = OrderSend(Symbol(),OP_BUY,Lots,Ask,Slippage,SLBuy,TPBuy,EAComment,MagicNumber,0,clrMagenta);
         openedtime = iTime(Symbol(),0,1);
         if(UsePO){
         sell1 = OrderSend(Symbol(),OP_SELLSTOP,LotPO,Ask-DIstancePO*g_Point,Slippage,(Ask-DIstancePO*g_Point)+(SLPO*g_Point),(Ask-DIstancePO*g_Point)-(TPPO*g_Point),EAComment,MagicNumber,0,clrDarkOrchid);
         }
         }

      if(CountOrder(1)<1 && sellsignal != EMPTY_VALUE  && openedtime != iTime(Symbol(),0,1)) {
         sell = OrderSend(Symbol(),OP_SELL,Lots,Bid,Slippage,SLSell,TPSell,EAComment,MagicNumber,0,clrDarkOrchid);
         openedtime = iTime(Symbol(),0,1);
         if(UsePO){
         buy1 = OrderSend(Symbol(),OP_BUYSTOP,LotPO,Bid+DIstancePO*g_Point,Slippage,(Bid+DIstancePO*g_Point)-(SLPO*g_Point),(Bid+DIstancePO*g_Point)+(TPPO*g_Point),EAComment,MagicNumber,0,clrMagenta);
         }
         }
     }
     }
     
//-------------------------------------------------------------------------------------------------------------     
     if(Reverse){
      if(!Hedging){
      if(CountOrder(0)<1 && sellsignal != EMPTY_VALUE && openedtime != iTime(Symbol(),0,1)) {
         buy = OrderSend(Symbol(),OP_BUY,Lots,Ask,Slippage,SLBuy,TPBuy,EAComment,MagicNumber,0,clrMagenta);
         openedtime = iTime(Symbol(),0,1);
         if(CutSwitch) {
         CloseAllSell();
         }
         if(UsePO){
         sell1 = OrderSend(Symbol(),OP_SELLSTOP,LotPO,Ask-DIstancePO*g_Point,Slippage,(Ask-DIstancePO*g_Point)+(SLPO*g_Point),(Ask-DIstancePO*g_Point)-(TPPO*g_Point),EAComment,MagicNumber,0,clrDarkOrchid);
         }
      }

      if(CountOrder(1)<1 && buysignal != EMPTY_VALUE  && openedtime != iTime(Symbol(),0,1)) {
         sell = OrderSend(Symbol(),OP_SELL,Lots,Bid,Slippage,SLSell,TPSell,EAComment,MagicNumber,0,clrDarkOrchid);
         openedtime = iTime(Symbol(),0,1);
         if(CutSwitch) {
          CloseAllBuy();
         }
         if(UsePO){
         buy1 = OrderSend(Symbol(),OP_BUYSTOP,LotPO,Bid+DIstancePO*g_Point,Slippage,(Bid+DIstancePO*g_Point)-(SLPO*g_Point),(Bid+DIstancePO*g_Point)+(TPPO*g_Point),EAComment,MagicNumber,0,clrMagenta);
         }
      }
     }
     
     
     if(Hedging){
      if(CountOrder(0)<1 && sellsignal != EMPTY_VALUE && openedtime != iTime(Symbol(),0,1)) {
         buy = OrderSend(Symbol(),OP_BUY,Lots,Ask,Slippage,SLBuy,TPBuy,EAComment,MagicNumber,0,clrMagenta);
         openedtime = iTime(Symbol(),0,1);
         if(UsePO){
         sell1 = OrderSend(Symbol(),OP_SELLSTOP,LotPO,Ask-DIstancePO*g_Point,Slippage,(Ask-DIstancePO*g_Point)+(SLPO*g_Point),(Ask-DIstancePO*g_Point)-(TPPO*g_Point),EAComment,MagicNumber,0,clrDarkOrchid);
         }
         }

      if(CountOrder(1)<1 && buysignal != EMPTY_VALUE && openedtime != iTime(Symbol(),0,1)) {
         sell = OrderSend(Symbol(),OP_SELL,Lots,Bid,Slippage,SLSell,TPSell,EAComment,MagicNumber,0,clrDarkOrchid);
         openedtime = iTime(Symbol(),0,1);
         }
         if(UsePO){
         buy1 = OrderSend(Symbol(),OP_BUYSTOP,LotPO,Bid+DIstancePO*g_Point,Slippage,(Bid+DIstancePO*g_Point)-(SLPO*g_Point),(Bid+DIstancePO*g_Point)+(TPPO*g_Point),EAComment,MagicNumber,0,clrMagenta);
         }
     }
     }
   }
      
   if(CountOrder(OP_BUY)>=1 && CountOrder(OP_BUY)<MaxTrade)
      {
       int NumTrade0=CountOrder(OP_BUY);
       
       
       if((LastPrice(0)-Ask)>=Distance1*g_Point)
       {
        ticket=OrderSend(Symbol(),OP_BUY,GLots(NumTrade0, OP_BUY),Ask,3,0,0,EAComment+"-"+IntegerToString(CountOrder(OP_BUY)),MagicNumber,0,clrGreen);     
       }
   }  
    for (int pos_0 = 0; pos_0 < OrdersTotal(); pos_0++) {
   {
     if (trailing > 0) {
     if (Bid - OrderOpenPrice() > trailing * Point)
     if (OrderStopLoss() == 0.0 || Bid - OrderStopLoss() > trailing * Point) Modified=OrderModify(OrderTicket(), OrderOpenPrice(), Bid - trailing * Point, OrderTakeProfit(), 0, Blue);
         }
      } 
   }
   
   if(CountOrder(OP_SELL)>=1 && CountOrder(OP_SELL)<MaxTrade)
      {
       int NumTrade1=CountOrder(OP_SELL);
       
       
       if((Bid-LastPrice(1))>=Distance1*g_Point)
       {
        ticket=OrderSend(Symbol(),OP_SELL,GLots(NumTrade1, OP_SELL),Bid,3,0,0,EAComment+"-"+IntegerToString(CountOrder(OP_SELL)),MagicNumber,0,clrGreen);     
       }
 }      
     for (int pos_0 = 0; pos_0 < OrdersTotal(); pos_0++) {
     {
     if (trailing > 0) {
     if (OrderOpenPrice() - Ask > trailing * Point)
     if (OrderStopLoss() == 0.0 || OrderStopLoss() - Ask > trailing * Point) Modified=OrderModify(OrderTicket(), OrderOpenPrice(), Ask + trailing * Point, OrderTakeProfit(), 0, Red);
         }
      }
   }        
  
      
   if(CountOrder(OP_BUY) > 1) {
          PutNewTP(OP_BUY, (BEP(OP_BUY)+(TPAV*g_Point))); 
          PutNewSL(OP_BUY, GetSLBuy());
          }
   
   
   
   if(CountOrder(OP_SELL) > 1) {
          PutNewTP(OP_SELL, (BEP(OP_SELL)-(TPAV*g_Point)));
          PutNewSL(OP_SELL, GetSLSell());
          }
   
   
   
   if(Trailing) { trailing();}

}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int JamTrading() {
   bool jtrade = false;
   if( Mulai > Berhenti) {
      if (Hour() >= Mulai || Hour() < Berhenti) jtrade = true;
   } else if (Hour() >= Mulai && Hour() < Berhenti) jtrade = true;

   return (jtrade);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CountOrder(int Type) {
   int order = 0;
   int i,total=OrdersTotal();
   for(i=0; i<total; i++) {
      if(OrderSelect(i,SELECT_BY_POS)==True)
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber() == MagicNumber)
               if(OrderType() == Type) {
                  order++;
               }
   }
   return(order);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CountOrder2(int Type) {
   int order = 0;
   int i,total=OrdersTotal();
   for(i=0; i<total; i++) {
      if(OrderSelect(i,SELECT_BY_POS)==True)
               if(OrderType() == Type) {
                  order++;
               }
   }
   return(order);
}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseAllOrders() {
   for(int i=OrdersTotal()-1; i>=0; i--) {
      bool result = false;
      if(OrderSelect(i,SELECT_BY_POS)==True)
         if(OrderType() == OP_SELL &&
               OrderSymbol() == Symbol() &&
               OrderMagicNumber() == MagicNumber)
            result = OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 3, Red);

      if(OrderSelect(i,SELECT_BY_POS)==True)
         if(OrderType() == OP_BUY &&
               OrderSymbol() == Symbol() &&
               OrderMagicNumber() == MagicNumber)
            result = OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 3, Red);
      Print("All Orders Closed. Target Reached");
   }
   return;
}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseAllSell() {
   for(int i=OrdersTotal()-1; i>=0; i--) {
      bool result = false;
      if(OrderSelect(i,SELECT_BY_POS)==True)
         if(OrderType() == OP_SELL &&
               OrderSymbol() == Symbol() &&
               OrderMagicNumber() == MagicNumber)
            result = OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 5, Red);
      Print("Orders Sell Closed. Target Sell Reached");
   }
   return;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseAllBuy() {
   for(int i=OrdersTotal()-1; i>=0; i--) {
      bool result = false;
      if(OrderSelect(i,SELECT_BY_POS)==True)
         if(OrderType() == OP_BUY &&
               OrderSymbol() == Symbol() &&
               OrderMagicNumber() == MagicNumber)
            result = OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 5, Red);
      Print("Orders Buy Closed. Target Buy Reached");
   }
   return;
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void CloseAllSell2() {
   for(int i=OrdersTotal()-1; i>=0; i--) {
      bool result = false;
      if(OrderSelect(i,SELECT_BY_POS)==True)
         if(OrderType() == OP_SELL)
            result = OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 5, Red);
      Print("Orders Sell Closed. Target Sell Reached");
   }
   return;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseAllBuy2() {
   for(int i=OrdersTotal()-1; i>=0; i--) {
      bool result = false;
      if(OrderSelect(i,SELECT_BY_POS)==True)
         if(OrderType() == OP_BUY)
            result = OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 5, Red);
      Print("Orders Buy Closed. Target Buy Reached");
   }
   return;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double ProfitOrder1(int Type) {
   double profitbuy = 0;
   int i,ordTotal=OrdersTotal();
   for(i=0; i<ordTotal; i++) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==True)
         if(OrderSymbol()==Symbol())
            if(OrderMagicNumber() == MagicNumber)
               if(OrderType() == Type) {
                  profitbuy += OrderProfit() + OrderSwap() + OrderCommission();
               }
   }
   return(profitbuy);
}
//+------------------------------------------------------------------+
double ProfitOrder2(int Type) {
   double profitbuy = 0;
   int i,ordTotal=OrdersTotal();
   for(i=0; i<ordTotal; i++) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==True)
               if(OrderType() == Type) {
                  profitbuy += OrderProfit() + OrderSwap() + OrderCommission();
               }
   }
   return(profitbuy);
}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void trailing() {
   double    Act;
   double    SL1;
   double    Next;
   double TStart0,TStart1,TStop0,TStop1;
   double BEP0=BEP(OP_BUY);
   double BEP1=BEP(OP_SELL);
   if(CountOrder(OP_BUY)>1){
      TStart0=TrailingStartAV;
      TStop0=TrailingStopAV;
      }
   else {
      TStart0=TrailingStart;
      TStop0=TrailingStop;
      }
      
      
   if(CountOrder(OP_SELL)>1){
      TStart1=TrailingStartAV;
      TStop1=TrailingStopAV;
      }
   else {
      TStart1=TrailingStart;
      TStop1=TrailingStop;
      }


   if ( TrailingStop == 0 )   return;
   for (int i = OrdersTotal() - 1 ; i >= 0 ; i = i - 1) {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))continue;
        if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=MagicNumber ) continue;

      if (  OrderSymbol() == Symbol() ) {
         if ( OrderType() == OP_BUY ) {
            Act = NormalizeDouble((Bid - BEP0) / g_Point,0) ;
            if ( Act < TStart0 )   continue;
            SL1 = OrderStopLoss() ;
            Next = Bid - TStop0 * g_Point ;
            if ( ( SL1==0.0 || (SL1!=0.0 && Next>SL1) ) ) {
               bool result1 = OrderModify(OrderTicket(),BEP0,Next,OrderTakeProfit(),0,clrAqua) ;
            }
         }
         if ( OrderType() == OP_SELL ) {
            Act = NormalizeDouble((BEP1 - Ask) / g_Point,0) ;
            if ( Act < TStart1 )   continue;
            SL1 = OrderStopLoss() ;
            Next = TStop1 * g_Point + Ask ;
            if ( ( SL1==0.0 || (SL1!=0.0 && Next<SL1) ) ) {
               bool result1 = OrderModify(OrderTicket(),BEP1,Next,OrderTakeProfit(),0,clrRed) ;
            }
         }
      }
   }
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
int LastTicket(int Type)
{
int    ticket1=0;
for (int x=0;x<OrdersTotal();x++)
     {
     if(OrderSelect           (x,SELECT_BY_POS,MODE_TRADES))
     if(OrderSymbol()         !=  Symbol())            continue;
     if(OrderMagicNumber()    !=  MagicNumber)         continue; 
     if(OrderType()           == Type)
     if(OrderTicket()         >   ticket1 || ticket1 == 0 )
                     ticket1   =   OrderTicket();
     }// for loop  

return(ticket1);
}
//-----------------------------------------------------------------+
double LastPrice(int Type)
{
double value=0;
int ticket1  =  LastTicket(Type);
if(OrderSelect(ticket1,SELECT_BY_TICKET,MODE_TRADES))
   value= OrderOpenPrice();

return(value);
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double BEP(int Type) {
   double BEP = 0;
   if(TotalLots(Type) != 0) {
      if(Type == OP_BUY) {
         BEP = (TotalPrice(OP_BUY)/TotalLots(OP_BUY));
      } else if(Type == OP_SELL) {
         BEP = (TotalPrice(OP_SELL)/TotalLots(OP_SELL));
      }
   }
   return(BEP);
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double TotalPrice(int Type) {
   double price = 0;
   int i,total=OrdersTotal();
   for(i=0; i<total; i++) {
      if(OrderSelect(i,SELECT_BY_POS)==True)
         if(OrderSymbol()==Symbol())
          if(OrderMagicNumber()==MagicNumber)
            if(OrderType() == Type) {
               price += OrderOpenPrice()*OrderLots();
            }
   }
   return(price);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double TotalLots(int Type) {
   double lots = 0;
   int i,total=OrdersTotal();
   for(i=0; i<total; i++) {
      if(OrderSelect(i,SELECT_BY_POS)==True)
         if(OrderSymbol()==Symbol())
          if(OrderMagicNumber()==MagicNumber)
            if(OrderType() == Type) {
               lots += OrderLots();
            }
   }
   return(lots);
}

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void PutNewTP(int Type, double NewTP) {
   for(int i=0; i<OrdersTotal(); i++) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
         break;
      if(OrderSymbol()!=Symbol())
         continue;
          if(OrderMagicNumber()!=MagicNumber)
            continue;
         if(OrderType()== Type)
            if(NormalizeDouble(OrderTakeProfit(),digit) != NormalizeDouble(NewTP,digit))
               bool result1 = OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),NewTP,0,clrNONE);
   }
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double GetSLBuy()
{
   double SLBuy1 = 0;
      int ticket1   = LastTicket(0);
      if(OrderSelect(ticket1,SELECT_BY_TICKET,MODE_TRADES))
           SLBuy = OrderStopLoss();
return(SLBuy);
}

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double GetSLSell()
{
   double SLSell1 = 0;
      int ticket1   = LastTicket(1);
      if(OrderSelect(ticket1,SELECT_BY_TICKET,MODE_TRADES))
           SLSell = OrderStopLoss();
return(SLSell);
}

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void PutNewSL(int Type, double NewSL) {
   for(int i=0; i<OrdersTotal(); i++) {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
         break;
      if(OrderSymbol()!=Symbol())
         continue;
          if(OrderMagicNumber()!=MagicNumber)
            continue;
         if(OrderType()== Type)
            if(NormalizeDouble(OrderTakeProfit(),digit) != NormalizeDouble(NewSL,digit))
               bool result1 = OrderModify(OrderTicket(),OrderOpenPrice(),NewSL,OrderTakeProfit(),0,clrNONE);
   }
}
//+------------------------------------------------------------------+
double trad(int m)
{
  for (int i = 0; i < OrdersHistoryTotal(); i++) {
   if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;
   if (OrderSymbol() != Symbol()) continue;
   if(m==1)pr=OrderProfit();
   if(m==2)pr=OrderType();
   if(m==3)pr=OrderMagicNumber();
   }
return(pr);
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double ProfitOrder()
  {
   double profitbuy = 0;
   int i,ordTotal=OrdersTotal();
   for(i=0; i<ordTotal; i++)
     {
      if(!OrderSelect(i, SELECT_BY_POS, MODE_TRADES))continue;
      if (OrderSymbol() != Symbol()  || OrderMagicNumber()!=MagicNumber) continue;
      profitbuy += OrderProfit() + OrderSwap() + OrderCommission();
     }
   return(profitbuy);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
 void closeall(int m)
{
int    ticket1 =0;
 for (int i = OrdersTotal() - 1; i >= 0; i--) 
 {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))continue;
  if (OrderSymbol() != Symbol() || OrderMagicNumber()!=MagicNumber||  OrderType()!=m) continue;
   if (OrderType() > 1) ticket1=OrderDelete(OrderTicket());
  if (OrderType() == 0) ticket1=OrderClose(OrderTicket(), OrderLots(), Bid, 3, CLR_NONE);
  if (OrderType() == 1) ticket1=OrderClose(OrderTicket(), OrderLots(), Ask, 3, CLR_NONE);
 }
}
//+------------------------------------------------------------------+
double GLots(int TotalOrder, int Type) {
   int NumTrade=CountOrder(Type);
   
   int total_use = TotalOrder;
   
   if(!Manual_Next_Lots) {
      vlot=NormalizeDouble(Lots*MathPow(Marti,NumTrade),2);
      }
   
   
   if(Manual_Next_Lots) {
      if(ArraySize(Next_Lots_Arr)>=1 && TotalOrder-1>=0) {
         if(TotalOrder-1<=ArraySize(Next_Lots_Arr))return(NormalizeDouble(Next_Lots_Arr[TotalOrder-1],2));
         else return(NormalizeDouble(Next_Lots_Arr[ArraySize(Next_Lots_Arr)-1],2));
      }
   }
   return (vlot);
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void              StringToDoubleArray_f(string String_inp,double &Out_Arr[]) {
   //---
   string sep=";";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string result[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   int k=StringSplit(String_inp,u_sep,result);
   //--- Now output all obtained strings
   ArrayResize(Out_Arr,ArraySize(result));
   if(k>0) {
      for(int j=0; j<k; j++) {
         Out_Arr[j]=StringToDouble(result[j]);
         //PrintFormat("result[%d]=%s",i,Out_Arr[i]);
      }
   }
}
//+------------------------------------------------------------------+
void info()
   {
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_SHOW_ASK_LINE,true);
   ChartSetInteger(0,CHART_COLOR_ASK,clrBlack);
   ChartSetInteger(0,CHART_SHOW_BID_LINE,true);
   ChartSetInteger(0,CHART_COLOR_BID,clrBlack);
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrBlack);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrWhite);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,clrRed);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,clrRed);
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,clrBlack);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,clrBlue);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrBlue);
   ChartSetInteger(0,CHART_COLOR_GRID,clrBlack);
   ChartSetInteger(0,CHART_COLOR_VOLUME,clrCrimson);
   ChartSetInteger(0,CHART_SHIFT,1);
   ChartSetInteger(0,CHART_SHOW_GRID,0);

   ObjectCreate("ObjLabel7", OBJ_LABEL, 0, 0, 0);
   ObjectSet("ObjLabel7", OBJPROP_CORNER, 1);
   ObjectSet("ObjLabel7", OBJPROP_XDISTANCE, 10);
   ObjectSet("ObjLabel7", OBJPROP_YDISTANCE, 50);
   ObjectSetText("ObjLabel7", EAComment, 13, "Times New Roman", Red);

   ObjectCreate("ObjLabel1", OBJ_LABEL, 0, 0, 0);
   ObjectSet("ObjLabel1", OBJPROP_CORNER, 1);
   ObjectSet("ObjLabel1", OBJPROP_XDISTANCE, 10);
   ObjectSet("ObjLabel1", OBJPROP_YDISTANCE, 85);
   ObjectSetText("ObjLabel1", AccountName(), 15, "Arial", Black);

   
   ObjectCreate("ObjLabel8", OBJ_LABEL, 0, 0, 0);
   ObjectSet("ObjLabel8", OBJPROP_CORNER, 1);
   ObjectSet("ObjLabel8", OBJPROP_XDISTANCE, 10);
   ObjectSet("ObjLabel8", OBJPROP_YDISTANCE, 200);
   ObjectSetText("ObjLabel8", "Server Time : "+IntegerToString(Hour())+" : "+IntegerToString(Minute())+" : "+IntegerToString(Seconds()), 15, "Arial", Blue);

   ObjectCreate("ObjLabel9", OBJ_LABEL, 0, 0, 0);
   ObjectSet("ObjLabel9", OBJPROP_CORNER, 1);
   ObjectSet("ObjLabel9", OBJPROP_XDISTANCE, 10);
   ObjectSet("ObjLabel9", OBJPROP_YDISTANCE, 245);
   ObjectSetText("ObjLabel9", "Spread : "+IntegerToString(MarketInfo(Symbol(), MODE_SPREAD)), 10, "Arial", Black);
   
   ObjectCreate("ObjLabel11", OBJ_LABEL, 0, 0, 0);
   ObjectSet("ObjLabel11", OBJPROP_CORNER, 1);
   ObjectSet("ObjLabel11", OBJPROP_XDISTANCE, 10);
   ObjectSet("ObjLabel11", OBJPROP_YDISTANCE, 280);
   ObjectSetText("ObjLabel11", "https://t.me/JIMBARWANAFX", 10, "Arial", Black);

   ObjectCreate("ObjLabel3", OBJ_LABEL, 0, 0, 0);
   ObjectSet("ObjLabel3", OBJPROP_CORNER, 1);
   ObjectSet("ObjLabel3", OBJPROP_XDISTANCE, 10);
   ObjectSet("ObjLabel3", OBJPROP_YDISTANCE, 125);
   ObjectSetText("ObjLabel3", "Balance : "+DoubleToString(AccountBalance(),2), 15, "Arial", clrDarkOrchid);

   ObjectCreate("ObjLabel4", OBJ_LABEL, 0, 0, 0);
   ObjectSet("ObjLabel4", OBJPROP_CORNER, 1);
   ObjectSet("ObjLabel4", OBJPROP_XDISTANCE, 10);
   ObjectSet("ObjLabel4", OBJPROP_YDISTANCE, 160);
   ObjectSetText("ObjLabel4", "Equity : "+DoubleToString(AccountEquity(),2), 15, "Arial", Red);

   }
//+------------------------------------------------------------------+

