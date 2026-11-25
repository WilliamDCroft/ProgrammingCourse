.extern stdin
.extern stdout
.extern fputs
.extern fgets
.extern atoi

.global main

.section .rodata
    welcomeMessage:     .ascii "Welcome to the menu."
                        .byte  10
                        .ascii "Press 1 for the current weather."
                        .byte  10
                        .ascii "Press 2 for appointment reminders."
                        .byte  10
                        .ascii "Press 3 for a positive message"
                        .byte  10
                        .asciz "$> "
    weatherMessage:     .ascii "The weather is currently tornado levels of scary!"
                        .byte  10, 0
    appointmentMessage: .ascii "You have a doctors appointment on the 17th."
                        .byte  10, 0
    positiveMessage:    .ascii "You are a good person. Have a pleasent day."
                        .byte  10, 0

.text

main:
    stp  x29, x30, [sp, #-16]!
    mov  x29, sp
    sub  sp, sp, #0x110
    // szUserChoice [x29 #-256]
    // userChoice   [x29 #-260]

    adrp x0, welcomeMessage
    add  x0, x0, :lo12:welcomeMessage
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

    sub  x0, x29, #256 // szUserChoice
    mov  x1, #256
    adrp x2, :got:stdin
    ldr  x2, [x2, :got_lo12:stdin]
    ldr  x2, [x2]
    bl   fgets

    sub  x0, x29, #256 //  szUserChoice
    bl   atoi
    sub  x1, x29, #260
    str  w0, [x1] // userChoice

    cmp  w0, #1
    b.ne oneSkip

    adrp x0, weatherMessage
    add  x0, x0, :lo12:weatherMessage
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

oneSkip:
    sub  x0, x29, #260
    ldr  w0, [x0] // userChoice
    cmp  w0, #2
    b.ne twoSkip

    adrp x0, appointmentMessage
    add  x0, x0, :lo12:appointmentMessage
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

twoSkip:
    sub  x0, x29, #260
    ldr  w0, [x0] // userChoice
    cmp  w0, #3
    b.ne threeSkip

    adrp x0, positiveMessage
    add  x0, x0, :lo12:positiveMessage
    adrp x1, :got:stdout
    ldr  x1, [x1, :got_lo12:stdout]
    ldr  x1, [x1]
    bl   fputs

threeSkip:
    mov  w0, #0
    mov  sp, x29
    ldp  x29, x30, [sp], #16
    ret

// assembly instruction
// as -o program1.o program1.asm
// gcc -o program1 program1.o