#include <Trade\Trade.mqh>
// falta codificar
CTrade trade;

int fractals_h;

double up_fractal[];
double down_fractal[];

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
  
  
  bool operacion_cerrada()
  {
   return !PositionSelectByTicket(trade_ticket); //Retorna true en caso de que la función se ejecute con éxito o sea encontró op. abierta. y pasamos del true a false
  }



int OnInit()
  {
   MqlTradeRequest request;
   MqlTradeResult result;
   ArraySetAsSeries(infoprecio,true);

   fractals_h = iFractals(_Symbol, _Period);
 
   
      if(fractals_h== INVALID_HANDLE)
     {
      Print("Error loading the indicators");
      return INIT_FAILED;
     }
     

  ArraySetAsSeries(up_fractal, true);
  ArraySetAsSeries(down_fractal, true);
 
   
   return INIT_SUCCEEDED;
  }
  
  void OnDeinit(const int reason)
  {
  
   if(fractals_h != INVALID_HANDLE)
      IndicatorRelease(fractals_h);
   
      
  }

void OnTick()
{

double Ask= NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
double Bid= NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);


MqlRates PriceArray[];

ArraySetAsSeries(PriceArray, true);

int Data = Co

}