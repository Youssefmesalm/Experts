//+------------------------------------------------------------------+
//|                                      Linear Regression Slope.mq4 |
//|                                                                  |
//|                                                          StRuTcH |
//+------------------------------------------------------------------+

 
#property indicator_separate_window
#property indicator_buffers 1
#property indicator_color1 Red

//---- indicator parameters
extern int RegLin_Period=10;

//---- indicator buffers
double SLOPE[];
//----
int ExtCountedBars=0;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+

int init()
  {

   IndicatorBuffers(1); 
    
   SetIndexBuffer(0,SLOPE);
   SetIndexStyle(0,DRAW_LINE);
   
   IndicatorShortName("Linear Regression Slope("+RegLin_Period+")"); 
      
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

int start()
  {
   if(Bars<=RegLin_Period) return(0);
   ExtCountedBars=IndicatorCounted();
//---- check for possible errors
   if (ExtCountedBars<0) return(-1);
//---- last counted bar will be recounted
   if (ExtCountedBars>0) ExtCountedBars--;
//----


   double sumy=0,
          sumx=0,
          sumxy=0,
          sumx2=0;
           
   int    i,pos=Bars-ExtCountedBars-1;
   
   
//---- initial accumulation

   if(pos<RegLin_Period) pos=RegLin_Period;
   
   for(i=1;i<RegLin_Period;i++,pos--)
      {
      sumy+=Close[pos];
      sumxy+=Close[pos]*i;
      sumx+=i;
      sumx2+=i*i;
      }      

//---- main calculation loop

   while(pos>=0)
     {
      sumy+=Close[pos];
      sumxy+=Close[pos]*i;
      sumx+=i;
      sumx2+=i*i;
            
      SLOPE[pos] = (((RegLin_Period*sumxy)-(sumx*sumy)) / ((RegLin_Period*sumx)-(sumx*sumx)));

      sumy-=Close[pos+RegLin_Period-1];
      sumxy-=Close[pos+RegLin_Period-1]*i;      
      pos--;
     }
     
     
//---- zero initial bars

   if(ExtCountedBars<1)
      for(i=1;i<RegLin_Period;i++) SLOPE[Bars-i]=0;


/*
Comment("sumy = ", sumy, 
        "\nsumxy = ", sumxy,  
        "\nsumx= ", sumx,  
        "\nsumx2= ", sumx2);
*/


   return(0);
  }