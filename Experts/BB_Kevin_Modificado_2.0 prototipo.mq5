// Importamos la librería para poder hacer operaciones

/*
NOTA sobre : la opcion de  maxima compilación sirve mas que nada para poder parovechar todos los reursos del pc todos los agentes de manera
 optimiza ya que una compilacion simple solo permitira usar un solo agente.
 <<>> O sea para backtestear y optimizar mas rapido.
 */

/*

Objetivos: modificar el programa para mejorar aspectos:
1- Poner parametros de entrada. listo

2- Cambiar condicion de ejecución. listo: le tengo desconfianza
How to do this?: i am re-writing  this code, lo que hice fue meterme y haberiguar MqlRates que parece que te sirve para tomar datos de
todo lo que es OHLC del precion (y el tiempo) entonces con ello luego vi que existe el copyrates para eso mismo meterle los datos al
array dinamico y previamente tenemos que tener un ordenador de array.

3- Cambiar condicion de cierre de la operacion. Nota: la unica condicion de cierre que vi es el stop loss y take profit por lo que voy a limitarme en poner modificar el parametro asignable al inicion de la ejecucion del algoritmo. 

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
input int Stp=50; // stop loss, el tp es igual a 2* stp, o sea por defecto en este caos es 100.

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
bool condicion_compra()
  {
// Si el close de la vela está por encima de la banda inferior
// Y el open de la vela está por debajo de la banda inferior
// COMPRA
//return velas[0].close > bollinger_dw[0] && velas[0].open < bollinger_dw[0]; //esto voy a modificar, pero tambien parte grosa del algoritomo
//por eso creare otro por las duas, la version proto 2.0.
   return velas[0].close < bollinger_dw[0]; //bool retorna true
  }

// Función para comprobar la condición de venta
bool condicion_venta()
  {
// Si el close de la vela está por debajo de la banda inferior
// Y el open de la vela está por encima de la banda inferior
// VENTA
//return velas[0].close < bollinger_up[0] && velas[0].open > bollinger_up[0];
   return velas[0].close > bollinger_up[0]; // si la barras de un minuto cierran por encima de de alas desviacion estandar entonces venda.
  }

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
   int current_bars = Bars(_Symbol, _Period); // acá estaba el bicho me parece. eso del _period
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
// Inicializamos el indicador de las bandas de bollinger
//bollinger_h = iBands(_Symbol, _Period, 20, 0, 2, PRICE_CLOSE);
   bollinger_h = iBands(_Symbol, _Period, MA_de_BB, BB_Desplazamiento, BB_Desviacion_Std, BB_Tipo_de_precio_a_calcular);// asi elegimos nosotros los parametros
   if(bollinger_h == INVALID_HANDLE)
     {
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
void OnDeinit(const int reason)
  {
   if(bollinger_h != INVALID_HANDLE)
      IndicatorRelease(bollinger_h);
  }
/*
En resumen, liberar el indicador de Bollinger en el evento OnDeinit es una práctica recomendada para garantizar
una gestión adecuada de recursos y evitar problemas potenciales al cerrar o desactivar el EA (volviendo lo mas robusto y "profesional").
*/



// Evento a ejecutar en cada tick
void OnTick()
  {
// Guardamos en los arrays la información necesaria
// Recordad usar f1 con la función iBands, para saber que buffer
// tiene cada línea}
   
   CopyBuffer(bollinger_h, UPPER_BAND, 0, 1, bollinger_up); // ese uno viene de que copia el dato nterior fundamentalmente , proba poniendole cero
   CopyBuffer(bollinger_h, LOWER_BAND, 0, 1, bollinger_dw);
//CopyRates(_Symbol, _Period, 0, 1, velas);// aca te modifico
   CopyRates(_Symbol, PERIOD_M1, 0, 1, velas);

// Condición de compra
   if(condicion_compra() && nueva_vela() && operacion_cerrada())
     {
      // Obtenemos el Ask del mercado
      double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);

      // Abrimos compra y guardamos el ticket de la posición
      trade.Buy(0.1, _Symbol, Ask, Ask-Stp*_Point, Ask+(Stp*2)*_Point);
      trade_ticket = trade.ResultOrder();

      // Condición de venta
     }
   else
      if(condicion_venta() && nueva_vela() && operacion_cerrada())
        {
         // Obtenemos el Bid del mercado
         double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);

         // Abrimos venta y guardamos el ticket de la posición
         trade.Sell(0.1, _Symbol, Bid, Bid+Stp*_Point, Bid-(Stp*2)*_Point);
         trade_ticket = trade.ResultOrder(); //result oreder : Obtiene el ticket de la orden 
        }
        //ctrade
  }
