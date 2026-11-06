#include <stdio.h>

int main() {
    int x = 3;
    if (x == 4) {
        fputs("x is 4!\n", stdout);
    } else {
        fputs("x is NOT 4!\n", stdout);
    }
    fputs("That's the program!\n", stdout);
    return 0;
}