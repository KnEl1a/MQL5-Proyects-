//+------------------------------------------------------------------+
//|                                                       Spread.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.20"
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
void OnStart()
{
   string symbol = Symbol(); // Obtiene el nombre del símbolo actual
   double contractSize = SymbolInfoDouble(symbol, SYMBOL_TRADE_CONTRACT_SIZE); // Tamaño mínimo del contrato
   double pointSize = (SymbolInfoDouble(symbol, SYMBOL_POINT))*10; // Tamaño del punto (pip) para el símbolo
   double pipValue = contractSize * pointSize;


   Print("el valor de pipValue es ", pipValue);
   Print("el valor del tamaño de contrato 1 lote estandar es ", + contractSize);
   Print("el valor del tamaño del pip es ", + pointSize);
}

/*
int OnInit()
  {
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const int begin,
                const double &price[])
  {
    MqlRates valores[];
   CopyRates(Symbol(),PERIOD_CURRENT,0,1,valores);
   
   ObjectCreate(0,"spreadValue",OBJ_TEXT,0,valores[0].time,SymbolInfoDouble(_Symbol,SYMBOL_BID));
   ObjectSetString(0,"spread",OBJPROP_TEXT,"   "+SymbolInfoInteger(Symbol(),SYMBOL_SPREAD));
   ObjectSetInteger(0,"spread",OBJPROP_COLOR,clrAquamarine);
   ObjectGetInteger(0,"spread",OBJPROP_FONTSIZE,14);
//--- return value of prev_calculated for next call
   return(0);
  }
//+------------------------------------------------------------------+
*/


/*
Para calcular el valor de 1 pip (pip value) para cualquier instrumento en MetaTrader 5, necesitas conocer el tamaño del contrato (contract size) y el tamaño del pip (pip size) para ese instrumento específico. El valor de 1 pip representa el cambio monetario en la ganancia o pérdida de una posición por cada movimiento de 1 pip en el precio.

En MetaTrader 5, puedes acceder a esta información fácilmente. Aquí te muestro cómo hacerlo:

Abre la plataforma MetaTrader 5 en tu computadora.
Haz clic con el botón derecho del ratón sobre el instrumento que deseas consultar en la ventana "Observación del mercado".
Selecciona la opción "Especificación" (o "Specification" en inglés).
En la ventana emergente "Especificación del símbolo", encontrarás información detallada sobre el instrumento, incluyendo el tamaño del contrato y el tamaño del pip.
El valor de 1 pip se calcula utilizando la siguiente fórmula:

Valor de 1 pip = Tamaño del Contrato / Tamaño del Pip

Por ejemplo, si estás operando el par de divisas EUR/USD y el tamaño del contrato es de 100,000 unidades (1 lote estándar) y el tamaño del pip es 0.0001 (para cuentas denominadas en USD), entonces el valor de 1 pip sería:

Valor de 1 pip = 100,000 / 0.0001 = 10 USD

Esto significa que por cada movimiento de 1 pip en el precio del EUR/USD, la ganancia o pérdida en tu posición sería de 10 USD.

Recuerda que el valor de 1 pip puede variar dependiendo del tamaño del contrato y del tamaño del pip del instrumento que estés operando, así como de la denominación de tu cuenta de trading. Es importante verificar siempre la especificación del símbolo para obtener la información más actualizada y precisa.
*/