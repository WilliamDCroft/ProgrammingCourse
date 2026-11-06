extern __acrt_iob_func: proc
extern fputs          : proc

.data
    messageOne   db "x is 4!", 10, 0
    messageTwo   db "x is NOT 4!", 10, 0
    messageThree db "That's the program!", 10, 0

.code

main proc
    push rbp
    push rbx
    mov rbp, rsp
    sub rsp, 38h
    ; x dword [rbp - 4]

    mov dword ptr [rbp - 4], 3; x
    mov eax, dword ptr [rbp - 4]; x
    mov ebx, 4
    cmp eax, ebx
    jne elseClause

    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageOne
    call fputs
    jmp ifChainExit

elseClause:
    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageTwo
    call fputs

ifChainExit:
    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageThree
    call fputs

    xor eax, eax
    mov rsp, rbp
    pop rbx
    pop rbp
    ret
    
main endp

end