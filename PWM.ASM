;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*              MODIFICAÇÕES PARA USO COM 12F675                   *
;*                FEITAS PELO PROF. MARDSON                        *
;*                    FEVEREIRO DE 2016                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       NOME DO PROJETO                           *
;*                           CLIENTE                               *
;*         DESENVOLVIDO PELA MOSAICO ENGENHARIA E CONSULTORIA      *
;*   VERSÃO: 1.0                           DATA: 17/06/03          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     DESCRIÇÃO DO ARQUIVO                        *
;*-----------------------------------------------------------------*
;*   MODELO PARA O PIC 12F675                                      *
;*   Controlador de LED RGB                                        *
;*   Edimar Bezerra da Silva Neto 11409565                         *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ARQUIVOS DE DEFINIÇÕES                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#INCLUDE <p12f675.inc>	;ARQUIVO PADRÃO MICROCHIP PARA 12F675

	__CONFIG _BODEN_OFF & _CP_OFF & _PWRTE_ON & _WDT_OFF & _MCLRE_ON & _INTRC_OSC_NOCLKOUT

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    PAGINAÇÃO DE MEMÓRIA                         *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;DEFINIÇÃO DE COMANDOS DE USUÁRIO PARA ALTERAÇÃO DA PÁGINA DE MEMÓRIA
#DEFINE	BANK0	BCF STATUS,RP0	;SETA BANK 0 DE MEMÓRIA
#DEFINE	BANK1	BSF STATUS,RP0	;SETA BANK 1 DE MAMÓRIA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                         VARIÁVEIS                               *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DOS NOMES E ENDEREÇOS DE TODAS AS VARIÁVEIS UTILIZADAS 
; PELO SISTEMA

	CBLOCK	0x20	;ENDEREÇO INICIAL DA MEMÓRIA DE
					;USUÁRIO
		W_TEMP		;REGISTRADORES TEMPORÁRIOS PARA USO
		STATUS_TEMP	;JUNTO ÀS INTERRUPÇÕES
		CHAVE
		LEDR
		LEDB
		LEDG
		;NOVAS VARIÁVEIS

	ENDC			;FIM DO BLOCO DE MEMÓRIA
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                        FLAGS INTERNOS                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODOS OS FLAGS UTILIZADOS PELO SISTEMA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                         CONSTANTES                              *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODAS AS CONSTANTES UTILIZADAS PELO SISTEMA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           ENTRADAS                              *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODOS OS PINOS QUE SERÃO UTILIZADOS COMO ENTRADA
; RECOMENDAMOS TAMBÉM COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           SAÍDAS                                *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODOS OS PINOS QUE SERÃO UTILIZADOS COMO SAÍDA
; RECOMENDAMOS TAMBÉM COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       VETOR DE RESET                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	ORG	0x00			;ENDEREÇO INICIAL DE PROCESSAMENTO
	GOTO	INICIO
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    INÍCIO DA INTERRUPÇÃO                        *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; ENDEREÇO DE DESVIO DAS INTERRUPÇÕES. A PRIMEIRA TAREFA É SALVAR OS
; VALORES DE "W" E "STATUS" PARA RECUPERAÇÃO FUTURA

	ORG	0x04			;ENDEREÇO INICIAL DA INTERRUPÇÃO
	MOVWF	W_TEMP		;COPIA W PARA W_TEMP
	SWAPF	STATUS,W
	MOVWF	STATUS_TEMP	;COPIA STATUS PARA STATUS_TEMP

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    ROTINA DE INTERRUPÇÃO                        *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; AQUI SERÁ ESCRITA AS ROTINAS DE RECONHECIMENTO E TRATAMENTO DAS
; INTERRUPÇÕES

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                 ROTINA DE SAÍDA DA INTERRUPÇÃO                  *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; OS VALORES DE "W" E "STATUS" DEVEM SER RECUPERADOS ANTES DE 
; RETORNAR DA INTERRUPÇÃO

