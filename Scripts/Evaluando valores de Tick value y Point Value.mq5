//+------------------------------------------------------------------+
//|                Evaluando valores de Tick value y Point Value.mq5 |
//|                                                            Elias |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Elias"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
int ATR_h;
double ATR[];

void OnStart()
  {
//---
   ATR_h = iATR(_Symbol, PERIOD_CURRENT, 20);
   ArraySetAsSeries(ATR,true);

   CopyBuffer(ATR_h, 0, 0, 4, ATR);
   
   double tickSize = SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_VALUE);
   double PointValue = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
   
   Print("el valor de un tick es : ", tickSize);
   Print("el valor de Symbol_Pint es  : ", PointValue);
   Print("el tick value por volatilidaad es : ", tickSize * ATR[1]);
   Print("el valor de un ATR[1] es ",ATR[1]);
   
   
  }
//+------------------------------------------------------------------+
