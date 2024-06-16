__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_ON & _MCLRE_ON & _BOREN_ON & _LVP_OFF & _CPD_OFF & _CP_OFF
 
 LIST    P=16f628A       ;Indicamos el procesador a usar
 
 INCLUDE <P16f628A.INC>  ;Agregamos las instrucciones
 
 ORG     0X00            ;Aquí indicamos el inicio del programa es exagesimal y se expresa mediante 0X
 
 BSF     STATUS,5        ;Cambiamos al banco 1
                         ; Banco 1 es paea configurar
                         ; Banco 2 es para programar
 
 MOVLW   00000011b       ;encender los puertos 0 y 1 (de una literal (Literal) hacia (W)). La b indica que es un numero binario
 MOVWF   TRISB           ;EStablecemos como ENTRADA RB0 y RB1
 CLRF    TRISA           ;Colocamos todos los PORTA en 0 o salidas TRISA=00000000
 
BCF      STATUS,RP0      ;Cambio el bit 5 del status a 0
                         ;Quiere decir que regreso al banco 0
 ;RB0 y RB1 son entradas
 ;BTFSS salta si es 1
INICIO           ; Este es un bloque
BTFSC    PORTB, 0; salta si es 0; el 0 es el bit
CALL     COMPROBAR_BTN_2
BCF      PORTA,2
GOTO     INICIO
			 
COMPROBAR_BTN_2   ; esta es una subrutina(la etiqueta tiene un nombre y su return) necesitas quitar el GOTO y cambiarlo po rel return 
BTFSC    PORTB, 1 ; Si es 1 enciende el led
BSF      PORTA,2  ; se ejecutaria esta linea
BCF      PORTA,2  ; en caso que no se ejecuta esta otra linea 
RETURN
 
 END
