//+------------------------------------------------------------------+
//|                                venta directa con tecla alt 0.mq5 |
//|                                                              eli |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "eli"
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <MoneyManagement1.mqh>
#include <trade\trade.mqh>
CTrade trade;


//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
/*
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
  
  int diferencia = MathAbs((rates[1].high + spread) - (bid)); // acá creo que esta el error
  Print("el valor de diferencia es: ", diferencia);
  double  tradeSize = MoneyManagement(_Symbol, t_predeterm, 1, diferencia); // 1% del balance
  
  trade.Sell(tradeSize, _Symbol, bid,  rates[1].high + spread);
   //no me esta funcionando la gestion monetaria , asi que voy tratar de entender los fundamentos , repasando el capitulo
   
   //no funciona la gestion del capital, eso tenes que investigar y tratar de mejorar, para que arriegue bien ese 1 %, de tu balance
  }
//+------------------------------------------------------------------+
*/

//prueba
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
  
  int diferencia = MathAbs((rates[1].high + spread) - (bid)); // acá creo que esta el error
  Print("el valor de diferencia es: ", diferencia);
  double  tradeSize = MoneyManagement(_Symbol, t_predeterm, 1, diferencia); // 1% del balance
  
  trade.Sell(tradeSize, _Symbol, bid,  rates[1].high + spread);
   //no me esta funcionando la gestion monetaria , asi que voy tratar de entender los fundamentos , repasando el capitulo
   
   //no funciona la gestion del capital, eso tenes que investigar y tratar de mejorar, para que arriegue bien ese 1 %, de tu balance
  }
//+------------------------------------------------------------------+