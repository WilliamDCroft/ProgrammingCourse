extern int printf(const char*, ...);

int x = 4;

int main() {
    int y = 3;
    register int a = x + y;
    printf("%i\n", a);
}

// compile instructions
// gcc -o program4 program4.c