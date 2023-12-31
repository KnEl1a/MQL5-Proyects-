#include <Trade\Trade.mqh>
#include <MoneyManagement1.mqh>
// vamos a probar el patron con todas las probabildiades que se puedan a nuestro favor
datetime lastBarTime = 0;

int Smash_alcista = 0;
int Smash_alcista1 = 0;

CTrade trade; 
ulong trade_ticket;

//--------EMAS--------------

int SMA_20_h; //emas de precio tipico
int SMA_50_h; //emas de precio tipico
int SMA_200_h;
int WPR_h;


double SMA_20[];
double SMA_50[];
double SMA_200[];
double WPR[];



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

   SMA_20_h = iMA(_Symbol, _Period, 20, 0, MODE_SMA, PRICE_CLOSE);
   SMA_50_h = iMA(_Symbol, _Period, 50, 0, MODE_SMA, PRICE_CLOSE);
   SMA_200_h = iMA(_Symbol, _Period, 200, 0, MODE_SMA, PRICE_CLOSE);
   WPR_h= iWPR(_Symbol, _Period, 13);
  
   
      if( WPR_h == INVALID_HANDLE || SMA_20_h == INVALID_HANDLE || SMA_200_h == INVALID_HANDLE|| SMA_50_h == INVALID_HANDLE ) //por el momento solo pruebo un smash day y de ahi lo vamos filtrando para tratar de entrear en momentos mas oportunos
     {
      Print("Error loading the indicators");
      return INIT_FAILED;
     }
     

  ArraySetAsSeries(SMA_20, true);
  ArraySetAsSeries(SMA_50, true);
  ArraySetAsSeries(SMA_200, true);
  ArraySetAsSeries(WPR, true);
 
   
   return INIT_SUCCEEDED;
  }
  
  void OnDeinit(const int reason)
  {
  
   if(SMA_20_h != INVALID_HANDLE)
      IndicatorRelease(SMA_20_h);
   if(SMA_50_h!= INVALID_HANDLE)
      IndicatorRelease(SMA_50_h);
   if(SMA_200_h!= INVALID_HANDLE)
      IndicatorRelease(SMA_200_h);
   if(WPR_h != INVALID_HANDLE)
      IndicatorRelease(WPR_h);
  }


void OnTick()
  {
  
  
   CopyBuffer(SMA_20_h, 0, 0, 7, SMA_20);
   CopyBuffer(SMA_50_h, 0, 0, 7, SMA_50);
   CopyBuffer(SMA_200_h, 0, 0, 7, SMA_200);
   CopyBuffer(WPR_h, 0, 0, 7, WPR);

  
  double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
  double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
  double spread = NormalizeDouble(ask - bid,_Digits); 
  
  
  
   CopyRates(_Symbol, _Period, 0,10, infoprecio);
   double Rango_mitad_delaBarra = NormalizeDouble(((infoprecio[1].high + spread) - (infoprecio[1].low - spread))/130, _Digits); // donde el denominador es 100 era un 2 en lugar de eso o sea la mitad del rango 
   
   
   //double rango = NormalizeDouble((ask - (infoprecio[1].low - spread)), _Digits);
  
   //smash Bar alcista // + tendencia alcista
   if (WPR[1] < -79.5 && SMA_200[1]<SMA_50[1] &&   SMA_20[1]>SMA_50[1]) {
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
   if (WPR[1] > -20.5 && SMA_200[1]>SMA_50[1] &&   SMA_20[1]<SMA_50[1]) {
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
 
 
    if(infoprecio[2].close < SMA_20[2] &&infoprecio[1].close > SMA_20[1] && PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
   {
   trade.PositionClose(PositionGetTicket(0));   
   }
   
   if(infoprecio[2].close > SMA_20[2] && infoprecio[1].close < SMA_20[1] && PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
   {
   trade.PositionClose(PositionGetTicket(0));   
   }
 
 
 }
 
 //este es el probador para no intervenir directamente en el main
 
 // tengo que probar el trailing stop 