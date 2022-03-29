//+------------------------------------------------------------------+
//|                                           CCI Multipair . v1.mq5 |
//|                                    Copyright 2021,Yousuf Mesalm. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021,Yousuf Mesalm"
#property link "https://www.mql5.com"
#property version "1.00"

#include  <MQL_Easy\Execute\Execute.mqh>
#include  <MQL_Easy\Position\Position.mqh>
#include <Indicators\Oscilators.mqh>
#include <ChartObjects\ChartObjectsLines.mqh>
#include <ChartObjects\ChartObjectsTxtControls.mqh>
#include <Arrays\ArrayString.mqh>
#include <Arrays\ArrayObj.mqh>
#include  <TradeState.mqh>
//Enumuration
enum entry
  {
   buy,
   sell,
   buyAndsell,
   none,
  };


// inputs



sinput string set1 = "Trading Settings";
input long magic_Number = 2020;
input string comment="EA";
input entry EntryType=buy;
input entry MartingleType=buy;
input bool useMoneyManagment=true;
input double lot= 0.1; // Lot for every 1000
input double LotMultipiler=1.5;
input int MultipilerStep=15;
input int trailingStop=50;  //trailing stop for Profit trades
sinput string set2 = "Currency Pairs Settings";
input string Suffix="";
input string Perfix="";
input string Pair1 = "EURUSD";
input string Pair2 = "USDCHF";
input string Pair3 = "USDCAD";
input string Pair4 = "USDJPY";
input string Pair5 = "GBPUSD";
input string Pair6 = "";
input string Pair7 = "";
input string Pair8 = "";
input string Pair9 = "";
input string Pair10 = "";
input string Pair11 = "";
input string Pair12 = "";
input string Pair13 = "";
input string Pair14 = "";
input string Pair15 = "";
input string Pair16 = "";
input string Pair17 = "";
input string Pair18 = "";
input string Pair19 = "";
input string Pair20 = "";
input string Pair21 = "";
input string Pair22 = "";
input string Pair23 = "";
input string Pair24 = "";
input string Pair25 = "";
input string Pair26 = "";
input string Pair27 = "";
input string Pair28 = "";
input string Pair29 = "";
input string Pair30 = "";
input string    Close_Pips_SetUP = "------< Close_Pips_SetUP >------";
input bool use_close_per_symbol_pip=true;
input int closeTP_buy_in_pips_eachpair=50;
input int closeTP_sell_in_pips_eachpair=50;
input int closeTP_all_in_pips_eachpair=50;
input int closeSL_buy_in_pips_eachpair=-50;
input int closeSL_sell_in_pips_eachpair=-50;
input int closeSL_all_in_pips_eachpair=-50;
input string    Close_USD_SetUP = "------< Close_USD_SetUP >------";
input bool use_close_per_symbol_usd=true;
input int closeTP_buy_in_USD_eachpair=50;
input int closeTP_sell_in_USD_eachpair=50;
input int closeTP_all_in_USD_eachpair=50;
input int closeSL_buy_in_USD_eachpair=-50;
input int closeSL_sell_in_USD_eachpair=-50;
input int closeSL_All_in_USD_eachpair=-50;
input string    Close_Account_SetUP = "------< Close_Account_SetUP >------";
input bool use_close_per_account_usd=true;
input int closeTP_in_USD_All_account=50;
input int closeSL_in_USD_All_account=-50;
input int MAX_Pair_Number =5;
input bool ShowPanel=false;
// indicator
sinput string Set2="------<Indicator settings >------";
input int Mperiod=40;
input ENUM_APPLIED_PRICE Applied =PRICE_CLOSE;
input int First_level_Positive=100;
input int Seconed_level_Positive=120;
input int First_level_Negative=-100;
input int Seconed_level_Negative=-120;
input string    Time_SetUP = "------< Time_SetUP >------";
input bool UseTimeFilter=false;
input string   TimeStart="12:00";
input string   TimeStop="14:00";
extern string       Trade_Day_SetUP                    = "------< Trade_Day_SetUP >------";
extern bool         Trade_sunday                       = true;
extern bool         Trade_monday                       = true;
extern bool         Trade_tuseday                      = true;
extern bool         Trade_wednisday                    = true;
extern bool         Trade_Thursday                     = true;
extern bool         Trade_friday                       = true;
//variables
double newLot;
bool Pass=false;
color N=clrNONE;
input color ObjectColor=clrLime;
input color ProfitColor=clrLime;
input color LoseColor=clrRed;
color ColorPS,ColorPB,ColorAccountP,ColorSymbolP;
//Arrrays
string AllPairs[30];

