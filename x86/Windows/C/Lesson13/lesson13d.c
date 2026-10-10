extern void ExitProcess();
extern int puts();

int start() {
    puts("Hello world!");
    ExitProcess(0);
    return 0;
}