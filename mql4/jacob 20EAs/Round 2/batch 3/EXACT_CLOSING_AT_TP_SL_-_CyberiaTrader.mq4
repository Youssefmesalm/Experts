#property copyright "Copyright c 2006, Cyberia Decisions"
#property link      "http://cyberia.org.ru"


#define DECISION_BUY 1
#define DECISION_SELL 0
#define DECISION_UNKNOWN -1

//---- Ãëîáàëüíûå ïåðåìåííûå
extern bool ExitMarket = false;
extern bool ShowSuitablePeriod = false;
extern bool ShowMarketInfo = false;
extern bool ShowAccountStatus = false;
extern bool ShowStat = false;
extern bool ShowDecision = false;
extern bool ShowDirection = false;
extern bool BlockSell = false;
extern bool BlockBuy = false;
extern bool ShowLots = false;
extern bool BlockStopLoss = false;
extern bool DisableShadowStopLoss = true;
extern bool DisableExitSell = false;
extern bool DisableExitBuy = false;
extern bool EnableMACD = false;
extern bool EnableMA = false;
extern bool EnableCyberiaLogic = true;
extern bool EnableLogicTrading = false;
extern bool EnableMoneyTrain = false;
extern bool EnableReverceDetector = false;
extern double ReverceIndex = 3;
extern double MoneyTrainLevel = 4;
extern int MACDLevel = 10;
extern bool AutoLots = True;
extern bool AutoDirection = True;
extern double ValuesPeriodCount = 23;
extern double ValuesPeriodCountMax = 23;
extern double SlipPage = 1; // Ïðîñêàëüçûâàíèå ñòàâêè
extern double Lots = 0.1; // Êîëè÷åñòâî ëîòîâ
extern double StopLoss = 0;
extern double TakeProfit = 0;
extern double SymbolsCount = 1;
extern double Risk = 0.5;
extern double StopLossIndex = 1.1;
extern bool AutoStopLossIndex = true;
extern double StopLevel;
bool DisableSell = false;
bool DisableBuy = false;
bool ExitSell = false;
bool ExitBuy = false;
double Disperce = 0;
double DisperceMax = 0;
bool DisableSellPipsator = false;
bool DisableBuyPipsator = false;
//----
double ValuePeriod = 1; // Øàã ïåðèîäà â ìèíóòàõ
double ValuePeriodPrev = 1;
int FoundOpenedOrder = false;
bool DisablePipsator = false;
double BidPrev = 0;
double AskPrev = 0;
// Ïåðåìåííûå äëÿ îöåíêè êà÷åñòâà ìîäåëèðîâàíèÿ
double BuyPossibilityQuality;
double SellPossibilityQuality;
double UndefinedPossibilityQuality;
//double BuyPossibilityQualityMid;
double PossibilityQuality;
double QualityMax = 0;
//----
double BuySucPossibilityQuality;
double SellSucPossibilityQuality;
double UndefinedSucPossibilityQuality;
double PossibilitySucQuality;
//----
double ModelingPeriod; // Ïåðèîä ìîäåëèðîâàíèÿ â ìèíóòàõ
double ModelingBars; // Êîëè÷åñòâî øàãîâ â ïåðèîäå
//----
double Spread; // Ñïðýä
double Decision;
double DecisionValue;
double PrevDecisionValue;
//----
int ticket, total, cnt;
//----
double BuyPossibility;
double SellPossibility;
double UndefinedPossibility;
double BuyPossibilityPrev;
double SellPossibilityPrev;
double UndefinedPossibilityPrev;
//----
double BuySucPossibilityMid; // Ñðåäíÿÿ âåðîÿòíîñòü óñïåøíîé ïîêóïêè
double SellSucPossibilityMid; // Ñðåäíÿÿ âåðîÿòíîñòü óñïåøíîé ïðîäàæè
double UndefinedSucPossibilityMid; // Ñðåäíÿÿ óñïåøíàÿ âåðîÿòíîñòü íåîïðåäåëåííîãî ñîñòîÿíèÿ
//----
double SellSucPossibilityCount; // Êîëè÷åñòâî âåðîÿòíîñòåé óñïåøíîé ïðîäàæè
double BuySucPossibilityCount; // Êîëè÷åñòâî âåðîÿòíîñòåé óñïåøíîé ïîêóïêè
double UndefinedSucPossibilityCount; // Êîëè÷åñòâî âåðîÿòíîñòåé íåîïðåäåëåííîãî ñîñòîÿíèÿ
//----
double BuyPossibilityMid; // Ñðåäíÿÿ âåðîÿòíîñòü ïîêóïêè
double SellPossibilityMid; // Ñðåäíÿÿ âåðîÿòíîñòü ïðîäàæè
double UndefinedPossibilityMid; // Ñðåäíÿÿ âåðîÿòíîñòü íåîïðåäåëåííîãî ñîñòîÿíèÿ
//----
double SellPossibilityCount; // Êîëè÷åñòâî âåðîÿòíîñòåé ïðîäàæè
double BuyPossibilityCount; // Êîëè÷åñòâî âåðîÿòíîñòåé ïîêóïêè
double UndefinedPossibilityCount; // Êîëè÷åñòâî âåðîÿòíîñòåé íåîïðåäåëåííîãî ñîñòîÿíèÿ
//----
// Ïåðåìåííûå äëÿ õðàíåíèÿ èíôîðìàöèÿ î ðûíêå
double ModeLow;
double ModeHigh;
double ModeTime;
double ModeBid;
double ModeAsk;
double ModePoint;
double ModeDigits;
double ModeSpread;
double ModeStopLevel;
double ModeLotSize;
double ModeTickValue;
double ModeTickSize;
double ModeSwapLong;
double ModeSwapShort;
double ModeStarting;
double ModeExpiration;
double ModeTradeAllowed;
double ModeMinLot;
double ModeLotStep;
//+------------------------------------------------------------------+
//|Ñ÷èòûâàåì èíôîðìàöèþ î ðûíêå                                                                  |
//+------------------------------------------------------------------+
int GetMarketInfo()
  {
   // Ñ÷èòûâàåì èíôîðìàöèþ î ðûíêå
   ModeLow = MarketInfo(Symbol(), MODE_LOW);
   ModeHigh = MarketInfo(Symbol(), MODE_HIGH);
   ModeTime = MarketInfo(Symbol(), MODE_TIME);
   ModeBid = MarketInfo(Symbol(), MODE_BID);
   ModeAsk = MarketInfo(Symbol(), MODE_ASK);
   ModePoint = MarketInfo(Symbol(), MODE_POINT);
   ModeDigits = MarketInfo(Symbol(), MODE_DIGITS);
   ModeSpread = MarketInfo(Symbol(), MODE_SPREAD);
   ModeStopLevel = MarketInfo(Symbol(), MODE_STOPLEVEL);
   ModeLotSize = MarketInfo(Symbol(), MODE_LOTSIZE);
   ModeTickValue = MarketInfo(Symbol(), MODE_TICKVALUE);
   ModeTickSize = MarketInfo(Symbol(), MODE_TICKSIZE);
   ModeSwapLong = MarketInfo(Symbol(), MODE_SWAPLONG);
   ModeSwapShort = MarketInfo(Symbol(), MODE_SWAPSHORT);
   ModeStarting = MarketInfo(Symbol(), MODE_STARTING);
   ModeExpiration = MarketInfo(Symbol(), MODE_EXPIRATION);
   ModeTradeAllowed = MarketInfo(Symbol(), MODE_TRADEALLOWED);
   ModeMinLot = MarketInfo(Symbol(), MODE_MINLOT);
   ModeLotStep = MarketInfo(Symbol(), MODE_LOTSTEP);
   // Âûâîäèì èíôîðìàöèþ î ðûíêå
   if ( ShowMarketInfo == True )
     {
       Print("ModeLow:",ModeLow);
       Print("ModeHigh:",ModeHigh);
       Print("ModeTime:",ModeTime);
       Print("ModeBid:",ModeBid);
       Print("ModeAsk:",ModeAsk);
       Print("ModePoint:",ModePoint);
       Print("ModeDigits:",ModeDigits);
       Print("ModeSpread:",ModeSpread);
       Print("ModeStopLevel:",ModeStopLevel);
       Print("ModeLotSize:",ModeLotSize);
       Print("ModeTickValue:",ModeTickValue);
       Print("ModeTickSize:",ModeTickSize);
       Print("ModeSwapLong:",ModeSwapLong);
       Print("ModeSwapShort:",ModeSwapShort);
       Print("ModeStarting:",ModeStarting);
       Print("ModeExpiration:",ModeExpiration);
       Print("ModeTradeAllowed:",ModeTradeAllowed);
       Print("ModeMinLot:",ModeMinLot);
       Print("ModeLotStep:",ModeLotStep);
     }
   return (0);
  }
