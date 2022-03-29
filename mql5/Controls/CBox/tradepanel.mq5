//+------------------------------------------------------------------+
//|                                                   TradePanel.mq5 |
//|                                              Copyright 2015, DNG |
//|                                      https://forex-start.ucoz.ua |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, DNG"
#property link      "https://forex-start.ucoz.ua"
#property version   "1.00"

#include <Controls\Dialog.mqh>
#include <Controls\Label.mqh>
#include <Controls\Button.mqh>
#include <ChartObjects\ChartObjectsLines.mqh>
#include <Trade\AccountInfo.mqh>
#include <Trade\Trade.mqh>

//+------------------------------------------------------------------+
//| Resources                                                        |
//+------------------------------------------------------------------+
#resource "\\Include\\Controls\\res\\RadioButtonOn.bmp"
#resource "\\Include\\Controls\\res\\RadioButtonOff.bmp"
#resource "\\Include\\Controls\\res\\CheckBoxOn.bmp"
#resource "\\Include\\Controls\\res\\CheckBoxOff.bmp"
#resource "\\Include\\Controls\\res\\SpinInc.bmp"
#resource "\\Include\\Controls\\res\\SpinDec.bmp"

class CEdit_new : public CEdit
  {
public:
                     CEdit_new(void){};
                    ~CEdit_new(void){};
   virtual bool      Save(const int file_handle)
     {
      if(file_handle==INVALID_HANDLE)
        {
         return false;
        }
      string text=Text();
      FileWriteInteger(file_handle,StringLen(text));
      return(FileWriteString(file_handle,text)>0); 
     }
   virtual bool      Load(const int file_handle)
     {
      if(file_handle==INVALID_HANDLE)
        {
         return false;
        }
      int size=FileReadInteger(file_handle);
      string text=FileReadString(file_handle,size);
      return(Text(text));
     }
   
  };

class CBmpButton_new : public CBmpButton
  {
public:
                     CBmpButton_new(void){};
                    ~CBmpButton_new(void){};
   virtual bool      Save(const int file_handle)
    {
     if(file_handle==INVALID_HANDLE)
        {
         return false;
        }
      return(FileWriteInteger(file_handle,Pressed()));
     }
   virtual bool      Load(const int file_handle)
     {
      if(file_handle==INVALID_HANDLE)
        {
         return false;
        }
      return(Pressed((bool)FileReadInteger(file_handle)));
     }
  };

class CTradePanel : public CAppDialog
  {
private:
   #define  Y_STEP   (int)(ClientAreaHeight()/18/4)      // height step betwine elements
   #define  Y_WIDTH  (int)(ClientAreaHeight()/18)        // height of element
   #define  BORDER   (int)(ClientAreaHeight()/24)        // distance betwine boder and elements
   #define  SL_Line_color  clrRed                        // Stop Loss lines color
   #define  TP_Line_color  clrGreen                      // Take Profit lines color
             
   enum label_align
     {
      left=-1,
      right=1,
      center=0
     };

   CLabel            ASK, BID;                        // Display Ask and Bid prices
   CLabel            Balance_label;                   // Display label "Account Balance"
   CLabel            Balance_value;                   // Display Account balance
   CLabel            Equity_label;                    // Display label "Account Equity"
   CLabel            Equity_value;                    // Display Account Equity
   CLabel            PIPs;                            // Display label "Pips"
   CLabel            Currency;                        // Display Account currency
   CLabel            ShowLevels;                      // Display label "Show"
   CLabel            StopLoss;                        // Display label "Stop Loss"
   CLabel            TakeProfit;                      // Display label "TakeProfit"
   CLabel            Risk;                            // Display label "Risk"
   CLabel            Equity;                          // Display label "% to Equity"
   CLabel            Currency2;                       // Display Account currency
   CLabel            Orders;                          // Display label "Opened Orders"
   CLabel            Buy_Lots_label;                  // Display label "Buy Lots"
   CLabel            Buy_Lots_value;                  // Display Buy Lots value 
   CLabel            Sell_Lots_label;                 // Display label "Sell Lots"
   CLabel            Sell_Lots_value;                 // Display Sell Lots value 
   CLabel            Buy_profit_label;                // Display label "Buy Profit"
   CLabel            Buy_profit_value;                // Display Buy Profit value 
   CLabel            Sell_profit_label;               // Display label "Sell Profit"
   CLabel            Sell_profit_value;               // Display Sell profit value 
   CEdit_new         Lots;                            // Display volume of next order
   CEdit_new         StopLoss_pips;                   // Display Stop loss in pips
   CEdit_new         StopLoss_money;                  // Display Stop loss in accaunt currency
   CEdit_new         TakeProfit_pips;                 // Display Take profit in pips
   CEdit_new         TakeProfit_money;                // Display Take profit in account currency
   CEdit_new         Risk_percent;                    // Display Risk percent to equity
   CEdit_new         Risk_money;                      // Display Risk in account currency
   CBmpButton_new    StopLoss_line;                   // Check to display StopLoss Line
   CBmpButton_new    TakeProfit_line;                 // Check to display TakeProfit Line
   CBmpButton_new    StopLoss_pips_b;                 // Select Stop loss in pips
   CBmpButton_new    StopLoss_money_b;                // Select Stop loss in accaunt currency
   CBmpButton_new    TakeProfit_pips_b;               // Select Take profit in pips
   CBmpButton_new    TakeProfit_money_b;              // Select Take profit in account currency
   CBmpButton_new    Risk_percent_b;                  // Select Risk percent to equity
   CBmpButton_new    Risk_money_b;                    // Select Risk in account currency
   CBmpButton        Increase,Decrease;               // Increase and Decrease buttons
   CButton           SELL,BUY;                        // Sell and Buy Buttons
   CButton           CloseSell,CloseBuy,CloseAll;     // Close buttons
   CChartObjectHLine BuySL, SellSL, BuyTP, SellTP;    // Stop Loss and Take Profit Lines
   //---
   CAccountInfo      AccountInfo;                     // Class to get account info
   CTrade            Trade;                           // Class of trade operations
   
   //--- variables of current values
   double            cur_lot;                         // Lot of next order
   int               cur_sl_pips;                     // Stop Loss in pips
   double            cur_sl_money;                    // Stop Loss in money
   int               cur_tp_pips;                     // Take Profit in pips
   double            cur_tp_money;                    // Take Profit in money
   double            cur_risk_percent;                // Risk in percent
   double            cur_risk_money;                  // Risk in money
   bool              RiskByValue;                     // Flag: Risk by Value or Value by Risk
   //--- Create Label object
   bool              CreateLabel(const long chart,const int subwindow,CLabel &object,const string text,const uint x,const uint y,label_align align);
   //--- Create Button
   bool              CreateButton(const long chart,const int subwindow,CButton &object,const string text,const uint x,const uint y,const uint x_size,const uint y_size);
   //--- Cleate Edit object
   bool              CreateEdit(const long chart,const int subwindow,CEdit &object,const string text,const uint x,const uint y,const uint x_size,const uint y_size);
   //--- Create BMP Button
   bool              CreateBmpButton(const long chart,const int subwindow,CBmpButton &object,const uint x,const uint y,string BmpON,string BmpOFF,bool lock);
   //--- Create Horizontal line
   bool              CreateHLine(long chart, int subwindow,CChartObjectHLine &object,color clr, string comment);
   //--- On Event functions
   void              LotsEndEdit(void);                              // Edit Lot size
   void              SLPipsEndEdit();                                // Edit Stop Loss in pips
   void              TPPipsEndEdit();                                // Edit Take Profit in pips
   void              SLMoneyEndEdit();                               // Edit Stop Loss in money
   void              TPMoneyEndEdit();                               // Edit Take Profit in money
   void              RiskPercentEndEdit();                           // Edit Risk in percent
   void              RiskMoneyEndEdit();                             // Edit Risk in money
   void              SLPipsClick();                                  // Click Stop Loss in pips
   void              TPPipsClick();                                  // Click Take Profit in pips
   void              SLMoneyClick();                                 // Click Stop Loss in money
   void              TPMoneyClick();                                 // Click Take Profit in money
   void              RiskPercentClick();                             // Click Risk in percent
   void              RiskMoneyClick();                               // Click Risk in money
   void              IncreaseLotClick();                             // Click Increase Lot
   void              DecreaseLotClick();                             // Click Decrease Lot
   void              StopLossLineClick();                            // Click StopLoss Line 
   void              TakeProfitLineClick();                          // Click TakeProfit Line
   void              BuyClick();                                     // Click BUY button
   void              SellClick();                                    // Click SELL button
   void              CloseBuyClick();                                // Click CLOSE BUY button
   void              CloseSellClick();                               // Click CLOSE SELL button
   void              CloseClick();                                   // Click CLOSE ALL button
   
   //--- Correction value functions
   double            NormalizeLots(double lots);                     // Normalize lot's size
   void              StopLossPipsByMoney(void);                      // Correct Stop Loss pips value by money risk
   void              TakeProfitPipsByMoney(void);                    // Correct Take Profit pips value by money profit
   void              StopLossMoneyByPips(void);                      // Correct Stop Loss money risk by pips value
   void              TakeProfitMoneyByPips(void);                    // Correct Take Profit money profit by pips value
   void              UpdateSLLines(void);                            // Calculate SL prices and modify lines
   void              UpdateTPLines(void);                            // Calculate TP prices and modify lines
   
public:
                     CTradePanel(void);
                    ~CTradePanel(void){};
  //--- Create function
   virtual bool      Create(const long chart,const string name,const int subwin=0,const int x1=20,const int y1=20,const int x2=320,const int y2=420);
   virtual void      OnTick(void);
   virtual bool      OnEvent(const int id,const long &lparam, const double &dparam, const string &sparam);
   virtual bool      Run(void);
   virtual bool      DragLine(string name);
   virtual void      Destroy(const int reason);

  };

