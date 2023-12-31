#include <Trade/Trade.mqh>
CTrade trade;

double minimo = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);

ulong trade_ticket;

//medias moviles
/*
int sma_10_h;
int sma_30_h;
int sma_100_h;
int sma_200_h;

double sma_10[];
double sma_30[];
double sma_100[];
double sma_200[];

*/

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


int ATR_tendencia_h;
double ATR_tendencia0[];
double ATR_tendencia1[];
double ATR_tendencia2[];

MqlRates rates[];

bool operacion_cerrada()
  {
   return !PositionSelectByTicket(trade_ticket);
  }

//vamos a estudiar el control numerico y despues metemos metemos todo junto 
int OnInit()
{
   string name = "Market\\Cybertrade ATR Trend Zone.ex5";
   ATR_tendencia_h = iCustom(_Symbol, PERIOD_CURRENT, name);
   
   

   if(ATR_tendencia_h == INVALID_HANDLE)
     {
      Print("Error al iniciar el indicador");
      return INIT_FAILED;
     }

   ArraySetAsSeries(ATR_tendencia0, true);
   ArraySetAsSeries(ATR_tendencia1, true);
   ArraySetAsSeries(ATR_tendencia2, true);
   ArraySetAsSeries(rates, true);
   
   



    return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
   if( ATR_tendencia_h!= INVALID_HANDLE)
      IndicatorRelease(ATR_tendencia_h);
}

void OnTick()
{
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
  
  CopyRates(_Symbol, PERIOD_CURRENT, 0, 5, rates);
  CopyBuffer(ATR_tendencia_h, 0, 0, 5, ATR_tendencia0);
  CopyBuffer(ATR_tendencia_h, 1, 0, 5, ATR_tendencia1);
  CopyBuffer(ATR_tendencia_h, 2, 0, 5, ATR_tendencia2);
  
/*  if(ATR_tendencia2[1] > rates[1].close && ATR_tendencia1[1] == 1.0)
  {
  Print("Prueba 1 . Cerramos la posicion larga y ocurrio a las " , rates[1].time);
  }
  
   if(ATR_tendencia2[1] < rates[1].close && ATR_tendencia1[1] == -1.0)
  {
  Print("Prueba 1 .Cerramos la posicion corta y ocurrio a las", rates[1].time);
  }
*/
   
      // Condiciones para abrir operaciones
      // Condiciones para abrir operaciones
   if (operacion_cerrada()) {
      if((rates[3].close < rates[2].close   &&  rates[2].close > rates[1].close) && ATR_tendencia1[1] == -1.0){
         Print("Abrimos posición corta a las ", rates[1].time);
         
         trade.Sell(minimo, _Symbol, bid);
         trade_ticket = trade.ResultOrder();
      } else if ( (rates[3].close > rates[2].close  && rates[2].close < rates[1].close) && ATR_tendencia1[1] == 1.0){
         Print("Abrimos posición larga a las ", rates[1].time);
         
         trade.Buy(minimo, _Symbol, ask);
         trade_ticket = trade.ResultOrder();
      } else {
         // Mensaje de depuración
         Print("No se cumplieron las condiciones para abrir posiciones.");
      }
   }

   // Condiciones para cerrar operaciones
   if (!operacion_cerrada()) {
      if ( ATR_tendencia1[2] == -1.0 && ATR_tendencia1[1] != -1.0) {
         Print("Cerramos posición corta a las ", rates[1].time);
         
       for (int i = PositionsTotal() - 1; i >= 0; i--)
        {
            ulong posTicket = PositionGetTicket(i);
            if (PositionSelectByTicket(posTicket))
            {
                // Verificar si la posición pertenece al símbolo actual
                if (PositionGetString(POSITION_SYMBOL) == _Symbol)
                {
                    if (trade.PositionClose(posTicket))
                    {
                        Print(__FUNCTION__, " > Pos # ", posTicket, " was closed because of close time ... ");
                    }
                }
            }
        }
         
         
         trade.PositionClose(trade_ticket);
         trade_ticket = trade.ResultOrder();
      } else if ( ATR_tendencia1[2] == 1.0 && ATR_tendencia1[1] != 1.0) {
         Print("Cerramos posición larga a las ", rates[1].time);
         
       for (int i = PositionsTotal() - 1; i >= 0; i--)
        {
            ulong posTicket = PositionGetTicket(i);
            if (PositionSelectByTicket(posTicket))
            {
                // Verificar si la posición pertenece al símbolo actual
                if (PositionGetString(POSITION_SYMBOL) == _Symbol)
                {
                    if (trade.PositionClose(posTicket))
                    {
                        Print(__FUNCTION__, " > Pos # ", posTicket, " was closed because of close time ... ");
                    }
                }
            }
        }
         
         trade.PositionClose(trade_ticket);
         trade_ticket = trade.ResultOrder();
      } else {
         // Mensaje de depuración
         Print("No se cumplieron las condiciones para cerrar posiciones.");
      }
   }
         
         //claro cierra la ultima y no cierra todas las ordenes de tipo compra o venta cuando estan por una sencilla razon, tenemos que modificar el altgoritmo
         // paraa que recorra todas las ordenes . 
         
         
      //cierre de orden de venta

   
    Comment("el valor del ATR es de ", ATR_tendencia0[0] , "\n Direccion (para Largo = 1 ,  para corto = -1)", ATR_tendencia1[0], "\n el stop se pondria en ... ", ATR_tendencia2[0],"\n el valor del  ATR 1 es", ATR_tendencia2[1]);


}

//mejoro pero aveces nno cierra las posiciones no se porque por lo que tendre que estar atento y formular alertas con esto

// aveces no ciera no se porque 

// me parece que la cagada esta por la APERTURA POR LO QUE AHORA LO QUE TENGO QUE HACER ES OTRA COSA


//para mi que lacagada de acumulacion esta en la entrada, tengo que probar algo mas practico tengo que abrir ordenes que luego pueda cerrar osea abrir y piramidar 



