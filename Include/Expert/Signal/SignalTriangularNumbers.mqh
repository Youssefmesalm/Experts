//+------------------------------------------------------------------+
//|                                      SignalTriangularNumbers.mqh |
//|                                              Copyright 2021, YM. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, YM."
#property link      "https://www.mql5.com"
//+------------------------------------------------------------------+
//| Libraries                                                                 |
//+------------------------------------------------------------------+

#include <Expert\ExpertSignal.mqh>

// wizard description start
//+------------------------------------------------------------------+
//| Description of the class                                         |
//| Title=Signals of 'Triangular Number'                             |
//| Type=SignalAdvanced                                              |
//| Name=Triangular Numbers                                          |
//| ShortName=Tri                                                    |
//| Class=CTriangularSignal                                          |
//| Page=Signal_Triangular_Numbers                                   |
//| Parameter=Set_Numbers,int,1000                |
//|
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
class CTriangularSignal :public CExpertSignal
  {
   //variables
protected:
   CPositionInfo     m_Position;


   int               m_ArrayReserveSize;  // variable for size of array reservation
   ulong             m_TriangularArray[];
   double            m_Triangular10[];
   double            m_Triangular100[];
   double            m_Triangular1000[];
   double            m_Triangular10000[];
   double            m_Triangular100000[];
   double            m_Triangular1000000[];
   double            Upper10,Upper100,Upper1000,Upper10000,Upper100000,Upper1000000;
   double            Lower10,Lower100,Lower1000,Lower10000,Lower100000,Lower1000000;
   double            trend10[10],trend100[10],trend1000[10],trend10000[10],trend100000[10],trend1000000[10];
   double            m_Wrapper10[2][10],m_Wrapper100[2][10],m_Wrapper1000[2][10],m_Wrapper10000[2][10],m_Wrapper100000[2][10],m_Wrapper1000000[2][10];
   double            Bid,Ask;

   int               m_Numbers;  // Numerical numbers
   //--- "weights" of market models (0-100)
   int               m_pattern_0;      // model 0 "price is on the necessary side from the indicator"
   int               m_pattern_1;      // model 1 "price crossed the indicator with opposite direction"
   int               m_pattern_2;      // model 2 "price crossed the indicator with the same direction"
   int               m_pattern_3;      // model 3 "piercing"
public:

   double             m_Highest,m_Lowest;

   //Method
public:
                     CTriangularSignal();    //Method to Set default Numerical numbers
                    ~CTriangularSignal();
   // Method to generate Tri Numbers
   void              Highest_and_Lowest();
   bool              Init(CSymbolInfo *symbol,ENUM_TIMEFRAMES period,double point);
   //--- Method to validate the parameters
   virtual bool       InitIndicators(CIndicators* indicators);
   bool              Set_TriangularArrays();  //Method to set Triangular array
   //Method to get parameter
   double            Get_Upper10() {return Upper10;}
   double            Get_Upper100() {return Upper100;}
   double            Get_Upper1000() {return Upper1000;}
   double            Get_Upper10000() {return Upper10000;}
   double            Get_Upper100000() {return Upper100000;}
   double            Get_Upper1000000() {return Upper1000000;}

   double            Get_Lower10() {return Lower10;}
   double            Get_Lower100() {return Lower100;}
   double            Get_Lower1000() {return Lower1000;}
   double            Get_Lower10000() {return Lower10000;}
   double            Get_Lower100000() {return Lower100000;}
   double            Get_Lower1000000() {return Lower1000000;}
   double            Get_Bid();
   double            Get_Ask();

   // Method to set parameters

   void              Set_Numbers(int value) {m_Numbers=value;} //Method to Set Numerical numbers
   bool              Set_ArrayReserveSize() {m_ArrayReserveSize=m_Numbers; return true;}
   bool              Set_ArrayReserveSize(int value) {m_ArrayReserveSize=value; return true;}
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
//|          constructor                                                        |
//+------------------------------------------------------------------+
CTriangularSignal::CTriangularSignal(void):
   m_Numbers(10000),
   m_pattern_0(80),
   m_pattern_1(10),
   m_pattern_2(60),
   m_pattern_3(60)
  {}

//+------------------------------------------------------------------+
//|                 DEstructor                                                 |
//+------------------------------------------------------------------+
CTriangularSignal::~CTriangularSignal() {}
//+------------------------------------------------------------------+
//|    impletmentation of srtting triangular array method                                                              |
//+------------------------------------------------------------------+
bool CTriangularSignal::Set_TriangularArrays()
  {

   printf("Start Generating triangular Numbers");
   Highest_and_Lowest();


   for(int n=0,a=1,b=1,c=1,d=1,e=1,f=1; n<m_Numbers-5; n++)
     {
      ulong result= (n*(n+1))/2;
      ArrayResize(m_TriangularArray,n+1,m_Numbers);



      // Append to array
      m_TriangularArray[n]=result;


      // loop to fill all arrays with its tri num after division
      for(double z=10; z<=1000000; z*=10)
        {
         double modified_result=((ulong)result)/z;


         double value=m_symbol.NormalizePrice(modified_result);
         if(m_Highest>value>m_Lowest)
           {
            if(z==10)
              {

               ArrayResize(m_Triangular10,a,m_Numbers);

               m_Triangular10[a-1]=value;
               a++;
              }
            else
               if(z==100)
                 {

                  ArrayResize(m_Triangular100,b,m_Numbers);

                  m_Triangular100[b-1]=value;
                  b++;
                 }
               else
                  if(z==1000)
                    {

                     ArrayResize(m_Triangular1000,c,m_Numbers);

                     m_Triangular1000[c-1]=value;
                     c++;
                    }
                  else
                     if(z==10000)
                       {

                        ArrayResize(m_Triangular10000,d,m_Numbers);

                        m_Triangular10000[d-1]=value;
                        d++;
                       }
                     else
                        if(z==100000)
                          {

                           ArrayResize(m_Triangular100000,e,m_Numbers);

                           m_Triangular100000[e-1]=value;
                           e++;
                          }
                        else
                           if(z==1000000)
                             {

                              ArrayResize(m_Triangular1000000,f,m_Numbers);

                              m_Triangular1000000[f-1]=value;
                              f++;
                             }

           }
        }
     }
   ArrayResize(m_Triangular10,ArraySize(m_Triangular10),ArraySize(m_Triangular10));
   ArrayResize(m_Triangular100,ArraySize(m_Triangular100),ArraySize(m_Triangular100));
   ArrayResize(m_Triangular1000,ArraySize(m_Triangular1000),ArraySize(m_Triangular1000));
   ArrayResize(m_Triangular10000,ArraySize(m_Triangular10000),ArraySize(m_Triangular10000));
   ArrayResize(m_Triangular100000,ArraySize(m_Triangular100000),ArraySize(m_Triangular100000));
   ArrayResize(m_Triangular1000000,ArraySize(m_Triangular1000000),ArraySize(m_Triangular1000000));
   printf("Finish Generating triangular Numbers");

   return(true);

  }


///+------------------------------------------------------------------+
//|   Get Ask and Bid                                                               |
//+------------------------------------------------------------------+
double CTriangularSignal::Get_Ask()
  {

   Ask=SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   return Ask;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CTriangularSignal::Get_Bid()
  {

   Bid=SymbolInfoDouble(_Symbol,SYMBOL_BID);
   return Bid;
  }

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|   Find the upper and lower Support                                                               |
//+------------------------------------------------------------------+
bool CTriangularSignal::Set_channels()
  {
   Get_Bid();

   for(int i=1; i<ArraySize(m_Triangular10); i++)
     {
      if(m_Triangular10[i-1]<Bid&&Bid<m_Triangular10[i])
        {
         Lower10=m_Triangular10[i-1];
         Upper10=m_Triangular10[i];
        }
     }
   for(int i=1; i<ArraySize(m_Triangular100); i++)
     {
      if(m_Triangular100[i-1]<Bid&&Bid<m_Triangular100[i])
        {
         Lower100=m_Triangular100[i-1];
         Upper100=m_Triangular100[i];
        }
     }
   for(int i=1; i<ArraySize(m_Triangular1000); i++)
     {
      if(m_Triangular1000[i-1]<Bid&&Bid<m_Triangular1000[i])
        {
         Lower1000=m_Triangular1000[i-1];
         Upper1000=m_Triangular1000[i];
        }
     }
   for(int i=1; i<ArraySize(m_Triangular10000); i++)
     {
      if(m_Triangular10000[i-1]<Bid&&Bid<m_Triangular10000[i])
        {
         Lower10000=m_Triangular10000[i-1];
         Upper10000=m_Triangular10000[i];
        }
     }
   for(int i=1; i<ArraySize(m_Triangular100000); i++)
     {
      if(m_Triangular100000[i-1]<Bid&&Bid<m_Triangular100000[i])
        {
         Lower100000=m_Triangular100000[i-1];
         Upper100000=m_Triangular100000[i];
        }
     }
   for(int i=1; i<ArraySize(m_Triangular1000000); i++)
     {
      if(m_Triangular1000000[i-1]<Bid&&Bid<m_Triangular1000000[i])
        {
         Lower1000000=m_Triangular1000000[i-1];
         Upper1000000=m_Triangular1000000[i];
        }

     }
   return true;

  }

//+------------------------------------------------------------------+
//|               check if there are any change in channels                                                   |
//+------------------------------------------------------------------+
bool CTriangularSignal::Check_Channels()
  {
   Get_Bid();
   if((ArraySize(m_Triangular1000000))==0)
     {
      Set_TriangularArrays();
      Set_channels();
     }


   if((Lower10<Bid&&Bid<Upper10)==false)

     {
      printf("channel10 changed");
      for(int i=1; i<ArraySize(m_Triangular10); i++)
        {
         if(m_Triangular10[i-1]<Bid&&Bid<m_Triangular10[i])
           {
            Lower10=m_Triangular10[i-1];
            Upper10=m_Triangular10[i];
            printf("channel10 Updated");
            return true;
           }
         else
           {
            printf("failed to check channel10");
            return false;
           }
        }
     }
   if((Lower100<Bid&&Bid<Upper100)==false)

     {
      printf("channel100 changed");
      for(int i=1; i<ArraySize(m_Triangular100); i++)
        {
         if(m_Triangular100[i-1]<Bid&&Bid<m_Triangular100[i])
           {
            Lower100=m_Triangular100[i-1];
            Upper100=m_Triangular100[i];
            printf("channel100 Updated");
            return true;
           }
         else
           {
            printf("failed to check channel100");
            return false;
           }
        }
     }
   if((Lower1000<Bid&&Bid<Upper1000)==false)

     {
      printf("channel1000 changed");
      for(int i=1; i<ArraySize(m_Triangular1000); i++)
        {
         if(m_Triangular1000[i-1]<Bid&&Bid<m_Triangular1000[i])
           {
            Lower1000=m_Triangular1000[i-1];
            Upper1000=m_Triangular1000[i];
            printf("channel1000 Updated");
            return true;
           }
         else
           {
            printf("failed to check channel1000");
            return false;
           }
        }
     }

   if((Lower10000<Bid&&Bid<Upper10000)==false)

     {
      printf("channel10000 changed");

      for(int i=1; i<ArraySize(m_Triangular100000); i++)
        {
         if(m_Triangular10000[i-1]<Bid&&Bid<m_Triangular10000[i])
           {
            Lower10000=m_Triangular10000[i-1];
            Upper10000=m_Triangular10000[i];
            printf("channel10000 Updated");
            return true;
           }
         else
           {
            printf("failed to check channel10000");
            return false;
           }
        }
     }
   if((Lower100000<Bid&&Bid<Upper100000)==false)

     {
      printf("channel100000 changed");
      for(int i=1; i<ArraySize(m_Triangular1000000); i++)
        {
         if(m_Triangular100000[i-1]<Bid&&Bid<m_Triangular100000[i])
           {
            Lower100000=m_Triangular100000[i-1];
            Upper100000=m_Triangular100000[i];
            printf("channel100000 Updated");
            return true;
           }
         else
           {
            printf("failed to check channel100000");
            return false;
           }
        }
     }
   if((Lower1000000<Bid&&Bid<Upper1000000)==false)

     {
      Print(ArraySize(m_Triangular1000000));
      printf("channel1000000 changed");
      for(int i=1; i<(ArraySize(m_Triangular1000000))-1; i++)
        {
         if(m_Triangular1000000[i-1]<Bid&&Bid<m_Triangular1000000[i])
           {
            Lower1000000=m_Triangular1000000[i-1];
            Upper1000000=m_Triangular1000000[i];
            printf("channel1000000 Updated");
            return true;
           }
         else
           {
            printf("failed to check channel1000000");
            return false;
           }
        }
     }
   printf("No change in channel");
   return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CTriangularSignal::Update_Wrapper(void)
  {
   if(Check_Channels())
     {
      if(m_Wrapper10[0][9]!=Lower10&&m_Wrapper10[1][9]!=Upper10)
        {
         m_Wrapper10[0][9]=Lower10;
         m_Wrapper10[1][9]=Upper10;

         return true;
        }

      else
         if(m_Wrapper100[0][9]!=Lower100&&m_Wrapper100[1][9]!=Upper100)
           {
            m_Wrapper100[0][9]=Lower100;
            m_Wrapper100[1][9]=Upper100;
            return true;

           }
         else

            if(m_Wrapper1000[0][9]!=Lower1000&&m_Wrapper1000[1][9]!=Upper1000)
              {
               m_Wrapper1000[0][9]=Lower1000;
               m_Wrapper1000[1][9]=Upper1000;
               return true;

              }
            else


               if(m_Wrapper10000[0][9]!=Lower10000&&m_Wrapper10000[1][9]!=Upper10000)
                 {
                  m_Wrapper10000[0][9]=Lower10000;
                  m_Wrapper10000[1][9]=Upper10000;

                  return true;
                 }
               else

                  if(m_Wrapper100000[0][9]!=Lower100000&&m_Wrapper100000[1][9]!=Upper100000)
                    {
                     m_Wrapper100000[0][9]=Lower100000;
                     m_Wrapper100000[1][9]=Upper100000;

                     return true;
                    }
                  else

                     if(m_Wrapper1000000[0][9]!=Lower1000000&&m_Wrapper1000000[1][9]!=Upper1000000)
                       {
                        m_Wrapper1000000[0][9]=Lower1000000;
                        m_Wrapper1000000[1][9]=Upper1000000;

                        return true;
                       }
                     else
                       {
                        printf("failed to Update wrapper");
                        return false;
                       }
     }
   return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CTriangularSignal::Get_Trend(void)
  {
   if(Update_Wrapper())
     {
      if(m_Wrapper10[0][9]== m_Wrapper10[1][8] && m_Wrapper10[1][9] > m_Wrapper10[1][8])
        {
         if(m_Wrapper10[0][9]!= trend10[9])
           {
            ArrayRemove(trend10,0,1);
            trend10[9]=m_Wrapper10[0][9];
            return true;
           }
        }
      else
         if(m_Wrapper10[1][9]==m_Wrapper10[0][8] && m_Wrapper10[0][8] > m_Wrapper10[0][9])
           {
            if(trend10[9]!=m_Wrapper10[1][9])
              {
               ArrayRemove(trend10,0,1);
               trend10[9]=m_Wrapper10[1][9];
               return true;
              }
           }
      if(m_Wrapper100[0][9]== m_Wrapper100[1][8] && m_Wrapper100[1][9] > m_Wrapper100[1][8])
        {
         if(m_Wrapper100[0][9]!= trend100[9])
           {
            ArrayRemove(trend100,0,1);
            trend100[9]=m_Wrapper100[0][9];
            return true;
           }
        }
      else
         if(m_Wrapper100[1][9]==m_Wrapper100[0][8] && m_Wrapper100[0][8] > m_Wrapper100[0][9])
           {
            if(trend100[9]!=m_Wrapper100[1][9])
              {
               ArrayRemove(trend100,0,1);
               trend100[9]=m_Wrapper100[1][9];
               return true;
              }
           }
      if(m_Wrapper1000[0][9]== m_Wrapper1000[1][8] && m_Wrapper1000[1][9] > m_Wrapper1000[1][8])
        {
         if(m_Wrapper1000[0][9]!= trend1000[9])
           {
            ArrayRemove(trend1000,0,1);
            trend1000[9]=m_Wrapper1000[0][9];
            return true;
           }
        }
      else
         if(m_Wrapper1000[1][9]==m_Wrapper1000[0][8] && m_Wrapper1000[0][8] > m_Wrapper1000[0][9])
           {
            if(trend1000[9]!=m_Wrapper1000[1][9])
              {
               ArrayRemove(trend1000,0,1);
               trend1000[9]=m_Wrapper1000[1][9];
               return true;
              }
           }
      if(m_Wrapper10000[0][9]== m_Wrapper10000[1][8] && m_Wrapper10000[1][9] > m_Wrapper10000[1][8])
        {
         if(m_Wrapper10000[0][9]!= trend10000[9])
           {
            ArrayRemove(trend10000,0,1);
            trend10000[9]=m_Wrapper10000[0][9];
            return true;
           }
        }
      else
         if(m_Wrapper10000[1][9]==m_Wrapper10000[0][8] && m_Wrapper10000[0][8] > m_Wrapper10000[0][9])
           {
            if(trend10000[9]!=m_Wrapper10000[1][9])
              {
               ArrayRemove(trend10000,0,1);
               trend10000[9]=m_Wrapper10000[1][9];
               return true;
              }
           }
      if(m_Wrapper100000[0][9]== m_Wrapper100000[1][8] && m_Wrapper100000[1][9] > m_Wrapper100000[1][8])
        {
         if(m_Wrapper100000[0][9]!= trend100000[9])
           {
            ArrayRemove(trend100000,0,1);
            trend100000[9]=m_Wrapper100000[0][9];
            return true;
           }
        }
      else
         if(m_Wrapper100000[1][9]==m_Wrapper100000[0][8] && m_Wrapper100000[0][8] > m_Wrapper100000[0][9])
           {
            if(trend100000[9]!=m_Wrapper100000[1][9])
              {
               ArrayRemove(trend100000,0,1);
               trend100000[9]=m_Wrapper100000[1][9];
               return true;
              }
           }
     }
   return(false);
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
//   if((Upper10>Bid&&Bid>Lower10)==false)
//     {
//
//      printf("Error in channel10");
//      return (false);
//     }
//   if((Upper100>Bid&&Bid>Lower100)==false)
//     {
//
//      printf("Error in channel100");
//      return (false);
//     }
//   if((Upper1000>Bid&&Bid>Lower1000)==false)
//     {
//
//      printf("Error in channel1000");
//      return (false);
//     }
//   if((Upper10000>Bid&&Bid>Lower10000)==false)
//     {
//
//      printf("Error in channel10000");
//      return (false);
//     }
//   if((Upper100000>Bid&&Bid>Lower100000)==false)
//     {
//
//      printf("Error in channel100000");
//      return (false);
//     }
//   if((Upper1000000>Bid&&Bid>Lower1000000)==false)
//     {
//
//      printf("Error in channel1000000");
//      return (false);
//     }



// ok
   return(true);
  }


//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
bool CTriangularSignal::Init(CSymbolInfo *symbol,ENUM_TIMEFRAMES period,double point)
  {
   if(!CExpertSignal::Init(symbol,period,point))
      return (false);

   if(!Set_ArrayReserveSize())
      return (false);

   if(!Set_TriangularArrays())
      return(false);
   if(!Set_channels())
      return(false);
   printf("Initialization Complete");
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CTriangularSignal::Trend10000_direction()
  {
   int result=-1;
   Get_Bid();
   if(Bid>trend10000[9]&&trend10000[9]>trend10000[8]&& Lower10000<Bid<Upper10000)
     {
      // Up trend
      result=1;
     }
   else
      if(Bid<trend10000[9]&&trend10000[9]<trend10000[8]&& Lower10000<Bid<Upper10000)
        {
         // Down Trend
         result=0;
        }
   return(result);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CTriangularSignal::Trend100000_direction()
  {
   int result=-1;
   Get_Bid();
   if(Bid>trend100000[9]&&trend100000[9]>trend100000[8]&& Lower100000<Bid<Upper100000)
     {
      // Up trend
      result=1;
     }
   else
      if(Bid<trend100000[9]&&trend100000[9]<trend100000[8]&& Lower100000<Bid<Upper100000)
        {
         // Down Trend
         result=0;
        }
   return(result);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CTriangularSignal::Trend1000000_direction()
  {
   int result=-1;
   Get_Bid();
   if(Bid>trend1000000[9]&&trend1000000[9]>trend1000000[8]&& Lower1000000<Bid<Upper1000000)
     {
      // Up trend
      result=1;
     }
   else
      if(Bid<trend1000000[9]&&trend1000000[9]<trend1000000[8]&& Lower1000000<Bid<Upper1000000)
        {
         // Down Trend
         result=0;
        }
   return(result);
  }

//+------------------------------------------------------------------+
//|         check if there is any open position in the channel       |
//+------------------------------------------------------------------+
bool CTriangularSignal::Check_Pos_in_channel(void)
  {

   for(int i=0; i<PositionsTotal(); i++)
     {
      m_Position.SelectByIndex(i);
      double price_open=m_Position.PriceOpen();
      Print(price_open);
      if(Upper1000000>price_open>Lower1000000)
        {
         return(true);
        }
      else
         return(false);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CTriangularSignal::Is_Entry(void)
  {
   int result=-1;
   Get_Bid();

   if(Bid>Lower1000000+2*m_symbol.Point()
      &&Bid< Lower1000000+4*m_symbol.Point())
     {
      printf("Price is in Buy Entry");
      result=1;
     }
   else
      if(Bid<Upper1000000-2*m_symbol.Point()
         &&Bid> Upper1000000-4*m_symbol.Point())
        {
         printf("Price is in Sell Entry");
         result=0;
        }

   return(result);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CTriangularSignal:: LongCondition(void)
  {

   Get_Ask();
   Get_Trend();
   int   result   =0;
   ArrayPrint(m_Wrapper1000000);
   Print(Bid);
   if(Is_Entry()==1)
     {
      printf("time to buy");
      result=m_pattern_0;
     }

   return(result);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CTriangularSignal::ShortCondition(void)
  {
   Get_Bid();
   Get_Trend();
   Print(Get_Lower1000000(),"  ",Get_Upper1000000());
   int   result =0;
   if(Is_Entry()==0)
     {
      printf("time to sell");
      result=m_pattern_0;
     }
   return(result);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

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
//|   Set highest                                                               |
//+------------------------------------------------------------------+
void CTriangularSignal::Highest_and_Lowest(void)
  {
   int Highest_candel,Lowest_candel;
   double High[],Low[];
// Set Arrays as timeseries
   ArraySetAsSeries(High,true);
   ArraySetAsSeries(Low,true);

// fill array with history data
   CopyHigh(_Symbol,PERIOD_W1,0,2500,High);
   CopyLow(_Symbol,PERIOD_W1,0,2500,Low);

//Get higest and lowest candel
   Highest_candel = ArrayMaximum(High,0,2500);
   Lowest_candel= ArrayMinimum(Low,0,2500);


   m_Highest=High[Highest_candel];
   m_Lowest=Low[Lowest_candel];


  }
//+------------------------------------------------------------------+
