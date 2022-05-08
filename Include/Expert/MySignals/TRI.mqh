//+------------------------------------------------------------------+
//|                                                          TRI.mqh |
//|                                  Copyright 2021,DR Yousuf Mesalm |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021,DR Yousuf Mesalm"
#property link      "https://www.mql5.com"

#include <Expert\ExpertSignalAdvanced.mqh>

// wizard description start
//+------------------------------------------------------------------+
//| Description of the class                                         |
//| Title=Triangular Signal                                          |
//| Type=SignalAdvanced                                              |
//| Name=Triangular Signal                                           |
//| ShortName=Tri                                                    |
//| Class=CTriangularSignal                                          |
//| Page=Signal_Triangular_Numbers                                   |
//| Parameter=Set_Numbers,int,1000,Number of N                       |
//| Parameter=Set_Period,ENUM_TIMEFRAMES,PERIOD_CURRENT,chart period |
//+------------------------------------------------------------------+
// wizard description end
//+------------------------------------------------------------------+
//| Class CTriangularSignal.                                         |
//| Purpose: Class of generator of trade signals based on            |
//|          the 'Triangular Numbers' indicator.                     |
//| Is derived from the CExpertSignal class.                         |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CTriangularSignal :public CExpertSignalAdvanced
  {
   //variables
protected:
   CBufferCalculate  *buff_calc;
   double            Bid,Ask;
   int               m_Numbers;  // Numerical numbers
   ENUM_TIMEFRAMES      InpPeriod ;  // Used chart period
   //--- "weights" of market models (0-100)
   int               m_pattern_0;      // model 0 "price is on the necessary side from the indicator"
   int               m_pattern_1;      // model 1 "price crossed the indicator with opposite direction"
   int               m_pattern_2;      // model 2 "price crossed the indicator with the same direction"
   int               m_pattern_3;      // model 3 "piercing"
   double             m_Highest,m_Lowest;

   //Method
public:
                     CTriangularSignal();    //Method to Set default Numerical numbers
                    ~CTriangularSignal();


   // Method to generate Tri Numbers
   void              Highest_and_Lowest();
   bool              Init(CSymbolInfo *symbol,ENUM_TIMEFRAMES period,double point);
   void              Init_Buffers();
   //--- Method to validate the parameters
   virtual bool       InitIndicators(CIndicators* indicators);

   // Method to set parameters

   bool              Set_TriangularArrays();  //Method to set Triangular array
   void              Set_Numbers(int value) {m_Numbers=value;} // Numerical numbers
   void              Set_Period(ENUM_TIMEFRAMES value) {InpPeriod=value;};  //Chart period
   bool              Set_channels();  //method to update price channel
   bool              Check_Channels();
   bool              Update_Wrapper();
   bool              Get_Trend();
   bool              Check_Pos_in_channel();
   int               Trend10000_direction();
   int               Trend100000_direction();
   int               Trend1000000_direction();
   int               Is_Entry();

   //--- method of verification of settings
   virtual bool      ValidationSettings();

   //--- methods of checking if the market models are formed
   virtual int       LongCondition(void);
   virtual int       ShortCondition(void);
  };

//+------------------------------------------------------------------+
//|          constructor                                             |
//+------------------------------------------------------------------+
CTriangularSignal::CTriangularSignal(void):
   m_Numbers(10000),
   InpPeriod(PERIOD_CURRENT),
   m_pattern_0(80),
   m_pattern_1(10),
   m_pattern_2(60),
   m_pattern_3(60)
  {}

//+------------------------------------------------------------------+
//|                 DEstructor                                       |
//+------------------------------------------------------------------+
CTriangularSignal::~CTriangularSignal() {}

