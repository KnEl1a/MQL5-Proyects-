#include <Trade/Trade.mqh>
CTrade trade;

double minimo = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);

ulong trade_ticket;

//medias moviles

int sma_10_h;
int sma_30_h;
int sma_100_h;
int sma_200_h;

double sma_10[];
double sma_30[];
double sma_100[];
double sma_200[];



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
double ATR_tendencia1[]; // niveles de 1 y -1 
double ATR_tendencia2[]; // stop 

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
   sma_10_h = iMA(_Symbol, PERIOD_CURRENT, 10, 0, MODE_SMA, PRICE_CLOSE);
   sma_30_h = iMA(_Symbol, PERIOD_CURRENT, 30, 0, MODE_SMA, PRICE_CLOSE);
   sma_100_h = iMA(_Symbol, PERIOD_CURRENT, 100, 0, MODE_SMA, PRICE_CLOSE);
   sma_200_h = iMA(_Symbol, PERIOD_CURRENT, 200, 0, MODE_SMA, PRICE_CLOSE);
   

   if(ATR_tendencia_h == INVALID_HANDLE) //sabemos que es raro de que lance nu error asi que lo dejamos asi y no ponemos ningun indicador acá por tiemp
     {
      Print("Error al iniciar el indicador");
      return INIT_FAILED;
     }

   ArraySetAsSeries(ATR_tendencia0, true);
   ArraySetAsSeries(ATR_tendencia1, true);
   ArraySetAsSeries(ATR_tendencia2, true);
   
   
   ArraySetAsSeries(rates, true);
   
   ArraySetAsSeries(sma_10, true);
   ArraySetAsSeries(sma_30, true);
   ArraySetAsSeries(sma_100, true);
   ArraySetAsSeries(sma_200, true);



    return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
   if( ATR_tendencia_h!= INVALID_HANDLE)
      IndicatorRelease(ATR_tendencia_h);
}

bool estadoAnterior = false;
void OnTick()
{
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
  
  //barras de precio
  CopyRates(_Symbol, PERIOD_CURRENT, 0, 5, rates);
  
  //ATR tendencia
  CopyBuffer(ATR_tendencia_h, 0, 0, 5, ATR_tendencia0);
  CopyBuffer(ATR_tendencia_h, 1, 0, 5, ATR_tendencia1);
  CopyBuffer(ATR_tendencia_h, 2, 0, 5, ATR_tendencia2);
  
  
  // sma 
  CopyBuffer(sma_10_h, 0, 0, 5, sma_10);
  CopyBuffer(sma_30_h, 0, 0, 5, sma_30);
  CopyBuffer(sma_100_h, 0, 0, 5, sma_100);
  CopyBuffer(sma_200_h, 0, 0, 5, sma_200);
  
  //arrancamos con un alertador basico

   

// Declarar una variable global para almacenar el estado anterior


// En tu función OnTick

   // Verificar la condición alcista
   if(sma_10[1] > sma_30[1] && sma_30[1] > sma_100[1] && sma_100[1] > sma_200[1])
   {
      // Si la condición actual es verdadera y la anterior era falsa
      if (!estadoAnterior)
      {
         // Activar la alerta y actualizar el estado anterior
         Print("alerta e solapamiento alcista", rates[1].time);
         //Alert("Solapamiento alcista");
         estadoAnterior = true;
      }
   }
   else
   {
      // Si la condición actual es falsa, actualizar el estado anterior
      estadoAnterior = false;
   }

   // Hacer lo mismo para la condición bajista
   if(sma_10[1] < sma_30[1] && sma_30[1] < sma_100[1] && sma_100[1] < sma_200[1])
   {
      if (!estadoAnterior)
      {
         //Alert("Solapamiento bajista");
         Print("alerta de solapamiento bajista ", rates[1].time);
         estadoAnterior = true;
      }
   }
   else
   {
      estadoAnterior = false;
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

// el algoritmo estaria finalizado si cierra las ordenes cuadno paasamos de un ATr trend positivo a negativo
// y ademas de ello tenemos alertadores de media moviles .