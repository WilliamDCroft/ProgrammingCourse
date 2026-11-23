.extern puts

.global main

.data
    message: .asciz "Hello world!"

.text

main:
    stp  x29, x30, [sp, -16]!
    mov  x29, sp

    adrp x0, message
    add  x0, x0, :lo12:message
    bl   puts

    mov  w0, 0
    ldp  x29, x30, [sp], 16
    ret

// assembly instructions
// as -o lesson13b.o lesson13b.asm
// gcc -o lesson13b lesson13b.o