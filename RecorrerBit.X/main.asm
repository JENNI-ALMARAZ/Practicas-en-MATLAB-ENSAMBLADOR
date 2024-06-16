; CONFIGURACIONES INICIALES
__CONFIG _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF

LIST P=16F84A		; Indicamos el procesador a usar
INCLUDE <P16F84A.INC>   ; Agregamos la librería

ORG 0x00    

BSF STATUS, RP0		; Cambiamos al banco 1
MOVLW 00000011b         ; Configuramos todos los pines de PORTA como entradas
MOVWF TRISA
CLRF TRISB		; Configuramos los pines RB0-RB7 como salidas, limpiamos esos puertos
BCF STATUS, RP0		; Regresamos al banco 0

CLRF PORTB		;limpiamos esos puertos
BSF STATUS,0		;Encendemos el byte 0 de status que es el que moveremos
INICIO:
    BTFSC   PORTA, 0		; Si RA0 está presionado
    GOTO    DESPLAZAR_DERECHA  
    BTFSC   PORTA, 1		; Si RA1 está presionado
    GOTO    DESPLAZAR_IZQUIERDA
    GOTO    INICIO		; Vuelve al inicio para volver a comprobar el estado de los botones

DESPLAZAR_DERECHA
    BTFSC   PORTA, 1		; Si también está presionado RA1, no hacer nada
    GOTO    INICIO		; Vuelve al inicio para volver a comprobar el estado de los botones
    RRF     PORTB		; Desplaza el bit a la derecha en PORTB (RB0-RB7)
    GOTO    INICIO		; Vuelve al inicio para volver a comprobar el estado de los botones

DESPLAZAR_IZQUIERDA
    BTFSC   PORTA, 0		; Si también está presionado RA0, no hacer nada
    GOTO    INICIO		; Vuelve al inicio para volver a comprobar el estado de los botones
    RLF     PORTB		; Desplaza el bit a la izquierda en PORTB (RB0-RB7)
    GOTO    INICIO		; Vuelve al inicio para volver a comprobar el estado de los botones

END    ; Fin del programa