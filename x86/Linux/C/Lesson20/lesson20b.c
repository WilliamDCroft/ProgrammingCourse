#include <stdio.h>
#include <stdlib.h>

int main() {
    fputs("1 being the worst and 5 being the best, what kinda day are you having?\n$> ", stdout);
    char szOption[256];
    fgets(szOption, 256, stdin);
    int option = atoi(szOption);
    if (option == 1) {
        fputs("Worst day.\n", stdout);
    } else if (option == 2) {
        fputs("Bad day.\n", stdout);
    } else if (option == 3) {
        fputs("The day is okay.\n", stdout);
    } else if (option == 4) {
        fputs("Nice day.\n", stdout);
    } else if (option == 5) {
        fputs("Best day.\n", stdout);
    } else {
        fputs("Invalid numer.\n", stdout);
    }
    return 0;
}
