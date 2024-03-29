/*
   Generated by EX4-TO-MQ4 decompiler LITE V4.0.427.3 [-]
   Website: https://purebeam.biz
   E-mail : purebeam@gmail.com
*/
#property copyright "Copyright © ichiFX, Ichi V55"
#property link      "www.ichifx.com"

extern string RiskINFO = "1 for conservative, 2 for normal, 3 for aggressive, 4 for very aggressive, 5 for extreme.";
extern int Risk = 2;
input double lot=0.01;
input double sl=100;
input double tp =100;
extern string ToCloseTrades = "To CLOSE ALL Trades, set the property below UseClose=True";
extern bool UseClose = FALSE;
extern string PercentageOfAccountToUseINFO = "This is the percentage (%) of the account to calculate base lot size";
extern int PercentageOfAccount = 100;
extern string MaxCapitalToRiskINFO = "To have Equity protection, set UseMaxCapitalStop=true and set MaxCapitalToRiskPercent=protect%";
extern bool UseMaxCapitalStop = FALSE;
extern double MaxCapitalToRiskPercent = 70.0;
extern string ToCloseOldTrades = "To CLOSE trades after a certain amount of time, set property UseTimeOut=true, and set MaxTradeOpenHours=number of hours";
extern bool UseTimeOut = FALSE;
extern double MaxTradeOpenHours = 48.0;
string gs_152 = "Set LotsDigits to number of decimal places for lots, for 0.01 lots, set to 2, for 0.1 set to 1, for 1.0 and greater set to 0";
double gd_160 = 2.0;
string gs_168 = "This property will automatically grow your account for 0.01 lot per one thousand";
bool gi_176 = TRUE;
string gs_180 = "This is automatically by lotSizeGrowthPer1000, set lotSizeGrowthPer1000=false to change";
double gd_188 = 0.01;
double gd_196 = 300.0;
double gd_204 = 30.0;
double gd_212 = 60.0;
double gd_220 = 30.0;
double gd_228 = 1.4;
double gd_236 = 5.0;
int gi_244 = 9;
bool gi_248 = TRUE;
int gi_252 = 1;
bool gi_256 = TRUE;
double gd_260 = 3.0;
double gd_268 = 10.0;
bool gi_276 = FALSE;
int gi_280 = 1;
double gd_284 = 0.0;
bool gi_292 = FALSE;
bool gi_296 = TRUE;
double gd_300 = 4.0;
bool gi_308 = TRUE;
bool gi_312 = FALSE;
bool gi_316 = TRUE;
int gi_320 = 40;
int gi_324 = 4;
bool gi_328 = FALSE;
double gd_332 = 0.005;
double gd_340 = 0.05;
int gi_348 = 1;
int gi_352 = 4;
double gd_356 = 4.0;
double gd_364 = 0.01;
double gd_372 = 20.0;
int gi_380 = 13;
int gi_384 = 26;
int gi_388 = 52;
int gi_392 = 1;
int gi_396 = 61;
int gi_400 = 2;
int gi_404 = 0;
double gd_408 = 0.0;
double gd_416 = 2.0;
int gi_424 = 8;
int gi_428 = 2;
int gi_432 = 0;
int gi_436 = 2;
int gi_440 = 1;
int gi_444 = 0;
int gi_448 = 255;
int gi_452 = 16711680;
bool gi_456 = TRUE;
double gd_460 = 0.00005;
int gi_468 = 8885554;
double gd_472;
double gd_480;
double gd_488;
double gd_496;
double gd_504;
double gd_512;
double gd_520;
double gd_528;
double gd_536;
double gd_552;
bool gi_560;
string gs_564 = "Ichi_FX AUDUSD_5M v54";
int gt_572 = 0;
int gi_576;
int gi_580 = 0;
double gd_584;
int gi_592 = 0;
int gi_596 = 0;
double gd_600 = 0.0;
bool gi_608 = FALSE;
bool gi_612 = FALSE;
bool gi_616 = FALSE;
int gi_620;
bool gi_624 = FALSE;
double gd_628 = 0.0;
int gi_636 = 10;
double gd_640 = 0.0;
double gd_648 = 1.0;
double gd_656 = 1.0;
double gd_664 = 0.0;
double gd_672 = 0.0;
double gd_680;
double gd_688;
double gd_696;
double gd_704;
double gd_712;
double gd_720;
double gd_728;
double gd_736;
int gi_744;
int gi_748;
int gi_752 = 0;
int gi_756 = 0;
bool gi_760 = FALSE;
bool gi_764 = FALSE;
bool gi_768 = FALSE;
int gi_772 = 0;
int gi_776 = 0;
double gd_780;
double gd_788;

