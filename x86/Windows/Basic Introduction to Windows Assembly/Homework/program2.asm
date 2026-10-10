extern ExitProcess   : proc
extern WriteFile     : proc
extern GetStdHandle  : proc

.data
    message db "Hello, William!", 10
    messageLength equ $ - message
    
.code

start proc
    push rbp
    mov rbp, rsp
    sub rsp, 30h
    ; numberOfBytesWritten dword ptr [ebp - 4]

    mov rcx, -11
    call GetStdHandle

    mov rcx, rax
    lea rdx, message
    mov r8, messageLength
    lea r9, [rbp - 4]
    mov qword ptr [rsp + 32], 0
    call WriteFile

    xor rcx, rcx
    call ExitProcess

start endp

end