#property copyright "Copyright 2022, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+


//funcion para detectar nueva vela o barra




// INICIO
#include <Trade\Trade.mqh>
#include <MoneyManagement1.mqh>


int fractal_alcista = 0;
int fractal_bajista= 0;

CTrade trade; 
ulong trade_ticket;



//variables
//creating arrays 
   // carguemos los fractales unicamente para testear
   double fracUpArray[];
   double fracDownArray[];

   MqlRates infoprecio[];
   double jawsArray[];
   double teethArray[];
   double lipsArray[];

//manejadores
int fractal_h;
int alligator_h;


int bars;//funciones opsiblemente utiles // creo que si no le especificamos entonces es 0

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
   return !PositionSelectByTicket(trade_ticket); //Retorna true en caso de que la función se ejecute con éxito o sea encontró op. abierta. y pasamos del true a false
  }
  
  //voy a hacer una mezcla, unicamente tendre en cuenta el ultimo valor del fractal para condfirmar aparte me dara una idea visual 
  //cuando confirme que esta bien hecho el patron de velas  ahi es cuadno lo dejare
  
  int OnInit()
  {
   MqlTradeRequest request;
   MqlTradeResult result;
   ArraySetAsSeries(infoprecio,true);
  
  //define values
    fracDef=iFractals(_Symbol,_Period);
    alligatorDef=iAlligator(_Symbol,_Period,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN);
   
   //Sorting data
   ArraySetAsSeries(fracUpArray,true);
   ArraySetAsSeries(fracDownArray,true);
   
   ArraySetAsSeries(jawsArray,true);
   ArraySetAsSeries(teethArray,true);
   ArraySetAsSeries(lipsArray,true);
   
   }
   
   
     void OnDeinit(const int reason)
  {
  
   if(alligatorDef != INVALID_HANDLE)
      IndicatorRelease(alligatorDef);
   if(fracDef != INVALID_HANDLE)
      IndicatorRelease(fracDef); 
      
  }
   