int OnInit()
{

return(INIT_SUCCEEDED);

}

void OnDeinit(const int reason)
{

}

void OnTick()
{

double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
static double lastBid = bid;

string objName = "clave";
datetime time = TimeCurrent();

double price = ObjectGetValueByTime(0, objName, time);

if(bid >= price && lastBid < price)
{

Print("We hit the line from below ! Do something ...");

}

if(bid <= price && lastBid > price)
{

Print("We hit the line from above ! Do something ...");

}

lastBid = bid;

Comment(price, "\n", bid);

}

// ahora deberia de mejorar el codigo. 

