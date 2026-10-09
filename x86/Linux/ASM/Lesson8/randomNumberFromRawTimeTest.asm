%define SYS_EXIT 60
%define SYS_WRITE 1
%define SYS_TIME 201

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

    ; get number of seconds since 1970-01-01 00:00:00 +0000 (UTC) in eax
    mov rax, SYS_TIME
    mov rdi, 0
    syscall

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
    xor rdi, rdi
    syscall
