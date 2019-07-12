;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*              MODIFICA��ES PARA USO COM 12F675                   *
;*                FEITAS PELO PROF. MARDSON                        *
;*                    FEVEREIRO DE 2016                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       NOME DO PROJETO                           *
;*                           CLIENTE                               *
;*         DESENVOLVIDO PELA MOSAICO ENGENHARIA E CONSULTORIA      *
;*   VERS�O: 1.0                           DATA: 17/06/03          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     DESCRI��O DO ARQUIVO                        *
;*-----------------------------------------------------------------*
;*   MODELO PARA O PIC 16f628a                                     *
;*   Comunica��o I2C com PIC16F628A(MODO SLAVE)                    *
;*   Edimar Bezerra da Silva Neto   Matricula 11409565             *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ARQUIVOS DE DEFINI��ES                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#INCLUDE <p16f628a.inc>	;ARQUIVO PADR�O MICROCHIP PARA 12F675

	__CONFIG _BODEN_OFF & _CP_OFF & _PWRTE_ON & _WDT_ON & _MCLRE_OFF & _INTRC_OSC_NOCLKOUT & _LVP_OFF

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    PAGINA��O DE MEM�RIA                         *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;DEFINI��O DE COMANDOS DE USU�RIO PARA ALTERA��O DA P�GINA DE MEM�RIA
#DEFINE	BANK0	BCF STATUS,RP0	;SETA BANK 0 DE MEM�RIA
#DEFINE	BANK1	BSF STATUS,RP0	;SETA BANK 1 DE MAM�RIA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                         VARI�VEIS                               *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DOS NOMES E ENDERE�OS DE TODAS AS VARI�VEIS UTILIZADAS 
; PELO SISTEMA

	CBLOCK	0x20	;ENDERE�O INICIAL DA MEM�RIA DE
					;USU�RIO
		W_TEMP		;REGISTRADORES TEMPOR�RIOS PARA USO
		STATUS_TEMP	;JUNTO �S INTERRUP��ES

		ADDRESS;
		COUNT;

	ENDC			;FIM DO BLOCO DE MEM�RIA
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                        FLAGS INTERNOS                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DE TODOS OS FLAGS UTILIZADOS PELO SISTEMA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                         CONSTANTES                              *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DE TODAS AS CONSTANTES UTILIZADAS PELO SISTEMA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           ENTRADAS                              *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DE TODOS OS PINOS QUE SER�O UTILIZADOS COMO ENTRADA
; RECOMENDAMOS TAMB�M COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           SA�DAS                                *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DE TODOS OS PINOS QUE SER�O UTILIZADOS COMO SA�DA
; RECOMENDAMOS TAMB�M COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       VETOR DE RESET                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	ORG	0x00			;ENDERE�O INICIAL DE PROCESSAMENTO
	GOTO	INICIO
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    IN�CIO DA INTERRUP��O                        *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; ENDERE�O DE DESVIO DAS INTERRUP��ES. A PRIMEIRA TAREFA � SALVAR OS
; VALORES DE "W" E "STATUS" PARA RECUPERA��O FUTURA

	ORG	0x04			;ENDERE�O INICIAL DA INTERRUP��O
	MOVWF	W_TEMP		;COPIA W PARA W_TEMP
	SWAPF	STATUS,W
	MOVWF	STATUS_TEMP	;COPIA STATUS PARA STATUS_TEMP

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    ROTINA DE INTERRUP��O                        *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; AQUI SER� ESCRITA AS ROTINAS DE RECONHECIMENTO E TRATAMENTO DAS
; INTERRUP��ES

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                 ROTINA DE SA�DA DA INTERRUP��O                  *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; OS VALORES DE "W" E "STATUS" DEVEM SER RECUPERADOS ANTES DE 
; RETORNAR DA INTERRUP��O

SAI_INT
	SWAPF	STATUS_TEMP,W
	MOVWF	STATUS		;MOVE STATUS_TEMP PARA STATUS
	SWAPF	W_TEMP,F
	SWAPF	W_TEMP,W	;MOVE W_TEMP PARA W
	RETFIE

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*	            	 ROTINAS E SUBROTINAS                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; CADA ROTINA OU SUBROTINA DEVE POSSUIR A DESCRI��O DE FUNCIONAMENTO
; E UM NOME COERENTE �S SUAS FUN��ES.

