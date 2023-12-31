//nota esta mal, no ejecuta ordenes y da error


// Input variables
input double TradeVolume=0.1;
input int StopLoss=1000;
input int TakeProfit=1000;
input int MAPeriod=10;



// Global variables
bool glBuyPlaced, glSellPlaced; //entonces al no especificar true inicializa como false, con estas variables veo si se tiene una orden abierta
//ese gl adelante es porque  las declara como global, asi evitamos q se abra otra posicion en la misma
//direccion depues de q salte stop loss o take profit.


// OnTick() event handler
void OnTick()
  {

// Trade structures
   MqlTradeRequest request; //la estructura especial predefinida MqlTradeRequest que contiene todos los campos necesarios para celebrar las transacciones comerciales
   MqlTradeResult result;//Respondiendo a una solicitud comercial acerca de colocación de una orden en el sistema comercial
   ZeroMemory(request);//La función reinicializa la variable que le ha sido pasada por referencia.
   /*La función ZeroMemory() garantiza que las variables miembro del objeto de solicitud se pongan a cero. No incluir la función
   ZeroMemory() puede causar errores de ejecución de órdenes."*/

// Moving average
   double ma[];
   ArraySetAsSeries(ma,true);
   /*Cuando se utiliza "ArraySetAsSeries", los elementos más recientes del array se colocan al principio, y los elementos más antiguos quedan
   al final del array. Asi los indicadoores y demas funcioanaran correctamente.
   "ArraySetAsSeries" es una función utilizada en MQL para cambiar la dirección de los elementos de un array en el tiempo,
   lo que facilita el análisis técnico y el cálculo de indicadores en MetaTrader.  Los arrays estáticos tienen un tamaño fijo que se establece al
   momento de la declaración, mientras que los arrays dinámicos pueden cambiar su tamaño en tiempo de ejecución según las necesidades del programa.*/

   /*El código anterior inicializa las matrices que contienen los valores promedio móviles y los precios de cierre. Discutiremos los
   datos de precios e indicadores en los capítulos 16 y 17. La matriz ma[] contiene los valores del indicador de promedio móvil,
   mientras que la matriz close[] contiene el precio de cierre de cada barra.*/


   int maHandle=iMA(_Symbol,0,MAPeriod,MODE_SMA,0,PRICE_CLOSE);

   CopyBuffer(maHandle,0,0,1,ma); //Recibe en el array búfer los datos del búfer especificado del indicador indicado en cantidad especificada

// Close price
   double close[];
   ArraySetAsSeries(close,true);
   CopyClose(_Symbol,0,0,1,close);

// Current position information
   bool openPosition = PositionSelect(_Symbol);
   long positionType = PositionGetInteger(POSITION_TYPE);
   double currentVolume = 0;
   if(openPosition == true)
      currentVolume = PositionGetDouble(POSITION_VOLUME);


/*
Antes de abrir una orden, debemos verificar y ver si ya hay una posición abierta. La función PositionSelect()
devuelve un valor verdadero si una posición está abierta en el símbolo actual. El resultado se asigna a la variable openPosition .
La función PositionGetInteger() con POSITION_TYPE 
El parámetro devuelve el tipo de la posición actual (compra o venta) y lo asigna a la variable positionType . Si una posición está
actualmente abierta, la función PositionGetDouble() con el parámetro POSITION_VOLUME asigna el volumen de 
la posición actual a la variable currentVolume.
*/


//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+


// Open buy market order
   if(close[0] > ma[0] && glBuyPlaced == false && (positionType != POSITION_TYPE_BUY || openPosition == false))
     {
      request.action = TRADE_ACTION_DEAL; // al toque, al momento,
      //Colocar una orden comercial de conclusión inmediata de un transacción según los parámetros especificados (colocar una orden de mercado)
      request.type = ORDER_TYPE_BUY; // orden tipo compra
      request.symbol = _Symbol;
      request.volume = TradeVolume + currentVolume;
      request.type_filling = ORDER_FILLING_FOK;// La orden solo puede ser ejecutada en el volumen indicado, si no se cancela
      request.price = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
      request.sl = 0;
      request.tp = 0;
      request.deviation = 50; /*Significa Slipage: Por ejemplo, si un trader coloca una orden de compra con un precio solicitado de 100 y
      establece una desviación máxima de 5 pips, la orden solo se ejecutará si el precio de compra está dentro de 5 pips del precio solicitado
      (es decir, entre 95 y 105).
      Si el precio de compra se desvía más de 5 pips, la orden no se ejecutará*/
      OrderSend(request,result); //gracias a la estructura especial mql de pedidos o request, si asi es, cambio mucho a lo que era mql4

      // Modify SL/TP
      if(result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE) //o sea si no hay error entnonces...
         /*Result.retcode : Código del resultado de operación*/
         //Asignamos el valor TRADE_ACTION_SLTP a la variable request.action para indicar que estamos modificando el stop loss y el take profit
        {
         request.action = TRADE_ACTION_SLTP;
         do
            Sleep(100); //suspendelo unos 100 milissegundos = 0.1 segundos
         while(PositionSelect(_Symbol) == false);
         /*en resumidas cuentas : mientrass no haya una orden abierta entonces el programa se
         sigue ejecutando en un ciclo suspendiendo por 0,1 segundos cada vez que lo hace*/
         //PositionSelect: Retorna true en caso de que la función se ejecute con éxito. Retorna false en caso de que la función no se ejecute con éxito.
         double positionOpenPrice = PositionGetDouble(POSITION_PRICE_OPEN);
         if(StopLoss > 0)//stop loss es una variable que en este caso vale 1000 por defecto
            request.sl = positionOpenPrice - (StopLoss * _Point);//_point
         if(TakeProfit > 0)
            request.tp = positionOpenPrice + (TakeProfit * _Point);
         if(request.sl > 0 && request.tp > 0)
            OrderSend(request,result);
         glBuyPlaced = true;
         glSellPlaced = false;
        }
     }
     
 /*Después de que se ha realizado el pedido de mercado de compra, verificamos si la operación fue exitosa. Si es así, seguimos adelante
y modifique la posición para agregar la pérdida de parada y tomar ganancias. Lo primero que debe hacer es verificar el valor del
resultado.retcode variable para ver si el pedido se colocó correctamente. Dependiendo del tipo de ejecución, un
El valor del código de retorno de Trade_RetCode_placed o Trade_Retcode_Done indica un pedido exitoso. Si el
La variable de código de retención coincide con cualquiera de estos valores, luego calculamos la pérdida de pérdida y tomamos los precios de las ganancias y
modificar el orden.
Asignamos el valor comercial_Action_SLTP a la variable de solicitud. Accione para indicar que estamos modificando
la parada de pérdida y tomar ganancias. A continuación, usamos un bucle Do-While para pausar la ejecución del programa utilizando el
Función sleep () antes de verificar la salida de la función posicionSelect (). Por la forma en que
La estructura comercial de Metatrader 5 funciona, puede tomar varios milisegundos hasta que se pusiera
aparece como una posición abierta actualmente. Si intentamos llamar a PositionSelect () inmediatamente,
A veces devuelve un valor de falso, lo que hace que sea imposible recuperar el precio de apertura del pedido. Después de hacer una pausa
Ejecución, verificamos la salida de la función posicionSelect () para ver si devuelve verdadero. Si no, el bucle
Continúa hasta que PositionSelect () devuelve verdadero.
Una vez que se ha seleccionado la posición actual, recuperamos el precio de apertura de la posición usando
PosicionGetDouble () con el parámetro posicion_price_open, asignando el resultado al
PositionOpenPrice Variable. Si las variables de entrada de tope y/o takenprofit son mayores que cero,
Calcule la pérdida de parada y/o tome el precio de la ganancia agregando o restando el valor relevante del
PositionOpenPrice Variable y asignando el resultado a request.sl o request.tp. Si request.sl o
request.tp contiene un valor mayor que cero, llamamos a la función OrderSend () para modificar nuestra posición con
la nueva parada de pérdida y/o tomar los precios de las ganancias.
Por último, necesitamos establecer las variables glbuyplaced y Glsellplated. Desde que se realizó nuestro pedido de compra
con éxito, estableceremos GLBUYPLECTADO en verdadero. Esto evitará que se abra un segundo pedido de compra si nuestra compra
La posición está cerrada por la pérdida de pérdida o toma ganancias. También establecemos GLSELLELCECTADO en falso, lo que permite una posición de venta para
Abra si el precio de cierre cruza el promedio móvil en la dirección opuesta.
Si todo esto te parece un poco abrumador, no te preocupes. El asesor experto de ejemplo anterior muestra el proceso
de colocar pedidos en MQL5, pero la implementación real de este código se ocultará en clases y funciones
que crearemos en los próximos capítulos. El nombre del archivo de este asesor experto es un simple experto
Advisor.mq5, y puede ver el código en la carpeta \ MQL5 \ Experts \ MQL5Book.*/
     

// Open sell market order
   else
      if(close[0] < ma[0] && glSellPlaced == false && positionType != POSITION_TYPE_SELL)
         //basicamente: si no esta colocado y el cierre actual es menor que la MA actualentonces...
        {
         request.action = TRADE_ACTION_DEAL;//abri ahora
         request.type = ORDER_TYPE_SELL;//tipo de orden venta
         request.symbol = _Symbol;//de simbolo actual
         request.volume = TradeVolume + currentVolume;//ese 0,1 que pusistes de variable por defecto mas el que esta
         request.type_filling = ORDER_FILLING_FOK;//si no se puede abrir un 0,1 entonces no habras
         request.price = SymbolInfoDouble(_Symbol,SYMBOL_BID);//precio de venta abri al bid
         request.sl = 0;
         request.tp = 0;//no esta colocado stop loss ni take profit por eso le ponemos cero
         request.deviation = 50;// igual a la de compra
         OrderSend(request,result);

         // Modify SL/TP
         if((result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE)
            && (StopLoss > 0 || TakeProfit > 0))//entonces aca si tenemos take profit mayor que cero entonces signifca que esta puesto  y por ende ...
            // igual que el de compra, ademas si queres verlo mejor asi creo tambien se puede dejar.
           {
            request.action = TRADE_ACTION_SLTP; //Modificar los valores Stop Loss y Take Profit de una posición abierta
            do
               Sleep(100); //suspender 100 miliseconds
            while(PositionSelect(_Symbol) == false);
            /* si tenemos posicion cerrada ejecuta este bucle, si tenemos abierta se suspende primero
            y luego rompe el bucle*/
            double positionOpenPrice = PositionGetDouble(POSITION_PRICE_OPEN);
            if(StopLoss > 0)
               request.sl = positionOpenPrice + (StopLoss * _Point);
            if(TakeProfit > 0)
               request.tp = positionOpenPrice - (TakeProfit * _Point);
            if(request.sl > 0 && request.tp > 0)
               OrderSend(request,result);
            glBuyPlaced = false;
            glSellPlaced = true;
           }
        }
  }
//+------------------------------------------------------------------+ FIN


/*
Si todo esto te parece un poco abrumador, no te preocupes. El asesor experto de ejemplo anterior muestra el proceso de realizar
pedidos en MQL5, pero la implementación real de este código estará oculta en las clases y funciones que crearemos en los
próximos capítulos. El nombre de archivo de este asesor experto es Simple Expert Advisor.mq5 y puede ver el
código en la carpeta \MQL5\Experts\Mql5Book .
*/