CTradePanel TradePanel;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   // Creat Trade Panel
   if(!TradePanel.Create(ChartID(),"Trade Panel"))
     {
      return (INIT_FAILED);
     }
   // Run Trade Panel
   TradePanel.Run();
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   TradePanel.Destroy(reason);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   TradePanel.OnTick();
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   if(id==CHARTEVENT_OBJECT_DRAG)
     {
      if(TradePanel.DragLine(sparam))
        {
         ChartRedraw();
        }
     }
   if(TradePanel.OnEvent(id, lparam, dparam, sparam))
      ChartRedraw();
  }
//+------------------------------------------------------------------+
//| Class initialization function                                    |
//+------------------------------------------------------------------+
CTradePanel::CTradePanel(void)
  {
   Trade.SetExpertMagicNumber(0);
   Trade.SetDeviationInPoints(5);
   int fill=(int)SymbolInfoInteger(_Symbol,SYMBOL_FILLING_MODE);
   Trade.SetTypeFilling((ENUM_ORDER_TYPE_FILLING)(fill==0 ? 2 : fill-1));
   return;
  }
//+------------------------------------------------------------------+
//| Creat Trade Panel function                                       |
//+------------------------------------------------------------------+
bool CTradePanel::Create(const long chart,const string name,const int subwin=0,const int x1=20,const int y1=20,const int x2=320,const int y2=420)
  {
      // At first call creat function of parents class
   if(!CAppDialog::Create(chart,name,subwin,x1,y1,x2,y2))
     {
      return false;
     }
   // Calculate coofrdinates and size of BID object
   // Coordinates calculate in dialog box, not in chart
   int l_x_left=BORDER;
   int l_y=BORDER;
   int y_width=Y_WIDTH;
   int y_sptep=Y_STEP;
   // Creat object
   if(!CreateLabel(chart,subwin,BID,DoubleToString(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits),l_x_left,l_y,left))
     {
      return false;
     }
   // Adjust font size for object
   if(!BID.FontSize(Y_WIDTH))
     {
      return false;
     }
   // Repeat same functions for other objects
   int l_x_right=ClientAreaWidth()-20;
   if(!CreateLabel(chart,subwin,ASK,DoubleToString(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits),l_x_right,l_y,right))
     {
      return false;
     }
   if(!ASK.FontSize(Y_WIDTH))
     {
      return false;
     }
   l_y+=2*Y_WIDTH;
   int x_size=(int)((ClientAreaWidth()-40)/3-5);
   if(!CreateButton(chart,subwin,SELL,"SELL",BORDER,l_y,x_size,Y_WIDTH))
     {
      return false;
     }
   if(!CreateButton(chart,subwin,BUY,"BUY",(l_x_right-x_size),l_y,x_size,Y_WIDTH))
     {
      return false;
     }
   l_x_left=(int)((ClientAreaWidth()-x_size)/2);
   cur_lot=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN);
   if(!CreateEdit(chart,subwin,Lots,DoubleToString(cur_lot,2),l_x_left,l_y,(int)(x_size-CONTROLS_BUTTON_SIZE),Y_WIDTH))
     {
      return false;
     }
   l_x_left+=x_size;
   if(!CreateBmpButton(chart,subwin,Increase,l_x_left,(int)(l_y-Y_WIDTH/4),"::Include\\Controls\\res\\SpinInc.bmp","::Include\\Controls\\res\\SpinInc.bmp",false))
     {
      return false;
     }
   if(!CreateBmpButton(chart,subwin,Decrease,l_x_left,(int)(l_y+Y_WIDTH/4),"::Include\\Controls\\res\\SpinDec.bmp","::Include\\Controls\\res\\SpinDec.bmp",false))
     {
      return false;
     }
   Increase.PropFlags(WND_PROP_FLAG_CLICKS_BY_PRESS);
   Decrease.PropFlags(WND_PROP_FLAG_CLICKS_BY_PRESS);
   l_y+=Y_WIDTH+Y_STEP;
   if(!CreateButton(chart,subwin,CloseSell,"CLOSE SELL",BORDER,l_y,x_size,Y_WIDTH))
     {
      return false;
     }
   if(!CreateButton(chart,subwin,CloseAll,"CLOSE ALL",(int)((ClientAreaWidth()-x_size)/2),l_y,x_size,Y_WIDTH))
     {
      return false;
     }
   CloseAll.ColorBackground(clrRed);
   if(!CreateButton(chart,subwin,CloseBuy,"CLOSE BUY",(l_x_right-x_size),l_y,x_size,Y_WIDTH))
     {
      return false;
     }
   l_y+=Y_WIDTH+Y_STEP;
   l_x_left=(int)(ClientAreaWidth()/2);
   if(!CreateLabel(chart,subwin,PIPs,"Pips",l_x_left,l_y,right))
     {
      return false;
     }
   if(!CreateLabel(chart,subwin,Currency,AccountInfoString(ACCOUNT_CURRENCY),(int)(l_x_left+x_size),l_y,right))
     {
      return false;
     }
   if(!CreateLabel(chart,subwin,ShowLevels,"Show",(int)(l_x_right-CONTROLS_BUTTON_SIZE/2),l_y,center))
     {
      return false;
     }
   l_y+=(int)(Y_WIDTH/2+Y_STEP);
   if(!CreateLabel(chart,subwin,StopLoss,"Stop Loss",BORDER,l_y,left))
     {
      return false;
     }
   l_x_left=(int)((ClientAreaWidth()-x_size)/2);
   if(!CreateBmpButton(chart,subwin,StopLoss_pips_b,l_x_left,l_y,"::Include\\Controls\\res\\RadioButtonOn.bmp","::Include\\Controls\\res\\RadioButtonOff.bmp",true))
     {
      return false;
     }
   if(!CreateEdit(chart,subwin,StopLoss_pips," ",l_x_left,l_y,(int)(x_size*0.75),Y_WIDTH))
     {
      return false;
     }
   cur_sl_pips=0;
   l_x_left+=x_size;
   if(!CreateBmpButton(chart,subwin,StopLoss_money_b,l_x_left,l_y,"::Include\\Controls\\res\\RadioButtonOn.bmp","::Include\\Controls\\res\\RadioButtonOff.bmp",true))
     {
      return false;
     }
   if(!CreateEdit(chart,subwin,StopLoss_money," ",l_x_left,l_y,(int)(x_size*0.75),Y_WIDTH))
     {
      return false;
     }
   cur_sl_money=0;
   if(!CreateBmpButton(chart,subwin,StopLoss_line,l_x_right,l_y,"::Include\\Controls\\res\\CheckBoxOn.bmp","::Include\\Controls\\res\\CheckBoxOff.bmp",true))
     {
      return false;
     }
   l_y+=Y_WIDTH+Y_STEP;
   if(!CreateLabel(chart,subwin,TakeProfit,"TakeProfit",BORDER,l_y,left))
     {
      return false;
     }
   l_x_left=(int)((ClientAreaWidth()-x_size)/2);
   if(!CreateBmpButton(chart,subwin,TakeProfit_pips_b,l_x_left,l_y,"::Include\\Controls\\res\\RadioButtonOn.bmp","::Include\\Controls\\res\\RadioButtonOff.bmp",true))
     {
      return false;
     }
   if(!CreateEdit(chart,subwin,TakeProfit_pips," ",l_x_left,l_y,(int)(x_size*0.75),Y_WIDTH))
     {
      return false;
     }
   cur_tp_pips=0;
   l_x_left+=x_size;
   if(!CreateBmpButton(chart,subwin,TakeProfit_money_b,l_x_left,l_y,"::Include\\Controls\\res\\RadioButtonOn.bmp","::Include\\Controls\\res\\RadioButtonOff.bmp",true))
     {
      return false;
     }
   if(!CreateEdit(chart,subwin,TakeProfit_money," ",l_x_left,l_y,(int)(x_size*0.75),Y_WIDTH))
     {
      return false;
     }
   cur_tp_money=0;
   if(!CreateBmpButton(chart,subwin,TakeProfit_line,l_x_right,l_y,"::Include\\Controls\\res\\CheckBoxOn.bmp","::Include\\Controls\\res\\CheckBoxOff.bmp",true))
     {
      return false;
     }
   l_y+=Y_WIDTH+Y_STEP;
   l_x_left=(int)(ClientAreaWidth()/2);
   if(!CreateLabel(chart,subwin,Equity,"% to Equity",(int)(l_x_left-CONTROLS_BUTTON_SIZE/2),l_y,center))
     {
      return false;
     }
   if(!CreateLabel(chart,subwin,Currency2,AccountInfoString(ACCOUNT_CURRENCY),(int)(l_x_right-x_size/2),l_y,center))
     {
      return false;
     }
   l_y+=(int)(Y_WIDTH/2+Y_STEP);
   if(!CreateLabel(chart,subwin,Risk,"Risk",BORDER,l_y,left))
     {
      return false;
     }
   l_x_left=(int)((ClientAreaWidth()-x_size)/2);
   if(!CreateBmpButton(chart,subwin,Risk_percent_b,l_x_left,l_y,"::Include\\Controls\\res\\RadioButtonOn.bmp","::Include\\Controls\\res\\RadioButtonOff.bmp",true))
     {
      return false;
     }
   if(!CreateEdit(chart,subwin,Risk_percent," ",l_x_left,l_y,(int)(x_size*0.9),Y_WIDTH))
     {
      return false;
     }
   cur_risk_percent=0;
   if(!CreateBmpButton(chart,subwin,Risk_money_b,(int)(l_x_right-x_size*0.9),l_y,"::Include\\Controls\\res\\RadioButtonOn.bmp","::Include\\Controls\\res\\RadioButtonOff.bmp",true))
     {
      return false;
     }
   if(!CreateEdit(chart,subwin,Risk_money," ",(int)(l_x_right-x_size*0.9),l_y,(int)(x_size*0.9),Y_WIDTH))
     {
      return false;
     }
   cur_risk_money=0;
   l_y+=Y_WIDTH+Y_STEP;
   if(!CreateLabel(chart,subwin,Balance_label,"Account balance",BORDER,l_y,left))
     {
      return false;
     }
   if(!CreateLabel(chart,subwin,Balance_value,DoubleToString(AccountInfoDouble(ACCOUNT_BALANCE),2)+" "+AccountInfoString(ACCOUNT_CURRENCY),l_x_right,l_y,right))
     {
      return false;
     }
   l_y+=(int)(Y_WIDTH*0.7+Y_STEP);
   if(!CreateLabel(chart,subwin,Equity_label,"Account Equity",BORDER,l_y,left))
     {
      return false;
     }
   if(!CreateLabel(chart,subwin,Equity_value,DoubleToString(AccountInfoDouble(ACCOUNT_EQUITY),2)+" "+AccountInfoString(ACCOUNT_CURRENCY),l_x_right,l_y,right))
     {
      return false;
     }
   l_y+=(int)(Y_WIDTH*0.7+2*Y_STEP);
   if(!CreateLabel(chart,subwin,Orders,"Opened Orders",BORDER,l_y,left))
     {
      return false;
     }
   l_x_left=(int)(BORDER+x_size/2);
   l_y+=(int)(Y_WIDTH*0.7+Y_STEP);
   if(!CreateLabel(chart,subwin,Buy_Lots_label,"Buy Lots",l_x_left,l_y,left))
     {
      return false;
     }
   if(!CreateLabel(chart,subwin,Buy_Lots_value,DoubleToString(0,2),l_x_right-28,l_y,right))
     {
      return false;
     } 
   l_y+=(int)(Y_WIDTH*0.7+Y_STEP);
   if(!CreateLabel(chart,subwin,Sell_Lots_label,"Sell Lots",l_x_left,l_y,left))
     {
      return false;
     }
   if(!CreateLabel(chart,subwin,Sell_Lots_value,DoubleToString(0,2),l_x_right-28,l_y,right))
     {
      return false;
     } 
   l_y+=(int)(Y_WIDTH*0.7+Y_STEP);
   if(!CreateLabel(chart,subwin,Buy_profit_label,"Buy Profit",l_x_left,l_y,left))
     {
      return false;
     }
   if(!CreateLabel(chart,subwin,Buy_profit_value,DoubleToString(0,2)+" "+AccountInfoString(ACCOUNT_CURRENCY),l_x_right,l_y,right))
     {
      return false;
     }
   l_y+=(int)(Y_WIDTH*0.7+Y_STEP);
   if(!CreateLabel(chart,subwin,Sell_profit_label,"Sell Profit",l_x_left,l_y,left))
     {
      return false;
     }
   if(!CreateLabel(chart,subwin,Sell_profit_value,DoubleToString(0,2)+" "+AccountInfoString(ACCOUNT_CURRENCY),l_x_right,l_y,right))
     {
      return false;
     } 
   //--- Create horizontal lines of SL & TP
   if(!CreateHLine(chart,subwin,BuySL,SL_Line_color,"Buy Stop Loss"))
     {
      return false;
     }
   if(!CreateHLine(chart,subwin,SellSL,SL_Line_color,"Sell Stop Loss"))
     {
      return false;
     }
   if(!CreateHLine(chart,subwin,BuyTP,TP_Line_color,"Buy Take Profit"))
     {
      return false;
     }
   if(!CreateHLine(chart,subwin,SellTP,TP_Line_color,"Sell Take Profit"))
     {
      return false;
     }
    return true;
  }
