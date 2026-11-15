.equ SYS_READ,  63
.equ SYS_WRITE, 64
.equ SYS_EXIT,  93

.equ STDIN,  0
.equ STDOUT, 1

.global _start

.data
    message:    .ascii "Hello. What is your favorite number? "
    .equ messageLength, . - message
    messageTwo: .ascii "Oh, cool! I like "
    .equ messageTwoLength, . - messageTwo

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

    mov  x0, #STDOUT
    adrp x1, messageTwo
    add  x1, x1, :lo12:messageTwo
    mov  x2, #messageTwoLength
    mov  x8, #SYS_WRITE
    svc  #0

    adrp x0, input
    add  x0, x0, :lo12:input
    ldrb w1, [x0]
    add  w1, w1, 1
    strb w1, [x0]

    mov  x0, #STDOUT
    adrp x1, input
    add  x1, x1, :lo12:input
    mov  x2, #inputLength
    mov  x8, #SYS_WRITE
    svc  #0

    mov  x0, #0
    mov  x8, #SYS_EXIT
    svc  #0

// assmebly instructions
// as -o program2.o program2.asm
// ld.lld -pie -o program2 program2.o