BORDASCL
	
	BTFSC	PORTA ,0    
	GOTO	$-1
	BTFSS	PORTA ,0
	GOTO	$-1
	RETURN


	

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1			;ALTERA PARA O BANCO 1
	MOVLW	B'00000011'	;CONFIGURA TODAS AS PORTAS DO GPIO (PINOS)
	MOVWF	TRISA		;COMO SA�DAS	
	MOVLW   B'00000000'
	MOVWF	TRISB		
	MOVLW	B'00000011'     ;16X250X25
	MOVWF	OPTION_REG 	;DEFINE OP��ES DE OPERA��O	
	MOVLW	B'00000000'
	MOVWF	INTCON		;DEFINE OP��ES DE INTERRUP��ES	
	BANK0			;RETORNA PARA O BANCO		
	MOVLW	B'00000111'
	MOVWF	CMCON		;DEFINE O MODO DE OPERA��O DO COMPARADOR ANAL�GICO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZA��O DAS VARI�VEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;Um LED deve indicar que o endere�o correto foi recebido, mantendo-o aceso pelo mesmo tempo do ACK em LOW = 100ms
;RA0 - SCL
;RA1 - SDA
;RB7 - LED
;Endere�o designado : 0x29
	
MAIN
	CLRF	ADDRESS	    	;endere�o a ser verificado
INICIALIZA			;Start bit 
	BTFSS	PORTA ,1
	GOTO	$-1
	BTFSC	PORTA ,1
	GOTO	$-1
	BTFSS	PORTA ,0
	GOTO	INICIALIZA
RECEBE				;Recebe byte do Master em cada bit separado
	CALL	BORDASCL	;Borda de subida scl
	BCF	ADDRESS , 6
	BTFSC	PORTA ,1	
	BSF	ADDRESS , 6 
	CALL	BORDASCL
	BCF	ADDRESS , 5
	BTFSC	PORTA ,1	
	BSF	ADDRESS , 5 
	CALL	BORDASCL
	BCF	ADDRESS , 4
	BTFSC	PORTA ,1	
	BSF	ADDRESS , 4 
	CALL	BORDASCL
	BCF	ADDRESS , 3
	BTFSC	PORTA ,1	
	BSF	ADDRESS , 3 
	CALL	BORDASCL
	BCF	ADDRESS , 2
	BTFSC	PORTA ,1	
	BSF	ADDRESS , 2 
	CALL	BORDASCL
	BCF	ADDRESS , 1
	BTFSC	PORTA ,1	
	BSF	ADDRESS , 1 
	CALL	BORDASCL
	BCF	ADDRESS , 0
	BTFSC	PORTA ,1	
	BSF	ADDRESS , 0
	CALL	BORDASCL	
	BCF	ADDRESS , 7 
	BTFSC	PORTA ,0    
	GOTO	$-1
	
ENDERECO			    ;Verifica se o endere�o correto foi recebido
	MOVLW	.41		    ;endere�o 0x29
	SUBWF	ADDRESS, W
	BTFSS	STATUS, Z	    ;Se for o endere�o manda o ack o acende o led
	GOTO	MAIN		    
ACK				    ;O bit ACK para o Master
	BANK1
	BCF	TRISA ,1	    ;Muda sda para saida
	BANK0
	BCF	PORTA ,1	    ;Envia o ack, com o sda em low
	
	CALL	BORDASCL	    ;Espera o scl estar em 1, para o Master ler o ack  
	
	BTFSC	PORTA ,0       
	GOTO	$-1
	
	BCF	PORTA ,0   
	BANK1		
	BCF	TRISA ,0	    ;Muda scl para saida
	BSF	TRISA ,1	    ;Volta sda para entrada
	BANK0
	BCF	PORTA ,0   	    
LED				    ;Liga Led por 100 ms(16x250x25)
	BSF	PORTB, 7	    
	MOVLW	.25
	MOVWF	COUNT
DELAY
	MOVLW	.5
	MOVWF	TMR0
	BTFSS	INTCON,2
	GOTO	$-1
	BCF	INTCON,2
	DECFSZ	COUNT
	GOTO	DELAY
	
	BCF	PORTB,7	    
	BANK1
	BSF	TRISA,0		    ;Volta scl como entrada
	BANK0
	GOTO	INICIALIZA
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END