global _start

segment .code

_start:
    mov ax, 1
    mov dx, 2
    mov ax, 3
    mov bx, 4
   
    mov eax, 1
    mov ebx, 0
    int 80h