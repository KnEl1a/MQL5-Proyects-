//+------------------------------------------------------------------+
//|                                            Calculo de spread.mq5 |
//|                                                     elias Prueba |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "elias Prueba"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
double spread = SymbolInfoInteger(_Symbol , SYMBOL_SPREAD) * _Point; 
double spread2 = SymbolInfoInteger(_Symbol , SYMBOL_SPREAD);

void OnStart()
  {
//---
    // te sirve para calcular stop mas precisos teniendo en cuenta los diferenciales.
 
   Print("spread *_point: ", spread);
   
   Print("spread : ", spread2);
   
   
  }
//+------------------------------------------------------------------+
