%pragma macho build_version macos,14,0

%define SYS_EXIT  0x02000001
%define SYS_WRITE 0x02000004
%define SYS_TIME  0x02000074

%define STDOUT 1

global _main
align 16

segment .bss
   timeval resq 2
   result resb 2

segment .text

_main:
  ; prime newline
   lea rax, [rel result]
   inc rax
   mov byte [rax], 10

  ; get number of seconds since 1970-01-01 00:00:00 +0000 (UTC) in eax
   mov rax, SYS_TIME
   lea rdi, [rel timeval]
   syscall

  ; divide eax by 6
   mov rax, qword [rel timeval]
   xor rdx, rdx
   mov rbx, 6
   div rbx

  ; eax now contains a number from 0-5 in edx.
  ; Add one to get 1-6
   inc dl

  ; print the number
   add dl, '0'
   mov byte [rel result], dl
   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel result]
   mov rdx, 2
   syscall

   mov rax, SYS_EXIT
   xor rdi, rdi
   syscall