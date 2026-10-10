extern void _syscall();
extern int puts();

int _start() {
    puts("Hello world!");
    _syscall(60, 0);
    return 0;
}
