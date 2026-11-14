extern __acrt_iob_func: proc
extern fputs          : proc
extern fgets          : proc
extern atoi           : proc

.data
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

    mov eax, dword ptr [rbp - 260]; option
    mov ecx, 1
    cmp eax, ecx
    jne ifChainTwo

    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageOne
    call fputs
    jmp ifChainEnd

ifChainTwo:
    mov eax, dword ptr [rbp - 260]; option
    mov ecx, 2
    cmp eax, ecx
    jne ifChainThree

    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageTwo
    call fputs
    jmp ifChainEnd

ifChainThree:
    mov eax, dword ptr [rbp - 260]; option
    mov ecx, 3
    cmp eax, ecx
    jne ifChainFour

    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageThree
    call fputs
    jmp ifChainEnd

ifChainFour:
    mov eax, dword ptr [rbp - 260]; option
    mov ecx, 4
    cmp eax, ecx
    jne ifChainFive

    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageFour
    call fputs
    jmp ifChainEnd

ifChainFive:
    mov eax, dword ptr [rbp - 260]; option
    mov ecx, 5
    cmp eax, ecx
    jne ifChainSix

    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageFive
    call fputs
    jmp ifChainEnd

ifChainSix:
    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, messageSix
    call fputs

ifChainEnd:
    xor eax, eax
    mov rsp, rbp
    pop rbp
    ret
main endp

end