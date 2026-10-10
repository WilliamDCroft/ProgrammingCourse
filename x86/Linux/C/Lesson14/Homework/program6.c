extern int printf(char*, ...);

int x;

int main() {
    x = 4;
    int y = 3;
    register int a = x + y;
    printf("%i\n", a);
}
