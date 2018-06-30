#include"timer.h"
void Init_TMR0()
{
  OPTION_REG	 = 0x85;
  TMR0		 = 99;
  INTCON	 = 0xA0;
}

void Reset_TMR0()
{
        TMR0IF_bit = 0;
        TMR0 = 99;
}

char Get_TMR0F()
{
    return  TMR0IF_bit;
}