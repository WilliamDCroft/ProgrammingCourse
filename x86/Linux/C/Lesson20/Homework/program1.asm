extern fputs
extern fgets
extern atoi
extern stdin
extern stdout

global main

segment .data
    switchTableOne dq matchZero, matchOne, matchTwo, matchThree, matchNone
    openingMessage db "Welcome to the menu.", 10 
                   db "Press 1 for the current weather.", 10
                   db "Press 2 for appointment reminders.", 10
                   db "Press 3 for a positive message.", 10
                   db "Press 4 to hear a fact about beetles.", 10
                   db "Type anything else to exit.", 10
                   db "$> ", 0
    messageOne     db "The weather is tornado levels of scary!", 10, 10, 0
    messageTwo     db "You have a doctors appointment on the 17th.", 10, 10, 0
    messageThree   db "You are a good person. Have a pleasent day.", 10, 10, 0
    messageFour    db "And how many times would you like to hear this fact?", 10
                   db "$> ", 0
    messageFive    db "Beatles have wings!!!", 10, 0
    newLine        db 10, 0

segment .text

main:
    push rbp
    mov rbp, rsp
    sub rsp, 110h
    ; szOption byte ptr [rbp - 256]
    ; option   dword ptr [rbp - 260]
    ; i        dword ptr [rbp - 264]

forEverLoop:
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
    mov eax, 4

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

    lea rdi, dword [rbp - 256]; szOption
    mov rsi, 256
    mov rdx, [rel stdin]
    call fgets wrt ..plt

    lea rdi, dword [rbp - 256]; szOption
    call atoi wrt ..plt
    mov dword [rbp - 260], eax; option

    mov dword [rbp - 264], 0; i
forLoopOne:
    mov eax, dword [rbp - 264]; i
    mov ecx, dword [rbp - 260]; option
    cmp eax, ecx
    jge forLoopOneEnd
    lea rdi, [rel messageFive]
    mov rsi, [rel stdout]
    call fputs wrt ..plt
    inc dword [rbp - 264]; i
    jmp forLoopOne

forLoopOneEnd:
    lea rdi, [rel newLine]
    mov rsi, [rel stdout]
    call fputs wrt ..plt
    jmp switchOneEnd

matchNone:
    jmp foreverLoopExit
switchOneEnd:
    jmp forEverLoop

foreverLoopExit:
    xor eax, eax
    mov rsp, rbp
    pop rbp
    ret

segment .note.GNU-stack noexec
