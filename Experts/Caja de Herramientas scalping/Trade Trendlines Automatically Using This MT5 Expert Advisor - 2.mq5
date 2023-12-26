//segunda parte, o sea mi codigo modificado para que detecte precios de cierre y no precio bid
// primero metemos este experto y luego tenemos que cambiar el nombre a la linea de tendencia.


// acá usaremos close[0] y no close[1]
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

MqlRates infoprecio[];


int OnInit()
  {
   CopyRates(_Symbol, PERIOD_CURRENT, 0, 6 , infoprecio);
   ArraySetAsSeries(infoprecio, true);

   return(INIT_SUCCEEDED);

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
  CopyRates(_Symbol, PERIOD_CURRENT, 0, 6 , infoprecio);
  double close = infoprecio[0].close;
  static double lastClose = close;
   //double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   //static double lastBid = bid;

   string objName = "clave";
   datetime time = TimeCurrent();

   double price = ObjectGetValueByTime(0, objName, time);

   if(close >= price && lastClose< price)
     {

      Print("We hit the line from below ! Do something ...");

     }

   if(close <= price && lastClose > price)
     {

      Print("We hit the line from above ! Do something ...");

     }

   lastClose = close;

   Comment(price, "\n", close);

  }

// ahora deberia de mejorar el codigo.

//+------------------------------------------------------------------+
