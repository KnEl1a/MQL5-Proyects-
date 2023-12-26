int OnCalculate(const int rates_total,
                const int prev_calculated,
                const int begin,
                const double &price[])
  {
   DibujarLinea("AsK", SymbolInfoDouble(Symbol(), SYMBOL_ASK));
   DibujarLinea("Bid", SymbolInfoDouble(Symbol(), SYMBOL_BID));

   return(0);
  }
  
  void DibujarLinea(string Linea, double Posicion)
  {
   ObjectCreate(Symbol(), Linea, OBJ_HLINE, 0,0, Posicion);
   ObjectSetInteger(Symbol(), Linea, OBJPROP_COLOR, clrYellow);
  }