//+------------------------------------------------------------------+
//|            Signal  Initialize                                    |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CTriangularSignal::Init(CSymbolInfo *symbol,ENUM_TIMEFRAMES period,double point)
  {
   if(!CExpertSignalAdvanced::Init(symbol,period,point))
      return (false);

   Init_Buffers();
//if(!Set_TriangularArrays())
//   return(false);
//if(!Set_channels())
//   return(false);
   printf("Initialization Complete");
   return true;
  }

//+------------------------------------------------------------------+
//|        Initialize Buffers                                        |
//+------------------------------------------------------------------+
void CTriangularSignal::Init_Buffers()
  {
//--- indicator buffers mapping
//--- Create all the necessary buffer objects
   engine.BufferCreateCalculate();     // 1 array
   engine.BufferCreateCalculate();     // 1 array
   engine.BufferCreateCalculate();     // 1 array
   engine.BufferCreateCalculate();     // 1 array
   engine.BufferCreateCalculate();     // 1 array
   engine.BufferCreateCalculate();     // 1 array
   engine.BufferCreateCalculate();     // 1 array
//--- Get the first calculated buffer
//--- It has the index of 0 considering that the starting point is zero
   buff_calc=engine.GetBufferCalculate(0);
   if(buff_calc!=NULL)
     {
      //--- Set the description of the first calculated buffer as the "MACD histogram temporary array""
      buff_calc.SetLabel("Pure_Triangular_Number");
      //--- and set a chart period and symbol selected in the settings for it
      buff_calc.SetTimeframe(InpPeriod);
      buff_calc.SetSymbol(_Symbol);
     }
//--- Get the second calculated buffer
//--- It has the index of 1 considering that the starting point is zero
   buff_calc=engine.GetBufferCalculate(1);
   if(buff_calc!=NULL)
     {
      //--- Set the description of the second calculated buffer as the "MACD signal line temporary array""
      buff_calc.SetLabel("Channel_1");
      //--- and set a chart period and symbol selected in the settings for it
      buff_calc.SetTimeframe(InpPeriod);
      buff_calc.SetSymbol(_Symbol);
     }
//--- Get the third calculated buffer
//--- It has the index of 2 considering that the starting point is zero
   buff_calc=engine.GetBufferCalculate(2);
   if(buff_calc!=NULL)
     {
      //--- Set the description of the second calculated buffer as the "MACD signal line temporary array""
      buff_calc.SetLabel("Channel_2");
      //--- and set a chart period and symbol selected in the settings for it
      buff_calc.SetTimeframe(InpPeriod);
      buff_calc.SetSymbol(_Symbol);
     }
//--- Get the second calculated buffer
//--- It has the index of 3 considering that the starting point is zero
   buff_calc=engine.GetBufferCalculate(3);
   if(buff_calc!=NULL)
     {
      //--- Set the description of the second calculated buffer as the "MACD signal line temporary array""
      buff_calc.SetLabel("Channel_3");
      //--- and set a chart period and symbol selected in the settings for it
      buff_calc.SetTimeframe(InpPeriod);
      buff_calc.SetSymbol(_Symbol);
     }
//--- Get the second calculated buffer
//--- It has the index of 4 considering that the starting point is zero
   buff_calc=engine.GetBufferCalculate(4);
   if(buff_calc!=NULL)
     {
      //--- Set the description of the second calculated buffer as the "MACD signal line temporary array""
      buff_calc.SetLabel("Channel_4");
      //--- and set a chart period and symbol selected in the settings for it
      buff_calc.SetTimeframe(InpPeriod);
      buff_calc.SetSymbol(_Symbol);
     }
//--- Get the second calculated buffer
//--- It has the index of 5 considering that the starting point is zero
   buff_calc=engine.GetBufferCalculate(5);
   if(buff_calc!=NULL)
     {
      //--- Set the description of the second calculated buffer as the "MACD signal line temporary array""
      buff_calc.SetLabel("Channel_5");
      //--- and set a chart period and symbol selected in the settings for it
      buff_calc.SetTimeframe(InpPeriod);
      buff_calc.SetSymbol(_Symbol);
     }
//--- Get the second calculated buffer
//--- It has the index of 6 considering that the starting point is zero
   buff_calc=engine.GetBufferCalculate(6);
   if(buff_calc!=NULL)
     {
      //--- Set the description of the second calculated buffer as the "MACD signal line temporary array""
      buff_calc.SetLabel("Channel_6");
      //--- and set a chart period and symbol selected in the settings for it
      buff_calc.SetTimeframe(InpPeriod);
      buff_calc.SetSymbol(_Symbol);
     }
   engine.BuffersInitCalculates();



//Get Highest and lowest of symbol
   CSeriesDE *Series=engine.SeriesGetSeries(_Symbol,PERIOD_MN1);
   CArrayObj *List=Series.GetList();
   int index_High=CSelect::FindBarMax(List,BAR_PROP_HIGH);
   int index_Low=CSelect::FindBarMin(List,BAR_PROP_LOW);
   double Highest=Series.High(index_High,true);
   double Lowest=Series.Low(index_Low,true);
//Calculate Triangular
   for(int n=0,a=0,b=0,c=0,d=0,e=0,f=0; n<m_Numbers; n++)
     {
      double result= (n*(n+1))/2;
      //Add to Calculate Buffer number 0
      engine.BufferSetDataCalculate(0,n,result);
      // loop to fill all arrays with its tri num after division
      for(double z=10; z<=1000000; z*=10)
        {
         result=NormalizeDouble(result/z,Digits());
         if(result>Lowest&&result<Highest)
           {
            if(z==10)
              {
               engine.BufferSetDataCalculate(1,a,result);
               a++;
              }
            else
               if(z==100)
                 {

                  engine.BufferSetDataCalculate(2,b,result);
                  b++;
                 }
               else
                  if(z==1000)
                    {

                     engine.BufferSetDataCalculate(3,c,result);
                     c++;
                    }
                  else
                     if(z==10000)
                       {

                        engine.BufferSetDataCalculate(4,d,result);
                        d++;
                       }
                     else
                        if(z==100000)
                          {

                           engine.BufferSetDataCalculate(5,e,result);
                           e++;
                          }
                        else
                           if(z==1000000)
                             {

                              engine.BufferSetDataCalculate(6,f,result);
                              f++;
                             }

           }

        }

     }

//--- Display short descriptions of created indicator buffers
   engine.BuffersPrintShort();
//---

  }
