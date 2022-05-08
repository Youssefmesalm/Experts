//+------------------------------------------------------------------+
//|                                         ExpertSignalAdvanced.mqh |
//|                                      Copyright 2014, PunkBASSter |
//|                      https://login.mql5.com/en/users/punkbasster |
//+------------------------------------------------------------------+
#include <DoEasy\Engine.mqh>
#include "ExpertSignal.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CExpertSignalAdvanced : public CExpertSignal
  {
protected:
   //---temporary data for opening a pending order or a position
   double            m_order_open_long;         //order open price
   double            m_order_stop_long;         //order stop loss price
   double            m_order_take_long;         //order take profit price
   datetime          m_order_expiration_long;   //order expiration time
   double            m_order_open_short;        //order open price
   double            m_order_stop_short;        //order stop loss price
   double            m_order_take_short;        //order take profit price
   datetime          m_order_expiration_short;  //order expiration time
   //---
   int               m_price_module;            //index of the first price module

public:
                     CExpertSignalAdvanced();
                    ~CExpertSignalAdvanced();
   CEngine           engine;
   virtual void      CalcPriceModuleIndex() {m_price_module=m_filters.Total();}
   virtual bool      CheckOpenLong(double &price,double &sl,double &tp,datetime &expiration);
   virtual bool      CheckOpenShort(double &price,double &sl,double &tp,datetime &expiration);
   virtual double    Direction(void);
   virtual double    Prices(void);
   virtual bool      OpenLongParams(double &price,double &sl,double &tp,datetime &expiration);
   virtual bool      OpenShortParams(double &price,double &sl,double &tp,datetime &expiration);
   virtual bool      CheckUpdateOrderLong(COrderInfo *order_ptr,double &open,double &sl,double &tp,datetime &ex);
   virtual bool      CheckUpdateOrderShort(COrderInfo *order_ptr,double &open,double &sl,double &tp,datetime &ex);
   double            getOpenLong()              { return m_order_open_long;         }
   double            getOpenShort()             { return m_order_open_short;        }
   double            getStopLong()              { return m_order_stop_long;         }
   double            getStopShort()             { return m_order_stop_short;        }
   double            getTakeLong()              { return m_order_take_long;         }
   double            getTakeShort()             { return m_order_take_short;        }
   datetime          getExpLong()               { return m_order_expiration_long;   }
   datetime          getExpShort()              { return m_order_expiration_short;  }
   double            getWeight()                { return m_weight;                  }
  
  };
