//+------------------------------------------------------------------+
//|                                                SlidingPuzzle.mqh |
//|                                                   Enrico Lambino |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Enrico Lambino"
#property link      "http://www.mql5.com"
#include <Layouts\GridTk.mqh>
#include <Controls\Dialog.mqh>
#include <Controls\Edit.mqh>
#include <Controls\Button.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CSlidingPuzzleDialog : public CAppDialog
  {
protected:
   bool              m_solved;
   int               m_difficulty;
   CGridTk           m_main;
   CButton           m_button1;
   CButton           m_button2;
   CButton           m_button3;
   CButton           m_button4;
   CButton           m_button5;
   CButton           m_button6;
   CButton           m_button7;
   CButton           m_button8;
   CButton           m_button9;
   CButton           m_button10;
   CButton           m_button11;
   CButton           m_button12;
   CButton           m_button13;
   CButton           m_button14;
   CButton           m_button15;
   CButton           m_button16;
   CButton           m_button_new;
   CEdit             m_label;
   CButton          *m_empty_cell;
public:
                     CSlidingPuzzleDialog();
                    ~CSlidingPuzzleDialog();
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);
   virtual bool      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   void              Difficulty(int d) {m_difficulty=d;}
protected:
   virtual bool      CreateMain(const long chart,const string name,const int subwin);
   virtual bool      CreateButton(const int button_id,const long chart,const string name,const int subwin);
   virtual bool      CreateButtonNew(const long chart,const string name,const int subwin);
   virtual bool      CreateLabel(const long chart,const string name,const int subwin);
   virtual bool      IsMovable(CButton *button);
   virtual bool      HasNorth(CButton *button,int id,bool shuffle=false);
   virtual bool      HasSouth(CButton *button,int id,bool shuffle=false);
   virtual bool      HasEast(CButton *button,int id,bool shuffle=false);
   virtual bool      HasWest(CButton *button,int id,bool shuffle=false);
   virtual void      Swap(CButton *source);
   void              OnClickButton(CButton *button);
   void              OnClickButton1();
   void              OnClickButton2();
   void              OnClickButton3();
   void              OnClickButton4();
   void              OnClickButton5();
   void              OnClickButton6();
   void              OnClickButton7();
   void              OnClickButton8();
   void              OnClickButton9();
   void              OnClickButton10();
   void              OnClickButton11();
   void              OnClickButton12();
   void              OnClickButton13();
   void              OnClickButton14();
   void              OnClickButton15();
   void              OnClickButton16();
   void              OnClickButtonNew();
   bool              Check();
   void              Shuffle();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
