.equ SYS_getrandom, 278

.equ SYS_WRITE, 64
.equ SYS_EXIT,  93

.equ STDOUT, 1

.global _start

.data
    result: .byte 0, 10

.bss
    randomBuffer: .skip 8
    .equ randomBufferLength, . - randomBuffer

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

    adrp x0, result
    add  x0, x0, :lo12:result
    strb w3, [x0]

    mov  x0, #STDOUT
    adrp x1, result
    add  x1, x1, :lo12:result
    mov  x2, 2
    mov  x8, #SYS_WRITE
    svc  #0

    mov  x0, #0
    mov  x8, #SYS_EXIT
    svc  #0

// assembly instructions
// as -o randomNumberFromSYS_getrandom.o randomNumberFromSYS_getrandom.asm
// ld.lld -pie -o randomNumberFromSYS_getrandom randomNumberFromSYS_getrandom.o