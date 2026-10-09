%define SYS_EXIT   60
%define SYS_READ   0
%define SYS_WRITE  1

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

segment .text

_start:
    rdrand eax
    jnc _start

    mov ebx, 6
    xor edx, edx
    div ebx
    inc dl
    add dl, '0'
    mov byte [someNumber], dl

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, openingMessage
    mov rdx, openingMessageLength
    syscall

mainLoop:
    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, userGuess
    mov rdx, userGuessLength
    syscall

    mov al, byte [userGuess]
    cmp al, byte [someNumber]
    jl tooLow
    jg tooHigh

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, youWinMessage
    mov rdx, youWinMessageLength
    syscall

    mov rax, SYS_EXIT
    mov rdi, 0
    syscall

tooLow:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, tooLowMessage
    mov rdx, tooLowMessageLength
    syscall

    jmp mainLoop

tooHigh:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, tooHighMessage
    mov rdx, tooHighMessageLength
    syscall

    jmp mainLoop
