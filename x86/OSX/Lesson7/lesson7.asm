%pragma macho build_version macos,14,0

%define SYS_EXIT  0x02000001
%define SYS_WRITE 0x02000004

%define STDOUT 1

global _main
align 16

segment .bss
   output resb 2
   outputLength equ $ - output

segment .text

_main:
   mov byte [rel output+1], 10

   mov cl, 0
loopOne:
   cmp cl, 9
   jg exit

   add cl, '0'
   mov byte [rel output], cl

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel output]
   mov rdx, outputLength
   syscall

   mov cl, byte [rel output]
   sub cl, '0'

   inc cl; increment command. Adds one to a thing
   jmp loopOne

exit:
   mov rax, SYS_EXIT
   mov rdi, 0
   syscall