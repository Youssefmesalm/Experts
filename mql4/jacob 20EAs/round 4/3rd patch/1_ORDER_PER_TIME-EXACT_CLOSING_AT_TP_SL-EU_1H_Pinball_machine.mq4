//+------------------------------------------------------------------+
//|                                              Pinball machine.mq4 |
//|                                                              ytg |
//|                                                              ytg |
//+------------------------------------------------------------------+
#property copyright "ytg"
#property link      "ytg"

input double stoploss=100;
input double takeProfit=100;
extern string ____2___      = "Íàñòðîéêè îðäåðîâ";
extern double Lots          = 0.3;          // Ðàçìåð ëîòà
 bool   MarketWatch   = false;         // Çàïðîñû ïîä èñïîëíåíèå "Market Watch".
 int    MagicNumber   = 28081975;     // Ìàãè÷åñêîå ÷èñëî îðäåðîâ
 int    Slippage      = 30;           // Ïðîñêàëüçûâàíèå öåíû
 int    NumberOfTry   = 5;            // Êîëè÷åñòâî òîðãîâûõ ïîïûòîê


int           NumberAccount = 0;            // Íîìåð òîðãîâîãî ñ÷¸òà
bool          ShowComment   = True;         // Ïîêàçûâàòü êîììåíòàðèé
color         clOpenBuy     = LightBlue;    // Öâåò çíà÷êà îòêðûòèÿ ïîêóïêè
color         clOpenSell    = LightCoral;   // Öâåò çíà÷êà îòêðûòèÿ ïðîäàæè
bool          UseSound      = True;         // Èñïîëüçîâàòü çâóêîâîé ñèãíàë
string        NameFileSound = "expert.wav"; // Íàèìåíîâàíèå çâóêîâîãî ôàéëà

//------- Ãëîáàëüíûå ïåðåìåííûå ñîâåòíèêà -------------------------------------+

bool          gbDisabled    = False;        // Ôëàã áëîêèðîâêè ñîâåòíèêà
bool          gbNoInit      = False;        // Ôëàã íåóäà÷íîé èíèöèàëèçàöèè

//------- Ïîäêëþ÷åíèå âíåøíèõ ìîäóëåé -----------------------------------------+

#include <stdlib.mqh>                       // Ñòàíäàðòíàÿ áèáëèîòåêà ÌÒ4

