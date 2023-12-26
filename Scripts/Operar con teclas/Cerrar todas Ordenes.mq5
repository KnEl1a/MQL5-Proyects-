//+------------------------------------------------------------------+
//|                                         Cerrar todas Ordenes.mq5 |
//|                                                              eli |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "eli"
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <Trade\Trade.mqh>
CTrade trade;

//cerrar todas las ordenes

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   int a = OrdersTotal();
   while(a!=0)
   {
      ulong Ticket = OrderGetTicket(OrdersTotal()-1);
      trade.OrderDelete(Ticket);
      a--;
   }
   
   
  }
//+------------------------------------------------------------------+
