//+------------------------------------------------------------------+
//|                                                 inside bar 1.mq5 |
//|                                                            elias |
//|                                                                  |
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
int Stoppips;
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


bool operacion_cerrada()
  {
   return !PositionSelectByTicket(trade_ticket);
  }


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
 
 ArraySetAsSeries(infoprecio,true);
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
double spread = ask - bid;
CopyRates(_Symbol, _Period, 0,5, infoprecio);
  
     //FIN , patrones de velas japonesas
   
   //Inside Bar alcista
   //if(((infoprecio[2].low < infoprecio[1].low) && (infoprecio[2].high > infoprecio[1].high)) && nueva_vela() && infoprecio[0].close > (infoprecio[1].high + spread)) //vamos a probar lo de "infoprecio[0].close  + spread""
   
   //gestion monetaria
    Stoppips = (infoprecio[1].high + spread) - (infoprecio[1].low - spread);
    double tradeSize = MoneyManagement(_Symbol, vol_predeterm, porcentaje_de_riesgo, Stoppips);
    
   
if(operacion_cerrada()){
   //entradas largas
   if(((infoprecio[2].low < infoprecio[1].low) && (infoprecio[2].high > infoprecio[1].high)) && nueva_vela() && infoprecio[0].close > (infoprecio[1].high + spread)) //vamos a verporque el spread se me hace complicado y sospechoso pero segun tengo entendido para aumentar la precicion del algoritmo y el calculo es importante
   {
   
         trade.Buy(tradeSize, _Symbol, ask, infoprecio[1].low - spread, 0);
         trade_ticket = trade.ResultOrder();
   }
   
   //entradas cortas
   if(((infoprecio[2].low < infoprecio[1].low) && (infoprecio[2].high > infoprecio[1].high)) && nueva_vela() && infoprecio[0].close < (infoprecio[1].low - spread)) //vamos a verporque el spread se me hace complicado y sospechoso pero segun tengo entendido para aumentar la precicion del algoritmo y el calculo es importante
   {
   
         trade.Sell(tradeSize, _Symbol, bid, infoprecio[1].high + spread, 0);
         trade_ticket = trade.ResultOrder();
   }
   
   //conteo
   if(((infoprecio[2].low < infoprecio[1].low) && (infoprecio[2].high > infoprecio[1].high)) && nueva_vela())
   {
   InsideBar = InsideBar + 1;
   Print("inside bar ocurrio: ", infoprecio[1].time); // un lujo , una maravilla el algoritmo
   }
   }
   
   //trailing stop
   
    for(int i = PositionsTotal() - 1 ; i >= 0 ; i--)
     {
      ulong posTicket = PositionGetTicket(i);
      if(PositionSelectByTicket(posTicket))
        {
         double posSl = PositionGetDouble(POSITION_SL);

         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
           {

            //if((barraH4[1].low - spread - (20*_Point))> posSl)
            if((infoprecio[1].low - spread - (1*_Point))> posSl )// creo q es es por ese orders total () == 1 ;)
              {

               trade.PositionModify(posTicket,(infoprecio[1].low - spread - (1*_Point)), 0);
                 
              }

           }
         else
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
              {
               //if(stoplosssell < posSl || posSl == 0)
               //if((barraH4[1].high + spread + (20*_Point))< posSl)
               if((infoprecio[1].high + spread + (1*_Point))< posSl)
                 {

                  trade.PositionModify(posTicket,(infoprecio[1].high + spread + (1*_Point)), 0); // creo que el stop  de h4 funcionaba  
                    
                 }

              }
        }

     }
   
   Comment("CANTIDADES\n\n Inside Bar: ", InsideBar);
  }
//+------------------------------------------------------------------+


//problema uno parece que no saltan las operaciones ni tampoco me detecta el patron, sospecho qu es el spread asi que generare copia de este codigo y lo eliminare completamente de todo