// Importamos la librería para poder hacer operaciones

/* 
Objetivos: modificar el programa para mejorar aspectos:
1- Poner parametros de entrada. listo
2- Cambiar condicion de ejecución.
3- 
*/

#include <Trade/Trade.mqh>
// Creamos un objeto que nos permitirá abrir operaciones
CTrade trade;
// Variable para guardar el ticket de la operación actual
ulong trade_ticket;

// Manejador del indicador bollinger bands
int bollinger_h;


//Variables de entrada:
input int MA_de_BB=20;
input int BB_Desplazamiento=0;
input int BB_Desviacion_Std=2;

enum PriceType
{
    PRICE_CLOSE,
    PRICE_OPEN,
    PRICE_HIGH,
    PRICE_LOW
};

input PriceType BB_Tipo_de_precio_a_calcular;     
// con ello enumeramos y tenemos la opcion de elegir ese tipo de parametro a fin de poder mod, en pantalla el tipo de calculo de MA del BB


//bollinger_h = iBands(_Symbol, _Period, 20, 0, 2, PRICE_CLOSE);


// Arrays para guardar las linéas del bollinger band
double bollinger_up[];
double bollinger_dw[];

// Arrays para guardar las velas
MqlRates velas[]; // sirve para almacenar la información sobre los precios, volúmenes y spread.

// Función para comprobar la condición de compra
bool condicion_compra() {
   // Si el close de la vela está por encima de la banda inferior
   // Y el open de la vela está por debajo de la banda inferior
   // COMPRA
   //return velas[0].close > bollinger_dw[0] && velas[0].open < bollinger_dw[0]; //esto voy a modificar, pero tambien parte grosa del algoritomo
   //por eso creare otro por las duas, la version proto 2.0.
   return velas[0].close > bollinger_dw[0] && velas[0].open < bollinger_dw[0];
}

// Función para comprobar la condición de venta
bool condicion_venta() {
   // Si el close de la vela está por debajo de la banda inferior
   // Y el open de la vela está por encima de la banda inferior
   // VENTA
   return velas[0].close < bollinger_up[0] && velas[0].open > bollinger_up[0];
}

// Función para comprobar si hay una operación abierta
bool operacion_cerrada() {
   return !PositionSelectByTicket(trade_ticket);
}

// Función para comprobar si estamos en una nueva vela
int bars;
bool nueva_vela() {
   int current_bars = Bars(_Symbol, _Period);
   if (current_bars != bars) {
      bars = current_bars;
      return true;
   }
   
   return false;
}

// Evento que inicializa el bot
int OnInit() {
   // Inicializamos el indicador de las bandas de bollinger
   //bollinger_h = iBands(_Symbol, _Period, 20, 0, 2, PRICE_CLOSE);
   bollinger_h = iBands(_Symbol, _Period, MA_de_BB, BB_Desplazamiento, BB_Desviacion_Std, BB_Tipo_de_precio_a_calcular);// asi elegimos nosotros los parametros
   if (bollinger_h == INVALID_HANDLE) {
      Print("Error al iniciar el indicador");
      return INIT_FAILED;
   }
   
   // Inicializamos los arrays para guardar los datos
   ArraySetAsSeries(bollinger_up, true);
   ArraySetAsSeries(bollinger_dw, true);
   ArraySetAsSeries(velas, true);
   
   /*
   la función ArraySetAsSeries se utiliza para establecer el orden de los elementos en un array. Específicamente, se 
   utiliza para indicar que el array debe ser tratado como una serie de tiempo, donde los elementos están ordenados desde 
   el más antiguo al más reciente Esto mejora la eficiencia del algoritmo.
   */

   return INIT_SUCCEEDED;
}

// Evento para cerrar el indicador cuando se cierre el bot
void OnDeinit(const int reason) {
   if (bollinger_h != INVALID_HANDLE) IndicatorRelease(bollinger_h);
}

// Evento a ejecutar en cada tick
void OnTick() {
   // Guardamos en los arrays la información necesaria
   // Recordad usar f1 con la función iBands, para saber que buffer
   // tiene cada línea
   CopyBuffer(bollinger_h, UPPER_BAND, 0, 1, bollinger_up);
   CopyBuffer(bollinger_h, LOWER_BAND, 0, 1, bollinger_dw);
   CopyRates(_Symbol, _Period, 0, 1, velas);

   // Condición de compra
   if (condicion_compra() && nueva_vela() && operacion_cerrada()) {
      // Obtenemos el Ask del mercado
      double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
      
      // Abrimos compra y guardamos el ticket de la posición
      trade.Buy(0.1, _Symbol, Ask, Ask-50*_Point, Ask+150*_Point);
      trade_ticket = trade.ResultOrder();
      
   // Condición de venta
   } else if (condicion_venta() && nueva_vela() && operacion_cerrada()) {
      // Obtenemos el Bid del mercado
      double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   
      // Abrimos venta y guardamos el ticket de la posición
      trade.Sell(0.1, _Symbol, Bid, Bid+50*_Point, Bid+150*_Point);
      trade_ticket = trade.ResultOrder();
   }
}