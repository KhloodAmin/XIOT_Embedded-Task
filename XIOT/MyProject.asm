
_Interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,22 :: 		void Interrupt()
;MyProject.c,24 :: 		if(intcon.intf==1)   Interrupt_On_Change_Flag = 1;
	BTFSS      INTCON+0, 1
	GOTO       L_Interrupt0
	MOVLW      1
	MOVWF      MyProject_Interrupt_On_Change_Flag+0
	MOVLW      0
	MOVWF      MyProject_Interrupt_On_Change_Flag+1
L_Interrupt0:
;MyProject.c,25 :: 		if(Get_TMR0F())
	CALL       _Get_TMR0F+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_Interrupt1
;MyProject.c,27 :: 		Reset_TMR0() ;
	CALL       _Reset_TMR0+0
;MyProject.c,28 :: 		counter_3second++;
	MOVF       _counter_3second+0, 0
	MOVWF      R0+0
	MOVF       _counter_3second+1, 0
	MOVWF      R0+1
	MOVF       _counter_3second+2, 0
	MOVWF      R0+2
	MOVF       _counter_3second+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      _counter_3second+0
	MOVF       R0+1, 0
	MOVWF      _counter_3second+1
	MOVF       R0+2, 0
	MOVWF      _counter_3second+2
	MOVF       R0+3, 0
	MOVWF      _counter_3second+3
;MyProject.c,29 :: 		}
L_Interrupt1:
;MyProject.c,30 :: 		}
L_end_Interrupt:
L__Interrupt14:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _Interrupt

_main:

;MyProject.c,32 :: 		void main ()
;MyProject.c,34 :: 		Init_TMR0();
	CALL       _Init_TMR0+0
;MyProject.c,35 :: 		pin_mode(LED , OUT );
	MOVLW      24
	MOVWF      FARG_pin_mode+0
	MOVLW      1
	MOVWF      FARG_pin_mode+0
	CALL       _pin_mode+0
;MyProject.c,36 :: 		digital_write(LED,LOW);
	MOVLW      24
	MOVWF      FARG_digital_write+0
	CLRF       FARG_digital_write+0
	CALL       _digital_write+0
;MyProject.c,37 :: 		pin_mode (0,IN);
	CLRF       FARG_pin_mode+0
	CLRF       FARG_pin_mode+0
	CALL       _pin_mode+0
;MyProject.c,38 :: 		ADC_Init();
	CALL       _ADC_Init+0
;MyProject.c,39 :: 		ADCON1 = 0b00000101;
	MOVLW      5
	MOVWF      ADCON1+0
;MyProject.c,40 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;MyProject.c,42 :: 		for(;;)
L_main2:
;MyProject.c,44 :: 		if (Interrupt_On_Change_Flag == 1 )
	MOVLW      0
	XORWF      MyProject_Interrupt_On_Change_Flag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main16
	MOVLW      1
	XORWF      MyProject_Interrupt_On_Change_Flag+0, 0
L__main16:
	BTFSS      STATUS+0, 2
	GOTO       L_main5
;MyProject.c,46 :: 		Enter_Critical_Section_Area   ;
	BCF        INTCON+0, 7
;MyProject.c,47 :: 		LedControlFunction();
	CALL       _LedControlFunction+0
;MyProject.c,48 :: 		Exit_Critical_Section_Area ;
	BSF        INTCON+0, 7
;MyProject.c,49 :: 		}
L_main5:
;MyProject.c,51 :: 		if ( counter_3second == 300)
	MOVLW      0
	MOVWF      R0+0
	XORWF      _counter_3second+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main17
	MOVF       R0+0, 0
	XORWF      _counter_3second+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main17
	MOVLW      1
	XORWF      _counter_3second+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main17
	MOVF       _counter_3second+0, 0
	XORLW      44
L__main17:
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;MyProject.c,53 :: 		Enter_Critical_Section_Area ;
	BCF        INTCON+0, 7
;MyProject.c,54 :: 		Print();
	CALL       _Print+0
;MyProject.c,55 :: 		counter_3second=0;
	CLRF       _counter_3second+0
	CLRF       _counter_3second+1
	CLRF       _counter_3second+2
	CLRF       _counter_3second+3
;MyProject.c,56 :: 		Exit_Critical_Section_Area ;
	BSF        INTCON+0, 7
;MyProject.c,57 :: 		}
L_main6:
;MyProject.c,58 :: 		}
	GOTO       L_main2
;MyProject.c,60 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_get_temp:

;MyProject.c,63 :: 		void get_temp()
;MyProject.c,65 :: 		adc_value = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_value+0
	MOVF       R0+1, 0
	MOVWF      _adc_value+1
;MyProject.c,66 :: 		TempC = adc_value * 2.2;
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
;MyProject.c,67 :: 		TempC = TempC / 1024;
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
;MyProject.c,68 :: 		TempC = TempC * 100;
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
;MyProject.c,69 :: 		floattostr(TempC,TempC_text);
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
;MyProject.c,70 :: 		}
L_end_get_temp:
	RETURN
; end of _get_temp

_Print:

