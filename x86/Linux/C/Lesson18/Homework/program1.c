#include <stdio.h>
#include <stdlib.h>

int main() {
    while (1) {
        fputs("Welcome to the menu.\nPress 1 for the current weather.\nPress 2 for appointment"
                "reminders.\nPress 3 for a positive message.\n"
                "Type anything else to exit.\n$> ", stdout);

        char szUserChoice[256];
        fgets(szUserChoice, 256, stdin);

        int userChoice = atoi(szUserChoice);
        if (userChoice == 1) {
            fputs("The weather is tornado levels of scary!\n\n", stdout);
            
        }
        else if (userChoice == 2) {
            fputs("You have a doctors appointment on the 17th.\n\n", stdout);
        }
        else if (userChoice == 3) {
            fputs("You are a good person. Have a pleasent day.\n\n", stdout);
        } else {
            break;
        }
    }
   return 0;
}
