//+------------------------------------------------------------------+
//|                                                       Spread.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "2.0"
#property description "fallido quer¿ia meterle el valor de pip abajo del de spread"
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const int begin,
                const double &price[])
  {
//---

   string symbol = Symbol(); // Obtiene el nombre del símbolo actual
   double contractSize = SymbolInfoDouble(symbol, SYMBOL_TRADE_CONTRACT_SIZE); // Tamaño mínimo del contrato
   double pointSize = (SymbolInfoDouble(symbol, SYMBOL_POINT))*10; // Tamaño del punto (pip) para el símbolo
   double pipValue = contractSize * pointSize;

   MqlRates valores[];
   CopyRates(Symbol(),PERIOD_CURRENT,0,1,valores);
   MqlRates valores2[];
   CopyRates(Symbol(),PERIOD_CURRENT,1,1,valores2);

   ObjectCreate(0,"spread",OBJ_TEXT,0,valores[0].time,SymbolInfoDouble(_Symbol,SYMBOL_BID));
   ObjectSetString(0,"spread",OBJPROP_TEXT,"    Spread:  "+SymbolInfoInteger(Symbol(),SYMBOL_SPREAD));
   ObjectSetInteger(0,"spread",OBJPROP_COLOR,clrAquamarine);
   ObjectGetInteger(0,"spread",OBJPROP_FONTSIZE,14);

   ObjectCreate(0,"Valor de pip",OBJ_TEXT,1,valores2[0].time,1.1196);
   ObjectSetString(0,"Valor de pip",OBJPROP_TEXT,"    Valor de pip:  "+ 1.12020);
   ObjectSetInteger(0,"Valor de pip",OBJPROP_COLOR,clrAliceBlue);
   ObjectGetInteger(0,"Valor de pip",OBJPROP_FONTSIZE,13);

//--- return value of prev_calculated for next call
   return(0);
  }
//+------------------------------------------------------------------+