string symbols[];
string Head[3];
// Class object
CExecute *trades[];
CPosition *Positions[];
CPosition *SellPositions[];
CPosition *BuyPositions[];
CUtilities *tools[];
CiCCI *CCi[];
CChartObjectLabel label;
CArrayObj *Panel=new CArrayObj;
CChartObjectEdit Heading;
CArrayString *MaxPair=new CArrayString;
CTradeState TradeState(TRADE_BUY_AND_SELL);  // Set the default mode to Buy And Sell
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   AllPairs[0]=Pair1;
   AllPairs[1]=Pair2;
   AllPairs[2]=Pair3;
   AllPairs[3]=Pair4;
   AllPairs[4]=Pair5;
   AllPairs[5]=Pair6;
   AllPairs[6]=Pair7;
   AllPairs[7]=Pair8;
   AllPairs[8]=Pair9;
   AllPairs[9]=Pair10;
   AllPairs[10]=Pair11;
   AllPairs[11]=Pair12;
   AllPairs[12]=Pair13;
   AllPairs[13]=Pair14;
   AllPairs[14]=Pair15;
   AllPairs[15]=Pair16;
   AllPairs[16]=Pair17;
   AllPairs[17]=Pair18;
   AllPairs[18]=Pair19;
   AllPairs[19]=Pair20;
   AllPairs[20]=Pair21;
   AllPairs[21]=Pair22;
   AllPairs[22]=Pair23;
   AllPairs[23]=Pair24;
   AllPairs[24]=Pair25;
   AllPairs[25]=Pair26;
   AllPairs[26]=Pair27;
   AllPairs[27]=Pair28;
   AllPairs[28]=Pair29;
   AllPairs[29]=Pair30;
   Head[0]="status";
   Head[1]="Tp";
   Head[2]= "Price";
   
   int total=ArraySize(AllPairs);
   for(int i=0; i<total; i++)
     {
      if(AllPairs[i]!="")
        {
         if(SymbolSelect(AllPairs[i],true))
           {
            Print(AllPairs[i]+" added to Market watch");
           }
         else
           {
            Print(AllPairs[i]+" doesn't Exist");
           }
         int size=ArraySize(symbols);
         ArrayResize(symbols,size+1,size+1);
         ArrayResize(trades,size+1,size+1);
         ArrayResize(Positions,size+1,size+1);
         ArrayResize(SellPositions,size+1,size+1);
         ArrayResize(BuyPositions,size+1,size+1);
         ArrayResize(tools,size+1,size+1);
         ArrayResize(CCi,size+1,size+1);
         symbols[size]=AllPairs[i];
         trades[size] = new CExecute(symbols[size], magic_Number);
         BuyPositions[size] = new CPosition(symbols[size], magic_Number, GROUP_POSITIONS_BUYS);
         SellPositions[size] = new CPosition(symbols[size], magic_Number, GROUP_POSITIONS_SELLS);
         Positions[size] = new CPosition(symbols[size], magic_Number, GROUP_POSITIONS_ALL);
         tools[size] = new CUtilities(symbols[size]);
         CCi[size]=new CiCCI;
         CCi[size].Create(symbols[size],PERIOD_CURRENT,Mperiod,Applied);
        }
     }
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   bool TradeAlow=(sTimeFilter(TimeStart,TimeStop)&&UseTimeFilter)||!UseTimeFilter;
   double profit = 0;
   double points = 0;
   if(useMoneyManagment)
     {
      newLot=(AccountInfoDouble(ACCOUNT_BALANCE)/1000)*lot;
     }
   else
      newLot=lot;
