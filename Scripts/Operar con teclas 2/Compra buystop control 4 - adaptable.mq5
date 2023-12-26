//+------------------------------------------------------------------+
//|                                             Compra con tecla.mq5 |
//|                                                              eli |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//prototipo en la qu se pone una orden pendiente
#property copyright "eli"
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <MoneyManagement1.mqh>
#include <trade\trade.mqh>
CTrade trade;

//para el money management tengo que hacer un stop points, entonces lo que debo hacer es hacer nua diferencia entre la orden establecida y tambien el minimo o maximo de la barra

//+------------------------------------------------------------------+
//| Script program start function                                    | ademas podemos ver como programar el tiempo de expiracion de la orden a fin de ver si esti es viable o no 
//+------------------------------------------------------------------+ debemos programar la expiracion a fin de zafar de los patrones que no funcan.

void OnStart()
  {
//---
   double t_predeterm = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);
   double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   double spread = ask - bid;

   MqlRates rates[];
   ArraySetAsSeries(rates, true);
   CopyRates(_Symbol, _Period, 0, 5, rates);
   
  
   
   
      ulong orGetticket = OrderGetTicket(0);
      if(PositionSelectByTicket(orGetticket))
        {
         double orSl = OrderGetDouble(POSITION_SL);

            //if((barraH4[1].low - spread - (20*_Point))> posSl)
            if(m> orSl || orSL <)// creo q es es por ese orders total () == 1 ;)
              {

               trade.PositionModify(posTicket,m, 0);
                 
              } }
   
   
  
  //double dif = (rates[1].high + spread) - (rates[1].low - spread);  
  double dif = StopPriceToPoints(_Symbol, rates[1].low - spread, rates[1].high + spread);
  double  tradeSize = MoneyManagement(_Symbol, t_predeterm, 1, dif); // 1% del balance
  
  trade.BuyStop(tradeSize, rates[1].high + spread, _Symbol, rates[1].low - spread);
   
   Print("1)el spread es de ", spread);
   Print("2) el spread de la barra previa es  ", rates[1].spread);
   Print("3) el spread acutal es ", rates[0].spread);
  
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

//funciona bien cuando el precio esta por encima de lo que es el maximo es un problema porque no habre nad