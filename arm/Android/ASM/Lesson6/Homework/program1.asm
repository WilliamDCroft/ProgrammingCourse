.equ SYS_READ,  63
.equ SYS_WRITE, 64
.equ SYS_EXIT,  93

.equ STDIN,  0
.equ STDOUT, 1

.global _start

.data
    message:      .ascii "Hello. What is your favorite number? "
    .equ messageLength, . - message
    messageTwo:   .ascii "You chose: "
    .equ messageTwoLength, . - messageTwo
    messageThree: .ascii "What an interesting number! "
                  .byte  10
    .equ messageThreeLength, . - messageThree

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

    mov  x0, #STDOUT
    adrp x1, input
    add  x1, x1, :lo12:input
    mov  x2, #inputLength
    mov  x8, #SYS_WRITE
    svc  #0

    mov  x0, #STDOUT
    adrp x1, messageThree
    add  x1, x1, :lo12:messageThree
    mov  x2, #messageThreeLength
    mov  x8, #SYS_WRITE
    svc  #0

    mov  x0, #0
    mov  x8, #SYS_EXIT
    svc  #0

// assembly instructions
// as -o program1.o program1.asm
// ld.lld -pie -o program1 program1.o