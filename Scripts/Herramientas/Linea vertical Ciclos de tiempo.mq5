//este script te muestra una linea vertical cada x cantdiad de velas pasadas
//lo que podemos hacer es agarrar y derile creame lineas temporales cada 6 meses porejemplo
// y luego podemos crear mas objetos para crear cada ves mas lineas con distintos "ciclos temporales"

//ahora lo hago
// esto te marca lineas de x dias atras (dias o periodo en mi caso uso barras diarias)).


// solo crea una sola linea de tiempo de hace 20 dias.

int numerodevelas = 20;// shr
int numerodevelas1 = 50;// shr
int numerodevelas2 = 250;// shr
int numerodevelas3 = 730;// lo dejo hasta acá voy a dar de comer a los conjeos despues volve y hace los ciclos.
void OnStart()
  {
   MqlRates InfoPrecio[];
   
   ArraySetAsSeries(InfoPrecio,true);
   CopyRates(_Symbol, _Period, 0, numerodevelas + 1, InfoPrecio);

   CrearLinea("shrot term trend dura aprox 20 días", InfoPrecio[numerodevelas].time);
   CrearLinea1("medium term trend dura aprox. 50 dias", InfoPrecio[numerodevelas1].time);
   CrearLinea2("primary  trend dura aprox. 250 dias", InfoPrecio[numerodevelas2].time);
   CrearLinea3("secular trend 2 años", InfoPrecio[numerodevelas3].time); // esto segun el cap uno en la imagen de la pagina 16 que habla de tendencias y ciclos
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CrearLinea(string identificador, datetime  Posicion)
  {
   ObjectCreate(_Symbol, identificador, OBJ_VLINE, 0, Posicion, 0); // del objeto este, con su identificador podemos asignarle otras propiedades a las predefinidas.
   ObjectSetInteger(_Symbol, identificador, OBJPROP_COLOR, clrYellow);// color amarillo
   ObjectSetInteger(_Symbol, identificador, OBJPROP_WIDTH, 2);// ancho 2
   ObjectSetInteger(_Symbol, identificador, OBJPROP_STYLE, STYLE_DASH); //estilo rayado
  }
  
  void CrearLinea1(string identificador, datetime  Posicion)
  {
   ObjectCreate(_Symbol, identificador, OBJ_VLINE, 0, Posicion, 0); // del objeto este, con su identificador podemos asignarle otras propiedades a las predefinidas.
   ObjectSetInteger(_Symbol, identificador, OBJPROP_COLOR, clrAquamarine);// color amarillo
   ObjectSetInteger(_Symbol, identificador, OBJPROP_WIDTH, 2);// ancho 2
   ObjectSetInteger(_Symbol, identificador, OBJPROP_STYLE, STYLE_DASH); //estilo rayado
  }
  
  void CrearLinea2(string identificador, datetime  Posicion)
  {
   ObjectCreate(_Symbol, identificador, OBJ_VLINE, 0, Posicion, 0); // del objeto este, con su identificador podemos asignarle otras propiedades a las predefinidas.
   ObjectSetInteger(_Symbol, identificador, OBJPROP_COLOR, clrRed);// color amarillo
   ObjectSetInteger(_Symbol, identificador, OBJPROP_WIDTH, 2);// ancho 2
   ObjectSetInteger(_Symbol, identificador, OBJPROP_STYLE, STYLE_DASH); //estilo rayado
  }
  
  void CrearLinea3(string identificador, datetime  Posicion)
  {
   ObjectCreate(_Symbol, identificador, OBJ_VLINE, 0, Posicion, 0); // del objeto este, con su identificador podemos asignarle otras propiedades a las predefinidas.
   ObjectSetInteger(_Symbol, identificador, OBJPROP_COLOR, clrBlue);// color amarillo
   ObjectSetInteger(_Symbol, identificador, OBJPROP_WIDTH, 2);// ancho 2
   ObjectSetInteger(_Symbol, identificador, OBJPROP_STYLE, STYLE_DASH); //estilo rayado
  }
//+------------------------------------------------------------------+
