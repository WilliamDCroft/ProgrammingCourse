%pragma macho build_version macos,14,0

%define SYS_EXIT   0x02000001
%define SYS_READ   0x02000003
%define SYS_WRITE  0x02000004

%define STDIN  0
%define STDOUT 1

global _main
align 16

segment .data
   message db "Type a character: "
   messageLength equ $ - message

segment .text

_main:
   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel message]
   mov rdx, messageLength
   syscall

   push 0000000000000000h

   mov rax, SYS_READ
   mov rdi, STDIN
   mov rsi, rsp
   mov rdx, 2
   syscall

   pop rax; 00 00 00 00 00 00 0A ??
   inc rax
   push rax

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   mov rsi, rsp
   mov rdx, 2
   syscall

   mov rax, SYS_EXIT
   mov rdi, 0
   syscall