//+------------------------------------------------------------------+
//| Create Label Object                                              |
//+------------------------------------------------------------------+
bool CTradePanel::CreateLabel(const long chart,const int subwindow,CLabel &object,const string text,const uint x,const uint y,label_align align)
  {
   // All objects mast to have separate name
   string name=m_name+"Label"+(string)ObjectsTotal(chart,-1,OBJ_LABEL);
   //--- Call Create function
   if(!object.Create(chart,name,subwindow,x,y,0,0))
     {
      return false;
     }
   //--- Addjust text
   if(!object.Text(text))
     {
      return false;
     }
   //--- Aling text to Dialog box's grid
   ObjectSetInteger(chart,object.Name(),OBJPROP_ANCHOR,(align==left ? ANCHOR_LEFT_UPPER : (align==right ? ANCHOR_RIGHT_UPPER : ANCHOR_UPPER)));
   //--- Add object to controls
   if(!Add(object))
     {
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Create Button                                                    |
//+------------------------------------------------------------------+
bool CTradePanel::CreateButton(const long chart,const int subwindow,CButton &object,const string text,const uint x,const uint y,const uint x_size,const uint y_size)
  {
   // All objects must to have separate name
   string name=m_name+"Button"+(string)ObjectsTotal(chart,-1,OBJ_BUTTON);
   //--- Call Create function
   if(!object.Create(chart,name,subwindow,x,y,x+x_size,y+y_size))
     {
      return false;
     }
   //--- Addjust text
   if(!object.Text(text))
     {
      return false;
     }
   //--- set button flag to unlock
   object.Locking(false);
   //--- set button flag to unpressed
   if(!object.Pressed(false))
     {
      return false;
     }
   //--- Add object to controls
   if(!Add(object))
     {
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Create Edit  Object                                              |
//+------------------------------------------------------------------+
bool CTradePanel::CreateEdit(const long chart,const int subwindow,CEdit &object,const string text,const uint x,const uint y,const uint x_size,const uint y_size)
  {
   // All objects must to have separate name
   string name=m_name+"Edit"+(string)ObjectsTotal(chart,-1,OBJ_EDIT);
   //--- Call Create function
   if(!object.Create(chart,name,subwindow,x,y,x+x_size,y+y_size))
     {
      return false;
     }
   //--- Addjust text
   if(!object.Text(text))
     {
      return false;
     }
   //--- Align text in Edit box
   if(!object.TextAlign(ALIGN_CENTER))
     {
      return false;
     }
   //--- set Read only flag to false
   if(!object.ReadOnly(false))
     {
      return false;
     }
   //--- Add object to controls
   if(!Add(object))
     {
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Create BMP Button                                                |
//+------------------------------------------------------------------+
bool CTradePanel::CreateBmpButton(const long chart,const int subwindow,CBmpButton &object,const uint x,const uint y,string BmpON,string BmpOFF,bool lock)
  {
   // All objects must to have separate name
   string name=m_name+"BmpButton"+(string)ObjectsTotal(chart,-1,OBJ_BITMAP_LABEL);
   //--- Calculate coordinates
   uint y1=(uint)(y-(Y_STEP-CONTROLS_BUTTON_SIZE)/2);
   uint y2=y1+CONTROLS_BUTTON_SIZE;
   //--- Call Create function
   if(!object.Create(m_chart_id,name,m_subwin,x-CONTROLS_BUTTON_SIZE,y1,x,y2))
      return(false);
   //--- Assign BMP pictuers to button status
   if(!object.BmpNames(BmpOFF,BmpON))
      return(false);
   //--- Add object to controls
   if(!Add(object))
      return(false);
   //--- set Lock flag to true
   object.Locking(lock);
//--- succeeded
   return(true);
  }
//+------------------------------------------------------------------+
//| Event "New Tick                                                  |
//+------------------------------------------------------------------+
void CTradePanel::OnTick(void)
  { 
   //--- Change Ask and Bid prices on panel
   ASK.Text(DoubleToString(SymbolInfoDouble(_Symbol,SYMBOL_ASK),(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS)));
   BID.Text(DoubleToString(SymbolInfoDouble(_Symbol,SYMBOL_BID),(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS)));
   //--- Check and change (if necessary) equity
   if(Equity_value.Text()!=DoubleToString(AccountInfoDouble(ACCOUNT_EQUITY),2)+" "+AccountInfoString(ACCOUNT_CURRENCY))
     {
      Equity_value.Text(DoubleToString(AccountInfoDouble(ACCOUNT_EQUITY),2)+" "+AccountInfoString(ACCOUNT_CURRENCY));
     }
   //--- Check and change (if necessary) balance
   if(Balance_value.Text()!=DoubleToString(AccountInfoDouble(ACCOUNT_BALANCE),2)+" "+AccountInfoString(ACCOUNT_CURRENCY))
     {
      Balance_value.Text(DoubleToString(AccountInfoDouble(ACCOUNT_BALANCE),2)+" "+AccountInfoString(ACCOUNT_CURRENCY));
     }
   //--- Check and change (if necessary) Buy and Sell lots and profit value.
   if(PositionSelect(_Symbol))
     {
      switch((ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE))
        {
         case POSITION_TYPE_BUY:
           Buy_profit_value.Text(DoubleToString(PositionGetDouble(POSITION_PROFIT),2)+" "+AccountInfoString(ACCOUNT_CURRENCY));
           if(Buy_Lots_value.Text()!=DoubleToString(PositionGetDouble(POSITION_VOLUME),2))
              {
               Buy_Lots_value.Text(DoubleToString(PositionGetDouble(POSITION_VOLUME),2));
              }
           if(Sell_profit_value.Text()!=DoubleToString(0,2)+" "+AccountInfoString(ACCOUNT_CURRENCY))
              {
               Sell_profit_value.Text(DoubleToString(0,2)+" "+AccountInfoString(ACCOUNT_CURRENCY));
              }
           if(Sell_Lots_value.Text()!=DoubleToString(0,2))
              {
               Sell_Lots_value.Text(DoubleToString(0,2));
              }
           break;
         case POSITION_TYPE_SELL:
           Sell_profit_value.Text(DoubleToString(PositionGetDouble(POSITION_PROFIT),2)+" "+AccountInfoString(ACCOUNT_CURRENCY));
           if(Sell_Lots_value.Text()!=DoubleToString(PositionGetDouble(POSITION_VOLUME),2))
              {
               Sell_Lots_value.Text(DoubleToString(PositionGetDouble(POSITION_VOLUME),2));
              }
           if(Buy_profit_value.Text()!=DoubleToString(0,2)+" "+AccountInfoString(ACCOUNT_CURRENCY))
              {
               Buy_profit_value.Text(DoubleToString(0,2)+" "+AccountInfoString(ACCOUNT_CURRENCY));
              }
           if(Buy_Lots_value.Text()!=DoubleToString(0,2))
              {
               Buy_Lots_value.Text(DoubleToString(0,2));
              }
           break;
        }
     }
   else
     {
      if(Buy_Lots_value.Text()!=DoubleToString(0,2))
        {
         Buy_Lots_value.Text(DoubleToString(0,2));
        }
      if(Sell_Lots_value.Text()!=DoubleToString(0,2))
        {
         Sell_Lots_value.Text(DoubleToString(0,2));
        }
      if(Buy_profit_value.Text()!=DoubleToString(0,2)+" "+AccountInfoString(ACCOUNT_CURRENCY))
        {
         Buy_profit_value.Text(DoubleToString(0,2)+" "+AccountInfoString(ACCOUNT_CURRENCY));
        }
      if(Sell_profit_value.Text()!=DoubleToString(0,2)+" "+AccountInfoString(ACCOUNT_CURRENCY))
        {
         Sell_profit_value.Text(DoubleToString(0,2)+" "+AccountInfoString(ACCOUNT_CURRENCY));
        }
     }
   //--- Move SL and TP lines if necessary
   if(StopLoss_line.Pressed())
     {
      UpdateSLLines();
     }
   if(TakeProfit_line.Pressed())
     {
      UpdateTPLines();
     }
   ChartRedraw();
   return;
  }
//+------------------------------------------------------------------+
//| Event Handling                                                   |
//+------------------------------------------------------------------+
EVENT_MAP_BEGIN(CTradePanel)
   ON_EVENT(ON_END_EDIT,Lots,LotsEndEdit)
   ON_EVENT(ON_END_EDIT,StopLoss_pips,SLPipsEndEdit)
   ON_EVENT(ON_END_EDIT,TakeProfit_pips,TPPipsEndEdit)
   ON_EVENT(ON_END_EDIT,StopLoss_money,SLMoneyEndEdit)
   ON_EVENT(ON_END_EDIT,TakeProfit_money,TPMoneyEndEdit)
   ON_EVENT(ON_END_EDIT,Risk_percent,RiskPercentEndEdit)
   ON_EVENT(ON_END_EDIT,Risk_money,RiskMoneyEndEdit)
   ON_EVENT(ON_CLICK,StopLoss_pips_b,SLPipsClick)
   ON_EVENT(ON_CLICK,TakeProfit_pips_b,TPPipsClick)
   ON_EVENT(ON_CLICK,StopLoss_money_b,SLMoneyClick)
   ON_EVENT(ON_CLICK,TakeProfit_money_b,TPMoneyClick)
   ON_EVENT(ON_CLICK,Risk_percent_b,RiskPercentClick)
   ON_EVENT(ON_CLICK,Risk_money_b,RiskMoneyClick)
   ON_EVENT(ON_CLICK,Increase,IncreaseLotClick)
   ON_EVENT(ON_CLICK,Decrease,DecreaseLotClick)
   ON_EVENT(ON_CLICK,StopLoss_line,StopLossLineClick)
   ON_EVENT(ON_CLICK,TakeProfit_line,TakeProfitLineClick)
   ON_EVENT(ON_CLICK,BUY,BuyClick)
   ON_EVENT(ON_CLICK,SELL,SellClick)
   ON_EVENT(ON_CLICK,CloseBuy,CloseBuyClick)
   ON_EVENT(ON_CLICK,CloseSell,CloseSellClick)
   ON_EVENT(ON_CLICK,CloseAll,CloseClick)
EVENT_MAP_END(CAppDialog)
//+------------------------------------------------------------------+
//| Read lots value after edit                                       |
//+------------------------------------------------------------------+
void CTradePanel::LotsEndEdit(void)
  {
   //--- Read and normalize lot value
   cur_lot=NormalizeLots(StringToDouble(Lots.Text()));
   //--- Output lot value to panel
   Lots.Text(DoubleToString(cur_lot,2));
   //--- Check and modify value of other labels 
   if(StopLoss_money_b.Pressed())
     {
      StopLossPipsByMoney();
     }
   if(TakeProfit_money_b.Pressed())
     {
      TakeProfitPipsByMoney();
     }
   if(StopLoss_pips_b.Pressed())
     {
      StopLossMoneyByPips();
     }
   if(TakeProfit_pips_b.Pressed())
     {
      TakeProfitMoneyByPips();
     }
   RiskByValue=true;
   ChartRedraw();
   return;
  }
//+------------------------------------------------------------------+
//|  Normalization of order volume                                   |
//+------------------------------------------------------------------+
double CTradePanel::NormalizeLots(double lots)
  {
   double result=0;
   double minLot=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN);
   double maxLot=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MAX);
   double stepLot=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);
   if (lots>0)
      {
      lots=MathMax(minLot,lots);
      lots=minLot+NormalizeDouble((lots-minLot)/stepLot,0)*stepLot;
      result=MathMin(maxLot,lots);
      }
   else
      result=minLot;   
   double Buy_FreeMargin=AccountInfo.FreeMarginCheck(_Symbol,ORDER_TYPE_BUY,result,SymbolInfoDouble(_Symbol,SYMBOL_ASK));
   double Sell_FreeMargin=AccountInfo.FreeMarginCheck(_Symbol,ORDER_TYPE_SELL,result,SymbolInfoDouble(_Symbol,SYMBOL_BID));
   if(Buy_FreeMargin<0 || Sell_FreeMargin<0)
     {
      if(result>minLot)
        {
         result=result*AccountInfo.FreeMargin()/(AccountInfo.FreeMargin()-MathMin(Buy_FreeMargin,Sell_FreeMargin));
         result=NormalizeLots(result);
        }
      else
        {
         result=0;
        }
     }
   return (NormalizeDouble(result,2));
  }
//+------------------------------------------------------------------+
//|  Modify SL pips by Order lot and SL money                        |
//+------------------------------------------------------------------+
void CTradePanel::StopLossPipsByMoney(void)
  {
   //--- Read and normalize lot value
   cur_lot=NormalizeLots(StringToDouble(Lots.Text()));
   //--- Output lot value to panel
   Lots.Text(DoubleToString(cur_lot,2));
   double tick_value=SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_VALUE);
   double tick_size=SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_SIZE);
   cur_sl_pips=(int)MathFloor(cur_sl_money/(tick_value*cur_lot)*(tick_size/_Point));
   StopLoss_pips.Text(IntegerToString(cur_sl_pips));
   if(StopLoss_line.Pressed())
     {
      UpdateSLLines();
     }
   return;
  }
//+------------------------------------------------------------------+
//|  Modify TP pips by Order lot and TP money                        |
//+------------------------------------------------------------------+
void CTradePanel::TakeProfitPipsByMoney(void)
  {
   //--- Read and normalize lot value
   cur_lot=NormalizeLots(StringToDouble(Lots.Text()));
   //--- Output lot value to panel
   Lots.Text(DoubleToString(cur_lot,2));
   double tick_value=SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_VALUE);
   double tick_size=SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_SIZE);
   cur_tp_pips=(int)MathFloor(cur_tp_money/(tick_value*cur_lot)*(tick_size/_Point));
   TakeProfit_pips.Text(IntegerToString(cur_tp_pips));
   if(TakeProfit_line.Pressed())
     {
      UpdateTPLines();
     }
   return;
  }