int init() {
   string ls_4;
   string ls_12;
  
   /*
   if (StringFind(AccountCompany(), "Synergy", 0) == -1) {
      Comment("ERROR: Broker needs to be SYNERGY. EA STOPPED.", "Your current broker is:", AccountCompany());
      gi_764 = TRUE;
      return (-1);
   }
   if (StringSubstr(Symbol(), 0, 6) != "AUDUSD") {
      Comment("ERROR: Currency Chart needs to be AUDUSD chart. EA STOPPED.  Remove EA from current chart and Attach EA to AUDUSD 5M Chart. Currently on chart:", StringSubstr(Symbol(),
         0, 6));
      gi_764 = TRUE;
      return (-1);
   }
   if (IsTesting()) {
      Comment(" For security reasons the EA cannot be run within backtester. EA STOPPED.");
      Print(" ERROR: For security reasons the EA cannot be run within backtester. EA STOPPED.");
      gi_764 = TRUE;
      return (-1);
   }
   */
   Comment("\nbalance = " + DoubleToStr(AccountBalance(), 2), 
   "\nequity = " + DoubleToStr(AccountEquity(), 2));
   if (gd_364 < MarketInfo(Symbol(), MODE_MINLOT)) gd_364 = MarketInfo(Symbol(), MODE_MINLOT);
   if (gd_372 > MarketInfo(Symbol(), MODE_MAXLOT)) gd_372 = MarketInfo(Symbol(), MODE_MAXLOT);
   if (gd_372 < gd_364) gd_372 = gd_364;
   int li_0 = MathMax(MarketInfo(Symbol(), MODE_FREEZELEVEL), MarketInfo(Symbol(), MODE_STOPLEVEL));
   gd_704 = AccountStopoutLevel();
   gd_712 = AccountLeverage();
   gd_720 = AccountCredit();
   gd_728 = MarketInfo(Symbol(), MODE_LOTSTEP);
   gd_736 = MarketInfo(Symbol(), MODE_LOTSIZE);
   gi_744 = AccountFreeMarginMode();
   gi_748 = AccountStopoutMode();
   double ld_20 = MarketInfo(Symbol(), MODE_MARGINREQUIRED);
   if (gi_744 == 0) ls_4 = "that floating profit/loss is not used for calculation.";
   else {
      if (gi_744 == 1) ls_4 = "both floating profit and loss on open positions.";
      else {
         if (gi_744 == 2) ls_4 = "only profitable values, where current loss on open positions are not included.";
         else
            if (gi_744 == 3) ls_4 = "only loss values are used for calculation, where current profitable open positions are not included.";
      }
   }
   if (gi_748 == 0) ls_12 = "percentage ratio between margin and equity.";
   else
      if (gi_748 == 1) ls_12 = "comparison of the free margin level to the absolute value.";
   Comment("This EA works in only in a SIDEWAYS MARKET!", 
      "\nIf the currency is strongly trending then either remove the EA and wait until the market is Sideways again OR", 
      "\nset the EA to only trade Long or Short in direction of the trend by changing the EA settings.\n\n", "Normal drawdown can be 20-30% when using this EA.", 
      "\nTo close all trades use EA property - UseClose=True.\nIf you wish to manually close positions, remove the EA first. ", 
   "\n\nFor this EA to be PROFITABLE it should run on a dedicated computer.");
   if (Digits == 2 || Digits == 4) gd_680 = 1;
   if (Digits == 3 || Digits == 5) gd_680 = 10;
   if (Digits == 6) gd_680 = 100;
   Print(" Digits:", Digits, " Point:", Point);
   int li_28 = 0;
   if (Digits == 5 || Digits == 3) li_28 = 10;
   else li_28 = 1;
   gd_688 = li_28 * Point;
   gd_696 = MarketInfo(Symbol(), MODE_STOPLEVEL) / li_28;
   gd_628 = AccountBalance();
   if (gd_188 == 0.01) gd_648 = 100;
   else {
      if (gd_188 == 0.1) gd_648 = 10;
      else {
         if (gd_188 == 10.0) gd_648 = 1;
         else gd_648 = 1;
      }
   }
   switch (Risk) {
   case 0:
   case 1:
      gd_656 = 0.5;
      break;
   case 2:
      gd_656 = 1;
      break;
   case 3:
      gd_656 = 1.7;
      break;
   case 4:
      gd_656 = 2.5;
      break;
   case 5:
      gd_656 = 3.5;
   }
   if (gi_176) gd_188 = MathMax(NormalizeDouble(MathFloor(AccountBalance() * PercentageOfAccount / 100.0 / 1000.0) / 100.0 * gd_656, gd_160), gd_364);
   else gd_640 = gd_188;
   Print("Starting Balance is:", gd_628);
   gd_552 = MarketInfo(Symbol(), MODE_SPREAD) * Point;
   gi_596 = f0_13();
   gd_504 = 0;
   double ld_36 = 0;
   for (gi_592 = OrdersTotal() - 1; gi_592 >= 0; gi_592--) {
      OrderSelect(gi_592, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != gi_468) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == gi_468) {
         if (OrderType() == OP_BUY || OrderType() == OP_SELL) {
            gd_504 += OrderOpenPrice() * OrderLots();
            ld_36 += OrderLots();
         }
      }
   }
   if (gi_596 > 0) gd_504 = NormalizeDouble(gd_504 / ld_36, Digits);
   Print("AUDUSD Robot for sideways market, Versionn=5.3 and Magic Number=", gi_468);
   return (0);
}

