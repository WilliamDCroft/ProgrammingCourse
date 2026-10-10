%pragma macho build_version macos,14,0

global _syscall

segment .text

; syscall rdi
; arg1 rsi
; arg2 rdx
; arg3 rcx
_syscall:
   push rbp
   mov rax, rdi
   mov rdi, rsi
   mov rsi, rdx
   mov rdx, rcx
   syscall
   pop rbp
   ret