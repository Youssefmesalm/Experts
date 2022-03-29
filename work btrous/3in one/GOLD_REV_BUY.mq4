#property strict
#property version   "1.2"   

enum Enum_GridSide
{
   GridSide_Buy,   //Buy only
   GridSide_Sell,  //Sell only
   GridSide_Both   //Both
};

input int MagicId = 555;                     //Magic
input Enum_GridSide GridSide = GridSide_Buy; //Trade type

input int Max_A_ordersCount = 1;             //Max number of orders A type (0 to disable)
input double A_Lots_Size = 0.01;             //A lots size
input double A_Lots_Multiplyer = 1.0;        //A lots multiplyer
input int Average_A_StepPoints = 100;        //Average A step points

input int Max_B_ordersCount = 1;             //Max number of orders B type (0 to disable)
input double B_Lots_Size = 0.01;             //B lots size
input double B_Lots_Multiplyer = 3.0;        //B lots multiplyer
input int Average_B_StepPoints = 200;        //Average B step points

input int Max_C_ordersCount = 10;             //Max number of orders C type (0 to disable)
input double C_Lots_Size = 0.01;             //C lots size
input double C_Lots_Multiplyer = 5.0;        //C lots multiplyer
input int Average_C_StepPoints = 100;        //Average C step points

input int TargetPoints = 5000;                //Target points
input int SlippagePips = 500;                //Slippage
input string Comment = "Finovics EA";        //Comment

input string TimePeriodToLetEaWork = "14:59:45-23:59:59";
input bool BoolToLetEaClosePositions = false;
input string TimeToLetEaClosePositions = "00:00:00";

enum Enum_Side
{
   Side_Buy,
   Side_Sell,
   Side_None
};

int OnInit()
 {
  EventSetTimer(1);
 if(!GlobalVariableCheck("activated")){
 GlobalVariableSet("activated",1);
 }
  SetValuesOfTime();
  SetValuesOfTimeClose();
  return(INIT_SUCCEEDED);
 }

void OnTick()
{
   if(GlobalVariableGet("activated")==0)return;

   TimeAllowed timeAllowed = CheckTime();
   
   if(timeAllowed == AllowedTime){
   static Enum_Side lastGridSide = Side_None;
   
   SelectOpenOrders().CheckDeleteNonExecutedPending();
   SelectOpenOrders().ModifyAllSls(lastGridSide);
   
   if (SelectOpenOrders().Cum() == 0)
   {
      ENUM_ORDER_TYPE newLoopSide
         = GridSide == GridSide_Buy ? ORDER_TYPE_BUY
         : GridSide == GridSide_Sell ? ORDER_TYPE_SELL
         : lastGridSide == Side_Buy ? ORDER_TYPE_SELL
         : ORDER_TYPE_BUY;
         
      SendInitialMarketOrder(newLoopSide);
      
      lastGridSide = newLoopSide == ORDER_TYPE_BUY ? Side_Buy : Side_Sell;
   }

   SelectOpenOrders().CheckSendNextLimit();}
   if(BoolToLetEaClosePositions){
   if(CheckTimeClose()==CLOSE)
   {
      SelectOpenOrders().CheckDeleteNonExecutedPending();
      CloseAnyOpenOrder();
   }}

}

void OnTimer()
{

}

bool SendInitialMarketOrder(ENUM_ORDER_TYPE type)
{
   RefreshRates();
   
   int ticket = -1;
   
   if(!is_allowed())return false;
   
   if (type == ORDER_TYPE_BUY)
   {
      ticket = OrderSend(_Symbol, ORDER_TYPE_BUY, SelectVolume(1), Ask, SlippagePips, ToNearestTick(Bid-TargetPoints * _Point), 0, ToComment(1), MagicId, 0, clrGreen);
   }
   else
   {
      ticket = OrderSend(_Symbol, ORDER_TYPE_SELL, SelectVolume(1), Bid, SlippagePips, ToNearestTick(Ask + TargetPoints * _Point), 0, ToComment(1), MagicId, 0, clrRed);
   }
   return ticket > 0;
}

int SelectDistance(int currentStep)
{
   return
        currentStep < Max_A_ordersCount                     ? Average_A_StepPoints
      : currentStep < Max_A_ordersCount + Max_B_ordersCount ? Average_B_StepPoints
                                                            : Average_C_StepPoints;
}
double SelectVolume(int sendingStep)
{
   double freeVolume
      = sendingStep <= Max_A_ordersCount                       ? A_Lots_Size * A_Lots_Multiplyer
      : sendingStep <= Max_A_ordersCount + Max_B_ordersCount   ? B_Lots_Size * B_Lots_Multiplyer
                                                               : C_Lots_Size * C_Lots_Multiplyer;
   
   return ToValidVolume(freeVolume);
}
string ToComment(int step)
{
   string letter
      = step <= Max_A_ordersCount                     ? "A"
      : step <= Max_A_ordersCount + Max_B_ordersCount ? "B" 
                                                      : "C";
      
   int number
      = step <= Max_A_ordersCount                     ? step
      : step <= Max_A_ordersCount + Max_B_ordersCount ? step - Max_A_ordersCount 
                                                      : step - Max_A_ordersCount - Max_B_ordersCount;
   
   return Comment + " " + letter + IntegerToString(number);
}