int deinit() {
   return (0);
}

int start() {
   double ld_32;
   double ld_40;
   double ld_48;
   double ld_56;
   double ld_72;
   double ld_80;
   if (gi_764) {
      init();
      return (-1);
   }
   if (gi_248) f0_15(gd_212, gd_220, gd_504);
   if (UseTimeOut) {
      if (TimeCurrent() >= gi_576) {
         f0_3();
         Print("Closed All due to TimeOut");
      }
   }
   if (gt_572 == Time[0]) return (0);
   gt_572 = Time[0];
   if (gi_176) gd_640 = MathMax(NormalizeDouble(MathFloor(AccountBalance() * PercentageOfAccount / 100.0 / 1000.0) / 100.0 * gd_656, gd_160), gd_364);
   else gd_640 = gd_188;
   double ld_16 = (Close[gi_320] + (Close[gi_320 + 2]) + (Close[gi_320 + 4]) + (Close[gi_320 + 8])) / 4.0;
   double ld_0 = High[iHighest(NULL, 0, MODE_HIGH, gi_320, gi_324)];
   double ld_8 = Low[iLowest(NULL, 0, MODE_LOW, gi_320, gi_324)];
   gd_664 = iATR(NULL, 0, gi_352, 0);
   gd_672 = iATR(NULL, 0, gi_352, 1);
   gd_268 = gd_356 * gd_664 * (1 / (Point * gd_680));
   double ld_24 = 0;
   gi_756 = gi_752;
   if (gi_312) ld_24 = iCustom(NULL, 0, "snowball indicator", gi_436, gi_440, gi_424, gi_428, gd_460, 4, gi_432);
   if (gi_308) {
      ld_32 = iIchimoku(NULL, 0, gi_380, gi_384, gi_388, MODE_TENKANSEN, gi_392);
      ld_40 = iIchimoku(NULL, 0, gi_380, gi_384, gi_388, MODE_KIJUNSEN, gi_392);
      ld_48 = iIchimoku(NULL, 0, gi_380, gi_384, gi_388, MODE_TENKANSEN, gi_392 + 1);
      ld_56 = iIchimoku(NULL, 0, gi_380, gi_384, gi_388, MODE_KIJUNSEN, gi_392 + 1);
      if (ld_48 > ld_56 && ld_32 < ld_40) ld_24 = -1;
      else
         if (ld_48 < ld_56 && ld_32 > ld_40) ld_24 = 1;
   }
   gi_752 = ld_24;
   if (gi_760 != gi_756) gi_760 = TRUE;
   double ld_64 = f0_5();
   if (UseMaxCapitalStop) {
      if (ld_64 < 0.0 && MathAbs(ld_64) > MaxCapitalToRiskPercent / 100.0 * f0_8()) {
         f0_3();
         Print("Closed All due to Stop Out");
         gi_624 = FALSE;
      }
   }
   gi_596 = f0_13();
   if (gi_596 == 0) gi_560 = FALSE;
   for (gi_592 = OrdersTotal() - 1; gi_592 >= 0; gi_592--) {
      OrderSelect(gi_592, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != gi_468) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == gi_468) {
         if (OrderType() == OP_BUY) {
            gi_612 = TRUE;
            gi_616 = FALSE;
            ld_72 = OrderLots();
            break;
         }
      }
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == gi_468) {
         if (OrderType() == OP_SELL) {
            gi_612 = FALSE;
            gi_616 = TRUE;
            ld_80 = OrderLots();
            break;
         }
      }
   }
   if (gi_596 > 0 && gi_596 <= gi_244) {
      RefreshRates();
      gd_528 = f0_2();
      gd_536 = f0_7();
      if (gi_612 && gd_528 - Ask >= gd_268 * Point) gi_608 = TRUE;
      if (gi_616 && Bid - gd_536 >= gd_268 * Point) gi_608 = TRUE;
   }
   if (gi_596 < 1) {
      gi_616 = FALSE;
      gi_612 = FALSE;
      gi_608 = TRUE;
      gd_480 = AccountEquity();
   }
   if (gi_608) {
      gd_528 = f0_2();
      gd_536 = f0_7();
      if (gi_616 && gi_752 == -1) {
         if (UseClose) {
            f0_1(0, 1);
            gd_584 = NormalizeDouble(gd_228 * ld_80, gd_160);
         } else gd_584 = f0_11(OP_SELL);
         if (gi_256) {
            gi_580 = gi_596;
            if (gd_584 > 0.0) {
               RefreshRates();
               if(OrdersTotal()==0){
               if (gi_276) gi_620 = f0_12(1, MathMax(gd_640 + (AccountBalance() - gd_628) / gd_628 / 10.0 - 0.06, gd_188), Bid, gd_260, Ask, 0, 0, gs_564 + "-" + gi_580, gi_468, 0, Orange);
               else gi_620 = f0_12(1, gd_584, Bid, gd_260, Ask, 0, 0, gs_564 + "-" + gi_580, gi_468, 0, Orange);
               }
               if (gi_620 < 0) {
                  Print("Error: ", GetLastError());
                  return (0);
               }
               gd_536 = f0_7();
               gi_608 = FALSE;
               gi_624 = TRUE;
            }
         }
      } else {
         if (gi_612 && gi_752 == 1) {
            if (UseClose) {
               f0_1(1, 0);
               gd_584 = NormalizeDouble(gd_228 * ld_72, gd_160);
            } else gd_584 = f0_11(OP_BUY);
            if (gi_256) {
               gi_580 = gi_596;
               if (gd_584 > 0.0) {
                  RefreshRates();
                  if(OrdersTotal()==0){
                  if (gi_276) gi_620 = f0_12(0, MathMax(gd_640 + (AccountBalance() - gd_628) / gd_628 / 10.0 - 0.06, gd_188), Ask, gd_260, Bid, 0, 0, gs_564 + "-" + gi_580, gi_468, 0, Blue);
                  else gi_620 = f0_12(0, gd_584, Ask, gd_260, Bid, 0, 0, gs_564 + "-" + gi_580, gi_468, 0, Blue);
                 }
                  if (gi_620 < 0) {
                     Print("Error: ", GetLastError());
                     return (0);
                  }
                  gd_528 = f0_2();
                  gi_608 = FALSE;
                  gi_624 = TRUE;
               }
            }
         }
      }
   }
   if (gi_608 && gi_596 < 1) {
      gd_512 = Bid;
      gd_520 = Ask;
      if (!gi_616) {
         gi_580 = gi_596;
         if ((gi_308 && ld_24 == -1.0) || (gi_312 && ld_24 == -1.0)) {
            gd_584 = f0_11(OP_SELL);
            if (gd_584 > 0.0) {
            if(OrdersTotal()==0){
               if (gi_276) gi_620 = f0_12(1, MathMax(gd_640 + (AccountBalance() - gd_628) / gd_628 / 10.0 - 0.06, gd_188), gd_512, gd_260, gd_512, 0, 0, gs_564 + "-" + gi_580, gi_468, 0, Red);
               else gi_620 = f0_12(1, gd_640, gd_512, gd_260, gd_512, 0, 0, gs_564 + "-" + gi_580, gi_468, 0, Red);
               }
               if (gi_620 < 0) {
                  Print(gd_584, "Error: ", GetLastError());
                  return (0);
               }
               gd_528 = f0_2();
               gi_624 = TRUE;
            }
         }
         if (!gi_612) gi_580 = gi_596;
         if ((gi_308 && ld_24 == 1.0) || (gi_312 && ld_24 == 1.0)) {
            gd_584 = f0_11(OP_BUY);
            if (gd_584 > 0.0) {
            if(OrdersTotal()==0){
               if (gi_276) gi_620 = f0_12(0, MathMax(gd_640 + (AccountBalance() - gd_628) / gd_628 / 10.0 - 0.06, gd_188), gd_520, gd_260, gd_520, 0, 0, gs_564 + "-" + gi_580, gi_468, 0, Lime);
               else gi_620 = f0_12(0, gd_640, gd_520, gd_260, gd_520, 0, 0, gs_564 + "-" + gi_580, gi_468, 0, Lime);
               }
               if (gi_620 < 0) {
                  Print(gd_584, "Error: ", GetLastError());
                  return (0);
               }
               gd_536 = f0_7();
               gi_624 = TRUE;
            }
         }
      }
      if (gi_620 > 0) gi_576 = TimeCurrent() + 60.0 * (60.0 * MaxTradeOpenHours);
      gi_608 = FALSE;
   }
   gi_596 = f0_13();
   gd_504 = 0;
   double ld_88 = 0;
   for (gi_592 = OrdersTotal() - 1; gi_592 >= 0; gi_592--) {
      OrderSelect(gi_592, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != gi_468) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == gi_468) {
         if (OrderType() == OP_BUY || OrderType() == OP_SELL) {
            gd_504 += OrderOpenPrice() * OrderLots();
            ld_88 += OrderLots();
         }
      }
   }
   if (gi_596 > 0) gd_504 = NormalizeDouble(gd_504 / ld_88, Digits);
   if (gi_624) {
      for (gi_592 = OrdersTotal() - 1; gi_592 >= 0; gi_592--) {
         OrderSelect(gi_592, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol() != Symbol() || OrderMagicNumber() != gi_468) continue;
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == gi_468) {
            if (OrderType() == OP_BUY) {
               gd_472 = gd_504 + gd_196 * Point;
               gd_488 = gd_472;
               gd_600 = gd_504 - gd_204 * Point;
               gi_560 = TRUE;
            }
         }
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == gi_468) {
            if (OrderType() == OP_SELL) {
               gd_472 = gd_504 - gd_196 * Point;
               gd_496 = gd_472;
               gd_600 = gd_504 + gd_204 * Point;
               gi_560 = TRUE;
            }
         }
      }
   }
   //if (gi_624) {
   //   if (gi_560 == TRUE) {
   //      for (gi_592 = OrdersTotal() - 1; gi_592 >= 0; gi_592--) {
   //         OrderSelect(gi_592, SELECT_BY_POS, MODE_TRADES);
   //         if (OrderSymbol() != Symbol() || OrderMagicNumber() != gi_468) continue;
   //         if (OrderSymbol() == Symbol() && OrderMagicNumber() == gi_468) OrderModify(OrderTicket(), gd_504, OrderStopLoss(), gd_472, 0, Yellow);
   //         gi_624 = FALSE;
   //      }
   //   }
   //}
   return (0);
}

