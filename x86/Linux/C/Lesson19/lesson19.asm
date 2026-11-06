extern printf: proc

global main

segment .data
    message db "This is from a loop and counter is: %i", 10, 0

segment .text

main:
    push rbp
    mov rbp, rsp
    sub rsp, 10h
    ; counter dword [rbp - 4]

    mov dword [rbp - 4], 5; counter
loopStart:
    inc dword [rbp - 4]; counter

    lea rdi, [rel message]
    mov esi, dword [rbp - 4]; counter
    call printf wrt ..plt

    mov eax, dword [rbp - 4]; counter
    mov ecx, 5
    cmp eax, ecx
    jl loopStart

loopEnd:
    xor eax, eax
    mov rsp, rbp
    pop rbp
    ret

segment .note.GNU-stack noexec
