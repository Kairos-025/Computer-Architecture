TITLE Q1 Solution

; Name: 
; Date: 
; ID: 
; Description: Using direct and indirect addressing to operate on an array

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; These two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
array DWORD 5, 10, 15, 20, 25          ; Initialize array with 5 DWORD elements
resultMsg BYTE "The result in the fifth element is: ", 0

.code
main PROC
    ; Step 1: Add the first and second elements using direct addressing
    mov eax, array[0]                   ; Load the first element into EAX
    add eax, array[4]                   ; Add the second element to EAX
    
    ; Step 2: Subtract the third element using indirect addressing
    mov ebx, OFFSET array               ; Get base address of array in EBX
    sub eax, [ebx + 8]                  ; Subtract the third element

    ; Step 3: Store the result in the fifth element
    mov [ebx + 16], eax                 ; Store the result in the fifth element

    ; Step 4: Display the result
    mov edx, OFFSET resultMsg           ; Load the message address
    call WriteString                    ; Display the message
    mov eax, [ebx + 16]                 ; Load the fifth element into EAX for display
    call WriteInt                       ; Display the result
    call Crlf                           ; New line

    exit
main ENDP
END main
