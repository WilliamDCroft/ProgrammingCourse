.extern fputs
.extern stdout

.global main

.section .rodata
    messageOne:    .ascii "x and a are equal."
                   .byte  10, 0
    messageTwo:    .ascii "x is less than y."
                   .byte  10, 0
    messageThree:  .ascii "c is greater than x."
                   .byte  10, 0
    messageFour:   .ascii "y is less than or equal to b."
                   .byte  10, 0
    messageFive:   .ascii "y is greater than or equal to b."
                   .byte  10, 0
    messageSix:    .ascii "x is not equal to y."
                   .byte  10, 0
    messageSeven:  .ascii "x does not "
                   .byte  34
                   .ascii "exist"
                   .byte  34
                   .ascii "."
                   .byte  10, 0
    messageEight:  .ascii "x "
                   .byte  34
                   .ascii "exists"
                   .byte  34
                   .ascii "."
                   .byte  10, 0
    messageNine:   .ascii "x is 3 AND y is 4."
                   .byte  10, 0
    messageTen:    .ascii "x is 3 OR y is 5."
                   .byte  10, 0
    messageEleven: .ascii "z is 5 at the same time that either x is 3 or y is 5."
                   .byte  10, 0

.text

main:
    stp  x29, x30, [sp, #-16]!
    mov  x29, sp
    sub  sp, sp, #0x20
    // x [x29 #-4]
    // y [x29 #-8]
    // z [x29 #-12]
    // a [x29 #-16]
    // b [x29 #-20]
    // c [x29 #-24]

    mov  w0, #3
    str  w0, [x29, #-4] // x
    mov  w0, #4
    str  w0, [x29, #-8] // y
    mov  w0, #5
    str  w0, [x29, #-12] // z
    mov  w0, #3
    str  w0, [x29, #-16] // a
    mov  w0, #4
    str  w0, [x29, #-20] // b
    mov  w0, #5
    str  w0, [x29, #-24] // c

    ldr  w0, [x29, #-4] // x
    ldr  w1, [x29, #-16] // a
    cmp  w0, w1
    b.ne equalSkip

    adrp x0, messageOne
    add  x0, x0, :lo12:messageOne
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

equalSkip:
    ldr  w0, [x29, #-4] // x
    ldr  w1, [x29, #-8] // y
    cmp  w0, w1
    b.ge lessThanSkip

    adrp x0, messageTwo
    add  x0, x0, :lo12:messageTwo
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

lessThanSkip:
    ldr  w0, [x29, #-24] // c
    ldr  w1, [x29, #-4] // x
    cmp  w0, w1
    b.le greaterThanSkip

    adrp x0, messageThree
    add  x0, x0, :lo12:messageThree
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

greaterThanSkip:
    ldr  w0, [x29, #-8] // y
    ldr  w1, [x29, #-20] // b
    cmp  w0, w1
    b.gt lessThanOrEqualSkip

    adrp x0, messageFour
    add  x0, x0, :lo12:messageFour
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

lessThanOrEqualSkip:
    ldr  w0, [x29, #-8] // y
    ldr  w1, [x29, #-20] // b
    cmp  w0, w1
    b.lt greaterThanOrEqualSkip

    adrp x0, messageFive
    add  x0, x0, :lo12:messageFive
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

greaterThanOrEqualSkip:
    ldr  w0, [x29, #-4] // x
    ldr  w1, [x29, #-8] // y
    cmp  w0, w1
    b.eq notEqualToSkip

    adrp x0, messageSix
    add  x0, x0, :lo12:messageSix
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

notEqualToSkip:
    ldr  w0, [x29, #-4] // x
    cbnz w0, notSkip

    adrp x0, messageSeven
    add  x0, x0, :lo12:messageSeven
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

notSkip:
    ldr  w0, [x29, #-4] // x
    cbz  w0, existsSkip

    adrp x0, messageEight
    add  x0, x0, :lo12:messageEight
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

existsSkip:
    ldr  w0, [x29, #-4] // x
    cmp  w0, #3
    b.ne andSkip
    ldr  w0, [x29, #-8] // y
    mov  w1, #4
    cmp  w0, w1
    b.ne andSkip

    adrp x0, messageNine
    add  x0, x0, :lo12:messageNine
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

andSkip:
    ldr  w0, [x29, #-4] // x
    cmp  w0, #3
    b.eq orShortcut
    ldr  w0, [x29, #-8] // y
    cmp  w0, #4
    b.ne orSkip

orShortcut:
    adrp x0, messageTen
    add  x0, x0, :lo12:messageTen
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

orSkip:
    ldr  w0, [x29, #-4] // x
    cmp  w0, #3
    b.eq daisyShortcut
    ldr  w0, [x29, #-8] // y
    mov  w1, #4
    cmp  w0, w1
    b.ne daisySkip

daisyShortcut:
    ldr  w0, [x29, #-12] // z
    cmp  w0, #5
    b.ne daisySkip

    adrp x0, messageEleven
    add  x0, x0, :lo12:messageEleven
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

daisySkip:
    mov  w0, #0
    mov  sp, x29
    ldp  x29, x30, [sp], #16
    ret

// assembly instruction
// as -o lesson17.o lesson17.asm
// gcc -o lesson17 lesson17.o