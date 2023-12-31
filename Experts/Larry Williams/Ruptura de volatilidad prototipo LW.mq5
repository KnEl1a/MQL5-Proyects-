
#property copyright "elias Prueba1 .0 - LArry williams"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <MoneyManagement1.mqh>
#include <Trade/Trade.mqh>

CTrade trade;

//ATR 
int atr_h;

double atr[];

ulong trade_ticket;
double ask;
double bid;
double spread;
input double porcentaje_rango = 100;
double range;

MqlRates bar[];


bool operacion_cerrada()
  {
   return !PositionSelectByTicket(trade_ticket); //Retorna true en caso de que la función se ejecute con éxito o sea encontró op. abierta.
  }

void OnInit()
{
   atr_h = iATR(_Symbol, _Period, 1); // de esta manera estariamos obteniendo el TR del calculo del atr o sea la diferencia entre el maximo y el minimo en teoria.
   
   ArraySetAsSeries(atr, true);//con este atr de uno obtenemos el TR
   ArraySetAsSeries(bar, true);
}

void OnDeinit(const int reason)
  {
//---
   if(atr_h != INVALID_HANDLE) IndicatorRelease(atr_h);
    
SymbolInfoDouble(_Symbol, SYMBOL_EXPIRATION_DAY);
  }

void OnTick()
{
   ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
   bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   spread = ask - bid;
   
   CopyBuffer(atr_h,0,0,3,atr);
   CopyRates(_Symbol, _Period, 0,3,bar);
   //atrloco=atr[0]/_Point;//asi obteniamos lo que era los puntos de pips para por ejemplo calcular stop loss para el calculo del lotaje
   //atrloco= atr[0]*_Point; no tampoco es lo que estaba buscando la respuesta mas facil es esto dejarlo asi nomas o sea sin operar con el _points//esto es lo que estaba buscando, con esto tenemos el rango de una vale max - minimo
   range = atr[1] * (porcentaje_rango/100); // no me esta calculando el rango
   double rangoBuy= NormalizeDouble((bar[0].open + range),_Digits);
   double rangoSell= NormalizeDouble((bar[0].open - range),_Digits);
   Print("el rango de compra es : ", rangoBuy);
   Print("la apertura de la barra es : ", bar[0].open);
   // price is equal to open + range% + spread?= buy ; price is equal to open - range = sell
   if(ask > rangoBuy && operacion_cerrada())
   {
      trade.Buy(0.1,_Symbol, ask, bar[0].open - range, bar[0].open + range*3);
      trade_ticket = trade.ResultOrder(); // ojo que hay results order distintos y no tosdos funcionan de la misma manera.
   }
   else if(bid < rangoSell && operacion_cerrada())
   {
      trade.Sell(0.1,_Symbol, bid, bar[0].open + range, bar[0].open - range*3);
      trade_ticket = trade.ResultOrder();
   }
   
}
