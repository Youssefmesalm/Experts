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

#include  <YM\YM.mqh>
#include <Arrays\ArrayDouble.mqh>
enum close
  {
   buy,
   sell,
   buyAndsell,
   None,
  };
enum Entry
  {
   Buy,Sell,Both
  };
// inputs
sinput string set1 = "<-------------- Currency Pairs Settings-------------->";
input string Suffix="";
input string Perfix="";
input string CustomPairs = "EURUSD";
sinput string set2 = "<----------------Trading Settings-------------------->";
input Entry OrderType=Buy;   //Entry Type
input double lotStarter = 0.1;  //Lot Start
input double LotMultiplier=1.6; //Lot Multiplier
input double Lot_Multiplier_Profit=2; // Lot Multiplier for profit
input int TradingLevelsNumbers=11; // Levels Number
input int GapBetweenLevels=100;     // Pips between Each level
input bool CloseWith_Points=false;  // Close All Opend Trades with x pips ?
input int ProfitPointsToCloseLossTrades=10;// Close Trades with Profit in Pips
input bool CloseWith_Dollar=false;// Close All Opend Trades with x Dollar ?
input double ProfitUSDToCloseLossTrades=10; // Close Trades with Profit in Dollar
input double trailingStop=50;  //trailing stop in pips
input double closeUSDAccountProfit  = 100;  // Close All when account with profit in Dollar
input long magic_Number = 2020;

//global variables
int TB=0,TS=0,TT=0;
int Total[],TotalSell[],TotalBuy[];
close WhichClos[];
int Highest[],lowest[];

// Arrays
string Symbols[];
double lots[];
double Profitlots[];

