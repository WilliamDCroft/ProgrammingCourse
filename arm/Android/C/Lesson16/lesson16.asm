.extern printf

.global main

.section .rodata
    doublePiValue: .double 3.14159265
    floatValOne:   .float  52.0
    floatValTwo:   .float  15.0
    messageOne:    .asciz  "%.8f\n"
    messageTwo:    .asciz  "%i %i/%i\n"
    messageThree:  .asciz  "%f\n"

.text

main:
    stp  x29, x30, [sp, #-16]!
    mov  x29, sp
    sub  sp, sp, #0x20
    // doublePrecisionPi [x29, #-8]
    // myWholeNumber     [x29, #-12]
    // myDenominator     [x29, #-16]
    // myRemainder       [x29, #-20]
    // myFloat           [x29, #-24]

    adrp x0, doublePiValue
    ldr  d0, [x0, :lo12:doublePiValue]
    str  d0, [x29, #-8] // doublePrecisionPi

    adrp x0, messageOne
    add  x0, x0, :lo12:messageOne
    ldr  d0, [x29, #-8] // doublePrecisionPi
    bl   printf

    mov  w0, #15
    str  w0, [x29, #-16] // myDenominator

    mov  w0, #52
    ldr  w1, [x29, #-16] // myDenominator
    udiv w2, w0, w1
    msub w3, w1, w2, w0

    str  w2, [x29, #-12] // myWholeNumber
    str  w3, [x29, #-20] // myRemainder

    adrp x0, messageTwo
    add  x0, x0, :lo12:messageTwo
    ldr  w1, [x29, #-12]
    ldr  w2, [x29, #-20]
    ldr  w3, [x29, #-16]
    bl   printf

    adrp x8, floatValOne
    ldr  s0, [x8, :lo12:floatValOne]
    adrp x8, floatValTwo
    ldr  s1, [x8, :lo12:floatValTwo]

    fdiv s0, s0, s1
    str  s0, [x29, #-24] // myFloat

    adrp x0, messageThree
    add  x0, x0, :lo12:messageThree
    ldr  s0, [x29, #-24] // myFloat
    fcvt d0, s0
    bl   printf

    mov  w0, #0
    mov  sp, x29
    ldp  x29, x30, [sp], #16
    ret

// assembly instructions
// as -o lesson16.o lesson16.asm
// gcc -o lesson16 lesson16.o