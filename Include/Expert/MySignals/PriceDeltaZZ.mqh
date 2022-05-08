//+------------------------------------------------------------------+
//|                                                 PriceDeltaZZ.mqh |
//|                                      Copyright 2014, PunkBASSter |
//|                      https://login.mql5.com/en/users/punkbasster |
//+------------------------------------------------------------------+
#include <Expert\ExpertSignalAdvanced.mqh>
// wizard description start
//+------------------------------------------------------------------+
//| Description of the class                                         |
//| Title=DeltaZZ Price Module                                       |
//| Type=SignalAdvanced                                              |
//| Name=DeltaZZ Price Module                                        |
//| ShortName=DeltaZZ_PM                                             |
//| Class=CPriceDeltaZZ                                              |
//| Page=not used                                                    |
//| Parameter=setAppPrice,int,1, Applied price: 0 - Close, 1 - H/L   |
//| Parameter=setRevMode,int,0, Reversal mode: 0 - Pips, 1 - Percent |
//| Parameter=setPips,int,300,Reverse in pips                        |
//| Parameter=setPercent,double,0.5,Reverse in percent               |
//| Parameter=setLevels,int,2,Peaks number                           |
//| Parameter=setTpRatio,double,1.6,TP:SL ratio                      |
//| Parameter=setExpBars,int,10,Expiration after bars number         |
//+------------------------------------------------------------------+
// wizard description end

