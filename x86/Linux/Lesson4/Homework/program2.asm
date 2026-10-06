global _start

segment .text

_start:
   mov ax, 1
   mov dx, 2
   mov ax, 3
   mov bx, 4

   mov rax, 60
   mov rdi, 0
   syscall