//---
   int total=ArraySize(symbols);
   for(int i=0; i<total; i++)
     {

      if(Positions[i].GroupTotal()==0)
        {
         if(MaxPair.Search(symbols[i])!=-1)
           {
            int idx=MaxPair.Search(symbols[i]);
            MaxPair.Delete(idx);
            CArrayObj *line=Panel.At(idx);

            while(line.Total())
               delete line.Detach(0);
            Panel.Detach(idx);
           }
        }
      MaxPair.Sort();
      if(day_trade()==true&&TradeAlow==true)
        {
         if(MaxPair.Total()<=MAX_Pair_Number)
           {
            CCi[i].Refresh(-1);
            if(EntryType==buy||EntryType==buyAndsell)
              {
               if(BuyPositions[i].GroupTotal()==0)
                 {
                  if(CCi[i].Main(1)<First_level_Positive&&CCi[i].Main(0)>Seconed_level_Positive)
                    {
                     double Lot=tools[i].NormalizeVolume(newLot);
                     trades[i].Position(TYPE_POSITION_BUY,Lot,0,0,SLTP_PIPS,30,comment);
                     bool found=false;
                     for(int c=0; c<MaxPair.Total(); c++)
                       {
                        if(MaxPair.At(c)==symbols[i])
                          {
                           found=true;
                          }
                       }
                     if(!found)
                       {
                        MaxPair.Add(symbols[i]);
                        CArrayObj *PanelLine=new CArrayObj;
                        PanelLine.Resize(4);
                        Panel.Add(PanelLine);

                       }
                    }
                 }
              }


            if(EntryType==sell||EntryType==buyAndsell)
              {
               if(SellPositions[i].GroupTotal()==0)
                 {
                  if(CCi[i].Main(1)>First_level_Negative&&CCi[i].Main(0)<Seconed_level_Negative)
                    {
                     double Lot=tools[i].NormalizeVolume(newLot);
                     trades[i].Position(TYPE_POSITION_SELL,Lot,0,0,SLTP_PIPS,30,comment);
                     bool found=false;
                     for(int c=0; c<MaxPair.Total(); c++)
                       {
                        if(MaxPair.At(c)==symbols[i])
                          {
                           found=true;
                          }
                       }
                     if(!found)
                       {
                        MaxPair.Add(symbols[i]);
                        CArrayObj *PanelLine=new CArrayObj;
                        PanelLine.Resize(4);
                        Panel.Add(PanelLine);
                       }
                    }
                 }
              }
           }
        }
        
      if(ShowPanel)
        {
         CreateDashboardTitles();
         SetPanelData();
        }
      if(symbols[i]==Symbol())
        {
         double BuyPipValue=((((SymbolInfoDouble(symbols[i], SYMBOL_TRADE_TICK_VALUE))*tools[i].Pip())/(SymbolInfoDouble(symbols[i],SYMBOL_TRADE_TICK_SIZE)))*BuyPositions[i].GroupTotalVolume());
         double SellPipValue=((((SymbolInfoDouble(symbols[i], SYMBOL_TRADE_TICK_VALUE))*tools[i].Pip())/(SymbolInfoDouble(symbols[i],SYMBOL_TRADE_TICK_SIZE)))*SellPositions[i].GroupTotalVolume());
     
         dashboard(Positions[i],BuyPositions[i],SellPositions[i],tools[i]);
        }
      profit+=Positions[i].GroupTotalProfit();
      ClosingEachSymbol(Positions[i],BuyPositions[i],SellPositions[i],tools[i],points);
      Hedging(trades[i],Positions[i],BuyPositions[i],SellPositions[i],tools[i]);
     }

   ClosingAccount(profit);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
