global _start:

segment .data
    message db "Hello world!", 10

segment .text

_start:
    mov rax, 1; SYS_WRITE
    mov rdi, 1; STDOUT
    mov rsi, message
    mov rdx, 13
    syscall

    mov rax, 60; SYS_EXIT
    mov rdi, 0; 0 means no errors
    syscall