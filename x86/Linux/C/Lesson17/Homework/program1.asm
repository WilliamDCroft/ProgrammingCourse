extern stdin
extern stdout
extern fputs
extern fgets
extern atoi

global main

segment .data
    welcomeMessage     db "Welcome to the menu.", 10
                       db "Press 1 for the current weather.", 10
                       db "Press 2 for appointment reminders.", 10
                       db "Press 3 for a positive message", 10
                       db "$> ", 0
    weatherMessage     db "The weather is currently tornado levels od scary!", 10, 0
    appointmentMessage db "You have a doctors appointment on the 17th.", 10, 0
    positiveMessage    db "You are a good person. Have a pleasent day.", 10, 0

segment .text

main:
    push rbp
    push rbx
    mov rbp, rsp
    sub rsp, 118h
    ; szUserChoice byte [rbp - 256]
    ; userChoice   dword [rbp - 260]

    lea rdi, [rel welcomeMessage]
    mov rsi, [rel stdout]
    call fputs wrt ..plt


    lea rdi, [rbp - 256]; szUserChoice
    mov rsi, 256
    mov rdx, [rel stdin]
    call fgets wrt ..plt

    lea rdi, [rbp - 256]; szUserChoice
    call atoi wrt ..plt
    mov dword [rbp - 260], eax; userChoice

    mov ebx, 1
    cmp eax, ebx
    jne oneSkip

    lea rdi, [rel weatherMessage]
    mov rsi, [rel stdout]
    call fputs wrt ..plt

oneSkip:
    mov eax, dword [rbp - 260]; userChoice
    mov ebx, 2
    cmp eax, ebx
    jne twoSkip

    lea rdi, [rel appointmentMessage]
    mov rsi, [rel stdout]
    call fputs wrt ..plt

twoSkip:
    mov eax, dword [rbp - 260]; userChoice
    mov ebx, 3
    cmp eax, ebx
    jne threeSkip

    lea rdi, [rel positiveMessage]
    mov rsi, [rel stdout]
    call fputs wrt ..plt

threeSkip:
    xor eax, eax
    mov rsp, rbp
    pop rbx
    pop rbp
    ret

segment .note.GNU-stack noexec
