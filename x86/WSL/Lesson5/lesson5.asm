global _start

segment .data
    message db "Hello world!", 10

segment .code

_start:
    mov eax, 4; SYS_WRITE
    mov ebx, 1; STDOUT
    mov ecx, message
    mov edx, 13
    int 128

    mov eax, 1; SYS_EXIT
    mov ebx, 0; no errors
    int 128