//+------------------------------------------------------------------+
//| Ðàñ÷åò êîëè÷åñòâà ëîòîâ                                          |
//+------------------------------------------------------------------+
int CyberiaLots()
  {
   GetMarketInfo();
   // Ñóììà ñ÷åòà
   double S;
   // Ñòîèìîñòü ëîòà
   double L;
   // Êîëè÷åñòâî ëîòîâ
   double k;
   // Ñòîèìîñòü îäíîãî ïóíêòà
   if( AutoLots == true )
     {
       if(SymbolsCount != OrdersTotal())
         {
           S = (AccountBalance()* Risk - AccountMargin()) * AccountLeverage() / 
                (SymbolsCount - OrdersTotal());
         }
       else
         {
           S = 0;
         }
       // Ïðîâåðÿåì, ÿâëÿåòñÿ ëè âàëþòà ïî åâðî
       if(StringFind( Symbol(), "USD") == -1)
         {
           if(StringFind( Symbol(), "EUR") == -1)
             {
               S = 0;
             }
           else
             {
               S = S / iClose ("EURUSD", PERIOD_M1, 0);
               if(StringFind( Symbol(), "EUR") != 0)
                  {
                  S /= Bid;
                  }
             }
         }
       else
         {
           if(StringFind(Symbol(), "USD") != 0)
             {
               S /= Bid;
             }
         }
       S /= ModeLotSize;
       S -= ModeMinLot;
       S /= ModeLotStep;
       S = NormalizeDouble(S, 0);
       S *= ModeLotStep;
       S += ModeMinLot;
       Lots = S;
       if(ShowLots == True)
           Print ("Lots:", Lots);
     }
   return (0);
  }
//+------------------------------------------------------------------+
//|   Èíèöèàëèçèðóåì ñîâåòíèêà                                       |
//+------------------------------------------------------------------+
int init()
  {
   AccountStatus();   
   GetMarketInfo();
   ModelingPeriod = ValuePeriod * ValuesPeriodCount; // Ïåðèîä ìîäåëèðîâàíèÿ â ìèíóòàõ
   if (ValuePeriod != 0 )
       ModelingBars = ModelingPeriod / ValuePeriod; // Êîëè÷åñòâî øàãîâ â ïåðèîäå
   CalculateSpread();
   return(0);
  }
//+------------------------------------------------------------------+
//| Âû÷èñëÿåì ôàêòè÷åñêóþ âåëè÷èíó ñïðåäà (âîçâðàùàåìûå ôóíêöèè      |
//| î ðûíêå ìîãóò äàâàòü íåâåðíîå ôàêòè÷åñêîå çíà÷åíèå ñïðåäà åñëè   |
//| áðîêåð âàðüèðóåò âåëè÷èíó ñïðåäà                                 |
//+------------------------------------------------------------------+
int CalculateSpread()
  {
   Spread = Ask - Bid;
   return (0);
  }
//+------------------------------------------------------------------+
//| Ïðèíèìàåì ðåøåíèå                                                |
//+------------------------------------------------------------------+
int CalculatePossibility (int shift)
  {
   DecisionValue = iClose( Symbol(), PERIOD_M1, ValuePeriod * shift) - 
                   iOpen( Symbol(), PERIOD_M1, ValuePeriod * shift);
   PrevDecisionValue = iClose( Symbol(), PERIOD_M1, ValuePeriod * (shift+1)) - 
                       iOpen( Symbol(), PERIOD_M1, ValuePeriod * (shift+1));
   SellPossibility = 0;
   BuyPossibility = 0;
   UndefinedPossibility = 0;
   if(DecisionValue != 0) // Åñëè ðåøåíèå íå îïðåäåëåííî
     {
       if(DecisionValue > 0) // Åñëè ðåøåíèå â ïîëüçó ïðîäàæè
         {
           // Ïîäîçðåíèå íà âåðîÿòíîñòü ïðîäàæè
           if(PrevDecisionValue < 0) // Ïîäòâåðæäåíèå ðåøåíèÿ â ïîëüçó ïðîäàæè
             {
               Decision = DECISION_SELL;
               BuyPossibility = 0;
               SellPossibility = DecisionValue;
               UndefinedPossibility = 0;
             }
           else  // Èíà÷å ðåøåíèå íå îïðåäåëåíî
             {
               Decision = DECISION_UNKNOWN;
               UndefinedPossibility = DecisionValue;
               BuyPossibility = 0;
               SellPossibility = 0;
             }
         }
       else // Åñëè ðåøåíèå â ïîëüçó ïîêóïêè
         {
           if(PrevDecisionValue > 0) // Ïîäòâåðæäåíèå ðåøåíèÿ â ïîëüçó ïðîäàæè
             {
               Decision = DECISION_BUY;
               SellPossibility = 0;
               UndefinedPossibility = 0;
               BuyPossibility = -1 * DecisionValue;
             }
           else  // Ðåøåíèå íå îïðåäåëåíî
             {
               Decision = DECISION_UNKNOWN;
               UndefinedPossibility = -1 * DecisionValue;
               SellPossibility = 0;
               BuyPossibility = 0;
             }
         }
     }
   else
     {
       Decision = DECISION_UNKNOWN;
       UndefinedPossibility = 0;
       SellPossibility = 0;
       BuyPossibility = 0;
     }
   return (Decision);
  }
