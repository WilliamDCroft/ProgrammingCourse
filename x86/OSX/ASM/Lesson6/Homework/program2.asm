%pragma macho build_version macos,14,0

%define SYS_EXIT  0x02000001
%define SYS_READ  0x02000003
%define SYS_WRITE 0x02000004

%define STDIN 0
%define STDOUT 1

global _main
align 16

segment .data
   message db "Hello. What is your favorite number? "
   messageLength equ $ - message
   messageTwo db "Oh, cool! I like "
   messageTwoLength equ $ - messageTwo

segment .bss
   input resb 2
   inputLength equ $ - input

segment .text

_main:
   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel message]
   mov rdx, messageLength
   syscall

   mov rax, SYS_READ
   mov rdi, STDIN
   lea rsi, [rel input]
   mov rdx, inputLength
   syscall

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel messageTwo]
   mov rdx, messageTwoLength
   syscall

   add byte [rel input], 1

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel input]
   mov rdx, inputLength
   syscall

   mov rax, SYS_EXIT
   mov rdi, 0
   syscall