struct OrderData
{
   public:
      int Ticket;
      int Type;
      double Volume;
      double OpenPrice;
      int Magic;
      double Sl;
      string Comment;
      
      
      void ModifySl(double newSl)
      {
         if (NormalizeDouble(this.Sl, 8) == NormalizeDouble(newSl, 8)) return;
         
         bool sent = OrderModify(this.Ticket, this.OpenPrice, newSl, 0, 0);
      }
      void DeletePending()
      {
         RefreshRates();
            
         bool deleted = OrderDelete(this.Ticket);
      }
      
};
struct Snapshot
{
   public:
      OrderData Orders[];
      
      int Cum()
      {
         return ArraySize(Orders);
      }
      int Cum(ENUM_ORDER_TYPE type)
      {
         int cum = 0;
         for (int i = 0; i < ArraySize(Orders); i++)
         {
            if (Orders[i].Type == type) cum++;
         }
         return cum;
      }
      double GetVolumeWeightedAveragePrice(ENUM_ORDER_TYPE marketType)
      {
         double cum = 0;
         double cumVolume = 0.0;
         for (int i = 0; i < Cum(); i++)
         {
            if (Orders[i].Type != marketType) continue;
            
            cum += Orders[i].Volume * Orders[i].OpenPrice;
            
            cumVolume += Orders[i].Volume;
         }
         return cumVolume == 0 ? 0 : cum / cumVolume;
      }
      
      void CheckDeleteNonExecutedPending()
      {
         if ((Cum(ORDER_TYPE_BUY) == 0 && Cum(ORDER_TYPE_BUY_STOP) > 0) || (Cum(ORDER_TYPE_SELL) == 0 && Cum(ORDER_TYPE_SELL_STOP) > 0))
         {
            Orders[0].DeletePending();
         }
      }
      
      void CheckSendNextLimit()
      {
         int step = Cum();
         
         if (step >= Max_A_ordersCount + Max_B_ordersCount + Max_C_ordersCount) return;
         
         double volume = SelectVolume(step + 1);
         
         string comment = ToComment(step + 1);
         
         RefreshRates();
         
         if (Cum(ORDER_TYPE_BUY) > 0 && Cum(ORDER_TYPE_BUY_STOP) == 0)
         {
            double nextPrice = Orders[ArraySize(Orders) - 1].OpenPrice + SelectDistance(step) * _Point;
            
            nextPrice = ToNearestTick(MathMax(nextPrice, Ask + _Point));
            if(!is_allowed())return;
            int sent = OrderSend(_Symbol, ORDER_TYPE_BUY_STOP, volume, nextPrice, INT_MAX, 0, 0, comment, MagicId, 0, clrGreen);
         }
         else if (Cum(ORDER_TYPE_SELL) > 0 && Cum(ORDER_TYPE_SELL_STOP) == 0)
         {
            double nextPrice = Orders[ArraySize(Orders) - 1].OpenPrice - SelectDistance(step) * _Point;
            
            nextPrice = ToNearestTick(MathMin(nextPrice, Bid - _Point));
            if(!is_allowed())return;
            int sent = OrderSend(_Symbol, ORDER_TYPE_SELL_STOP, volume, nextPrice, INT_MAX, 0, 0, comment, MagicId, 0, clrRed);
         }
      }
      void ModifyAllSls(Enum_Side side)
      {
         double avg = GetVolumeWeightedAveragePrice(side == Side_Buy ? ORDER_TYPE_BUY : ORDER_TYPE_SELL);
         
         double sl = side == Side_Buy ? avg - TargetPoints * _Point : avg + TargetPoints * _Point;
         
         for (int i = 0; i < Cum(); i++)
         {
            Orders[i].ModifySl(ToNearestTick(sl));
         }
      }
};
Snapshot SelectOpenOrders()
{   
   Snapshot result;
   
   int total = OrdersTotal();
   
   ArrayResize(result.Orders, total);
   
   int n = 0;
   for (int i = 0; i < total; i++)
   {
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES) && OrderSymbol() == _Symbol && OrderMagicNumber() == MagicId)
      {
         int ticket = OrderTicket();
         
         int k = n;
         
         if (n != 0 && ticket < result.Orders[n - 1].Ticket)
         {
            result.Orders[n - 1] = result.Orders[n];
            
            k = n - 1;
         }
         
         result.Orders[k] = CopySelected();
         
         n++;
      }
   }
   ArrayResize(result.Orders, n);
   
   return result;
}
OrderData CopySelected()
{
   OrderData result;
         
   result.Ticket = OrderTicket();
   result.Type = OrderType();
   result.Volume = OrderLots();
   result.OpenPrice = OrderOpenPrice();
   result.Magic = OrderMagicNumber();
   result.Sl = OrderStopLoss();
   result.Comment = OrderComment();
   
   return result;
}


