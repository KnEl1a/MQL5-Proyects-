#include <Trade\Trade.mqh>

datetime lastBarTime = 0;

int InsideBar = 0;
int InsideBar1 = 0;

CTrade trade; 
ulong trade_ticket;

//--------EMAS--------------
int ema_4_h;
int ema_18_h;
int ema_40_h;
int SMA_200_h;

double ema_4[];
double ema_18[];
double ema_40[];
double SMA_200[];

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



bool tendencia_alcista()
  {
   //return ema_fast[1] < ema_slow[1] && ema_fast[0] > ema_slow[0]; //creo que retorna true si la condicion se da
   return ema_4[1]>ema_18[1]>ema_40[1]>SMA_200[1];
   //return ema_4[0]>ema_18[0]>ema_40[0]; //aunque yo me quedaria con la segunda //nota y tambien estaria bueno proobar lo que es una EMA de 200
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
   ema_4_h= iMA(_Symbol, _Period, 4, 0, MODE_EMA, PRICE_CLOSE);
   ema_18_h = iMA(_Symbol, _Period, 18, 0, MODE_EMA, PRICE_CLOSE);
   ema_40_h = iMA(_Symbol, _Period, 40, 0, MODE_EMA, PRICE_CLOSE);
   SMA_200_h = iMA(_Symbol, _Period, 200, 0, MODE_SMA, PRICE_CLOSE);
   
      if(ema_4_h == INVALID_HANDLE || ema_18_h == INVALID_HANDLE || ema_40_h == INVALID_HANDLE || SMA_200_h == INVALID_HANDLE)
     {
      Print("Error loading the indicators");
      return INIT_FAILED;
     }
     
  ArraySetAsSeries(ema_4, true);
  ArraySetAsSeries(ema_18, true);
  ArraySetAsSeries(ema_40, true);
  ArraySetAsSeries(SMA_200, true);
   
   return INIT_SUCCEEDED;
  }
  
  void OnDeinit(const int reason)
  {
   if(ema_4_h != INVALID_HANDLE)
      IndicatorRelease(ema_4_h);
   if(ema_18_h != INVALID_HANDLE)
      IndicatorRelease(ema_18_h);
   if(ema_40_h != INVALID_HANDLE)
      IndicatorRelease(ema_40_h);
   if(SMA_200_h != INVALID_HANDLE)
      IndicatorRelease(SMA_200_h);
  }


void OnTick()
  {
  
   CopyBuffer(ema_4_h, 0, 1, 2, ema_4);
   CopyBuffer(ema_18_h, 0, 1, 2, ema_18);
   CopyBuffer(ema_40_h, 0, 1, 2, ema_40);
   CopyBuffer(SMA_200_h, 0, 1, 2, SMA_200);
  
  double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
  double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
  double spread = NormalizeDouble(ask - bid,_Digits); 
  
   CopyRates(_Symbol, _Period, 0,10, infoprecio);
   double Rango_mitad_delaBarra = NormalizeDouble(((infoprecio[1].high + spread) - (infoprecio[1].low - spread))/2, _Digits);
   
   //double rango = NormalizeDouble((ask - (infoprecio[1].low - spread)), _Digits);
  
   //Inside Bar alcista // + tendencia alcista
   if (ema_4[1] > ema_18[1] && ema_18[1] > ema_40[1] && ema_40[1]>SMA_200[1]) {
   if(((infoprecio[2].low < infoprecio[1].low) && (infoprecio[2].high > infoprecio[1].high) && (infoprecio[0].close > infoprecio[1].high)) && nueva_vela())
   {
   InsideBar = InsideBar + 1;
   Print("inside bar alcista ocurrio: ", infoprecio[1].time, "y su spread o diferencial fue de ", infoprecio[1].spread ); // un lujo , una maravilla el algoritmo
   
  
   
   double sl_buy = NormalizeDouble(infoprecio[1].low -  spread, _Digits);
   sl_buy = sl_buy - Rango_mitad_delaBarra;
   double rango_buy = NormalizeDouble((ask - sl_buy), _Digits);
   double tp_buy = NormalizeDouble(ask + rango_buy*2.1 + spread, _Digits);  
   //nada el stop parece funcionar perfecto, y el algoritmo parece finalizar en ganancias
   //nota es impresiso porque el spread cambia y por lo tanto lo que tenemos que hacer es ver el spread promedio que creo que figura en la pagina de ic markets
   // el calculo del rango es incorrecto voy a hacerlo de otra manera para ver sii sale, porque necesito arriesgar con precicion por ejemplo 2:1 
   
   trade.Buy(1,NULL,ask,sl_buy,tp_buy);
   }
   }
   
   
   
   //Inside Bar bajista // + tendencia bajista
   if (ema_4[1] < ema_18[1] && ema_18[1] < ema_40[1] && ema_40[1]<SMA_200[1]) {
   if(((infoprecio[2].low < infoprecio[1].low) && (infoprecio[2].high > infoprecio[1].high) && (infoprecio[0].close < infoprecio[1].low)) && nueva_vela())
   {
    InsideBar1 = InsideBar1 + 1;
   Print("inside bar bajista ocurrio: ", infoprecio[1].time, "y su spread o diferencial fue de ", infoprecio[1].spread ); // un lujo , una maravilla el algoritmo
   
   double sl_sell = NormalizeDouble(infoprecio[1].high +  spread, _Digits); // el stop es invalido dice
   sl_sell = sl_sell+ Rango_mitad_delaBarra;
   double rango_sell = NormalizeDouble((sl_sell - bid), _Digits); // aca esta el problema este 
   double tp_sell = NormalizeDouble(bid - rango_sell*2.1 - spread, _Digits);  
   //nada el stop parece funcionar perfecto, y el algoritmo parece finalizar en ganancias
   //nota es impresiso porque el spread cambia y por lo tanto lo que tenemos que hacer es ver el spread promedio que creo que figura en la pagina de ic markets
   // el calculo del rango es incorrecto voy a hacerlo de otra manera para ver sii sale, porque necesito arriesgar con precicion por ejemplo 2:1 
   
   trade.Sell(1,NULL,bid,sl_sell,tp_sell);
   }}
   
   //Print("hay una nueva barra ? o el tiempo de hoy es mayor que el de ayer", isNewBar() );
   
   Comment("CANTIDADES\n Doji normal: ",
   "\n Inside Bar alcista: ", InsideBar,
   "\n Inside Bar bajista: ", InsideBar1);
 
 }
 
 //este es el probador para no intervenir directamente en el main