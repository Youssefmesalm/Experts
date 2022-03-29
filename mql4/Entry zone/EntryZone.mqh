//+------------------------------------------------------------------+
//|                                               Entry Zone.mqh |
//|                                                    Yousuf Mesalm |
//|                               www.mql5.com/en/users/yousuf_Mesalm|
//+------------------------------------------------------------------+
#property copyright "Yousuf Mesalm"
#property link "www.mql5.com/en/users/Yousuf_Mesalm"
#property strict
#include <Controls/Dialog.mqh>
#include <Controls/Label.mqh>
#include "Box.mqh"
#include <Controls/Button.mqh>
#include <ChartObjects/ChartObjectsLines.mqh>
#include <ChartObjects/ChartObjectsTxtControls.mqh>

#include "defines.mqh"

class CEntry : public CAppDialog
{
private:
   /* data */
   CBox m_main;
   CBox m_Entry_row;
   CLabel m_Entry_label;
   CBox m_upper_row;
   CLabel m_upper_label;
   CEdit m_upper_edit;
   CBox m_lower_row;
   CLabel m_lower_label;
   CEdit m_lower_edit;
   CBox m_select_row;
   CButton m_select_button;
   CChartObjectHLine m_upper_line;
   CChartObjectHLine m_lower_line;

   //  Variables
   double m_sl_point;
   double m_lot;
   double m_sl, m_tp, m_market;
   double m_profit, m_loss;
   string m_Pending_type;

public:
   CEntry();
   ~CEntry();
   virtual bool Create(const long chart, const string name, const int subwin, const int x1, const int y1, const int x2, const int y2);
   virtual bool OnEvent(const int id, const long &lparam, const double &dparam, const string &sparam);
   virtual bool OnTick();

protected:
   // Create functions
   virtual bool CreateMain(const long chart, const string name, const int subwin);
   virtual bool CreateEntryRow(const long chart, const string name, const int subwin);
   virtual bool CreateUpperRow(const long chart, const string name, const int subwin);
   virtual bool CreateLowerRow(const long chart, const string name, const int subwin);
   virtual bool CreateSelectRow(const long chart, const string name, const int subwin);
   virtual bool CreateLine(CChartObjectHLine &object, const string name, const double price, const color Color, const int Width);

   //Events Handler

   // Additional Methods
   double NormalizeLot(const double lot);
   double OrderOutputCalc(const double lot, const double pips, const int OutputType);
};

EVENT_MAP_BEGIN(CEntry)
EVENT_MAP_END(CAppDialog)

CEntry ::CEntry() : m_sl_point(200), m_loss(0), m_profit(0), m_lot(0)
{
}

CEntry ::~CEntry()
{
}
bool CEntry::Create(const long chart, const string name, const int subwin, const int x1, const int y1, const int x2, const int y2)
{
   if (!CAppDialog::Create(chart, name, subwin, x1, y1, x2, y2))
      return false;
   if (!CreateMain(chart, name, subwin))
      return false;
   if (!CreateEntryRow(chart, name, subwin))
      return false;
   if (!CreateUpperRow(chart, name, subwin))
      return false;
   if (!CreateLowerRow(chart, name, subwin))
      return false;
   if (!CreateSelectRow(chart, name, subwin))
      return false;

   if (!m_main.Add(m_Entry_row))
      return false;
   if (!m_main.Add(m_upper_row))
      return false;
   if (!m_main.Add(m_lower_row))
      return false;
   if (!m_main.Add(m_select_row))
      return false;
   if (!m_main.Pack())
      return false;
   if (!Add(m_main))
      return false;
   return (true);
}

// Create main
bool CEntry::CreateMain(const long chart, const string name, const int subwin)
{
   if (!m_main.Create(chart, name + "main", subwin, 0, 0, CDialog::m_client_area.Width(), CDialog::m_client_area.Height()))
      return false;
   m_main.LayoutStyle(LAYOUT_STYLE_VERTICAL);
   m_main.Padding(20);
   m_main.ColorBackground(BACKGROUND);
   return (true);
}

bool CEntry::CreateEntryRow(const long chart, const string name, const int subwin)
{
   if (!m_Entry_row.Create(chart, name + "entry_row", subwin, 0, 0, CDialog::m_client_area.Width(), CONTROL_HEIGHT))
      return false;
   if (!m_Entry_label.Create(chart, name + "entry_label", subwin, 0, 0, CONTROL_WIDTH, CONTROL_HEIGHT))
      return (false);
   m_Entry_label.Text("Select your Zone");
   m_Entry_label.Color(clrWhite);
   m_Entry_row.ColorBackground(BACKGROUND);
   if (!m_Entry_row.Add(m_Entry_label))
      return false;

   return (true);
}
bool CEntry::CreateUpperRow(const long chart, const string name, const int subwin)
{
   if (!m_upper_row.Create(chart, name + "upper_row", subwin, 0, 0, CDialog::m_client_area.Width(), CONTROL_HEIGHT))
      return false;

   if (!m_upper_label.Create(chart, name + "upper_label", subwin, 0, 0, CONTROL_WIDTH, CONTROL_HEIGHT))
      return false;
   if (!m_upper_edit.Create(chart, name + "upper_Edit", subwin, 0, 0, CONTROL_WIDTH, CONTROL_HEIGHT))
      return false;
   m_upper_label.Text("Upper");
   m_upper_label.Color(clrWhite);
   m_upper_row.ColorBackground(BACKGROUND);
   if (!m_upper_row.Add(m_upper_label))
      return false;

   if (!m_upper_row.Add(m_upper_edit))
      return false;
   return (true);
}
bool CEntry::CreateLowerRow(const long chart, const string name, const int subwin)
{
   if (!m_lower_row.Create(chart, name + "lower_row", subwin, 0, 0, CDialog::m_client_area.Width(), CONTROL_HEIGHT))
      return false;
   if (!m_lower_label.Create(chart, name + "lower_label", subwin, 0, 0, CONTROL_WIDTH, CONTROL_HEIGHT))
      return false;
   if (!m_lower_edit.Create(chart, name + "lower_Edit", subwin, 0, 0, CONTROL_WIDTH, CONTROL_HEIGHT))
      return false;
   m_lower_label.Text("Lower");
   m_lower_label.Color(clrWhite);
   m_lower_row.ColorBackground(BACKGROUND);
   if (!m_lower_row.Add(m_lower_label))
      return false;

   if (!m_lower_row.Add(m_lower_edit))
      return false;
   return (true);
}

bool CEntry::CreateSelectRow(const long chart, const string name, const int subwin)
{
   if (!m_select_row.Create(chart, name + "Select_row", subwin, 0, 0, CONTROL_WIDTH * 2, CONTROL_HEIGHT))
      return false;
   if (!m_select_button.Create(chart, name + "Select_button", subwin, 0, 0, CONTROL_WIDTH * 2, CONTROL_HEIGHT))
      return false;
   m_select_button.Text("Select");
   m_select_button.ColorBackground(BUTTON_GREEN);
   m_select_button.ColorBorder(clrWhite);
   m_select_button.FontSize(12);

   if (!m_select_row.Add(m_select_button))
      return false;

   return (true);
}
// Create Horizontal lines
bool CEntry::CreateLine(CChartObjectHLine &object, const string name, const double price, const color Color, const int Width)
{
   if (!object.Create(0, name, 0, price))
      return false;
   object.Color(Color);
   object.Selectable(true);
   object.Width(Width);
   object.Selected(true);
   return (true);
}
// Validate Lot vol
bool CEntry::OnTick(void)
{
  
   
   return true;
}