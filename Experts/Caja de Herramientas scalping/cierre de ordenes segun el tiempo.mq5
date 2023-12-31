#include <Trade/Trade.mqh>

input int CloseTimeHour = 17;
input int CloseTimeMin = 0;
input int CloseTimeSec = 0;


//Print("El símbolo actual es: ", symbol);


int OnInit()
{

SymbolInfoString()

return(INIT_SUCCEEDED);

}

void OnDeinit(const int reason){

}

void OnTick()
{
MqlDateTime structTime;
TimeCurrent(structTime);

structTime.hour = CloseTimeHour;
structTime.min = CloseTimeMin;
structTime.sec = CloseTimeSec;

datetime timeClose = StructToTime(structTime);

if(TimeCurrent() > timeClose)
{
   CTrade trade; // linea de codigo de BNalke numero 29 
   for(int i = PositionsTotal()-1; i >= 0; i--)
   {
      ulong posTicket = PositionGetTicket(i);
      if(PositionSelectByTicket(posTicket)){
         if(trade.PositionClose(posTicket)){
            Print(__FUNCTION__, " > Pos # " , posTicket, " was closed because of close time ... "); 
         }
      
      }
   }      
}

Comment("\n Server Time: ", TimeCurrent(), "\n Close Time: ", timeClose);

}


// el error del codigo es que cierra las posiciones de todos los simbolos del mt5  que tengo abieros

