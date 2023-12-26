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
  
  double dif = StopPriceToPoints(_Symbol, rates[1].high + spread, bid);//ponemos los parametros para ello
  double  tradeSize = MoneyManagement(_Symbol, t_predeterm, 1, dif); // 1% del balance
  
  trade.Sell(tradeSize, _Symbol, bid,  rates[1].high + spread);
   
   
  }
//+------------------------------------------------------------------+
