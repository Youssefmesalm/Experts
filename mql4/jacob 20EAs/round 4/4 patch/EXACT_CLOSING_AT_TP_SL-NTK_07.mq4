/*
Êàê ðàáîòàåò:
ñòàâèì äâà îòëîæåííûõ îðåäðà îò òåêóùåé öåíû íà ðàññòîÿíèè netstep
åñëè îäèí èç íèõ ñðàáàòûâàåò, òî âòîðîé óäàëÿåì
ñòàâèì åùå îäèí îòëîæåííûé â íàïðàâëåíèè äâèæåíèÿ öåíû íà ðàññòîÿíèè netstep, íî ñ ëîòîì óìíîæåííûì íà mul
è ò.ä. äî òåõ ïîð ïîêà íå äîñòèãíåì êîëè÷åñòâà îòðûòûõ ñäåëîê maxtrades èëè LotLim
è äàëüøå òàùèì ñòîïû è ïðîôèòû â íàïðàâëåíèè öåíû, ò.å. çàäà÷à ïîéìàòü òðåíä è íå ñëèòü íà ôëåòå
ïîýòîìó maxtrades, ñòîïû, ïðîôèòû çàâèñÿò îò âîëàòèëüíîñòè ðûíêà, à mul ïî èäåå äîëæåí áûòü ìåíüøå äâóõ, ÷òîáû çà ñ÷åò íàêîïëåííîé ìàðæè íå ñëèòü ìíîãî
âîîáùåì ýêñïåðò íàèáîëåå ñòàáèëüíî ðàáîòàåò ñ íàèìåíüøèìè âîçìîæíûìè çíà÷åíèÿìè ýòèõ ïàðàìåòðîâ
òô ëþáîé

Íà ðèñóíêå 1 äàí ãðàôèê ñóòî÷íîãî èçìåíåíèÿ öåíû ïî eurusd (ñóòî÷íûå áàðû), ïàðàìåòðû ýêñïåðòà îïòèìèçèðîâàíû çà ïåðèîä 01.01.2008 - 01.11.2008.
Ýêñïåðò íîðìàëüíî ðàáîòàåò è ïîñëåäíèå äâà ìåñÿöà è âòîðóþ ïîëîâèíó 2007 ãîäà, ÷òî è ïîäòâåðæäàåòñÿ ãðàôèêîì

Îáðàùàþñü çà ïîìîùüþ ê òåì êîìó ïîíðàâèëñÿ ýòîò ýêñïåðò èëè Âû íàøëè â íåì ðàöèîíàëüíîå çåðíî.
Îñíîâíûå ïðîáëåìû:
1. Áîëüøàÿ ïðîñàäêà, ìîæíî ïîñòàâèòü ôèëüòðû íà îñíîâå êàêèõ ëèáî èíäèêàòîðîâ ÷òîáû çàêðûâàòü ðàíüøå, ïîçæå èëè ñòîïû, ïðîôèòû ïåðåäâèãàòü (íå ïîëó÷àåòñÿ ó ìåíÿ)
2. Ó êîãî åñòü õîðîøèé îïûò ðàáîòû íà ðåàëå, òî ýêñïåðò áû î÷åíü õîòåëîñü äî ýòîãî ñîñòîÿíèÿ äîâåñòè ...
(íàïðèìåð, íà äåìêå fxstart íå ìîäèôèóöèðóåò îðäåðà (â òåñòåðå íîðìàëüíî), à íà forex4u âñå îê)
Áóäó áëàãîäàðåí çà ëþáûå îòçûâû, ïîæåëàíèÿ è ïðåäëîæåíèÿ.
Ïðèñûëàéòå ïåðåäåëàííûå ýêñïåðòû, set ôàéëû äëÿ ðàçíûõ èíñòðóìåíòîâ, íàéäåííûå îøèáêè
Ýêñïåðò íå áóäó çàêðûâàòü èëè ïðîäàâàòü, âñåì êòî ïîìîæåò äîâåñòè åãî î óìà áóäó âûñûëàòü ïîñëåäíèå âåðñèè.
È ÿ ïðîòèâ òîãî ÷òîáû ýòîò ýêñïåðò ïðîäàâàëè !
(íå ïîòîìó ÷òî îí õîðîøèé/ïëîõîé, à ïîòîìó ÷òî IMHO òîëüêî àâòîð(û) èìåþò íà ýòî ïðàâî) 

Êñòàòè, åñëè Âàì íóæíà êó÷à ýêñïåðòîâ, òî âîò îíà (351 ìá) http://depositfiles.com/files/lxs1avv7l
(ñêà÷àíî â îñíîâíîì ñ îäíîãî ñàéòà, òàì áóäåò ññûëêà)
*/
//
//
#property copyright "runik"
#property link      "ngb2008@mail.ru"

