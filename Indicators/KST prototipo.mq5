
/*error en mt5 de Array out of range "//+------------------------------------------------------------------+
//|                                                KST prototipo.mq5 |
//|                                         young, copiado por elias |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include <MovingAverages.mqh>
#property copyright "young, copiado por elias"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 6 // 2 + 4
#property indicator_plots   2 // solo dos representaciones, línea KST y señal
//--- plot KST
#property indicator_label1  "KST"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrYellowGreen
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- plot Signal
#property indicator_label2  "Signal"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrOrangeRed
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1
//--- indicator buffers
//--- indicator buffers
double         KSTBuffer[];
double         SignalBuffer[];

double         ROCMA1_Buffer[];
double         ROCMA2_Buffer[];
double         ROCMA3_Buffer[];
double         ROCMA4_Buffer[];

double         ROC1_Buffer[];
double         ROC2_Buffer[];
double         ROC3_Buffer[];
double         ROC4_Buffer[];

//--- input parameters
input int                P_ROC1=10;
input int                P_ROC2=15;
input int                P_ROC3=20;
input int                P_ROC4=30;
input int                P_SMA1=10;
input int                P_SMA2=10;
input int                P_SMA3=10;
input int                P_SMA4=15;
input int                P_SMAsignal=9;

////--- handlers

int ROC1_Handler;
int ROC2_Handler;
int ROC3_Handler;
int ROC4_Handler;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,KSTBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,SignalBuffer,INDICATOR_DATA);
   
   SetIndexBuffer(2,ROC1_Buffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(3,ROC2_Buffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(4,ROC3_Buffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(5,ROC4_Buffer,INDICATOR_CALCULATIONS);
   
// --- establece la primera barra de qué índice se dibujará // nota: lo del macd
   PlotIndexSetInteger(1,PLOT_DRAW_BEGIN,P_SMAsignal-1);

// --- Nombre para la etiqueta de subwindow indicador
   string short_name=StringFormat("KST(%d,%d,%d,%d,%d,%d,%d,%d,%d)",P_ROC1,P_ROC2,P_ROC3,P_ROC4,P_SMA1,P_SMA2,P_SMA3,P_SMA4,P_SMAsignal); //KST (know sure thing)de martin J spring, el creador de su calculo y nombre
   IndicatorSetString(INDICATOR_SHORTNAME,short_name);
   IndicatorSetInteger(INDICATOR_DIGITS, 2);
   
//--- get ROC handles
 ROC1_Handler= iCustom(_Symbol, _Period, "Examples\\ROC.ex5",P_ROC1);
 ROC2_Handler= iCustom(_Symbol, _Period, "Examples\\ROC.ex5",P_ROC2);
 ROC3_Handler= iCustom(_Symbol, _Period, "Examples\\ROC.ex5",P_ROC3);
 ROC4_Handler= iCustom(_Symbol, _Period, "Examples\\ROC.ex5",P_ROC4);

//---
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
    int start = prev_calculated;

    // Copy the ROC values from the custom indicators
    CopyBuffer(ROC1_Handler, 0, 0, rates_total - 1, ROC1_Buffer);
    CopyBuffer(ROC2_Handler, 0, 0, rates_total - 1, ROC2_Buffer);
    CopyBuffer(ROC3_Handler, 0, 0, rates_total - 1, ROC3_Buffer);
    CopyBuffer(ROC4_Handler, 0, 0, rates_total - 1, ROC4_Buffer);

    // Calculate the simple moving averages //fallara acá?
 SimpleMAOnBuffer(rates_total, prev_calculated, 1,P_SMA1,ROC1_Buffer,ROCMA1_Buffer);
 SimpleMAOnBuffer(rates_total, prev_calculated, 1,P_SMA2,ROC2_Buffer,ROCMA2_Buffer);
 SimpleMAOnBuffer(rates_total, prev_calculated, 1,P_SMA3,ROC3_Buffer,ROCMA3_Buffer);
 SimpleMAOnBuffer(rates_total, prev_calculated, 1,P_SMA4,ROC4_Buffer,ROCMA4_Buffer);

    // Calculate KST values
    for (int i = start; i < rates_total; i++)
    {
        KSTBuffer[i] = (ROCMA1_Buffer[i] * 1) + (ROCMA2_Buffer[i] * 2) + (ROCMA3_Buffer[i] * 3) + (ROCMA4_Buffer[i] * 4);
    }

    return(rates_total);
}
" ahora no tira error, muestra una ventana vacia, como que no calcula y muestra, por lo que pido en este promt que mejores el codigo segun tu logica de programacion para que calcule y muestre segun el codigo proporcionado.*/