double f0_9(double ad_0) {
   return (NormalizeDouble(ad_0, Digits));
}

int f0_1(bool ai_0 = TRUE, bool ai_4 = TRUE) {
   int li_8 = 0;
   for (int li_12 = OrdersTotal() - 1; li_12 >= 0; li_12--) {
      if (OrderSelect(li_12, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == gi_468) {
            if (OrderType() == OP_BUY && ai_0) {
               RefreshRates();
               if (!IsTradeContextBusy()) {
                  if (!OrderClose(OrderTicket(), OrderLots(), f0_9(Bid), 5, CLR_NONE)) {
                     Print("Error close BUY " + OrderTicket());
                     li_8 = -1;
                  }
               } else {
                  if (gi_772 == iTime(NULL, 0, 0)) return (-2);
                  gi_772 = iTime(NULL, 0, 0);
                  Print("Need close BUY " + OrderTicket() + ". Trade Context Busy");
                  return (-2);
               }
            }
            if (OrderType() == OP_SELL && ai_4) {
               RefreshRates();
               if (!IsTradeContextBusy()) {
                  if (!(!OrderClose(OrderTicket(), OrderLots(), f0_9(Ask), 5, CLR_NONE))) continue;
                  Print("Error close SELL " + OrderTicket());
                  li_8 = -1;
                  continue;
               }
               if (gi_776 == iTime(NULL, 0, 0)) return (-2);
               gi_776 = iTime(NULL, 0, 0);
               Print("Need close SELL " + OrderTicket() + ". Trade Context Busy");
               return (-2);
            }
         }
      }
   }
   return (li_8);
}

