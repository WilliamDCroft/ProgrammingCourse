extern __acrt_iob_func: proc
extern fputs          : proc

.data
    messageOne    db "x equals 3.", 10, 0
    messageTwo    db "x is less than y.", 10, 0
    messageThree  db "c is greater than y.", 10, 0
    messageFour   db "y is less than or equal to b.", 10, 0
    messageFive   db "y is greater than or equal to b.", 10, 0
    messageSix    db "x is not equal to 5.", 10, 0
    messageSeven  db "x does not ", 34, "exist", 34, ".", 10, 0
    messageEight  db "x ", 34, "exists", 34, ".", 10, 0
    messageNine   db "x is 3 AND y is 4.", 10, 0
    messageTen    db "x is 3 OR y is 5.", 10, 0
    messageEleven db "z is 5 at the same time that either x is 3 or y is 5.", 10, 0

.code

main proc
    push rbp
    push rbx
    mov rbp, rsp
    sub rsp, 48h
    ; x dword ptr [rbp - 4]
    ; y dword ptr [rbp - 8]
    ; z dword ptr [rbp - 12]
    ; a dword ptr [rbp - 16]
    ; b dword ptr [rbp - 20]
    ; c dword ptr [rbp - 24]

    mov dword ptr [rbp - 4],  3; x
    mov dword ptr [rbp - 8],  4; y
    mov dword ptr [rbp - 12], 5; z
    mov dword ptr [rbp - 16], 3; a
    mov dword ptr [rbp - 20], 4; b
    mov dword ptr [rbp - 24], 5; c

    mov eax, dword ptr [rbp - 4]; x
    mov ebx, 3
    cmp eax, ebx
    jne equalsSkip

    mov rcx, 1
    call __acrt_iob_func

    mov rdx, rax
    lea rcx, messageOne
    call fputs

equalsSkip:
    mov eax, dword ptr [rbp - 4]; x
    mov ebx, dword ptr [rbp - 8]; y
    cmp eax, ebx
    jge lessThanSkip

    mov rcx, 1
    call __acrt_iob_func

    mov rdx, rax
    lea rcx, messageTwo
    call fputs

lessThanSkip:
    mov eax, dword ptr [rbp - 24]; c
    mov ebx, dword ptr [rbp - 8]; y
    cmp eax, ebx
    jle greaterThanSkip

    mov rcx, 1
    call __acrt_iob_func

    mov rdx, rax
    lea rcx, messageThree
    call fputs

greaterThanSkip:
    mov eax, dword ptr [rbp - 8]; y
    mov ebx, dword ptr [rbp - 20]; b
    cmp eax, ebx
    jg lessThanOrEqualSkip

    mov rcx, 1
    call __acrt_iob_func

    mov rdx, rax
    lea rcx, messageFour
    call fputs

lessThanOrEqualSkip:
    mov eax, dword ptr [rbp - 8]; y
    mov ebx, dword ptr [rbp - 20]; b
    cmp eax, ebx
    jl greaterThanOrEqualToSkip

    mov rcx, 1
    call __acrt_iob_func

    mov rdx, rax
    lea rcx, messageFive
    call fputs

greaterThanOrEqualToSkip:
    mov eax, dword ptr [rbp - 4]; x
    mov ebx, 5
    cmp eax, ebx
    je notEqualToSkip

    mov rcx, 1
    call __acrt_iob_func

    mov rdx, rax
    lea rcx, messageSix
    call fputs

notEqualToSkip:
    mov eax, dword ptr [rbp - 4]; x
    mov ebx, 0
    cmp eax, ebx
    jne notSkip

    mov rcx, 1
    call __acrt_iob_func

    mov rdx, rax
    lea rcx, messageSeven
    call fputs

notSkip:
    mov eax, dword ptr [rbp - 4]; x
    mov ebx, 0
    cmp eax, ebx
    je existsSkip

    mov rcx, 1
    call __acrt_iob_func

    mov rdx, rax
    lea rcx, messageEight
    call fputs

existsSkip:
    mov eax, dword ptr [rbp - 4]; x
    mov ebx, 3
    cmp eax, ebx
    jne andSkip
    mov eax, dword ptr [rbp - 8]; y
    mov ebx, 4
    cmp eax, ebx
    jne andSkip
    
    mov rcx, 1
    call __acrt_iob_func

    mov rdx, rax
    lea rcx, messageNine
    call fputs

andSkip:
    mov eax, dword ptr [rbp - 4]; x
    mov ebx, 3
    cmp eax, ebx
    je orShortcut
    mov eax, dword ptr [rbp - 8]; y
    mov ebx, 5
    cmp eax, ebx
    jne orSkip

orShortcut:
    mov rcx, 1
    call __acrt_iob_func

    mov rdx, rax
    lea rcx, messageTen
    call fputs

orSkip:
    mov eax, dword ptr [rbp - 4]; x
    mov ebx, 3
    cmp eax, ebx
    je dasiyShortcut
    mov eax, dword ptr [rbp - 8]; y
    mov ebx, 5
    cmp eax, ebx
    jne daisySkip

dasiyShortcut:
    mov eax, dword ptr [rbp - 12]; z
    mov ebx, 5
    cmp eax, ebx
    jne daisySkip

    mov rcx, 1
    call __acrt_iob_func

    mov rdx, rax
    lea rcx, messageEleven
    call fputs

daisySkip:
    mov rsp, rbp
    pop rbx
    pop rbp
    xor eax, eax
    ret
main endp

end