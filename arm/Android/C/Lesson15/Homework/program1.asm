.extern stdout
.extern stdin
.extern fputs
.extern fgets

.global main

.data
    message:    .asciz "Type a message: "
    messageTwo: .asciz "Your message is: "

.text

main:
    stp  x29, x30, [sp, #-16]!
    mov  x29, sp
    sub  sp, sp, #0x100
    // buffer [x29, #-256]

    adrp x0, message
    add  x0, x0, :lo12:message
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl fputs

    sub  x0, x29, #256
    mov  x1, #256
    adrp x2, :got:stdin
    ldr  x2, [x2, :got_lo12:stdin]
    ldr  x2, [x2]
    bl fgets

    adrp x0, messageTwo
    add  x0, x0, :lo12:messageTwo
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl fputs

    sub  x0, x29, #256
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl fputs

    mov  w0, #0
    mov  sp, x29
    ldp  x29, x30, [sp], #16
    ret

// assembly instructions
// as -o program1.o program1.asm
// gcc -o program1 program1.o