void ClosingEachSymbol(CPosition & Pos,CPosition  & BuyPos,CPosition & SellPos, CUtilities & tool,double & points)
  {

// take profit with dollar for each symbol
   if(use_close_per_symbol_usd)
     {
      if((closeTP_sell_in_USD_eachpair>0&&SellPos.GroupTotalProfit() >= closeTP_sell_in_USD_eachpair)
         ||(closeTP_all_in_USD_eachpair>0&&SellPos.GroupTotalProfit() >= closeTP_all_in_USD_eachpair))
        {
         SellPos.GroupCloseAll(20);
        }
      if((closeTP_buy_in_USD_eachpair>0&&BuyPos.GroupTotalProfit() >= closeTP_buy_in_USD_eachpair)
         ||(closeTP_all_in_USD_eachpair>0&&BuyPos.GroupTotalProfit() >= closeTP_all_in_USD_eachpair))
        {
         BuyPos.GroupCloseAll(20);
        }

      //Stop loss with dollar for each symbol

      if((closeSL_sell_in_USD_eachpair<0&&SellPos.GroupTotalProfit() <= closeSL_sell_in_USD_eachpair)
         ||(closeSL_All_in_USD_eachpair<0&&SellPos.GroupTotalProfit() <= closeSL_All_in_USD_eachpair))
        {
         SellPos.GroupCloseAll(20);
        }
      if((closeSL_buy_in_USD_eachpair<0&&BuyPos.GroupTotalProfit() <= closeSL_buy_in_USD_eachpair)
         ||(closeSL_All_in_USD_eachpair<0&&BuyPos.GroupTotalProfit() <= closeSL_All_in_USD_eachpair))
        {
         BuyPos.GroupCloseAll(20);
        }
     }
// take profit with point for each symbol

   double Bpt = 0,Spt=0;
   int tt = Pos.GroupTotal();
   for(int x = 0; x < tt; x++)
     {
      if(Pos.GetType() == ORDER_TYPE_BUY)
        {
         Bpt += tool.Bid() - Pos.GetPriceOpen() ;
        }
      else
         if(Pos.GetType() == ORDER_TYPE_SELL)
           {
            Spt += Pos.GetPriceOpen() - tool.Bid() ;
           }
     }
   if(use_close_per_symbol_pip)
     {
      if(Bpt>=closeTP_buy_in_pips_eachpair * tool.Pip())
        {
         BuyPos.GroupCloseAll(20);
        }
      if(Spt>=closeTP_sell_in_pips_eachpair * tool.Pip())
        {
         SellPos.GroupCloseAll(20);
        }
      if(Bpt<=closeTP_buy_in_pips_eachpair * tool.Pip())
        {
         BuyPos.GroupCloseAll(20);
        }
      if(Spt<=closeTP_sell_in_pips_eachpair * tool.Pip())
        {
         SellPos.GroupCloseAll(20);
        }
      if((Bpt+Spt)>=closeTP_all_in_pips_eachpair*tool.Pip())
        {
         Pos.GroupCloseAll(20);
        }

      if((Bpt+Spt)<=closeSL_all_in_pips_eachpair*tool.Pip())
        {
         Pos.GroupCloseAll(20);
        }
     }

   points += (Bpt+Spt) /tool.Pip();



  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ClosingAccount(double & profit)
  {
// close all account postion with profit
   int t=ArraySize(symbols);
   for(int i = 0; i < t; i++)
     {
      if(profit >= closeTP_in_USD_All_account && use_close_per_account_usd)
        {
         Positions[i].GroupCloseAll(20);
        }
      if(profit >= closeSL_in_USD_All_account && use_close_per_account_usd)
        {
         Positions[i].GroupCloseAll(20);
        }


     }
  }
//+------------------------------------------------------------------+
void Hedging(CExecute & OpenHedge,CPosition & Pos,CPosition  & BuyPos,CPosition & SellPos, CUtilities & tool)
  {
   int  posTotal=Pos.GroupTotal();
   int  sellTotal=SellPos.GroupTotal();
   int  buyTotal=BuyPos.GroupTotal();
   if(sellTotal>0)
     {
      if(MartingleType==sell||MartingleType==buyAndsell)
        {
         if(SellPos[sellTotal-1].GetProfit()<0
            &&tool.Bid()-SellPos[sellTotal-1].GetPriceOpen()>=MultipilerStep*tool.Pip())
           {
            double lastLot=tool.NormalizeVolume(SellPos[sellTotal-1].GetVolume()*LotMultipiler);
            OpenHedge.Position(TYPE_POSITION_SELL,lastLot,0,0,SLTP_PIPS,30,comment);

           }
        }
     }
   if(buyTotal>0)
     {
      if(MartingleType==buy||MartingleType==buyAndsell)
        {
         if(BuyPos[buyTotal-1].GetProfit()<0
            &&BuyPos[buyTotal-1].GetPriceOpen()-tool.Bid()>=MultipilerStep*tool.Pip())
           {
            double lastLot=tool.NormalizeVolume(BuyPos[buyTotal-1].GetVolume()*LotMultipiler);
            OpenHedge.Position(TYPE_POSITION_BUY,lastLot,0,0,SLTP_PIPS,30,comment);
           }
        }
     }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void dashboard(CPosition & Pos,CPosition  & BuyPos,CPosition & SellPos, CUtilities & tool)
  {
   if(AccountInfoDouble(ACCOUNT_PROFIT)>=0)
     {
      ColorAccountP=ProfitColor;
     }
   else
     {
      ColorAccountP=LoseColor;
     }
   if(Pos.GroupTotalProfit()>=0)
     {
      ColorSymbolP=ProfitColor;
     }
   else
     {
      ColorSymbolP=LoseColor;
     }
   if(SellPos.GroupTotalProfit()>=0)
     {
      ColorPS=ProfitColor;
     }
   else
     {
      ColorPS=LoseColor;
     }
   if(BuyPos.GroupTotalProfit()>=0)
     {
      ColorPB=ProfitColor;
     }
   else
     {
      ColorPB=LoseColor;
     }


   Info("info1",1,25,150,"Account Balance : ",10,"",clrLime);
   Info("info11",1,25,50,DoubleToString(AccountInfoDouble(ACCOUNT_BALANCE),2),10,"",clrLime);
   Info("info2",1,50,150,"Account Equity : ",10,"",clrLime);
   Info("info22",1,50,50,DoubleToString(AccountInfoDouble(ACCOUNT_EQUITY),2),10,"",clrLime);
   Info("info3",1,75,150,"Account Profit : ",10,"",clrLime);
   Info("info33",1,75,50,DoubleToString(AccountInfoDouble(ACCOUNT_PROFIT),2),10,"",ColorAccountP);
   Info("info4",1,100,150,"Symbol Profit : ",10,"",clrLime);
   Info("info44",1,100,50,DoubleToString(Pos.GroupTotalProfit(),2),10,"",ColorSymbolP);
   Info("info5",1,125,150,"Sell Profit : ",10,"",clrLime);
   Info("info55",1,125,50,DoubleToString(SellPos.GroupTotalProfit(),2),10,"",ColorPS);
   Info("info6",1,150,150,"Buy Profit : ",10,"",clrLime);
   Info("info66",1,150,50,DoubleToString(BuyPos.GroupTotalVolume(),2),10,"",ColorPB);
   Info("info9",1,175,150,"  Number of Sell : ",10,"",clrLime);
   Info("info99",1,175,50,IntegerToString(SellPos.GroupTotal()),10,"",clrLime);
   Info("info8",1,200,150," Number of Buy : ",10,"",clrLime);
   Info("info88",1,200,50,IntegerToString(BuyPos.GroupTotal()),10,"",clrLime);



//Info("info09",0,25,20,"Max Account DrawDown : ",10,"",clrLime);
//Info("info00",0,25,200,DoubleToStr(MAXD,2),10,"",clrLime);
//Info("infoP",0,50,20,"Max Account Profit : ",10,"",clrLime);
//Info("infoP1",0,50,200,DoubleToStr(MAXP,2),10,"",clrLime);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Info(string NAME,double CORNER,int Y,int X,string TEXT,int FONTSIZE,string FONT,color FONTCOLOR)
  {
   label.Create(0,NAME,0,0,0);
   label.Description(TEXT);
   label.Corner(CORNER_RIGHT_UPPER);
   label.X_Distance(X);
   label.Y_Distance(Y);
  }
//+------------------------------------------------------------------+
bool day_trade()
  {
   if(Trade_sunday == true&& DayOfWeek() ==0)
      return (true);
   if(Trade_monday  == true&& DayOfWeek() ==1)
      return (true);
   if(Trade_tuseday  == true&& DayOfWeek() ==2)
      return (true);
   if(Trade_wednisday  == true&& DayOfWeek() ==3)
      return (true);
   if(Trade_Thursday  == true&& DayOfWeek() ==4)
      return (true);
   if(Trade_friday  == true&& DayOfWeek() ==5)
      return (true);

   if(Trade_sunday == false&& DayOfWeek() ==0)
      return (false);
   if(Trade_monday  == false&& DayOfWeek() ==1)
      return (false);
   if(Trade_tuseday  == false&& DayOfWeek() ==2)
      return (false);
   if(Trade_wednisday  == false&& DayOfWeek() ==3)
      return (false);
   if(Trade_Thursday  == false&& DayOfWeek() ==4)
      return (false);
   if(Trade_friday  == false&& DayOfWeek() ==5)
      return (false);

   return(false);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|              create dashboard title                              |
//+------------------------------------------------------------------+
int Y_Move = 20;
void CreateDashboardTitles()
  {
   int X_Shift, Y_Shift;
   Y_Shift = 10 + Y_Move;
   int sizeSym = MaxPair.Total();
   X_Shift = 10;
   Y_Shift = 40 + Y_Move;
   for(int i = 0; i < sizeSym; i++)
     {
      CArrayObj *Line=Panel.At(i);
      if(Line.At(0)==NULL)
        {
         CChartObjectEdit *edit= new CChartObjectEdit();
         Line.Insert(edit,0);
        }
      CChartObjectEdit *e=Line.At(0);

      CreatePanel(MaxPair.At(i),e,MaxPair.At(i), X_Shift, Y_Shift, 60, 25, clrYellow, clrBlack, clrBlack, 9, true, false, 0, ALIGN_CENTER);
      Y_Shift += 25;
     }
   int sizeTF = ArraySize(Head);
   X_Shift = 80;
   Y_Shift = 10 + Y_Move;
   for(int i = 0; i < sizeTF; i++)
     {
      CreatePanel(Head[i], Heading, Head[i], X_Shift, Y_Shift, 75, 25,  clrYellow, clrBlack, clrBlack, 9, true, false, 0, ALIGN_CENTER);
      X_Shift += 73;
     }
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CreatePanel(string name, CChartObjectEdit & Edit, string text, int XDistance, int YDistance, int Width, int Hight,
                 color BGColor_, color InfoColor, color boarderColor, int fontsize, bool readonly = false, bool Obj_Selectable = false, int Corner = 0, ENUM_ALIGN_MODE Align = ALIGN_LEFT)
  {


   Edit.Create(0,name,0,0,0,0,0);
   Edit.X_Distance(XDistance);
   Edit.Y_Distance(YDistance);
   Edit.Width(Width);
   Edit.X_Size(Width);
   Edit.Y_Size(Hight);
   Edit.Description(text);
   Edit.Font("Arial");
   Edit.FontSize(fontsize);
   Edit.Corner(CORNER_LEFT_UPPER);
   Edit.Color(InfoColor);
   Edit.SetInteger(OBJPROP_BGCOLOR,BGColor_);
   Edit.SetInteger(OBJPROP_BORDER_COLOR,boarderColor);
   Edit.Selectable(true);
   Edit.ReadOnly(true);
   Edit.TextAlign(Align);


  }
//+------------------------------------------------------------------+
void SetPanelData()
  {

   int X_Shift, Y_Shift;
   int sizeSym = MaxPair.Total();
   int sizeTF = ArraySize(Head);
   Y_Shift = 40 + Y_Move;

// for loop on all symbols
   for(int i = 0; i < sizeSym; i++)
     {
      X_Shift = 80;
      int symbolIDX;
      for(int c=0;c<ArraySize(symbols);c++){
         if(symbols[c]==MaxPair.At(i)){
            symbolIDX=c;
         }
      }
      // for loop on all TF for each symbol
      for(int j = 0; j < sizeTF; j++)
        {
         string stats;
         if(j==0)
           {
            stats=(BuyPositions[symbolIDX].GroupTotal()>0&&SellPositions[symbolIDX].GroupTotal()>0)?"BuyAndSell":(BuyPositions[symbolIDX].GroupTotal()>0&&SellPositions[symbolIDX].GroupTotal()==0)?"Buy":(BuyPositions[symbolIDX].GroupTotal()==0&&SellPositions[symbolIDX].GroupTotal()>0)?"Sell":"None";
           }

         CArrayObj *Line=Panel.At(i);
         CChartObjectEdit *e=Line.At(j+1);
         if(e==NULL)
           {
            CChartObjectEdit *edit=new CChartObjectEdit;
            Line.Insert(edit,j+1);
           }
         CChartObjectEdit *edit=Line.At(j+1);
         string   Txt=j==0?stats:j==1?"TP":DoubleToString(tools[symbolIDX].Bid(),(int)tools[symbolIDX].Digits());
         CreatePanel(MaxPair.At(i)+Head[j], edit, Txt, X_Shift, Y_Shift, 75, 25, clrGreen, clrBlack, clrWhite, 9, true, false, 0, ALIGN_CENTER);

         X_Shift += 73;
        }
      Y_Shift += 25;
     }
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool sTimeFilter(string inStart,string inEnd,string inString=":")
  {
   bool Result=true;
   int TimeHourStart,TimeMinuteStart,TimeHourEnd,TimeMinuteEnd;
   static datetime TimeStarts,TimeEnd;
//---
   sInputTimeConvert(TimeHourStart,TimeMinuteStart,inStart,inString);
   sInputTimeConvert(TimeHourEnd,TimeMinuteEnd,inEnd,inString);
   TimeStarts=StringToTime(IntegerToString(TimeHourStart)+":"+IntegerToString(TimeMinuteStart));
   TimeEnd=StringToTime(IntegerToString(TimeHourEnd)+":"+IntegerToString(TimeMinuteEnd));
//---
   if((TimeStarts<=TimeEnd) && ((TimeCurrent()<TimeStarts) || (TimeCurrent()>TimeEnd)))
      Result=false;
   if((TimeStarts>TimeEnd) && (TimeCurrent()<TimeStarts) && (TimeCurrent()>TimeEnd))
      Result=false;
//---
   return(Result);
  }
//+------------------------------------------------------------------+
//| sInputTimeConvert                                                |
//+------------------------------------------------------------------+
int sInputTimeConvert(int &inHour,int &inMinute,string inInput,string inString=":")
  {
   int PS;
//---
   PS=StringFind(inInput,inString,0);
   inMinute=(int)StringToDouble(StringSubstr(inInput,PS+1,StringLen(inInput)-PS));
   inHour=(int)StringToDouble(StringSubstr(inInput,0,PS));
//---
   return(PS);
  }
  
  void DrawSlTP(CExecute & OpenHedge,CPosition & Pos,CPosition  & BuyPos,CPosition & SellPos, CUtilities & tool,string sym){
    
  }