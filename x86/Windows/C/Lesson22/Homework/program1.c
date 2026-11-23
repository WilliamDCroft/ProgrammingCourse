#include <stdio.h>
#include <stdlib.h>

int main() {
    fputs("Welcome to Array Maker. Please input the size of the array (max 50)\n$> ", stdout);
    char input[16];
    fgets(input, 16, stdin);
    int arraySize = atoi(input);
    int theArray[50] = {0};

    for (;;) {
        fputs("\n\n----------------------------------------\n"
                "Press 1 to store a value in the array.\nPress 2 to get an index from the array.\n"
                "Press 3 to print the entire array.\nPress 4 to quit.\n$> ", stdout);
        fgets(input, 16, stdin);
        int option = atoi(input);
        switch (option) {
            case 1: {
                fputs("Input the index to store: ", stdout);
                fgets(input, 16, stdin);
                int index = atoi(input);
                fputs("Input the value to store: ", stdout);
                fgets(input, 16, stdin);
                int value = atoi(input);
                theArray[--index] = value;
            } break;
            case 2: {
                fputs("Input the index to retrieve: ", stdout);
                fgets(input, 16, stdin);
                int index = atoi(input);
                int value = theArray[index - 1];
                printf("%d : %d", index, value);
            } break;
            case 3: {
                for (int i = 0; i < arraySize; ++i) {
                    printf("\n%d : %d", i + 1, theArray[i]);
                }
            } break;
            case 4: {
                return 0;
            } 
            default: {
                fputs("That option is invalid.\n\n", stdout);
            }
        }
    }
}