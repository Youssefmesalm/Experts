//+------------------------------------------------------------------+
//|                                               RiskCalculator.mqh |
//|                                                    Yousuf Mesalm |
//|                               www.mql5.com/en/users/yousuf_Mesalm|
//+------------------------------------------------------------------+
#property copyright "Yousuf Mesalm"
#property link "www.mql5.com/en/users/Yousuf_Mesalm"
#property strict
#include <Controls/Dialog.mqh>
#include <Controls/Label.mqh>
#include <Controls/BmpButton.mqh>
#include <Controls/Button.mqh>
#include <Trade/AccountInfo.mqh>
#include <Trade/SymbolInfo.mqh>
#include <Trade/Trade.mqh>
#include <ChartObjects/ChartObjectsLines.mqh>
#include <ChartObjects/ChartObjectsTxtControls.mqh>
#include <MQL_Easy/MQL_Easy.mqh>
#include <Experts/RiskCalculator/defines.mqh>
#include <Experts/RiskCalculator/Box.mqh>

class CRiskCalculator : public CAppDialog
{
private:
   /* data */
   CBox m_main;
   CBox m_lock_row;
   CLabel m_lock_label;
   CBox m_risk_row;
   CLabel m_risk_label;
   CEdit m_risk_edit;
   CBox m_ratio_row;
   CLabel m_ratio_label;
   CEdit m_ratio_edit;
   CBox m_calculation_actions_row;
   CBmpButton m_calc_sell_button;
   CBmpButton m_calc_buy_button;
   CBmpButton m_calc_settings_button;
   CBox m_execution_row;
   CButton m_execute_button;
   CBox m_pending_row;
   CButton m_pending_button;
   CButton m_enter_button;
   CChartObjectHLine m_sl_line;
   CChartObjectText m_sl_label;
   CChartObjectHLine m_tp_line;
   CChartObjectText m_tp_label;
   CChartObjectHLine m_market_price_line;
   CChartObjectText m_market_price_label;

   // Experts
   CAccountInfo *m_account;
   CExecute m_trade;
   CUtilities utlis;

   //  Variables
   double m_sl_point;
   double m_lot;
   double m_sl, m_tp, m_market;
   double m_profit, m_loss;
   string m_Pending_type;
   int m_trade_type;

public:
   CRiskCalculator();
   ~CRiskCalculator();
   virtual bool Create(const long chart, const string name, const int subwin, const int x1, const int y1, const int x2, const int y2);
   virtual bool OnEvent(const int id, const long &lparam, const double &dparam, const string &sparam);
   bool ChartDrag(const int id, const long &lparam, const double &dparam, const string &sparam);
   virtual bool OnTick();

protected:
   // Create functions
   virtual bool CreateMain(const long chart, const string name, const int subwin);
   virtual bool CreateLockRow(const long chart, const string name, const int subwin);
   virtual bool CreateRatioRow(const long chart, const string name, const int subwin);
   virtual bool CreateRiskRow(const long chart, const string name, const int subwin);
   virtual bool CreateCalculationRow(const long chart, const string name, const int subwin);
   virtual bool CreateExecutonRow(const long chart, const string name, const int subwin);
   virtual bool CreatePending(const long chart, const string name, const int subwin);
   virtual bool CreateLine(CChartObjectHLine &object, const string name, const double price, const color Color, const int Width);
   virtual bool CreateChartText(CChartObjectText &label, const string name, const double price, const color Color, const double profit, const double pips);

   //Events Handler
   void CalcBuy();
   void CalcSell();
   void DragTakeProfitLine();
   void DragStopLossLine();
   void DragMakeLine();
   void ExecuteClick();
   void CalcPending();
   void EnterClick();

   // Additional Methods
   double OrderOutputCalc(const double lot, const double pips, const int OutputType);
};

