extern printf: proc

.data
    doubleValuePi dq 3.14159265
    floatValOne   dd 52.0
    floatValTwo   dd 15.0
    messageOne    db "%.8f", 10, 0
    messageTwo    db "%i %i/%i", 10, 0
    messageThree  db "%f", 10, 0

.code

main proc
    push rbp
    push rbx
    mov rbp, rsp
    sub rsp, 48h
    ; doublePrecisionPi qword ptr [rbp - 8]
    ; myWholeNumber     dword ptr [rbp - 12]
    ; myDenominator     dword ptr [rbp - 16]
    ; myRemainder       dword ptr [rbp - 20]
    ; myFloat           dword ptr [rbp - 24]

    movsd xmm0, qword ptr [doubleValuePi]
    movsd qword ptr [rbp - 8], xmm0; doublePrecisionPi

    lea rcx, messageOne
    movsd xmm1, qword ptr [rbp - 8]; doublePrecisionPi
    movq rdx, xmm1; this keeps windows happy so it can double check the value
    call printf

    mov dword ptr [rbp - 16], 15; myDenominator

    mov eax, 52
    mov ebx, dword ptr [rbp - 16]; myDenominator
    xor edx, edx
    div ebx
    mov dword ptr [rbp - 12], eax; myWholeNumber
    mov dword ptr [rbp - 20], edx; myRemainder

    lea rcx, messageTwo
    mov edx, dword ptr [rbp - 12]; myWholeNumber
    mov r8d, dword ptr [rbp - 20]; myRemainder
    mov r9d, dword ptr [rbp - 16]; myDenominator
    call printf

    movss xmm0, dword ptr [floatValOne]
    movss xmm1, dword ptr [floatValTwo]
    divss xmm0, xmm1

    movss dword ptr [rbp - 24], xmm0; myFloat

    lea rcx, messageThree
    cvtss2sd xmm1, dword ptr [rbp - 24]; myFloat
    movq rdx, xmm1
    call printf

    xor rax, rax
    mov rsp, rbp
    pop rbx
    pop rbp
    ret

main endp
end