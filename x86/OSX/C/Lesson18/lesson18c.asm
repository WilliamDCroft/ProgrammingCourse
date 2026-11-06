%pragma macho build_version macos,14,0

default rel

extern ___stdoutp
extern _fputs

global _main

segment .data
   messageOne   db "x is 4!", 10, 0
   messageTwo   db "y is 4!", 10, 0
   messageThree db "x is NOT 4 and y is NOT 4!", 10, 0
   messageFour  db "That's the program!", 10, 0

segment .text

_main:
   push rbp
   push rbx
   mov rbp, rsp
   sub rsp, 18h
  ; x dword [rbp - 4]
  ; y dword [rbp - 8]

   mov dword [rbp - 4], 5; x
   mov dword [rbp - 4], 5; y

   mov eax, dword [rbp - 4]; x
   mov ebx, 4
   cmp eax, ebx
   jne elseIfClause

   lea rdi, [messageOne]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs
   jmp ifChainExit

elseIfClause:
   mov eax, dword [rbp - 8]; 8
   mov ebx, 4
   cmp eax, ebx
   jne elseClause

   lea rdi, [messageTwo]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs
   jmp ifChainExit

elseClause:
   lea rdi, [messageThree]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

ifChainExit:
   lea rdi, [messageFour]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

   xor eax, eax
   mov rsp, rbp
   pop rbx
   pop rbp
   ret