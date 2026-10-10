extern int printf();

int x = 4;

int main() {
    int y = 3;
    register int a = x + y;
    printf("%i\n", a);
}