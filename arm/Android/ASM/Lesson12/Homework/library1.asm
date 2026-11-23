.equ SYS_WRITE, 64

.equ STDOUT, 1

.global summateTwoNumbers
.global divideTwoNumbers
.global moduloTwoNumbers

.text

// numOne x0
// numTwo x1
summateTwoNumbers:
    stp  x29, x30, [sp, #-16]!
    mov  x29, sp
    sub  sp, sp, #16
    // output byte [x29, #-2]

    add  x0, x0, x1
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

// numOne x0
// numTwo x1
divideTwoNumbers:
    stp  x29, x30, [sp, #-16]!
    mov  x29, sp
    sub  sp, sp, #16
    // output byte [x29, #-2]

    udiv x0, x0, x1
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

// assembly instructions
// as -o program1.o program1.asm
// as -o library1.o library1.asm
// ld.lld -pie -o program1 program1.o library1.o