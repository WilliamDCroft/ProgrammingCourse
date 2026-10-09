%define SYS_EXIT  60
%define SYS_READ  0
%define SYS_WRITE 1

%define STDIN  0
%define STDOUT 1

global _start

segment .data
    message db "Type a character: "
    messageLength equ $ - message

segment .text

_start:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, message
    mov rdx, messageLength
    syscall

    push 0000000000000000h

    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, rsp
    mov rdx, 2
    syscall

    pop rax; 00 00 00 00 00 00 0A ??
    inc rax
    push rax

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, rsp
    mov rdx, 2
    syscall

    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
