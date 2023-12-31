//+------------------------------------------------------------------+
//|                       lineas horizontales en numerosredondos.mq5 |
//|                                                   xavier andreau |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "xavier andreau"
#property link      "https://www.mql5.com"
#property version   "1.00"
//autor xavier andreu, un trader que enseña programar "herramientas" basicas de trading para el analisis visual de la accion del precio.
input double Minimo = 7000.0;
input double Maximo= 8000.0;
input double Valor = 100.0;

input color Color_Linea = clrRed;
input int Ancho_Linea = 2;

void OnStart()
{
   if (Minimo > Maximo) Alert("valores error");
   for(double a = Minimo; a<=Maximo; a=a+Valor)
   {
      DibujarLinea(rand(),a);
   }
   
   ExpertRemove();
}

void DibujarLinea(string Linea, double Posicion)
{
   ObjectCreate(0,Linea, OBJ_HLINE,0,0,Posicion);
   ObjectSetInteger(0,Linea,OBJPROP_COLOR, Color_Linea);
   ObjectSetInteger(0,Linea, OBJPROP_WIDTH, Ancho_Linea);
   //ObjectSetInteger(0,Linea,OBJPROP_STYLE,STYLE_DOT);]
}