//+------------------------------------------------------------------+
//|  Modify SL money by Order lot and SL pips                        |
//+------------------------------------------------------------------+
void CTradePanel::StopLossMoneyByPips(void)
  {
   //--- Read and normalize lot value
   double tick_value=SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_VALUE);
   double tick_size=SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_SIZE);
   if(!RiskByValue)
     {
      cur_sl_money=StringToDouble(StopLoss_money.Text());
      cur_lot=NormalizeLots(cur_sl_money/(tick_value*(tick_size/_Point)*cur_sl_pips));
     }
   else
     {
      cur_lot=NormalizeLots(StringToDouble(Lots.Text()));
     }
   //--- Output lot value to panel
   Lots.Text(DoubleToString(cur_lot,2));
   cur_sl_money=NormalizeDouble(tick_value*cur_lot*(tick_size/_Point)*cur_sl_pips,2);
   StopLoss_money.Text(DoubleToString(cur_sl_money,2));
   cur_risk_money=cur_sl_money;
   Risk_money.Text(DoubleToString(cur_risk_money,2));
   cur_risk_percent=NormalizeDouble(cur_risk_money/AccountInfoDouble(ACCOUNT_EQUITY)*100,2);
   Risk_percent.Text(DoubleToString(cur_risk_percent,2));
   if(TakeProfit_money_b.Pressed())
     {
      TakeProfitPipsByMoney();
     }
   else
     {
      TakeProfitMoneyByPips();
     }
   return;
  }
