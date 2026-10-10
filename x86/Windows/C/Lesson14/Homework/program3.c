extern int printf();

int main() {
    static int x = 4;
    int y = 3;
    register int a = x + y;
    printf("%i\n", a);
}