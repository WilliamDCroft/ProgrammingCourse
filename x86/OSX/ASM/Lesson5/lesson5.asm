%pragma macho build_version macos,14,0

global _main
align 16

segment .data
   message db "Hello world!", 10

segment .text

_main:
   mov rax, 33554436; SYS_WRITE
   mov rdi, 1; STDOUT
   lea rsi, [rel message]
   mov rdx, 13
   syscall

   mov rax, 33554433; SYS_EXIT
   mov rdi, 0; 0 means no errors
   syscall