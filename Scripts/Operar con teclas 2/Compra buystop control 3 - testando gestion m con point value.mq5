//+------------------------------------------------------------------+
//|                                             Compra con tecla.mq5 |
//|                                                              eli |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//prototipo en la qu se pone una orden pendiente
#property copyright "eli"
#property link      "https://www.mql5.com"
#property version   "1.00"
//#include <MoneyManagement1 - solo Point Value.mqh>
#include <trade\trade.mqh>
CTrade trade;

//para el money management tengo que hacer un stop points, entonces lo que debo hacer es hacer nua diferencia entre la orden establecida y tambien el minimo o maximo de la barra

//+------------------------------------------------------------------+
//| Script program start function                                    | ademas podemos ver como programar el tiempo de expiracion de la orden a fin de ver si esti es viable o no 
//+------------------------------------------------------------------+ debemos programar la expiracion a fin de zafar de los patrones que no funcan.


// Función para calcular el tamaño de la posición
double CalculatePositionSize(string symbol, double stopPrice, double orderPrice, double riskPercentage)
{
    // Calcular la distancia en puntos desde la entrada hasta la parada
    double distanceInPoints = StopPriceToPoints(symbol, stopPrice, orderPrice);

    // Obtener el valor de un punto para el símbolo dado
    double pointValue = SymbolInfoDouble(symbol, SYMBOL_POINT);

    // Calcular el tamaño de la posición basado en el riesgo por operación
    double balance = AccountInfoDouble(ACCOUNT_BALANCE);
    double riskAmount = balance * riskPercentage / 100.0;
    double positionSize = riskAmount / (distanceInPoints * pointValue);

    return positionSize;
}

// Función para calcular la diferencia en puntos desde la entrada hasta la parada
double StopPriceToPoints(string symbol, double stopPrice, double orderPrice)
{
    double stopDiff = MathAbs(stopPrice - orderPrice);
    double getPoint = SymbolInfoDouble(symbol, SYMBOL_POINT);
    double priceToPoint = stopDiff / getPoint;
    return priceToPoint;
}


void OnStart()
{
   double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   double spread = ask - bid;

   MqlRates rates[];
   ArraySetAsSeries(rates, true);
   CopyRates(_Symbol, _Period, 0, 5, rates);

   double dif = StopPriceToPoints(_Symbol, rates[1].low - spread, rates[1].high + spread);
   double tradeSize = CalculatePositionSize(_Symbol, rates[1].low - spread, rates[1].high + spread, 0.8);
  
   // Convertir el tamaño de la posición a un valor entero
   int positionSizeInteger = (int)tradeSize;

   trade.BuyStop(positionSizeInteger, rates[1].high + spread, _Symbol, rates[1].low - spread);

   Print("1) el spread es de ", spread);
   Print("2) el spread de la barra previa es  ", rates[1].spread);
   Print("3) el spread actual es ", rates[0].spread);
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

//funciona bien cuando el precio esta por encima de lo que es el maximo es un problema porque no habre nad