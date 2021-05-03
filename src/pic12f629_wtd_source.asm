
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;pic12f629_wtd_source.c,12 :: 		void interrupt()
;pic12f629_wtd_source.c,14 :: 		if(INTF_bit)                               //Houve interrupção externa?
	BTFSS      INTF_bit+0, 1
	GOTO       L_interrupt0
;pic12f629_wtd_source.c,16 :: 		INTF_bit = 0x00;                       //limpa flag
	BCF        INTF_bit+0, 1
;pic12f629_wtd_source.c,17 :: 		wtd_counter = 0x00;                    //reinicia wtd_counter
	CLRF       _wtd_counter+0
	CLRF       _wtd_counter+1
;pic12f629_wtd_source.c,18 :: 		GP4_bit = 0x01;                        //Seta GP4 (para MCUs com reset em LOW)
	BSF        GP4_bit+0, 4
;pic12f629_wtd_source.c,19 :: 		GP5_bit = 0x00;                        //Limpa GP5 (para MCUs com reset em HIGH)
	BCF        GP5_bit+0, 5
;pic12f629_wtd_source.c,22 :: 		} //end INTF_bit
L_interrupt0:
;pic12f629_wtd_source.c,25 :: 		} //end interrupt
L__interrupt5:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;pic12f629_wtd_source.c,30 :: 		void main()
;pic12f629_wtd_source.c,32 :: 		CMCON      = 0x07;                         //Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;pic12f629_wtd_source.c,33 :: 		INTCON     = 0x90;                         //Habilita interrupção global
	MOVLW      144
	MOVWF      INTCON+0
;pic12f629_wtd_source.c,36 :: 		TRISIO     = 0x0F;                         //Configura GP4 e GP5 como saída
	MOVLW      15
	MOVWF      TRISIO+0
;pic12f629_wtd_source.c,37 :: 		GPIO       = 0x0F;                         //Inicializa GPIO
	MOVLW      15
	MOVWF      GPIO+0
;pic12f629_wtd_source.c,39 :: 		while(1)                                   //Loop Infinito
L_main1:
;pic12f629_wtd_source.c,41 :: 		wtd_counter++;
	INCF       _wtd_counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _wtd_counter+1, 1
;pic12f629_wtd_source.c,42 :: 		delay_ms(1);
	MOVLW      2
	MOVWF      R12+0
	MOVLW      75
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
;pic12f629_wtd_source.c,44 :: 		if(wtd_counter == 60)
	MOVLW      0
	XORWF      _wtd_counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main6
	MOVLW      60
	XORWF      _wtd_counter+0, 0
L__main6:
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;pic12f629_wtd_source.c,46 :: 		wtd_counter = 0x00;
	CLRF       _wtd_counter+0
	CLRF       _wtd_counter+1
;pic12f629_wtd_source.c,47 :: 		GP4_bit = ~GP4_bit;
	MOVLW      16
	XORWF      GP4_bit+0, 1
;pic12f629_wtd_source.c,48 :: 		GP5_bit = ~GP5_bit;
	MOVLW      32
	XORWF      GP5_bit+0, 1
;pic12f629_wtd_source.c,50 :: 		} //end if
L_main4:
;pic12f629_wtd_source.c,52 :: 		} //end while
	GOTO       L_main1
;pic12f629_wtd_source.c,54 :: 		} //end main
	GOTO       $+0
; end of _main
