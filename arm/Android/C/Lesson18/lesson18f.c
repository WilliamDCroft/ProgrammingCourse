#include <stdio.h>

int main() {
    {
        int counter = 0;
        while (counter < 5) {
            if (counter == 4) {
                break;
            }
            counter++;
            if (counter == 1) {
                continue;
            }
            printf("This is made from a loop and counter is: %i\n", counter);
        }
    }
    // line is llegal: counter was lexically scoped and is out of scope here.
    // printf("Final counter: %i\n", counter);
    // a new counter appears:
    int counter = 40; // innacurate, but available
    printf("Final counter: %i\n", counter);
    {
        int counter = 0;
        while (counter < 5) {
            if (counter == 4) {
                break;
            }
            counter++;
            if (counter == 1) {
                continue;
            }
            printf("This is made from a loop and counter is: %i\n", counter);
        }
    }
    // still innacurate due to lexical scoping!
    printf("Final counter: %i\n", counter);
    printf("Final counter: %i\n", counter);
    {
        counter = 0; // use the outer scope!
        while (counter < 5) {
            if (counter == 4) {
                break;
            }
            counter++;
            if (counter == 1) {
                int counter = 200;
                printf("This counter is lower and doesn't effect the loop: %i\n", counter);
                continue;
            }
            printf("This is made from a loop and counter is: %i\n", counter);
        }
    }
    // accurate now because the lexical scoping was using the higher scope counter!
    printf("Final counter: %i\n", counter);
    return 0;
}

// compile instuctions
// gcc -o lesson18f lesson18f.c