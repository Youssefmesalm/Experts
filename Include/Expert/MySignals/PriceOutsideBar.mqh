//+------------------------------------------------------------------+
//|                                              PriceOutsideBar.mqh |
//|                                      Copyright 2014, PunkBASSter |
//|                      https://login.mql5.com/en/users/punkbasster |
//+------------------------------------------------------------------+
#include <Expert\ExpertSignalAdvanced.mqh>
// wizard description start
//+------------------------------------------------------------------+
//| Description of the class                                         |
//| Title=Outside Bar Price Module                                   |
//| Type=SignalAdvanced                                              |
//| Name=Outside Bar Price Module                                    |
//| ShortName=OB_PM                                                  |
//| Class=CPriceOutsideBar                                           |
//| Page=not used                                                    |
//| Parameter=setTpRatio,double,1.5,TP:SL ratio                      |
//| Parameter=setExpBars,int,10,Expiration after bars number         |
//| Parameter=setOrderOffset,int,5,Offset for open and stop loss     |
//+------------------------------------------------------------------+
// wizard description end
//+------------------------------------------------------------------+
//| Class CPriceOutsideBar                                           |
//| Purpose: Class of generator of price levels for orders based on  |
//|          the Outside bar pattern.                                |
//| Is derived from the CExpertSignalAdvanced class.                 |
//+------------------------------------------------------------------+
class CPriceOutsideBar : public CExpertSignalAdvanced
  {
protected:
   double            m_tp_ratio;          //tp:sl ratio
   int               m_exp_bars;          //expiration in bars
   double            m_order_offset;      //offset applied to open price and stop loss level
   datetime          calcExpiration()  { return(TimeCurrent()+m_exp_bars*PeriodSeconds(m_period)); }
public:
                     CPriceOutsideBar();
                    ~CPriceOutsideBar();
   void              setTpRatio(double ratio){ m_tp_ratio=ratio; }
   void              setExpBars(int bars)    { m_exp_bars=bars;}
   void              setOrderOffset(int pips){ m_order_offset=m_symbol.Point()*pips;}
   bool              ValidationSettings();
   double            Prices();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CPriceOutsideBar::CPriceOutsideBar()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CPriceOutsideBar::~CPriceOutsideBar()
  {
  }
//+------------------------------------------------------------------+
//| Validation of protected settings                                 |
//+------------------------------------------------------------------+
bool CPriceOutsideBar::ValidationSettings(void)
  {
//--- validation settings of additional filters
   if(!CExpertSignal::ValidationSettings())
      return(false);
//--- initial data checks
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
//| Price levels refreshing                                          |
//+------------------------------------------------------------------+
double CPriceOutsideBar::Prices(void)
{
   double h[2],l[2];
   if(CopyHigh(m_symbol.Name(),m_period,1,2,h)!=2 || CopyLow(m_symbol.Name(),m_period,1,2,l)!=2)
      return(EMPTY_VALUE);
      
   if(h[0] <= h[1] && l[0] >= l[1])
   {
      m_order_open_long=h[1]+m_order_offset;
      m_order_stop_long=l[1]-m_order_offset;
      m_order_take_long=m_order_open_long+(m_order_open_long-m_order_stop_long)*m_tp_ratio;
      m_order_expiration_long=calcExpiration();
      
      m_order_open_short=m_order_stop_long;
      m_order_stop_short=m_order_open_long;
      m_order_take_short=m_order_open_short-(m_order_stop_short-m_order_open_short)*m_tp_ratio;
      m_order_expiration_short=m_order_expiration_long;
      return(0);
   }
   
   return(EMPTY_VALUE);
}  
//+------------------------------------------------------------------+