%pragma macho build_version macos,14,0

%define SYS_EXIT   0x02000001
%define SYS_READ   0x02000003
%define SYS_WRITE  0x02000004

%define STDIN  0
%define STDOUT 1

global _main
align 16

segment .data
   openingMessage db "Guess a number from 1 to 6: "
   openingMessageLength equ $ - openingMessage
   youWinMessage db "You got it!", 10
   youWinMessageLength equ $ - youWinMessage
   tooLowMessage db "Too low! Try again: "
   tooLowMessageLength equ $ - tooLowMessage
   tooHighMessage db "Too High! Try again: "
   tooHighMessageLength equ $ - tooHighMessage

segment .bss
   someNumber resb 1
   userGuess resb 2
   userGuessLength equ $ - userGuess

segment .text

_main:
   rdrand eax
   jnc _main

   mov ebx, 6
   xor edx, edx
   div ebx
   inc dl
   add dl, '0'
   mov byte [rel someNumber], dl

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel openingMessage]
   mov rdx, openingMessageLength
   syscall

mainLoop:
   mov rax, SYS_READ
   mov rdi, STDIN
   lea rsi, [rel userGuess]
   mov rdx, userGuessLength
   syscall

   mov al, byte [rel userGuess]
   cmp al, byte [rel someNumber]
   jl tooLow
   jg tooHigh

   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel youWinMessage]
   mov rdx, youWinMessageLength
   syscall

   mov rax, SYS_EXIT
   mov rdi, 0
   syscall

tooLow:
   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel tooLowMessage]
   mov rdx, tooLowMessageLength
   syscall

   jmp mainLoop

tooHigh:
   mov rax, SYS_WRITE
   mov rdi, STDOUT
   lea rsi, [rel tooHighMessage]
   mov rdx, tooHighMessageLength
   syscall

   jmp mainLoop