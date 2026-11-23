.extern summateTwoNumbers
.extern divideTwoNumbers
.extern moduloTwoNumbers

.equ SYS_EXIT,  93

.global _start

.text

_start:
    mov  x0, #2
    mov  x1, #3
    bl summateTwoNumbers

    mov  x0, #3
    mov  x1, #5
    bl summateTwoNumbers

    mov  x0, #12
    mov  x1, #3
    bl divideTwoNumbers

    mov  x0, #15
    mov  x1, #5
    bl divideTwoNumbers

    mov  x0, #7
    mov  x1, #4
    bl moduloTwoNumbers

    mov  x0, #8
    mov  x1, #7
    bl moduloTwoNumbers

    mov  x0, #0
    mov  x8, #SYS_EXIT
    svc  #0

// assembly instructions
// as -o program1.o program1.asm
// as -o library2.o library2.asm
// ld.lld -pie -o program1 program1.o library2.o