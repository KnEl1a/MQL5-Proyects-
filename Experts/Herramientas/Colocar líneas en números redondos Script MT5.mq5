//autor xavier andreu, un trader que enseña programar "herramientas" basicas de trading para el analisis visual de la accion del precio.
input double Minimo = 1.2;
input double Maximo= 1.4;
input double Valor = 0.01;

input color Color_Linea = clrRed;
input int Ancho_Linea = 1;

void OnStart()
{
   
   for(double a = Minimo; a<=Maximo; a=a+Valor)
   {
      DibujarLinea(rand(),a);
   }
   
}

void DibujarLinea(string Linea, double Posicion)
{
   ObjectCreate(0,Linea, OBJ_HLINE,0,0,Posicion);
   //ObjectSetInteger(0,Linea,OBJPROP_STYLE,STYLE_DOT);]
   ObjectSetInteger(0,Linea,OBJPROP_COLOR, Color_Linea);
   ObjectSetInteger(0,Linea, OBJPROP_WIDTH, Ancho_Linea);
}