%define SYS_WRITE 1

%define STDOUT 1

global memcpy
global strlen
global puts
global atoi
global secure_itoa

segment .bss
    iobuffer resb 4096

segment .text

; dest rdi
; src  rsi
; n    rdx
memcpy:
    mov rcx, rdx; n
    rep movsb
    ret


; str rdi
strlen:
    mov rcx, 0FFFFFFFFFFFFFFFFh
    xor al, al
    repne scasb

    not rcx
    dec rcx

    mov rax, rcx

    ret

; str rdi
puts:
    push rbp
    mov rbp, rsp
    sub rsp, 10h
    ; str          qword [rbp - 8]
    ; stringLength qword [rbp - 16]

    mov qword [rbp - 8], rdi; str
    call strlen

    mov qword [rbp - 16], rax; stringLength

    lea rdi, iobuffer
    mov rsi, qword [rbp - 8]; str
    mov rdx, rax; stringLength
    call memcpy

    lea rdi, [iobuffer]
    add rdi, qword [rbp - 16]; stringLength
    mov byte [rdi], 10

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, iobuffer
    mov rdx, qword [rbp - 16]; stringLength
    inc rdx
    syscall
    
    mov rax, qword [rbp - 16]; stringLength
    mov rsp, rbp
    pop rbp

    ret

; str rdi
atoi:
    push rbp
    mov rbp, rsp
    push rbx

    mov eax, 0
    mov ebx, 10
atoiLoop:
    cmp byte [rdi], 0
    je atoiLoopEnd

    xor edx, edx
    mul ebx
    movzx ecx, byte [rdi]
    sub cl, '0'
    add eax, ecx

    inc rdi

    jmp atoiLoop

atoiLoopEnd:
    pop rbx
    mov rsp, rbp
    pop rbp

    ret

; value edi
; str   rsi
; n     rdx
secure_itoa:
    push rbp
    mov rbp, rsp
    sub rsp, 20h
    ; value dword [rbp - 4]
    ; str   qword [rbp - 12]
    ; n     qword [rbp - 20]
    push rbx

    mov dword [rbp - 4], edi; value
    mov qword [rbp - 12], rsi; str
    mov qword [rbp - 20], rdx; n

    mov rdi, qword [rbp - 12]; str
    mov esi, dword [rbp - 20]; n

    ; Return immediately if buffer size n <= 1 (no space for digits + null terminator)
    cmp esi, 0
    jle secItoaExit

    cmp esi, 1
    je secItoaLoopTwoEnd

    mov eax, dword [rbp - 4]; value
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
    mov byte [rdi], al; str
    inc rdi
    dec esi
    jmp secItoaLoopTwo

secItoaLoopTwoEnd:
    mov byte [rdi], 0

secItoaExit:
    pop rbx
    mov rsp, rbp
    pop rbp

    ret

segment .note.GNU-stack noexec; added for C linkage
