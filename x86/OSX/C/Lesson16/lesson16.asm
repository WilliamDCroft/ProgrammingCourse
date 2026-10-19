%pragma macho build_version macos,14,0

default rel

extern _printf

global _main

segment .data
    doubleValuePi dq 3.14159265
    floatValOne   dd 52.0
    floatValTwo   dd 15.0
    messageOne    db "%.8f", 10, 0
    messageTwo    db "%i %i/%i", 10, 0
    messageThree  db "%f", 10, 0

segment .text
  
_main:
    push rbp
    push rbx
    mov rbp, rsp
    sub rsp, 28h
    ; doublePrecisionPi qword [rbp - 8]
    ; myWholeNumber     dword [rbp - 12]
    ; myDenominator     dword [rbp - 16]
    ; myRemainder       dword [rbp - 20]
    ; myFloat           dword [rbp - 24]

    movsd xmm0, qword [doubleValuePi]
    movsd qword [rbp - 8], xmm0; doublePrecisionPi

    lea rdi, messageOne
    movsd xmm0, qword [rbp - 8]; doublePrecisionPi
    mov rax, 1
    call _printf

    mov dword [rbp - 16], 15; myDenominator

    mov eax, 52
    mov ebx, dword [rbp - 16]; myDenominator
    xor edx, edx
    div ebx
    mov dword [rbp - 12], eax; myWholeNumber
    mov dword [rbp - 20], edx; myRemainder

    lea rdi, messageTwo
    mov esi, dword [rbp - 12]; myWholeNumber
    mov edx, dword [rbp - 20]; myRemainder
    mov ecx, dword [rbp - 16]; myDenominator
    xor rax, rax
    call _printf

    movss xmm0, dword [floatValOne]
    movss xmm1, dword [floatValTwo]
    divss xmm0, xmm1
    movss dword [rbp - 24], xmm0; myFloat

    lea rdi, messageThree
    cvtss2sd xmm0, dword [rbp - 24]; myFloat
    mov rax, 1
    call _printf

    xor eax, eax 
    mov rsp, rbp
    pop rbx
    pop rbp
    ret