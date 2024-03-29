
//+------------------------------------------------------------------+
//|                                                    SK_TVM_EA.mq4 |
//|                SkypeID (batttoot) ==Email (batabeto_1@yahoo.com) |
//|                            https://www.mql5.com/en/users/batttot |
//+------------------------------------------------------------------+
#define Copyright          "Copyright © 2020 SkypeID (batttoot) ==Email (batabeto_1@yahoo.com)"
#property copyright        Copyright
#define Link               "https://www.mql5.com/en/users/batttot"
#property link             Link
#define Version            "1.00"
#property version          Version
#property strict
//---
#property indicator_chart_window

#define ExpertName         "SK_TVM"
#define OBJPREFIX          "MT - "
//---

//---
#define CLIENT_BG_WIDTH    1190
#define INDENT_TOP         15
//---
#define OPENPRICE          0
#define CLOSEPRICE         1
//---
#define OP_ALL            -1
//---
#define KEY_UP             38
#define KEY_DOWN           40
//---
enum ENUM_TF {DAILY/*Daily*/,WEEKLY/*Weekly*/,MONTHLY/*Monthly*/};
enum ENUM_MODE {FULL/*Full*/,COMPACT/*Compact*/,MINI/*Mini*/};
//--- User inputs
input int Pairs_By_Page =6;
    int  Pairs_N_page =Pairs_By_Page-1;
    input int  Strength_Bar1 =240;

input int  Strength_Bar2 =90;
input int  Strength_Bar3 =45;
 

#include <Arrays\ArrayObj.mqh>

//--- input variables
input  string   InpFileName  = "summary_by_symbols.csv"; // Filename
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
/// Class CSymbolSummary for grouping closed trades by symbol in ArrayObj.
class CSymbolSummary : public CObject
  {
public:
   string            symbol;
   int               count;
   double            vols;
   double            prof;
   double            comm;
   double            swap;
public:
                     CSymbolSummary() : count(0),vols(0),prof(0),comm(0),swap(0) {   }
                    ~CSymbolSummary() {   }
   void              Update(double v,double p,double c,double s) { vols+=v; prof+=p; comm+=c; swap+=s; count+=1; }
public:
   //--- method of comparing the objects
   virtual int       Compare(const CObject *node,const int mode=0) const
     {
      const CSymbolSummary *obj=dynamic_cast<const CSymbolSummary *>(node);
      return(StringCompare(this.symbol,obj.symbol));  // 1, 0, -1
     }
  };

input string  ="                    < - - -  General  - - - >";
  ENUM_MODE SelectedMode  = COMPACT;/*Dashboard (Size)*/
 input double  BuyLevel            = 90; 
input double SellLevel           = 10; 
input string Prefix           = "";//Symbol Prefix
input string Suffix           = "";//Symbol Suffix
string TradeSymbols    = "";//"AUDCAD;AUDCHF;AUDJPY;AUDNZD;AUDUSD;CADCHF;CADJPY;CHFJPY;EURAUD;EURCAD;EURCHF;EURGBP;EURJPY;EURNZD;EURUSD;GBPAUD;GBPCAD;GBPCHF;GBPNZD;GBPUSD;GBPJPY;NZDCHF;NZDCAD;NZDJPY;NZDUSD;USDCAD;USDCHF;USDJPY;";/*Symbol List (separated by " ; ")*/

 
input string                  = "                    < - - -  Alerts  - - - >";
 input bool SmartAlert         = true;/*Smart Alerts*/
input bool _Alert             = true;/*Pop-ups*/
input bool Push               = false;/*Push*/
input bool Mail               = false;/*Email*/
input string                  = "                    < - - -  Graphics  - - - >";
input color COLOR_BORDER      = C'255,151,25';/*Panel Border*/
input color COLOR_CBG_LIGHT   = C'252,252,252';/*Chart Background (Light)*/
input color COLOR_CBG_DARK    = C'28,27,26';/*Chart Background (Dark)*/



enum enPrices
  {
   pr_close,      // Close
   pr_open,       // Open
   pr_high,       // High
   pr_low,        // Low
   pr_median,     // Median
   pr_typical,    // Typical
   pr_weighted,   // Weighted
   pr_average,    // Average (high+low+open+close)/4
   pr_medianb,    // Average median body (open+close)/2
   pr_tbiased,    // Trend biased price
   pr_tbiased2,   // Trend biased (extreme) price
   pr_haclose,    // Heiken ashi close
   pr_haopen,     // Heiken ashi open
   pr_hahigh,     // Heiken ashi high
   pr_halow,      // Heiken ashi low
   pr_hamedian,   // Heiken ashi median
   pr_hatypical,  // Heiken ashi typical
   pr_haweighted, // Heiken ashi weighted
   pr_haaverage,  // Heiken ashi average
   pr_hamedianb,  // Heiken ashi median body
   pr_hatbiased,  // Heiken ashi trend biased price
   pr_hatbiased2  // Heiken ashi trend biased (extreme) price
  };
enum enColorOn
  {
   cc_onSlope,   // Change color on slope change
   cc_onMiddle,  // Change color on middle line cross
   cc_onLevels   // Change color on outer levels cross
  };
enum enLevelType
  {
   lev_float, // Floating levels
   lev_quan   // Quantile levels
  };


//--- Global variables
string sTradeSymbols          = TradeSymbols;
string sFontType              = "";
//---
double RiskP                  = 0;
double RiskC                  = 0;
double RiskInpC               = 0;
double RiskInpP               = 0;
//---
int ResetAlertUp              = 0;
int ResetAlertDwn             = 0;
bool UserIsEditing            = false;
bool UserWasNotified          = false;
//---
double StopLossDist           = 0;
double RiskInp                = 0;
double RR                     = 0;
double _TP                    = 0;
//---
int SelectedTheme             = 0;
int PriceRowLeft              = 0;
int PriceRowRight             = 0;
bool ShowTradePanel           = true;
//---
int ErrorInterval             = 300;
int LastReason                = 0;
string ErrorSound             = "error.wav";
bool SoundIsEnabled           = false;
bool AlarmIsEnabled           = false;
int ProfitMode                = 0;
//---
bool AUDAlarm                 = true;
bool CADAlarm                 = true;
bool CHFAlarm                 = true;
bool EURAlarm                 = true;
bool GBPAlarm                 = true;
bool JPYAlarm                 = true;
bool NZDAlarm                 = true;
bool USDAlarm                 = true;
//---
bool AUDTrigger               = false;
bool CADTrigger               = false;
bool CHFTrigger               = false;
bool EURTrigger               = false;
bool GBPTrigger               = false;
bool JPYTrigger               = false;
bool NZDTrigger               = false;
bool USDTrigger               = false;
//----
string SuggestedPair          = "";
int LastTimeFrame             = 0;
int LastMode                  = -1;
//---
bool AutoSL                   = false;
bool AutoTP                   = false;
bool AutoLots                 = false;
bool ClearedTemplate          = false;
bool FirstRun                 = true;
//---
color COLOR_BG                = clrNONE;
color COLOR_FONT              = clrNONE;
//---
color COLOR_GREEN             = clrForestGreen;
color COLOR_RED               = clrFireBrick;
color COLOR_SELL              = C'225,68,29';
color COLOR_BUY               = C'3,95,172';
color COLOR_CLOSE             = clrNONE;
color COLOR_AUTO              = clrDodgerBlue;
color COLOR_LOW               = clrNONE;
color COLOR_MARKER            = clrNONE;
int FONTSIZE                  = 9;
//---
int _x1                       = 0;
int _y1                       = 0;
int ChartX                    = 0;
int ChartY                    = 0;
int Chart_XSize               = 0;
int Chart_YSize               = 0;
int CalcTF                    = 0;
datetime drop_time            = 0;
datetime stauts_time          = 0;
//---
color COLOR_REGBG             = C'27,27,27';
color COLOR_REGFONT           = clrSilver;
//---
int Bck_Win_X                 = 255;
int Bck_Win_Y                 = 150;
//---
string newpairs[];
string UsedSymbols[];
//---
string MB_CAPTION=ExpertName+" v"+Version+" | "+Copyright;
//---
string PriceRowLeftArr[]= {"Bid","Low","Open","Pivot"};
string PriceRowRightArr[]= {"Ask","High","Open","Pivot"};

datetime tim1,tim2,tim3,tim4,tim5,tim6,tim7,tim8,tim9;
//string Symbols[];


 
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
  
//--- return value of prev_calculated for next call
   return(rates_total);
  }
 
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {

   string expirytime = "2020.2.10";
   string starttime = "2017.1.1";
   datetime expirytime1 = StrToTime(expirytime);
   datetime starttime1 = StrToTime(starttime);
   if(TimeCurrent() >= expirytime1 ||TimeCurrent() < starttime1)
     {
      Comment("Your copy for testing from "+ starttime + " to "+  expirytime +" please contact support  Email:batabeto_1@yahoo.com ");
      Print("Your copy for testing from "+starttime + " to "+  expirytime +" please contact support  Email:batabeto_1@yahoo.com ");

     }
   else
     {
     
IndicatorShortName(ExpertName);

      int HowManySymbols=SymbolsTotal(true);
      string ListSymbols=" ";
      for(int i=0; i<HowManySymbols; i++)
        {
         ListSymbols=StringConcatenate(ListSymbols,SymbolName(i,true),",");
        }

      u_sep=StringGetCharacter(sep,0);
      kz=StringSplit(ListSymbols,u_sep,newpairs);
      int index =0;
      int index2 =0;
      for(int i=0; i<ArraySize(newpairs); i++)
        {
         if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)==0)
           {
            continue;
           }
         if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)!=0)
           {
            if(sigma1_value(newpairs[i] , Strength_Bar1,iClose(newpairs[i],0,0))*100>=BuyLevel || sigma1_value(newpairs[i] , Strength_Bar1,iClose(newpairs[i],0,0))*100<=SellLevel)
              {
               // finalpairs[index]=newpairs[i];
               index++;
              }
           }
        }

      ArrayResize(finalpairs,index);
      for(int i=0; i<ArraySize(newpairs); i++)
        {
         if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)==0)
           {
            continue;
           }
         if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)!=0)
           {
            if(sigma1_value(newpairs[i] , Strength_Bar1,iClose(newpairs[i],0,0))*100>=BuyLevel || sigma1_value(newpairs[i] , Strength_Bar1,iClose(newpairs[i],0,0))*100<=SellLevel)
              {
               finalpairs[index2]=newpairs[i];
               index2++;
              }
           }
        }
      ArrayResize(currentpage,Pairs_N_page+1);

      for(int i=0; i<=Pairs_N_page; i++)
        {
         currentpage[i]=finalpairs[starter-i];

        }
      //---- CreateTimer
      EventSetMillisecondTimer(100);

      //--- StrategyTester
      if(MQLInfoInteger(MQL_TESTER))
        {
         _OnTester();
         return(INIT_SUCCEEDED);
        }

      //--- Disclaimer
      if(!GlobalVariableCheck(OBJPREFIX+"Disclaimer") || GlobalVariableGet(OBJPREFIX+"Disclaimer")!=1)
        {
         //---
         string message="hope you like this product";
         //---
         if(MessageBox(message,MB_CAPTION,MB_OKCANCEL|MB_ICONWARNING)==IDOK)
            GlobalVariableSet(OBJPREFIX+"Disclaimer",1);
         else
            return(INIT_FAILED);
        }

      //---
      if(!GlobalVariableCheck(OBJPREFIX+"Theme"))
         SelectedTheme=1;
      else
         SelectedTheme=(int)GlobalVariableGet(OBJPREFIX+"Theme");

      //---
      if(SelectedTheme==0)
        {
         COLOR_BG=C'240,240,240';
         COLOR_FONT=C'40,41,59';
         COLOR_GREEN=clrForestGreen;
         COLOR_RED=clrIndianRed;
         COLOR_LOW=clrGoldenrod;
         COLOR_MARKER=clrDarkOrange;
        }
      else
        {
         COLOR_BG=C'28,28,28';
         COLOR_FONT=clrSilver;
         COLOR_GREEN=clrLimeGreen;
         COLOR_RED=clrRed;
         COLOR_LOW=clrYellow;
         COLOR_MARKER=clrGold;
        }

      //---
      if(LastReason==0)
        {

         //--- OfflineChart
         if(ChartGetInteger(0,CHART_IS_OFFLINE))
           {
            MessageBox("The currenct chart is offline, make sure to uncheck \"Offline chart\" under Properties(F8)->Common.",
                       MB_CAPTION,MB_OK|MB_ICONERROR);
            return(INIT_FAILED);
           }

         //--- CheckConnection
         if(!TerminalInfoInteger(TERMINAL_CONNECTED))
            MessageBox("Warning: No Internet connection found!\nPlease check your network connection.",
                       MB_CAPTION+" | "+"#"+IntegerToString(123),MB_OK|MB_ICONWARNING);

 

       
         //---
         if(!SymbolInfoInteger(_Symbol,SYMBOL_TRADE_MODE))//Symbol
            MessageBox("Warning: Trading is disabled for the symbol "+_Symbol+" at the trade server side.",
                       MB_CAPTION+" | "+"#"+IntegerToString(ERR_TRADE_DISABLED),MB_OK|MB_ICONWARNING);

         //--- CheckDotsPerInch
         if(TerminalInfoInteger(TERMINAL_SCREEN_DPI)!=96)
           {
            Comment("Warning: 96 DPI highly recommended !");
            Sleep(3000);
            Comment("");
           }

        }

 

 
     
 

      //--- Init ChartSize
      Chart_XSize = (int)ChartGetInteger(0,CHART_WIDTH_IN_PIXELS);
      Chart_YSize = (int)ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS);
      ChartX=Chart_XSize;
      ChartY=Chart_YSize;

      //--- CheckSoundIsEnabled
      if(!GlobalVariableCheck(OBJPREFIX+"Sound"))
         SoundIsEnabled=true;
      else
         SoundIsEnabled=GlobalVariableGet(OBJPREFIX+"Sound");

      //--- Alert
      if(!GlobalVariableCheck(OBJPREFIX+"Alarm"))
         AlarmIsEnabled=true;
      else
         AlarmIsEnabled=GlobalVariableGet(OBJPREFIX+"Alarm");

      if(!_Alert && !Push && !Mail)
        {
         //---
         AlarmIsEnabled=false;
         //---
         if(ObjectFind(0,OBJPREFIX+"ALARMIO")==0)
            if(ObjectGetInteger(0,OBJPREFIX+"ALARMIO",OBJPROP_COLOR)!=C'59,41,40')
               ObjectSetInteger(0,OBJPREFIX+"ALARMIO",OBJPROP_COLOR,C'59,41,40');
        }

      //---
      if(!GlobalVariableCheck(OBJPREFIX+"Dashboard"))
         ShowTradePanel=true;
      else
         ShowTradePanel=GlobalVariableGet(OBJPREFIX+"Dashboard");
 
      //---
      if(LastReason==0)
         ChartGetColor();

      //--- Hide OneClick Arrow
      ChartSetInteger(0,CHART_SHOW_ONE_CLICK,true);
      ChartSetInteger(0,CHART_SHOW_ONE_CLICK,false);

      //--- ChartChanged
      if(LastReason==REASON_CHARTCHANGE)
         _PlaySound("switch.wav");

      //---
      if(ShowTradePanel)
         ChartMouseScrollSet(false);
      else
         ChartMouseScrollSet(true);

    
      //---
      if(SelectedMode!=LastMode)
         ObjectsDeleteAll(0,OBJPREFIX,-1,-1);

      //--- Init Speed Prices
      for(int i=ArraySize(newpairs)-1; i>=0; i--)
         GlobalVariableSet(OBJPREFIX+Prefix+newpairs[i]+Suffix+" - Price",(SymbolInfoDouble(Prefix+newpairs[i]+Suffix,SYMBOL_ASK)+SymbolInfoDouble(Prefix+newpairs[i]+Suffix,SYMBOL_BID))/2);

      //--- Animation
      if(LastReason==0 && ShowTradePanel)
        {
         //---
         ObjectsCreateAll();
         ObjectSetInteger(0,OBJPREFIX+"PRICEROW_Lª",OBJPROP_COLOR,clrNONE);
         ObjectSetInteger(0,OBJPREFIX+"PRICEROW_Rª",OBJPROP_COLOR,clrNONE);
         //---
         SetStatus("6","Please wait...");
         //---
        
        
        }

      //---
      FirstRun=false;

      //--- Dropped Time
      drop_time=TimeLocal();

      //--- Border Color
      if(ShowTradePanel)
        {
         //---
         if(ObjectFind(0,OBJPREFIX+"BORDER[]")==0 || ObjectFind(0,OBJPREFIX+"BCKGRND[]")==0)
           {
            //---
            if(ObjectGetInteger(0,OBJPREFIX+"BORDER[]",OBJPROP_COLOR)!=COLOR_BORDER)
              {
               ObjectSetInteger(0,OBJPREFIX+"BORDER[]",OBJPROP_COLOR,COLOR_BORDER);
               ObjectSetInteger(0,OBJPREFIX+"BORDER[]",OBJPROP_BGCOLOR,COLOR_BORDER);
               ObjectSetInteger(0,OBJPREFIX+"BCKGRND[]",OBJPROP_COLOR,COLOR_BORDER);
              }
           }
        }
      //---
      if(!ShowTradePanel)
        {
         //---
         if(ObjectFind(0,OBJPREFIX+"MIN"+"BCKGRND[]")==0)
           {
            //---
            if(ObjectGetInteger(0,OBJPREFIX+"MIN"+"BCKGRND[]",OBJPROP_COLOR)!=COLOR_BORDER)
              {
               ObjectSetInteger(0,OBJPREFIX+"MIN"+"BCKGRND[]",OBJPROP_COLOR,COLOR_BORDER);
               ObjectSetInteger(0,OBJPREFIX+"MIN"+"BCKGRND[]",OBJPROP_BGCOLOR,COLOR_BORDER);
              }
           }
        }
      //----
 pagescode();

     }
   return(INIT_SUCCEEDED);
  }
  
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---- DestroyTimer
   EventKillTimer();

