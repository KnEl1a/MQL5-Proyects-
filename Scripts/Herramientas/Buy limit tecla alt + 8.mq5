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
  
  //en el caso de que la apertura este alta y esperas una reversion al maximo ...
  //basicamente no tuve que modificar nada ya esta ...
  trade.BuyLimit(tradeSize, rates[1].high + spread, _Symbol, rates[1].low - spread);
   
   
  }