EVENT_MAP_BEGIN(CRiskCalculator)
ON_EVENT(ON_CLICK, m_calc_buy_button, CalcBuy)
ON_EVENT(ON_CLICK, m_calc_sell_button, CalcSell)
ON_EVENT(ON_CLICK, m_execute_button, ExecuteClick)
ON_EVENT(ON_CLICK, m_pending_button, CalcPending)
ON_EVENT(ON_CLICK, m_enter_button, EnterClick)
EVENT_MAP_END(CAppDialog)

CRiskCalculator ::CRiskCalculator() : m_sl_point(200), m_loss(0), m_profit(0), m_lot(0)
{

   if (m_account == NULL)
   {
      m_account = new CAccountInfo;
   }
   m_trade.SetMagicNumber(2020);
   m_trade.SetSymbol(_Symbol);

   if (CheckPointer(m_account) == POINTER_INVALID)
      Print(__FUNCTION__, " the variable 'object' isn't initialized!");
}

CRiskCalculator ::~CRiskCalculator()
{

   if (m_account != NULL)
   {
      delete m_account;
      m_account = NULL;
   }
}
bool CRiskCalculator::Create(const long chart, const string name, const int subwin, const int x1, const int y1, const int x2, const int y2)
{

   if (!CAppDialog::Create(chart, name, subwin, x1, y1, x2, y2))
      return false;
   if (!CreateMain(chart, name, subwin))
      return false;
   if (!CreateLockRow(chart, name, subwin))
      return false;
   if (!CreateRiskRow(chart, name, subwin))
      return false;
   if (!CreateRatioRow(chart, name, subwin))
      return false;
   if (!CreateCalculationRow(chart, name, subwin))
      return false;
   if (!CreateExecutonRow(chart, name, subwin))
      return false;
   if (!CreatePending(chart, name, subwin))
      return false;

   if (!m_main.Add(m_lock_row))
      return false;
   if (!m_main.Add(m_risk_row))
      return false;
   if (!m_main.Add(m_ratio_row))
      return false;
   if (!m_main.Add(m_calculation_actions_row))
      return false;
   if (!m_main.Add(m_execution_row))
      return false;
   if (!m_main.Add(m_pending_row))
      return false;
   if (!m_main.Pack())
      return false;
   if (!Add(m_main))
      return false;
   return (true);
}

// Create main
bool CRiskCalculator::CreateMain(const long chart, const string name, const int subwin)
{
   if (!m_main.Create(chart, name + "main", subwin, 0, 0, CDialog::m_client_area.Width(), CDialog::m_client_area.Height()))
      return false;
   m_main.LayoutStyle(LAYOUT_STYLE_VERTICAL);
   m_main.Padding(20);
   m_main.ColorBackground(BACKGROUND);
   return (true);
}

