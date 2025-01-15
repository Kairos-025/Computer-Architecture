TITLE Q2 Solution

; Name: 
; Date: 
; ID: 
; Description: Using direct and indirect addressing to operate on two arrays

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; These two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
array1 DWORD 10, 21, 30, 41, 50         ; First array
array2 DWORD 5, 10, 15, 20, 25          ; Second array
resultArray DWORD 5 DUP(0)              ; Result array initialized to 0
resultMsg BYTE "Result array:", 0

.code
main PROC
    ; Step 1: Process the elements at even indices (0, 2, 4) using addition
    mov eax, array1[0]                  ; Load the first element of array1
    add eax, array2[0]                  ; Add the first element of array2
    mov resultArray[0], eax             ; Store in resultArray[0]

    mov eax, array1[8]                  ; Load the third element of array1 (index 2)
    add eax, array2[8]                  ; Add the third element of array2
    mov resultArray[8], eax             ; Store in resultArray[2]

    mov eax, array1[16]                 ; Load the fifth element of array1 (index 4)
    add eax, array2[16]                 ; Add the fifth element of array2
    mov resultArray[16], eax            ; Store in resultArray[4]

    ; Step 2: Process the elements at odd indices (1, 3) using subtraction
    mov eax, array1[4]                  ; Load the second element of array1 (index 1)
    sub eax, array2[4]                  ; Subtract the second element of array2
    mov resultArray[4], eax             ; Store in resultArray[1]

    mov eax, array1[12]                 ; Load the fourth element of array1 (index 3)
    sub eax, array2[12]                 ; Subtract the fourth element of array2
    mov resultArray[12], eax            ; Store in resultArray[3]

    ; Step 3: Output the result array
    mov edx, OFFSET resultMsg           ; Load address of the result message
    call WriteString                    ; Display the result message
    call Crlf                           ; New line after the message

    mov esi, OFFSET resultArray         ; Load address of resultArray
    mov ecx, 5                          ; Set loop counter to 5 (number of elements)

display_result:
    mov eax, [esi]                      ; Load the current element of resultArray into EAX
    call WriteInt                       ; Display the integer
    call Crlf                           ; New line after each number
    add esi, 4                          ; Move to the next element (DWORD size)
    loop display_result                 ; Repeat for all elements

    ; End program
    exit
main ENDP
END main