//--- Save global variables
   if(reason!=REASON_INITFAILED && !MQLInfoInteger(MQL_TESTER))
     {
      //---
      for(int i=0; i<ArraySize(newpairs); i++)
        {
         //---
         GlobalVariableDel(Prefix+newpairs[i]+Suffix+" - Price");
         //---
         if(ShowTradePanel)
           {
            GlobalVariableSet(OBJPREFIX+Prefix+newpairs[i]+Suffix+" - Stoploss",StringToDouble(ObjectGetString(0,OBJPREFIX+"SL<>"+" - "+Prefix+newpairs[i]+Suffix,OBJPROP_TEXT)));
            GlobalVariableSet(OBJPREFIX+Prefix+newpairs[i]+Suffix+" - Takeprofit",StringToDouble(ObjectGetString(0,OBJPREFIX+"_TP<>"+" - "+Prefix+newpairs[i]+Suffix,OBJPROP_TEXT)));
            GlobalVariableSet(OBJPREFIX+Prefix+newpairs[i]+Suffix+" - Lotsize",StringToDouble(ObjectGetString(0,OBJPREFIX+"LOTSIZE<>"+" - "+Prefix+newpairs[i]+Suffix,OBJPROP_TEXT)));
           }
        }
      //---
      if(ShowTradePanel)
        {
         GlobalVariableSet(OBJPREFIX+"Stoploss",StringToDouble(ObjectGetString(0,OBJPREFIX+"SL<>",OBJPROP_TEXT)));
         GlobalVariableSet(OBJPREFIX+"Takeprofit",StringToDouble(ObjectGetString(0,OBJPREFIX+"_TP<>",OBJPROP_TEXT)));
         GlobalVariableSet(OBJPREFIX+"Lotsize",StringToDouble(ObjectGetString(0,OBJPREFIX+"LOTSIZE<>",OBJPROP_TEXT)));
        }
      //---
      GlobalVariableSet(OBJPREFIX+"Theme",SelectedTheme);
      //---
      GlobalVariableSet(OBJPREFIX+"Dashboard",ShowTradePanel);
      //---
      GlobalVariableSet(OBJPREFIX+"Sound",SoundIsEnabled);
      //---
      GlobalVariableSet(OBJPREFIX+"Alarm",AlarmIsEnabled);
      //---
      GlobalVariableSet(OBJPREFIX+"AutoSL",AutoSL);
      GlobalVariableSet(OBJPREFIX+"AutoTP",AutoTP);
      GlobalVariableSet(OBJPREFIX+"AutoLots",AutoLots);
      //---
      GlobalVariableSet(OBJPREFIX+"RR",RR);
      GlobalVariableSet(OBJPREFIX+"Risk",RiskInp);
      //---
      GlobalVariableSet(OBJPREFIX+"PRL",PriceRowLeft);
      GlobalVariableSet(OBJPREFIX+"PRR",PriceRowRight);
      //---
      GlobalVariablesFlush();
     }
//--- DeleteObjects
   if(reason<=REASON_REMOVE || reason==REASON_CLOSE || reason==REASON_RECOMPILE || reason==REASON_INITFAILED || reason==REASON_ACCOUNT)
     {
      ObjectsDeleteAll(0,OBJPREFIX,-1,-1);
      DelteMinWindow();
     }

//---
   if(reason<=REASON_REMOVE || reason==REASON_CLOSE || reason==REASON_RECOMPILE)
     {
      //---
      if(ClearedTemplate)
         ChartSetColor(2);
     }

//--- UnblockScrolling
   ChartMouseScrollSet(true);

//--- UserIsRegistred
   if(!GlobalVariableCheck(OBJPREFIX+"Registred"))
      GlobalVariableSet(OBJPREFIX+"Registred",1);

//---
   LastMode=SelectedMode;

//--- StoreDeinitReason
   LastReason=reason;
//----
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
int pages,starter =Pairs_N_page ;
string aSymbols[];
string finalpairs[];
string currentpage[];

datetime tim;
string sep=",";                // A separator as a character
ushort u_sep;                  // The code of the separator character
int kz ;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTimer()
  {
//----
//Comment(SymbolsTotal(true));
 
  
    string expirytime = "2020.2.10";
   string starttime = "2017.1.1";
   datetime expirytime1 = StrToTime(expirytime);
   datetime starttime1 = StrToTime(starttime);
   if(TimeCurrent() >= expirytime1 ||TimeCurrent() < starttime1)
     {
      Comment("Your copy for testing from "+ starttime + " to "+  expirytime +" please contact support  Email:batabeto_1@yahoo.com ");
      Print("Your copy for testing from "+starttime + " to "+  expirytime +" please contact support  Email:batabeto_1@yahoo.com ");

     }
   else
     {

      int HowManySymbols=SymbolsTotal(true);
      string ListSymbols=" ";
      for(int i=0; i<HowManySymbols; i++)
        {
         ListSymbols=StringConcatenate(ListSymbols,SymbolName(i,true),",");
        }

      u_sep=StringGetCharacter(sep,0);
      kz=StringSplit(ListSymbols,u_sep,newpairs);
      int index =0;
      int index2 =0;
      for(int i=0; i<ArraySize(newpairs); i++)
        {
         if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)==0)
           {
            continue;
           }
         if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)!=0)
           {
            if(sigma1_value(newpairs[i] , Strength_Bar1,iClose(newpairs[i],0,0))*100>=90 || sigma1_value(newpairs[i] , Strength_Bar1,iClose(newpairs[i],0,0))*100<=10)
              {
               // finalpairs[index]=newpairs[i];
               index++;
              }
           }
        }

      ArrayResize(finalpairs,index);
      for(int i=0; i<ArraySize(newpairs); i++)
        {
         if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)==0)
           {
            continue;
           }
         if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)!=0)
           {
           if(sigma1_value(newpairs[i] , Strength_Bar1,iClose(newpairs[i],0,0))*100>=90 || sigma1_value(newpairs[i] , Strength_Bar1,iClose(newpairs[i],0,0))*100<=10)
              {
               finalpairs[index2]=newpairs[i];
               index2++;
              }
           }
        }
      ArrayResize(currentpage,Pairs_N_page+1);

      for(int i=0; i<=Pairs_N_page; i++)
        {
         currentpage[i]=finalpairs[starter-i];

        }


 
      //---
      if(ShowTradePanel)
        {
         //---
         ObjectsCreateAll();
         //---
         for(int i=0; i<ArraySize(newpairs); i++)
           {
            ObjectsUpdateAll(Prefix+newpairs[i]+Suffix);
            
           }
         
         //--- MoveWindow
         if(LastReason==REASON_CHARTCHANGE)
           {
            Chart_XSize=(int)ChartGetInteger(0,CHART_WIDTH_IN_PIXELS);
            Chart_YSize=(int)ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS);
            //---
            ChartX=Chart_XSize;
            ChartY=Chart_YSize;
            //---
            LastReason=0;
           }
         //---
         if(ChartX!=Chart_XSize || ChartY!=Chart_YSize)
           {
            ObjectsDeleteAll(0,OBJPREFIX,-1,-1);
            //---
            ObjectsCreateAll();
            //---
            ChartX=Chart_XSize;
            ChartY=Chart_YSize;
           }
         //---
         Chart_XSize=(int)ChartGetInteger(0,CHART_WIDTH_IN_PIXELS);
         Chart_YSize=(int)ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS);

         //--- Connected
         if(TerminalInfoInteger(TERMINAL_CONNECTED))
           {
            //---
            if(ObjectGetString(0,OBJPREFIX+"CONNECTION",OBJPROP_TEXT)!="ü")//GetObject
               ObjectSetString(0,OBJPREFIX+"CONNECTION",OBJPROP_TEXT,"ü");//SetObject
            //---
            if(ObjectGetString(0,OBJPREFIX+"CONNECTION",OBJPROP_TOOLTIP)!="Connected")//GetObject
              {
               double Ping=TerminalInfoInteger(TERMINAL_PING_LAST);//SetPingToMs
               ObjectSetString(0,OBJPREFIX+"CONNECTION",OBJPROP_TOOLTIP,"Connected..."+"\nPing: "+DoubleToString(Ping/1000,2)+" ms");//SetObject
              }
           }
         //--- Disconnected
         else
           {
            //---
            if(ObjectGetString(0,OBJPREFIX+"CONNECTION",OBJPROP_TEXT)!="ñ")//GetObject
               ObjectSetString(0,OBJPREFIX+"CONNECTION",OBJPROP_TEXT,"ñ");//SetObject
            //---
            if(ObjectGetString(0,OBJPREFIX+"CONNECTION",OBJPROP_TOOLTIP)!="No connection!")//GetObject
               ObjectSetString(0,OBJPREFIX+"CONNECTION",OBJPROP_TOOLTIP,"No connection!");//SetObject
           }
         //--- ResetStatus
         if(stauts_time<TimeLocal()-1)
            ResetStatus();
         //---
         // Comment("");
         ChartRedraw();
        }
      else
         CreateMinWindow();
      //----
     } 
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//----
   if(id==CHARTEVENT_KEYDOWN)
     {

      //---
      if(true)
        {
         //---
     
         //---
      
         //--- Switch Symbol (UP)
         if(lparam==KEY_UP)
           {
            //---
            int index=0;
            //---
            for(int i=0; i<ArraySize(newpairs); i++)
              {
               if(_Symbol==Prefix+newpairs[i]+Suffix)
                 {
                  //---
                  index=i-1;
                  //---
                  if(index<0)
                     index=ArraySize(newpairs)-1;
                  //---
                  if(SymbolFind(Prefix+newpairs[index]+Suffix,false))
                    {
                     ChartSetSymbolPeriod(0,Prefix+newpairs[index]+Suffix,PERIOD_CURRENT);
                     SetStatus("ÿ","Switched to "+newpairs[index]);
                     break;
                    }
                 }
              }
           }

         //--- Switch Symbol (DOWN)
         if(lparam==KEY_DOWN)
           {
            //---
            int index=0;
            //---
            for(int i=0; i<ArraySize(newpairs); i++)
              {
               //---
               if(_Symbol==Prefix+newpairs[i]+Suffix)
                 {
                  //---
                  index=i+1;
                  //---
                  if(index>=ArraySize(newpairs))
                     index=0;
                  //---
                  if(SymbolFind(Prefix+newpairs[index]+Suffix,false))
                    {
                     ChartSetSymbolPeriod(0,Prefix+newpairs[index]+Suffix,PERIOD_CURRENT);
                     SetStatus("ÿ","Switched to "+newpairs[index]);
                     break;
                    }
                 }
              }
           }
        }
     }

