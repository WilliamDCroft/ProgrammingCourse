extern ExitProcess   : proc
extern WriteFile     : proc
extern GetStdHandle  : proc

.data
    message db "Hello world!", 10
    messageLength equ $ - message
    messageTwo db "I love programming!", 10
    messageTWoLength equ $ - messageTwo
    
.code

start proc
    push rbp
    mov rbp, rsp
    sub rsp, 30h
    ; numberOfBytesWritten dword ptr [ebp - 4]

    xor rcx, rcx
    call ExitProcess

    mov rcx, -11
    call GetStdHandle

    mov rcx, rax
    lea rdx, message
    mov r8, messageLength
    lea r9, [rbp - 4]
    mov qword ptr [rsp + 32], 0
    call WriteFile

    mov rcx, -11
    call GetStdHandle

    mov rcx, rax
    lea rdx, messageTwo
    mov r8, messageTwoLength
    lea r9, [rbp - 4]
    mov qword ptr [rsp + 32], 0
    call WriteFile

start endp

end