//+------------------------------------------------------------------+
//|                                           Telegram_Search_EA.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict

#include <Telegram.mqh>
//+------------------------------------------------------------------+
//|   Defines                                                        |
//+------------------------------------------------------------------+
#define SEARCH_URL      "https://search.mql5.com"
//---
#define BUTTON_TOP      "\xF51D"
#define BUTTON_LEFT     "\x25C0"
#define BUTTON_RIGHT    "\x25B6"
//---
#define RADIO_SELECT    "\xF518"
#define RADIO_EMPTY     "\x26AA"
//---
#define CHECK_SELECT    "\xF533"
#define CHECK_EMPTY     "\x25FB"
//---
#define MENU_LANGUAGES  "Languages"
#define MENU_MODULES    "Modules"
//---
#define LANG_EN 0
#define LANG_RU 1
#define LANG_ZH 2
#define LANG_ES 3
#define LANG_DE 4
#define LANG_JA 5
//---
#define MODULE_PROFILES   0x001
#define MODULE_FORUM      0x002
#define MODULE_ARTICLES   0x004
#define MODULE_CODEBASE   0x008
#define MODULE_JOBS       0x010
#define MODULE_DOCS       0x020
#define MODULE_MARKET     0x040
#define MODULE_SIGNALS    0x080
#define MODULE_BLOGS      0x100
//+------------------------------------------------------------------+
//|   CResultMessage                                                 |
//+------------------------------------------------------------------+
class CResultMessage: public CObject
{
public:
   datetime          date;
   string            module;
   string            id;
   string            info_url;
   string            info_title;
   string            text;
};
//+------------------------------------------------------------------+
//|   TLanguage                                                      |
//+------------------------------------------------------------------+
struct TLanguage
{
   string            name;
   string            flag;
   string            prefix;
};
//---
TLanguage languages[6]=
{
   {"English","\xF1EC\xF1E7","en"},
   {"Русский","\xF1F7\xF1FA","ru"},
   {"中文",    "\xF1E8\xF1F3","zh"},
   {"Español","\xF1EA\xF1F8","es"},
   {"Deutsch","\xF1E9\xF1EA","de"},
   {"日本語",   "\xF1EF\xF1F5","ja"}
};
const string MODULES_WEB[9]= {"profiles","forum","articles","codebase","jobs","docs","market","signals","blogs"};
const string MODULES_EN[9]= {"Profiles","Forum","Articles","Codebase","Freelance","Documentation","Market","Signals","Blogs"};
const string MODULES_RU[9]= {"Профили","Форум","Статьи","Codebase","Фриланс","Документация","Маркет","Сигналы","Блоги"};
const string MODULES_ZH[9]= {"个人资料","论坛","文章","代码库","自由职业者","文档库","市场","信号","博客"};
const string MODULES_ES[9]= {"Perfil","Foro","Artículos","Codebase","Freelance","Documentación","Market","Señales","Blogs"};
const string MODULES_DE[9]= {"Profile","Forum","Artikel","Codebase","Freelance","Dokumentation","Market","Signale","Blogs"};
const string MODULES_JA[9]= {"プロファイル","フォーラム","記事","コードベース","フリーランス","ドキュメンテーション","マーケット","シグナル","ブログ"};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CSearchBot: public CCustomBot
{
private:
   int               m_lang;
   int               m_index;
   int               m_modules;
   CList             m_result;
   int               m_result_index;

   //+------------------------------------------------------------------+
   string            GetKeyboard(int index)
   {
      if(index==0)
      {
         string counter=StringFormat("%d/%d",m_result.Total()==0?0:m_result_index+1,m_result.Total());
         return("[[\""+BUTTON_LEFT+"\",\""+counter+"\",\""+BUTTON_RIGHT+"\"],[\""+MENU_LANGUAGES+" "+languages[m_lang].flag +"\",\""+MENU_MODULES+"\"]]");
      }
      //---
      if(index==1)
      {
         string radio[6]= {RADIO_EMPTY,RADIO_EMPTY,RADIO_EMPTY,RADIO_EMPTY,RADIO_EMPTY,RADIO_EMPTY};
         //---
         switch(m_lang)
         {
         case LANG_EN:
            radio[0] = RADIO_SELECT;
            break;
         case LANG_RU:
            radio[1] = RADIO_SELECT;
            break;
         case LANG_ZH:
            radio[2] = RADIO_SELECT;
            break;
         case LANG_ES:
            radio[3] = RADIO_SELECT;
            break;
         case LANG_DE:
            radio[4] = RADIO_SELECT;
            break;
         case LANG_JA:
            radio[5] = RADIO_SELECT;
            break;
         default:
            m_lang=LANG_EN;
            radio[0]=RADIO_SELECT;
            break;
         }
         //---
         return(StringFormat("[[\"%s %s\",\"%s %s\",\"%s %s\"],[\"%s %s\",\"%s %s\",\"%s %s\"],[\""+BUTTON_TOP+"\"]]",
                             radio[0],languages[0].name,
                             radio[1],languages[1].name,
                             radio[2],languages[2].name,
                             radio[3],languages[3].name,
                             radio[4],languages[4].name,
                             radio[5],languages[5].name));
      }

      //---
      if(index==2)
      {
         string check[9]= {CHECK_EMPTY,CHECK_EMPTY,CHECK_EMPTY,CHECK_EMPTY,CHECK_EMPTY,CHECK_EMPTY,CHECK_EMPTY,CHECK_EMPTY};
         for(int i=0; i<9; i++)
         {
            if((m_modules&(1<<i))!=0)
               check[i]=CHECK_SELECT;
            else
               check[i]=CHECK_EMPTY;
         }

         //---
         string armod[9];
         switch(m_lang)
         {
         case 0:
            ArrayCopy(armod,MODULES_EN);
            break;
         case 1:
            ArrayCopy(armod,MODULES_RU);
            break;
         case 2:
            ArrayCopy(armod,MODULES_ZH);
            break;
         case 3:
            ArrayCopy(armod,MODULES_ES);
            break;
         case 4:
            ArrayCopy(armod,MODULES_DE);
            break;
         case 5:
            ArrayCopy(armod,MODULES_JA);
            break;
         default:
            ArrayCopy(armod,MODULES_EN);
            break;
         }

         //---
         string keyb=StringFormat("[[\"%s %s\",\"%s %s\",\"%s %s\"],[\"%s %s\",\"%s %s\",\"%s %s\"],[\"%s %s\",\"%s %s\",\"%s %s\"],[\""+BUTTON_TOP+"\"]]",
                                  check[0],armod[0],
                                  check[1],armod[1],
                                  check[2],armod[2],
                                  check[3],armod[3],
                                  check[4],armod[4],
                                  check[5],armod[5],
                                  check[6],armod[6],
                                  check[7],armod[7],
                                  check[8],armod[8]);
         return(keyb);

      }

      return("");
   }

public:
   //+------------------------------------------------------------------+
   void              CSearchBot::CSearchBot(void)
   {
      m_lang=LANG_EN;
      m_index=0;
      m_modules=MODULE_DOCS;
   }
   //+------------------------------------------------------------------+
   void              ProcessMessages(void)
   {

      for(int i=0; i<m_chats.Total(); i++)
      {

         CCustomChat *chat=m_chats.GetNodeAtIndex(i);
         if(!chat.m_new_one.done)
         {
            chat.m_new_one.done=true;
            string text=chat.m_new_one.message_text;

            //--- start
            if(text == "/start" ||
                  text == "/help" ||
                  text == BUTTON_TOP)
            {
               m_index=0;
               bot.SendMessage(chat.m_id,"Choose a menu item",bot.ReplyKeyboardMarkup(GetKeyboard(m_index),false,false));
               continue;
            }

            //---
            if(StringFind(text,MENU_LANGUAGES)==0)
            {
               m_index=1;
               bot.SendMessage(chat.m_id,"Choose a language",bot.ReplyKeyboardMarkup(GetKeyboard(m_index),false,false));
               continue;
            }

            //---
            if(text==MENU_MODULES)
            {
               m_index=2;
               bot.SendMessage(chat.m_id,"Choose modules",bot.ReplyKeyboardMarkup(GetKeyboard(m_index),false,false));
               continue;
            }

            //---
            if(text==BUTTON_LEFT)
            {
               if(m_result.Total()>0)
               {
                  if(m_result_index>0)
                     m_result_index--;
                  else
                     m_result_index=m_result.Total()-1;

                  CResultMessage *item=m_result.GetNodeAtIndex(m_result_index);
                  bot.SendMessage(chat.m_id,item.text+"\n"+item.info_url,bot.ReplyKeyboardMarkup(GetKeyboard(m_index),false,false));
               }
               continue;
            }

            //---
            if(text==BUTTON_RIGHT)
            {
               if(m_result.Total()>0)
               {
                  if(m_result_index<m_result.Total()-1)
                     m_result_index++;
                  else
                     m_result_index=0;

                  CResultMessage *item=m_result.GetNodeAtIndex(m_result_index);
                  bot.SendMessage(chat.m_id,item.text+"\n"+item.info_url,bot.ReplyKeyboardMarkup(GetKeyboard(m_index),false,false));
               }
               continue;
            }

            //---
            if(m_index==0)
            {
               string prefix=languages[m_lang].prefix;
               string modules=NULL;
               for(int k=0; k<9; k++)
               {
                  if((m_modules&(1<<k))!=0)
                  {
                     if(modules!=NULL)
                        modules+="|";
                     modules+="mql5.com."+prefix+"."+MODULES_WEB[k];
                  }
               }

               string url=StringFormat("https://search.mql5.com/api/query?hl=%s&module=%s&keyword=%s&from=0&count=5",
                                       prefix,modules,text);
               char result[];
               char data[];
               string headers;//="Content-Type:text/html; charset=utf-8\r\n";
               string result_headers=NULL;
               int res=WebRequest("GET",url,headers,5000,data,result,result_headers);
               if(res==200)//ok
               {
                  m_result.Clear();
                  m_result_index=0;

                  string out=CharArrayToString(result,0,WHOLE_ARRAY,CP_UTF8);
                  //MessageBox(out);
                  //--- parse result

                  CJAVal js(NULL,jtUNDEF);
                  bool done=js.Deserialize(out,CP_UTF8);
                  if(!done)
                     continue;//return(ERR_JSON_PARSING);

                  CResultMessage temp;

                  int total=ArraySize(js["results"].m_e);
                  for(int k=0; k<total; k++)
                  {
                     CJAVal item=js["results"].m_e[k];

                     //---
                     temp.date=(datetime)item["date"].ToInt();
                     temp.module=item["module"].ToStr();
                     temp.id=item["id"].ToStr();
                     temp.info_url=item["info"]["url"].ToStr();
                     temp.info_title=item["info"]["title"].ToStr();
                     temp.text=item["text"].ToStr();
                     temp.text=StringSubstr(temp.text,0,600);

                     //--- add
                     m_result.Add(new CResultMessage);
                     CResultMessage *msg=m_result.GetLastNode();
                     msg.date=temp.date;
                     msg.module=temp.module;
                     msg.id=temp.id;
                     msg.info_url=temp.info_url;
                     msg.info_title=temp.info_title;
                     msg.text=temp.text;
                  }
               }
               else
               {
                  if(res==-1)
                  {
                     Print(GetErrorDescription(_LastError));
                     Print("Add '",SEARCH_URL,"' to WebRequest allowed URLs list");
                  }
                  else
                  {
                     //--- HTTP errors
                     if(res>=100 && res<=511)
                     {
                        Print(GetErrorDescription(ERR_HTTP_ERROR_FIRST+res));
                     }
                  }
               }

               if(m_result.Total()>0)
               {
                  CResultMessage *item=m_result.GetNodeAtIndex(m_result_index);

                  bot.SendMessage(chat.m_id,item.text+"\n"+item.info_url,bot.ReplyKeyboardMarkup(GetKeyboard(m_index),false,false));
               }
               else
                  bot.SendMessage(chat.m_id,"Result is empty",bot.ReplyKeyboardMarkup(GetKeyboard(m_index),false,false));

               continue;
            }
            //---
            if(m_index==1)
            {
               int total=ArraySize(languages);
               for(int k=0; k<total; k++)
               {
                  if(text==RADIO_EMPTY+" "+languages[k].name)
                  {
                     m_lang=k;
                     bot.SendMessage(chat.m_id,languages[k].name,bot.ReplyKeyboardMarkup(GetKeyboard(m_index),false,false));
                  }
               }
               continue;
            }

            //---
            if(m_index==2)
            {
               string armod[9];
               switch(m_lang)
               {
               case 0:
                  ArrayCopy(armod,MODULES_EN);
                  break;
               case 1:
                  ArrayCopy(armod,MODULES_RU);
                  break;
               case 2:
                  ArrayCopy(armod,MODULES_ZH);
                  break;
               case 3:
                  ArrayCopy(armod,MODULES_ES);
                  break;
               case 4:
                  ArrayCopy(armod,MODULES_DE);
                  break;
               case 5:
                  ArrayCopy(armod,MODULES_JA);
                  break;
               default:
                  ArrayCopy(armod,MODULES_EN);
                  break;
               }

               int total=ArraySize(armod);
               for(int k=0; k<total; k++)
               {
                  if(text==CHECK_EMPTY+" "+armod[k])
                  {
                     m_modules|=(1<<k);
                     bot.SendMessage(chat.m_id,armod[k],bot.ReplyKeyboardMarkup(GetKeyboard(m_index),false,false));
                  }
                  if(text==CHECK_SELECT+" "+armod[k])
                  {
                     m_modules&=~(1<<k);
                     bot.SendMessage(chat.m_id,armod[k],bot.ReplyKeyboardMarkup(GetKeyboard(m_index),false,false));
                  }
               }
               continue;
            }
         }
      }
   }
};

//+------------------------------------------------------------------+
input string InpToken="";//Token
CSearchBot bot;
int getme_result;
//+------------------------------------------------------------------+
//|   OnInit                                                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- set token
   bot.Token(InpToken);
//--- check token
   getme_result=bot.GetMe();
//--- run timer
   EventSetTimer(1);
   OnTimer();
//--- done
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//|   OnDeinit                                                       |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   Comment("");
}
//+------------------------------------------------------------------+
//|   OnTimer                                                        |
//+------------------------------------------------------------------+
void OnTimer()
{
//--- show error message end exit
   if(getme_result!=0)
   {
      Comment("Error: ",GetErrorDescription(getme_result));
      return;
   }
//--- show bot name
   Comment("Bot name: ",bot.Name());
//--- reading messages
   bot.GetUpdates();
//--- processing messages
   bot.ProcessMessages();
}
//+------------------------------------------------------------------+
