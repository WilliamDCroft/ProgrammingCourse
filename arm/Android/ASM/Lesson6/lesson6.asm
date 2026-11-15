.equ SYS_READ,  63
.equ SYS_WRITE, 64
.equ SYS_EXIT,  93

.equ STDIN,  0
.equ STDOUT, 1

.global _start

.data
    message: .ascii "Type a character: "
    .equ messageLength, . - message

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
    ldrb w2, [x1] // load into register a byte (from memory)
    add  w2, w2, #1
    strb w2, [x1] // store from register a byte (to memory)

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
// as -o lesson6.o lesson6.asm
// ld.lld -pie -o lesson6 lesson6.o