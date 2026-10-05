global _start

segment .data
    message db "Hello world!", 10

segment .code

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, message
    mov edx, 13
    int 128

    mov eax, 1
    mov ebx, 0
    int 128