//+------------------------------------------------------------------+
//|  Modify TP money by Order lot and TP pips                        |
//+------------------------------------------------------------------+
void CTradePanel::TakeProfitMoneyByPips(void)
  {
   //--- Read and normalize lot value
   cur_lot=NormalizeLots(StringToDouble(Lots.Text()));
   //--- Output lot value to panel
   Lots.Text(DoubleToString(cur_lot,2));
   double tick_value=SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_VALUE);
   double tick_size=SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_SIZE);
   cur_tp_money=NormalizeDouble(tick_value*cur_lot*(tick_size/_Point)*cur_tp_pips,2);
   TakeProfit_money.Text(DoubleToString(cur_tp_money,2));
   return;
  }
//+------------------------------------------------------------------+
//| Update Stop Loss Lines                                           |
//+------------------------------------------------------------------+
void CTradePanel::UpdateSLLines(void)
  {
   if(cur_sl_pips<=0)
     {
      return;
     }
   double price=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK)-cur_sl_pips*_Point,(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS));
   BuySL.Price(0,price);
   price=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID)+cur_sl_pips*_Point,(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS));
   SellSL.Price(0,price);
   return;
  }
//+------------------------------------------------------------------+
//| Update Take Profit Lines                                         |
//+------------------------------------------------------------------+
void CTradePanel::UpdateTPLines(void)
  {
   if(cur_tp_pips<=0)
     {
      return;
     }
   double price=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK)+cur_tp_pips*_Point,(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS));
   BuyTP.Price(0,price);
   price=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID)-cur_tp_pips*_Point,(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS));
   SellTP.Price(0,price);
   return;
  }
