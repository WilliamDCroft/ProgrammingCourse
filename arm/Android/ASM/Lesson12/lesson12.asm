.extern puts
.extern secure_itoa

.equ SYS_EXIT, 93

.global _start

.data
    message:        .ascii "Hello world!"
                    .byte  0
    numberAsString: .ascii "4096"
                    .byte  0

.bss
    outputBuffer:   .skip 4096

.text

_start:
    adrp x0, numberAsString
    add  x0, x0, :lo12:numberAsString
    bl atoi

    mov  x1, #4096
    cmp  x0, x1
    b.ne exit

    adrp x0, message
    add  x0, x0, :lo12:message
    bl puts

    movz x0, #0xF515
    movk x0, #0xF5C6, lsl #16
    adrp x1, outputBuffer
    add  x1, x1, :lo12:outputBuffer
    mov  x2, #4096
    bl secure_itoa

    adrp x0, outputBuffer
    add  x0, x0, :lo12:outputBuffer
    bl puts

exit:
    mov  x0, #0
    mov  x8, #SYS_EXIT
    svc  #0

// assembly instructions
// as -o lesson12.o lesson12.asm
// as -o lesson12lib.o lesson12lib.asm
// ld.lld -pie -o lesson12 lesson12.o lesson12lib.o