.global _start

.data
    messageOne: .ascii "Hello, STC!"
                .byte  10
    messageTwo: .ascii "Hello world!"
                .byte  10

.text

_start:
    mov  x0, 1
    adrp x1, messageOne
    add  x1, x1, :lo12:messageOne
    mov  x2, #12
    mov  x8, #64
    svc  #0

    mov  x0, 1
    adrp x1, messageTwo
    add  x1, x1, :lo12:messageTwo
    mov  x2, #13
    mov  x8, #64
    svc  #0

    mov x0, 0
    mov x8, 93
    svc #0

// assmebly instructions
// as -o program3.o program3.asm
// ld.lld -pie -o program3 program3.o