//+------------------------------------------------------------------+
//|                                                KST prototipo.mq5 |
//|                                         young, copiado por elias |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include <MovingAverages.mqh>
#property copyright "young, copiado por elias"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 10 
#property indicator_plots   2 
//--- plot KST
#property indicator_label1  "KST"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrYellowGreen
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- plot Signal
#property indicator_label2  "Signal"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrOrangeRed
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1
//--- indicator buffers
//--- indicator buffers
double         KSTBuffer[];
double         SignalBuffer[];

double         ROCMA1_Buffer[];
double         ROCMA2_Buffer[];
double         ROCMA3_Buffer[];
double         ROCMA4_Buffer[];

double         ROC1_Buffer[];
double         ROC2_Buffer[];
double         ROC3_Buffer[];
double         ROC4_Buffer[];

//--- input parameters
input int                P_ROC1=10;
input int                P_ROC2=15;
input int                P_ROC3=20;
input int                P_ROC4=30;
input int                P_SMA1=10;
input int                P_SMA2=10;
input int                P_SMA3=10;
input int                P_SMA4=15;
input int                P_SMAsignal=9;

////--- handlers

int ROC1_Handler;
int ROC2_Handler;
int ROC3_Handler;
int ROC4_Handler;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,KSTBuffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(1,SignalBuffer,INDICATOR_CALCULATIONS);
   
   SetIndexBuffer(2,ROC1_Buffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(3,ROC2_Buffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(4,ROC3_Buffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(5,ROC4_Buffer,INDICATOR_CALCULATIONS);
   
   /*faltaron : 
   double         ROCMA1_Buffer[];
   double         ROCMA2_Buffer[];
   double         ROCMA3_Buffer[];
   double         ROCMA4_Buffer[];
   */
   
   SetIndexBuffer(6,ROCMA1_Buffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(7,ROCMA2_Buffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(8,ROCMA3_Buffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(9,ROCMA4_Buffer,INDICATOR_CALCULATIONS);
   
// --- establece la primera barra de qué índice se dibujará // nota: lo del macd
PlotIndexSetInteger(0,PLOT_DRAW_BEGIN, P_ROC1+P_ROC2+P_ROC3+P_ROC4+P_SMA1+P_SMA2+P_SMA3+P_SMA4+P_SMAsignal-1);
   PlotIndexSetInteger(1,PLOT_DRAW_BEGIN,+P_ROC1+P_ROC2+P_ROC3+P_ROC4+P_SMA1+P_SMA2+P_SMA3+P_SMA4+ P_SMAsignal-1);

// --- Nombre para la etiqueta de subwindow indicador
   string short_name=StringFormat("KST(%d,%d,%d,%d,%d,%d,%d,%d,%d)",P_ROC1,P_ROC2,P_ROC3,P_ROC4,P_SMA1,P_SMA2,P_SMA3,P_SMA4,P_SMAsignal); //KST (know sure thing)de martin J spring, el creador de su calculo y nombre
   IndicatorSetString(INDICATOR_SHORTNAME,short_name);
  
   
//--- get ROC handles
/*
 ROC1_Handler= iCustom(_Symbol, PERIOD_D1, "Examples\\ROC.ex5",P_ROC1);
 ROC2_Handler= iCustom(_Symbol, PERIOD_D1, "Examples\\ROC.ex5",P_ROC2);
 ROC3_Handler= iCustom(_Symbol, PERIOD_D1, "Examples\\ROC.ex5",P_ROC3);
 ROC4_Handler= iCustom(_Symbol, PERIOD_D1, "Examples\\ROC.ex5",P_ROC4);
*/
 ROC1_Handler= iMA(NULL,PERIOD_D1,P_ROC1,0,MODE_EMA,PRICE_CLOSE);
 ROC2_Handler= iMA(NULL,PERIOD_D1,P_ROC2,0,MODE_EMA,PRICE_CLOSE);
 ROC3_Handler= iMA(NULL,PERIOD_D1,P_ROC3,0,MODE_EMA,PRICE_CLOSE);
 ROC4_Handler= iMA(NULL,PERIOD_D1,P_ROC4,0,MODE_EMA,PRICE_CLOSE);
//---
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
  
  if(rates_total<P_SMAsignal)
      return(0);
      
    //--- not all data may be calculated
   int calculated=BarsCalculated(ROC1_Handler);
   if(calculated<rates_total)
     {
      Print("Not all data of ROC1_Handler is calculated (",calculated," bars). Error ",GetLastError());
      return(0);
     }
   calculated=BarsCalculated(ROC2_Handler);
   if(calculated<rates_total)
     {
      Print("Not all data of ROC2_Handler is calculated (",calculated," bars). Error ",GetLastError());
      return(0);
     }
     calculated=BarsCalculated(ROC3_Handler);
   if(calculated<rates_total)
     {
      Print("Not all data of ROC3_Handler is calculated (",calculated," bars). Error ",GetLastError());
      return(0);
     }
   calculated=BarsCalculated(ROC4_Handler);
   if(calculated<rates_total)
     {
      Print("Not all data of ROC4_Handler is calculated (",calculated," bars). Error ",GetLastError());
      return(0);
     }
//--- we can copy not all data
   int to_copy;
   if(prev_calculated>rates_total || prev_calculated<0)
      to_copy=rates_total;
   else
     {
      to_copy=rates_total-prev_calculated;
      if(prev_calculated>0)
         to_copy++;
     }
//--- get buffer
      
     if(IsStopped()) // checking for stop flag // Comprobando la bandera de parada
      return(0);
   if(CopyBuffer(ROC1_Handler,0,0,to_copy,ROC1_Buffer)<=0)
     {
      Print("Getting ROC1_Buffer is failed! Error ",GetLastError());
      return(0);
     }
     
     //---
     if(IsStopped()) // checking for stop flag // Comprobando la bandera de parada
      return(0);
   if(CopyBuffer(ROC2_Handler,0,0,to_copy,ROC2_Buffer)<=0)
     {
      Print("Getting ROC2_Buffer is failed! Error ",GetLastError());
      return(0);
     }
     //---
if(IsStopped()) // checking for stop flag // Comprobando la bandera de parada
      return(0);
   if(CopyBuffer(ROC3_Handler,0,0,to_copy,ROC3_Buffer)<=0)
     {
      Print("Getting ROC3_Buffer is failed! Error ",GetLastError());
      return(0);
     }     
//---
if(IsStopped()) // checking for stop flag // Comprobando la bandera de parada
      return(0);
   if(CopyBuffer(ROC4_Handler,0,0,to_copy,ROC4_Buffer)<=0)
     {
      Print("Getting ROC4_Buffer is failed! Error ",GetLastError());
      return(0);
     }
   //---
   
//---
   int start;
   if(prev_calculated==0)
      start=0;
   else
      start=prev_calculated-1;
//--- calculate 
    // Calculate the simple moving averages
    SimpleMAOnBuffer(rates_total, prev_calculated, 0,P_SMA1,ROC1_Buffer,ROCMA1_Buffer);
    SimpleMAOnBuffer(rates_total, prev_calculated, 0,P_SMA2,ROC2_Buffer,ROCMA2_Buffer);
    SimpleMAOnBuffer(rates_total, prev_calculated, 0,P_SMA3,ROC3_Buffer,ROCMA3_Buffer);
    SimpleMAOnBuffer(rates_total, prev_calculated, 0,P_SMA4,ROC4_Buffer,ROCMA4_Buffer);

    // Calculate KST values
    for(int i=start; i<rates_total && !IsStopped(); i++)//for (int i = start; i < rates_total; i++)
    {
        KSTBuffer[i] = (ROCMA1_Buffer[i] * 1) + (ROCMA2_Buffer[i] * 2) + (ROCMA3_Buffer[i] * 3) + (ROCMA4_Buffer[i] * 4);
    }
   ExponentialMAOnBuffer(rates_total, prev_calculated, 0,P_SMAsignal,KSTBuffer,SignalBuffer);
    return(rates_total);
}

//algo llega a calcular en 1h pero no calcula en d1 ni ningun otro periodo mas largo, a que se debera?

//a que se debera el array out of range ?
//nota: el grafico que muestra se asemeja al de un ROC pero de 10 periodos, creo que no calcula el suavizado porque dice array fuera de rango in moving averages.mqh

