#property copyright "Copyright 2018, Trevor Schuil"
#property link "https://www.mql5.com/en/users/trevone" 
#property strict // maybe this is whats wrong??
#property version "1.35"

extern string title6 = "GENERAL SETTINGS";  //\ Time
enum manager {
   P=0, // Primary
   B=1, // Secondary
}; 

  manager Terminal = 0;
extern string TradeComment = ""; // Comment
extern int MagicNumber = 1; // Magic 
extern int Slippage = 1;  
extern string title5 = "TICK SETTINGS";  //\ Time
extern int TickModulus = 2; // Tick Filter
extern int TickSample = 30; // Tick Samples 
extern string title1 = "TIME SETTINGS";  //\ Time
extern int TradeInterval = 0; // Trade Request Seconds
extern int Secs = 60; // Order Modify Seconds
extern int StartHour = 2; // Start Hour
extern int EndHour = 22; // End Hour 
extern string title2 = "MONEY MANAGEMENT";  //\ Account  
extern double FixedLot = 0.0; // Fixed Lots 0.0 = MM
extern double RiskPercent = 7.5; // Risk MM%
extern double Aggressive = 3; // Aggressive > 1 
extern string title4 = "SPREAD IN POINTS";  //\ Spread Settings
extern int MaxSpread = 40;  // Max Spread Limit
extern int MinMeasure = 5; // Min Spread Limit
extern string title3 = "MEASURED IN SPREADS";  //\ Trade Settings
extern double Signal = 1.8; // Signal Size
extern double Delta = 3.5; // Order Distance 
extern double MaxDistance = 12.0; // Max Distance  
extern double Stop = 8.0; // Stop Loss   
extern double Tp = 8.0; // Take Profit
extern double MaxTrailing = 3.0; // Max Trailing 
extern double TrailingTarget = 9.0; // Trailing Target       

int OrderExpiry = 0; // Order Expiry
int MaxTrades = 1; // Max Trades 
double TakeProfit = 0.0; // TakeProfit
double MinTrailing = 0.0; // Min Trailing
double TrailingStart = 0.0; // Start Trailing 
bool BothDirection = true; // Both Directions Together

int r, size, stoplevel, freezelevel, lastBuyOrder, lastSellOrder, lastTradeRequest, leverage,
tcount, m_digit;

double marginRequirement, maxLot, minLot, lotSize, avgSpread, commissionPoints,
p_stopDistance, p_signalDistance, m_trailingtarget, m_mintrailing, m_maxtrailing, 
m_trailingstart, p_orderDistance, p_takeProfit, p_mapTrailing, p_totalSpread, 
p_maxSpread, p_stoplevel, p_freezelevel, lotstep, p_stopSignal, p_martingale, 
p_doubleTarget, p_buyStoploss, p_sellStoploss, p_maxSignalDistance, p_aggressiveDistance;

double spreadSize[]; 
   
double p_point; 
double rate;

int init() {    

   if( Signal > Delta ) Delta = Signal + 0.1;
   if( MaxTrailing > TrailingTarget ) TrailingTarget = MaxTrailing + 0.1;
   if( Aggressive < 1 ) Aggressive = 1;
   
   tcount = 0;
   rate = 0.0;
   
   // these should always be zero
   m_mintrailing=MinTrailing;
   m_trailingstart=TrailingStart;
   p_takeProfit=TakeProfit;
   
   m_digit = Digits; 
   p_point = Point; 
   
   leverage = ( int ) AccountLeverage();
   lotstep = ( double ) MarketInfo( Symbol(), MODE_LOTSTEP ); 
   maxLot = ( double ) MarketInfo( Symbol(), MODE_MAXLOT );  
   minLot = ( double ) MarketInfo( Symbol(), MODE_MINLOT );   
   marginRequirement = ( double ) MarketInfo( Symbol(), MODE_MARGINREQUIRED ) * minLot;   
   
   p_stoplevel = 0;
   stoplevel = ( int ) MarketInfo( Symbol(), MODE_STOPLEVEL ); 
   if( stoplevel > 0 )
      p_stoplevel = ( stoplevel + 1 ) * Point;  // add 1 why?  
      
   p_freezelevel = 0;
   freezelevel = ( int ) MarketInfo( Symbol(), MODE_FREEZELEVEL ); // add 1 why? 
   if( freezelevel > 0 )
      p_freezelevel = ( freezelevel + 1 ) * Point;  
      
   if( stoplevel > 0 || freezelevel > 0 ){
      Print( "WARNING! Broker is not suitable, the stoplevel is greater than zero." );
   }
      
   avgSpread = NormalizeDouble( Ask - Bid, m_digit ); 
   p_totalSpread = avgSpread;
   if( Terminal == 0 )
      size = TickSample;
   else size = 3; // for performance 
   
   ArrayResize( spreadSize, size ); 
   ArrayFill( spreadSize, 0, size, avgSpread );
   p_maxSpread = NormalizeDouble( MaxSpread * Point, m_digit );   
   lotSize(); 
   HideTestIndicators( true );
   return ( 0 );
}  

