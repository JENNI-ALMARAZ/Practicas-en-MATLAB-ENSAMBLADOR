__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _BOREN_ON & _LVP_OFF & _CPD_OFF & _CP_OFF

LIST P=16F628A     ; Iniciamos el programador a usar
INCLUDE <P16f628A.INC>   ; Agregamos la librería

ORG     0x00    ; INICIO DEL PROGRAMA
BSF     STATUS,5    ; CAMBIAMOS AL BANCO 1

MOVLW   00000011b       ; Configuramos los pines RB0 y RB1 como entradas
MOVWF   TRISB
CLRF    TRISA           ; Configuramos PORTA como salida (todos los bits en 0)

BCF     STATUS,RP0      ; REGRESO A BANCO 0

INICIO

; RB0 o RB1 son entradas, RA2 es salida

BTFSC   PORTB,0     ; Si RB0 está presionado, salta a encender LED
GOTO    ENCENDER_LED
BTFSC   PORTB,1     ; Si RB1 está presionado, también salta a encender LED
GOTO    ENCENDER_LED
BCF     PORTA,2     ; Apaga el LED si ninguno de los botones está presionado
GOTO    INICIO

ENCENDER_LED
BSF     PORTA,2     ; Enciende el LED
GOTO    INICIO       ; Vuelve al inicio para volver a comprobar el estado de los botones

END