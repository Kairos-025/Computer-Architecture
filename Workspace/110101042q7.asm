TITLE ; Assignment 2
; Name: John Ekemini
; Date: 12th NOV 2024
; ID: 110101042
; Description: Encrypting and decrypting

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; These two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
encryptionKey BYTE "ABXmv#7", 0             ; Encryption key
encryptionKeySize DWORD SIZEOF encryptionKey - 1  ; Size of the key
MAX_INPUT_SIZE = 128                       ; Maximum input size
inputPrompt BYTE "Enter the plain text: ", 0
cipherTextMsg BYTE "Cipher text: ", 0
decryptedTextMsg BYTE "Decrypted text: ", 0
inputBuffer BYTE MAX_INPUT_SIZE + 1 DUP(0)      ; Buffer for the input text
inputSize DWORD ?                    ; Size of the input text

.code
main PROC
    ; Prompt user, encrypt, display cipher text, decrypt, and display original text
    call Crlf
    call getInputString            ; Read user input
    call encryptDecryptBuffer      ; Encrypt the buffer
    mov edx, OFFSET cipherTextMsg
    call displayMessage            ; Display encrypted message
    call encryptDecryptBuffer      ; Decrypt the buffer
    mov edx, OFFSET decryptedTextMsg
    call displayMessage            ; Display decrypted message
    INVOKE ExitProcess, 0
main ENDP

getInputString PROC
    ; Prompts the user for input text and saves it in inputBuffer
    pushad
    mov edx, OFFSET inputPrompt
    call WriteString
    mov ecx, MAX_INPUT_SIZE
    mov edx, OFFSET inputBuffer
    call ReadString
    mov inputSize, eax               ; Store the size of the input text
    call Crlf
    popad
    ret
getInputString ENDP

displayMessage PROC
    ; Displays the message (either encrypted or decrypted) stored in inputBuffer
    pushad
    call WriteString
    mov edx, OFFSET inputBuffer
    call WriteString
    call Crlf
    call Crlf
    popad
    ret
displayMessage ENDP

encryptDecryptBuffer PROC
    ; Encrypts/decrypts inputBuffer by XORing each byte with the encryptionKey, wrapping as needed
    pushad
    mov ecx, inputSize               ; Set loop counter to size of input text
    mov esi, 0                        ; Initialize index for inputBuffer
    mov edi, 0                        ; Key index (wraps around)

    EncryptDecryptLoop:
        mov al, [encryptionKey + edi]        ; Get current key character
        xor inputBuffer[esi], al             ; XOR key character with inputBuffer byte
        inc esi                             ; Move to the next buffer byte
        inc edi                             ; Move to the next key byte
        cmp edi, encryptionKeySize          ; Check if we need to wrap key index
        jl SkipWrap                         ; If edi < encryptionKeySize, skip wrap
        mov edi, 0                          ; Reset key index if reached end
    SkipWrap:
        loop EncryptDecryptLoop              ; Repeat until all buffer bytes are processed

    popad
    ret
encryptDecryptBuffer ENDP
END main
