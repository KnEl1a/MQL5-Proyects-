int Bull = 0;
int Bear = 0;

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
   ArraySetAsSeries(infoprecio, true);
   CopyRates(_Symbol, _Period, 0, 4, infoprecio);
   
   if(infoprecio[1].open < infoprecio[1].close
   && infoprecio[2].open < infoprecio[2].close
   && infoprecio[3].open < infoprecio[3].close
   && nueva_vela())
   {
   Bull = Bull +1; 
   Print("el patron alcista aparece : ", infoprecio[1].time);
   }
   if(infoprecio[1].open > infoprecio[1].close
   && infoprecio[2].open > infoprecio[2].close
   && infoprecio[3].open > infoprecio[3].close
   && nueva_vela())
   {
   Bear = Bear +1;
   Print("el patron bajista aparece : ", infoprecio[1].time);
   }
   Comment("\n Bear: ", Bear,
   "\n Bull: ", Bull);

}
//este funciona de 10, para detectar este patron.
//mañana hago patron out side and inside