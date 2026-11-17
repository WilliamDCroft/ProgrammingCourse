.equ SYS_READ,  63
.equ SYS_WRITE, 64
.equ SYS_EXIT,  93

.equ STDIN,  0
.equ STDOUT, 1

.global _start

.data
    message: .ascii "Type a character: "
    .equ messageLength, . - message

.text

_start:
    mov  x0, #STDOUT
    adrp x1, message
    add  x1, x1, :lo12:message
    mov  x2, #messageLength
    mov  x8, #SYS_WRITE
    svc  #0

    sub  sp, sp, #16

    mov  x0, #STDIN
    mov  x1, sp
    mov  x2, #16
    mov  x8, #SYS_READ
    svc  #0

    mov  x0, sp
    ldrb w1, [x0]
    add  w1, w1, #1
    strb w1, [x0]

    mov  x0, #STDOUT
    mov  x1, sp
    mov  x2, #16
    mov  x8, #SYS_WRITE
    svc  #0

    mov  x0, #0
    mov  x8, #SYS_EXIT
    svc  #0

// assembly instructions
// as -o lesson9.6.o lesson9.6.asm
// ld.lld -pie -o lesson9.6 lesson9.6.o