extern __acrt_iob_func: proc
extern fputs          : proc
extern fgets          : proc
extern atoi           : proc

.data
    switchTableOne dq 6 dup (?)
    openingMessage db "1 being the worst and 5 being the best, what kinda day are you having?", 10
                   db "$> ", 0
    messageOne     db "Worst day.", 10, 0
    messageTwo     db "Bad day.", 10, 0
    messageThree   db "The day is okay.", 10, 0
    messageFour    db "Nice day.", 10, 0
    messageFive    db "Best day.", 10, 0
    messageSix     db "Invalid numer.", 10, 0

.code

main proc
    push rbp
    mov rbp, rsp
    sub rsp, 130h
    ; szOption byte ptr [rbp - 256]
    ; option   dword ptr [rbp - 260]

    lea rax, matchZero
    mov qword ptr [switchTableOne], rax

    lea rax, matchOne
    mov qword ptr [switchTableOne + 8], rax

    lea rax, matchTwo
    mov qword ptr [switchTableOne + 16], rax

    lea rax, matchThree
    mov qword ptr [switchTableOne + 24], rax

    lea rax, matchFour
    mov qword ptr [switchTableOne + 32], rax

    lea rax, matchNone
    mov qword ptr [switchTableOne + 40], rax

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
    mov eax, 5

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
    jmp switchOneEnd

matchFour:
    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageFive
    call fputs
    jmp switchOneEnd

matchNone:
    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageSix
    call fputs

switchOneEnd:
    xor eax, eax
    mov rsp, rbp
    pop rbp
    ret
main endp

end