bool CRiskCalculator::CreateLockRow(const long chart, const string name, const int subwin)
{
   if (!m_lock_row.Create(chart, name + "lock_row", subwin, 0, 0, CDialog::m_client_area.Width(), CONTROL_HEIGHT))
      return false;
   if (!m_lock_label.Create(chart, name + "lock_label", subwin, 0, 0, CONTROL_WIDTH, CONTROL_HEIGHT))
      return (false);
   m_lock_label.Text("LOCK IN YOUR RISK");
   m_lock_label.Color(clrWhite);
   m_lock_row.ColorBackground(BACKGROUND);
   if (!m_lock_row.Add(m_lock_label))
      return false;

   return (true);
}
bool CRiskCalculator::CreateRiskRow(const long chart, const string name, const int subwin)
{
   if (!m_risk_row.Create(chart, name + "risk_row", subwin, 0, 0, CDialog::m_client_area.Width(), CONTROL_HEIGHT))
      return false;

   if (!m_risk_label.Create(chart, name + "risk_label", subwin, 0, 0, CONTROL_WIDTH, CONTROL_HEIGHT))
      return false;
   if (!m_risk_edit.Create(chart, name + "risk_Edit", subwin, 0, 0, CONTROL_WIDTH, CONTROL_HEIGHT))
      return false;
   m_risk_label.Text("% Risk");
   m_risk_label.Color(clrWhite);
   m_risk_row.ColorBackground(BACKGROUND);
   if (!m_risk_row.Add(m_risk_label))
      return false;

   if (!m_risk_row.Add(m_risk_edit))
      return false;
   return (true);
}
bool CRiskCalculator::CreateRatioRow(const long chart, const string name, const int subwin)
{
   if (!m_ratio_row.Create(chart, name + "ratio_row", subwin, 0, 0, CDialog::m_client_area.Width(), CONTROL_HEIGHT))
      return false;
   if (!m_ratio_label.Create(chart, name + "ratio_label", subwin, 0, 0, CONTROL_WIDTH, CONTROL_HEIGHT))
      return false;
   if (!m_ratio_edit.Create(chart, name + "ratio_Edit", subwin, 0, 0, CONTROL_WIDTH, CONTROL_HEIGHT))
      return false;
   m_ratio_label.Text("% ratio");
   m_ratio_label.Color(clrWhite);
   m_ratio_row.ColorBackground(BACKGROUND);
   if (!m_ratio_row.Add(m_ratio_label))
      return false;

   if (!m_ratio_row.Add(m_ratio_edit))
      return false;
   return (true);
}
bool CRiskCalculator::CreateCalculationRow(const long chart, const string name, const int subwin)
{
   if (!m_calculation_actions_row.Create(chart, name + "calculation_row", subwin, 0, 0, CDialog::m_client_area.Width(), CONTROL_HEIGHT * 2.5))
      return false;
   if (!m_calc_sell_button.Create(chart, name + "sell_button_calc", subwin, 0, 0, CONTROL_WIDTH / 2, CONTROL_HEIGHT * 2))
      return false;
   m_calc_sell_button.BmpNames("Images\\sell.bmp", "Images\\sell.bmp");

   if (!m_calculation_actions_row.Add(m_calc_sell_button))
      return false;

   if (!m_calc_buy_button.Create(chart, name + "buy_button_calc", subwin, 0, 0, CONTROL_WIDTH / 2, CONTROL_HEIGHT * 2))
      return false;
   m_calc_buy_button.BmpNames("images\\buy.bmp", "images\\buy.bmp");

   if (!m_calculation_actions_row.Add(m_calc_buy_button))
      return false;
   if (!m_calc_settings_button.Create(chart, name + "settings_button_calc", subwin, 0, 0, CONTROL_WIDTH / 2, CONTROL_HEIGHT * 2))
      return false;
   m_calc_settings_button.BmpNames("images\\settings.bmp", "images\\settings.bmp");

   if (!m_calculation_actions_row.Add(m_calc_settings_button))
      return false;
   m_calculation_actions_row.ColorBackground(BACKGROUND);
   return (true);
}
bool CRiskCalculator::CreateExecutonRow(const long chart, const string name, const int subwin)
{
   if (!m_execution_row.Create(chart, name + "execution_row", subwin, 0, 0, CONTROL_WIDTH * 2, CONTROL_HEIGHT))
      return false;
   if (!m_execute_button.Create(chart, name + "execute_button", subwin, 0, 0, CONTROL_WIDTH * 2, CONTROL_HEIGHT))
      return false;
   m_execute_button.Text("EXECUTE TRADE");
   m_execute_button.ColorBackground(BUTTON_GREEN);
   m_execute_button.ColorBorder(clrWhite);
   m_execute_button.FontSize(15);

   if (!m_execution_row.Add(m_execute_button))
      return false;

   return (true);
}
// Create Pending
bool CRiskCalculator::CreatePending(const long chart, const string name, const int subwin)
{
   if (!m_pending_row.Create(chart, name + "pending_row", subwin, 0, 0, CONTROL_WIDTH * 2, CONTROL_HEIGHT * 3))
      return false;
   m_pending_row.LayoutStyle(LAYOUT_STYLE_VERTICAL);
   m_pending_row.ColorBackground(BACKGROUND);
   m_pending_row.PaddingTop(10);
   if (!m_pending_button.Create(chart, name + "pending button", subwin, 0, 0, CONTROL_WIDTH * 2, CONTROL_HEIGHT))
      return false;
   if (!m_enter_button.Create(chart, name + "enter button", subwin, 0, 0, CONTROL_WIDTH * 2, CONTROL_HEIGHT))
      return false;
   if (!m_pending_row.Add(m_pending_button))
      return false;
   if (!m_pending_row.Add(m_enter_button))
      return false;
   m_pending_button.Text("Pending Order");
   m_enter_button.Text("Enter");
   return (true);
}
//  Crate Chart Label
bool CRiskCalculator::CreateChartText(CChartObjectText &label, const string name, const double price, const color Color, const double profit, const double pips)
{
   if (!label.Create(0, name, 0, 0, 0))

      return false;
   string x = profit > 0 ? "profit" : "loss";

   string Desc = label.Name() == "market price label" ? "Des: " + DoubleToString(pips, 2) + " spread :" + DoubleToString(utlis.Spread(), 2) : x + ": " + DoubleToString(profit, 2) + " Pips: " + DoubleToString(pips, 2) + " Lot: " + DoubleToString(m_lot, 2);
   label.Color(Color);
   label.Description(Desc);
   label.Price(0, price);
   label.Time(0, TimeCurrent());
   label.Anchor(ANCHOR_RIGHT_LOWER);

   return true;
}
// Create Horizontal lines
bool CRiskCalculator::CreateLine(CChartObjectHLine &object, const string name, const double price, const color Color, const int Width)
{
   if (!object.Create(0, name, 0, price))
      return false;
   object.Color(Color);
   object.Selectable(true);
   object.Width(Width);
   object.Selected(true);
   return (true);
}
// Method to send buy order when click calc buy button
void CRiskCalculator::CalcBuy(void)
{
   double freeMargin = m_account.FreeMargin();
   double risk = StringToDouble(m_risk_edit.Text());
   double ratio = StringToDouble(m_ratio_edit.Text()) < 1.00 ? 1 : StringToDouble(m_ratio_edit.Text());
   m_sl = NormalizeDouble(utlis.Ask() - (m_sl_point * utlis.Point()), utlis.Digits());
   m_tp = NormalizeDouble(utlis.Bid() + ((m_sl_point * ratio) * utlis.Point()), utlis.Digits());
   m_lot = utlis.NormalizeVolume(m_account.MaxLotCheck(_Symbol, ORDER_TYPE_BUY, utlis.Bid(), risk));

   if (!CreateLine(m_sl_line, "stop loss", m_sl, clrRed, 2))
      PrintFormat("Can't create Stoploss Line");
   // Calculate loss
   double losspips = utlis.Ask() - m_sl_line.Price(0);
   double pips = losspips / _Point;
   m_loss = OrderOutputCalc(m_lot, losspips, 0);
   if (!CreateChartText(m_sl_label, "stop loss chart label", m_sl, clrRed, m_loss, pips))
      PrintFormat("chart stop loss label failed to mount");

   if (!CreateLine(m_tp_line, "take profit", m_tp, clrGreen, 2))
      PrintFormat("Can't create Stoploss Line");
   // Calculate profit
   double profitpips = m_tp_line.Price(0) - utlis.Ask();
   pips = profitpips / _Point;
   m_profit = OrderOutputCalc(m_lot, profitpips, 1);
   if (!CreateChartText(m_tp_label, "takeprofit chart label", m_tp, clrGreen, m_profit, pips))
      PrintFormat("chart take profit label failed to mount");

   m_trade_type = 1;
}
void CRiskCalculator::CalcSell(void)
{
   double freeMargin = m_account.FreeMargin();
   double risk = StringToDouble(m_risk_edit.Text());
   double ratio = StringToDouble(m_ratio_edit.Text()) < 1.00 ? 1 : StringToDouble(m_ratio_edit.Text());
   m_sl = NormalizeDouble(utlis.Bid() + (m_sl_point * utlis.Point()), utlis.Digits());
   m_tp = NormalizeDouble(utlis.Ask() - ((m_sl_point * ratio) * utlis.Point()), utlis.Digits());
   m_lot = utlis.NormalizeVolume(m_account.MaxLotCheck(_Symbol, ORDER_TYPE_SELL, utlis.Ask(), risk));

   if (!CreateLine(m_sl_line, "stop loss", m_sl, clrRed, 2))
      PrintFormat("Can't create Stoploss Line");
   if (!CreateLine(m_tp_line, "take profit", m_tp, clrGreen, 2))
      PrintFormat("Can't create Stoploss Line");

   // Calculate profit
   double profitpips = utlis.Ask() - m_tp_line.Price(0);
   double pips = profitpips / _Point;
   m_profit = OrderOutputCalc(m_lot, profitpips, 1);
   if (!CreateChartText(m_tp_label, "takeprofit chart label", m_tp, clrGreen, m_profit, pips))
      PrintFormat("chart take profit label failed to mount");

   // Calculate loss
   double losspips = m_sl_line.Price(0) - utlis.Ask();
   pips = losspips / _Point;
   m_loss = OrderOutputCalc(m_lot, losspips, 0);
   if (!CreateChartText(m_sl_label, "stop loss chart label", m_sl, clrRed, m_loss, pips))
      PrintFormat("chart stop loss label failed to mount");
   m_trade_type = 0;
}

