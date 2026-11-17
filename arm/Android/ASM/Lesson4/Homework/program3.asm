.global _start

.text

_start:
    mov x0, #1
    mov x2, #2
    add x0, x0, x2
    add x2, x2, #5
    mov x1, #4
    sub x2, x2, x1
    sub x2, x2, #1

    mov x0, #0
    mov x8, #93
    svc #0

// assembly instructions
// as -o program3.o program3.asm
// ld.lld -pie -o program3 program3.o