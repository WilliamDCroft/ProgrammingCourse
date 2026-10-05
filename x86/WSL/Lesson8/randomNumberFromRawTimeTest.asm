%define SYS_EXIT 1
%define SYS_WRITE 4
%define SYS_TIME 13

%define STDOUT 1

segment .bss
    result resb 2

segment .code
    global _start:

_start:
    ; prime newline
    mov eax, result
    inc eax
    mov byte [eax], 10

    ; get number of seconds since 1970-01-01 00:00:00 +0000 (UTC) in eax
    mov eax, SYS_TIME
    mov ebx, 0
    int 80h

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
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, result
    mov edx, 2
    int 80h

    mov eax, SYS_EXIT
    mov ebx, 0
    int 80h