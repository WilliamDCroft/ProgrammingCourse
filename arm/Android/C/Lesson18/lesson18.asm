.extern stdout
.extern fputs

.global main

.section .rodata
    messageOne:   .asciz "x is 4!\n"
    messageTwo:   .asciz "x is NOT 4!\n"
    messageThree: .asciz "That's the program!\n"

.text

main:
    stp  x29, x30, [sp, #16]!
    mov  x29, sp
    sub  sp, sp, #0x10
    // x [x29, #-4]

    mov  w0, #3
    str  w0, [x29, #-4] // x

    ldr  w0, [x29, #-4] // x
    cmp  w0, #4
    b.ne elseClause

    adrp x0, messageOne
    add  x0, x0, :lo12:messageOne
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs
    b    ifChainExit

elseClause:
    adrp x0, messageTwo
    add  x0, x0, :lo12:messageTwo
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

ifChainExit:
    adrp x0, messageThree
    add  x0, x0, :lo12:messageThree
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

    mov  w0, #0
    mov  sp, x29
    ldp  x29, x30, [sp], #16
    ret

// assembly instruction
// as -o lesson18.o lesson18.asm
// gcc -o lesson18 lesson18.o