//+------------------------------------------------------------------+
//| Âû÷èñëÿåì ñòàòèñòèêó âåðîÿòíîñòåé                                |
//+------------------------------------------------------------------+
int CalculatePossibilityStat()
  {
   int i;
   BuySucPossibilityCount = 0;
   SellSucPossibilityCount = 0;
   UndefinedSucPossibilityCount = 0;
//----
   BuyPossibilityCount = 0;
   SellPossibilityCount = 0;
   UndefinedPossibilityCount = 0;
   // Âû÷èñëÿåì ñðåäíèå çíà÷åíèÿ âåðîÿòíîñòè
   BuySucPossibilityMid = 0;
   SellSucPossibilityMid = 0;
   UndefinedSucPossibilityMid = 0;
   BuyPossibilityQuality = 0;
   SellPossibilityQuality = 0;
   UndefinedPossibilityQuality = 0;
   PossibilityQuality = 0;
//----
   BuySucPossibilityQuality = 0;
   SellSucPossibilityQuality = 0;
   UndefinedSucPossibilityQuality = 0;
   PossibilitySucQuality = 0;
   for( i = 0 ; i < ModelingBars ; i ++ )
     {
       // Âû÷èñëÿåì ðåøåíèå äëÿ äàííîãî èíòåðâàëà
       CalculatePossibility (i);
       // Åñëè ðåøåíèå äëÿ çíà÷åíèÿ i - ïðîäàâàòü         
       if(Decision == DECISION_SELL )
           SellPossibilityQuality ++;           
       // Åñëè ðåøåíèå äëÿ çíà÷åíèÿ i - ïîêóïàòü
       if(Decision == DECISION_BUY )
           BuyPossibilityQuality ++;           
       // Åñëè ðåøåíèå äëÿ çíà÷åíèÿ i - íå îïðåäåëåíî
       if(Decision == DECISION_UNKNOWN )
           UndefinedPossibilityQuality ++;           
       // Òå æå îöåíêè äëÿ óñïåøíûõ ñèòóàöèé                 
         //
       if((BuyPossibility > Spread) || (SellPossibility > Spread) || 
          (UndefinedPossibility > Spread))
         {
           if(Decision == DECISION_SELL)
               SellSucPossibilityQuality ++;                     
           if(Decision == DECISION_BUY)
               BuySucPossibilityQuality ++;
           if(Decision == DECISION_UNKNOWN )
               UndefinedSucPossibilityQuality ++;                   
         }  
       // Âû÷èñëÿåì ñðåäíèå âåðîÿòíîñòè ñîáûòèé
       // Âåðîÿòíîñòè ïîêóïêè
       BuyPossibilityMid *= BuyPossibilityCount;
       BuyPossibilityCount ++;
       BuyPossibilityMid += BuyPossibility;
       if(BuyPossibilityCount != 0 )
           BuyPossibilityMid /= BuyPossibilityCount;
       else
           BuyPossibilityMid = 0;
       // Âåðîÿòíîñòè ïðîäàæè
       SellPossibilityMid *= SellPossibilityCount;
       SellPossibilityCount ++;
       SellPossibilityMid += SellPossibility;
       if(SellPossibilityCount != 0 )
           SellPossibilityMid /= SellPossibilityCount;
       else
           SellPossibilityMid = 0;
       // Âåðîÿòíîñòè íåîïðåäåëåííîãî ñîñòîÿíèÿ
       UndefinedPossibilityMid *= UndefinedPossibilityCount;
       UndefinedPossibilityCount ++;
       UndefinedPossibilityMid += UndefinedPossibility;
       if(UndefinedPossibilityCount != 0)
           UndefinedPossibilityMid /= UndefinedPossibilityCount;
       else
           UndefinedPossibilityMid = 0;
       // Âû÷èñëÿåì ñðåäíèå âåðîÿòíîñòè óñïåøíûõ ñîáûòèé
       if(BuyPossibility > Spread)
         {
           BuySucPossibilityMid *= BuySucPossibilityCount;
           BuySucPossibilityCount ++;
           BuySucPossibilityMid += BuyPossibility;
           if(BuySucPossibilityCount != 0)
               BuySucPossibilityMid /= BuySucPossibilityCount;
           else
               BuySucPossibilityMid = 0;
         }
       if(SellPossibility > Spread)
         {
           SellSucPossibilityMid *= SellSucPossibilityCount;
           SellSucPossibilityCount ++;                 
           SellSucPossibilityMid += SellPossibility;
           if (SellSucPossibilityCount != 0)
              SellSucPossibilityMid /= SellSucPossibilityCount;
              else
                 SellSucPossibilityMid = 0;
         }
       if(UndefinedPossibility > Spread)
         {
           UndefinedSucPossibilityMid *= UndefinedSucPossibilityCount;
           UndefinedSucPossibilityCount ++;                 
           UndefinedSucPossibilityMid += UndefinedPossibility;
           if(UndefinedSucPossibilityCount != 0)
               UndefinedSucPossibilityMid /= UndefinedSucPossibilityCount;
           else
               UndefinedSucPossibilityMid = 0;
         }
     }
   if((UndefinedPossibilityQuality + SellPossibilityQuality + BuyPossibilityQuality)!= 0)
       PossibilityQuality = (SellPossibilityQuality + BuyPossibilityQuality) / 
       (UndefinedPossibilityQuality + SellPossibilityQuality + BuyPossibilityQuality);
   else             
       PossibilityQuality = 0;
   // Êà÷åñòâî äëÿ óñïåøíûõ ñèòóàöèé
   if((UndefinedSucPossibilityQuality + SellSucPossibilityQuality + 
      BuySucPossibilityQuality)!= 0)          
       PossibilitySucQuality = (SellSucPossibilityQuality + BuySucPossibilityQuality) / 
                                (UndefinedSucPossibilityQuality + SellSucPossibilityQuality + 
                                BuySucPossibilityQuality);
   else             
       PossibilitySucQuality = 0;
   return (0);
  }
//+------------------------------------------------------------------+
//| Ïîêàçûâàåì ñòàòèñòèêó                                            |
//+------------------------------------------------------------------+
int DisplayStat()
  {
   if(ShowStat == true)
     {
       Print ("SellPossibilityMid*SellPossibilityQuality:", SellPossibilityMid*SellPossibilityQuality);
       Print ("BuyPossibilityMid*BuyPossibilityQuality:", BuyPossibilityMid*BuyPossibilityQuality);
       Print ("UndefinedPossibilityMid*UndefinedPossibilityQuality:", UndefinedPossibilityMid*UndefinedPossibilityQuality);
       Print ("UndefinedSucPossibilityQuality:", UndefinedSucPossibilityQuality);
       Print ("SellSucPossibilityQuality:", SellSucPossibilityQuality);
       Print ("BuySucPossibilityQuality:", BuySucPossibilityQuality);
       Print ("UndefinedPossibilityQuality:", UndefinedPossibilityQuality);
       Print ("SellPossibilityQuality:", SellPossibilityQuality);
       Print ("BuyPossibilityQuality:", BuyPossibilityQuality);
       Print ("UndefinedSucPossibilityMid:", UndefinedSucPossibilityMid);
       Print ("SellSucPossibilityMid:", SellSucPossibilityMid);
       Print ("BuySucPossibilityMid:", BuySucPossibilityMid);
       Print ("UndefinedPossibilityMid:", UndefinedPossibilityMid);
       Print ("SellPossibilityMid:", SellPossibilityMid);
       Print ("BuyPossibilityMid:", BuyPossibilityMid);
     }
   return (0);
  }   // 
//+------------------------------------------------------------------+
//|  Àíàëèçèðóåì ñîñòîÿíèå äëÿ ïðèíÿòèÿ ðåøåíèÿ                      |
//+------------------------------------------------------------------+
int CyberiaDecision()
  {
// Âû÷èñëÿåì ñòàòèñòèêó ïåðèîäà
   CalculatePossibilityStat();
// Âû÷èñëÿåì âåðîÿòíîñòè ñîâåðøåíèÿ ñäåëîê
   CalculatePossibility(0);
   DisplayStat();
   return(Decision);     
  }
//+------------------------------------------------------------------+
//| Âû÷èñëÿåì íàïðàâëåíèå äâèæåíèÿ ðûíêà                             |
//+------------------------------------------------------------------+
int CalculateDirection()
  {
   DisableSellPipsator = false;
   DisableBuyPipsator = false;
   DisablePipsator = false;
   DisableSell = false;
   DisableBuy = false;
//----
   if(EnableCyberiaLogic == true)           
     {
       AskCyberiaLogic();
     }
   if(EnableMACD == true)
       AskMACD();
   if(EnableMA == true)
       AskMA();
   if(EnableReverceDetector == true)
       ReverceDetector();
   return (0);
  }
