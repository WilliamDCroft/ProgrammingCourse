extern ExitProcess: proc
extern puts       : proc

.data
    message db "Hello world!", 0

.code
start proc
    sub rsp, 40

    lea rcx, message
    call puts

    mov rcx, 0
    call ExitProcess
start endp

end