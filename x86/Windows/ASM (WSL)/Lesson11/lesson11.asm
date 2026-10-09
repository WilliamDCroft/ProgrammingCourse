%define SYS_EXIT  1
%define SYS_WRITE 4

%define STDOUT 1

global _start

segment .data
    message db "Hello world! I am the greatest! muahahahaha! eheheheheh!", 0; we removed the newline!!!
    ;messageLength equ $ - message
    ;messageTwo db "This is a go", 10, 0

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

_start:
    push message
    call puts
    add esp, 4


    mov eax, SYS_EXIT
    mov ebx, 0
    int 80h