//+------------------------------------------------------------------+
//| Åñëè âåðîÿòíîñòè ïðåâûøàþò ïîðîãè èíâåðòèðîâàíèÿ ðåøåíèÿ         |
//+------------------------------------------------------------------+
int ReverceDetector ()
  {
   if((BuyPossibility > BuyPossibilityMid * ReverceIndex && BuyPossibility != 0 && 
      BuyPossibilityMid != 0) ||(SellPossibility > SellPossibilityMid * ReverceIndex && 
      SellPossibility != 0 && SellPossibilityMid != 0))
     {
       if(DisableSell == true)
           DisableSell = false;
       else
           DisableSell = true;
       if(DisableBuy == true)
           DisableBuy = false;
       else
           DisableBuy = true;
       //----
       if(DisableSellPipsator == true)
           DisableSellPipsator = false;
       else
           DisableSellPipsator = true;
       if(DisableBuyPipsator == true)
           DisableBuyPipsator = false;
       else
           DisableBuyPipsator = true;
     }
   return (0);
  }
//+------------------------------------------------------------------+
//| Îïðàøèâàåì ëîãèêó òîðãîâëè CyberiaLogic(C)                       |
//+------------------------------------------------------------------+
int AskCyberiaLogic()
  {
   //Óñòàíàâëèâàåì áëîêèðîâêè ïðè ïàäåíèÿõ ðûíêà
   /*DisableBuy = true;
   DisableSell = true;
   DisablePipsator = false;*/
   // Åñëè ðûíîê ðàâíîìåðíî äâèæåòñÿ â çàäàííîì íàïðàâëåíèè
   if(ValuePeriod > ValuePeriodPrev)
     {
       if(SellPossibilityMid*SellPossibilityQuality > BuyPossibilityMid*BuyPossibilityQuality)
         {
           DisableSell = false;
           DisableBuy = true;
           DisableBuyPipsator = true;
           if(SellSucPossibilityMid*SellSucPossibilityQuality > 
              BuySucPossibilityMid*BuySucPossibilityQuality)
             {
               DisableSell = true;  
             }
         }
       if(SellPossibilityMid*SellPossibilityQuality < BuyPossibilityMid*BuyPossibilityQuality)
         {
           DisableSell = true;
           DisableBuy = false;
           DisableSellPipsator = true;
           if(SellSucPossibilityMid*SellSucPossibilityQuality < 
              BuySucPossibilityMid*BuySucPossibilityQuality)
             {
               DisableBuy = true;
             }
         }
     }
   // Åñëè ðûíîê ìåíÿåò íàïðàâëåíèå - íèêîãäà íå òîðãóé ïðîòèâ òðåíäà!!!
   if(ValuePeriod < ValuePeriodPrev)
     {
      if(SellPossibilityMid*SellPossibilityQuality > BuyPossibilityMid*BuyPossibilityQuality)
         {
           DisableSell = true;
           DisableBuy = true;
         }
      if(SellPossibilityMid*SellPossibilityQuality < BuyPossibilityMid*BuyPossibilityQuality)
        {
          DisableSell = true;
          DisableBuy = true;
        }
     }
   // Åñëè ðûíîê ãîðèçîíòàëüíûé
   if(SellPossibilityMid*SellPossibilityQuality == BuyPossibilityMid*BuyPossibilityQuality)
     {
       DisableSell = true;
       DisableBuy = true;
       DisablePipsator=false;
     }
   // Áëîêèðóåì âåðîÿòíîñòü âûõîäà èç ðûíêà
   if(SellPossibility > SellSucPossibilityMid * 2 && SellSucPossibilityMid > 0)
     {
       DisableSell = true;
       DisableSellPipsator = true;
     }
   // Áëîêèðóåì âåðîÿòíîñòü âûõîäà èç ðûíêà
   if(BuyPossibility > BuySucPossibilityMid * 2 && BuySucPossibilityMid > 0 )
     {
       DisableBuy = true;
       DisableBuyPipsator = true;
     }
   if(ShowDirection == true)
     {
       if(DisableSell == true )
         {
           Print("Ïðîäàæà çàáëîêèðîâàíà:", SellPossibilityMid*SellPossibilityQuality);
         }
       else
         {
           Print ("Ïðîäàæà ðàçðåøåíà:", SellPossibilityMid*SellPossibilityQuality);
         }
       //----
       if(DisableBuy == true )
         {
           Print ("Ïîêóïêà çàáëîêèðîâàíà:", BuyPossibilityMid*BuyPossibilityQuality);
         }
       else
         {
           Print ("Ïîêóïêà ðàçðåøåíà:", BuyPossibilityMid*BuyPossibilityQuality);
         }
     }
   if(ShowDecision == true)
     {
       if(Decision == DECISION_SELL)
           Print("Ðåøåíèå - ïðîäàâàòü: ", DecisionValue);
       if(Decision == DECISION_BUY)
           Print("Ðåøåíèå - ïîêóïàòü: ", DecisionValue);
       if(Decision == DECISION_UNKNOWN)
           Print("Ðåøåíèå - íåîïðåäåëåííîñòü: ", DecisionValue);
     }
   return (0);
  }
//+------------------------------------------------------------------+
//| Îïðàøèâàåì èíäèêàòîð MA                                          |
//+------------------------------------------------------------------+
int AskMA()
  {
   if(iMA(Symbol(), PERIOD_M1, ValuePeriod, 0 , MODE_EMA, PRICE_CLOSE, 0) > 
      iMA(Symbol(), PERIOD_M1, ValuePeriod, 0 , MODE_EMA, PRICE_CLOSE, 1))        
     {
       DisableSell = true;
       DisableSellPipsator = true;
     }
   if(iMA(Symbol(), PERIOD_M1, ValuePeriod, 0 , MODE_EMA, PRICE_CLOSE, 0) < 
      iMA(Symbol(), PERIOD_M1, ValuePeriod, 0 , MODE_EMA, PRICE_CLOSE, 1))        
     {
       DisableBuy = true;
       DisableBuyPipsator = true;
     }
   return (0);
  }
//+------------------------------------------------------------------+
//| Îïðàøèâàåì èíäèêàòîð MACD                                        |
//+------------------------------------------------------------------+
int AskMACD()
  {
   double DecisionIndex = 0;
   double SellIndex = 0;
   double BuyIndex = 0;
   double BuyVector = 0;
   double SellVector = 0;
   double BuyResult = 0;
   double SellResult = 0;
   DisablePipsator = false;
   DisableSellPipsator = false;
   DisableBuyPipsator = false;
   DisableBuy = false;
   DisableSell = false;
   DisableExitSell = false;
   DisableExitBuy = false;
   // Áëîêèðóåì îøèáêè
   for(int i = 0 ; i < MACDLevel ; i ++)
     {
       if(iMACD(Symbol(), MathPow( 2, i) , 2, 4, 1, PRICE_CLOSE, MODE_MAIN, 0) < 
          iMACD(Symbol(), MathPow( 2, i), 2, 4, 1, PRICE_CLOSE, MODE_MAIN, 1) )
         {
           SellIndex += iMACD(Symbol(), MathPow( 2, i), 2, 4, 1, PRICE_CLOSE, MODE_MAIN, 0);
         }
       if(iMACD(Symbol(), MathPow( 2, i), 2, 4, 1, PRICE_CLOSE, MODE_MAIN, 0) > 
          iMACD(Symbol(), MathPow( 2, i), 2, 4, 1, PRICE_CLOSE, MODE_MAIN, 1) )
         {
           BuyIndex += iMACD(Symbol(), MathPow( 2, i), 2, 4, 1, PRICE_CLOSE, MODE_MAIN, 0);
         }

     }
   if(SellIndex> BuyIndex)
     {
       DisableBuy = true;
       DisableBuyPipsator = true;
     }
   if(SellIndex < BuyIndex)
     {
       DisableSell = true;
       DisableSellPipsator = true;
     }
   return (0);
  }