;

//  Additional functions

// Validate Lot volume
// double CRiskCalculator::utlis.NormalizeVolume(const double lot)
// {
//    double result = 0;
//    double MaxLot = m_symbol.LotsMax();
//    double MinLot = m_symbol.LotsMin();
//    if (lot > 0)
//    {
//       result = MathMax(lot, MinLot);
//       result = MathMin(result, MaxLot);
//    }
//    else if (lot < 0)
//    {
//       result = MinLot;
//    }
//    double NormalizedLot = NormalizeDouble(result, 2);
//    return NormalizedLot;
// }

//  caclculate  profit and loss value in m_money
double CRiskCalculator::OrderOutputCalc(const double lot, const double pips, const int OutputType)
{
   double result = lot * pips * 100000;
   if (OutputType > 0)
   {
      result = result;
   }
   else
   {
      result = result * -1;
   }

   return NormalizeDouble(result, 2);
}

// hanfle Penfing Calculation button click
void CRiskCalculator::CalcPending(void)
{
   double freeMargin = m_account.FreeMargin();
   double risk = StringToDouble(m_risk_edit.Text());
   double ratio = StringToDouble(m_ratio_edit.Text()) < 1.00 ? 1 : StringToDouble(m_ratio_edit.Text());
   m_sl = NormalizeDouble(utlis.Ask() - (m_sl_point * utlis.Point()), utlis.Digits());
   m_tp = NormalizeDouble(utlis.Bid() + ((m_sl_point * ratio) * utlis.Point()), utlis.Digits());
   m_lot = utlis.NormalizeVolume(m_account.MaxLotCheck(_Symbol, ORDER_TYPE_BUY, utlis.Bid(), risk));

   if (!CreateLine(m_sl_line, "stop loss", m_sl, clrRed, 2))
      PrintFormat("Can't create Stoploss Line");
   // Calculate loss
   double losspips = utlis.Ask() - m_sl_line.Price(0);
   double pips = losspips / _Point;
   m_loss = OrderOutputCalc(m_lot, losspips, 0);
   if (!CreateChartText(m_sl_label, "stop loss chart label", m_sl, clrRed, m_loss, pips))
      PrintFormat("chart stop loss label failed to mount");

   if (!CreateLine(m_tp_line, "take profit", m_tp, clrGreen, 2))
      PrintFormat("Can't create Stoploss Line");
   // Calculate profit
   double profitpips = m_tp_line.Price(0) - utlis.Ask();
   pips = profitpips / _Point;
   m_profit = OrderOutputCalc(m_lot, profitpips, 1);
   if (!CreateChartText(m_tp_label, "takeprofit chart label", m_tp, clrGreen, m_profit, pips))
      PrintFormat("chart take profit label failed to mount");
   // Create market price line
   m_market = utlis.Ask();
   if (!CreateLine(m_market_price_line, "market price", m_market, clrYellow, 2))
      PrintFormat("Can't create Market price Line");

   if (!CreateChartText(m_market_price_label, "market price label", m_market, clrYellow, 0, 0))
      PrintFormat("chart market price label failed to mount");
   m_trade_type = 2;
}
// handle Execute Button click`
void CRiskCalculator::ExecuteClick()
{

   m_sl = m_sl_line.Price(0);
   m_tp = m_tp_line.Price(0);

   if (m_trade_type == 0)
   {
      m_trade.Position(TYPE_POSITION_SELL, m_lot, m_sl, m_tp, SLTP_PRICE, 20, "Expert");
      m_trade_type = 0;
      m_tp_line.Delete();
      m_sl_line.Delete();
      m_sl_label.Delete();
      m_tp_label.Delete();
   }
   else if (m_trade_type == 1)
   {
      m_trade.Position(TYPE_POSITION_BUY, m_lot, m_sl, m_tp, SLTP_PRICE, 20, "Expert");
      m_trade_type = 0;
      m_tp_line.Delete();
      m_sl_line.Delete();
      m_sl_label.Delete();
      m_tp_label.Delete();
   }
   else if (m_trade_type == 0)
   {
      Alert("Please select Trade Before Execute");
   }
}
// handle Enter button
void CRiskCalculator::EnterClick(void)
{
   m_sl = m_sl_line.Price(0);
   m_tp = m_tp_line.Price(0);
   m_market = m_market_price_line.Price(0);
   if (m_trade_type == 2)
   {
      if (m_market > utlis.Ask())
      {

         m_market = m_market_price_line.Price(0);
         if (m_tp > m_market && m_sl < m_market)
         {
            m_trade.Order(TYPE_ORDER_BUYSTOP, m_lot, m_market, m_sl, m_tp, SLTP_PRICE, 0, 20, "Expert");
            m_trade_type = 0;
            m_tp_line.Delete();
            m_sl_line.Delete();
            m_sl_label.Delete();
            m_tp_label.Delete();
            m_market_price_line.Delete();
         }
         else if (m_tp < m_market && m_sl > m_market)
         {
            m_trade.Order(TYPE_ORDER_SELLLIMIT, m_lot, m_market, m_sl, m_tp, SLTP_PRICE, 0, 20, "Expert");
            m_trade_type = 0;
            m_tp_line.Delete();
            m_sl_line.Delete();
            m_sl_label.Delete();
            m_tp_label.Delete();
            m_market_price_line.Delete();
            ;
         }
      }
      else if (m_market < utlis.Ask())
      {
         if (m_tp < m_market && m_sl > m_market)
         {
            m_trade.Order(TYPE_ORDER_SELLSTOP, m_lot, m_market, m_sl, m_tp, SLTP_PRICE, 0, 20, "Expert");
            m_trade_type = 0;
            m_tp_line.Delete();
            m_sl_line.Delete();
            m_market_price_line.Delete();
         }
         else if (m_tp > m_market && m_sl < m_market)
         {
            m_trade.Order(TYPE_ORDER_BUYLIMIT, m_lot, m_market, m_sl, m_tp, SLTP_PRICE, 0, 20, "Expert");
            m_trade_type = 0;
            m_tp_line.Delete();
            m_sl_line.Delete();
            m_market_price_line.Delete();
         }
      }
   }
}
// handle Lines Drag

