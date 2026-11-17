.equ SYS_getrandom, 278

.equ SYS_READ,  63
.equ SYS_WRITE, 64
.equ SYS_EXIT,  93

.equ STDIN,  0
.equ STDOUT, 1

.global _start

.data
    openingMessage: .ascii "Guess a number from 1 to 6: "
    .equ openingMessageLength, . - openingMessage
    youWinMessage:  .ascii "You got it!"
                    .byte  10
    .equ youWinMessageLength,  . - youWinMessage
    tooLowMessage:  .ascii "Too low! Try again: "
    .equ tooLowMessageLength,  . - tooLowMessage
    tooHighMessage: .ascii "Too High! Try again: "
    .equ tooHighMessageLength, . - tooHighMessage

.bss
    randomBuffer: .skip 8
    .equ randomBufferLength, . - randomBuffer
    someNumber: .skip 1
    userGuess:  .skip 2
    .equ userGuessLength, . - userGuess

.text

_start:
    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    mov  x1, #randomBufferLength
    mov  x2, #0 // default behavior
    mov  x8, SYS_getrandom
    svc  #0
    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    ldr x0, [x0] // dividend

    mov x1, #6 // divisor
    udiv x2, x0, x1 // quotient in x2

    // Find remainder by taking original value and subtracting whole number portion * divisor
    //   x3 = x0 - (x1 * x2)
    msub x3, x1, x2, x0

    add x3, x3, #1
    add x3, x3, '0'

    adrp x0, someNumber
    add  x0, x0, :lo12:someNumber
    strb w3, [x0]

    mov  x0, #STDOUT
    adrp x1, openingMessage
    add  x1, x1, :lo12:openingMessage
    mov  x2, #openingMessageLength
    mov  x8, #SYS_WRITE
    svc  #0

mainLoop:
    mov  x0, #STDIN
    adrp x1, userGuess
    add  x1, x1, :lo12:userGuess
    mov  x2, #2
    mov  x8, #SYS_READ
    svc  #0

    adrp x0, userGuess
    add  x0, x0, :lo12:userGuess
    ldrb w0, [x0]
    adrp x1, someNumber
    add  x1, x1, :lo12:someNumber
    ldrb w1, [x1]
    cmp  w0, w1
    b.lt tooLow
    b.gt tooHigh

    mov  x0, #STDOUT
    adrp x1, youWinMessage
    add  x1, x1, :lo12:youWinMessage
    mov  x2, #youWinMessageLength
    mov  x8, #SYS_WRITE
    svc  #0

    mov  x0, #0
    mov  x8, #SYS_EXIT
    svc  #0

tooLow:
    mov  x0, #STDOUT
    adrp x1, tooLowMessage
    add  x1, x1, :lo12:tooLowMessage
    mov  x2, #tooLowMessageLength
    mov  x8, #SYS_WRITE
    svc  #0

    b mainLoop

tooHigh:
    mov  x0, #STDOUT
    adrp x1, tooHighMessage
    add  x1, x1, :lo12:tooHighMessage
    mov  x2, #tooHighMessageLength
    mov  x8, #SYS_WRITE
    svc  #0

    b mainLoop

// assembly instructions
// as -o program1.o program1.asm
// ld.lld -pie -o program1 program1.o