//+------------------------------------------------------------------+
//| StopLoss in pips end edit                                        |
//+------------------------------------------------------------------+
void CTradePanel::SLPipsEndEdit(void)
  {
   cur_sl_pips=(int)StringToInteger(StopLoss_pips.Text());
   if(cur_sl_pips<=0)
     {
      cur_sl_pips=0;
     }
   else
     {
      cur_sl_pips=(int)fmax(cur_sl_pips,SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)+SymbolInfoInteger(_Symbol,SYMBOL_SPREAD));
     }
   StopLoss_pips.Text(IntegerToString(cur_sl_pips));
   SLPipsClick();
   StopLossMoneyByPips();
   UpdateSLLines();
   ChartRedraw();
   return;
  }
//+------------------------------------------------------------------+
//| Take Profit in pips end edit                                     |
//+------------------------------------------------------------------+
void CTradePanel::TPPipsEndEdit(void)
  {
   cur_tp_pips=(int)StringToInteger(TakeProfit_pips.Text());
   if(cur_tp_pips<=0)
     {
      cur_tp_pips=0;
     }
   else
     {
      cur_tp_pips=(int)fmax(cur_tp_pips,SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)-SymbolInfoInteger(_Symbol,SYMBOL_SPREAD));
     }
   TakeProfit_pips.Text(IntegerToString(cur_tp_pips));
   TPPipsClick();
   TakeProfitMoneyByPips();
   UpdateTPLines();
   ChartRedraw();
   return;
  }
//+------------------------------------------------------------------+
//| StopLoss in money end edit                                       |
//+------------------------------------------------------------------+
void CTradePanel::SLMoneyEndEdit(void)
  {
   cur_sl_money=NormalizeDouble(StringToDouble(StopLoss_money.Text()),2);
   if(cur_sl_money<=0)
     {
      cur_sl_money=0;
     }
   else
     {
      cur_sl_money=(int)fmin(cur_sl_money,AccountInfoDouble(ACCOUNT_MARGIN_SO_SO)*
      (AccountInfoInteger(ACCOUNT_MARGIN_SO_MODE)==ACCOUNT_STOPOUT_MODE_PERCENT ? AccountInfoDouble(ACCOUNT_BALANCE)/100 : 1));
     }
   cur_risk_money=cur_sl_money;
   cur_risk_percent=NormalizeDouble(cur_risk_money/AccountInfoDouble(ACCOUNT_BALANCE)*100,2);
   Risk_percent.Text(DoubleToString(cur_risk_percent,2));
   StopLoss_money.Text(DoubleToString(cur_sl_money,2));
   Risk_money.Text(DoubleToString(cur_risk_money,2));
   SLMoneyClick();
   StopLossPipsByMoney();
   if(cur_sl_pips>0 && cur_sl_pips<(SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)+SymbolInfoInteger(_Symbol,SYMBOL_SPREAD)))
     {
      cur_sl_pips=(int)(SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)+SymbolInfoInteger(_Symbol,SYMBOL_SPREAD));
      StopLoss_pips.Text(IntegerToString(cur_sl_pips));
      StopLossMoneyByPips();
     }
   ChartRedraw();
   return;
  }
//+------------------------------------------------------------------+
//| TakeProfit in money end edit                                     |
//+------------------------------------------------------------------+
void CTradePanel::TPMoneyEndEdit(void)
  {
   cur_tp_money=NormalizeDouble(StringToDouble(TakeProfit_money.Text()),2);
   if(cur_tp_money<=0)
     {
      cur_tp_money=0;
     }
   TakeProfit_money.Text(DoubleToString(cur_tp_money,2));
   TPMoneyClick();
   TakeProfitPipsByMoney();
   if(cur_tp_pips>0 && cur_tp_pips<(SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)-SymbolInfoInteger(_Symbol,SYMBOL_SPREAD)))
     {
      cur_tp_pips=(int)(SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)-SymbolInfoInteger(_Symbol,SYMBOL_SPREAD));
      TakeProfit_pips.Text(IntegerToString(cur_tp_pips));
      TakeProfitMoneyByPips();
     }
   ChartRedraw();
   return;
  }
