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

double ATR = iATR(_Symbol,PERIOD_CURRENT,ParametrodeATR) * 10;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   for(int a=0; a<PositionsTotal() ; a++)
     {
      ulong Ticket=PositionGetTicket(a);

      if(_Symbol == PositionGetString(POSITION_SYMBOL))
        {
         //COMPRA
         if(PositionGetInteger(POSITION_TYPE)== POSITION_TYPE_BUY && Compra==false)
           {
            AperturaCompra=PositionGetDouble(POSITION_PRICE_OPEN);
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
            AperturaVenta=PositionGetDouble(POSITION_PRICE_OPEN);
            SLVenta= AperturaVenta + ATR*_Point;
            TPVenta= AperturaVenta - (ATR*2)*_Point;

            trade.PositionModify(Ticket,SLVenta,TPVenta);
            Venta=true;
           }
        }
     }
  }
//+------------------------------------------------------------------+