double f0_11(int ai_0) {
   double ld_4;
   int li_16;
   int li_20;
   switch (gi_252) {
   case 0:
      ld_4 = gd_188;
      break;
   case 1:
      if (gi_580 >= gd_236) {
         Print("Past Lot Exponent Threshold, Scaling to exit the trade");
         ld_4 = NormalizeDouble(gd_188 * MathPow(gd_228, gi_580), gd_160);
      } else ld_4 = gd_188;
      break;
   case 2:
      li_16 = 0;
      li_20 = 0;
      ld_4 = gd_188;
      for (int li_24 = OrdersHistoryTotal() - 1; li_24 >= 0; li_24--) {
         if (!(OrderSelect(li_24, SELECT_BY_POS, MODE_HISTORY))) return (-3);
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == gi_468) {
            if (li_16 < OrderCloseTime()) {
               li_16 = OrderCloseTime();
               if (OrderProfit() < 0.0) {
                  li_20++;
                  if (li_20 < gd_236) continue;
                  ld_4 = NormalizeDouble(OrderLots() * gd_228, gd_160);
                  continue;
               }
               ld_4 = gd_188;
               li_20 = 0;
               continue;
               return (-3);
            }
         }
      }
   }
   if (AccountFreeMarginCheck(Symbol(), ai_0, ld_4) <= 0.0) return (-1);
   if (GetLastError() == 134/* NOT_ENOUGH_MONEY */) return (-2);
   return (ld_4);
}

