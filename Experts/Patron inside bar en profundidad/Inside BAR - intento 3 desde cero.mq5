//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "elias"
#property link      ""
#property version   "1.00"

#include <Trade/Trade.mqh>
#include <MoneyManagement1.mqh>


// Creamos un objeto que nos permitirá abrir operaciones
CTrade trade;
ulong trade_ticket;
MqlRates infoprecio[];
int InsideBar= 0; //contador

int bars; // creo que si no le especificamos entonces es 0

//para gestion monetaria
//Varaialbles para la gesition monetaria
input double porcentaje_de_riesgo = 1;
double vol_predeterm = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);


//funciones auxiliares
bool nueva_vela()
  {
   int current_bars = Bars(_Symbol, _Period);
   if(current_bars != bars)
     {
      bars = current_bars;
      return true;
     }

   return false;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

   ArraySetAsSeries(infoprecio,true);

//---
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {

   double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   double spread = NormalizeDouble(ask - bid, _Digits);

   CopyRates(NULL, PERIOD_CURRENT, 0, 7, infoprecio);
//Inside Bar
   if(((infoprecio[2].low < infoprecio[1].low) && (infoprecio[2].high > infoprecio[1].high)) && nueva_vela())
     {
      InsideBar = InsideBar + 1;
      Print("inside bar ocurrio: ", infoprecio[1].time, "y su spread o diferencial fue de ", infoprecio[1].spread, "y segun el otro spread es de ", spread);  // un lujo , una maravilla el algoritmo

      trade.BuyStop(SymbolInfoDouble(NULL, SYMBOL_VOLUME_STEP), infoprecio[1].high + spread,  infoprecio[1].low - spread);
     }

   Comment(" spread : ", spread, "\nask : ", ask, "\ny el bid es : ", bid, "\n cantidad de inside bar encontradas : ", InsideBar);

  }


//notas


//los spread funcionan bien pero me quedo con el spread calculado   "double spread = NormalizeDouble(ask - bid, _Digits);"

// nota 2 : no hay forma de hacerlo que funcione porque parece que no detecta el patron cuando lo hago con e lclose y eso ., sin embargo
// si detecta el inside bar por l oque puedo poner un buy stop y o sell stop para hacer que funcione y rprobar el tema es que tengo que hacerlouego que este se elimine .
