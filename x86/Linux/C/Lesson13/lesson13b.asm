extern puts

global main

segment .data
    message db "Hello world!", 0

segment .text

main:
    endbr64
    push rbp
    mov rbp, rsp


    lea rax, [rel message]
    mov rdi, rax
    call puts wrt ..plt

    mov eax, 0
    pop rbp
    ret

segment .note.GNU-stack noexec
