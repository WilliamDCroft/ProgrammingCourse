%pragma macho build_version macos,14,0

default rel

extern _fputs
extern _fgets
extern ___stdoutp
extern ___stdinp

global _main
align 16

segment .data
   message db "Type a message: ", 0
   messageTwo db "Your message is: ", 0

segment .text

_main:
   push rbp
   mov rbp, rsp
   sub rsp, 100h
  ; buffer byte [rbp - 256]

   lea rdi, message
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

   lea rdi, [rbp - 256]
   mov rsi, 256
   mov rdx, [___stdinp wrt ..gotpcrel]
   mov rdx, [rdx]
   call _fgets

   lea rdi, messageTwo
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs 

   lea rdi, [rbp - 256]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

   xor rax, rax
   mov rsp, rbp
   pop rbp
   ret