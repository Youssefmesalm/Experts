//+------------------------------------------------------------------+
//|                                                   GridSample.mqh |
//|                                                   Enrico Lambino |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Enrico Lambino"
#property link      "http://www.mql5.com"
#include <Layouts\Grid.mqh>
#include <Controls\Dialog.mqh>
#include <Controls\Button.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CGridSampleDialog : public CAppDialog
  {
protected:
   CGrid             m_main;
   CButton           m_button1;
   CButton           m_button2;
   CButton           m_button3;
   CButton           m_button4;
   CButton           m_button5;
   CButton           m_button6;
   CButton           m_button7;
   CButton           m_button8;
   CButton           m_button9;
public:
                     CGridSampleDialog();
                    ~CGridSampleDialog();
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);
   virtual bool      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
protected:
   virtual bool      CreateMain(const long chart,const string name,const int subwin);
   virtual bool      CreateButton(const int button_id,const long chart,const string name,const int subwin);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
EVENT_MAP_BEGIN(CGridSampleDialog)
EVENT_MAP_END(CAppDialog)
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CGridSampleDialog::CGridSampleDialog()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CGridSampleDialog::~CGridSampleDialog()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CGridSampleDialog::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2)
  {
   if(!CAppDialog::Create(chart,name,subwin,x1,y1,x2,y2))
      return(false);
   if(!CreateMain(chart,name,subwin))
      return(false);   
   for(int i=1;i<=9;i++)
     {
      if(!CreateButton(i,chart,"button",subwin))
         return(false);
     }   
   if(!m_main.Pack())
      return(false);
   if(!Add(m_main))
      return(false);
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CGridSampleDialog::CreateMain(const long chart,const string name,const int subwin)
  {
   if(!m_main.Create(chart,name+"main",subwin,0,0,CDialog::m_client_area.Width(),CDialog::m_client_area.Height()))
      return(false);
   m_main.Init(3,3,5,5);
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CGridSampleDialog::CreateButton(const int button_id,const long chart,const string name,const int subwin)
  {
   CButton *button;
   switch(button_id)
     {
      case 1: button = GetPointer(m_button1); break;
      case 2: button = GetPointer(m_button2); break;
      case 3: button = GetPointer(m_button3); break;
      case 4: button = GetPointer(m_button4); break;
      case 5: button = GetPointer(m_button5); break;
      case 6: button = GetPointer(m_button6); break;
      case 7: button = GetPointer(m_button7); break;
      case 8: button = GetPointer(m_button8); break;
      case 9: button = GetPointer(m_button9); break;
      default: return(false);
     }
   if (!button.Create(chart,name+IntegerToString(button_id),subwin,0,0,100,100))
      return(false);
   if (!button.Text(name+IntegerToString(button_id)))
      return(false);
   if (!m_main.Add(button))
      return(false);
   return(true);
  }
//+------------------------------------------------------------------+
