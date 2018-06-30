#include "common.h"
const  REG_t GPIO_PINS[number_of_ports] = {
    {&TRISA,&PORTA,0,0,8},
    {&TRISB,&PORTB,0 ,8,16},
    {&TRISC,&PORTC,0,16,24},
    {&TRISD,&PORTD,0,24,32}
    };
    
    uint8_t port_index(uint8_t pin_no){
    int8_t i;
    for(i=0;i<number_of_ports;i++){
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
        MAKEOUTPUT(*GPIO_PINS[index].DDR , pin_no);
    }
    else{
        MAKEINPUT(*GPIO_PINS[index].DDR , pin_no);
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