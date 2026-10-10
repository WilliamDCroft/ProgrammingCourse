extern int printf();

int main() {
    register int x = 4;
    register int y = 3;
    register int a = x + y;
    printf("%i\n", a);
}