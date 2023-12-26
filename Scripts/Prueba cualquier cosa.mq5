//+------------------------------------------------------------------+
//|                                        Prueba cualquier cosa.mq5 |
//|                                                              Eli |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Eli"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

MqlTradeRequest request;
MqlTradeResult result;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
// Input variables
   input int TrailingStop = 500;
// OnTick() event handler
   if(PositionSelect(_Symbol) == true && TrailingStop > 0)
     {
      request.action = TRADE_ACTION_SLTP;
      request.symbol = _Symbol;
      long posType = PositionGetInteger(POSITION_TYPE);
      double currentStop = PositionGetDouble(POSITION_SL);
      double trailStop = TrailingStop * _Point;
      double trailStopPrice;
      if(posType == POSITION_TYPE_BUY)
        {
         trailStopPrice = SymbolInfoDouble(_Symbol,SYMBOL_BID) - trailStop;

         if(trailStopPrice > currentStop)
           {
            request.sl = trailStopPrice;
            OrderSend(request,result);
           }
        }
      else
         if(posType == POSITION_TYPE_SELL)
           {
            trailStopPrice = SymbolInfoDouble(_Symbol,SYMBOL_ASK) + trailStop;
            if(trailStopPrice < currentStop)
              {
               request.sl = trailStopPrice;
               OrderSend(request,result);
              }
           }
     }

  }




input int TrailingStop = 500;
// OnTick() event handler
if(PositionSelect(_Symbol) == true && TrailingStop > 0)
  {
   request.action = TRADE_ACTION_SLTP;
   request.symbol = _Symbol;
   long posType = PositionGetInteger(POSITION_TYPE);
   double currentStop = PositionGetDouble(POSITION_SL);
   double trailStop = TrailingStop * _Point;
   double trailStopPrice;
   if(posType == POSITION_TYPE_BUY)
     {
      trailStopPrice = SymbolInfoDouble(_Symbol,SYMBOL_BID) - trailStop;

      if(trailStopPrice > currentStop)
        {
         request.sl = trailStopPrice;
         OrderSend(request,result);
        }
     }
   else
      if(posType == POSITION_TYPE_SELL)
        {
         trailStopPrice = SymbolInfoDouble(_Symbol,SYMBOL_ASK) + trailStop;
         if(trailStopPrice < currentStop)
           {
            request.sl = trailStopPrice;
            OrderSend(request,result);
           }
        }
  }

//+------------------------------------------------------------------+
