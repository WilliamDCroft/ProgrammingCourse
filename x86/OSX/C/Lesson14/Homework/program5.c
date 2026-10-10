extern int printf(const char*, ...);

int main() {
    static int x;
    x = 4;
    int y = 3;
    printf("%i\n", x + y);
    return 0;
}