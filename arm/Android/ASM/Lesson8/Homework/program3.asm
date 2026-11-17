.equ SYS_getrandom, 278

.equ SYS_WRITE, 64
.equ SYS_EXIT,  93

.equ STDOUT, 1

.global _start

.data
    message: .ascii "Your lucky number is: "
    .equ messageLength, . - message
    newline: .byte 10

.bss
    randomBuffer: .skip 8
    .equ randomBufferLength, . - randomBuffer
    numberOne:    .skip 1
    numberTwo:    .skip 1
    numberThree:  .skip 1
    numberFour:   .skip 1
    numberFive:   .skip 1
    numberSix:    .skip 1

.text

_start:
    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    mov  x1, #randomBufferLength
    mov  x2, #0
    mov  x8, #SYS_getrandom
    svc  #0
    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    ldr  x0, [x0]

    mov  x1, #10
    udiv x2, x0, x1
    msub x3, x1, x2, x0

    add  x3, x3, '0'

    adrp x0, numberOne
    add  x0, x0, :lo12:numberOne
    strb w3, [x0]



    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    mov  x1, #randomBufferLength
    mov  x2, #0
    mov  x8, #SYS_getrandom
    svc  #0
    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    ldr  x0, [x0]

    mov  x1, #10
    udiv x2, x0, x1
    msub x3, x1, x2, x0

    add  x3, x3, '0'

    adrp x0, numberTwo
    add  x0, x0, :lo12:numberTwo
    strb w3, [x0]



    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    mov  x1, #randomBufferLength
    mov  x2, #0
    mov  x8, #SYS_getrandom
    svc  #0
    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    ldr  x0, [x0]

    mov  x1, #10
    udiv x2, x0, x1
    msub x3, x1, x2, x0

    add  x3, x3, '0'

    adrp x0, numberThree
    add  x0, x0, :lo12:numberThree
    strb w3, [x0]



    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    mov  x1, #randomBufferLength
    mov  x2, #0
    mov  x8, #SYS_getrandom
    svc  #0
    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    ldr  x0, [x0]

    mov  x1, #10
    udiv x2, x0, x1
    msub x3, x1, x2, x0

    add  x3, x3, '0'

    adrp x0, numberFour
    add  x0, x0, :lo12:numberFour
    strb w3, [x0]



    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    mov  x1, #randomBufferLength
    mov  x2, #0
    mov  x8, #SYS_getrandom
    svc  #0
    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    ldr  x0, [x0]

    mov  x1, #10
    udiv x2, x0, x1
    msub x3, x1, x2, x0

    add  x3, x3, '0'

    adrp x0, numberFive
    add  x0, x0, :lo12:numberFive
    strb w3, [x0]



    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    mov  x1, #randomBufferLength
    mov  x2, #0
    mov  x8, #SYS_getrandom
    svc  #0
    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    ldr  x0, [x0]

    mov  x1, #10
    udiv x2, x0, x1
    msub x3, x1, x2, x0

    add  x3, x3, '0'

    adrp x0, numberSix
    add  x0, x0, :lo12:numberSix
    strb w3, [x0]



    mov  x0, #STDOUT
    adrp x1, message
    add  x1, x1, :lo12:message
    mov  x2, #messageLength
    mov  x8, #SYS_WRITE
    svc  #0

    mov  x0, #STDOUT
    adrp x1, numberOne
    add  x1, x1, :lo12:numberOne
    mov  x2, #1
    mov  x8, #SYS_WRITE
    svc  #0

    mov  x0, #STDOUT
    adrp x1, numberTwo
    add  x1, x1, :lo12:numberTwo
    mov  x2, #1
    mov  x8, #SYS_WRITE
    svc  #0

    mov  x0, #STDOUT
    adrp x1, numberThree
    add  x1, x1, :lo12:numberThree
    mov  x2, #1
    mov  x8, #SYS_WRITE
    svc  #0

    mov  x0, #STDOUT
    adrp x1, numberFour
    add  x1, x1, :lo12:numberFour
    mov  x2, #1
    mov  x8, #SYS_WRITE
    svc  #0

    mov  x0, #STDOUT
    adrp x1, numberFive
    add  x1, x1, :lo12:numberFive
    mov  x2, #1
    mov  x8, #SYS_WRITE
    svc  #0

    mov  x0, #STDOUT
    adrp x1, numberSix
    add  x1, x1, :lo12:numberSix
    mov  x2, #1
    mov  x8, #SYS_WRITE
    svc  #0

    mov  x0, #STDOUT
    adrp x1, newline
    add  x1, x1, :lo12:newline
    mov  x2, #1
    mov  x8, #SYS_WRITE
    svc  #0

    mov  x0, #0
    mov  x8, #SYS_EXIT
    svc  #0

// assembly instructions
// as -o program2.o program2.asm
// ld.lld -pie -o program2 program2.o