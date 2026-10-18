extern stdout
extern stdin
extern fputs
extern fgets

global main

segment .data
    message db "Type a message: ", 0
    messageTwo db "Your message is: ", 0

segment .text

main:
    push rbp
    mov rbp, rsp
    sub rsp, 100h
    ; buffer dword [rbp - 256]

    lea rdi,[rel message]
    mov rsi, [rel stdout]
    call fputs wrt ..plt

    lea rdi, [rbp - 256]
    mov rsi, 256
    mov rdx, [rel stdin]
    call fgets wrt ..plt

    lea rdi, [rel messageTwo]
    mov rsi, [rel stdout]
    call fputs wrt ..plt

    lea rdi, [rbp - 256]
    mov rsi, [rel stdout]
    call fputs wrt ..plt

    xor eax, eax
    mov rsp, rbp
    pop rbp
    ret

segment .note.GNU-stack noexec