double ToValidVolume(double freeVolume)
{
   double _minlot    = MarketInfo(_Symbol, MODE_MINLOT);
   double _maxlot    = MarketInfo(_Symbol, MODE_MAXLOT);
   double _lotstep   = MarketInfo(_Symbol, MODE_LOTSTEP);
   
   double _lot = MathMin(_maxlot, MathMax(_minlot, MathRound(freeVolume / _lotstep) * _lotstep));
   
   return _lot;
}
const double TickSize()
{
   return SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_SIZE);
}
double ToNearestTick(double price)
{
   return TickSize() * (int)MathRound(price / TickSize());
}

enum TimeAllowed
  {
   AllowedTime,
   NotAllowedTime
  };  

TimeAllowed CheckTime()
  {
   datetime CurrentTime = TimeCurrent();
   MqlDateTime currentTimeStr; TimeToStruct(CurrentTime,currentTimeStr);
   

   int CurrentHour = currentTimeStr.hour;
   int CurrentMin = currentTimeStr.min;
   int CurrentSec = currentTimeStr.sec;
   
   if(CurrentHour>StartHour && CurrentHour < StopHour) return AllowedTime;
   if(CurrentHour==StartHour && ((CurrentMin > StartMin && CurrentMin < StopMin) || (CurrentMin == StartMin && CurrentSec > StartSec))) return AllowedTime;
   if(CurrentHour==StopHour && (CurrentMin < StopMin || (CurrentMin == StopMin && CurrentSec < StopSec))) return AllowedTime;    

   
   return NotAllowedTime;
  }  
long StartHour,StartMin,StartSec,StopHour,StopMin,StopSec; 

void SetValuesOfTime()
  {
   string Open_Close[]; ushort u_charB; u_charB = StringGetCharacter("-",0); StringSplit(TimePeriodToLetEaWork,u_charB,Open_Close);

   string Hours_Mins_Secs_Start[],Hours_Mins_Secs_Stop[];ushort u_charS; u_charS = StringGetCharacter(":",0);
   StringSplit(Open_Close[0],u_charS,Hours_Mins_Secs_Start);StringSplit(Open_Close[1],u_charS,Hours_Mins_Secs_Stop);
   
   StartHour = StringToInteger(Hours_Mins_Secs_Start[0]);
   StartMin = StringToInteger(Hours_Mins_Secs_Start[1]);
   StartSec = StringToInteger(Hours_Mins_Secs_Start[2]);
   
   StopHour = StringToInteger(Hours_Mins_Secs_Stop[0]);
   StopMin = StringToInteger(Hours_Mins_Secs_Stop[1]);
   StopSec = StringToInteger(Hours_Mins_Secs_Stop[2]);
  }  
  
long CloseHours, CloseMin, CloseSec;

void SetValuesOfTimeClose()
  {
   string Hours_Mins_Secs_Close[];ushort u_charS; u_charS = StringGetCharacter(":",0);
   StringSplit(TimeToLetEaClosePositions,u_charS,Hours_Mins_Secs_Close);
   
   
   
   CloseHours = StringToInteger(Hours_Mins_Secs_Close[0]);
   CloseMin = StringToInteger(Hours_Mins_Secs_Close[1]);
   CloseSec = StringToInteger(Hours_Mins_Secs_Close[2]);  

  } 
  
enum CloseOrNo
  {
   CLOSE,
   NO_CLOSE
  };  
   
CloseOrNo CheckTimeClose()
  {
   datetime CurrentTime = TimeCurrent();
   MqlDateTime currentTimeStr; TimeToStruct(CurrentTime,currentTimeStr);
   

   int CurrentHour = currentTimeStr.hour;
   int CurrentMin = currentTimeStr.min;
   int CurrentSec = currentTimeStr.sec;

   /*if(CurrentHour>=CloseHours)
   {
      if(CurrentHour>CloseHours) return CLOSE;
      if(CurrentHour==CloseHours)
      {
         if(CurrentMin>StopMin) return CLOSE;
         if(CurrentMin==StopMin && CurrentSec > StopSec) return CLOSE;
         
      } 
   }*/
   if(CurrentHour == CloseHours && CurrentMin == CloseMin) return CLOSE;  
   return NO_CLOSE;
  }


    
void CloseAnyOpenOrder()
  {
   for(int i = OrdersTotal();i>=0;i--)
     {
      if(OrderSelect(i,SELECT_BY_POS)&&OrderMagicNumber()==MagicId&&OrderSymbol()==Symbol())
      {
         if(OrderType()==0){if(OrderClose(OrderTicket(),OrderLots(),Bid,5)){;}} 
         if(OrderType()==1){if(OrderClose(OrderTicket(),OrderLots(),Ask,5)){;}}  
      }
     }
  }
  
  
bool is_allowed(){
   if(GlobalVariableGet("activated")==0)return false;
   
   return true;
   }  