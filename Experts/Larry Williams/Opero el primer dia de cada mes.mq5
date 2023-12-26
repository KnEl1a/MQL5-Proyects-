
#property copyright "elias Prueba1 .0 - LArry williams"
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <trade\trade.mqh>

CTrade trade;
double ask;
double bid;

ulong trade_ticket;
//segun el solo operar en el s&p 500 el primer dia de cada mes
// si opera pero cierra encegida

bool operacion_cerrada()
{
  return !PositionSelectByTicket(trade_ticket);
}
bool operacion_abierta()
{
  return PositionSelectByTicket(trade_ticket);
}

int bars;
bool nueva_vela_diaria() {
   int current_bars = Bars("US500", PERIOD_D1);
   if (current_bars != bars) {
      bars = current_bars;
      return true;
   }
   
   return false;
}

int barsM;
bool nueva_vela_mensual() {
   int current_barsM = Bars("US500", PERIOD_MN1);
   if (current_barsM != barsM) {
      barsM = current_barsM;//abria muchas operaciones por lo que cambie esta parte
      return true;
   }
   return false;
}



void OnTick()
{
   ask = NormalizeDouble(SymbolInfoDouble("US500" , SYMBOL_ASK),_Digits);
   
   bid = NormalizeDouble(SymbolInfoDouble("US500", SYMBOL_BID),_Digits);
   
   if (operacion_cerrada() && nueva_vela_mensual())
   {
   trade.Buy(0.1, "US500", ask);
    trade_ticket = trade.ResultOrder();
   }
   
   if(nueva_vela_diaria() && operacion_abierta())
   {
      trade.PositionClose(trade_ticket);
   }
   
}
//
//void OnTimer()
//{
//if(operacion_cerrada())
//   {
//   trade.Buy(0.1, "US500", ask, ask - 600*_Point, ask + 1200*_Point, "orden abierta");
//   trade_ticket = trade.ResultOrder();
//   }
//}