//+------------------------------------------------------------------+
//|                                                    Chemp2008.mq4 |
//|                                        Copyright © 2008, solandr |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2007, solandr"
#property link      "http://"

//---- Ñïèñîê âàëþòíûõ ïàð, íà êîòîðûõ èãðàåì, ðàçäåë¸ííûé çàïÿòîé (",")
string ChartList[]={"USDCHF","GBPUSD","EURUSD","USDJPY","USDCAD","AUDUSD","EURGBP","EURAUD","EURCHF","EURJPY","GBPJPY","GBPCHF"};
double ChartList_value[1];
double ChartList_value_real[1];
int ChartList_active[1];
double delta=0.01;
int limit_chart=0;
double v=0.1;
bool var_v_PERMITION=true;
double k_v=0.03;
bool TRADE_PERMITION=true;
input double stoploss=150;
input double takeprofit=150;
//---- Ñïèñîê âàëþòíûõ ïàð, ïî êîòîðûì âåä¸ì ðàñ÷¸ò îòíîøåíèé ÷åðåç USD
string ChartHistoryList[]={"USDCHF","GBPUSD","EURUSD","USDJPY","USDCAD","AUDUSD"};
double pips=0;
int pips_profit=100;

string symbol_for_trade="";
string sym1="",sym2="";
double sym1_value=0,sym2_value=0;
datetime old_bar=0;
int magic_chemp=27777777;
int q1=0,q2=0,q3=0,q_total=0;
int number1=-1,number2=-1,number3=-1;
double equity=0;

//Êëàñòåð
int MA_Method = 3;
int Price = 6;
int Fast = 3;
int Slow = 5;

//----
double arrUSD[1];
double arrEUR[1];
double arrGBP[1];
double arrCHF[1];
double arrJPY[1];
double arrAUD[1];
double arrCAD[1];

bool flag_date=true;

