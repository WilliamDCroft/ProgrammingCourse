global _start

segment .text

_start:
    mov rax, 60
    mov rdi, 0
    syscall