//+------------------------------------------------------------------------+
//| Ëîâèì ðûíî÷íûå ÃÝÏ - (âêëþ÷àåòñÿ íåïîñðåäñòâåííî ïåðåä âûõîäîì íîâîñòåé|
//+------------------------------------------------------------------------+
int MoneyTrain()
  {
   if(FoundOpenedOrder == False)
     {
       // Ñ÷èòàåì äèñïåðñèþ
       Disperce = (iHigh ( Symbol(), PERIOD_M1, 0) - iLow ( Symbol(), PERIOD_M1, 0));
       if(Decision == DECISION_SELL)
         {
           // *** Âïðûãèâàåì â ïàðîâîç ïî íàïðàâëåíèþ äâèæåíèÿ õàîñà ðûíêà ***
           if((iClose( Symbol(), PERIOD_M1, 0) - iClose( Symbol(), PERIOD_M1, ValuePeriod)) / 
               MoneyTrainLevel >= SellSucPossibilityMid && SellSucPossibilityMid != 0 && 
               EnableMoneyTrain == true)
             {
               ModeSpread = ModeSpread + 1;
               // Ðàñ÷åò ñòîï-ëîññ
               if((Bid - SellSucPossibilityMid*StopLossIndex- ModeSpread * Point) > 
                  (Bid - ModeStopLevel* ModePoint- ModeSpread * Point))
                 {
                   StopLoss = Bid - ModeStopLevel* ModePoint- ModeSpread * Point - Disperce;
                 }
               else
                 {
                   if(SellSucPossibilityMid != 0)
                       StopLoss = Bid - SellSucPossibilityMid*StopLossIndex- 
                       ModeSpread * Point - Disperce;
                   else
                       StopLoss = Bid - ModeStopLevel* ModePoint- ModeSpread * Point - Disperce;
                 }

               if(BlockBuy == true)
                 {
                   return(0);
                 }
               StopLevel = StopLoss;
               Print ("StopLevel:", StopLevel);
               // Áëîêèðîâêà ñòîïëîñîâ
               if(BlockStopLoss == true)
                   StopLoss = 0;                                                                            
               ticket = OrderSend(Symbol(), OP_BUY, Lots, Ask, SlipPage, StopLoss, 
                                  TakeProfit,"CyberiaTrader-AI-HB1",0,0,Blue);
               if(ticket > 0)
                 {
                   if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) 
                       Print("Îòêðûò îðäåð íà ïîêóïêó: ",OrderOpenPrice());
                 }
               else
                 {
                   Print("Âõîä â ðûíîê: Îøèáêà îòêðûòèÿ îðäåðà íà ïîêóïêó: ",GetLastError());
                   PrintErrorValues();
                 }
               return (0);
             }
         }              
       if(Decision == DECISION_BUY)
         {
           // *** Âïðûãèâàåì â ïàðîâîç ïî íàïðàâëåíèþ äâèæåíèÿ õàîñà ðûíêà ***
           if((iClose( Symbol(), PERIOD_M1, ValuePeriod) - iClose( Symbol(), PERIOD_M1, 0)) / 
               MoneyTrainLevel >= BuySucPossibilityMid && BuySucPossibilityMid != 0 && 
               EnableMoneyTrain == true)
             {
               ModeSpread = ModeSpread + 1;
               // Ðàñ÷åò ñòîï-ëîññ
               if((Ask + BuySucPossibilityMid*StopLossIndex+ ModeSpread* Point) < 
                  (Ask + ModeStopLevel* ModePoint+ ModeSpread * Point))
                 {
                   StopLoss = Ask + ModeStopLevel* ModePoint+ ModeSpread * Point+ Disperce;
                 }
               else
                 {
               if(BuySucPossibilityMid != 0)
                   StopLoss = Ask + BuySucPossibilityMid*StopLossIndex+ ModeSpread*Point + 
                              Disperce;
               else
                   StopLoss = Ask + ModeStopLevel* ModePoint+ ModeSpread * Point+ Disperce;
                 }
               // Åñëè âêëþ÷åíà ðó÷íàÿ áëîêèðîâêà ïðîäàæ
               if(BlockSell == true)
                 {
                   return(0);
                 }
               StopLevel = StopLoss;
               Print ("StopLevel:", StopLevel);
               // Áëîêèðîâêà ñòîïëîñîâ
               if(BlockStopLoss == true)
                   StopLoss = 0;                                                                      
               ticket = OrderSend(Symbol(), OP_SELL, Lots, Bid, SlipPage, StopLoss, 
                                  TakeProfit, "CyberiaTrader-AI-HS1", 0, 0, Green);
               if(ticket > 0)
                 {
                   if(OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES)) 
                       Print("Îòêðûò îðäåð íà ïðîäàæó: ", OrderOpenPrice());
                 }
               else
                 {
                   Print("Âõîä â ðûíîê: Îøèáêà îòêðûòèÿ îðäåðà íà ïðîäàæó: ",GetLastError());
                   PrintErrorValues();
                 }
               return (0);
             }   
         }            
     }
   return (0);
  }