void commission(){   
   int count = 0;
   for( int pos = OrdersHistoryTotal() - 1; pos >= 0; pos-- ) {
      if( OrderSelect( pos, SELECT_BY_POS, MODE_HISTORY ) ) {
         if( OrderProfit() != 0.0 ) {
            if( OrderClosePrice() != OrderOpenPrice() ) {
               if( OrderSymbol() == Symbol() ) { 
                  rate = MathAbs( OrderProfit() / MathAbs( OrderClosePrice() - OrderOpenPrice() ) );
                  commissionPoints = ( -OrderCommission() ) / rate;
                  break; 
               }
            }
         }
      }
   }  
} 

double mapValue( double actualSource, double minSource, double maxSource, double minDestination, double maxDestination ){  
   if( ( maxSource - minSource ) == 0 ) return ( maxDestination ); 
   double map = minDestination + ( ( actualSource - minSource ) / ( maxSource - minSource ) * ( maxDestination - minDestination ) ); 
   double clamp = MathMin( MathMax( minDestination, map ), maxDestination );
   if( minDestination > maxDestination ) clamp = MathMax( MathMin( minDestination, map ), maxDestination ); 
   return ( clamp ); 
} 

int start() { 
   tcount++;  
   if( rate == 0 ) commission();
   prepareSpread(); 
   
   int ticket, ot;
   
   int timeCurrent = ( int ) TimeCurrent(); 
   int totalBuyStop = 0;
   int totalSellStop = 0;  
   int buys = 0; 
   int sells = 0; 
   int totalUnprotectedBuy = 0; 
   int totalUnprotectedSell = 0;
   
   double ol, osl, otp, oop, price, stoploss, target, absProfit, startTrailing; 
   
   target = 0.0;   
   
   double priceLotsBuy = 0;
   double totalOpenLotsBuy = 0;
   double priceLotsSell = 0;
   double totalOpenLotsSell = 0;
   double avgOpenPriceBuy=0;
   double avgOpenPriceSell=0;
   double lowestBuyPrice = 99999;
   double highestSellPrice = 0;
   
   for( int pos = OrdersTotal() - 1; pos >= 0; pos-- ) { 
      r = OrderSelect( pos, SELECT_BY_POS, MODE_TRADES ); 
      if( OrderSymbol() != Symbol() || OrderMagicNumber() != MagicNumber ) continue;  
      osl = OrderStopLoss(); 
      oop = OrderOpenPrice();
      otp = OrderTakeProfit();
      ot = OrderTicket();
      ol = OrderLots();
      switch ( OrderType() ) {
         case OP_BUYSTOP:  
            totalBuyStop++;
            totalUnprotectedBuy++;
         break;
         case OP_SELLSTOP:  
            totalSellStop++; 
            totalUnprotectedSell++;
         break;
         case OP_BUY:    
            buys++; 
            if( osl == 0 || ( osl > 0 && osl < oop ) ) totalUnprotectedBuy++; 
            p_buyStoploss = osl; 
            priceLotsBuy += OrderOpenPrice() * OrderLots();
            totalOpenLotsBuy += OrderLots();
            if( OrderOpenPrice() < lowestBuyPrice )
               lowestBuyPrice = OrderOpenPrice();
         break;
         case OP_SELL:    
            sells++; 
            if( osl == 0 || ( osl > 0 && osl > oop ) ) totalUnprotectedSell++;  
            p_sellStoploss = osl; 
            if( OrderOpenPrice() > highestSellPrice )
               highestSellPrice = OrderOpenPrice();
            priceLotsSell += OrderOpenPrice() * OrderLots();
            totalOpenLotsSell += OrderLots();
         break;
      } 
   }    
   
   if( totalOpenLotsBuy > 0 ) avgOpenPriceBuy = NormalizeDouble( priceLotsBuy / totalOpenLotsBuy, m_digit );
   if( totalOpenLotsSell > 0 ) avgOpenPriceSell = NormalizeDouble( priceLotsSell / totalOpenLotsSell, m_digit ); 
   
   //for( int pos = OrdersTotal() - 1; pos >= 0; pos-- ) { 
   //   r = OrderSelect( pos, SELECT_BY_POS, MODE_TRADES ); 
   //   if( OrderSymbol() != Symbol() || OrderMagicNumber() != MagicNumber ) continue; 
   //   osl = OrderStopLoss(); 
   //   oop = OrderOpenPrice();
   //   otp = OrderTakeProfit();
   //   ot = OrderTicket();  
   //   switch ( OrderType() ) {
   //      case OP_BUYSTOP: 
   //         if( Terminal == 0 ){ 
   //            if( p_totalSpread > p_maxSpread || !CheckTime() ) {
   //               r = OrderDelete( ot );
   //            } else if( timeCurrent - lastBuyOrder > Secs 
   //                        || ( tcount % TickModulus == 0 
   //                        && ( ( buys < 1 && oop - Ask < p_signalDistance ) 
   //                        || oop - Ask < p_aggressiveDistance 
   //                        || oop - Ask > p_maxSignalDistance ) ) ){ 
   //               if( buys > 0 ){
   //                  price = NormalizeDouble( Ask + MathMax( ( p_orderDistance / Aggressive ), p_stoplevel ), m_digit );
   //                  stoploss = p_buyStoploss;
   //               } else {
   //                  price = NormalizeDouble( Ask + MathMax( p_orderDistance, p_stoplevel ), m_digit ); 
   //                  stoploss = NormalizeDouble( price - p_stopDistance, m_digit ); 
   //               } 
   //               if( ( ( buys > 0 && price > avgOpenPriceBuy ) || buys == 0 ) && price != oop && oop - Ask > p_freezelevel ){
   //                  r = OrderModify( ot, price, stoploss, target, 0 ); 
   //                  if( r ) lastBuyOrder = timeCurrent; 
   //               }
   //            }  
   //         }
   //      break;
   //      case OP_SELLSTOP:    
   //         if( Terminal == 0 ){ 
   //            if( p_totalSpread > p_maxSpread || !CheckTime() )
   //               r = OrderDelete( ot ); 
   //            else if( timeCurrent - lastSellOrder > Secs 
   //                     || ( tcount % TickModulus == 0 
   //                     && ( ( sells < 1 && Bid - oop < p_signalDistance ) 
   //                     || Bid - oop < p_aggressiveDistance 
   //                     || Bid - oop > p_maxSignalDistance ) ) ){ 
   //               if( sells > 0 ){
   //                  price = NormalizeDouble( Bid - MathMax( ( p_orderDistance / Aggressive ), p_stoplevel ), m_digit ); 
   //                  stoploss = p_sellStoploss;
   //               } else {
   //                  price = NormalizeDouble( Bid - MathMax( p_orderDistance, p_stoplevel ), m_digit ); 
   //                  stoploss = NormalizeDouble( price + p_stopDistance, m_digit ); 
   //               } 
   //               if( ( ( sells > 0 && price < avgOpenPriceSell ) || sells == 0 ) && price != oop && Bid - oop > p_freezelevel ){
   //                  r = OrderModify( ot, price, stoploss, target, 0 ); 
   //                  if( r ) lastSellOrder = timeCurrent; 
   //               }
   //            }  
   //         }
   //      break;
   //      case OP_BUY:      
   //         absProfit = MathMax( Bid - oop + commissionPoints, 0 );
   //         p_mapTrailing = MathMax( mapValue( absProfit, 0.0, m_trailingtarget, m_mintrailing, m_maxtrailing ), p_stoplevel );
   //         stoploss = NormalizeDouble( Bid - p_mapTrailing, m_digit ); 
   //         startTrailing = oop + commissionPoints + m_trailingstart; 
   //         if( Bid - startTrailing > p_mapTrailing ){  
   //            if( osl == 0.0 || Bid - osl > p_mapTrailing )
   //               if( stoploss != osl ){
   //                  r = OrderModify( ot, oop, stoploss, otp, 0 );
   //               }
   //         }   
   //      break;
   //      case OP_SELL:   
   //         absProfit = MathMax( oop - Ask - commissionPoints, 0 );
   //         p_mapTrailing = MathMax( mapValue( absProfit, 0.0, m_trailingtarget, m_mintrailing, m_maxtrailing ), p_stoplevel );
   //         stoploss = NormalizeDouble( Ask + p_mapTrailing, m_digit ); 
   //         startTrailing = oop - commissionPoints - m_trailingstart;
   //         if( startTrailing - Ask > p_mapTrailing ){  
   //            if( osl == 0.0 || osl - Ask > p_mapTrailing ) 
   //               if( stoploss != osl ){
   //                  r = OrderModify( ot, oop, stoploss, otp, 0 ); 
   //               }                   
   //         }    
   //      break;
   //   }   
   //}      
 
   if( ( ( Aggressive > 1 && totalUnprotectedBuy < 1 ) || buys < 1 ) && totalBuyStop < 1 && p_totalSpread <= p_maxSpread && timeCurrent - lastTradeRequest > TradeInterval && CheckTime() && Terminal == 0 ) {  
      if( AccountFreeMarginCheck( Symbol(), OP_BUY, lotSize() ) <= 0 || GetLastError() == 134 ){  
         return ( 0 );
      }  
      price = NormalizeDouble( Ask + MathMax( p_orderDistance, p_stoplevel ), m_digit ); 
      if( buys > 0 )
         stoploss = p_buyStoploss;
      else stoploss = NormalizeDouble( price - p_stopDistance, m_digit );  
      ticket = OrderSend( Symbol(), OP_BUYSTOP, lotSize, price, Slippage, stoploss, price+Tp*10*Point, TradeComment, MagicNumber );
      if( ticket ){
         lastBuyOrder = timeCurrent;
         lastTradeRequest = lastBuyOrder;
      }
   }   
   if( ( ( Aggressive > 1 && totalUnprotectedSell < 1 ) || sells < 1 ) && totalSellStop < 1 && p_totalSpread <= p_maxSpread && timeCurrent - lastTradeRequest > TradeInterval && CheckTime() && Terminal == 0 ) { 
      if( AccountFreeMarginCheck( Symbol(), OP_SELL, lotSize() ) <= 0 || GetLastError() == 134 ){  
         return ( 0 );
      }  
      price = NormalizeDouble( Bid - MathMax( p_orderDistance, p_stoplevel ), m_digit ); 
      if( sells > 0 )
         stoploss = p_sellStoploss;
      else stoploss = NormalizeDouble( price + p_stopDistance, m_digit );  
      ticket = OrderSend( Symbol(), OP_SELLSTOP, lotSize, price, Slippage, stoploss, price-Tp*10*Point, TradeComment, MagicNumber );
      if( ticket ) {
         lastSellOrder = timeCurrent;
         lastTradeRequest = lastSellOrder; 
      }
   }     
    ObjectsDeleteAll(); 
   return ( 0 );
}

