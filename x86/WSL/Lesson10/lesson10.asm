%define SYS_EXIT  1
%define SYS_WRITE 4

%define STDOUT 1

global _start

segment .code

_start:
    ; x      dword [ebp-4]
    ; y      dword [ebp-8]
    ; z      dword [ebp-12]
    ; output byte [ebp-14]
    push ebp
    mov ebp, esp
    sub esp, 14

    mov dword [ebp-4], 3; x
    mov dword [ebp-8], 4; y
    
    mov eax, dword [ebp-4]; x
    add eax, dword [ebp-8]; y
    mov dword [ebp-12], eax; z

    mov eax, dword [ebp-12]; z
    add al, '0'
    mov byte [ebp-14], al; output[0]
    mov byte [ebp-13], 10; output[1]

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    lea ecx, [ebp-14]
    mov edx, 2
    int 80h
    
    mov esp, ebp
    pop ebp

    mov eax, SYS_EXIT
    mov ebx, 0
    int 80h

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
