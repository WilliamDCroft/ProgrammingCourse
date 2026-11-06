extern printf: proc
.data
    message db "This is made fron a loop and the counter is at: %i", 10, 0

.code

main proc
    push rbp
    mov rbp, rsp
    sub rsp, 30h
    ; counter dword ptr [rbp - 4]

    mov dword ptr [rbp - 4], 0; counter

whileLoopStart:
    mov eax, dword ptr [rbp - 4]; counter
    mov ecx, 5
    cmp eax, ecx
    jge whileLoopEnd

    mov eax, dword ptr [rbp - 4]; counter
    mov ecx, 4
    cmp eax, ecx
    je whileLoopEnd

    inc dword ptr [rbp - 4]; counter

    mov eax, dword ptr [rbp - 4]; counter
    mov ecx, 1
    cmp eax, ecx
    je whileLoopStart

    lea rcx, message
    mov edx, dword ptr [rbp - 4]; counter
    call printf

    jmp whileLoopStart

whileLoopEnd:
    xor eax, eax
    mov rsp, rbp
    pop rbx
    ret
    
main endp

end