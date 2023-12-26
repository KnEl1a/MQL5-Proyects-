//+------------------------------------------------------------------+
//|                                          Cerrar ultima orden.mq5 |
//|                                                              eli |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "eli"
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <Trade\Trade.mqh>
CTrade trade;

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   trade.PositionClose(PositionGetTicket(0));   
  }
//+------------------------------------------------------------------+
