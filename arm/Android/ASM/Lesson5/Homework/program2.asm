.global _start

.data
    message: .ascii "Hello, William!"
             .byte  10

.text

_start:
    mov  x0, 1
    adrp x1, message
    add  x1, x1, :lo12:message
    mov  x2, #16
    mov  x8, #64
    svc  #0

    mov x0, 0
    mov x8, 93
    svc #0

// assmebly instructions
// as -o program2.o program2.asm
// ld.lld -pie -o program2 program2.o