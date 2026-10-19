extern printf

global main

segment .data
    doublePiValue dq 3.14159265
    floatValOne   dd 52.0
    floatValTwo   dd 15.0
    messageOne    db "%.8f", 10, 0
    messageTwo    db "%i %i/%i", 10, 0
    messageThree  db "%f", 10, 0

segment .text

main:
    push rbp
    mov rbp, rsp
    sub rsp, 28h
    ; doublePrecisionPi qword [rbp - 8]
    ; myWholeNumber     dword [rbp - 12]
    ; myDenominator     dword [rbp - 16]
    ; myRemainder       dword [rbp - 20]
    ; myFloat           dword [rbp - 24]
    push rbx

    movsd xmm0, qword [rel doublePiValue]
    movsd qword [rbp - 8], xmm0; doublePrecisionPi

    lea rdi, [rel messageOne]
    movsd xmm1, qword [rbp - 8]; doublePrecisionPi
    mov rax, 1
    call printf wrt ..plt

    mov dword [rbp - 16], 15; myDenominator

    mov eax, 52
    mov ebx, dword [rbp - 16]; myDenominator
    xor edx, edx
    div ebx
    mov dword [rbp - 12], eax; myWholeNumber
    mov dword [rbp - 20], edx; myRemainder

    lea rdi, [rel messageTwo]
    mov esi, dword [rbp - 12]; myWholeNumber
    mov edx, dword [rbp - 20]; myRemainder
    mov ecx, dword [rbp - 16]; myDenominator
    xor rax, rax
    call printf wrt ..plt


    movss xmm0, dword [rel floatValOne]
    movss xmm1, dword [rel floatValTwo]
    divss xmm0, xmm1
    movss dword [rbp - 24], xmm0; myFloat

    lea rdi, [rel messageThree]
    cvtss2sd xmm0, dword [rbp - 24]; myFloat
    mov rax, 1
    call printf wrt ..plt

    pop rbx
    xor eax, eax
    mov rsp, rbp
    pop rbp
    ret

segment .note.GNU-stack noexec
