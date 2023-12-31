

//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+


#include <Trade/Trade.mqh>

CTrade trade;

ulong trade_ticket;


int bollinger_h;


//Variables de entrada:
input int MA_de_BB=8;
input int BB_Desplazamiento=0;
input double BB_Desviacion_Std=2.8;
input int Stp=50; // stop loss, el tp es igual a 2* stp, o sea por defecto en este caos es 100.
double PRICE_CLOSE_Medio;

enum PriceType
  {
   PRICE_CLOSE,
   PRICE_OPEN,
   PRICE_HIGH,
   PRICE_LOW,
   PRICE_MEDIAN,
   PRICE_TYPICAL,
   PRICE_WEIGHTED,
   PRICE_CLOSE_Medio
  };

input PriceType BB_Tipo_de_precio_a_calcular;

// Arrays para guardar las linéas del bollinger band
double bollinger_up[];
double bollinger_dw[];

// Arrays para guardar las velas
MqlRates velas[]; // sirve para almacenar la información sobre los precios, volúmenes y spread.
MqlRates precio[]; // sirve para almacenar la información sobre los precios, volúmenes y spread.

// Función para comprobar la condición de compra
// Función para comprobar si hay una operación abierta
bool operacion_cerrada()
  {
   return !PositionSelectByTicket(trade_ticket); //Retorna true en caso de que la función se ejecute con éxito o sea encontró op. abierta.
  }/*
este operador ! significa not o "negacion", entonces acá: si la expresión es verdadera,
"!expresion" será falso, y si la expresión es falsa, "!expresion" será verdadero.
*/

// Función para comprobar si estamos en una nueva vela
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

// Evento que inicializa el bot
int OnInit()
  {
   bollinger_h = iBands(_Symbol, _Period, MA_de_BB, BB_Desplazamiento, BB_Desviacion_Std, BB_Tipo_de_precio_a_calcular);// asi elegimos nosotros los parametros
   if(bollinger_h == INVALID_HANDLE)
     {
      Print("Error al iniciar el indicador");
      return INIT_FAILED;
     }

   ArraySetAsSeries(bollinger_up, true);
   ArraySetAsSeries(bollinger_dw, true);
   ArraySetAsSeries(velas, true);
   ArraySetAsSeries(precio, true);

   return INIT_SUCCEEDED;
  }

// Evento para cerrar el indicador cuando se cierre el bot
void OnDeinit(const int reason)
  {
   if(bollinger_h != INVALID_HANDLE)
      IndicatorRelease(bollinger_h);
  }

// Evento a ejecutar en cada tick
void OnTick()
  {
  
  double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
  double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
  CopyRates(_Symbol, _Period, 0,6,precio);
  //PRICE_CLOSE_Medio = (((precio[1].high + precio[1].low )/ 2) + ((precio[2].high + precio[2].low )/ 2) + ((precio[3].high + precio[3].low )/ 2) + ((precio[4].high + precio[4].low )/ 2)) / 4;
  PRICE_CLOSE_Medio = (((precio[0].high + precio[0].low )/ 2) + ((precio[2].high + precio[2].low )/ 2) + ((precio[3].high + precio[3].low )/ 2) + ((precio[4].high + precio[4].low )/ 2)) / 10;
  //PRICE_CLOSE_Medio = (precio[1].high + precio[1].low )/ 2;
//PRICE_TYPICAL_Modified = (velas[h].high + velas[l].low)/2;
   CopyBuffer(bollinger_h, UPPER_BAND, 0, 3, bollinger_up); // ese uno viene de que copia el dato nterior fundamentalmente , proba poniendole cero
   CopyBuffer(bollinger_h, LOWER_BAND, 0, 3, bollinger_dw);
//CopyRates(_Symbol, _Period, 0, 1, velas);// aca te modifico
   CopyRates(_Symbol, PERIOD_M1, 0, 1, velas);

// Condición de compra
   if(Ask = bollinger_dw[0] && nueva_vela() && operacion_cerrada())
     {
      // Obtenemos el Ask del mercado
      

      // Abrimos compra y guardamos el ticket de la posición
      trade.Buy(0.1, _Symbol, Ask, Ask-Stp*_Point, Ask+(Stp*2)*_Point);
      trade_ticket = trade.ResultOrder();

      // Condición de venta
     }
   else
      if(Bid = bollinger_up[0] && nueva_vela() && operacion_cerrada())
        {
         // Obtenemos el Bid del mercado
         

         // Abrimos venta y guardamos el ticket de la posición
         trade.Sell(0.1, _Symbol, Bid, Bid+Stp*_Point, Bid-(Stp*2)*_Point);
         trade_ticket = trade.ResultOrder(); //result oreder : Obtiene el ticket de la orden
        }
//ctrade
  }
//+------------------------------------------------------------------+

