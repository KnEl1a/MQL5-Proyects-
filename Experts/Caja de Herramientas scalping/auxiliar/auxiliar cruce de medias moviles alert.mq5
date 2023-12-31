
bool cortoplazo = true;
string descripcion1 = "";
string descripcion2 = "";

int media_100_h;
int media_200_h;

double media_100[];
double media_200[];


int media_10_h;
int media_30_h;

double media_10[];
double media_30[];


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

void OnInit()
{
   media_100_h = iMA(_Symbol, PERIOD_CURRENT, 100, 0, MODE_SMA, PRICE_CLOSE);
   media_200_h = iMA(_Symbol, PERIOD_CURRENT, 200, 0, MODE_SMA, PRICE_CLOSE);
   media_10_h = iMA(_Symbol, PERIOD_CURRENT, 10, 0, MODE_SMA, PRICE_CLOSE);
   media_30_h = iMA(_Symbol, PERIOD_CURRENT, 30, 0, MODE_SMA, PRICE_CLOSE);
   
   ArraySetAsSeries(media_100, true);
   ArraySetAsSeries(media_200, true);
   ArraySetAsSeries(media_10,  true);
   ArraySetAsSeries(media_30,  true);
}



void OnTick()
{
   CopyBuffer(media_100_h, 0, 0, 5, media_100);
   CopyBuffer(media_200_h, 0, 0, 5, media_200);
   CopyBuffer(media_10_h, 0, 0, 5, media_10);
   CopyBuffer(media_30_h, 0, 0, 5, media_30);
   
   if(media_100[1]> media_200[1] && media_100[2] < media_200[2] && nueva_vela() )
   { 
     Alert("ocurrio un cruce alcista sma100 > sma200 ");
   }
   
   
    if(media_100[1]< media_200[1] && media_100[2] > media_200[2]&& nueva_vela() )
   {
     Alert("ocurrio un cruce bajista sma100 < sma200 ");
   }
   
   
   if(cortoplazo == true)
   {
   
      if(media_10[1] > media_30[1] && media_10[2] < media_30[2] && nueva_vela())
      Alert("ocurrio un cruce alcista de corto plazo sma10 > sma30 ");
      
      if(media_10[1] < media_30[1] && media_10[2] > media_30[2] && nueva_vela())
      Alert("ocurrio un cruce bajista de corto plazo sma10 < sma30 ");
   }
   
   
   
} // ahora funciona bien le incorpore lo de "nueva vela "



void OnDeinit(const int reason)
  {
//---
   if(media_10_h != INVALID_HANDLE) IndicatorRelease(media_10_h);
   if(media_100_h != INVALID_HANDLE) IndicatorRelease(media_100_h);
   if(media_200_h != INVALID_HANDLE) IndicatorRelease(media_200_h);
   if(media_30_h != INVALID_HANDLE) IndicatorRelease(media_30_h);
   
  }