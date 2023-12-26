//+------------------------------------------------------------------+
//|                            gestion del capital a base de ATR.mq5 |
//|                                elias Prueba1 .0 - LArry williams |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "elias Prueba1 .0 - LArry williams"
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <trade\trade.mqh>
#include <MoneyManagement1.mqh>

// en esta parte voy a ahacer la gestion de capital basada en atr que usaban los tortugas para arriesgar mas segun el atr y menos segun el atr. Eso aconsejaba richard dennis y todos sabemos muy bien como le fue, ya que el sabia que mas volatilidad representa mas riesgo.

input double porcentaje_de_riesgo = 1.0;
double ATR[];
int ATR_h;

double contratos;

double vol_predeterm = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   ATR_h = iATR(_Symbol, PERIOD_CURRENT, 20);
   
   ArraySetAsSeries(ATR, true);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   if(ATR_h != INVALID_HANDLE)
      IndicatorRelease(ATR_h);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   CopyBuffer(ATR_h, 0, 0, 5, ATR);
   double tradeSize = MoneyManagement(_Symbol, vol_predeterm, porcentaje_de_riesgo, 500);
   double Pporcentaje_de_riesgo = porcentaje_de_riesgo/ 100;
   contratos = (Pporcentaje_de_riesgo * AccountInfoDouble(ACCOUNT_EQUITY)) / (ATR[1]* _Point); // _sera que este equity me da lo que yo quiero que es el point value?
   Comment("el valor de atr es : ", ATR[1], " \nel valor de atr *_point value es : ", ATR[1]*_Point 
   , "\n el equity es :", AccountInfoDouble(ACCOUNT_EQUITY)
   , "\nel porcentaje de riesgo es : ", Pporcentaje_de_riesgo
   , "\ny el numero de contratos ajustado por volatilidad es : ", contratos
   , "\nmientras que los contratos a adquirir segun la forma adicional es : ", tradeSize);  
  }
//+------------------------------------------------------------------+
