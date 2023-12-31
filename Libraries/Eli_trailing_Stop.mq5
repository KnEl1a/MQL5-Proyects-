//+------------------------------------------------------------------+
//|                                            Eli_trailing_Stop.mq5 |
//|                                                 elias Prueba 2.0 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "elias Prueba 2.0"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| My function                                                      |
//+------------------------------------------------------------------+
// int MyCalculator(int value,int value2) export
//   {
//    return(value+value2);
//   }
//+------------------------------------------------------------------+

// Trailing stop (price)


// Input variables
//input int Stop_Pntos = 500;       // este es tu stop en puntos , en mi caso este sera mi ATR / _ Point


// OnTick() event handler
MqlTradeRequest request;
MqlTradeResult result;
void TraillingStop(string pSymbol, double Stop_Pntos){ // stop emn puntos ej 500
if(PositionSelect(pSymbol) == true && Stop_Pntos > 0) //positionSelect (pSymbol)Elige una posición abierta para trabajar posteriormente con ella. Retorna true en caso de que la función se ejecute con éxito. Retorna false en caso de que la función no se ejecute con éxito.
  {
  
      
  
   request.action = TRADE_ACTION_SLTP;            // Trade_action_sltp modifica los valores de una posición abierta
   request.symbol = pSymbol;
   long posType = PositionGetInteger(POSITION_TYPE);  
   double currentStop = PositionGetDouble(POSITION_SL);  
   double trailStop = Stop_Pntos * _Point;
   //double trailStop = Stop_Pntos;
   double trailStopPrice;
   if(posType == POSITION_TYPE_BUY)
     {
      trailStopPrice = SymbolInfoDouble(pSymbol,SYMBOL_BID) - trailStop;      // aca le voy a meter lo que es el valor del maximo de la barra anterior - el stopp - vaalor del spread 

      if(trailStopPrice > currentStop)
        {
         request.sl = trailStopPrice;
         OrderSend(request,result);
        }
     }
   else
      if(posType == POSITION_TYPE_SELL)
        {
         trailStopPrice = SymbolInfoDouble(pSymbol,SYMBOL_ASK) + trailStop;
         if(trailStopPrice < currentStop)
           {
            request.sl = trailStopPrice;
            OrderSend(request,result);
           }
        }
  }
  }
//+------------------------------------------------------------------+
