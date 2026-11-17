.equ SYS_WRITE, 64
.equ SYS_EXIT,  93

.equ STDOUT, 1

.global _start

.data
    output: .skip 2
    .equ outputLength, . - output

.text

_start:
    adrp x0, output
    add  x0, x0, :lo12:output
    add  x0, x0, #1
    mov  w1, #10
    strb w1, [x0]

    mov  x3, 0 // count
loopOne:
    cmp  x3, 9
    b.gt exit

    add  x3, x3, '0'
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
    sub  x3, x3, '0'

    add  x3, x3, 1
    b loopOne

exit:
    mov  x0, #0
    mov  x8, #SYS_EXIT
    svc  #0

// assembly instructions
// as -o lesson7.o lesson7.asm
// ld.lld -pie -o lesson7 lesson7.o