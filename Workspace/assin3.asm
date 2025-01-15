TITLE Assignment3

; Name: Ekemini John
; Date: 30th November, 2024
; ID: 110101042
; Description: This program computes the value of the expression 
; Y = 6.0 * (2.0 + 3.0) - 4.0 using the FPU in postfix notation.

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    num1 REAL4 2.0       ; Operand 1
    num2 REAL4 3.0       ; Operand 2
    num3 REAL4 6.0       ; Operand 3
    num4 REAL4 4.0       ; Operand 4
    result REAL4 0.0     ; To store the final result
    msg BYTE "Y = ", 0
    
.code
main PROC
    ; Load operands onto the FPU stack and perform calculations step by step
    fld num1             ; Stack: 2.0
    fld num2             ; Stack: 3.0, 2.0
    fadd                 ; Stack: 5.0
    fld num3             ; Stack: 6.0, 5.0
    fmul                 ; Stack: 30.0
    fld num4             ; Stack: 4.0, 30.0
    fsub                 ; Stack: 26.0
    fstp result          ; Store 26.0 in memory and clear the stack

    ; Display the result
    mov edx, OFFSET msg   ; Load address of the message
    call WriteString      ; Print the message
    fld result            ; Reload the result into the FPU stack
    call WriteFloat       ; Print the result

    ; Exit the program
    exit
main ENDP
END main