//+------------------------------------------------------------------+
//| Risk in money end edit                                           |
//+------------------------------------------------------------------+
void CTradePanel::RiskMoneyEndEdit(void)
  {
   cur_risk_money=NormalizeDouble(StringToDouble(Risk_money.Text()),2);
   if(cur_risk_money<=0)
     {
      cur_risk_money=0;
     }
   else
     {
      cur_risk_money=(int)fmin(cur_risk_money,AccountInfoDouble(ACCOUNT_MARGIN_SO_SO)*
      (AccountInfoInteger(ACCOUNT_MARGIN_SO_MODE)==ACCOUNT_STOPOUT_MODE_PERCENT ? AccountInfoDouble(ACCOUNT_BALANCE)/100 : 1));
     }
   cur_sl_money=cur_risk_money;
   cur_risk_percent=NormalizeDouble(cur_risk_money/AccountInfoDouble(ACCOUNT_EQUITY)*100,2);
   Risk_percent.Text(DoubleToString(cur_risk_percent,2));
   StopLoss_money.Text(DoubleToString(cur_sl_money,2));
   Risk_money.Text(DoubleToString(cur_risk_money,2));
   RiskMoneyClick();
   StopLossPipsByMoney();
   if(cur_sl_pips>0 && cur_sl_pips<(SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)+SymbolInfoInteger(_Symbol,SYMBOL_SPREAD)))
     {
      cur_sl_pips=(int)(SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)+SymbolInfoInteger(_Symbol,SYMBOL_SPREAD));
      StopLoss_pips.Text(IntegerToString(cur_sl_pips));
      StopLossMoneyByPips();
     }
   RiskByValue=false;
   ChartRedraw();
   return;
  }
//+------------------------------------------------------------------+
//| Risk in percent end edit                                           |
//+------------------------------------------------------------------+
void CTradePanel::RiskPercentEndEdit(void)
  {
   cur_risk_percent=NormalizeDouble(StringToDouble(Risk_percent.Text()),2);
   if(cur_risk_percent<=0)
     {
      cur_risk_percent=0;
     }
   else
     {
      cur_risk_percent=NormalizeDouble(fmin(cur_risk_percent,AccountInfoDouble(ACCOUNT_MARGIN_SO_SO)*
      (AccountInfoInteger(ACCOUNT_MARGIN_SO_MODE)==ACCOUNT_STOPOUT_MODE_PERCENT ? 1 : 100/AccountInfoDouble(ACCOUNT_BALANCE))),2);
     }
   cur_sl_money=cur_risk_money=NormalizeDouble(AccountInfoDouble(ACCOUNT_EQUITY)*cur_risk_percent/100,2);
   StopLoss_money.Text(DoubleToString(cur_sl_money,2));
   Risk_money.Text(DoubleToString(cur_risk_money,2));
   Risk_percent.Text(DoubleToString(cur_risk_percent,2));
   RiskPercentClick();
   StopLossPipsByMoney();
   if(cur_sl_pips>0 && cur_sl_pips<(SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)+SymbolInfoInteger(_Symbol,SYMBOL_SPREAD)))
     {
      cur_sl_pips=(int)(SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)+SymbolInfoInteger(_Symbol,SYMBOL_SPREAD));
      StopLoss_pips.Text(IntegerToString(cur_sl_pips));
      StopLossMoneyByPips();
     }
   RiskByValue=false;
   ChartRedraw();
   return;
  }
//+------------------------------------------------------------------+
//| Click Stop Loss in pips                                          |
//+------------------------------------------------------------------+
void CTradePanel::SLPipsClick(void)
  {
   StopLoss_pips_b.Pressed(cur_sl_pips>0);
   StopLoss_money_b.Pressed(false);
   Risk_money_b.Pressed(false);
   Risk_percent_b.Pressed(false);
   ChartRedraw();
   return;
  }
//+------------------------------------------------------------------+
//| Click Take Profit in pips                                        |
//+------------------------------------------------------------------+
void CTradePanel::TPPipsClick(void)
  {
   TakeProfit_pips_b.Pressed(cur_tp_pips>0);
   TakeProfit_money_b.Pressed(false);
   ChartRedraw();
   return;
  }
//+------------------------------------------------------------------+
//| Click Stop Loss in money                                         |
//+------------------------------------------------------------------+
void CTradePanel::SLMoneyClick(void)
  {
   StopLoss_pips_b.Pressed(false);
   StopLoss_money_b.Pressed(cur_sl_money>0);
   Risk_money_b.Pressed(cur_risk_money>0);
   Risk_percent_b.Pressed(false);
   ChartRedraw();
   return;
  }
//+------------------------------------------------------------------+
//| Click Take Profit in money                                       |
//+------------------------------------------------------------------+
void CTradePanel::TPMoneyClick(void)
  {
   TakeProfit_pips_b.Pressed(false);
   TakeProfit_money_b.Pressed(cur_tp_money>0);
   ChartRedraw();
   return;
  }
//+------------------------------------------------------------------+
//| Click Risk in money                                              |
//+------------------------------------------------------------------+
void CTradePanel::RiskMoneyClick(void)
  {
   StopLoss_pips_b.Pressed(false);
   StopLoss_money_b.Pressed(cur_sl_money>0);
   Risk_money_b.Pressed(cur_risk_money>0);
   Risk_percent_b.Pressed(false);
   ChartRedraw();
   return;
  }
//+------------------------------------------------------------------+
//| Click Risk in percent                                            |
//+------------------------------------------------------------------+
void CTradePanel::RiskPercentClick(void)
  {
   StopLoss_pips_b.Pressed(false);
   StopLoss_money_b.Pressed(cur_sl_money>0);
   Risk_money_b.Pressed(false);
   Risk_percent_b.Pressed(cur_risk_percent>0);
   ChartRedraw();
   return;
  }
//+------------------------------------------------------------------+
//| Create horizontal line                                           |
//+------------------------------------------------------------------+
bool CTradePanel::CreateHLine(long chart, int subwindow,CChartObjectHLine &object,color clr, string comment)
  {
   // All objects must to have separate name
   string name="HLine"+(string)ObjectsTotal(chart,-1,OBJ_HLINE);
   //--- Create horizontal line
   if(!object.Create(chart,name,subwindow,0))
      return false;
   //--- Set color of line
   if(!object.Color(clr))
      return false;
   //--- Set dash style to line
   if(!object.Style(STYLE_DASH))
      return false;
   //--- Add comment to line
   if(!object.Tooltip(comment))
      return false;
   //--- Hide line 
   if(!object.Timeframes(OBJ_NO_PERIODS))
      return false;
   //--- Move line to background
   if(!object.Background(true))
      return false;
   if(!object.Selectable(true))
      return false;
   return true;
  }
//+------------------------------------------------------------------+
//| Show and Hide Stop Loss Lines                                    |
//+------------------------------------------------------------------+
void CTradePanel::StopLossLineClick()
  {
   if(StopLoss_line.Pressed()) // Button pressed
     {
      if(BuySL.Price(0)<=0)
        {
         UpdateSLLines();
        }
      BuySL.Timeframes(OBJ_ALL_PERIODS);
      SellSL.Timeframes(OBJ_ALL_PERIODS);
     }
   else                         // Button unpressed
     {
      BuySL.Timeframes(OBJ_NO_PERIODS);
      SellSL.Timeframes(OBJ_NO_PERIODS);
     }
   ChartRedraw();
   return;
  }
