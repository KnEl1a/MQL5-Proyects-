int OnCalculate(const int rates_total,
               const int prev_calculted,
               const int begin,
               const double &price[])

{

   dibujarlinea("Ask",SymbolInfoDouble(Symbol(), SYMBOL_ASK));
   dibujarlinea("Bid",SymbolInfoDouble(Symbol(), SYMBOL_BID));
   
   //indica con un valor numerico el spread para tenerlo mejor en cuenta para posicionar mejor nuestro stop
      MqlRates valores[];
      CopyRates(Symbol(),PERIOD_CURRENT,0,1,valores);

      ObjectCreate(0,"spread",OBJ_TEXT,0,valores[0].time,SymbolInfoDouble(_Symbol,SYMBOL_BID));
      ObjectSetString(0,"spread",OBJPROP_TEXT,"   "+SymbolInfoInteger(Symbol(),SYMBOL_SPREAD));
      ObjectSetInteger(0,"spread",OBJPROP_COLOR,clrRed);
      ObjectSetInteger(0,"spread",OBJPROP_FONTSIZE,12);
   
   
   return (0);
}             


void dibujarlinea( string linea, double posicion)
{

      ObjectCreate(Symbol(), linea, OBJ_HLINE, 0, 0, posicion);
      ObjectSetInteger(Symbol(), linea, OBJPROP_COLOR, clrPink);
      

}               