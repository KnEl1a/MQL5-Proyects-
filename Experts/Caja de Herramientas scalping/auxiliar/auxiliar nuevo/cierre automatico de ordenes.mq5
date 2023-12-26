#include <Trade\Trade.mqh>

CTrade trade;

void OnStart()
{
   int totalPositions = PositionsTotal();

   for (int i = totalPositions - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      string symbol = PositionGetSymbol(i);

      // Verificar si la posición pertenece al símbolo actual
      if (StringCompare(symbol, Symbol(), 0) == 0)
      {
         trade.PositionClose(ticket, -1);
      }
   }
}
// deberia cerrar solo del simbolo al que seleccionamos 

// si funciona como deberia 