#include <Trade\Trade.mqh>
#include <MoneyManagement1.mqh>

CTrade trade; 
ulong trade_ticket;

//Money management
double t_predeterm = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);
input int MM_Percentage = 1;// porcentaje de riesgo del balance

int fractales_h;

double fractal_down[];
double fractal_up[]; //vamos a ver que onda si es qu elos patrones de precios para deetectar los fractales estan bien

MqlRates infoprecio[];

double n =0.0; // para el trailing stop cortos
double m =0.0; // para el trailing stop largos 

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
   ArraySetAsSeries(infoprecio, true);

   fractales_h = iFractals(_Symbol, PERIOD_CURRENT); // es para v er que tan bien programamos la identificacion de un patron de fractales 

   if (fractales_h == INVALID_HANDLE)
   {
      Print("Error loading the indicators");
      return INIT_FAILED;
   }

   return INIT_SUCCEEDED;
}

void OnDeinit(const int reason)
{
   if (fractales_h != INVALID_HANDLE)
      IndicatorRelease(fractales_h);
}

void OnTick()
{
   
  double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
  double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
  double spread = NormalizeDouble(ask - bid,_Digits);
   

   CopyBuffer(fractales_h, LOWER_LINE, 1, 3, fractal_down);
   CopyBuffer(fractales_h, UPPER_LINE, 1, 3, fractal_up); // los cargamos pero capaz que no  los usemos 
   CopyRates(_Symbol, PERIOD_CURRENT, 0, 10 , infoprecio);
   Comment("Fractal alcista [0]: ", fractal_up[0], "\nFractal alcista [1]: ", fractal_up[1], "\nFractal bajista [0]: ", fractal_down[0], "\nFractal bajista [1]: ", fractal_down[1]);
   
   
   //+-+-+-+-+-+-+--++-+-+-+-+-+-+-+ +-+-+-+-+-+-+--++-+-+-+-+-+-+-+ +-+-+-+-+-+-+--++-+-+-+-+-+-+-+ +-+-+-+-+-+-+--++-+-+-+-+-+-+-+ +-+-+-+-+-+-+--++-+-+-+-+-+-+-+
   //mismas condiciones de l patron lo que vamos a hacer acá es guardar el valor de alto o bajo cuando apares ca y gracias a eso podemos asignar y hacer un trailing stop 
   
   //para cortos
   if (infoprecio[3].high > infoprecio[5].high && infoprecio[3].high > infoprecio[4].high && infoprecio[3].high > infoprecio[2].high && infoprecio[3].high > infoprecio[1].high)
   {
   n= infoprecio[3].high + spread; // o sea seria el maximo del fractal previo
   }
   
   //para largos
   if(infoprecio[3].low < infoprecio[5].low && infoprecio[3].low < infoprecio[4].low && infoprecio[3].low < infoprecio[2].low && infoprecio[3].low < infoprecio[1].low)
   {
   m = infoprecio[3].low - spread; // o sea sería el minimo del fractal previo.
   }
  
   
   
   
   //+-+-+-+-+-+-+--++-+-+-+-+-+-+-+ +-+-+-+-+-+-+--++-+-+-+-+-+-+-+ +-+-+-+-+-+-+--++-+-+-+-+-+-+-+ +-+-+-+-+-+-+--++-+-+-+-+-+-+-+ +-+-+-+-+-+-+--++-+-+-+-+-+-+-+
   
   //farctal bajista, fractal que aparece en un high
   if (operacion_cerrada() && infoprecio[3].high > infoprecio[5].high && infoprecio[3].high > infoprecio[4].high && infoprecio[3].high > infoprecio[2].high && infoprecio[3].high > infoprecio[1].high && nueva_vela())
   {
   
   double sl_sell = NormalizeDouble(infoprecio[3].high +  spread, _Digits); // el stop es invalido dice
   
   double dif_sell = StopPriceToPoints(_Symbol, sl_sell, bid);
   double  tradeSize_sell = MoneyManagement(_Symbol, t_predeterm, MM_Percentage, dif_sell); // 1% del balance  //t_predeterm es el volum, minimo
   trade.Sell(tradeSize_sell,NULL,bid,sl_sell);
      trade_ticket = trade.ResultOrder();
   
   
   Print("se detecto un fractal bajista , en tiempo : ", infoprecio[3].time, "  concretamente en el  precio alto que es ", NormalizeDouble(infoprecio[3].high, _Digits));
   
   }
   
   if(operacion_cerrada() && infoprecio[3].low < infoprecio[5].low && infoprecio[3].low < infoprecio[4].low && infoprecio[3].low < infoprecio[2].low && infoprecio[3].low < infoprecio[1].low && nueva_vela())
   {
   
   double sl_buy = NormalizeDouble(infoprecio[3].low -  spread, _Digits);
   
   
   //gestion monetaria compra
   double dif_buy = StopPriceToPoints(_Symbol, sl_buy, ask);
   double  tradeSize_buy = MoneyManagement(_Symbol, t_predeterm, MM_Percentage, dif_buy); // 1% del balance
   
   
   trade.Buy(tradeSize_buy,NULL,ask,sl_buy);
   trade_ticket = trade.ResultOrder(); // parece qu va bien pero no nos confiemos todavia 
   
   Print(" se detecto un fractal alcista , en tiempo : ", infoprecio[3].time, "  concretamente en el  precio bajo que es ", NormalizeDouble(infoprecio[3].low, _Digits));
            
   }
   
   
   for(int i = PositionsTotal() - 1 ; i >= 0 ; i--)
     {
      ulong posTicket = PositionGetTicket(i);
      if(PositionSelectByTicket(posTicket))
        {
         double posSl = PositionGetDouble(POSITION_SL);

         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
           {

            //if((barraH4[1].low - spread - (20*_Point))> posSl)
            if(m> posSl )// creo q es es por ese orders total () == 1 ;)
              {

               trade.PositionModify(posTicket,m, 0);
                 
              }

           }
         else
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
              {
               //if(stoplosssell < posSl || posSl == 0)
               //if((barraH4[1].high + spread + (20*_Point))< posSl)
               if(n < posSl)
                 {

                  trade.PositionModify(posTicket,n, 0); // creo que el stop  de h4 funcionaba  
                    
                 }

              }
        }

     }
   
}
