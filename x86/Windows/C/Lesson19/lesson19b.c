#include <stdio.h>

int main() {
    {
        int counter = 5;
        do {
            counter++;
            printf("This is from a loop and counter is: %d\n", counter);
        } while (counter < 5);
    }
    fputs("----\n", stdout);

    {
        int counter = 0;
        while (counter < 5) {
            counter++;
            printf("This is from a loop and counter is: %d\n", counter);
        }
    }
    fputs("----\n", stdout);

    for (int i = 1; i <= 20; i++) {
        printf("This is from a loop and counter is: %d\n", i);
    }
    return 0;
}