//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
int Numerovelas=1000; //originalmente estaba en 100.

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnStart()
  {
   int velaMasBaja=1;
   int velaMasAltal=1;

   MqlRates InfoPrecio[];
   ArraySetAsSeries(InfoPrecio, true);
   CopyRates(Symbol(), PERIOD_CURRENT, 0, Numerovelas+1,InfoPrecio);

   for(int i=1; i<=Numerovelas; i++)
     {
      if(InfoPrecio[i].low < InfoPrecio[(velaMasBaja)].low)
         velaMasBaja=i;

      if(InfoPrecio[i].high > InfoPrecio[(velaMasAltal)].high)
         velaMasAltal=i;
     }
   ObjectCreate(Symbol(), "1", OBJ_HLINE, 0,0,InfoPrecio[velaMasBaja].low);
   ObjectSetInteger(0,"1", OBJPROP_COLOR,clrCoral);
   ObjectSetInteger(0,"1", OBJPROP_WIDTH,2);

   ObjectCreate(Symbol(), "2", OBJ_HLINE, 0,0,InfoPrecio[velaMasAltal].high);
   ObjectSetInteger(0,"2", OBJPROP_COLOR,clrCoral);
   ObjectSetInteger(0,"2", OBJPROP_WIDTH,2);
  }
//+------------------------------------------------------------------+


/*
Claro, te voy a explicar el código que está escrito en el lenguaje MQL5, que es un lenguaje de programación para crear estrategias de trading automatizadas, 
indicadores técnicos personalizados y otras herramientas para el análisis de los mercados financieros¹. El código hace lo siguiente:

- Define una variable global llamada `Numerovelas`, que almacena el número de velas que se van a analizar. En este caso, el valor es 100.
- Define una función llamada `OnStart`, que se ejecuta cuando se inicia el programa. Esta función tiene las siguientes acciones:
    - Declara dos variables locales llamadas `velaMasBaja` y `velaMasAlta`, que almacenan los índices de las velas más baja y más alta, respectivamente. Inicialmente, ambas variables 
    tienen el valor 1.
    - Declara un array de estructuras llamado `InfoPrecio`, que almacena la información de las velas (apertura, cierre, máximo, mínimo y volumen). Luego, usa la función `ArraySetAsSeries` 
    para ordenar el array de forma descendente, es decir, desde la vela más reciente hasta la más antigua. Después, usa la función `CopyRates` para copiar los datos de las velas del símbolo y período actual al array `InfoPrecio`.
    - Usa un bucle `for` para recorrer el array `InfoPrecio` desde la posición 1 hasta la posición `Numerovelas`. Dentro del bucle, compara el mínimo y el máximo de cada vela con los 
    valores almacenados en las variables `velaMasBaja` y `velaMasAlta`. Si encuentra una vela con un mínimo menor que el valor almacenado en `velaMasBaja`, actualiza el valor de esta 
    variable con el índice de la vela. Si encuentra una vela con un máximo mayor que el valor almacenado en `velaMasAlta`, actualiza el valor de esta variable con el índice de la vela.
    - Usa la función `ObjectCreate` para crear dos objetos gráficos de tipo línea horizontal (`OBJ_HLINE`) en el gráfico del símbolo actual. El primer objeto se llama "1" y tiene como
     precio el mínimo de la vela más baja. El segundo objeto se llama "2" y tiene como precio el máximo de la vela más alta. Estos objetos sirven para marcar los niveles de soporte y 
     resistencia del mercado.
    - Usa la función `ObjectSetInteger` para establecer las propiedades de color y grosor de los objetos gráficos creados. En este caso, ambos objetos tienen el color amarillo (`clrYellow`) y el grosor 2.

Espero que te haya quedado claro el funcionamiento del código. Si tienes alguna duda, puedes consultar la referencia del lenguaje MQL5² o los artículos sobre programación en MQL5³. También 
puedes ver un ejemplo de cómo escribir un Expert Advisor y un indicador personalizado en MQL5⁴.

Origen: Conversación con Bing, 30/8/2023
(1) Language Basics - MQL5 Reference - Reference on algorithmic/automated .... https://www.mql5.com/en/docs/basis.
(2) MQL5 Reference - How to use algorithmic/automated trading language for .... https://www.mql5.com/en/docs.
(3) MQL5 programming language - MetaQuotes. https://www.metaquotes.net/en/metatrader5/algorithmic-trading/mql5.
(4) Introduction to MQL5: How to write simple Expert Advisor and Custom .... https://www.mql5.com/en/articles/35.
*/