%define SYS_WRITE 4
%define SYS_EXIT  1

%define STDOUT 1

global _start

segment .code

; numOne dword [ebp + 8]
; numTwo dword [ebp + 12]
summateTwoNumbers:
    push ebp
    mov ebp, esp
    sub esp, 2
    ; output byte [ebp - 2]
    push ebx

    mov eax, dword [ebp + 8]; numOne
    add eax, dword [ebp + 12]; numTwo
    add al, "0"
    mov byte [ebp - 2], al
    mov byte [ebp - 1], 10; newline

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    lea ecx, [ebp - 2]
    mov edx, 2
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

_start:
    push 3
    push 2
    call summateTwoNumbers
    add esp, 8

    push 5
    push 3
    call summateTwoNumbers
    add esp, 8

    mov eax, SYS_EXIT
    mov ebx, 0
    int 80h