//--- OBJ_CLICKS
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      if(sparam==OBJPREFIX+"exportcsv")
        {

         Export();
         ObjectSetInteger(0,OBJPREFIX+"exportcsv",OBJPROP_STATE,false);//SetObject
        }

      if(sparam==OBJPREFIX+"pagbtn")
        {
         deletepanel();
         pages =(ArraySize(finalpairs)/Pairs_N_page)+1;
         if(starter+Pairs_N_page>ArraySize(finalpairs))
           {starter=0;}
         if(starter<=ArraySize(finalpairs))
           {
            starter =starter+Pairs_N_page;
           }
         int x=150;//ChartMiddleX()-(Dpi2(CLIENT_BG_WIDTH)/2);
   int y=50;//ChartMiddleY()-(fr_y2/2);


 LabelCreate(0,OBJPREFIX+"Pages",0,x+50,y-10,CORNER_LEFT_UPPER,"Page "+IntegerToString(starter/Pairs_N_page,0,0)+"/"+IntegerToString(pages-1,0,0),"Arial Black",10,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");

         int HowManySymbols=SymbolsTotal(true);
         string ListSymbols=" ";
         for(int i=0; i<HowManySymbols; i++)
           {
            ListSymbols=StringConcatenate(ListSymbols,SymbolName(i,true),",");
           }

         u_sep=StringGetCharacter(sep,0);
         kz=StringSplit(ListSymbols,u_sep,newpairs);
         int index =0;
         int index2 =0;
         for(int i=0; i<ArraySize(newpairs); i++)
           {
            if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)==0)
              {
               continue;
              }
            if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)>0)
              {
               if(sigma1_value(newpairs[i] , Strength_Bar1,iClose(newpairs[i],0,0))*100>=BuyLevel || sigma1_value(newpairs[i] , Strength_Bar1,iClose(newpairs[i],0,0))*100<=SellLevel)
                 {
                  // finalpairs[index]=newpairs[i];
                  index++;
                 }
              }
           }

         ArrayResize(finalpairs,index);
         for(int i=0; i<ArraySize(newpairs); i++)
           {
            if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)==0)
              {
               continue;
              }
            if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)>0)
              {
                if(sigma1_value(newpairs[i] , Strength_Bar1,iClose(newpairs[i],0,0))*100>=BuyLevel || sigma1_value(newpairs[i] , Strength_Bar1,iClose(newpairs[i],0,0))*100<=SellLevel)
                 {
                  finalpairs[index2]=newpairs[i];
                  index2++;
                 }
              }
           }
         ArrayResize(currentpage,Pairs_N_page+1);
         for(int i=0; i<=Pairs_N_page; i++)
           {
            currentpage[i]=finalpairs[starter-i];

           }
         pages =(ArraySize(finalpairs)/Pairs_N_page)+1;

         draw_again();

         ObjectSetInteger(0,OBJPREFIX+"pagbtn",OBJPROP_STATE,false);//SetObject
        }


      //---
      
      
            if(sparam==OBJPREFIX+"pagbtn2")
        {
         if(starter/Pairs_N_page>1)
        {
         deletepanel();
         pages =(ArraySize(finalpairs)/Pairs_N_page)+1;
         if(starter-Pairs_N_page<=0)
           {starter=0;}
         if(starter<=ArraySize(finalpairs)&& starter>Pairs_N_page)
           {
            starter =starter-Pairs_N_page;
           }
           
         int x=150;//ChartMiddleX()-(Dpi2(CLIENT_BG_WIDTH)/2);
   int y=50;//ChartMiddleY()-(fr_y2/2);


 LabelCreate(0,OBJPREFIX+"Pages",0,x+50,y-10,CORNER_LEFT_UPPER,"Page "+IntegerToString(starter/Pairs_N_page,0,0)+"/"+IntegerToString(pages-1,0,0),"Arial Black",10,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");

         int HowManySymbols=SymbolsTotal(true);
         string ListSymbols=" ";
         for(int i=0; i<HowManySymbols; i++)
           {
            ListSymbols=StringConcatenate(ListSymbols,SymbolName(i,true),",");
           }

         u_sep=StringGetCharacter(sep,0);
         kz=StringSplit(ListSymbols,u_sep,newpairs);
         int index =0;
         int index2 =0;
         for(int i=0; i<ArraySize(newpairs); i++)
           {
            if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)==0)
              {
               continue;
              }
            if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)>0)
              {
                if(sigma1_value(newpairs[i] , Strength_Bar1,iClose(newpairs[i],0,0))*100>=BuyLevel || sigma1_value(newpairs[i] , Strength_Bar1,iClose(newpairs[i],0,0))*100<=SellLevel)
                 {
                  // finalpairs[index]=newpairs[i];
                  index++;
                 }
              }
           }

         ArrayResize(finalpairs,index);
         for(int i=0; i<ArraySize(newpairs); i++)
           {
            if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)==0)
              {
               continue;
              }
            if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)>0)
              {
               if(sigma1_value(newpairs[i] , Strength_Bar1,iClose(newpairs[i],0,0))*100>=BuyLevel || sigma1_value(newpairs[i] , Strength_Bar1,iClose(newpairs[i],0,0))*100<=SellLevel)
                 {
                  finalpairs[index2]=newpairs[i];
                  index2++;
                 }
              }
           }
         ArrayResize(currentpage,Pairs_N_page+1);
         for(int i=0; i<=Pairs_N_page; i++)
           {
            currentpage[i]=finalpairs[starter-i];

           }
         pages =(ArraySize(finalpairs)/Pairs_N_page)+1;

         draw_again();
      
         }
         ObjectSetInteger(0,OBJPREFIX+"pagbtn2",OBJPROP_STATE,false);//SetObject
        }

      
      
      
      
 
      //---
      for(int i=0; i<ArraySize(newpairs); i++)
        {
  
         //--- SymoblSwitcher
         if(sparam==OBJPREFIX+Prefix+newpairs[i]+Suffix)
           {
            ChartSetSymbolPeriod(0,Prefix+newpairs[i]+Suffix,PERIOD_CURRENT);
            SetStatus("ÿ","Switched to "+newpairs[i]);
            break;
           }
        }

      //--- RemoveExpert
      if(sparam==OBJPREFIX+"EXIT")
        {
         //---
         if(MessageBox("Are you sure you want to exit?",MB_CAPTION,MB_ICONQUESTION|MB_YESNO)==IDYES)
           ChartIndicatorDelete(0, 0, ExpertName);
        }

      //--- Minimize
      if(sparam==OBJPREFIX+"MINIMIZE")
        {
         ObjectsDeleteAll(0,OBJPREFIX,-1,-1);
         CreateMinWindow();
         ShowTradePanel=false;
         ChartMouseScrollSet(true);
         ChartSetColor(2);
         ClearedTemplate=false;
        }

      //--- Maximize
      if(sparam==OBJPREFIX+"MIN"+"MAXIMIZE")
        {
         DelteMinWindow();
         ObjectsCreateAll();
         ShowTradePanel=true;
         ChartMouseScrollSet(false);
        }

      //--- Ping
      if(sparam==OBJPREFIX+"CONNECTION")
        {
         //---
         double Ping=TerminalInfoInteger(TERMINAL_PING_LAST);//SetPingToMs
         //---
         if(TerminalInfoInteger(TERMINAL_CONNECTED))
            SetStatus("\n","Ping: "+DoubleToString(Ping/1000,2)+" ms");
         else
            SetStatus("ý","No Internet connection...");
        }

      
      //--- SwitchTheme
      if(sparam==OBJPREFIX+"THEME")
        {
         //---
         if(SelectedTheme==0)
           {
            ObjectsDeleteAll(0,OBJPREFIX,-1,-1);
            COLOR_BG=C'28,28,28';
            COLOR_FONT=clrSilver;
            COLOR_GREEN=clrLimeGreen;
            COLOR_RED=clrRed;
            COLOR_LOW=clrYellow;
            COLOR_MARKER=clrGold;
            ObjectsCreateAll();
            SelectedTheme=1;
            //---
            SetStatus("ÿ","Dark theme selected...");
            Sleep(250);
            ResetStatus();
           }
         else
           {
            ObjectsDeleteAll(0,OBJPREFIX,-1,-1);
            COLOR_BG=C'240,240,240';
            COLOR_FONT=C'40,41,59';
            COLOR_GREEN=clrForestGreen;
            COLOR_RED=clrIndianRed;
            COLOR_LOW=clrGoldenrod;
            COLOR_MARKER=clrDarkOrange;
            ObjectsCreateAll();
            SelectedTheme=0;
            //---
            SetStatus("ÿ","Light theme selected...");
            Sleep(250);
            ResetStatus();
           }
        }

      //--- SwitchTheme
      if(sparam==OBJPREFIX+"TEMPLATE")
        {
         //---
         if(!ClearedTemplate)
           {
            //---
            if(SelectedTheme==0)
              {
               ChartSetColor(0);
               ClearedTemplate=true;
               SetStatus("ÿ","Chart color cleared...");
              }
            else
              {
               ChartSetColor(1);
               ClearedTemplate=true;
               SetStatus("ÿ","Chart color cleared...");
              }
           }
         else
           {
            ChartSetColor(2);
            ClearedTemplate=false;
            SetStatus("ÿ","Original chart color applied...");
           }
        }

      //--- GetParameters
      GetParam(sparam);

      //--- SoundManagement
      if(sparam==OBJPREFIX+"SOUND" || sparam==OBJPREFIX+"SOUNDIO")
        {
         //--- EnableSound
         if(!SoundIsEnabled)
           {
            SoundIsEnabled=true;
            ObjectSetInteger(0,OBJPREFIX+"SOUNDIO",OBJPROP_COLOR,C'59,41,40');//SetObject
            SetStatus("þ","Sounds enabled...");
            PlaySound("sound.wav");
           }
         //--- DisableSound
         else
           {
            SoundIsEnabled=false;
            ObjectSetInteger(0,OBJPREFIX+"SOUNDIO",OBJPROP_COLOR,clrNONE);//SetObject
            SetStatus("ý","Sounds disabled...");
           }
        }
      //--- AlarmManagement
      if(sparam==OBJPREFIX+"ALARM" || sparam==OBJPREFIX+"ALARMIO")
        {
         //--- EnableSound
         if(!AlarmIsEnabled)
           {
            //---
            AlarmIsEnabled=true;
            //---
            ObjectSetInteger(0,OBJPREFIX+"ALARMIO",OBJPROP_COLOR,clrNONE);
            //---
            string message="\n";
            //---
            if(_Alert)
               message="[Pop-up]";
            //---
            if(Push)
               StringAdd(message,"[Push]");
            //---
            if(Mail)
               StringAdd(message,"[Email]");
            //---
            if(!_Alert && !Push && !Mail)
              {
               Alert(OBJPREFIX+"No alert method selected!");
               return;
              }
            //---
            Alert("Alerts enabled "+message);
            SetStatus("þ","Alerts enabled...");
           }
         //--- DisableSound
         else
           {
            //---
            AlarmIsEnabled=false;
            ObjectSetInteger(0,OBJPREFIX+"ALARMIO",OBJPROP_COLOR,C'59,41,40');
            //---
            SetStatus("ý","Alerts disabled...");
           }
        }

      //--- Balance
      if(sparam==OBJPREFIX+"BALANCE«")
        {
         //---
         string text="";
         //---
         if(_AccountCurrency()=="$" || _AccountCurrency()=="£")
            text=_AccountCurrency()+DoubleToString(AccountInfoDouble(ACCOUNT_EQUITY),2);
         else
            text=DoubleToString(AccountInfoDouble(ACCOUNT_EQUITY),2)+_AccountCurrency();
         //---
         SetStatus("","Equity: "+text);
        }

 
 

      //--- Switch PriceRow Left
      if(sparam==OBJPREFIX+"PRICEROW_Lª")
        {
         //---
         PriceRowLeft++;
         //---
         if(PriceRowLeft>=ArraySize(PriceRowLeftArr))//Reset
            PriceRowLeft=0;
         //---
         ObjectSetString(0,OBJPREFIX+"PRICEROW_Lª",OBJPROP_TEXT,0,PriceRowLeftArr[PriceRowLeft]);/*SetObject*/
         //---
         SetStatus("É","Switched to "+PriceRowLeftArr[PriceRowLeft]+" mode...");
         //---
         for(int i=0; i<ArraySize(newpairs); i++)
            ObjectSetString(0,OBJPREFIX+"PRICEROW_L"+" - "+newpairs[i],OBJPROP_TOOLTIP,PriceRowLeftArr[PriceRowLeft]+" "+newpairs[i]);
        }

      //--- Switch PriceRow Right
      if(sparam==OBJPREFIX+"PRICEROW_Rª")
        {
         //---
         PriceRowRight++;
         //---
         if(PriceRowRight>=ArraySize(PriceRowRightArr))//Reset
            PriceRowRight=0;
         //---
         ObjectSetString(0,OBJPREFIX+"PRICEROW_Rª",OBJPROP_TEXT,0,PriceRowRightArr[PriceRowRight]);/*SetObject*/
         //---
         SetStatus("Ê","Switched to "+PriceRowRightArr[PriceRowRight]+" mode...");
         //---
         for(int i=0; i<ArraySize(newpairs); i++)
            ObjectSetString(0,OBJPREFIX+"PRICEROW_R"+" - "+newpairs[i],OBJPROP_TOOLTIP,PriceRowRightArr[PriceRowRight]+" "+newpairs[i]);
        }

 
 
    
     }

//--- OnEdit
   if(id==CHARTEVENT_OBJECT_ENDEDIT)
     {
 
      //--- RRInpA
      double RRInpA=StringToDouble(ObjectGetString(0,OBJPREFIX+"RR<>",OBJPROP_TEXT));
      //---
      if(RRInpA<0.1)
        {
         ObjectSetString(0,OBJPREFIX+"RR<>",OBJPROP_TEXT,0,DoubleToString(0.1,2));/*SetObject*/
         RRInpA=0.1;
        }
      //---
      ObjectSetString(0,OBJPREFIX+"RR<>",OBJPROP_TEXT,0,DoubleToString(RRInpA,2));/*SetObject*/

      //---
  
      //---
      UserIsEditing=false;
     }
//----
  }
//+------------------------------------------------------------------+
//| _OnTester                                                        |
//+------------------------------------------------------------------+
void _OnTester()
  {
//---
   if(AccountFreeMarginCheck(_Symbol,OP_BUY,SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN))>=0)
     {
      double lots=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN);
      //---
      int tkt=OrderSend(_Symbol,OP_BUY,lots,SymbolInfoDouble(_Symbol,SYMBOL_ASK),0,0,0,NULL,0,0,clrNONE);
      //---
      if(tkt>0)
         int c_tkt=OrderClose(tkt,lots,SymbolInfoDouble(_Symbol,SYMBOL_BID),0,clrNONE);
     }
//---
  }
 
