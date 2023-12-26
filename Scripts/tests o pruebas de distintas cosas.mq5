//+------------------------------------------------------------------+
//|                           tests o pruebas de distintas cosas.mq5 |
//|                                                              eli |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "eli"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
MqlRates rates[];
ArraySetAsSeries(rates,true);
CopyRates(_Symbol, _Period, 0, 5, rates);

int diferencia = rates[1].high - rates[1].low;

Print("diferencia high -lw: ", diferencia);
  // bien me lo da directamente en stop points como yo quiero
  }
//+------------------------------------------------------------------+
