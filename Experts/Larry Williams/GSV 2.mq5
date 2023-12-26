//+------------------------------------------------------------------+
//|                                                          GSV.mq5 |
//|                                elias Prueba1 .0 - LArry williams |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//este progrma trata sobre gsv es un concepto de ruptura de probabilidad en el  cual segun el autor es el esperado de la rupturasd e volatilidad ya que lo que se buscaa es 
//determinar la inmediatez de compradores y vendedores por medio de esto lo que se busca es saber la proxim tendencia
//su calculo consiste en nada mas que realizar un diferencial entre el max y minimo desde la apertura seuido de luego hacer un promedio y multiplicarlo por un porcentaje
/*
En esta parte vamos a ver si se puede  mejorar , como vemos el ratio de sharp esta en negativo. vamos a jugra co nel concepto, profundizando en sus aplicacioes

Incorporaremos un trailing stop y filtros de ordenes de compras
*/
/*
YA corregilo que estaba mal que era eso del calculo , cambie el ask ppor el rates[0].close
asi que ahora resta incorporar en otra version el gsv con trailing stop para aprovechat las tendencias.
asi como filtros de compras queremos tener previabarra un rsi de 2 en niveles de sobrecompra o sobreventa.



*/

//+------------------------------------------------------------------+
#property copyright "elias Prueba1 .0 - LArry williams"
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <Trade\Trade.mqh>
//#include <MoneyManagement1.mqh>

//variables globales
CTrade trade;

//input int periods= 4; //el periodo recomendado por larry williams por lo que luego para ver parametros optimos deberias de hacer 4-3 4-2 4-1 o sea (period - numbero )y asi obtenes los numeros
input int swing_percent_value = 180; 

MqlRates rates[];
ulong trade_ticket;

double ask;
double bid;
double spread;



//+------------------------------------------------------------------+
//funciones basicas

bool operacion_cerrada()
{
   return !PositionSelectByTicket(trade_ticket);
}

//+------------------------------------------------------------------+

//funciones fundamentales del algoritmo:

void OnInit()
{
   ArraySetAsSeries(rates, true);
}

void OnTick ()
{
   ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
   //spread = ask - bid; // despues incorporale el spread.
   CopyRates(_Symbol,PERIOD_CURRENT,0,6,rates);
   
   //if((rates[0].open + Rango_GSV_compra()) == ask && operacion_cerrada())
   if(rates[0].open + Rango_GSV_compra() <= rates[0].close && operacion_cerrada())
   {
      trade.Buy(0.1,_Symbol,ask, (rates[0].open - Rango_GSV_venta()), (rates[0].open + Rango_GSV_compra()* 2.5) );
      trade_ticket = trade.ResultOrder(); 
   }
   
   if((rates[0].open - Rango_GSV_venta()) >= rates[0].close && operacion_cerrada()) // aca me quede en sl , que sera la orden contraria para este caso basico , despues tomare el concepto y lo estudiare a fondo.
   {
      trade.Sell(0.1,_Symbol,bid, (rates[0].open + Rango_GSV_compra()), (rates[0].open - Rango_GSV_venta()* 2.5) );
      trade_ticket = trade.ResultOrder();
   }
     
}

//calculos: 
double Rango_GSV_compra()
{
   double rango_compra =  ((MathAbs(rates[4].high - rates[4].open) + MathAbs(rates[3].high - rates[3].open) + MathAbs(rates[2].high - rates[2].open) + MathAbs(rates[1].high - rates[1].open))/4)*(swing_percent_value/100); // esto esta mal, el calculo esta mal
   //double rango_venta =  ((MathAbs(rates[4].open - rates[4].low) + MathAbs(rates[3].open - rates[3].low) + MathAbs(rates[2].open - rates[2].low) + MathAbs(rates[1].open - rates[1].low))/ 4)*(swing_percent_value/100); // nota los promedios son la suma de los elementos dividida la cantidad de los mismos.
   return rango_compra;
}

double Rango_GSV_venta()
{
   double rango_venta =  ((MathAbs(rates[4].open - rates[4].low) + MathAbs(rates[3].open - rates[3].low) + MathAbs(rates[2].open - rates[2].low) + MathAbs(rates[1].open - rates[1].low))/4)*(swing_percent_value/100);
   return rango_venta;
}