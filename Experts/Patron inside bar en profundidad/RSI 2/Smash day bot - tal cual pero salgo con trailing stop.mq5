// # patron RSI 2 

#include <Trade\Trade.mqh>
#include <MoneyManagement1.mqh>
// vamos a probar el patron con todas las probabildiades que se puedan a nuestro favor
datetime lastBarTime = 0;

int Patron_RSI = 0;
int Patron_RSI1 = 0;

CTrade trade; 
ulong trade_ticket;

//--------Indicadores--------------
//RSI
int RSI_h;
double RSI[];

// ATr
int ATR_h;
double ATR[];


//Money management
double t_predeterm = SymbolInfoDouble(_Symbol , SYMBOL_VOLUME_STEP);
input int MM_Percentage = 1;// porcentaje de riesgo del balance

//-------------------------

//uso tambien 

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
/* bool isNewBar() {
    datetime currentBarTime = iTime(_Symbol, PERIOD_CURRENT, 0);
    if (currentBarTime > lastBarTime) {
        lastBarTime = currentBarTime;
        return true;
    }
    return false;
}*/

MqlRates infoprecio[];

int OnInit()
  {
   MqlTradeRequest request;
   MqlTradeResult result;
   ArraySetAsSeries(infoprecio,true);

   RSI_h= iRSI(_Symbol, PERIOD_CURRENT, 2, PRICE_CLOSE);
   ATR_h = iATR(_Symbol, PERIOD_CURRENT, 20);

   
      if( RSI_h == INVALID_HANDLE || ATR_h == INVALID_HANDLE) //por el momento solo pruebo un smash day y de ahi lo vamos filtrando para tratar de entrear en momentos mas oportunos
     {
      Print("Error loading the indicators");
      return INIT_FAILED;
     }
     

  ArraySetAsSeries(RSI, true);
  ArraySetAsSeries(ATR, true);
   
   return INIT_SUCCEEDED;
  }
  
  void OnDeinit(const int reason)
  {
  
   if(RSI_h != INVALID_HANDLE)
      IndicatorRelease(RSI_h);
      
  if(ATR_h!= INVALID_HANDLE)
      IndicatorRelease(ATR_h);
  }


void OnTick()
  {
  
  double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
  double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
  double spread = NormalizeDouble(ask - bid,_Digits); 
  CopyRates(_Symbol, _Period, 0,10, infoprecio);
   CopyBuffer(RSI_h, 0, 0, 6, RSI);
   CopyBuffer(ATR_h, 0, 0, 7, ATR);
   
   double Porcentaje_ATR = NormalizeDouble(ATR[1]*0.8333, _Digits);     // es un 8.333 % del promedio del rango  de los 20 periods 
   double Maximo_clave = infoprecio[1].high + spread + Porcentaje_ATR;  // entonces este es mi nivel clave para largos y creo tamb para poner nuestro stop loss
   double Minimo_clave = infoprecio[1].low - spread - Porcentaje_ATR;   // entonces este es mi nivel clave para corots  y creo tamb para poner nuestro stop loss
  
   
   
   if( RSI[1] < 5 && infoprecio[0].close >  Maximo_clave && nueva_vela())
   {   
   Patron_RSI = Patron_RSI + 1;
   Print("entramos largo : ", infoprecio[1].time, " y su spread o diferencial fue de : ", infoprecio[1].spread ); // un lujo , una maravilla el algoritmo
    
   double sl_buy = NormalizeDouble(Minimo_clave , _Digits); // ser aque esta bien hacer un normalize double ? ojo tenems que probar esto, tambien testealo seriamente con con una calidad de datos lo mas alta posible 
   double rango_buy = NormalizeDouble((Maximo_clave - Minimo_clave), _Digits);
   double tp_buy = NormalizeDouble(ask + rango_buy*1, _Digits);  //corto plazo 
   
   //gestion monetaria compra
   double dif_buy = StopPriceToPoints(_Symbol, sl_buy, ask); 
   double  tradeSize_buy = MoneyManagement(_Symbol, t_predeterm, MM_Percentage, dif_buy); // 1% del balance
   
   
   trade.Buy(tradeSize_buy,NULL,ask,sl_buy, tp_buy);
   trade_ticket = trade.ResultOrder();
   }
   
   
   
   // me parece qu eel volumen es clave, creo que tenemos que tenerlo en cueenta orque como dijo couglin es como el combustible, o sea te indica cuando entraron o salieron mas indicando mas movimiento y por lo tanto un incremento en la volatilidad
   //smash Bar bajista // + tendencia bajista
 
      if(RSI[1] > 95 && infoprecio[0].close <  Minimo_clave && nueva_vela())
   {
   Patron_RSI1 = Patron_RSI1 + 1;
   Print("entramos corto: ", infoprecio[1].time, "y su spread o diferencial fue de ", infoprecio[1].spread ); // un lujo , una maravilla el algoritmo
   
   double sl_sell = NormalizeDouble(Maximo_clave, _Digits); // el stop es invalido dice
   double rango_sell = NormalizeDouble((Maximo_clave - Minimo_clave), _Digits); // aca esta el problema este 
   double tp_sell = NormalizeDouble(bid - rango_sell*1, _Digits);  
 
 // - -- - - - - gestion monetaria venta
   
      double dif_sell = StopPriceToPoints(_Symbol, sl_sell, bid);
      double  tradeSize_sell = MoneyManagement(_Symbol, t_predeterm, MM_Percentage, dif_sell); // 1% del balance  //t_predeterm es el volum, minimo
   trade.Sell(tradeSize_sell , NULL , bid , sl_sell , tp_sell ); // este seria el fijo 
   trade_ticket = trade.ResultOrder();
   
   }
   
   //Print("hay una nueva barra ? o el tiempo de hoy es mayor que el de ayer", isNewBar() );
   
   Comment("CANTIDADES\n Doji normal: ",
   "\n Largo RSI : ", Patron_RSI,
   "\n Corto RSI : ", Patron_RSI1);
   
  /* for(int i = PositionsTotal() - 1 ; i >= 0 ; i--)
     {
      ulong posTicket = PositionGetTicket(i);
      if(PositionSelectByTicket(posTicket))
        {
         double posSl = PositionGetDouble(POSITION_SL);

         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
           {

            //if((barraH4[1].low - spread - (20*_Point))> posSl)
            if((infoprecio[1].low - spread)> posSl )// creo q es es por ese orders total () == 1 ;)
              {

               trade.PositionModify(posTicket,(infoprecio[1].low - spread), 0);
                 
              }

           }
         else
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
              {
               //if(stoplosssell < posSl || posSl == 0)
               //if((barraH4[1].high + spread + (20*_Point))< posSl)
               if((infoprecio[1].high + spread)< posSl)
                 {

                  trade.PositionModify(posTicket,(infoprecio[1].high + spread), 0); // creo que el stop  de h4 funcionaba  
                    
                 }

              }
        }

     }*/
   
 
 }
 
 //este es el probador para no intervenir directamente en el main
 
 // tengo que probar el trailing stop 