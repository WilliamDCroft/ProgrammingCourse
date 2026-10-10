extern fputs: proc
extern fgets: proc
extern __acrt_iob_func: proc

.data
    message db "Type a character: ", 0

.code

main proc
    push rbp
    mov rbp, rsp
    sub rsp, 30h
    ; buffer byte [rbp - 3]

    mov rcx, 1; STDOUT
    call __acrt_iob_func

    mov rdx, rax
    lea rcx, message
    call fputs

    xor rcx, rcx; STDIN
    call __acrt_iob_func

    mov r8, rax
    lea rcx, [rbp - 3]
    mov rdx, 3
    call fgets

    inc byte ptr [rbp - 3]

    mov rcx, 1; STDOUT
    call __acrt_iob_func

    mov rdx, rax
    lea rcx, [rbp - 3]
    call fputs

    mov rsp, rbp
    pop rbp
    xor rax, rax
    ret
main endp

end