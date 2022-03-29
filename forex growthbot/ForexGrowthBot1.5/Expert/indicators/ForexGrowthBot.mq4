//+------------------------------------------------------------------+
//|                                               ForexGrowthBot.mq4 |
//|                   Copyright © 2010, ForexGrowthBot & E. Labunsky |
//|                                    http://www.ForexGrowthBot.com |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2010, ForexGrowthBot"
#property link      "http://www.ForexGrowthBot.com"

#property indicator_chart_window

#import "quanttradermt4.dll"
double GetVolatilityRatio (double &ArrClose[], double &ArrOpen[], int FastPeriod, int SlowPeriod, int arrLen); 
int initQuant(int SystemID, int LotLimit, double CapGameProfit, double LossPerLot, double CapManagValue, int CapGameFreq, int EntryFreq, double Marging, int UseWaveTrailing, string WaveTrailing);

extern int FastVolatilityBase = 3;
extern int SlowVolatilityBase = 50;
extern double VolatilityFactor = 1.5;
//extern double VolatilityFactorEnd = 0.6;
extern bool SmallArrow = true;

string SessionID = "";
double lastSign = 0;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
{


	string short_name = "ForexGrowBot";
	IndicatorShortName(short_name);
	SetIndexLabel(0, short_name);

	SessionID  = MathRand();
	
	initQuant(9, 1, 1, 1, 1, 1, 1, 1, false, "");      

	//ObjectsDeleteAll();

}

//+------------------------------------------------------------------+
//| Moving Averages Convergence/Divergence                           |
//+------------------------------------------------------------------+

int start()
{

	int countedBars = IndicatorCounted();
	if (countedBars < 0)
	{
		countedBars = 110;
		//ObjectsDeleteAll();
		Clear();
	} else 
		countedBars--;

	int limit = Bars - countedBars;

	if (Bars > 133)
	//if (ArraySize(Close)>125)
	{

		double ShiftY = MathAbs(High[Bars - 1] - Low[WindowFirstVisibleBar()]);

		for (int i = limit; i >0; i--)

		{

			int signal = 0;

			string objName = "-!@!-" + SessionID + Time[i];


			if (ObjectFind(objName) >= 0)
				//return (0);  
				ObjectDelete (objName);

			int currOffSet = i; //(Bars - i) ;

			// RUN IT          


			//if (Bars>33)
			{

				//Start LONG/SHORT/LONG and 
				int point1 = 0;
				int point2 = 0;

				double maxProfit_LSL = -10000;
				double currProfit = 0;

			
            double arrayClose[];
				//ArraySetAsSeries(arrayClose,true);
				double arrayOpen[];
				//ArraySetAsSeries(arrayOpen,true);	

				//Copy last 100 prices (15 mins)
				
				int copiedElements = 0;
				
				if (ArraySize (Close) - i > 101) 
				{
				  copiedElements = ArrayCopy (arrayClose, Close,0, i , 100);
				  copiedElements = ArrayCopy (arrayOpen, Open,0, i, 100);				
				}

            if (copiedElements == 100)
            {
                       
				  double volatatilityRatio = GetVolatilityRatio (arrayClose, arrayOpen, FastVolatilityBase, SlowVolatilityBase, 100);  
				  //if (MathAbs (volatatilityRatio) > VolatilityFactor && MathAbs (volatatilityRatio) < VolatilityFactorEnd )				  				
				  if (MathAbs (volatatilityRatio) > VolatilityFactor)				  				
				  {

					  if (volatatilityRatio>0)
						  signal = 1;
					  else  
						  signal =  -1;						
						
				  }   
				   
				}
				
				if (signal == 1)
				{               


					if (!SmallArrow)
					{
						ObjectCreate(objName, OBJ_ARROW, 0, Time[i], Low[i]);
						//ObjectSet(objName,OBJPROP_ARROWCODE,SYMBOL_ARROWDOWN);
						ObjectSet(objName, OBJPROP_ARROWCODE, 233);
						ObjectSet(objName, OBJPROP_WIDTH, 1);
						ObjectSet(objName, OBJPROP_COLOR, Green);
					}
					else
					{

						ObjectCreate(objName, OBJ_ARROW, 0, Time[i], Low[i]);
						ObjectSet(objName, OBJPROP_ARROWCODE, 1);
						ObjectSet(objName, OBJPROP_WIDTH, 1);
						ObjectSet(objName, OBJPROP_COLOR, Green);
					}



				}

				if (signal == -1)
				{


					if (!SmallArrow)
					{
						ObjectCreate(objName, OBJ_ARROW, 0, Time[i], High[i] + ShiftY / 100);
						//ObjectSet(objName,OBJPROP_ARROWCODE,SYMBOL_ARROWDOWN);
						ObjectSet(objName, OBJPROP_ARROWCODE, 234);
						ObjectSet(objName, OBJPROP_WIDTH, 1);
						ObjectSet(objName, OBJPROP_COLOR, Red);
					}
					else
					{

						ObjectCreate(objName, OBJ_ARROW, 0, Time[i], High[i]);
						ObjectSet(objName, OBJPROP_ARROWCODE, 2);
						ObjectSet(objName, OBJPROP_WIDTH, 1);
						ObjectSet(objName, OBJPROP_COLOR, Red);
					}

				}
			}


		}


	}

	return (0);

}


int deinit()
{
	//ObjectsDeleteAll();
	Clear();
	return (0); 
}

void Clear()
{
	int obj_total = ObjectsTotal();
	for(int obj = obj_total - 1; obj >= 0; obj--)
	{  
		string objname = ObjectName(obj);
		if (StringFind(objname, "-!@!-" + SessionID) >= 0)
			ObjectDelete(objname);
	}
}