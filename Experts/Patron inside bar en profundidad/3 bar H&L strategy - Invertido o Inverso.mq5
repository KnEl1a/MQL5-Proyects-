#include <Trade\Trade.mqh>
#include <MoneyManagement1.mqh>

datetime lastBarTime = 0; //este creo que al final no se usaba

int patron_alcista = 0;
int patron_alcista1 = 0;

CTrade trade; 
ulong trade_ticket;

//--------EMAS--------------

int smaH_h;
int smaL_h;
int ATR_h;


double smaH[];
double smaL[];
double ATR[];


//Money management
double t_predeterm = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);
input int MM_Percentage = 2;// porcentaje de riesgo del balance

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
   smaL_h= iMA(_Symbol, _Period, 3, 0, MODE_SMA, PRICE_LOW);
   ATR_h = iATR(_Symbol, _Period, 14);
   
      if(smaH_h == INVALID_HANDLE || smaL_h == INVALID_HANDLE || ATR_h == INVALID_HANDLE)
     {
      Print("Error loading the indicators");
      return INIT_FAILED;
     }
     

  ArraySetAsSeries(smaH, true);
  ArraySetAsSeries(smaL, true);
  ArraySetAsSeries(ATR, true);
 
   
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
  
  
   CopyBuffer(smaH_h, 0, 0, 6, smaH);
   CopyBuffer(smaL_h, 0, 0, 6, smaL);
   CopyBuffer(ATR_h, 0, 0, 6, ATR);   
  
  
  double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
  double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
  double spread = NormalizeDouble(ask - bid,_Digits); 
  
  
  double Porcentaje_ATR = NormalizeDouble(ATR[1]*0.35, _Digits); 
   CopyRates(_Symbol, _Period, 0,10, infoprecio);
   double Rango_mitad_delaBarra = NormalizeDouble(((infoprecio[1].high + spread) - (infoprecio[1].low - spread))/200, _Digits); // donde el denominador es 100 era un 2 en lugar de eso o sea la mitad del rango 
   
   
   //double rango = NormalizeDouble((ask - (infoprecio[1].low - spread)), _Digits);
  
   //smash Bar alcista // + tendencia alcista
   
   // if((infoprecio[0].close == infoprecio[0].low) && nueva_vela())
   //if((smaL[0]>smaL[1]) && (infoprecio[0].close < smaL[0]) && operacion_cerrada() && nueva_vela())
   if((smaH[0]<smaH[1]) && (infoprecio[0].close > smaH[0]) && (ask > smaH[0]) && operacion_cerrada() && nueva_vela())
   {
   patron_alcista = patron_alcista + 1;
   Print("Patron bar alcista ocurrio: ", infoprecio[1].time, "y su spread o diferencial fue de ", infoprecio[1].spread ); // un lujo , una maravilla el algoritmo
   
   //double sl_buy = NormalizeDouble(smaL[0] -  spread - Porcentaje_ATR, _Digits);
   //sl_buy = sl_buy - Rango_mitad_delaBarra;
   //double rango_buy = NormalizeDouble((ask - sl_buy), _Digits);
   //double tp_buy = NormalizeDouble(ask + rango_buy*2 + spread, _Digits);  
   //-----------------------------------------------------------------------
   double sl_buy = NormalizeDouble(smaH[0] +  spread + Porcentaje_ATR, _Digits);// va a ser mi take profit
   sl_buy = sl_buy + Rango_mitad_delaBarra;
   double rango_buy = NormalizeDouble(( sl_buy - ask), _Digits);
   double tp_buy = NormalizeDouble(ask - rango_buy*2 - spread, _Digits);  //que va a ser mi stop loss
   
   //gestion monetaria compra
   double dif_buy = StopPriceToPoints(_Symbol, tp_buy, ask);// el tp buy va a ser nuestro stop price
   double  tradeSize_buy = MoneyManagement(_Symbol, t_predeterm, MM_Percentage, dif_buy); // 2% del balance predeterminado a arriesgar del balance
   
   
   trade.Buy(tradeSize_buy,NULL,ask,tp_buy,sl_buy); // segun lo razonado sería lo contrario
   trade_ticket = trade.ResultOrder();
   }
   
  //el sistema es terriblemente malo, pero consistete vamos a ver si inviertiendo podemos ganarle al mercado
   
   
   
   //if((smaL[0]>smaL[1]) && (infoprecio[0].close < smaL[0]) && (bid < smaL[0]) && operacion_cerrada() && nueva_vela())
   if((smaL[0]>smaL[1]) && (infoprecio[0].close < smaL[0]) && operacion_cerrada() && nueva_vela())
   {
    patron_alcista1 = patron_alcista1 + 1;
   Print("smash bar bajista ocurrio: ", infoprecio[1].time, "y su spread o diferencial fue de ", infoprecio[1].spread ); // un lujo , una maravilla el algoritmo
   
   double sl_sell = NormalizeDouble(smaL[0] -  spread - Porcentaje_ATR, _Digits); // smaH[0]  o tambien puede ser  lo que es  
   sl_sell = sl_sell - Rango_mitad_delaBarra; //toma de ganancias
   double rango_sell = NormalizeDouble((bid - sl_sell), _Digits); // aca esta el problema este 
   double tp_sell = NormalizeDouble(bid + rango_sell*2 + spread, _Digits);  
 
 // - -- - - - - gestion monetaria venta   //  si quiero que el sistema sea exactamente lo contrario debo invertir los stop loss, o sea mi take seria mi stop, y asi
   
      double dif_sell = StopPriceToPoints(_Symbol, tp_sell, bid);
      double  tradeSize_sell = MoneyManagement(_Symbol, t_predeterm, MM_Percentage, dif_sell); // 2% del balance  //t_predeterm es el volum, minimo
   trade.Sell(tradeSize_sell,NULL,bid,tp_sell,sl_sell);
   trade_ticket = trade.ResultOrder();
   }}
   
   //Print("hay una nueva barra ? o el tiempo de hoy es mayor que el de ayer", isNewBar() );

 
 
 //este es el probador para no intervenir directamente en el main