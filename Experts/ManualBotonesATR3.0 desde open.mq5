//desde open and close

//Youtube: https://youtu.be/w-ipm3nkvWs

/*
This code is written in MQL5 language and is used to modify the stop loss and take profit levels of open positions.
The code begins by declaring two sets of variables, one for buy positions and one for sell positions, which will store the opening price,
stop loss and take profit levels. It then enters the OnTick() function, which is called every time a new tick is received. Inside the function,
a loop is used to iterate through all open positions. For each position, the code checks if the symbol matches the current symbol and then checks
if the position type is either buy or sell. If the position is a buy position, the opening price, stop loss and take profit levels are calculated
and then the trade.PositionModify() function is called to modify the position with the new levels. The same process is repeated
for sell positions.
*/

//si funcionaG

//nota esta mal porque algo estoy haceiendo mal q no carga el indicador.

int i = BuyStopLoss  

#include<Trade\Trade.mqh> CTrade trade;

double AperturaVenta=0;
double SLVenta=0;
double TPVenta=0;
bool Venta=false;
double AperturaCompra=0;
double SLCompra=0;
double TPCompra=0;
bool Compra=false;
input int ParametrodeATR;
double ATR
//double ATR = iATR(_Symbol,_Period,ParametrodeATR) * 10;//*10 porque arroja valor en ticks por lo que lo multiplico * 10 para especificar el valor en pips

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
  //double ATR = iATR(_Symbol,_Period,ParametrodeATR) * 10;
   for(int a=0; a<PositionsTotal() ; a++)
     {
      ulong Ticket=PositionGetTicket(a);

      if(_Symbol == PositionGetString(POSITION_SYMBOL))
        {
         //COMPRA
         if(PositionGetInteger(POSITION_TYPE)== POSITION_TYPE_BUY && Compra==false)
           {
            //AperturaCompra=PositionGetDouble(POSITION_PRICE_OPEN);
            //AperturaCompra=iOpen(_Symbol,PERIOD_CURRENT,0); 
            AperturaCompra=iClose(_Symbol,_Period,2);           
            Print("el valor de pips de atr es : ", ATR);
            SLCompra= AperturaCompra - ATR*_Point;//50 pips, voy a asignarle una variable de entrada para ambos
            TPCompra= AperturaCompra + (ATR*2)*_Point; //50 pips, voy a asignarle una variable de entrada para ambos, *2

            trade.PositionModify(Ticket,SLCompra,TPCompra);
            Compra=true;
           }
         //VENTA
         if(PositionGetInteger(POSITION_TYPE)== POSITION_TYPE_SELL && Venta==false)
           {
           
            Print("el valor de pips de atr es : ", ATR);
            //AperturaVenta=PositionGetDouble(POSITION_PRICE_OPEN);
            //AperturaVenta=iOpen(_Symbol,PERIOD_CURRENT,0);
            AperturaVenta=iClose(_Symbol,_Period,2);
            SLVenta= AperturaVenta + ATR*_Point;
            TPVenta= AperturaVenta - (ATR*2)*_Point;

            trade.PositionModify(Ticket,SLVenta,TPVenta);
            Venta=true;
           }
        }
     }
  }
//+------------------------------------------------------------------+
