global _start

segment .data
    message db "Hello, William!", 10

segment .text

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, 16
    syscall

    mov rax, 60
    mov rdi, 0
    syscall
