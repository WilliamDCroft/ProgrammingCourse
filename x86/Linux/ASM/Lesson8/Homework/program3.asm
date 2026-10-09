%define SYS_EXIT 60
%define SYS_WRITE 1

%define STDOUT 1
global _start

segment .data
    message db "Your luck number is: "
    messageLength equ $ - message
    newline db 10

segment .bss
    numberOne   resb 1
    numberTwo   resb 1
    numberThree resb 1
    numberFour  resb 1
    numberFive  resb 1
    numberSix   resb 1

segment .text

_start:

attemptRandOne:
    rdrand eax
    jnc attemptRandOne

    ; divide eax by 10
    mov edx, 0
    mov ebx, 10
    div ebx

    add dl, '0'
    mov byte [numberOne], dl

attemptRandTwo:
    rdrand eax
    jnc attemptRandTwo

    ; divide eax by 10
    mov edx, 0
    mov ebx, 10
    div ebx

    add dl, '0'
    mov byte [numberTwo], dl

attemptRandThree:
    rdrand eax
    jnc attemptRandThree

    ; divide eax by 10
    mov edx, 0
    mov ebx, 10
    div ebx

    add dl, '0'
    mov byte [numberThree], dl

attemptRandFour:
    rdrand eax
    jnc attemptRandFour

    ; divide eax by 10
    mov edx, 0
    mov ebx, 10
    div ebx

    add dl, '0'
    mov byte [numberFour], dl

attemptRandFive:
    rdrand eax
    jnc attemptRandFive

    ; divide eax by 10
    mov edx, 0
    mov ebx, 10
    div ebx
   
    add dl, '0'
    mov byte [numberFive], dl

attemptRandSix:
    rdrand eax
    jnc attemptRandSix

    ; divide eax by 10
    mov edx, 0
    mov ebx, 10
    div ebx

    add dl, '0'
    mov byte [numberSix], dl

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, message
    mov rdx, messageLength
    syscall

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, numberOne
    mov rdx, 1
    syscall

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, numberTwo
    mov rdx, 1
    syscall

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, numberThree
    mov rdx, 1
    syscall

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, numberFour
    mov rdx, 1
    syscall

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, numberFive
    mov rdx, 1
    syscall

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, numberSix
    mov rdx, 1
    syscall

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, newline
    mov rdx, 1
    syscall

    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall
