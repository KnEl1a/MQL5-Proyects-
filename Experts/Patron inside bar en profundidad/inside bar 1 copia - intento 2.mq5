// este es mi primer prototipo (plantilla) de asesor para alertar sobre los patrones de barras
// la idea es que mande alertas a mi celu o a mi correo para que este atento para operar
//NOTA : aca en estos patrones tenemos en cuenta solo el precio y no el volumen


int InsideBar= 0; //contador

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
  
  MqlRates infoprecio[];
  

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

int OnInit()
{
ArraySetAsSeries(infoprecio,true);
return(INIT_SUCCEEDED);
}


void OnTick()
  {
   
  CopyRates(_Symbol, _Period, 0,10, infoprecio);
   //Patrones de velas japonesas
  
  

   //Inside Bar
   if(((infoprecio[2].low < infoprecio[1].low) && (infoprecio[2].high > infoprecio[1].high)) && nueva_vela())
   {
   InsideBar = InsideBar + 1;
   Print("inside bar ocurrio: ", infoprecio[1].time); // un lujo , una maravilla el algoritmo
   }


   Comment("CANTIDADES\n Doji normal: ", 
   "\n Doji perfecto: ",  
   "\n Inside Bar: ", InsideBar, 
   "\n Outside Bar: ",
   "\n Cinturon Vela: " 
 );
  
  }