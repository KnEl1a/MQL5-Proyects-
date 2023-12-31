//+------------------------------------------------------------------+
//|       Trailing Stop y Gestion monetaria estrategia simple MA.mq5 |
//|                 Un aprendis de richard dennis - Kevin de la coba |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#property copyright "Un aprendis de richard dennis - Kevin de la coba"
#property link      "https://www.mql5.com"
#property version   "1.00"

//Opero ante cruces de EMA 10 y EMA 100
//Trailing stop de 3 ATR desde maximos si es compra o desde minimos si es venta.
//Uso un 1% del capital . SI listo
//(tratare de calcularlo con ATR para incrementar posicion cuando sea menos volatil el mercado y disminuir lote cuando el mercado dsea mas volatil) . No aun no.
//encontrar la forma de estudiar la correlacion de las estrategias.

//"El sistema es lo de menos, lo importante es seguir la tendencia y gestionar bien el capital".
//enseña el hombre como se puede estar a la par o incluso superar a los grandes fondos, recuerde que los minoristas requieren menos liquides para entrar y salir.

#include <Trade/Trade.mqh>
#include <MoneyManagement1.mqh>


// Creamos un objeto que nos permitirá abrir operaciones
CTrade trade;



ulong trade_ticket; // acá dejalo tipo ulong para evitar errores

//handlers
int Ema_10_h;
int Ema_100_h;
int ATR_h;

//Varaialbles para la gesition monetaria
input double porcentaje_de_riesgo = 2;
input double volume_predeterminado_para_entrar = 0.1;
int  Stoppips;

//entradas
input int MAperiodoATR=14;


//variables de entrda a modo de input por si se quiere optimizar los parametros.

input int MA10_periodo=10;//Periodo MA rapida
input int MA10_Desplazamiento;//Su Desplazamiento
input int MA100_periodo=100;//Periodo MA lenta
input int MA100_Desplazamiento=0;//Su Desplazamiento
//input int Stp=100;//Stop loss en ticks

enum PriceType
  {
   PRICE_CLOSE,
   PRICE_HIGH,
   PRICE_LOW,
   PRICE_OPEN
  }; // acordate del puunto  y  coma acá

input PriceType Ema_tipos_de_precio;

double Ema_100[];
double Ema_10[];
double ATR[];


double minimo[];
double maximos[];

