%define SYS_EXIT 1
%define SYS_WRITE 4

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

segment .code

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

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, message
    mov edx, messageLength
    int 80h

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, numberOne
    mov edx, 1
    int 80h

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, numberTwo
    mov edx, 1
    int 80h

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, numberThree
    mov edx, 1
    int 80h

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, numberFour
    mov edx, 1
    int 80h

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, numberFive
    mov edx, 1
    int 80h

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, numberSix
    mov edx, 1
    int 80h

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, newline
    mov edx, 1
    int 80h

    mov eax, SYS_EXIT
    mov ebx, 0
    int 80h
