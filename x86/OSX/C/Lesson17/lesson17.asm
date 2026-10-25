%pragma macho build_version macos,14,0

default rel

extern _fputs
extern ___stdoutp

global _main

segment .data
   messageOne    db "x and a are equal.", 10, 0
   messageTwo    db "x is less than y.", 10, 0
   messageThree  db "c is greather than x.", 10, 0
   messageFour   db "y is less than or equal to b.", 10, 0
   messageFive   db "y is greater than or equal to b.", 10, 0
   messageSix    db "x is not equal to y.", 10, 0
   messageSeven  db "x does not ", 34, "exist", 34, ".", 10, 0
   messageEight  db "x ", 34, "exists", 34, ".", 10, 0
   messageNine   db "x is 3 AND y is 4.", 10, 0
   messageTen    db "x is 3 OR y is 5.", 10, 0
   messageEleven db "z is 5 at the same time that either x is 3 or y is 5.", 10, 0

segment .text

_main:
   push rbp
   mov rbp, rsp
   sub rsp, 28h
  ; x dword [rbp - 4]
  ; y dword [rbp - 8]
  ; z dword [rbp - 12]
  ; a dword [rbp - 16]
  ; b dword [rbp - 20]
  ; c dword [rbp - 24]
   push rbx

   mov dword [rbp - 4], 3; x
   mov dword [rbp - 8], 4; y
   mov dword [rbp - 12], 5; z
   mov dword [rbp - 16], 3; a
   mov dword [rbp - 20], 4; b
   mov dword [rbp - 24], 5; c

   mov eax, dword [rbp - 4]; x
   mov ebx, dword [rbp - 16]; a
   cmp eax, ebx
   jne equalSkip

   lea rdi, [messageOne]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

equalSkip:
   mov eax, dword [rbp - 4]; x
   mov ebx, dword [rbp - 8]; y
   cmp eax, ebx
   jge lessThanSkip

   lea rdi, [messageTwo]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

lessThanSkip:
   mov eax, dword [rbp - 24]; c
   mov ebx, dword [rbp - 4]; x
   cmp eax, ebx
   jle greaterThanSkip

   lea rdi, [messageThree]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

greaterThanSkip:
   mov eax, dword [rbp - 8]; y
   mov ebx, dword [rbp - 20]; b
   cmp eax, ebx
   jg lessThanOrEqualSkip

   lea rdi, [messageFour]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

lessThanOrEqualSkip:
   mov eax, dword [rbp - 8]; y
   mov ebx, dword [rbp - 20]; b
   cmp eax, ebx
   jl greaterThanOrEqualSkip

   lea rdi, [messageFive]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

greaterThanOrEqualSkip:
   mov eax, dword [rbp - 4]; x
   mov ebx, dword [rbp - 8]; y
   cmp eax, ebx
   je notEqualToSkip

   lea rdi, [messageSix]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

notEqualToSkip:
   mov eax, dword [rbp - 8]; x
   mov ebx, 0
   cmp eax, ebx
   jne notSkip

   lea rdi, [messageSeven]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

notSkip:
   mov eax, dword [rbp - 4]; x
   mov ebx, 0
   cmp eax, ebx
   je existsSkip

   lea rdi, [messageEight]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

existsSkip:
   mov eax, dword [rbp - 4]; x
   mov ebx, 3
   cmp eax, ebx
   jne andSkip
   mov eax, dword [rbp - 8]; y
   mov ebx, 4
   cmp eax, ebx
   jne andSkip

   lea rdi, [messageNine]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

andSkip:
   mov eax, dword [rbp - 4]; x
   mov ebx, 3
   cmp eax, ebx
   jne orShortcut
   mov eax, dword [rbp - 8]; y
   mov ebx, 4
   cmp eax, ebx
   jne orSkip

orShortcut:
   lea rdi, [messageTen]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

orSkip:
   mov eax, dword [rbp - 4]; x
   mov ebx, 3
   cmp eax, ebx
   jne daisyShortcut
   mov eax, dword [rbp - 8]; y
   mov ebx, 4
   cmp eax, ebx
   jne daisySkip

daisyShortcut:
   mov eax, dword [rbp - 12]; z
   mov ebx, 5
   cmp eax, ebx
   jne daisySkip

   lea rdi, [messageEleven]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

daisySkip:
   xor eax, eax
   pop rbx
   mov rsp, rbp
   pop rbp
   ret