//---- input parameters
extern string  g1="Îñíîâíûå ïàðàìåòðû";
extern int       netstep=23;
extern int       sl=115;
extern int       tp=300;
extern int       TrailingStop=75;
extern double    mul=1.7;
extern int       trailprofit=1;   // ïåðåäâèãàòü ëè ïðîôèò

extern string  gg="Óïðàâëåíèå äåíüãàìè";

extern int       mm=2; 
                  // 0 - ïîñòîÿííûé ëîò, 
                  // 1 - âû÷èñëÿåòñÿ â % îò äåïî è maxtrades, 
                  // 2 - âû÷èñëÿåòñÿ â çàâèñèìîñòè îò ïåðâîíà÷àëüíîãî ëîòà è maxtrades
extern double    Lots=1;
extern double    LotLim=7;
extern int       maxtrades=4;
extern double    percent=10;
extern double    minsum=5000;
extern int       bezub=0; // åñëè 1, ïåðåíîñÿòñÿ ñòîïû â áåçóáûòîê
extern int       deltalast=5; // åñëè ïîñëå ñîâåðøåíèÿ ïîñëåäíåé ñäåëêè öåíà îòîéäåò íà 5 ïóíêòîâ â íóæíóþ ñòîðîíó, òî ïåðåíîñèì â áåçóáûòîê 

extern string  bq="Ôèëüòðû";

extern int       usema=0;
extern int    MovingPeriod       = 100;
extern int    MovingShift        = 0;

extern string  bb="Ìàëîçíà÷èìûå ïåðåìåííûå";

extern int       chas1=0;        // ÷àñû ðàáîòû
extern int       chas2=24;
extern int       per=0;       // ïåðèîä â áàðàõ
extern int       center=0; // 0 - òîðãóåì îò êðàåâ äèàïàçîíà, 1- òîðãóåì îò öåíòðà
extern int       c10=10; // èñïîëüçóåòñÿ äëÿ îêðóãëåíèÿ ëîòîâ
extern int       c20=10000; // èñïîëüçóåòñÿ äëÿ îêðóãëåíèÿ öåí

int oldtr=0;
double nulpoint=0;


//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----

  
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
 if (oldtr>TrailingStop) {TrailingStop=oldtr;}
//   Îïðåäåëÿåì ðàçìåð ëîòà, ÷òî-òî íå î÷åíü ðàáîòàåò
if (mm==1)
   {
double lotsi=MathCeil(AccountBalance()/1000*percent/100);
  LotLim=lotsi;
  for(int t=1;t<=maxtrades;t++)   
    {
    lotsi=lotsi/mul;
    }
    lotsi=MathRound(lotsi*c10)/c10;    
    Lots=lotsi;
    }

if (mm==2)
   {
   lotsi=Lots;
  for(t=1;t<=maxtrades;t++)   
    {
    lotsi=lotsi*mul;
    }
    LotLim=lotsi;
    }    
    
    
    


if(DayOfWeek()==0 || DayOfWeek()==6)  return(0);// íå ðàáîòàåò â âûõîäíûå äíè.

if(AccountFreeMargin()<minsum) // äåíüãè êîí÷èëèñü
        {
         Print("We have no money. Free Margin = ", AccountFreeMargin());
         return(0);  
        }   
        
        

