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
;*   MODELO PARA O PIC 12F675                                      *
;*   Edimar Bezerra da Silva Neto   11409565			   *
;*   Medi��o de tens�o e indica��o em BCD			   *
;*								   *
;*                                                                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ARQUIVOS DE DEFINI��ES                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#INCLUDE <p12f675.inc>	;ARQUIVO PADR�O MICROCHIP PARA 12F675

	__CONFIG _BODEN_OFF & _CP_OFF & _PWRTE_ON & _WDT_OFF & _MCLRE_ON & _INTRC_OSC_NOCLKOUT

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
		
		;NOVAS VARI�VEIS

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

SUBROTINA1

	;CORPO DA ROTINA

	RETURN

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1				;ALTERA PARA O BANCO 1
	MOVLW	B'00000100' ;CONFIGURA TODAS AS PORTAS DO GPIO (PINOS)
	MOVWF	TRISIO		;COMO SA�DAS  
	MOVLW	B'00010100'
	MOVWF	ANSEL 		;DEFINE PORTAS COMO Digital I/O
	MOVLW	B'00000100'
	MOVWF	OPTION_REG	;DEFINE OP��ES DE OPERA��O
	MOVLW	B'00000000'
	MOVWF	INTCON		;DEFINE OP��ES DE INTERRUP��ES
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00001001'
	MOVWF	ADCON0
	MOVLW	B'00000111'
	MOVWF	CMCON		;DEFINE O MODO DE OPERA��O DO COMPARADOR ANAL�GICO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZA��O DAS VARI�VEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;FOI DEFINIDO QUE A CODIFICACAO DO BCD(b3 b2 b1 b0) SERA CONFIGURADO COMO 
;GP0 - b0
;GP1 - b1
;GP4 - b2
;GP5 - b3
MAIN

	BSF	ADCON0, 1		;INICIA  O CICLO DE CONVERSAO
	BTFSC	ADCON0, 1		;VERIFICA ATE CONCLUIR A CONVERSAO
	
	GOTO	$-1			;VOLTA PARA A LINHA ANTERIOR CASO A CONVERSAO NAO TERMINE
	
MENOR05					
	MOVLW	.26			;VERIFICA TENS�ES MENORES QUE 0.5V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRA��O ADRESH - WORK 
	BTFSC	STATUS , C		;VERIFICO NO CARRY SE O VALOR ENCONTRADO FOI MENOR E CONFIGURO GPIO 
	GOTO	ENTRE05E10		;CASO NAO SEJA VERIFICO SE ESTA ENTRE 0.5V E 1V	
	BCF	GPIO, 0			
	BCF	GPIO, 1
	BCF	GPIO, 4			
	BCF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 0(0000)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO
	
ENTRE05E10				;FORAM VERIFICADOS VALORES ABAIXO DE 0.5V
	MOVLW	.52			;AGORA VERIFICA TENS�ES MENORES QUE 1V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRA��O ADRESH - WORK
	BTFSC	STATUS , C		;VERIFICO NO CARRY SE O VALOR ENCONTRADO FOI MENOR E CONFIGURO GPIO 
	GOTO	ENTRE10E15		;CASO NAO SEJA VERIFICO SE ESTA ENTRE 1V E 1.5V
	BSF	GPIO, 0
	BCF	GPIO, 1
	BCF	GPIO, 4
	BCF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 1(0001)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO
	
ENTRE10E15				;FORAM VERIFICADOS VALORES ABAIXO DE 1V
	MOVLW	.77			;VERIFICA TENS�ES MENORES QUE 1.5V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRA��O ADRESH - WORK
	BTFSC	STATUS , C		;VERIFICO NO CARRY SE O VALOR ENCONTRADO FOI MENOR E CONFIGURO GPIO 
	GOTO	ENTRE15E20		;CASO NAO SEJA VERIFICO SE ESTA ENTRE 1.5V E 2V
	BCF	GPIO, 0
	BSF	GPIO, 1
	BCF	GPIO, 4
	BCF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 2(0010)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO
	
