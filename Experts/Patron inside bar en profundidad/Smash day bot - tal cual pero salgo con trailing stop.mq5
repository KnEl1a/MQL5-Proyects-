#include <Trade\Trade.mqh>
#include <MoneyManagement1.mqh>
// vamos a probar el patron con todas las probabildiades que se puedan a nuestro favor
datetime lastBarTime = 0;

int Smash_alcista = 0;
int Smash_alcista1 = 0;

CTrade trade; 
ulong trade_ticket;

//--------EMAS--------------

int EMA_50_h; //emas de precio tipico
int EMA_250_h;
int WPR_h;
int ATR_h;
int vol_h;

double EMA_50[];
double EMA_250[];
double WPR[];
double ATR[];
double vol[];




//Money management
double t_predeterm = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);
input int MM_Percentage = 1;// porcentaje de riesgo del balance

//-------------------------

//uso tambien 

int bars; // creo que si no le especificamos entonces es 0

bool nueva_vela()
  {
   int current_bars = Bars(_Symbol, _Period);
   if(current_bars != bars)
     {
      bars = current_bars;
      return true;
     }

   return false;
  }


// Función para verificar si ha nacido una nueva barra
/* bool isNewBar() {
    datetime currentBarTime = iTime(_Symbol, PERIOD_CURRENT, 0);
    if (currentBarTime > lastBarTime) {
        lastBarTime = currentBarTime;
        return true;
    }
    return false;
}*/

MqlRates infoprecio[];

int OnInit()
  {
   MqlTradeRequest request;
   MqlTradeResult result;
   ArraySetAsSeries(infoprecio,true);

   EMA_50_h = iMA(_Symbol, _Period, 50, 0, MODE_EMA, PRICE_TYPICAL);
   EMA_250_h = iMA(_Symbol, _Period, 250, 0, MODE_SMA, PRICE_TYPICAL);
   WPR_h= iWPR(_Symbol, _Period, 14);
   vol_h = iVolumes(_Symbol, _Period, VOLUME_TICK);
   ATR_h = iATR(_Symbol, _Period, 14);
   
      if(vol_h == INVALID_HANDLE || ATR_h == INVALID_HANDLE || WPR_h == INVALID_HANDLE ||EMA_50_h == INVALID_HANDLE || EMA_250_h == INVALID_HANDLE) //por el momento solo pruebo un smash day y de ahi lo vamos filtrando para tratar de entrear en momentos mas oportunos
     {
      Print("Error loading the indicators");
      return INIT_FAILED;
     }
     

  ArraySetAsSeries(EMA_50, true);
  ArraySetAsSeries(EMA_250, true);
  ArraySetAsSeries(WPR, true);
  ArraySetAsSeries(ATR, true);
  ArraySetAsSeries(vol, true);
   
   return INIT_SUCCEEDED;
  }
  
  void OnDeinit(const int reason)
  {
  
   if(EMA_50_h != INVALID_HANDLE)
      IndicatorRelease(EMA_50_h);
   if(EMA_250_h != INVALID_HANDLE)
      IndicatorRelease(EMA_250_h);
   if(WPR_h != INVALID_HANDLE)
      IndicatorRelease(WPR_h);
   if(ATR_h != INVALID_HANDLE)
      IndicatorRelease(ATR_h);
   if(vol_h != INVALID_HANDLE)
      IndicatorRelease(vol_h);
  }


