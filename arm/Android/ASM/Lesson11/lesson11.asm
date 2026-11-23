.equ SYS_WRITE, 64
.equ SYS_EXIT,  93

.equ STDOUT, 1

.global _start

.data
    message:          .ascii "Hello world!"
                      .byte  10, 0
    .equ messageLength, . - message
    messageTwo:       .ascii "This is a go"
                      .byte 10, 0
    bigOlMessage:     .ascii "This message is so big, that it's probably larger than 64 bytes, at least I think!"
                      .byte 0 // we removed both newlines!!!
    bigOlReplacement: .ascii "And this is actually a really solid replacement of the above, or so I am most sure"
                      .byte 0

.bss
    iobuffer:   .skip 4096

.text

// x0 dest
// x1 src
// x2 n
memcpy:
    cmp  x2, #16
    b.lo memcpyEightBytes // unsigned lower
    cmp  x2, #32
    b.ls memcpySixteenToThirtyTwoBytes // unsigned lower or same

    sub  x2, x2,#32
memcpyMoreThanThirtyTwoByteLoop:
    ldp  x3, x4, [x1], #16 // src
    ldp  x5, x6, [x1], #16 // src
    stp  x3, x4, [x0], #16 // dest
    stp  x5, x6, [x0], #16 // dest
    subs x2, x2, #32 // sub and SET FLAGS
    b.hs memcpyMoreThanThirtyTwoByteLoop // unsigned higher or same

// memcpyMoreThanThirtyTwoBytesTail
    // this copies bits that have technically already been copied
    add  x1, x1, x2  // count will be negative, so this adjusts the src pointer
    add  x0, x0, x2  // ditto above
    ldp  x3, x4, [x1] // src
    ldp  x5, x6, [x1, #16] // src
    stp  x3, x4, [x0] // dest
    stp  x5, x6, [x0, #16] // dest
    ret

memcpySixteenToThirtyTwoBytes:
    ldp x3, x4, [x1]      // grab the first 16 bytes
    sub x7, x2, #16       // how much more than 16 is there?
    add x1, x1, x7        // point x1 to the start of the last 16 bytes
    ldp x5, x6, [x1]      // load the last 16 bytes (overlapping)
    stp x3, x4, [x0]      // store the first 16 bytes
    add x0, x0, x7        // point x0 to the start of the last 16 bytes
    stp x5, x6, [x0]      // store the last 16 bytes (overlapping)
    ret

memcpyEightBytes:
    tbz  x2, #3, memcpyFourBytes
    ldr  x3, [x1], #8
    str  x3, [x0], #8

memcpyFourBytes:
    tbz  x2, #2, memcpyTwoBytes
    ldr  w3, [x1], #4
    str  w3, [x0], #4

memcpyTwoBytes:
    tbz  x2, #1, memcpyOneByte
    ldrh w3, [x1], #2
    strh w3, [x0], #2

memcpyOneByte:
    tbz  x2, #0, memcpyDone
    ldrb w3, [x1]
    strb w3, [x0]
memcpyDone:
    ret

// x0 str
strlen:
    mov  x1, x0
strlenLoop:
    ldrb w2, [x1], #1
    cbnz w2, strlenLoop
    sub  x0, x1, x0
    sub  x0, x0, #1 // exclude null terminator
    ret

// x0 str
puts:
    stp  x29, x30, [sp, #-16]!
    mov  x29, sp
    sub  sp, sp, #16
    // str [x29, #-8]
    // stringLength [x29, #16]

    str  x0, [x29, #-8] // str
    bl strlen
    str  x0, [x29, #-16] // stringLength

    adrp x0, iobuffer
    add  x0, x0, :lo12:iobuffer
    ldr  x1, [x29, #-8] // str
    ldr  x2, [x29, #-16] // stringLength
    bl memcpy

    // append newline
    adrp x0, iobuffer
    add  x0, x0, :lo12:iobuffer
    ldr  x1, [x29, #-16] // stringLength
    add  x0, x0, x1
    mov  w1, #10
    strb w1, [x0]

    mov  x0, #STDOUT
    adrp x1, iobuffer
    add  x1, x1, :lo12:iobuffer
    ldr  x2, [x29, #-16] // stringLength
    add  x2, x2, #1 // (increment for newline)
    mov  x8, #SYS_WRITE
    svc  #0

    mov sp, x29
    ldp x29, x30, [sp], #16
    ret

_start:
    stp  x29, x30, [sp, #-16]!
    mov  x29, sp
    sub  sp, sp, #16
    // stringLength [x29, #-8]

    adrp x0, bigOlMessage
    add  x0, x0, :lo12:bigOlMessage
    bl puts

    mov  sp, x29
    ldp  x29, x30, [sp], #16

    mov  x0, #0
    mov  x8, #SYS_EXIT
    svc  #0

// assembly instructions
// as -o lesson11.o lesson11.asm
// ld.lld -pie -o lesson11 lesson11.o