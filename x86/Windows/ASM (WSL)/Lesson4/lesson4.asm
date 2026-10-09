global _start

segment .code

_start:
    mov ax, 1
    mov bx, 2
    mov cx, 3
    mov dx, 4

    mov ebx, 0
    mov eax, 1
    int 128