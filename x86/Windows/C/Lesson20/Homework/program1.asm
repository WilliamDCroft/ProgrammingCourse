extern __acrt_iob_func: proc
extern fputs          : proc
extern fgets          : proc
extern atoi           : proc

.data
    switchTableOne dq 6 dup (?)
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

.code

main proc
    push rbp
    mov rbp, rsp
    sub rsp, 130h
    ; szOption byte ptr [rbp - 256]
    ; option   dword ptr [rbp - 260]
    ; i        dword ptr [rbp - 264]

    lea rax, matchZero
    mov qword ptr [switchTableOne], rax

    lea rax, matchOne
    mov qword ptr [switchTableOne + 8], rax

    lea rax, matchTwo
    mov qword ptr [switchTableOne + 16], rax

    lea rax, matchThree
    mov qword ptr [switchTableOne + 24], rax

    lea rax, matchNone
    mov qword ptr [switchTableOne + 32], rax

forEverLoop:
    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, openingMessage
    call fputs

    mov rcx, 0
    call __acrt_iob_func
    mov r8, rax
    lea rcx, dword ptr [rbp - 256]; szOption
    mov rdx, 256
    call fgets

    lea rcx, dword ptr [rbp - 256]; szOption
    call atoi
    mov dword ptr [rbp - 260], eax; option

    ; switch logic time
    mov eax, dword ptr [rbp - 260]; option
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

    lea rcx, switchTableOne
    add rax, rcx
    jmp qword ptr [rax]

matchZero:
    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageOne
    call fputs
    jmp switchOneEnd

matchOne:
    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageTwo
    call fputs
    jmp switchOneEnd

matchTwo:
    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageThree
    call fputs
    jmp switchOneEnd

matchThree:
    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageFour
    call fputs

    mov rcx, 0
    call __acrt_iob_func
    mov r8, rax
    lea rcx, dword ptr [rbp - 256]; szOption
    mov rdx, 256
    call fgets

    lea rcx, dword ptr [rbp - 256]; szOption
    call atoi
    mov dword ptr [rbp - 260], eax; option

    mov dword ptr [rbp - 264], 0; i
forLoopOne:
    mov eax, dword ptr [rbp - 264]; i
    mov ecx, dword ptr [rbp - 260]; option
    cmp eax, ecx
    jge forLoopOneEnd
    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageFive
    call fputs
    inc dword ptr [rbp - 264]; i
    jmp forLoopOne

forLoopOneEnd:
    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, newLine
    call fputs
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
main endp

end