.extern puts

.equ SYS_EXIT, 93

.global _start

.data
    message: .asciz "Hello world!"

.text

_start:
    stp  x29, x30, [sp, -16]!
    mov  x29, sp

    adrp x0, message
    add  x0, x0, :lo12:message
    bl   puts

    mov  x0, 0
    mov  x8, #SYS_EXIT
    svc  #0

// assembly instructions
// as -o lesson13.o lesson13.asm
// gcc -nostartfiles -o lesson13 lesson13.o