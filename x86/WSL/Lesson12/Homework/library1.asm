%define SYS_WRITE 4

%define STDOUT 1

global summateTwoNumbers
global divideTwoNumbers
global moduloTwoNumbers

segment .code

; numOne dword [ebp + 8]
; numTwo dword [ebp + 12]
summateTwoNumbers:
    push ebp
    mov ebp, esp
    sub esp, 2
    ; output byte [ebp - 2]
    push ebx

    mov eax, dword [ebp + 8]; numOne
    add eax, dword [ebp + 12]; numTwo
    add al, "0"
    mov byte [ebp - 2], al
    mov byte [ebp - 1], 10; newline

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    lea ecx, [ebp - 2]
    mov edx, 2
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

; numOne dword [ebp + 8]
; numTwo dword [ebp + 12]
divideTwoNumbers:
    push ebp
    mov ebp, esp
    sub esp, 2
    ; output byte [ebp - 2]
    push ebx

    mov eax, dword [ebp + 8]; numOne
    mov ebx, dword [ebp + 12]; numTwo
    xor edx, edx
    div ebx

    add al, "0"
    mov byte [ebp - 2], al
    mov byte [ebp - 1], 10; newline

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    lea ecx, [ebp - 2]
    mov edx, 2
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

; numOne dword [ebp + 8]
; numTwo dword [ebp + 12]
moduloTwoNumbers:
    push ebp
    mov ebp, esp
    sub esp, 2
    ; output byte [ebp - 2]
    push ebx

    mov eax, dword [ebp + 8]; numOne
    mov ebx, dword [ebp + 12]; numTwo
    xor edx, edx
    div ebx

    add dl, "0"
    mov byte [ebp - 2], dl
    mov byte [ebp - 1], 10; newline

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    lea ecx, [ebp - 2]
    mov edx, 2
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret