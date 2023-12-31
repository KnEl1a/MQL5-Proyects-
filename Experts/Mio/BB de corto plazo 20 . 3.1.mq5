#include <trade\trade.mqh>
#include <MoneyManagement1.mqh>

CTrade trade;

ulong trade_ticket;

int bb_h;
double bb_dw[];
double bb_up[];

MqlRates rates[];

void OnInit()
{
   bb_h= iBands(_Symbol,PERIOD_CURRENT,20,0,3,PRICE_OPEN);
   
   ArraySetAsSeries(bb_dw,true);
   ArraySetAsSeries(bb_up,true);
   ArraySetAsSeries(rates, true);
   
}
void OnDeinit(const int reason)
{
   IndicatorRelease(bb_h);
}
//buffers de ibands: Números de búfers: 0 - BASE_LINE, 1 - UPPER_BAND, 2 - LOWER_BAND
void OnTick()
{
   double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
   double bid = NormalizeDouble(SymbolInfoDouble (_Symbol, SYMBOL_BID), _Digits);

   CopyBuffer(bb_h,1,0,3,bb_up);
   CopyBuffer(bb_h,2,0,3,bb_dw);
   CopyRates(_Symbol, PERIOD_CURRENT,0, 3,rates);
   
   if(operacion_cerrada() && condicion_compra())
   {
      trade.Buy(0.1 , _Symbol, ask, ask - 555*_Point , ask + 555*1.5*_Point);
      trade_ticket = trade.ResultOrder();
      
   }
   
    if (operacion_cerrada () && condicion_venta())
   {
      trade.Sell(0.1 , _Symbol, bid, bid + 555*_Point , bid - 555*2*_Point);
      trade_ticket = trade.ResultOrder();
      
   }
   
   
}

bool operacion_cerrada()
{
  return !PositionSelectByTicket(trade_ticket);
}

bool condicion_compra()
{
   return rates[0].close <= bb_dw[0]; // asi si abre las operaciones de compra con el simbolo <= porque con == no lo hace.
   // pero esta en open esto
}

bool condicion_venta()
{
   return rates[0].close >= bb_up[0];
}