TITLE

; Name: John Ekemini
; Date: 4th November, 2024
; ID: 110101042
; Description: Analysis of a series of bank transactions

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; These two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    ; Define DWORD array `a` with transactions and the count `b`
    a DWORD 500, -300, 1200, -600, 800, -200, 1500, -750, 300
    b DWORD 9                            ; Number of transactions

    ; Variables for results
    sumWithdrawal DWORD 0                ; Sum of large withdrawals (< -500)
    count DWORD 0                        ; Count of regular transactions
    sumDeposit DWORD 0                   ; Sum of large deposits (> 1000)

    ; Message strings for output
    withdrawals BYTE "Total sum of large withdrawals: ", 0
    regular BYTE "Count of regular transactions: ", 0
    deposits BYTE "Total sum of large deposits: ", 0

.code
main PROC
    ; Initialize registers
    mov ecx, b                           ; Load transaction count into ECX
    mov esi, OFFSET a                    ; Load address of `a` array into ESI
    xor ebx, ebx                         ; Clear sumWithdrawal accumulator
    xor edx, edx                         ; Clear sumDeposit accumulator
    xor edi, edi                         ; Clear count accumulator
    push esp                             ; Initialize stack base pointer
    mov esp, ebp                         ; Set stack base pointer

transaction_loop:
    ; Check if all transactions have been processed
    cmp ecx, 0
    je end_loop                          ; Exit loop when ECX reaches 0

    ; Load current transaction
    mov eax, [esi]                       ; Load transaction value into EAX (32-bit)
    add esi, 4                           ; Move to the next transaction in array
    dec ecx                              ; Decrement the loop counter

    ; Check if it's a large deposit (> 1000)
    cmp eax, 1000
    jle check_withdrawal                 ; If not, check for large withdrawal

    ; Handle large deposit
    push eax                             ; Push large deposit onto stack
    add edx, eax                         ; Add to sumDeposit
    jmp next_transaction                  ; Go to next transaction

check_withdrawal:
    ; Check if it's a large withdrawal (< -500)
    cmp eax, -500
    jge regular_transaction               ; If not, it's a regular transaction

    ; Handle large withdrawal
    add ebx, eax                         ; Add to sumWithdrawal
    jmp next_transaction                  ; Go to next transaction

regular_transaction:
    ; Count as a regular transaction
    inc edi                              ; Increment regular transaction count

next_transaction:
    jmp transaction_loop                 ; Repeat the loop

end_loop:
    ; Process stack for large deposits sum
    mov eax, 0                           ; Clear EAX for large deposits sum
stack_processing:
    cmp ebp, esp                         ; Compare stack pointer with base pointer
    je end_stack_processing               ; If they are equal, we are done
    pop ecx                              ; Pop the top of the stack
    add eax, ecx                         ; Add to large deposits sum
    jmp stack_processing                  ; Continue processing stack

end_stack_processing:
    ; Store results
    mov sumWithdrawal, ebx                ; Store sum of large withdrawals
    mov count, edi                        ; Store count of regular transactions
    mov sumDeposit, eax                   ; Store sum of large deposits

    ; Output the results
    ; Total sum of large withdrawals
    mov edx, OFFSET withdrawals          ; Load address of the withdrawals message
    call WriteString                     ; Output the message
    mov eax, sumWithdrawal               ; Move result into EAX for output
    call WriteInt
    call Crlf

    ; Count of regular transactions
    mov edx, OFFSET regular              ; Load address of the regular message
    call WriteString                     ; Output the message
    mov eax, count                       ; Move result into EAX for output
    call WriteInt
    call Crlf

    ; Total sum of large deposits
    mov edx, OFFSET deposits             ; Load address of the deposits message
    call WriteString                     ; Output the message
    mov eax, sumDeposit                  ; Move result into EAX for output
    call WriteInt
    call Crlf

    ; End program
    call DumpRegs                        ; Display register contents for verification
    exit
main ENDP
END main
