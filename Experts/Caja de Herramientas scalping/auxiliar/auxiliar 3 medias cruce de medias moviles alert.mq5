int interruptor = 0;
string dicho = "";

void OnTick()
{
   
   //3 medias moviles de manera ascendente
   if(MediaMovil(1,20) > MediaMovil(1,50)
   
      && MediaMovil(1,50) > MediaMovil(1,100)
      && interruptor != 1
      
   )
   {
        Alert("Compra");
        interruptor = 1;
        dicho = " SMA 20 > SMA 50 > SMA 100 \n Tendencia Alcista"; // tambien podria ser como un indicador mas del solapamiento
   }
      
      //3 medias moviles de manera descendente
      if(MediaMovil(1,20) < MediaMovil(1,50)
   
      && MediaMovil(1,50) < MediaMovil(1,100)
      && interruptor != 2
      
   )
   {
        Alert("Venta");
        interruptor = 2;
        dicho = "SMA 20 < SMA 50 < SMA 100 \n Tendencia Bajista";
   }
   
   
// 3 medias moviles sin ningun orden anterior
if (
    (MediaMovil(1, 20) < MediaMovil(1, 50) && MediaMovil(1, 20) > MediaMovil(1, 100)) || (MediaMovil(1, 20) > MediaMovil(1, 50) && MediaMovil(1, 20) < MediaMovil(1, 100)) && (interruptor != 3)
) 
{
interruptor = 3;
dicho = "El solapamiento de SMA no esta Claro";
}

   
Comment("\n--------------------","Estado de SMA´s : \n", dicho);
   
}

double MediaMovil(int posicion, int periodos)
{
   double MediaMovilArray[];
   CopyBuffer(iMA(_Symbol,NULL,periodos, 0, MODE_SMA, PRICE_CLOSE),0,0,3,MediaMovilArray);
   ArraySetAsSeries(MediaMovilArray,true);
   
   return (MediaMovilArray[posicion]);

}

//si funciona perfecto

//lo que podemos hacer ahora es tene


//funciona y podemos hacer cosas con esto 

//deberiamos mejorarlo para que esta mierda sea mas  