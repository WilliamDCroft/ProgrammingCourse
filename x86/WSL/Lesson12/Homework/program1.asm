%define SYS_EXIT  1

extern summateTwoNumbers
extern divideTwoNumbers
extern moduloTwoNumbers

global _start

segment .code

_start:
    push 3
    push 2
    call summateTwoNumbers
    add esp, 8

    push 5
    push 3
    call summateTwoNumbers
    add esp, 8

    push 3
    push 12
    call divideTwoNumbers
    add esp, 8

    push 5
    push 15
    call divideTwoNumbers
    add esp, 8

    push 4
    push 7
    call moduloTwoNumbers
    add esp, 8

    push 7
    push 8
    call moduloTwoNumbers
    add esp, 8

    mov eax, SYS_EXIT
    mov ebx, 0
    int 80h