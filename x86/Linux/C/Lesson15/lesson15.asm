extern stdout
extern stdin
extern fputs
extern fgets

global main

segment .data
    message db "Type a character: ", 0

segment .text

main:
    push rbp
    mov rbp, rsp
    sub rsp, 10h
    ; buffer byte [rbp - 3]

    lea rdi, [rel message]
    mov rsi, [rel stdout]
    call fputs wrt ..plt

    lea rdi, [rbp - 3]
    mov rsi, 3
    mov rdx, [rel stdin]
    call fgets wrt ..plt

    inc byte [rbp - 3]

    lea rdi, [rbp -3]
    mov rsi, [rel stdout]
    call fputs wrt ..plt

    mov rsp, rbp
    pop rbp
    xor rax, rax
    ret

segment .note.GNU-stack noexec
