//+------------------------------------------------------------------+
//|                                                 Point&Figure.mq4 |
//|                                Copyright 2022, Dr Yousuf Mesalm. |
//|                                    https://www.youssefmesalm.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Dr Yousuf Mesalm."
#property link      "https://www.youssefmesalm.com"
#property version   "1.00"
#property strict

int P1=0,P2=0,P3=0,P=0,BP=0;
int Pattern=0;
datetime t=0;
int LastCheckIndex=-1;
string Perfix="P&P";
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(60);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   datetime LastObjTime=0;
   string LastObjName;
   double B1[2]= {0,0},B2[2]= {0,0},B3[2]= {0,0},B[2]= {0,0},PB[2]= {0,0},PB1[2]= {0,0};
   int id;
   for(int i=0; i<ObjectsTotal(0,0,OBJ_TEXT);  i++)
     {
      string Name=ObjectName(0,i);
      datetime time=ObjectGetInteger(0,Name,OBJPROP_TIME1);
      id=iBarShift(Symbol(),PERIOD_CURRENT,time);

      if(StringFind(Name,"Box_",0)!=-1)
        {

         if(time>LastObjTime)
           {
            LastObjTime=time;
            LastObjName=Name;

           }
         if(time!=t)
           {

            if(BP==1&&PB[1]>PB1[1]&&PB[1]>B[1])
              {
               if(ObjectFind(0,Perfix+"- UpLine")>=0)
                 {
                 datetime objTime=ObjectGetInteger(0,Perfix+"- UpLine",OBJPROP_TIME1);
                  if(objTime<t)
                    {
                     TrendDelete(0,Perfix+"- UpLine");
                     TrendCreate(0,Perfix+"- UpLine",0,t,PB[1],Time[0],PB[1],clrYellow);
                     Print(1);
                    }
                 }
               else
                 {
                  TrendCreate(0,Perfix+"- UpLine",0,t,PB[1],Time[0],PB[1],clrYellow);

                 }
              }
            if(BP==-1&&PB[0]<PB1[0]&&PB[0]<B[0])
              {
               if(ObjectFind(0,Perfix+"- DnLine")>=0)
                 {
                  datetime ObjTime=ObjectGetInteger(0,Perfix+"- DnLine",OBJPROP_TIME1);
                  if(ObjTime<t)
                    {

                     TrendDelete(0,Perfix+"- DnLine");
                     TrendCreate(0,Perfix+"- DnLine",0,t,PB[0],Time[0],PB[0],clrRed);
                     Print(2);
                    }
                 }
               else
                 {
                  TrendCreate(0,Perfix+"- DnLine",0,t,PB[0],Time[0],PB[0],clrRed);

                 }
              }
            LastCheckIndex=iBarShift(Symbol(),PERIOD_CURRENT,t);
            t=time;

            PB1[0]=PB[0];
            PB1[1]=PB[1];
            PB[0]=B[0];
            PB[1]=B[1];
            BP=P;
            B[1]=0;
            B[0]=0;
            P=0;
           }
         if(time==t)
           {
            string Value=ObjectGetString(0,Name,OBJPROP_TEXT);
            double Price=ObjectGetDouble(0,Name,OBJPROP_PRICE);
            //Get Highest object
            if(B[1]<Price)
               B[1]=Price;
            //Get Lowest object
            if(B[0]>Price||B[0]==0)
               B[0]=Price;
            if(Value=="   O")
              {
               P=-1;
              }
            if(Value=="   X")
              {
               P=1;
              }
           }

        }
     }
   int idx=iBarShift(Symbol(),PERIOD_CURRENT,LastObjTime,false);
   for(int z=0; z<ObjectsTotal(0,0,OBJ_TEXT); z++)
     {
      string Name=ObjectName(0,z);
      datetime time=ObjectGetInteger(0,Name,OBJPROP_TIME1);
      if(StringFind(Name,"Box_",0)!=-1)
        {

         if(time==Time[idx+2])
           {
            string Value=ObjectGetString(0,Name,OBJPROP_TEXT);
            double Price=ObjectGetDouble(0,Name,OBJPROP_PRICE);
            //Get Highest object
            if(B3[1]<Price)
               B3[1]=Price;
            //Get Lowest object
            if(B3[0]>Price||B3[0]==0)
               B3[0]=Price;
            if(Value=="   O")
              {
               P3=-1;

              }
            if(Value=="   X")
              {
               P3=1;
              }
           }

         if(time==Time[idx+1])
           {
            string Value=ObjectGetString(0,Name,OBJPROP_TEXT);
            double Price=ObjectGetDouble(0,Name,OBJPROP_PRICE);
            //Get Highest object
            if(B2[1]<Price)
               B2[1]=Price;
            //Get Lowest object
            if(B2[0]>Price||B2[0]==0)
               B2[0]=Price;
            if(Value=="   O")
              {
               P2=-1;

              }
            if(Value=="   X")
              {
               P2=1;
              }
           }

         if(time==Time[idx])
           {
            string Value=ObjectGetString(0,Name,OBJPROP_TEXT);
            double Price=ObjectGetDouble(0,Name,OBJPROP_PRICE);
            //Get Highest object
            if(B1[1]<Price)
               B1[1]=Price;
            //Get Lowest object
            if(B1[0]>Price||B2[0]==0)
               B1[0]=Price;
            if(Value=="   O")
              {
               P1=-1;

              }
            if(Value=="   X")
              {
               P1=1;
              }
           }


        }
     }
   if(B3[1]<B2[1]&&B2[1]>B1[1]&&P1==1&&P2==-1&&P3==1)
     {
      Pattern=1;
     }
   if(B3[0]<B2[0]&&B2[0]>B1[0]&&P1==-1&&P2==1&&P3==-1)
     {
      Pattern=-1;
     }

  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---

  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Create a trend line by the given coordinates                     |
