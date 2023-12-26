//+------------------------------------------------------------------+
//| Valores de indicadores como atr o sarp para traillling stops.mq5
//| Copyright Eli
//| https://www.mql5.com
//+------------------------------------------------------------------+
#property copyright "Eli"
#property link      "https://www.mql5.com"
#property version   "1.00"


//precios y spread

//double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
//double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
//double spread = Ask - Bid; 

//esto de arriba tiene que ir en ontick de lo contrario no te cuenta nada asi que fijate 

//handlers
int ATR_h;

//arrays dinamicos
double ATR[];
MqlRates barra[];


//entradas
input int MAperiodoATR=14;
double Stoppips; // ya tengo el valor del atr no hace falt hacer la diferencia
double Stoppips2;

double stoplossbuy;
double stoplosssell;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
   ATR_h = iATR(_Symbol,_Period,MAperiodoATR);
   if(ATR_h == INVALID_HANDLE)
     {
      Print("Error al iniciar el indicador");
      return INIT_FAILED;
     }
     
     //arreglamos array para introducir luego los valores
     
    ArraySetAsSeries(ATR, true);
    ArraySetAsSeries(barra, true);
  
     
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
if(ATR_h != INVALID_HANDLE)
      IndicatorRelease(ATR_h);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
  
double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
double spread = Ask - Bid; 
  
  Print ("el precio ask es : " + Ask + " y el precio bid es : ",Bid );
  Print("el spread es : ", spread);
  
//---

/*
CopyBuffer(ATR_h, 0, 0, 3, ATR);
CopyRates(_Symbol, _Period, 0, 2,barra);
Print("valor ATR ", + ATR[0] + " del simbolo ", _Symbol);

//el maximo de la vela anterior es : 
Print("el maximo de la barra anterior es : ", barra[1].high);
Print("el minimo de la barra anterior es : ", barra[1].low);





Stoppips = ATR[0] / _Point;
Print("valor Stoppips ", Stoppips); // funciono, me dio los pips del rango promedio verdadero.

//obtenemos el bid y el ask

//entradas con spread 


Print ("el precio ask es : " + Ask + " y el precio bid es : ",Bid );



double  spr = ((SymbolInfoInteger(_Symbol, SYMBOL_SPREAD))*_Point); 

Print ("el spread  es : " + spread);
Print ("el cal. de otra forma spread  es : ", spr);


double stp_compra = Ask - ATR[0] - spread;
double stp_venta = Bid + ATR[0] + spread; //para evitar falsos toques rcorda que el precio por un tema de spread tiene como un rango de bid y ask entonces para que no salte antes incorporamos el spread all stop loss


Print("el stop de compra (ask ) con spread es ", stp_compra);
Print("el stop de venta (bid) con spread es ", stp_venta);//lo tenemos 

Print("spread alterno : ", SymbolInfoInteger(_Symbol, SYMBOL_SPREAD));//lo tenemos
Print("spread alterno con * de _point: ", ((SymbolInfoInteger(_Symbol, SYMBOL_SPREAD))*_Point));//lo tenemos



//calculo de precio de stop loss usando maximo y atr[1]*3
//del supuesto alumno de richard dennis
stoplossbuy=barra[1].high - (ATR[1]*3) - spread;
stoplosssell=barra[1].low + ((ATR[1]*3)) + spread;

Print("precio stop loss de compra " , stoplossbuy);
Print("precio stop loss de venta " , stoplosssell);



Print("+---------------------------------------------------------------------------------------+"); 
*/
  }
//+------------------------------------------------------------------+
