.extern printf

.global main

.section .rodata
    message: .asciz "This is from a loop and the counter is at: %i!\n"

.text

main:
    stp  x29, x30, [sp, #-16]!
    mov  x29, sp
    sub  sp, sp, #0x10
    // counter [x29, #-4]

    mov  w0, #0
    str  w0, [x29, #-4] // counter

whileLoopStart:
    ldr  w0, [x29, #-4] // counter
    cmp  w0, #5
    b.ge whileLoopEnd

    ldr  w0, [x29, #-4] // coumter
    cmp  w0, #4
    b.eq whileLoopEnd

    ldr  w0, [x29, #-4] // counter
    add  w0, w0, #1
    str  w0, [x29, #-4] // counter

    ldr  w0, [x29, #-4] // counter
    cmp  w0, #1
    b.eq whileLoopStart


    adrp x0, message
    add  x0, x0, :lo12:message
    ldr  x1, [x29, #-4] // counter
    bl   printf

    b    whileLoopStart

whileLoopEnd:
    mov  x0, #0
    mov  sp, x29
    ldp  x29, x30, [sp], #16
    ret

// assembly instructions
// as -o lesson18e.o lesson18e.asm
// gcc -o lesson18e lesson18e.o