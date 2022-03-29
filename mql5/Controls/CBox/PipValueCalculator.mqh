//+------------------------------------------------------------------+
//|                                           PipValueCalculator.mqh |
//|                                                   Enrico Lambino |
//|                                      www.mql5.com/en/users/iceron|
//+------------------------------------------------------------------+
#property copyright "Enrico Lambino"
#property link "www.mql5.com/en/users/iceron"
#property strict
#include <Trade\SymbolInfo.mqh>
#include <Layouts\Box.mqh>
#include <Controls\Dialog.mqh>
#include <Controls\Label.mqh>
#include <Controls\Button.mqh>

#define CONTROL_WIDTH (100)
#define CONTROL_HEIGHT (20)
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CPipValueCalculatorDialog : public CAppDialog
{
protected:
   CSymbolInfo *m_symbol;
   CBox m_main;
   CBox m_symbol_row;
   CLabel m_symbol_label;
   CEdit m_symbol_edit;
   CBox m_pip_size_row;
   CLabel m_pip_size_label;
   CEdit m_pip_size_edit;
   CBox m_pip_value_row;
   CLabel m_pip_value_label;
   CEdit m_pip_value_edit;
   CBox m_button_row;
   CButton m_button;
   int m_digits_adjust;
   double m_points_adjust;

public:
   CPipValueCalculatorDialog();
   ~CPipValueCalculatorDialog();
   virtual bool Create(const long chart, const string name, const int subwin, const int x1, const int y1, const int x2, const int y2);
   virtual bool OnEvent(const int id, const long &lparam, const double &dparam, const string &sparam);

protected:
   virtual bool CreateMain(const long chart, const string name, const int subwin);
   virtual bool CreateSymbolRow(const long chart, const string name, const int subwin);
   virtual bool CreatePipSizeRow(const long chart, const string name, const int subwin);
   virtual bool CreatePipValueRow(const long chart, const string name, const int subwin);
   virtual bool CreateButtonRow(const long chart, const string name, const int subwin);
   void OnClickButton();
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
EVENT_MAP_BEGIN(CPipValueCalculatorDialog)
ON_EVENT(ON_CLICK, m_button, OnClickButton)
EVENT_MAP_END(CAppDialog)
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CPipValueCalculatorDialog::CPipValueCalculatorDialog(void)
{
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CPipValueCalculatorDialog::~CPipValueCalculatorDialog(void)
{
   if (m_symbol != NULL)
   {
      delete m_symbol;
      m_symbol = NULL;
   }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CPipValueCalculatorDialog::Create(const long chart, const string name, const int subwin, const int x1, const int y1, const int x2, const int y2)
{
   if (m_symbol == NULL)
      m_symbol = new CSymbolInfo();
   if (m_symbol != NULL)
   {
      if (!m_symbol.Name(_Symbol))
         return (false);
   }
   if (!CAppDialog::Create(chart, name, subwin, x1, y1, x2, y2))
      return (false);
   if (!CreateMain(chart, name, subwin))
      return (false);
   if (!CreateSymbolRow(chart, name, subwin))
      return (false);
   if (!CreatePipSizeRow(chart, name, subwin))
      return (false);
   if (!CreatePipValueRow(chart, name, subwin))
      return (false);
   if (!CreateButtonRow(chart, name, subwin))
      return (false);
   if (!m_main.Add(m_symbol_row))
      return (false);
   if (!m_main.Add(m_pip_size_row))
      return (false);
   if (!m_main.Add(m_pip_value_row))
      return (false);
   if (!m_main.Add(m_button_row))
      return (false);
   if (!m_main.Pack())
      return (false);
   if (!Add(m_main))
      return (false);
   OnClickButton();
   return (true);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CPipValueCalculatorDialog::CreateMain(const long chart, const string name, const int subwin)
{
   if (!m_main.Create(chart, name + "main", subwin, 0, 0, CDialog::m_client_area.Width(), CDialog::m_client_area.Height()))
      return (false);
   m_main.LayoutStyle(LAYOUT_STYLE_VERTICAL);
   m_main.Padding(10);
   return (true);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CPipValueCalculatorDialog::CreateSymbolRow(const long chart, const string name, const int subwin)
{
   if (!m_symbol_row.Create(chart, name + "symbol_row", subwin, 0, 0, CDialog::m_client_area.Width(), CONTROL_HEIGHT * 1.5))
      return (false);
   if (!m_symbol_label.Create(chart, name + "symbol_label", subwin, 0, 0, CONTROL_WIDTH, CONTROL_HEIGHT))
      return (false);
   m_symbol_label.Text("Symbol");
   if (!m_symbol_edit.Create(chart, name + "symbol_edit", subwin, 0, 0, CONTROL_WIDTH, CONTROL_HEIGHT))
      return (false);
   m_symbol_edit.Text(m_symbol.Name());
   if (!m_symbol_row.Add(m_symbol_label))
      return (false);
   if (!m_symbol_row.Add(m_symbol_edit))
      return (false);
   return (true);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CPipValueCalculatorDialog::CreatePipSizeRow(const long chart, const string name, const int subwin)
{
   if (!m_pip_size_row.Create(chart, name + "pipsize_row", subwin, 0, 0, CDialog::m_client_area.Width(), CONTROL_HEIGHT * 1.5))
      return (false);
   if (!m_pip_size_label.Create(chart, name + "pipsize_label", subwin, 0, 0, CONTROL_WIDTH, CONTROL_HEIGHT))
      return (false);
   m_pip_size_label.Text("Pip Size");
   if (!m_pip_size_edit.Create(chart, name + "pipsize_edit", subwin, 0, 0, CONTROL_WIDTH, CONTROL_HEIGHT))
      return (false);
   m_pip_size_edit.ReadOnly(true);
   m_pip_size_edit.Text((string)m_points_adjust);
   if (!m_pip_size_row.Add(m_pip_size_label))
      return (false);
   if (!m_pip_size_row.Add(m_pip_size_edit))
      return (false);
   return (true);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CPipValueCalculatorDialog::CreatePipValueRow(const long chart, const string name, const int subwin)
{
   if (!m_pip_value_row.Create(chart, name + "pipvalue_row", subwin, 0, 0, CDialog::m_client_area.Width(), CONTROL_HEIGHT * 1.5))
      return (false);
   if (!m_pip_value_label.Create(chart, name + "pipvalue_label", subwin, 0, 0, CONTROL_WIDTH, CONTROL_HEIGHT))
      return (false);
   m_pip_value_label.Text("Pip Value");
   if (!m_pip_value_edit.Create(chart, name + "pipvalue_edit", subwin, 0, 0, CONTROL_WIDTH, CONTROL_HEIGHT))
      return (false);
   m_pip_value_edit.ReadOnly(true);
   if (!m_pip_value_row.Add(m_pip_value_label))
      return (false);
   if (!m_pip_value_row.Add(m_pip_value_edit))
      return (false);
   return (true);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CPipValueCalculatorDialog::CreateButtonRow(const long chart, const string name, const int subwin)
{
   if (!m_button_row.Create(chart, name + "button_row", subwin, 0, 0, CDialog::m_client_area.Width(), CONTROL_HEIGHT * 1.5))
      return (false);
   m_button_row.HorizontalAlign(HORIZONTAL_ALIGN_RIGHT);
   if (!m_button.Create(chart, name + "button_button", subwin, 0, 0, CONTROL_WIDTH, CONTROL_HEIGHT))
      return (false);
   m_button.Text("Calculate");
   if (!m_button_row.Add(m_button))
      return (false);
   return (true);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CPipValueCalculatorDialog::OnClickButton()
{
   string symbol = m_symbol_edit.Text();
   StringToUpper(symbol);
   if (m_symbol.Name(symbol))
   {
      m_symbol.RefreshRates();
      m_digits_adjust = (m_symbol.Digits() == 3 || m_symbol.Digits() == 5) ? 10 : 1;
      m_points_adjust = m_symbol.Point() * m_digits_adjust;
      m_pip_size_edit.Text((string)m_points_adjust);
      m_pip_value_edit.Text(DoubleToString(m_symbol.TickValue() * (StringToDouble(m_pip_size_edit.Text())) / m_symbol.TickSize(), 2));
   }
   else
      Print("invalid input");
}
//+------------------------------------------------------------------+
