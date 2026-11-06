extern stdout
extern fputs

global main

segment .data 
    messageOne   db "x is 4!", 10, 0
    messageTwo   db "x is NOT 4!", 10, 0
    messageThree db "That's the program!", 10, 0

segment .text

main:
    push rbp
    push rbx
    mov rbp, rsp
    sub rsp, 18h
    ; x dword [rbp - 4]

    mov dword [rbp - 4], 3; x
    mov eax, dword [rbp - 4]; x
    mov ebx, 4
    cmp eax, ebx
    jne elseClause

    lea rdi, [rel messageOne]
    mov rsi, [rel stdout]
    call fputs wrt ..plt
    jmp ifChainExit

elseClause:
    lea rdi, [rel messageTwo]
    mov rsi, [rel stdout]
    call fputs wrt ..plt


ifChainExit:
    lea rdi, [rel messageThree]
    mov rsi, [rel stdout]
    call fputs wrt ..plt

    xor eax, eax
    mov rsp, rbp
    pop rbx
    pop rbp
    ret

segment .note.GNU-stack noexec
