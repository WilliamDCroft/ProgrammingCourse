%pragma macho build_version macos,14,0

%define SYS_EXIT   0x02000001
%define SYS_WRITE  0x02000004

%define STDOUT 1

global _main
align 16

segment .text

; numOne edi
; numTwo esi
moduloTwoNumbers:
   push rbp
   mov rbp, rsp
   sub rsp, 10h
  ; output byte [rbp - 2]
   push rbx

   mov eax, edi; numOne
   mov ebx, esi; numTwo
   xor edx, edx
   div ebx

   add dl, "0"
   mov byte [rbp - 2], dl
   mov byte [rbp - 1], 10; newline

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rbp - 2]
   mov rdx, 2
   syscall

   pop rbx
   mov rsp, rbp
   pop rbp
   ret

_main:
   mov edi, 7
   mov esi, 4
   call moduloTwoNumbers

   mov edi, 8
   mov esi, 7
   call moduloTwoNumbers

   mov rax, SYS_EXIT
   mov rdi, 0
   syscall