ENTRE15E20				;FORAM VERIFICADOS VALORES ABAIXO DE 1.5V
	MOVLW	.103			;VERIFICA TENS�ES MENORES QUE 2V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRA��O ADRESH - WORK
	BTFSC	STATUS , C		;VERIFICO NO CARRY SE O VALOR ENCONTRADO FOI MENOR E CONFIGURO GPIO 
	GOTO	ENTRE20E25		;CASO NAO SEJA VERIFICO SE ESTA ENTRE 2V E 2.5V
	BSF	GPIO, 0
	BSF	GPIO, 1
	BCF	GPIO, 4
	BCF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 3(0011)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO
	
ENTRE20E25				;FORAM VERIFICADOS VALORES ABAIXO DE 2V
	MOVLW	.129			;VERIFICA TENS�ES MENORES QUE 2.5V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRA��O ADRESH - WORK
	BTFSC	STATUS , C		;VERIFICO NO CARRY SE O VALOR ENCONTRADO FOI MENOR E CONFIGURO GPIO 
	GOTO	ENTRE25E30		;CASO NAO SEJA VERIFICO SE ESTA ENTRE 2.5V E 3V
	BCF	GPIO, 0
	BCF	GPIO, 1
	BSF	GPIO, 4
	BCF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 4(0100)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO
	
ENTRE25E30				;FORAM VERIFICADOS VALORES ABAIXO DE 2.5V
	MOVLW	.154			;VERIFICA TENS�ES MENORES QUE 3V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRA��O ADRESH - WORK
	BTFSC	STATUS , C		;VERIFICO NO CARRY SE O VALOR ENCONTRADO FOI MENOR E CONFIGURO GPIO 
	GOTO	ENTRE30E35		;CASO NAO SEJA VERIFICO SE ESTA ENTRE 3V E 3.5V
	BSF	GPIO, 0
	BCF	GPIO, 1
	BSF	GPIO, 4
	BCF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 5(0101)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO
	
ENTRE30E35				;FORAM VERIFICADOS VALORES ABAIXO DE 3V
	MOVLW	.180			;VERIFICA TENS�ES MENORES QUE 3.5V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRA��O ADRESH - WORK
	BTFSC	STATUS , C		;VERIFICO NO CARRY SE O VALOR ENCONTRADO FOI MENOR E CONFIGURO GPIO 
	GOTO	ENTRE35E40		;CASO NAO SEJA VERIFICO SE ESTA ENTRE 3.5V E 4V
	BCF	GPIO, 0
	BSF	GPIO, 1
	BSF	GPIO, 4
	BCF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 6(0110)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO
	
ENTRE35E40				;FORAM VERIFICADOS VALORES ABAIXO DE 3.5V
	MOVLW	.205			;VERIFICA TENS�ES MENORES QUE 4V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRA��O ADRESH - WORK
	BTFSC	STATUS , C		;VERIFICO NO CARRY SE O VALOR ENCONTRADO FOI MENOR E CONFIGURO GPIO 
	GOTO	ENTRE40E45		;CASO NAO SEJA VERIFICO SE ESTA ENTRE 4V E 4.5V
	BSF	GPIO, 0
	BSF	GPIO, 1
	BSF	GPIO, 4
	BCF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 7(0111)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO
	
ENTRE40E45				;FORAM VERIFICADOS VALORES ABAIXO DE 4V
	MOVLW	.231			;VERIFICA TENS�ES MENORES QUE 4.5V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRA��O ADRESH - WORK
	BTFSC	STATUS , C		;VERIFICO NO CARRY SE O VALOR ENCONTRADO FOI MENOR E CONFIGURO GPIO 
	GOTO	MAIOR45			;CASO NAO SEJA VERIFICO SE ESTA ENTRE 4.5V E 5V
	BCF	GPIO, 0
	BCF	GPIO, 1
	BCF	GPIO, 4
	BSF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 8(1000)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO
	
MAIOR45					;FORAM VERIFICADOS VALORES ABAIXO DE 4.5V
	BSF	GPIO, 0			;SERA USADO UMA TENSAO DE 0V A 5V
	BCF	GPIO, 1			;ENTAO OS PROXIMOS VALORES SERAO ENTRE 4.5V E 5V
	BCF	GPIO, 4			
	BSF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 9(1001)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO



;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END
