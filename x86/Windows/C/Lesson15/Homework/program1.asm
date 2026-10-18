extern __acrt_iob_func: proc
extern fputs          : proc
extern fgets          : proc

.data
    message db "Type a message: ", 0
    messageTwo db "Your message is: ", 0

.code 

main proc
    push rbp
    mov rbp, rsp
    sub rsp, 120h
    ; buffer byte ptr [rbp - 256]

    mov rcx, 1
    call __acrt_iob_func

    mov rdx, rax
    lea rcx, message
    call fputs

    xor rcx, rcx
    call __acrt_iob_func

    mov r8, rax
    lea rcx, [rbp - 256]
    mov rdx, 256
    call fgets

    mov rcx, 1
    call __acrt_iob_func

    mov rdx, rax
    lea rcx, messageTwo
    call fputs

    mov rcx, 1
    call __acrt_iob_func

    mov rdx, rax
    lea rcx, [rbp - 256]
    call fputs

    xor eax, eax
    mov rsp, rbp
    pop rbp
    ret
main endp

end