//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----
   Print("Çàãðóçèëèñü. Æä¸ì 10 ñåêóíä äî íà÷àëà ðàáîòû.");
   Sleep(10000);//Ïàóçà 10 ñåêóíä ïðè ñòàðòå
   Print("Íà÷èíàåì ðàáîòàòü!");
   start();
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
   
   //Ýêñïåðò ðàáîòàåò òîëüêî â íà÷àëå êàæäîãî áàðà Ì30
   if(iTime(Symbol(),PERIOD_M30,0)==old_bar) return(0);
   
   if(Hour()==0 && flag_date) {Print("Ñîâåòíèê ðàáîòàåò! (12 âàëþòíûõ ïàð)"); flag_date=false;}
   if(Hour()==10) flag_date=true;
   
   int i,k;
   
   if(IsTesting())
   {  
      bool flag_sym=true;
      for(i=0;i<ArraySize(ChartList);i++)
      {
         if(Symbol()==ChartList[i]) flag_sym=false;
      }
   }
   //if(flag_sym) {Print("Íà ýòîì ñèìâîëå òåñòèðîâàíèå íåâîçìîæíî! Âûáåðèòå äðóãîé èíñòðóìåíò."); return(0);}
   
   if(var_v_PERMITION && AccountBalance()*k_v<5000) v=NormalizeDouble(AccountBalance()*k_v/1000,1);
   if(var_v_PERMITION && AccountBalance()*k_v>=5000) v=5;
   if(v<0.1) v=0.1;
   
   
   int limit_his=ArraySize(ChartHistoryList);
   bool flag=true;
   
   //Ïðîâåðêà íàëè÷èÿ êîòèðîâîê
   if(!IsTesting())
   {
      for(i=0;i<limit_his;i++)
      {
         symbol_for_trade=ChartHistoryList[i];//Âûáèðàåì èíñòðóìåíò èç ñïèñêà
         while(flag)
         {  
            flag=false;
            for(k=0;k<7;k++)
            {
               if(iClose(symbol_for_trade,1,k)<0.0001) flag=true;
               if(iClose(symbol_for_trade,5,k)<0.0001) flag=true;
               if(iClose(symbol_for_trade,15,k)<0.0001) flag=true;
               if(iClose(symbol_for_trade,30,k)<0.0001) flag=true;
               if(iClose(symbol_for_trade,60,k)<0.0001) flag=true;
               if(iClose(symbol_for_trade,240,k)<0.0001) flag=true;
               if(iClose(symbol_for_trade,1440,k)<0.0001) flag=true;
               if(iClose(symbol_for_trade,10080,k)<0.0001) flag=true;
               if(iClose(symbol_for_trade,43200,k)<0.0001) flag=true;
            }
            if(flag) {Print("Ïðîáëåìû ñ èñòîðèåé êîòèðîâîê íà ",symbol_for_trade,". Æä¸ì 1 ìèíóòó");Sleep(60000);RefreshRates();}
         }
      }
   }
   
   //Ïðîâîäèì ðàñ÷¸ò òåêóùèõ çíà÷åíèé âàëþò
   claster_all();
   limit_chart=ArraySize(ChartList);
   ArrayResize(ChartList_value,limit_chart);
   ArrayResize(ChartList_value_real,limit_chart);
   //Îïðåäåëÿåì çíà÷åíèÿ êàæäîé âàëþòíîé ïàðû
   for(i=0;i<limit_chart;i++)
   {
      symbol_for_trade=ChartList[i];
      sym1=StringSubstr(symbol_for_trade,0,3);
      sym2=StringSubstr(symbol_for_trade,3,3);

      sym1_value=0;
      if(sym1=="EUR") sym1_value=arrEUR[0];
         else if(sym1=="USD") sym1_value=arrUSD[0];
            else if(sym1=="GBP") sym1_value=arrGBP[0];
               else if(sym1=="JPY") sym1_value=arrJPY[0];
                  else if(sym1=="CHF") sym1_value=arrCHF[0];
                     else if(sym1=="AUD") sym1_value=arrAUD[0];
                        else if(sym1=="CAD") sym1_value=arrCAD[0];
                                                                           
      sym2_value=0;
      if(sym2=="EUR") sym2_value=arrEUR[0];
         else if(sym2=="USD") sym2_value=arrUSD[0];
            else if(sym2=="GBP") sym2_value=arrGBP[0];
               else if(sym2=="JPY") sym2_value=arrJPY[0];
                  else if(sym2=="CHF") sym2_value=arrCHF[0];
                     else if(sym2=="AUD") sym2_value=arrAUD[0];
                        else if(sym2=="CAD") sym2_value=arrCAD[0]; 
                           
      if(MathAbs(sym1_value)<0.0001 && MathAbs(sym2_value)<0.0001) Print("Ïðîáëåìû ñ îïðåäåëåíèåì çíà÷åíèé äëÿ ïàðû ",symbol_for_trade);                       
      else 
      {
         ChartList_value[i]=MathAbs(sym1_value-sym2_value);
         ChartList_value_real[i]=sym1_value-sym2_value;
      }
   }
   
   ArrayResize(ChartList_active,limit_chart);
   for(i=0;i<limit_his;i++) ChartList_active[i]=0;
   double max=0;
   //Íàõîäèì 3 ïàðû ñ ìàêñèìàëüíûì çíà÷åíèåì
   for(i=0;i<limit_chart;i++)
   {
      if(ChartList_value[i]>max) {max=ChartList_value[i]; number1=i;}
   }
   if(!IsTesting())
   {
      max=0;
      for(i=0;i<limit_chart;i++)
      {  
         if(i==number1) continue;
         if(ChartList_value[i]>max) {max=ChartList_value[i]; number2=i;}
      }   
      max=0;
      for(i=0;i<limit_chart;i++)
      {  
         if(i==number1 || i==number2) continue;
         if(ChartList_value[i]>max) {max=ChartList_value[i]; number3=i;}
      }
   }      
   
   //Ïîäñ÷¸ò îðäåðîâ
   for(i=0;i<2;i++)//ñ÷èòàåì 2 ðàçà äëÿ íàä¸æíîñòè ñðàáàòûâàíèÿ íåîáõîäèìîãî çàêðûòèÿ îðäåðîâ
   {
      q1=0;q2=0;q3=0;q_total=0;
      equity=0;
      q_total=quantity_chemp(magic_chemp);
   }
   
   //Ïðîèçâîäèì îòêðûòèå îðäåðîâ 
   if(((q_total<3 && !IsTesting()) || (IsTesting() && q_total==0 && ChartList[number1]==Symbol())) && TRADE_PERMITION)
   {
      q_total=quantity_chemp(magic_chemp);
      if(q_total<3 && q1==0 && ChartList_value[number1]>delta)
      {
         if(ChartList_value_real[number1]>0)
         {
            Print("Îòêðûòèå îðäåðà BUY â ïàðå ", ChartList[number1]);
            RefreshRates();
            OrderSend(ChartList[number1],OP_BUY,NormalizeDouble(v,1),NormalizeDouble(MarketInfo(ChartList[number1],MODE_ASK),MarketInfo(ChartList[number1],MODE_DIGITS)),6,MarketInfo(ChartList[number1],MODE_ASK)-stoploss*10*Point(),MarketInfo(ChartList[number1],MODE_ASK)+takeprofit*10*Point(),"BUY_chemp2",magic_chemp,0);
            Sleep(60000);RefreshRates();
         }
         if(ChartList_value_real[number1]<0)
         {
            Print("Îòêðûòèå îðäåðà SELL â ïàðå ", ChartList[number1]);
            RefreshRates();
            OrderSend(ChartList[number1],OP_SELL,NormalizeDouble(v,1),NormalizeDouble(MarketInfo(ChartList[number1],MODE_BID),MarketInfo(ChartList[number1],MODE_DIGITS)),6,MarketInfo(ChartList[number1],MODE_BID)+stoploss*10*Point(),MarketInfo(ChartList[number1],MODE_BID)-takeprofit*10*Point(),"SELL_chemp2",magic_chemp,0);
            Sleep(60000);RefreshRates();
         }        
      }
         
      q_total=quantity_chemp(magic_chemp);         
      if(q_total<3 && q2==0 && ChartList_value[number2]>delta && !IsTesting())
      {
         if(ChartList_value_real[number2]>0)
         {
            Print("Îòêðûòèå îðäåðà BUY â ïàðå ", ChartList[number2]);
            RefreshRates();
            OrderSend(ChartList[number2],OP_BUY,NormalizeDouble(v,1),NormalizeDouble(MarketInfo(ChartList[number2],MODE_ASK),MarketInfo(ChartList[number2],MODE_DIGITS)),6,MarketInfo(ChartList[number2],MODE_ASK)-stoploss*10*Point(),MarketInfo(ChartList[number2],MODE_ASK)+takeprofit*10*Point(),"BUY_chemp2",magic_chemp,0);
            Sleep(60000);RefreshRates();
         }
         if(ChartList_value_real[number2]<0)
         {
            Print("Îòêðûòèå îðäåðà SELL â ïàðå ", ChartList[number2]);
            RefreshRates();
            OrderSend(ChartList[number2],OP_SELL,NormalizeDouble(v,1),NormalizeDouble(MarketInfo(ChartList[number2],MODE_BID),MarketInfo(ChartList[number2],MODE_DIGITS)),6,MarketInfo(ChartList[number2],MODE_BID)+stoploss*10*Point(),MarketInfo(ChartList[number2],MODE_BID)-takeprofit*10*Point(),"SELL_chemp2",magic_chemp,0);
            Sleep(60000);RefreshRates();
         }    
      }   
      
      q_total=quantity_chemp(magic_chemp);               
      if(q_total<3 && q3==0 && ChartList_value[number3]>delta && !IsTesting())
      {
         if(ChartList_value_real[number3]>0)
         {
            Print("Îòêðûòèå îðäåðà BUY â ïàðå ", ChartList[number3]);
            RefreshRates();
            OrderSend(ChartList[number3],OP_BUY,NormalizeDouble(v,1),NormalizeDouble(MarketInfo(ChartList[number3],MODE_ASK),MarketInfo(ChartList[number3],MODE_DIGITS)),6,MarketInfo(ChartList[number3],MODE_ASK)-stoploss*10*Point(),MarketInfo(ChartList[number3],MODE_ASK)+takeprofit*10*Point(),"BUY_chemp2",magic_chemp,0);
            Sleep(60000);RefreshRates();
         }
         if(ChartList_value_real[number3]<0)
         {
            Print("Îòêðûòèå îðäåðà SELL â ïàðå ", ChartList[number3]);
            RefreshRates();
            OrderSend(ChartList[number3],OP_SELL,NormalizeDouble(v,1),NormalizeDouble(MarketInfo(ChartList[number3],MODE_BID),MarketInfo(ChartList[number3],MODE_DIGITS)),6,MarketInfo(ChartList[number3],MODE_BID)+stoploss*10*Point(),MarketInfo(ChartList[number3],MODE_BID)-takeprofit*10*Point(),"SELL_chemp2",magic_chemp,0);
            Sleep(60000);RefreshRates();
         }                    
      }
   }
