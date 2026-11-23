extern fputs
extern fgets
extern atoi
extern stdin
extern stdout

global main

section .data
    switchTableOne dq matchZero, matchOne, matchTwo, matchThree, matchFour, matchNone
    openingMessage db "1 being the worst and 5 being the best, what kinda day are you having?", 10
                   db "$> ", 0
    messageOne     db "Worst day.", 10, 0
    messageTwo     db "Bad day.", 10, 0
    messageThree   db "The day is okay.", 10, 0
    messageFour    db "Nice day.", 10, 0
    messageFive    db "Best day.", 10, 0
    messageSix     db "Invalid numer.", 10, 0

section .text

main:
    push rbp
    mov rbp, rsp
    sub rsp, 110h
    ; szOption byte [rbp - 256]
    ; option   dword [rbp - 260]

    lea rdi, [rel openingMessage]
    mov rsi, [rel stdout]
    call fputs wrt ..plt

    lea rdi, dword [rbp - 256]; szOption
    mov rsi, 256
    mov rdx, [rel stdin]
    call fgets wrt ..plt

    lea rdi, dword [rbp - 256]; szOption
    call atoi wrt ..plt
    mov dword [rbp - 260], eax; option

    ; switch logic time
    mov eax, dword [rbp - 260]; option
    dec eax
    cmp eax, 0
    jl switchTableOneSetInvalid
    cmp eax, 4
    jg switchTableOneSetInvalid
    jmp switchTableOneChooser

switchTableOneSetInvalid:
    mov eax, 5

switchTableOneChooser:
    xor edx, edx
    mov ecx, 8
    mul ecx

    lea rcx, [rel switchTableOne]
    add rax, rcx
    jmp qword [rax]

matchZero:
    lea rdi, [rel messageOne]
    mov rsi, [rel stdout]
    call fputs wrt ..plt
    jmp switchOneEnd

matchOne:
    lea rdi, [rel messageTwo]
    mov rsi, [rel stdout]
    call fputs wrt ..plt
    jmp switchOneEnd

matchTwo:
    lea rdi, [rel messageThree]
    mov rsi, [rel stdout]
    call fputs wrt ..plt
    jmp switchOneEnd

matchThree:
    lea rdi, [rel messageFour]
    mov rsi, [rel stdout]
    call fputs wrt ..plt
    jmp switchOneEnd

matchFour:
    lea rdi, [rel messageFive]
    mov rsi, [rel stdout]
    call fputs wrt ..plt
    jmp switchOneEnd

matchNone:
    lea rdi, [rel messageSix]
    mov rsi, [rel stdout]
    call fputs wrt ..plt

switchOneEnd:
    xor eax, eax
    mov rsp, rbp
    pop rbp
    ret

segment .note.GNU-stack noexec