// Class object
CExecute *trades[];
CPosition *Positions[];
CPosition *SellPositions[];
CPosition *BuyPositions[];
COrder *Pendings[];
COrder *SellPendings[];
COrder *BuyPendings[];
CUtilities *tools[];
int openDirection[];
CArrayDouble *Levelprices[];
bool trailinghappened=false;
//arrays
double upPrice[];
double dnPrice[];
bool profitUpdate=false;
long HighestTicket=-1;
long lowestTicket=-1;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   StringSplit(CustomPairs, StringGetCharacter(",", 0), Symbols);
   int size= ArraySize(Symbols);
   ArrayResize(trades,size,size);
   ArrayResize(Positions,size,size);
   ArrayResize(SellPositions,size,size);
   ArrayResize(BuyPositions,size,size);
   ArrayResize(Pendings,size,size);
   ArrayResize(BuyPendings,size,size);
   ArrayResize(SellPendings,size,size);
   ArrayResize(tools,size,size);
   ArrayResize(upPrice,size,size);
   ArrayResize(dnPrice,size,size);
   ArrayResize(Levelprices,size,size);
   ArrayResize(WhichClos,size,size);
   ArrayResize(Total,size,size);
   ArrayResize(TotalBuy,size,size);
   ArrayResize(TotalSell,size,size);
   ArrayResize(openDirection,size,size);
   ArrayResize(Highest,size,size);
   ArrayResize(lowest,size,size);
   ArrayResize(lots,TradingLevelsNumbers,TradingLevelsNumbers);
   ArrayResize(Profitlots,TradingLevelsNumbers,TradingLevelsNumbers);


   for(int i=0; i<size; i++)
     {
      Symbols[i]=Perfix+Symbols[i]+Suffix;
      if(SymbolSelect(Symbols[i],true))
        {
         Print(Symbols[i]+" added to Market watch");
        }
      else
        {
         Print(Symbols[i]+" does't Exist");
        }

      trades[i] = new CExecute(Symbols[i], magic_Number);
      BuyPositions[i] = new CPosition(Symbols[i], magic_Number, GROUP_POSITIONS_BUYS);
      SellPositions[i] = new CPosition(Symbols[i], magic_Number, GROUP_POSITIONS_SELLS);
      Positions[i] = new CPosition(Symbols[i], magic_Number, GROUP_POSITIONS_ALL);
      Pendings[i]=new COrder(Symbols[i],magic_Number,GROUP_ORDERS_ALL);
      BuyPendings[i]=new COrder(Symbols[i],magic_Number,GROUP_ORDERS_BUY_STOP);
      SellPendings[i]=new COrder(Symbols[i],magic_Number,GROUP_ORDERS_SELL_STOP);
      tools[i] = new CUtilities(Symbols[i]);
      Levelprices[i]= new CArrayDouble;
      Levelprices[i].Resize((1+TradingLevelsNumbers)*2);

      WhichClos[i]=None;
      Total[i]=0;
      TotalBuy[i]=0;
      TotalSell[i]=0;
      openDirection[i]=0;
      Highest[i]=0;
      lowest[i]=0;
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
   int size= ArraySize(Symbols);
   for(int i=0; i<size; i++)
     {
      delete(trades[i]);
      delete(BuyPositions[i]);
      delete(SellPositions[i]);
      delete(Positions[i]);
      delete(Pendings[i]);
      delete(tools[i]);
     }
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   int size= ArraySize(Symbols);
   for(int i=0; i<size; i++)
     {
      int TotalPositions=Positions[i].GroupTotal();
      int TotalPendings=Pendings[i].GroupTotal();
      if(TotalPendings==0&&TotalPositions==0)
        {
         Levelprices[i].Clear();
         Total[i]=0;
         TotalBuy[i]=0;
         TotalSell[i]=0;
         Highest[i]=0;
         lowest[i]=0;
         openDirection[i]=0;
         WhichClos[i]=None;
         profitUpdate=false;
         HighestTicket=-1;
         lowestTicket=-1;
         upPrice[i]=tools[i].Bid();
         dnPrice[i]=tools[i].Bid();
         double ssl=tools[i].Bid()+(GapBetweenLevels*(TradingLevelsNumbers+0.5)*tools[i].Pip());
         double bsl=tools[i].Ask()-(GapBetweenLevels*(TradingLevelsNumbers+0.5)*tools[i].Pip());
         bool first=true;
         double lot=0;
         for(int x=0; x<TradingLevelsNumbers; x++)
           {
            lot=first?lotStarter:tools[i].NormalizeVolume(lot*LotMultiplier,ROUNDING_OFF);
            Profitlots[x]=first?lotStarter:tools[i].NormalizeVolume(lot*Lot_Multiplier_Profit,ROUNDING_OFF);

            lots[x]=lot;
            upPrice[i] =first?(upPrice[i]+(GapBetweenLevels/2)*tools[i].Pip()):upPrice[i]+(GapBetweenLevels*tools[i].Pip());
            dnPrice[i] =first?(dnPrice[i]-(GapBetweenLevels/2)*tools[i].Pip()):dnPrice[i]-(GapBetweenLevels*tools[i].Pip());
            if(OrderType==Buy||OrderType==Both)
              {
               trades[i].Order(TYPE_ORDER_BUYSTOP,lot,upPrice[i],bsl,0,SLTP_PRICE,0,30,(string)x);
               trades[i].Order(TYPE_ORDER_BUYLIMIT,lot,dnPrice[i],bsl,0,SLTP_PRICE,0,30,"-"+(string)x);
              }
            if(OrderType==Sell||OrderType==Both)
              {
               trades[i].Order(TYPE_ORDER_SELLLIMIT,lot,upPrice[i],ssl,0,SLTP_PRICE,0,30,(string)x);
               trades[i].Order(TYPE_ORDER_SELLSTOP,lot,dnPrice[i],ssl,0,SLTP_PRICE,0,30,"-"+(string)x);
              }
            first=false;
            Levelprices[i].Add(dnPrice[i]);
            Levelprices[i].Add(upPrice[i]);

           }
         Levelprices[i].Add(bsl);
         Levelprices[i].Add(ssl);
         Levelprices[i].Sort(0);

        }

      CheckNewOpen(Positions[i],BuyPositions[i],SellPositions[i],Total[i],TotalBuy[i],TotalSell[i],openDirection[i],WhichClos[i]);
      if(openDirection[i]!=0)
        {
         UpdateLot(Positions[i],Pendings[i],trades[i],tools[i],Highest[i],lowest[i],openDirection[i]);
        }
      Traliling(BuyPositions[i],SellPositions[i],tools[i],Levelprices[i],Pendings[i],Highest[i],lowest[i]);

      UpdateProfitLot(Positions[i],Pendings[i],trades[i],tools[i],Highest[i],lowest[i]);
      Closing(BuyPositions[i],SellPositions[i],tools[i],Pendings[i],upPrice[i],dnPrice[i],Levelprices[i]);
      if(Positions[i].GroupTotal()==0&&Pendings[i].GroupTotal()<TradingLevelsNumbers*2)
        {
         Pendings[i].GroupCloseAll(20);
        }

     }
   if(AccountInfoDouble(ACCOUNT_PROFIT)>=closeUSDAccountProfit)
     {
      size= ArraySize(Symbols);
      for(int i=0; i<size; i++)
        {
         Positions[i].GroupCloseAll(30);
         Pendings[i].GroupCloseAll(30);
        }
     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UpdateLot(CPosition & Pos,COrder & Pending,CExecute & open,CUtilities & tool,int & H,int & L,int & D)
  {
   int size=Pos.GroupTotal();
   int direction=0;
   long tickets[];
   int lotindex=0;
   for(int i=0; i<size; i++)
     {
      int comment=(int)Pos[i].GetComment();
      if(comment==0)
        {
         if(Pos[i].GetComment()=="0")
            direction=1;
         else
            direction=-1;
        }
      if(comment>0&&comment>=H)
        {
         H=comment;
         HighestTicket=Pos[i].GetTicket();
         direction=1;
         lotindex=MathAbs(H);
        }
      if(comment<0&&comment<=L)
        {
         L=comment;
         lowestTicket=Pos[i].GetTicket();
         direction=-1;
         lotindex=MathAbs(L);
        }
     }
   int totalPending=Pending.GroupTotal();
   if(direction>0&&L==0&&H==0)
     {
      for(int x=0; x<totalPending; x++)
        {
         int comment=(int)Pending[x].GetComment();
         string c=Pending[x].GetComment();

         if(comment<=0&&c!="0")
           {
            long ticket=Pending[x].GetTicket();
            int tsize=ArraySize(tickets);
            ArrayResize(tickets,tsize+1);
            tickets[tsize]=ticket;
           }
        }
      int ttotal=ArraySize(tickets);
      for(int z=0; z<ttotal; z++)
        {
         long x=tickets[z];
         int comment=(int)Pending[x].GetComment();
         string c=comment<=0?IntegerToString(comment-1):IntegerToString(comment+1);
         double openPrice=Pending[x].GetPriceOpen();
         double sl=Pending[x].GetStopLoss();
         double NewLot=0;
         ENUM_TYPE_ORDER type=Pending[x].GetType()==ORDER_TYPE_SELL_STOP?TYPE_ORDER_SELLSTOP:TYPE_ORDER_BUYLIMIT;

         if(MathAbs(comment)<TradingLevelsNumbers-1)
           {
            NewLot = lots[MathAbs(comment)+1];
           }
         Pending[x].Close();
         if(MathAbs(comment)<TradingLevelsNumbers-1)
           {
            open.Order(type,tool.NormalizeVolume(NewLot),openPrice,sl,0,SLTP_PRICE,0,30,c);
            D=0;
           }
        }

     }
   if(direction<0&&L==0&&H==0)
     {
      for(int x=0; x<totalPending; x++)
        {
         int comment=(int)Pending[x].GetComment();
         string c=Pending[x].GetComment();
         if(comment>=0&&c!="-0")
           {
            long ticket=Pending[x].GetTicket();
            int tsize=ArraySize(tickets);
            ArrayResize(tickets,tsize+1);
            tickets[tsize]=ticket;
           }
        }
      int ttotal=ArraySize(tickets);
      for(int z=0; z<ttotal; z++)
        {
         long x=tickets[z];
         int comment=(int)Pending[x].GetComment();
         string c=comment>=0?IntegerToString(comment+1):IntegerToString(comment-1);
         double openPrice=Pending[x].GetPriceOpen();
         double sl=Pending[x].GetStopLoss();
         double NewLot=0;
         ENUM_TYPE_ORDER type=Pending[x].GetType()==ORDER_TYPE_BUY_STOP?TYPE_ORDER_BUYSTOP:TYPE_ORDER_SELLLIMIT;
         if(MathAbs(comment)<TradingLevelsNumbers-1)
           {

            NewLot=lots[MathAbs(comment)+1];
           }
         Pending[x].Close();
         if(MathAbs(comment)<TradingLevelsNumbers-1)
           {
            open.Order(type,tool.NormalizeVolume(NewLot),openPrice,sl,0,SLTP_PRICE,0,30,c);
            D=0;
           }
        }
     }
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
void CheckNewOpen(CPosition & Pos, CPosition & BuyPos,CPosition & SellPos,int & T,int & B,int & S,int & direction,close & WhichClose)
  {
   int totalPos=Pos.GroupTotal();
   int totalSell=SellPos.GroupTotal();
   int totalbuy=BuyPos.GroupTotal();
   if(totalPos>T||(T==0&&totalPos>T))
     {
      T=totalPos;
     }
   if(totalSell>S||(S==0&&totalSell>S))
     {
      S=totalSell;
      direction=-1;
     }
   if(totalbuy>B||(B==0&&totalbuy>B))
     {
      B=totalbuy;
      direction=1;
     }
   if(totalPos<T)
     {
      totalSell=SellPos.GroupTotal();
      totalbuy=BuyPos.GroupTotal();
      if(totalSell<S&&WhichClose==None)
        {
         WhichClose=sell;
         S=totalSell;
         T=totalPos;
        }
      else
         if(totalbuy<B&&WhichClose==None)
           {
            WhichClose=buy;
            T=totalPos;
            B=totalbuy;
           }
         else
            if((totalbuy<B||totalSell<S)&&WhichClose!=buyAndsell&&WhichClose!=None)
              {
               WhichClose=buyAndsell;
               TT=totalPos;
               B=totalbuy;
               S=totalSell;
              }

     }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Traliling(CPosition & BuyPos,CPosition & SellPos, CUtilities & tool,CArrayDouble & Levels,COrder & Pending,int & H,int & L)
  {
   long tickets[];
// Positions numbers
   int totalBuy = BuyPos.GroupTotal();
   int totalSell = SellPos.GroupTotal();
//
   if(TB>0&&totalBuy==0)
     {
      TB=0;
     }
   if(TS>0&&totalSell==0)
     {
      TS=0;
     }
//Buy trailing
   int TL=Levels.Total();
   double buyPriceOpen=0;
   double lowestBuy=0;
//Get High Buy PriceOpen
   for(int i = 0; i < totalBuy; i++)
     {
      if(BuyPos.SelectByIndex(i))
        {
         if(BuyPos[i].GetPriceOpen()>buyPriceOpen&&tool.Bid()>BuyPos.GetPriceOpen())
           {
            buyPriceOpen=BuyPos[i].GetPriceOpen();
           }
         if(BuyPos[i].GetPriceOpen()<lowestBuy||lowestBuy==0)
           {
            lowestBuy=BuyPos[i].GetPriceOpen();
           }
        }
     }

   if(tool.Bid()>=buyPriceOpen&&buyPriceOpen>0&&lowestBuy>0&&buyPriceOpen>lowestBuy)
     {
      double sl=buyPriceOpen -(trailingStop*tool.Pip());
      TB=totalBuy;
      for(int i = 0; i < totalBuy; i++)
        {
         if(BuyPos.SelectByIndex(i))
           {
            if(BuyPos.GetStopLoss()<sl)
               if(BuyPos.Modify(sl,BuyPos.GetTakeProfit(),SLTP_PRICE))
                 {
                  trailinghappened=true;
                  int s=Pending.GroupTotal();
                  for(int x=0; x<s; x++)
                    {
                     int c=(int)Pending[x].GetComment();
                     if(c<L)
                       {
                        long ticket=Pending[x].GetTicket();
                        int tsize=ArraySize(tickets);
                        ArrayResize(tickets,tsize+1);
                        tickets[tsize]=ticket;
                       }
                    }
                  for(int xx=0; xx<ArraySize(tickets); xx++)
                    {
                     Pending[tickets[xx]].Close(30);
                    }
                 }
           }
        }
     }


   double sellPriceOpen=0;
   double HighestSell=0;
//Get low sell PriceOpen
   for(int i = 0; i < totalSell; i++)
     {
      if(SellPos.SelectByIndex(i))
        {
         if(tool.Bid()<SellPos.GetPriceOpen())
           {
            if(sellPriceOpen==0)
              {
               sellPriceOpen=SellPos[i].GetPriceOpen();
              }
            if(SellPos[i].GetPriceOpen()<sellPriceOpen)
              {
               sellPriceOpen=SellPos[i].GetPriceOpen();
              }
           }
         if(SellPos[i].GetPriceOpen()>HighestSell)
           {
            HighestSell=SellPos[i].GetPriceOpen();
           }
        }
     }
   if(tool.Bid()<sellPriceOpen&&sellPriceOpen>0&&HighestSell>0&&sellPriceOpen<HighestSell)
     {
      double sl=sellPriceOpen +(trailingStop*tool.Pip());
      TS=totalSell;
      for(int i = 0; i < totalSell; i++)
        {
         if(SellPos.SelectByIndex(i))
           {
            if(SellPos[i].GetStopLoss()>sl)
               if(SellPos.Modify(sl,SellPos.GetTakeProfit(),SLTP_PRICE))
                 {
                  trailinghappened=true;
                  int s=Pending.GroupTotal();
                  for(int x=0; x<s; x++)
                    {
                     int c=(int)Pending[x].GetComment();
                     if(c>H)
                       {
                        long ticket=Pending[x].GetTicket();
                        int tsize=ArraySize(tickets);
                        ArrayResize(tickets,tsize+1);
                        tickets[tsize]=ticket;
                       }
                    }
                  for(int xx=0; xx<ArraySize(tickets); xx++)
                    {
                     Pending[tickets[xx]].Close(30);
                    }
                 }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UpdateProfitLot(CPosition & Pos,COrder & Pending,CExecute & open,CUtilities & tool,int & H,int & L)
  {
   bool found=false;
   long tickets[];
   int size=Pos.GroupTotal();
   int direction=0;
   int lotindex=0;
   for(int i=0; i<size; i++)
     {
      int comment=(int)Pos[i].GetComment();
      if(comment==0)
        {
         if(Pos[i].GetComment()=="0")
            HighestTicket=Pos[i].GetTicket();
         else
         if(Pos[i].GetComment()=="-0")
            lowestTicket=Pos[i].GetTicket();
        }
      if(comment>0&&comment>=H)
        {
         H=comment;
         HighestTicket=Pos[i].GetTicket();
         direction=1;
         lotindex=MathAbs(H);
        }
      if(comment<0&&comment<=L)
        {
         L=comment;
         lowestTicket=Pos[i].GetTicket();
         direction=-1;
         lotindex=MathAbs(L);
        }
     }
   if(OrderType==Buy&&Pos.GroupTotal()>0&&!profitUpdate)
     {
      for(int i=0; i<Pos.GroupTotal(); i++)
        {
         double po=Pos[lowestTicket].GetPriceOpen();
         if(Pos[i].GetStopLoss()>po&&lowestTicket>0)
           {
            found=true;
           }
        }

      if(found&&Pos.GroupTotalProfit()>0)
        {
         for(int i=0; i<Pending.GroupTotal(); i++)
           {
            long ticket=Pending[i].GetTicket();
            int tsize=ArraySize(tickets);
            ArrayResize(tickets,tsize+1);
            tickets[tsize]=ticket;
           }
         for(int z=0; z<ArraySize(tickets); z++)
           {
            long x=tickets[z];
            int comment=(int)Pending[x].GetComment();
            string c=Pending[x].GetComment();
            double openPrice=Pending[x].GetPriceOpen();
            double sl=Pending[x].GetStopLoss();
            double NewLot=0;
            profitUpdate=true;
            NewLot=Profitlots[MathAbs(comment)];
            Pending[x].Close();
            open.Order(TYPE_ORDER_BUYSTOP,tool.NormalizeVolume(NewLot),openPrice,sl,0,SLTP_PRICE,0,30,c);
           }
        }
     }
   else
      if(OrderType==Sell&&Pos.GroupTotalProfit()>0&&!profitUpdate)
        {
         for(int i=0; i<Pos.GroupTotal(); i++)
           {
            double po=Pos[HighestTicket].GetPriceOpen();
            if(Pos[i].GetStopLoss()<po&&HighestTicket>0)
              {
               found=true;
              }

           }
         if(found&&Pos.GroupTotalProfit()>0)
           {
            for(int i=0; i<Pending.GroupTotal(); i++)
              {
               long ticket=Pending[i].GetTicket();
               int tsize=ArraySize(tickets);
               ArrayResize(tickets,tsize+1);
               tickets[tsize]=ticket;
              }
            for(int z=0; z<ArraySize(tickets); z++)
              {
               long x=tickets[z];
               int comment=(int)Pending[x].GetComment();
               string c=Pending[x].GetComment();
               double openPrice=Pending[x].GetPriceOpen();
               double sl=Pending[x].GetStopLoss();
               double NewLot=0;
               NewLot=Profitlots[MathAbs(comment)];
               Pending[x].Close();
               profitUpdate=true;
               open.Order(TYPE_ORDER_SELLSTOP,tool.NormalizeVolume(NewLot),openPrice,sl,0,SLTP_PRICE,0,30,c);
              }
           }
        }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Closing(CPosition & BuyPos,CPosition & SellPos, CUtilities & tool,COrder & Pending,double up,double dn,CArrayDouble & Levels)
  {
// Positions numbers
   int totalBuy = BuyPos.GroupTotal();
   int totalSell = SellPos.GroupTotal();
   double profitpoint=0;
// logics

   if(CloseWith_Points)
     {
      if(totalSell>0&&totalBuy==0&&tool.Bid()>dn)
        {
         if(SellPos.GroupTotalProfit()>0)
           {

            for(int i=0; i<totalSell; i++)
              {

               profitpoint+=SellPos[i].GetPriceOpen()-tool.Bid();
              }

            if(profitpoint>=ProfitPointsToCloseLossTrades*tool.Pip())
              {
               SellPos.GroupCloseAll(20);
               Pending.GroupCloseAll(20);
              }

           }
        }
      else
         if(totalBuy>0&&totalSell==0&&tool.Ask()<up)
           {
            if(BuyPos.GroupTotalProfit()>0)
              {


               for(int i=0; i<totalBuy; i++)
                 {

                  profitpoint+=tool.Bid()-BuyPos[i].GetPriceOpen();
                 }

               if(profitpoint>=ProfitPointsToCloseLossTrades*tool.Pip())
                 {
                  BuyPos.GroupCloseAll(20);
                  Pending.GroupCloseAll(20);
                 }

              }
           }
     }
   if(CloseWith_Dollar)
     {
      if(SellPos.GroupTotalProfit()>=ProfitUSDToCloseLossTrades)
        {

         if(totalSell>0&&totalBuy==0&&tool.Bid()>dn)
           {


            SellPos.GroupCloseAll(20);
            Pending.GroupCloseAll(20);

           }
        }
      if(BuyPos.GroupTotalProfit()>=ProfitUSDToCloseLossTrades)
        {
         if(totalBuy>0&&totalSell==0&&tool.Ask()<up)
           {

            BuyPos.GroupCloseAll(20);
            Pending.GroupCloseAll(20);

           }
        }
     }
   int TL=Levels.Total();

   if(tool.Bid()>Levels.At(TL-1)+5*tool.Pip())
     {
      Pending.GroupCloseAll(20);
      SellPos.GroupCloseAll(30);
     }
   if(tool.Bid()<Levels.At(0)-5*tool.Pip())
     {
      Pending.GroupCloseAll(20);
      BuyPos.GroupCloseAll(30);
     }
  }
//+------------------------------------------------------------------+