if (OrdersTotal()<1) // íà÷èíàåì !
  {
  if (Hour()<chas1 || Hour()>(chas2) || chas1>chas2) return(0);// âðåìÿ â äèàïàçîíå
  
     if (per>0 && center==0) 
        {   
          double ssmax=High[1];
          double ssmin=Low[1];
          for (int x=2;x<=per;x++)
            {
            if (ssmax < High[x]) ssmax=High[x];
            if (ssmin > Low[x]) ssmin=Low[x];
            }
         if (Ask>=ssmax || Ask<=ssmin)
            {
            int ticket=OrderSend(Symbol(),OP_BUYSTOP,Lots,Ask+netstep*Point,3,Ask+netstep*Point-sl*Point,Ask+netstep*Point+tp*Point,"BUYSTOP",0,0,Green);          
            ticket=OrderSend(Symbol(),OP_SELLSTOP,Lots,Bid-netstep*Point,3,Bid-netstep*Point+sl*Point,Bid-netstep*Point-tp*Point,"STOPLIMIT",0,0,Green);   
            }
        }
        
     if (per>0 && center==1) 
        {   
          ssmax=High[1];
          ssmin=Low[1];
          for (x=2;x<=per;x++)
            {
            if (ssmax < High[x]) ssmax=High[x];
            if (ssmin > Low[x]) ssmin=Low[x];
            }
         if (Ask==(ssmax+ssmin)/2 || Bid==(ssmax+ssmin)/2)
            {
            ticket=OrderSend(Symbol(),OP_BUYSTOP,Lots,Ask+netstep*Point,3,Ask+netstep*Point-sl*Point,Ask+netstep*Point+tp*Point,"BUYSTOP",0,0,Green);          
            ticket=OrderSend(Symbol(),OP_SELLSTOP,Lots,Bid-netstep*Point,3,Bid-netstep*Point+sl*Point,Bid-netstep*Point-tp*Point,"STOPLIMIT",0,0,Green);   
            }
        }        
  
    if (per==0)
    {
    ticket=OrderSend(Symbol(),OP_BUYSTOP,Lots,Ask+netstep*Point,3,Ask+netstep*Point-sl*Point,Ask+netstep*Point+tp*Point,"BUYSTOP",0,0,Green) ;        
    ticket=OrderSend(Symbol(),OP_SELLSTOP,Lots,Bid-netstep*Point,3,Bid-netstep*Point+sl*Point,Bid-netstep*Point-tp*Point,"STOPLIMIT",0,0,Green);  
    }
    
  }

int cnt=0;
int mode=0; 

double buylot=0;double buyprice=0;double buystoplot=0;double buystopprice=0;double buylimitlot=0;double buylimitprice=0;
double selllot=0;double sellprice=0;double sellstoplot=0;double sellstopprice=0;double selllimitlot=0;double selllimitprice=0;
double buysl=0;double buytp=0;double sellsl=0;double selltp=0;
int bt=-1;int bst=-1;int blt=-1;int st=-1;int sst=-1;int slt=-1;

