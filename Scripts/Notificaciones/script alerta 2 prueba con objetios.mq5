//+------------------------------------------------------------------+
//|                                                  MiEA.mq5     |
//|                        Generated by Bing AI                    |
//+------------------------------------------------------------------+
#property strict

// Identificador único para la alerta
input int alertID = 1;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   // Establecer una alerta para el precio actual
   ObjectCreate(0, "MyAlert", OBJ, 0, 0, 0);

   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   // Verificar si la alerta está activa
   if (ObjectGetInteger(0, "MyAlert", OBJPROP_STATE) == OBJ_STATE_SELECTED)
   {
      // Ejecutar acciones cuando la alerta está activa
      Print("¡La alerta se ha activado!");

      // Eliminar el objeto después de tocarlo
      ObjectDelete(0, "MyAlert");
   }
}

//+------------------------------------------------------------------+
