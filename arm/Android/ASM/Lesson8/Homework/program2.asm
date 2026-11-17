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
    loseMessage:    .ascii "Sorry, you are out of guesses. The number was X."
                    .byte  10
    .equ loseMessageLength, . - loseMessage

.bss
    randomBuffer: .skip 8
    .equ randomBufferLength, . - randomBuffer
    someNumber: .skip 1
    userGuess:  .skip 2
    .equ userGuessLength, . - userGuess
    guessCount: .skip 1

.text

_start:
    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    mov  x1, #randomBufferLength
    mov  x2, #0 // default behavior
    mov  x8, #SYS_getrandom
    svc  #0
    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    ldr  x0, [x0] // dividend

    mov  x1, #6 // divisor
    udiv x2, x0, x1 // quotient in x2

    // Find remainder by taking original value and subtracting whole number portion * divisor
    //   x3 = x0 - (x1 * x2)
    msub x3, x1, x2, x0

    add x3, x3, #1
    add x3, x3, '0'

    adrp x0, someNumber
    add  x0, x0, :lo12:someNumber
    strb w3, [x0]

    adrp x0, loseMessage
    add  x0, x0, :lo12:loseMessage
    add  x0, x0, #loseMessageLength
    sub  x0, x0, #3
    strb w3, [x0]

    mov  x0, #STDOUT
    adrp x1, openingMessage
    add  x1, x1, :lo12:openingMessage
    mov  x2, #openingMessageLength
    mov  x8, #SYS_WRITE
    svc  #0

mainLoop:
    adrp x0, guessCount
    add  x0, x0, :lo12:guessCount
    ldrb w1, [x0]
    add  w1, w1, #1
    strb w1, [x0]

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

exit:
    mov  x0, #0
    mov  x8, #SYS_EXIT
    svc  #0

tooLow:
    adrp x0, guessCount
    add  x0, x0, :lo12:guessCount
    ldrb w1, [x0]
    cmp  w1, 3
    b.eq outOfGuesses

    mov  x0, #STDOUT
    adrp x1, tooLowMessage
    add  x1, x1, :lo12:tooLowMessage
    mov  x2, #tooLowMessageLength
    mov  x8, #SYS_WRITE
    svc  #0

    b mainLoop

tooHigh:
    adrp x0, guessCount
    add  x0, x0, :lo12:guessCount
    ldrb w1, [x0]
    cmp  w1, 3
    b.eq outOfGuesses

    mov  x0, #STDOUT
    adrp x1, tooHighMessage
    add  x1, x1, :lo12:tooHighMessage
    mov  x2, #tooHighMessageLength
    mov  x8, #SYS_WRITE
    svc  #0

    b mainLoop

outOfGuesses:
    mov  x0, #STDOUT
    adrp x1, loseMessage
    add  x1, x1, :lo12:loseMessage
    mov  x2, #loseMessageLength
    mov  x8, #SYS_WRITE
    svc  #0

    b exit

// assembly instructions
// as -o program2.o program2.asm
// ld.lld -pie -o program2 program2.o