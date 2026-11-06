extern printf: proc

.data
    message db "This is from a loop and counter is: %i", 10, 0

.code

main proc
    push rbp
    mov rbp, rsp
    sub rsp, 30h
    ; counter dword ptr [rbp - 4]

    mov dword ptr [rbp - 4], 5; counter
loopStart:
    inc dword ptr [rbp - 4]; counter

    lea rcx, message
    mov edx, dword ptr [rbp - 4]; counter
    call printf

    mov eax, dword ptr [rbp - 4]; counter
    mov ecx, 5
    cmp eax, ecx
    jl loopStart

loopEnd:
    xor eax, eax
    mov rsp, rbp
    pop rbp
    ret

main endp

end