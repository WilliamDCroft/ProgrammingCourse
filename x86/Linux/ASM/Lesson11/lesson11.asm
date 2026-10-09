%define SYS_EXIT  60
%define SYS_WRITE 1

%define STDOUT 1

global _start

segment .data
    message db "Hello world! I am the greatest! muahahahaha! eheheheheh!", 0; we removed the newline!!!
    ;messageLength equ $ - message
    ;messageTwo db "This is a go", 10, 0

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

_start:
    lea rdi, message
    call puts

    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
