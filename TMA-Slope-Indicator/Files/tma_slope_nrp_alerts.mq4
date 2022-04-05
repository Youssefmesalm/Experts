//+------------------------------------------------------------------+
//|                                          colored macd            |
//+------------------------------------------------------------------+
#property copyright "www.forex-tsd.com"
#property link      "www.forex-tsd.com"


#property indicator_separate_window
#property indicator_buffers    4
#property indicator_color1     Green
#property indicator_color2     Coral
#property indicator_color3     Aqua
#property indicator_color4     Red
#property indicator_width1     2
#property indicator_width2     2
#property indicator_width3     1
#property indicator_width4     1
#property indicator_levelcolor DarkSlateGray

//
//
//
//
//

extern int    FastTma         = 25;
extern int    SlowTma         = 50;
extern int    TmaPrice        = PRICE_TYPICAL;
extern bool   ArrowsOnSlope   = true;
extern double hiLevel         = 0.005;
extern double loLevel         = -0.005;

extern string note            = "turn on Alert = true; turn off = false";
extern bool   alertsOn        = true;
extern bool   alertsOnSlope   = true;
extern bool   alertsOnCurrent = false;
extern bool   alertsMessage   = true;
extern bool   alertsSound     = true;
extern bool   alertsEmail     = false;

//
//
//
//
//

double Upa[];
double Dna[];
double arUp[];
double arDn[];
double diff[];
double trend[];
double slope[];
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//
//

int init()
  {
   IndicatorBuffers(7);
   SetIndexBuffer(0,Upa);
   SetIndexStyle(0,DRAW_HISTOGRAM);
   SetIndexBuffer(1,Dna);
   SetIndexStyle(1,DRAW_HISTOGRAM);

   SetIndexBuffer(2,arUp);
   SetIndexBuffer(3,arDn);
   SetIndexBuffer(4,diff);
   SetIndexBuffer(5,trend);
   SetIndexBuffer(6,slope);
   SetLevelValue(0,0);
   SetLevelValue(1,0.5);
   SetLevelValue(2,-0.5);

   if(ArrowsOnSlope)
     {
      SetIndexStyle(2,DRAW_ARROW); SetIndexArrow(2,159);
      SetIndexStyle(3,DRAW_ARROW); SetIndexArrow(3,159);
     }
   else
     {
      SetIndexStyle(2,DRAW_NONE);
      SetIndexStyle(3,DRAW_NONE);
     }

   IndicatorShortName("Tma Slope");
   return(0);
  }

//
//
//
//
//

int deinit() { return(0);}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//
//

int start()
  {
   int counted_bars=IndicatorCounted();
   int i,limit;
   limit=Bars-counted_bars;
   if(counted_bars<0) return(-1);
   if(counted_bars>0) counted_bars--;

   if(counted_bars==0) limit-=1+1;
//
//
//
//
//
   for(i=limit; i>=0; i--)
     {
      double price=iMA(NULL,0,1,0,MODE_SMA,TmaPrice,i);
      diff[i]  = iTma(price,FastTma,i,0) - iTma(price,SlowTma,i,1);
      Upa[i]   = EMPTY_VALUE;
      Dna[i]   = EMPTY_VALUE;
      arUp[i]  = EMPTY_VALUE;
      arDn[i]  = EMPTY_VALUE;
      trend[i] = trend[i+1];
      slope[i] = slope[i+1];
      if(diff[i] > 0)         trend[i] =  1;
      if(diff[i] < 0)         trend[i] = -1;
      if(diff[i] > diff[i+1]) slope[i] =  1;
      if(diff[i] < diff[i+1]) slope[i] = -1;

      if(trend[i]== 1) Upa[i]  = diff[i];
      if(trend[i]==-1) Dna[i]  = diff[i];
      if(slope[i]== 1) arUp[i] = diff[i];
      if(slope[i]==-1) arDn[i] = diff[i];
     }

   if(alertsOn)
     {
      if(alertsOnCurrent)
         int whichBar=0;
      else     whichBar=1; whichBar=iBarShift(NULL,0,iTime(NULL,0,whichBar));
      //
      //
      //
      //
      //

      if(alertsOnSlope)
        {
         if(slope[whichBar]!=slope[whichBar+1])
           {
            if(slope[whichBar] == 1) doAlert(whichBar,"slope changed to up");
            if(slope[whichBar] ==-1) doAlert(whichBar,"slope changed to down");
           }
        }
      else
        {
         if(trend[whichBar]!=trend[whichBar+1])
           {
            if(trend[whichBar] == 1) doAlert(whichBar,"crossed zero line up");
            if(trend[whichBar] ==-1) doAlert(whichBar,"crossed zero line down");
           }
        }
     }
   return(0);
  }
//
//
//
//
//

void doAlert(int forBar,string doWhat)
  {
   static string   previousAlert="nothing";
   static datetime previousTime;
   string message;

   if(previousAlert!=doWhat || previousTime!=Time[forBar])
     {
      previousAlert  = doWhat;
      previousTime   = Time[forBar];


      //
      //
      //
      //
      //

      message=StringConcatenate(Symbol()," at ",TimeToStr(TimeLocal(),TIME_SECONDS)," Tma ",doWhat);
      if(alertsMessage) Alert(message);
      if(alertsEmail) SendMail(StringConcatenate(Symbol()," Tma "),message);
      if(alertsSound) PlaySound("alert2.wav");
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//
//

double workTma[][2];
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double iTma(double price,double period,int r,int instanceNo=0)
  {
   if(ArraySize(workTma)!=Bars) ArrayResize(workTma,Bars); r=Bars-r-1;

//
//
//
//
//

   workTma[r][instanceNo]=price;

   double half = (period+1.0)/2.0;
   double sum  = price;
   double sumw = 1;

   for(int k=1; k<period && (r-k)>=0; k++)
     {
      double weight=k+1; if(weight>half) weight=period-k;
      sumw  += weight;
      sum   += weight*workTma[r-k][instanceNo];
     }
   return(sum/sumw);
  }
//+------------------------------------------------------------------+
