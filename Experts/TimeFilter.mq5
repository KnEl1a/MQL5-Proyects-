//+------------------------------------------------------------------+
//|                                                   TimeFilter.mq5 |
//|                                                 elias Prueba1 .0 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "elias Prueba1 .0"
#property link      "https://www.mql5.com"
#property version   "1.00"

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+


int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+


void OnTick()
  {
//---
   MqlDateTime strucTime;
   TimeCurrent(strucTime); // hora del servidor creo que es la que se requiee para ello, hay queestablecerla si o si de lo contrario te va a dar numeros 
   
   
   Print(" ", strucTime.hour,":", strucTime.min, ":",strucTime.sec);// creo que eneste bloque de codigo dentro de ontick esta la clave para cerrar en el periodo.
  
   if (strucTime.hour == 7) // ese 7 seria un input en otro programa para determinar el close de la posiccion.
   
   {
   
   Print("mamala"); // very good.
   
   
   }
   

  
   
  }
//+------------------------------------------------------------------+
