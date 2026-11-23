extern int printf(const char*, ...);

int main() {
    static int x = 4;
    int y = 3;
    register int a = x + y;
    printf("%i\n", a);
}

// compile instructions
// gcc -o program3 program3.c