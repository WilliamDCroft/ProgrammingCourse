%define SYS_EXIT  60
%define SYS_READ  0
%define SYS_WRITE 1

%define STDIN  0
%define STDOUT 1

global _start

segment .data
    guessMessage db "Guess a number from 1 to 6: "
    guessMessageLength equ $ - guessMessage
    youWinMessage db "You win!", 10
    youWinMessageLength equ $ - youWinMessage
    tooLowMessage db "Too low. Try again: "
    tooLowMessageLength equ $ - tooLowMessage
    tooHighMessage db "Too high. Try again: "
    tooHighMessageLength equ $ - tooHighMessage
    loseMessage db "Sorry, you are out of guesses. The number was X.", 10
    loseMessageLength equ $ - loseMessage
   
segment .bss
    userGuess resb 10
    userGuessLength equ $ - userGuess
    guessCount resb 1

segment .text

_start:
    ; To start with, get a random number from 1 to 6 and store it.
    rdrand eax
    jnc _start

    mov ebx, 6
    xor edx, edx
    div ebx

    add dl, '1'; combine adding 48 and 1
    push rdx; random number

    mov byte [loseMessage+loseMessageLength-3], dl

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, guessMessage
    mov rdx, guessMessageLength
    syscall

    push 0000000000000000h; guessCount

gameLoop:
    pop rcx; guess count
    inc rcx
    push rcx; guess count
    push 0000000000000000h; user guess
    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, rsp
    mov rdx, 2
    syscall

    pop rax; user guess
    pop rcx; guess count
    pop rbx; random number

    push rbx; random number
    push rcx; guess count

    cmp al, bl
    jl tooLow
    jg tooHigh

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, youWinMessage
    mov rdx, youWinMessageLength
    syscall

exit:
    mov rax, SYS_EXIT
    mov rdi, 0
    syscall

tooLow:
    pop rcx;guess count
    push rcx; guess count
    cmp rcx, 3
    je outOfGuesses
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, tooLowMessage
    mov rdx, tooLowMessageLength
    syscall
    jmp gameLoop

tooHigh:
    pop rcx;guess count
    push rcx; guess count
    cmp rcx, 3
    je outOfGuesses
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, tooHighMessage
    mov rdx, tooHighMessageLength
    syscall
    jmp gameLoop

outOfGuesses:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, loseMessage
    mov rdx, loseMessageLength
    syscall
    jmp exit
