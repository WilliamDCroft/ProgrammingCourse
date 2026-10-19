extern printf

global main

segment .data
    floatValOne  dd 3.14
    floatValTwo  dd 17.24
    doubleValTwo dq 4.17365789012
    message      db "%f", 10, 0

segment .text

main:
    push rbp
    mov rbp, rsp
    sub rsp, 20h
    ; floatOne  dword [rbp - 4]
    ; floatTwo  dword [rbp - 8]
    ; resultOne dword [rbp - 12]
    ; doubleOne qword [rbp - 20]
    ; doubltTwo qword [rbp - 28]
    ; resultTwo qword [rbp - 36]

    movss xmm0, dword [rel floatValOne]
    movss dword [rbp - 4], xmm0; floatOne

    movss xmm0, dword [rel floatValTwo]
    movss dword [rbp - 8], xmm0; floatTwo

    movss xmm0, dword [rbp - 4]; floatOne
    movss xmm1, dword [rbp - 8]; floatTwo
    addss xmm0, xmm1
    movss dword [rbp - 12], xmm0; resultOne

    lea rdi, [rel message]
    cvtss2sd xmm0, dword [rbp - 12]; resultOne
    mov rax, 1
    call printf wrt ..plt

    
    cvtss2sd xmm0, dword [rbp - 8]; floatTwo
    movsd qword [rbp - 20], xmm0
    movsd xmm0, qword [rel doubleValTwo]
    movsd qword [rbp - 28], xmm0; doubleTwo


    movsd xmm0, qword [rbp - 20]; doubleOne
    movsd xmm1, qword [rbp - 28]; doubleTwo
    mulsd xmm0, xmm1

    movsd qword [rbp - 36], xmm0; resultTwo

    lea rdi, [rel message]
    movsd xmm0, qword [rbp - 36]; resultTwo
    mov rax, 1
    call printf wrt ..plt

    xor eax, eax
    mov rsp, rbp
    pop rbp
    ret

segment .note.GNU-stack noexec