//+------------------------------------------------------------------+
//| Âõîä â ðûíîê                                                     |
//+------------------------------------------------------------------+
int EnterMarket()
  {
// Åñëè íåò ñðåäñòâ, âûõîäèì
   if(Lots == 0)
     {
       return (0);
     }
// Âõîäèì â ðûíîê åñëè íåò êîìàíäû âûõîäà èç ðûíêà
   if(ExitMarket == False)
     {
       // ------- Åñëè íåò îòêðûòûõ îðäåðîâ - âõîäèì â ðûíîê ------------
       if(FoundOpenedOrder == False)
         {
           // Ñ÷èòàåì äèñïåðñèþ
           Disperce = (iHigh(Symbol(), PERIOD_M1, 0) - iLow(Symbol(), PERIOD_M1, 0));
           if(Decision == DECISION_SELL)
             {
               // Åñëè öåíà ïîêóïêè áîëüøå ñðåäíåé âåëè÷èíû ïîêóïêè íà ìîäåëèðóåìîì èíòåðâàëå
               if(SellPossibility >= SellSucPossibilityMid)
                 {
                   // Ðàñ÷åò ñòîï-ëîññ
                   if((Ask + BuySucPossibilityMid*StopLossIndex + ModeSpread * Point) < 
                      (Ask + ModeStopLevel* ModePoint+ ModeSpread * Point))
                     {
                       StopLoss = Ask + ModeStopLevel* ModePoint+ ModeSpread * Point + Disperce;
                     }
                   else
                     {
                       if(BuySucPossibilityMid != 0)
                           StopLoss = Ask + BuySucPossibilityMid*StopLossIndex + 
                                      ModeSpread * Point+ Disperce;
                       else
                           StopLoss = Ask + ModeStopLevel* ModePoint+ ModeSpread * Point + 
                                      Disperce;
                     }
                   // Åñëè âêëþ÷åíà ðó÷íàÿ áëîêèðîâêà ïðîäàæ
                   if(DisableSell == true)
                     {
                       return(0);
                     }
                   if(BlockSell == true)
                     {
                       return(0);
                     }
                   StopLevel = StopLoss;
                   Print ("StopLevel:", StopLevel);
                   // Áëîêèðîâêà ñòîïëîñîâ
                   if(BlockStopLoss == true)
                       StopLoss = 0;                                                                      
                   ticket = OrderSend(Symbol(), OP_SELL, Lots, Bid, SlipPage, StopLoss, 
                            TakeProfit, "CyberiaTrader-AI-LS1", 0, 0, Green);
                   if(ticket > 0)
                     {
                       if(OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES)) 
                           Print("Îòêðûò îðäåð íà ïðîäàæó: ",OrderOpenPrice());
                     }
                   else
                     {
                       Print("Âõîä â ðûíîê: Îøèáêà îòêðûòèÿ îðäåðà íà ïðîäàæó: ",GetLastError());
                       PrintErrorValues();
                     }
                   // Ñîõðàíÿåì ïðåäûäóùåå çíà÷åíèå ïåðèîäà
                   return (0);
                 }
             }
           if(Decision == DECISION_BUY)
             {
               // Åñëè öåíà ïîêóïêè áîëüøå ñðåäíåé âåëè÷èíû ïîêóïêè íà ìîäåëèðóåìîì èíòåðâàëå
               if(BuyPossibility >= BuySucPossibilityMid)
                 {
                   // Ðàñ÷åò ñòîï-ëîññ
                   if((Bid - SellSucPossibilityMid*StopLossIndex- ModeSpread* Point) > 
                      (Bid - ModeStopLevel* ModePoint- ModeSpread* Point))
                     {
                       StopLoss = Bid - ModeStopLevel* ModePoint- ModeSpread* Point - Disperce;
                     }
                   else
                     {
                       if(SellSucPossibilityMid != 0)
                           StopLoss = Bid - SellSucPossibilityMid*StopLossIndex- 
                                      ModeSpread* Point- Disperce;
                       else
                           StopLoss = Bid - ModeStopLevel* ModePoint- ModeSpread* Point- 
                                      Disperce;
                     }
                   // Åñëè âêëþ÷åíà ðó÷íàÿ áëîêèðîâêà ïîêóïîê
                   if(DisableBuy == true)
                     {
                       return(0);
                     }
                   if(BlockBuy == true)
                     {
                       return(0);
                     }
                   StopLevel = StopLoss;
                   Print("StopLevel:", StopLevel);
                   // Áëîêèðîâêà ñòîïëîñîâ
                   if(BlockStopLoss == true)
                       StopLoss = 0;                                                                      
                   ticket = OrderSend(Symbol(), OP_BUY, Lots, Ask, SlipPage, StopLoss, 
                            TakeProfit, "CyberiaTrader-AI-LB1", 0, 0, Blue);
                   if(ticket > 0)
                     {
                      if(OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES)) 
                          Print("Îòêðûò îðäåð íà ïîêóïêó: ",OrderOpenPrice());
                     }
                   else
                     {
                       Print("Âõîä â ðûíîê: Îøèáêà îòêðûòèÿ îðäåðà íà ïîêóïêó: ",GetLastError());
                       PrintErrorValues();
                     }
                   return (0);
                 }
             }
         }
// ---------------- Êîíåö âõîäà â ðûíîê ----------------------        
     }     
   return (0);
  }   
//+------------------------------------------------------------------+
//| Ïîèñê îòêðûòûõ îðäåðîâ                                           |
//+------------------------------------------------------------------+
int FindSymbolOrder()
  {
   FoundOpenedOrder = false;
   total = OrdersTotal();
   for(cnt = 0; cnt < total; cnt++)
     {
       OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
       // Èùåì îðäåð ïî íàøåé âàëþòå
       if(OrderSymbol() == Symbol())
         {
           FoundOpenedOrder = True;
           break;
         }
       else
         {
           StopLevel = 0;
           StopLoss = 0;
         }
     }
   return (0);
  }
//+------------------------------------------------------------------+
//| Ïèïñàòîð íà ìèíóòíûõ èíòåðâàëàõ                                  |
//+------------------------------------------------------------------+
int RunPipsator()
  {
   int i = 0;
   FindSymbolOrder();
   // Âõîäèì â ðûíîê åñëè íåò êîìàíäû âûõîäà èç ðûíêà
   // Ñ÷èòàåì äèñïåðñèþ
   if(Lots == 0)
       return (0);
   Disperce = 0;
   if(ExitMarket == False)
     {
       // ---------- Åñëè íåò îòêðûòûõ îðäåðîâ - âõîäèì â ðûíîê ----------
       if(FoundOpenedOrder == False)
         {
           Disperce = 0;
           DisperceMax = 0;
           // Ñ÷èòàåì ìàêñèìàëüíóþ äèñïåðñèþ
           for(i = 0 ; i < ValuePeriod ; i ++)
             {
               Disperce = (iHigh( Symbol(), PERIOD_M1, i + 1) - 
                           iLow( Symbol(), PERIOD_M1, i + 1));                                
               if(Disperce > DisperceMax)
                   DisperceMax = Disperce;                             
             }
           Disperce = DisperceMax  * StopLossIndex;
           if( Disperce == 0 )
             {
               Disperce = ModeStopLevel * Point;
             }
           for(i = 0 ; i < ValuePeriod ; i ++)
             {
               // Ïèïñàòîð ìèíóòíîãî èíòåðâàëà ïî ïðîäàæå
               if((Bid - iClose( Symbol(), PERIOD_M1, i + 1)) > 
                  SellSucPossibilityMid * (i + 1) && 
                  SellSucPossibilityMid != 0 && DisablePipsator == false && 
                  DisableSellPipsator == false)
                 {
                   // Ðàñ÷åò ñòîï-ëîññ
                   if((Ask + ModeSpread * Point + Disperce) < 
                      (Ask + ModeStopLevel* ModePoint + ModeSpread * Point))
                     {
                       StopLoss = Ask + ModeStopLevel* ModePoint+ ModeSpread * Point + Point;
                     }
                   else
                     {
                       if(BuySucPossibilityMid != 0)
                           StopLoss = Ask + ModeSpread * Point+ Disperce + Point;
                       else
                         StopLoss = Ask + ModeStopLevel* ModePoint+ ModeSpread * Point + Point;
                     }
                   // Åñëè âêëþ÷åíà ðó÷íàÿ áëîêèðîâêà ïðîäàæ
                   if(BlockSell == true)
                     {
                       return(0);
                     }
                   // Åñëè âêëþ÷åíà ðó÷íàÿ áëîêèðîâêà ïðîäàæ
                   if(DisableSell == true)
                     {
                       return(0);
                     }
                   StopLevel = StopLoss;
                   Print("StopLevel:", StopLevel);
                                      // Áëîêèðîâêà ñòîïëîñîâ
                   if(BlockStopLoss == true)
                       StopLoss = 0;
                   ticket = OrderSend(Symbol(), OP_SELL, Lots, Bid, SlipPage, StopLoss, 
                            TakeProfit, "CyberiaTrader-AI-PS1", 0, 0, Green);
                   if(ticket > 0)
                     {
                       if(OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES)) 
                           Print("Îòêðûò îðäåð íà ïðîäàæó: ",OrderOpenPrice());
                     }
                   else
                     {
                       Print("Âõîä â ðûíîê: Îøèáêà îòêðûòèÿ îðäåðà íà ïðîäàæó: ",GetLastError());
                       PrintErrorValues();
                     }
                   return (0);
                 }
               // Ïèïñàòîð ìèíóòíîãî èíòåðâàëà ïî ïîêóïêå
               if((iClose(Symbol(), PERIOD_M1, i + 1) - Bid) > BuySucPossibilityMid *(i + 1) && 
                   BuySucPossibilityMid != 0 && DisablePipsator == False && 
                   DisableBuyPipsator == false)
                 {
                   // Ðàñ÷åò ñòîï-ëîññ
                   if((Bid -  ModeSpread * Point - Disperce) > 
                      (Bid - ModeStopLevel* ModePoint- ModeSpread * Point))
                     {
                       StopLoss = Bid - ModeStopLevel* ModePoint- ModeSpread * Point - Point;
                     }
                   else
                     {
                       if(SellSucPossibilityMid != 0)
                           StopLoss = Bid - ModeSpread * Point- Disperce- Point;
                       else
                           StopLoss = Bid - ModeStopLevel* ModePoint- ModeSpread * Point - Point;
                     }
                   // Åñëè âêëþ÷åíà ðó÷íàÿ áëîêèðîâêà 
                   if(DisableBuy == true)
                     {
                       return(0);
                     }
                   if(BlockBuy == true)
                     {
                       return(0);
                     }
                   StopLevel = StopLoss;
                   Print("StopLevel:", StopLevel);
                   // Áëîêèðîâêà ñòîïëîñîâ
                   if(BlockStopLoss == true)
                       StopLoss = 0;                                                                            
                   ticket = OrderSend(Symbol(), OP_BUY, Lots, Ask, SlipPage, StopLoss, 
                            TakeProfit, "CyberiaTrader-AI-PB1", 0, 0, Blue);
                   if(ticket > 0)
                     {
                       if(OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES)) 
                           Print("Îòêðûò îðäåð íà ïîêóïêó: ",OrderOpenPrice());
                     }
                   else
                     {
                       Print("Âõîä â ðûíîê: Îøèáêà îòêðûòèÿ îðäåðà íà ïîêóïêó: ",GetLastError());
                       PrintErrorValues();
                     }
                   return (0);
                 }   
             }// Êîíåö ïèïñàòîðíîãî öèêëà           
         }
     }
   return (0);
  }
