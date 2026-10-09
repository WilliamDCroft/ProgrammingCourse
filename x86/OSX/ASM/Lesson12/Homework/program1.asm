%pragma macho build_version macos,14,0

%define SYS_EXIT   0x02000001

extern summateTwoNumbers
extern divideTwoNumbers
extern moduloTwoNumbers

global _main
align 16

segment .text

_main:
   mov edi, 2; numbers should be treated as dwords
   mov esi, 3
   call summateTwoNumbers

   mov edi, 3
   mov esi, 5
   call summateTwoNumbers

   mov edi, 12
   mov esi, 3
   call divideTwoNumbers

   mov edi, 15
   mov esi, 5
   call divideTwoNumbers

   mov edi, 7
   mov esi, 4
   call moduloTwoNumbers

   mov edi, 8
   mov esi, 7
   call moduloTwoNumbers

   mov rax, SYS_EXIT
   mov rdi, 0
   syscall