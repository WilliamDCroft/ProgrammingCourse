%define SYS_EXIT  1
%define SYS_WRITE 4

%define STDOUT 1

global _start

segment .code

_start:
    mov ecx, 00000A30h; "0\n"
    
loopOne:
    cmp cl, '9'
    jg exit

    push ecx; 300A0000h

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, esp
    mov edx, 2
    int 80h

    pop ecx

    inc cl; increment command. Adds one to a thing
    jmp loopOne

exit:
    mov eax, SYS_EXIT
    mov ebx, 0
    int 80h