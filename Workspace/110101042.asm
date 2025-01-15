TITLE ; Lab4

; Name: John Ekemini
; Date: 28th October, 2024
; ID: 110101042
; Description: Evaluation of the following expressions:
                ; z[0] = x + 130
                ; z[1] = y - x + z[0]
                ; z[2] = r + x - z[1]

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    
    ; Define 16-bit integer variables
    x dw 10
    y dw 15
    r dw 4

    ; Define DWORD array z (size 3), uninitialized using DUP
    z DWORD 3 DUP(?)

.code
main PROC

    xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx

    call DumpRegs ; displays registers in console

    ; ------- z[0] = x + 130 -------
    movzx eax, word ptr [x]  ; Load x into EAX with zero-extension
    add eax, 130             ; Add 130 to EAX
    mov [z], eax             ; Store result in z[0]

    call DumpRegs ; displays registers in console

    ; ------- z[1] = y - x + z[0] -------
    movzx eax, word ptr [y]  ; Load y into EAX with zero-extension
    movzx ebx, word ptr [x]  ; Load x into EBX with zero-extension
    sub eax, ebx             ; Subtract x from y
    add eax, [z]             ; Add z[0] (DWORD) to EAX
    mov [z + 4], eax         ; Store result in z[1]

    call DumpRegs ; displays registers in console

    ; ------- z[2] = r + x - z[1] -------
    movzx eax, word ptr [r]  ; Load r into EAX with zero-extension
    movzx ebx, word ptr [x]  ; Load x into EBX with zero-extension
    add eax, ebx             ; Add x to r
    sub eax, [z + 4]         ; Subtract z[1] from EAX
    mov [z + 8], eax         ; Store result in z[2]

    call DumpRegs ; displays registers in console

	exit

main ENDP
END main
