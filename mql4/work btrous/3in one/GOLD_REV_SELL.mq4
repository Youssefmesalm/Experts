//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2018, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {


  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTimer()
  {

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool SendInitialMarketOrder(ENUM_ORDER_TYPE type)
  {
   RefreshRates();

   int ticket = -1;

   if(type == ORDER_TYPE_BUY)
     {
      if(!is_allowed())
         return false;
      ticket = OrderSend(_Symbol, ORDER_TYPE_BUY, SelectVolume(1), Ask, SlippagePips, ToNearestTick(Bid-TargetPoints * _Point), 0, ToComment(1), MagicId, 0, clrGreen);
     }
   else
     {
      if(!is_allowed())
         return false;
      ticket = OrderSend(_Symbol, ORDER_TYPE_SELL, SelectVolume(1), Bid, SlippagePips, ToNearestTick(Ask + TargetPoints * _Point), 0, ToComment(1), MagicId, 0, clrRed);
     }
   return ticket > 0;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int SelectDistance(int currentStep)
  {
   return
      currentStep < Max_A_ordersCount                     ? Average_A_StepPoints
      : currentStep < Max_A_ordersCount + Max_B_ordersCount ? Average_B_StepPoints
      : Average_C_StepPoints;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double SelectVolume(int sendingStep)
  {
   double freeVolume
      = sendingStep <= Max_A_ordersCount                       ? A_Lots_Size * A_Lots_Multiplyer
        : sendingStep <= Max_A_ordersCount + Max_B_ordersCount   ? B_Lots_Size * B_Lots_Multiplyer
        : C_Lots_Size * C_Lots_Multiplyer;

   return ToValidVolume(freeVolume);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

