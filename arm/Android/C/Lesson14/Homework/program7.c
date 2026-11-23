extern int printf(const char*, ...);

int main() {
    register int x = 4;
    register int y = 3;
    register int a = x + y;
    printf("%i\n", a);
}

// compile instructions
// gcc -o program7 program7.c