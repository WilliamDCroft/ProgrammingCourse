.extern stdout
.extern fputs

.global main

.section .rodata
    messageOne:   .asciz "x is 4!\n"
    messageTwo:   .asciz "y is 4!\n"
    messageThree: .asciz "x is NOT 4 and y is NOT four!\n"
    messageFour:  .asciz "That's the program!\n"

.text

main:
    stp  x29, x30, [sp, #-16]!
    mov  x29, sp
    sub  sp, sp, #0x10
    // x [x29, #-4]
    // y [x29, #-8]

    mov  w0, #5
    str  w0, [x29, #-4] // x
    str  w0, [x29, #-8] // y

    ldr  w0, [x29, #-4] // x
    cmp  w0, #4
    b.ne elseIfClause

    adrp x0, messageOne
    add  x0, x0, :lo12:messageOne
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs
    b    ifChainExit

elseIfClause:
    ldr  w0, [x29, #-8] // y
    cmp  w0, #4
    b.ne elseClause

    adrp x0, messageTwo
    add  x0, x0, :lo12:messageTwo
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs
    b    ifChainExit

elseClause:
    adrp x0, messageThree
    add  x0, x0, :lo12:messageThree
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

ifChainExit:
    adrp x0, messageFour
    add  x0, x0, :lo12:messageFour
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

    mov  w0, #0
    mov  sp, x29
    ldp  x29, x30, [sp], #16
    ret

// assembly instructions
// as -o lesson18c.o lesson18c.asm
// gcc -o lesson18c lesson18c.o