datetime lastBarTime = 0;

int InsideBar = 0;
int InsideBar1 = 0;


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


// Función para verificar si ha nacido una nueva barra
bool isNewBar() {
    datetime currentBarTime = iTime(_Symbol, PERIOD_CURRENT, 0);
    if (currentBarTime > lastBarTime) {
        lastBarTime = currentBarTime;
        return true;
    }
    return false;
}


void OnTick()
  {
   MqlRates infoprecio[];
   ArraySetAsSeries(infoprecio,true);
  CopyRates(_Symbol, _Period, 0,10, infoprecio);
  
  
   //Inside Bar alcista
   if(((infoprecio[2].low < infoprecio[1].low) && (infoprecio[2].high > infoprecio[1].high) && (infoprecio[0].close > infoprecio[1].high)) && nueva_vela())
   {
   InsideBar = InsideBar + 1;
   Print("inside bar alcista ocurrio: ", infoprecio[1].time, "y su spread o diferencial fue de ", infoprecio[1].spread ); // un lujo , una maravilla el algoritmo
   
   
   }
   
   
   //Inside Bar alcista
   if(((infoprecio[2].low < infoprecio[1].low) && (infoprecio[2].high > infoprecio[1].high) && (infoprecio[0].close < infoprecio[1].low)) && nueva_vela())
   {
    InsideBar1 = InsideBar1 + 1;
   Print("inside bar bajista ocurrio: ", infoprecio[1].time, "y su spread o diferencial fue de ", infoprecio[1].spread ); // un lujo , una maravilla el algoritmo
   }
   
   //Print("hay una nueva barra ? o el tiempo de hoy es mayor que el de ayer", isNewBar() );
   
   Comment("CANTIDADES\n Doji normal: ",
   "\n Inside Bar alcista: ", InsideBar,
   "\n Inside Bar bajista: ", InsideBar1);
 
 }
 
 //este es el probador para no intervenir directamente en el main