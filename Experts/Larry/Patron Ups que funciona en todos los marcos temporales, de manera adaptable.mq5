//+------------------------------------------------------------------+
//|                                                    Plantilla.mq5 |
//|                                                 elias Prueba1 .0 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "elias Prueba1 .0"
#property link      "prueba sin trailing stop ni nada mas. com"
#property version   "1.00"
#include <MoneyManagement1.mqh>
#include <Trade/Trade.mqh>

//handdler:
int ATR_h;

//time filter ; close
input int hora_de_cierre = 23;//Hora de cierre del mercado
input int minuto_de_cierre = 58;//Minutos de cierre del mercado


CTrade trade;

ulong trade_ticket;
datetime lastBarTime;
//arrays
MqlRates bars[];
MqlDateTime Time[];
double ATR[];

double ask;
double bid;
double spread;


int bars1;
bool nueva_vela()
  {
   int current_bars = Bars(_Symbol, _Period);
   if(current_bars != bars1)
     {
      bars1 = current_bars;
      return true;
     }//vigila esta func
   return false;
  }

 

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
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
   //EventSetTimer(86370);
   
   ATR_h = iATR(_Symbol, _Period, 3);

   if(ATR_h == INVALID_HANDLE)
     {
      Print("Error al iniciar el indicador");
      return INIT_FAILED;
     }
checkfornewcandel
   ArraySetAsSeries(ATR, true);
   ArraySetAsSeries(bars, true);
   ArraySetAsSeries(Time , true);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   if(ATR_h != INVALID_HANDLE) IndicatorRelease(ATR_h);
    
SymbolInfoDouble(_Symbol, SYMBOL_EXPIRATION_DAY);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   MqlDateTime strucTime;
   TimeCurrent(strucTime); // hora del servidor creo que es la que se requiee para cierre, hay queestablecerla si o si de lo contrario te va a dar numeros 
                           //aignamos estructura como el timepo int del servidor actual, sea hora , minutos , seg, etc.
   

    
   CopyBuffer(ATR_h, 0, 0, 10, ATR);
   CopyRates(_Symbol, _Period, 0, 10, bars);
   ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   spread = ask-bid;
   double Stoppips = (ATR[1])/_Point;

   double tradeSize = MoneyManagement(_Symbol, 0.1, 1, Stoppips);

   if(operacion_cerrada()) //es verdad que hay una operacion cerrada
     {
     //Buy: max[0] > max [1] && min[0]< min[1] && close[0]< min[0] 
      //if(bars[1].high > bars[2].high && bars[1].low < bars[2].low && bars[1].close<bars[2].low && bars[0].open < bars[1].close)
      
      if(bars[1].open > bars[2].high && bars[1].low < bars[2].low && bars[1].close < bars[2].low && bars[0].open <bars[1].close)//Patron dia exterior  S&P 500
         {
                  if(strucTime.hour < hora_de_cierre && strucTime.min < minuto_de_cierre) trade.Buy(tradeSize,_Symbol, ask + spread, ask - (ATR[1]*0.7) - spread); // esto impide que habraen la misma barra mas de una operacion
                  trade_ticket = trade.ResultOrder(); // esto impide que abra varias operacioes 
         }
        }    
        
        //trade.PositionClose(trade_ticket, bid);
        
        if (strucTime.hour == hora_de_cierre && strucTime.min == minuto_de_cierre)
        {
        trade.PositionClose(trade_ticket, bid);
        Print("La barra cerro: ", hora_de_cierre, ":", minuto_de_cierre);
        } 
       
 
 }
  
  
  
  
 /* void OnTimer() // se ejecuta cada x cant de timepo dependiendo del valor puesto en oninit con set event timer.
{
   // Verificar si hay una posición abierta
   if (operacion_cerrada() == false) // si hay una operacion abierta o lo que es lo mismo operacion crerrada es igual a false, entonces.
   {
      // Verificar si hemos llegado al final de la barra actual
      if (TimeCurrent() > bars[0].time)
      {
         // Cerrar la posición al cierre de la barra
         trade.PositionClose(trade_ticket, bid);
      }
   }*/
//+------------------------------------------------------------------+

 /*   ctrade
     //trailling stop:
     
     //funcion que saqe de YT : tailling stop
   for(int i = PositionsTotal() - 1 ; i >= 0 ; i--)
     {
      ulong posTicket = PositionGetTicket(i);
      if(PositionSelectByTicket(posTicket))
        {
         double posSl = PositionGetDouble(POSITION_SL);

         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
           {

            if(bars[1].low - spread > posSl)
              {
               trade.PositionModify(posTicket,bars[1].low - spread, 0);  
              }

           }

  }}*/