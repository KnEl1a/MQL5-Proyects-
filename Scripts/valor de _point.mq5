//+------------------------------------------------------------------+
//|                                              valor de _point.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "mamarrachero."
#property link      "https://perralocura.com"
#property version   "2.00"

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

//double ATR = iATR(_Symbol, PERIOD_CURRENT, 14); , ya que lo declaro como manejador


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
/*
CopyBuffer se utiliza para obtener valores de indicadores personalizados que ya han sido calculados previamente,
mientras que CopyRates se utiliza para obtener datos OHLC históricos directamente del histórico de precios del símbolo.
*/



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnStart()
  {

   Print("el valor de _point es: ", _Point);
   Print("el _Symbol es: ", _Symbol);
   Print("el _StopFlag es: ", _StopFlag);
   Print("el valor de _Digits es: ", _Digits);
   double ContractSize = SymbolInfoDouble(_Symbol,SYMBOL_TRADE_CONTRACT_SIZE);
   Print("el valor de tamaño de contrato es: ", ContractSize);//nice


//------------------------------------------------------------------------------------------------------------------------------------
//CAccountInfo info;
//Gestion de capital laboratorio:



//variables
double Equity = AccountInfoDouble(ACCOUNT_BALANCE); //nota segun L.williams usa el balance de la cuenta. segun las AI hay que usar el equity 
double porcentaje_De_riesgo = 2; // 1% de riesgo.
int distancia_de_st_enPips = 30;

double pipSize = _Point*10;
double bidPrice = SymbolInfoDouble(_Symbol, SYMBOL_BID);
double askPrice = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
double cotizacion = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE );
//riesgo en dolares

//double Monto_del_riesgo = Equity*(porcentaje_De_riesgo/100); // este no calcula la verdad no se porque si esta bin pero bue
  porcentaje_De_riesgo= porcentaje_De_riesgo/100; // no funcionaba porque el tipo de variable de procentaje de riesgog era tipo it, , cambiandolo a tipo double pudo realizar el calculo aritmetico.
   double Monto_del_riesgo = Equity*(porcentaje_De_riesgo);

//valor del pip:

double pipValue = (ContractSize * pipSize)/ bidPrice; // este depende de la compra o la venta

    //double pipValue = (SymbolInfoDouble(_Symbol, SYMBOL_POINT) / SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_SIZE)) * SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE);
    
    
    // tamaño del lote
    
    double tamanio_de_lote = Monto_del_riesgo / (distancia_de_st_enPips*pipValue);
   Ctrade
   
   Print("cotizacion : ", cotizacion);
 
 Print("distancia sl en pips : ", distancia_de_st_enPips);
   Print("valor del pip es : ", pipValue);
   Print(" tamaño del pip : ", pipSize);
   Print(" monto del riesgo : ", Monto_del_riesgo);
   
    Print("Precio Bid (venta) de ", _Symbol, ": ", bidPrice);
    Print("Precio Ask (compra) de ", _Symbol, ": ", askPrice);

//tamaño del lote

Print("Tamanio_de_lote en ", _Symbol, ": ", tamanio_de_lote);
Print("Tamanio_de_lote esta confirmado en forex Eurusd ");
Print("Tamanio_de_lote no sirve para commodities ni tampoco para mercado de futuros de materias prias porque ?");
//fracase en gestion monetaria, solo sire para forex, pero este algoritmo no se adapta a mercados de futuros de indices y comoddities por ejemplo . 


}
//------------------------------------------------------------------------------------------------------------------------------------











   /*
   estudio de esto:

   trade.Buy(0.1, _Symbol, Ask, Ask-50*_Point, Ask+150*_Point);
      trade_ticket = trade.ResultOrder();

   */

//double tp = _Point + 150; // aparece 150.000001
//   por ende debo hacer esto: 150*_Point  y multiplicarlo por el ask actual



   /*
    double bidPrice = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    double askPrice = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    double pipSize = _Point*10;



    //double pipValue = (SymbolInfoDouble(_Symbol, SYMBOL_POINT) / SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_SIZE)) * SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE);
    double pipValue = (ContractSize * pipSize)/ bidPrice;
   
   Print("valor del pip es : ", pipValue);
   Print(" tamaño del pip : ", pipSize);
   
   
    Print("Precio Bid (venta) de ", _Symbol, ": ", bidPrice);
    Print("Precio Ask (compra) de ", _Symbol, ": ", askPrice);
    */

//tamaño del lote

//ahora con atr, NO FALLE LOCO. ta difichil.



// no sirve algo estoy haciendo mal q el atr siempre es una constante.

// no pude calc. el valor del atr en script para ver su valor
 
//+------------------------------------------------------------------+
