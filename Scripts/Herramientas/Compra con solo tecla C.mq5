//+------------------------------------------------------------------+
//|                                             Compra con tecla.mq5 |
//|                                                              eli |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//prototipo en la qu se pone una orden pendiente
#property copyright "eli"
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <MoneyManagement1.mqh>
#include <trade\trade.mqh>
CTrade trade;

//para el money management tengo que hacer un stop points, entonces lo que debo hacer es hacer nua diferencia entre la orden establecida y tambien el minimo o maximo de la barra

//+------------------------------------------------------------------+
//| Script program start function                                    | ademas podemos ver como programar el tiempo de expiracion de la orden a fin de ver si esti es viable o no 
//+------------------------------------------------------------------+ debemos programar la expiracion a fin de zafar de los patrones que no funcan.

// -- 7/9 -- voy a programar para que la orden pendiente de buy stop en mi caso desaparesca ni bien ocurra otra barra, a fin de que si por ejemplo veo un smash que no sale , en la siguiente barra esta orden desaparesca de la faz de la tierra de manera automatica.
// de esta manera puedo prevenir olvidos y errores de por ejemplo no ver el mercado por un dia. Por cualquier cosa lo hago espero no sea demasiado complicado.


// Función para comprobar si estamos en una nueva vela: la idea es que si se comprueba como true entonces la orden colocada se borre la orden creo que no se podra ya que necesitamos la funcion on tick, que cada tick  o cada tantos (ojo que te bloquean) se fije si paso una nueva barra si es asi entonces que lo cierre)
int bars;
bool nueva_barra()
  {
   int current_bars = Bars(_Symbol, _Period); // si no funciona sigue sin abri ordenes entonces mandale  M15.
   if(current_bars != bars)
     {
      bars = current_bars;
      return true;
     }

   return false;
  }

void OnStart()
  {
//---
   double t_predeterm = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);
   double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   double spread = ask - bid;

   MqlRates rates[];
   ArraySetAsSeries(rates, true);
   CopyRates(_Symbol, _Period, 0, 5, rates);
  
  double diferencia = (rates[1].high + spread) - (rates[1].low - spread);
  double  tradeSize = MoneyManagement(_Symbol, t_predeterm, 1, diferencia); // 1% del balance
  
  trade.BuyStop(tradeSize, rates[1].high + spread, _Symbol, rates[1].low - spread);
   
   
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

//funciona bien cuando el precio esta por encima de lo que es el maximo es un problema porque no habre nada