#property copyright "Copyright © 2011, ForexGrowthBot, "

#include <WinUser32.mqh>
#include <stderror.mqh>
#import "quanttradermt4.dll"
int initQuant(int SystemID, int LotLimit, double CapGameProfit, double LossPerLot, double CapManagValue, int CapGameFreq, int EntryFreq, double Marging, int UseWaveTrailing, string WaveTrailing);
double GetVolatilityRatio(double &ArrClose[], double &ArrOpen[], int FastPeriod, int SlowPeriod, int arrLen); 
int GetQuantPositionChange(int SystemID, int useDerivativeSize, int DerivativeSize, double LastPrice, int Signal, int BarNum, double Profit, double Loss, double atrRatio);
int getSystemID();
int SYSTEM_ID = 0;
//---
extern double LotSize = 0.01;
extern double RiskValue = 2.5;
extern int Magic = 110528;
extern bool FIFO = false;
extern int ClosePreviousSessionOrders = 2;
extern bool Assign_PT_and_ST = false;
//Advanced and power
extern string BotComment = "FGB-DE";
extern int FastVolatilityBase = 5;
extern int SlowVolatilityBase = 60;
extern double VolatilityFactor = 2;
//Advanced
extern double ProfitTarget = 0.5;
extern double StopLoss = 0.2;
extern int ProfitLossVolatilityBase = 50;
//All versions
extern double TrailProfitRisk = 0;
//Power only
extern bool UseWaveTrailing = false;
extern string WaveTrailing = "40-80;40-80;40-80;40";
//extended growth settings
extern bool UseDerivativeSize = false;
extern int DerivativeSize = 25;
extern int NoiseLevelBegin = 0; //By default do not add noice
extern int NoiseLevelEnd = 0;   //---------------------------
extern int EntryNoiseCount = 1;
//orders control
bool CheckPrevSession = true;
int RetryNum=30;
int TryDelay=7500;
int slippage=25;
//dll management
int ArrayLen = 100;
double LotLimit = 10;
double StandardLotSize = 100000;
double CapManagementValue = 250;
int CapManagementAggLevel = 240;
int EntryManagementAggLevel = 15; //m15
//other variables
double MinLot,MaxLot,LotStep;
double VarLotSize;
int BarNumber;
datetime LastBarTime;
//---
void SetOptimizedLots()
 {
  if (RiskValue != 0) { VarLotSize = NormalizeDouble(MathFloor( AccountFreeMargin() * (RiskValue * (100.0 / AccountLeverage())) / 100.0 ) * LotStep, 2); }
  else VarLotSize = LotSize;
  if (VarLotSize < MinLot) VarLotSize = MinLot;
  if (VarLotSize > MaxLot) VarLotSize = MaxLot;
 }
//---
double RoundPrec(double Source, double Prec)
 {
  return(MathRound(Source / Prec) * Prec);      
 }
//---
void WaitContext()
 {
  RefreshRates();
  while (IsTradeContextBusy()) {Sleep(100); RefreshRates();}
 }
//--- 
bool CareCloseOrder(int orderNum, int orderType, double Lots)
 {
  bool res = TRUE;
  for (int k=1; (k <= RetryNum); k++)
   {
    WaitContext();
    if (orderType == OP_BUY) res = OrderClose(orderNum, NormalizeDouble(Lots,2), Bid, slippage, Blue);
    if (orderType == OP_SELL) res = OrderClose(orderNum, NormalizeDouble(Lots,2), Ask, slippage, Red);
    if (res) break;
    Sleep(TryDelay);
   } 
  return (res); 
 }
