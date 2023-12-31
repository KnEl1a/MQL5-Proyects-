//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#include <Trade\Trade.mqh>

CTrade trade;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {

   if((MediaMovil(2,3) < MediaMovil(2,5) && MediaMovil(1,3) > MediaMovil(1,5)) || (MediaMovil(2,3) > MediaMovil(2,5) && MediaMovil(1,3) < MediaMovil(1,5)))
     {
      int totalPositions = PositionsTotal();

      for(int i = totalPositions - 1; i >= 0; i--)
        {
         ulong ticket = PositionGetTicket(i);
         string symbol = PositionGetSymbol(i);

         // Verificar si la posición pertenece al símbolo actual
         if(StringCompare(symbol, Symbol(), 0) == 0)
           {
            trade.PositionClose(ticket, -1);
           }
        }
     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double MediaMovil(int posicion, int periodos)
  {
   double MediaMovilArray[];
   CopyBuffer(iMA(_Symbol,NULL,periodos, 0, MODE_SMA, PRICE_CLOSE),0,0,3,MediaMovilArray);
   ArraySetAsSeries(MediaMovilArray,true);

   return (MediaMovilArray[posicion]);

  }

//vamos a ver como podemos interactuar con un indicador para que cumpla con la funcion que le especifiquemos del cierre .





// pruebas


// si funciona
// no hay problemas

// cierra todas las ordenes ante un cruce
//+------------------------------------------------------------------+
