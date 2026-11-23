.equ SYS_WRITE, 64
.equ SYS_EXIT,  93

.equ STDOUT, 1

.global _start

.text

// numOne x0
// numTwo x1
moduloTwoNumbers:
    stp  x29, x30, [sp, #-16]!
    mov  x29, sp
    sub  sp, sp, #16
    // output byte [x29, #-2]

    udiv x2, x0, x1
    msub x0, x1, x2, x0
    add  x0, x0, #'0'
    strb w0, [x29, #-2] // output
    mov  x0, #10 // newline
    strb w0, [x29, #-1]

    mov  x0, #STDOUT
    mov  x1, x29
    sub  x1, x1, #2
    mov  x2, 2
    mov  x8, #SYS_WRITE
    svc  #0

    mov  sp, x29
    ldp  x29, x30, [sp], #16
    ret

_start:
    mov  x0, #7
    mov  x1, #4
    bl moduloTwoNumbers

    mov  x0, #8
    mov  x1, #7
    bl moduloTwoNumbers

    mov  x0, #0
    mov  x8, #SYS_EXIT
    svc  #0

// assembly instructions
// as -o program3.o program3.asm
// ld.lld -pie -o program3 program3.o