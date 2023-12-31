//+------------------------------------------------------------------+
//|                       Funciones de Libro expert advisor mql5.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| My function                                                      |
//+------------------------------------------------------------------+
// int MyCalculator(int value,int value2) export
//   {
//    return(value+value2);
//   }
//+------------------------------------------------------------------+

double BuyStopLoss(string pSymbol, int pStopPoints, double pOpenPrice = 0)
{
double stopLoss = pOpenPrice - (pStopPoints * _Point);
stopLoss = NormalizeDouble(stopLoss,_Digits); //ej : NormalizeDouble() lo redondearía a 1.23457 para ajustarse a los 5 dígitos decimales del símbolo.

//This code is used to normalize a double value, "stopLoss", to the number of decimal places specified by the "_Digits" variable. This is done by rounding the double value to the specified number of decimal places. The result is then stored in the "stopLoss" variable.
// Este código se usa para normalizar un valor doble, "stoploss", al número de lugares decimales especificados por la variable "_dígitos". Esto se hace redondeando el valor doble al número especificado de lugares decimales. El resultado se almacena luego en la variable "Stoploss".
return(stopLoss);
}

/*
--> funcion de stop loss : 
This function will calculate the stop loss by multiplying pStopPoints by the symbol's point value, represented
by the predefined variable _Point (usually 0.00001 or 0.001), and subtracting that value from pOpenPrice.
The result is assigned to the variable stopLoss. The value of stopLoss is normalized to the number of digits
in the price using the NormalizeDouble() function, and the return operator returns the normalized value of
stopLoss to the program.

Esta función calculará el stop loss multiplicando pStopPoints por el valor del punto del símbolo, representado por la variable predefinida
_Point (generalmente 0.00001 o 0.001), y restando ese valor de pOpenPrice.
El resultado se asigna a la variable stopLoss. El valor de stopLoss se normaliza al número de dígitos en el precio utilizando la función
NormalizeDouble() , y el operador de retorno devuelve el valor normalizado de stopLoss al programa.

Here's an example of how we would call this function in our program:
// Input variables            
input int StopLoss = 500;
// OnTick() event handler
double orderPrice = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
double useStopLoss = BuyStopLoss(_Symbol,StopLoss,orderPrice);

*/
//----------------------------------------------------------------+