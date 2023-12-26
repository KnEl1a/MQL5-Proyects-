//+------------------------------------------------------------------+
//|                                                       Spread.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
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
    MqlRates valores[];
   CopyRates(Symbol(),PERIOD_CURRENT,0,1,valores);
   
   ObjectCreate(0,"spread",OBJ_TEXT,0,valores[0].time,SymbolInfoDouble(_Symbol,SYMBOL_BID));
   ObjectSetString(0,"spread",OBJPROP_TEXT,"    Spread:  "+SymbolInfoInteger(Symbol(),SYMBOL_SPREAD));
   ObjectSetInteger(0,"spread",OBJPROP_COLOR,clrAquamarine);
   ObjectGetInteger(0,"spread",OBJPROP_FONTSIZE,14);
//--- return value of prev_calculated for next call
   return(0);
  }
//+------------------------------------------------------------------+
