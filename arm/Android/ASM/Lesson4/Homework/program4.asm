.global _start

.text

_start:
    mov w0, #4
    movk x0, #1, lsl #16
    movz x1, #3, lsl #32
    add x1, x1, x0
    mov w1, w3
    movz x0, 4785
    movk x0, 32500, lsl #16
    movk x0, 55903, lsl #32
    movk x0, 3508, lsl #48

    mov x0, #0
    mov x8, 93
    svc #0

// assmebly instructions
// as -o program4.o program4.asm
// ld.lld -pie -o program4 program4.o