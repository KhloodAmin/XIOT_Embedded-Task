
_port_index:

;common.c,9 :: 		uint8_t port_index(uint8_t pin_no){
;common.c,11 :: 		for(i=0;i<number_of_ports;i++){
	CLRF       port_index_i_L0+0
L_port_index0:
	MOVLW      128
	XORWF      port_index_i_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      4
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_port_index1
;common.c,12 :: 		if(pin_no<GPIO_PINS[i].end_p){
	MOVLW      5
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       port_index_i_L0+0, 0
	MOVWF      R4+0
	MOVLW      0
	BTFSC      R4+0, 7
	MOVLW      255
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVLW      _GPIO_PINS+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_GPIO_PINS+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVLW      4
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R1+0
	MOVF       R1+0, 0
	SUBWF      FARG_port_index_pin_no+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_port_index3
;common.c,13 :: 		break;
	GOTO       L_port_index1
;common.c,14 :: 		}
L_port_index3:
;common.c,11 :: 		for(i=0;i<number_of_ports;i++){
	INCF       port_index_i_L0+0, 1
;common.c,15 :: 		}
	GOTO       L_port_index0
L_port_index1:
;common.c,16 :: 		return i;
	MOVF       port_index_i_L0+0, 0
	MOVWF      R0+0
;common.c,17 :: 		}
L_end_port_index:
	RETURN
; end of _port_index

_pin_mode:

;common.c,18 :: 		void pin_mode(uint8_t pin_no,dir_T direction){
;common.c,20 :: 		index = port_index(pin_no);
	MOVF       FARG_pin_mode_pin_no+0, 0
	MOVWF      FARG_port_index_pin_no+0
	CALL       _port_index+0
	MOVF       R0+0, 0
	MOVWF      pin_mode_index_L0+0
;common.c,21 :: 		pin_no -= GPIO_PINS[index].start_p;
	MOVLW      0
	MOVWF      R0+1
	MOVLW      5
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVLW      _GPIO_PINS+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_GPIO_PINS+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVLW      3
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	SUBWF      FARG_pin_mode_pin_no+0, 1
;common.c,22 :: 		if(direction == OUT){
	MOVF       FARG_pin_mode_direction+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_pin_mode4
;common.c,23 :: 		MAKEOUTPUT(*GPIO_PINS[index].DDR , pin_no);
	MOVLW      5
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       pin_mode_index_L0+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16x16_U+0
	MOVLW      _GPIO_PINS+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_GPIO_PINS+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R2+0
	MOVF       FARG_pin_mode_pin_no+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__pin_mode12:
	BTFSC      STATUS+0, 2
	GOTO       L__pin_mode13
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__pin_mode12
L__pin_mode13:
	COMF       R0+0, 1
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ANDWF      R0+0, 1
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;common.c,24 :: 		}
	GOTO       L_pin_mode5
L_pin_mode4:
;common.c,26 :: 		MAKEINPUT(*GPIO_PINS[index].DDR , pin_no);
	MOVLW      5
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       pin_mode_index_L0+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16x16_U+0
	MOVLW      _GPIO_PINS+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_GPIO_PINS+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R2+0
	MOVF       FARG_pin_mode_pin_no+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__pin_mode14:
	BTFSC      STATUS+0, 2
	GOTO       L__pin_mode15
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__pin_mode14
L__pin_mode15:
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	IORWF      R0+0, 1
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;common.c,27 :: 		}
L_pin_mode5:
;common.c,28 :: 		}
L_end_pin_mode:
	RETURN
; end of _pin_mode

_digital_write:

;common.c,30 :: 		void digital_write(uint8_t pin_no,state_T value){
;common.c,32 :: 		index = port_index(pin_no);
	MOVF       FARG_digital_write_pin_no+0, 0
	MOVWF      FARG_port_index_pin_no+0
	CALL       _port_index+0
	MOVF       R0+0, 0
	MOVWF      digital_write_index_L0+0
;common.c,33 :: 		pin_no -= GPIO_PINS[index].start_p;
	MOVLW      0
	MOVWF      R0+1
	MOVLW      5
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVLW      _GPIO_PINS+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_GPIO_PINS+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVLW      3
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	SUBWF      FARG_digital_write_pin_no+0, 1
;common.c,34 :: 		if(value == HIGH){
	MOVF       FARG_digital_write_value+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_digital_write6
;common.c,35 :: 		*GPIO_PINS[index].PORT |= (1<<pin_no);
	MOVLW      5
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       digital_write_index_L0+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16x16_U+0
	MOVLW      _GPIO_PINS+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_GPIO_PINS+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R2+0
	MOVF       FARG_digital_write_pin_no+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__digital_write17:
	BTFSC      STATUS+0, 2
	GOTO       L__digital_write18
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__digital_write17
L__digital_write18:
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	IORWF      R0+0, 1
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;common.c,36 :: 		}
	GOTO       L_digital_write7
L_digital_write6:
;common.c,38 :: 		*GPIO_PINS[index].PORT &= ~(1<<pin_no);
	MOVLW      5
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       digital_write_index_L0+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16x16_U+0
	MOVLW      _GPIO_PINS+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_GPIO_PINS+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R2+0
	MOVF       FARG_digital_write_pin_no+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__digital_write19:
	BTFSC      STATUS+0, 2
	GOTO       L__digital_write20
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__digital_write19
L__digital_write20:
	COMF       R0+0, 1
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ANDWF      R0+0, 1
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;common.c,39 :: 		}
L_digital_write7:
;common.c,41 :: 		}
L_end_digital_write:
	RETURN
; end of _digital_write

_digital_read:

;common.c,43 :: 		bool_T digital_read(uint8_t pin_no){
;common.c,47 :: 		bool_T ret_val = False;
	CLRF       digital_read_ret_val_L0+0
;common.c,48 :: 		index = port_index(pin_no);
	MOVF       FARG_digital_read_pin_no+0, 0
	MOVWF      FARG_port_index_pin_no+0
	CALL       _port_index+0
	MOVF       R0+0, 0
	MOVWF      digital_read_index_L0+0
;common.c,49 :: 		pin_no -= GPIO_PINS[index].start_p;
	MOVLW      0
	MOVWF      R0+1
	MOVLW      5
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVLW      _GPIO_PINS+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_GPIO_PINS+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVLW      3
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	SUBWF      FARG_digital_read_pin_no+0, 1
;common.c,50 :: 		temp = (*GPIO_PINS[index].PORT&(1<<pin_no)) >>pin_no;
	MOVLW      5
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       digital_read_index_L0+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16x16_U+0
	MOVLW      _GPIO_PINS+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_GPIO_PINS+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R3+0
	MOVF       FARG_digital_read_pin_no+0, 0
	MOVWF      R2+0
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__digital_read22:
	BTFSC      STATUS+0, 2
	GOTO       L__digital_read23
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__digital_read22
L__digital_read23:
	MOVF       R3+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	ANDWF      INDF+0, 0
	MOVWF      R3+0
	MOVLW      0
	ANDWF      R0+1, 0
	MOVWF      R3+1
	MOVF       FARG_digital_read_pin_no+0, 0
	MOVWF      R2+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__digital_read24:
	BTFSC      STATUS+0, 2
	GOTO       L__digital_read25
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	ADDLW      255
	GOTO       L__digital_read24
L__digital_read25:
;common.c,51 :: 		if (temp)
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_digital_read8
;common.c,53 :: 		ret_val = True;
	MOVLW      1
	MOVWF      digital_read_ret_val_L0+0
;common.c,54 :: 		}else
	GOTO       L_digital_read9
L_digital_read8:
;common.c,56 :: 		ret_val = False;
	CLRF       digital_read_ret_val_L0+0
;common.c,57 :: 		}
L_digital_read9:
;common.c,58 :: 		return ret_val;
	MOVF       digital_read_ret_val_L0+0, 0
	MOVWF      R0+0
;common.c,59 :: 		}
L_end_digital_read:
	RETURN
; end of _digital_read

common____?ag:

L_end_common___?ag:
	RETURN
; end of common____?ag