//+------------------------------------------------------------------+
//|        Initialize Indicator                                      |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CTriangularSignal::InitIndicators(CIndicators* indicators)
  {
//////--- Validation of the pointer
//   if(indicators==NULL)       return(false);
////--- Initialization of the High
//   if(!InitHigh(indicators))    return(false);
//   //--- Initialization of the Low
//   if(!InitLow(indicators))    return(false);
//--- Successful completion
   return(true);
  }
//+------------------------------------------------------------------+
//|    //--- method of verification of settings                                                              |
//+------------------------------------------------------------------+
bool CTriangularSignal::ValidationSettings(void)
  {
//--- validation settings of additional filters
   if(m_Numbers<=0)
     {
      printf("Numerical Numbers should be Greater than zero");
      return (false);
     }

// ok
   return(true);
  }

//+------------------------------------------------------------------+
//|    impletmentation of triangular Buffers                                                             |
//+------------------------------------------------------------------+
bool CTriangularSignal::Set_TriangularArrays()
  {
   printf("Start Generating triangular Numbers");


   printf("Finish Generating triangular Numbers");

   return(true);

  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|             Check Long Condition                                 |
//+------------------------------------------------------------------+
int CTriangularSignal:: LongCondition(void)
  {

   int   result   =0;

   return(result);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|  Check Short Condition                                           |
//+------------------------------------------------------------------+
int CTriangularSignal::ShortCondition(void)
  {

   int   result =0;
   return(result);
  }
//+------------------------------------------------------------------+
