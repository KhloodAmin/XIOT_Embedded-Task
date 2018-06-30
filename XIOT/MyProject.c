#include "common.h"
#include "timer.h"
#define LED 24
#define Switch 8
#define Enter_Critical_Section_Area intcon.gie=0
#define Exit_Critical_Section_Area intcon.gie=1
static int Interrupt_On_Change_Flag =0 ;
int PrintFlag=1;
unsigned long  counter_3second=0;
unsigned int adc_value;
float TempC;
char TempC_text[15];
char Led_state[15]  ;
char Switch_state[30] ;
void get_temp(void );
void Print(void);
void LedControlFunction (void);




 void Interrupt()
  {
     if(intcon.intf==1)   Interrupt_On_Change_Flag = 1;
     if(Get_TMR0F())
       {
        Reset_TMR0() ;
        counter_3second++;
       }
  }
  
 void main ()
  {
     Init_TMR0();
     pin_mode(LED , OUT );
     digital_write(LED,LOW);
     pin_mode (0,IN);
     ADC_Init();
     ADCON1 = 0b00000101;
     UART1_Init(9600);

     for(;;)
      {
        if (Interrupt_On_Change_Flag == 1 )
          {
            Enter_Critical_Section_Area   ;
            LedControlFunction();
            Exit_Critical_Section_Area ;
          }
    
        if ( counter_3second == 300)
          {
            Enter_Critical_Section_Area ;
            Print();
           counter_3second=0;
           Exit_Critical_Section_Area ;
         }
     }

   }
   

 void get_temp()
   {
      adc_value = ADC_Read(0);
      TempC = adc_value * 2.2;
      TempC = TempC / 1024;
      TempC = TempC * 100;
      floattostr(TempC,TempC_text);
   }



 void Print()
   {
      get_temp();
      if (digital_read (LED) == True )  strncpy(Led_state, "LED id ON", 15);
      if (digital_read (LED) == FALSE )  strncpy(Led_state , "LED id OFF", 15);
      if ( digital_read ( Switch )  == TRUE ) strncpy(Switch_state , "Switch is Released ", 30);
      if ( digital_read ( Switch  )  == FALSE ) strncpy(Switch_state , "Switch is Pressed" , 30);
      ltrim(Led_state);
      ltrim(Switch_state);
      ltrim(TempC_text);
      UART1_Write_Text (Led_state);
      UART1_Write_Text ("   ");
      UART1_Write_Text (Switch_state);
      UART1_Write_Text ("   ");
      UART1_Write_Text (TempC_text);
      UART1_Write(10);
      UART1_Write(13);

   }


 void LedControlFunction()
   {
        digital_write (LED, HIGH);
        if (PrintFlag == 1 ) Print();
        PrintFlag = 0;
        delay_ms(250);
        digital_write (LED, LOW);
        intcon.intf=0;
        Interrupt_On_Change_Flag = 0;
    }