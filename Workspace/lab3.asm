TITLE ; Lab3

; Name: John Ekemini
; Date: 11th Oct, 2024
; ID: 110101042
; Description: Evaluation of AL = (AL – DL) + CL - BL

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    
	; data declarations go here

.code
main PROC
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	
	; Initialize data in the registers
    mov al, 245        ; Store 245 (F5 in hexadecimal form) in AL
    mov bl, 41         ; Store 41 (29 in hexadecimal form) in BL
    mov cl, 11         ; Store 11 (0B in hexadecimal form) in CL
    mov dl, 215        ; Store 215 (D7 in hexadecimal form) in DL

    ; Evaluate the expression: AL = (AL – DL) + CL - BL
    sub al, dl         ; AL = AL - DL
    add al, cl         ; AL = AL + CL
    sub al, bl         ; AL = AL - BL

	; code goes here
	call DumpRegs ; displays registers in console

	exit

main ENDP
END main
