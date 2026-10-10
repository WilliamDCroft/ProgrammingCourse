extern int printf(char*, ...);

int main() {
    auto int x = 4;
    auto int y = 3;
    register int a = x + y;
    printf("%i\n", a);
}
