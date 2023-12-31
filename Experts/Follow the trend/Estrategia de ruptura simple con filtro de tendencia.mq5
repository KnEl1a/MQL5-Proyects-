//+------------------------------------------------------------------+
//|         Estrategia de ruptura simple con filtro de tendencia.mq5 |
//|                                                            Elias |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
/*

las reglas son muy simples y son reglas similares a las que usan los fondos de cobertura de materias primas, para seguir tendencias unicamente en base al precio.

tenemos dos filtros de tendencias

- Dos medias moviles, no aclara el libro si son simples o exponenciales asi que la haremos con las simples que para el largo plazo funcionan mejor
si las medias moviles se cruzan indican direccion de la tendencias

- Operamos con una ruptura de un "canal de donchian" del cierre mas alto o bajo de los ultimos 50 dias y salimos  y o pactamos contratos segun la volatilidad ATR de 3 desde el precio de cirre

- no arriesgamos mas que el 0.25% del capital

- necesitamos un capital grande para seguir la tendencia o sea aprox unos 50000 usd en la cuenta

- opearmos solo en graf. diarios y no de plazos mas bajos. o sea seguimos la tendencia hasta las idnicaciones de que e sta cambie
*/

#include <Trade/Trade.mqh>
#include <MoneyManagement1.mqh>

CTrade trade;

//Variables de entrada
input double Riesgo = 0.25;
double t_predeterm = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);
double stoplosssell;
double stoplossbuy;

ulong trade_ticket;

double close[];

MqlRates precios[];


int sma_50_h;
int sma_100_h;

double sma_50[];
double sma_100[];

int ATR_h;
double ATR[];


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool operacion_cerrada()
  {
   return !PositionSelectByTicket(trade_ticket);
  }
//----------------------------

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool filtro_tendencia_compra()
  {
   return sma_50[1] > sma_100[1];
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool filtro_tendencia_venta()
  {
   return sma_50[1] < sma_100[1];
  }

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

//------------------------------


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

   sma_50_h = iMA(_Symbol, PERIOD_CURRENT, 50, 0, MODE_SMA, PRICE_CLOSE);
   sma_100_h = iMA(_Symbol, PERIOD_CURRENT, 100, 0, MODE_SMA, PRICE_CLOSE);
   ATR_h = iATR(_Symbol, PERIOD_CURRENT, 20);

   if(sma_100_h == INVALID_HANDLE && sma_50_h == INVALID_HANDLE && ATR_h == INVALID_HANDLE)
     {
      Print("Error al iniciar el indicador");
      return INIT_FAILED;
     }

   ArraySetAsSeries(sma_100, true);
   ArraySetAsSeries(sma_50, true);
   ArraySetAsSeries(ATR, true);



//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |

//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   ArraySetAsSeries(close,true);
   ArraySetAsSeries(precios,true);

   if(ATR_h != INVALID_HANDLE)
      IndicatorRelease(ATR_h);
   if(sma_100_h!= INVALID_HANDLE)
      IndicatorRelease(sma_100_h);
   if(sma_50_h!= INVALID_HANDLE)
      IndicatorRelease(sma_50_h);

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   CopyBuffer(sma_100_h, 0, 0, 4, sma_100);
   CopyBuffer(sma_50_h, 0, 0, 4, sma_50);
   CopyBuffer(ATR_h, 0, 0, 4, ATR);
   CopyRates(_Symbol, PERIOD_CURRENT, 0, 0, precios);
   double Stoppips = (ATR[1]*3)/_Point;
   CopyClose(_Symbol,_Period,0,100,close);


   int minIdx = NormalizeDouble(ArrayMinimum(close,0,50),_Digits);
   int maxIdx = NormalizeDouble(ArrayMaximum(close,0,50),_Digits);

   double lowest_close= close[minIdx];
   double highest_close= close[maxIdx];

//
//Stops para el trailling
  
   //stoplosssell=(precios[1].close + (ATR[1]*3)); // otra forma es con iLow
   stoplossbuy=(precios[1].close - (ATR[1]*3));// otra forma es con iHigh
   stoplosssell=(precios[1].close + (ATR[1]*3));// otra 
   
//gestion monetaria
   double tradeSize = MoneyManagement(_Symbol, t_predeterm, Riesgo, Stoppips);// ojo que acá no esta bien calcula da la gestion del riesgo

   if(operacion_cerrada())
     {

      if(filtro_tendencia_compra() && nueva_vela() && precios[1].close > highest_close)
      {
        
         
         trade.Buy(tradeSize, _Symbol, precios[0].open);
         
         trade_ticket = trade.ResultOrder();
      }
      
      if(filtro_tendencia_venta() && nueva_vela() && precios[1].close < lowest_close)
      {
         
         
         trade.Sell(tradeSize, _Symbol, precios[0].open);
         
         trade_ticket = trade.ResultOrder();
      }
      
     }
     
     
     
     
     for(int i = PositionsTotal() - 1 ; i >= 0 ; i--)
     {
      ulong posTicket = PositionGetTicket(i);
      if(PositionSelectByTicket(posTicket))
        {
         double posSlBuy = stoplossbuy;
         double posSlSell= stoplosssell;

         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
           {

            if(stoplossbuy > posSlBuy)
              {

               if(trade.PositionModify(posTicket,stoplossbuy, 0))
                 {
                  Print(__FUNCTION__, " > Pos # ", posTicket, "was modified ... ");
                  //(__FUNCTION__) es una característica del lenguaje que devuelve el nombre de la función en la que se encuentra en tiempo de compilación.
                 }
              }

           }
         else
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
              {
               //if(stoplosssell < posSl || posSl == 0)
               if(stoplosssell < posSlSell)
                 {

                  if(trade.PositionModify(posTicket,stoplosssell, 0))
                    {
                     Print(__FUNCTION__, " > Pos # ", posTicket, "was modified ... ");
                     //(__FUNCTION__) es una característica del lenguaje que devuelve el nombre de la función en la que se encuentra en tiempo de compilación.
                    }
                 }

              }
        }


     }
     
     
     
     
     //cierre de posicion en caso de que el precio cierre por debajo del rango ATR * 3 desde el cierre 
     // if(nueva_vela() && PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY && (precios[1].close < stoplossbuy || precios[1].close < stop%%%% ) 
        //{
         //trade.PositionClose(trade_ticket); // entonces cerrame el ultimo trade.
        //}
     

  }
//+------------------------------------------------------------------+




//notas
/*

directamente no tenemos que poner le stop loss creo porque si no salta, si no agregar una condicion imaginaria un punto de parada 
"que no se coloque, tipo imaginario, y cuando el precio de cierre sea mas bajo que eso entonces salimos"

la idea es esa


*/