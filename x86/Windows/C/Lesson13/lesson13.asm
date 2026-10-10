extern ExitProcess: proc
extern puts       : proc

.data
    message db "Hello world!", 0

.code 

start proc
    sub rsp, 28h

    lea rcx, message
    call puts

    xor rcx, rcx
    call ExitProcess
start endp

end