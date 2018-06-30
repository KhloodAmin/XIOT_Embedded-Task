
_get_temp:

;my.Functions.c,4 :: 		void get_temp()
;my.Functions.c,6 :: 		adc_value = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_value+0
	MOVF       R0+1, 0
	MOVWF      _adc_value+1
;my.Functions.c,7 :: 		TempC = adc_value * 2.2;
	CALL       _Word2Double+0
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      12
	MOVWF      R4+2
	MOVLW      128
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _TempC+0
	MOVF       R0+1, 0
	MOVWF      _TempC+1
	MOVF       R0+2, 0
	MOVWF      _TempC+2
	MOVF       R0+3, 0
	MOVWF      _TempC+3
;my.Functions.c,8 :: 		TempC = TempC / 1024;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      137
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _TempC+0
	MOVF       R0+1, 0
	MOVWF      _TempC+1
	MOVF       R0+2, 0
	MOVWF      _TempC+2
	MOVF       R0+3, 0
	MOVWF      _TempC+3
;my.Functions.c,9 :: 		TempC = TempC * 100;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _TempC+0
	MOVF       R0+1, 0
	MOVWF      _TempC+1
	MOVF       R0+2, 0
	MOVWF      _TempC+2
	MOVF       R0+3, 0
	MOVWF      _TempC+3
;my.Functions.c,10 :: 		floattostr(TempC,TempC_text);
	MOVF       R0+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       R0+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       R0+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       R0+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _TempC_text+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;my.Functions.c,11 :: 		ltrim(TempC_text);
	MOVLW      _TempC_text+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;my.Functions.c,12 :: 		}
L_end_get_temp:
	RETURN
; end of _get_temp

_Print:

;my.Functions.c,16 :: 		void Print()
;my.Functions.c,18 :: 		get_temp();
	CALL       _get_temp+0
;my.Functions.c,19 :: 		if (digital_read (LED) == True )  strncpy(Led_state, "LED id ON", 15);
	MOVLW      24
	MOVWF      FARG_digital_read+0
	CALL       _digital_read+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Print0
	MOVLW      _Led_state+0
	MOVWF      FARG_strncpy_to+0
	MOVLW      ?lstr1_my.Functions+0
	MOVWF      FARG_strncpy_from+0
	MOVLW      15
	MOVWF      FARG_strncpy_size+0
	MOVLW      0
	MOVWF      FARG_strncpy_size+1
	CALL       _strncpy+0
L_Print0:
;my.Functions.c,20 :: 		if (digital_read (LED) == FALSE )  strncpy(Led_state , "LED id OFF", 15);
	MOVLW      24
	MOVWF      FARG_digital_read+0
	CALL       _digital_read+0
	MOVF       R0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_Print1
	MOVLW      _Led_state+0
	MOVWF      FARG_strncpy_to+0
	MOVLW      ?lstr2_my.Functions+0
	MOVWF      FARG_strncpy_from+0
	MOVLW      15
	MOVWF      FARG_strncpy_size+0
	MOVLW      0
	MOVWF      FARG_strncpy_size+1
	CALL       _strncpy+0
L_Print1:
;my.Functions.c,21 :: 		if ( digital_read ( Switch )  == TRUE ) strncpy(Switch_state , "Switch is Released ", 30);
	MOVLW      8
	MOVWF      FARG_digital_read+0
	CALL       _digital_read+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Print2
	MOVLW      _Switch_state+0
	MOVWF      FARG_strncpy_to+0
	MOVLW      ?lstr3_my.Functions+0
	MOVWF      FARG_strncpy_from+0
	MOVLW      30
	MOVWF      FARG_strncpy_size+0
	MOVLW      0
	MOVWF      FARG_strncpy_size+1
	CALL       _strncpy+0
L_Print2:
;my.Functions.c,22 :: 		if ( digital_read ( Switch  )  == FALSE ) strncpy(Switch_state , "Switch is Pressed" , 30);
	MOVLW      8
	MOVWF      FARG_digital_read+0
	CALL       _digital_read+0
	MOVF       R0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_Print3
	MOVLW      _Switch_state+0
	MOVWF      FARG_strncpy_to+0
	MOVLW      ?lstr4_my.Functions+0
	MOVWF      FARG_strncpy_from+0
	MOVLW      30
	MOVWF      FARG_strncpy_size+0
	MOVLW      0
	MOVWF      FARG_strncpy_size+1
	CALL       _strncpy+0
L_Print3:
;my.Functions.c,23 :: 		ltrim(Led_state);
	MOVLW      _Led_state+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;my.Functions.c,24 :: 		ltrim(Switch_state);
	MOVLW      _Switch_state+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;my.Functions.c,25 :: 		ltrim(TempC_text);
	MOVLW      _TempC_text+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;my.Functions.c,26 :: 		UART1_Write_Text (Led_state);
	MOVLW      _Led_state+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;my.Functions.c,27 :: 		UART1_Write_Text ("   ");
	MOVLW      ?lstr5_my.Functions+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;my.Functions.c,28 :: 		UART1_Write_Text (Switch_state);
	MOVLW      _Switch_state+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;my.Functions.c,29 :: 		UART1_Write_Text ("   ");
	MOVLW      ?lstr6_my.Functions+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;my.Functions.c,30 :: 		uart1_write_text(TempC_text);
	MOVLW      _TempC_text+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;my.Functions.c,31 :: 		uart1_write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;my.Functions.c,32 :: 		uart1_write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;my.Functions.c,34 :: 		}
L_end_Print:
	RETURN
; end of _Print

_LedControlFunction:

;my.Functions.c,37 :: 		void LedControlFunction()
;my.Functions.c,39 :: 		digital_write (LED, HIGH);
	MOVLW      24
	MOVWF      FARG_digital_write+0
	MOVLW      1
	MOVWF      FARG_digital_write+0
	CALL       _digital_write+0
;my.Functions.c,40 :: 		if (PrintFlag == 1 ) Print();
	MOVLW      0
	XORWF      _PrintFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__LedControlFunction9
	MOVLW      1
	XORWF      _PrintFlag+0, 0
L__LedControlFunction9:
	BTFSS      STATUS+0, 2
	GOTO       L_LedControlFunction4
	CALL       _Print+0
L_LedControlFunction4:
;my.Functions.c,41 :: 		PrintFlag = 0;
	CLRF       _PrintFlag+0
	CLRF       _PrintFlag+1
;my.Functions.c,42 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_LedControlFunction5:
	DECFSZ     R13+0, 1
	GOTO       L_LedControlFunction5
	DECFSZ     R12+0, 1
	GOTO       L_LedControlFunction5
	DECFSZ     R11+0, 1
	GOTO       L_LedControlFunction5
	NOP
	NOP
;my.Functions.c,43 :: 		digital_write (LED, LOW);
	MOVLW      24
	MOVWF      FARG_digital_write+0
	CLRF       FARG_digital_write+0
	CALL       _digital_write+0
;my.Functions.c,44 :: 		intcon.intf=0;
	BCF        INTCON+0, 1
;my.Functions.c,45 :: 		Interrupt_On_Change_Flag = 0;
	CLRF       my.Functions_Interrupt_On_Change_Flag+0
	CLRF       my.Functions_Interrupt_On_Change_Flag+1
;my.Functions.c,46 :: 		}
L_end_LedControlFunction:
	RETURN
; end of _LedControlFunction
