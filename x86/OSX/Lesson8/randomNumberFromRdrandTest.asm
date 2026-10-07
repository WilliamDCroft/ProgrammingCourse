%define SYS_EXIT 60
%define SYS_WRITE 1

%define STDOUT 1

segment .bss
    result resb 2

segment .text
    global _start:

_start:
    ; prime newline
    mov eax, result
    inc eax
    mov byte [eax], 10

attemptRand:
    rdrand eax; get random number
    jnc attemptRand

    ; divide eax by 6
    mov edx, 0
    mov ebx, 6
    div ebx

    ; eax now contains a number from 0-5 in edx.
    ; Add one to get 1-6
    inc dl

    ; print the number
    add dl, '0'
    mov byte [result], dl
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, result
    mov rdx, 2
    syscall

    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