void CRiskCalculator::DragTakeProfitLine(void)
{
   double new_price = m_tp_line.Price(0);
   m_tp_label.Price(0, new_price);

   if (m_trade_type == 0)
   { // Calculate profit
      double profitpips = utlis.Ask() - m_tp_line.Price(0);
      double pips = profitpips / _Point;
      m_profit = OrderOutputCalc(m_lot, profitpips, 1);
      string Desc = "Profit: " + DoubleToString(m_profit, 2) + " Pips: " + DoubleToString(pips, 2) + " Lot: " + DoubleToString(m_lot, 2);
      m_tp_label.Description(Desc);
   }
   else if (m_trade_type == 1)
   {
      double profitpips = m_tp_line.Price(0) - utlis.Ask();
      double pips = profitpips / _Point;
      m_profit = OrderOutputCalc(m_lot, profitpips, 1);
      string Desc = "Profit: " + DoubleToString(m_profit, 2) + " Pips: " + DoubleToString(pips, 2) + " Lot: " + DoubleToString(m_lot, 2);
      m_tp_label.Description(Desc);
   }
   else if (m_trade_type == 2)
   {
      m_market = m_market_price_line.Price(0);
      if (m_market > utlis.Ask())
      {

         double profitpips = m_market_price_line.Price(0) - utlis.Ask();
         double pips = profitpips / _Point;
         double Spread = utlis.Spread();
         if (m_tp > m_market && m_sl < m_market)
         {
            m_Pending_type = "Buy Stop";

            string Desc = "Des: " + DoubleToString(pips, 2) + " spread :" + DoubleToString(Spread, 2) + m_Pending_type;
            m_tp_line.Description(Desc);
         }
         else if (m_tp < m_market && m_sl > m_market)
         {
            m_Pending_type = "Sell Limit";

            string Desc = "Des: " + DoubleToString(pips, 2) + " spread :" + DoubleToString(Spread, 2) + m_Pending_type;
            m_tp_line.Description(Desc);

            ;
         }
      }
      else if (m_market < utlis.Ask())
      {
         double profitpips = utlis.Bid() - m_market_price_line.Price(0);
         double pips = profitpips / _Point;
         double Spread = utlis.Spread();
         if (m_tp < m_market && m_sl > m_market)
         {
            m_Pending_type = "Sell Stop";

            string Desc = "Des: " + DoubleToString(pips, 2) + " spread :" + DoubleToString(Spread, 2) + m_Pending_type;
            m_tp_line.Description(Desc);
         }
         else if (m_tp > m_market && m_sl < m_market)
         {
            m_Pending_type = "Buy Limit";

            string Desc = "Des: " + DoubleToString(pips, 2) + " spread :" + DoubleToString(Spread, 2) + m_Pending_type;
            m_tp_line.Description(Desc);
         }
      }
   }
}
// Market price line for pending order drage handler
void CRiskCalculator::DragMakeLine(void)
{
   if (m_trade_type == 2)
   {
      m_market = m_market_price_line.Price(0);
      if (m_market > utlis.Ask())
      {

         double profitpips = m_market_price_line.Price(0) - utlis.Ask();
         double pips = profitpips / _Point;
         double Spread = utlis.Spread();
         if (m_tp > m_market && m_sl < m_market)
         {
            m_Pending_type = "Buy Stop";

            string Desc = "Des: " + DoubleToString(pips, 2) + " spread :" + DoubleToString(Spread, 2) + m_Pending_type;
            m_market_price_label.Description(Desc);
         }
         else if (m_tp < m_market && m_sl > m_market)
         {
            m_Pending_type = "Sell Limit";

            string Desc = "Des: " + DoubleToString(pips, 2) + " spread :" + DoubleToString(Spread, 2) + m_Pending_type;
            m_market_price_label.Description(Desc);

            ;
         }
      }
      else if (m_market < utlis.Ask())
      {
         double profitpips = utlis.Bid() - m_market_price_line.Price(0);
         double pips = profitpips / _Point;
         double Spread = utlis.Spread();
         if (m_tp < m_market && m_sl > m_market)
         {
            m_Pending_type = "Sell Stop";

            string Desc = "Des: " + DoubleToString(pips, 2) + " spread :" + DoubleToString(Spread, 2) + m_Pending_type;
            m_market_price_label.Description(Desc);
         }
         else if (m_tp > m_market && m_sl < m_market)
         {
            m_Pending_type = "Buy Limit";

            string Desc = "Des: " + DoubleToString(pips, 2) + " spread :" + DoubleToString(Spread, 2) + m_Pending_type;
            m_market_price_label.Description(Desc);
         }
      }
      m_market_price_label.Price(0, m_market_price_line.Price(0));
   }
}

