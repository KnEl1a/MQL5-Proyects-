// version con el alligator
//no me gusta el mecanismo ni que guarde los valores, voy a probar haciendo uno propio detectando el patron a lo rtadicional con un EA y voy a hacerlo asi como debreia de haber heco
// esto lo dejo como algo curioso


//+------------------------------------------------------------------+
//|                                      Fractals with Alligator.mq5 |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+


//funcion para detectar nueva vela o barra




// INICIO
#include <Trade\Trade.mqh>
#include <MoneyManagement1.mqh>


int patron_alcista = 0;
int patron_bajista= 0;

CTrade trade; 
ulong trade_ticket;



//variables
//creating arrays
   double fracUpArray[];
   double fracDownArray[];
   MqlRates priceArray[];
   double jawsArray[];
   double teethArray[];
   double lipsArray[];

//manejadores
int fracDef;
int alligatorDef;


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


void OnInit()
{

//define values
    fracDef=iFractals(_Symbol,_Period);
    
    alligatorDef=iAlligator(_Symbol,_Period,13,8,8,5,5,3,MODE_SMMA,PRICE_MEDIAN);
//Sorting data
   ArraySetAsSeries(fracUpArray,true);
   ArraySetAsSeries(fracDownArray,true);
   ArraySetAsSeries(jawsArray,true);
   ArraySetAsSeries(teethArray,true);
   ArraySetAsSeries(lipsArray,true);
   
   ArraySetAsSeries(priceArray,true);

}

  void OnDeinit(const int reason)
  {
  
   if(alligatorDef != INVALID_HANDLE)
      IndicatorRelease(alligatorDef);
   if(fracDef != INVALID_HANDLE)
      IndicatorRelease(fracDef); 
      
  }


void OnTick()
  {
    double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
  double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
  double spread = NormalizeDouble(ask - bid,_Digits);
 CopyRates(_Symbol,_Period,0,3,priceArray); // capaz que por eso no aprobechava todas las operaciones porque se ejecutaba una vez en el oninit
//define data and store result
   CopyBuffer(fracDef,UPPER_LINE,2,1,fracUpArray);
   CopyBuffer(fracDef,LOWER_LINE,2,1,fracDownArray);
   CopyBuffer(alligatorDef,0,0,3,jawsArray);
   CopyBuffer(alligatorDef,1,0,3,teethArray);
   CopyBuffer(alligatorDef,2,0,3,lipsArray);
//get values
   double fracUpValue=NormalizeDouble(fracUpArray[0],5);
   double fracDownValue=NormalizeDouble(fracDownArray[0],5);
   double closingPrice = priceArray[0].close;
   double jawsValue=NormalizeDouble(jawsArray[0],5);
   double teethValue=NormalizeDouble(teethArray[0],5);
   double lipsValue=NormalizeDouble(lipsArray[0],5);
//creating bool variables to avoid buy and sell signals at the same time
   bool isBuy = false;
   bool isSell = false;
//conditions of the strategy and comment on the chart
//in case of buy
   if(lipsValue>teethValue && lipsValue>jawsValue && teethValue>jawsValue
   && closingPrice > teethValue && fracDownValue != EMPTY_VALUE && nueva_vela())
     {
     
   trade.Buy(0.1,NULL,ask,fracDownValue - spread);
   trade_ticket = trade.ResultOrder();
     
      Comment("Buy","\n",
              "jawsValue = ",jawsValue,"\n",
              "teethValue = ",teethValue,"\n",
              "lipsValue = ",lipsValue,"\n",
              "Fractals Low around: ",fracDownValue);
      isBuy = true;
     }
//in case of sell
   if(lipsValue<teethValue && lipsValue<jawsValue && teethValue<jawsValue
   && closingPrice < teethValue && fracUpValue != EMPTY_VALUE && nueva_vela())
     {
   trade.Sell(0.1,NULL,bid,fracUpValue + spread);
   trade_ticket = trade.ResultOrder();
     
      Comment("Sell","\n",
              "jawsValue = ",jawsValue,"\n",
              "teethValue = ",teethValue,"\n",
              "lipsValue = ",lipsValue,"\n",
              "Fractals High around: ",fracUpValue);
      isSell = true;
     }
  }
//+------------------------------------------------------------------+