int f0_13() {
   int li_0 = 0;
   for (int li_4 = OrdersTotal() - 1; li_4 >= 0; li_4--) {
      OrderSelect(li_4, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != gi_468) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == gi_468)
         if (OrderType() == OP_SELL || OrderType() == OP_BUY) li_0++;
   }
   return (li_0);
}

void f0_3() {
   for (int li_0 = OrdersTotal() - 1; li_0 >= 0; li_0--) {
      OrderSelect(li_0, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() == Symbol()) {
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == gi_468) {
            if (OrderType() == OP_BUY) OrderClose(OrderTicket(), OrderLots(), Bid, gd_260, Blue);
            if (OrderType() == OP_SELL) OrderClose(OrderTicket(), OrderLots(), Ask, gd_260, Red);
         }
         Sleep(1000);
      }
   }
}

int f0_12(int ai_0, double ad_4, double ad_12, int ai_20, double ad_24, int ai_32, int ai_36, string as_40, int ai_48, int ai_52, color ai_56) {
   int li_60 = 0;
   int li_64 = 0;
   int li_68 = 0;
   int li_72 = 100;
   switch (ai_0) {
   case 2:
      for (li_68 = 0; li_68 < li_72; li_68++) {
         li_60 = OrderSend(Symbol(), OP_BUYLIMIT, ad_4, ad_12, ai_20, f0_10(ad_24, ai_32), f0_14(ad_12, ai_36), as_40, ai_48, ai_52, ai_56);
         li_64 = GetLastError();
         if (li_64 == 0/* NO_ERROR */) break;
         if (!(li_64 == 4/* SERVER_BUSY */ || li_64 == 137/* BROKER_BUSY */ || li_64 == 146/* TRADE_CONTEXT_BUSY */ || li_64 == 136/* OFF_QUOTES */)) break;
         Sleep(1000);
      }
      break;
   case 4:
      for (li_68 = 0; li_68 < li_72; li_68++) {
         li_60 = OrderSend(Symbol(), OP_BUYSTOP, ad_4, ad_12, ai_20, f0_10(ad_24, ai_32), f0_14(ad_12, ai_36), as_40, ai_48, ai_52, ai_56);
         li_64 = GetLastError();
         if (li_64 == 0/* NO_ERROR */) break;
         if (!(li_64 == 4/* SERVER_BUSY */ || li_64 == 137/* BROKER_BUSY */ || li_64 == 146/* TRADE_CONTEXT_BUSY */ || li_64 == 136/* OFF_QUOTES */)) break;
         Sleep(5000);
      }
      break;
   case 0:
      for (li_68 = 0; li_68 < li_72; li_68++) {
         RefreshRates();
         li_60 = OrderSend(Symbol(), OP_BUY, lot, Ask, ai_20, Ask-sl*10*Point() ,Ask+tp*10*Point(), as_40, ai_48, ai_52, ai_56);
         li_64 = GetLastError();
         if (li_64 == 0/* NO_ERROR */) break;
         if (!(li_64 == 4/* SERVER_BUSY */ || li_64 == 137/* BROKER_BUSY */ || li_64 == 146/* TRADE_CONTEXT_BUSY */ || li_64 == 136/* OFF_QUOTES */)) break;
         Sleep(5000);
      }
      break;
   case 3:
      for (li_68 = 0; li_68 < li_72; li_68++) {
         li_60 = OrderSend(Symbol(), OP_SELLLIMIT, ad_4, ad_12, ai_20, f0_0(ad_24, ai_32), f0_4(ad_12, ai_36), as_40, ai_48, ai_52, ai_56);
         li_64 = GetLastError();
         if (li_64 == 0/* NO_ERROR */) break;
         if (!(li_64 == 4/* SERVER_BUSY */ || li_64 == 137/* BROKER_BUSY */ || li_64 == 146/* TRADE_CONTEXT_BUSY */ || li_64 == 136/* OFF_QUOTES */)) break;
         Sleep(5000);
      }
      break;
   case 5:
      for (li_68 = 0; li_68 < li_72; li_68++) {
         li_60 = OrderSend(Symbol(), OP_SELLSTOP, ad_4, ad_12, ai_20, f0_0(ad_24, ai_32), f0_4(ad_12, ai_36), as_40, ai_48, ai_52, ai_56);
         li_64 = GetLastError();
         if (li_64 == 0/* NO_ERROR */) break;
         if (!(li_64 == 4/* SERVER_BUSY */ || li_64 == 137/* BROKER_BUSY */ || li_64 == 146/* TRADE_CONTEXT_BUSY */ || li_64 == 136/* OFF_QUOTES */)) break;
         Sleep(5000);
      }
      break;
   case 1:
      for (li_68 = 0; li_68 < li_72; li_68++) {
         li_60 = OrderSend(Symbol(), OP_SELL, lot, Bid, ai_20, Ask+sl*10*Point() ,Bid-tp*10*Point(), as_40, ai_48, ai_52, ai_56);
         li_64 = GetLastError();
         if (li_64 == 0/* NO_ERROR */) break;
         if (!(li_64 == 4/* SERVER_BUSY */ || li_64 == 137/* BROKER_BUSY */ || li_64 == 146/* TRADE_CONTEXT_BUSY */ || li_64 == 136/* OFF_QUOTES */)) break;
         Sleep(5000);
      }
   }
   return (li_60);
}

