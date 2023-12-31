//segunda parte, o sea mi codigo modificado para que detecte precios de cierre y no precio bid
// primero metemos este experto y luego tenemos que cambiar el nombre a la linea de tendencia.


// acá usaremos close[0] y no close[1]
//+------------------------------------------------------------------+
//|                                                                  |

#include <Trade/Trade.mqh>

input int CloseTimeHour = 22;
input int CloseTimeMin = 54;
input int CloseTimeSec = 0;
input bool cierre = false; // cerrar ordenes autom. a tiempo
//

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

MqlRates infoprecio[];

   string id = "-1002123527134";
   string token = "6606815801:AAGiHaILLrrO_FCEnGAB9wQn_vt-GsrGKbo";
   
   string texto1 = "Posible compra violamos la linea de tendencia desde abajo...";
   string texto2 = "violamos la linea de tendencia desde arriba...";

int OnInit()
  {
   
   CopyRates(_Symbol, PERIOD_CURRENT, 0, 6 , infoprecio);
   ArraySetAsSeries(infoprecio, true);

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
  CopyRates(_Symbol, PERIOD_CURRENT, 0, 6 , infoprecio);
  double close = infoprecio[0].close;
  static double lastClose = close;
   //double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   //static double lastBid = bid;

   string objName = "clave";
   datetime time = TimeCurrent();

   double price = ObjectGetValueByTime(0, objName, time);

   if(close >= price && lastClose< price)
     {

      //Print("We hit the line from below ! Do something ...");
      
       string resultado1;
       StringConcatenate(resultado1," [simbolo]: ", _Symbol , " ", texto1, " ", " [simbolo]: ", _Symbol, " ", " en Tiempo de Servidor: ", TimeCurrent(), " " , " en Tiempo Local: " , TimeLocal());
      
      
      Print(resultado1);
      Alert(sendMessage(resultado1, id, token));
      Sleep(2500);

     }

   if(close <= price && lastClose > price)
     {
       
       string resultado2;
       StringConcatenate(resultado2, " [simbolo]: ", _Symbol , " ", texto2, " ", " [simbolo]: ", _Symbol, " ", " en Tiempo de Servidor: ", TimeCurrent(), " " , " en Tiempo Local: " , TimeLocal());
       
      
      //Print("We hit the line from above ! Do something ...");
      Print(resultado2);
      Alert(sendMessage(resultado2, id, token));
      Sleep(2500);

     }

   lastClose = close;

   Comment("\n precio Linea ", price, "\n close : ", close);
   
   
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

    Comment("\n [Trend Line Alert] ","\n precio Linea ", price, "\n close : ", close , " \n ----------------------------------\n [Cerrar automaticamente ...]","\n Server Time: ", TimeCurrent(), "\n Close Time: ", timeClose, "\n Current Symbol: ", Symbol(), "\n---------------------------------- ","\n Cierre Automatico activado ? ", cierre);

  }

// ahora deberia de mejorar el codigo.

//+------------------------------------------------------------------+

int sendMessage(string text, string chatID, string botToken)
{
string baseUrl = "https://api.telegram.org";
string headers = "";
string requestURL ="";
string requestHeaders = "";
char resultData[];
char posData[];
int timeout = 2000;

requestURL = StringFormat("%s/bot%s/sendmessage?chat_id=%s&text=%s",baseUrl, botToken, chatID,text);
int response = WebRequest("POST", requestURL, headers, timeout, posData, resultData,requestHeaders);

string resultMessage = CharArrayToString(resultData);
Print(resultMessage);

return response; 
}