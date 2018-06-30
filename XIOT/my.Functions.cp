#line 1 "E:/XIOT/final.fri/my.Functions.c"
#line 1 "e:/xiot/final.fri/my.functions.h"







static int Interrupt_On_Change_Flag =0 ;
int PrintFlag=1;
unsigned long counter_3second=0;
unsigned int adc_value;
float TempC;
char TempC_text[15];
char Led_state[15] ;
char Switch_state[30] ;
void get_temp(void);
void Print(void);
void LedControlFunction(void);
#line 1 "e:/xiot/final.fri/common.h"




typedef unsigned short uint8_t;
typedef signed short int8_t ;
typedef unsigned int uint16_t;
typedef signed int int16_t;
typedef unsigned long uint32_t;
typedef signed long int32_t;


typedef enum{FALSE,TRUE} bool_T;
typedef enum{LOW,HIGH} state_T;
typedef enum{IN,OUT,IN_pull_up} dir_T;
typedef enum{PRESSED,REALISED} Switch_T;

typedef struct RIPO{
 uint8_t *DDR;
 uint8_t *PORT;
 uint8_t *PIN;
 uint8_t start_p;
 uint8_t end_p;
}REG_t;




uint8_t port_index(uint8_t );
void pin_mode(uint8_t ,dir_T );
void digital_write(uint8_t ,state_T );
bool_T digital_read(uint8_t );
#line 1 "e:/xiot/final.fri/timer.h"



void Init_TMR0(void);
void Reset_TMR0(void);
char Get_TMR0F(void);
#line 4 "E:/XIOT/final.fri/my.Functions.c"
void get_temp()
 {
 adc_value = ADC_Read(0);
 TempC = adc_value * 2.2;
 TempC = TempC / 1024;
 TempC = TempC * 100;
 floattostr(TempC,TempC_text);
 ltrim(TempC_text);
 }



 void Print()
 {
 get_temp();
 if (digital_read ( 24 ) == True ) strncpy(Led_state, "LED id ON", 15);
 if (digital_read ( 24 ) == FALSE ) strncpy(Led_state , "LED id OFF", 15);
 if ( digital_read (  8  ) == TRUE ) strncpy(Switch_state , "Switch is Released ", 30);
 if ( digital_read (  8  ) == FALSE ) strncpy(Switch_state , "Switch is Pressed" , 30);
 ltrim(Led_state);
 ltrim(Switch_state);
 ltrim(TempC_text);
 UART1_Write_Text (Led_state);
 UART1_Write_Text ("   ");
 UART1_Write_Text (Switch_state);
 UART1_Write_Text ("   ");
 uart1_write_text(TempC_text);
 uart1_write(10);
 uart1_write(13);

 }


void LedControlFunction()
 {
 digital_write ( 24 , HIGH);
 if (PrintFlag == 1 ) Print();
 PrintFlag = 0;
 delay_ms(250);
 digital_write ( 24 , LOW);
 intcon.intf=0;
 Interrupt_On_Change_Flag = 0;
 }
