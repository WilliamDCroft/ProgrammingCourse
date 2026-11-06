extern __acrt_iob_func: proc
extern fputs          : proc

.data
    messageOne   db "x is 4!", 10, 0
    messageTwo   db "y is 4!", 10, 0
    messageThree db "x is NOT 4 and y is NOT four!", 10, 0
    messageFour  db "That's the program!", 10, 0

.code

main proc
    push rbp
    push rbx
    mov rbp, rsp
    sub rsp, 38h
    ; x dword [rbp - 4]
    ; y dword [rbp - 8]

    mov dword ptr [rbp - 4], 5; x
    mov dword ptr [rbp - 8], 5; y

    mov eax, dword ptr [rbp - 4]; x
    mov ebx, 4
    cmp eax, ebx
    jne elseIfClause

    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageOne
    call fputs
    jmp ifChainExit

elseIfClause:
    mov eax, dword ptr [rbp - 8]; y
    mov ebx, 4
    cmp eax, ebx
    jne elseClause

    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageTwo
    call fputs
    jmp ifChainExit

elseClause:
    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageThree
    call fputs

ifChainExit:
    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageFour
    call fputs

    xor eax, eax
    mov rsp, rbp
    pop rbx
    pop rbp
    ret
    
main endp

end