extern int printf(const char*, ...);

int main() {
    register int x = 4;
    register int y = 3;
    printf("%i\n", x + y);
    return 0;
}