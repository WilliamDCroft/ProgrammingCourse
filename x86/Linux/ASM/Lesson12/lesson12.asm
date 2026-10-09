extern puts
extern atoi
extern secure_itoa

%define SYS_EXIT 60

global _start

segment .data
    message db "Hello world!", 0
    numberAsString db "4096", 0

segment .bss
    outputBuffer resb 4096

segment .text

_start:
    lea rdi, numberAsString
    call atoi

    cmp eax, 4096
    jne exit

    lea rdi, message
    call puts

    mov edi, 4123456789
    lea rsi, outputBuffer
    mov rdx, 4096
    call secure_itoa

    lea rdi, outputBuffer
    call puts

exit:
    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
