%define SYS_WRITE 4

%define STDOUT 1

global memcpy
global strlen
global puts
global atoi
global secure_itoa

segment .bss
    iobuffer resb 4096

segment .code

; dest dword [ebp + 8]
; src  dword [ebp + 12]
; n    dword [ebp + 16]
memcpy:
    push ebp
    mov ebp, esp
    push esi
    push edi

    mov esi, dword [ebp + 12]; src
    mov edi, dword [ebp + 8]; dest
    mov ecx, dword [ebp + 16]; n

    rep movsb

    pop edi
    pop esi
    mov esp, ebp
    pop ebp

    ret

; str dword [ebp + 8]
strlen:
    push ebp
    mov ebp, esp
    push edi

    mov ecx, 0FFFFFFFFh
    mov edi, dword [ebp + 8]; str
    xor al, al
    repne scasb

    not ecx
    dec ecx

    mov eax, ecx

    pop edi
    mov esp, ebp
    pop ebp

    ret

; str dword [ebp + 8]
puts:
    push ebp
    mov ebp, esp
    sub esp, 4
    ; stringLength dword [ebp - 4]
    push edi

    push dword [ebp + 8]
    call strlen
    add esp, 4

    mov dword [ebp - 4], eax; stringLength

    push eax
    push dword [ebp + 8]; str
    push iobuffer
    call memcpy
    add esp, 12

    lea edi, [iobuffer]
    add edi, dword [ebp - 4]; stringLength
    mov byte [edi], 10

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, iobuffer
    mov edx, dword [ebp - 4]; stringLength
    inc edx
    int 80h
    
    pop edi
    mov esp, ebp
    pop ebp

    ret

; str dword [ebp + 8]
atoi:
    push ebp
    mov ebp, esp
    push ebx
    push edi

    mov edi, dword [ebp + 8]; str

    mov eax, 0
    mov ebx, 10
atoiLoop:
    cmp byte [edi], 0
    je atoiLoopEnd

    xor edx, edx
    mul ebx
    movzx ecx, byte [edi]
    sub cl, '0'
    add eax, ecx

    inc edi

    jmp atoiLoop

atoiLoopEnd:
    pop edi
    pop ebx
    mov esp, ebp
    pop ebp

    ret

; value dword [ebp + 8]
; str   dword [ebp + 12]
; n     dword [ebp + 16]
secure_itoa:
    push ebp
    mov ebp, esp
    push ebx
    push edi
    push esi

    mov edi, dword [ebp + 12] ; str
    mov esi, dword [ebp + 16] ; n

    ; Return immediately if buffer size n <= 1 (no space for digits + null terminator)
    cmp esi, 0
    jle secItoaExitEarly

    cmp esi, 1
    je secItoaLoopTwoEnd

    mov eax, dword [ebp + 8]; value
    mov ecx, 0
    mov ebx, 10

    ; if value is 0, handle this special case
    cmp eax, 0
    jne secItoaLoopOne
    push 0
    inc ecx
    jmp secItoaLoopOneEnd

secItoaLoopOne:
    cmp eax, 0
    je secItoaLoopOneEnd

    xor edx, edx
    div ebx
    push edx
    inc ecx

    jmp secItoaLoopOne

secItoaLoopOneEnd:
    dec esi

secItoaLoopTwo:
    cmp ecx, 0
    jle secItoaLoopTwoEnd
    pop eax
    dec ecx

    cmp esi, 0
    jle secItoaLoopTwo

    add al, '0'
    mov byte [edi], al
    inc edi
    dec esi
    jmp secItoaLoopTwo

secItoaLoopTwoEnd:
    mov byte [edi], 0

secItoaExitEarly:
    pop esi
    pop edi
    pop ebx
    mov esp, ebp
    pop ebp

    ret