//----
   //Äåëàåì ïîâòîðíûé ïåðåñ÷¸ò îðäåðîâ è îáùåé ïðèáûëè ïî íèì
   q1=0;q2=0;q3=0;q_total=0;
   equity=0;
   pips=0;
   q_total=quantity_chemp(magic_chemp);
  
  
   q1=0;q2=0;q3=0;q_total=0;
   equity=0;
   pips=0;
   q_total=quantity_chemp(magic_chemp);
   string comment_string="";
   comment_string=StringConcatenate("Ïðèáûëü = ",DoubleToStr(equity,2),"\nÏèïñû = ",DoubleToStr(pips,0),"\n",ChartList[number1]," = ",q1,"\n",ChartList[number2]," = ",q2,"\n",ChartList[number3]," = ",q3);
   Comment(comment_string);
   old_bar=iTime(Symbol(),PERIOD_M30,0);
   return(0);
  }
//+------------------------------------------------------------------+

bool claster_all()
  {
     //---- îñíîâíîé öèêë
     int i=0;
     {
       // Ïðåäâàðèòåëüíûé ðàñ÷¸ò
       double I_EURUSD=0,I_GBPUSD=0,I_AUDUSD=0,I_USDCAD=0,I_USDCHF=0,I_USDJPY=0;

           double EURUSD_Fast = ma("EURUSD", Fast, MA_Method, Price, i);
           double EURUSD_Slow = ma("EURUSD", Slow, MA_Method, Price, i);
           Sleep(200);
           if(EURUSD_Fast>0.0001 && EURUSD_Slow>0.0001) I_EURUSD=EURUSD_Fast/EURUSD_Slow;
           else {Print("Îøèáêà â îïðåäåëåíèè èíäåêñà I_EURUSD (Äåëåíèå íà íîëü)");return(0);}


           double GBPUSD_Fast = ma("GBPUSD", Fast, MA_Method, Price, i);
           double GBPUSD_Slow = ma("GBPUSD", Slow, MA_Method, Price, i);
           Sleep(200);
           if(GBPUSD_Fast>0.0001 && GBPUSD_Slow>0.0001) I_GBPUSD=GBPUSD_Fast/GBPUSD_Slow;
           else {Print("Îøèáêà â îïðåäåëåíèè èíäåêñà I_GBPUSD (Äåëåíèå íà íîëü)");return(0);}
           

           double AUDUSD_Fast = ma("AUDUSD", Fast, MA_Method, Price, i);
           double AUDUSD_Slow = ma("AUDUSD", Slow, MA_Method, Price, i);
           Sleep(200);
           if(AUDUSD_Fast>0.0001 && AUDUSD_Slow>0.0001) I_AUDUSD=AUDUSD_Fast/AUDUSD_Slow;
           else {Print("Îøèáêà â îïðåäåëåíèè èíäåêñà I_AUDUSD (Äåëåíèå íà íîëü)");return(0);}


           double USDCAD_Fast = ma("USDCAD", Fast, MA_Method, Price, i);
           double USDCAD_Slow = ma("USDCAD", Slow, MA_Method, Price, i);
           Sleep(200);
           if(USDCAD_Fast>0.0001 && USDCAD_Slow>0.0001) I_USDCAD=USDCAD_Fast/USDCAD_Slow;
           else {Print("Îøèáêà â îïðåäåëåíèè èíäåêñà I_USDCAD (Äåëåíèå íà íîëü)");return(0);}


           double USDCHF_Fast = ma("USDCHF", Fast, MA_Method, Price, i);
           double USDCHF_Slow = ma("USDCHF", Slow, MA_Method, Price, i);
           Sleep(200);
           if(USDCHF_Fast>0.0001 && USDCHF_Slow>0.0001) I_USDCHF=USDCHF_Fast/USDCHF_Slow;
           else {Print("Îøèáêà â îïðåäåëåíèè èíäåêñà I_USDCHF (Äåëåíèå íà íîëü)");return(0);}


           double USDJPY_Fast = ma("USDJPY", Fast, MA_Method, Price, i);
           double USDJPY_Slow = ma("USDJPY", Slow, MA_Method, Price, i);
           Sleep(200);
           if(USDJPY_Fast>0.01 && USDJPY_Slow>0.01) I_USDJPY=USDJPY_Fast/USDJPY_Slow;
           else {Print("Îøèáêà â îïðåäåëåíèè èíäåêñà I_USDJPY (Äåëåíèå íà íîëü)");return(0);}

       // ðàñ÷¸ò âàëþò
       
           arrUSD[i]= 0;
           arrUSD[i]+=1/I_EURUSD-1;//EUR
           arrUSD[i]+=1/I_GBPUSD-1;//GBP
           arrUSD[i]+=1/I_AUDUSD-1;//AUD
           arrUSD[i]+=I_USDCAD-1;//CAD
           arrUSD[i]+=I_USDCHF-1;//CHF
           arrUSD[i]+=I_USDJPY-1;//JPY
           
       
           arrEUR[i]=0;
           arrEUR[i]+=I_EURUSD-1;//EUR
           arrEUR[i]+=I_EURUSD/I_GBPUSD-1;//GBP
           arrEUR[i]+=I_EURUSD/I_AUDUSD-1;//AUD
           arrEUR[i]+=I_EURUSD*I_USDCAD-1;//CAD
           arrEUR[i]+=I_EURUSD*I_USDCHF-1;//CHF
           arrEUR[i]+=I_EURUSD*I_USDJPY-1;//JPY
        
           arrGBP[i]=0;
           arrGBP[i]+=I_GBPUSD/I_EURUSD-1;//EUR
           arrGBP[i]+=I_GBPUSD-1;//GBP
           arrGBP[i]+=I_GBPUSD/I_AUDUSD-1;//AUD
           arrGBP[i]+=I_GBPUSD*I_USDCAD-1;//CAD
           arrGBP[i]+=I_GBPUSD*I_USDCHF-1;//CHF
           arrGBP[i]+=I_GBPUSD*I_USDJPY-1;//JPY
           
           arrAUD[i]=0;
           arrAUD[i]+=I_AUDUSD/I_EURUSD-1;//EUR
           arrAUD[i]+=I_AUDUSD/I_GBPUSD-1;//GBP
           arrAUD[i]+=I_AUDUSD-1;//AUD
           arrAUD[i]+=I_AUDUSD*I_USDCAD-1;//CAD
           arrAUD[i]+=I_AUDUSD*I_USDCHF-1;//CHF
           arrAUD[i]+=I_AUDUSD*I_USDJPY-1;//JPY
           
          
           arrCAD[i]=0;
           arrCAD[i]+=1/(I_USDCAD*I_EURUSD)-1;//EUR
           arrCAD[i]+=1/(I_USDCAD*I_GBPUSD)-1;//GBP
           arrCAD[i]+=1/(I_USDCAD*I_AUDUSD)-1;//AUD
           arrCAD[i]+=1/I_USDCAD-1;//CAD
           arrCAD[i]+=I_USDCHF/I_USDCAD-1;//CHF
           arrCAD[i]+=I_USDJPY/I_USDCAD-1;//JPY
             
           arrCHF[i]=0;
           arrCHF[i]+=1/(I_USDCHF*I_EURUSD)-1;//EUR
           arrCHF[i]+=1/(I_USDCHF*I_GBPUSD)-1;//GBP
           arrCHF[i]+=1/(I_USDCHF*I_AUDUSD)-1;//AUD
           arrCHF[i]+=I_USDCAD/I_USDCHF-1;//CAD
           arrCHF[i]+=1/I_USDCHF-1;//CHF
           arrCHF[i]+=I_USDJPY/I_USDCHF-1;//JPY
            
           arrJPY[i]=0;
           arrJPY[i]+=1/(I_USDJPY*I_EURUSD)-1;//EUR
           arrJPY[i]+=1/(I_USDJPY*I_GBPUSD)-1;//GBP
           arrJPY[i]+=1/(I_USDJPY*I_AUDUSD)-1;//AUD
           arrJPY[i]+=I_USDCAD/I_USDJPY-1;//CAD
           arrJPY[i]+=I_USDCHF/I_USDJPY-1;//CHF
           arrJPY[i]+=1/I_USDJPY-1;//JPY
                 
     }//end block for(int i=0; i<limit; i++)
//----

   return(true);
  }

