extern printf: proc

.data
    floatValOne  dd 3.14
    floatValTwo  dd 17.24
    doubleValTwo dq 4.17365789012
    message      db "%f", 10, 0

.code

main proc
    push rbp
    mov rbp, rsp
    sub rsp, 50h
    ; floatOne  dword ptr [rbp - 4]
    ; floatTwo  dword ptr [rbp - 8]
    ; resultOne dword ptr [rbp - 12]
    ; doubleOne qword ptr [rbp - 20]
    ; doubleTwo qword ptr [rbp - 28]
    ; resultTwo qword ptr [rbp - 36]

    movss xmm0, dword ptr [floatValOne]
    movss dword ptr [rbp - 4], xmm0; floatOne

    movss xmm0, dword ptr [floatValTwo]
    movss dword ptr [rbp - 8], xmm0; floatTwo

    movss xmm0, dword ptr [rbp - 4]; floatOne
    movss xmm1, dword ptr [rbp - 8]; floatTwo

    addss xmm0, xmm1

    movss dword ptr [rbp - 12], xmm0; resultOne

    lea rcx, message
    cvtss2sd xmm1, dword ptr [rbp - 12]; resultOne
    movq rdx, xmm1
    call printf


    movss xmm0, dword ptr [rbp - 8]; floatTwo
    cvtss2sd xmm0, xmm0
    movsd qword ptr [rbp - 20], xmm0; doubleOne

    movsd xmm0, qword ptr [doubleValTwo]
    movsd qword ptr [rbp - 28], xmm0; doubleTwo

    movsd xmm0, qword ptr [rbp - 20]; doubleOne
    movsd xmm1, qword ptr [rbp - 28]; doubleTwo

    mulsd xmm0, xmm1

    movsd qword ptr [rbp - 36], xmm0; resultTwo

    lea rcx, message
    movsd xmm1, qword ptr [rbp - 36]; resultTwo
    movq rdx, xmm1
    call printf

    xor rax, rax
    mov rsp, rbp
    pop rbp
    ret

main endp
end