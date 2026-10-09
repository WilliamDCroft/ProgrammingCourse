extern puts
extern atoi
extern secure_itoa

%define SYS_EXIT 1

global _start

segment .data
    message db "Hello world!", 0
    numberAsString db "4096", 0

segment .bss
    ouputBuffer resb 4096

segment .code

_start:
    push numberAsString
    call atoi
    add esp, 4

    cmp eax, 4096
    jne exit

    push message
    call puts
    add esp, 4

    push 4096
    push ouputBuffer
    push 4123456789
    call secure_itoa
    add esp, 12

    push ouputBuffer
    call puts
    add esp, 4

exit:
    mov eax, SYS_EXIT
    mov ebx, 0
    int 80h