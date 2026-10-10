extern GetStdHandle: proc
extern WriteFile   : proc

.data
    iobuffer db 4096 dup (?)

.code

; dest rcx
; src  rdx
; n    r8
memcpy proc
    ; Leaf function, no invocation or shadow space needed
    ; preserve registers only, no frame needed
    push rdi
    push rsi
    
    mov rax, rcx

    mov rdi, rcx
    mov rsi, rdx
    mov rcx, r8
    rep movsb

    pop rsi
    pop rdi
    ret
memcpy endp

strlen proc
    ; Leaf function, no invocation or shadow space needed
    ; preserve registers only, no frame needed
    push rdi

    mov rdi, rcx
    mov al, 0
    mov rcx, 0FFFFFFFFFFFFFFFFh
    repne scasb
    not rcx
    dec rcx

    mov rax, rcx

    pop rdi
    ret
strlen endp

; str rcx
puts proc
    push rbp
    mov rbp, rsp
    sub rsp, 40h
    ; stringLength  dword ptr [rbp - 4]
    ; str           qword ptr [rbp - 12]
    ; nBytesWritten dword ptr [rbp - 16]
    mov qword ptr [rbp - 12], rcx; str

    call strlen
    mov dword ptr [rbp - 4], eax; stringLength

    lea rcx, iobuffer
    mov rdx, qword ptr [rbp - 12]; str
    mov r8, rax
    call memcpy

    mov eax, dword ptr [rbp - 4]; stringLength
    lea rdx, iobuffer
    mov byte ptr [rdx + rax], 10

    mov rcx, -11
    call GetStdHandle

    mov rcx, rax
    lea rdx, iobuffer
    mov r8d, dword ptr [rbp - 4]; stringLength
    inc r8d
    mov r9d, dword ptr [rbp - 16]; nBytesWritten
    mov qword ptr [rsp + 32], 0; LPOVERLAPPED
    call WriteFile

    mov eax, dword ptr [rbp - 16]; nBytesWritten

    mov rsp, rbp
    pop rbp
    ret
puts endp

; str rcx
atoi proc
    ; Leaf function, no invocation or shadow space needed
    ; preserve registers only, no frame needed
    push rbx
    push rdi

    mov rdi, rcx

    mov eax, 0
    mov ebx, 10
atoiLoop:
    cmp byte ptr [rdi], 0
    je atoiLoopEnd

    xor edx, edx
    mul ebx
    movzx ecx, byte ptr [rdi]
    sub cl, '0'
    add eax, ecx

    inc rdi

    jmp atoiLoop

atoiLoopEnd:
    pop rdi
    pop rbx
    ret
atoi endp

; value ecx
; str   rdx
; n     r8
secure_itoa proc
    push rbp
    mov rbp, rsp
    sub rsp, 40h
    ; value dword ptr [rbp - 4]
    ; str   qword ptr [rbp - 12]
    ; n     qword ptr [rbp - 20]
    push rbx
    push rdi
    push rsi

    mov dword ptr [rbp - 4], ecx; value
    mov qword ptr [rbp - 12], rdx; str
    mov qword ptr [rbp - 20], r8; n

    mov rdi, qword ptr [rbp - 12]; str
    mov esi, dword ptr [rbp - 20]; n

    ; Return immediately if buffer size n <= 1 (no space for digits + null terminator)
    cmp esi, 0
    jle secItoaExit

    cmp esi, 1
    je secItoaLoopTwoEnd

    mov eax, dword ptr [rbp - 4]; value
    mov rcx, 0
    mov ebx, 10

    ; if value is 0, handle this special case
    cmp eax, 0
    jne secItoaLoopOne
    push 0000000000000000h
    inc rcx
    jmp secItoaLoopOneEnd

secItoaLoopOne:
    cmp eax, 0
    je secItoaLoopOneEnd

    xor rdx, rdx
    div ebx
    push rdx
    inc rcx

    jmp secItoaLoopOne

secItoaLoopOneEnd:
    dec esi; n

secItoaLoopTwo:
    cmp rcx, 0
    jle secItoaLoopTwoEnd
    pop rax
    dec rcx

    cmp esi, 0; n
    jle secItoaLoopTwo

    add al, '0'
    mov byte ptr [rdi], al; str
    inc rdi
    dec esi
    jmp secItoaLoopTwo

secItoaLoopTwoEnd:
    mov byte ptr [rdi], 0

secItoaExit:
    pop rsi
    pop rdi
    pop rbx
    mov rsp, rbp
    pop rbp

    ret
secure_itoa endp

end