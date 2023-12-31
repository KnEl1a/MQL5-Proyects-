//+------------------------------------------------------------------+
//|                       TSi creado a base de ortos indicadores.mq5 |
//|                          elias creacino de indicadores con otros |
//|                                creacino de indicadores con otros |
//+------------------------------------------------------------------+
#property copyright "elias creacino de indicadores con otros"
#property link      "creacino de indicadores con otros"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 4 //el histograma en color usa dos buffers - uno se muestra en el gráfico y se usa para los valores del indicador; y el otro se usa para definir los colores de representación del primer buffer. No cambies el valor de #property indicator_buffers. Cambia el valor de #property indicator_plots a 1 - se debe mostrar un sólo buffer en el gráfico.
#property indicator_plots   1
//--- plot TSICD
#property indicator_label1  "TSICD"
#property indicator_type1   DRAW_COLOR_HISTOGRAM
#property indicator_color1  clrLimeGreen,clrRed
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- plot TSI
#property indicator_label2  "TSI"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrRed
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1
//--- plot TSIsignal
#property indicator_label3  "TSIsignal"
#property indicator_type3   DRAW_LINE
#property indicator_color3  clrBlue
#property indicator_style3  STYLE_SOLID
#property indicator_width3  1
//--- input parameters
input int r=25;
input int s=13;
input int sp=5;                 // período de suavizado
input ENUM_MA_METHOD sm=MODE_EMA; // tipo de suavizado
//--- indicator buffers
double         TSICDBuffer[];
double         TSICDColors[];
double         TSIBuffer[];
double         TSIsignalBuffer[];

//handlers
int handle;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,TSICDBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,TSICDColors,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(2,TsiBuffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(3,TsiSignalBuffer,INDICATOR_CALCULATIONS);
   
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
//---
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
