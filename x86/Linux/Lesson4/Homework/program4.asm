global _start

segment .text

_start:
    mov ah, 4
    mov al, 1
    mov ebx, 3
    add ebx, eax
    mov ch, bh
    mov dl, bh

    mov rax, 60
    mov rdi, 0
    syscall
