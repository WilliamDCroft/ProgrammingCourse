%pragma macho build_version macos,14,0

extern _printf

global _main

segment .data
   message db "x is %i", 10
           db "y is %i", 10
           db "z is %i", 10
           db "a is %i", 10, 0
   x dd 3

segment .bss
   y resd 1

segment .text

_main:
   push rbp
   mov rbp, rsp
   sub rsp, 10h
  ; z dword ptr [rbp - 4]

   mov dword [rel y], 4
   mov dword [rbp - 4], 5; z

  ;xor r11, r11
   mov r11d, dword [rel x]; a
   add r11d, dword [rel y]; a
   add r11d, dword [rbp - 4]; a, z

   lea rdi, [rel message]
   mov esi, dword [rel x]
   mov edx, dword [rel y]
   mov ecx, dword [rbp - 4]; z
   mov r8d, r11d; a
   xor rax, rax
   call _printf

   mov rsp, rbp
   pop rbp
   ret