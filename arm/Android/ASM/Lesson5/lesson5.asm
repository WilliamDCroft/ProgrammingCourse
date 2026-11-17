.global _start

.data
    message: .ascii "Hello world!"
             .byte  10, 13

.text

_start:
    mov  x0, #1 // STDOUT
    adrp x1, message
    add  x1, x1, :lo12:message //The add instruction only has room for 12 digits 
    mov  x2, #14
    mov  x8, #64 // SYS_WRITE
    svc  #0

    mov x0, #0 // 0 means no errors
    mov x8, #93 // SYS_EXIT
    svc #0

// assembly instructions
// as -o lesson5.o lesson5.asm
// ld.lld -pie -o lesson5 lesson5.o