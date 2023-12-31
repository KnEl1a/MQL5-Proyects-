#include <Trade/Trade.mqh>

input int CloseTimeHour = 22;
input int CloseTimeMin = 54;
input int CloseTimeSec = 0;
input bool cierre = true; // si funciona genial , ahora si es util 


int OnInit()
{
    return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
}

void OnTick()
{
    MqlDateTime structTime;
    TimeCurrent(structTime);

    structTime.hour = CloseTimeHour;
    structTime.min = CloseTimeMin;
    structTime.sec = CloseTimeSec;

    datetime timeClose = StructToTime(structTime);

    if (TimeCurrent() > timeClose && cierre == true)
    {
        CTrade trade;
        string symbolActual = Symbol(); // Obtener el símbolo actual

        for (int i = PositionsTotal() - 1; i >= 0; i--)
        {
            ulong posTicket = PositionGetTicket(i);
            if (PositionSelectByTicket(posTicket))
            {
                // Verificar si la posición pertenece al símbolo actual
                if (PositionGetString(POSITION_SYMBOL) == symbolActual)
                {
                    if (trade.PositionClose(posTicket))
                    {
                        Print(__FUNCTION__, " > Pos # ", posTicket, " was closed because of close time ... ");
                    }
                }
            }
        }
    }
    
    //-------------------------------
    //acá tenemos comentario sería como una guia 

    Comment("\n Server Time: ", TimeCurrent(), "\n Close Time: ", timeClose, "\n Current Symbol: ", Symbol());
    
    
    
    
    //
    
}



/*
double MediaMovil(int posicion, int periodos)
{
   double MediaMovilArray[];
   CopyBuffer(iMA(_Symbol,NULL,periodos, 0, MODE_SMA, PRICE_CLOSE),0,0,3,MediaMovilArray);
   ArraySetAsSeries(MediaMovilArray,true);
   
   return (MediaMovilArray[posicion]);

}

*/