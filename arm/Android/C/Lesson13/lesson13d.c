extern void _syscall();
extern int puts();

int _start() {
    _syscall(64, 1, "Hello world!\n", 13);
    _syscall(93, 0);
}

// assembly instructions
// as -o kernelcalllib.o kernelcalllib.asm
// gcc -nostartfiles -o lesson13d lesson13d.c kernelcalllib.o