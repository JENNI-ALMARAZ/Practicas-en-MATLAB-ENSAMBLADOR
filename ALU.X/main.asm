;CONFIGURACIONES INICIALES
__CONFIG _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF

LIST P = 16F628A	    ;INDICAMOS EL PROCESADOR A USAR

INCLUDE <P16F628A.INC>      ;AGREGAMOS LA LIBRER�A A USAR
    

ORG	0x00		    ;INICIO DEL PROGRAMA

    BSF STATUS,5	    ;CAMBIAR AL BANCO 1
    BSF TRISB,0		    ;Asignamos entrada
    BSF TRISB,1		    ;Asignamos entrada
    BSF TRISB,2		    ;Asignamos entrada
    BSF TRISB,3		    ;Asignamos entrada
    CLRF TRISA		    ;Configuramos los pines RA0-RA7 como salidas, limpiamos esos puertos
    BCF STATUS, RP0	    ;Regresamos al banco 0
    
    MAIN:
    ;ELEGIR CASO (MATEMATICO = 1, LOGICO = 0)
	BTFSC PORTB,RB0
	    GOTO CASO_MATEMATICO
	    GOTO CASO_LOGICO
    ;CASO 1
    ;ELEGIR OPERACION (SUMA = 0, RESTA = 1) 
    CASO_MATEMATICO
	BTFSC PORTB,RB1
	    GOTO RESTA
	    GOTO SUMA
	    
    ;TENEMOS DOS OPCIONES DEPENDIENDO DE LA ENTRADA C
    ; C = 1 --> RESTA 1
    ; C = 0 --> RESTA 0
    RESTA
	BTFSC PORTB,RB2
	    GOTO RESTA_1
	    GOTO RESTA_0
	    
    RESTA_1
	BTFSC PORTB,RB3
	    CALL APAGAR_LEDS
	    NOP
	BTFSS PORTB,RB3   
	    CALL ENCENDER_F
	    NOP
	GOTO MAIN
	
    RESTA_0
	BTFSC PORTB,RB3
	    CALL ENCENDER_LEDS
	    CALL APAGAR_LEDS
	GOTO MAIN
	
    ;TENEMOS DOS OPCIONES DEPENDIENDO DE LA ENTRADA C
    ; C = 1 --> SUMA 1
    ; C = 0 --> SUMA 0
    SUMA
	BTFSC PORTB,RB2
	    GOTO SUMA_1
	    GOTO SUMA_0
	
    SUMA_1
	BTFSC PORTB,RB3
	    CALL ENCENDER_E
	    NOP
	BTFSS PORTB,RB3
	    CALL ENCENDER_F
	    NOP
	GOTO MAIN
    
    SUMA_0
	BTFSC PORTB,RB3
	    CALL ENCENDER_F
	    CALL APAGAR_LEDS
	GOTO MAIN

	
    ;CASO 2
    ;ELEGIR OPERACION (OR = 0, AND = 1)     
    CASO_LOGICO
	BTFSC PORTB,RB1
	    GOTO OR
	    GOTO AND
	    
    ;TENEMOS DOS OPCIONES DEPENDIENDO DE LA ENTRADA C
    ; C = 1 --> OR 1
    ; C = 0 --> OR 0
    OR
	BTFSC PORTB,RB2
	    GOTO OR_1
	    GOTO OR_0
	    
    OR_1
	CALL ENCENDER_F
	GOTO MAIN
    
    OR_0
	BTFSC PORTB,RB3
	    CALL ENCENDER_F
	    CALL APAGAR_LEDS
	GOTO MAIN
	    
    ;TENEMOS DOS OPCIONES DEPENDIENDO DE LA ENTRADA C
    ; C = 1 --> AND 1
    ; C = 0 --> AND 0
    AND 
	BTFSC PORTB,RB2
	    GOTO AND_1
	    GOTO AND_0
    	    
    AND_1
	BTFSC PORTB,RB3
	    CALL ENCENDER_F
	    CALL APAGAR_LEDS
	GOTO MAIN
   
    AND_0
	CALL APAGAR_LEDS
	GOTO MAIN
	
	
    ;SUBRUTINAS PARA LOS 4 CASOS DE SALIDAS QUE TENEMOS
    
    ; 0 0
    APAGAR_LEDS
	BCF PORTA,RA0
	BCF PORTA,RA1
    RETURN 
    
    ; 1 1
    ENCENDER_LEDS
	BSF PORTA,RA0
	BSF PORTA,RA1
    RETURN
    
    ; 0 1
    ENCENDER_F
	BTFSS PORTB,RB3
	    return
	    NOP
	BCF PORTA,RA0
	BSF PORTA,RA1
    RETURN
    
    ; 1 0
    ENCENDER_E
	BTFSS PORTB,RB3
	    return
	    NOP
	BSF PORTA,RA0
	BCF PORTA,RA1
    RETURN
    
END