%define SYS_EXIT  60
%define SYS_WRITE 1

%define STDOUT 1

global _start

segment .bss
    output resb 2
    outputLength equ $ - output

segment .text

_start:
    mov byte [output+1], 10

    mov cl, 0
loopOne:
    cmp cl, 9
    jg exit

    add cl, '0'
    mov byte [output], cl

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, output
    mov rdx, outputLength
    syscall

    mov cl, byte [output]
    sub cl, '0'

    inc cl; increment command. Adds one to a thing
    jmp loopOne

exit:
    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
