%pragma macho build_version macos,14,0

%define SYS_EXIT  0x02000001
%define SYS_READ  0x02000003
%define SYS_WRITE 0x02000004

%define STDIN 0
%define STDOUT 1

global _main
align 16

segment .bss
   input resb 2
   inputLength equ $ - input

segment .data
   message db "Please enter the number 1 or 2 -> "
   messageLength equ $ - message
   output db 0, 10
   outputLength equ $ - output

segment .text

_main:
   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel message]
   mov rdx, messageLength
   syscall

   mov rax, SYS_READ
   mov rdi, STDIN
   lea rsi, [rel input]
   mov rdx, inputLength
   syscall

   cmp byte [rel input], '1'
   je loopTwoStart

   mov ecx, '9'
loopOne:
   cmp cl, '0'
   jl exit

   mov byte [rel output], cl

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel output]
   mov rdx, outputLength
   syscall

   mov cl, byte [rel output]

   dec ecx
   jmp loopOne

loopTwoStart:
   mov ecx, '0'
loopTwo:
   cmp cl, '9'
   jg exit

   mov byte [rel output], cl

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel output]
   mov rdx, outputLength
   syscall

   mov cl, byte [rel output]

   inc ecx
   jmp loopTwo

exit:
   mov rax, SYS_EXIT
   xor rdi, rdi
   syscall