%define SYS_EXIT  60
%define SYS_READ  0
%define SYS_WRITE 1

%define STDIN 0
%define STDOUT 1

global _start

segment .data
    message db "Type a character: "
    messageLength equ $ - message 
    
segment .bss
    input resb 2
    inputLength equ $ - input


segment .text

_start:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, message
    mov rdx, messageLength
    syscall

    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, input
    mov rdx, inputLength
    syscall

    add byte [input], 1

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, input
    mov rdx, inputLength
    syscall

    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
