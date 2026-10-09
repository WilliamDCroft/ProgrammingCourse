%pragma macho build_version macos,14,0

global _main

segment .text

_main:
   mov ax, 1
   mov dx, 2
   add ax, dx
   add dx, 5
   mov bx, 4
   sub dx, bx
   sub dx, 1

   mov rax, 33554433
   mov rdi, 0
   syscall