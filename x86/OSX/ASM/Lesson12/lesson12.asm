%pragma macho build_version macos,14,0

extern puts
extern atoi
extern secure_itoa

%define SYS_EXIT   0x02000001

global _main
align 16

segment .data
   message db "Hello world!", 0
   numberAsString db "4096", 0

segment .bss
   outputBuffer resb 4096

segment .text

_main:
   lea rdi, [rel numberAsString]
   call atoi

   cmp eax, 4096
   jne exit

   lea rdi, [rel message]
   call puts

   mov edi, 4123456789
   lea rsi, [rel outputBuffer]
   mov rdx, 4096
   call secure_itoa

   lea rdi, [rel outputBuffer]
   call puts

exit:
   mov rax, SYS_EXIT
   mov rdi, 0
   syscall