SAI_INT
	SWAPF	STATUS_TEMP,W
	MOVWF	STATUS		;MOVE STATUS_TEMP PARA STATUS
	SWAPF	W_TEMP,F
	SWAPF	W_TEMP,W	;MOVE W_TEMP PARA W
	RETFIE

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*	            	 ROTINAS E SUBROTINAS                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; CADA ROTINA OU SUBROTINA DEVE POSSUIR A DESCRIÇÃO DE FUNCIONAMENTO
; E UM NOME COERENTE ÀS SUAS FUNÇÕES.

SUBROTINA1

	;CORPO DA ROTINA

	RETURN

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1				;ALTERA PARA O BANCO 1
	MOVLW	B'00111000' ;CONFIGURA TODAS AS PORTAS DO GPIO (PINOS)
	MOVWF	TRISIO		;COMO SAÍDAS
	MOVLW	B'00011000'
	MOVWF	ANSEL 		;DEFINE PORTAS COMO Digital I/O
	MOVLW	B'00000010'
	MOVWF	OPTION_REG	;DEFINE OPÇÕES DE OPERAÇÃO
	MOVLW	B'00000000'
	MOVWF	INTCON		;DEFINE OPÇÕES DE INTERRUPÇÕES
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00001101'
	MOVWF	ADCON0
	MOVLW	B'00000111'
	MOVWF	CMCON		;DEFINE O MODO DE OPERAÇÃO DO COMPARADOR ANALÓGICO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZAÇÃO DAS VARIÁVEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;FREQ 500HZ  T=2000us
;O PRESCALE ESCOLHIDO FOI DE 1:8 PARA ATINGIR NO MAXIMO T = 2048us
;ENTAO FOI FEITO O TMR0 DE 5 A 255

MAIN
	MOVLW	.0	    ;INICIALIZA CHAVE = 00
	MOVWF	CHAVE	   
	BSF	ADCON0, 1  ;Inicializa conversao
	BTFSC	ADCON0, 1
	GOTO	$-1
	
	
	
VALORCHAVE			;Calcula valor das chaves GP3 E GP5
	BTFSC	GPIO, 5		;GP3 = 0 e GP5 = 0  CHAVE = 0(00)
	INCF	CHAVE ,1	;GP3 = 0 e GP5 = 1  CHAVE = 1(01)
	BTFSS	GPIO, 3		;GP3 = 1 e GP5 = 0  CHAVE = 2(10)
	GOTO	DESLIGADO	;GP3 = 1 e GP5 = 1  CHAVE = 3(11)
	INCF	CHAVE ,1
	INCF	CHAVE ,1
DESLIGADO			;DESLIGA OS LEDS(GP0,GP1,GP2)
	MOVLW	 .0	    
	SUBWF	CHAVE,W
	BTFSS	STATUS, Z	;VERIFICA SE A CHAVE IGUAL A 00
	GOTO	RED		;SE NAO VERIFICA SE A CHAVE E IGUAL A 1(LED RED)
	BCF	GPIO,0
	BCF	GPIO,1		
	BCF	GPIO,2
	GOTO	MAIN
RED				;VERIFICA SE O LED SELECIONADO E O VERMELHO(GP0) ,CHAVE = 01
	MOVLW	 .1		
	SUBWF	CHAVE,W	     
	BTFSS	STATUS, Z
	GOTO	GREEN		;SE NAO VERIFICA SE A CHAVE E IGUAL A 2(LED GREEN)
	MOVFW	ADRESH
	MOVWF	LEDR		;GUARDA VALOR DO ADRESH
	GOTO	DUTYCYCLERED	;INICIA O CALCULO DO DUTYCYCLE RED
