#ifndef COMMON_H
#define COMMON_H

#define number_of_ports 4
typedef  unsigned short   uint8_t;
typedef  signed short     int8_t ;
typedef  unsigned int     uint16_t;
typedef  signed int       int16_t;
typedef  unsigned long    uint32_t;
typedef  signed long      int32_t;
#define MAKEOUTPUT(REG , PIN)  REG &=~(1<<PIN)
#define MAKEINPUT(REG , PIN)  REG |=(1<<PIN)
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


#endif // COMMON_H