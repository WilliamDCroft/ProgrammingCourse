%define SYS_EXIT  1
%define SYS_READ  3
%define SYS_WRITE 4

%define STDIN  0
%define STDOUT 1

global _start

segment .data
    message db "Type a character: "
    messageLength equ $ - message

segment .code

_start:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, message
    mov edx, messageLength
    int 80h

    push 00000000h

    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, esp
    mov edx, 2
    int 80h

    pop eax; 00 00 0A ??
    inc eax
    push eax

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, esp
    mov edx, 2
    int 80h

    mov eax, SYS_EXIT
    mov ebx, 0
    int 80h