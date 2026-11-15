.equ SYS_clock_gettime, 113

.equ CLOCK_REALTIME, 0

.equ SYS_WRITE, 64
.equ SYS_EXIT,  93

.equ STDOUT, 1

.global _start

.data
    result: .byte 0, 10

.bss
    timeBuffer: .skip 16

.text

_start:
    mov  x0, #CLOCK_REALTIME
    adrp x1, timeBuffer
    add  x1, x1, :lo12:timeBuffer
    mov  x8, SYS_clock_gettime
    svc  #0
    ldr x0, [x1] // dividend

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

// assmebly instructions
// as -o randomNumberFromRawTimeTest.o randomNumberFromRawTimeTest.asm
// ld.lld -pie -o randomNumberFromRawTimeTest randomNumberFromRawTimeTest.o