double f0_10(double ad_0, int ai_8) {
   if (ai_8 == 0) return (0);
   return (ad_0 - ai_8 * Point);
}

double f0_0(double ad_0, int ai_8) {
   if (ai_8 == 0) return (0);
   return (ad_0 + ai_8 * Point);
}

double f0_14(double ad_0, int ai_8) {
   if (ai_8 == 0) return (0);
   return (ad_0 + ai_8 * Point);
}

double f0_4(double ad_0, int ai_8) {
   if (ai_8 == 0) return (0);
   return (ad_0 - ai_8 * Point);
}

double f0_5() {
   double ld_0 = 0;
   for (gi_592 = OrdersTotal() - 1; gi_592 >= 0; gi_592--) {
      OrderSelect(gi_592, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != gi_468) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == gi_468)
         if (OrderType() == OP_BUY || OrderType() == OP_SELL) ld_0 += OrderProfit();
   }
   return (ld_0);
}

void f0_15(int ai_0, int ai_4, double ad_8) {
   int li_16;
   double ld_20;
   double ld_28;
   double ld_36;
   double ld_44;
   double ld_52;
   double ld_60;
   gi_292 = TRUE;
   if (gi_296) ld_44 = gd_268 / gd_416;
   else ld_44 = ai_4;
   if (gi_292) ld_52 = gd_268 * gd_300;
   else ld_52 = ai_0;
   if (ai_4 != 0) {
      for (int li_76 = OrdersTotal() - 1; li_76 >= 0; li_76--) {
         if (OrderSelect(li_76, SELECT_BY_POS, MODE_TRADES)) {
            if (OrderSymbol() != Symbol() || OrderMagicNumber() != gi_468) continue;
            if (OrderSymbol() == Symbol() || OrderMagicNumber() == gi_468) {
               if (gi_328) {
                  f0_6(OrderTicket(), ad_8);
                  continue;
               }
               if (OrderType() == OP_BUY) {
                  li_16 = NormalizeDouble((Bid - ad_8) / Point, 0);
                  if (li_16 < ld_52) continue;
                  ld_20 = OrderStopLoss();
                  ld_28 = OrderTakeProfit();
                  ld_36 = Bid - ld_44 * Point;
                  ld_60 = Bid + ld_52 * Point;
                  if (ld_20 == 0.0 || (ld_20 != 0.0 && ld_36 > ld_20))
                     if (MathAbs(ld_36 - ld_20) > 0.0 || MathAbs(ld_60 - ld_28) > 0.0) OrderModify(OrderTicket(), ad_8, ld_36, OrderTakeProfit(), 0, Aqua);
               }
               if (OrderType() == OP_SELL) {
                  li_16 = NormalizeDouble((ad_8 - Ask) / Point, 0);
                  if (li_16 < ld_52) continue;
                  ld_20 = OrderStopLoss();
                  ld_28 = OrderTakeProfit();
                  ld_36 = Ask + ld_44 * Point;
                  ld_60 = Ask - ld_52 * Point;
                  if (ld_20 == 0.0 || (ld_20 != 0.0 && ld_36 < ld_20))
                     if (MathAbs(ld_36 - ld_20) > 0.0 || MathAbs(ld_60 - ld_28) > 0.0) OrderModify(OrderTicket(), ad_8, ld_36, OrderTakeProfit(), 0, Red);
               }
            }
            Sleep(1000);
         }
      }
   }
}

