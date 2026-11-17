.equ SYS_WRITE, 64
.equ SYS_EXIT,  93

.equ STDOUT, 1

.global _start

.text

_start:
    mov  x0, 0x0A30 // "0\n"

loopOne:
    and  x1, x0, #0xFF
    cmp  x1, '9'
    b.gt exit

    //            presubtract, ! means store back to sp
    stp  x0, xzr, [sp, #-16]! // 16 BYTES, not bits

    mov  x0, #STDOUT
    mov  x1, sp
    mov  x2, #2
    mov  x8, #SYS_WRITE
    svc  #0

    //            post add
    ldp  x0, xzr, [sp], #16

    add  x0, x0, #1
    b loopOne

exit:
    mov  x0, #0
    mov  x8, #SYS_EXIT
    svc  #0

// assembly instructions
// as -o lesson9.7.o lesson9.7.asm
// ld.lld -pie -o lesson9.7 lesson9.7.o