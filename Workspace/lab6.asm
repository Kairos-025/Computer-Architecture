TITLE

; Name: 
; Date: 
; ID: 
; Description: 

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    
	; data declarations go here
    array DWORD 4 DUP(0)

.code
main PROC
	
	; code goes here
    mov eax, 10
    mov esi, 0
    call proc_1
    add esi, 4
    add eax, 10
    mov array[esi], eax
	call DumpRegs ; displays registers in console
    INVOKE ExitProcess, 0
	;exit
main ENDP
proc_1 PROC
    call proc_2
    add esi, 4
    add eax, 10
    mov array[esi], eax
    call DumpRegs ; displays registers in console
    ret
proc_1 ENDP
proc_2 PROC
    call proc_3
    add esi, 4
    add eax, 10
    mov array[esi], eax
    call DumpRegs ; displays registers in console
    ret
proc_2 ENDP
proc_3 PROC
    mov array[esi], eax
    call DumpRegs ; displays registers in console
    ret
proc_3 ENDP
END main