//+------------------------------------------------------------------+
//| Show and Hide Take Profit Lines                                  |
//+------------------------------------------------------------------+
void CTradePanel::TakeProfitLineClick(void)
  {
   if(TakeProfit_line.Pressed())
     {
      if(BuyTP.Price(0)<=0)
        {
         UpdateTPLines();
        }
      BuyTP.Timeframes(OBJ_ALL_PERIODS);
      SellTP.Timeframes(OBJ_ALL_PERIODS);
     }
   else
     {
      BuyTP.Timeframes(OBJ_NO_PERIODS);
      SellTP.Timeframes(OBJ_NO_PERIODS);
     }
   ChartRedraw();
   return;
  }
//+------------------------------------------------------------------+
//|  Increase Lot Click                                              |
//+------------------------------------------------------------------+
void CTradePanel::IncreaseLotClick(void)
  {
   //--- Read and normalize lot value
   cur_lot=NormalizeLots(StringToDouble(Lots.Text())+SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP));
   //--- Output lot value to panel
   Lots.Text(DoubleToString(cur_lot,2));
   //--- Call end edit lot function
   LotsEndEdit();
   return;
  }
//+------------------------------------------------------------------+
//|  Decrease Lot Click                                              |
//+------------------------------------------------------------------+
void CTradePanel::DecreaseLotClick(void)
  {
   //--- Read and normalize lot value
   cur_lot=NormalizeLots(StringToDouble(Lots.Text())-SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP));
   //--- Output lot value to panel
   Lots.Text(DoubleToString(cur_lot,2));
   LotsEndEdit();
  }
//+------------------------------------------------------------------+
//|  Click BUY button                                                |
//+------------------------------------------------------------------+
void CTradePanel::BuyClick(void)
  {
   cur_lot=NormalizeLots(StringToDouble(Lots.Text()));
   Lots.Text(DoubleToString(cur_lot,2));
   double price=SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   double SL=(cur_sl_pips>0 ? NormalizeDouble(price-cur_sl_pips*_Point,_Digits) : 0);
   double TP=(cur_tp_pips>0 ? NormalizeDouble(price+cur_tp_pips*_Point,_Digits) : 0);
   if(!Trade.Buy(NormalizeLots(cur_lot),_Symbol,price,SL,TP,"Trade Panel"))
      MessageBox("Error of open BUY ORDER "+Trade.ResultComment(),"Trade Panel Error",MB_ICONERROR|MB_OK);;
   return;
  }
//+------------------------------------------------------------------+
//|  Click SELL button                                               |
//+------------------------------------------------------------------+
void CTradePanel::SellClick(void)
  {
   cur_lot=NormalizeLots(StringToDouble(Lots.Text()));
   Lots.Text(DoubleToString(cur_lot,2));
   double price=SymbolInfoDouble(_Symbol,SYMBOL_BID);
   double SL=(cur_sl_pips>0 ? NormalizeDouble(price+cur_sl_pips*_Point,_Digits) : 0);
   double TP=(cur_tp_pips>0 ? NormalizeDouble(price-cur_tp_pips*_Point,_Digits) : 0);
   if(!Trade.Sell(NormalizeLots(cur_lot),_Symbol,price,SL,TP,"Trade Panel"))
      MessageBox("Error of open BUY ORDER "+Trade.ResultComment(),"Trade Panel Error",MB_ICONERROR|MB_OK);;
   return;
  }
//+------------------------------------------------------------------+
//|  Click CLOSE BUY button                                          |
//+------------------------------------------------------------------+
void CTradePanel::CloseBuyClick(void)
  {
   if(!PositionSelect(_Symbol) || PositionGetInteger(POSITION_TYPE)!=POSITION_TYPE_BUY)
     {
      return;
     }
   if(!Trade.PositionClose(_Symbol))
      MessageBox("Error of Close position "+Trade.ResultComment(),"Trade Panel Error",MB_ICONERROR|MB_OK);;
   return;
  }
//+------------------------------------------------------------------+
//|  Click CLOSE SELL button                                         |
//+------------------------------------------------------------------+
void CTradePanel::CloseSellClick(void)
  {
   if(!PositionSelect(_Symbol) || PositionGetInteger(POSITION_TYPE)!=POSITION_TYPE_SELL)
     {
      return;
     }
   if(!Trade.PositionClose(_Symbol))
      MessageBox("Error of Close position "+Trade.ResultComment(),"Trade Panel Error",MB_ICONERROR|MB_OK);;
   return;
  }
//+------------------------------------------------------------------+
//|  Click CLOSE BUY button                                          |
//+------------------------------------------------------------------+
void CTradePanel::CloseClick(void)
  {
   if(!PositionSelect(_Symbol))
     {
      return;
     }
   if(!Trade.PositionClose(_Symbol))
      MessageBox("Error of Close position "+Trade.ResultComment(),"Trade Panel Error",MB_ICONERROR|MB_OK);;
   return;
  }
//+------------------------------------------------------------------+
//| Run of Trade Panel                                               |
//+------------------------------------------------------------------+
bool CTradePanel::Run(void)
  {
   IniFileLoad();
   cur_lot=StringToDouble(Lots.Text());
   cur_sl_pips=(int)StringToInteger(StopLoss_pips.Text());     // Stop Loss in pips
   cur_sl_money=StringToDouble(StopLoss_money.Text());         // Stop Loss in money
   cur_tp_pips=(int)StringToInteger(TakeProfit_pips.Text());   // Take Profit in pips
   cur_tp_money=StringToDouble(TakeProfit_money.Text());       // Take Profit in money
   cur_risk_percent=StringToDouble(Risk_percent.Text());       // Risk in percent
   cur_risk_money=StringToDouble(Risk_money.Text());           // Risk in money
   RiskByValue=true;
   StopLossLineClick();
   TakeProfitLineClick();
   return(CAppDialog::Run());
  }
//+------------------------------------------------------------------+
//| Function of moving horizontal lines                              |
//+------------------------------------------------------------------+
bool CTradePanel::DragLine(string name)
  {
   if(name==BuySL.Name())
     {
      StopLoss_pips.Text(DoubleToString(MathAbs(BuySL.Price(0)-SymbolInfoDouble(_Symbol,SYMBOL_ASK))/_Point,0));
      SLPipsEndEdit();
      BuySL.Selected(false);
      return true;
     }
   if(name==SellSL.Name())
     {
      StopLoss_pips.Text(DoubleToString(MathAbs(SellSL.Price(0)-SymbolInfoDouble(_Symbol,SYMBOL_BID))/_Point,0));
      SLPipsEndEdit();
      SellSL.Selected(false);
      return true;
     }
   if(name==BuyTP.Name())
     {
      TakeProfit_pips.Text(DoubleToString(MathAbs(BuyTP.Price(0)-SymbolInfoDouble(_Symbol,SYMBOL_ASK))/_Point,0));
      TPPipsEndEdit();
      BuyTP.Selected(false);
      return true;
     }
   if(name==SellTP.Name())
     {
      TakeProfit_pips.Text(DoubleToString(MathAbs(SellTP.Price(0)-SymbolInfoDouble(_Symbol,SYMBOL_BID))/_Point,0));
      TPPipsEndEdit();
      SellTP.Selected(false);
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Application deinitialization function                            |
//+------------------------------------------------------------------+
void CTradePanel::Destroy(const int reason)
  {
   BuySL.Delete();
   SellSL.Delete();
   BuyTP.Delete();
   SellTP.Delete();
   CAppDialog::Destroy(reason);
   return;
  }