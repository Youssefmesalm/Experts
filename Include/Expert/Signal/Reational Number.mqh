//+------------------------------------------------------------------+
//|                                             Reational Number.mqh |
//|                                    Copyright 2021,Yousuf Mesalm. |
//|                           https://www.mql5.com/en/users/20163440 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021,Yousuf Mesalm."
#property link      "https://www.mql5.com/en/users/20163440"
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
class CRationalNumbers :public CExpertSignal
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
