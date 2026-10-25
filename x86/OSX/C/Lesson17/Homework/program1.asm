%pragma macho build_version macos,14,0

extern ___stdinp
extern ___stdoutp
extern _fputs
extern _fgets
extern _atoi

default rel

global _main

segment .data
   welcomeMessage     db "Welcome to the menu.", 10
                      db "Press 1 for the current weather.", 10
                      db "Press 2 for appointment reminders.", 10
                      db "Press 3 for a positive message", 10
                      db "$> ", 0
   weatherMessage     db "The weather is currently tornado levels of scary!", 10, 0
   appointmentMessage db "You have a doctors appointment on the 17th.", 10, 0
   positiveMessage    db "You are a good person. Have a pleasent day.", 10, 0

segment .text

_main:
   push rbp
   push rbx
   mov rbp, rsp
   sub rsp, 118h
  ; szUserChoice byte [rbp - 256]
  ; userChoice   dword [rbp - 260]

   lea rdi, [welcomeMessage]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

   lea rdi, [rbp - 256]; szUserChoice
   mov rsi, 256
   mov rdx, [rel ___stdinp wrt ..gotpcrel]
   mov rdx, [rdx]
   call _fgets

   lea rdi, [rbp - 256]; szUserChoice
   call _atoi
   mov dword [rbp - 260], eax; userChoice

   mov ebx, 1
   cmp eax, ebx
   jne oneSkip

   lea rdi, [weatherMessage]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

oneSkip:
   mov eax, dword [rbp - 260]; userChoice
   mov ebx, 2
   cmp eax, ebx
   jne twoSkip

   lea rdi, [appointmentMessage]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

twoSkip:
   mov eax, dword [rbp - 260]; userChoice
   mov ebx, 3
   cmp eax, ebx
   jne threeSkip

   lea rdi, [positiveMessage]
   mov rsi, [___stdoutp wrt ..gotpcrel]
   mov rsi, [rsi]
   call _fputs

threeSkip:
   xor eax, eax
   mov rsp, rbp
   pop rbx
   pop rbp
   ret