//+------------------------------------------------------------------+
//| Class CPriceDeltaZZ                                              |
//| Purpose: Class of generator of price levels for orders based on  |
//|          the 'DeltaZZ' indicator.                                |
//| Is derived from the CExpertSignalAdvanced class.                 |
//+------------------------------------------------------------------+
class CPriceDeltaZZ : public CExpertSignalAdvanced
  {
protected:
   //--- indicator objects
   CiCustom          m_deltazz;           //DeltaZZ indicator object
   //--- module settings
   int               m_app_price;
   int               m_rev_mode;
   int               m_pips;
   double            m_percent;
   int               m_levels;
   double            m_tp_ratio;          //tp:sl ratio
   int               m_exp_bars;          //expiration in bars
   //--- indicator init method
   bool              InitDeltaZZ(CIndicators *indicators);
   //--- data acquisition methods
   datetime          calcExpiration() { return(TimeCurrent()+m_exp_bars*PeriodSeconds(m_period)); }
   double            getBuySL();          //function for searching latest minimum of ZZ for buy SL
   double            getSellSL();         //function for searching latest maximum of ZZ for sell SL
public:
                     CPriceDeltaZZ();
                    ~CPriceDeltaZZ();
   //--- settings adjustment methods
   void              setAppPrice(int ap)           { m_app_price=ap; }
   void              setRevMode(int rm)            { m_rev_mode=rm;  }
   void              setPips(int pips)             { m_pips=pips;    }
   void              setPercent(double perc)       { m_percent=perc; }
   void              setLevels(int rnum)           { m_levels=rnum;  }
   void              setTpRatio(double tpr)        { m_tp_ratio=tpr; }
   void              setExpBars(int bars)          { m_exp_bars=bars;}
   //--- method of settings validation
   virtual bool      ValidationSettings(void);
   //--- method of creating indicators and time series
   virtual bool      InitIndicators(CIndicators *indicators);
   //--- main method of the module calculating price levels
   virtual double    Prices();            //the main method of the price module based on Delta ZigZag
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CPriceDeltaZZ::CPriceDeltaZZ() : m_app_price(1),
                                 m_rev_mode(0),
                                 m_pips(300),
                                 m_percent(0.5),
                                 m_levels(2),
                                 m_tp_ratio(1),
                                 m_exp_bars(10)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CPriceDeltaZZ::~CPriceDeltaZZ()
  {
  }
//+------------------------------------------------------------------+
//| Validation of protected settings                                 |
//+------------------------------------------------------------------+
bool CPriceDeltaZZ::ValidationSettings(void)
  {
//--- validation settings of additional filters
   if(!CExpertSignal::ValidationSettings())
      return(false);
//--- initial data checks
   if(m_app_price<0 || m_app_price>1)
     {
      printf(__FUNCTION__+": Applied price must be 0 or 1");
      return(false);
     }
   if(m_rev_mode<0 || m_rev_mode>1)
     {
      printf(__FUNCTION__+": Reversal mode must be 0 or 1");
      return(false);
     }
   if(m_pips<10)
     {
      printf(__FUNCTION__+": Number of pips in a ray must be at least 10");
      return(false);
     }
   if(m_percent<=0)
     {
      printf(__FUNCTION__+": Percent must be greater than 0");
      return(false);
     }
   if(m_levels<1)
     {
      printf(__FUNCTION__+": Ray Number must be at least 1");
      return(false);
     }
   if(m_tp_ratio<=0)
     {
      printf(__FUNCTION__+": TP Ratio must be greater than zero");
      return(false);
     }
   if(m_exp_bars<0)
     {
      printf(__FUNCTION__+": Expiration must be zero or positive value");
      return(false);
     }
//--- ok
   return(true);
  }
//+------------------------------------------------------------------+
//| Indicator creation                                               |
//+------------------------------------------------------------------+
bool CPriceDeltaZZ::InitIndicators(CIndicators *indicators)
  {
//--- check of pointer is performed in the method of the parent class
//---
//--- initialization of indicators and time series of filters
   if(!CExpertSignal::InitIndicators(indicators))
      return(false);
//--- creation and initialization of custom indicators
   if(!InitDeltaZZ(indicators))
      return(false);
//--- ok
   return(true);
  }
//+------------------------------------------------------------------+
//| DeltaZZ initialization                                           |
//+------------------------------------------------------------------+
bool CPriceDeltaZZ::InitDeltaZZ(CIndicators *indicators)
  {
//--- adding an object to the collection
   if(!indicators.Add(GetPointer(m_deltazz)))
     {
      printf(__FUNCTION__+": error adding object");
      return(false);
     }
//--- indicator parameters assignment
   MqlParam parameters[6];
//---
   parameters[0].type=TYPE_STRING;
   parameters[0].string_value="deltazigzag.ex5";
   parameters[1].type=TYPE_INT;
   parameters[1].integer_value=m_app_price;
   parameters[2].type=TYPE_INT;
   parameters[2].integer_value=m_rev_mode;
   parameters[3].type=TYPE_INT;
   parameters[3].integer_value=m_pips;
   parameters[4].type=TYPE_DOUBLE;
   parameters[4].double_value=m_percent;
   parameters[5].type=TYPE_INT;
   parameters[5].integer_value=m_levels;
//--- object initialization
   if(!m_deltazz.Create(m_symbol.Name(),m_period,IND_CUSTOM,6,parameters))
     {
      printf(__FUNCTION__+": error initializing object");
      return(false);
     }
//--- buffers quantity
   if(!m_deltazz.NumBuffers(5)) return(false);
//--- ok
   return(true);
  }
//+------------------------------------------------------------------+
//| Buy StopLossCalculation function                                 |
//+------------------------------------------------------------------+
double CPriceDeltaZZ::getBuySL(void)
  {
   int i=0;
   double sl=0.0;
   while(sl==0.0)
     {
      sl=m_deltazz.GetData(0,i);
      i++;
     }
   return(sl);
  }
//+------------------------------------------------------------------+
//| Sell StopLossCalculation function                                |
//+------------------------------------------------------------------+
double CPriceDeltaZZ::getSellSL(void)
  {
   int i=0;
   double sl=0.0;
   while(sl==0.0)
     {
      sl=m_deltazz.GetData(1,i);
      i++;
     }
   return(sl);
  }
//+------------------------------------------------------------------+
//| Price module main function                                       |
//+------------------------------------------------------------------+
double CPriceDeltaZZ::Prices(void)
  {
   double openbuy =m_deltazz.GetData(3,0);//getting latest indicator value from buffer 3
   double opensell=m_deltazz.GetData(4,0);//getting latest indicator value from buffer 4
//---wiping parameters
   m_order_open_long=EMPTY_VALUE;
   m_order_stop_long=EMPTY_VALUE;
   m_order_take_long=EMPTY_VALUE;
   m_order_expiration_long=0;
   m_order_open_short=EMPTY_VALUE;
   m_order_stop_short=EMPTY_VALUE;
   m_order_take_short=EMPTY_VALUE;
   m_order_expiration_short=0;
   int digits=m_symbol.Digits();
//---checking buy pattern
   if(openbuy>0)//if buystop level buffer in not empty
     {
      m_order_open_long=NormalizeDouble(openbuy,digits);
      m_order_stop_long=NormalizeDouble(getBuySL(),digits);
      m_order_take_long=NormalizeDouble(m_order_open_long + m_tp_ratio*(m_order_open_long - m_order_stop_long),digits);
      m_order_expiration_long=calcExpiration();
     }
//---checking sell pattern
   if(opensell>0)//if sellstop level buffer is not empty
     {
      m_order_open_short=NormalizeDouble(opensell,digits);
      m_order_stop_short=NormalizeDouble(getSellSL(),digits);
      m_order_take_short=NormalizeDouble(m_order_open_short - m_tp_ratio*(m_order_stop_short - m_order_open_short),digits);
      m_order_expiration_short=calcExpiration();
     }
   return(0);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Alternative SL algorithms                                        |
//+------------------------------------------------------------------+
/*
double CPriceDeltaZZ::getBuySL(void)
{
//looking for minimums
   int i=0;    //index
   int n=0;    //number of minimums found
   double sl=999999999;
   while(n<m_levels)
     {
      double cur=m_deltazz.GetData(0,i);  //0 -- zz bottom buffer
      if(cur !=0 && cur !=EMPTY_VALUE)    //found a minimum
        {
         n++;
         if(cur<sl)sl=cur;              //choosing the lowest minimum
        }
      i++;
     }
   return(sl);
}
double CPriceDeltaZZ::getSellSL(void)
{
//looking for maximums
   int i=0;    //index
   int n=0;    //number of maximums found
   double sl=0;
   while(n<m_levels)
     {
      double cur=m_deltazz.GetData(1,i);  //1 -- zz top buffer
      if(cur !=0 && cur !=EMPTY_VALUE)    //found a maximum
        {
         n++;
         if(cur>sl)sl=cur;              //choosing the highest maximum
        }
      i++;
     }
   return(sl);
}
*/
//+------------------------------------------------------------------+
