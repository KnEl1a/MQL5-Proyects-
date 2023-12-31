// este prototipo lo que intentare es la regla justa 
#include <Trade\Trade.mqh>
#include <MoneyManagement1.mqh>

datetime lastBarTime = 0;

int patron_alcista = 0;
int patron_alcista1 = 0;

CTrade trade; 
ulong trade_ticket;

//--------EMAS--------------
int macd_h;
int smaH_h;
int smaL_h;
int ATR_h;

double macd[];
double signal_macd[];

double smaH[];
double smaL[];
double ATR[];


//Money management
double t_predeterm = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);
input int MM_Percentage = 1;// porcentaje de riesgo del balance
input int ATR_period = 7; // periodo del ATR
input double ATR_M= 0.6; // multiplicador ddel ATR

//creo que los periodos ATR serian mas adaptables en el corto plazo que nos importa

//loco tenemos que ingeniarnoslas para que se modifique la orden de stop loss en el caso de que cambie y ocourra una nueva vela: creo que para eta contienda nos conviene agarrar y no poner stop loss sino que tenemos que cerrar orden ante la condicion

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

// ------ operacion cerrada

bool operacion_cerrada()
  {
   return !PositionSelectByTicket(trade_ticket); //Retorna true en caso de que la función se ejecute con éxito o sea encontró op. abierta. y pasamos del true a false
  }


// -----

MqlRates infoprecio[];

int OnInit()
  {
   MqlTradeRequest request;
   MqlTradeResult result;
   ArraySetAsSeries(infoprecio,true);

   smaH_h = iMA(_Symbol, _Period, 3, 0, MODE_SMA, PRICE_HIGH);
   smaL_h = iMA(_Symbol, _Period, 3, 0, MODE_SMA, PRICE_LOW);
    ATR_h = iATR(_Symbol, _Period, ATR_period);
    macd_h = iMACD(_Symbol, PERIOD_CURRENT, 12, 26, 9, PRICE_CLOSE);
   
      if(smaH_h == INVALID_HANDLE || smaL_h == INVALID_HANDLE || ATR_h == INVALID_HANDLE)
     {
      Print("Error loading the indicators");
      return INIT_FAILED;
     }
     

  ArraySetAsSeries(smaH, true);
  ArraySetAsSeries(smaL, true);
  ArraySetAsSeries(ATR, true);
  
  ArraySetAsSeries(macd, true);
  ArraySetAsSeries(signal_macd, true);
  
  // # sera tan simple como tener 
 
   
   return INIT_SUCCEEDED;
  }
  
  void OnDeinit(const int reason)
  {
  
   if(smaH_h != INVALID_HANDLE)
      IndicatorRelease(smaH_h);
   if(smaL_h != INVALID_HANDLE)
      IndicatorRelease(smaL_h);
   if(ATR_h != INVALID_HANDLE)
      IndicatorRelease(ATR_h);
   
      
  }


void OnTick()
  {
  
  
   CopyBuffer(smaH_h, 0, 0, 10, smaH);
   CopyBuffer(smaL_h, 0, 0, 10, smaL);
   CopyBuffer(ATR_h, 0, 0, 10, ATR);   
   
   CopyBuffer(macd_h, 0, 0, 10, macd);   
   CopyBuffer(macd_h, 1, 0, 10, signal_macd);   
  
  
  double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
  double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
  double spread = NormalizeDouble(ask - bid,_Digits); 
  
  
  double Porcentaje_ATR = NormalizeDouble(ATR[1]*ATR_M, _Digits);  // igual estara bueno un stop loss vien ajustado que represente al menos un tercio de las bandas  // lo importante no es tanto la entda sino la salida
   CopyRates(_Symbol, _Period, 0,10, infoprecio);
   double Rango_mitad_delaBarra = NormalizeDouble(((infoprecio[1].high + spread) - (infoprecio[1].low - spread))/200, _Digits); // donde el denominador es 100 era un 2 en lugar de eso o sea la mitad del rango 
   
   
   //double rango = NormalizeDouble((ask - (infoprecio[1].low - spread)), _Digits);
  
   //smash Bar alcista // + tendencia alcista
   
   // if((infoprecio[0].close == infoprecio[0].low) && nueva_vela())
   if((infoprecio[3].low<infoprecio[5].low)&&(infoprecio[3].low<infoprecio[1].low)  && (infoprecio[0].close < smaL[0]) && operacion_cerrada() && nueva_vela()) // que pasa si probamos con nueva vela ?
   { //saqu el macd
   patron_alcista = patron_alcista + 1;
   Print("Patron bar alcista ocurrio: ", infoprecio[1].time, "y su spread o diferencial fue de ", infoprecio[1].spread ); // un lujo , una maravilla el algoritmo
   
   double sl_buy = NormalizeDouble(smaL[0] -  spread - Porcentaje_ATR, _Digits);
   sl_buy = sl_buy - Rango_mitad_delaBarra;
   double rango_buy = NormalizeDouble((ask - sl_buy), _Digits);
   //double tp_buy = NormalizeDouble(ask + rango_buy*2 + spread, _Digits);  
   
   //gestion monetaria compra
   double dif_buy = StopPriceToPoints(_Symbol, sl_buy, ask);
   double  tradeSize_buy = MoneyManagement(_Symbol, t_predeterm, MM_Percentage, dif_buy); // 1% del balance
   
   
   trade.Buy(tradeSize_buy,NULL,ask,infoprecio[3].low - spread);
   trade_ticket = trade.ResultOrder();
   }//ctrade
  

   
  
   
   
   //smash Bar bajista // + tendencia bajista
   if((infoprecio[3].high>infoprecio[5].high)&&(infoprecio[3].high>infoprecio[1].high)   && (infoprecio[0].close > smaH[0]) && operacion_cerrada() && nueva_vela())
   {
    patron_alcista1 = patron_alcista1 + 1;
   Print("smash bar bajista ocurrio: ", infoprecio[1].time, "y su spread o diferencial fue de ", infoprecio[1].spread ); // un lujo , una maravilla el algoritmo
   
   double sl_sell = NormalizeDouble(smaH[0] +  spread + Porcentaje_ATR, _Digits); // smaH[0]  o tambien puede ser  lo que es  
   sl_sell = sl_sell + Rango_mitad_delaBarra;
   double rango_sell = NormalizeDouble((sl_sell - bid), _Digits); // aca esta el problema este 
   //double tp_sell = NormalizeDouble(bid - rango_sell*2 - spread, _Digits);  
 
 // - -- - - - - gestion monetaria venta
   
      double dif_sell = StopPriceToPoints(_Symbol, sl_sell, bid);
      double  tradeSize_sell = MoneyManagement(_Symbol, t_predeterm, MM_Percentage, dif_sell); // 1% del balance  //t_predeterm es el volum, minimo
   trade.Sell(tradeSize_sell,NULL,bid,infoprecio[3].high + spread);
   trade_ticket = trade.ResultOrder();
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

     }
   
   }
   
   //Print("hay una nueva barra ? o el tiempo de hoy es mayor que el de ayer", isNewBar() );

 
 
 //este es el probador para no intervenir directamente en el main