//if (OrdersTotal()>0)////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//{
//
//  for(cnt=0;cnt<OrdersTotal();cnt++)   // çàïîìèíàåì ïàðàìåòðû îðäåðîâ
//    {
//    OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
//    mode = OrderType(); 
//    
//    if (mode==OP_BUY )        
//      {
//      if (buylot<OrderLots())  // çàïîìèíàåì ïàðàìåòðû ñàìîãî áîëüøîãî îòêðûòîãî îðäåðà
//        {     buylot=OrderLots();
//              buyprice=OrderOpenPrice();
//              bt=OrderTicket(); 
//              buysl=OrderStopLoss(); 
//              buytp=OrderTakeProfit(); 
//        }  
//      }     
//           
//           
//    if (mode==OP_BUYSTOP )    {       buystoplot=OrderLots();    buystopprice=OrderOpenPrice();    bst=OrderTicket();  }         
//    if (mode==OP_BUYLIMIT )   {       buylimitlot=OrderLots();   buylimitprice=OrderOpenPrice();   blt=OrderTicket();  }      
//    
//    if (mode==OP_SELL )       
//      { 
//      if (selllot<OrderLots())      // çàïîìèíàåì ïàðàìåòðû ñàìîãî áîëüøîãî îòêðûòîãî îðäåðà
//         {    selllot=OrderLots();       
//              sellprice=OrderOpenPrice();       
//              st=OrderTicket(); 
//              sellsl=OrderStopLoss(); 
//              selltp=OrderTakeProfit(); 
//         }      
//      }     
//    
//    if (mode==OP_SELLSTOP )   {       sellstoplot=OrderLots();   sellstopprice=OrderOpenPrice();   sst=OrderTicket();  }     
//    if (mode==OP_SELLLIMIT )  {       selllimitlot=OrderLots();  selllimitprice=OrderOpenPrice();  slt=OrderTicket();  }     
//    
//    }   
//    
//if (selllot>=Lots) // åñëè öåíà ïîøëà âíèç
//  {   
//  if (bst>0) {OrderDelete(bst);      return(0);    }
//  
//  if (sellstopprice==0  && LotLim>MathRound(c10*selllot*mul)/c10) {
//  ticket=OrderSend(Symbol(),OP_SELLSTOP,MathRound(c10*selllot*mul)/c10,sellprice-netstep*Point,3,sellprice-netstep*Point+sl*Point,sellprice-netstep*Point-tp*Point,"STOPLIMIT",0,0,Green);         return(0);}
//  }
//  
//if (buylot>=Lots) // åñëè öåíà ïîøëà ââåðõ
//  {   
//
//  if (sst>0) {OrderDelete(sst);      return(0);    }  
//
//  if (buystopprice==0 && LotLim>MathRound(c10*buylot*mul)/c10) {
//  ticket=OrderSend(Symbol(),OP_BUYSTOP,MathRound(c10*buylot*mul)/c10,buyprice+netstep*Point,3,buyprice+netstep*Point-sl*Point,buyprice+netstep*Point+tp*Point,"BUYSTOP",0,0,Green);               return(0);}
//
//  }
//
//if (buylot!=0 || selllot!=0) // êîíòðîëèðóåì îòêðûòûå ïîçèöèè
//  {
//double tp1,sl1;
//
//  for(cnt=0;cnt<OrdersTotal();cnt++)    // ïîñëå òîãî êàê áûë ìîäèôèöèðîâàí ñàìûé áîëüøîé îðäåð, íàäî áîëåå ìåëêèå ïîäòàñêèâàòü ê ñòîïó è ïðîôèòó áîëüøîãî
//    {
//    OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
//    mode = OrderType(); tp1=OrderTakeProfit();sl1=OrderStopLoss();
//    if (mode==OP_BUY) 
//      {
//      if (buytp>tp1 || buysl>sl1 ) 
//        {
//        OrderModify(OrderTicket(),OrderOpenPrice(),buysl,buytp,0,Purple);return(0);
//        }        
//      }     
//    if (mode==OP_SELL) 
//      {
//      if (selltp<tp1 || sellsl<sl1 ) 
//        {        
//        OrderModify(OrderTicket(),OrderOpenPrice(),sellsl,selltp,0,Purple);return(0);
//        
//        }        
//      } 
//    
//    }
//      
//  oldtr=TrailingStop;
//  if (LotLim<MathRound(c10*selllot*mul)/c10 || LotLim<MathRound(c10*buylot*mul)/c10) // ëîñòèãíóò ëèìèò êîëè÷åñòâà îòêðûâàåìûõ ñäåëîê, íàäî òàùèòü ñòîï è ïðîôèò
//    {     
//    if(TrailingStop>0)
//      {
//         if (usema==1) 
//         {
//          double oldts=TrailingStop;
//          double ma=iMA(NULL,0,MovingPeriod,MovingShift,MODE_SMA,PRICE_CLOSE,0);
//             if (buylot>0 && Ask<ma){TrailingStop=MathRound(TrailingStop/2);}
//             if (selllot>0 && Bid>ma){TrailingStop=MathRound(TrailingStop/2);}
//             Print(Ask,"   ",ma,"   ",TrailingStop,"   ",buylot,"   ",selllot,"   ");
//         }
//         
//         if (bezub==1) 
//         {
//           if (buyprice<(Ask+deltalast*Point)) 
//             {
//              OrderModify(bt,buyprice,nulfunc(),buytp,0,Green);return(0);   
//             }
//           if (sellprice>(Bid-deltalast*Point)) 
//             {              
//              OrderModify(st,sellprice,nulfunc(),selltp,0,Green);return(0);                 
//             }             
//         }      
//      
//      if(buysl>0)
//        {
//        if(High[0]-buysl>TrailingStop*Point+1*Point) // +1 - ÷òîáû íå áûëî ERR_NO_RESULT 1 OrderModify ïûòàåòñÿ èçìåíèòü óæå óñòàíîâëåííûå çíà÷åíèÿ òàêèìè æå çíà÷åíèÿìè.
//          {   
//            if (trailprofit==1) 
//            {
//            //Print(Ask,"   ",bt,"   ",buyprice,"   ",High[0]-TrailingStop*Point,"   ",buytp);
//            OrderModify(bt,buyprice,High[0]-TrailingStop*Point,High[0]+tp*Point,0,Green);return(0);               
//            }else
//            {
//            OrderModify(bt,buyprice,High[0]-TrailingStop*Point,buytp,0,Green);return(0);
//            }
//          }   
//        }   
//        if(sellsl>0)
//        {
//        if(sellsl-Low[0]>TrailingStop*Point+1*Point)
//          {
//          //Print(Ask,"   ",st,"   ",sellprice,"   ",Low[0]+TrailingStop*Point,"   ",selltp);
//            if (trailprofit==1) 
//            {
//            OrderModify(st,sellprice,Low[0]+TrailingStop*Point,Low[0]-tp*Point,0,Green);return(0);
//            
//            } else 
//            {          
//            OrderModify(st,sellprice,Low[0]+TrailingStop*Point,selltp,0,Green);return(0);
//            
//            }
//          }   
//        }       
//                     
//      }//if(TrailingStop>0)
//    
//    }//if (LotLim<MathRound(c10*selllot*mul)/c10 || LotLim<MathRound(c10*buylot*mul)/c10) 
//  
//  } // if (buylot!=0 || selllot!=0)
//  
//  if (buylot==selllot && buylot==0) // êîãäà âñå ñðàáîòàëî, íî âèñèò îòëîæåííûé
//  {
//  if (bst>0 && buystoplot!=Lots) {OrderDelete(bst);      return(0);    }
//  if (slt>0 && selllimitlot!=Lots) {OrderDelete(slt);      return(0);    }
//  if (blt>0 && buylimitlot!=Lots) {OrderDelete(blt);      return(0);    }
//  if (sst>0 && sellstoplot!=Lots) {OrderDelete(sst);      return(0);    }            
//  } 
//
//  
//} //if (OrdersTotal()>0)


 
//----
   return(0);
  }
//+------------------------------------------------------------------+


double nulfunc() // äëÿ ïîäñ÷åòà òî÷êè áåçóáûòî÷íîñòè âñåõ îòêðûòûõ îðäåðîâ (åñëè âñå èõ çàêðûòü ïî ýòîé öåíå òî ïîëó÷èì 0)
  {
    double np=0;double f=0; double p=0;double l=0; int m=0;
    for(int t1=0;t1<OrdersTotal();t1++)    
    {
    OrderSelect(t1, SELECT_BY_POS, MODE_TRADES); 
    m = OrderType();p=OrderOpenPrice();l=OrderLots();
    if  (m==OP_BUY || m==OP_SELL) 
      {
      np=np+l*p;  
      f=f+l;
      }
    }
    np=np/f;
    np=MathCeil(np*c20)/c20;
    Print(np);  
   return (np);
  }