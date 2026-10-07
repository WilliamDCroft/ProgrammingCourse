%pragma macho build_version macos,14,0

global _main

segment .text

_main:
   mov ah, 4
   mov al, 1
   mov ebx, 3
   add ebx, eax
   mov ch, bh
   mov dl, bh

   mov rax, 33554433
   mov rdi, 0
   syscall