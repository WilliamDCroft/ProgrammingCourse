.global _start

.data
    message: .ascii "Hello world!"
             .byte  10

.text

_start:
    mov  x0, #1
    adrp x1, message
    add  x1, x1, :lo12:message //The add instruction only has room for 12 digits 
    mov  x2, #13
    mov  x8, #64
    svc  #0

    mov x0, #0
    mov x8, #93
    svc #0

// assembly instructions
// as -o program1.o program1.asm
// ld.lld -pie -o program1 program1.o