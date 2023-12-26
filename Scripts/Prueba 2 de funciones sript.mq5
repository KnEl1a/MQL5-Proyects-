//+------------------------------------------------------------------+
//|                                  Prueba 2 de funciones sript.mq5 |
//|                                                            elias |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "elias"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

MqlRates infoprecio[];

double  ask = 0;
double  bid = 0;
double  spread = 0;

void OnStart()
  {
//---
 ArraySetAsSeries(infoprecio,true);
   CopyRates(_Symbol, PERIOD_CURRENT, 0, 10, infoprecio);
   
    ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
    bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
    spread = ask - bid; 

   
   Print("el infoprecio low. ", infoprecio[1].low);
   Print("el infoprecio high. ", infoprecio[1].high);
   Print("la diferencia es " , dif(infoprecio[1].high, infoprecio[1].low));
   Print("el spread es ", infoprecio[0].spread, " o segun esto otro es ", spread);
  }
  
 
double dif(double a, double b)
{
double result = a - b;
return result;
}

//+------------------------------------------------------------------+