//+------------------------------------------------------------------+
//|  Subroutines                                                     |
//+------------------------------------------------------------------+
double ma(string sym, int per, int Mode, int Price, int i)
  {
   double res = 0;
   int k = 1;
   int ma_shift = 0;
   int tf = 0;
   int bar=i+1;
   int x=30;
   if(per==3)
   {
   switch(x)
     {
    
       case 1:     res += iClose(sym,PERIOD_M1,bar); bar=iBarShift(sym,PERIOD_M5,iTime(sym,PERIOD_M1,bar));
                   
       case 5:     res += iClose(sym,PERIOD_M5,bar); bar=iBarShift(sym,PERIOD_M15,iTime(sym,PERIOD_M5,bar));
                   
       case 15:    res += iClose(sym,PERIOD_M15,bar); bar=iBarShift(sym,PERIOD_M30,iTime(sym,PERIOD_M15,bar));
                   
       case 30:    res += iClose(sym,PERIOD_M30,bar); bar=iBarShift(sym,PERIOD_H1,iTime(sym,PERIOD_M30,bar));
                  
       case 60:    res += iClose(sym,PERIOD_H1,bar); bar=iBarShift(sym,PERIOD_H4,iTime(sym,PERIOD_H1,bar));
                  
       case 240:   res += iClose(sym,PERIOD_H4,bar); bar=iBarShift(sym,PERIOD_D1,iTime(sym,PERIOD_H4,bar)); 
                  
       case 1440:  res += iClose(sym,PERIOD_D1,bar); bar=iBarShift(sym,PERIOD_W1,iTime(sym,PERIOD_D1,bar)); 
                  
       case 10080: res += iClose(sym,PERIOD_W1,bar);  bar=iBarShift(sym,PERIOD_MN1,iTime(sym,PERIOD_W1,bar));
                  
       case 43200: res += iClose(sym,PERIOD_MN1,bar);

     } 
   }
   
   bar=i+1;
   
   if(per==5)
   {
   switch(x)
     {
     
       case 1:     res += (iOpen(sym,PERIOD_M1,bar)+iClose(sym,PERIOD_M1,bar)+iHigh(sym,PERIOD_M1,bar)+iLow(sym,PERIOD_M1,bar))/4; bar=iBarShift(sym,PERIOD_M5,iTime(sym,PERIOD_M1,bar))+1;
                  
       case 5:     res += (iOpen(sym,PERIOD_M5,bar)+iClose(sym,PERIOD_M5,bar)+iHigh(sym,PERIOD_M5,bar)+iLow(sym,PERIOD_M5,bar))/4; bar=iBarShift(sym,PERIOD_M15,iTime(sym,PERIOD_M5,bar))+1;
                  
       case 15:    res += (iOpen(sym,PERIOD_M15,bar)+iClose(sym,PERIOD_M15,bar)+iHigh(sym,PERIOD_M15,bar)+iLow(sym,PERIOD_M15,bar))/4; bar=iBarShift(sym,PERIOD_M30,iTime(sym,PERIOD_M15,bar))+1;
                  
       case 30:    res += (iOpen(sym,PERIOD_M30,bar)+iClose(sym,PERIOD_M30,bar)+iHigh(sym,PERIOD_M30,bar)+iLow(sym,PERIOD_M30,bar))/4; bar=iBarShift(sym,PERIOD_H1,iTime(sym,PERIOD_M30,bar))+1;
                   
       case 60:    res += (iOpen(sym,PERIOD_H1,bar)+iClose(sym,PERIOD_H1,bar)+iHigh(sym,PERIOD_H1,bar)+iLow(sym,PERIOD_H1,bar))/4; bar=iBarShift(sym,PERIOD_H4,iTime(sym,PERIOD_H1,bar))+1;
                   
       case 240:   res += (iOpen(sym,PERIOD_H4,bar)+iClose(sym,PERIOD_H4,bar)+iHigh(sym,PERIOD_H4,bar)+iLow(sym,PERIOD_H4,bar))/4; bar=iBarShift(sym,PERIOD_D1,iTime(sym,PERIOD_H4,bar))+1; 
                  
       case 1440:  res += (iOpen(sym,PERIOD_D1,bar)+iClose(sym,PERIOD_D1,bar)+iHigh(sym,PERIOD_D1,bar)+iLow(sym,PERIOD_D1,bar))/4; bar=iBarShift(sym,PERIOD_W1,iTime(sym,PERIOD_D1,bar))+1; 
                   
       case 10080: res += (iOpen(sym,PERIOD_W1,0)+iClose(sym,PERIOD_W1,bar)+iHigh(sym,PERIOD_W1,bar)+iLow(sym,PERIOD_W1,bar))/4;  bar=iBarShift(sym,PERIOD_MN1,iTime(sym,PERIOD_W1,bar))+1;
                  
       case 43200: res += (iOpen(sym,PERIOD_MN1,0)+iClose(sym,PERIOD_MN1,bar)+iHigh(sym,PERIOD_MN1,bar)+iLow(sym,PERIOD_MN1,bar))/4;

     } 
   }
   return(res);
  }  
    