//+------------------------------------------------------------------+
//| ObjectsCreateAll                                                 |
//+------------------------------------------------------------------+
void ObjectsCreateAll()
  {
//---
   int fr_y2=Dpi2(140);
//---
   for(int i=0; i<ArraySize(newpairs); i++)
     {
      //---
      if(SelectedMode==FULL)
         fr_y2+=Dpi2(25);
      //---
      if(SelectedMode==COMPACT)
         fr_y2+=Dpi2(21);
      //---
      if(SelectedMode==MINI)
         fr_y2+=Dpi2(17);
     }
//---
   int x=150;//ChartMiddleX()-(Dpi2(CLIENT_BG_WIDTH)/2);
   int y=50;//ChartMiddleY()-(fr_y2/2);
//---
   int height=70;
//---

   RectLabelCreate(0,OBJPREFIX+"BCKGRND[]",0,x-140,y,Dpi2(CLIENT_BG_WIDTH)+130,height+(Pairs_N_page*20),COLOR_BG,BORDER_FLAT,CORNER_LEFT_UPPER,COLOR_BORDER,STYLE_SOLID,1,false,false,true,0,"\n");
   RectLabelCreate(0,OBJPREFIX+"BORDER[]",0,x-140,y,Dpi2(CLIENT_BG_WIDTH)+130,Dpi2(INDENT_TOP),COLOR_BORDER,BORDER_FLAT,CORNER_LEFT_UPPER,COLOR_BORDER,STYLE_SOLID,1,false,false,true,0,"\n");
  
   LabelCreate(0,OBJPREFIX+"Pages",0,x+50,y-10,CORNER_LEFT_UPPER,"Page "+IntegerToString(starter/Pairs_N_page,0,0)+"/"+IntegerToString(pages-1,0,0),"Arial Black",10,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
   ButtonCreate(0,OBJPREFIX+"pagbtn",0,x+130,y-22,70,20,CORNER_LEFT_UPPER,"Next page >","Trebuchet MS",8,C'59,41,40',C'160,192,255',C'144,176,239',false,false,false,true,1,"\n");
   ButtonCreate(0,OBJPREFIX+"pagbtn2",0,x-30,y-22,70,20,CORNER_LEFT_UPPER,"< Prev. page","Trebuchet MS",8,C'59,41,40',C'160,192,255',C'144,176,239',false,false,false,true,1,"\n");
   ButtonCreate(0,OBJPREFIX+"exportcsv",0,x-120,y-22,70,20,CORNER_LEFT_UPPER,"Export CSV","Trebuchet MS",10,clrBlack,clrRed,C'144,176,239',false,false,false,true,1,"\n");



   pages =(ArraySize(finalpairs)/Pairs_N_page)+1;


   _x1=(int)ObjectGetInteger(0,OBJPREFIX+"BCKGRND[]",OBJPROP_XDISTANCE);
   _y1=(int)ObjectGetInteger(0,OBJPREFIX+"BCKGRND[]",OBJPROP_YDISTANCE);
//---
//---
   LabelCreate(0,OBJPREFIX+"CAPTION",0,_x1+(Dpi2(CLIENT_BG_WIDTH)/2)-Dpi2(16),_y1,CORNER_LEFT_UPPER,ExpertName,"Arial Black",9,C'59,41,40',0,ANCHOR_UPPER,false,false,true,0,"\n");
 //---
   LabelCreate(0,OBJPREFIX+"EXIT",0,(_x1+Dpi2(CLIENT_BG_WIDTH))-Dpi2(10),_y1-Dpi2(2),CORNER_LEFT_UPPER,"r","Webdings",10,C'59,41,40',0,ANCHOR_UPPER,false,false,true,1,"\n",false);
//---
   LabelCreate(0,OBJPREFIX+"MINIMIZE",0,(_x1+Dpi2(CLIENT_BG_WIDTH))-Dpi2(30),_y1-Dpi2(2),CORNER_LEFT_UPPER,"2","Webdings",10,C'59,41,40',0,ANCHOR_UPPER,false,false,true,1,"\n",false);
//---
   LabelCreate(0,OBJPREFIX+" ",0,(_x1+Dpi2(CLIENT_BG_WIDTH))-Dpi2(50),_y1-Dpi2(2),CORNER_LEFT_UPPER,"s","Webdings",10,C'59,41,40',0,ANCHOR_UPPER,false,false,true,1,"\n",false);
//---
   LabelCreate(0,OBJPREFIX+"TIME",0,(_x1+Dpi2(CLIENT_BG_WIDTH))-Dpi2(85),_y1+Dpi2(1),CORNER_LEFT_UPPER,TimeToString(0,TIME_SECONDS),"Tahoma",8,C'59,41,40',0,ANCHOR_UPPER,false,false,true,1,"Local Time",false);
   LabelCreate(0,OBJPREFIX+"TIME§",0,(_x1+Dpi2(CLIENT_BG_WIDTH))-Dpi2(120),_y1,CORNER_LEFT_UPPER,"Â","Wingdings",12,C'59,41,40',0,ANCHOR_UPPER,false,false,true,1,"Local Time",false);
//---
   LabelCreate(0,OBJPREFIX+"CONNECTION",0,_x1+Dpi2(15),_y1-Dpi2(2),CORNER_LEFT_UPPER,"ü","Webdings",10,C'59,41,40',0,ANCHOR_UPPER,false,false,true,0,"Connection",false);
//---
   LabelCreate(0,OBJPREFIX+"THEME",0,_x1+Dpi2(40),_y1-Dpi2(4),CORNER_LEFT_UPPER,"N","Webdings",15,C'59,41,40',0,ANCHOR_UPPER,false,false,true,1,"Theme",false);
//---
   LabelCreate(0,OBJPREFIX+"TEMPLATE",0,_x1+Dpi2(65),_y1-Dpi2(2),CORNER_LEFT_UPPER,"+","Webdings",12,C'59,41,40',0,ANCHOR_UPPER,false,false,true,1,"Background",false);
//---
   int middle=Dpi2(CLIENT_BG_WIDTH/2);
//---
   LabelCreate(0,OBJPREFIX+"STATUS",0,_x1+middle+(middle/2),_y1+Dpi2(8),CORNER_LEFT_UPPER,"\n","Wingdings",10,C'59,41,40',0,ANCHOR_LEFT,false,false,true,1,"\n",false);
//---
   LabelCreate(0,OBJPREFIX+"STATUS«",0,_x1+middle+(middle/2)+Dpi2(15),_y1+Dpi2(8),CORNER_LEFT_UPPER,"\n",sFontType,8,C'59,41,40',0,ANCHOR_LEFT,false,false,true,1,"\n",false);
//---
   LabelCreate(0,OBJPREFIX+"SOUND",0,_x1+Dpi2(90),_y1-Dpi2(2),CORNER_LEFT_UPPER,"X","Webdings",12,C'59,41,40',0,ANCHOR_UPPER,false,false,true,1,"Sounds",false);
//---
   color soundclr=SoundIsEnabled?C'59,41,40':clrNONE;
//---
   LabelCreate(0,OBJPREFIX+"SOUNDIO",0,_x1+Dpi2(100),_y1-Dpi2(1),CORNER_LEFT_UPPER,"ð","Webdings",10,soundclr,0,ANCHOR_UPPER,false,false,true,1,"Sounds",false);
//---
   LabelCreate(0,OBJPREFIX+"ALARM",0,_x1+Dpi2(115),_y1-Dpi2(1),CORNER_LEFT_UPPER,"%","Wingdings",12,C'59,41,40',0,ANCHOR_UPPER,false,false,true,1,"Alerts",false);
//---
   color alarmclr=AlarmIsEnabled?clrNONE:C'59,41,40';
//---
   if(!_Alert && !Push && !Mail)
      alarmclr=C'59,41,40';
//---
   LabelCreate(0,OBJPREFIX+"ALARMIO",0,_x1+Dpi2(115),_y1-Dpi2(6),CORNER_LEFT_UPPER,"x",sFontType,16,alarmclr,0,ANCHOR_UPPER,false,false,true,1,"Alerts",false);
//---
   int csm_fr_x1=_x1+Dpi2(50);
   int csm_fr_x2=_x1+Dpi2(95);
   int csm_fr_x3=_x1+Dpi2(137);
   int csm_dist_b=Dpi2(150);
 
   LabelCreate(0,OBJPREFIX+"BALANCE«",0,_x1+Dpi2(300),_y1+Dpi2(8),CORNER_LEFT_UPPER,DoubleToStr(AccountBalance(),2),sFontType,8,C'59,41,40',0,ANCHOR_CENTER,false,false,true,0,"\n");
//---

   color autosl=AutoSL?COLOR_AUTO:COLOR_FONT;
   color autotp=AutoTP?COLOR_AUTO:COLOR_FONT;
   color autolots=AutoLots?COLOR_AUTO:COLOR_FONT;
//---
  
   int fr_y=_y1+Dpi2(95);

 
   LabelCreate(0,OBJPREFIX+"x--",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1180,_y1+40,CORNER_LEFT_UPPER,"--------------------","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"x--2",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1100,_y1+40,CORNER_LEFT_UPPER,"-------------------------","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"x--3",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1000,_y1+40,CORNER_LEFT_UPPER,"-------------------------","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"x--4",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-900,_y1+40,CORNER_LEFT_UPPER,"--------------------------","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"x--5",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-800,_y1+40,CORNER_LEFT_UPPER,"--------------------------","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"x--6",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-700,_y1+40,CORNER_LEFT_UPPER,"--------------------------","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"x--7",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-600,_y1+40,CORNER_LEFT_UPPER,"--------------------------","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"x--8",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-500,_y1+40,CORNER_LEFT_UPPER,"--------------------------","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"x--9",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-400,_y1+40,CORNER_LEFT_UPPER,"--------------------------","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"x--10",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-300,_y1+40,CORNER_LEFT_UPPER,"--------------------------","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"x--11",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-200,_y1+40,CORNER_LEFT_UPPER,"--------------------------","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"x--12",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-100,_y1+40,CORNER_LEFT_UPPER,"--------------------------","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"x--13",0,_x1+ Dpi2(CLIENT_BG_WIDTH),_y1+40,CORNER_LEFT_UPPER,    "--------------------------","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"x--14",0,_x1+ Dpi2(CLIENT_BG_WIDTH)+100,_y1+40,CORNER_LEFT_UPPER,"-------","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");

   for(int i=0; i<ArraySize(currentpage); i++)
     {
 
      string pairs;
      CreateSymbGUI(Prefix+currentpage[i]+Suffix,_y1+60+(i*20));

      pairs =Prefix+currentpage[i]+Suffix;
      LabelCreate(0,OBJPREFIX+"ltv_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-925,_y1+60+(i*20),CORNER_LEFT_UPPER, DoubleToStr(iClose(pairs,0,0),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");

      if(sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100 >=BuyLevel)
        {
         LabelCreate(0,OBJPREFIX+"str1_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-840,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrLime,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }
      if(sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100 <=SellLevel)
        {
         LabelCreate(0,OBJPREFIX+"str1_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-840,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrOrchid,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }
        
     if(sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100>SellLevel && sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100<BuyLevel)
        {
         LabelCreate(0,OBJPREFIX+"str1_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-840,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrYellow,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }

      if(sigma1_value(pairs , Strength_Bar2,iClose(pairs,0,0))*100>=BuyLevel)
        {
         LabelCreate(0,OBJPREFIX+"str2_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-760,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar2,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrLime,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }
      if(sigma1_value(pairs , Strength_Bar2,iClose(pairs,0,0))*100<=SellLevel)
        {
         LabelCreate(0,OBJPREFIX+"str2_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-760,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar2,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrOrchid,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }

 if(sigma1_value(pairs , Strength_Bar2,iClose(pairs,0,0))*100>SellLevel &&sigma1_value(pairs , Strength_Bar2,iClose(pairs,0,0))*100<BuyLevel)
        {
         LabelCreate(0,OBJPREFIX+"str2_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-760,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar2,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrYellow,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }

      if(sigma1_value(pairs , Strength_Bar3,iClose(pairs,0,0))*100>=BuyLevel)
        {
         LabelCreate(0,OBJPREFIX+"str3_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-680,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar3,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrLime,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }
      if(sigma1_value(pairs , Strength_Bar3,iClose(pairs,0,0))*100<=SellLevel)
        {
         LabelCreate(0,OBJPREFIX+"str3_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-680,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar3,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrOrchid,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }

  if(sigma1_value(pairs , Strength_Bar3,iClose(pairs,0,0))*100>SellLevel && sigma1_value(pairs , Strength_Bar3,iClose(pairs,0,0))*100<BuyLevel)
        {
         LabelCreate(0,OBJPREFIX+"str3_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-680,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar3,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrYellow,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }
      LabelCreate(0,OBJPREFIX+"sup3_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-605,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sup(Strength_Bar1,pairs,3),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
      LabelCreate(0,OBJPREFIX+"sup2_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-540,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sup(Strength_Bar1,pairs,2),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
      LabelCreate(0,OBJPREFIX+"sup1_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-465,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sup(Strength_Bar1,pairs,1),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
      if(iClose(pairs,0,0)<iMA(pairs,0,Strength_Bar1,0,0,0,0))
        {
         LabelCreate(0,OBJPREFIX+"pivot_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-395,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(iMA(pairs,0,Strength_Bar1,0,0,0,1),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,clrOrchid,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }
      if(iClose(pairs,0,0)>iMA(pairs,0,Strength_Bar1,0,0,0,0))
        {
         LabelCreate(0,OBJPREFIX+"pivot_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-390,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(iMA(pairs,0,Strength_Bar1,0,0,0,1),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,clrLime,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }
      LabelCreate(0,OBJPREFIX+"res1_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-320,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(res(Strength_Bar1,pairs,1),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
      LabelCreate(0,OBJPREFIX+"res2_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-255,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(res(Strength_Bar1,pairs,2),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
      LabelCreate(0,OBJPREFIX+"res3_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-180,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(res(Strength_Bar1,pairs,3),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
      LabelCreate(0,OBJPREFIX+"high_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-120,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(MathMax(iHigh(pairs,PERIOD_M1,1), iHigh(pairs,0,iHighest(pairs,0,MODE_HIGH,Strength_Bar1,0))),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
      LabelCreate(0,OBJPREFIX+"low_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-40,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(MathMin(iLow(pairs,PERIOD_M1,1),iLow(pairs,0,iLowest(pairs,0,MODE_LOW,Strength_Bar1,0))),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");


      if(iLow(pairs,PERIOD_M1,1)==iLow(pairs,0,iLowest(pairs,0,MODE_LOW,Strength_Bar1,0)) && iClose(pairs,PERIOD_M1,1)>iLow(pairs,0,iLowest(pairs,0,MODE_LOW,Strength_Bar1,0)) && sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100<=1)
        {
         LabelCreate(0,OBJPREFIX+"signal_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1110,_y1+60+(i*20),CORNER_LEFT_UPPER,"Buy",sFontType,FONTSIZE,clrLime,0,ANCHOR_CENTER,false,false,true,0,"\n");
         LabelCreate(0,OBJPREFIX+"signal_p"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1010,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(iClose(pairs,0,0),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
         LabelCreate(0,OBJPREFIX+"signal_t"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)+50 ,_y1+60+(i*20),CORNER_LEFT_UPPER, TimeToStr(iTime(pairs,0,0),TIME_DATE|TIME_MINUTES),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
        // LabelCreate(0,OBJPREFIX+"signal_a"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)+130,_y1+60+(i*20),CORNER_LEFT_UPPER, "ى","Wingdings",FONTSIZE,clrLime,0,ANCHOR_LEFT,false,false,true,0,"\n");
          
        }
      else
         if(iHigh(pairs,PERIOD_M1,1)==iHigh(pairs,0,iHighest(pairs,0,MODE_HIGH,Strength_Bar1,0)) && iClose(pairs,PERIOD_M1,1)<iHigh(pairs,0,iHighest(pairs,0,MODE_HIGH,Strength_Bar1,0)) && sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100>=99)
           {
            LabelCreate(0,OBJPREFIX+"signal_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1110,_y1+60+(i*20),CORNER_LEFT_UPPER,"Sell",sFontType,FONTSIZE,clrOrchid,0,ANCHOR_CENTER,false,false,true,0,"\n");
            LabelCreate(0,OBJPREFIX+"signal_p"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1010,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(iClose(pairs,0,0),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
            LabelCreate(0,OBJPREFIX+"signal_t"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)+50 ,_y1+60+(i*20),CORNER_LEFT_UPPER, TimeToStr(iTime(pairs,0,0),TIME_DATE|TIME_MINUTES),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
            //LabelCreate(0,OBJPREFIX+"signal_a"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)+130,_y1+60+(i*20),CORNER_LEFT_UPPER, "ي","Wingdings",FONTSIZE,clrOrchid,0,ANCHOR_LEFT,false,false,true,0,"\n");
            

           }
         else
           {
            LabelCreate(0,OBJPREFIX+"signal_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1110,_y1+60+(i*20),CORNER_LEFT_UPPER, "No Signal",sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
            LabelCreate(0,OBJPREFIX+"signal_p"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1010,_y1+60+(i*20),CORNER_LEFT_UPPER, "No Price",sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
            LabelCreate(0,OBJPREFIX+"signal_t"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)+50 ,_y1+60+(i*20),CORNER_LEFT_UPPER, "No Time",sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
         //   LabelCreate(0,OBJPREFIX+"signal_a"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)+130,_y1+60+(i*20),CORNER_LEFT_UPPER, "No Arrow",sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");

           }

      //}
      //---
      if(SelectedMode==FULL)
         fr_y+=Dpi2(25);
      //---
      if(SelectedMode==COMPACT)
         fr_y+=Dpi2(21);
      //---
      if(SelectedMode==MINI)
         fr_y+=Dpi2(17);


     }

   LabelCreate(0,OBJPREFIX+"SCRIP",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1180,_y1+30,CORNER_LEFT_UPPER,"SCRIP :","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"b/s",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1110,_y1+30,CORNER_LEFT_UPPER,"Buy/Sell  ","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"sp",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1030,_y1+30,CORNER_LEFT_UPPER,"Signal Price","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"ltp",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-920,_y1+30,CORNER_LEFT_UPPER,"LTP","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");

   LabelCreate(0,OBJPREFIX+"str1",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-850,_y1+30,CORNER_LEFT_UPPER,"Strength 1","Arial Black",9,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"str2",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-775,_y1+30,CORNER_LEFT_UPPER,"Strength 2","Arial Black",9,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"str3",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-695,_y1+30,CORNER_LEFT_UPPER,"Strength 3","Arial Black",9,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");

   LabelCreate(0,OBJPREFIX+"sup3",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-600,_y1+30,CORNER_LEFT_UPPER,"Sup 3","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"sup2",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-530,_y1+30,CORNER_LEFT_UPPER,"Sup 2","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"sup1",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-460,_y1+30,CORNER_LEFT_UPPER,"Sup 1","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"pivot",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-390,_y1+30,CORNER_LEFT_UPPER,"Pivot","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");

   LabelCreate(0,OBJPREFIX+"res1",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-320,_y1+30,CORNER_LEFT_UPPER,"Res 1","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"res2",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-250,_y1+30,CORNER_LEFT_UPPER,"Res 2","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"res3",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-180,_y1+30,CORNER_LEFT_UPPER,"Res 3","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");

   LabelCreate(0,OBJPREFIX+"hi",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-110,_y1+30,CORNER_LEFT_UPPER,"High","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   LabelCreate(0,OBJPREFIX+"low",0,_x1+ Dpi2(CLIENT_BG_WIDTH)-40,_y1+30,CORNER_LEFT_UPPER,"Low","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");

   LabelCreate(0,OBJPREFIX+"sigtime",0,_x1+ Dpi2(CLIENT_BG_WIDTH)+30,_y1+30,CORNER_LEFT_UPPER,"Signal Time","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");
   //LabelCreate(0,OBJPREFIX+"trend",0,_x1+ Dpi2(CLIENT_BG_WIDTH)+130,_y1+30,CORNER_LEFT_UPPER,"Trend","Arial Black",10,clrWhite,0,ANCHOR_LEFT,false,false,false,0,"\n");



  }
//+------------------------------------------------------------------+
//| CreateSymbGUI                                                    |
//+------------------------------------------------------------------+
void CreateSymbGUI(string _Symb,int Y)
  {
//---

   color startcolor=FirstRun?clrNONE:COLOR_FONT;
//---
   LabelCreate(0,OBJPREFIX+_Symb,0,_x1+Dpi2(10),Y,CORNER_LEFT_UPPER,StringSubstr(_Symb,StringLen(Prefix),6)+":",sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");



   int fr_x=Dpi2(330);
//---
   for(int i=0; i<10; i++)
     {
      //LabelCreate(0,OBJPREFIX+"SPEED#"+" - "+_Symb+IntegerToString(i),0,_x1+fr_x,Y,CORNER_LEFT_UPPER,"l","Arial Black",12,clrNONE,0.0,ANCHOR_RIGHT,false,false,true,0);
      fr_x-=Dpi2(5);
     }
//---
   double bid=MarketInfo(_Symb,MODE_BID);
//---
   int digits=(int)MarketInfo(_Symb,MODE_DIGITS);

//--- KeyboardTrading
   if(ShowTradePanel)
     {
      //---
      if(true)
        {
         //---
         if(_Symb==_Symbol)
           {
            //---
            if(ObjectFind(0,OBJPREFIX+"MARKER")!=0)
               LabelCreate(0,OBJPREFIX+"MARKER",0,_x1+Dpi2(10),Y+Dpi2(5),CORNER_LEFT_UPPER,"_______",sFontType,FONTSIZE,COLOR_MARKER,0,ANCHOR_LEFT,false,false,true,0,"\n");
            else
              {
               //---
               if(ObjectGetInteger(0,OBJPREFIX+"MARKER",OBJPROP_YDISTANCE,0)!=Y+Dpi2(5))
                  ObjectDelete(0,OBJPREFIX+"MARKER");
              }
           }
        }
      else
        {
         //---
         if(ObjectFind(0,OBJPREFIX+"MARKER")==0)
            ObjectDelete(0,OBJPREFIX+"MARKER");
        }
     }
//---
  }
//+------------------------------------------------------------------+
//| CreateProBar                                                     |
//+------------------------------------------------------------------+
void CreateProBar(string _Symb,int x,int y)
  {
//---
   int fr_y_pb=y;
//---
   for(int i=1; i<11; i++)
     {
      LabelCreate(0,OBJPREFIX+"PB#"+IntegerToString(i)+" - "+_Symb,0,x,fr_y_pb,CORNER_LEFT_UPPER,"0","Webdings",25,clrNONE,0,ANCHOR_RIGHT,false,false,true,0,"\n");
      fr_y_pb-=Dpi2(5);
     }
//---
  }
 
//+------------------------------------------------------------------+
//| CreateMinWindow                                                  |
//+------------------------------------------------------------------+
void CreateMinWindow()
  {
//---
   RectLabelCreate(0,OBJPREFIX+"MIN"+"BCKGRND[]",0,Dpi2(1),Dpi2(20),Dpi2(163),Dpi2(25),COLOR_BORDER,BORDER_FLAT,CORNER_LEFT_LOWER,COLOR_BORDER,STYLE_SOLID,1,false,false,true,0,"\n");
//---
   LabelCreate(0,OBJPREFIX+"MIN"+"CAPTION",0,Dpi2(140)-Dpi2(64),Dpi2(18),CORNER_LEFT_LOWER,"MultiTrader","Arial Black",8,C'59,41,40',0,ANCHOR_UPPER,false,false,true,0,"\n",false);
//---
   LabelCreate(0,OBJPREFIX+"MIN"+"MAXIMIZE",0,Dpi2(156),Dpi2(23),CORNER_LEFT_LOWER,"1","Webdings",10,C'59,41,40',0,ANCHOR_UPPER,false,false,true,0,"\n",false);
//---
  }
//+------------------------------------------------------------------+
//| DelteMinWindow                                                   |
//+------------------------------------------------------------------+
void DelteMinWindow()
  {
//---
   ObjectDelete(0,OBJPREFIX+"MIN"+"BCKGRND[]");
   ObjectDelete(0,OBJPREFIX+"MIN"+"CAPTION");
   ObjectDelete(0,OBJPREFIX+"MIN"+"MAXIMIZE");
//---
  }
 
//+------------------------------------------------------------------+
//| UpdateSymbolGUI                                                  |
//+------------------------------------------------------------------+
void ObjectsUpdateAll(string _Symb)
  {
//--- Market info
   double bid=MarketInfo(_Symb,MODE_BID),ask=MarketInfo(_Symb,MODE_ASK),avg=(ask+bid)/2;
//---
   double TFHigh=iHigh(_Symb,CalcTF,0),TFLow=iLow(_Symb,CalcTF,0),TFOpen=iOpen(_Symb,CalcTF,0);
//---
   double TFLastHigh=iHigh(_Symb,CalcTF,1),TFLastLow=iLow(_Symb,CalcTF,1),TFLastClose=iClose(_Symb,CalcTF,1);
//---
   long Spread=SymbolInfoInteger(_Symb,SYMBOL_SPREAD);
   int digits = (int)MarketInfo(_Symb,MODE_DIGITS);

 
//--- Range
   double pts=MarketInfo(_Symb,MODE_POINT);
//---
   double range=0;
//---
   if(pts!=0)
      range=(TFHigh-TFLow)/pts;

//--- SetRange
 
//---
  
//--- Spread
   ObjectSetString(0,OBJPREFIX+"SPREAD"+" - "+_Symb,OBJPROP_TEXT,DoubleToString(MarketInfo(_Symb,MODE_SPREAD),0)+"p");

//---
   if(Spread>=100)
      ObjectSetInteger(0,OBJPREFIX+"SPREAD"+" - "+_Symb,OBJPROP_COLOR,clrOrangeRed);
   else
      ObjectSetInteger(0,OBJPREFIX+"SPREAD"+" - "+_Symb,OBJPROP_COLOR,COLOR_FONT);

 
//---
   color COLOR_HEDGE=(SelectedTheme==0)?clrDarkOrange:clrGold;
 
//--- Get Currencies
 
//---
   double symbol_r=SymbPerc(_Symb);

//--- Percent
   ObjectSetString(0,OBJPREFIX+"RANGE%"+" - "+_Symb,OBJPROP_TEXT,DoubleToString(SymbPerc(_Symb),0)+"%");
   ObjectSetInteger(0,OBJPREFIX+_Symb,OBJPROP_COLOR,COLOR_FONT);
   ObjectSetInteger(0,OBJPREFIX+"RANGE%"+" - "+_Symb,OBJPROP_COLOR,COLOR_FONT);

//- 
//---
   
 
 
 
//---
  }
 
 
 
//+------------------------------------------------------------------+
//| GetParam                                                         |
//+------------------------------------------------------------------+
void GetParam(string p)
  {
//---
   if(p==OBJPREFIX+" ")
     {
      //---
      double pVal=TerminalInfoInteger(TERMINAL_PING_LAST);
      //---
      MessageBox
      (
         //---
         dString("99A6D43B833CB976021189ABAEEACF5D")+AccountInfoString(ACCOUNT_NAME)
         +"\n"+
         dString("47D4F60E4272BE70FB300EB05BD2AEC9")+IntegerToString(AccountInfoInteger(ACCOUNT_LOGIN))
         +"\n"+
         dString("83744D48C2D63F90DD2F812DBB5CFC0C")+IntegerToString(AccountInfoInteger(ACCOUNT_LEVERAGE))
         +"\n\n"+
         //---
         dString("B001C36F24DDD87AFB300EB05BD2AEC9")+AccountInfoString(ACCOUNT_COMPANY)
         +"\n"+
         dString("808FEF727352434E021189ABAEEACF5D")+AccountInfoString(ACCOUNT_SERVER)
         +"\n"+
         dString("70FA849373E41928")+DoubleToString(pVal/1000,2)+dString("CDB9155CB6080FC4")
         +"\n\n"+
         //---
         dString("47EFF8FADDDA4F05FB300EB05BD2AEC9")+dString("97BA10D5D76C54AE")
         +"\n\n"+
         dString("7823F8858C13A39B7CC5A7EC4F40E381")
         +"\n"+
         dString("3D1E8ABC29DB2E92F1B07FD9CB96A45738FCA32595840B48C24BEEC18191F150087C9AFD999E487F")
         +"\n\n"+
         dString("589AC65F2BB83753")
         +"\n"+
         dString("3D1E8ABC29DB2E92F1B07FD9CB96A45738FCA32595840B4801D4FEEBA49183BD6314E740BF3EB954")
         //---
         ,MB_CAPTION,MB_ICONINFORMATION|MB_OK
      );
     }
//---
  }
//+------------------------------------------------------------------+
//| GetSetInputsA                                                    |
//+------------------------------------------------------------------+
void GetSetInputsA()
  {
//---
   double balance=AccountInfoDouble(ACCOUNT_BALANCE);

//---
   if(StringToDouble(ObjectGetString(0,OBJPREFIX+"RISK%<>",OBJPROP_TEXT))-RiskInpP!=0)
     {
      //---
      RiskC=(balance/100)*StringToDouble(ObjectGetString(0,OBJPREFIX+"RISK%<>",OBJPROP_TEXT));
      //---
      if(!UserIsEditing)
         ObjectSetString(0,OBJPREFIX+"RISK$<>",OBJPROP_TEXT,0,DoubleToString(RiskC,2));/*SetObject*/
      //---
      RiskInpP=StringToDouble(ObjectGetString(0,OBJPREFIX+"RISK%<>",OBJPROP_TEXT));
     }

//---
   if(StringToDouble(ObjectGetString(0,OBJPREFIX+"RISK$<>",OBJPROP_TEXT))-RiskInpC!=0)
     {
      //---
      if(balance!=0)
         RiskP=StringToDouble(ObjectGetString(0,OBJPREFIX+"RISK$<>",OBJPROP_TEXT))*100/balance;
      //---
      if(!UserIsEditing)
         ObjectSetString(0,OBJPREFIX+"RISK%<>",OBJPROP_TEXT,0,DoubleToString(RiskP,2));/*SetObject*/
      //---
      RiskInpC=StringToDouble(ObjectGetString(0,OBJPREFIX+"RISK$<>",OBJPROP_TEXT));
     }

//---
   if(RiskInpP<0.01)
      if(!UserIsEditing)
         ObjectSetString(0,OBJPREFIX+"RISK%<>",OBJPROP_TEXT,0,DoubleToString(0.01,2));/*SetObject*/

//---
   if(RiskInpC<=0)
      if(!UserIsEditing)
         ObjectSetString(0,OBJPREFIX+"RISK$<>",OBJPROP_TEXT,0,DoubleToString(0.01,2));/*SetObject*/
//---
  } 
  
      
double SymbPerc(string _Symb)
  {
//---
   double percent=0,range=iHigh(_Symb,CalcTF,0)-iLow(_Symb,CalcTF,0);
//---
   if(range!=0)
      percent=100*((iClose(_Symb,CalcTF,0)-iLow(_Symb,CalcTF,0))/range);
//---
   return(percent);
  }
//+------------------------------------------------------------------+
//| ±Str                                                             |
//+------------------------------------------------------------------+
string ±Str(double Inp,int Precision)
  {
//--- PositiveValue
   if(Inp>0)
      return("+"+DoubleToString(Inp,Precision));
//--- NegativeValue
   else
      return(DoubleToString(Inp,Precision));
//---
  }
//+------------------------------------------------------------------+
//| ±Clr                                                             |
//+------------------------------------------------------------------+
color ±Clr(double Inp)
  {
//---
   color clr=clrNONE;
//--- PositiveValue
   if(Inp>0)
      clr=COLOR_GREEN;
//--- NegativeValue
   if(Inp<0)
      clr=COLOR_RED;
//--- NeutralValue
   if(Inp==0)
      clr=COLOR_FONT;
//---
   return(clr);
  }
//+------------------------------------------------------------------+
//| ±ClrBR                                                           |
//+------------------------------------------------------------------+
color ±ClrBR(double Inp)
  {
//---
   color clr=clrNONE;
//--- PositiveValue
   if(Inp>0)
      clr=COLOR_BUY;
//--- NegativeValue
   if(Inp<0)
      clr=COLOR_SELL;
//--- NeutralValue
   if(Inp==0)
      clr=COLOR_FONT;
//---
   return(clr);
  }
//+------------------------------------------------------------------+
//| Deposits                                                         |
//+------------------------------------------------------------------+
 
//+------------------------------------------------------------------+
//| _AccountCurrency                                                 |
//+------------------------------------------------------------------+
string _AccountCurrency()
  {
//---
   string txt="";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="AUD")
      txt="$";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="BGN")
      txt="B";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="CAD")
      txt="$";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="CHF")
      txt="F";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="COP")
      txt="$";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="CRC")
      txt="₡";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="CUP")
      txt="₱";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="CZK")
      txt="K";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="EUR")
      txt="€";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="GBP")
      txt="£";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="GHS")
      txt="¢";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="HKD")
      txt="$";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="JPY")
      txt="¥";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="NGN")
      txt="₦";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="NOK")
      txt="k";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="NZD")
      txt="$";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="USD")
      txt="$";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="RUB")
      txt="₽";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="SGD")
      txt="$";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="ZAR")
      txt="R";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="SEK")
      txt="k";
//---
   if(AccountInfoString(ACCOUNT_CURRENCY)=="VND")
      txt="₫";
//---
   if(txt=="")
      txt="$";
//---
   return(txt);
  } 
//+------------------------------------------------------------------+
//| PriceByTkt                                                       |
//+------------------------------------------------------------------+
double PriceByTkt(const int Type,const int Ticket)
  {
//---
   double price=0;
//---
   if(OrderSelect(Ticket,SELECT_BY_TICKET,MODE_TRADES))
     {
      //---
      if(Type==OPENPRICE)
         price=OrderOpenPrice();
      //---
      if(Type==CLOSEPRICE)
         price=OrderClosePrice();
     }
//---
   return(price);
  }
//+------------------------------------------------------------------+
//| SymbolFind                                                       |
//+------------------------------------------------------------------+
bool SymbolFind(const string _Symb,int mode)
  {
//---
   bool result=false;
//---
   for(int i=0; i<SymbolsTotal(mode); i++)
     {
      //---
      if(_Symb==SymbolName(i,mode))
        {
         result=true;//SymbolFound
         break;
        }
     }
//---
   return(result);
  } 
//+------------------------------------------------------------------+
//| SetStatus                                                        |
//+------------------------------------------------------------------+
void SetStatus(string Char,string Text)
  {
//---
   Comment("");
//---
   stauts_time=TimeLocal();
//---
   ObjectSetString(0,OBJPREFIX+"STATUS",OBJPROP_TEXT,Char);
   ObjectSetString(0,OBJPREFIX+"STATUS«",OBJPROP_TEXT,Text);
//---
  }
//+------------------------------------------------------------------+
//| ResetStatus                                                      |
//+------------------------------------------------------------------+
void ResetStatus()
  {
//---
   if(ObjectGetString(0,OBJPREFIX+"STATUS",OBJPROP_TEXT)!="\n" || ObjectGetString(0,OBJPREFIX+"STATUS«",OBJPROP_TEXT)!="\n")
     {
      ObjectSetString(0,OBJPREFIX+"STATUS",OBJPROP_TEXT,"\n");
      ObjectSetString(0,OBJPREFIX+"STATUS«",OBJPROP_TEXT,"\n");
     }
//---
  }
//+------------------------------------------------------------------+
//| Dpi                                                              |
//+------------------------------------------------------------------+
int Dpi(int Size)
  {
//---
   int screen_dpi=TerminalInfoInteger(TERMINAL_SCREEN_DPI);
   int base_width=Size;
   int width=(base_width*screen_dpi)/96;
   int scale_factor=(TerminalInfoInteger(TERMINAL_SCREEN_DPI)*100)/96;
//---
   width=(base_width*scale_factor)/100;
//---
   return(width);
  }
  
  int Dpi2(int Size)
  {
 
   return(Size);
  }
//+------------------------------------------------------------------+
//| dString                                                          |
//+------------------------------------------------------------------+
string dString(string text)
  {
//---
   uchar in[],out[],key[];
//---
   StringToCharArray("H+#eF_He",key);
//---
   StringToCharArray(text,in,0,StringLen(text));
//---
   HexToArray(text,in);
//---
   CryptDecode(CRYPT_DES,in,key,out);
//---
   string result=CharArrayToString(out);
//---
   return(result);
  }
//+------------------------------------------------------------------+
//| HexToArray                                                       |
//+------------------------------------------------------------------+
bool HexToArray(string str,uchar &arr[])
  {
//--- By Andrew Sumner & Alain Verleyen
//--- https://www.mql5.com/en/forum/157839/page3
#define HEXCHAR_TO_DECCHAR(h) (h<=57?(h-48):(h-55))
//---
   int strcount = StringLen(str);
   int arrcount = ArraySize(arr);
   if(arrcount < strcount / 2)
      return false;
//---
   uchar tc[];
   StringToCharArray(str,tc);
//---
   int i=0,j=0;
//---
   for(i=0; i<strcount; i+=2)
     {
      //---
      uchar tmpchr=(HEXCHAR_TO_DECCHAR(tc[i])<<4)+HEXCHAR_TO_DECCHAR(tc[i+1]);
      //---
      arr[j]=tmpchr;
      j++;
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| ArrayToHex                                                       |
//+------------------------------------------------------------------+
//--- By Andrew Sumner & Alain Verleyen
//--- https://www.mql5.com/en/forum/157839/page3
string ArrayToHex(uchar &arr[],int count=-1)
  {
   string res="";
//---
   if(count<0 || count>ArraySize(arr))
      count=ArraySize(arr);
//---
   for(int i=0; i<count; i++)
      res+=StringFormat("%.2X",arr[i]);
//---
   return(res);
  }
//+------------------------------------------------------------------+
//|  ChartSetColor                                                   |
//+------------------------------------------------------------------+
void ChartSetColor(const int Type)
  {
//--- Set Light
   if(Type==0)
     {
      ChartSetInteger(0,CHART_COLOR_BACKGROUND,COLOR_CBG_LIGHT);
      ChartSetInteger(0,CHART_COLOR_FOREGROUND,COLOR_FONT);
      ChartSetInteger(0,CHART_COLOR_GRID,clrNONE);
      ChartSetInteger(0,CHART_COLOR_CHART_UP,COLOR_CBG_LIGHT);
      ChartSetInteger(0,CHART_COLOR_CHART_DOWN,COLOR_CBG_LIGHT);
      ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,COLOR_CBG_LIGHT);
      ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,COLOR_CBG_LIGHT);
      ChartSetInteger(0,CHART_COLOR_CHART_LINE,COLOR_CBG_LIGHT);
      ChartSetInteger(0,CHART_COLOR_VOLUME,COLOR_CBG_LIGHT);
      ChartSetInteger(0,CHART_COLOR_ASK,clrNONE);
      ChartSetInteger(0,CHART_COLOR_STOP_LEVEL,COLOR_CBG_LIGHT);
      //---
      ChartSetInteger(0,CHART_SHOW_OHLC,false);
      ChartSetInteger(0,CHART_SHOW_ASK_LINE,false);
      ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,false);
      ChartSetInteger(0,CHART_SHOW_GRID,false);
      ChartSetInteger(0,CHART_SHOW_VOLUMES,false);
      ChartSetInteger(0,CHART_SHOW_OBJECT_DESCR,false);
      ChartSetInteger(0,CHART_SHOW_TRADE_LEVELS,false);
     }

//--- Set Dark
   if(Type==1)
     {
      ChartSetInteger(0,CHART_COLOR_BACKGROUND,COLOR_CBG_DARK);
      ChartSetInteger(0,CHART_COLOR_FOREGROUND,COLOR_FONT);
      ChartSetInteger(0,CHART_COLOR_GRID,clrNONE);
      ChartSetInteger(0,CHART_COLOR_CHART_UP,COLOR_CBG_DARK);
      ChartSetInteger(0,CHART_COLOR_CHART_DOWN,COLOR_CBG_DARK);
      ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,COLOR_CBG_DARK);
      ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,COLOR_CBG_DARK);
      ChartSetInteger(0,CHART_COLOR_CHART_LINE,COLOR_CBG_DARK);
      ChartSetInteger(0,CHART_COLOR_VOLUME,COLOR_CBG_DARK);
      ChartSetInteger(0,CHART_COLOR_ASK,clrNONE);
      ChartSetInteger(0,CHART_COLOR_STOP_LEVEL,COLOR_CBG_DARK);
      //---
      ChartSetInteger(0,CHART_SHOW_OHLC,false);
      ChartSetInteger(0,CHART_SHOW_ASK_LINE,false);
      ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,false);
      ChartSetInteger(0,CHART_SHOW_GRID,false);
      ChartSetInteger(0,CHART_SHOW_VOLUMES,false);
      ChartSetInteger(0,CHART_SHOW_OBJECT_DESCR,false);
      ChartSetInteger(0,CHART_SHOW_TRADE_LEVELS,false);
     }

//--- Set Original
   if(Type==2)
     {
      ChartSetInteger(0,CHART_COLOR_BACKGROUND,ChartColor_BG);
      ChartSetInteger(0,CHART_COLOR_FOREGROUND,ChartColor_FG);
      ChartSetInteger(0,CHART_COLOR_GRID,ChartColor_GD);
      ChartSetInteger(0,CHART_COLOR_CHART_UP,ChartColor_UP);
      ChartSetInteger(0,CHART_COLOR_CHART_DOWN,ChartColor_DWN);
      ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,ChartColor_BULL);
      ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,ChartColor_BEAR);
      ChartSetInteger(0,CHART_COLOR_CHART_LINE,ChartColor_LINE);
      ChartSetInteger(0,CHART_COLOR_VOLUME,ChartColor_VOL);
      ChartSetInteger(0,CHART_COLOR_ASK,ChartColor_ASK);
      ChartSetInteger(0,CHART_COLOR_STOP_LEVEL,ChartColor_LVL);
      //---
      ChartSetInteger(0,CHART_SHOW_OHLC,ChartColor_OHLC);
      ChartSetInteger(0,CHART_SHOW_ASK_LINE,ChartColor_ASKLINE);
      ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,ChartColor_PERIODSEP);
      ChartSetInteger(0,CHART_SHOW_GRID,ChartColor_GRID);
      ChartSetInteger(0,CHART_SHOW_VOLUMES,ChartColor_SHOWVOL);
      ChartSetInteger(0,CHART_SHOW_OBJECT_DESCR,ChartColor_OBJDESCR);
      ChartSetInteger(0,CHART_SHOW_TRADE_LEVELS,ChartColor_TRADELVL);
     }

//---
   if(Type==3)
     {
      ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrWhite);
      ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrBlack);
      ChartSetInteger(0,CHART_COLOR_GRID,clrSilver);
      ChartSetInteger(0,CHART_COLOR_CHART_UP,clrBlack);
      ChartSetInteger(0,CHART_COLOR_CHART_DOWN,clrBlack);
      ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrWhite);
      ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,clrBlack);
      ChartSetInteger(0,CHART_COLOR_CHART_LINE,clrBlack);
      ChartSetInteger(0,CHART_COLOR_VOLUME,clrGreen);
      ChartSetInteger(0,CHART_COLOR_ASK,clrOrangeRed);
      ChartSetInteger(0,CHART_COLOR_STOP_LEVEL,clrOrangeRed);
      //---
      ChartSetInteger(0,CHART_SHOW_OHLC,false);
      ChartSetInteger(0,CHART_SHOW_ASK_LINE,false);
      ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,false);
      ChartSetInteger(0,CHART_SHOW_GRID,false);
      ChartSetInteger(0,CHART_SHOW_VOLUMES,false);
      ChartSetInteger(0,CHART_SHOW_OBJECT_DESCR,false);
     }
//---
  }
//+------------------------------------------------------------------+
//| ChartGetColor                                                    |
//+------------------------------------------------------------------+
//---- Original Template
color ChartColor_BG=0,ChartColor_FG=0,ChartColor_GD=0,ChartColor_UP=0,ChartColor_DWN=0,ChartColor_BULL=0,ChartColor_BEAR=0,ChartColor_LINE=0,ChartColor_VOL=0,ChartColor_ASK=0,ChartColor_LVL=0;
//---
bool ChartColor_OHLC=false,ChartColor_ASKLINE=false,ChartColor_PERIODSEP=false,ChartColor_GRID=false,ChartColor_SHOWVOL=false,ChartColor_OBJDESCR=false,ChartColor_TRADELVL=false;
//----
void ChartGetColor()
  {
   ChartColor_BG=(color)ChartGetInteger(0,CHART_COLOR_BACKGROUND,0);
   ChartColor_FG=(color)ChartGetInteger(0,CHART_COLOR_FOREGROUND,0);
   ChartColor_GD=(color)ChartGetInteger(0,CHART_COLOR_GRID,0);
   ChartColor_UP=(color)ChartGetInteger(0,CHART_COLOR_CHART_UP,0);
   ChartColor_DWN=(color)ChartGetInteger(0,CHART_COLOR_CHART_DOWN,0);
   ChartColor_BULL=(color)ChartGetInteger(0,CHART_COLOR_CANDLE_BULL,0);
   ChartColor_BEAR=(color)ChartGetInteger(0,CHART_COLOR_CANDLE_BEAR,0);
   ChartColor_LINE=(color)ChartGetInteger(0,CHART_COLOR_CHART_LINE,0);
   ChartColor_VOL=(color)ChartGetInteger(0,CHART_COLOR_VOLUME,0);
   ChartColor_ASK=(color)ChartGetInteger(0,CHART_COLOR_ASK,0);
   ChartColor_LVL=(color)ChartGetInteger(0,CHART_COLOR_STOP_LEVEL,0);
//---
   ChartColor_OHLC=ChartGetInteger(0,CHART_SHOW_OHLC,0);
   ChartColor_ASKLINE=ChartGetInteger(0,CHART_SHOW_ASK_LINE,0);
   ChartColor_PERIODSEP=ChartGetInteger(0,CHART_SHOW_PERIOD_SEP,0);
   ChartColor_GRID=ChartGetInteger(0,CHART_SHOW_GRID,0);
   ChartColor_SHOWVOL=ChartGetInteger(0,CHART_SHOW_VOLUMES,0);
   ChartColor_OBJDESCR=ChartGetInteger(0,CHART_SHOW_OBJECT_DESCR,0);
   ChartColor_TRADELVL=ChartGetInteger(0,CHART_SHOW_TRADE_LEVELS,0);
//---
  }
//+------------------------------------------------------------------+
//| ChartMiddleX                                                     |
//+------------------------------------------------------------------+
int ChartMiddleX()
  {
   return((int)ChartGetInteger(0,CHART_WIDTH_IN_PIXELS)/2);
  }
//+------------------------------------------------------------------+
//| ChartMiddleY                                                     |
//+------------------------------------------------------------------+
int ChartMiddleY()
  {
   return((int)ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS)/2);
  }
//+------------------------------------------------------------------+
//| Create rectangle label                                           |
//+------------------------------------------------------------------+
//https://docs.mql4.com/constants/objectconstants/enum_object/obj_rectangle_label
bool RectLabelCreate(const long             chart_ID=0,               // chart's ID
                     const string           name="RectLabel",         // label name
                     const int              sub_window=0,             // subwindow index
                     const int              x=0,                      // X coordinate
                     const int              y=0,                      // Y coordinate
                     const int              width=50,                 // width
                     const int              height=18,                // height
                     const color            back_clr=C'236,233,216',  // background color
                     const ENUM_BORDER_TYPE border=BORDER_SUNKEN,     // border type
                     const ENUM_BASE_CORNER corner=CORNER_LEFT_UPPER, // chart corner for anchoring
                     const color            clr=clrRed,               // flat border color (Flat)
                     const ENUM_LINE_STYLE  style=STYLE_SOLID,        // flat border style
                     const int              line_width=1,             // flat border width
                     const bool             back=false,               // in the background
                     const bool             selection=false,          // highlight to move
                     const bool             hidden=true,              // hidden in the object list
                     const long             z_order=0,                // priority for mouse click
                     const string           tooltip="\n")             // tooltip for mouse hover
  {
//---- reset the error value
   ResetLastError();
//---
   if(ObjectFind(chart_ID,name)!=0)
     {
      if(!ObjectCreate(chart_ID,name,OBJ_RECTANGLE_LABEL,sub_window,0,0))
        {
         Print(__FUNCTION__,
               ": failed to create a rectangle label! Error code = ",_LastError);
         return(false);
        }
      //--- SetObjects
      ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
      ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
      ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
      ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
      ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_TYPE,border);
      ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
      ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
      ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,line_width);
      ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
      ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
      ObjectSetString(chart_ID,name,OBJPROP_TOOLTIP,tooltip);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Create a text label                                              |
//+------------------------------------------------------------------+
//https://docs.mql4.com/constants/objectconstants/enum_object/obj_label
bool LabelCreate(const long              chart_ID=0,               // chart's ID
                 const string            name="Label",             // label name
                 const int               sub_window=0,             // subwindow index
                 const int               x=0,                      // X coordinate
                 const int               y=0,                      // Y coordinate
                 const ENUM_BASE_CORNER  corner=CORNER_LEFT_UPPER, // chart corner for anchoring
                 const string            text="Label",             // text
                 const string            font="Arial",             // font
                 const int               font_size=10,             // font size
                 const color             clr=clrRed,               // color
                 const double            angle=0.0,                // text slope
                 const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // anchor type
                 const bool              back=false,               // in the background
                 const bool              selection=false,          // highlight to move
                 const bool              hidden=true,              // hidden in the object list
                 const long              z_order=0,                // priority for mouse click
                 const string            tooltip="\n",             // tooltip for mouse hover
                 const bool              tester=true)              // create object in the strategy tester
  {
//--- reset the error value
   ResetLastError();
//--- CheckTester
   if(!tester && MQLInfoInteger(MQL_TESTER))
      return(false);
//---
   if(ObjectFind(chart_ID,name)!=0)
     {
      if(!ObjectCreate(chart_ID,name,OBJ_LABEL,sub_window,0,0))
        {
         Print(__FUNCTION__,
               ": failed to create text label! Error code = ",_LastError);
         return(false);
        }
      //--- SetObjects
      ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
      ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
      ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
      ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
      ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
      ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
      ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
      ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
      ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
      ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
      ObjectSetString(chart_ID,name,OBJPROP_TOOLTIP,tooltip);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Create Edit object                                               |
//+------------------------------------------------------------------+
//https://docs.mql4.com/constants/objectconstants/enum_object/obj_edit
bool EditCreate(const long             chart_ID=0,               // chart's ID
                const string           name="Edit",              // object name
                const int              sub_window=0,             // subwindow index
                const int              x=0,                      // X coordinate
                const int              y=0,                      // Y coordinate
                const int              width=50,                 // width
                const int              height=18,                // height
                const string           text="Text",              // text
                const string           font="Arial",             // font
                const int              font_size=10,             // font size
                const ENUM_ALIGN_MODE  align=ALIGN_CENTER,       // alignment type
                const bool             read_only=false,          // ability to edit
                const ENUM_BASE_CORNER corner=CORNER_LEFT_UPPER, // chart corner for anchoring
                const color            clr=clrBlack,             // text color
                const color            back_clr=clrWhite,        // background color
                const color            border_clr=clrNONE,       // border color
                const bool             back=false,               // in the background
                const bool             selection=false,          // highlight to move
                const bool             hidden=true,              // hidden in the object list
                const long             z_order=0,                // priority for mouse click
                const string           tooltip="\n")             // tooltip for mouse hover
  {
//--- reset the error value
   ResetLastError();
//---
   if(ObjectFind(chart_ID,name)!=0)
     {
      if(!ObjectCreate(chart_ID,name,OBJ_EDIT,sub_window,0,0))
        {
         Print(__FUNCTION__,
               ": failed to create \"Edit\" object! Error code = ",_LastError);
         return(false);
        }
      //--- SetObjects
      ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
      ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
      ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
      ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
      ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
      ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
      ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
      ObjectSetInteger(chart_ID,name,OBJPROP_ALIGN,align);
      ObjectSetInteger(chart_ID,name,OBJPROP_READONLY,read_only);
      ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
      ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
      ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
      ObjectSetString(chart_ID,name,OBJPROP_TOOLTIP,tooltip);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the button                                                |
//+------------------------------------------------------------------+
//https://docs.mql4.com/constants/objectconstants/enum_object/obj_button
bool ButtonCreate(const long              chart_ID=0,               // chart's ID
                  const string            name="Button",            // button name
                  const int               sub_window=0,             // subwindow index
                  const int               x=0,                      // X coordinate
                  const int               y=0,                      // Y coordinate
                  const int               width=50,                 // button width
                  const int               height=18,                // button height
                  const ENUM_BASE_CORNER  corner=CORNER_LEFT_UPPER, // chart corner for anchoring
                  const string            text="Button",            // text
                  const string            font="Arial",             // font
                  const int               font_size=10,             // font size
                  const color             clr=clrBlack,             // text color
                  const color             back_clr=C'236,233,216',  // background color
                  const color             border_clr=clrNONE,       // border color
                  const bool              state=false,              // pressed/released
                  const bool              back=false,               // in the background
                  const bool              selection=false,          // highlight to move
                  const bool              hidden=true,              // hidden in the object list
                  const long              z_order=0,                // priority for mouse click
                  const string            tooltip="\n")             // tooltip for mouse hover
  {
//--- reset the error value
   ResetLastError();
//---
   if(ObjectFind(chart_ID,name)!=0)
     {
      if(!ObjectCreate(chart_ID,name,OBJ_BUTTON,sub_window,0,0))
        {
         Print(__FUNCTION__,
               ": failed to create the button! Error code = ",_LastError);
         return(false);
        }
      //--- SetObjects
      ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
      ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
      ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
      ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
      ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
      ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
      ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
      ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
      ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr);
      ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
      ObjectSetInteger(chart_ID,name,OBJPROP_STATE,state);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
      ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
      ObjectSetString(chart_ID,name,OBJPROP_TOOLTIP,tooltip);
     }
//---
   return(true);
  }
//+--------------------------------------------------------------------+
//| ChartMouseScrollSet                                                |
//+--------------------------------------------------------------------+
//https://docs.mql4.com/constants/chartconstants/charts_samples
bool ChartMouseScrollSet(const bool value)
  {
//--- reset the error value
   ResetLastError();
//---
   if(!ChartSetInteger(0,CHART_MOUSE_SCROLL,0,value))
     {
      Print(__FUNCTION__,
            ", Error Code = ",_LastError);
      return(false);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| PlaySound                                                        |
//+------------------------------------------------------------------+
void _PlaySound(const string FileName)
  {
//---
   if(SoundIsEnabled)
      PlaySound(FileName);
//---
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
 



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double sup(int mbars,string sym,int multiplier)
  {
   double ratio1 = iMA(sym,0,mbars,0,0,0,1)-(iStdDev(sym,0,mbars,0,0,0,1)*multiplier);
   return(ratio1);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double res(int mbars,string sym,int multiplier)
  {
   double ratio1 = iMA(sym,0,mbars,0,0,0,1)+(iStdDev(sym,0,mbars,0,0,0,1)*multiplier);
   return(ratio1);
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void deletepanel()
  {
   for(int i=0; i<=ObjectsTotal(); i++)
     {


      for(int i=0; i<ArraySize(currentpage); i++)
        {
         ObjectDelete(0,OBJPREFIX+currentpage[i]);
        }

      ObjectDelete(0,OBJPREFIX+"ltv_v"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"str1_v"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"str1_v"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"str2_v"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"str2_v"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"str3_v"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"str3_v"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"sup3_v"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"sup2_v"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"sup1_v"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"pivot_v"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"res1_v"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"res2_v"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"res3_v"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"high_v"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"low_v"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"Pages");
      ObjectDelete(0,OBJPREFIX+"signal_v"+IntegerToString(i,0,0));

      ObjectDelete(0,OBJPREFIX+"signal_v"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"signal_p"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"signal_t"+IntegerToString(i,0,0));
      ObjectDelete(0,OBJPREFIX+"signal_a"+IntegerToString(i,0,0));



     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void draw_again()
  {

   int fr_y2=Dpi2(140);
//---
   for(int i=0; i<ArraySize(newpairs); i++)
     {
      //---
      if(SelectedMode==FULL)
         fr_y2+=Dpi2(25);
      //---
      if(SelectedMode==COMPACT)
         fr_y2+=Dpi2(21);
      //---
      if(SelectedMode==MINI)
         fr_y2+=Dpi2(17);
     }

   int fr_y=_y1+Dpi2(95);


  for(int i=0; i<ArraySize(currentpage); i++)
     {
 
      string pairs;
      CreateSymbGUI(Prefix+currentpage[i]+Suffix,_y1+60+(i*20));

      pairs =Prefix+currentpage[i]+Suffix;
      LabelCreate(0,OBJPREFIX+"ltv_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-925,_y1+60+(i*20),CORNER_LEFT_UPPER, DoubleToStr(iClose(pairs,0,0),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");

      if(sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100 >=BuyLevel)
        {
         LabelCreate(0,OBJPREFIX+"str1_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-840,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrLime,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }
      if(sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100 <=SellLevel)
        {
         LabelCreate(0,OBJPREFIX+"str1_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-840,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrOrchid,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }
        
     if(sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100>SellLevel && sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100<BuyLevel)
        {
         LabelCreate(0,OBJPREFIX+"str1_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-840,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrYellow,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }

      if(sigma1_value(pairs , Strength_Bar2,iClose(pairs,0,0))*100>=BuyLevel)
        {
         LabelCreate(0,OBJPREFIX+"str2_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-760,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar2,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrLime,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }
      if(sigma1_value(pairs , Strength_Bar2,iClose(pairs,0,0))*100<=SellLevel)
        {
         LabelCreate(0,OBJPREFIX+"str2_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-760,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar2,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrOrchid,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }

 if(sigma1_value(pairs , Strength_Bar2,iClose(pairs,0,0))*100>SellLevel &&sigma1_value(pairs , Strength_Bar2,iClose(pairs,0,0))*100<BuyLevel)
        {
         LabelCreate(0,OBJPREFIX+"str2_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-760,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar2,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrYellow,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }

      if(sigma1_value(pairs , Strength_Bar3,iClose(pairs,0,0))*100>=BuyLevel)
        {
         LabelCreate(0,OBJPREFIX+"str3_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-680,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar3,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrLime,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }
      if(sigma1_value(pairs , Strength_Bar3,iClose(pairs,0,0))*100<=SellLevel)
        {
         LabelCreate(0,OBJPREFIX+"str3_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-680,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar3,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrOrchid,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }

  if(sigma1_value(pairs , Strength_Bar3,iClose(pairs,0,0))*100>SellLevel && sigma1_value(pairs , Strength_Bar3,iClose(pairs,0,0))*100<BuyLevel)
        {
         LabelCreate(0,OBJPREFIX+"str3_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-680,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sigma1_value(pairs , Strength_Bar3,iClose(pairs,0,0))*100,2) +" %",sFontType,FONTSIZE,clrYellow,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }
      LabelCreate(0,OBJPREFIX+"sup3_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-605,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sup(Strength_Bar1,pairs,3),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
      LabelCreate(0,OBJPREFIX+"sup2_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-540,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sup(Strength_Bar1,pairs,2),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
      LabelCreate(0,OBJPREFIX+"sup1_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-465,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(sup(Strength_Bar1,pairs,1),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
      if(iClose(pairs,0,0)<iMA(pairs,0,Strength_Bar1,0,0,0,0))
        {
         LabelCreate(0,OBJPREFIX+"pivot_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-395,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(iMA(pairs,0,Strength_Bar1,0,0,0,1),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,clrOrchid,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }
      if(iClose(pairs,0,0)>iMA(pairs,0,Strength_Bar1,0,0,0,0))
        {
         LabelCreate(0,OBJPREFIX+"pivot_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-390,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(iMA(pairs,0,Strength_Bar1,0,0,0,1),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,clrLime,0,ANCHOR_LEFT,false,false,true,0,"\n");
        }
      LabelCreate(0,OBJPREFIX+"res1_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-320,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(res(Strength_Bar1,pairs,1),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
      LabelCreate(0,OBJPREFIX+"res2_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-255,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(res(Strength_Bar1,pairs,2),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
      LabelCreate(0,OBJPREFIX+"res3_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-180,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(res(Strength_Bar1,pairs,3),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
      LabelCreate(0,OBJPREFIX+"high_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-120,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(MathMax(iHigh(pairs,PERIOD_M1,1), iHigh(pairs,0,iHighest(pairs,0,MODE_HIGH,Strength_Bar1,0))),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
      LabelCreate(0,OBJPREFIX+"low_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-40,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(MathMin(iLow(pairs,PERIOD_M1,1),iLow(pairs,0,iLowest(pairs,0,MODE_LOW,Strength_Bar1,0))),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");


      if(iLow(pairs,PERIOD_M1,1)==iLow(pairs,0,iLowest(pairs,0,MODE_LOW,Strength_Bar1,0)) && iClose(pairs,PERIOD_M1,1)>iLow(pairs,0,iLowest(pairs,0,MODE_LOW,Strength_Bar1,0)) && sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100<=1)
        {
         LabelCreate(0,OBJPREFIX+"signal_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1110,_y1+60+(i*20),CORNER_LEFT_UPPER,"Buy",sFontType,FONTSIZE,clrLime,0,ANCHOR_CENTER,false,false,true,0,"\n");
         LabelCreate(0,OBJPREFIX+"signal_p"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1010,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(iClose(pairs,0,0),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
         LabelCreate(0,OBJPREFIX+"signal_t"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)+50 ,_y1+60+(i*20),CORNER_LEFT_UPPER, TimeToStr(iTime(pairs,0,0),TIME_DATE|TIME_MINUTES),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
        // LabelCreate(0,OBJPREFIX+"signal_a"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)+130,_y1+60+(i*20),CORNER_LEFT_UPPER, "ى","Wingdings",FONTSIZE,clrLime,0,ANCHOR_LEFT,false,false,true,0,"\n");
          
        }
      else
         if(iHigh(pairs,PERIOD_M1,1)==iHigh(pairs,0,iHighest(pairs,0,MODE_HIGH,Strength_Bar1,0)) && iClose(pairs,PERIOD_M1,1)<iHigh(pairs,0,iHighest(pairs,0,MODE_HIGH,Strength_Bar1,0)) && sigma1_value(pairs , Strength_Bar1,iClose(pairs,0,0))*100>=99)
           {
            LabelCreate(0,OBJPREFIX+"signal_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1110,_y1+60+(i*20),CORNER_LEFT_UPPER,"Sell",sFontType,FONTSIZE,clrOrchid,0,ANCHOR_CENTER,false,false,true,0,"\n");
            LabelCreate(0,OBJPREFIX+"signal_p"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1010,_y1+60+(i*20),CORNER_LEFT_UPPER,DoubleToStr(iClose(pairs,0,0),MarketInfo(pairs,MODE_DIGITS)),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
            LabelCreate(0,OBJPREFIX+"signal_t"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)+50 ,_y1+60+(i*20),CORNER_LEFT_UPPER, TimeToStr(iTime(pairs,0,0),TIME_DATE|TIME_MINUTES),sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
            //LabelCreate(0,OBJPREFIX+"signal_a"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)+130,_y1+60+(i*20),CORNER_LEFT_UPPER, "ي","Wingdings",FONTSIZE,clrOrchid,0,ANCHOR_LEFT,false,false,true,0,"\n");
            

           }
         else
           {
            LabelCreate(0,OBJPREFIX+"signal_v"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1110,_y1+60+(i*20),CORNER_LEFT_UPPER, "No Signal",sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
            LabelCreate(0,OBJPREFIX+"signal_p"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)-1010,_y1+60+(i*20),CORNER_LEFT_UPPER, "No Price",sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
            LabelCreate(0,OBJPREFIX+"signal_t"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)+50 ,_y1+60+(i*20),CORNER_LEFT_UPPER, "No Time",sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
         //   LabelCreate(0,OBJPREFIX+"signal_a"+IntegerToString(i,0,0),0,_x1+ Dpi2(CLIENT_BG_WIDTH)+130,_y1+60+(i*20),CORNER_LEFT_UPPER, "No Arrow",sFontType,FONTSIZE,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");

           }

      //}
      //---
      if(SelectedMode==FULL)
         fr_y+=Dpi2(25);
      //---
      if(SelectedMode==COMPACT)
         fr_y+=Dpi2(21);
      //---
      if(SelectedMode==MINI)
         fr_y+=Dpi2(17);


     }

  }


string entry  ;
string entryprice ;
string entrytime  ;

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void Export()
  {
   if(MQLInfoInteger(MQL_DLLS_ALLOWED)==false)
     {
      Alert("Error: DLL imports is not allowed in the program settings.");

     }



   if(ExportSummaryBySymbol(InpFileName))
     {
      //--- open the .csv file with the associated Windows program
      Execute(TerminalInfoString(TERMINAL_DATA_PATH)+"\\MQL4\\Files\\"+InpFileName);

      Print("Data  is exported to ",TerminalInfoString(TERMINAL_DATA_PATH)+"\\MQL4\\Files\\"+InpFileName);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ExportSummaryBySymbol(string filename)
  {




//--- Sorted array of CSymbolSummary objects
   CArrayObj arr;
   arr.Sort(MODE_ASCEND);

//--- now process the list of history orders


   int handle;

//---------- SIZE --------------//
   if(true)
     {
      ResetLastError();
      //--- use FILE_ANSI to correctly display .csv files within Excel 2013 and above.
      handle=FileOpen(filename,FILE_WRITE|FILE_SHARE_READ|FILE_CSV|FILE_ANSI,',');
      if(handle==INVALID_HANDLE)
        {
         Alert("File open failed, error ",_LastError);
         return(false);
        }

      FileWrite(handle,"Symbol","Signal","Signal price","LTP","Strength 1","Strength 2","Strength 3","Sup 3","Sup 2","Sup 1"
                ,"Pivot","Res 1","Res 1","Res 3","High","Low","Signal Time"
               );
     }

   else
      return(false);

//---------- FOR --------------//
   CSymbolSummary *summary=NULL;

   int count = arr.Total();
   for(int i=0; i<ArraySize(finalpairs); i++)
     {

      if(iLow(finalpairs[i],PERIOD_M1,1)==iLow(finalpairs[i],0,iLowest(finalpairs[i],0,MODE_LOW,Strength_Bar1,0)) && iClose(finalpairs[i],PERIOD_M1,1)>iLow(finalpairs[i],0,iLowest(finalpairs[i],0,MODE_LOW,Strength_Bar1,0)) && sigma1_value(finalpairs[i], Strength_Bar1,iClose(finalpairs[i],0,0))*100<=1)
        {
         entry ="Buy" ;
         entryprice =DoubleToStr(iClose(finalpairs[i],0,0),MarketInfo(finalpairs[i],MODE_DIGITS));
         entrytime =TimeToStr(iTime(finalpairs[i],0,0),TIME_DATE|TIME_MINUTES);

        }
      else
         if(iHigh(finalpairs[i],PERIOD_M1,1)==iHigh(finalpairs[i],0,iHighest(finalpairs[i],0,MODE_HIGH,Strength_Bar1,0)) && iClose(finalpairs[i],PERIOD_M1,1)<iHigh(finalpairs[i],0,iHighest(finalpairs[i],0,MODE_HIGH,Strength_Bar1,0)) && sigma1_value(finalpairs[i], Strength_Bar1,iClose(finalpairs[i],0,0))*100>=99)
           {
            entry ="Sell" ;
            entryprice =DoubleToStr(iClose(finalpairs[i],0,0),MarketInfo(finalpairs[i],MODE_DIGITS));
            entrytime =TimeToStr(iTime(finalpairs[i],0,0),TIME_DATE|TIME_MINUTES);

           }
         else
           {
            entry ="No signal" ;
            entryprice ="No Price";
            entrytime ="No Time";

           }


      FileWrite(handle,
                finalpairs[i],
                entry,
                entryprice,
                DoubleToStr(iClose(finalpairs[i],0,0)),
                DoubleToStr(sigma1_value(finalpairs[i], Strength_Bar1,iClose(finalpairs[i],0,0))*100,2),
                DoubleToStr(sigma1_value(finalpairs[i], Strength_Bar2,iClose(finalpairs[i],0,0))*100,2),
                DoubleToStr(sigma1_value(finalpairs[i], Strength_Bar3,iClose(finalpairs[i],0,0))*100,2),
                DoubleToStr(sup(Strength_Bar1,finalpairs[i],3),MarketInfo(finalpairs[i],MODE_DIGITS)),
                DoubleToStr(sup(Strength_Bar1,finalpairs[i],2),MarketInfo(finalpairs[i],MODE_DIGITS)),
                DoubleToStr(sup(Strength_Bar1,finalpairs[i],1),MarketInfo(finalpairs[i],MODE_DIGITS)),
                DoubleToStr(iMA(finalpairs[i],0,Strength_Bar1,0,0,0,1),MarketInfo(finalpairs[i],MODE_DIGITS)),
                DoubleToStr(res(Strength_Bar1,finalpairs[i],1),MarketInfo(finalpairs[i],MODE_DIGITS)),
                DoubleToStr(res(Strength_Bar1,finalpairs[i],2),MarketInfo(finalpairs[i],MODE_DIGITS)),
                DoubleToStr(res(Strength_Bar1,finalpairs[i],3),MarketInfo(finalpairs[i],MODE_DIGITS)),
                DoubleToStr(MathMax(iHigh(finalpairs[i],PERIOD_M1,1), iHigh(finalpairs[i],0,iHighest(finalpairs[i],0,MODE_HIGH,Strength_Bar1,0))),MarketInfo(finalpairs[i],MODE_DIGITS)),
                DoubleToStr(MathMin(iLow(finalpairs[i],PERIOD_M1,1),iLow(finalpairs[i],0,iLowest(finalpairs[i],0,MODE_LOW,Strength_Bar1,0))),MarketInfo(finalpairs[i],MODE_DIGITS)),
                entrytime

               );
     }

//--- complete cleaning of the array with the release of memory
   arr.Shutdown();

//--- footer
   FileWrite(handle,"");
//---
   FileClose(handle);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#import "shell32.dll"
int ShellExecuteW(int hWnd,string Verb,string File,string Parameter,string Path,int ShowCommand);
#import
//+------------------------------------------------------------------+
//| Execute Windows command/program or open a document/webpage       |
//+------------------------------------------------------------------+
void Execute(const string command,const string parameters="")
  {
   shell32::ShellExecuteW(0,"open",command,parameters,NULL,1);
  }
//+------------------------------------------------------------------+
 
//+------------------------------------------------------------------+


  void pagescode()
  {
   deletepanel();
         pages =(ArraySize(finalpairs)/Pairs_N_page)+1;
         if(starter+Pairs_N_page>ArraySize(finalpairs))
           {starter=0;}
         if(starter<=ArraySize(finalpairs))
           {
            starter =starter+Pairs_N_page;
           }
         int x=150;//ChartMiddleX()-(Dpi2(CLIENT_BG_WIDTH)/2);
   int y=50;//ChartMiddleY()-(fr_y2/2);


 LabelCreate(0,OBJPREFIX+"Pages",0,x+50,y-10,CORNER_LEFT_UPPER,"Page "+IntegerToString(starter/Pairs_N_page,0,0)+"/"+IntegerToString(pages-1,0,0),"Arial Black",10,COLOR_FONT,0,ANCHOR_LEFT,false,false,true,0,"\n");
 
         int HowManySymbols=SymbolsTotal(true);
         string ListSymbols=" ";
         for(int i=0; i<HowManySymbols; i++)
           {
            ListSymbols=StringConcatenate(ListSymbols,SymbolName(i,true),",");
           }

         u_sep=StringGetCharacter(sep,0);
         kz=StringSplit(ListSymbols,u_sep,newpairs);
         int index =0;
         int index2 =0;
         for(int i=0; i<ArraySize(newpairs); i++)
           {
            if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)==0)
              {
               continue;
              }
            if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)>0)
              {
               if(sigma1_value(newpairs[i], Strength_Bar1,iClose(newpairs[i],0,0))*100>=90 || sigma1_value(newpairs[i], Strength_Bar1,iClose(newpairs[i],0,0))*100<=10)
                 {
                  // finalpairs[index]=newpairs[i];
                  index++;
                 }
              }
           }

         ArrayResize(finalpairs,index);
         for(int i=0; i<ArraySize(newpairs); i++)
           {
            if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)==0)
              {
               continue;
              }
            if(iStdDev(newpairs[i],0,Strength_Bar1,0,0,0,1)>0)
              {
              if(sigma1_value(newpairs[i], Strength_Bar1,iClose(newpairs[i],0,0))*100>=90 || sigma1_value(newpairs[i], Strength_Bar1,iClose(newpairs[i],0,0))*100<=10)
                 {
                  finalpairs[index2]=newpairs[i];
                  index2++;
                 }
              }
           }
         ArrayResize(currentpage,Pairs_N_page+1);
         for(int i=0; i<=Pairs_N_page; i++)
           {
            currentpage[i]=finalpairs[starter-i];

           }
         pages =(ArraySize(finalpairs)/Pairs_N_page)+1;

         draw_again();

  }
  
  
  double sigma1_value(string sym , int strg, double price)
  {
  double mean =  iMA(sym,0,strg,0,0,0,1) ;
  double std  =  iStdDev(sym,0,strg,0,0,0,1);
   double ratio1 = 68.26;
   double ratio2 = 95.44;
   double ratio3 = 99.72;
   double ratio4 = 100;

 double high =   MathMax(iHigh(sym,PERIOD_M1,1), iHigh(sym,0,iHighest(sym,0,MODE_HIGH,strg,1))) ;
 double low  =  MathMin(iLow(sym,PERIOD_M1,1),iLow(sym,0,iLowest(sym,0,MODE_LOW,strg,1))) ;
 
  double ratio1_ = 68.26/2;;
   double ratio2_ = MathAbs(ratio2-ratio1)/2;
   double ratio3_ = MathAbs(ratio3-ratio2)/2;
   double ratio4_ = ratio4/ratio3 ;


  double factor1 = 68.26/2/std; 
  double factor2 = MathAbs(ratio2-ratio1)/2/std;
  double factor3 = MathAbs(ratio3-ratio2)/2/std; 
  double factor4 = ratio4/ratio3/std;
 
 
 double res1= mean +std;
 double res2= mean +(std*2);
 double res3= mean +(std*3);
 
 double sup1= mean -std;
 double sup2= mean -(std*2);
 double sup3= mean -(std*3);

/*double segmaup1=50+(((res1-mean)/100)*factor1);
 Print(segmaup1);
 double segmaup2= mean -std;
 double segmaup3= mean -std;
 */

  
   double lvl1up = ( 0.5+ ((MathAbs(res1-mean)/100)*factor1)) ;
   double lvl2up = lvl1up+ ((MathAbs(res2-res1)/100)*factor2);  
   double lvl3up = lvl2up+ ((MathAbs(res3-res2)/100)*factor3); 
   double lvl4up = lvl3up+ ((MathAbs(high-res3)/100)*factor4); 
 


   double lvl1dn = ( 0.5- ((MathAbs(sup1-mean)/100)*factor1)) ;
   double lvl2dn = lvl1dn- ((MathAbs(sup1-sup2)/100)*factor2);  
   double lvl3dn = lvl2dn- ((MathAbs(sup2-sup3)/100)*factor3); 
   double lvl4dn = lvl3dn- ((MathAbs(low-sup3)/100)*factor4);
   
   
   if(price>=res1 && price <res2)
    {
    return(lvl1up+ ((MathAbs(price-res1)/100)*factor2));
    }
    
     if(price>=res2 && price <res3)
    {
    return(lvl2up+ ((MathAbs(price-res2)/100)*factor3));
    }
    
      if(price>=res3 && price <high)
    {
    return(lvl3up+ ((MathAbs(price-res3)/100)*factor4));
    }
    
    
    
    
    
    if(price<=sup1 && price >sup2)
    {
    return(lvl1dn-((MathAbs(price-sup1)/100)*factor2));
    }
    
     if(price<=sup2 && price >sup3)
    {
    return(lvl2dn- ((MathAbs(price-res2)/100)*factor3));
    }
    
      if(price<=sup3 && price >low)
    {
    return(lvl3dn-((MathAbs(price-sup3)/100)*factor4));
    }
    
return(0);
  }