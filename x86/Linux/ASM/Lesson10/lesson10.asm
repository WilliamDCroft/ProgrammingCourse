%define SYS_EXIT  60
%define SYS_WRITE 1

%define STDOUT 1

global _start

segment .text

_start:
    ; x      dword [rbp-4]
    ; y      dword [rbp-8]
    ; z      dword [rbp-12]
    ; output byte [rbp-14]
    push rbp
    mov rbp, rsp
    sub rsp, 10h

    mov dword [rbp-4], 3; x
    mov dword [rbp-8], 4; y
    
    mov eax, dword [rbp-4]; x
    add eax, dword [rbp-8]; y
    mov dword [rbp-12], eax; z

    mov eax, dword [rbp-12]; z
    add al, '0'
    mov byte [rbp-14], al; output[0]
    mov byte [rbp-13], 10; output[1]

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    lea rsi, [rbp-14]
    mov rdx, 2
    syscall
    
    mov rsp, rbp
    pop rbp

    mov rax, SYS_EXIT
    mov rdi, 0
    syscall

; variable x as integer
; variable y as integer
; variable z as integer
; variable output as 2 byte string
; x = 3
; y = 4
; z = x + y
; output = z as string with newline
; print output

; 21321 / (3 + 4) * 52

; 21321 3 4 + 52 * /
;
; / * 52 + 4 3 21321

; push 21321
; push 3
; push 4
; pop reg2
; pop reg1
; add reg1, reg2
; push reg1
; push 52
; pop reg2
; pop reg1
; mul reg1, reg2
; push reg1
; pop reg2
; pop reg1
; div reg1, reg2

; + 4 3
; + 4 3
; / * 52 + 4 3 21321

; PEMDAS
; BODMAS
; PEMA

;2 + -3
;2 - 3

;4 / 5
;4 * .2
