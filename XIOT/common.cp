#line 1 "C:/Users/Khlood/Downloads/XIOT-Embedded-master/XIOT-Embedded-master/XIOT/common.c"
#line 1 "c:/users/khlood/downloads/xiot-embedded-master/xiot-embedded-master/xiot/common.h"




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
#line 2 "C:/Users/Khlood/Downloads/XIOT-Embedded-master/XIOT-Embedded-master/XIOT/common.c"
const REG_t GPIO_PINS[ 4 ] = {
 {&TRISA,&PORTA,0,0,8},
 {&TRISB,&PORTB,0 ,8,16},
 {&TRISC,&PORTC,0,16,24},
 {&TRISD,&PORTD,0,24,32}
 };

 uint8_t port_index(uint8_t pin_no){
 int8_t i;
 for(i=0;i< 4 ;i++){
 if(pin_no<GPIO_PINS[i].end_p){
 break;
 }
 }
 return i;
}
void pin_mode(uint8_t pin_no,dir_T direction){
 uint8_t index;
 index = port_index(pin_no);
 pin_no -= GPIO_PINS[index].start_p;
 if(direction == OUT){
  *GPIO_PINS[index].DDR &=~(1<<pin_no) ;
 }
 else{
  *GPIO_PINS[index].DDR |=(1<<pin_no) ;
 }
}

void digital_write(uint8_t pin_no,state_T value){
 uint8_t index;
 index = port_index(pin_no);
 pin_no -= GPIO_PINS[index].start_p;
 if(value == HIGH){
 *GPIO_PINS[index].PORT |= (1<<pin_no);
 }
 else{
 *GPIO_PINS[index].PORT &= ~(1<<pin_no);
 }

}

bool_T digital_read(uint8_t pin_no){

 uint8_t temp;
 uint8_t index;
 bool_T ret_val = False;
 index = port_index(pin_no);
 pin_no -= GPIO_PINS[index].start_p;
 temp = (*GPIO_PINS[index].PORT&(1<<pin_no)) >>pin_no;
 if (temp)
 {
 ret_val = True;
 }else
 {
 ret_val = False;
 }
 return ret_val;
}
