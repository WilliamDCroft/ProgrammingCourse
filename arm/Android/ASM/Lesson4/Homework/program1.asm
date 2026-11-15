.global _start

.text

_start:
    mov x0, #0
    mov x8, #93
    svc #0

// assmebly instructions
// as -o program1.o program1.asm
// ld.lld -pie -o program1 program1.o