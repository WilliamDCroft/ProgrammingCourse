%define SYS_WRITE 4
%define SYS_EXIT  1

%define STDOUT 1

global _start

segment .code

; numOne dword [ebp + 8]
; numTwo dword [ebp + 12]
moduloTwoNumbers:
    push ebp
    mov ebp, esp
    sub esp, 2
    ; output byte [ebp - 2]
    push ebx

    mov eax, dword [ebp + 8]; numOne
    mov ebx, dword [ebp + 12]; numTwo
    xor edx, edx
    div ebx

    add dl, "0"
    mov byte [ebp - 2], dl
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
    push 4
    push 7
    call moduloTwoNumbers
    add esp, 8

    push 7
    push 8
    call moduloTwoNumbers
    add esp, 8

    mov eax, SYS_EXIT
    mov ebx, 0
    int 80h