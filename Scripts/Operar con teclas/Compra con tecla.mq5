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