void CRiskCalculator::DragStopLossLine(void)
{
   double new_price = m_sl_line.Price(0);
   m_sl_label.Price(0, new_price);
   if (m_trade_type == 0)
   {
      double losspips = m_sl_line.Price(0) - utlis.Ask();
      double pips = losspips / _Point;
      m_loss = OrderOutputCalc(m_lot, losspips, 0);
      string Desc = "Loss: " + DoubleToString(m_loss, 2) + " Pips: " + DoubleToString(pips, 2) + " Lot: " + DoubleToString(m_lot, 2);
      m_sl_label.Description(Desc);
   }
   else if (m_trade_type == 1)
   {
      double losspips = utlis.Ask() - m_sl_line.Price(0);
      double pips = losspips / _Point;
      m_loss = OrderOutputCalc(m_lot, losspips, 0);

      string Desc = "Loss: " + DoubleToString(m_loss, 2) + " Pips: " + DoubleToString(pips, 2) + " Lot: " + DoubleToString(m_lot, 2);
      m_sl_label.Description(Desc);
   }
}
// Drag Event

bool CRiskCalculator::ChartDrag(const int id, const long &lparam, const double &dparam, const string &sparam)
{
   if (id == CHARTEVENT_OBJECT_DRAG)
   {
      if (sparam == m_tp_line.Name())
      {
         DragTakeProfitLine();
      }
      else if (sparam == m_sl_line.Name())
      {
         DragStopLossLine();
      }
      else if (sparam == m_market_price_line.Name())
      {
         DragMakeLine();
      }
   }
   return true;
}
bool CRiskCalculator::OnTick(void)
{
   if (m_trade_type == 2)
   {
      m_market = m_market_price_line.Price(0);
      if (m_market > utlis.Ask())
      {

         double profitpips = m_market_price_line.Price(0) - utlis.Ask();
         double pips = profitpips / _Point;
         double Spread = utlis.Spread();
         if (m_tp > m_market && m_sl < m_market)
         {
            m_Pending_type = "Buy Stop";

            string Desc = "Des: " + DoubleToString(pips, 2) + " spread :" + DoubleToString(Spread, 2) + m_Pending_type;
            m_market_price_label.Description(Desc);
         }
         else if (m_tp < m_market && m_sl > m_market)
         {
            m_Pending_type = "Sell Limit";

            string Desc = "Des: " + DoubleToString(pips, 2) + " spread :" + DoubleToString(Spread, 2) + m_Pending_type;
            m_market_price_label.Description(Desc);

            ;
         }
      }
      else if (m_market < utlis.Ask())
      {
         double profitpips = utlis.Bid() - m_market_price_line.Price(0);
         double pips = profitpips / _Point;
         double Spread = utlis.Spread();
         if (m_tp < m_market && m_sl > m_market)
         {
            m_Pending_type = "Sell Stop";

            string Desc = "Des: " + DoubleToString(pips, 2) + " spread :" + DoubleToString(Spread, 2) + m_Pending_type;
            m_market_price_label.Description(Desc);
         }
         else if (m_tp > m_market && m_sl < m_market)
         {
            m_Pending_type = "Buy Limit";

            string Desc = "Des: " + DoubleToString(pips, 2) + " spread :" + DoubleToString(Spread, 2) + m_Pending_type;
            m_market_price_label.Description(Desc);
         }
      }
   }
   return true;
}