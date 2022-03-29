//+------------------------------------------------------------------+
//|                                                    bbsqueeze.mq4 |
//|                Copyright © 2005, Nick Bilak, beluck[AT]gmail.com |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2005, Nick Bilak"
#property link      "http://metatrader.50webs.com/"

#property indicator_separate_window
#property indicator_buffers 6
#property indicator_color1 Blue
#property indicator_color2 Red
#property indicator_color3 DarkSlateBlue
#property indicator_color4 FireBrick
#property indicator_color5 LawnGreen
#property indicator_color6 MediumOrchid

//---- input parameters
extern int       totalBars=400;
extern int       bolPrd=20;
extern double    bolDev=2.0;
extern int       keltPrd=20;
extern double    keltFactor=1.5;
extern int       momPrd=12;
extern bool    alertBox=false;
extern bool    audioAlert=false;

//---- buffers
double upB[];
double loB[];
double upK[];
double loK[];
double upB2[];
double loB2[];

int i,j,slippage=3;
double breakpoint=0.0;
double ema=0.0;
int peakf=0;
int peaks=0;
int valleyf=0;
int valleys=0, limit=0;
double ccis[61],ccif[61];
double delta=0;
double ugol=0;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
   SetIndexStyle(0,DRAW_HISTOGRAM,0,2);
   SetIndexBuffer(0,upB);
   SetIndexEmptyValue(0,0);
   
   SetIndexStyle(1,DRAW_HISTOGRAM,0,2);
   SetIndexBuffer(1,loB);
   SetIndexEmptyValue(1,0);

   SetIndexStyle(4,DRAW_ARROW);
   SetIndexBuffer(4,upK);
   SetIndexEmptyValue(42,0);
   SetIndexArrow(4,159);
   
   SetIndexStyle(5,DRAW_ARROW);
   SetIndexBuffer(5,loK);
   SetIndexEmptyValue(5,EMPTY_VALUE);
   SetIndexArrow(5,159);
   
   SetIndexStyle(2,DRAW_HISTOGRAM,0,2);
   SetIndexBuffer(2,upB2);
   SetIndexEmptyValue(2,0);
   
   SetIndexStyle(3,DRAW_HISTOGRAM,0,2);
   SetIndexBuffer(3,loB2);
   SetIndexEmptyValue(3,0);
//----
   return(0);
  }


int start() {
   int counted_bars=IndicatorCounted();
   int shift,limit;
   double diff,d[],std,bbs;
   
  /* if (counted_bars<0) return(-1);
   if (counted_bars>0) counted_bars--;
   limit=Bars-31;
   if(counted_bars>=31) limit=Bars-counted_bars-1;*/
   
   if (counted_bars<0) return(-1);
   limit=totalBars; //Bars-31;
   
   ArrayResize(d,limit);

   for (shift=limit;shift>=0;shift--)   {
   
      /*upB[shift]=0;
      upB2[shift]=0;
      loB[shift]=0;
      loB2[shift]=0;*/
            
      //d[shift]=(iMomentum(NULL,0,momPrd,PRICE_CLOSE,shift) - iMomentum(NULL,0,momPrd,PRICE_CLOSE,shift+1));
      d[shift]=LinearRegressionValue(momPrd,shift);
      //d[shift]=0;//FindDirection(shift);
      
      if (shift == 1) Print (d[shift]);
      
      if(d[shift]>0) {
         if (d[shift] >= d[shift+1]) {
            upB[shift]=d[shift];
            upB2[shift]=0;
         } else {
            upB2[shift]=d[shift];
            upB[shift]=0;
         }
         
         loB[shift]=0;
         loB2[shift]=0;
      } else if (d[shift] < 0) {
         
         if (d[shift] <= d[shift+1]) {
            loB[shift]=d[shift];
            loB2[shift]=0;
         } else {
            loB2[shift]=d[shift];
            loB[shift]=0;
         }
         upB[shift]=0;
         upB2[shift]=0;
      } else {
         upB[shift]=0.01;
         upB2[shift]=0.01;
         loB[shift]=-0.01;
         loB2[shift]=-0.01;
      }
      
		diff = iATR(NULL,0,keltPrd,shift)*keltFactor;
		std = iStdDev(NULL,0,bolPrd,MODE_SMA,0,PRICE_CLOSE,shift);
		bbs = bolDev * std / diff;
		
      if(bbs<1) {
         upK[shift]=0;
         loK[shift]=EMPTY_VALUE;
         
         if (alertBox == true && shift == 0) Alert("Warning for ", Symbol(), " on ", Period(), " chart!");
         if (audioAlert == true && shift == 0) PlaySound("alert.wav");
            
      } else {
         loK[shift]=0;
         upK[shift]=EMPTY_VALUE;
      }
   }
   return(0);
  }
//+------------------------------------------------------------------+

double FindDirection (int i) {

   int j;
   double val;
   double bulls, bears;
   
   for (j=i+8; j>i; j--) {
      
      bulls += High[j]-Close[j];
      bears += Close[j]-Low[j];
      
      if (bulls > bears) {
         val = 0.5;
      } else if (bears > bulls) {
         val = -0.5;
      }
      
      //sum += (Close[j] - Open[j]);
      //val = sum/j;
      
   }
   
   return (val);   

}

double LinearRegressionValue(int Len,int shift) {
   double SumBars = 0;
   double SumSqrBars = 0;
   double SumY = 0;
   double Sum1 = 0;
   double Sum2 = 0;
   double Slope = 0;

   SumBars = Len * (Len-1) * 0.5;
   SumSqrBars = (Len - 1) * Len * (2 * Len - 1)/6;

  for (int x=0; x<=Len-1;x++) {
   double HH = Low[x+shift];
   double LL = High[x+shift];
   for (int y=x; y<=(x+Len)-1; y++) {
     HH = MathMax(HH, High[y+shift]);
     LL = MathMin(LL, Low[y+shift]);
   }
    Sum1 += x* (Close[x+shift]-((HH+LL)/2 + iMA(NULL,0,Len,0,MODE_EMA,PRICE_CLOSE,x+shift))/2);
    SumY += (Close[x+shift]-((HH+LL)/2 + iMA(NULL,0,Len,0,MODE_EMA,PRICE_CLOSE,x+shift))/2);
  }
  Sum2 = SumBars * SumY;
  double Num1 = Len * Sum1 - Sum2;
  double Num2 = SumBars * SumBars-Len * SumSqrBars;

  if (Num2 != 0.0)  { 
    Slope = Num1/Num2; 
  } else { 
    Slope = 0; 
  }

  double Intercept = (SumY - Slope*SumBars) /Len;
  //debugPrintln(Intercept+" : "+Slope);
  double LinearRegValue = Intercept+Slope * (Len - 1);

  return (LinearRegValue);

}

