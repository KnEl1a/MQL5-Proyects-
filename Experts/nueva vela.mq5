
int bars1;
bool nueva_vela()
  {
   int current_bars = Bars(_Symbol, _Period);
   if(current_bars != bars1)
     {
      bars1 = current_bars;
      return true;
     }//vigila esta func
   return false;
  }

int count;

void OnTick(){
   if(nueva_vela())
   {
      count = count + 1;
      Comment("nueva vela aparecio N° ", count);
   }
   
}