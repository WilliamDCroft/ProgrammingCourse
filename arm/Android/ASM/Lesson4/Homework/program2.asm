.global _start

.text

_start:
    mov x0, #1
    mov x2, #2
    mov x0, #3
    mov x1, #4

    mov x0, #0
    mov x8, #93
    svc #0

// assembly instructions
// as -o program2.o program2.asm
// ld.lld -pie -o program2 program2.o