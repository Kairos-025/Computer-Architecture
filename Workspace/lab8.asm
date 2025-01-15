TITLE Lab8
; Name: John Ekemini
; Date: 25th November, 2024
; ID: 110101042
; Description: This program computes the result of a recursive function for 3, 5, and 7 using recursion, with the numbers stored in an array.

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    numbers DWORD 3, 5, 7        ; Array containing the numbers 3, 5, and 7
    result DWORD 0               ; Variable to store the result of the recursive function
    msg BYTE "The result of ", 0
    msg2 BYTE " is: ", 0
    newline BYTE 10, 0           ; Newline for formatting

.code
main PROC
    ; Set up a loop to process each number in the array
    lea esi, numbers            ; Load address of 'numbers' array into ESI
    mov ecx, 3                  ; We have 3 numbers in the array (3, 5, 7)

function_loop:
    mov eax, [esi]              ; Load current number from the array into EAX
    mov edx, eax                ; Store the number in EDX for printing later

    ; Print the message for the current number
    mov edx, OFFSET msg         ; Load address of "The result of"
    call WriteString            ; Print the first part of the message
    call WriteDec               ; Print the number
    mov edx, OFFSET msg2        ; Load address of " is: "
    call WriteString            ; Print " is: "

    ; Call the recursive function to compute the result of the current number
    call function

    ; Print the result of the recursive function
    call WriteDec               ; Print the result
    call Crlf                   ; Print newline for formatting

    ; Move to the next number in the array
    add esi, 4                  ; Move to the next number in the array (each number is 4 bytes)
    loop function_loop          ; Repeat the loop until all numbers are processed

    ; Exit program
    exit

main ENDP

; Recursive function: A function that computes a result based on the input
function PROC
    ; Base case: if EAX == 0, return 0
    cmp eax, 0                  ; Compare EAX with 0
    je end_function             ; If EAX == 0, jump to end (base case)

    ; Recursive case: EAX + function(EAX - 1)
    push eax                    ; Save the current value of EAX on the stack
    dec eax                     ; Decrement EAX by 1
    call function               ; Recursive call with EAX - 1
    pop ebx                     ; Restore the original value of EAX into EBX

    ; Add the result of the recursive call (which is already in EAX) to the original EAX
    add eax, ebx                ; Add EAX to EBX (original value before decrement)

end_function:
    ret
function ENDP

END main
