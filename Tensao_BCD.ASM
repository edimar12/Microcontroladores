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
;*   Edimar Bezerra da Silva Neto   11409565			   *
;*   Medição de tensão e indicação em BCD			   *
;*								   *
;*                                                                 *
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
	MOVLW	B'00000100' ;CONFIGURA TODAS AS PORTAS DO GPIO (PINOS)
	MOVWF	TRISIO		;COMO SAÍDAS  
	MOVLW	B'00010100'
	MOVWF	ANSEL 		;DEFINE PORTAS COMO Digital I/O
	MOVLW	B'00000100'
	MOVWF	OPTION_REG	;DEFINE OPÇÕES DE OPERAÇÃO
	MOVLW	B'00000000'
	MOVWF	INTCON		;DEFINE OPÇÕES DE INTERRUPÇÕES
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00001001'
	MOVWF	ADCON0
	MOVLW	B'00000111'
	MOVWF	CMCON		;DEFINE O MODO DE OPERAÇÃO DO COMPARADOR ANALÓGICO

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZAÇÃO DAS VARIÁVEIS                 *
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
	MOVLW	.26			;VERIFICA TENSÕES MENORES QUE 0.5V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRAÇÃO ADRESH - WORK 
	BTFSC	STATUS , C		;VERIFICO NO CARRY SE O VALOR ENCONTRADO FOI MENOR E CONFIGURO GPIO 
	GOTO	ENTRE05E10		;CASO NAO SEJA VERIFICO SE ESTA ENTRE 0.5V E 1V	
	BCF	GPIO, 0			
	BCF	GPIO, 1
	BCF	GPIO, 4			
	BCF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 0(0000)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO
	
ENTRE05E10				;FORAM VERIFICADOS VALORES ABAIXO DE 0.5V
	MOVLW	.52			;AGORA VERIFICA TENSÕES MENORES QUE 1V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRAÇÃO ADRESH - WORK
	BTFSC	STATUS , C		;VERIFICO NO CARRY SE O VALOR ENCONTRADO FOI MENOR E CONFIGURO GPIO 
	GOTO	ENTRE10E15		;CASO NAO SEJA VERIFICO SE ESTA ENTRE 1V E 1.5V
	BSF	GPIO, 0
	BCF	GPIO, 1
	BCF	GPIO, 4
	BCF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 1(0001)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO
	
ENTRE10E15				;FORAM VERIFICADOS VALORES ABAIXO DE 1V
	MOVLW	.77			;VERIFICA TENSÕES MENORES QUE 1.5V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRAÇÃO ADRESH - WORK
	BTFSC	STATUS , C		;VERIFICO NO CARRY SE O VALOR ENCONTRADO FOI MENOR E CONFIGURO GPIO 
	GOTO	ENTRE15E20		;CASO NAO SEJA VERIFICO SE ESTA ENTRE 1.5V E 2V
	BCF	GPIO, 0
	BSF	GPIO, 1
	BCF	GPIO, 4
	BCF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 2(0010)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO
	
ENTRE15E20				;FORAM VERIFICADOS VALORES ABAIXO DE 1.5V
	MOVLW	.103			;VERIFICA TENSÕES MENORES QUE 2V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRAÇÃO ADRESH - WORK
	BTFSC	STATUS , C		;VERIFICO NO CARRY SE O VALOR ENCONTRADO FOI MENOR E CONFIGURO GPIO 
	GOTO	ENTRE20E25		;CASO NAO SEJA VERIFICO SE ESTA ENTRE 2V E 2.5V
	BSF	GPIO, 0
	BSF	GPIO, 1
	BCF	GPIO, 4
	BCF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 3(0011)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO
	
ENTRE20E25				;FORAM VERIFICADOS VALORES ABAIXO DE 2V
	MOVLW	.129			;VERIFICA TENSÕES MENORES QUE 2.5V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRAÇÃO ADRESH - WORK
	BTFSC	STATUS , C		;VERIFICO NO CARRY SE O VALOR ENCONTRADO FOI MENOR E CONFIGURO GPIO 
	GOTO	ENTRE25E30		;CASO NAO SEJA VERIFICO SE ESTA ENTRE 2.5V E 3V
	BCF	GPIO, 0
	BCF	GPIO, 1
	BSF	GPIO, 4
	BCF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 4(0100)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO
	
ENTRE25E30				;FORAM VERIFICADOS VALORES ABAIXO DE 2.5V
	MOVLW	.154			;VERIFICA TENSÕES MENORES QUE 3V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRAÇÃO ADRESH - WORK
	BTFSC	STATUS , C		;VERIFICO NO CARRY SE O VALOR ENCONTRADO FOI MENOR E CONFIGURO GPIO 
	GOTO	ENTRE30E35		;CASO NAO SEJA VERIFICO SE ESTA ENTRE 3V E 3.5V
	BSF	GPIO, 0
	BCF	GPIO, 1
	BSF	GPIO, 4
	BCF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 5(0101)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO
	
ENTRE30E35				;FORAM VERIFICADOS VALORES ABAIXO DE 3V
	MOVLW	.180			;VERIFICA TENSÕES MENORES QUE 3.5V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRAÇÃO ADRESH - WORK
	BTFSC	STATUS , C		;VERIFICO NO CARRY SE O VALOR ENCONTRADO FOI MENOR E CONFIGURO GPIO 
	GOTO	ENTRE35E40		;CASO NAO SEJA VERIFICO SE ESTA ENTRE 3.5V E 4V
	BCF	GPIO, 0
	BSF	GPIO, 1
	BSF	GPIO, 4
	BCF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 6(0110)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO
	
ENTRE35E40				;FORAM VERIFICADOS VALORES ABAIXO DE 3.5V
	MOVLW	.205			;VERIFICA TENSÕES MENORES QUE 4V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRAÇÃO ADRESH - WORK
	BTFSC	STATUS , C		;VERIFICO NO CARRY SE O VALOR ENCONTRADO FOI MENOR E CONFIGURO GPIO 
	GOTO	ENTRE40E45		;CASO NAO SEJA VERIFICO SE ESTA ENTRE 4V E 4.5V
	BSF	GPIO, 0
	BSF	GPIO, 1
	BSF	GPIO, 4
	BCF	GPIO, 5			;VALOR MOSTRADO NO DISPLAY SERA 7(0111)
	GOTO	MAIN			;VOLTA PARA MAIN E REINICIA A CONVERSAO
	
ENTRE40E45				;FORAM VERIFICADOS VALORES ABAIXO DE 4V
	MOVLW	.231			;VERIFICA TENSÕES MENORES QUE 4.5V(ARREDONDAMENTO)
	SUBWF	ADRESH,W		;ATRAVES DA SUBTRAÇÃO ADRESH - WORK
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
