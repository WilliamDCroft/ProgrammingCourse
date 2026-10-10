extern int prinft();

int x = 3;
static int y;

int main() {
    y = 4;
    int z = 5;
    register int a = x + y + z;
    printf("x is %i\ny is %i\nz is %i\na is %i\n", x, y, z, a);
    return 0;
}