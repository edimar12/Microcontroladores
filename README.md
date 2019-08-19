# Microcontroladores

## Identificando diferentes frequências
  
    Objetivo: Exercícios para gerenciamento de portas e de timers.
    Contexto: Dado um sinal de onda quadrada, que opera em 4 diferentes frequências, identificá-las com a sinalização através de LEDs.
    Especificações:
    • As frequências a serem verificadas são: 5kHz, 10kHz, 20kHz e 30kHz;
    • A porta de entrada que receberá o sinal deve ser através de GP2;
    • Os LEDs devem ser ativados (ON) apenas para indicar sua frequência correspondente, de acordo com a tabela abaixo:
    GP0 ON para f=5kHz
    GP1 ON para f=10kHz
    GP4 ON para f=20kHz
    GP5 ON para f=30kHz
    • A tolerância ao erro será uma variação de 10% sobre a frequência identificada; 

## Conversão de hexadecimal para BCD

    Objetivo: Exercícios de familiarização com o conjunto de instruções do PIC.
    Especificações:
    • Dado um valor em hexadecimal (1 byte), converter esse valor para a notação BCD.
    • Considera-se que o valor a ser convertido estará armazenado no registrador WORK e, após a
    conversão, o valor será armazenado na variável DADO;
    • Se o valor convertido for maior que 99, o registrador WORK será utilizado como byte complementar;
    • Se o valor convertido for menor que 99, o registrador WORK deverá conter zero
    • Veja os exemplos:

## Utilizando a EEPROM 

    Objetivo: Gravar e recuperar dados na memória perene (EEPROM).
    Contexto: Medir o tempo para colocar em ordem decrescente dados previamente armazenados na
    EEPROM.
    Especificações:
    • Apague todos os leds;
    • Considere 40 bytes já armazenados na EEPROM, a partir do endereço 00h;
    • Acenda o led GP5 imediatamente antes de iniciar a ordenação para sinalizar o início do processo;
    • Coloque-os em ordem decrescente;
    • Apague o led GP5 imediatamente depois para sinalizar que a ordenação terminou;
    • A medição será efetuada com o osciloscópio;

## Medição de tensão e indicação em BCD

    Objetivo: Exercício de familiarização com o conversor A/D do PIC.
    Especificações:
    • Conversão A/D deve ser efetuada, em modo cíclico e tão rápido quanto possível (limitado pela
    velocidade do microcontrolador);
    • O valor da conversão A/D, de 0V a 5V, deve ser transformado para uma escala de 0 a 9, em valores
    inteiros. Veja a escala na tabela abaixo;
    • O valor da escala a ser mostrado, de 0 a 9, deve ser representado na codificação BCD para ser
    conectado ao display de 7 segmentos (kit didático do LABEC 2). Para que todos tenham a mesma
    conectividade, siga a seguinte configuração:
    • GP0 → b0 (MENOS significativo) do BCD
    • GP1 → b1 do BCD
    • GP4 → b2 do BCD
    • GP5 → b3 (MAIS significativo) do BCD
    • A conversão A/D deve ser feita pela porta GP2;

## Controlador com histerese: sensor LDR

    Objetivo: Exercício de aplicação e gerenciamento do comparador.
    Contexto: Implementar um sistema de controle de iluminação artificial para ambiente, utilizando o princípio
    da histerese para evitar a “flutuação” da comutação no valor de comparação. Para isso, serão utilizados dois
    valores distintos (Lmín e Lmáx) para definir uma faixa de comutação.
    Como funciona:
    • Condições iniciais 1:
    o Supondo que a iluminação de controle do comparador está configurado para Lmáx;
    o Supondo que a iluminação ambiente (LAMB), a ser comparada, é superior a Lmáx;
    o Nessas condições: 
     a iluminação artificial deve ser desligada;
     e altera-se a configuração do comparador para Lmín.
    • Condições iniciais 2:
    o Supondo que a iluminação de controle do comparador está configurado para Lmín;
    o Supondo que a iluminação ambiente (LAMB), a ser comparada, é inferior a Lmin;
    o Nessas condições:
     a iluminação artificial deve ser ligada;
     e altera-se a configuração do comparador para Lmáx.
    • Para qualquer outra condição diferente das descritas acima:
    o Mantém o estado anterior de funcionamento da iluminação artificial (ligada ou desligada);
    o Mantém o valor anterior de configuração do comparador(Lmín ou Lmáx).
    • A Figura 1 ilustra como o sistema deve reagir para ativar/desativar a iluminação artificial.
    Figura 1. Variação da intensidade luminosa e respectivo comportamento do sistema de controle.
    Especificações:
    • A conversão de iluminação (medida pelo LDR) para tensão (V) faz parte do projeto. Assim, a partir do
    LDR, faça o levantamento das especificações e as medidas que considerar necessárias.
    • A escolha da equação do comparador deve ser justificada pela demonstração dos diferentes valores
    obtidos.
    • GP1 deverá ser utilizado para receber o sinal do LDR;
    • GP2 deverá ser utilizado para fornecer o sinal de controle. 

## Controlador de LED RGB

    Objetivo: Exercícios para implementação de portas com PWM.
    Contexto: Controle da cor e da intensidade do brilho de um LED RGB.
    Especificações:
    • Após o RESET, os LEDs deverão estar apagados;
    • Duas chaves serão utilizadas para selecionar o LED que será ajustado, segundo a tabela:
    Chaves Cor do LED
    00 Desligados
    01 Red
    10 Green
    11 Blue
    • Um canal será utilizado para conversão A/D será utilizada para controlar a intensidade (duty cycle) do
    brilho do LED selecionado;
    • A intensidade do LED ajustado deverá ser mantida após a alteração da seleção para outro LED;
    • Quando houver duty cycle diferente de 100%, a frequência do sinal deve ser de 500Hz;
    • GP0, GP1 e GP2 deverão ser utilizados para produzir os sinais PWM, respectivamente, para os LED
    R, G e B;
    • GP3 e GP5 deverão ser utilizados para efetuar a seleção do LED que será ajustado;
    • GP4 deverá ser utilizado efetuar a conversão A/D; 

## Comunicação I2C com PIC16F628A 

    Objetivo: Exercício de aplicação de microcontrolador PIC16F628A, com Implementação do protocolo I2C
    no modo SLAVE.
    Especificações:
    • CÓPIAS integral ou parcial de algum trabalho anterior ou atual serão sumariamente penalizados;
    • O protocolo I2C deve ser implementado no PIC (16F628A) no modo SLAVE;
    • O PIC deve receber um byte de endereço e sinalizar sua identificação através de um LED;
    • Quando o endereço for identificado como correto, um ACK deve ser enviado e o sinal CLK deve forçado
    a LOW por 100 ms;
    • Um LED deve indicar que o endereço correto foi recebido, mantendo-o aceso pelo mesmo tempo do ACK
    em LOW;
    • Para padronizar a utilização das portas, deve ser adotado:
    • RA0 - SCL
    • RA1 - SDA
    • RB7 - LED
    • Endereço 41d/29h
