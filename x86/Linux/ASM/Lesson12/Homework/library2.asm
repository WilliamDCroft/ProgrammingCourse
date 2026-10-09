%define SYS_WRITE 1

%define STDOUT 1

global summateTwoNumbers
global divideTwoNumbers
global moduloTwoNumbers

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

    mov di, word [rbp - 2]
    call print

    mov rsp, rbp
    pop rbp
    ret

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

    mov di, word [rbp - 2]
    call print

    pop rbx
    mov rsp, rbp
    pop rbp
    ret

; numOne edi
; numTwo esi
moduloTwoNumbers:
    push rbp
    mov rbp, rsp
    sub rsp, 10h
    ; output byte [rbp - 2]
    push rbx

    mov eax, edi; numOne
    mov ebx, esi; numTwo
    xor edx, edx
    div ebx

    add dl, "0"
    mov byte [rbp - 2], dl
    mov byte [rbp - 1], 10; newline

    mov di, word [rbp - 2]
    call print

    pop rbx
    mov rsp, rbp
    pop rbp
    ret

; result di
print:
    sub rsp, 10h
    ; result word [rsp + 2]
    mov word [rsp + 2], di

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    lea rsi, [rsp + 2]
    mov rdx, 2
    syscall

    add rsp, 10h
    ret