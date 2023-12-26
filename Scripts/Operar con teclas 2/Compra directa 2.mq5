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



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
//seria la compra de una, con control + c, o sea abro a precio ask , y opngo stop en ultimo minimo
   double t_predeterm = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);
   double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   double spread = ask - bid;

   MqlRates rates[];
   ArraySetAsSeries(rates, true);
   CopyRates(_Symbol, _Period, 0, 5, rates);

   double dif = StopPriceToPoints(_Symbol, rates[1].low - spread, ask);//ponemos los parametros para ello
   double  tradeSize2 = MoneyManagement(_Symbol, t_predeterm, 1, dif); // 1% del balance, si este parece funcionar, el otro que hice yo no.

   trade.Buy(tradeSize2, _Symbol, ask, rates[1].low - spread);

//listo funciono de 10, ahora si puedo arriesgar el 1% de mi capital.
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

//funciona bien cuando el precio esta por encima de lo que es el maximo es un problema porque no habre nada
