//+------------------------------------------------------------------+
//|                                    Venta con tecla sell stop.mq5 |
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

   trade.SellLimit(tradeSize, rates[1].low - spread, _Symbol, rates[1].high + spread);

  }
//+------------------------------------------------------------------+
