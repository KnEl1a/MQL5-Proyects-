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


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
 
   
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
   MqlRates infoprecio[];
   ArraySetAsSeries(infoprecio,true);
  CopyRates(_Symbol, _Period, 0,10, infoprecio);
  
double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
CopyRates(_Symbol, _Period, 0,5, infoprecio);
  
     //FIN , patrones de velas japonesas
   
   //Inside Bar alcista
   //if(((infoprecio[2].low < infoprecio[1].low) && (infoprecio[2].high > infoprecio[1].high)) && nueva_vela() && infoprecio[0].close > (infoprecio[1].high + )) //vamos a probar lo de "infoprecio[0].close  + ""
   
   //gestion monetaria
    Stoppips = (infoprecio[1].high  ) - (infoprecio[1].low);
    double tradeSize = MoneyManagement(_Symbol, vol_predeterm, porcentaje_de_riesgo, Stoppips);
    
   //entradas largas
   //if(((infoprecio[2].low < infoprecio[1].low) && (infoprecio[2].high > infoprecio[1].high)) && nueva_vela() && infoprecio[0].close > (infoprecio[1].high )) //vamos a verporque el  se me hace complicado y sospechoso pero segun tengo entendido para aumentar la precicion del algoritmo y el calculo es importante
   if(((infoprecio[2].low < infoprecio[1].low) && (infoprecio[2].high > infoprecio[1].high) && (infoprecio[0].close > infoprecio[1].high)) && nueva_vela())
   {
   
         trade.Buy(tradeSize, _Symbol, ask, ask - (Stoppips*_Point ), 0);
         trade_ticket = trade.ResultOrder();
   }
   
   //entradas cortas
   //if(((infoprecio[2].low < infoprecio[1].low) && (infoprecio[2].high > infoprecio[1].high)) && infoprecio[0].close < (infoprecio[1].low && nueva_vela() )) //vamos a verporque el  se me hace complicado y sospechoso pero segun tengo entendido para aumentar la precicion del algoritmo y el calculo es importante
    if(((infoprecio[2].low < infoprecio[1].low) && (infoprecio[2].high > infoprecio[1].high) && (infoprecio[0].close < infoprecio[1].low)) && nueva_vela())
   {
   
         trade.Sell(tradeSize, _Symbol, bid, bid + (Stoppips*_Point )  , 0);
         trade_ticket = trade.ResultOrder();
   }
   
   //conteo
   if(((infoprecio[2].low < infoprecio[1].low) && (infoprecio[2].high > infoprecio[1].high)) && nueva_vela())
   {
   InsideBar = InsideBar + 1;
   Print("inside bar ocurrio: ", infoprecio[1].time); // un lujo , una maravilla el algoritmo
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

            //if((barraH4[1].low -  - (20*_Point))> posSl)
            if((infoprecio[1].low)> posSl )// creo q es es por ese orders total () == 1 ;)
              {

               trade.PositionModify(posTicket,(infoprecio[1].low), 0);
                 
              }

           }
         else
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
              {
               //if(stoplosssell < posSl || posSl == 0)
               //if((barraH4[1].high +  + (20*_Point))< posSl)
               if(((infoprecio[1].high)< posSl) || ((infoprecio[1].low)> posSl))
                 {

                  trade.PositionModify(posTicket,(infoprecio[1].high), 0); // creo que el stop  de h4 funcionaba  
                    
                 }

              }
        }

     }
   
   Comment("CANTIDADES\n\n Inside Bar: ", InsideBar);
  }
//+------------------------------------------------------------------+


//problema uno parece que no saltan las operaciones ni tampoco me detecta el patron, sospecho qu es el  asi que generare copia de este codigo y lo eliminare completamente de todo