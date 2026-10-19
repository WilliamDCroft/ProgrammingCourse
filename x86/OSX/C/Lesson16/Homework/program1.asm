%pragma macho build_version macos,14,0

default rel

extern _printf

global _main

segment .data
   floatValOne  dd 3.14
   floatValTwo  dd 17.24
   doubleValOne dq 4.17356789012
   message      db "%f", 10, 0

segment .text

_main:
   push rbp
   mov rbp, rsp
   sub rsp, 30h
  ; floatOne  dword [rbp - 4]
  ; floatTwo  dword [rbp - 8]
  ; resultOne dword [rbp - 12]
  ; doubleOne qword [rbp - 20]
  ; doubleTwo qword [rbp - 28]
  ; resultTwo qword [rbp - 36]

   movss xmm0, dword [floatValOne]
   movss dword [rbp - 4], xmm0; floatOne

   movss xmm0, dword [floatValTwo]
   movss dword [rbp - 8], xmm0; floatTwo

   movss xmm0, dword [rbp - 4]; floatOne
   movss xmm1, dword [rbp - 8]; floatTwo
   addss xmm0, xmm1
   movss dword [rbp - 12], xmm0; resultOne

   lea rdi, message
   cvtss2sd xmm0, dword [rbp - 12]; resultOne
   mov rax, 1
   call _printf

   cvtss2sd xmm0, dword [floatValTwo]
   movsd qword [rbp - 20], xmm0; doubleOne

   movsd xmm0, qword [doubleValOne]
   movsd qword [rbp - 28], xmm0; doubleTwo

   movsd xmm0, qword [rbp - 20]; doubleOne
   movsd xmm1, qword [rbp - 28]; doubleTwo
   mulsd xmm0, xmm1
   movsd qword [rbp - 36], xmm0; resultTwo

   lea rdi, message
   movsd xmm0, qword [rbp - 36]; resultTwo
   mov rax, 1
   call _printf

   xor eax, eax
   mov rsp, rbp
   pop rbp
   ret