bool CheckTime() {
   if( ( Hour() > StartHour && Hour() < EndHour ) || Hour() == StartHour || Hour() == EndHour ) return ( true );
   return ( false );
} 

double lotSize(){   
   if( FixedLot > 0 ){ 
      lotSize = MathCeil( FixedLot / lotstep ) * lotstep;
      return ( NormalizeLots( lotSize ) );
   } else {
      if( marginRequirement > 0 ) 
         lotSize = MathMax( MathMin( NormalizeDouble( ( AccountBalance() * ( ( double ) RiskPercent / 100 ) * minLot / marginRequirement ), 2 ), maxLot ), minLot );    
      return ( NormalizeLots( lotSize ) );  
   }
}  

double NormalizeLots( double amount ){ 
    return( MathRound( amount / lotstep ) * lotstep );
}

void prepareSpread(){
   //if( tcount % TickModulus == 0 ){
      //if( !IsTesting() ){
         double spreadSize_temp[];
         ArrayResize( spreadSize_temp, size - 1 );
         ArrayCopy( spreadSize_temp, spreadSize, 0, 1, size - 1 );
         ArrayResize( spreadSize_temp, size ); 
         spreadSize_temp[size-1] = NormalizeDouble( Ask - Bid, m_digit ); 
         ArrayCopy( spreadSize, spreadSize_temp, 0, 0 ); 
         avgSpread = iMAOnArray( spreadSize, size, size, 0, MODE_LWMA, 0 );   
      //}
      p_totalSpread = MathMax( avgSpread + commissionPoints, MinMeasure * p_point );  
      p_orderDistance = MathMax( p_totalSpread * Delta, p_stoplevel );   
      //p_takeProfit = MathMax( p_totalSpread * TakeProfit, p_stoplevel ); 
      p_signalDistance = MathMax( p_totalSpread * Signal, p_freezelevel );
      //m_mintrailing = MathMax( p_totalSpread * MinTrailing, p_stoplevel );
      m_maxtrailing = p_totalSpread * MaxTrailing;  
      //m_trailingstart = p_totalSpread * TrailingStart;
      m_trailingtarget = p_totalSpread * TrailingTarget;
      p_maxSignalDistance = p_totalSpread * MaxDistance;
      p_aggressiveDistance = p_signalDistance / Aggressive;
      p_stopDistance = MathMax( ( p_totalSpread * Stop ), p_stoplevel );  
   //}
}  

// normalize lots calc risk %
// aggressive trade calculated to bring breakeven closer and open as market order
// only trail if greater than equity highest balance
