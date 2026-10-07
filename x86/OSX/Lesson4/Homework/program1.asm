%pragma macho build_version macos,14,0

global _main

segment .text

_main:
   mov rax, 33554433
   mov rdi, 0
   syscall