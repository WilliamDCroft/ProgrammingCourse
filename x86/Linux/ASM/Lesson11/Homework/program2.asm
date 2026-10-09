%define SYS_WRITE 1
%define SYS_EXIT  60

%define STDOUT 1

global _start

segment .text

; numOne edi
; numTwo esi
divideTwoNumbers:
    push rbp
    mov rbp, rsp
    sub rsp, 10h
    ; output byte [rbp - 2]
    push rbx; rbx must not be clobbered

    mov eax, edi; numOne
    mov ebx, esi; numTwo
    xor edx, edx
    div ebx

    add al, "0"
    mov byte [rbp - 2], al
    mov byte [rbp - 1], 10; newline

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    lea rsi, [rbp - 2]
    mov rdx, 2
    syscall

    pop rbx
    mov rsp, rbp
    pop rbp
    ret

_start:
    mov edi, 12
    mov esi, 3
    call divideTwoNumbers

    mov edi, 15
    mov esi, 5
    call divideTwoNumbers

    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
