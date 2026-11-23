extern fputs
extern fgets
extern atoi
extern stdin
extern stdout

global main

segment .data
    openingMessage db "1 being the worst and 5 being the best, what kinda day are you having?", 10
                   db "$> ", 0
    messageOne     db "Worst day.", 10, 0
    messageTwo     db "Bad day.", 10, 0
    messageThree   db "The day is okay.", 10, 0
    messageFour    db "Nice day.", 10, 0
    messageFive    db "Best day.", 10, 0
    messageSix     db "Invalid numer.", 10, 0

segment .text

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

    mov eax, dword [rbp - 260]; option
    mov ecx, 1
    cmp eax, ecx
    jne ifChainTwo

    lea rdi, [rel messageOne]
    mov rsi, [rel stdout]
    call fputs wrt ..plt
    jmp ifChainEnd

ifChainTwo:
    mov eax, dword [rbp - 260]; option
    mov ecx, 2
    cmp eax, ecx
    jne ifChainThree

    lea rdi, [rel messageTwo]
    mov rsi, [rel stdout]
    call fputs wrt ..plt
    jmp ifChainEnd

ifChainThree:
    mov eax, dword [rbp - 260]; option
    mov ecx, 3
    cmp eax, ecx
    jne ifChainFour

    lea rdi, [rel messageThree]
    mov rsi, [rel stdout]
    call fputs wrt ..plt
    jmp ifChainEnd

ifChainFour:
    mov eax, dword [rbp - 260]; option
    mov ecx, 4
    cmp eax, ecx
    jne ifChainFive

    lea rdi, [rel messageFour]
    mov rsi, [rel stdout]
    call fputs wrt ..plt
    jmp ifChainEnd

ifChainFive:
    mov eax, dword [rbp - 260]; option
    mov ecx, 5
    cmp eax, ecx
    jne ifChainSix

    lea rdi, [rel messageFive]
    mov rsi, [rel stdout]
    call fputs wrt ..plt
    jmp ifChainEnd

ifChainSix:
    lea rdi, [rel messageSix]
    mov rsi, [rel stdout]
    call fputs wrt ..plt

ifChainEnd:
    xor eax, eax
    mov rsp, rbp
    pop rbp
    ret

segment .note.GNU-stack noexec
