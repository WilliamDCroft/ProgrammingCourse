%pragma macho build_version macos,14,0

%define SYS_EXIT   0x02000001
%define SYS_WRITE  0x02000004

%define STDOUT 1

global _main
align 16

segment .data
   message db "Your luck number is: "
   messageLength equ $ - message
   newline db 10

segment .bss
   numberOne   resb 1
   numberTwo   resb 1
   numberThree resb 1
   numberFour  resb 1
   numberFive  resb 1
   numberSix   resb 1

segment .text

_main:

attemptRandOne:
   rdrand eax
   jnc attemptRandOne

  ; divide eax by 10
   mov edx, 0
   mov ebx, 10
   div ebx

   add dl, '0'
   mov byte [rel numberOne], dl

attemptRandTwo:
   rdrand eax
   jnc attemptRandTwo

  ; divide eax by 10
   mov edx, 0
   mov ebx, 10
   div ebx

   add dl, '0'
   mov byte [rel numberTwo], dl

attemptRandThree:
   rdrand eax
   jnc attemptRandThree

  ; divide eax by 10
   mov edx, 0
   mov ebx, 10
   div ebx

   add dl, '0'
   mov byte [rel numberThree], dl

attemptRandFour:
   rdrand eax
   jnc attemptRandFour

  ; divide eax by 10
   mov edx, 0
   mov ebx, 10
   div ebx

   add dl, '0'
   mov byte [rel numberFour], dl

attemptRandFive:
   rdrand eax
   jnc attemptRandFive

  ; divide eax by 10
   mov edx, 0
   mov ebx, 10
   div ebx
 
   add dl, '0'
   mov byte [rel numberFive], dl

attemptRandSix:
   rdrand eax
   jnc attemptRandSix

  ; divide eax by 10
   mov edx, 0
   mov ebx, 10
   div ebx

   add dl, '0'
   mov byte [rel numberSix], dl

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel message]
   mov rdx, messageLength
   syscall

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel numberOne]
   mov rdx, 1
   syscall

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel numberTwo]
   mov rdx, 1
   syscall

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel numberThree]
   mov rdx, 1
   syscall

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel numberFour]
   mov rdx, 1
   syscall

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel numberFive]
   mov rdx, 1
   syscall

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel numberSix]
   mov rdx, 1
   syscall

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel newline]
   mov rdx, 1
   syscall

   mov rax, SYS_EXIT
   xor rdi, rdi
   syscall