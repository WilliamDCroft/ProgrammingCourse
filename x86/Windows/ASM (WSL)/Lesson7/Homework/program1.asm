%define SYS_EXIT 1
%define SYS_WRITE 4
%define SYS_READ 3

%define STDOUT 1
%define STDIN 0

global _start

segment .bss
    input resb 2
    inputLength equ $ - input

segment .data
    message db "Please enter the number 1 or 2 -> "
    messageLength equ $ - message
    output db 0, 10
    outputLength equ $ - output

segment .code

_start:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, message
    mov edx, messageLength
    int 80h

    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, input
    mov edx, inputLength
    int 80h

    cmp byte [input], '1'
    je loopTwoStart

    mov ecx, '9'
loopOne:
    cmp cl, '0'
    jl exit

    mov byte [output], cl

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, output
    mov edx, outputLength
    int 80h

    mov cl, byte [output]

    dec ecx
    jmp loopOne

loopTwoStart:
    mov ecx, '0'
loopTwo:
    cmp cl, '9'
    jg exit

    mov byte [output], cl

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, output
    mov edx, outputLength
    int 80h

    mov cl, byte [output]

    inc ecx
    jmp loopTwo

exit:
    mov eax, SYS_EXIT
    xor ebx, ebx
    int 80h 