//+------------------------------------------------------------------+
//| Âûõîä èç ðûíêà                                                   |
//+------------------------------------------------------------------+
int ExitMarket ()
  {
   //FindSymbolOrder();
   // -------------------- Îáðàáîòêà îòêðûòûõ îðäåðîâ ----------------
   if(FoundOpenedOrder == True) // Åñëè åñòü îòêðûòûé îðäåð ïî ýòîé âàëþòå
     {
       if(OrderType()==OP_BUY) // Åñëè íàéäåííûé îðäåð íà ïðèîáðåòåíèå âàëþòû
         {
           // Çàêðûòèå îðäåðà, åñëè îí äîñòèã óðîâíÿ ñòîï-ëîññ
           if(Bid <= StopLevel && DisableShadowStopLoss == false && StopLevel != 0)
             {
               OrderClose(OrderTicket(),OrderLots(),Bid ,SlipPage,Violet); // Çàêðûâàåì îðäåð
               return(0);
             }
           if(DisableExitBuy == true)
               return (0);
           // Çàêðûòèå ïèïñàòîðà
           if((OrderOpenPrice() < Bid))
             {
               // çàêðûâàåì îðäåð
               OrderClose(OrderTicket(), OrderLots(), Bid , SlipPage, Violet); // Çàêðûâàåì îðäåð
               return(0);
             }
           // Íå âûõîäèì èç ðûíêà, åñëè èìååì õàîñ, ðàáîòàþùèé íà ïðèáûëü
           if((iClose( Symbol(), PERIOD_M1, 0) - iClose( Symbol(), PERIOD_M1, 1)) >= 
               SellSucPossibilityMid * 4 && SellSucPossibilityMid > 0)
               return(0);

           // Çàêðûòèå îðäåðà ïî ïðåâûøåíèþ âåðîÿòíîñòè óñïåøíîé ïðîäàæè
           if((OrderOpenPrice() < Bid) && (Bid - OrderOpenPrice() >= 
              SellSucPossibilityMid) && (SellSucPossibilityMid > 0) )
             {
               // çàêðûâàåì îðäåð
               OrderClose(OrderTicket(), OrderLots(), Bid , SlipPage, Violet); // Çàêðûâàåì îðäåð
               return(0);
             }
           // Çàêðûòèå îðäåðà ïî ïðåâûøåíèþ âåðîÿòíîñòè óñïåøíîé ïîêóïêè
           if((OrderOpenPrice() < Bid) && (Bid - OrderOpenPrice() >= 
              BuySucPossibilityMid) && (BuySucPossibilityMid > 0) )
             {
               // çàêðûâàåì îðäåð
               OrderClose(OrderTicket(), OrderLots(), Bid , SlipPage, Violet); // Çàêðûâàåì îðäåð
               return(0);
             }

           if(Decision == DECISION_SELL)
             {
               // Åñëè öåíà ïðîäàæè áîëüøå öåíû ïîêóïêè - çíà÷èò èìååì ïðèáûëü (ñ ó÷åòîì ñëèïà îðäåðà)
               //if ( OrderOpenPrice() < Bid - SlipPage * Point )
               if( OrderOpenPrice() < Bid)
                 {
                   // Åñëè öåíà ïîêóïêè áîëüøå ñðåäíåé âåëè÷èíû ïîêóïêè íà ìîäåëèðóåìîì èíòåðâàëå
                   if(SellPossibility >= SellPossibilityMid - Point)
                     {
                       OrderClose(OrderTicket(), OrderLots(), Bid , SlipPage, Violet); // Çàêðûâàåì îðäåð
                       return(0);
                     }
                 }
             }
           // Çàêðûòèå îðäåðà ïî èíäèêàòîðó íåîïðåäåëåííîãî ññòîÿíèÿ
           if((OrderOpenPrice() < Bid) && (Bid - OrderOpenPrice() >= UndefinedPossibilityMid) )
             {
               // çàêðûâàåì îðäåð
               OrderClose(OrderTicket(), OrderLots(), Bid , SlipPage, Violet); // Çàêðûâàåì îðäåð
               return(0);
             }

           //Ïðîâåðÿåì ìîæíî ëè åãî ïðîäàòü â íàñòîÿùèé ìîìåíò
           if(Decision == DECISION_BUY)
             {
               return(0);
             }
         }
       if(OrderType() == OP_SELL) // Åñëè íàéäåííûé îðäåð íà ïðèîáðåòåíèå âàëþòû
         {
           // Çàêðûòèå îðäåðà, åñëè îí äîñòèã óðîâíÿ ñòîï-ëîññ
           if(Ask >= StopLevel && DisableShadowStopLoss == false && StopLevel != 0)
             {
               OrderClose(OrderTicket(), OrderLots(), Ask , SlipPage, Violet); // Çàêðûâàåì îðäåð
               return(0);
             }
           if(DisableExitSell == true)
               return (0);
           // Çàêðûòèå ïèïñàòîðà
           if((OrderOpenPrice() > Ask))
             {
               OrderClose(OrderTicket(), OrderLots(), Ask, SlipPage, Violet); // Çàêðûâàåì îðäåð
               return(0);
             }


           // Íå âûõîäèì èç ðûíêà, åñëè èìååì õàîñ, ðàáîòàþùèé íà ïðèáûëü
           if((iClose( Symbol(), PERIOD_M1, 1) - iClose( Symbol(), PERIOD_M1, 0)) >= BuySucPossibilityMid * 4 && BuySucPossibilityMid > 0)
            return (0);
           // Çàêðûòèå îðäåðà ïî ôàêòó ïðåâûùåíèÿ âåðîÿòíîñòè óñïåøíîé ïîêóïêè
           if((OrderOpenPrice() > Ask) && (OrderOpenPrice() - Ask) >= 
               BuySucPossibilityMid && BuySucPossibilityMid > 0)
             {
               // Çàêðûâàåì îðäåð
               OrderClose(OrderTicket(), OrderLots(), Ask, SlipPage, Violet); // Çàêðûâàåì îðäåð
               return(0);
             }

           // Çàêðûòèå îðäåðà ïî ôàêòó ïðåâûùåíèÿ âåðîÿòíîñòè óñïåøíîé ïðîäàæè
           if((OrderOpenPrice() > Ask) && (OrderOpenPrice() - Ask) >= 
              SellSucPossibilityMid && SellSucPossibilityMid > 0)
             {
               // Çàêðûâàåì îðäåð
               OrderClose(OrderTicket(), OrderLots(), Ask, SlipPage, Violet); // Çàêðûâàåì îðäåð
               return(0);
             }

           if (Decision == DECISION_BUY )
             {
               // Åñëè öåíà ïîêóïêè áîëüøå öåíû ïðîäàæè - çíà÷èò èìååì ïðèáûëü (ñ ó÷åòîì ñëèïà îðäåðà)
               if(OrderOpenPrice() > Ask)
                 {
                   // Åñëè öåíà ïîêóïêè áîëüøå ñðåäíåé âåëè÷èíû ïîêóïêè íà ìîäåëèðóåìîì èíòåðâàëå
                   if(BuyPossibility >= BuyPossibilityMid - Point)
                     {
                       OrderClose(OrderTicket(), OrderLots(), Ask, SlipPage, Violet); // Çàêðûâàåì îðäåð
                       return(0);
                     }
                 }

             }
           // Çàêðûòèå îðäåðà ïî èíäèêàòîðó íåîïðåäåëåííîãî ññòîÿíèÿ
           if((OrderOpenPrice() > Ask) && (OrderOpenPrice() - Ask) >= UndefinedPossibilityMid)
             {
               // Çàêðûâàåì îðäåð
               OrderClose(OrderTicket(), OrderLots(), Ask, SlipPage, Violet); // Çàêðûâàåì îðäåð
               return(0);
             }
           //Ïðîâåðÿåì ìîæíî ëè åãî ïðîäàòü â íàñòîÿùèé ìîìåíò
           if(Decision == DECISION_SELL)
             {
               return (0);
             }

         }
     }
 // --------------------- Êîíåö îáðàáîòêè îòêðûòûõ îðäåðîâ -----------
 //  ValuePeriodPrev = ValuePeriod;
   return (0);
  }   
