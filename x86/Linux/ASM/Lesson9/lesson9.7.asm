%define SYS_EXIT  60
%define SYS_WRITE 1

%define STDOUT 1

global _start

segment .text

_start:
    mov rcx, 0000000000000A30h; "0\n"
    
loopOne:
    cmp cl, '9'
    jg exit

    push rcx; 300A000000000000h

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, rsp
    mov rdx, 2
    syscall

    pop rcx

    inc cl; increment command. Adds one to a thing
    jmp loopOne

exit:
    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
