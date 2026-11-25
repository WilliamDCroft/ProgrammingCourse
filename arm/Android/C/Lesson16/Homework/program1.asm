.extern printf

.global main

.section .rodata
    floatValOne:  .float  3.14
    floatValTwo:  .float  17.24
    doubleValTwo: .double 4.17365789012
    message:      .ascii  "%f"
                  .byte   10, 0

.text

main:
    stp  x29, x30, [sp, #-16]!
    mov  x29, sp
    sub  sp, sp, #0x30
    // floatOne  [x29, #-4]
    // floatTwo  [x29, #-8]
    // resultOne [x29, #-12]
    // doubleOne [x29, #-20]
    // doubleTwo [x29, #-28]
    // resultTwo [x29, #-36]

    adrp x0, floatValOne
    ldr  s0, [x0, :lo12:floatValOne]
    str  s0, [x29, #-4] // floatOne

    adrp x0, floatValTwo
    ldr  s0, [x0, :lo12:floatValTwo]
    str  s0, [x29, #-8] // floatTwo

    ldr  s0, [x29, #-4] // floatOne
    ldr  s1, [x29, #-8] // floatTwo
    fadd s0, s0, s1
    str  s0, [x29, #-12] // resultOne

    adrp x0, message
    add  x0, x0, :lo12:message
    ldr  s0, [x29, #-12] // resultOne
    fcvt d0, s0
    bl printf

    ldr  s0, [x29, #-8] // floatTwo
    fcvt d0, s0
    str  d0, [x29, #-20] // doubleOne

    adrp x0, doubleValTwo
    ldr  d0, [x0, :lo12:doubleValTwo]
    str  d0, [x29, #-28] // doubleTwo

    ldr  d0, [x29, #-20] // doubleOne
    ldr  d1, [x29, #-28] // doubleTwo
    fmul d0, d0, d1
    str  d0, [x29, #-36] // resultTwo

    adrp x0, message
    add  x0, x0, :lo12:message
    ldr  d0, [x29, #-36] // resultTwo
    bl printf

    mov  w0, #0
    mov  sp, x29
    ldp  x29, x30, [sp], #16
    ret

// assembly instructions
// as -o program1.o program1.asm
// gcc -o program1 program1.o