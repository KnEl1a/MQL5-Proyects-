//+------------------------------------------------------------------+
//|                                        Ups con tecla alcista.mq5 |
//|                                                              eli |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "eli"
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <MoneyManagement1.mqh>
#include <trade\trade.mqh>
CTrade trade;

int atr_h;
double atr[];

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   atr_h = iATR(_Symbol, _Period, 4);
   ArraySetAsSeries(atr, true);
   CopyBuffer(atr_h, 0,0,5,atr);

   double t_predeterm = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);
   double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   double spread = ask - bid;

   MqlRates rates[];
   ArraySetAsSeries(rates, true);
   CopyRates(_Symbol, _Period, 0, 5, rates);

   double stoploss = MathAbs((rates[1].high + spread)+(atr[1]* 65/100));

   double diferencia = (rates[1].high + spread) - (rates[1].low - spread);
   double  tradeSize = MoneyManagement(_Symbol, t_predeterm, 1, diferencia);


   trade.SellStop(tradeSize, rates[1].high + spread, _Symbol, (rates[1].high + spread)+(atr[1]* 65/100));
//no comprobado ve mañana.
//no comprobado la gestion monetaria.

//si funciona y coloca orden auotomaticamente a un de un 65 % del atr de 4 periodos.

  }
//+------------------------------------------------------------------+
