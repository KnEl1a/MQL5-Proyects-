//sin open cl 15, 65 seg
//con open cl 0 , 46 seg
//+------------------------------------------------------------------+
//|                                                 OCL_pi_float.mq5 |
//+------------------------------------------------------------------+
#property copyright "Copyright (c) 2012, Mthmt"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property script_show_inputs;

input int _device=0;        /// OpenCL device number (0, I have CPU)

#define  _num_steps        1000000000 
#define  _divisor          40000
#define  _step             1.0 / _num_steps
#define  _intrnCnt         _num_steps / _divisor

string d2s(double arg,int dig) { return DoubleToString(arg,dig); }
string i2s(int arg)            { return IntegerToString(arg); }

const string clSrc=
                   "#define _step "+d2s(_step,12)+"                   \r\n"
                   "#define _intrnCnt "+i2s(_intrnCnt)+"             \r\n"
                   "                                                   \r\n"
                   "__kernel void pi( __global float *out )            \r\n"   // type float
                   "{                                                  \r\n"
                   "  int i = get_global_id( 0 );                      \r\n"
                   "  float partsum = 0.0;                             \r\n"   // type float
                   "  float x = 0.0;                                   \r\n"   // type float
                   "  long from = i * _intrnCnt;                       \r\n"
                   "  long to = from + _intrnCnt;                      \r\n"
                   "  for( long j = from; j < to; j ++ )               \r\n"
                   "  {                                                \r\n"
                   "     x = ( j + 0.5 ) * _step;                      \r\n"
                   "     partsum += 4.0 / ( 1. + x * x );              \r\n"
                   "  }                                                \r\n"
                   "  out[ i ] = partsum;                              \r\n"
                   "}                                                  \r\n";
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
int OnStart()
  {
   Print("FLOAT: _step = "+d2s(_step,12)+"; _intrnCnt = "+i2s(_intrnCnt));// esto no importada te decia solo lo que esta definido"#define""
   int clCtx=CLContextCreate(CL_USE_GPU_ONLY);

   int clPrg = CLProgramCreate( clCtx, clSrc );
   int clKrn = CLKernelCreate( clPrg, "pi" );

   uint st=GetTickCount();//La función GetTickCount() devuelve la cantidad de milisegundos pasados desde el momento de arranque del sistema. O SEA ESTE TE CUENTA  LOS SEGUNDOS DE ARRANQUE

   int clMem=CLBufferCreate(clCtx,_divisor*sizeof(float),CL_MEM_READ_WRITE); // type float
   CLSetKernelArgMem(clKrn,0,clMem);

   const uint offs[ 1 ]  = { 0 };
   const uint works[ 1 ] = { _divisor };
   bool ex=CLExecute(clKrn,1,offs,works);
//--- Print( "CL program executed: " + ex );

   float buf[];                                          // type float
   ArrayResize(buf,_divisor);
   uint read=CLBufferRead(clMem,buf);
   Print("read = "+i2s(read)+" elements");

   float sum=0.0;                                        // type float
   for(int cnt=0; cnt<_divisor; cnt++) sum+=buf[cnt];
   float pi=float(sum*_step);                            // type float

   Print("pi = "+d2s(pi,12));

   CLBufferFree(clMem);
   CLKernelFree(clKrn);
   CLProgramFree(clPrg);
   CLContextFree(clCtx);

   double gone=(GetTickCount()-st)/1000.;// siempre se hace asi entonces te da la cantidad de milisegundos, se pone desde donde empieza el programa hasta donde termina este.
   Print("OpenCl: gone = "+d2s(gone,3)+" sec.");
   Print("________________________");

   return(0);
  }
//+------------------------------------------------------------------+