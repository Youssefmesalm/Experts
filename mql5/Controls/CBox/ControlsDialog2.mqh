//+------------------------------------------------------------------+
//|                                              ControlsDialog2.mqh |
//|                                                   Enrico Lambino |
//|                                      www.mql5.com/en/users/iceron|
//+------------------------------------------------------------------+
#property copyright "Enrico Lambino"
#property link      "www.mql5.com/en/users/iceron"
#include <Controls\Dialog.mqh>
#include <Controls\Button.mqh>
#include <Controls\Edit.mqh>
#include <Controls\DatePicker.mqh>
#include <Controls\ListView.mqh>
#include <Controls\ComboBox.mqh>
#include <Controls\SpinEdit.mqh>
#include <Controls\RadioGroup.mqh>
#include <Controls\CheckGroup.mqh>
#include <Layouts\Box.mqh>
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
//--- for buttons
#define BUTTON_WIDTH                        (100)     // size by X coordinate
#define BUTTON_HEIGHT                       (20)      // size by Y coordinate
//--- for the indication area
#define EDIT_HEIGHT                         (20)      // size by Y coordinate
//--- for group controls
#define GROUP_WIDTH                         (150)     // size by X coordinate
#define LIST_HEIGHT                         (179)     // size by Y coordinate
#define RADIO_HEIGHT                        (56)      // size by Y coordinate
#define CHECK_HEIGHT                        (93)      // size by Y coordinate
//+------------------------------------------------------------------+
//| Class CControlsDialog                                            |
//| Usage: main dialog of the Controls application                   |
//+------------------------------------------------------------------+
class CControlsDialog : public CAppDialog
  {
private:
   CBox              m_main;
   CBox              m_edit_row;
   CEdit             m_edit;                          // the display field object   
   CBox              m_button_row;
   CButton           m_button1;                       // the button object
   CButton           m_button2;                       // the button object
   CButton           m_button3;                       // the fixed button object
   CBox              m_spin_date_row;
   CSpinEdit         m_spin_edit;                     // the up-down object
   CDatePicker       m_date;                          // the datepicker object
   CBox              m_lists_row;
   CBox              m_lists_column1;
   CComboBox         m_combo_box;                     // the dropdown list object
   CRadioGroup       m_radio_group;                   // the radio buttons group object
   CCheckGroup       m_check_group;                   // the check box group object
   CBox              m_lists_column2;
   CListView         m_list_view;                     // the list object

public:
                     CControlsDialog(void);
                    ~CControlsDialog(void);
   //--- create
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);
   //--- chart event handler
   virtual bool      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);

protected:
   //--- create dependent controls
   bool              CreateEdit(void);
   bool              CreateButton1(void);
   bool              CreateButton2(void);
   bool              CreateButton3(void);
   bool              CreateSpinEdit(void);
   bool              CreateDate(void);
   bool              CreateListView(void);
   bool              CreateComboBox(void);
   bool              CreateRadioGroup(void);
   bool              CreateCheckGroup(void);
   //--- handlers of the dependent controls events
   void              OnClickButton1(void);
   void              OnClickButton2(void);
   void              OnClickButton3(void);
   void              OnChangeSpinEdit(void);
   void              OnChangeDate(void);
   void              OnChangeListView(void);
   void              OnChangeComboBox(void);
   void              OnChangeRadioGroup(void);
   void              OnChangeCheckGroup(void);
   //--- containers
   virtual bool      CreateMain(const long chart,const string name,const int subwin);
   virtual bool      CreateEditRow(const long chart,const string name,const int subwin);
   virtual bool      CreateButtonRow(const long chart,const string name,const int subwin);
   virtual bool      CreateSpinDateRow(const long chart,const string name,const int subwin);
   virtual bool      CreateListsRow(const long chart,const string name,const int subwin);
   virtual bool      CreateListsColumn1(const long chart,const string name,const int subwin);
   virtual bool      CreateListsColumn2(const long chart,const string name,const int subwin);
  };
//+------------------------------------------------------------------+
//| Event Handling                                                   |
//+------------------------------------------------------------------+
EVENT_MAP_BEGIN(CControlsDialog)
   ON_EVENT(ON_CLICK,m_button1,OnClickButton1)
   ON_EVENT(ON_CLICK,m_button2,OnClickButton2)
   ON_EVENT(ON_CLICK,m_button3,OnClickButton3)
   ON_EVENT(ON_CHANGE,m_spin_edit,OnChangeSpinEdit)
   ON_EVENT(ON_CHANGE,m_date,OnChangeDate)
   ON_EVENT(ON_CHANGE,m_list_view,OnChangeListView)
   ON_EVENT(ON_CHANGE,m_combo_box,OnChangeComboBox)
   ON_EVENT(ON_CHANGE,m_radio_group,OnChangeRadioGroup)
   ON_EVENT(ON_CHANGE,m_check_group,OnChangeCheckGroup)
