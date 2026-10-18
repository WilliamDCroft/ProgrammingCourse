#include <stdio.h>

int main() {
    char buffer[256];
    fputs("Type a message: ", stdout);
    fgets(buffer, 256, stdin);
    fputs("Your message is: ", stdout);
    fputs(buffer, stdout);
    return 0;
}