//+------------------------------------------------------------------+
//|                                      Fractals highs and lows.mq5 |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+

double n ; // maximo del fractal anterior
double m ; // minimo del fractal anterior

void OnTick()
  {
//creating arrays
   double fracUpArray[];
   double fracDownArray[];
//Sorting data
   ArraySetAsSeries(fracUpArray,true);
   ArraySetAsSeries(fracDownArray,true);
//define frac
   int fracDef = iFractals(_Symbol,_Period);
//define data and store result
   CopyBuffer(fracDef,UPPER_LINE,2,10,fracUpArray);
   CopyBuffer(fracDef,LOWER_LINE,2,10,fracDownArray);
//define values
   double fracUpValue = NormalizeDouble(fracUpArray[1],5);
   double fracDownValue = NormalizeDouble(fracDownArray[1],5);
  
   
   
//returning zero in case of empty values
   if(fracUpValue == EMPTY_VALUE)
      
      fracUpValue = 0;
   if(fracDownValue ==EMPTY_VALUE)
      
      fracDownValue = 0;
//conditions of the strategy and comment on the chart with highs and lows
//in case of high
  
      Comment("Fractals High around: ",fracUpValue, "\n Fractals Down around: ", fracDownValue, "\n Fractal de arriba anterior es ", n, "\n el fractal de abajo anterior es ", m );
      }
      
      
     