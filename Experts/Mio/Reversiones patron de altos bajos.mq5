#include <trade\trade.mqh>

CTrade trade;

ulong trade_ticket;

MqlRates rates[];

  int cont = 0;
   int cont2 = 0;

/*
haremos patrones de velas segun los diasa exteriores de su libro long term secrets to short term trading
el mas basico es fijarce en los maximos  y minimos cuando uno sale para afuera le dice dia exterior y cuando el rango no supera nada le dice barra inside day o dia dentro
lo que buscaba williams siempre es capitalizar los rangos comprimidos menores al rango anterior, o algo asi tengo entendido.

lo que voy a hacer es contar la cantidad de inside days y ademas voy a abrir operaciones.
*/
int bars;
bool nueva_vela()
  {
   int current_bars = Bars(_Symbol, _Period);
   if(current_bars != bars)
     {
      bars = current_bars;
      return true;
     }//vigila esta func
   return false;
  }
  
void OnTick()
{  
   ArraySetAsSeries(rates, true);
   CopyRates(_Symbol,_Period,0,100,rates);
   //double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
   //double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
   
 
   
   //if(rates[1].low > rates[2].low < rates[3].low)
   if(rates[1].low > rates[2].low && rates[2].low < rates[3].low && nueva_vela())  // me lo corrigio la IA, dice que no estaban bien los operadores logicos y por eso no comparaba.
   {
      cont = cont + 1; 
   }
   
   //if(rates[1].high < rates[2].high > rates[3].high)/
   if(rates[1].high < rates[2].high && rates[2].high > rates[3].high && nueva_vela())
   {
      cont2 = cont2 + 1;
   }
      Comment("la cantidad de short term high es: ", cont2," \nla cantidad de short term low es: ", cont);
      
   
}


/*
Conceptos clave del libor long term ... que descubri profundizando en el libro:
- Un maximo a corto plazo es ver un maximo con maximos mas bajos a ambos lados de el, osea el precio subio hasta el cenit y luego comenzo a retroceder.
en cambio el minimo a corto plazo es un minimo con minimos mas altos a ambos lados.

-un dia inside es un dia de negociacion que se dio dentro del rango de negociacion del dia anterior o sea no  supera ni nuevos maximos ni nuevos minimos.


- el simepre dice diario ... o sea le gustan las barras diarias.

-en el caso de identificacion de giros a corto plazo lo que nos dice williams es ignorar los inside days queindican congestion .

*/