void OnTick()
  {
  
  
   CopyBuffer(EMA_50_h, 0, 0, 7, EMA_50);
   CopyBuffer(EMA_250_h, 0, 0, 7, EMA_250);
   CopyBuffer(WPR_h, 0, 0, 7, WPR);
   CopyBuffer(vol_h, 0, 0, 7, vol);
   CopyBuffer(ATR_h, 0, 0, 7, ATR);
  
  double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
  double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
  double spread = NormalizeDouble(ask - bid,_Digits); 
  
  
  
   CopyRates(_Symbol, _Period, 0,10, infoprecio);
   double Rango_mitad_delaBarra = NormalizeDouble(((infoprecio[1].high + spread) - (infoprecio[1].low - spread))/130, _Digits); // donde el denominador es 100 era un 2 en lugar de eso o sea la mitad del rango 
   
   
   //double rango = NormalizeDouble((ask - (infoprecio[1].low - spread)), _Digits);
  
   //smash Bar alcista // + tendencia alcista
   if (WPR[1] < -79.5 && vol[1]>vol[2]) {
   if((((infoprecio[0].close > infoprecio[1].high) &&
       (infoprecio[1].high > infoprecio[0].open) &&
       (infoprecio[0].open > infoprecio[1].low) &&
       (infoprecio[1].close < infoprecio[2].low) &&
       (infoprecio[1].low < infoprecio[2].low)) ||
      ((infoprecio[0].close < infoprecio[1].high) &&
       (infoprecio[1].high < infoprecio[0].open) &&
       (infoprecio[1].close < infoprecio[2].low) &&
       (infoprecio[1].low < infoprecio[2].low))) &&
      nueva_vela())
{
   Smash_alcista = Smash_alcista + 1;
   Print("smash bar alcista ocurrio: ", infoprecio[1].time, "y su spread o diferencial fue de ", infoprecio[1].spread ); // un lujo , una maravilla el algoritmo
    
   double sl_buy = NormalizeDouble(infoprecio[1].low -  spread, _Digits);
   sl_buy = sl_buy - Rango_mitad_delaBarra;
   double rango_buy = NormalizeDouble((ask - sl_buy), _Digits);
   double tp_buy = NormalizeDouble(ask + rango_buy*3 + spread, _Digits);  
   
   //gestion monetaria compra
   double dif_buy = StopPriceToPoints(_Symbol, sl_buy, ask);
   double  tradeSize_buy = MoneyManagement(_Symbol, t_predeterm, MM_Percentage, dif_buy); // 1% del balance
   
   
   trade.Buy(tradeSize_buy,NULL,ask,sl_buy);
   }
   }
   
   
   // me parece qu eel volumen es clave, creo que tenemos que tenerlo en cueenta orque como dijo couglin es como el combustible, o sea te indica cuando entraron o salieron mas indicando mas movimiento y por lo tanto un incremento en la volatilidad
   //smash Bar bajista // + tendencia bajista
   if (WPR[1] > -20.5 && vol[1]>vol[2]) {
      if((((infoprecio[0].close < infoprecio[1].low) &&
       (infoprecio[1].high > infoprecio[0].open) &&
       (infoprecio[0].open > infoprecio[1].low) &&
       (infoprecio[1].close > infoprecio[2].high) &&
       (infoprecio[1].high > infoprecio[2].high)) ||
      ((infoprecio[0].close > infoprecio[1].low) &&
       (infoprecio[1].low > infoprecio[0].open) &&
       (infoprecio[1].close > infoprecio[2].high) &&
       (infoprecio[1].high > infoprecio[2].high))) &&
      nueva_vela())
   {
    Smash_alcista1 = Smash_alcista1 + 1;
   Print("smash bar bajista ocurrio: ", infoprecio[1].time, "y su spread o diferencial fue de ", infoprecio[1].spread ); // un lujo , una maravilla el algoritmo
   
   double sl_sell = NormalizeDouble(infoprecio[1].high +  spread, _Digits); // el stop es invalido dice
   sl_sell = sl_sell+ Rango_mitad_delaBarra;
   double rango_sell = NormalizeDouble((sl_sell - bid), _Digits); // aca esta el problema este 
   double tp_sell = NormalizeDouble(bid - rango_sell*1.8 - spread, _Digits);  
 
 // - -- - - - - gestion monetaria venta
   
      double dif_sell = StopPriceToPoints(_Symbol, sl_sell, bid);
      double  tradeSize_sell = MoneyManagement(_Symbol, t_predeterm, MM_Percentage, dif_sell); // 1% del balance  //t_predeterm es el volum, minimo
   trade.Sell(tradeSize_sell,NULL,bid,sl_sell);
   }}
   
   //Print("hay una nueva barra ? o el tiempo de hoy es mayor que el de ayer", isNewBar() );
   
   Comment("CANTIDADES\n Doji normal: ",
   "\n smash Bar alcista: ", Smash_alcista,
   "\n smash Bar bajista: ", Smash_alcista1);
   
   for(int i = PositionsTotal() - 1 ; i >= 0 ; i--)
     {
      ulong posTicket = PositionGetTicket(i);
      if(PositionSelectByTicket(posTicket))
        {
         double posSl = PositionGetDouble(POSITION_SL);

         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
           {

            //if((barraH4[1].low - spread - (20*_Point))> posSl)
            if((infoprecio[1].low - spread)> posSl )// creo q es es por ese orders total () == 1 ;)
              {

               trade.PositionModify(posTicket,(infoprecio[1].low - spread), 0);
                 
              }

           }
         else
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
              {
               //if(stoplosssell < posSl || posSl == 0)
               //if((barraH4[1].high + spread + (20*_Point))< posSl)
               if((infoprecio[1].high + spread)< posSl)
                 {

                  trade.PositionModify(posTicket,(infoprecio[1].high + spread), 0); // creo que el stop  de h4 funcionaba  
                    
                 }

              }
        }

     }
   
 
 }
 
 //este es el probador para no intervenir directamente en el main
 
 // tengo que probar el trailing stop 