%pragma macho build_version macos,14,0

default rel

extern ___stdoutp
extern _fputs

global _main

segment .data
   messageOne   db "x is 4!", 10, 0
   messageTwo   db "x is NOT 4!", 10, 0
   messageThree db "That's the program!", 10, 0

segment .text

_main:
   push rbp
   push rbx
   mov rbp, rsp
   sub rsp, 18h
  ; x dword [rbp - 4]

   mov dword [rbp - 4], 3; x
   mov eax, dword [rbp - 8]; x
   mov ebx, 4
   cmp eax, ebx
   jne elseClause

   lea rdi, [messageOne]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs
   jmp ifChainExit

elseClause:
   lea rdi, [messageTwo]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

ifChainExit:
   lea rdi, [messageThree]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

   xor eax, eax
   mov rsp, rbp
   pop rbx
   pop rbp
   ret