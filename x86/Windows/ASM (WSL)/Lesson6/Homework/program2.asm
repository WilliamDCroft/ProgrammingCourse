%define SYS_EXIT  1
%define SYS_READ  3
%define SYS_WRITE 4

%define STDIN 0
%define STDOUT 1

global _start

segment .data
    message db "Hello. What is your favorite number? "
    messageLength equ $ - message
    messageTwo db "Oh, cool! I like "
    messageTwoLength equ $ - messageTwo

segment .bss
    input resb 2
    inputLength equ $ - input

segment .code

_start:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, message
    mov edx, messageLength
    int 128

    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, input
    mov edx, inputLength
    int 128

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, messageTwo
    mov edx, messageTwoLength
    int 128

    add byte [input], 1

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, input
    mov edx, inputLength
    int 128

    mov eax, SYS_EXIT
    mov ebx, 0
    int 128