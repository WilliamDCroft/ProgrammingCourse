extern puts: proc

.data
    message db "Hello world!", 0

.code 

main proc
    sub rsp, 28h

    lea rcx, message
    call puts

    xor rax, rax
    add rsp, 28h
    ret
main endp

end