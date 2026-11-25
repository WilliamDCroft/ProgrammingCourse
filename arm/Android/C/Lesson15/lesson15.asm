.extern stdout
.extern stdin
.extern fputs
.extern fgets

.global main

.data
    message: .asciz "Type a character: "

.text

main:
    stp  x29, x30, [sp, #-16]!
    mov  x29, sp
    sub  sp, sp, #0x10
    // buffer [x29, #-3]

    adrp x0, message
    add  x0, x0, :lo12:message
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl fputs

    sub  x0, x29, #3
    mov  x1, #3
    adrp x2, :got:stdin
    ldr  x2, [x2, :got_lo12:stdin]
    ldr  x2, [x2]
    bl fgets

    ldrb w0, [x29, #-3]
    add  w0, w0, #1
    strb w0, [x29, #-3]

    sub  x0, x29, #3
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl fputs

    mov  sp, x29
    ldp  x29, x30, [sp], #16
    mov  w0, #0
    ret

// assembly instructions
// as -o lesson15.o lesson15.asm
// gcc -o lesson15 lesson15.o