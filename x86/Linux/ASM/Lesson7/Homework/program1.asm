%define SYS_EXIT 60
%define SYS_WRITE 1
%define SYS_READ 0

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

segment .text

_start:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, message
    mov rdx, messageLength
    syscall

    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, input
    mov rdx, inputLength
    syscall

    cmp byte [input], '1'
    je loopTwoStart

    mov ecx, '9'
loopOne:
    cmp cl, '0'
    jl exit

    mov byte [output], cl

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, output
    mov rdx, outputLength
    syscall

    mov cl, byte [output]

    dec ecx
    jmp loopOne

loopTwoStart:
    mov ecx, '0'
loopTwo:
    cmp cl, '9'
    jg exit

    mov byte [output], cl

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, output
    mov rdx, outputLength
    syscall

    mov cl, byte [output]

    inc ecx
    jmp loopTwo

exit:
    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall 
