global _start

segment .code

_start:
    mov ax, 1
    mov dx, 2
    add ax, dx
    add dx, 5
    mov bx, 4
    sub bx, dx
    sub dx, 1
   
    mov eax, 1
    mov ebx, 0
    int 80h