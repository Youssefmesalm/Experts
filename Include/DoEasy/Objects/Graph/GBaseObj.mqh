//+------------------------------------------------------------------+
//|                                                     GBaseObj.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
#property strict    // Necessary for mql4
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "..\..\Services\DELib.mqh"
#include <Graphics\Graphic.mqh>
//+------------------------------------------------------------------+
//| Class of the base object of the library graphical objects        |
//+------------------------------------------------------------------+
class CGBaseObj : public CObject
  {
private:

protected:
   string            m_name_prefix;                      // Object name prefix
   string            m_name;                             // Object name
   long              m_chart_id;                         // Chart ID
   int               m_subwindow;                        // Subwindow index
   int               m_shift_y;                          // Y coordinate shift for the subwindow
   int               m_type;                             // Object type
   bool              m_visible;                          // Object visibility
   
//--- Create (1) the object structure and (2) the object from the structure
   virtual bool      ObjectToStruct(void)                      { return true; }
   virtual void      StructToObject(void){;}

public:
//--- Return the values of class variables
   string            Name(void)                          const { return this.m_name;      }
   long              ChartID(void)                       const { return this.m_chart_id;  }
   int               SubWindow(void)                     const { return this.m_subwindow; }
//--- (1) Set and (2) return the object visibility
   void              SetVisible(const bool flag)   
                       { 
                        long value=(flag ? OBJ_ALL_PERIODS : 0);
                        if(::ObjectSetInteger(this.m_chart_id,this.m_name,OBJPROP_TIMEFRAMES,value))
                           this.m_visible=flag;
                       }
   bool              IsVisible(void)                     const { return this.m_visible;   }

//--- The virtual method returning the object type
   virtual int       Type(void)                          const { return this.m_type;      }

//--- Constructor/destructor
                     CGBaseObj();
                    ~CGBaseObj();
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CGBaseObj::CGBaseObj() : m_shift_y(0), m_type(0),m_visible(false), m_name_prefix(::MQLInfoString(MQL_PROGRAM_NAME)+"_")
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CGBaseObj::~CGBaseObj()
  {
  }
//+------------------------------------------------------------------+
