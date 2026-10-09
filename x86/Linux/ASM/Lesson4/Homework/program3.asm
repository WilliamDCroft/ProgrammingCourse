global _start

segment .text

_start:
    mov ax, 1
    mov dx, 2
    add ax, dx
    add dx, 5
    mov bx, 4
    sub dx, bx
    sub dx, 1

    mov rax, 60
    mov rdi, 0
    syscall
