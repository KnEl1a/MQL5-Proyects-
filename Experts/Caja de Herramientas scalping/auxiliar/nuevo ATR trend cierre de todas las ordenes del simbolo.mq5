//la idea basica es cargar el indicador y con el obtener los niveles, vamos a abrir ordenes y vamos a cerrar las ordenes al cambio del ATR trend
// por el momento voy a ver como cerrar las ordenes 


#include <Trade/Trade.mqh>
CTrade trade;

double minimo = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);

ulong trade_ticket;



// funciones auxiliares --------
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



bool operacion_cerrada()
  {
   return !PositionSelectByTicket(trade_ticket);
  }
  
  
  
bool cierre_compra()
  {
   return ATR_tendencia1[2] == 1.00 && ATR_tendencia1[1] == -1.00;
  }
  
  
  
bool cierre_venta()
  {
   return ATR_tendencia1[2] == -1.00 && ATR_tendencia1[1] == 1.00;
  }
  
  
// --------------------------------

int ATR_tendencia_h;
double ATR_tendencia0[];
double ATR_tendencia1[]; // niveles de 1 y -1 
double ATR_tendencia2[]; // stop 

MqlRates rates[];


//------------------------


int OnInit()
{
   string name = "Market\\Cybertrade ATR Trend Zone.ex5";
   ATR_tendencia_h = iCustom(_Symbol, PERIOD_CURRENT, name);
   
      if(ATR_tendencia_h == INVALID_HANDLE) //sabemos que es raro de que lance nu error asi que lo dejamos asi y no ponemos ningun indicador acá por tiemp
     {
      Print("Error al iniciar el indicador");
      return INIT_FAILED;
     }

   ArraySetAsSeries(ATR_tendencia0, true);//valor del ATr
   ArraySetAsSeries(ATR_tendencia1, true);// 
   ArraySetAsSeries(ATR_tendencia2, true);
   
   
return(INIT_SUCCEEDED);
}


void OnTick()
{

CopyBuffer(ATR_tendencia_h, 0, 0 ,5,ATR_tendencia0);
CopyBuffer(ATR_tendencia_h, 1, 0 ,5,ATR_tendencia1);
CopyBuffer(ATR_tendencia_h, 2, 0 ,5,ATR_tendencia2);

       
      if (MathAbs(ATR_tendencia1[2] - (-1.0)) < 0.001 && MathAbs(ATR_tendencia1[1] - (-1.0)) > 0.001) {
         // Código de cierre para posición corta
         Print("Cerramos posición corta a las ", rates[1].time);
         trade.PositionClose(trade_ticket);
      } else if (MathAbs(ATR_tendencia1[2] - 1.0) < 0.001 && MathAbs(ATR_tendencia1[1] - 1.0) > 0.001) {
         // Código de cierre para posición larga
         Print("Cerramos posición larga a las ", rates[1].time);
         trade.PositionClose(trade_ticket);
      } else {
         // Mensaje de depuración
         Print("No se cumplieron las condiciones para cerrar posiciones.");
      }
   
       //if(nueva_vela() && (cierre_compra() || cierre_venta())) // preguntamos si hay una vela nueva y si se produce un cruce
      
}

