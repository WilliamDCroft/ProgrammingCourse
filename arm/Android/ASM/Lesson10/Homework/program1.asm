.equ SYS_getrandom, 278

.equ SYS_READ,  63
.equ SYS_WRITE, 64
.equ SYS_EXIT,  93

.equ STDIN,  0
.equ STDOUT, 1

.global _start

.data
    guessMessage:   .ascii "Guess a number from 1 to 6: "
    .equ guessMessageLength, . - guessMessage
    youWinMessage:  .ascii "You win!"
                    .byte  10
    .equ youWinMessageLength, . - youWinMessage
    tooLowMessage:  .ascii "Too low. Try again: "
    .equ tooLowMessageLength, . - tooLowMessage
    tooHighMessage: .ascii "Too high. Try again: "
    .equ tooHighMessageLength, . - tooHighMessage
    loseMessage:    .ascii "Sorry, you are out of guesses. The number was X."
                    .byte  10
    .equ loseMessageLength, . - loseMessage

.bss
    randomBuffer:   .skip 8
    .equ randomBufferLength, . - randomBuffer

.text

_start:
    stp  x29, x30, [sp, #-16]!
    mov  x29, sp
    sub  sp, sp, #16
    // randomNumber [x29, #-1]
    // userGuess    [x29, #-3]
    // guessCount   [x29, #-4]

attemptRand:
    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    mov  x1, #randomBufferLength
    mov  x2, #0
    mov  x8, SYS_getrandom
    svc  #0
    adrp x0, randomBuffer
    add  x0, x0, :lo12:randomBuffer
    ldr  x0, [x0]

    mov  x1, #6
    udiv x2, x0, x1
    msub x3, x1, x2, x0

    add  x3, x3, #1 // combine adding 48 and 1
    add  x3, x3, '0'

    strb w3, [x29, #-1] // randomNumber

    adrp x0, loseMessage
    add  x0, x0, :lo12:loseMessage
    add  x0, x0, #loseMessageLength
    sub  x0, x0, #3
    strb w3, [x0]

    mov  x0, #STDOUT
    adrp x1, guessMessage
    add  x1, x1, :lo12:guessMessage
    mov  x2, #guessMessageLength
    mov  x8, #SYS_WRITE
    svc  #0

    mov  w0, #0
    strb w0, [x29, #-4] // guessCount

gameLoop:
    ldrb w0, [x29, #-4] // guessCount
    add  w0, w0, #1
    strb w0, [x29, #-4] // guessCount

    mov  x0, #STDIN
    mov  x1, x29
    sub  x1, x1, #3 // userGuess
    mov  x2, #2
    mov  x8, #SYS_READ
    svc  #0

    ldrb w0, [x29, #-3] // userGuess
    ldrb w1, [x29, #-1] // randomNumber
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
    ldrb w0, [x29, #-4] // guessCount
    mov  w1, #3
    cmp  w0, w1
    b.eq outOfGuesses

    mov  x0, #STDOUT
    adrp x1, tooLowMessage
    add  x1, x1, :lo12:tooLowMessage
    mov  x2, #tooLowMessageLength
    mov  x8, #SYS_WRITE
    svc  #0

    b gameLoop

tooHigh:
    ldrb w0, [x29, #-4] // guessCount
    mov  w1, #3
    cmp  w0, w1
    b.eq outOfGuesses

    mov  x0, #STDOUT
    adrp x1, tooHighMessage
    add  x1, x1, :lo12:tooHighMessage
    mov  x2, #tooHighMessageLength
    mov  x8, #SYS_WRITE
    svc  #0

    b gameLoop

outOfGuesses:
    mov  x0, #STDOUT
    adrp x1, loseMessage
    add  x1, x1, :lo12:loseMessage
    mov  x2, #loseMessageLength
    mov  x8, #SYS_WRITE
    svc  #0

    b exit

// assembly instructions
// as -o program1.o program1.asm
// ld.lld -pie -o program1 program1.o