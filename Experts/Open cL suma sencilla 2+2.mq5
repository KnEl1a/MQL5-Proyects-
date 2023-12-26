/*string clSrc =
    "__kernel void sum(__global int *a, __global int *b, __global int *result) \r\n"
    "{ \r\n"
    "    int id = get_global_id(0); \r\n"
    "    result[id] = a[id] + b[id]; \r\n"
    "} \r\n";
void SumWithOpenCL()
{
    int a[1] = {5};
    int b[1] = {5};
    int result[1];

    int clCtx = CLContextCreate(CL_USE_GPU_ONLY);
    int clPrg = CLProgramCreate(clCtx, clSrc);
    int clKrn = CLKernelCreate(clPrg, "sum");

    int clMemA = CLBufferCreate(clCtx, ArraySize(a) * sizeof(int), CL_MEM_READ_ONLY);
    int clMemB = CLBufferCreate(clCtx, ArraySize(b) * sizeof(int), CL_MEM_READ_ONLY);
    int clMemResult = CLBufferCreate(clCtx, ArraySize(result) * sizeof(int), CL_MEM_WRITE_ONLY);

    CLBufferWrite(clMemA, a);
    CLBufferWrite(clMemB, b);

    CLSetKernelArgMem(clKrn, 0, clMemA);
    CLSetKernelArgMem(clKrn, 1, clMemB);
    CLSetKernelArgMem(clKrn, 2, clMemResult);

    const uint offs[1] = {0};
    const uint works[1] = {ArraySize(result)};
    bool ex = CLExecute(clKrn, 1, offs, works);
    Print("CL program executed: ", ex);

    CLBufferRead(clMemResult, result);
    Print("Result: ", result[0]);

    CLBufferFree(clMemA);
    CLBufferFree(clMemB);
    CLBufferFree(clMemResult);
    CLKernelFree(clKrn);
    CLProgramFree(clPrg);
    CLContextFree(clCtx);
    
   
}

void OnStart()
{
uint st=GetTickCount();

    Print("Suma con OpenCL:");
    SumWithOpenCL();
    double gone=(GetTickCount()-st)/1000.;
    Print("tiempo de eject:",gone);//0,11 sec
}
*/
/*
double st = GetTickCount();
void OnStart()
{

uint st=GetTickCount();

int a=2,b=2,r;

r = a+b;
Print("resultado 2+2 es ",r);

double gone=(GetTickCount()-st)/1000.;
    Print("tiempo de eject:",gone);
    Print("tiempo tick count:",GetTickCount());//0,0
}
*/

//bueno hoy viste como es, en teoria esto sirve para calcular simulatanemanete calcuos complejos en el gpu a 
//fin de mejorar el rendimiento del algoritmo, ni siquiera la biblioteca de pyton de esto es facil, es mas parece mas dificil asi que ya viste.