double f0_8() {
   if (f0_13() == 0) gd_780 = AccountEquity();
   if (gd_780 < gd_788) gd_780 = gd_788;
   else gd_780 = AccountEquity();
   gd_788 = AccountEquity();
   return (gd_780);
}

double f0_2() {
   double ld_8;
   int li_24;
   double ld_0 = 0;
   int li_20 = 0;
   for (int li_16 = OrdersTotal() - 1; li_16 >= 0; li_16--) {
      OrderSelect(li_16, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != gi_468) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == gi_468 && OrderType() == OP_BUY) {
         li_24 = OrderTicket();
         if (li_24 > li_20) {
            ld_8 = OrderOpenPrice();
            ld_0 = ld_8;
            li_20 = li_24;
         }
      }
   }
   return (ld_8);
}

double f0_7() {
   double ld_8;
   int li_24;
   double ld_0 = 0;
   int li_20 = 0;
   for (int li_16 = OrdersTotal() - 1; li_16 >= 0; li_16--) {
      OrderSelect(li_16, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != gi_468) continue;
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == gi_468 && OrderType() == OP_SELL) {
         li_24 = OrderTicket();
         if (li_24 > li_20) {
            ld_8 = OrderOpenPrice();
            ld_0 = ld_8;
            li_20 = li_24;
         }
      }
   }
   return (ld_8);
}

void f0_6(int ai_0, double ad_4) {
   bool li_20;
   double ld_12 = iSAR(NULL, 0, gd_332, gd_340, 0);
   if (OrderSelect(ai_0, SELECT_BY_POS, MODE_TRADES)) {
      if (OrderType() == OP_BUY) {
         ld_12 -= gi_348 * gd_688;
         if (gi_456) ld_12 -= MarketInfo(Symbol(), MODE_SPREAD) * Point;
         if (!(NormalizeDouble(OrderStopLoss(), Digits) < NormalizeDouble(ld_12, Digits) && NormalizeDouble(Bid - gd_696 * gd_688, Digits) > NormalizeDouble(ld_12, Digits))) return;
         li_20 = OrderModify(OrderTicket(), ad_4, NormalizeDouble(ld_12, Digits), OrderTakeProfit(), 0, Blue);
         if (!(!li_20)) return;
         Print("Error modifying order on candletrail: ", GetLastError());
         return;
      }
      if (OrderType() == OP_SELL) {
         ld_12 += gi_348 * gd_688;
         if (gi_456) ld_12 += MarketInfo(Symbol(), MODE_SPREAD) * Point;
         if (NormalizeDouble(OrderStopLoss(), Digits) > NormalizeDouble(ld_12, Digits) || OrderStopLoss() == 0.0 && NormalizeDouble(Ask + gd_696 * gd_688, Digits) < NormalizeDouble(ld_12,
            Digits)) {
            li_20 = OrderModify(OrderTicket(), ad_4, NormalizeDouble(ld_12, Digits), OrderTakeProfit(), 0, Red);
            if (!li_20) Print("Error modifying order on candletrail: ", GetLastError());
         }
      }
   }
}