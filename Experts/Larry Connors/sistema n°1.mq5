//+------------------------------------------------------------------+
//|                                                  sistema n°1.mq5 |
//|                                elias Prueba1 .0 - LArry williams |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "elias Prueba1 .0 - LArry williams"
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <trade\trade.mqh>

CTrade trade;
ulong trade_ticket;
//condiciones
/*
sp500 por encima de sma 200

rsi de 2 periodos del sp 500 cierra debajo de 5

compre sp al cierre

salga cuando el sp cierra por encima de su ma de 5 periodos

*/
//variables

//arrays
double rsi[];
double sma200[];
double sma5[];

MqlRates rates[];

//handlers
int rsi_h;
int sma200_h;
int sma5_h;

double ask;
double bid;
double spread;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

bool operacion_cerrada()
{
   return !PositionSelectByTicket(trade_ticket);
}

int OnInit()
  {
//---
   rsi_h= iRSI(_Symbol, PERIOD_CURRENT, 2, PRICE_CLOSE);
   sma200_h = iMA(_Symbol, PERIOD_CURRENT, 200, 0, MODE_SMA, PRICE_CLOSE);
   sma5_h= iMA(_Symbol, PERIOD_CURRENT, 5, 0, MODE_SMA, PRICE_CLOSE);

   ArraySetAsSeries(sma5,true);
   ArraySetAsSeries(sma200,true);
   ArraySetAsSeries(rsi,true);
   ArraySetAsSeries(rates,true);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   if(rsi_h != INVALID_HANDLE)
      IndicatorRelease(rsi_h);
      
      if(sma200_h != INVALID_HANDLE)
      IndicatorRelease(sma200_h);
      
      if(sma5_h!= INVALID_HANDLE)
      IndicatorRelease(sma5_h);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
   spread = ask - bid;//clave para los stop lss

   CopyRates(_Symbol, _Period,0,5,rates);
   CopyBuffer(sma200_h,0,0,5,sma200);
   CopyBuffer(sma5_h,0,0,5,sma5);
   CopyBuffer(rsi_h,0,0,5,rsi);

   if(sma200[1] < rates[1].close && rsi[1] < 5 && operacion_cerrada())//la idea es compre el sp al cierre
     {
      trade.Buy(0.1,_Symbol, ask, ask - 600*_Point - spread, sma5[0]);
      trade_ticket=trade.ResultOrder();
     }//hasta aca todo en orden abre , pero abre millones de operaciones creo que falta esa funcion bool de opecracion cerrada 

  }
//+------------------------------------------------------------------+