EVENT_MAP_END(CAppDialog)
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CControlsDialog::CControlsDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CControlsDialog::~CControlsDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Create                                                           |
//+------------------------------------------------------------------+
bool CControlsDialog::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2)
  {
   if(!CAppDialog::Create(chart,name,subwin,x1,y1,x2,y2))
      return(false);
   if(!CreateMain(chart,name,subwin))
      return(false);
   m_main.VerticalAlign(VERTICAL_ALIGN_TOP);
   if(!CreateEditRow(chart,name,subwin))
      return(false);
   if(!CreateButtonRow(chart,name,subwin))
      return(false);
   if(!CreateSpinDateRow(chart,name,subwin))
      return(false);
   if(!CreateListsRow(chart,name,subwin))
      return(false);
   if(!m_main.Add(m_edit_row))
      return(false);
   if(!m_main.Add(m_button_row))
      return(false);
   if(!m_main.Add(m_spin_date_row))
      return(false);
   if(!m_main.Add(m_lists_row))
      return(false);
   if(!m_main.Pack())
      return(false);
   if(!Add(m_main))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateMain(const long chart,const string name,const int subwin)
  {
   if(!m_main.Create(chart,name+"main",subwin,0,0,CDialog::m_client_area.Width(),CDialog::m_client_area.Height()))
      return(false);
   m_main.LayoutStyle(LAYOUT_STYLE_VERTICAL);
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateEditRow(const long chart,const string name,const int subwin)
  {
   if(!m_edit_row.Create(chart,name+"editrow",subwin,0,0,CDialog::m_client_area.Width(),EDIT_HEIGHT*1.5))
      return(false);
   if(!CreateEdit())
      return(false);
   m_edit_row.PaddingLeft(8);
   m_edit_row.PaddingRight(8);
   m_edit_row.Add(m_edit);
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButtonRow(const long chart,const string name,const int subwin)
  {
   if(!m_button_row.Create(chart,name+"buttonrow",subwin,0,0,CDialog::m_client_area.Width(),BUTTON_HEIGHT*1.5))
      return(false);
   if(!CreateButton1())
      return(false);
   if(!CreateButton2())
      return(false);
   if(!CreateButton3())
      return(false);
   m_button_row.Add(m_button1);
   m_button_row.Add(m_button2);
   m_button_row.Add(m_button3);
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateSpinDateRow(const long chart,const string name,const int subwin)
  {
   if(!m_spin_date_row.Create(chart,name+"spindaterow",subwin,0,0,CDialog::m_client_area.Width(),BUTTON_HEIGHT*1.5))
      return(false);
   if(!CreateSpinEdit())
      return(false);
   if(!CreateDate())
      return(false);
   m_spin_date_row.Add(m_spin_edit);
   m_spin_date_row.Add(m_date);
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateListsRow(const long chart,const string name,const int subwin)
  {
   if(!m_lists_row.Create(chart,name+"listsrow",subwin,0,0,CDialog::m_client_area.Width(),LIST_HEIGHT))
      return(false);
   m_lists_row.PaddingLeft(0);
   m_lists_row.PaddingRight(0);
   if(!CreateListsColumn1(chart,name,subwin))
      return(false);
   if(!CreateListsColumn2(chart,name,subwin))
      return(false);
   m_lists_row.Add(m_lists_column1);
   m_lists_row.Add(m_lists_column2);
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateListsColumn1(const long chart,const string name,const int subwin)
  {
   if(!m_lists_column1.Create(chart,name+"listscolumn1",subwin,0,0,GROUP_WIDTH,LIST_HEIGHT))
      return(false);
   m_lists_column1.Padding(0);
   m_lists_column1.LayoutStyle(LAYOUT_STYLE_VERTICAL);
   m_lists_column1.VerticalAlign(VERTICAL_ALIGN_CENTER_NOSIDES);
   if(!CreateRadioGroup())
      return(false);
   if(!CreateCheckGroup())
      return(false);
   if(!CreateComboBox())
      return(false);
   m_lists_column1.Add(m_combo_box);
   m_lists_column1.Add(m_radio_group);
   m_lists_column1.Add(m_check_group);
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateListsColumn2(const long chart,const string name,const int subwin)
  {
   if(!m_lists_column2.Create(chart,name+"listscolumn2",subwin,0,0,GROUP_WIDTH,LIST_HEIGHT))
      return(false);
   m_lists_column2.Padding(0);
   m_lists_column2.LayoutStyle(LAYOUT_STYLE_VERTICAL);
   m_lists_column2.VerticalAlign(VERTICAL_ALIGN_CENTER);
   if(!CreateListView())
      return(false);
   m_lists_column2.Add(m_list_view);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the display field                                         |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateEdit(void)
  {
//--- create
   if(!m_edit.Create(m_chart_id,m_name+"Edit",m_subwin,0,0,CDialog::m_client_area.Width(),EDIT_HEIGHT))
      return(false);
   if(!m_edit.ReadOnly(true))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Button1" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton1(void)
  {
//--- create
   if(!m_button1.Create(m_chart_id,m_name+"Button1",m_subwin,0,0,BUTTON_WIDTH,BUTTON_HEIGHT))
      return(false);
   if(!m_button1.Text("Button1"))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Button2" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton2(void)
  {
//--- create
   if(!m_button2.Create(m_chart_id,m_name+"Button2",m_subwin,0,0,BUTTON_WIDTH,BUTTON_HEIGHT))
      return(false);
   if(!m_button2.Text("Button2"))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Button3" fixed button                                |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton3(void)
  {
//--- create
   if(!m_button3.Create(m_chart_id,m_name+"Button3",m_subwin,0,0,BUTTON_WIDTH,BUTTON_HEIGHT))
      return(false);
   if(!m_button3.Text("Locked"))
      return(false);
   m_button3.Locking(true);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "SpinEdit" element                                    |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateSpinEdit(void)
  {
//--- create
   if(!m_spin_edit.Create(m_chart_id,m_name+"SpinEdit",m_subwin,0,0,GROUP_WIDTH,EDIT_HEIGHT))
      return(false);
   m_spin_edit.MinValue(10);
   m_spin_edit.MaxValue(1000);
   m_spin_edit.Value(100);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "DatePicker" element                                  |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateDate(void)
  {
//--- create
   if(!m_date.Create(m_chart_id,m_name+"Date",m_subwin,0,0,GROUP_WIDTH,EDIT_HEIGHT))
      return(false);
   m_date.Value(TimeCurrent());
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "ListView" element                                    |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateListView(void)
  {
//--- create
   if(!m_list_view.Create(m_chart_id,m_name+"ListView",m_subwin,0,0,GROUP_WIDTH,LIST_HEIGHT))
      return(false);
//--- fill out with strings
   for(int i=0;i<16;i++)
      if(!m_list_view.AddItem("Item "+IntegerToString(i)))
         return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "ComboBox" element                                    |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateComboBox(void)
  {
//--- create
   if(!m_combo_box.Create(m_chart_id,m_name+"ComboBox",m_subwin,0,0,GROUP_WIDTH,EDIT_HEIGHT))
      return(false);
//--- fill out with strings
   for(int i=0;i<16;i++)
      if(!m_combo_box.ItemAdd("Item "+IntegerToString(i)))
         return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "RadioGroup" element                                  |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateRadioGroup(void)
  {
//--- create
   if(!m_radio_group.Create(m_chart_id,m_name+"RadioGroup",m_subwin,0,0,GROUP_WIDTH,RADIO_HEIGHT))
      return(false);
//--- fill out with strings
   for(int i=0;i<3;i++)
      if(!m_radio_group.AddItem("Item "+IntegerToString(i),1<<i))
         return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "CheckGroup" element                                  |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateCheckGroup(void)
  {
//--- create
   if(!m_check_group.Create(m_chart_id,m_name+"CheckGroup",m_subwin,0,0,GROUP_WIDTH,CHECK_HEIGHT))
      return(false);
//--- fill out with strings
   for(int i=0;i<5;i++)
      if(!m_check_group.AddItem("Item "+IntegerToString(i),1<<i))
         return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnClickButton1(void)
  {
   m_edit.Text(__FUNCTION__);
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnClickButton2(void)
  {
   m_edit.Text(__FUNCTION__);
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnClickButton3(void)
  {
   if(m_button3.Pressed())
      m_edit.Text(__FUNCTION__+"On");
   else
      m_edit.Text(__FUNCTION__+"Off");
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnChangeSpinEdit()
  {
   m_edit.Text(__FUNCTION__+" : Value="+IntegerToString(m_spin_edit.Value()));
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnChangeDate(void)
  {
   m_edit.Text(__FUNCTION__+" \""+TimeToString(m_date.Value(),TIME_DATE)+"\"");
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnChangeListView(void)
  {
   m_edit.Text(__FUNCTION__+" \""+m_list_view.Select()+"\"");
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnChangeComboBox(void)
  {
   m_edit.Text(__FUNCTION__+" \""+m_combo_box.Select()+"\"");
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnChangeRadioGroup(void)
  {
   m_edit.Text(__FUNCTION__+" : Value="+IntegerToString(m_radio_group.Value()));
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnChangeCheckGroup(void)
  {
   m_edit.Text(__FUNCTION__+" : Value="+IntegerToString(m_check_group.Value()));
  }
//+------------------------------------------------------------------+
