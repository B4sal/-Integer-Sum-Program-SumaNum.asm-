TITLE Programa de suma de numeros enteros (SumaNum.asm)
; Este programa pide tres enteros al usuario,
; los almacena en un arreglo, calcula la suma del
; arreglo y muestra la suma.
; Ultima actualizacion: 06/06/2024
; Version modificada por:
;               Russell Sleither Perez Santana
;               Oscar Tadeo Perez Bocos
;               Jafeth Daniel Gamboa Baas


.MODEL SMALL
.STACK
.DATA
    N1 DW 0                                     ; Variable para el primer entero
    N2 DW 0                                     ; Variable para el segundo entero
    N3 DW 0                                     ; Variable para el tercer entero
    N4 DW 0                                     ; Variable para el resultado de la suma
    M1 DB 10,13,' Escriba un entero con signo: $'    ; Mensaje para solicitar el primer entero
    M2 DB 10,13,' Escriba un entero con signo: $'    ; Mensaje para solicitar el segundo entero
    M3 DB 10,13,' Escriba un entero con signo: $'    ; Mensaje para solicitar el tercer entero
    M4 DB 10,13,' La suma de los enteros es: $'      ; Mensaje para mostrar el resultado de la suma
.CODE

;-----------------------------------------------------
PedirEnteros PROC 
;
; Pide al usuario tres enteros y los almacena en variables.
; No recibe argumentos.
; Devuelve: nada
;-----------------------------------------------------
    MOV AH, 9               ; Servicio de impresion
    LEA DX, M1              ; Carga el mensaje para el primer entero en DX
    INT 21H                 ; Interrupcion 21H para imprimir el mensaje
    MOV AH, 1               ; Servicio de entrada
    INT 21H                 ; Interrupcion 21H para leer el primer entero
    SUB AL, 30H             ; Resta 30H (48 en decimal) para convertir de ASCII a numero
    MOV AH, 0               ; Limpiamos AH para evitar problemas en la conversion
    MOV N1, AX              ; Almacena el primer entero en N1

    MOV AH, 9               ; Servicio de impresion
    LEA DX, M2              ; Carga el mensaje para el segundo entero en DX
    INT 21H                 ; Interrupcion 21H para imprimir el mensaje
    MOV AH, 1               ; Servicio de entrada
    INT 21H                 ; Interrupcion 21H para leer el segundo entero
    SUB AL, 30H             ; Resta 30H (48 en decimal) para convertir de ASCII a numero
    MOV AH, 0               ; Limpiamos AH para evitar problemas en la conversion
    MOV N2, AX              ; Almacena el segundo entero en N2
    
    MOV AH, 9               ; Servicio de impresion
    LEA DX, M3              ; Carga el mensaje para el tercer entero en DX
    INT 21H                 ; Interrupcion 21H para imprimir el mensaje
    MOV AH, 1               ; Servicio de entrada
    INT 21H                 ; Interrupcion 21H para leer el tercer entero
    SUB AL, 30H             ; Resta 30H (48 en decimal) para convertir de ASCII a numero
    MOV AH, 0               ; Limpiamos AH para evitar problemas en la conversion
    MOV N3, AX              ; Almacena el tercer entero en N3
    RET
PedirEnteros ENDP 

;-----------------------------------------------------
SumaArreglo PROC
;
; Calcula la suma de los tres enteros almacenados en N1, N2 y N3.
; No recibe argumentos.
; Devuelve: nada
;-----------------------------------------------------
    MOV AX, N1              ; Mueve el primer entero a AX
    ADD AX, N2              ; Suma el segundo entero a AX
    ADD AX, N3              ; Suma el tercer entero a AX
    MOV N4, AX              ; Guarda el resultado en N4
    RET
SumaArreglo ENDP

;-----------------------------------------------------
MostrarSuma PROC
;
; Muestra el resultado de la suma en la pantalla.
; No recibe argumentos.
; Devuelve: nada
;---------------------------------------------------
    MOV AH, 9               ; Servicio de impresion
    LEA DX, M4              ; Carga el mensaje para mostrar la suma en DX
    INT 21H                 ; Interrupcion 21H para imprimir el mensaje
    
    MOV AX, N4              ; Mueve el resultado a AX
    MOV BX, 10              ; Divisor para convertir a decimal
    XOR CX, CX              ; Limpiamos CX

    R1:
        XOR DX, DX          ; Limpiamos DX
        DIV BX              ; Divide AX por BX (10)
        PUSH DX             ; Guardamos el residuo en la pila
        INC CX              ; Incrementamos el contador
        TEST AX, AX         ; Verificamos si AX es cero
        JNZ R1     ; Si no es cero, repetimos

    R2:
        POP DX              ; Sacamos un dígito de la pila
        ADD DL, 30H         ; Convertimos el dígito en ASCII
        MOV AH, 2           ; Servicio para mostrar un carácter
        INT 21H             ; Mostramos el dígito
        LOOP R2      ; Repetimos hasta que no queden dígitos en CX

    RET
MostrarSuma ENDP

MAIN:
    MOV AX, @DATA           ; Acumula la direccion de DATA en AX
    MOV DS, AX              ; Mueve la direccion a DS

    CALL PedirEnteros       ; Llama al procedimiento PedirEnteros

    CALL SumaArreglo        ; Llama al procedimiento SumaArreglo

    CALL MostrarSuma        ; Llama al procedimiento MostrarSuma

    MOV AH, 4cH             ; Servicio de finalizacion
    INT 21H                 ; Interrupcion 21H
END MAIN
