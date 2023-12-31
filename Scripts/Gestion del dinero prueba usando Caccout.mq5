//+------------------------------------------------------------------+
//|                     Gestion del dinero prueba usando Caccout.mq5 |
//|                                                              Eli |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Eli"
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <Trade\AccountInfo.mqh>
CAccountInfo info;


//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
   /*
    double balance = info.Balance();

    Print("balance :", balance);//listo

    double equity = info.Equity();

    Print("equity :", equity);//listo

    double Margenlibre= info.FreeMargin();

    Print("Margen libre :", Margenlibre);//listo

    double Leverage= info.Leverage();

    Print("cantidad de apalancamiento dado:", Leverage);//listo


    */

// Input variables
// Input variables
   double TradeVolume = 0.02;
// OnTick() event handler
   double minVolume = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN);
   double maxVolume = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MAX);
   double stepVolume = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);
   double tradeSize;
   if(TradeVolume < minVolume)
      tradeSize = minVolume;
   else
      if(TradeVolume > maxVolume)
         tradeSize = maxVolume;
      else
         tradeSize = MathRound(TradeVolume / stepVolume) * stepVolume;
   if(stepVolume >= 0.1)
      tradeSize = NormalizeDouble(tradeSize,1);
   else
      tradeSize = NormalizeDouble(tradeSize,2);
      
    double tickvalue = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE);

   Print("simbolo:", _Symbol + " y su tick value es : ", tickvalue);//listo
   Print("stepVolume:", stepVolume);//listo
   Print("trade Size:", tradeSize);//listo



  }
//+------------------------------------------------------------------+
