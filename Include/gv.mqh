//+------------------------------------------------------------------+
//|                                                           GV.mqh |
//|                                   Copyright 2010, Sergeev Alexey |
//|                                              profy.mql@gmail.com |
//+------------------------------------------------------------------+

class CGV
  {
   string            m_name;             // unique name
   bool              m_temp;             // flag
public:
                     CGV() { m_name=""; m_temp=false; }
   bool              Create(string name,bool temp=false);
                    ~CGV() { Delete(); }
   //--- methods of access to protected data
   string Name() { return(m_name); }
   //--- methods deleting
   bool              Delete();
   //--- methods access to properties object
   bool              Check();
   datetime LastTime() { return(GlobalVariableCheck(m_name)); }
   datetime          Set(const int data);
   datetime          Set(const bool data);
   datetime          Set(const double data);
   datetime          Set(const datetime data);
   bool              Get(int &res);
   bool              Get(bool &res);
   bool              Get(double &res);
   bool              Get(datetime &res);
   void Flush() { GlobalVariablesFlush(); }
  };
//------------------------------------------------
bool CGV::Create(string name,bool temp=false)
  {
   bool rez=true;
   if(GlobalVariableCheck(name)==0)
     {
      if(temp) { rez=false; rez=GlobalVariableTemp(name); }
      if(rez) if(GlobalVariableSet(name,0)>0) { m_name=name; m_temp=temp; return(true); }
     }
   return(false);
  }
//------------------------------------------------
bool CGV::Delete()
  {
   if(GlobalVariableCheck(m_name)) if(GlobalVariableDel(m_name)) { m_name=""; m_temp=false; return(true); }
   return(false);
  }
//------------------------------------------------
bool CGV::Check()
  {
   if(GlobalVariableCheck(m_name)>0) return(true);
   return(false);
  }
//------------------------------------------------
datetime CGV::Set(const int data)
  {
   if(GlobalVariableCheck(m_name)>0) return(GlobalVariableSet(m_name,data));
   return(0);
  }
//------------------------------------------------
datetime CGV::Set(const bool data)
  {
   if(GlobalVariableCheck(m_name)>0) return(GlobalVariableSet(m_name,data));
   return(0);
  }
//------------------------------------------------
datetime CGV::Set(const double data)
  {
   if(GlobalVariableCheck(m_name)>0) return(GlobalVariableSet(m_name,data));
   return(0);
  }
//------------------------------------------------
datetime CGV::Set(const datetime data)
  {
   if(GlobalVariableCheck(m_name)>0) return(GlobalVariableSet(m_name,data));
   return(0);
  }
//------------------------------------------------
bool CGV::Get(int &res)
  {
   bool b=false; double d;
   if(GlobalVariableCheck(m_name)>0) { b=GlobalVariableGet(m_name,d); res=int(d);   }
   return(b);
  }
//------------------------------------------------
bool CGV::Get(bool &res)
  {
   bool b=false; double d;
   if(GlobalVariableCheck(m_name)>0) { b=GlobalVariableGet(m_name,d); res=bool(d); }
   return(b);
  }
//------------------------------------------------
bool CGV::Get(double &res)
  {
   bool b=false; double d;
   if(GlobalVariableCheck(m_name)>0) { b=GlobalVariableGet(m_name,d); res=double(d); }
   return(b);
  }
//------------------------------------------------
bool CGV::Get(datetime &res)
  {
   bool b=false; double d;
   if(GlobalVariableCheck(m_name)>0) { b=GlobalVariableGet(m_name,d); res=datetime(d); }
   return(b);
  }
//+------------------------------------------------------------------+