//---
void AdjustPosition(int PositionChange)
 {
  double FinalNetPos = NormalizeDouble(RoundPrec(PositionChange * VarLotSize, LotStep), 2);
  double AbsNetPos=MathAbs(FinalNetPos);
  if (!FIFO) //default
   {
    for (int i = OrdersTotal()-1; i >=0; i--) if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
     {
      if (OrderMagicNumber() != Magic || OrderSymbol() != Symbol()) continue;
      if (OrderType() == OP_BUY && FinalNetPos < 0)
       {
        if (OrderLots() <= AbsNetPos) {if (CareCloseOrder(OrderTicket(), OP_BUY, OrderLots())) {FinalNetPos = FinalNetPos + OrderLots(); AbsNetPos = MathAbs(FinalNetPos);}}
	     else if (AbsNetPos != 0) if (CareCloseOrder(OrderTicket(), OP_BUY, AbsNetPos)) {FinalNetPos = 0; AbsNetPos = 0;}
       }
      if (OrderType() == OP_SELL && FinalNetPos > 0)
       {
        if (OrderLots() <= AbsNetPos) {if (CareCloseOrder(OrderTicket(), OP_SELL, OrderLots())) {FinalNetPos = FinalNetPos - OrderLots(); AbsNetPos = MathAbs(FinalNetPos);}}
        else if (AbsNetPos != 0) if (CareCloseOrder(OrderTicket(), OP_SELL, AbsNetPos))	{FinalNetPos = 0; AbsNetPos = 0;}
       }
     } //for
   }  
  else
   {
    for (i = 0; i < OrdersTotal(); i++) if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
     {
      if (OrderMagicNumber() != Magic || OrderSymbol() != Symbol()) continue;
      if (OrderType() == OP_BUY && FinalNetPos < 0)
       {
        if (OrderLots() <= AbsNetPos) {if (CareCloseOrder(OrderTicket(), OP_BUY, OrderLots())) {i--; FinalNetPos = FinalNetPos + OrderLots(); AbsNetPos = MathAbs(FinalNetPos);}}
	     else if (AbsNetPos != 0) if (CareCloseOrder(OrderTicket(), OP_BUY, AbsNetPos)) {i--; FinalNetPos = 0; AbsNetPos = 0;}
       }
      if (OrderType() == OP_SELL && FinalNetPos > 0)
       {
        if (OrderLots() <= AbsNetPos) {if (CareCloseOrder(OrderTicket(), OP_SELL, OrderLots())) {i--; FinalNetPos = FinalNetPos - OrderLots(); AbsNetPos = MathAbs(FinalNetPos);}}
        else if (AbsNetPos != 0) if (CareCloseOrder(OrderTicket(), OP_SELL, AbsNetPos)) {i--; FinalNetPos = 0; AbsNetPos = 0;}
       }
     } //for
   } //fifo
  if (FinalNetPos == 0) SetOptimizedLots();
  if (FinalNetPos > 0) for (int k=1; (k <= RetryNum); k++)
   {
    WaitContext();
    if (OrderSend(Symbol(), OP_BUY, NormalizeDouble(AbsNetPos,2), Ask, slippage, 0, 0, BotComment, Magic, 0, Blue)!=-1) break;
    Sleep(TryDelay);
   } 
  if (FinalNetPos < 0) for (k=1; (k <= RetryNum); k++)
   {
    WaitContext();
    if (OrderSend(Symbol(), OP_SELL, NormalizeDouble(AbsNetPos,2), Bid, slippage, 0, 0, BotComment, Magic, 0, Red)!=-1) break;
    Sleep(TryDelay);
   } 
 }
//---
int init()
 {
  MinLot=MarketInfo(Symbol(), MODE_MINLOT);
  MaxLot = MarketInfo(Symbol(), MODE_MAXLOT);
  LotStep = MarketInfo(Symbol(), MODE_LOTSTEP);
  if (!IsTesting()) SYSTEM_ID = getSystemID();
  if ((TrailProfitRisk != 0) && (!UseWaveTrailing)) {WaveTrailing = TrailProfitRisk; UseWaveTrailing = TRUE;}
  MathSrand(TimeLocal());
  EntryManagementAggLevel = Period();
  initQuant(SYSTEM_ID, LotLimit, ProfitTarget, StopLoss, CapManagementValue, CapManagementAggLevel, EntryManagementAggLevel, StandardLotSize, UseWaveTrailing, WaveTrailing);
  BarNumber = 0; LastBarTime = 0;
  SetOptimizedLots();
 }