//+--------------------------------------------------------------------------+
//| Ñîõðàíÿåì çíà÷åíèÿ ñòàâîê è ïåðèîäà ìîäåëèðîâàíèÿ äëÿ ñëåäóþùåé èòåððàöèè|
//+--------------------------------------------------------------------------+
int SaveStat()
  {
   BidPrev = Bid;
   AskPrev = Ask;
   ValuePeriodPrev = ValuePeriod;
   return (0);
  }
//+------------------------------------------------------------------+
//| Òðåéäèíã                                                         |
//+------------------------------------------------------------------+
int Trade ()
  {
   // Íà÷èíàåì òîðãîâàòü
   // Èùåì îòêðûòûå îðäåðà
   FindSymbolOrder();
   CalculateDirection();
   AutoStopLossIndex();
//---- Åñëè îòêðûòûõ îðäåðîâ ïî ñèìàîëó íåò, âîçìîæåí âõîä â ðûíîê
//---- Âíèìàíèå - âàæåí èìåííî ýòîò ïîðÿäîê ðàññìîòðåíèÿ òåõíîëîãèé âõîäà â ðûíîê (MoneyTrain, LogicTrading, Pipsator)
   if(FoundOpenedOrder == false)
     {
       if(EnableMoneyTrain == true)
           MoneyTrain();
       if(EnableLogicTrading == true)
           EnterMarket();
       if(DisablePipsator == false)
           RunPipsator();           
     }
   
//---- Êîíåö îáðàáîòêè âõîäà/âûõîäà èç ðûíêà
   return(0);
  }
//+------------------------------------------------------------------+
//| Âûâîäèòü â ëîãàõ ñòàòóñ ñ÷åòà                                    |
//+------------------------------------------------------------------+
int AccountStatus()
  {
   if(ShowAccountStatus == True )
     {
       Print ("AccountBalance:", AccountBalance());
       Print ("AccountCompany:", AccountCompany());
       Print ("AccountCredit:", AccountCredit());
       Print ("AccountCurrency:", AccountCurrency());
       Print ("AccountEquity:", AccountEquity());
       Print ("AccountFreeMargin:", AccountFreeMargin());
       Print ("AccountLeverage:", AccountLeverage());
       Print ("AccountMargin:", AccountMargin());
       Print ("AccountName:", AccountName());
       Print ("AccountNumber:", AccountNumber());
       Print ("AccountProfit:", AccountProfit());
     }    
   return ( 0 );
  }
//+------------------------------------------------------------------+
//| Ñàìàÿ âàæíàÿ ôóíêöèÿ - âûáîð ïåðèîäà ìîäåëèðîâàíèÿ               |
//+------------------------------------------------------------------+
int FindSuitablePeriod()
  {
   double SuitablePeriodQuality = -1 *ValuesPeriodCountMax*ValuesPeriodCountMax;
   double SuitablePeriod = 0;
   int i; // Ïåðåìåííàÿ äëÿ àíàëèçà ïåðèîäîâ
// Êîëè÷åñòâî àíàëèçèðóåìûõ ïåðèîäîâ. i - ðàçìåð ïåðèîäà
   for(i = 0 ; i < ValuesPeriodCountMax ; i ++ )
     {
       ValuePeriod = i + 1;
      // Çíà÷åíèå ïîäîáðàíî îïûòíûì ïóòåì è êàê íè ñòðàííî îíî ñîâïàëî ñ ÷èñëîì â òåîðèè ýëëèîòà
       ValuesPeriodCount = ValuePeriod * 5; 
       init();           
       CalculatePossibilityStat ();
       if(PossibilitySucQuality > SuitablePeriodQuality)
         {
           SuitablePeriodQuality = PossibilitySucQuality;
           //Print ("PossibilitySucQuality:", PossibilitySucQuality:);
           SuitablePeriod = i + 1;
         }
     }
   ValuePeriod = SuitablePeriod;
   init();
   // Âûâîäèòü ïåðèîä ìîäåëèðîâàíèÿ
   if(ShowSuitablePeriod == True)
     {
       Print("Ïåðèîä ìîäåëèðîâàíèÿ:", SuitablePeriod, " ìèíóò ñ âåðîÿòíîñòüþ:", 
       SuitablePeriodQuality );
     }
   return(SuitablePeriod);
  }
//+------------------------------------------------------------------+
//|Àâòîìàòè÷åñêàÿ óñòàíîâêà óðîâíÿ ñòîï-ëîññ                         |
//+------------------------------------------------------------------+
int AutoStopLossIndex()
  {
   if(AutoStopLossIndex == true)
     {
       StopLossIndex = ModeSpread;
     }
   return(0);
  }
//+------------------------------------------------------------------+
//|Âûâîä îøèáîê ïðè âõîäå â ðûíîê                                    |
//+------------------------------------------------------------------+
int PrintErrorValues()
  {
   Print("ErrorValues:Symbol=", Symbol(),",Lots=",Lots, ",Bid=", Bid, ",Ask=", Ask,
         ",SlipPage=", SlipPage, "StopLoss=",StopLoss,",TakeProfit=", TakeProfit);
   return (0);
  }   
//+------------------------------------------------------------------+
//| expert start function (Òðåéäèíã)                                 |
//+------------------------------------------------------------------+
int start()
  {
   GetMarketInfo();
   CyberiaLots();
   CalculateSpread();
   FindSuitablePeriod();
   CyberiaDecision();
   Trade();
   SaveStat();
   return(0);
  }


