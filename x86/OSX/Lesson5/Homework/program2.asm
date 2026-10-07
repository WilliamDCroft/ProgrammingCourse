%pragma macho build_version macos,14,0

global _main
align 16

segment .data
   message db "Hello, William!", 10

segment .text

_main:
   mov rax, 33554436
   mov rdi, 1
   lea rsi, [rel message]
   mov rdx, 16
   syscall

   mov rax, 33554433
   mov rdi, 0
   syscall