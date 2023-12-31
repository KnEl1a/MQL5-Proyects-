//+------------------------------------------------------------------+
//|                                                          SMA.mq5 |
//|                        Copyright 2009, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
//---- el indicador se trazará en la ventana principal
#property indicator_chart_window
//---- se usará un buffer para los cálculo y el trazado del indicador
#property indicator_buffers 1
//---- solo se usa un trazado gráfico 
#property indicator_plots   1
//---- el indicador debe trazarse como una línea
#property indicator_type1   DRAW_LINE
//---- el color de la línea del indicador es el rojo 
#property indicator_color1  Red 

//---- parámetros de entrada del indicador
input int MAPeriod = 13; //período de promediación
input int MAShift = 0; //cambio horizontal (en barras)

//---- la declaración de la matriz dinámica
//que se usará posteriormente como buffer del indicador
double ExtLineBuffer[]; 
//+------------------------------------------------------------------+
//| función de inicialización del indicador personalizado            |
//+------------------------------------------------------------------+ 
void OnInit()
  {
//----+
//----asigna la matriz dinámica ExtLineBuffer con el buffer del indicador 0
   SetIndexBuffer(0,ExtLineBuffer,INDICATOR_DATA);
//---- establece el cambio de trazado a lo largo del eje horizontal por MAShift barras
   PlotIndexSetInteger(0,PLOT_SHIFT,MAShift);
//---- Establece el inicio del trazado en la barra con número MAPeriod
   PlotIndexSetInteger(0,PLOT_DRAW_BEGIN,MAPeriod);  
//----+
  }
//+------------------------------------------------------------------+
//| Función de iteración del indicador personalizado                 |
//+------------------------------------------------------------------+
int OnCalculate(
                const int rates_total,    // número de barras disponibles en el historial en el tick actual
                const int prev_calculated,// número de barras calculadas en el tick anterior
                const int begin,          // índice de la primera barra
                const double &price[]     // matriz de precio para al cálculo
                )
  {
//----+   
   //---- comprueba la presencia de barras suficientes para el cálculo
   if (rates_total < MAPeriod - 1 + begin)
    return(0);   

   //---- declaración de variables locales 
   int first, bar, iii;
   double Sum, SMA;   

   //---- cálculo del índice de inicio first del lazo principal
   if(prev_calculated==0) // comprueba el primer inicio del indicador
      first=MAPeriod-1+begin; // índice de inicio para todas las barras
   else first=prev_calculated-1; // índice de inicio para las nuevas barras

   //---- lazo principal del cálculo
   for(bar = first; bar < rates_total; bar++)
    {    
      Sum=0.0;
      //---- lazo de suma para la promediación de la barra actual
      for(iii=0;iii<MAPeriod;iii++)
         Sum+=price[bar-iii]; // It's equal to: Sum = Sum + price[bar - iii];         

      //---- calcula el valor promediado
      SMA=Sum/MAPeriod;

      //---- establece el elemento del buffer del indicador con el valor de SMA que hemos calculado
      ExtLineBuffer[bar]=SMA;
    }
//----+     
   return(rates_total);
  }
//+------------------------------------------------------------------+