;MyProject.c,74 :: 		void Print()
;MyProject.c,76 :: 		get_temp();
	CALL       _get_temp+0
;MyProject.c,77 :: 		if (digital_read (LED) == True )  strncpy(Led_state, "LED id ON", 15);
	MOVLW      24
	MOVWF      FARG_digital_read+0
	CALL       _digital_read+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Print7
	MOVLW      _Led_state+0
	MOVWF      FARG_strncpy_to+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_strncpy_from+0
	MOVLW      15
	MOVWF      FARG_strncpy_size+0
	MOVLW      0
	MOVWF      FARG_strncpy_size+1
	CALL       _strncpy+0
L_Print7:
;MyProject.c,78 :: 		if (digital_read (LED) == FALSE )  strncpy(Led_state , "LED id OFF", 15);
	MOVLW      24
	MOVWF      FARG_digital_read+0
	CALL       _digital_read+0
	MOVF       R0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_Print8
	MOVLW      _Led_state+0
	MOVWF      FARG_strncpy_to+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_strncpy_from+0
	MOVLW      15
	MOVWF      FARG_strncpy_size+0
	MOVLW      0
	MOVWF      FARG_strncpy_size+1
	CALL       _strncpy+0
L_Print8:
;MyProject.c,79 :: 		if ( digital_read ( Switch )  == TRUE ) strncpy(Switch_state , "Switch is Released ", 30);
	MOVLW      8
	MOVWF      FARG_digital_read+0
	CALL       _digital_read+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Print9
	MOVLW      _Switch_state+0
	MOVWF      FARG_strncpy_to+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_strncpy_from+0
	MOVLW      30
	MOVWF      FARG_strncpy_size+0
	MOVLW      0
	MOVWF      FARG_strncpy_size+1
	CALL       _strncpy+0
L_Print9:
;MyProject.c,80 :: 		if ( digital_read ( Switch  )  == FALSE ) strncpy(Switch_state , "Switch is Pressed" , 30);
	MOVLW      8
	MOVWF      FARG_digital_read+0
	CALL       _digital_read+0
	MOVF       R0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_Print10
	MOVLW      _Switch_state+0
	MOVWF      FARG_strncpy_to+0
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_strncpy_from+0
	MOVLW      30
	MOVWF      FARG_strncpy_size+0
	MOVLW      0
	MOVWF      FARG_strncpy_size+1
	CALL       _strncpy+0
L_Print10:
;MyProject.c,81 :: 		ltrim(Led_state);
	MOVLW      _Led_state+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;MyProject.c,82 :: 		ltrim(Switch_state);
	MOVLW      _Switch_state+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;MyProject.c,83 :: 		ltrim(TempC_text);
	MOVLW      _TempC_text+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;MyProject.c,84 :: 		UART1_Write_Text (Led_state);
	MOVLW      _Led_state+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,85 :: 		UART1_Write_Text ("   ");
	MOVLW      ?lstr5_MyProject+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,86 :: 		UART1_Write_Text (Switch_state);
	MOVLW      _Switch_state+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,87 :: 		UART1_Write_Text ("   ");
	MOVLW      ?lstr6_MyProject+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,88 :: 		UART1_Write_Text (TempC_text);
	MOVLW      _TempC_text+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,89 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;MyProject.c,90 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;MyProject.c,92 :: 		}
L_end_Print:
	RETURN
; end of _Print

_LedControlFunction:

;MyProject.c,95 :: 		void LedControlFunction()
;MyProject.c,97 :: 		digital_write (LED, HIGH);
	MOVLW      24
	MOVWF      FARG_digital_write+0
	MOVLW      1
	MOVWF      FARG_digital_write+0
	CALL       _digital_write+0
;MyProject.c,98 :: 		if (PrintFlag == 1 ) Print();
	MOVLW      0
	XORWF      _PrintFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__LedControlFunction21
	MOVLW      1
	XORWF      _PrintFlag+0, 0
L__LedControlFunction21:
	BTFSS      STATUS+0, 2
	GOTO       L_LedControlFunction11
	CALL       _Print+0
L_LedControlFunction11:
;MyProject.c,99 :: 		PrintFlag = 0;
	CLRF       _PrintFlag+0
	CLRF       _PrintFlag+1
;MyProject.c,100 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_LedControlFunction12:
	DECFSZ     R13+0, 1
	GOTO       L_LedControlFunction12
	DECFSZ     R12+0, 1
	GOTO       L_LedControlFunction12
	DECFSZ     R11+0, 1
	GOTO       L_LedControlFunction12
	NOP
	NOP
;MyProject.c,101 :: 		digital_write (LED, LOW);
	MOVLW      24
	MOVWF      FARG_digital_write+0
	CLRF       FARG_digital_write+0
	CALL       _digital_write+0
;MyProject.c,102 :: 		intcon.intf=0;
	BCF        INTCON+0, 1
;MyProject.c,103 :: 		Interrupt_On_Change_Flag = 0;
	CLRF       MyProject_Interrupt_On_Change_Flag+0
	CLRF       MyProject_Interrupt_On_Change_Flag+1
;MyProject.c,104 :: 		}
L_end_LedControlFunction:
	RETURN
; end of _LedControlFunction
