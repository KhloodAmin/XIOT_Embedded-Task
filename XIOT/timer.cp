#line 1 "C:/Users/Khlood/Downloads/XIOT-Embedded-master/XIOT-Embedded-master/XIOT/timer.c"
#line 1 "c:/users/khlood/downloads/xiot-embedded-master/xiot-embedded-master/xiot/timer.h"



void Init_TMR0(void);
void Reset_TMR0(void);
char Get_TMR0F(void);
#line 2 "C:/Users/Khlood/Downloads/XIOT-Embedded-master/XIOT-Embedded-master/XIOT/timer.c"
void Init_TMR0()
{
 OPTION_REG = 0x85;
 TMR0 = 99;
 INTCON = 0xA0;
}

void Reset_TMR0()
{
 TMR0IF_bit = 0;
 TMR0 = 99;
}

char Get_TMR0F()
{
 return TMR0IF_bit;
}
