%define SYS_WRITE 1
%define SYS_EXIT  60

%define STDOUT 1

global _start

segment .text

; numOne edi
; numTwo esi
summateTwoNumbers:
    push rbp
    mov rbp, rsp
    sub rsp, 10h
    ; output byte [rbp - 2]

    mov eax, edi; numOne
    add eax, esi; numTwo
    add al, "0"
    mov byte [rbp - 2], al
    mov byte [rbp - 1], 10; newline

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    lea rsi, [rbp - 2]
    mov rdx, 2
    syscall

    mov rsp, rbp
    pop rbp
    ret

_start:
    mov edi, 2; numbers should be treated as dwords
    mov esi, 3
    call summateTwoNumbers

    mov edi, 3
    mov esi, 5
    call summateTwoNumbers

    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
