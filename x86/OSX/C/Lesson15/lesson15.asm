%pragma macho build_version macos,14,0

default rel

extern ___stdoutp
extern ___stdinp
extern _fputs
extern _fgets

global _main

segment .data
   message db "Type a character: ", 0

segment .text

_main:
   push rbp
   mov rbp, rsp
   sub rsp, 10h
  ; buffer byte [rbp - 3]

   lea rdi, [rel message]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   call _fputs

   lea rdi, [rbp - 3]
   mov rsi, 3
   mov rdx, [___stdinp wrt ..gotpcrel]
   call _fgets

   inc byte [rbp - 3]

   lea rdi, [rbp -3]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   call _fputs

   mov rsp, rbp
   pop rbp
   xor rax, rax
   ret