.equ SYS_READ,  63
.equ SYS_WRITE, 64
.equ SYS_EXIT,  93

.equ STDIN,  0
.equ STDOUT, 1

.global _start

.data
    message: .ascii "Please enter the number 1 or 2 -> "
    .equ messageLength, . - message
    output:  .byte 0, 10
    .equ outputLength, . - output

.bss
    input: .skip 2
    .equ inputLength, . - input

.text

_start:
    mov  x0, #STDOUT
    adrp x1, message
    add  x1, x1, :lo12:message
    mov  x2, #messageLength
    mov  x8, #SYS_WRITE
    svc  #0

    mov  x0, #STDIN
    adrp x1, input
    add  x1, x1, :lo12:input
    mov  x2, #inputLength
    mov  x8, #SYS_READ
    svc  #0

    adrp x1, input
    add  x1, x1, :lo12:input
    ldrb w1, [x1]
    cmp  w1, '1'
    b.eq loopTwoStart

    mov  x3, '9' // count
loopOne:
    cmp  x3, '0'
    b.lt exit

    adrp x4, output
    add  x4, x4, :lo12:output
    strb w3, [x4]

    mov  x0, #STDOUT
    mov  x1, x4
    mov  x2, #outputLength
    mov  x8, #SYS_WRITE
    svc  #0

    adrp x4, output
    add  x4, x4, :lo12:output
    ldrb w3, [x4]

    sub  x3, x3, 1
    b loopOne

loopTwoStart:
    mov  x3, '0' // count
loopTwo:
    cmp  x3, '9'
    b.gt exit

    adrp x4, output
    add  x4, x4, :lo12:output
    strb w3, [x4]

    mov  x0, #STDOUT
    mov  x1, x4
    mov  x2, #outputLength
    mov  x8, #SYS_WRITE
    svc  #0

    adrp x4, output
    add  x4, x4, :lo12:output
    ldrb w3, [x4]

    add  x3, x3, 1
    b loopTwo

exit:
    mov  x0, #0
    mov  x8, #SYS_EXIT
    svc  #0

// assmebly instructions
// as -o program1.o program1.asm
// ld.lld -pie -o program1 program1.o