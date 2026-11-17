.global _start

.text

_start:
    mov x0, #0
    mov x8, #93
    svc #0

// assembly instructions
// as -o lesson4.o lesson4.asm
// ld.lld -pie -o lesson4 lesson4.o