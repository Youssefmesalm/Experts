//+------------------------------------------------------------------+
//|                                 NirvamanImax.mq4                 |
//|                      Copyright © 2008, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2008, Gabriel Jaime Mejía Arbelaez"
#property link      "http://www.metaquotes.net"

//---- input parameters
extern double       lots = 0.1;
extern int          mn = 555;

static int          prevtime = 0;
extern double       tp = 100;
extern double       sl = 50;
extern double       periodos=13;
extern int          tiempoCierre=15000;


int StartHour=22;
int EndHour=2;
int BrokerTimeZone=0;



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start()
  {

   if(Time[0] == prevtime)
      return(0);
   prevtime = Time[0];

   if(! IsTradeAllowed())
     {
      again();
      return(0);
     }

//----------------------------------------cerrando orden abierta despues de la primera barra



   int total = OrdersTotal();
   for(int i = 0; i < total; i++)
     {
      OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
      if(OrderSymbol() == Symbol() && OrderMagicNumber() == mn)
        {
         if(TimeCurrent()-OrderOpenTime()>=tiempoCierre)
           {

            OrderClose(OrderTicket(),lots,MarketInfo(Symbol(),MODE_BID),3,GreenYellow);

           }
         else
           {
            return(0);
           }
        }

     }



//----------------------------------------------------------------------------------------


   int ticket = -1;
   int perceptron = Supervisor();
   int ha=0;


   double buff0=0;
   double buff1=0;



   buff0=iCustom(NULL, 0, "HA",2,0);
   buff1=iCustom(NULL, 0, "HA",3,0);



   if(buff0>buff1)
      ha=-1;

   if(buff0<buff1)
      ha=1;
//-----------------------------------------------------------------------------------------


   double  promedioEMA=iCustom(NULL, 0, "Moving_Averages2",periodos,0,0);


//----------------------------------------------------------No operar en este rango de horas

   int h=TimeHour(TimeCurrent()-BrokerTimeZone);





   if(!(h> StartHour && h<EndHour))
     {


      if(perceptron > 0 && ha > 0 && Close[1]>promedioEMA)
        {
         ticket = OrderSend(Symbol(), OP_BUY, lots, Ask,2, Bid - sl * Point, Bid + tp * Point, WindowExpertName(), mn, 0, Blue);
         Alert("SEÑAL:"+Symbol());
         if(ticket < 0)
           {
            again();
           }
        }

      if(perceptron < 0 && ha <0  && Close[1]<promedioEMA)
        {
         ticket = OrderSend(Symbol(), OP_SELL, lots, Bid, 2, Ask + sl * Point, Ask - tp * Point, WindowExpertName(), mn, 0, Red);
         Alert("SEÑAL:"+Symbol());
         if(ticket < 0)
           {
            again();
           }
        }


     }


   return(0);



//------------------------------------------------------------------------------



  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void again()
  {
   prevtime = Time[1];
   Sleep(30000);
  }

/*+-------------------------------------------------------------------+
  | supervisor encargado de determinar si se hace long o short        |
  +-------------------------------------------------------------------+*/
double Supervisor()
  {

   double iMAX0=iCustom(NULL, 0, "iMAX3alert1",4,0);
   double iMAX1=iCustom(NULL, 0, "iMAX3alert1",5,0);

   double iMAX01=iCustom(NULL, 0, "iMAX3alert1",4,1);
   double iMAX11=iCustom(NULL, 0, "iMAX3alert1",5,1);

   double b0=0;
   double b1=0;
   double r0=0;
   double r1=0;

   b0 = iMAX0;
   b1 = iMAX01;
   r0 = iMAX1;
   r1 = iMAX11;

   if(b0 > r0 && b1 < r1)
      return(1);

   if(b0 < r0 && b1 > r1)
      return(-1);




  }










//+------------------------------------------------------------------+