//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----
   MathSrand(TimeLocal());   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {
//----
   double sl=0, tp=0;

   int value1  = GetRand(0,100);
   int value2  = GetRand(0,100);
   int value3  = GetRand(0,100);
   int value4  = GetRand(0,100);

   
    
   if(value1==value2)
    {
      
     if (stoploss  >0) sl=Ask-stoploss*10*Point;   else sl=0;
     if (takeProfit>0) tp=Ask+takeProfit*10*Point; else tp=0;
     OpenPosition(NULL, OP_BUY, Lots, sl, tp, MagicNumber);
    }
    
   if(value3==value4)
     {
      if (stoploss  >0) sl=Bid+stoploss*10*Point;   else sl=0;
      if (takeProfit>0) tp=Bid-takeProfit*10*Point; else tp=0;
      OpenPosition(NULL, OP_SELL, Lots, sl, tp, MagicNumber);
     }    
//----
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//Àâòîð - Åâñòðàòåíêî Äìèòðèé  (ãåíåðàòîð ñëó÷àéíûõ ÷èñåë)
//ïðèìåð âûçîâà ôóíêöèè        int value1  = GetRand(0,10);
//â èíèò âñòàâèòü     MathSrand(TimeLocal());

int GetRand(int vFrom, int vTo)
{
 int vV;
 while (true)
  {
   vV = MathRand();
   if (vV>=vFrom && vV<=vTo) break;   
  }
 return(vV); 
}
//+----------------------------------------------------------------------------+
//|  Îïèñàíèå : Âûâîä ñîîáùåíèÿ â êîììåíò è â æóðíàë                           |
//+----------------------------------------------------------------------------+
//|  Ïàðàìåòðû:                                                                |
//|    m - òåêñò ñîîáùåíèÿ                                                     |
//+----------------------------------------------------------------------------+
void Message(string m) {
  Comment(m);
  if (StringLen(m)>0) Print(m);
}
//|  Îïèñàíèå : Îòêðûâàåò ïîçèöèþ ïî ðûíî÷íîé öåíå.                            |
//+----------------------------------------------------------------------------+
//|  Ïàðàìåòðû:                                                                |
//|    sy - íàèìåíîâàíèå èíñòðóìåíòà   (NULL èëè "" - òåêóùèé ñèìâîë)          |
//|    op - îïåðàöèÿ                                                           |
//|    ll - ëîò                                                                |
//|    sl - óðîâåíü ñòîï                                                       |
//|    tp - óðîâåíü òåéê                                                       |
//|    mn - MagicNumber                                                        |
//+----------------------------------------------------------------------------+
void OpenPosition(string sy, int op, double ll, double sl=0, double tp=0, int mn=0) {
  color    clOpen;
  datetime ot;
  double   pp, pa, pb;
  int      dg, err, it, ticket=0;
  string   lsComm=WindowExpertName()+" "+GetNameTF(Period());

  if (sy=="" || sy=="0") sy=Symbol();
  if (op==OP_BUY) clOpen=clOpenBuy; else clOpen=clOpenSell;
  for (it=1; it<=NumberOfTry; it++) {
    if (!IsTesting() && (!IsExpertEnabled() || IsStopped())) {
      Print("OpenPosition(): Îñòàíîâêà ðàáîòû ôóíêöèè");
      break;
    }
    while (!IsTradeAllowed()) Sleep(5000);
    RefreshRates();
    dg=MarketInfo(sy, MODE_DIGITS);
    pa=MarketInfo(sy, MODE_ASK);
    pb=MarketInfo(sy, MODE_BID);
    if (op==OP_BUY) pp=pa; else pp=pb;
    pp=NormalizeDouble(pp, dg);
    ot=TimeCurrent();
    if(OrdersTotal()==0){
    if (MarketWatch)
      ticket=OrderSend(sy, op, ll, pp, Slippage, sl, tp, lsComm, mn, 0, clOpen);
    else
      ticket=OrderSend(sy, op, ll, pp, Slippage, sl, tp, lsComm, mn, 0, clOpen);
      }
    if (ticket>0) {
      if (UseSound) PlaySound(NameFileSound); break;
    } else {
      err=GetLastError();
      if (pa==0 && pb==0) Message("Ïðîâåðüòå â Îáçîðå ðûíêà íàëè÷èå ñèìâîëà "+sy);
      // Âûâîä ñîîáùåíèÿ îá îøèáêå
      Print("Error(",err,") opening position: ",ErrorDescription(err),", try ",it);
      Print("Ask=",pa," Bid=",pb," sy=",sy," ll=",ll," op=",GetNameOP(op),
            " pp=",pp," sl=",sl," tp=",tp," mn=",mn);
      // Áëîêèðîâêà ðàáîòû ñîâåòíèêà
      if (err==2 || err==64 || err==65 || err==133) {
        gbDisabled=True; break;
      }
      // Äëèòåëüíàÿ ïàóçà
      if (err==4 || err==131 || err==132) {
        Sleep(1000*300); break;
      }
      if (err==128 || err==142 || err==143) {
        Sleep(1000*66.666);
        if (ExistPositions(sy, op, mn, ot)) {
          if (UseSound) PlaySound(NameFileSound); break;
        }
      }
      if (err==140 || err==148 || err==4110 || err==4111) break;
      if (err==141) Sleep(1000*100);
      if (err==145) Sleep(1000*17);
      if (err==146) while (IsTradeContextBusy()) Sleep(1000*11);
      if (err!=135) Sleep(1000*7.7);
    }
  }
  if (MarketWatch && ticket>0 && (sl>0 || tp>0)) {
    if (OrderSelect(ticket, SELECT_BY_TICKET)) ModifyOrder(-1, sl, tp);
  }
}
//|  Îïèñàíèå : Âîçâðàùàåò íàèìåíîâàíèå òàéìôðåéìà                             |
//+----------------------------------------------------------------------------+
//|  Ïàðàìåòðû:                                                                |
//|    TimeFrame - òàéìôðåéì (êîëè÷åñòâî ñåêóíä)      (0 - òåêóùèé ÒÔ)         |
//+----------------------------------------------------------------------------+
string GetNameTF(int TimeFrame=0) {
  if (TimeFrame==0) TimeFrame=Period();
  switch (TimeFrame) {
    case PERIOD_M1:  return("M1");
    case PERIOD_M5:  return("M5");
    case PERIOD_M15: return("M15");
    case PERIOD_M30: return("M30");
    case PERIOD_H1:  return("H1");
    case PERIOD_H4:  return("H4");
    case PERIOD_D1:  return("Daily");
    case PERIOD_W1:  return("Weekly");
    case PERIOD_MN1: return("Monthly");
    default:         return("UnknownPeriod");
  }
}
//|  Îïèñàíèå : Âîçâðàùàåò íàèìåíîâàíèå òîðãîâîé îïåðàöèè                      |
//+----------------------------------------------------------------------------+
//|  Ïàðàìåòðû:                                                                |
//|    op - èäåíòèôèêàòîð òîðãîâîé îïåðàöèè                                    |
//+----------------------------------------------------------------------------+
string GetNameOP(int op) {
  switch (op) {
    case OP_BUY      : return("Buy");
    case OP_SELL     : return("Sell");
    case OP_BUYLIMIT : return("Buy Limit");
    case OP_SELLLIMIT: return("Sell Limit");
    case OP_BUYSTOP  : return("Buy Stop");
    case OP_SELLSTOP : return("Sell Stop");
    default          : return("Unknown Operation");
  }
}
//+----------------------------------------------------------------------------+
//|  Àâòîð    : Êèì Èãîðü Â. aka KimIV,  http://www.kimiv.ru                   |
//+----------------------------------------------------------------------------+
//|  Âåðñèÿ   : 06.03.2008                                                     |
//|  Îïèñàíèå : Âîçâðàùàåò ôëàã ñóùåñòâîâàíèÿ ïîçèöèé                          |
//+----------------------------------------------------------------------------+
//|  Ïàðàìåòðû:                                                                |
//|    sy - íàèìåíîâàíèå èíñòðóìåíòà   (""   - ëþáîé ñèìâîë,                   |
//|                                     NULL - òåêóùèé ñèìâîë)                 |
//|    op - îïåðàöèÿ                   (-1   - ëþáàÿ ïîçèöèÿ)                  |
//|    mn - MagicNumber                (-1   - ëþáîé ìàãèê)                    |
//|    ot - âðåìÿ îòêðûòèÿ             ( 0   - ëþáîå âðåìÿ îòêðûòèÿ)           |
//+----------------------------------------------------------------------------+
bool ExistPositions(string sy="", int op=-1, int mn=-1, datetime ot=0) {
  int i, k=OrdersTotal();

  if (sy=="0") sy=Symbol();
  for (i=0; i<k; i++) {
    if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
      if (OrderSymbol()==sy || sy=="") {
        if (OrderType()==OP_BUY || OrderType()==OP_SELL) {
          if (op<0 || OrderType()==op) {
            if (mn<0 || OrderMagicNumber()==mn) {
              if (ot<=OrderOpenTime()) return(True);
            }
          }
        }
      }
    }
  }
  return(False);
}
//|  Îïèñàíèå : Ìîäèôèêàöèÿ îäíîãî ïðåäâàðèòåëüíî âûáðàííîãî îðäåðà.           |
//+----------------------------------------------------------------------------+
//|  Ïàðàìåòðû:                                                                |
//|    pp - öåíà óñòàíîâêè îðäåðà                                              |
//|    sl - öåíîâîé óðîâåíü ñòîïà                                              |
//|    tp - öåíîâîé óðîâåíü òåéêà                                              |
//|    ex - äàòà èñòå÷åíèÿ                                                     |
//+----------------------------------------------------------------------------+
void ModifyOrder(double pp=-1, double sl=0, double tp=0, datetime ex=0) {
  bool   fm;
  color  cl;
  double op, pa, pb, os, ot;
  int    dg=MarketInfo(OrderSymbol(), MODE_DIGITS), er, it;

  if (pp<=0) pp=OrderOpenPrice();
  if (sl<0 ) sl=OrderStopLoss();
  if (tp<0 ) tp=OrderTakeProfit();
  
  pp=NormalizeDouble(pp, dg);
  sl=NormalizeDouble(sl, dg);
  tp=NormalizeDouble(tp, dg);
  op=NormalizeDouble(OrderOpenPrice() , dg);
  os=NormalizeDouble(OrderStopLoss()  , dg);
  ot=NormalizeDouble(OrderTakeProfit(), dg);

  if (pp!=op || sl!=os || tp!=ot) {
    for (it=1; it<=NumberOfTry; it++) {
      if (!IsTesting() && (!IsExpertEnabled() || IsStopped())) break;
      while (!IsTradeAllowed()) Sleep(5000);
      RefreshRates();
      fm=OrderModify(OrderTicket(), pp, sl, tp, ex, cl);
      if (fm) {
        if (UseSound) PlaySound(NameFileSound); break;
      } else {
        er=GetLastError();
        pa=MarketInfo(OrderSymbol(), MODE_ASK);
        pb=MarketInfo(OrderSymbol(), MODE_BID);
        Print("Error(",er,") modifying order: ",ErrorDescription(er),", try ",it);
        Print("Ask=",pa,"  Bid=",pb,"  sy=",OrderSymbol(),
              "  op="+GetNameOP(OrderType()),"  pp=",pp,"  sl=",sl,"  tp=",tp);
        Sleep(1000*10);
      }
    }
  }
}