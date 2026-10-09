global _start

segment .data
    message    db "Hello world!", 10
    messageTwo db "I love programming!", 10

segment .text

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, 13
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, messageTwo
    mov rdx, 20
    syscall

    mov rax, 60
    mov rdi, 0
    syscall