GREEN				;VERIFICA SE O LED SELECIONADO E O VERDE(GP1) ,CHAVE = 10
	MOVLW	 .2 
	SUBWF	CHAVE,W
	BTFSS	STATUS, Z
	GOTO	BLUE		;SE NAO VERIFICA SE A CHAVE E IGUAL A 3(LED GREEN)
	MOVFW	ADRESH
	MOVWF	LEDG		;GUARDA VALOR DO ADRESH
	GOTO	DUTYCYCLEGREEN	;INICIA O CALCULO DO DUTYCYCLE RED

BLUE				;VERIFICA SE O LED SELECIONADO E O AZUL(GP2) ,CHAVE = 11
	MOVLW	 .3
	SUBWF	CHAVE,W
	BTFSS	STATUS, Z	;SE NAO VERIFICA SE A CHAVE E IGUAL A 3(LED GREEN)
	GOTO	MAIN	
	MOVFW	ADRESH
	MOVWF	LEDB		;GUARDA VALOR DO ADRESH
	GOTO	DUTYCYCLEBLUE	;INICIA O CALCULO DO DUTYCYCLE BLUE
	
DUTYCYCLERED
	BSF	GPIO,0	    
	MOVLW	.0		;TMR0 DE 0 A 250 ALCANÇANDO T = 2000us
	MOVWF	TMR0		
	MOVFW	LEDR		;VALOR DO ADRESH GUARDADO QUANDO ESCOLHIDO O LED VERMELHO
	SUBWF	TMR0 ,W		;COMPARA O TMR0 ATE ATINGIR O VALOR DO ADRESH
	BTFSS	STATUS , Z	
	GOTO	$-3
	BCF	GPIO, 0		;DEPOIS COLOCANDO PARA O NIVEL BAIXO QUANDO DUTY CYCLE DIFERENTE DE 100%
	MOVLW	.250
	SUBWF	TMR0 , W
	BTFSS	STATUS, C	;DEPOIS FINALIZA QUANDO ATINGIR OS 2000us
	GOTO	$-3
	CLRF	TMR0		;ZERA TMR0
	
	GOTO	MAIN
	
	
DUTYCYCLEGREEN

	BSF	GPIO,1
	MOVLW	.0		;TMR0 DE 0 A 250 ALCANÇANDO T = 2000us
	MOVWF	TMR0
	MOVFW	LEDG		;VALOR DO ADRESH GUARDADO QUANDO ESCOLHIDO O LED VERDE
	SUBWF	TMR0 ,W		;COMPARA O TMR0 ATE ATINGIR O VALOR DO ADRESH
	BTFSS	STATUS , Z
	GOTO	$-3
	BCF	GPIO, 1		;DEPOIS COLOCANDO PARA O NIVEL BAIXO QUANDO DUTY CYCLE DIFERENTE DE 100%
	MOVLW	.250
	SUBWF	TMR0 , W
	BTFSS	STATUS, C	;DEPOIS FINALIZA QUANDO ATINGIR OS 2000us
	GOTO	$-3
	CLRF	TMR0		;ZERA TMR0 
	GOTO	MAIN
DUTYCYCLEBLUE
	BSF	GPIO,2
	MOVLW	.0		;TMR0 DE 0 A 250 ALCANÇANDO T = 2000us
	MOVWF	TMR0
	MOVFW	LEDB		;VALOR DO ADRESH GUARDADO QUANDO ESCOLHIDO O LED AZUL
	SUBWF	TMR0 ,W		;COMPARA O TMR0 ATE ATINGIR O VALOR DO ADRESH
	BTFSS	STATUS , Z
	GOTO	$-3
	BCF	GPIO, 2		;DEPOIS COLOCANDO PARA O NIVEL BAIXO QUANDO DUTY CYCLE DIFERENTE DE 100%
	MOVLW	.250
	SUBWF	TMR0 , W
	BTFSS	STATUS, C	;DEPOIS FINALIZA QUANDO ATINGIR OS 2000us
	GOTO	$-3
	CLRF	TMR0		;ZERA TMR0
	GOTO	MAIN
	

	;CORPO DA ROTINA PRINCIPAL

	GOTO MAIN

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END
