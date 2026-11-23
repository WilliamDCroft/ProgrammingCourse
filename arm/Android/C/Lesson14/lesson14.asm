.extern printf

.global main

.data
    message: .ascii "x is %i"
             .byte  10
             .ascii "y is %i"
             .byte  10
             .ascii "z is %i"
             .byte  10
             .ascii "a is %i",
             .byte  10, 0
    x:       .word  3
.bss
    y:       .skip 4

.text

main:
    stp  x29, x30, [sp, #-16]!
    mov  x29, sp
    sub  sp, sp, #0x10
    // z [x29, #-4]

    adrp x0, y
    add  x0, x0, :lo12:y
    mov  w1, #4
    str  w1, [x0]

    mov  w1, #5
    str  w1, [x29, #-4] // z

    adrp x0, x
    add  x0, x0, :lo12:x
    ldr  w11, [x0] // a
    adrp x0, y
    add  x0, x0, :lo12:y
    ldr  w1, [x0]
    add  w11, w11, w1 // a
    ldr  w1, [x29, #-4]
    add  w11, w11, w1 // a


    adrp x0, message
    add  x0, x0, :lo12:message
    adrp x1, x
    add  x1, x1, :lo12:x
    ldr  w1, [x1]
    adrp x2, y
    add  x2, x2, :lo12:y
    ldr  w2, [x2]
    ldr  w3, [x29, #-4] // z
    mov  w4, w11 // a
    bl printf

    mov w0, #0
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret

// assembly instructions
// as -o lesson14.o lesson14.asm
// gcc -o lesson14 lesson14.o