%pragma macho build_version macos,14,0

global _main
align 16

segment .data
   message    db "Hello world!", 10
   messageTwo db "I love programming!", 10

segment .text

_main:
   mov rax, 33554433
   mov rdi, 0
   syscall

   mov rax, 33554436
   mov rdi, 1
   lea rsi, [rel message]
   mov rdx, 13
   syscall

   mov rax, 33554436
   mov rdi, 1
   lea rsi, [rel messageTwo]
   mov rdx, 20
   syscall