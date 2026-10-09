%pragma macho build_version macos,14,0

%define SYS_EXIT   0x02000001
%define SYS_WRITE  0x02000004

%define STDOUT 1

global _main
align 16

segment .text

_main:
   mov rcx, 0000000000000A30h; "0\n"
  
loopOne:
   cmp cl, '9'
   jg exit

   push rcx; 300A000000000000h

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   mov rsi, rsp
   mov rdx, 2
   syscall

   pop rcx

   inc cl; increment command. Adds one to a thing
   jmp loopOne

exit:
   mov rax, SYS_EXIT
   mov rdi, 0
   syscall