//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
int Numerovelas=100;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnStart()
  {
   int velaMasBaja=1;
   int velaMasAltal=1;

   MqlRates InfoPrecio[];
   ArraySetAsSeries(InfoPrecio, true);
   CopyRates(Symbol(), PERIOD_CURRENT, 0, Numerovelas+1,InfoPrecio);

   for(int i=1; i<=Numerovelas; i++)
     {
      if(InfoPrecio[i].low < InfoPrecio[(velaMasBaja)].low)
         velaMasBaja=i;

      if(InfoPrecio[i].high > InfoPrecio[(velaMasAltal)].high)
         velaMasAltal=i;
     }
   ObjectCreate(Symbol(), "1", OBJ_HLINE, 0,0,InfoPrecio[velaMasBaja].low);
   ObjectSetInteger(0,"1", OBJPROP_COLOR,clrYellow);
   ObjectSetInteger(0,"1", OBJPROP_WIDTH,2);

   ObjectCreate(Symbol(), "2", OBJ_HLINE, 0,0,InfoPrecio[velaMasAltal].high);
   ObjectSetInteger(0,"2", OBJPROP_COLOR,clrYellow);
   ObjectSetInteger(0,"2", OBJPROP_WIDTH,2);
  }
//+------------------------------------------------------------------+
