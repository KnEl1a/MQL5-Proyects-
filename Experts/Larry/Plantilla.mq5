//+------------------------------------------------------------------+
//|                                                    Plantilla.mq5 |
//|                                                 elias Prueba1 .0 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "elias Prueba1 .0"
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <MoneyManagement1.mqh>
#include <Trade/Trade.mqh>

//handdler:
int ATR_h;

CTrade trade;

ulong trade_ticket;

//arrays
MqlRates bars[];
double ATR[];

double ask;
double bid;
double spread;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool operacion_cerrada()
  {
   return !PositionSelectByTicket(trade_ticket);
  }

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   ATR_h = iATR(_Symbol, _Period, 3);

   if(ATR_h == INVALID_HANDLE)
     {
      Print("Error al iniciar el indicador");
      return INIT_FAILED;
     }

   ArraySetAsSeries(ATR, true);
   ArraySetAsSeries(bars, true);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   if(ATR_h != INVALID_HANDLE)
      IndicatorRelease(ATR_h);

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   CopyBuffer(ATR_h, 0, 0, 2, ATR);
   CopyRates(_Symbol, _Period, 0, 2, bars);
   ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   spread = ask-bid;
   double Stoppips = (ATR[0])/_Point;

   double tradeSize = MoneyManagement(_Symbol, 0.1, 1, Stoppips);

   if(operacion_cerrada())
     {
      if()
        {

        }
     }

  }
//+------------------------------------------------------------------+
