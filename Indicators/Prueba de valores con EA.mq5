//+------------------------------------------------------------------+
//|                                     Prueba de valores con EA.mq5 |
//|                                                            elias |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//de donde extraigo los valores para el roc, como ? eso es lo que voy a averiguar acá
#property copyright " elias"
#property link      "https://www.mql5.com"
#property version   "1.00"

double roc[];
int roc_h;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
    roc_h = iCustom(_Symbol, _Period, "Examples\\ROC.ex5",9); // se encuentra en la carpeta Examples
   if(roc_h== INVALID_HANDLE)
     {
      Print("Error al iniciar el indicador");
      return INIT_FAILED;
     }
   ArraySetAsSeries(roc, true);
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   if(roc_h != INVALID_HANDLE) IndicatorRelease(roc_h);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
CopyBuffer(roc_h, 0,1,5, roc);

Print("valores del roc: ", roc[0]);
   
  }
//+------------------------------------------------------------------+
