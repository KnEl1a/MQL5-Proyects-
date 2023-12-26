double ask;
double bid;
double spread;

void OnTick()
{
   ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
   spread = ask - bid;
   Comment("el precio ask es :", ask);
   Comment("el precio bid es: ", bid);
   Comment("el spread es :", spread);
   Comment("el precio de la ultima transaccion es: ", SymbolInfoDouble(_Symbol,SYMBOL_SESSION_CLOSE))
   
}