//+------------------------------------------------------------------+
bool TrendCreate(const long            chart_ID=0,        // chart's ID
                 const string          name="TrendLine",  // line name
                 const int             sub_window=0,      // subwindow index
                 datetime              time1=0,           // first point time
                 double                price1=0,          // first point price
                 datetime              time2=0,           // second point time
                 double                price2=0,          // second point price
                 const color           clr=clrRed,        // line color
                 const ENUM_LINE_STYLE style=STYLE_SOLID, // line style
                 const int             width=1,           // line width
                 const bool            back=false,        // in the background
                 const bool            selection=true,    // highlight to move
                 const bool            ray_right=false,   // line's continuation to the right
                 const bool            hidden=true,       // hidden in the object list
                 const long            z_order=0)         // priority for mouse click
  {
//--- set anchor points' coordinates if they are not set
   ChangeTrendEmptyPoints(time1,price1,time2,price2);
//--- reset the error value
   ResetLastError();
//--- create a trend line by the given coordinates
   if(ObjectFind(chart_ID,name)<0)
      if(!ObjectCreate(chart_ID,name,OBJ_TREND,sub_window,time1,price1,time2,price2))
        {
         Print(__FUNCTION__,
               ": failed to create a trend line! Error code = ",GetLastError());
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
//--- enable (true) or disable (false) the mode of moving the line by mouse
//--- when creating a graphical object using ObjectCreate function, the object cannot be
//--- highlighted and moved by default. Inside this method, selection parameter
//--- is true by default making it possible to highlight and move the object
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- enable (true) or disable (false) the mode of continuation of the line's display to the right
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
   return(true);
  }
//+------------------------------------------------------------------+
//| Move trend line anchor point                                     |
//+------------------------------------------------------------------+
bool TrendPointChange(const long   chart_ID=0,       // chart's ID
                      const string name="TrendLine", // line name
                      const int    point_index=0,    // anchor point index
                      datetime     time=0,           // anchor point time coordinate
                      double       price=0)          // anchor point price coordinate
  {
//--- if point position is not set, move it to the current bar having Bid price
   if(!time)
      time=TimeCurrent();
   if(!price)
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID);
//--- reset the error value
   ResetLastError();
//--- move trend line's anchor point
   if(!ObjectMove(chart_ID,name,point_index,time,price))
     {
      Print(__FUNCTION__,
            ": failed to move the anchor point! Error code = ",GetLastError());
      return(false);
     }
//--- successful execution
   return(true);
  }
//+------------------------------------------------------------------+
//| The function deletes the trend line from the chart.              |
//+------------------------------------------------------------------+
bool TrendDelete(const long   chart_ID=0,       // chart's ID
                 const string name="TrendLine") // line name
  {
//--- reset the error value
   ResetLastError();
//--- delete a trend line
   if(!ObjectDelete(chart_ID,name))
     {
      Print(__FUNCTION__,
            ": failed to delete a trend line! Error code = ",GetLastError());
      return(false);
     }
//--- successful execution
   return(true);
  }
//+------------------------------------------------------------------+
//| Check the values of trend line's anchor points and set default   |
//| values for empty ones                                            |
//+------------------------------------------------------------------+
void ChangeTrendEmptyPoints(datetime &time1,double &price1,
                            datetime &time2,double &price2)
  {
//--- if the first point's time is not set, it will be on the current bar
   if(!time1)
      time1=TimeCurrent();
//--- if the first point's price is not set, it will have Bid value
   if(!price1)
      price1=SymbolInfoDouble(Symbol(),SYMBOL_BID);
//--- if the second point's time is not set, it is located 9 bars left from the second one
   if(!time2)
     {
      //--- array for receiving the open time of the last 10 bars
      datetime temp[10];
      CopyTime(Symbol(),Period(),time1,10,temp);
      //--- set the second point 9 bars left from the first one
      time2=temp[0];
     }
//--- if the second point's price is not set, it is equal to the first point's one
   if(!price2)
      price2=price1;
  }
//+------------
//+------------------------------------------------------------------+
