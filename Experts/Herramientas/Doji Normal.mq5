int Doji= 0; //contador
//acá en este doji normal lo que voy a hacer es modificar el if, es un codigo heredado del "doji perfecto", nota estos suelen aparecer en marcos temporales mas bajos, son mas comunes ahí.

int bars; // creo que si no le especificamos entonces es 0
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
//void OnTick()
//  {
//   MqlRates infoprecio[];
//   ArraySetAsSeries(infoprecio,true);
//   CopyRates(_Symbol, _Period, 0,2, infoprecio);
//
//   if(infoprecio[1].open == infoprecio[1].close && nueva_vela())
//     {
//      Doji = Doji + 1;
//      Print("el doji perfecto ocurrio: ", infoprecio[1].time); // un lujo , una maravilla el algoritmo
//     }
//
//   Comment("\n Doji perfecto (cantidad): ", Doji);
//
//  }
//+------------------------------------------------------------------+

void OnTick()
  {
   MqlRates infoprecio[];
   ArraySetAsSeries(infoprecio,true);
  CopyRates(_Symbol, _Period, 0,2, infoprecio);
   
   //receta copiada de xavier andreu
   if((infoprecio[1].open < infoprecio[1].close //bull
   && ((infoprecio[1].high - infoprecio[1].close) > (infoprecio[1].close - infoprecio[1].open))
   && ((infoprecio[1].open - infoprecio[1].low) >(infoprecio[1].close - infoprecio[1].open))
   
   ||
   
   infoprecio[1].open > infoprecio[1].close //bear
   && ((infoprecio[1].high - infoprecio[1].open) > (infoprecio[1].open - infoprecio[1].close))
   && ((infoprecio[1].close - infoprecio[1].low) >(infoprecio[1].open - infoprecio[1].close))
   ) && nueva_vela())
      {
      Doji = Doji + 1;
      Print("el doji  ocurrio: ", infoprecio[1].time); // un lujo , una maravilla el algoritmo
      }
   
   Comment("\n Doji normal (cantidad): ", Doji);
   // corregir errores . Listo ahora si
   // la cosa es que es tener en cuenta lo visual porque aveces avisa de que se forman dojis pero en realidad son como algo muy pareecido, a ya que no llegan a tener la apertura y el cierre tan pegados , por eso lo visual esmu yimportante.
   

  }