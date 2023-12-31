//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
/*
>>Emas que se cruzan y se cierran y cambian de tipo de posicion de buy a sell por ejemplo
>>lote 1%;
>>Trailing stop
*/

//+------------------------------------------------------------------+

#include <Trade/Trade.mqh>
#include <MoneyManagement1.mqh>

CTrade trade;

ulong trade_ticket;

int ema_fast_h;
int ema_slow_h;
int ATR_h; // los handlers siempre dejalos como double.

double ema_fast[];
double ema_slow[];
double ATR[];
MqlRates barra[];

//Variables de entrada
input double Riesgo = 1;
double t_predeterm = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);
double stoplosssell;
double stoplossbuy;

//spread

//precios
//obtenemos el bid y el ask
double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);

double spread_point = ask - bid;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool cruce_compra()
  {
   return ema_fast[1] < ema_slow[1] && ema_fast[0] > ema_slow[0];
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool cruce_venta()
  {
   return ema_fast[1] > ema_slow[1] && ema_fast[0] < ema_slow[0];
  }

int bars;
bool nueva_vela()
  {
   int current_bars = Bars(_Symbol, _Period);
   if(current_bars != bars)
     {
      bars = current_bars;
      return true;
     }

   return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool operacion_cerrada()
  {
   return !PositionSelectByTicket(trade_ticket);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
   MqlTradeRequest request;
   MqlTradeResult result;

   ATR_h = iATR(_Symbol, _Period, 14);
   ema_fast_h = iMA(_Symbol, _Period, 10, 0, MODE_EMA, PRICE_CLOSE);
   ema_slow_h = iMA(_Symbol, _Period, 100, 0, MODE_EMA, PRICE_CLOSE);

   if(ema_fast_h == INVALID_HANDLE || ema_slow_h == INVALID_HANDLE)
     {
      Print("Error loading the indicators");
      return INIT_FAILED;
     }

   ArraySetAsSeries(ema_fast, true);
   ArraySetAsSeries(ema_slow, true);
   ArraySetAsSeries(ATR, true);
   ArraySetAsSeries(barra, true);

   return INIT_SUCCEEDED;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   if(ema_fast_h != INVALID_HANDLE)
      IndicatorRelease(ema_fast_h);
   if(ema_slow_h != INVALID_HANDLE)
      IndicatorRelease(ema_slow_h);
   if(ATR_h != INVALID_HANDLE)
      IndicatorRelease(ATR_h); // si no hubo error listo hacelo pasar baby
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   CopyBuffer(ATR_h, 0, 0, 2, ATR);
   CopyBuffer(ema_fast_h, 0, 1, 2, ema_fast);
   CopyBuffer(ema_slow_h, 0, 1, 2, ema_slow);
   CopyRates(_Symbol, _Period, 0, 2, barra);
   double Stoppips = (ATR[0])/_Point;
   Print("lco ", ATR[0]);

   Print("stopips", Stoppips);

//Stops para el trailling
   stoplossbuy=(barra[1].high - (ATR[1]*11) - spread_point);// otra forma es con iHigh
   stoplosssell=(barra[1].low + ((ATR[1]*11)) + spread_point); // otra forma es con iLow

   double tradeSize = MoneyManagement(_Symbol, t_predeterm, Riesgo, Stoppips);// ojo que acá no esta bien calcula da la gestion del riesgo
   if(operacion_cerrada())
     {
      if(cruce_compra())
        {
         trade.Buy(tradeSize, _Symbol, ask, stoplossbuy, 0);
         trade_ticket = trade.ResultOrder();
        }
      else
         if(cruce_venta())
           {
            trade.Sell(tradeSize, _Symbol, bid, stoplosssell, 0);
            trade_ticket = trade.ResultOrder();
           }
     }
   else
      if(nueva_vela() && (cruce_compra() || cruce_venta())) // preguntamos si hay una vela nueva y si se produce un cruce
        {
         trade.PositionClose(trade_ticket); // entonces cerrame el ultimo trade.
        }


//funcion que saqe de YT : tailling stop
   for(int i = PositionsTotal() - 1 ; i >= 0 ; i--)
     {
      ulong posTicket = PositionGetTicket(i);
      if(PositionSelectByTicket(posTicket))
        {
         double posSl = PositionGetDouble(POSITION_SL);

         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
           {

            if(stoplossbuy > posSl)
              {

               if(trade.PositionModify(posTicket,stoplossbuy, 0))
                 {
                  Print(__FUNCTION__, " > Pos # ", posTicket, "was modified ... ");
                  //(__FUNCTION__) es una característica del lenguaje que devuelve el nombre de la función en la que se encuentra en tiempo de compilación.
                 }
              }

           }
         else
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
              {
               //if(stoplosssell < posSl || posSl == 0)
               if(stoplosssell < posSl)
                 {

                  if(trade.PositionModify(posTicket,stoplosssell, 0))
                    {
                     Print(__FUNCTION__, " > Pos # ", posTicket, "was modified ... ");
                     //(__FUNCTION__) es una característica del lenguaje que devuelve el nombre de la función en la que se encuentra en tiempo de compilación.
                    }
                 }

              }
        }

     }



  }
//+------------------------------------------------------------------+

//coso if(bars[1].high > bars[2].high && bars[1].low < bars[2].low && bars[1].close<bars[2].low && bars[0].open < bars[1].close)