MqlTradeRequest request1;
MqlTradeResult result1;
//condiciones para entrar
bool compra()
  {
   return Ema_10[1]>Ema_100[1];
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool venta() // acordate de poner los parentesis en las funciones
  {
   return Ema_10[1]<Ema_100[1];
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool operacion_cerrada()
  {
   return !PositionSelectByTicket(trade_ticket); //Retorna true en caso de que la función se ejecute con éxito o sea encontró op. abierta.
//esto significa que si encontro operac. abierta devuelve true pero al estar el not (!) queda false, indicando que aun no se cerro la  operacion.
  }

//verifico generacion d nuevas velas a traves de esta funcion;
int bars;
bool nueva_vela()
  {
   int current_bars = Bars(_Symbol, _Period);
   if(current_bars != bars)
     {
      bars = current_bars;
      return true;
     }//vigila esta func
   return false;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {

   ATR_h = iATR(_Symbol,_Period,MAperiodoATR);
   if(ATR_h == INVALID_HANDLE)
     {
      Print("Error al iniciar el indicador");
      return INIT_FAILED;
     }

//arreglamos array para introducir luego los valores
   ArraySetAsSeries(ATR, true);

   Ema_10_h = iMA(_Symbol,_Period, MA10_periodo,MA10_Desplazamiento,MODE_EMA,Ema_tipos_de_precio); // aca no va pri
   Ema_100_h = iMA(_Symbol,_Period, MA100_periodo,MA100_Desplazamiento,MODE_EMA,Ema_tipos_de_precio);

   if(Ema_10_h == INVALID_HANDLE && Ema_100_h == INVALID_HANDLE)
     {
      Print("Error al iniciar el indicador");
      return INIT_FAILED;
     }

// Inicializamos los arrays para guardar los datos
   ArraySetAsSeries(Ema_10, true);
   ArraySetAsSeries(Ema_100, true);
   // la indexación de los elementos del array va a efectuarse como en las series temporales para todos estos array dinamicos
   ArraySetAsSeries(minimo, true);
   ArraySetAsSeries(maximos, true);
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   if(Ema_10_h != INVALID_HANDLE && Ema_100_h != INVALID_HANDLE)
     {
      IndicatorRelease(Ema_10_h);
      IndicatorRelease(Ema_100_h);// al salir , Elimina el manejador del indicador y libera la parte calculadora del indicador si nadie la usa
     }

   if(ATR_h != INVALID_HANDLE)
      IndicatorRelease(ATR_h);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()

// Guardamos en los arrays la información necesaria

  {
   CopyLow(_Symbol, _Period,0,5,minimo); // para los minimos especificamos en oninit el array set
   CopyHigh(_Symbol, _Period, 0,5,maximos);// para los maximos especificamos en oninit el array set
   CopyBuffer(ATR_h, 0, 0, 5, ATR);
   Stoppips = ATR[0] / _Point; // para money management de % 
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   double spread = Ask - Bid; 
   double tradeSize = MoneyManagement(_Symbol, volume_predeterminado_para_entrar, porcentaje_de_riesgo, Stoppips);

   CopyBuffer(Ema_10_h, 0, 0, 5, Ema_10); // ese uno viene de que copia el dato nterior fundamentalmente , proba poniendole cero
   CopyBuffer(Ema_100_h, 0, 0, 5, Ema_100); // o sea copiamos buffer de indicador que se precargar y calcula a fin de evitar demoras
//CopyRates(_Symbol, _Period, 0, 1, velas);// aca te modifico


//condicion de compra
// Condición de compra
   if(compra() && nueva_vela() && operacion_cerrada())
     {
  
      // Abrimos compra y guardamos el ticket de la posición
      //trade.Buy(tradeSize, _Symbol, Ask, maximos[1]-((ATR[1]*_Point)*3) - spread, 0); // acá debemos modificar y aplicar gestion de capital.
      trade.Buy(tradeSize, _Symbol, Ask, maximos[1]- 1000*_Point - spread, Ask + 3000*_Point); // este funciono
      trade_ticket = trade.ResultOrder();


     }

//venta
   else
      if(venta() && nueva_vela() && operacion_cerrada())
        {
         // Obtenemos el Bid del mercado


         // Abrimos venta y guardamos el ticket de la posición
         //trade.Sell(tradeSize, _Symbol, Bid, minimo[1]+((ATR[1]*_Point)*3) + spread, 0);
         trade.Sell(tradeSize, _Symbol, Bid, minimo[1]+ 1000*_Point + spread, Bid - 3000*_Point);
         trade_ticket = trade.ResultOrder();//result oreder : Obtiene el ticket de la orden
        }
        
        /*
        //trailling stop
        if(PositionSelect(_Symbol) == true && Stoppips > 0)
  {
   request.action = TRADE_ACTION_SLTP;
   request.symbol = _Symbol;
   long posType = PositionGetInteger(POSITION_TYPE);
   double currentStop = PositionGetDouble(POSITION_SL);
   double trailStop = ATR[0];
   double trailStopPrice;
   if(posType == POSITION_TYPE_BUY)
     {
      trailStopPrice = maximos[1] - trailStop;

      if(trailStopPrice > currentStop)
        {
         request.sl = trailStopPrice;
         OrderSend(request,result);
        }
     }
   else
      if(posType == POSITION_TYPE_SELL)
        {
         trailStopPrice = SymbolInfoDouble(_Symbol,SYMBOL_ASK) + trailStop;
         if(trailStopPrice < currentStop)
           {
            request.sl = trailStopPrice;
            OrderSend(request,result);
           }
        }
  }
*/

  }
//+------------------------------------------------------------------+
