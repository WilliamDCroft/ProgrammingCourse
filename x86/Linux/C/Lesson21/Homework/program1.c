#include <stdio.h>

int main() {
    char input[256];
    fputs("Type a message to cipher.\n$> ", stdout);
    fgets(input, 256, stdin);
    for (char* pointer = input; *pointer != '\n'; ++pointer) {
        (*pointer)++;
    }
    printf("Your enciphered message: %s", input);
    return 0;
}
