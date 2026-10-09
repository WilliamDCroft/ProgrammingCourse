%define SYS_EXIT  1
%define SYS_WRITE 4

%define STDOUT 1

global _start

segment .bss
    output resb 2
    outputLength equ $ - output

segment .code

_start:
    mov byte [output+1], 10

    mov cl, 0
loopOne:
    cmp cl, 9
    jg exit

    add cl, '0'
    mov byte [output], cl

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, output
    mov edx, outputLength
    int 80h

    mov cl, byte [output]
    sub cl, '0'

    inc cl; increment command. Adds one to a thing
    jmp loopOne

exit:
    mov eax, SYS_EXIT
    mov ebx, 0
    int 80h