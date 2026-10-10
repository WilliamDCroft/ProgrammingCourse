%define SYS_EXIT 60

extern puts

global _start

segment .data
    message db "Hello world!", 0

segment .text

_start:
    endbr64; this is a valid jump point
    push rbp
    mov rbp, rsp

    lea rax, message
    mov rdi, rax
    call puts

    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
