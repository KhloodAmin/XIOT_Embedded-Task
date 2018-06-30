
_Init_TMR0:

;timer.c,2 :: 		void Init_TMR0()
;timer.c,4 :: 		OPTION_REG	 = 0x85;
	MOVLW      133
	MOVWF      OPTION_REG+0
;timer.c,5 :: 		TMR0		 = 99;
	MOVLW      99
	MOVWF      TMR0+0
;timer.c,6 :: 		INTCON	 = 0xA0;
	MOVLW      160
	MOVWF      INTCON+0
;timer.c,7 :: 		}
L_end_Init_TMR0:
	RETURN
; end of _Init_TMR0

_Reset_TMR0:

;timer.c,9 :: 		void Reset_TMR0()
;timer.c,11 :: 		TMR0IF_bit = 0;
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;timer.c,12 :: 		TMR0 = 99;
	MOVLW      99
	MOVWF      TMR0+0
;timer.c,13 :: 		}
L_end_Reset_TMR0:
	RETURN
; end of _Reset_TMR0

_Get_TMR0F:

;timer.c,15 :: 		char Get_TMR0F()
;timer.c,17 :: 		return  TMR0IF_bit;
	MOVLW      0
	BTFSC      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	MOVLW      1
	MOVWF      R0+0
;timer.c,18 :: 		}
L_end_Get_TMR0F:
	RETURN
; end of _Get_TMR0F
