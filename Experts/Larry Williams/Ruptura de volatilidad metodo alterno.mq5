//+------------------------------------------------------------------+
//|                        Ruptura de volatilidad metodo alterno.mq5 |
//|                                elias Prueba1 .0 - LArry williams |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//este metodo se calcula el rango de ruptura como la diferencia entre el maxiom de hace 3 dias y el miniomo de ayer, y el maximo de ayer y el minimo de hace 3 dias y entonces el rango de ruptura  mas grande termina siendo el rango elegido
#property copyright "elias Prueba1 .0 - LArry williams"
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <trade\trade.mqh>

CTrade trade;

input int porcentaje_M = 1;
input int ma_period = 1;
ulong trade_ticket;

int ATR_h;

double ATR[];

MqlRates rates[];

double ask;
double bid;
double spread;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool operacion_cerrada()
  {
   return !PositionSelectByTicket(trade_ticket); //Retorna true en caso de que la función se ejecute con éxito o sea encontró op. abierta.
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnInit()
  {
   ATR_h=iATR(_Symbol, PERIOD_CURRENT, ma_period);

   ArraySetAsSeries(ATR, true);
   ArraySetAsSeries(rates, true);

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit()
  {
   if(ATR_h != INVALID_HANDLE)
      IndicatorRelease(ATR_h);
   SymbolInfoDouble(_Symbol, SYMBOL_EXPIRATION_DAY);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
//precios y spread:
   ask =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
   bid =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
   spread = ask - bid;

//buffers
   CopyBuffer(ATR_h, 0,0,5,ATR);
   CopyRates(_Symbol,PERIOD_CURRENT,0,5,rates);

//claculoos para el rango de ruotura de volatilida alterno La idea de esto es que el rango de ruptura sea superado y este se calculara coomo:
//necesitamos calcular la diferencia de: maximo de hace trees dias menos el minimo de hoy ; y calcular distancia de maximo de hace 1 dia menos el mininmo de hace 3 dias
//usaremos el mayor valor deestos como nueustra medicion de volatilidad.

//voy a crear dos variables una si es mayor a otra sera la medicion de volatilidad

//apertura de ordenes

//Comment("la medicion de volatilidad es: ", medicion()); // funciona bien
//Print("el atr es : ",ATR[1]); // funciona bien.

   if(ask > (rates[0].open + medicion()) && operacion_cerrada())
     {
      trade.Buy(0.1, _Symbol,ask, rates[0].open - ATR[1], rates[0].open + ATR[1]*3);
      trade_ticket = trade.ResultOrder();
     }
   else
      if(bid < (rates[0].open - medicion()) && operacion_cerrada())
        {
         trade.Sell(0.1,_Symbol,bid, rates[0].open + ATR[1], rates[0].open - ATR[1]*3);
         trade_ticket = trade.ResultOrder();//avisameos de q se ejecuto una orden.
        }

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double medicion() // de ultima si no funciona entonce lo que tenes q hacer es sacar esto e implemnentarlo en ontick.
  {
   double medicion1 = MathAbs(rates[3].high - rates[1].low);
   double medicion2 = MathAbs(rates[1].high - rates[3].low);
   double medicion_definitiva;
   if(medicion1 > medicion2) medicion_definitiva = medicion1;
   else if(medicion2 > medicion1) medicion_definitiva = medicion2;

   return (NormalizeDouble(medicion_definitiva,_Digits));
  }
//+------------------------------------------------------------------+
