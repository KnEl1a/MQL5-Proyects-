// este es mi primer prototipo (plantilla) de asesor para alertar sobre los patrones de barras
// la idea es que mande alertas a mi celu o a mi correo para que este atento para operar
//NOTA : aca en estos patrones tenemos en cuenta solo el precio y no el volumen

int Doji= 0; //contador
int DojiPerfecto= 0; //contador
int InsideBar= 0; //contador
int InsideBar_triple= 0; //contador
int outsideBar = 0;
int cinturon= 0;

int patron_hikake = 0;//significa trampa en japones // es un patraon de velas japones o barras el tema es que isgnifaca trmpa en japones, que muerdan el ansuelo
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
  CopyRates(_Symbol, _Period, 0,10, infoprecio);
   //Patrones de velas japonesas
   //Doji normal
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
      Print("el doji normal ocurrio: ", infoprecio[1].time); // un lujo , una maravilla el algoritmo
      }
   
   
   // Doji perfecto
   if(infoprecio[1].open == infoprecio[1].close && nueva_vela()) 
   {DojiPerfecto = DojiPerfecto+ 1;
   Print("el doji perfecto ocurrio: ", infoprecio[1].time); // un lujo , una maravilla el algoritmo
   }
   
   // Marubozzu o lo que es "similar sujecion del cinturon ""
   if(((infoprecio[1].open == infoprecio[1].low) || (infoprecio[1].open == infoprecio[1].high) || (((infoprecio[1].open == infoprecio[1].high)&&(infoprecio[1].close == infoprecio[1].low))|| (infoprecio[1].open == infoprecio[1].low)&&(infoprecio[1].close == infoprecio[1].high))) && nueva_vela()) 
   {cinturon = cinturon+ 1;
   Print("vela cinturon  ocurrio: ", infoprecio[1].time); // un lujo , una maravilla el algoritmo
   }


   //Inside Bar
   if(((infoprecio[2].low < infoprecio[1].low) && (infoprecio[2].high > infoprecio[1].high)) && nueva_vela())
   {
   InsideBar = InsideBar + 1;
   Print("inside bar ocurrio: ", infoprecio[1].time, "y su spread o diferencial fue de ", infoprecio[1].spread ); // un lujo , una maravilla el algoritmo
   }

   //Outside Bar   
   if(((infoprecio[2].low > infoprecio[1].low) && (infoprecio[2].high < infoprecio[1].high)) && nueva_vela())
   { 
   outsideBar = outsideBar + 1;
   Print("Outside bar ocurrio: ", infoprecio[1].time); // un lujo , una maravilla el algoritmo
   }
   
   //Outside Bar
   
   Comment("CANTIDADES\n Doji normal: ", Doji, 
   "\n Doji perfecto: ", DojiPerfecto, 
   "\n Inside Bar: ", InsideBar, 
   "\n Outside Bar: ", outsideBar,
   "\n Cinturon Vela: ", cinturon 
 );
   // corregir errores . Listo ahora si
   // la cosa es que es tener en cuenta lo visual porque aveces avisa de que se forman dojis pero en realidad son como algo muy pareecido, a ya que no llegan a tener la apertura y el cierre tan pegados , por eso lo visual esmu yimportante.
   //creo que te avisa a la apertura

  }