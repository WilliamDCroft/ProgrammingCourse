extern int printf(const char*, ...);

int main() {
    int x = 4;
    int y = 3;
    register int a = x + y;
    printf("%i\n", a);
}

// compile instructions
// gcc -o program2 program2.c