.global _syscall

.text

_syscall:
    mov  x9, x8
    mov  x8, x0
    mov  x0, x1
    mov  x1, x2
    mov  x2, x3
    mov  x3, x4
    mov  x4, x5
    mov  x5, x6
    mov  x6, x7
    mov  x7, x9
    svc  #0
    ret

// assembly instructions
// as -o kernelcalllib.o kernelcalllib.asm
// gcc -nostartfiles -o lesson13d lesson13d.c kernelcalllib.o