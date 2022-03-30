//+------------------------------------------------------------------+
//|                                   Copyright 2022, Yousuf Mesalm. |
//|                                    https://www.Yousuf-mesalm.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Yousuf Mesalm."
#property link      "https://www.Yousuf-mesalm.com"
#property link      "https://www.mql5.com/en/users/20163440"
#property description      "Developed by Yousuf Mesalm"
#property description      "https://www.Yousuf-mesalm.com"
#property description      "https://www.mql5.com/en/users/20163440"
#property version   "1.00"

#define  OBJPERFIX  "YM - "
//includes
#include <YM\Utilities\Utilities.mqh>
#include <YM\EXecute\EXecute.mqh>
#include <YM\Position\Position.mqh>
#include <YM\Order\Order.mqh>
#include  <YM\HistoryPosition\HistoryPosition.mqh>


// enumerations
enum type
  {
   Buy,Sell,Buystop,Sellstop,Buylimit,Selllimit
  };
enum EntryType
  {
   Points,Price
  };
enum timeType
  {
   GMT,SERVER_Time
  };
enum Methods
  {
   Delete,Suspend_and_Delete,
  };
enum typ
  {
   initial,reset,
  };
//User Inputs
input type Trade_Type               =Buy;
input long MagicNumber              =2020;
input double Lot                    =1;
input EntryType entry_Type          =Price;
input double Entry= 1.5000;
input bool   UseDefault_sl          =true;
input double General_Sl             =0; //Default Stop loss
input bool   UseDefault_tp          =false;
input double General_TP             =0; //General  take Profit
sinput string set1                  ="<------------------->PARTIAL CLOSE SETTINGS<---------------------->";
input bool USePartialClose          =true; // Enable partial close
input double volume1                =50 ; //Percent of volume 1 to close after tp 1
input double volume2                =0  ; //Percent of volume 2 to close after tp 2
input bool  Enable_BE               =true; //Enable breakeven after partial close
input bool   UseDefault_tp1         =true;
input double TP1                    =0;
input double TP2                    =0;
input string set2                   ="<------------------->TRAILING STOP SETTINGS<---------------------->";
input bool Use_Trailing             =true; //Enable Trailing stop
input double TrailingStopPoint      =0 ;  //Trailing distance
input double Activation_Distance    =0 ;  //Activation Distance in points
input bool Use_Activation_Time          =true;
input timeType Activation_Time_Type =SERVER_Time;
input string Activation_Time        ="00:00";
sinput string set3                  ="<------------------->Automatic reseting<--------------------------->";
input bool enable_Reset             =true;  //Enable auto BE Resetting
input bool enable_Post_Reset        =true;
input double Distance_away          =0;
input timeType Close_Time_type = SERVER_Time;// Close and Breakeven Time Type
input bool close_of_active_trades  = true;
input bool Use_time_to_BE           =false;
input string time_to_breakEven      ="00:00";
double BreakEven_point        =10 ;
input string Time_to_close_Active_Trades = "08:00";
input bool close_of_inactive_trades = true;
Methods Inactive_Trades_Methods=Suspend_and_Delete;
input string TimeTo_Delete_and_Suspend_Inactive_Trades1 ="23:00";
input string TimeTo_stop_suspension_Inactive_Trades1 ="23:59";
input bool use_Seconed_suspension_period             =true;
input string TimeTo_Delete_and_Suspend_Inactive_Trades2 ="00:00";
input string TimeTo_stop_suspension_Inactive_Trades2 ="00:30";
//variables
double takeprofit1,GSL,GTP,GTD,GAD,DA;
double entry=0;
color entrycolor=0;
bool closewithtp=true,closewithBE=false,BE_happen=false,buy=false,sell=false;
string Pairs[18]= {"GBPJPY","AUDJPY","GBPUSD","AUDUSD","EURGBP","GBPAUD","EURJPY","GBPNZD","EURUSD","EURAUD","USDJPY","EURNZD","GBPCAD","NZDJPY","EURCAD","NZDUSD","USDCAD","CADJPY"};
int DSL[18]= {240,150,180,146,120,270,170,280,160,240,160,260,260,145,230,140,180,148};
int DAD[18]= {960,600,720,292,480,458,680,1120,640,980,640,1140,1140,580,920,560,360,720};
int DTD[18]= {480,300,360,292,240,540,340,560,320,480,320,520,520,290,460,280,360,296};
int DTP1[18]= {320,200,240,195,213,260,227,373,213,320,213,347,347,193,307,187,320,197};
datetime StartTime=0;
datetime lastorder_close=0;
double fristtp=0;
bool closeHappen=false;
bool suspendHappen=false;
bool entryPut=false;
typ which;
bool BE_reset=false;
int whereis=0;
bool waitSell=false,waitBuy=false;
bool BE_with_time=false;
double initialEntry=0;
bool onetrade=false;
bool skip=false;
//Objects
CUtilities tool;
CExecute trade(Symbol(),MagicNumber);
CPosition Pos(Symbol(),MagicNumber,GROUP_POSITIONS_ALL);
CPosition BuyPos(Symbol(),MagicNumber,GROUP_POSITIONS_BUYS);
CPosition SellPos(Symbol(),MagicNumber,GROUP_POSITIONS_SELLS);
CHistoryPosition Hist(Symbol(),MagicNumber,GROUP_HISTORY_POSITIONS_ALL);
COrder order;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   bool found=false;
   StartTime=TimeCurrent();
   int total=ArraySize(Pairs);
   if(Trade_Type==Selllimit)
     {
      order.SetGroup(GROUP_ORDERS_SELL_LIMIT);
     }
   if(Trade_Type==Buylimit)
     {
      order.SetGroup(GROUP_ORDERS_BUY_LIMIT);
     }
   if(Trade_Type==Sellstop)
     {
      order.SetGroup(GROUP_ORDERS_SELL_STOP);
     }
   if(Trade_Type==Buystop)
     {
      order.SetGroup(GROUP_ORDERS_BUY_STOP);
     }
   order.SetGroupSymbol(Symbol());
   order.SetGroupMagicNumber(MagicNumber);
   for(int i=0; i<total; i++)
     {
      if(StringFind(Symbol(),Pairs[i],0)>=0)
        {
         found=true;
         if(UseDefault_tp1)
           {
            if(TP1==0)
               takeprofit1=DSL[i];
            else
               takeprofit1=TP1;
           }
         else
           {
            takeprofit1=0;
           }
         if(Distance_away==0)
            DA=DTP1[i];
         else
            DA=Distance_away;
         if(UseDefault_sl)
           {
            if(General_Sl==0)
               GSL=DSL[i];
            else
               GSL=General_Sl;
           }
         else
           {
            GSL=0;
           }
         if(UseDefault_tp)
           {
            if(General_TP==0)
               GTP=DTP1[i];
            else
               GTP=General_TP;
           }
         else
           {
            GTP=0;
           }
         if(TrailingStopPoint==0)
            GTD=DTD[i];
         else
            GTD=TrailingStopPoint;
         if(Activation_Distance==0)
            GAD=DAD[i];
         else
            GAD=Activation_Distance;
        }

     }
   if(!found)
     {
      if(UseDefault_tp1)
        {
         if(TP1==0)
            takeprofit1=240;
         else
            takeprofit1=TP1;
        }
      else
        {
         takeprofit1=0;
        }
      if(Distance_away==0)
         DA=240;
      else
         DA=Distance_away;
      if(UseDefault_sl)
        {
         if(General_Sl==0)
            GSL=240;
         else
            GSL=General_Sl;
        }
      else
        {
         GSL=0;
        }
      if(UseDefault_tp)
        {
         if(General_TP==0)
            GTP=240;
         else
            GTP=General_TP;
        }
      else
        {
         GTP=0;
        }
      if(TrailingStopPoint==0)
         GTD=240;
      else
         GTD=TrailingStopPoint;
      if(Activation_Distance==0)
         GAD=240;
      else
         GAD=Activation_Distance;

     }
   initialEntry=tool.Bid();
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
//---
   dashboard();

   if(Pos.GroupTotal()==0&&closewithtp==true)
     {
      BE_happen=false;
      if(!waitBuy)
         buy=false;
      if(!waitSell)

         sell=false;
      if(!entryPut)
        {
         if(entry_Type==Price)
           {
            entry=tool.NormalizePrice(Entry);
            entryPut=true;
           }
         else
            if(entry_Type==Points)
              {
               if(Trade_Type==Buy||Trade_Type==Buystop||Trade_Type==Selllimit)
                 {
                  entry=tool.NormalizePrice(initialEntry+Entry*tool.Point());
                  entryPut=true;
                 }
               if(Trade_Type==Sell||Trade_Type==Sellstop||Trade_Type==Buylimit)
                 {
                  entry=tool.NormalizePrice(initialEntry-Entry*tool.Point());
                  entryPut=true;
                 }
              }
        }
      if((close_of_inactive_trades&&!TimeFilter(TimeTo_Delete_and_Suspend_Inactive_Trades1,TimeTo_stop_suspension_Inactive_Trades1)&&
          ((use_Seconed_suspension_period&&!TimeFilter(TimeTo_Delete_and_Suspend_Inactive_Trades2,TimeTo_stop_suspension_Inactive_Trades2))||use_Seconed_suspension_period))
         ||!close_of_inactive_trades)
        {
         if(!onetrade)
           {
            if(!skip)
              {
               if(Trade_Type==Selllimit&&tool.Bid()<entry)
                 {
                  trade.Order(TYPE_ORDER_SELLLIMIT,Lot,entry,GSL,GTP,SLTP_POINTS,0,30,OBJPERFIX+"SellLimit");
                  if(order.GroupTotal()>0)
                    {
                     closewithtp=false;
                     closewithBE=false;
                     BE_happen=false;
                     which=initial;
                    }
                 }
               if(Trade_Type==Buystop&&tool.Bid()<entry)
                 {
                  trade.Order(TYPE_ORDER_BUYSTOP,Lot,entry,GSL,GTP,SLTP_POINTS,0,30,OBJPERFIX+"BuyStop");
                  if(order.GroupTotal()>0)
                    {
                     closewithtp=false;
                     closewithBE=false;
                     BE_happen=false;
                     which=initial;

                    }
                 }
               if(Trade_Type==Buy&&!waitBuy&&!buy)
                 {
                  HLineCreate(0,OBJPERFIX+"entry",0,entry,clrLimeGreen,STYLE_SOLID,2);
                  TextCreate(0,OBJPERFIX+"entry Type",0,TimeCurrent(),entry,"Buy","Arial",10,clrLimeGreen);
                  buy=true;
                  which=initial;
                  if(entry>tool.Bid())
                     whereis=-1;
                  else
                     whereis=1;
                  waitBuy=true;
                 }
               if(Trade_Type==Buylimit&&tool.Bid()>entry)
                 {
                  trade.Order(TYPE_ORDER_BUYLIMIT,Lot,entry,GSL,GTP,SLTP_POINTS,0,30,OBJPERFIX+"BuyLimit");
                  if(order.GroupTotal()>0)
                    {
                     closewithtp=false;
                     closewithBE=false;
                     BE_happen=false;
                     which=initial;
                     if(!USePartialClose)
                        onetrade=true;
                    }
                 }
               if(Trade_Type==Sellstop&&tool.Bid()>entry)
                 {
                  trade.Order(TYPE_ORDER_SELLSTOP,Lot,entry,GSL,GTP,SLTP_POINTS,0,30,OBJPERFIX+"SellStop");
                  if(order.GroupTotal()>0)
                    {
                     closewithtp=false;
                     closewithBE=false;
                     BE_happen=false;
                     which=initial;
                     if(!USePartialClose)
                        onetrade=true;
                    };
                 }
               if(Trade_Type==Sell&&!waitSell&&!sell)
                 {
                  HLineCreate(0,OBJPERFIX+"entry",0,entry,clrRed,STYLE_SOLID,2);
                  TextCreate(0,OBJPERFIX+"entry Type",0,TimeCurrent(),entry,"Sell","Arial",10,clrRed);
                  sell=true;
                  if(entry>tool.Bid())
                     whereis=-1;
                  else
                     whereis=1;
                  which=initial;
                  waitSell=true;
                 }
              }
           }
        }
     }
   if((close_of_inactive_trades&&!TimeFilter(TimeTo_Delete_and_Suspend_Inactive_Trades1,TimeTo_stop_suspension_Inactive_Trades1)&&
       ((use_Seconed_suspension_period&&!TimeFilter(TimeTo_Delete_and_Suspend_Inactive_Trades2,TimeTo_stop_suspension_Inactive_Trades2))||use_Seconed_suspension_period))
      ||!close_of_inactive_trades)
     {
      if(!onetrade)
        {
         if(!skip)
           {
            if(Trade_Type==Buy&&waitBuy)
              {
               if(closewithtp)
                  if(((whereis==1&&tool.Ask()<=entry)||(whereis==-1&&tool.Ask()>=entry))&&buy)
                    {
                     trade.Position(TYPE_POSITION_BUY,Lot,GSL,GTP,SLTP_POINTS,30,OBJPERFIX+"Buy");
                     ObjectDelete(0,OBJPERFIX+"entry");
                     ObjectDelete(0,OBJPERFIX+"entry Type");
                     if(Pos.GroupTotal()>0)
                       {
                        closewithtp=false;
                        closewithBE=false;
                        BE_happen=false;
                        buy=false;

                        which=initial;
                        waitBuy=false;
                        if(!USePartialClose)
                           onetrade=true;
                       }
                    }
               if(closewithBE)
                  if(((whereis==1&&tool.Ask()<=fristtp)||(whereis==-1&&tool.Ask()>=fristtp))&&buy)
                    {
                     trade.Position(TYPE_POSITION_BUY,Lot,entry,GTP==0?0:fristtp+GTP*tool.Point(),SLTP_PRICE,30,OBJPERFIX+"Rest Buy");

                     ObjectDelete(0,OBJPERFIX+"entry");
                     ObjectDelete(0,OBJPERFIX+"entry Type");
                     if(Pos.GroupTotal()>0)
                       {
                        closewithtp=false;
                        closewithBE=false;
                        BE_happen=false;
                        which=reset;
                        buy=false;

                        waitBuy=false;

                       }
                    }
              }
            if(Trade_Type==Sell&&waitSell)
              {
               if(closewithtp)
                  if(((whereis==1&&tool.Bid()<=entry)||(whereis==-1&&tool.Bid()>=entry))&&sell)
                    {
                     trade.Position(TYPE_POSITION_SELL,Lot,GSL,GTP,SLTP_POINTS,30,OBJPERFIX+"Sell");
                     ObjectDelete(0,OBJPERFIX+"entry");
                     ObjectDelete(0,OBJPERFIX+"entry Type");
                     if(Pos.GroupTotal()>0)
                       {
                        closewithtp=false;
                        closewithBE=false;
                        BE_happen=false;
                        which=initial;
                        waitSell=false;
                        if(!USePartialClose)
                           onetrade=true;
                       }
                    }
               if(closewithBE)
                  if(((whereis==1&&tool.Bid()<=fristtp)||(whereis==-1&&tool.Bid()>=fristtp))&&sell)
                    {
                     trade.Position(TYPE_POSITION_SELL,Lot,entry,GTP==0?0:fristtp-GTP*tool.Point(),SLTP_PRICE,30,OBJPERFIX+"Reset Sell");
                     ObjectDelete(0,OBJPERFIX+"entry");
                     ObjectDelete(0,OBJPERFIX+"entry Type");
                     if(Pos.GroupTotal()>0)
                       {
                        closewithtp=false;
                        closewithBE=false;
                        BE_happen=false;
                        sell=false;
                        which=reset;
                        waitSell=false;

                       }
                    }
              }
           }
        }
     }
   if(closewithBE&&!closewithtp)
     {
      setOrder();
     }
   if(TimeTo_stop_suspension_Inactive_Trades1=="23:59"&&ClosingTimeFilter("23:58")&&use_Seconed_suspension_period)
      skip=true;

   Closing();
   ReSet();
   Traliling();
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Closing()
  {
   int BuyTotal=BuyPos.GroupTotal();
   if(USePartialClose)
     {
      for(int i=0; i<BuyTotal; i++)
        {
         double openPrice=BuyPos[i].GetPriceOpen();
         double lot=BuyPos[i].GetVolume();
         fristtp=openPrice+takeprofit1*tool.Point();

         if(tool.Bid()>=(fristtp)&&Lot==lot)
           {
            if(USePartialClose)
               BuyPos[i].ClosePartial(lot*(volume1/100),30);
            if(Enable_BE)
              {
               BuyPos[i].Modify(BuyPos.GetPriceOpen(), BuyPos.GetTakeProfit(), SLTP_PRICE);
               BE_happen=true;
               BE_reset=true;
              }
           }
         if(USePartialClose)
            if(tool.Bid()>=(openPrice+TP2*tool.Point())&&TP2!=0&&(Lot*(volume1/100)==lot))
              {
               BuyPos[i].ClosePartial(lot*(volume2/100),30);
              }
        }
      int SellTotal=SellPos.GroupTotal();
      for(int i=0; i<SellTotal; i++)
        {
         double openPrice=SellPos[i].GetPriceOpen();
         double lot=SellPos[i].GetVolume();
         fristtp=openPrice-takeprofit1*tool.Point();
         if(tool.Bid()<=fristtp&&Lot==lot)
           {
            if(USePartialClose)
               SellPos.ClosePartial(lot*(volume1/100),30);
            if(Enable_BE)
              {
               SellPos.Modify(SellPos.GetPriceOpen(), SellPos.GetTakeProfit(), SLTP_PRICE);
               BE_happen=true;
               BE_reset=true;
              }

           }
         if(USePartialClose)
            if(tool.Bid()<=(openPrice-TP2*tool.Point())&&TP2!=0&&(Lot*(volume1/100)==lot))
              {
               SellPos.ClosePartial(lot*(volume2/100),30);

              }
        }
     }
   if(close_of_active_trades&&ClosingTimeFilter(Time_to_close_Active_Trades)&&!closeHappen)
     {
      if(Pos.GroupTotal()>0)
        {
         Pos.GroupCloseAll();
         closewithtp=true;
         closewithBE=false;
         BE_happen=false;
         buy=false;
         sell=false;
         waitBuy=false;
         waitSell=false;
         entryPut=false;
         closeHappen=true;
        }
      if(Pos.GroupTotal()==0)
        {
         closeHappen=true;
        }
     }
   if(close_of_inactive_trades&&ClosingTimeFilter(TimeTo_Delete_and_Suspend_Inactive_Trades1)&&!suspendHappen)
     {

      order.GroupCloseAll(30);
      if(Pos.GroupTotal()==0)
        {
         closewithtp=true;
         closewithBE=false;
         BE_happen=false;
         buy=false;
         sell=false;
         entryPut=false;
         waitBuy=false;
         waitSell=false;
         suspendHappen=true;
         ObjectDelete(0,OBJPERFIX+"entry");
         ObjectDelete(0,OBJPERFIX+"entry Type");
        }
     }

   if(Use_time_to_BE&&skipFilter(time_to_breakEven)&&!BE_with_time)
     {
      int size=Pos.GroupTotal();
      for(int i=0; i<size; i++)
        {
         int type=Pos[i].GetType();
         double p=-1;
         if(type==ORDER_TYPE_BUY)
           {
            p=Pos[i].GetPriceOpen()+BreakEven_point*tool.Point();
            if(p<=tool.Ask())
              {
               if(Pos[i].Modify(Pos[i].GetPriceOpen(),Pos[i].GetTakeProfit(),SLTP_PRICE))
                 {
                  BE_happen=true;
                  BE_reset=false;
                  BE_with_time=true;
                 }
              }
           }
         if(type==ORDER_TYPE_SELL)
           {
            p=Pos[i].GetPriceOpen()-BreakEven_point*tool.Point();
            if(p>=tool.Ask())
              {
               if(Pos[i].Modify(Pos[i].GetPriceOpen(),Pos[i].GetTakeProfit(),SLTP_PRICE))
                 {
                  BE_happen=true;
                  BE_reset=false;
                  BE_with_time=true;
                 }
              }
           }
        }
     }
   if(tool.IsNewBar(PERIOD_D1))
     {
      closeHappen=false;
      suspendHappen=false;
      BE_with_time=false;
      initialEntry=tool.Bid();

     }
   if(skipFilter(TimeTo_stop_suspension_Inactive_Trades2)&&use_Seconed_suspension_period)
      skip=false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ReSet()
  {
   int  size=Pos.GroupTotal();
   Hist.SetHistoryRange(StartTime,TimeCurrent());
   int total=Hist.GroupTotal();
   datetime time=0;
   long ticket=-1;
   double profit=0;
   double closeprice=0;
   double tp=0,sl=0,openprice=0;
   datetime timeClose=0;
   for(int i= 0; i<total; i++)
     {
      timeClose=Hist[i].GetTimeClose();
      if(timeClose>time)
        {
         time=timeClose;
         ticket=Hist[i].GetTicket();
         profit=Hist[i].GetProfit();
         closeprice=Hist[i].GetPriceClose();
         tp=Hist[i].GetTakeProfit();
         sl=Hist[i].GetStopLoss();
         openprice=Hist[i].GetPriceOpen();
        }
     }
   if(total>0&&time>lastorder_close&&size==0&&time!=0)
     {
      lastorder_close=time;


      if(profit>0&&closeprice>=tp-2*tool.Pip()&&closeprice<=tp+2*tool.Pip())
        {
         closewithtp=true;
         closewithBE=false;
         BE_happen=false;
         buy=false;
         sell=false;
         entryPut=false;
         if(!USePartialClose)
            onetrade=true;
        }
      if(profit>0&&(closeprice>openprice+1*tool.Pip()||closeprice<openprice-1*tool.Pip()))
        {
         closewithtp=true;
         closewithBE=false;
         BE_happen=false;
         buy=false;
         sell=false;
         entryPut=false;
         if(!USePartialClose)
            onetrade=true;

        }
      if(BE_happen&&!closewithBE)
        {
         if(!USePartialClose)
            onetrade=true;
         if(enable_Reset)
           {
            closewithBE=true;
            BE_happen=false;

            if(BE_reset)
              {
               closewithtp=false;
               setOrder();
              }
            else
              {
               closewithtp=true;
               buy=false;
               sell=false;
               entryPut=false;
              }
           }
         else
           {
            closewithtp=true;
            closewithBE=false;
            BE_happen=false;
            buy=false;
            sell=false;
            entryPut=false;
            if(!USePartialClose)
               onetrade=true;
           }
        }
      if(!BE_happen&&!closewithBE&&!closewithtp&&profit<0&&closeprice>=sl-2*tool.Pip()&&closeprice<=sl+2*tool.Pip())
        {
         if(!USePartialClose)
            onetrade=true;
         if(enable_Reset)
           {
            closewithtp=true;
            entryPut=true;
            closewithBE=false;
            BE_happen=false;
           }
         else
           {
            closewithtp=true;
            closewithBE=false;
            BE_happen=false;
            buy=false;
            sell=false;
            entryPut=false;
           }
        }

     }
   double d= MathAbs(fristtp-tool.Bid())/tool.Point();
   if(which==reset&&!BE_happen&&size==0&&d>=DA&&enable_Post_Reset&&!closewithtp)
     {
      order.GroupCloseAll(30);
      closewithtp=true;
      closewithBE=false;
      BE_happen=false;
      entryPut=true;
      ObjectDelete(0,OBJPERFIX+"entry");
      ObjectDelete(0,OBJPERFIX+"entry Type");
      waitBuy=false;
      waitSell=false;
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setOrder()
  {
   if((close_of_inactive_trades&&!TimeFilter(TimeTo_Delete_and_Suspend_Inactive_Trades1,TimeTo_stop_suspension_Inactive_Trades1)&&
       ((use_Seconed_suspension_period&&!TimeFilter(TimeTo_Delete_and_Suspend_Inactive_Trades2,TimeTo_stop_suspension_Inactive_Trades2))||use_Seconed_suspension_period))
      ||!close_of_inactive_trades)
     {
      if(!onetrade)
        {
         if(!skip)
           {
            if(Trade_Type==Selllimit&&tool.Bid()<fristtp)
              {
               trade.Order(TYPE_ORDER_SELLLIMIT,Lot,fristtp,entry,GTP==0?0:fristtp+GTP*tool.Point(),SLTP_PRICE,0,30,OBJPERFIX+"Reset SellLimit");
               if(order.GroupTotal()>0)
                 {
                  closewithtp=false;
                  closewithBE=false;
                  BE_happen=false;
                  which=reset;
                 }
              }
            if(Trade_Type==Buystop&&tool.Bid()<fristtp)
              {
               trade.Order(TYPE_ORDER_BUYSTOP,Lot,fristtp,entry,GTP==0?0:fristtp+GTP*tool.Point(),SLTP_PRICE,0,30,OBJPERFIX+"Reset BuyStop");
               if(order.GroupTotal()>0)
                 {
                  closewithtp=false;
                  closewithBE=false;
                  BE_happen=false;
                  which=reset;
                 }
              }
            if(Trade_Type==Buy&&!waitBuy)
              {
               HLineCreate(0,OBJPERFIX+"entry",0,fristtp,clrLimeGreen,STYLE_SOLID,2);
               TextCreate(0,OBJPERFIX+"entry Type",0,TimeCurrent(),fristtp,"Buy","Arial",10,clrLimeGreen);
               buy=true;
               which=reset;
               if(fristtp>tool.Bid())
                  whereis=-1;
               else
                  whereis=1;
               waitBuy=true;
              }
            if(Trade_Type==Buylimit&&tool.Bid()>fristtp)
              {
               trade.Order(TYPE_ORDER_BUYLIMIT,Lot,fristtp,entry,GTP==0?0:fristtp-GTP*tool.Point(),SLTP_PRICE,0,30,OBJPERFIX+"Reset BuyLimit");
               if(order.GroupTotal()>0)
                 {
                  closewithtp=false;
                  closewithBE=false;
                  BE_happen=false;
                  which=reset;
                 }
              }
            if(Trade_Type==Sellstop&&tool.Bid()>fristtp)
              {
               trade.Order(TYPE_ORDER_SELLSTOP,Lot,fristtp,entry,GTP==0?0:fristtp-GTP*tool.Point(),SLTP_PRICE,0,30,OBJPERFIX+"Reset SellStop");
               if(order.GroupTotal()>0)
                 {
                  closewithtp=false;
                  closewithBE=false;
                  BE_happen=false;
                  which=reset;
                 }
              }
            if(Trade_Type==Sell&&!waitSell)
              {

               HLineCreate(0,OBJPERFIX+"entry",0,fristtp,clrRed,STYLE_SOLID,2);
               TextCreate(0,OBJPERFIX+"entry Type",0,TimeCurrent(),fristtp,"Sell Reset","Arial",10,clrRed);
               sell=true;
               which=reset;
               if(fristtp>tool.Bid())
                  whereis=-1;
               else
                  whereis=1;
               waitSell=true;
              }

           }
        }
     }
  }

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void Traliling()
  {
   int sell_total = SellPos.GroupTotal();

   int buy_total = BuyPos.GroupTotal();
   if(Use_Trailing&&((Use_Activation_Time&&TrailingTimeFilter(Activation_Time))||!Use_Activation_Time))
     {
      for(int i = 0; i < buy_total; i++)
        {
         if(BuyPos.SelectByIndex(i))
           {
            if(tool.Bid() - BuyPos.GetPriceOpen() > tool.Point() * GAD)
              {
               if(BuyPos.GetStopLoss() < tool.Bid() - tool.Point() * GTD)
                 {
                  double ModfiedSl = tool.Bid() - (tool.Point() * GTD);
                  BuyPos.Modify(ModfiedSl, BuyPos.GetTakeProfit(), SLTP_PRICE);
                 }
              }
           }
        }

      for(int i = 0; i < sell_total; i++)
        {
         if(SellPos.SelectByIndex(i))
           {
            if(SellPos.GetPriceOpen() - tool.Ask() > tool.Point() * GAD)
              {
               if(SellPos.GetStopLoss() > tool.Ask() + tool.Point() * GTD)
                 {
                  double ModfiedSl = tool.Ask() + tool.Point() * GTD;
                  SellPos.Modify(ModfiedSl, SellPos.GetTakeProfit(), SLTP_PRICE);
                 }
              }
           }


        }
     }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Create the horizontal line                                       |
//+------------------------------------------------------------------+
bool HLineCreate(const long            chart_ID=0,        // chart's ID
                 const string          name="HLine",      // line name
                 const int             sub_window=0,      // subwindow index
                 double                price=0,           // line price
                 const color           clr=clrRed,        // line color
                 const ENUM_LINE_STYLE style=STYLE_SOLID, // line style
                 const int             width=1,           // line width
                 const bool            back=false,        // in the background
                 const bool            selection=true,    // highlight to move
                 const bool            hidden=true,       // hidden in the object list
                 const long            z_order=0)         // priority for mouse click
  {
   if(!price)
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID);
//--- reset the error value
   ResetLastError();
//--- create a horizontal line
   if(!ObjectCreate(chart_ID,name,OBJ_HLINE,sub_window,0,price))
     {
      Print(__FUNCTION__,
            ": failed to create a horizontal line! Error code = ",GetLastError());
      return(false);
     }
//--- set line color
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- set line display style
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- set line width
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
   return(true);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Creating Text object                                             |
//+------------------------------------------------------------------+
bool TextCreate(const long              chart_ID=0,               // chart's ID
                const string            name="Text",              // object name
                const int               sub_window=0,             // subwindow index
                datetime                time=0,                   // anchor point time
                double                  price=0,                  // anchor point price
                const string            text="Text",              // the text itself
                const string            font="Arial",             // font
                const int               font_size=10,             // font size
                const color             clr=clrRed,               // color
                const double            angle=0.0,                // text slope
                const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // anchor type
                const bool              back=false,               // in the background
                const bool              selection=false,          // highlight to move
                const bool              hidden=true,              // hidden in the object list
                const long              z_order=0)                // priority for mouse click
  {

//--- reset the error value
   ResetLastError();
//--- create Text object
   if(!ObjectCreate(chart_ID,name,OBJ_TEXT,sub_window,time,price))
     {
      Print(__FUNCTION__,
            ": failed to create \"Text\" object! Error code = ",GetLastError());
      return(false);
     }
//--- set the text
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
//--- set text font
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
//--- set font size
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
//--- set the slope angle of the text
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
//--- set anchor type
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
//--- set color
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of moving the object by mouse
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
   return(true);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Time Filter                                                                 |
//+------------------------------------------------------------------+
bool ClosingTimeFilter(string ET)
  {

   datetime End   =StringToTime(TimeToString(TimeCurrent(),TIME_DATE)+" "+ET);
   datetime curr=Close_Time_type==GMT?TimeGMT():TimeLocal();

   if((curr<=End))
     {
      return(false);
     }
   return(true);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
bool TimeFilter(string Sh,string Eh)
  {
   datetime Strat=StringToTime(TimeToString(TimeCurrent(),TIME_DATE)+" " +Sh);
   datetime End  =StringToTime(TimeToString(TimeCurrent(),TIME_DATE)+" "+ Eh);
   datetime curr=Close_Time_type==GMT?TimeGMT():TimeLocal();

   if(!(curr>=Strat &&curr<=End))
     {
      return(false);
     }
   return(true);

  }
//+------------------------------------------------------------------+
bool TrailingTimeFilter(string ET)
  {

   datetime End   =StringToTime(TimeToString(TimeCurrent(),TIME_DATE)+" "+ET);
   datetime curr=Activation_Time_Type==GMT?TimeGMT():TimeLocal();

   if((curr<=End))
     {
      return(false);
     }
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool skipFilter(string ET)
  {

   datetime End   =StringToTime(TimeToString(TimeCurrent(),TIME_DATE)+" "+ET);
   datetime curr=Activation_Time_Type==GMT?TimeGMT():TimeLocal();

   if((curr==End))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
void dashboard()
  {

   Info("info1",0,25,21,"Entry: ",10,"",clrLime);
   Info("info11",0,25,200,DoubleToString(entry,Digits()),10,"",clrLime);
   Info("info2",0,50,21,"General Tp : ",10,"",clrLime);
   Info("info22",0,50,200,DoubleToString(GTP,2),10,"",clrLime);
   Info("info3",0,75,21,"Default Sl : ",10,"",clrLime);
   Info("info33",0,75,200,DoubleToString(GSL,2),10,"",clrLime);
   Info("info4",0,100,21,"TP1 : ",10,"",clrLime);
   Info("info44",0,100,200,DoubleToString(takeprofit1,2),10,"",clrLime);
   Info("info5",0,125,21,"Default Distance away : ",10,"",clrLime);
   Info("info55",0,125,200,DoubleToString(DA,2),10,"",clrLime);
   Info("info6",0,150,21,"Trailing Distance : ",10,"",clrLime);
   Info("info66",0,150,200,DoubleToString(GTD,2),10,"",clrLime);
   Info("info7",0,175,21," Activation Distance : ",10,"",clrLime);
   Info("info77",0,175,200,DoubleToString(GAD,2),10,"",clrLime);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Info(string NAME,int CORNER,int Y,int X,string TEXT,int FONTSIZE,string FONT,color FONTCOLOR)
  {
   ObjectCreate(0,NAME,OBJ_LABEL,0,0,0);
   ObjectSetString(0,NAME,OBJPROP_TEXT,TEXT);
   ObjectSetInteger(0,NAME,OBJPROP_FONTSIZE,FONTSIZE);
   ObjectSetInteger(0,NAME,OBJPROP_COLOR,FONTCOLOR);
   ObjectSetString(0,NAME,OBJPROP_FONT,FONT);
   ObjectSetInteger(0,NAME,OBJPROP_CORNER,CORNER);
   ObjectSetInteger(0,NAME,OBJPROP_XDISTANCE,X);
   ObjectSetInteger(0,NAME,OBJPROP_YDISTANCE,Y);

  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
