//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#include <Trade\Trade.mqh>

CTrade trade;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   
   Print(" el numero del buffer 1 : ", CyberTrenATR_buff1(1));
   Print(" el numero del buffer 2 : ", CyberTrenATR_buff2(1));
   
   if ((CyberTrenATR_buff1(2) == 1 && CyberTrenATR_buff1(1) == -1) || (CyberTrenATR_buff1(2) == -1 && CyberTrenATR_buff1(1) == 1)) 
   
   {Print("se cumplio la condicion o sea cambiamos de linea ade arriba a la de abajo ");


   int totalPositions = PositionsTotal();

   for(int i = totalPositions - 1; i >= 0; i--)
     {
      ulong ticket = PositionGetTicket(i);
      string symbol = PositionGetSymbol(i);

      // Verificar si la posición pertenece al símbolo actual
      if(StringCompare(symbol, Symbol(), 0) == 0)
        {
         trade.PositionClose(ticket, -1);
        }
     }
  }}
// deberia cerrar solo del simbolo al que seleccionamos

// si funciona como deberia

// el LT supertrend solo tiene uno asi que tenemos que haer andar como sea el sybertrend zone o apañarnosla de otra manera

//+------------------------------------------------------------------+


double CyberTrenATR_buff2(int posicion)
  {
   double ATRT[];
   string name = "Market\\Cybertrade ATR Trend Zone.ex5";
   int handler = iCustom(_Symbol, PERIOD_CURRENT, name);
   CopyBuffer(handler,2,0,3,ATRT);
   ArraySetAsSeries(ATRT,true);

   return (ATRT[posicion]);

  }



double CyberTrenATR_buff1(int posicion)
  {
   double ATRT[];
   string name = "Market\\Cybertrade ATR Trend Zone.ex5";
   int handler = iCustom(_Symbol, PERIOD_CURRENT, name);
   CopyBuffer(handler,1,0,3,ATRT);
   ArraySetAsSeries(ATRT,true);

   return (ATRT[posicion]);

  }
  
  
  
double CyberTrenATR_buff0(int posicion)
  {
   double ATRT[];
   string name = "Market\\Cybertrade ATR Trend Zone.ex5";
   int handler = iCustom(_Symbol, PERIOD_CURRENT, name);
   CopyBuffer(handler,0,0,3,ATRT);
   ArraySetAsSeries(ATRT,true);

   return (ATRT[posicion]);

  }