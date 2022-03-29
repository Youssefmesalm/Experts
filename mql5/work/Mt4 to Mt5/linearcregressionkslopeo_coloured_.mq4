//+------------------------------------------------------------------+
//|                                      Linear Regression Slope.mq4 |
//|                                                                  |
//|                                                          StRuTcH |
//+------------------------------------------------------------------+

 
#property indicator_separate_window

#property indicator_buffers 3
#property indicator_color1 Blue
#property indicator_width1 2
#property indicator_color2 Red
#property indicator_width2 2
#property indicator_color3 DarkGreen
#property indicator_width3 2

//---- indicator parameters
extern int RegLin_Period=14;

//---- indicator buffers
double SLOPE[];
double Negativo[];
double Positivo[];

//----
int ExtCountedBars=0;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+

int init()
  {

   IndicatorBuffers(3); 
    
   SetIndexBuffer(0,SLOPE);
   SetIndexStyle(0,DRAW_NONE);
    
   SetIndexBuffer(1,Negativo);
   SetIndexStyle(1,DRAW_HISTOGRAM);
    
   SetIndexBuffer(2,Positivo);
   SetIndexStyle(2,DRAW_HISTOGRAM);      
   
   IndicatorShortName("Linear Regression Slope("+RegLin_Period+")"); 
      
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+


double slope(int iBar, int nBars)
{
   double sumy=0,
          sumx=0,
          sumxy=0,
          sumx2=0;
          
   int iLimit = iBar + nBars;
   
   for(; iBar < iLimit; iBar++)
      {
      sumy+=Close[iBar];
      sumxy+=Close[iBar]*iBar;
      sumx+=iBar;
      sumx2+=iBar*iBar;
      }      
      
   return( (nBars*sumxy - sumx*sumy) / (nBars*sumx2 - sumx*sumx) );
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

int start()

{           
   int count = IndicatorCounted();
   
   if(count < RegLin_Period) count = RegLin_Period; // Lookback
   
   for(int iBar = Bars - 1 - count; iBar >= 0; iBar--)
     {
      SLOPE[iBar] = -slope(iBar, RegLin_Period);
      
      if(SLOPE[iBar]>0)
        {
        Positivo[iBar]=SLOPE[iBar];
        Negativo[iBar]=EMPTY_VALUE;
        }
     if(SLOPE[iBar]<0)
        {
        Negativo[iBar]=SLOPE[iBar];
        Positivo[iBar]=EMPTY_VALUE;
        }       
       
     }



     
 return(0);     
     
}