int quantity_chemp(int MN)
{
   int ticket,count=0,i;
      
   for(ticket=0;ticket<OrdersTotal();ticket++)
   {//âíóòðåííèé for
      if (OrderSelect(ticket,SELECT_BY_POS,MODE_TRADES)==false) break;
      else
      {//íà÷àëî else
         if (OrderMagicNumber()==MN) 
         {
            count++;   
            equity=equity+OrderProfit()+OrderSwap();   
            if(OrderType()==OP_SELL && MarketInfo(OrderSymbol(),MODE_POINT)>0) pips=pips+(OrderOpenPrice()-MarketInfo(OrderSymbol(),MODE_ASK))/MarketInfo(OrderSymbol(),MODE_POINT);
            if(OrderType()==OP_BUY && MarketInfo(OrderSymbol(),MODE_POINT)>0) pips=pips+(MarketInfo(OrderSymbol(),MODE_BID)-OrderOpenPrice())/MarketInfo(OrderSymbol(),MODE_POINT);
            if(OrderSymbol()==ChartList[number1]) q1++;
            if(OrderSymbol()==ChartList[number2]) q2++;
            if(OrderSymbol()==ChartList[number3]) q3++;
           
          
         }

      }//êîíåö else
   }//âíóòðåííèé for
   return(count);
}    

//Ôóíêöèÿ çàêðûòèÿ âñåõ îðäåðîâ
int Close_All(int MN)
{
   int ticket;
   
   for(ticket=0;ticket<OrdersTotal();ticket++)
   {//âíóòðåííèé for
      if (OrderSelect(ticket,SELECT_BY_POS,MODE_TRADES)==false) break;
      else
      {//íà÷àëî else
         if (OrderMagicNumber()==MN) 
         {
   
            if(OrderType()==OP_SELL) {RefreshRates();Print("Çàêðûòèå îðäåðà SELL â ñâÿçè ñ äîñòèæåíèåì çàäàííîé îáùåé ïðèáûëè");OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),5); Sleep(30000);RefreshRates();}
            if(OrderType()==OP_BUY) {RefreshRates();Print("Çàêðûòèå îðäåðà SELL â ñâÿçè ñ äîñòèæåíèåì çàäàííîé îáùåé ïðèáûëè");OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),5); Sleep(30000);RefreshRates();}
           
         }

      }//êîíåö else
   }//âíóòðåííèé for
   return(0);
}