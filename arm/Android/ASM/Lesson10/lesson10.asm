.equ SYS_WRITE, 64
.equ SYS_EXIT,  93

.equ STDOUT, 1

.global _start

.text

_start:
    // x      [x29, #-4]
    // y      [x29, #-8]
    // z      [x29, #-12]
    // output [x29, #-14]
    stp  x29, x30, [sp, #-16]!
    mov  x29, sp
    sub  sp, sp, #16

    mov  w0, #3
    str  w0, [x29, #-4] // x
    mov  w0, #4
    str  w0, [x29, #-8] // y

    ldr  w0, [x29, #-4] // x
    ldr  w1, [x29, #-8] // y
    add  w0, w0, w1
    str  w0, [x29, #-12] // z

    ldr  w0, [x29, #-12] // z
    add  w0, w0, #'0'
    strb w0, [x29, #-14] // output[0]
    mov  w0, #10
    strb w0, [x29, #-13] // output[1]

    mov  x0, #STDOUT
    mov  x1, x29
    sub  x1, x1, #14
    mov  x2, #2
    mov  x8, #SYS_WRITE
    svc  #0

    mov  sp, x29
    ldp  x29, x30, [sp], #16

    mov  x0, #0
    mov  x8, #SYS_EXIT
    svc  #0

// assembly instructions
// as -o lesson10.o lesson10.asm
// ld.lld -pie -o lesson10 lesson10.o