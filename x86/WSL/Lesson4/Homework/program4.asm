global _start

segment .code

_start:
    mov ah, 4
    mov al, 1
    mov ebx, 3
    add ebx, eax
    mov ch, bh
    mov dl, bh
   
    mov eax, 1
    mov ebx, 0
    int 80h