
// no salio, no abre posiciones noi de comprani de venta, investiga el programa base y fijate si asi lo podes resolver.

//+------------------------------------------------------------------+
//|                                          BB Dukascopy 80 3 3.mq5 |
//|                                                 elias Prueba 3.0 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "elias Prueba 3.0"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <MoneyManagement1.mqh>
#include <Trade/Trade.mqh>

CTrade trade;

ulong trade_ticket;

//definimos las variables

double B_superior[];
double B_Inferior[];
double B_del_Medio[];

//handlers
int BB_h;


int stop  = 400 ; // puntos del stop

double ask;
double bid;
double spread;

double tp_short;
double tp_long;
double k; // variable que me ayudara para calc tp´s

MqlRates barraM15[];
MqlRates barraH4[];

double t_predeterm = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool operacion_cerrada()
  {
   return !PositionSelectByTicket(trade_ticket); //Retorna true en caso de que la función se ejecute con éxito o sea encontró op. abierta. y pasamos del true a false
  }

// Función para comprobar si estamos en una nueva vela
int bars;
bool nueva_vela()
  {
   int current_bars = Bars(_Symbol, PERIOD_M15); // si no funciona sigue sin abri ordenes entonces mandale  M15.
   if(current_bars != bars)
     {
      bars = current_bars;
      return true;
     }

   return false;
  }

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {

   BB_h = iBands(_Symbol, PERIOD_M15, 80, 0, 3.1,PRICE_CLOSE);

   if(BB_h == INVALID_HANDLE)
     {
      Print("Error al iniciar el indicador");
      return INIT_FAILED;
     }

   ArraySetAsSeries(B_Inferior, true);
   ArraySetAsSeries(B_del_Medio, true);
   ArraySetAsSeries(B_superior, true);
   ArraySetAsSeries(barraM15, true);
   ArraySetAsSeries(barraH4, true); // para el stop loss en h4, min o max

   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   if(BB_h != INVALID_HANDLE)
      IndicatorRelease(BB_h);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   

   ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   spread = ask - bid;

   CopyBuffer(BB_h,  BASE_LINE, 0, 120, B_del_Medio);
   CopyBuffer(BB_h,  LOWER_BAND, 0, 120, B_Inferior);
   CopyBuffer(BB_h,  UPPER_BAND, 0, 120, B_superior);
   CopyRates(_Symbol, PERIOD_M15,0,115,barraM15);
   CopyRates(_Symbol, PERIOD_H4,0,115,barraH4);

//Calculo tp



   double tradeSize = MoneyManagement(_Symbol, t_predeterm, 10 , stop); // 1% del balance
//Ctrade trade

if(operacion_cerrada()){
   if((barraM15[0].close > B_superior[0]) && operacion_cerrada()  && nueva_vela() ) //Corto
     {
      /*k = (MathAbs(B_del_Medio[1] - B_Inferior[1])) /3;
      tp_short = B_Inferior[1] + k;
      trade.Buy(tradeSize, _Symbol, ask, bid + (stop*_Point) + spread,tp_short, "Orden Short Abierta");*/
      Print("corto en precio bid : ", bid);
      trade.Sell(tradeSize, _Symbol, bid, bid + (stop*_Point) + spread, bid - (stop*_Point)*2.5 - spread);
      trade_ticket = trade.ResultOrder();
     }


   else
      if((barraM15[0].close < B_Inferior[0]) && operacion_cerrada()  && nueva_vela() ) // Largo
        {
        /*
         k = (MathAbs(B_superior[1] - B_del_Medio[1])) /3;
         tp_long = B_superior[1] - k;
         trade.Sell(tradeSize, _Symbol, bid, ask - (stop*_Point) - spread,tp_long, "Orden Long Abierta"); */ // por  el comentario te da esta advertencia nada mas, perdida de datos string numbre, no pasa nada
         Print("Largo en precio ask: ", ask);
         trade.Buy(tradeSize, _Symbol, ask, ask - (stop*_Point) - spread,ask + (stop*_Point)*2.5 + spread);
         trade_ticket = trade.ResultOrder();// creo que esto faltaba para que cno abra miles de posiciones. // si eso es. perfecto ahora solo abre una a la vez pero el trailling stpo no se muev 
        }
}
//Trailling stop

//Abre muchas operaciones sera eso de ahi abajo ? r/ no 

//funcion que saqe de YT : tailling stop ; este lo copie del Archivo close on crose with trailling stop


   for(int i = PositionsTotal() - 1 ; i >= 0 ; i--)
     {
      ulong posTicket = PositionGetTicket(i);
      if(PositionSelectByTicket(posTicket))
        {
         double posSl = PositionGetDouble(POSITION_SL);

         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
           {

            //if((barraH4[1].low - spread - (20*_Point))> posSl)
            if((barraH4[1].low - spread - (10*_Point))> posSl )// creo q es es por ese orders total () == 1 ;)
              {

               trade.PositionModify(posTicket,(barraH4[1].low - spread - (10*_Point)), 0);
                 
              }

           }
         else
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
              {
               //if(stoplosssell < posSl || posSl == 0)
               //if((barraH4[1].high + spread + (20*_Point))< posSl)
               if((barraH4[1].high + spread + (10*_Point))< posSl)
                 {

                  trade.PositionModify(posTicket,(barraH4[1].high + spread + (10*_Point)), 0); // creo que el stop  de h4 funcionaba  
                    
                 }

              }
        }

     }


  }
//+------------------------------------------------------------------+

//cosas a hacer:

//este tiene el trailling stop en m15, péro lo quiero en h4, ¿se podra?;

