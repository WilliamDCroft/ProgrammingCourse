extern printf: proc

.data
    message db "x is %i", 10
            db "y is %i", 10
            db "z is %i", 10
            db "a is %i", 10, 0
    x dd 3
;.bss
    y dd ?

.code 

main proc
    push rbp
    mov rbp, rsp
    sub rsp, 30h
    ; z dword ptr [rbp - 4]

    mov dword ptr [y], 4
    mov dword ptr [rbp - 4], 5; z

    ;xor r15, r15
    mov r15d, dword ptr [x]; a
    add r15d, dword ptr [y]; a
    add r15d, dword ptr [rbp - 4]; a, z

    lea rcx, message
    mov edx, dword ptr [x]
    mov r8d, dword ptr [y]
    mov r9d, dword ptr [rbp - 4]; z
    mov qword ptr [rsp + 32], r15
    call printf

    mov rsp, rbp
    pop rbp
    ret
main endp

end