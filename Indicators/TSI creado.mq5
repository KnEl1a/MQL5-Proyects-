//+------------------------------------------------------------------+
//|                                                   TSI creado.mq5 |
//|                                                              eli |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include <MovingAverages.mqh>
#property copyright "eli"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 7 //número de buffers del indicador, agregamos 7 en total
#property indicator_plots   1 //número de representaciones
//--- plot TSI
#property indicator_label1  "TSI" //nombre de la representación nº 1
#property indicator_type1   DRAW_LINE //stilo de la primera representación -línea, indicator_type1=DRAW_LINE;
#property indicator_color1  clrRed //color rojo de representación 1
#property indicator_style1  STYLE_SOLID //estilo de linea
#property indicator_width1  1 //grosor de línea para la representación nº 1
//--- input parameters
input int      r=25;
input int      s=13;
//--- indicator buffers
double         TSIBuffer[];
double         MTMBuffer[];
double         AbsMTMBuffer[];
double         EMA_MTMBUffer[];
double         EMA2_MTMBuffer[];
double         EMA_Abs_MTMBuffer[];
double         EMA2_Abs_MTMBuffer[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,TSIBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,MTMBuffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(2,AbsMTMBuffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(3,EMA_MTMBUffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(4,EMA2_MTMBuffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(5,EMA_Abs_MTMBuffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(6,EMA2_Abs_MTMBuffer,INDICATOR_CALCULATIONS);
//---ahora establecemos la barra con lo que vamos a comenzar a ver
   
   //--- barra de inicio
   PlotIndexSetInteger(0,PLOT_DRAW_BEGIN, r+s-1); // r+s-1, puesto que comenzamos a identificar las matrices de entrada con el índice r, y el período del segundo promedio exponencial es igual a s.
   //---Titulo del indicador
   string shortname;
   StringConcatenate(shortname, "TSI(",r,",",s,")");
   PlotIndexSetString(0,PLOT_LABEL,shortname);
   IndicatorSetInteger(INDICATOR_DIGITS, 2);
   //--- arrancamos con los calculos en OnCalculate ahora

   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate (const int rates_total,      // size of the price[] array
                 const int prev_calculated,  // number of available bars at the previous call
                 const int begin,            // from what index in price[] authentic data start
                 const double& price[])      // array, on which the indicator will be calculated
  {
  //--- es la primera llamada
  if(prev_calculated == 0)
  {
  MTMBuffer[0] = 0.0;
  AbsMTMBuffer[0] =0.0;
  }
  
//--- calcular los valores para mtm y |mtm|
int start;
if(prev_calculated == 0) start = 1; //calculame lo de hoy y no lo que ya esta calculado
else start = prev_calculated - 1;
   for (int i=1; i<rates_total; i++)
   {
      MTMBuffer[i] = price[i] - price[i-1]; //cierre actual menos el cierre anterior
      AbsMTMBuffer[i] = fabs(MTMBuffer[i]);
   }
   
   //--- primer suavizado
   ExponentialMAOnBuffer(rates_total, prev_calculated, 1,r,MTMBuffer,EMA_MTMBUffer);
   ExponentialMAOnBuffer(rates_total, prev_calculated, 1,r,AbsMTMBuffer,EMA_Abs_MTMBuffer);
   //---
   //segundo suavizado
   ExponentialMAOnBuffer(rates_total, prev_calculated, r, s, EMA_MTMBUffer, EMA2_MTMBuffer);
   ExponentialMAOnBuffer(rates_total, prev_calculated, r, s, EMA_Abs_MTMBuffer, EMA2_Abs_MTMBuffer);
   //---
   //valores del indicador
   if (prev_calculated ==0) start =r+s-1; // esto agregue para optimizar // o sea basicamente si el calculo previo es 0 o esa acutal, too
   for(int i=start; i<rates_total; i++)   // quite esto r+s-1 y lo remplace con esto start
   {
      TSIBuffer[i] = 100 * EMA2_MTMBuffer[i] / EMA2_Abs_MTMBuffer[i];
   }
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