//+------------------------------------------------------------------+
//| OrdersParameters initialization                                  |
//+------------------------------------------------------------------+
CExpertSignalAdvanced::CExpertSignalAdvanced()
  {
   m_order_open_long=EMPTY_VALUE;
   m_order_stop_long=EMPTY_VALUE;
   m_order_take_long=EMPTY_VALUE;
   m_order_expiration_long=0;
   m_order_open_short=EMPTY_VALUE;
   m_order_stop_short=EMPTY_VALUE;
   m_order_take_short=EMPTY_VALUE;
   m_order_expiration_short=0;
   m_price_module=-1;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CExpertSignalAdvanced::~CExpertSignalAdvanced()
  {
  }
//+------------------------------------------------------------------+
//| Checking open conditions for buys                                |
//+------------------------------------------------------------------+
bool CExpertSignalAdvanced::CheckOpenLong(double &price,double &sl,double &tp,datetime &expiration)
  {
//if there are no price modules, act like CExpertSignal
   if(m_price_module<0)
      return(CExpertSignal::CheckOpenLong(price,sl,tp,expiration));

   bool   result   =false;
   double direction=Direction();
//--- the "prohibition" signal
   if(direction==EMPTY_VALUE)
      return(false);
//--- check of exceeding the threshold value
   if(direction>=m_threshold_open)
     {
      Prices();
      result=OpenLongParams(price,sl,tp,expiration);//there's a signal if m_order_open_long!=EMPTY_VALUE
     }
//--- return the result
   return(result);
  }
//+------------------------------------------------------------------+
//| Checking open conditions for sells                               |
//+------------------------------------------------------------------+
bool CExpertSignalAdvanced::CheckOpenShort(double &price,double &sl,double &tp,datetime &expiration)
  {
//if there are no price modules, act like CExpertSignal
   if(m_price_module<0)
      return(CExpertSignal::CheckOpenShort(price,sl,tp,expiration));

   bool   result   =false;
   double direction=Direction();
//--- the "prohibition" signal
   if(direction==EMPTY_VALUE)
      return(false);
//--- check of exceeding the threshold value
   if(-direction>=m_threshold_open)
     {
      Prices();
      result=OpenShortParams(price,sl,tp,expiration);//there's a signal if m_order_open_short!=EMPTY_VALUE
     }
//--- return the result
   return(result);
  }
//+------------------------------------------------------------------+
//| Calculating of average weighted forecast                         |
//+------------------------------------------------------------------+
double CExpertSignalAdvanced::Direction(void)
  {
   long   mask;
   double direction;
   double result=m_weight*(LongCondition()-ShortCondition());
   int    number=(result==0.0)? 0 : 1;      // number of "voted"
//--- loop by filters
   for(int i=0; i<m_price_module; i++)
     {
      //--- mask for bit maps
      mask=((long)1)<<i;
      //--- check of the flag of ignoring the signal of filter
      if((m_ignore&mask)!=0)
         continue;
      CExpertSignal *filter=m_filters.At(i);
      //--- check pointer
      if(filter==NULL)
         continue;
      direction=filter.Direction();
      //--- the "prohibition" signal
      if(direction==EMPTY_VALUE)
         return(EMPTY_VALUE);
      if((m_invert&mask)!=0)
         result-=direction;
      else
         result+=direction;
      number++;
     }
//--- normalization of average weighted forecast
   if(number!=0)
      result/=number;
//--- return the result
   return(result);
  }
//+------------------------------------------------------------------+
//| Selecting available order parameters                             |
//+------------------------------------------------------------------+
double CExpertSignalAdvanced::Prices(void)
  {
   if(m_price_module<0)
      return(EMPTY_VALUE);
   m_order_open_long=EMPTY_VALUE;
   m_order_stop_long=EMPTY_VALUE;
   m_order_take_long=EMPTY_VALUE;
   m_order_expiration_long=0;
   m_order_open_short=EMPTY_VALUE;
   m_order_stop_short=EMPTY_VALUE;
   m_order_take_short=EMPTY_VALUE;
   m_order_expiration_short=0;
   int    total=m_filters.Total();
   double last_weight_long=0;
   double last_weight_short=0;
//--- loop by price modules
   for(int i=m_price_module; i<total; i++)
     {
      //--- choosing  parameters to save
      CExpertSignalAdvanced *prm=m_filters.At(i);
      if(prm==NULL)
         continue;
      if(prm.Prices()==EMPTY_VALUE)
         continue;//ignore current price module
      double weight=prm.getWeight();
      if(weight==0.0)
         continue;

      if(weight>last_weight_long && prm.getExpLong()>TimeCurrent())
         if(prm.OpenLongParams(m_order_open_long,m_order_stop_long,m_order_take_long,m_order_expiration_long))
            last_weight_long=weight;
      if(weight>last_weight_short && prm.getExpShort()>TimeCurrent())
         if(prm.OpenShortParams(m_order_open_short,m_order_stop_short,m_order_take_short,m_order_expiration_short))
            last_weight_short=weight;
     }
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CExpertSignalAdvanced::OpenLongParams(double &price,double &sl,double &tp,datetime &expiration)
  {
   if(m_order_open_long!=EMPTY_VALUE)
     {
      price=m_order_open_long;
      sl=m_order_stop_long;
      tp=m_order_take_long;
      expiration=m_order_expiration_long;
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CExpertSignalAdvanced::OpenShortParams(double &price,double &sl,double &tp,datetime &expiration)
  {
   if(m_order_open_short!=EMPTY_VALUE)
     {
      price=m_order_open_short;
      sl=m_order_stop_short;
      tp=m_order_take_short;
      expiration=m_order_expiration_short;
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CExpertSignalAdvanced::CheckUpdateOrderLong(COrderInfo *order_ptr,double &open,double &sl,double &tp,datetime &ex)
  {
   if(Prices()==EMPTY_VALUE)
      return(false);   //Refresh prices
//--- Checking changes
   double point=m_symbol.Point();
   if(MathAbs(order_ptr.PriceOpen() - m_order_open_long)>point
      || MathAbs(order_ptr.StopLoss()  - m_order_stop_long)>point
      || MathAbs(order_ptr.TakeProfit()- m_order_take_long)>point
      || order_ptr.TimeExpiration()!=m_order_expiration_long)
      return(OpenLongParams(open,sl,tp,ex));

//--- No update required
   return (false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CExpertSignalAdvanced::CheckUpdateOrderShort(COrderInfo *order_ptr,double &open,double &sl,double &tp,datetime &ex)
  {
   if(Prices()==EMPTY_VALUE)
      return(false);   //Refresh prices
//--- Checking changes
   double point=m_symbol.Point();
   if(MathAbs(order_ptr.PriceOpen() - m_order_open_short)>point
      || MathAbs(order_ptr.StopLoss()  - m_order_stop_short)>point
      || MathAbs(order_ptr.TakeProfit()- m_order_take_short)>point
      || order_ptr.TimeExpiration()!=m_order_expiration_short)
      return(OpenShortParams(open,sl,tp,ex));

//--- No update required
   return (false);
  }

//+------------------------------------------------------------------+
