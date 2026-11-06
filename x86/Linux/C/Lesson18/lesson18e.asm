extern printf

global main

segment .data 
    message db "This is from a loop and the counter is at: %i!", 10, 0

segment .text

main:
    push rbp
    mov rbp, rsp
    sub rsp, 10h
    ; counter dword [rbp - 4]

    mov dword [rbp - 4], 0; counter

whileLoopStart:
    mov eax, dword [rbp - 4]; counter
    mov ecx, 5
    cmp eax, ecx
    jge whileLoopEnd

    mov eax, dword [rbp - 4]; counter
    mov ecx, 4
    cmp eax, ecx
    je whileLoopEnd

    inc dword [rbp - 4]; counter
    
    mov eax, dword [rbp - 4]
    mov ecx, 1
    cmp eax, ecx
    je whileLoopStart

    xor rax, rax
    lea rdi, [rel message]
    mov esi, dword [rbp - 4]; counter
    call printf wrt ..plt

    jmp whileLoopStart

whileLoopEnd:
    xor eax, eax
    mov rsp, rbp
    pop rbp
    ret

segment .note.GNU-stack noexec
