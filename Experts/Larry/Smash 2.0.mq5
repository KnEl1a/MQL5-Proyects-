//+------------------------------------------------------------------+
//|                                                    Plantilla.mq5 |
//|                                                 elias Prueba1 .0 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//notas: este trailling stop si funciona por el time horad de cierre por lo que voy a quitarseloy ver que onda en el ed trailling stop de la verison 1.0 no porque no saque el controlador de tiempo
// ademas introducire mis patrones de smash ups de compra
//en h1 una bosta, com que le falta algo

#property copyright "elias Prueba1 .0"
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <MoneyManagement1.mqh>
#include <Trade/Trade.mqh>

//handdler:
int ATR_h;

//time filter ; close


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
   //EventSetTimer(86370);
   
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
   if(ATR_h != INVALID_HANDLE) IndicatorRelease(ATR_h);
    
SymbolInfoDouble(_Symbol, SYMBOL_EXPIRATION_DAY);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
 
   CopyBuffer(ATR_h, 0, 0, 10, ATR);
   CopyRates(_Symbol, _Period, 0, 10, bars);
   ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   spread = ask-bid;
   double Stoppips = (ATR[1])/_Point;

   double tradeSize = MoneyManagement(_Symbol, 0.1, 1, Stoppips);

   if(operacion_cerrada()) //es verdad que hay una operacion cerrada
     {
     //Buy: max[0] > max [1] && min[0]< min[1] && close[0]< min[0] 
      //if(bars[1].high > bars[2].high && bars[1].low < bars[2].low && bars[1].close<bars[2].low && bars[0].open < bars[1].close)
      
      if(bars[1].close < bars[2].low && bars[1].close < bars[3].low)//Patron smash
         {
                  if(ask+spread > bars[1].high)trade.Buy(tradeSize,_Symbol, ask, ask - (ATR[1]*0.7) - spread);
                  trade_ticket = trade.ResultOrder();
         }
         /* una poronga de patrones
         if(bars[1].open < bars[2].low && bars[1].high >= bars[3].low)//Patron smash ups 
         {
                  if(ask+spread > bars[1].high)trade.Buy(tradeSize,_Symbol, ask, ask - (ATR[1]*0.7) - spread);
                  trade_ticket = trade.ResultOrder();
         }
       if(bars[0].open < bars[1].low )//Patron ups XAUSD
         {
                  if(ask+spread >= bars[1].low)trade.Buy(tradeSize,_Symbol, ask, ask - (ATR[1]*0.7) - spread);
                  trade_ticket = trade.ResultOrder();
        }*/ }
       //el trailling stop no se movia cuando estaban vrios partones juntos, ojo con los parentesis.
        
      //funcion que saqe de YT : tailling stop
   for(int i = PositionsTotal() - 1 ; i >= 0 ; i--) 
     {
      ulong posTicket = PositionGetTicket(i);
      if(PositionSelectByTicket(posTicket))
        {
         double posSl = PositionGetDouble(POSITION_SL);

         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
           {

            if(bars[1].low - spread > posSl)
              {
               trade.PositionModify(posTicket,bars[1].low - spread, 0);  
              }

           }
 
 }
  }
  }
  
  
 /* void OnTimer() // se ejecuta cada x cant de timepo dependiendo del valor puesto en oninit con set event timer.
{
   // Verificar si hay una posición abierta
   if (operacion_cerrada() == false) // si hay una operacion abierta o lo que es lo mismo operacion crerrada es igual a false, entonces.
   {
      // Verificar si hemos llegado al final de la barra actual
      if (TimeCurrent() > bars[0].time)
      {
         // Cerrar la posición al cierre de la barra
         trade.PositionClose(trade_ticket, bid);
      }
   }*/
//+------------------------------------------------------------------+

 /*   ctrade
     //trailling stop:
     
     //funcion que saqe de YT : tailling stop
   for(int i = PositionsTotal() - 1 ; i >= 0 ; i--)
     {
      ulong posTicket = PositionGetTicket(i);
      if(PositionSelectByTicket(posTicket))
        {
         double posSl = PositionGetDouble(POSITION_SL);

         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
           {

            if(bars[1].low - spread > posSl)
              {
               trade.PositionModify(posTicket,bars[1].low - spread, 0);  
              }

           }

  }}*/