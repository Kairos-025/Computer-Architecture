TITLE Lab7
; Name: John Ekemini
; Date: 18th November, 2024
; ID: 110101042
; Description: Analysis of an array to sum positive values and count negative values.

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; These two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    a DWORD 10, -20, 4, 5, -35, 44, -60, 2, 0, 23 ; Array of 10 signed integers
    arraySize DWORD 10                            ; Number of elements in the array

    sumPositive DWORD 0                           ; Variable to store the sum of positive values
    countNegative DWORD 0                         ; Variable to store the count of negative values

    msgSum BYTE "Sum of positive values: ", 0
    msgCount BYTE "Count of negative values: ", 0

.code
main PROC
    mov ecx, arraySize           ; Loop counter (number of elements in array)
    mov esi, OFFSET a            ; Point to the start of the array
    xor eax, eax                 ; Clear EAX (used for calculations)
    xor ebx, ebx                 ; Clear EBX (accumulator for sumPositive)
    xor edx, edx                 ; Clear EDX (counter for countNegative)

loopStart:
    cmp ecx, 0                   ; Check if loop counter is zero
    je loopEnd                   ; Exit loop if done

    mov eax, [esi]               ; Load the current array element
    add esi, 4                   ; Move to the next element in the array
    dec ecx                      ; Decrement the loop counter

    cmp eax, 0                   ; Check if the value is positive
    jl negativeValue             ; Jump if value is negative
    add ebx, eax                 ; Add positive value to sumPositive
    jmp loopStart                ; Continue to next iteration

negativeValue:
    inc edx                      ; Increment countNegative
    jmp loopStart                ; Continue to next iteration

loopEnd:
    mov sumPositive, ebx         ; Store sum of positive values
    mov countNegative, edx       ; Store count of negative values

    ; Display sum of positive values
    mov edx, OFFSET msgSum
    call WriteString
    mov eax, sumPositive
    call WriteInt
    call Crlf

    ; Display count of negative values
    mov edx, OFFSET msgCount
    call WriteString
    mov eax, countNegative
    call WriteInt
    call Crlf

    exit
main ENDP
END main
