%define SYS_EXIT   1
%define SYS_READ   3
%define SYS_WRITE  4

%define STDIN  0
%define STDOUT 1

global _start

segment .data
    openingMessage db "Guess a number from 1 to 6: "
    openingMessageLength equ $ - openingMessage
    youWinMessage db "You got it!", 10
    youWinMessageLength equ $ - youWinMessage
    tooLowMessage db "Too low! Try again: "
    tooLowMessageLength equ $ - tooLowMessage
    tooHighMessage db "Too High! Try again: "
    tooHighMessageLength equ $ - tooHighMessage

segment .bss
    someNumber resb 1
    userGuess resb 2
    userGuessLength equ $ - userGuess

segment .code

_start:
    rdrand eax
    jnc _start

    mov ebx, 6
    xor edx, edx
    div ebx
    inc dl
    add dl, '0'
    mov byte [someNumber], dl

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, openingMessage
    mov edx, openingMessageLength
    int 80h

mainLoop:
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, userGuess
    mov edx, userGuessLength
    int 80h

    mov al, byte [userGuess]
    cmp al, byte [someNumber]
    jl tooLow
    jg tooHigh

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, youWinMessage
    mov edx, youWinMessageLength
    int 80h

    mov eax, SYS_EXIT
    mov ebx, 0
    int 80h

tooLow:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, tooLowMessage
    mov edx, tooLowMessageLength
    int 80h

    jmp mainLoop

tooHigh:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, tooHighMessage
    mov edx, tooHighMessageLength
    int 80h

    jmp mainLoop