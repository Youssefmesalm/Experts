//+------------------------------------------------------------------+
//|                                      GraphElementsCollection.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "ListObj.mqh"
#include "..\Services\Select.mqh"
#include "..\Objects\Graph\Form.mqh"
//+------------------------------------------------------------------+
//| Collection of graphical objects                                  |
//+------------------------------------------------------------------+
class CGraphElementsCollection : public CBaseObj
  {
private:
   CListObj          m_list_all_graph_obj;      // List of all graphical objects
   int               m_delta_graph_obj;         // Difference in the number of graphical objects compared to the previous check
//--- Return the flag indicating the graphical element object in the list of graphical objects
   bool              IsPresentGraphElmInList(const int id,const ENUM_GRAPH_ELEMENT_TYPE type_obj);
public:
//--- Return itself
   CGraphElementsCollection *GetObject(void)                                                             { return &this;                        }
   //--- Return the full collection list 'as is'
   CArrayObj        *GetList(void)                                                                       { return &this.m_list_all_graph_obj;   }
   //--- Return the list by selected (1) integer, (2) real and (3) string properties meeting the compared criterion
   CArrayObj        *GetList(ENUM_CANV_ELEMENT_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode=EQUAL)  { return CSelect::ByGraphCanvElementProperty(this.GetList(),property,value,mode);  }
   CArrayObj        *GetList(ENUM_CANV_ELEMENT_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode=EQUAL) { return CSelect::ByGraphCanvElementProperty(this.GetList(),property,value,mode);  }
   CArrayObj        *GetList(ENUM_CANV_ELEMENT_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode=EQUAL) { return CSelect::ByGraphCanvElementProperty(this.GetList(),property,value,mode);  }
   //--- Return the number of new graphical objects
   int               NewObjects(void)   const                                                            { return this.m_delta_graph_obj;       }
   //--- Constructor
                     CGraphElementsCollection();
//--- Display the description of the object properties in the journal (full_prop=true - all properties, false - supported ones only - implemented in descendant classes)
   virtual void      Print(const bool full_prop=false,const bool dash=false);
//--- Display a short description of the object in the journal
   virtual void      PrintShort(const bool dash=false,const bool symbol=false);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CGraphElementsCollection::CGraphElementsCollection()
  {
   ::ChartSetInteger(::ChartID(),CHART_EVENT_MOUSE_MOVE,true);
   ::ChartSetInteger(::ChartID(),CHART_EVENT_MOUSE_WHEEL,true);
   this.m_list_all_graph_obj.Sort(SORT_BY_CANV_ELEMENT_ID);
   this.m_list_all_graph_obj.Clear();
   this.m_list_all_graph_obj.Type(COLLECTION_GRAPH_OBJ_ID);
  }
//+------------------------------------------------------------------+
