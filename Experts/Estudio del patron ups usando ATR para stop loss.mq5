//+------------------------------------------------------------------+
//|             Estudio del patron ups usando ATR para stop loss.mq5 |
//|                                                              eli |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "eli"
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <trade\trade.mqh>
CTrade trade;

int atr_h;
double atr[];

MqlRates rates[];

ulong trade_ticket;

bool operacion_cerrada()
  {
   return !PositionSelectByTicket(trade_ticket); //Retorna true en caso de que la función se ejecute con éxito o sea encontró op. abierta. y pasamos del true a false
  }
  
  /// Función para comprobar si estamos en una nueva vela
int bars;
bool nueva_vela()
  {
   int current_bars = Bars(_Symbol, PERIOD_M15); // si no funciona sigue sin abri ordenes entonces mandale  M15.
   if(current_bars != bars)
     {
      bars = current_bars;
      return true;
     }

   return false;
  }

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   atr_h = iATR(_Symbol, _Period, 4);

   ArraySetAsSeries(atr, true);
   ArraySetAsSeries(rates, true);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
if(atr_h!= INVALID_HANDLE) IndicatorRelease(atr_h);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
int contar= 0;
int contar2=0;
   double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   double spread = ask - bid;
   CopyRates(_Symbol, _Period, 0, 5, rates);
   CopyBuffer(atr_h, 0, 0,5, atr);
   
   //ups alcista al azar solo cuando ocurra la condicion se activa, no analiza ni mira tendencias ni nada
   if(rates[0].open < rates[1].low && rates[0].close == rates[1].low && operacion_cerrada() && nueva_vela())
   {
      contar = contar +1;
      trade.Buy(0.1,_Symbol,ask, bid - (atr[1]*(65/100)*_Point), (bid + (atr[1]*(65/100)*_Point)*2));
      Print("ocurrio un ups alcista a las : ", rates[0].time);
   }
   Comment("cantidad patrones ups alcistas : ",  contar);
  }
//+------------------------------------------------------------------+
