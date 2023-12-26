//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#include <Trade/Trade.mqh>

int handle;
int barsTotal;
CTrade trade;
ulong posTicket;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
   handle = iFractals(_Symbol, PERIOD_CURRENT);
   barsTotal = iBars(_Symbol, PERIOD_CURRENT);

   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   int bars = iBars(_Symbol, PERIOD_CURRENT);
   if(barsTotal != bars)
     {
      barsTotal = bars;

      double fracUpper[];
      double fracLower[];

      CopyBuffer(handle, UPPER_LINE, 3, 1, fracUpper);
      CopyBuffer(handle, LOWER_LINE, 3, 1, fracLower);

      bool isSell = false;
      bool isBuy = false;

      if(fracUpper[0] != EMPTY_VALUE)
        {
         Print("sell signal ... ");
         isSell = true;
         if(posTicket > 0)
           {
            if(PositionSelectByTicket(posTicket))
              {
               if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
                 {
                  if(trade.PositionClose(posTicket))
                    {
                     posTicket  = 0;
                    }
                 }
              }else{posTicket = 0;
              }
           }
        }
      if(fracLower[0] != EMPTY_VALUE){
      Print("buy signal ...");
      isBuy = true;
      if(posTicket > 0){
           if(PositionSelectByTicket(posTicket)){
               if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL){
                     if(trade.PositionClose(posTicket))
                     {
                     posTicket = 0;
                     }
               }
      }else{
      posTicket= 0;
      }
      }
      }
      if(posTicket <= 0)
      {
      if(isSell && !isBuy)
      {
         if(trade.Sell(0.1)){
         posTicket = trade.ResultOrder();
         }
      }
      if(isBuy && !isSell){
         if(trade.Buy(0.1)){
            posTicket = trade.ResultOrder();
         }
            
      }
      }
     }

  }
//+------------------------------------------------------------------+
