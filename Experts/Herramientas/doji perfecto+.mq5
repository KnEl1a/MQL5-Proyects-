int Doji= 0; //contador
//funciona pero cuenta todos los ticks cuando ocurre, cuenta como 4000 o algo asi por los tcks.

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
  
void OnTick()
{
   MqlRates infoprecio[];
   ArraySetAsSeries(infoprecio,true);
   CopyRates(_Symbol, _Period, 0,2, infoprecio);
   
   if(infoprecio[1].open == infoprecio[1].close && nueva_vela()) 
   {Doji = Doji + 1;
   Print("el doji perfecto ocurrio: ", infoprecio[1].time); // un lujo , una maravilla el algoritmo
   }
   
   Comment("\n Doji perfecto (cantidad): ", Doji);
   
}