EVENT_MAP_BEGIN(CSlidingPuzzleDialog)
ON_EVENT(ON_CLICK,m_button1,OnClickButton1)
ON_EVENT(ON_CLICK,m_button2,OnClickButton2)
ON_EVENT(ON_CLICK,m_button3,OnClickButton3)
ON_EVENT(ON_CLICK,m_button4,OnClickButton4)
ON_EVENT(ON_CLICK,m_button5,OnClickButton5)
ON_EVENT(ON_CLICK,m_button6,OnClickButton6)
ON_EVENT(ON_CLICK,m_button7,OnClickButton7)
ON_EVENT(ON_CLICK,m_button8,OnClickButton8)
ON_EVENT(ON_CLICK,m_button9,OnClickButton9)
ON_EVENT(ON_CLICK,m_button10,OnClickButton10)
ON_EVENT(ON_CLICK,m_button11,OnClickButton11)
ON_EVENT(ON_CLICK,m_button12,OnClickButton12)
ON_EVENT(ON_CLICK,m_button13,OnClickButton13)
ON_EVENT(ON_CLICK,m_button14,OnClickButton14)
ON_EVENT(ON_CLICK,m_button15,OnClickButton15)
ON_EVENT(ON_CLICK,m_button16,OnClickButton16)
ON_EVENT(ON_CLICK,m_button_new,OnClickButtonNew)
EVENT_MAP_END(CAppDialog)
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::CSlidingPuzzleDialog() : m_solved(false),
                                               m_difficulty(30)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::~CSlidingPuzzleDialog()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CSlidingPuzzleDialog::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2)
  {
   if(!CAppDialog::Create(chart,name,subwin,x1,y1,x2,y2))
      return(false);
   if(!CreateMain(chart,name,subwin))
      return(false);
   for(int i=1;i<=16;i++)
     {
      if(!CreateButton(i,chart,"block",subwin))
         return(false);
     }
   m_empty_cell=GetPointer(m_button16);
   if(!CreateButtonNew(chart,name,subwin))
      return(false);
   if(!CreateLabel(chart,name,subwin))
      return(false);
   if(!m_main.Pack())
      return(false);
   if(!Add(m_main))
      return(false);
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CSlidingPuzzleDialog::CreateMain(const long chart,const string name,const int subwin)
  {
   if(!m_main.Create(chart,name+"main",subwin,0,0,CDialog::m_client_area.Width(),CDialog::m_client_area.Height()))
      return(false);
   m_main.Init(5,4,2,2);
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CSlidingPuzzleDialog::CreateButtonNew(const long chart,const string name,const int subwin)
  {
   if(!m_button_new.Create(chart,name+"buttonnew",m_subwin,0,0,101,101))
      return(false);
   m_button_new.Text("New");
   m_button_new.ColorBackground(clrYellow);
   if(!m_main.Grid(GetPointer(m_button_new),4,0,1,2))
      return(false);
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CSlidingPuzzleDialog::CreateLabel(const long chart,const string name,const int subwin)
  {
   if(!m_label.Create(chart,name+"labelnew",m_subwin,0,0,102,102))
      return(false);
   m_label.Text("click new");
   m_label.ReadOnly(true);
   m_label.TextAlign(ALIGN_CENTER);
   if(!m_main.Grid(GetPointer(m_label),4,2,1,2))
      return(false);   
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CSlidingPuzzleDialog::CreateButton(const int button_id,const long chart,const string name,const int subwin)
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
      case 10: button = GetPointer(m_button10); break;
      case 11: button = GetPointer(m_button11); break;
      case 12: button = GetPointer(m_button12); break;
      case 13: button = GetPointer(m_button13); break;
      case 14: button = GetPointer(m_button14); break;
      case 15: button = GetPointer(m_button15); break;
      case 16: button = GetPointer(m_button16); break;
      default: return(false);
     }
   if(!button.Create(chart,name+IntegerToString(button_id),subwin,0,0,100,100))
      return(false);
   if(button_id<16)
     {
      if(!button.Text(IntegerToString(button_id)))
         return(false);

     }
   button.Id(button_id);
   button.ColorBackground(clrCyan);
   if(!m_main.Add(button))
      return(false);
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CSlidingPuzzleDialog::IsMovable(CButton *button)
  {
   int id=(int)(button.Id()-m_button1.Id()+1);
   if(button.Text()=="")
      return(false);
   if(HasNorth(button,id) || HasSouth(button,id) || HasEast(button,id) || HasWest(button,id))
      return(true);
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CSlidingPuzzleDialog::HasNorth(CButton *button,int id,bool shuffle=false)
  {
   if(id==1 || id==2 || id==3 || id==4)
      return(false);
   CButton *button_adj=m_main.Control(id-4);
   if(!CheckPointer(button_adj))
      return(false);
   if(!shuffle)
     {
      if(button_adj.Text()!="")
         return(false);
     }
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CSlidingPuzzleDialog::HasSouth(CButton *button,int id,bool shuffle=false)
  {
   if(id==13 || id==14 || id==15 || id==16)
      return(false);
   CButton *button_adj=m_main.Control(id+4);
   if(!CheckPointer(button_adj))
      return(false);
   if(!shuffle)
     {
      if(button_adj.Text()!="")
         return(false);
     }
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CSlidingPuzzleDialog::HasEast(CButton *button,int id,bool shuffle=false)
  {
   if(id==4 || id==8 || id==12 || id==16)
      return(false);
   CButton *button_adj=m_main.Control(id+1);
   if(!CheckPointer(button_adj))
      return(false);
   if(!shuffle)
     {
      if(button_adj.Text()!="")
         return(false);
     }
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CSlidingPuzzleDialog::HasWest(CButton *button,int id,bool shuffle=false)
  {
   if(id==1 || id==5 || id==9 || id==13)
      return(false);
   CButton *button_adj=m_main.Control(id-1);
   if(!CheckPointer(button_adj))
      return(false);
   if(!shuffle)
     {
      if(button_adj.Text()!="")
         return(false);
     }
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::Swap(CButton *source)
  {
   string source_text = source.Text();
   string target_text = m_empty_cell.Text();
   source.Text(target_text);
   m_empty_cell.Text(source_text);
   m_empty_cell=source;
   m_empty_cell.Text("");
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButton(CButton *button)
  {
   if(IsMovable(button) && !m_solved)
     {
      Swap(button);
      Check();
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButton1(void)
  {
   OnClickButton(GetPointer(m_button1));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButton2(void)
  {
   OnClickButton(GetPointer(m_button2));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButton3(void)
  {
   OnClickButton(GetPointer(m_button3));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButton4(void)
  {
   OnClickButton(GetPointer(m_button4));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButton5(void)
  {
   OnClickButton(GetPointer(m_button5));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButton6(void)
  {
   OnClickButton(GetPointer(m_button6));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButton7(void)
  {
   OnClickButton(GetPointer(m_button7));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButton8(void)
  {
   OnClickButton(GetPointer(m_button8));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButton9(void)
  {
   OnClickButton(GetPointer(m_button9));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButton10(void)
  {
   OnClickButton(GetPointer(m_button10));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButton11(void)
  {
   OnClickButton(GetPointer(m_button11));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButton12(void)
  {
   OnClickButton(GetPointer(m_button12));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButton13(void)
  {
   OnClickButton(GetPointer(m_button13));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButton14(void)
  {
   OnClickButton(GetPointer(m_button14));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButton15(void)
  {
   OnClickButton(GetPointer(m_button15));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButton16(void)
  {
   OnClickButton(GetPointer(m_button16));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSlidingPuzzleDialog::OnClickButtonNew(void)
  {
   Shuffle();
   m_label.Text("not solved");
   m_solved=false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CSlidingPuzzleDialog::Check(void)
  {
   int cnt=1;
   for(int i=0;i<m_main.ControlsTotal();i++)
     {
      CWnd *control=m_main.Control(i);
      if(StringFind(control.Name(),"block")>=0)
        {
         CButton *button=control;
         if(CheckPointer(button))
           {
            if(button.Text()!=IntegerToString(cnt) && cnt<16)
              {
               m_label.Text("not solved");
               return(false);
              }
           }
         cnt++;
        }
     }
   m_label.Text("solved");
   m_solved=true;
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CSlidingPuzzleDialog::Shuffle(void)
  {
   int cnt=1;
   for(int i=1;i<m_main.ControlsTotal();i++)
     {
      CWnd *control=m_main.Control(i);
      if(StringFind(control.Name(),"block")>=0)
        {
         CButton *button=control;
         if(cnt<16)
            button.Text((string)cnt);
         if(button.Id()-m_button1.Id()+1==16)
            m_empty_cell=button;
         cnt++;
        }
     }
   MathSrand((int)TimeLocal());
   CButton *target=NULL;
   for(int i=0;i<m_difficulty;i++)
     {
      int empty_cell_id=(int)(m_empty_cell.Id()-m_button1.Id()+1);
      int random=MathRand()%4+1;
      if(random==1 && HasNorth(m_empty_cell,empty_cell_id,true))
         target= m_main.Control(empty_cell_id-4);
      else if(random==2 && HasEast(m_empty_cell,empty_cell_id,true))
         target=m_main.Control(empty_cell_id+1);
      else if(random==3 && HasSouth(m_empty_cell,empty_cell_id,true))
         target=m_main.Control(empty_cell_id+4);
      else if(random==4 && HasWest(m_empty_cell,empty_cell_id,true))
         target=m_main.Control(empty_cell_id-1);
      if(CheckPointer(target))
         Swap(target);
     }
  }
//+------------------------------------------------------------------+
