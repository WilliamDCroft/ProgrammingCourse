#include <stdio.h>

int main() {
    int x = 3;
    int y = 4;
    int z = 5;
    int a = 3;
    int b = 4;
    int c = 5;
    if (x == 3) fputs("x is equal to 3.\n", stdout);
    if (x < y) {
        fputs("x is less than y.\n", stdout);
    }
    if (c > y) {
        fputs("c is greater than y.\n", stdout);
    }
    if (y <= b) {
        fputs("y is less than or equal to b.\n", stdout);
    }
    if (y >= b) {
        fputs("y is greater than or equal to b.\n", stdout);
    }
    if (x != 5) {
        fputs("x is not equal to 5.\n", stdout);
    }
    if (!x) {
        fputs("x does not \"exist\".\n", stdout);
    }
    if (x) {
        fputs("x \"exists\".\n", stdout);
    }
    if (x == 3 && y == 4) {
        fputs("x is 3 AND y is 4.\n", stdout);
    }
    if (x == 3 || y == 5) {
        fputs("x is 3 OR y is 5.\n", stdout);
    }
    if ((x == 3 || y == 5) && z == 5) {
        fputs("z is 5 at the same time that either x is 3 or y is 5.", stdout);
    }

    return 0;
}