//---
int start()
 {   
  if (CheckPrevSession && !IsTesting())
   {
    CheckPrevSession = false;
    if (ClosePreviousSessionOrders > 0)
     {
      bool askedClear = false;
	   if (ClosePreviousSessionOrders == 2) askedClear = true;
      if (!FIFO)
       {
        for (int i = OrdersTotal()-1; i >=0; i--) if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
         {
          if (OrderMagicNumber() != Magic || OrderSymbol() != Symbol()) continue;
          if (!askedClear)
           {
            askedClear = true;
            if (MessageBox("Close my not tracked orders?","FGB-DE", MB_YESNO|MB_ICONQUESTION) == IDNO) break;
           } 
          CareCloseOrder(OrderTicket(), OrderType(), OrderLots());
         }
       } 
      else
       {
        for (i = 0; i < OrdersTotal(); i++) if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
         {
          if (OrderMagicNumber() != Magic || OrderSymbol() != Symbol()) continue;
          if (!askedClear)
           {
            askedClear = true;
            if (MessageBox("Close my not tracked orders?","FGB-DE", MB_YESNO|MB_ICONQUESTION) == IDNO) break;
           } 
          CareCloseOrder(OrderTicket(), OrderType(), OrderLots()); i--;
         }
       } //else
     } //>0
   } //CheckPrevSession
   
  //---main LOOP
  if (Time[1]!=LastBarTime) 
	{
    LastBarTime = Time[1];
    BarNumber += Period();
    for (int NoiseLevel = NoiseLevelBegin; NoiseLevel <= NoiseLevelEnd; NoiseLevel++) 
     {
		for (int j=0; j < EntryNoiseCount; j++)
       {
        double arrayClose[]; double arrayOpen[]; int AS = ArraySize(Close);
        if (AS >= ArrayLen) 				
         {
			 ArrayCopy(arrayClose, Close, 0, 1, ArrayLen); ArrayCopy(arrayOpen, Open, 0, 1, ArrayLen); double randomAdd;
          if (NoiseLevel > 0) // Add noise
			  {				
				for (i=0; i<ArrayLen; i++)
             {
              if (MathRand() > 16383) randomAdd = (MathRand() + 0.0000001) / 32767.0 * (NoiseLevel * Point);		
				  else randomAdd = - (MathRand() + 0.0000001) / 32767.0 * (NoiseLevel * Point);		      
              arrayClose[i] += randomAdd;
             }
				for (i=0; i<ArrayLen; i++)
             {
              if (MathRand() > 16383) randomAdd = (MathRand() + 0.0000001) / 32767.0 * (NoiseLevel * Point);		
				  else randomAdd = - (MathRand() + 0.0000001) / 32767.0 * (NoiseLevel * Point);		     
              arrayOpen[i] += randomAdd;
             }
           }
         }
        int Signal = 0; 
        if (AS >= ArrayLen)
			{  
          double volatatilityRatio = GetVolatilityRatio(arrayClose, arrayOpen, FastVolatilityBase, SlowVolatilityBase, ArrayLen);  
          if (MathAbs(volatatilityRatio) > VolatilityFactor)				  				
			  {
				if (volatatilityRatio > 0) Signal = 1;
				else Signal = -1;		
           }	
			}																	 
        double atrRatio = High[iHighest(NULL, 0, MODE_HIGH, ProfitLossVolatilityBase, 1)] - Low[iLowest(NULL, 0, MODE_LOW, ProfitLossVolatilityBase, 1)];			   
		  atrRatio *= StandardLotSize;  
        if (!Assign_PT_and_ST)
			{
          int ChangePosition = GetQuantPositionChange(SYSTEM_ID, UseDerivativeSize, DerivativeSize, arrayClose[0], Signal, BarNumber, ProfitTarget, StopLoss, atrRatio);
          if (ChangePosition != 0) AdjustPosition(ChangePosition);
          //if (Signal != 0) break; // EntryNoiseCount LOOP
         }
        else 
			{
			 if (Signal != 0)
			  {
            double PTSL_Level = High[iHighest(NULL, 0, MODE_HIGH, ProfitLossVolatilityBase, 1)] - Low[iLowest(NULL, 0, MODE_LOW, ProfitLossVolatilityBase, 1)];
            SetOptimizedLots();
           } 
		    if (Signal == 1) for (int k=1; (k <= RetryNum); k++)
           {
            WaitContext();
            if (OrderSend(Symbol(), OP_BUY, VarLotSize, Ask, slippage, Ask - PTSL_Level * StopLoss,Ask + PTSL_Level * ProfitTarget, BotComment, Magic, 0, Blue)!=-1) break;
            Sleep(TryDelay);
           } 
			 if (Signal == -1)  for (k=1; (k <= RetryNum); k++)
           {
            WaitContext();
			   if (OrderSend(Symbol(), OP_SELL, VarLotSize, Bid, slippage, Bid + PTSL_Level * StopLoss, Bid - PTSL_Level * ProfitTarget, BotComment, Magic, 0, Red)!=-1) break;
            Sleep(TryDelay);
           } 
		   } // Assign_PT_and_ST		
			
       } // EntryNoiseCount

	  } // NoiseLevel

	} //Time
	
 } //start

