%pragma macho build_version macos,14,0

%define SYS_EXIT 0x02000001

extern puts

global _main

segment .data
   message db "Hello world!", 0

segment .text

_main:
   push rbp
   mov rbp, rsp
   sub rsp, 10

  ; LLVM allocates this for the sake of an implicit return 0 if none is provided
  ; with optimizations off, it is never cleaned up
   mov dword [rbp - 4], 0

   lea rdi, [rel message]
   call puts

   mov rax, SYS_EXIT
   mov rdi, 0
   syscall